From: Craig Stein <stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
Date: Tue, 4 Jul 2017 10:29:27 -0600
Message-ID: <CAEm5wMnjd5Vex9+qCJwrJUqLYMme_CJH-sA2wMvyc1vj6n6=0w@mail.gmail.com>
References: <1496954035.4188.1.camel@rutgers.edu>
	<1498062018.17007.6.camel@rutgers.edu>
	<bf685f44-019c-4c21-25d4-6a6ea647b7cc@amd.com>
	<1498079371.17007.18.camel@rutgers.edu>
	<20170622092053.GV30388@8bytes.org>
	<1498144389.17007.25.camel@rutgers.edu>
	<20170622215735.GW30388@8bytes.org>
	<1498227647.17007.31.camel@rutgers.edu>
	<20170626121430.GX30388@8bytes.org>
	<1498580675.10525.3.camel@rutgers.edu>
	<20170628083659.GA30388@8bytes.org>
	<BN6PR12MB16525D2E89F4AB61DC36EFBEF7DD0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8787983354925682365=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <BN6PR12MB16525D2E89F4AB61DC36EFBEF7DD0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Lendacky, Thomas" <Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org>, Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>, "Nath,
	Arindam" <arindam.nath-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============8787983354925682365==
Content-Type: multipart/alternative; boundary="001a113fec6e28cf520553806306"

--001a113fec6e28cf520553806306
Content-Type: text/plain; charset="UTF-8"

Just to be clear which patch should I test and would you provide me with
the link of its location?

Thanks,
Craig

On Jun 28, 2017 16:14, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
wrote:

> > -----Original Message-----
> > From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> > Sent: Wednesday, June 28, 2017 4:37 AM
> > To: Jan Vesely; Deucher, Alexander
> > Cc: Lendacky, Thomas; Nath, Arindam; Craig Stein; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> > foundation.org; Duran, Leo; Suthikulpanit, Suravee
> > Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush
> >
> > [Adding Alex Deucher]
> >
> > Hey Alex,
> >
> > On Tue, Jun 27, 2017 at 12:24:35PM -0400, Jan Vesely wrote:
> > > On Mon, 2017-06-26 at 14:14 +0200, Joerg Roedel wrote:
> >
> > > > How does that 'dGPU goes to sleep' work? Do you put it to sleep
> > manually
> > > > via sysfs or something? Or is that something that amdgpu does on its
> > > > own?
> > >
> > > AMD folks should be able to provide more details. afaik, the driver
> > > uses ACPI methods to power on/off the device. Driver routines wake the
> > > device up before accessing it and there is a timeout to turn it off
> > > after few seconds of inactivity.
> > >
> > > >
> > > > It looks like the GPU just switches the ATS unit off when it goes to
> > > > sleep and doesn't answer the invalidation anymore, which explains the
> > > > completion-wait timeouts.
> > >
> > > Both MMIO regs and PCIe config regs are turned off so it would not
> > > surprise me if all PCIe requests were ignored by the device in off
> > > state. it should be possible to request device wake up before
> > > invalidating the relevant IOMMU domain. I'll leave to more
> > > knowledgeable ppl to judge whether it's a good idea (we can also
> > > postpone such invalidations until the device is woken by other means)
> >
> > Can you maybe sched some light on how the sleep-mode of the GPUs work?
> > Is it initiated by the GPU driver or from somewhere else? In the case
> > discussed here it looks like the ATS unit of the GPU is switched of,
> > causing IOTLB invalidation timeouts on the IOMMU side.
> >
> > If that is the case we might need some sort of dma-api extension so that
> > the GPU driver can tell the iommu driver that the device is going to be
> > quiet.
>
> I assume you are talking about Hybrid/PowerXpress laptops where the dGPU
> can be powered down dynamically?  That is done via the runtime pm subsystem
> in the kernel.  We register several callbacks with that, and then it takes
> care of the power down auto timers and such.  The actual mechanism to power
> down the GPU varies for platform to platform (platform specific ACPI
> methods on early systems, D3cold on newer ones).
>
> Alex
>
>

--001a113fec6e28cf520553806306
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Just to be clear which patch should I test and would you =
provide me with the link of its location?<div dir=3D"auto"><br></div><div d=
ir=3D"auto">Thanks,=C2=A0</div><div dir=3D"auto">Craig</div></div><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote">On Jun 28, 2017 16:14, &qu=
ot;Deucher, Alexander&quot; &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org=
">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br type=3D"attribution"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">&gt; -----Original Message-----<br>
&gt; From: Joerg Roedel [mailto:<a href=3D"mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org">joro@8by=
tes.org</a>]<br>
&gt; Sent: Wednesday, June 28, 2017 4:37 AM<br>
&gt; To: Jan Vesely; Deucher, Alexander<br>
&gt; Cc: Lendacky, Thomas; Nath, Arindam; Craig Stein; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org<b=
r>
&gt; <a href=3D"http://foundation.org" rel=3D"noreferrer" target=3D"_blank"=
>foundation.org</a>; Duran, Leo; Suthikulpanit, Suravee<br>
&gt; Subject: Re: [PATCH v1 3/3] iommu/amd: Optimize the IOMMU queue flush<=
br>
&gt;<br>
&gt; [Adding Alex Deucher]<br>
&gt;<br>
&gt; Hey Alex,<br>
&gt;<br>
&gt; On Tue, Jun 27, 2017 at 12:24:35PM -0400, Jan Vesely wrote:<br>
&gt; &gt; On Mon, 2017-06-26 at 14:14 +0200, Joerg Roedel wrote:<br>
&gt;<br>
&gt; &gt; &gt; How does that &#39;dGPU goes to sleep&#39; work? Do you put =
it to sleep<br>
&gt; manually<br>
&gt; &gt; &gt; via sysfs or something? Or is that something that amdgpu doe=
s on its<br>
&gt; &gt; &gt; own?<br>
&gt; &gt;<br>
&gt; &gt; AMD folks should be able to provide more details. afaik, the driv=
er<br>
&gt; &gt; uses ACPI methods to power on/off the device. Driver routines wak=
e the<br>
&gt; &gt; device up before accessing it and there is a timeout to turn it o=
ff<br>
&gt; &gt; after few seconds of inactivity.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; It looks like the GPU just switches the ATS unit off when it=
 goes to<br>
&gt; &gt; &gt; sleep and doesn&#39;t answer the invalidation anymore, which=
 explains the<br>
&gt; &gt; &gt; completion-wait timeouts.<br>
&gt; &gt;<br>
&gt; &gt; Both MMIO regs and PCIe config regs are turned off so it would no=
t<br>
&gt; &gt; surprise me if all PCIe requests were ignored by the device in of=
f<br>
&gt; &gt; state. it should be possible to request device wake up before<br>
&gt; &gt; invalidating the relevant IOMMU domain. I&#39;ll leave to more<br=
>
&gt; &gt; knowledgeable ppl to judge whether it&#39;s a good idea (we can a=
lso<br>
&gt; &gt; postpone such invalidations until the device is woken by other me=
ans)<br>
&gt;<br>
&gt; Can you maybe sched some light on how the sleep-mode of the GPUs work?=
<br>
&gt; Is it initiated by the GPU driver or from somewhere else? In the case<=
br>
&gt; discussed here it looks like the ATS unit of the GPU is switched of,<b=
r>
&gt; causing IOTLB invalidation timeouts on the IOMMU side.<br>
&gt;<br>
&gt; If that is the case we might need some sort of dma-api extension so th=
at<br>
&gt; the GPU driver can tell the iommu driver that the device is going to b=
e<br>
&gt; quiet.<br>
<br>
I assume you are talking about Hybrid/PowerXpress laptops where the dGPU ca=
n be powered down dynamically?=C2=A0 That is done via the runtime pm subsys=
tem in the kernel.=C2=A0 We register several callbacks with that, and then =
it takes care of the power down auto timers and such.=C2=A0 The actual mech=
anism to power down the GPU varies for platform to platform (platform speci=
fic ACPI methods on early systems, D3cold on newer ones).<br>
<br>
Alex<br>
<br>
</blockquote></div></div>

--001a113fec6e28cf520553806306--

--===============8787983354925682365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8787983354925682365==--
