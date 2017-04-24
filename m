From: "Akula, Geethasowjanya" <Geethasowjanya.Akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Increase SMMU CMD queue poll timeout
Date: Mon, 24 Apr 2017 16:46:25 +0000
Message-ID: <BN3PR07MB2500C44E88D79B57116F2876E01F0@BN3PR07MB2500.namprd07.prod.outlook.com>
References: <1493035176-3633-1-git-send-email-gakula@caviumnetworks.com>,
	<20170424160841.GS12323@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0364337873469627852=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170424160841.GS12323-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "Goutham, Sunil" <Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============0364337873469627852==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN3PR07MB2500C44E88D79B57116F2876E01F0BN3PR07MB2500namp_"

--_000_BN3PR07MB2500C44E88D79B57116F2876E01F0BN3PR07MB2500namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


>>On Mon, Apr 24, 2017 at 05:29:36PM +0530, Geetha sowjanya wrote:
>> From: Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>> When large memory is being unmapped, huge no of tlb invalidation cmds ar=
e
>> submitted followed by a SYNC command. This sometimes hits CMD queue full=
 and
>> poll on queue drain is being timedout throwing error message 'CMD_SYNC t=
imeout'.
>>
>> Although there is no functional issue, error message confuses user. Henc=
e increased
>> poll timeout to 500us

>Hmm, what are you doing to unmap that much? Is this VFIO teardown? Do you


Yes. I see this issue while poweroff the guest with VFIO device attached (4=
0G Intel VF).


>have 7c6d90e2bb1a ("iommu/io-pgtable-arm: Fix iova_to_phys for block
>entries") applied?

 Using 4.11-rc5 kernel and patch is in place.



Thanks,

Geetha.


Will

>>
>> Signed-off-by: Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 591bb96..1dcd154 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>>@@ -407,7 +407,7 @@
>>  #define PRIQ_1_ADDR_MASK             0xfffffffffffffUL
>>
>> /* High-level queue structures */
>> -#define ARM_SMMU_POLL_TIMEOUT_US     100
>> +#define ARM_SMMU_POLL_TIMEOUT_US     500
>>
>>  #define MSI_IOVA_BASE                        0x8000000
>>  #define MSI_IOVA_LENGTH                      0x100000
>> -


________________________________
From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Sent: Monday, April 24, 2017 9:38:41 PM
To: Akula, Geethasowjanya
Cc: robin.murphy-5wv7dgnIgG8@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; catalin.marinas=
@arm.com; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-kernel-u79uwXL29TaqPxH82wqD4g@public.gmane.org=
g; Goutham, Sunil; Akula, Geethasowjanya
Subject: Re: [PATCH] iommu/arm-smmu-v3: Increase SMMU CMD queue poll timeou=
t

On Mon, Apr 24, 2017 at 05:29:36PM +0530, Geetha sowjanya wrote:
> From: Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>
> When large memory is being unmapped, huge no of tlb invalidation cmds are
> submitted followed by a SYNC command. This sometimes hits CMD queue full =
and
> poll on queue drain is being timedout throwing error message 'CMD_SYNC ti=
meout'.
>
> Although there is no functional issue, error message confuses user. Hence=
 increased
> poll timeout to 500us

Hmm, what are you doing to unmap that much? Is this VFIO teardown? Do you
have 7c6d90e2bb1a ("iommu/io-pgtable-arm: Fix iova_to_phys for block
entries") applied?

Will

>
> Signed-off-by: Geetha <gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 591bb96..1dcd154 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -407,7 +407,7 @@
>  #define PRIQ_1_ADDR_MASK             0xfffffffffffffUL
>
>  /* High-level queue structures */
> -#define ARM_SMMU_POLL_TIMEOUT_US     100
> +#define ARM_SMMU_POLL_TIMEOUT_US     500
>
>  #define MSI_IOVA_BASE                        0x8000000
>  #define MSI_IOVA_LENGTH                      0x100000
> --
> 1.9.1
>

--_000_BN3PR07MB2500C44E88D79B57116F2876E01F0BN3PR07MB2500namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:10pt; col=
or:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p></p>
<p><br>
</p>
<p><font size=3D"2"><span style=3D"font-size:10pt">&gt;&gt;On Mon, Apr 24, =
2017 at 05:29:36PM &#43;0530, Geetha sowjanya wrote:<br>
&gt;&gt; From: Geetha &lt;gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org&gt;<br>
&gt;&gt; <br>
&gt;&gt; When large memory is being unmapped, huge no of tlb invalidation c=
mds are<br>
&gt;&gt; submitted followed by a SYNC command. This sometimes hits CMD queu=
e full and<br>
&gt;&gt; poll on queue drain is being timedout throwing error message 'CMD_=
SYNC timeout'.<br>
&gt;&gt; <br>
&gt;&gt; Although there is no functional issue, error message confuses user=
. Hence increased<br>
&gt;&gt; poll timeout to 500us<br>
<br>
&gt;Hmm, what are you doing to unmap that much? Is this VFIO teardown? Do y=
ou</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">Yes. I see this issue wh=
ile poweroff the guest with VFIO device attached (40G Intel VF).</span></fo=
nt></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">&gt;have 7c6d90e2bb1a (&=
quot;iommu/io-pgtable-arm: Fix iova_to_phys for block<br>
&gt;entries&quot;) applied?<br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">&nbsp;Using 4.11-rc5 ker=
nel and patch is in place.</span></font></p>
<p><br>
<font size=3D"2"><span style=3D"font-size:10pt"></span></font></p>
<p><br>
<font size=3D"2"><span style=3D"font-size:10pt"></span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">Thanks,</span></font></p=
>
<p><font size=3D"2"><span style=3D"font-size:10pt">Geetha.<br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt"><br>
</span></font></p>
<p><font size=3D"2"><span style=3D"font-size:10pt">Will<br>
<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Geetha &lt;gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; drivers/iommu/arm-smmu-v3.c | 2 &#43;-<br>
&gt;&gt;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-=
v3.c<br>
&gt;&gt; index 591bb96..1dcd154 100644<br>
&gt;&gt; --- a/drivers/iommu/arm-smmu-v3.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/iommu/arm-smmu-v3.c<br>
&gt;&gt;@@ -407,7 &#43;407,7 @@<br>
&gt;&gt;&nbsp; #define PRIQ_1_ADDR_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xfffffffffffffUL<br>
&gt;&gt;&nbsp; <br>
&gt;&gt; /* High-level queue structures */<br>
&gt;&gt; -#define ARM_SMMU_POLL_TIMEOUT_US&nbsp;&nbsp;&nbsp;&nbsp; 100<br>
&gt;&gt; &#43;#define ARM_SMMU_POLL_TIMEOUT_US&nbsp;&nbsp;&nbsp;&nbsp; 500<=
br>
&gt;&gt;&nbsp; <br>
&gt;&gt;&nbsp; #define MSI_IOVA_BASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x8000000<br>
&gt;&gt;&nbsp; #define MSI_IOVA_LENGTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x100000<br>
&gt;&gt; - </span></font></p>
<br>
<p></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Will Deacon &lt;wil=
l.deacon-5wv7dgnIgG8@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, April 24, 2017 9:38:41 PM<br>
<b>To:</b> Akula, Geethasowjanya<br>
<b>Cc:</b> robin.murphy-5wv7dgnIgG8@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; catalin.=
marinas-5wv7dgnIgG8@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-kernel-fy+rA21nqHI@public.gmane.org=
rnel.org; Goutham, Sunil; Akula, Geethasowjanya<br>
<b>Subject:</b> Re: [PATCH] iommu/arm-smmu-v3: Increase SMMU CMD queue poll=
 timeout</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Mon, Apr 24, 2017 at 05:29:36PM &#43;0530, Geet=
ha sowjanya wrote:<br>
&gt; From: Geetha &lt;gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org&gt;<br>
&gt; <br>
&gt; When large memory is being unmapped, huge no of tlb invalidation cmds =
are<br>
&gt; submitted followed by a SYNC command. This sometimes hits CMD queue fu=
ll and<br>
&gt; poll on queue drain is being timedout throwing error message 'CMD_SYNC=
 timeout'.<br>
&gt; <br>
&gt; Although there is no functional issue, error message confuses user. He=
nce increased<br>
&gt; poll timeout to 500us<br>
<br>
Hmm, what are you doing to unmap that much? Is this VFIO teardown? Do you<b=
r>
have 7c6d90e2bb1a (&quot;iommu/io-pgtable-arm: Fix iova_to_phys for block<b=
r>
entries&quot;) applied?<br>
<br>
Will<br>
<br>
&gt; <br>
&gt; Signed-off-by: Geetha &lt;gakula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/iommu/arm-smmu-v3.c | 2 &#43;-<br>
&gt;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c=
<br>
&gt; index 591bb96..1dcd154 100644<br>
&gt; --- a/drivers/iommu/arm-smmu-v3.c<br>
&gt; &#43;&#43;&#43; b/drivers/iommu/arm-smmu-v3.c<br>
&gt; @@ -407,7 &#43;407,7 @@<br>
&gt;&nbsp; #define PRIQ_1_ADDR_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xfffffffffffffUL<br>
&gt;&nbsp; <br>
&gt;&nbsp; /* High-level queue structures */<br>
&gt; -#define ARM_SMMU_POLL_TIMEOUT_US&nbsp;&nbsp;&nbsp;&nbsp; 100<br>
&gt; &#43;#define ARM_SMMU_POLL_TIMEOUT_US&nbsp;&nbsp;&nbsp;&nbsp; 500<br>
&gt;&nbsp; <br>
&gt;&nbsp; #define MSI_IOVA_BASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x8000000<br>
&gt;&nbsp; #define MSI_IOVA_LENGTH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x100000<br>
&gt; -- <br>
&gt; 1.9.1<br>
&gt; <br>
</div>
</span></font>
</body>
</html>

--_000_BN3PR07MB2500C44E88D79B57116F2876E01F0BN3PR07MB2500namp_--

--===============0364337873469627852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0364337873469627852==--
