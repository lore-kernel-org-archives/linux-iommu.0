From: Alejandro Lucero <alejandro.lucero-wFxRvT7yatFl57MIdRCFDg@public.gmane.org>
Subject: Re: SRIOV and clear_context_table
Date: Wed, 13 May 2015 14:04:12 +0100
Message-ID: <CAD+H992n+au2hT5wCUhNVAsQBrjDkYUQrXg9qsqdW_r9OW3K_g@mail.gmail.com>
References: <CAD+H990_L1fWeb9b1LRH=h2E+vbz1whZpDSBwrtLp8=si1hP=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8017918286668362233=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAD+H990_L1fWeb9b1LRH=h2E+vbz1whZpDSBwrtLp8=si1hP=w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============8017918286668362233==
Content-Type: multipart/alternative; boundary=089e0160bd145f11300515f63f0b

--089e0160bd145f11300515f63f0b
Content-Type: text/plain; charset=UTF-8

I have found out the problem is related to using iommu=pt and a device not
setting dma_mask_coherent.

In that case the kernel does not use the identity mapping but a specific
one for that device. But a kernel bug avoids the device mapping being
removed if iommu=pt whatever the device gets or not the identity mapping.

I can see that has been fixed at some point because last kernel has not
this problem.

On Tue, Apr 21, 2015 at 6:38 PM, Alejandro Lucero <
alejandro.lucero-wFxRvT7yatFl57MIdRCFDg@public.gmane.org> wrote:

> Hi,
>
> I've been trying to understand some DMAR errors we got with our device
> which supports SRIOV. We create 8 VFs and we use two of them for
> configuring two ethernet interfaces. No VM is involved. The first time
> interfaces are upped all works fine. Some time later they are downed and
> the VFs removed. If we create the VFs again then we got this when upping
> the interfaces:
>
> [ 611.152374] dmar: DMAR:[DMA Read] Request device [02:08.0] fault addr
> fffe8000
> [ 611.152374] DMAR:[fault reason 06] PTE Read access is not set
> [ 611.324461] dmar: DMAR:[DMA Read] Request device [02:08.1] fault addr
> fffe8000
> [ 611.324461] DMAR:[fault reason 06] PTE Read access is not set
>
> The address involved is just the first dma address used by the device for
> getting RX ring descriptors. I have used iommu kernel traces and also some
> specific ones (as I found those events not helpful enough) and I could see
> the mappings being done both times the devices are upped and with the right
> read/write permissions.
>
> Then I looked at the work done each time the VFs are created and I found
> out the context entry is not created the second time. When VFs are removed
> the iommu_bus_notifier gets action for removing device calling
> intel_iommu_remove_device. There just call for removing the iommu group is
> done so the context entry is used later on.
>
> I have seen that more work is done when a device is detached from a VM. In
> that case code calls to clear_context_entry and also some calls to flushing
> iotlb. So I have tried adding the same code when removing the VF and this
> solves the issue.
>
> I do not know if this is the right thing to do. I know attaching and
> detaching devices to VMs is likely more usual and then that functionality
> is well tested. By other hand, creating and destroying VFs could be
> unlikely or even considered unsense and then this has never been tested.
>
> I'm working with a 3.13.0-49 Ubuntu kernel. Last stable kernel from Linus
> Torvalds is not doing anything different related to the remove device
> action.
>
> The patch applied to intel-iommu.c is attached.
>
>
>

--089e0160bd145f11300515f63f0b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have found out the problem is related to using iommu=3Dp=
t and a device not setting dma_mask_coherent.<div><br></div><div>In that ca=
se the kernel does not use the identity mapping but a specific one for that=
 device. But a kernel bug avoids the device mapping being removed if iommu=
=3Dpt whatever the device gets or not the identity mapping.</div><div><br><=
/div><div>I can see that has been fixed at some point because last kernel h=
as not this problem.</div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Tue, Apr 21, 2015 at 6:38 PM, Alejandro Lucero <span di=
r=3D"ltr">&lt;<a href=3D"mailto:alejandro.lucero-wFxRvT7yatFl57MIdRCFDg@public.gmane.org" target=3D"_=
blank">alejandro.lucero-wFxRvT7yatFl57MIdRCFDg@public.gmane.org</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>I&#39;ve been tr=
ying to understand some DMAR errors we got with our device which supports S=
RIOV. We create 8 VFs and we use two of them for configuring two ethernet i=
nterfaces. No VM is involved. The first time interfaces are upped all works=
 fine. Some time later they are downed and the VFs removed. If we create th=
e VFs again then we got this when upping the interfaces:</div><div><br></di=
v><div><span style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font=
-size:14px;line-height:18.1818180084229px">[ 611.152374] dmar: DMAR:</span>=
<span style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:1=
4px;line-height:18.1818180084229px">[DMA Read]</span><span style=3D"color:r=
gb(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-height:18.181=
8180084229px">=C2=A0Request device=C2=A0</span><span style=3D"color:rgb(51,=
51,51);font-family:Arial,sans-serif;font-size:14px;line-height:18.181818008=
4229px">[02:08.0]</span><span style=3D"color:rgb(51,51,51);font-family:Aria=
l,sans-serif;font-size:14px;line-height:18.1818180084229px">=C2=A0fault add=
r fffe8000=C2=A0</span><br style=3D"color:rgb(51,51,51);font-family:Arial,s=
ans-serif;font-size:14px;line-height:18.1818180084229px"><span style=3D"col=
or:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-height:18=
.1818180084229px">[ 611.152374] DMAR:</span><span style=3D"color:rgb(51,51,=
51);font-family:Arial,sans-serif;font-size:14px;line-height:18.181818008422=
9px">[fault reason 06]</span><span style=3D"color:rgb(51,51,51);font-family=
:Arial,sans-serif;font-size:14px;line-height:18.1818180084229px">=C2=A0PTE =
Read access is not set</span><br style=3D"color:rgb(51,51,51);font-family:A=
rial,sans-serif;font-size:14px;line-height:18.1818180084229px"><span style=
=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-he=
ight:18.1818180084229px">[ 611.324461] dmar: DMAR:</span><span style=3D"col=
or:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-height:18=
.1818180084229px">[DMA Read]</span><span style=3D"color:rgb(51,51,51);font-=
family:Arial,sans-serif;font-size:14px;line-height:18.1818180084229px">=C2=
=A0Request device=C2=A0</span><span style=3D"color:rgb(51,51,51);font-famil=
y:Arial,sans-serif;font-size:14px;line-height:18.1818180084229px">[02:08.1]=
</span><span style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font=
-size:14px;line-height:18.1818180084229px">=C2=A0fault addr fffe8000=C2=A0<=
/span><br style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-si=
ze:14px;line-height:18.1818180084229px"><span style=3D"color:rgb(51,51,51);=
font-family:Arial,sans-serif;font-size:14px;line-height:18.1818180084229px"=
>[ 611.324461] DMAR:</span><span style=3D"color:rgb(51,51,51);font-family:A=
rial,sans-serif;font-size:14px;line-height:18.1818180084229px">[fault reaso=
n 06]</span><span style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif=
;font-size:14px;line-height:18.1818180084229px">=C2=A0PTE Read access is no=
t set</span><br></div><div><span style=3D"color:rgb(51,51,51);font-family:A=
rial,sans-serif;font-size:14px;line-height:18.1818180084229px"><br></span><=
/div><div><span style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;f=
ont-size:14px;line-height:18.1818180084229px">The address involved is just =
the first dma address used by the device for getting RX ring descriptors. I=
 have used iommu kernel traces and also some specific ones (as I found thos=
e events not helpful enough) and I could see the mappings being done both t=
imes the devices are upped and with the right read/write permissions.=C2=A0=
</span></div><div><br></div><div>Then I looked at the work done each time t=
he VFs are created and I found out the context entry is not created the sec=
ond time. When VFs are removed the iommu_bus_notifier gets action for remov=
ing device calling intel_iommu_remove_device. There just call for removing =
the iommu group is done so the context entry is used later on.</div><div><b=
r></div><div>I have seen that more work is done when a device is detached f=
rom a VM. In that case code calls to clear_context_entry and also some call=
s to flushing iotlb. So I have tried adding the same code when removing the=
 VF and this solves the issue.</div><div><br></div><div>I do not know if th=
is is the right thing to do. I know attaching and detaching devices to VMs =
is likely more usual and then that functionality is well tested. By other h=
and, creating and destroying VFs could be unlikely or even considered unsen=
se and then this has never been tested.</div><div><br></div><div>I&#39;m wo=
rking with a 3.13.0-49 Ubuntu kernel. Last stable kernel from Linus Torvald=
s is not doing anything different related to the remove device action.</div=
><div><br></div><div>The patch applied to intel-iommu.c is attached.</div><=
div><br></div><div><br></div></div>
</blockquote></div><br></div>

--089e0160bd145f11300515f63f0b--

--===============8017918286668362233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8017918286668362233==--
