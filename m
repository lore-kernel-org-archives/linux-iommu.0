From: Alejandro Lucero <alejandro.lucero-wFxRvT7yatFl57MIdRCFDg@public.gmane.org>
Subject: SRIOV and clear_context_table
Date: Tue, 21 Apr 2015 18:38:55 +0100
Message-ID: <CAD+H990_L1fWeb9b1LRH=h2E+vbz1whZpDSBwrtLp8=si1hP=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf307cfd0e4ccaf705143f85c9
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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

--20cf307cfd0e4ccaf705143f85c9
Content-Type: multipart/alternative; boundary=20cf307cfd0e4ccaf405143f85c7

--20cf307cfd0e4ccaf405143f85c7
Content-Type: text/plain; charset=UTF-8

Hi,

I've been trying to understand some DMAR errors we got with our device
which supports SRIOV. We create 8 VFs and we use two of them for
configuring two ethernet interfaces. No VM is involved. The first time
interfaces are upped all works fine. Some time later they are downed and
the VFs removed. If we create the VFs again then we got this when upping
the interfaces:

[ 611.152374] dmar: DMAR:[DMA Read] Request device [02:08.0] fault addr
fffe8000
[ 611.152374] DMAR:[fault reason 06] PTE Read access is not set
[ 611.324461] dmar: DMAR:[DMA Read] Request device [02:08.1] fault addr
fffe8000
[ 611.324461] DMAR:[fault reason 06] PTE Read access is not set

The address involved is just the first dma address used by the device for
getting RX ring descriptors. I have used iommu kernel traces and also some
specific ones (as I found those events not helpful enough) and I could see
the mappings being done both times the devices are upped and with the right
read/write permissions.

Then I looked at the work done each time the VFs are created and I found
out the context entry is not created the second time. When VFs are removed
the iommu_bus_notifier gets action for removing device calling
intel_iommu_remove_device. There just call for removing the iommu group is
done so the context entry is used later on.

I have seen that more work is done when a device is detached from a VM. In
that case code calls to clear_context_entry and also some calls to flushing
iotlb. So I have tried adding the same code when removing the VF and this
solves the issue.

I do not know if this is the right thing to do. I know attaching and
detaching devices to VMs is likely more usual and then that functionality
is well tested. By other hand, creating and destroying VFs could be
unlikely or even considered unsense and then this has never been tested.

I'm working with a 3.13.0-49 Ubuntu kernel. Last stable kernel from Linus
Torvalds is not doing anything different related to the remove device
action.

The patch applied to intel-iommu.c is attached.

--20cf307cfd0e4ccaf405143f85c7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;ve been trying to understand =
some DMAR errors we got with our device which supports SRIOV. We create 8 V=
Fs and we use two of them for configuring two ethernet interfaces. No VM is=
 involved. The first time interfaces are upped all works fine. Some time la=
ter they are downed and the VFs removed. If we create the VFs again then we=
 got this when upping the interfaces:</div><div><br></div><div><span style=
=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-he=
ight:18.1818180084229px">[ 611.152374] dmar: DMAR:</span><span class=3D"" s=
tyle=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;lin=
e-height:18.1818180084229px">[DMA Read]</span><span style=3D"color:rgb(51,5=
1,51);font-family:Arial,sans-serif;font-size:14px;line-height:18.1818180084=
229px">=C2=A0Request device=C2=A0</span><span class=3D"" style=3D"color:rgb=
(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-height:18.18181=
80084229px">[02:08.0]</span><span style=3D"color:rgb(51,51,51);font-family:=
Arial,sans-serif;font-size:14px;line-height:18.1818180084229px">=C2=A0fault=
 addr fffe8000=C2=A0</span><br style=3D"color:rgb(51,51,51);font-family:Ari=
al,sans-serif;font-size:14px;line-height:18.1818180084229px"><span style=3D=
"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-heigh=
t:18.1818180084229px">[ 611.152374] DMAR:</span><span class=3D"" style=3D"c=
olor:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-height:=
18.1818180084229px">[fault reason 06]</span><span style=3D"color:rgb(51,51,=
51);font-family:Arial,sans-serif;font-size:14px;line-height:18.181818008422=
9px">=C2=A0PTE Read access is not set</span><br style=3D"color:rgb(51,51,51=
);font-family:Arial,sans-serif;font-size:14px;line-height:18.1818180084229p=
x"><span style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-siz=
e:14px;line-height:18.1818180084229px">[ 611.324461] dmar: DMAR:</span><spa=
n class=3D"" style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font=
-size:14px;line-height:18.1818180084229px">[DMA Read]</span><span style=3D"=
color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-height=
:18.1818180084229px">=C2=A0Request device=C2=A0</span><span class=3D"" styl=
e=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-h=
eight:18.1818180084229px">[02:08.1]</span><span style=3D"color:rgb(51,51,51=
);font-family:Arial,sans-serif;font-size:14px;line-height:18.1818180084229p=
x">=C2=A0fault addr fffe8000=C2=A0</span><br style=3D"color:rgb(51,51,51);f=
ont-family:Arial,sans-serif;font-size:14px;line-height:18.1818180084229px">=
<span style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:1=
4px;line-height:18.1818180084229px">[ 611.324461] DMAR:</span><span class=
=3D"" style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:1=
4px;line-height:18.1818180084229px">[fault reason 06]</span><span style=3D"=
color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-height=
:18.1818180084229px">=C2=A0PTE Read access is not set</span><br></div><div>=
<span style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:1=
4px;line-height:18.1818180084229px"><br></span></div><div><span style=3D"co=
lor:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;line-height:1=
8.1818180084229px">The address involved is just the first dma address used =
by the device for getting RX ring descriptors. I have used iommu kernel tra=
ces and also some specific ones (as I found those events not helpful enough=
) and I could see the mappings being done both times the devices are upped =
and with the right read/write permissions.=C2=A0</span></div><div><br></div=
><div>Then I looked at the work done each time the VFs are created and I fo=
und out the context entry is not created the second time. When VFs are remo=
ved the iommu_bus_notifier gets action for removing device calling intel_io=
mmu_remove_device. There just call for removing the iommu group is done so =
the context entry is used later on.</div><div><br></div><div>I have seen th=
at more work is done when a device is detached from a VM. In that case code=
 calls to clear_context_entry and also some calls to flushing iotlb. So I h=
ave tried adding the same code when removing the VF and this solves the iss=
ue.</div><div><br></div><div>I do not know if this is the right thing to do=
. I know attaching and detaching devices to VMs is likely more usual and th=
en that functionality is well tested. By other hand, creating and destroyin=
g VFs could be unlikely or even considered unsense and then this has never =
been tested.</div><div><br></div><div>I&#39;m working with a 3.13.0-49 Ubun=
tu kernel. Last stable kernel from Linus Torvalds is not doing anything dif=
ferent related to the remove device action.</div><div><br></div><div>The pa=
tch applied to intel-iommu.c is attached.</div><div><br></div><div><br></di=
v></div>

--20cf307cfd0e4ccaf405143f85c7--

--20cf307cfd0e4ccaf705143f85c9
Content-Type: application/octet-stream; name="intel-iommu.patch"
Content-Disposition: attachment; filename="intel-iommu.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i8rkpv7e0

LS0tIGludGVsLWlvbW11LmMub3JpZwkyMDE1LTA0LTIxIDE4OjExOjMyLjY5MDIxOTk2NiArMDEw
MAorKysgaW50ZWwtaW9tbXUuYwkyMDE1LTA0LTIxIDE4OjEzOjI3Ljk3NjA1NDIzMiArMDEwMApA
QCAtNDI0Miw2ICs0MjQyLDE4IEBACiAKIHN0YXRpYyB2b2lkIGludGVsX2lvbW11X3JlbW92ZV9k
ZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQogeworCXN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXU7
CisJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGRldik7CisKKwlpb21tdSA9IGRl
dmljZV90b19pb21tdShwY2lfZG9tYWluX25yKHBkZXYtPmJ1cyksIHBkZXYtPmJ1cy0+bnVtYmVy
LAorCQkJCQkJCXBkZXYtPmRldmZuKTsKKworCWlmIChpb21tdSAmJiAocGRldi0+ZGV2Zm4gPT0g
MHg0MCB8fCBwZGV2LT5kZXZmbiA9PSAweDQxKSkgeworCQljbGVhcl9jb250ZXh0X3RhYmxlKGlv
bW11LCBwZGV2LT5idXMtPm51bWJlciwgcGRldi0+ZGV2Zm4pOworCQlpb21tdS0+Zmx1c2guZmx1
c2hfY29udGV4dChpb21tdSwgMCwgMCwgMCwgRE1BX0NDTURfR0xPQkFMX0lOVkwpOworCQlpb21t
dS0+Zmx1c2guZmx1c2hfaW90bGIoaW9tbXUsIDAsIDAsIDAsIERNQV9UTEJfR0xPQkFMX0ZMVVNI
KTsKKwl9CisKIAlpb21tdV9ncm91cF9yZW1vdmVfZGV2aWNlKGRldik7CiB9CiAK
--20cf307cfd0e4ccaf705143f85c9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf307cfd0e4ccaf705143f85c9--
