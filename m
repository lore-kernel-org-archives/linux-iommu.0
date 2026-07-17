Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D73DE45C
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288419; cv=none; b=m5VqjBbMOrZc7YCN7aLwaaRk/sEUStJwYeAUQw5KZX8FwD3rJ9EXaz58IqwLznyLbZcthEaD6HJabIYDRZhhyT8hOvH9r9gma3Jt6CgQKW4GIQMP1q1mTaxYdKAr6m09qjz4/fbVqLupDHGDQvMblUM3yvEzx5qV9S0ImJI3e4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288419; c=relaxed/simple;
	bh=0M54LK+e+ZsqutDKWxmQf1vKliGbRxbhOcJFvzG1A0g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DMX2n7Xeli91t8iTJFvrjoh56Rhs3jYriAM8mahQvZgfYo2beUzg3iqaC5ySUNBFy7e9VYq98Kr64/owguTxAIC4oWo7QUjziz1zcHwAOmpD4K6mjiyeodMtXSigkVM6oXbhb9WBsdQNkvYnyexvBRd/T73OlHtRSu8iHWey88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a2v8hqQK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hEuxlkZ/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a2v8hqQK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hEuxlkZ/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HASmFh1348789
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 11:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KXuugUouKlB/CUW4LY6w9L6J1o6zPDA0wz2TTB2Kat4=; b=a2v8hqQK+5NFF89D
	97D6u2gu1GhLs3KiOzhJ9ucraCDlBeBTtrCFilTzkcsuq9OcGN9kl9X0Up4NKBW0
	k8plGKaONU2Bzc6E1gTHBP91QyRnTHCCKPUs7Eocnr7Lw/AYnrWS8mWgabM3brTf
	zNzQfLgUss/CGIKIpFSeoxa5zrxGstJ0SuHwOhNKlxP+dS73z/EQae0t3glkeB9f
	2yO4euksQGEzVf/SST7/9nJAgB6TdMC6y1iWmS/hunc/ene9xhV9+RTFBFHUlYqd
	cLZIT408D4tIFli89y1czok8b1kU2nzfSKyDjgwSyDMlN1joZXxW9XCuCDxt+qvJ
	rrlsCw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fffag92ea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 11:40:16 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8484ba00601so5609117b3a.1
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 04:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784288415; x=1784893215; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KXuugUouKlB/CUW4LY6w9L6J1o6zPDA0wz2TTB2Kat4=;
        b=hEuxlkZ/Ml8qZ+fx5EaIWK4l4w+Gjt5vSoI1S76QyYeJiUBTC3hE4/24+frgUMF0/Q
         uN9bi36Nu+dHvBcLrFU1cp0C6weK/1ZwVoxViPTGdQ3XOFW3E87f5OWNmKy2r0509huv
         Ylzdvac/w/QiPERrGupml/wEb/SKJvEcJOjAKc5DrB9QYTB/eXAV5bnCYSffYG+L+Iu1
         xajlU+LCM3fWYM6jVcA/tewC9SpMS2WS8NLrXiJa8xgNbZQAD42Qq+0xVcTqfeOA73r3
         O4DgiIT19GMPm/hIhUicnCNHzVUlVsuBsp3jFklRSXrqXiX6wErLPSIYxtSIM4GHkJH+
         PBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784288415; x=1784893215;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KXuugUouKlB/CUW4LY6w9L6J1o6zPDA0wz2TTB2Kat4=;
        b=anVfTk6N5WXYqG1J2p2aULIlNi4uPH2HK6jxK3FtWSqgnbKVPO0ybwLpiqpuqdag/z
         YOso55wu8Fv6qe0wl6kUFdfKirWK5gZhP/JcPL/kyfef3jX5hGaZXtk8jXQAUfGUFdfH
         Acv0EFel4QI//FyGZqbCsOgKHg0DBtJKgRJz23DLvUGaSrNWsOvmVD9+SWnjnISA6A8w
         ROpXHdJDBSpmSsT/Rktyuozi1VOCF1yDh+PFXb+JchrJtBoNW+l29tuSWV+Iw/SkM1Vc
         n7PF0jVH14GZQzjx8R6tAo0bJRaMJmBTcBLxbxcr5Ww/hWtnHfmiszL7XcKS350ZStJ6
         b3Tw==
X-Forwarded-Encrypted: i=1; AHgh+RoZ8AHnuUlwaTLvmOXZ5Lz0QY79Jubt1tIKSUo7z724/iOo2hih+na0EAn2ye4GBvywyOGDaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXMOSUbgT3iPUkGi+zraE/mnpYFyxp5xFmBlNoar8H6Zgxo4ah
	LObr48Uh1KfYIdEKUb3YyuCTT5vaqzJUUGj21tm/NFc7xaL0u+oboIPwAlcoe3lIE28x65oEb7D
	LJMo38wSykSeeRaQ27drqg5mh9+BQuIZRyREIUBxv5cFEUzBXvQmpEkZA0WRWDTMRgQ==
X-Gm-Gg: AfdE7cnndfxVtJXBNW/x8Gyi5T91xpUkIC4HKRTheJehcLD2n/98Ob6p/27SY3NI7dL
	aDnd6R6TgaCQigpCMEDKpDarNHPika7q6s6EKs8tHBG+z2u/njjifXMJIVHHwGoHde4tumHqfuM
	xFfKPU/ZzA1Deb+lEaEQFLQ2VXVUUNG3vVRfGmcBA5+tjfEBgFf7mouScle/iciC9diIBwLUnDn
	hMCh3uU0OYLBSeqG8pJjGzCXLRifM0i2mdxhpuHMl0yDNb9VO30JuSJBhtlA9cj0SuB9j29VrS3
	+k9GWe6X69QNQCpDtZQimccbybLrsRLH7QZxZMSqvuhPGBcLk7jFOCnrS2dHbPfqwzqa62CeiB9
	ljepJiTZzZFFTSh2vabSY5UQOy1KZ
X-Received: by 2002:a05:6a00:80a:b0:847:97a4:d6b3 with SMTP id d2e1a72fcca58-84c2922630cmr2362986b3a.16.1784288415352;
        Fri, 17 Jul 2026 04:40:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:80a:b0:847:97a4:d6b3 with SMTP id d2e1a72fcca58-84c2922630cmr2362945b3a.16.1784288414707;
        Fri, 17 Jul 2026 04:40:14 -0700 (PDT)
Received: from [10.218.33.224] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af317c8sm859795b3a.30.2026.07.17.04.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 04:40:14 -0700 (PDT)
Message-ID: <2c21041d-f84c-4fa7-a977-555f9203d8b5@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 17:10:08 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC interconnect
 for adreno SMMU
To: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
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
Content-Language: en-US
In-Reply-To: <ak5qkRKk2eHHLYmo@baldur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExOCBTYWx0ZWRfX84hv61NP0jcZ
 YZLdoylDbkRQvFMqIAvRSvvXU/qLetUP9IK6xUI+GL/LMHPsAYTeorvqXXisLTW2Fsmkz8oMbgn
 piLOis2B7/ESAXpQlebugIwZvzRTxkthQJ9nrIsZYkJdxz7gQ7i2Uiw6QdCV/g3vnXHjbAx899O
 xcBHRmnAVcmiStDPpOY+94QMIHKG7CWJskZnjZfoC/R48gSJI9CtZa1XmMZAXVjOGO3JiotQgI6
 gu/Iniep5AC72/EX7EybH6Kvi9LqBwIav7mdNhDwQ0UyWv/db1TN7JiFZM8sw3KqmZH8Ccg2qFl
 UoMkd62ckvqEidDgENGhcqrHgkP2rGT/Q0d1F1uVNuCBpRy05GLxlLGIRhTlhszcchCTFgng3YG
 p9cT/TudG1F3SLEpLTTkeBjTf1a9kAIbgGW08mflYstMOHaC3T6RRv1CORMI4uaiua7w8dfWAjI
 xUkeBSM7hv1rCxlMutg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExOCBTYWx0ZWRfXwlFAiEdldz5w
 jKc49isXdyoQ1ev8R/L4Rq4gReCU9zNwrPgnLOngpLFdYvT2mdItLItxWMhofIl7APEM+mZlJRK
 oSAgVgYzceoPX5VOuo84DHZkCP8L+Mw=
X-Authority-Analysis: v=2.4 cv=KZfidwYD c=1 sm=1 tr=0 ts=6a5a14a0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qc56rwwszmrP7wb0vM8A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: fYiLabIsmZEa_ROQEEjwRB_zdhLjnL2v
X-Proofpoint-ORIG-GUID: fYiLabIsmZEa_ROQEEjwRB_zdhLjnL2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170118



On 7/8/2026 8:56 PM, Bjorn Andersson wrote:
> On Wed, Jul 08, 2026 at 03:31:07PM +0530, Bibek Kumar Patro wrote:
>>
>>
>> On 7/7/2026 10:14 PM, Dmitry Baryshkov wrote:
>>> On Tue, Jul 07, 2026 at 06:37:24PM +0530, Bibek Kumar Patro wrote:
>>>>
>>>>
>>>> On 7/6/2026 11:12 PM, Dmitry Baryshkov wrote:
>>>>> On Mon, Jul 06, 2026 at 10:26:36PM +0530, Bibek Kumar Patro wrote:
>>>>>> On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
>>>>>> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
>>>>>> are accessible. Without this vote, the SMMU may become unreachable,
>>>>>> leading to intermittent probe failures and runtime issues.
>>>>>>
>>>>>> Add the required interconnect to ensure reliable register access.
>>>>>>
>>>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>>>>>>     1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>>>> index 90e50c245c0c..721526f023dd 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>>>> @@ -3389,6 +3389,8 @@ adreno_smmu: iommu@3da0000 {
>>>>>>     			power-domains = <&gpucc GPU_CC_CX_GDSC>;
>>>>>>     			dma-coherent;
>>>>>> +			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
>>>>>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>>>>>
>>>>> Why is it ALWAYS? Would it be better to declare it as ACTIVE_ONLY and
>>>>
>>>> Added QCOM_ICC_TAG_ALWAYS, to hold the vote in SLEEP bucket as well
>>>> preventing gem_noc going to sleep when icc_set_bw is being called.
>>>
>>> _why_?
>>>
>>
>> Now when i think of where we implemented the hooks, ALWAYS is not needed. We
>> should keep it ACTIVE_ONLY since we are already voting it
>> back in resume pah. I'll fix it in next revision.
>>
> 
> The path is between the SMMU and DDR, so clearly it has to do with the
> TCU's ability to fetch things from DDR.
> 

Yes as you rightly mentioned, this series is helping to resolve the race 
in TCU DDR clink

> ACTIVE_ONLY states that the vote should only be applied when the
> application subsystem (CPUSS) is not in low-power mode (CPU is active).
> 
> So, are you saying that in all cases that cpuidle might select such
> low-power state the GPU TCU is "stopped", and does not need to perform
> any memory transactions?
> 

I rechecked the architectural block diagram, GPU TCU is
independent of the CPUSS, unlike system TCU.

This means CPUSS can be powered down while the GPU TCU remains voted up. 
While this series was intended to avoid a DDR voting race between the
GPU TCU and its clients, using ACTIVE_ONLY could have possibly
introduced a race between CPUSS and the GPU TCU itself.

Thanks for catching this in my reply Bjorn.

ACTIVE_ONLY would have been suitable for system TCU (apps_smmu)
for which the interconnect field is anyways not needed, but
unsuitable for GPU TCU.

> 
> To me these two are orthogonal and TAG_ALWAYS is logically correct, but
> perhaps there's some practical dependency that I'm missing?
> 

We can ignore my acknowledgment [1] on previous response, Dmitry.
ALWAYS TAG is correct here instead of ACTIVE_ONLY in the interconnect 
field for adreno SMMU.

[1]: 
https://lore.kernel.org/all/4e5a3d82-b946-4490-885a-ea7061939c32@oss.qualcomm.com/#:~:text=Yes%2C%20I%20think%20we%20should%20go%20with%20the%20ACTIVE_ONLY%20flag

Thanks & regards,
Bibek

> Regards,
> Bjorn
> 
>>>>
>>>>> then drop the extra suspend/resume play?
>>>>
>>>> Not sure if I understood it correctly.
>>>> Did you mean the extra suspend/resume play in arm_smmu_runtime_suspend
>>>> or in arm_smmu_device_shutdown() path?
>>>
>>> runtime_suspend/resume. I might be incorrect here, but I think it is
>>> exactly what you need.
>>>
>>
>> Yes, I think we should go with the ACTIVE_ONLY flag and we would need
>> this voting in suspend resume path (For the same reason mentioned in commit
>> description and cover letter of the series).
>>
>> ALWAYS would avoid the need for this handling, it would keep the vote active
>> unnecessarily, but still that would have been nondeterministic.
>>
>> Thanks & regards,
>> Bibek
>>
>>>>
>>>> Thanks & regards,
>>>> Bibek
>>>>
>>>>>
>>>>>>     		};
>>>>>>     		gfx_0_tbu: tbu@3dd9000 {
>>>>>>
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
>>>>>
>>>>
>>>
>>

