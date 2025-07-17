Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CFF2BDC32
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755222; cv=none; b=J13NeG3jYMNMRO+5JH3YmlykNtc4WpH93+cG3KrDaNa0ROcoo5i7f7DPIMToVlidZ+kuLJzLmrkkLlhz9G/5kioF3Jwzv4yxP2llgpZg4VnZM2VYXCEgHYlgta+lquSPx2KMVDFFk6/cZ/P3+qZ95oDTrZQU0nVP3Ob5q1s78I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755222; c=relaxed/simple;
	bh=k1AU9RHb0Kl7CzIBQsz15cpKEvQJw6GvReja3qw8EDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiDxPIu0cNxKfJ1nJFC5aIeHmFc172Pcj+0r42MKQQNDltoggdmTit4gkE7wVu3F62y4TGJ9kUY8MmJXp1uSm4VjtpISITNBNgRG2rkMqhUi/SGV4mKSjN+7sqZTEVfzCpu6bLMfcqxHIGb575+S6QDf1znJpbwwjnC3CkJKu54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TE25JG2V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TE25JG2V"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCB5PC015626
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 12:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IbmcROfOzVtWLlLwTUK701q3d6gz5yN28T/mfJ33MIw=; b=TE25JG2VN6qQdbFI
	+EPMUOzIJpT9ZbN4ZIkZATeVvy4GwUPV5dCscItU/HZvCgO6zt8HQRfg2IkbcAT+
	/bRkQgCwvhtEQkpUQScqWrWuB+LunPUpfuPEa9/YyBRJ5RWfX3dru0yV6Ck8UISD
	QAoil+qyBsfyp0uBtBYRio7QFWo2/NrN7YMfHYntO4dGtjiBDS77+iZmAJKB8y6e
	YY5aSsLonYn4nSw5GocPrVGB5jgSgad6gzeOGzIhTJX9yDqeuCq7Bma8SyfEsfks
	Qfhx/IiDic3dsw1TEgmCJWQ8dpS53t20P6vudUZXZ9KFyP8FslENwvzt4Q2JV/IZ
	SmDm4g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dytjk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 12:26:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f539358795so3308606d6.3
        for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 05:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755218; x=1753360018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbmcROfOzVtWLlLwTUK701q3d6gz5yN28T/mfJ33MIw=;
        b=jcZnDoVybzaeA/VOso4eydrzpqaYw8hGpko4UJBPRf/ce2jHSpQG94/bFOY8w0PSwM
         5/ZFfzmiG+e7bK1P3Ef1IPayKbFSdNKX+euWUYeAXRp7yVVU6VF8lf5ZOY8VpMjwMDPL
         WGcjmQcsq14xDValm1dsegf70NO2tyoJODPMDVHkliQkocTos650oaI0IzNVa7BuSNaY
         6oV1+SnjLnxifOWdz9ibrond+M1lKdlVinYZa9bQEG6fWT/iRCvI9/Fi668kwerT+GKt
         ZsECYyFr7+VlpjcPsM0cbKs0V3uwnD3dBi+T5GeW/I4p25J+Yj2Su5H84IM6RlJj5lno
         NfbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxxttmMDpmA99N+PThDBJXL7fQezHi6yf1PygLVLw0JE0BegGw4eRrtoDf/f9ASdh2exzNXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy31rIT8jbUvABMl8vw+Q35CKe0XO9dZgl2mP4qqBDoXdwvW0An
	4qJTZR9a9HObkvwge0qlzryrP4/eBgMkvSFIyl4DHa+OnNiq4faTZ/nfFg3AGsOi65Wgfct50T9
	HyST2nICZIlmxJbwtch7haBY0PKB3PP0pLv4p3Q/ZEyLNVzgAoRrmjuCtow==
X-Gm-Gg: ASbGnctY9c2ssG2EneejfFNgzLEjlAhSxPbab4d6tvqRSs9ZWWC73abVJrS9K8nAdCE
	GOgMMdVkQL48HuxEd9lgQlSdErhGq3O5FfE/NheeXyOLlB8oU4myMTMiEFUZ/c3eBHiEEUWeVqC
	EYCgSFpsdbDgFJVaqaMFcx99gdBID8A9IWxXZ2XUHIp96UzVxeFJZgdA2Sl7FXYBcYN8KQCGFvf
	1EIYIKNx5ec80ES4XvPaU7f5abIguMPMtSONaSs9HLvrzRcIbjP95b2ym5sj5zsoS4I27Y5/wuX
	7TlRPkY2ojsliaDED3VAP3Wz28t36MeUVtFZSyeMrEtvmT6Q4D2nb5A1sBoce98I7VoPqabUzZ+
	kFTAdFZi71wsWFkdNZaNI
X-Received: by 2002:a05:620a:4093:b0:7e3:302a:3e9d with SMTP id af79cd13be357-7e342ad54e7mr401315285a.7.1752755217804;
        Thu, 17 Jul 2025 05:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWMwBx+PyOHxTxgnaS5xzRvQae4iwC7dd8Cj0Sms6zoxQGp+IkrMAc/iJ+gLrK8J7XJbyIqA==
X-Received: by 2002:a05:620a:4093:b0:7e3:302a:3e9d with SMTP id af79cd13be357-7e342ad54e7mr401311985a.7.1752755217290;
        Thu, 17 Jul 2025 05:26:57 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee8d9fsm1336084466b.46.2025.07.17.05.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 05:26:56 -0700 (PDT)
Message-ID: <d25c3f81-38c3-4559-a1e6-7b586c817d57@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 14:26:52 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8VkwbhM5CZ5kGQOFJp4BYz5y2Nr-qXz2
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6878ec13 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7CQSdrXTAAAA:8 a=6H0WHjuAAAAA:8
 a=iHGpd6SFZaqAm2lpoLIA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEwOSBTYWx0ZWRfX9EOqeDGVKSPv
 BPyTvawRi8AuUEPzWnqUfZbRmU5ooAVeK/Rtp+ZFPiojLbtahwa+sG6NGa5lupUP+kaZCHg9nJ8
 QHfQv+Of4xRjlNLVcfo48P5A+5U0UKXcWRx5f1Di3aD+4ub8/Rs7G7yU7acpGLwWF0JUu3B6Kdf
 Jj1fEerN5SyhPutz2DpnHRqrKl9Pyli1oUWxmG242EkrDws6/zizYNav7eeKsvP27kBjQBMtiXe
 EYpwU0w6bueciZwvcSUKzGJwSqyiofrd2pAwBw9QTCvrkr/0I/BkZZHkoT9C/aCtt016VHhWpJ8
 CYwFx/w3e7Hl1UWad7cO2twKOKRmUJZ8H9vdJ24kmElGwcEqw3J2VDnJ/TwNt1/Pnvomi94YCTQ
 LgiF1hKSRt1EgaYHEeolNleJVeFUIne6oCyjClO5EC/3aoM3uS89+qxV7Unfd7WiY9foKIpN
X-Proofpoint-GUID: 8VkwbhM5CZ5kGQOFJp4BYz5y2Nr-qXz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170109

On 7/17/25 10:29 AM, Luca Weiss wrote:
> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>>> Add a devicetree description for the Milos SoC, which is for example
>>> Snapdragon 7s Gen 3 (SM7635).
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---

[...]

>>
>> [...]
>>
>>> +		cpu-map {
>>> +			cluster0 {
>>> +				core0 {
>>> +					cpu = <&cpu0>;
>>> +				};
>>> +
>>> +				core1 {
>>> +					cpu = <&cpu1>;
>>> +				};
>>> +
>>> +				core2 {
>>> +					cpu = <&cpu2>;
>>> +				};
>>> +
>>> +				core3 {
>>> +					cpu = <&cpu3>;
>>> +				};
>>> +			};
>>> +
>>> +			cluster1 {
>>> +				core0 {
>>> +					cpu = <&cpu4>;
>>> +				};
>>> +
>>> +				core1 {
>>> +					cpu = <&cpu5>;
>>> +				};
>>> +
>>> +				core2 {
>>> +					cpu = <&cpu6>;
>>> +				};
>>> +			};
>>> +
>>> +			cluster2 {
>>> +				core0 {
>>> +					cpu = <&cpu7>;
>>> +				};
>>> +			};
>>> +		};
>>
>> I'm getting mixed information about the core topology.. 
>>
>> What does dmesg say wrt this line?
>>
>> CPU%u: Booted secondary processor 0x%010lx [0x%08x]\n
> 
> [    0.003570] CPU1: Booted secondary processor 0x0000000100 [0x410fd801]
> [    0.004738] CPU2: Booted secondary processor 0x0000000200 [0x410fd801]
> [    0.005783] CPU3: Booted secondary processor 0x0000000300 [0x410fd801]
> [    0.007206] CPU4: Booted secondary processor 0x0000000400 [0x410fd811]
> [    0.008206] CPU5: Booted secondary processor 0x0000000500 [0x410fd811]
> [    0.009073] CPU6: Booted secondary processor 0x0000000600 [0x410fd811]
> [    0.010406] CPU7: Booted secondary processor 0x0000000700 [0x410fd811]

Okay, so the cache topology that I can make out of docs matches your dt..

As for the CPU map, we tended to simply throw all cores that are in
the same "DSU cluster" [1] together, represented as a single CPU cluster.
This is not what other vendors do though, it seems. And downstream has
the same silver/gold/prime split as you did above.

Looking at some docs, it seems like the prime core shares the cache
bridge with the gold cluster so I'm not sure how separate it really is.

There was a time when the MIDR_EL1 register would be more helpful, but
according to [2], it would mean that each core is in its own cluster..
For reference exynos2200.dtsi seems to have the very same MPIDRs (though
with cores that are a little older). One would expect the small cores
that share the L2 to be within the same cluster [3].

All in all, I don't know what to tell you for sure..

[1] https://developer.arm.com/documentation/100453/0401/Technical-overview/Components?lang=en
[2] https://developer.arm.com/documentation/102517/0004/AArch64-registers/AArch64-Identification-registers-summary/MPIDR-EL1--Multiprocessor-Affinity-Register?lang=en
[3] https://developer.arm.com/documentation/102517/0004/The-Cortex-A520--core/Cortex-A520--core-configuration-options?lang=en

[...]

>> Does access control disallow accessing these on your prod-fused
>> device?
> 
> Hm, taking another look, this property should probably be moved to
> device dts.
> 
> Downstream has this in volcano.dtsi but volcano6i.dtsi (QCM6690?) and
> volcano6ip.dtsi (QCS6690?) have a /delete-property/ for this, because
> they have PCIe available.
> 
> I don't think this has anything to do with secure boot fuses, but I
> don't think I have tried enabling these clocks on my SB-off prototype.

I wouldn't be so sure about sb-off being necessarily a difference, but
I wouldn't object to a smoke test either ;)

[...]

>>> +			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
>>
>> pdc 26
> 
> You mean replace <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH> with
> <&pdc 26 IRQ_TYPE_LEVEL_HIGH> (plus interrupts-extended)?

Yes

> I assume you got this from internal docs, but just to mention,
> volcano-thermal.dtsi contains GIC_SPI 506 (+ 507 for tsens1).

Right, I found it in the docs (but we most likely want the device to
wake up from sleep and try to power off if it's too hot/cold)

Konrad
