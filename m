From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: Re: [PATCH 0/3] Add support for APM X-Gene SoC AHBC IOMMU driver.
Date: Tue, 16 Dec 2014 01:31:58 +0530
Message-ID: <CAOHikRB0eBnPnE+QWdmWunOMFHJOLDqU6o2ByBruQ3KC+1-XmA@mail.gmail.com>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
	<548F3C91.3030803@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7131137012358800283=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <548F3C91.3030803-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============7131137012358800283==
Content-Type: multipart/alternative; boundary=001a11c1d558148905050a46b76f

--001a11c1d558148905050a46b76f
Content-Type: text/plain; charset=UTF-8

No not yet
On Dec 16, 2014 1:25 AM, "Don Dutile" <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On 12/15/2014 11:55 AM, Suman Tripathi wrote:
>
>> This patch adds the support for the APM X-Gene SoC AHBC IOMMU driver.
>>
>> Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
>> ---
>>
>> Suman Tripathi (3):
>>    xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC IOMMU driver.
>>    arm64: dts: Add the APM X-Gene AHBC IOMMU DTS node.
>>    Documentation: dt-bindings: Add the binding info for APM X-Gene AHBC
>>      IOMMU driver.
>>
>>   .../devicetree/bindings/iommu/xgene,ahbc-iommu.txt |  17 ++
>>   arch/arm64/boot/dts/apm-storm.dtsi                 |   5 +
>>   drivers/iommu/Kconfig                              |  10 +
>>   drivers/iommu/Makefile                             |   1 +
>>   drivers/iommu/xgene-ahbc-iommu.c                   | 336
>> +++++++++++++++++++++
>>   5 files changed, 369 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iommu/xgene,ahbc-
>> iommu.txt
>>   create mode 100644 drivers/iommu/xgene-ahbc-iommu.c
>>
>> --
>> 1.8.2.1
>>
>>
> Have you tested this with a kernel that uses 64K page size ?
>
>

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.

--001a11c1d558148905050a46b76f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">No not yet</p>
<div class=3D"gmail_quote">On Dec 16, 2014 1:25 AM, &quot;Don Dutile&quot; =
&lt;<a href=3D"mailto:ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:=
<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 12/15/2014 11:55=
 AM, Suman Tripathi wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
This patch adds the support for the APM X-Gene SoC AHBC IOMMU driver.<br>
<br>
Signed-off-by: Suman Tripathi &lt;<a href=3D"mailto:stripathi-qTEPVZfXA3Y@public.gmane.org" targ=
et=3D"_blank">stripathi-qTEPVZfXA3Y@public.gmane.org</a>&gt;<br>
---<br>
<br>
Suman Tripathi (3):<br>
=C2=A0 =C2=A0xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC IOMMU dr=
iver.<br>
=C2=A0 =C2=A0arm64: dts: Add the APM X-Gene AHBC IOMMU DTS node.<br>
=C2=A0 =C2=A0Documentation: dt-bindings: Add the binding info for APM X-Gen=
e AHBC<br>
=C2=A0 =C2=A0 =C2=A0IOMMU driver.<br>
<br>
=C2=A0 .../devicetree/bindings/iommu/<u></u>xgene,ahbc-iommu.txt |=C2=A0 17=
 ++<br>
=C2=A0 arch/arm64/boot/dts/apm-storm.<u></u>dtsi=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
=C2=A0 drivers/iommu/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br=
>
=C2=A0 drivers/iommu/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 =
+<br>
=C2=A0 drivers/iommu/xgene-ahbc-<u></u>iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 336 +++++++++++++++++++++<br>
=C2=A0 5 files changed, 369 insertions(+)<br>
=C2=A0 create mode 100644 Documentation/devicetree/<u></u>bindings/iommu/xg=
ene,ahbc-<u></u>iommu.txt<br>
=C2=A0 create mode 100644 drivers/iommu/xgene-ahbc-<u></u>iommu.c<br>
<br>
--<br>
1.8.2.1<br>
<br>
</blockquote>
<br>
Have you tested this with a kernel that uses 64K page size ?<br>
<br>
</blockquote></div>

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
--001a11c1d558148905050a46b76f--

--===============7131137012358800283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7131137012358800283==--
