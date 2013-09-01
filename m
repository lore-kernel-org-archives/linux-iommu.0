From: "Shankar, Hari" <Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Subject: bug in intel_iommu_unmap()
Date: Sun, 1 Sep 2013 20:26:10 +0000
Message-ID: <CE48F11D.4142A%hshankar@netapp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_004_CE48F11D4142Ahshankarnetappcom_"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "Singh, Varinder" <Varinder.Singh-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Sundaram,
	Rajesh" <Rajesh.Sundaram-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Kimmel,
	Jeff" <jeff.kimmel-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Spiller, John" <John.Spiller-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--_004_CE48F11D4142Ahshankarnetappcom_
Content-Type: multipart/alternative;
	boundary="_000_CE48F11D4142Ahshankarnetappcom_"

--_000_CE48F11D4142Ahshankarnetappcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi David,
NetApp is using Linux VFIO code for user space drivers. We recently ran int=
o a memory corruption bug which was root caused to lack of IOMMU TLB flush =
in intel_iommu_unmap() routine.

While reviewing the code we also figured that the unmap routine always retu=
rns size only for one page rather than the total unmapped size. Since VFIO =
unmaps one page at a time, the problem isn't exposed

Alex Williamson suggested that you're the maintainer of the code so sending=
 to you for review.

Diff for the changes is attached and is generated on Linux kernel version 3=
.6.11

Hari.

--_000_CE48F11D4142Ahshankarnetappcom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <1E8A5284563A204FA279BACE7A032BD0-c5HhxtLuC0z3oGB3hsPCZA@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space; color: rgb(0, 0, 0); font-size: 14px; font-fami=
ly: Calibri, sans-serif; ">
<div>Hi David,</div>
<div>NetApp is using Linux VFIO code for user space drivers. We recently ra=
n into a memory corruption bug which was root caused to lack of IOMMU TLB f=
lush in&nbsp;intel_iommu_unmap() routine.&nbsp;</div>
<div><br>
</div>
<div>While reviewing the code we also figured&nbsp;that the unmap routine&n=
bsp;always returns size only for one page rather than the total unmapped si=
ze. Since VFIO unmaps one page at a time, the problem isn't exposed</div>
<div><br>
</div>
<div>Alex Williamson suggested that you're the maintainer of the code so se=
nding to you for review.</div>
<div><br>
</div>
<div>Diff for the changes is attached and is generated on&nbsp;Linux kernel=
 version 3.6.11</div>
<div><br>
</div>
<div>Hari.</div>
</body>
</html>

--_000_CE48F11D4142Ahshankarnetappcom_--

--_004_CE48F11D4142Ahshankarnetappcom_
Content-Type: text/plain; name="intel_iommu_unmap_patch.txt"
Content-Description: intel_iommu_unmap_patch.txt
Content-Disposition: attachment; filename="intel_iommu_unmap_patch.txt";
	size=1695; creation-date="Sun, 01 Sep 2013 20:26:09 GMT";
	modification-date="Sun, 01 Sep 2013 20:26:09 GMT"
Content-ID: <89C4F83DFDA9D44683F3758D87E2E1AC-c5HhxtLuC0z3oGB3hsPCZA@public.gmane.org>
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYy5vcmlnICAgIDIwMTMtMDktMDEgMTA6MTA6
MTQuNzIzOTU4MDAwIC0wNzAwCisrKyBkcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMgMjAxMy0w
OS0wMSAxMDoxNzoyMi40Mjg0MTIwMDAgLTA3MDAKQEAgLTQwNjAsMTQgKzQwNjAsMzQgQEAgc3Rh
dGljIHNpemVfdCBpbnRlbF9pb21tdV91bm1hcChzdHJ1Y3QgaQogewogICAgICAgIHN0cnVjdCBk
bWFyX2RvbWFpbiAqZG1hcl9kb21haW4gPSBkb21haW4tPnByaXY7CiAgICAgICAgaW50IG9yZGVy
OworICAgICAgIHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXU7CisgICAgICAgdW5zaWduZWQgbG9u
ZyBzdGFydF9wZm4sIGxhc3RfcGZuOworICAgICAgIHVuc2lnbmVkIGludCBucGFnZXM7CisgICAg
ICAgaW50IGlvbW11X2lkLCBudW0sIG5kb21haW5zOwoKLSAgICAgICBvcmRlciA9IGRtYV9wdGVf
Y2xlYXJfcmFuZ2UoZG1hcl9kb21haW4sIGlvdmEgPj4gVlREX1BBR0VfU0hJRlQsCi0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAoaW92YSArIHNpemUgLSAxKSA+PiBWVERfUEFHRV9TSElGVCk7
CisgICAgICAgc3RhcnRfcGZuID0gaW92YSA+PiBWVERfUEFHRV9TSElGVDsKKyAgICAgICBsYXN0
X3BmbiA9IChpb3ZhICsgc2l6ZSAtIDEpID4+IFZURF9QQUdFX1NISUZUOworICAgICAgIG9yZGVy
ID0gZG1hX3B0ZV9jbGVhcl9yYW5nZShkbWFyX2RvbWFpbiwgc3RhcnRfcGZuLCBsYXN0X3Bmbik7
CgotICAgICAgIGlmIChkbWFyX2RvbWFpbi0+bWF4X2FkZHIgPT0gaW92YSArIHNpemUpCi0gICAg
ICAgICAgICAgICBkbWFyX2RvbWFpbi0+bWF4X2FkZHIgPSBpb3ZhOworICAgICAgIGxhc3RfcGZu
IHw9ICgxVUwgPDwgb3JkZXIpIC0gMTsKKyAgICAgICBucGFnZXMgPSBsYXN0X3BmbiAtIHN0YXJ0
X3BmbiArIDE7CisKKyAgICAgICBmb3JfZWFjaF9zZXRfYml0KGlvbW11X2lkLCBkbWFyX2RvbWFp
bi0+aW9tbXVfYm1wLCBnX251bV9vZl9pb21tdXMpIHsKKyAgICAgICAgICAgICAgIGlvbW11ID0g
Z19pb21tdXNbaW9tbXVfaWRdOwoKLSAgICAgICByZXR1cm4gUEFHRV9TSVpFIDw8IG9yZGVyOwor
ICAgICAgICAgICAgICAgLyoKKyAgICAgICAgICAgICAgICAqIGZpbmQgYml0IHBvc2l0aW9uIG9m
IGRtYXJfZG9tYWluCisgICAgICAgICAgICAgICAgKi8KKyAgICAgICAgICAgICAgIG5kb21haW5z
ID0gY2FwX25kb21zKGlvbW11LT5jYXApOworICAgICAgICAgICAgICAgZm9yX2VhY2hfc2V0X2Jp
dChudW0sIGlvbW11LT5kb21haW5faWRzLCBuZG9tYWlucykKKyAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKGlvbW11LT5kb21haW5zW251bV0gPT0gZG1hcl9kb21haW4pCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW9tbXVfZmx1c2hfaW90bGJfcHNpKGlvbW11LCBudW0sIHN0YXJ0
X3BmbiwgbnBhZ2VzLCAwKTsKKyAgICAgICB9CisKKyAgICAgICBpZiAoZG1hcl9kb21haW4tPm1h
eF9hZGRyIDw9IGlvdmEgKyAobnBhZ2VzIDw8IFZURF9QQUdFX1NISUZUKSkKKyAgICAgICAgICAg
ICAgIGRtYXJfZG9tYWluLT5tYXhfYWRkciA9IGlvdmE7CisKKyAgICAgICByZXR1cm4gbnBhZ2Vz
IDw8IFZURF9QQUdFX1NISUZUOwogfQoKIHN0YXRpYyBwaHlzX2FkZHJfdCBpbnRlbF9pb21tdV9p
b3ZhX3RvX3BoeXMoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAoK

--_004_CE48F11D4142Ahshankarnetappcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_004_CE48F11D4142Ahshankarnetappcom_--
