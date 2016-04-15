From: Benjamin Serebrin via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v2 7/7] iommu: introduce per-cpu caching to iova allocation
Date: Thu, 14 Apr 2016 21:59:39 -0700
Message-ID: <CAN+hb0WRDYCpY8xoUvvGu4SSD83F9VTMW=9W=xfjYtJV-dijmQ@mail.gmail.com>
References: <cover.1460548546.git.mad@cs.technion.ac.il>
	<b208a304d83088aae7ecac10a3062dc57c0a2f79.1460548546.git.mad@cs.technion.ac.il>
	<CAN+hb0W=+tuQp3cm_VKoU=LKiVQDPMtGrZGq=59rcaWsy2S-+A@mail.gmail.com>
	<CAHMfzJmjZWeUpmTVb-Z7NMJUp0N84ZK4zwUWdAKHv4sd4TXPMg@mail.gmail.com>
	<CAN+hb0WOaokFYc6C+mR6rdj4WwmMUSzDHDZngfUvy-5cEve_-g@mail.gmail.com>
	<20160414213326.GA474260@devbig084.prn1.facebook.com>
Reply-To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6013095971304126481=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160414213326.GA474260-tb7CFzD8y5b7E6g3fPdp/g2O0Ztt9esIQQ4Iyu8u01E@public.gmane.org>
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

--===============6013095971304126481==
Content-Type: multipart/alternative; boundary=94eb2c123344d9a74e05307ee04f

--94eb2c123344d9a74e05307ee04f
Content-Type: text/plain; charset=UTF-8

On Thu, Apr 14, 2016 at 2:33 PM, Shaohua Li <shli-b10kYP2dOMg@public.gmane.org> wrote:

> On Thu, Apr 14, 2016 at 02:18:32PM -0700, Benjamin Serebrin wrote:
> > On Thu, Apr 14, 2016 at 2:05 PM, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
> wrote:
> > > On Thu, Apr 14, 2016 at 9:26 PM, Benjamin Serebrin via iommu
> > > <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org> wrote:
> > >
> > >> It was pointed out that DMA_32 or _24 (or anything other non-64 size)
> > >> could be starved if the magazines on all cores are full and the depot
> > >> is empty.  (This gets more probable with increased core count.)  You
> > >> could try one more time: call free_iova_rcaches() and try alloc_iova
> > >> again before giving up
> > >
> > > That's not safe, unfortunately.  free_iova_rcaches() is meant to be
> > > called only when the domain is dying and the CPUs won't access the
> > > rcaches.
> >
> > Fair enough.  Is it possible to make this safe, cleanly and without
> > too much locking during the normal case?
> >
> > > It's tempting to make the rcaches work only for DMA_64 allocations.
> > > This would also solve the problem of respecting the pfn_limit when
> > > allocating, which Shaohua Li pointed out.  Sadly, intel-iommu.c
> > > converts DMA_64 to DMA_32 by default, apparently to avoid dual address
> > > cycles on the PCI bus.  I wonder about the importance of this, though,
> > > as it doesn't seem that anything equivalent happens when iommu=off.
> >
> > I agree.  It's tempting to make all DMA_64 allocations grow up from
> > 4G, leaving the entire 32 bit space free for small allocations.  I'd
> > be willing to argue that that should be the default, with some
> > override for anyone who finds it objectionable.
> >
> > Dual address cycle is really "4 more bytes in the TLP header" on PCIe;
> > a 32-bit address takes 3 doublewords (12 bytes) while a 64-bit address
> > takes 4 DW (16 bytes).  What's 25% of a read request between friends?
> > And every read request has a read response 3DW TLP plus its data, so
> > the aggregate bandwidth consumed is getting uninteresting.  Similarly
> > for writes, the additional address bytes don't cost a large
> > percentage.
> >
> > That being said, it's a rare device that needs more than 4GB of active
> > address space, and it's a rare system that needs to mix a
> > performance-critical DMA_32 (or 24) and _64 device in the same page
> > table.
>
> I'm not sure about the TLP overhead. IOMMU is not only for pcie device.
> there are pcie-to-pcix/pci bridge, any pci device can reside behind it.
> The device might not handle DMA_64. DAC has overhead for pcix device
> iirc, which somebody might care about. So let's not break such devices.
>
> Thanks,
> Shaohua
>

Thanks, Shaohua.

As Adam mentioned, in iommu=off cases, there's no enforcement that keeps
any PCIe address below 4GB.  If you have a system with DRAM addresses above
4GB and you're using any of the iommu disabled or 1:1 settings, you'll
encounter this.  So the change in allocation policy would not add any new
failure mode; we're already going to encounter it today.

--94eb2c123344d9a74e05307ee04f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Apr 14, 2016 at 2:33 PM, Shaohua Li <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:shli-b10kYP2dOMg@public.gmane.org">shli-b10kYP2dOMg@public.gmane.org</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:=
1ex"><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Thu, Apr 14, 20=
16 at 02:18:32PM -0700, Benjamin Serebrin wrote:<br>
&gt; On Thu, Apr 14, 2016 at 2:05 PM, Adam Morrison &lt;<a href=3D"mailto:m=
ad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org">mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; On Thu, Apr 14, 2016 at 9:26 PM, Benjamin Serebrin via iommu<br>
&gt; &gt; &lt;<a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu@lis=
ts.linux-foundation.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; It was pointed out that DMA_32 or _24 (or anything other non-=
64 size)<br>
&gt; &gt;&gt; could be starved if the magazines on all cores are full and t=
he depot<br>
&gt; &gt;&gt; is empty.=C2=A0 (This gets more probable with increased core =
count.)=C2=A0 You<br>
&gt; &gt;&gt; could try one more time: call free_iova_rcaches() and try all=
oc_iova<br>
&gt; &gt;&gt; again before giving up<br>
&gt; &gt;<br>
&gt; &gt; That&#39;s not safe, unfortunately.=C2=A0 free_iova_rcaches() is =
meant to be<br>
&gt; &gt; called only when the domain is dying and the CPUs won&#39;t acces=
s the<br>
&gt; &gt; rcaches.<br>
&gt;<br>
&gt; Fair enough.=C2=A0 Is it possible to make this safe, cleanly and witho=
ut<br>
&gt; too much locking during the normal case?<br>
&gt;<br>
&gt; &gt; It&#39;s tempting to make the rcaches work only for DMA_64 alloca=
tions.<br>
&gt; &gt; This would also solve the problem of respecting the pfn_limit whe=
n<br>
&gt; &gt; allocating, which Shaohua Li pointed out.=C2=A0 Sadly, intel-iomm=
u.c<br>
&gt; &gt; converts DMA_64 to DMA_32 by default, apparently to avoid dual ad=
dress<br>
&gt; &gt; cycles on the PCI bus.=C2=A0 I wonder about the importance of thi=
s, though,<br>
&gt; &gt; as it doesn&#39;t seem that anything equivalent happens when iomm=
u=3Doff.<br>
&gt;<br>
&gt; I agree.=C2=A0 It&#39;s tempting to make all DMA_64 allocations grow u=
p from<br>
&gt; 4G, leaving the entire 32 bit space free for small allocations.=C2=A0 =
I&#39;d<br>
&gt; be willing to argue that that should be the default, with some<br>
&gt; override for anyone who finds it objectionable.<br>
&gt;<br>
&gt; Dual address cycle is really &quot;4 more bytes in the TLP header&quot=
; on PCIe;<br>
&gt; a 32-bit address takes 3 doublewords (12 bytes) while a 64-bit address=
<br>
&gt; takes 4 DW (16 bytes).=C2=A0 What&#39;s 25% of a read request between =
friends?<br>
&gt; And every read request has a read response 3DW TLP plus its data, so<b=
r>
&gt; the aggregate bandwidth consumed is getting uninteresting.=C2=A0 Simil=
arly<br>
&gt; for writes, the additional address bytes don&#39;t cost a large<br>
&gt; percentage.<br>
&gt;<br>
&gt; That being said, it&#39;s a rare device that needs more than 4GB of ac=
tive<br>
&gt; address space, and it&#39;s a rare system that needs to mix a<br>
&gt; performance-critical DMA_32 (or 24) and _64 device in the same page<br=
>
&gt; table.<br>
<br>
</div></div>I&#39;m not sure about the TLP overhead. IOMMU is not only for =
pcie device.<br>
there are pcie-to-pcix/pci bridge, any pci device can reside behind it.<br>
The device might not handle DMA_64. DAC has overhead for pcix device<br>
iirc, which somebody might care about. So let&#39;s not break such devices.=
<br>
<br>
Thanks,<br>
Shaohua<br>
</blockquote></div><br></div><div class=3D"gmail_extra">Thanks, Shaohua.<di=
v><br></div><div>As Adam mentioned, in iommu=3Doff cases, there&#39;s no en=
forcement that keeps any PCIe address below 4GB.=C2=A0 If you have a system=
 with DRAM addresses above 4GB and you&#39;re using any of the iommu disabl=
ed or 1:1 settings, you&#39;ll encounter this.=C2=A0 So the change in alloc=
ation policy would not add any new failure mode; we&#39;re already going to=
 encounter it today.</div></div></div>

--94eb2c123344d9a74e05307ee04f--

--===============6013095971304126481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6013095971304126481==--
