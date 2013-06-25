From: Dave Young <hidave.darkstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
Date: Tue, 25 Jun 2013 16:41:32 +0800
Message-ID: <CABqxG0eYfxpEipZSGBX7mCv1jXqN6+Fk=Mb7pORvm81DVY5ajg@mail.gmail.com>
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com>
	<CAErSpo4t_2Xw76p3Z9FVzyyK-MBovavDu9D=pYoPMjESSxgT=w@mail.gmail.com>
	<51B19DF3.2070009@jp.fujitsu.com>
	<CAErSpo6dfEnzriHD_aWZB_3E-kSzauhNRHPd+VuFX5HONVKgqw@mail.gmail.com>
	<51B6BEDB.3000509@jp.fujitsu.com>
	<CAErSpo5u8qGALt6C+tuPYXdd2YgyMH6fnPnA+afUteEZ7kY0iw@mail.gmail.com>
	<51B93221.2040505@jp.fujitsu.com>
	<CAErSpo5tVK-Z3aOdMTzab-S8o5zLVtDOFQ8-LSYpUgbrJSsxuw@mail.gmail.com>
	<51BA7BB6.1080104@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1023665509278898032=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <51BA7BB6.1080104-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, bill.sumner-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1023665509278898032==
Content-Type: multipart/alternative; boundary=089e011821ea060a1504dff67f05

--089e011821ea060a1504dff67f05
Content-Type: text/plain; charset=UTF-8

On Fri, Jun 14, 2013 at 10:11 AM, Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>wrote:

> (2013/06/13 12:41), Bjorn Helgaas wrote:
> > On Wed, Jun 12, 2013 at 8:44 PM, Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> wrote:
> >> (2013/06/12 13:45), Bjorn Helgaas wrote:
> >>> [+cc Vivek, Haren; sorry I didn't think to add you earlier]
> >>>
> >>> On Tue, Jun 11, 2013 at 12:08 AM, Takao Indoh
> >>> <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org> wrote:
> >>>> (2013/06/11 11:20), Bjorn Helgaas wrote:
> >>>
> >>>>> I'm not sure you need to reset legacy devices (or non-PCI devices)
> >>>>> yet, but the current hook isn't anchored anywhere -- it's just an
> >>>>> fs_initcall() that doesn't give the reader any clue about the
> >>>>> connection between the reset and the problem it's solving.
> >>>>>
> >>>>> If we do something like this patch, I think it needs to be done at
> the
> >>>>> point where we enable or disable the IOMMU.  That way, it's connected
> >>>>> to the important event, and there's a clue about how to make
> >>>>> corresponding fixes for other IOMMUs.
> >>>>
> >>>> Ok. pci_iommu_init() is appropriate place to add this hook?
> >>>
> >>> I looked at various IOMMU init places today, and it's far more
> >>> complicated and varied than I had hoped.
> >>>
> >>> This reset scheme depends on enumerating PCI devices before we
> >>> initialize the IOMMU used by those devices.  x86 works that way today,
> >>> but not all architectures do (see the sparc pci_fire_pbm_init(), for
> >>
> >> Sorry, could you tell me which part depends on architecture?
> >
> > Your patch works if PCIe devices are reset before the kdump kernel
> > enables the IOMMU.  On x86, this is possible because PCI enumeration
> > happens before the IOMMU initialization.  On sparc, the IOMMU is
> > initialized before PCI devices are enumerated, so there would still be
> > a window where ongoing DMA could cause an IOMMU error.
>
> Ok, understood, thanks.
>
> Hmmm, it seems to be difficult to find out method which is common to
> all architectures. So, what I can do for now is introducing reset scheme
> which is only for x86.
>
> 1) Change this patch so that it work only on x86 platform. For example
>    call this reset code from x86_init.iommu.iommu_init() instead of
>    fs_initcall.
>
> Or another idea is:
>
> 2) Enumerate PCI devices in IOMMU layer. That is:
>    PCI layer
>      Just provide interface to reset given strcut pci_dev. Maybe
>      pci_reset_function() looks good for this purpose.
>    IOMMU layer
>      Determine which devices should be reset. On kernel boot, check if
>      IOMMU is already active or not, and if active, check IOMMU page
>      table and reset devices whose entry exists there.
>
> > Of course, it might be possible to reorganize the sparc code to to the
> > IOMMU init *after* it enumerates PCI devices.  But I think that change
> > would be hard to justify.
> >
> > And I think even on x86, it would be better if we did the IOMMU init
> > before PCI enumeration -- the PCI devices depend on the IOMMU, so
> > logically the IOMMU should be initialized first so the PCI devices can
> > be associated with it as they are enumerated.
>
> So third idea is:
>
> 3) Do reset before PCI enumeration(arch_initcall_sync or somewhere). We
>    need to implement new code to enumerate PCI devices and reset them
>    for this purpose.
>
> Idea 2 is not difficult to implement, but one problem is that this
> method may be dangerous. We need to scan IOMMU page table which is used
> in previous kernel, but it may be broken. Idea 3 seems to be difficult
> to implement...
>
>
> >
> >>> example).  And I think conceptually, the IOMMU should be enumerated
> >>> and initialized *before* the devices that use it.
> >>>
> >>> So I'm uncomfortable with that aspect of this scheme.
> >>>
> >>> It would be at least conceivable to reset the devices in the system
> >>> kernel, before the kexec.  I know we want to do as little as possible
> >>> in the crashing kernel, but it's at least a possibility, and it might
> >>> be cleaner.
> >>
> >> I bet this will be not accepted by kdump maintainer. Everything in panic
> >> kernel is unreliable.
> >
> > kdump is inherently unreliable.  The kdump kernel doesn't start from
> > an arbitrary machine state.  We don't expect it to tolerate all CPUs
> > running, for example.  Maybe it should be expected to tolerate PCI
> > devices running, either.
>
> What I wanted to say is that any resources of first kernel are
> unreliable. Under panic situation, struct pci_dev tree may be broken, or
> pci_lock may be already hold by someone, etc. So, if we do this in first
> kernel, maybe kdump needs its own code to enumerate PCI devices and
> reset them.
>
> Vivek?
>

Ping Vivek


>
> Thanks,
> Takao Indoh
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



-- 
Regards
Dave

--089e011821ea060a1504dff67f05
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Fri, Jun 14, 2013 at 10:11 AM, Takao Indoh <span dir=3D"ltr">&lt=
;<a href=3D"mailto:indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org" target=3D"_blank">indou.taka=
o@jp.fujitsu.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">(201=
3/06/13 12:41), Bjorn Helgaas wrote:<br>
&gt; On Wed, Jun 12, 2013 at 8:44 PM, Takao Indoh &lt;<a href=3D"mailto:ind=
ou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org">indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt; (2013/06/12 13:45), Bjorn Helgaas wrote:<br>
&gt;&gt;&gt; [+cc Vivek, Haren; sorry I didn&#39;t think to add you earlier=
]<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Tue, Jun 11, 2013 at 12:08 AM, Takao Indoh<br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org">indou.takao@=
jp.fujitsu.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; (2013/06/11 11:20), Bjorn Helgaas wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I&#39;m not sure you need to reset legacy devices (or =
non-PCI devices)<br>
&gt;&gt;&gt;&gt;&gt; yet, but the current hook isn&#39;t anchored anywhere =
-- it&#39;s just an<br>
&gt;&gt;&gt;&gt;&gt; fs_initcall() that doesn&#39;t give the reader any clu=
e about the<br>
&gt;&gt;&gt;&gt;&gt; connection between the reset and the problem it&#39;s =
solving.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; If we do something like this patch, I think it needs t=
o be done at the<br>
&gt;&gt;&gt;&gt;&gt; point where we enable or disable the IOMMU. =C2=A0That=
 way, it&#39;s connected<br>
&gt;&gt;&gt;&gt;&gt; to the important event, and there&#39;s a clue about h=
ow to make<br>
&gt;&gt;&gt;&gt;&gt; corresponding fixes for other IOMMUs.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Ok. pci_iommu_init() is appropriate place to add this hook=
?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I looked at various IOMMU init places today, and it&#39;s far =
more<br>
&gt;&gt;&gt; complicated and varied than I had hoped.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This reset scheme depends on enumerating PCI devices before we=
<br>
&gt;&gt;&gt; initialize the IOMMU used by those devices. =C2=A0x86 works th=
at way today,<br>
&gt;&gt;&gt; but not all architectures do (see the sparc pci_fire_pbm_init(=
), for<br>
&gt;&gt;<br>
&gt;&gt; Sorry, could you tell me which part depends on architecture?<br>
&gt;<br>
&gt; Your patch works if PCIe devices are reset before the kdump kernel<br>
&gt; enables the IOMMU. =C2=A0On x86, this is possible because PCI enumerat=
ion<br>
&gt; happens before the IOMMU initialization. =C2=A0On sparc, the IOMMU is<=
br>
&gt; initialized before PCI devices are enumerated, so there would still be=
<br>
&gt; a window where ongoing DMA could cause an IOMMU error.<br>
<br>
</div></div>Ok, understood, thanks.<br>
<br>
Hmmm, it seems to be difficult to find out method which is common to<br>
all architectures. So, what I can do for now is introducing reset scheme<br=
>
which is only for x86.<br>
<br>
1) Change this patch so that it work only on x86 platform. For example<br>
=C2=A0 =C2=A0call this reset code from x86_init.iommu.iommu_init() instead =
of<br>
=C2=A0 =C2=A0fs_initcall.<br>
<br>
Or another idea is:<br>
<br>
2) Enumerate PCI devices in IOMMU layer. That is:<br>
=C2=A0 =C2=A0PCI layer<br>
=C2=A0 =C2=A0 =C2=A0Just provide interface to reset given strcut pci_dev. M=
aybe<br>
=C2=A0 =C2=A0 =C2=A0pci_reset_function() looks good for this purpose.<br>
=C2=A0 =C2=A0IOMMU layer<br>
=C2=A0 =C2=A0 =C2=A0Determine which devices should be reset. On kernel boot=
, check if<br>
=C2=A0 =C2=A0 =C2=A0IOMMU is already active or not, and if active, check IO=
MMU page<br>
=C2=A0 =C2=A0 =C2=A0table and reset devices whose entry exists there.<br>
<div class=3D"im"><br>
&gt; Of course, it might be possible to reorganize the sparc code to to the=
<br>
&gt; IOMMU init *after* it enumerates PCI devices. =C2=A0But I think that c=
hange<br>
&gt; would be hard to justify.<br>
&gt;<br>
&gt; And I think even on x86, it would be better if we did the IOMMU init<b=
r>
&gt; before PCI enumeration -- the PCI devices depend on the IOMMU, so<br>
&gt; logically the IOMMU should be initialized first so the PCI devices can=
<br>
&gt; be associated with it as they are enumerated.<br>
<br>
</div>So third idea is:<br>
<br>
3) Do reset before PCI enumeration(arch_initcall_sync or somewhere). We<br>
=C2=A0 =C2=A0need to implement new code to enumerate PCI devices and reset =
them<br>
=C2=A0 =C2=A0for this purpose.<br>
<br>
Idea 2 is not difficult to implement, but one problem is that this<br>
method may be dangerous. We need to scan IOMMU page table which is used<br>
in previous kernel, but it may be broken. Idea 3 seems to be difficult<br>
to implement...<br>
<div class=3D"im"><br>
<br>
&gt;<br>
&gt;&gt;&gt; example). =C2=A0And I think conceptually, the IOMMU should be =
enumerated<br>
&gt;&gt;&gt; and initialized *before* the devices that use it.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; So I&#39;m uncomfortable with that aspect of this scheme.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; It would be at least conceivable to reset the devices in the s=
ystem<br>
&gt;&gt;&gt; kernel, before the kexec. =C2=A0I know we want to do as little=
 as possible<br>
&gt;&gt;&gt; in the crashing kernel, but it&#39;s at least a possibility, a=
nd it might<br>
&gt;&gt;&gt; be cleaner.<br>
&gt;&gt;<br>
&gt;&gt; I bet this will be not accepted by kdump maintainer. Everything in=
 panic<br>
&gt;&gt; kernel is unreliable.<br>
&gt;<br>
&gt; kdump is inherently unreliable. =C2=A0The kdump kernel doesn&#39;t sta=
rt from<br>
&gt; an arbitrary machine state. =C2=A0We don&#39;t expect it to tolerate a=
ll CPUs<br>
&gt; running, for example. =C2=A0Maybe it should be expected to tolerate PC=
I<br>
&gt; devices running, either.<br>
<br>
</div>What I wanted to say is that any resources of first kernel are<br>
unreliable. Under panic situation, struct pci_dev tree may be broken, or<br=
>
pci_lock may be already hold by someone, etc. So, if we do this in first<br=
>
kernel, maybe kdump needs its own code to enumerate PCI devices and<br>
reset them.<br>
<br>
Vivek?<br></blockquote><div><br></div><div>Ping Vivek<br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
<br>
Thanks,<br>
Takao Indoh<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
Please read the FAQ at =C2=A0<a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards<br>=
Dave
</div></div>

--089e011821ea060a1504dff67f05--

--===============1023665509278898032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1023665509278898032==--
