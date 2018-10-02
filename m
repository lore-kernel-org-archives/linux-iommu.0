From: Yang Yang <yyang0729-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: add_device vs attach_device
Date: Mon, 1 Oct 2018 20:48:42 -0700
Message-ID: <CAFT6yXGcm1g0G_RAu1usA2mcQ3MSs30ZPZzmL1qNDbOS1cY5Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8689476382022866537=="
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

--===============8689476382022866537==
Content-Type: multipart/alternative; boundary="000000000000ef41b5057736cc55"

--000000000000ef41b5057736cc55
Content-Type: text/plain; charset="UTF-8"

Hi all,
I have a very basic question, what's the difference betwee
arm_smmu_attach_dev()
and arm_smmu_add_device() in ARM SMMUv3 driver? When should I use which
method?

Thanks,
- y

--000000000000ef41b5057736cc55
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Hi all,</div><div class=3D"gmail_default" style=3D"font=
-family:arial,helvetica,sans-serif">I have a very basic question, what&#39;=
s the difference betwee=C2=A0<span style=3D"color:rgb(0,0,0);font-family:Ar=
ial,Helvetica,sans-serif">arm_smmu_attach_dev() and=C2=A0</span><span style=
=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif">arm_smmu_add_d=
evice() in ARM SMMUv3 driver? When should I use which method?</span></div><=
div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif=
"><span style=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif"><=
br></span></div><div class=3D"gmail_default" style=3D"font-family:arial,hel=
vetica,sans-serif"><span style=3D"color:rgb(0,0,0);font-family:Arial,Helvet=
ica,sans-serif">Thanks,</span></div><div><div dir=3D"ltr" class=3D"gmail_si=
gnature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<div><font face=3D"arial, helvetica, sans-serif">- y</font></div></div></di=
v></div></div></div></div></div></div></div></div></div></div>

--000000000000ef41b5057736cc55--

--===============8689476382022866537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8689476382022866537==--
