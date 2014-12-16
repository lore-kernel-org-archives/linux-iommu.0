From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: [PATCH 0/3] Add support for APM X-Gene SoC AHBC IOMMU driver.
Date: Tue, 16 Dec 2014 07:36:57 +0530
Message-ID: <CAOHikRCg02NeEpR4OXmjeJ4YbfUFrNandsENnStArkP6CKe6iw@mail.gmail.com>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
	<548F3C91.3030803@redhat.com>
	<CAOHikRB0eBnPnE+QWdmWunOMFHJOLDqU6o2ByBruQ3KC+1-XmA@mail.gmail.com>
	<20141215202738.GG24292@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1540810700857433716=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141215202738.GG24292-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, patches-qTEPVZfXA3Y@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1540810700857433716==
Content-Type: multipart/alternative; boundary=001a11c3be3252a33e050a4bd092

--001a11c3be3252a33e050a4bd092
Content-Type: text/plain; charset=UTF-8

Hi Joerg,

Hi Suman,

On Tue, Dec 16, 2014 at 01:31:58AM +0530, Suman Tripathi wrote:
> On Dec 16, 2014 1:25 AM, "Don Dutile" <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
>     On 12/15/2014 11:55 AM, Suman Tripathi wrote:
>
>         This patch adds the support for the APM X-Gene SoC AHBC IOMMU
driver.
>
>         Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
>         ---
>
>         Suman Tripathi (3):
>            xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC IOMMU
driver.
>            arm64: dts: Add the APM X-Gene AHBC IOMMU DTS node.
>            Documentation: dt-bindings: Add the binding info for APM
X-Gene AHBC
>              IOMMU driver.
>
>           .../devicetree/bindings/iommu/xgene,ahbc-iommu.txt |  17 ++
>           arch/arm64/boot/dts/apm-storm.dtsi                 |   5 +
>           drivers/iommu/Kconfig                              |  10 +
>           drivers/iommu/Makefile                             |   1 +
>           drivers/iommu/xgene-ahbc-iommu.c                   | 336
>         +++++++++++++++++++++
>           5 files changed, 369 insertions(+)
>           create mode 100644 Documentation/devicetree/bindings/iommu/
>         xgene,ahbc-iommu.txt
>           create mode 100644 drivers/iommu/xgene-ahbc-iommu.c
What are the differences between the X-Gene IOMMU and the ARM-SMMU?
[suman] : AHBC is IP from XGene for performing 32-bi to 64 bit and vice
versa with AHBC peripherals. ARM-SMMU is IP from ARM which performs
translations of different peripherals other than AHBC .

Thanks,
with regards,
suman

On Tue, Dec 16, 2014 at 1:57 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>
> Hi Suman,
>
> On Tue, Dec 16, 2014 at 01:31:58AM +0530, Suman Tripathi wrote:
> > On Dec 16, 2014 1:25 AM, "Don Dutile" <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >
> >     On 12/15/2014 11:55 AM, Suman Tripathi wrote:
> >
> >         This patch adds the support for the APM X-Gene SoC AHBC IOMMU
> driver.
> >
> >         Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
> >         ---
> >
> >         Suman Tripathi (3):
> >            xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC IOMMU
> driver.
> >            arm64: dts: Add the APM X-Gene AHBC IOMMU DTS node.
> >            Documentation: dt-bindings: Add the binding info for APM
> X-Gene AHBC
> >              IOMMU driver.
> >
> >           .../devicetree/bindings/iommu/xgene,ahbc-iommu.txt |  17 ++
> >           arch/arm64/boot/dts/apm-storm.dtsi                 |   5 +
> >           drivers/iommu/Kconfig                              |  10 +
> >           drivers/iommu/Makefile                             |   1 +
> >           drivers/iommu/xgene-ahbc-iommu.c                   | 336
> >         +++++++++++++++++++++
> >           5 files changed, 369 insertions(+)
> >           create mode 100644 Documentation/devicetree/bindings/iommu/
> >         xgene,ahbc-iommu.txt
> >           create mode 100644 drivers/iommu/xgene-ahbc-iommu.c
>
> What are the differences between the X-Gene IOMMU and the ARM-SMMU?
>
>
>         Joerg
>
>

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.

--001a11c3be3252a33e050a4bd092
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Joerg,<div><br></div><div><span style=3D"font-size:13px=
">Hi Suman,</span><br style=3D"font-size:13px"><div style=3D"font-size:13px=
"><div class=3D"adm"><div id=3D"q_14a4fb73a9efe109_1" class=3D"h4"><div cla=
ss=3D""></div></div></div><div class=3D"im"><br>On Tue, Dec 16, 2014 at 01:=
31:58AM +0530, Suman Tripathi wrote:<br>&gt; On Dec 16, 2014 1:25 AM, &quot=
;Don Dutile&quot; &lt;<a href=3D"mailto:ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">ddutile@redhat.=
com</a>&gt; wrote:<br>&gt;<br>&gt;=C2=A0 =C2=A0 =C2=A0On 12/15/2014 11:55 A=
M, Suman Tripathi wrote:<br>&gt;<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0T=
his patch adds the support for the APM X-Gene SoC AHBC IOMMU driver.<br>&gt=
;<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Suman Tripathi &l=
t;<a href=3D"mailto:stripathi-qTEPVZfXA3Y@public.gmane.org">stripathi-qTEPVZfXA3Y@public.gmane.org</a>&gt;<br>&gt;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---<br>&gt;<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Suman Tripathi (3):<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0 =C2=A0xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC IOMMU drive=
r.<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0arm64: dts: Add th=
e APM X-Gene AHBC IOMMU DTS node.<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=C2=A0 =C2=A0Documentation: dt-bindings: Add the binding info for APM X-Gen=
e AHBC<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0IOMMU d=
river.<br>&gt;<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 .../devicetr=
ee/bindings/iommu/xgene,ahbc-iommu.txt |=C2=A0 17 ++<br>&gt;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=C2=A0 arch/arm64/boot/dts/apm-storm.dtsi=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>&gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 drivers/iommu/Kconfig=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0 drivers/iommu/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br=
>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 drivers/iommu/xgene-ahbc-iomm=
u.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 3=
36<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+++++++++++++++++++++<br>&gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 5 files changed, 369 insertions(+)=
<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 create mode 100644 Documen=
tation/devicetree/bindings/iommu/<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
xgene,ahbc-iommu.txt<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 create=
 mode 100644 drivers/iommu/xgene-ahbc-iommu.c<br></div></div><span style=3D=
"font-size:13px">What are the differences between the X-Gene IOMMU and the =
ARM-SMMU?</span><div class=3D"" style=3D"font-size:13px"><div id=3D":29v" c=
lass=3D"" tabindex=3D"0"><img class=3D"" src=3D"https://ssl.gstatic.com/ui/=
v1/icons/mail/images/cleardot.gif">[suman] : AHBC is IP from XGene for perf=
orming 32-bi to 64 bit and vice versa with AHBC peripherals. ARM-SMMU is IP=
 from ARM which performs translations of different peripherals other than A=
HBC .</div><div id=3D":29v" class=3D"" tabindex=3D"0"><br></div><div id=3D"=
:29v" class=3D"" tabindex=3D"0">Thanks,</div><div id=3D":29v" class=3D"" ta=
bindex=3D"0">with regards,</div><div id=3D":29v" class=3D"" tabindex=3D"0">=
suman</div></div></div></div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Tue, Dec 16, 2014 at 1:57 AM, Joerg Roedel <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" target=3D"_blank">joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org</=
a>&gt;</span> wrote:<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Suman,<br>
<div><div class=3D"h5"><br>
On Tue, Dec 16, 2014 at 01:31:58AM +0530, Suman Tripathi wrote:<br>
&gt; On Dec 16, 2014 1:25 AM, &quot;Don Dutile&quot; &lt;<a href=3D"mailto:=
ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 12/15/2014 11:55 AM, Suman Tripathi wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This patch adds the support for the A=
PM X-Gene SoC AHBC IOMMU driver.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Suman Tripathi &lt;<a =
href=3D"mailto:stripathi-qTEPVZfXA3Y@public.gmane.org">stripathi-qTEPVZfXA3Y@public.gmane.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0---<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Suman Tripathi (3):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0xgene-ahbc-iommu: Add su=
pport for APM X-Gene SoC AHBC IOMMU driver.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0arm64: dts: Add the APM =
X-Gene AHBC IOMMU DTS node.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0Documentation: dt-bindin=
gs: Add the binding info for APM X-Gene AHBC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0IOMMU driver.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 .../devicetree/bindings/iommu/=
xgene,ahbc-iommu.txt |=C2=A0 17 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 arch/arm64/boot/dts/apm-storm.=
dtsi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A05 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 drivers/iommu/Kconfig=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 drivers/iommu/Makefile=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 drivers/iommu/xgene-ahbc-iommu=
.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 33=
6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 5 files changed, 369 insertion=
s(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 create mode 100644 Documentati=
on/devicetree/bindings/iommu/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xgene,ahbc-iommu.txt<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 create mode 100644 drivers/iom=
mu/xgene-ahbc-iommu.c<br>
<br>
</div></div>What are the differences between the X-Gene IOMMU and the ARM-S=
MMU?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Joerg<br>
<br>
</font></span></blockquote></div></div>

<pre>CONFIDENTIALITY NOTICE: This e-mail message, including any attachmen=
ts, =

is for the sole use of the intended recipient(s) and contains information=

that is confidential and proprietary to Applied Micro Circuits Corporatio=
n or its subsidiaries. =

It is to be used solely for the purpose of furthering the parties' busine=
ss relationship. =

All unauthorized review, use, disclosure or distribution is prohibited. =

If you are not the intended recipient, please contact the sender by reply=
 e-mail =

and destroy all copies of the original message.
=0D
--001a11c3be3252a33e050a4bd092--

--===============1540810700857433716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1540810700857433716==--
