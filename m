From: "Shankar, Hari" <Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Subject: Re: bug in intel_iommu_unmap()
Date: Mon, 2 Sep 2013 01:54:32 +0000
Message-ID: <CE493D74.414FF%hshankar@netapp.com>
References: <CE48F11D.4142A%hshankar@netapp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4028847496147214152=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CE48F11D.4142A%hshankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
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

--===============4028847496147214152==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CE493D74414FFhshankarnetappcom_"

--_000_CE493D74414FFhshankarnetappcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please ignore this email. Per suggestion from Alex, I will send another ema=
il to fix some style points related to the patch. Thanks Alex for pointing =
it out.

Hari.

From: <Shankar>, Hari <Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org<mailto:Hari.Shankar@netapp.c=
om>>
Date: Sunday, September 1, 2013 1:26 PM
To: "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org<mailto:dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org<=
mailto:dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org<mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+c@public.gmane.org=
rg>" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org<mailto:iommu-cunTk1MwBs9QetFLy7KEmxxBWXNxL4zz@public.gmane.org=
org>>, "Kimmel, Jeff" <jeff.kimmel-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org<mailto:jeff.kimmel-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org=
>>, "Spiller, John" <John.Spiller-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org<mailto:John.Spiller-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org=
>>, "Singh, Varinder" <Varinder.Singh-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org<mailto:Varinder.Singh@neta=
pp.com>>, "Sundaram, Rajesh" <Rajesh.Sundaram-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org<mailto:Rajesh.Sund=
aram-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org<mailto:alex.=
williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>
Subject: bug in intel_iommu_unmap()

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

--_000_CE493D74414FFhshankarnetappcom_
Content-Type: text/html; charset="us-ascii"
Content-ID: <0D1DE198C3224049A47304671399F2E3-c5HhxtLuC0z3oGB3hsPCZA@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space; color: rgb(0, 0, 0); font-size: 14px; font-fami=
ly: Calibri, sans-serif; ">
<div>Please ignore this email. Per suggestion from Alex, I will send anothe=
r email to fix some style points related to the patch. Thanks Alex for poin=
ting it out.</div>
<div><br>
</div>
<div>Hari.</div>
<div><br>
</div>
<span id=3D"OLK_SRC_BODY_SECTION">
<div style=3D"font-family:Calibri; font-size:11pt; text-align:left; color:b=
lack; BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; PADDING-BOTTOM:=
 0in; PADDING-LEFT: 0in; PADDING-RIGHT: 0in; BORDER-TOP: #b5c4df 1pt solid;=
 BORDER-RIGHT: medium none; PADDING-TOP: 3pt">
<span style=3D"font-weight:bold">From: </span>&lt;Shankar&gt;, Hari &lt;<a =
href=3D"mailto:Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org">Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
<span style=3D"font-weight:bold">Date: </span>Sunday, September 1, 2013 1:2=
6 PM<br>
<span style=3D"font-weight:bold">To: </span>&quot;<a href=3D"mailto:dwmw2@i=
nfradead.org">dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org</a>&quot; &lt;<a href=3D"mailto:dwmw2@inf=
radead.org">dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org</a>&gt;<br>
<span style=3D"font-weight:bold">Cc: </span>&quot;<a href=3D"mailto:iommu@l=
ists.linux-foundation.org">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a>&quot; &lt;<=
a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm3ANibfEOA+W@public.gmane.org=
tion.org</a>&gt;, &quot;Kimmel, Jeff&quot; &lt;<a href=3D"mailto:jeff.kimme=
l@netapp.com">jeff.kimmel-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org</a>&gt;,
 &quot;Spiller, John&quot; &lt;<a href=3D"mailto:John.Spiller-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org">J=
ohn.Spiller-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org</a>&gt;, &quot;Singh, Varinder&quot; &lt;<a href=3D"=
mailto:Varinder.Singh-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org">Varinder.Singh-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org</a>&gt;, &quot;=
Sundaram, Rajesh&quot; &lt;<a href=3D"mailto:Rajesh.Sundaram-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org">Ra=
jesh.Sundaram-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org</a>&gt;,
 Alex Williamson &lt;<a href=3D"mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">alex.wil=
liamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
<span style=3D"font-weight:bold">Subject: </span>bug in intel_iommu_unmap()=
<br>
</div>
<div><br>
</div>
<div>
<div style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line=
-break: after-white-space; color: rgb(0, 0, 0); font-size: 14px; font-famil=
y: Calibri, sans-serif; ">
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
</div>
</div>
</span>
</body>
</html>

--_000_CE493D74414FFhshankarnetappcom_--

--===============4028847496147214152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4028847496147214152==--
