From: Lars Segerlund <lars.segerlund-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: problems with iommu and userspace DMA to hugepages, how to add iommu
	mapings from userspace.
Date: Thu, 10 Nov 2016 12:16:19 +0100
Message-ID: <CAF-VNarFte4k0bAEjYkUMaCeWXqFZZdn-EHFPGKj8M7y9iCd+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4620315923197958331=="
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

--===============4620315923197958331==
Content-Type: multipart/alternative; boundary=001a114381fcc322000540f080a7

--001a114381fcc322000540f080a7
Content-Type: text/plain; charset=UTF-8

 Hi,

 I am getting these errors from a userspace 'device driver' ,

[599805.585424] DMAR: DRHD: handling fault status reg 202
[599805.585431] DMAR: DMAR:[DMA Read] Request device [03:00.0] fault addr
4c0008000
                DMAR:[fault reason 06] PTE Read access is not set

 Basicly i mapp a dma engine in a PCIe card by uio to a userspace library,
and then allocate hugepages ( continous ),  do a virt to phys translation
via /proc/self/.... setup a dma and turn it on.

The message tells me I lack iommu mappings for the memory regions i try to
read/write , so far so good nothing unexpected.

My problem is that I have to run with intel_iommu=on iommu=pt flags to the
kernel due to other hard/software on the machine, I can't turn iommu off
completely.

So I have the question is it possible to add iommu mappings from userspace
? through iommu groups in /sys/..  ?

So far all applications that does something similar either uses vfio or
some kernel driver callback and I would prefer not to do this.
( I had high hopes for dpdk pmd driver but so far no luck ).

 All hints and help appreciated ! :-D

 / regards, Lars Segerlund.

--001a114381fcc322000540f080a7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:x-small"><=
br></div><div class=3D"gmail_default" style=3D"font-size:x-small">=C2=A0Hi,=
<br><br></div><div class=3D"gmail_default" style=3D"font-size:x-small">=C2=
=A0I am getting these errors from a userspace &#39;device driver&#39; ,<br>=
<br>[599805.585424] DMAR: DRHD: handling fault status reg 202<br>[599805.58=
5431] DMAR: DMAR:[DMA Read] Request device [03:00.0] fault addr 4c0008000<b=
r>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 DMAR:[fault reason 06] PTE Read access is not set<br><br=
></div><div class=3D"gmail_default" style=3D"font-size:x-small">=C2=A0Basic=
ly i mapp a dma engine in a PCIe card by uio to a userspace library, and th=
en allocate hugepages ( continous ),=C2=A0 do a virt to phys translation vi=
a /proc/self/.... setup a dma and turn it on.<br><br></div><div class=3D"gm=
ail_default" style=3D"font-size:x-small">The message tells me I lack iommu =
mappings for the memory regions i try to read/write , so far so good nothin=
g unexpected.<br><br></div><div class=3D"gmail_default" style=3D"font-size:=
x-small">My problem is that I have to run with intel_iommu=3Don iommu=3Dpt =
flags to the kernel due to other hard/software on the machine, I can&#39;t =
turn iommu off completely.<br><br></div><div class=3D"gmail_default" style=
=3D"font-size:x-small">So I have the question is it possible to add iommu m=
appings from userspace ? through iommu groups in /sys/..=C2=A0 ?<br><br></d=
iv><div class=3D"gmail_default" style=3D"font-size:x-small">So far all appl=
ications that does something similar either uses vfio or some kernel driver=
 callback and I would prefer not to do this.<br></div><div class=3D"gmail_d=
efault" style=3D"font-size:x-small">( I had high hopes for dpdk pmd driver =
but so far no luck ).<br><br></div><div class=3D"gmail_default" style=3D"fo=
nt-size:x-small">=C2=A0All hints and help appreciated ! :-D<br><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:x-small">=C2=A0/ regards, Lar=
s Segerlund.<br><br></div></div>

--001a114381fcc322000540f080a7--

--===============4620315923197958331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4620315923197958331==--
