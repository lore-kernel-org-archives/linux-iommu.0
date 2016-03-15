From: Benjamin Serebrin via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 0/7] Intel IOMMU scalability improvements
Date: Tue, 15 Mar 2016 11:00:34 -0700
Message-ID: <CAN+hb0Xt21CMmM7uE0rzjf5p9w-W+5y8at4v1J8+pYd8tamLpQ@mail.gmail.com>
References: <20151228161421.GA27829@cs.technion.ac.il>
Reply-To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2302478999078556298=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151228161421.GA27829-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Cc: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============2302478999078556298==
Content-Type: multipart/alternative; boundary=001a114413868a81f0052e1a2c21

--001a114413868a81f0052e1a2c21
Content-Type: text/plain; charset=UTF-8

There are nice.  Thanks very much for doing this work!

We have some preliminary results, looking at scaling to high core counts.
We tested the patches on a 2-socket high core count SNB-EP server with a
Broadcomm NIC.  Our benchmark uses 200 threads of TCP_RR.  We see similar
performance for IOMMU disabled as we do for IOMMU enabled with this
patchset, which is good news.  We're working on getting a lab setup with
Haswell servers so we can further test the scalability of the code.

We owe the scaling results and of course actual code reviews.

On Mon, Dec 28, 2015 at 8:14 AM, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
wrote:

> This patchset improves the scalability of the Intel IOMMU code by
> resolving two spinlock bottlenecks, yielding up to ~10x performance
> improvement and approaching iommu=off performance.
>
> For example, here's the throughput obtained by 16 memcached instances
> running on a 16-core Sandy Bridge system, accessed using memslap on
> another machine that has iommu=off, using the default memslap config
> (64-byte keys, 1024-byte values, and 10%/90% SET/GET ops):
>
>     stock iommu=off:
>        1,088,996 memcached transactions/sec (=100%, median of 10 runs).
>     stock iommu=on:
>        123,760 memcached transactions/sec (=11%).
>        [perf: 43.56%    0.86%  memcached       [kernel.kallsyms]      [k]
> _raw_spin_lock_irqsave]
>     patched iommu=on:
>        1,067,586 memcached transactions/sec (=98%).
>        [perf: 0.75%     0.75%  memcached       [kernel.kallsyms]      [k]
> _raw_spin_lock_irqsave]
>
> The two resolved spinlocks:
>
>  - Deferred IOTLB invalidations are batched in a global data structure
>    and serialized under a spinlock (add_unmap() & flush_unmaps()); this
>    patchset batches IOTLB invalidations in a per-CPU data structure.
>
>  - IOVA management (alloc_iova() & __free_iova()) is serialized under
>    the rbtree spinlock; this patchset adds per-CPU caches of allocated
>    IOVAs so that the rbtree doesn't get accessed frequently. (Adding a
>    cache above the existing IOVA allocator is less intrusive than dynamic
>    identity mapping and helps keep IOMMU page table usage low; see
>    Patch 7.)
>
> The paper "Utilizing the IOMMU Scalably" (presented at the 2015 USENIX
> Annual Technical Conference) contains many more details and experiments:
>
>
> https://www.usenix.org/system/files/conference/atc15/atc15-paper-peleg.pdf
>
>
> Omer Peleg (7):
>   iommu: refactoring of deferred flush entries
>   iommu: per-cpu deferred invalidation queues
>   iommu: correct flush_unmaps pfn usage
>   iommu: only unmap mapped entries
>   iommu: avoid dev iotlb logic in intel-iommu for domains with no dev
>     iotlbs
>   iommu: change intel-iommu to use IOVA frame numbers
>   iommu: introduce per-cpu caching to iova allocation
>
>  drivers/iommu/intel-iommu.c | 264 +++++++++++++++++++++-------------
>  drivers/iommu/iova.c        | 334
> +++++++++++++++++++++++++++++++++++++-------
>  include/linux/iova.h        |  23 ++-
>  3 files changed, 470 insertions(+), 151 deletions(-)
>
> --
> 1.9.1
>
>

--001a114413868a81f0052e1a2c21
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">There are nice.=C2=A0 Tha=
nks very much for doing this work!</span><div><span style=3D"font-size:12.8=
px"><br></span></div><div><span style=3D"font-size:12.8px">We have some pre=
liminary results, looking at scaling to high core counts.=C2=A0 We tested t=
he patches on a 2-socket high core count SNB-EP server with a Broadcomm NIC=
.=C2=A0 Our benchmark uses 200 threads of TCP_RR.=C2=A0 We see similar perf=
ormance for IOMMU disabled as we do for IOMMU enabled with this patchset, w=
hich is good news.=C2=A0 We&#39;re working on getting a lab setup with Hasw=
ell servers so we can further test the scalability of the code.</span><br><=
/div><div><span style=3D"font-size:12.8px"><br></span></div><div><span styl=
e=3D"font-size:12.8px">We owe the scaling results and of course actual code=
 reviews.</span></div></div><div class=3D"gmail_extra"><br><div class=3D"gm=
ail_quote">On Mon, Dec 28, 2015 at 8:14 AM, Adam Morrison <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org" target=3D"_blank">mad-5qB/rewXR4M@public.gmane.org=
nion.ac.il</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">This pat=
chset improves the scalability of the Intel IOMMU code by<br>
resolving two spinlock bottlenecks, yielding up to ~10x performance<br>
improvement and approaching iommu=3Doff performance.<br>
<br>
For example, here&#39;s the throughput obtained by 16 memcached instances<b=
r>
running on a 16-core Sandy Bridge system, accessed using memslap on<br>
another machine that has iommu=3Doff, using the default memslap config<br>
(64-byte keys, 1024-byte values, and 10%/90% SET/GET ops):<br>
<br>
=C2=A0 =C2=A0 stock iommu=3Doff:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A01,088,996 memcached transactions/sec (=3D100%, m=
edian of 10 runs).<br>
=C2=A0 =C2=A0 stock iommu=3Don:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0123,760 memcached transactions/sec (=3D11%).<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0[perf: 43.56%=C2=A0 =C2=A0 0.86%=C2=A0 memcached=
=C2=A0 =C2=A0 =C2=A0 =C2=A0[kernel.kallsyms]=C2=A0 =C2=A0 =C2=A0 [k] _raw_s=
pin_lock_irqsave]<br>
=C2=A0 =C2=A0 patched iommu=3Don:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A01,067,586 memcached transactions/sec (=3D98%).<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0[perf: 0.75%=C2=A0 =C2=A0 =C2=A00.75%=C2=A0 memc=
ached=C2=A0 =C2=A0 =C2=A0 =C2=A0[kernel.kallsyms]=C2=A0 =C2=A0 =C2=A0 [k] _=
raw_spin_lock_irqsave]<br>
<br>
The two resolved spinlocks:<br>
<br>
=C2=A0- Deferred IOTLB invalidations are batched in a global data structure=
<br>
=C2=A0 =C2=A0and serialized under a spinlock (add_unmap() &amp; flush_unmap=
s()); this<br>
=C2=A0 =C2=A0patchset batches IOTLB invalidations in a per-CPU data structu=
re.<br>
<br>
=C2=A0- IOVA management (alloc_iova() &amp; __free_iova()) is serialized un=
der<br>
=C2=A0 =C2=A0the rbtree spinlock; this patchset adds per-CPU caches of allo=
cated<br>
=C2=A0 =C2=A0IOVAs so that the rbtree doesn&#39;t get accessed frequently. =
(Adding a<br>
=C2=A0 =C2=A0cache above the existing IOVA allocator is less intrusive than=
 dynamic<br>
=C2=A0 =C2=A0identity mapping and helps keep IOMMU page table usage low; se=
e<br>
=C2=A0 =C2=A0Patch 7.)<br>
<br>
The paper &quot;Utilizing the IOMMU Scalably&quot; (presented at the 2015 U=
SENIX<br>
Annual Technical Conference) contains many more details and experiments:<br=
>
<br>
=C2=A0 <a href=3D"https://www.usenix.org/system/files/conference/atc15/atc1=
5-paper-peleg.pdf" rel=3D"noreferrer" target=3D"_blank">https://www.usenix.=
org/system/files/conference/atc15/atc15-paper-peleg.pdf</a><br>
<br>
<br>
Omer Peleg (7):<br>
=C2=A0 iommu: refactoring of deferred flush entries<br>
=C2=A0 iommu: per-cpu deferred invalidation queues<br>
=C2=A0 iommu: correct flush_unmaps pfn usage<br>
=C2=A0 iommu: only unmap mapped entries<br>
=C2=A0 iommu: avoid dev iotlb logic in intel-iommu for domains with no dev<=
br>
=C2=A0 =C2=A0 iotlbs<br>
=C2=A0 iommu: change intel-iommu to use IOVA frame numbers<br>
=C2=A0 iommu: introduce per-cpu caching to iova allocation<br>
<br>
=C2=A0drivers/iommu/intel-iommu.c | 264 +++++++++++++++++++++-------------<=
br>
=C2=A0drivers/iommu/iova.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 334 +++++++++++++++=
++++++++++++++++++++++-------<br>
=C2=A0include/linux/iova.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 23 ++-<br>
=C2=A03 files changed, 470 insertions(+), 151 deletions(-)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br></div>

--001a114413868a81f0052e1a2c21--

--===============2302478999078556298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2302478999078556298==--
