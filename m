From: "Akula, Geethasowjanya" <Geethasowjanya.Akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum
	28168
Date: Wed, 21 Dec 2016 04:40:12 +0000
Message-ID: <MWHPR07MB31335EC4072EA3DFB0C49025E0930@MWHPR07MB3133.namprd07.prod.outlook.com>
References: <1482231993-27571-1-git-send-email-gakula@caviumnetworks.com>
	<bd950765-8c1f-14d5-2be8-efa76f2d6b6b@arm.com>
	<20161220115630.GD10132@arm.com>,
	<d8aed795-f4ce-609e-ccd2-0daf628b0376@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6391806382841717536=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d8aed795-f4ce-609e-ccd2-0daf628b0376-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
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
To: "Daney, David" <David.Daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: "jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org" <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "Goutham,
	Sunil" <Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "suzuki.poulose-5wv7dgnIgG8@public.gmane.org" <suzuki.poulose-5wv7dgnIgG8@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "Chalamarla,
	Tirumalesh" <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "james.morse-5wv7dgnIgG8@public.gmane.org" <james.morse-5wv7dgnIgG8@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============6391806382841717536==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR07MB31335EC4072EA3DFB0C49025E0930MWHPR07MB3133namp_"

--_000_MWHPR07MB31335EC4072EA3DFB0C49025E0930MWHPR07MB3133namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



On 12/20/2016 03:56 AM, Will Deacon wrote:
> On Tue, Dec 20, 2016 at 11:52:58AM +0000, Marc Zyngier wrote:
>> On 20/12/16 11:06, Geetha sowjanya wrote:
>>>> From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>>>> +#ifdef CONFIG_CAVIUM_ERRATUM_28168
>>>> +/*
>>>> + * Cavium ThunderX erratum 28168
>>>> + *
>>>> + * Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
>>>> + * controller are delivered to the interrupt controller before older
>>>> + * PCI-inbound memory stores are committed. Doing a sync on SMMU
>>>> + * will make sure all prior data transfers are completed before
>>>> + * invoking ISR.
>>>> + *
>>>> + */
>>>> +void dev_smmu_tlb_sync(struct device *dev)
>>>> +{
>>>> +   struct iommu_fwspec *fwspec =3D dev->iommu_fwspec;
>>>> +   struct arm_smmu_device *smmu =3D fwspec_smmu(fwspec);
>>>> +
>>>> +   if (smmu)
>>>> +           __arm_smmu_tlb_sync(smmu);
>>>> +}
>>>> +#endif
>>>
>>> I'll let Robin and Will comment on this, but it strikes be as rather od=
d
>>> that nothing will happen if the SMMU is in bypass or simply compiled
>>> out. So this workaround is at best incomplete.
>>
>> Agreed. Unless the SMMU is the cause of the issue, relying on it to
>> implement the workaround is fragile and unnecessarily introduces a linka=
ge
>> between SMMU driver internals and the interrupt handling code.

We checked all possible ways. This is the only workaround we found.

>The SMMU is not the cause of the problem, it is the solution, and as
>such is required.

>Perhaps we should have a Kconfig "select" for the SMMU driver if
>CAVIUM_ERRATUM_28168 is selected.


>
> Not a fan.

>In general, I don't think anybody is a big fan of errata and their
>workarounds.

Thank you,
Geetha.

>
> Will
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>


--_000_MWHPR07MB31335EC4072EA3DFB0C49025E0930MWHPR07MB3133namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:10pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p><br>
</p>
<div style=3D"color: rgb(26, 26, 26);">
<div>
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr">
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 12/20/2016 03:56 AM, Will Deacon wrote:<br>
&gt; On Tue, Dec 20, 2016 at 11:52:58AM &#43;0000, Marc Zyngier wrote:<br>
&gt;&gt; On 20/12/16 11:06, Geetha sowjanya wrote:<br>
&gt;&gt;&gt;&gt; From: Tirumalesh Chalamarla &lt;tchalamarla@caviumnetworks=
.com&gt;<br>
&gt;&gt;&gt;&gt; &#43;#ifdef CONFIG_CAVIUM_ERRATUM_28168<br>
&gt;&gt;&gt;&gt; &#43;/*<br>
&gt;&gt;&gt;&gt; &#43; * Cavium ThunderX erratum 28168<br>
&gt;&gt;&gt;&gt; &#43; *<br>
&gt;&gt;&gt;&gt; &#43; * Due to erratum #28168 PCI-inbound MSI-X store to t=
he interrupt<br>
&gt;&gt;&gt;&gt; &#43; * controller are delivered to the interrupt controll=
er before older<br>
&gt;&gt;&gt;&gt; &#43; * PCI-inbound memory stores are committed. Doing a s=
ync on SMMU<br>
&gt;&gt;&gt;&gt; &#43; * will make sure all prior data transfers are comple=
ted before<br>
&gt;&gt;&gt;&gt; &#43; * invoking ISR.<br>
&gt;&gt;&gt;&gt; &#43; *<br>
&gt;&gt;&gt;&gt; &#43; */<br>
&gt;&gt;&gt;&gt; &#43;void dev_smmu_tlb_sync(struct device *dev)<br>
&gt;&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp; struct iommu_fwspec *fwspec =3D dev-&gt;=
iommu_fwspec;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp; struct arm_smmu_device *smmu =3D fwspec_=
smmu(fwspec);<br>
&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp; if (smmu)<br>
&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; __arm_smmu_tlb_sync(smmu);<br>
&gt;&gt;&gt;&gt; &#43;}<br>
&gt;&gt;&gt;&gt; &#43;#endif<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I'll let Robin and Will comment on this, but it strikes be as =
rather odd<br>
&gt;&gt;&gt; that nothing will happen if the SMMU is in bypass or simply co=
mpiled<br>
&gt;&gt;&gt; out. So this workaround is at best incomplete.<br>
&gt;&gt;<br>
&gt;&gt; Agreed. Unless the SMMU is the cause of the issue, relying on it t=
o<br>
&gt;&gt; implement the workaround is fragile and unnecessarily introduces a=
 linkage<br>
&gt;&gt; between SMMU driver internals and the interrupt handling code.<br>
<br>
We checked all possible ways. This is the only workaround we found. <br>
<br>
&gt;The SMMU is not the cause of the problem, it is the solution, and as <b=
r>
&gt;such is required.<br>
<br>
&gt;Perhaps we should have a Kconfig &quot;select&quot; for the SMMU driver=
 if <br>
&gt;CAVIUM_ERRATUM_28168 is selected.<br>
<br>
<br>
&gt;<br>
&gt; Not a fan.<br>
<br>
&gt;In general, I don't think anybody is a big fan of errata and their <br>
&gt;workarounds.<br>
<br>
<font size=3D"2"><span style=3D"font-size:10pt;">Thank you,<br>
Geetha.</span></font><br>
<br>
&gt;<br>
&gt; Will<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; linux-arm-kernel mailing list<br>
&gt; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org<br>
&gt; <a previewremoved=3D"true" id=3D"LPlnk773318" href=3D"http://lists.inf=
radead.org/mailman/listinfo/linux-arm-kernel">
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel</a><br>
&gt;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR07MB31335EC4072EA3DFB0C49025E0930MWHPR07MB3133namp_--

--===============6391806382841717536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6391806382841717536==--
