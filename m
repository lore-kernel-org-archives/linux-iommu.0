Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595614;
	b=dxtah9NkC6GtnwdqgIZh3LXXkRVasZFmBdVM3HvkCvWn9x5wgPomql14s6dlsy2eR2cS
	 hKu3IYDs6h+I6b5PMDzBF107nXhkigVOigSjFfwGn0d+Z+hgVN/k0DQN7GSHzYmjzIUPl
	 B/ydJuVMQiuTYHsvqo2t/XwLTsvpyMMVSLWA3H2hRQb2xIAWlKeHHXP9rrQs2GT4kg+Io
	 9uUBXMrP99SbZkd/oUBM/9YdwvAUrbA5A0jPS8ybIpOKRpSVGhnuK8zzqMEvDGhL5/5PM
	 /ssDvT+8/MvllElSYPATBSo2w6ak3jgKBNdnhnWd3IFKcx67ooDZu9UpzRG+dS5y3JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595614;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jnDAeo7CmnNaA/656fOLCkXGnntEEKJb98BwVbdJVSA=;
	b=oQNwneP87TU7N2oLuOSgezPJ2fsCA784MpcZ0hxge6P/cyjUTEMSAod47hR6POGL+2GE
	 t10lVXcYT5PL3BwykcxWXhUV0dOZykfSrpwrfLwD5bIC9eZTRGmiFVEFBeiEuyAnPQqJc
	 u/eCm20uYcvOnvCXvB6/pre+bujzf8a0gMCAmnSchZjBzyQcauj0c5lGf9OnYihk3waKC
	 cJjInA7zcQXLmpnzM+7j6yvuMt4Bf4TL3+18eCs8BoNCGtEGdJd7KyZrhE9owNRQUFDlk
	 hBiIHoCR6FJm0gem89Q8+msmagI7iijnFS2vdj2rUEn4uwnnlAqrzMqXmTjUunUbFDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=wKqlIfso;
	arc=none smtp.remote-ip=95.215.58.60
Received: from mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B58606A32D
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 18:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B58606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=wKqlIfso
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=YRNPDyKnF5AAnH1Nkcj0IpcYyCLG3qMSgftkaQIlJjM=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794595610; v=1; x=1795200410;
 b=wKqlIfsoAs0iiPyqGpYb1eUg2O8du+8UjqsDMtpATzTB6foPKYrKEZW3X/GCT6x0Htk3RdMS
 rYqKk+9j35v5d7UF3Lgka/03jO7vWIae3pT1pqTd3i4mQfDNs8KV5Ho9Rdi1FIH34bCAKLKvKOz
 Xpm868QO4MtJl7TzQeub6Z4v2Sin4Ltb5EMgyE6mw2mhX8JMm5q7T7KHupDQ5lM0SIvgtD1QKEB
 yDfLlLnJSWRsFseTjO/pr746/CI5K1dLg8uSdw1YRFRXnF8Iuxl+fqd+QTIRhwy73cr0NDLmqtG
 kF8OuSRi46q4kYjbqTbjjdB5YLwzVG2yLa+YGTyNhu13g==
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id e856afca2a42441d;
	Fri, 13 Nov 2026 18:46:50 +0000
X-Mizu-Trace-ID: e856afca2a42441d
X-Migadu-Flow: FLOW_OUT
Message-ID: <4ce436ed-63b7-4764-afc5-dc5ffa4f0ba1@packett.cool>
Date: Fri, 13 Nov 2026 15:46:40 -0300
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC interconnect
 for adreno SMMU
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-3-afdca0125a65@oss.qualcomm.com>
 <h6opbtr2ced3sannj3ym573qc2sjk7ek3clpto5j5mtqfrfk6w@34sk2zraoqtj>
 <807f145d-88d3-460a-9862-b63fe2a52cf7@oss.qualcomm.com>
 <a4f5sod3aflubxkk4mm4k5ozddydqcnqeac4s6vnozkd2nvxbi@hmh6zclsw5z3>
 <4e5a3d82-b946-4490-885a-ea7061939c32@oss.qualcomm.com>
 <ak5qkRKk2eHHLYmo@baldur>
 <2c21041d-f84c-4fa7-a977-555f9203d8b5@oss.qualcomm.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <2c21041d-f84c-4fa7-a977-555f9203d8b5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 7/17/26 8:40 AM, Bibek Kumar Patro wrote:
>
>
> On 7/8/2026 8:56 PM, Bjorn Andersson wrote:
>> On Wed, Jul 08, 2026 at 03:31:07PM +0530, Bibek Kumar Patro wrote:
>>>
>>>
>>> On 7/7/2026 10:14 PM, Dmitry Baryshkov wrote:
>>>> On Tue, Jul 07, 2026 at 06:37:24PM +0530, Bibek Kumar Patro wrote:
>>>>>
>>>>>
>>>>> On 7/6/2026 11:12 PM, Dmitry Baryshkov wrote:
>>>>>> On Mon, Jul 06, 2026 at 10:26:36PM +0530, Bibek Kumar Patro wrote:
>>>>>>> On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
>>>>>>> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its 
>>>>>>> registers
>>>>>>> are accessible. Without this vote, the SMMU may become unreachable,
>>>>>>> leading to intermittent probe failures and runtime issues.
>>>>>>>
>>>>>>> Add the required interconnect to ensure reliable register access.
>>>>>>>
>>>>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>>>>> ---
>>>>>>>     arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>>>>>>>     1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi 
>>>>>>> b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>>>>> index 90e50c245c0c..721526f023dd 100644
>>>>>>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>>>>> @@ -3389,6 +3389,8 @@ adreno_smmu: iommu@3da0000 {
>>>>>>>                 power-domains = <&gpucc GPU_CC_CX_GDSC>;
>>>>>>>                 dma-coherent;
>>>>>>> +            interconnects = <&gem_noc MASTER_GPU_TCU 
>>>>>>> QCOM_ICC_TAG_ALWAYS
>>>>>>> +                     &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>>>>>>
>>>>>> Why is it ALWAYS? Would it be better to declare it as ACTIVE_ONLY 
>>>>>> and
>>>>>
>>>>> Added QCOM_ICC_TAG_ALWAYS, to hold the vote in SLEEP bucket as well
>>>>> preventing gem_noc going to sleep when icc_set_bw is being called.
>>>>
>>>> _why_?
>>>>
>>>
>>> Now when i think of where we implemented the hooks, ALWAYS is not 
>>> needed. We
>>> should keep it ACTIVE_ONLY since we are already voting it
>>> back in resume pah. I'll fix it in next revision.
>>>
>>
>> The path is between the SMMU and DDR, so clearly it has to do with the
>> TCU's ability to fetch things from DDR.
>>
>
> Yes as you rightly mentioned, this series is helping to resolve the 
> race in TCU DDR clink
>
>> ACTIVE_ONLY states that the vote should only be applied when the
>> application subsystem (CPUSS) is not in low-power mode (CPU is active).
>>
>> So, are you saying that in all cases that cpuidle might select such
>> low-power state the GPU TCU is "stopped", and does not need to perform
>> any memory transactions?
>>
>
> I rechecked the architectural block diagram, GPU TCU is
> independent of the CPUSS, unlike system TCU.
>
> This means CPUSS can be powered down while the GPU TCU remains voted 
> up. While this series was intended to avoid a DDR voting race between the
> GPU TCU and its clients, using ACTIVE_ONLY could have possibly
> introduced a race between CPUSS and the GPU TCU itself.
>
> Thanks for catching this in my reply Bjorn.
>
> ACTIVE_ONLY would have been suitable for system TCU (apps_smmu)
> for which the interconnect field is anyways not needed, but
> unsuitable for GPU TCU.
>
>>
>> To me these two are orthogonal and TAG_ALWAYS is logically correct, but
>> perhaps there's some practical dependency that I'm missing?
>>
>
> We can ignore my acknowledgment [1] on previous response, Dmitry.
> ALWAYS TAG is correct here instead of ACTIVE_ONLY in the interconnect 
> field for adreno SMMU. 


This series seems to help with a really annoying bug on Kodiak phones 
like sm7325-motorola-dubai where often boot would hang when initializing 
the display panel (so it took a few reboots to successfully boot the 
device).

And indeed it only helps with the ALWAYS tag..

I've had this patch applied for a while (without even realizing that it 
fixed that!! thought the issue was gone because of something else) and 
today I went around kodiak.dtsi trying to remove unnecessary ALWAYS 
votes… first boot after changing this tag to ACTIVE_ONLY and boom, hang.


Tested-by: Val Packett <val@packett.cool> # sm7325-motorola-dubai

(for patch 2 i.e. the driver code as well)


Thanks,
~val

