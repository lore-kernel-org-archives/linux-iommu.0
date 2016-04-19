From: Benjamin Serebrin via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v3 0/7] Intel IOMMU scalability improvements
Date: Tue, 19 Apr 2016 13:52:03 -0700
Message-ID: <CAN+hb0W9Qm0mJY24ZmUVVbOsA20BpRWT-KeDOX90VUYX3f1hYw@mail.gmail.com>
References: <cover.1460733778.git.mad@cs.technion.ac.il>
	<20160419204705.GA1134028@devbig084.prn1.facebook.com>
Reply-To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0246793581643737554=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160419204705.GA1134028-tb7CFzD8y5b7E6g3fPdp/g2O0Ztt9esIQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Cc: Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Godfrey van der Linden <gvdl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kernel-team-b10kYP2dOMg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============0246793581643737554==
Content-Type: multipart/alternative; boundary=001a11c075a23de5e70530dca6ab

--001a11c075a23de5e70530dca6ab
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 19, 2016 at 1:47 PM, Shaohua Li <shli-b10kYP2dOMg@public.gmane.org> wrote:

> On Tue, Apr 19, 2016 at 07:48:16PM +0300, Adam Morrison wrote:
> > This patchset improves the scalability of the Intel IOMMU code by
> > resolving two spinlock bottlenecks, yielding up to ~5x performance
> > improvement and approaching iommu=3Doff performance.
> >
> > For example, here's the throughput obtained by 16 memcached instances
> > running on a 16-core Sandy Bridge system, accessed using memslap on
> > another machine that has iommu=3Doff, using the default memslap config
> > (64-byte keys, 1024-byte values, and 10%/90% SET/GET ops):
> >
> >     stock iommu=3Doff:
> >        990,803 memcached transactions/sec (=3D100%, median of 10 runs).
> >     stock iommu=3Don:
> >        221,416 memcached transactions/sec (=3D22%).
> >        [61.70%    0.63%  memcached       [kernel.kallsyms]      [k]
> _raw_spin_lock_irqsave]
> >     patched iommu=3Don:
> >        963,159 memcached transactions/sec (=3D97%).
> >        [1.29%     1.10%  memcached       [kernel.kallsyms]      [k]
> _raw_spin_lock_irqsave]
> >
> > The two resolved spinlocks:
> >
> >  - Deferred IOTLB invalidations are batched in a global data structure
> >    and serialized under a spinlock (add_unmap() & flush_unmaps()); this
> >    patchset batches IOTLB invalidations in a per-CPU data structure.
> >
> >  - IOVA management (alloc_iova() & __free_iova()) is serialized under
> >    the rbtree spinlock; this patchset adds per-CPU caches of allocated
> >    IOVAs so that the rbtree doesn't get accessed frequently. (Adding a
> >    cache above the existing IOVA allocator is less intrusive than dynam=
ic
> >    identity mapping and helps keep IOMMU page table usage low; see
> >    Patch 7.)
> >
> > The paper "Utilizing the IOMMU Scalably" (presented at the 2015 USENIX
> > Annual Technical Conference) contains many more details and experiments=
:
> >
> >
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.usenix.org_sys=
tem_files_conference_atc15_atc15-2Dpaper-2Dpeleg.pdf&d=3DCwIBAg&c=3D5VD0RTt=
NlTh3ycd41b3MUw&r=3DX13hAPkxmvBro1Ug8vcKHw&m=3DO-p7wCR-G4eXQJOhyiio_pLUyJGk=
aFCUv4CNBrTdMPs&s=3DT7ynyUVZWcBkslPyKJqEUUggCmFDrsglpKRu0I3EXhQ&e=3D
> >
> > v3:
> >  * Patch 7/7: Respect the caller-passed limit IOVA when satisfying an
> IOVA
> >    allocation from the cache.
>
> Thanks, looks good. I'm still thinking to have 2 caches, one for DMA32
> and the other for DMA64. Mixing them in one cache might make allocation
> from cache have more failure. But we can do this later if it is a real
> problem. So for the the whole series
> Reviewed-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
>


I agree, looks great.  I gave one slight comment on a comment in 7/7, but
after that:

Reviewed-by: Ben Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

Thanks for doing all of this!

--001a11c075a23de5e70530dca6ab
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Apr 19, 2016 at 1:47 PM, Shaohua Li <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:shli-b10kYP2dOMg@public.gmane.org">shli-b10kYP2dOMg@public.gmane.org</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:=
1ex"><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Tue, Apr 19, 20=
16 at 07:48:16PM +0300, Adam Morrison wrote:<br>
&gt; This patchset improves the scalability of the Intel IOMMU code by<br>
&gt; resolving two spinlock bottlenecks, yielding up to ~5x performance<br>
&gt; improvement and approaching iommu=3Doff performance.<br>
&gt;<br>
&gt; For example, here&#39;s the throughput obtained by 16 memcached instan=
ces<br>
&gt; running on a 16-core Sandy Bridge system, accessed using memslap on<br=
>
&gt; another machine that has iommu=3Doff, using the default memslap config=
<br>
&gt; (64-byte keys, 1024-byte values, and 10%/90% SET/GET ops):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0stock iommu=3Doff:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 990,803 memcached transactions/sec (=3D100%=
, median of 10 runs).<br>
&gt;=C2=A0 =C2=A0 =C2=A0stock iommu=3Don:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 221,416 memcached transactions/sec (=3D22%)=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 [61.70%=C2=A0 =C2=A0 0.63%=C2=A0 memcached=
=C2=A0 =C2=A0 =C2=A0 =C2=A0[kernel.kallsyms]=C2=A0 =C2=A0 =C2=A0 [k] _raw_s=
pin_lock_irqsave]<br>
&gt;=C2=A0 =C2=A0 =C2=A0patched iommu=3Don:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 963,159 memcached transactions/sec (=3D97%)=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 [1.29%=C2=A0 =C2=A0 =C2=A01.10%=C2=A0 memca=
ched=C2=A0 =C2=A0 =C2=A0 =C2=A0[kernel.kallsyms]=C2=A0 =C2=A0 =C2=A0 [k] _r=
aw_spin_lock_irqsave]<br>
&gt;<br>
&gt; The two resolved spinlocks:<br>
&gt;<br>
&gt;=C2=A0 - Deferred IOTLB invalidations are batched in a global data stru=
cture<br>
&gt;=C2=A0 =C2=A0 and serialized under a spinlock (add_unmap() &amp; flush_=
unmaps()); this<br>
&gt;=C2=A0 =C2=A0 patchset batches IOTLB invalidations in a per-CPU data st=
ructure.<br>
&gt;<br>
&gt;=C2=A0 - IOVA management (alloc_iova() &amp; __free_iova()) is serializ=
ed under<br>
&gt;=C2=A0 =C2=A0 the rbtree spinlock; this patchset adds per-CPU caches of=
 allocated<br>
&gt;=C2=A0 =C2=A0 IOVAs so that the rbtree doesn&#39;t get accessed frequen=
tly. (Adding a<br>
&gt;=C2=A0 =C2=A0 cache above the existing IOVA allocator is less intrusive=
 than dynamic<br>
&gt;=C2=A0 =C2=A0 identity mapping and helps keep IOMMU page table usage lo=
w; see<br>
&gt;=C2=A0 =C2=A0 Patch 7.)<br>
&gt;<br>
&gt; The paper &quot;Utilizing the IOMMU Scalably&quot; (presented at the 2=
015 USENIX<br>
&gt; Annual Technical Conference) contains many more details and experiment=
s:<br>
&gt;<br>
</div></div>&gt;=C2=A0 =C2=A0<a href=3D"https://urldefense.proofpoint.com/v=
2/url?u=3Dhttps-3A__www.usenix.org_system_files_conference_atc15_atc15-2Dpa=
per-2Dpeleg.pdf&amp;d=3DCwIBAg&amp;c=3D5VD0RTtNlTh3ycd41b3MUw&amp;r=3DX13hA=
PkxmvBro1Ug8vcKHw&amp;m=3DO-p7wCR-G4eXQJOhyiio_pLUyJGkaFCUv4CNBrTdMPs&amp;s=
=3DT7ynyUVZWcBkslPyKJqEUUggCmFDrsglpKRu0I3EXhQ&amp;e=3D" rel=3D"noreferrer"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.usenix.org_syst=
em_files_conference_atc15_atc15-2Dpaper-2Dpeleg.pdf&amp;d=3DCwIBAg&amp;c=3D=
5VD0RTtNlTh3ycd41b3MUw&amp;r=3DX13hAPkxmvBro1Ug8vcKHw&amp;m=3DO-p7wCR-G4eXQ=
JOhyiio_pLUyJGkaFCUv4CNBrTdMPs&amp;s=3DT7ynyUVZWcBkslPyKJqEUUggCmFDrsglpKRu=
0I3EXhQ&amp;e=3D</a><br>
<span class=3D"gmail-">&gt;<br>
&gt; v3:<br>
&gt;=C2=A0 * Patch 7/7: Respect the caller-passed limit IOVA when satisfyin=
g an IOVA<br>
&gt;=C2=A0 =C2=A0 allocation from the cache.<br>
<br>
</span>Thanks, looks good. I&#39;m still thinking to have 2 caches, one for=
 DMA32<br>
and the other for DMA64. Mixing them in one cache might make allocation<br>
from cache have more failure. But we can do this later if it is a real<br>
problem. So for the the whole series<br>
Reviewed-by: Shaohua Li &lt;<a href=3D"mailto:shli-b10kYP2dOMg@public.gmane.org">shli-b10kYP2dOMg@public.gmane.org</a>&=
gt;<br>
</blockquote></div><br></div><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">I agree, looks great.=C2=A0 I gave one slight comment on =
a comment in 7/7, but after that:</div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra"><span style=3D"font-size:12.8px">Reviewed-by: B=
en Serebrin &lt;<a href=3D"mailto:serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org">serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org<=
/a>&gt;</span><br></div><div class=3D"gmail_extra"><span style=3D"font-size=
:12.8px"><br></span></div><div class=3D"gmail_extra"><span style=3D"font-si=
ze:12.8px">Thanks for doing all of this!</span></div><div class=3D"gmail_ex=
tra"><br></div></div>

--001a11c075a23de5e70530dca6ab--

--===============0246793581643737554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0246793581643737554==--
