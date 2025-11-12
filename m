Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E40225B2FA
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956182; cv=none; b=MeAVISxSTUMO8KcDoD8nETa6O/ek7aKaidTDE9idZXo7fhR79VxxRgeNM1HD/h+DEdxjvxc/v3LadR7A2PFEMsVAftBAdEY0F2jhSaoNTgB41RWHP+GTC6Q2BJ5Klz5F3nE5N7IK+7Y4wyD0v83bJBw1z0gyK0oaU/iEKIu7jHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956182; c=relaxed/simple;
	bh=mM9fAjOXXwht9yAdsure33Nqj9S+xcHDp8imOVtYD60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfFCqT1PM0gus80tOUKXdK4DlqaTbnjb1IC/j7fD0WNvNSIq6o/UjP+hrKvWUJeDYPN+sDAz6hhoAyXp21MLpaOY/EJGISq1idSVvyHBoqBIttwAfeSnzvhLxhRW8PtqGuHlZ6GwN8sfCLoUSBCb+UIkROaMC7j4qlJZs/klah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlG5U3To; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FCXsbYRQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlG5U3To";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FCXsbYRQ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9fTPG721958
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aTbuJi3FxUPkkWHKpmQ79xCiSdbgLHZBGK2oKYcauJw=; b=hlG5U3TohjmX4ClM
	fRmUhB+jeUucmH3r8qCOseKTaySRZtmTOBvAGRJ4JW6aHkxhslDqAh1XYSiSVsFJ
	po5HZYh5AADDR6Z4WO7Axr5BsWoJ2VyhTuSAHY/9YiM+SdG/rmVza0f8IFvAG+bh
	3l0iqhR8p1IxpWG2ZXDKCMp0KvZlpQOzvbUdyg5h0TcKoIF746oQCeM7MPK7aVuh
	+UJdwm2fheTdiC/BuI8kT5Na7lwwmJ0fEVvoZq3XER3k65xnr6iIyjFWuT3peoJr
	CNgR/jZ2qMG/34Ij/Zk0TVSaKhq1legtEY2LqbVeV6oJfFKz4OzDIkfy1zz6R1ET
	6nMgFQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqu1rsq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 14:03:00 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-559ab9b8b24so32356e0c.2
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 06:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762956179; x=1763560979; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTbuJi3FxUPkkWHKpmQ79xCiSdbgLHZBGK2oKYcauJw=;
        b=FCXsbYRQBcZNo5hQHUZOucLMl9QMV7SaKfaoy4KvEaaQSdJNwWcffMWgesvFftZnpj
         RBwIbs6SIdcoctrBTjHxjnI7/iQjFUJllYHLvAZQIvBDQ/ite7GQ9aTvdVsF8slLCIty
         NhLIHZSK/N1Cm7iJQ5ems3RwjhbbF9b+ABlReXcIeoE72aI6IO9TwJkig80m0H3ZVe61
         wT+Q8Jfje6+5dQBf6TwOzQCTI69IanQ9vWVAdicDHv2PyTst1Zt/TsRk6RIPuNv+lQyT
         uPNqCduIAUithzdbyoSBZj2P/UB/yvPkBeSgoW4dXRrqo9970uuydJUtiH04/YCn57xl
         bTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956179; x=1763560979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTbuJi3FxUPkkWHKpmQ79xCiSdbgLHZBGK2oKYcauJw=;
        b=gLRG0xQooDbt/9FQEsVVyfJnS8YaaQGPkPKXRpTI0TUNpTfoP8n75QiyNz/Co5aQ7n
         UYjo0AHct8/aWAgDlQBV9JWJPbIzoguJWX/FtKEDYu3RZNuQHvO6aQcmEskUtl4J1l1w
         pzcpeY0dvocsuevQWfBu4Q1MociSWZ8GYLFG9SIhkETwzesM3nkcLDJlTY7VTJFd/2ie
         8H6U8jpY5nTK22XfBLy/4vTudWjHvQdTx2F000Zh+TfVY8pQi29M6AcK3Zb2P+psO9Qm
         f+M/8rsocsUbemXHJetcIErhFylFuME/04VCLVSWJh7BaCqgnMRzUVMumWLCSWYHcR1j
         A3HQ==
X-Gm-Message-State: AOJu0YykfC4Majkgt5r9fpUlS2p002grVw4zhSUoBbRDHEfp4PFtKJWi
	mPvF0V8mg2j+rWdQgyg0kvJCWMkWJ1mhHy235HUpo+BWFk1+byts7NHabH/9+mWph/WQUhCBI2n
	ArmFymgs02GPM2KIUXpnDjaWH9THMvTOQTvkXdmbKVTjbkn6wLMfeJtnssQ==
X-Gm-Gg: ASbGncsm7o39zeypY55cJ2GKJOvrMRyv4E3xTaGGtARvpfxxS8TIDwgyTMEW1F0AugH
	x2AKV593j36QAgYzvEAIJpoR9mp518a/TEX3IhA86yqRkIvVmr6Bw8TCqBX/6Fv05u6Djs1i/JT
	6qok2wdGh5kNWFZYuipHNfTNHRtMvNbupFcYlPLdly87+ql671W+rVDeImZ1ce/ydbLKmV7PYi2
	pu+IuupxL1MbGDTUsyp3P6kh4M6LgzzjIi6FxqSK0MfHQkUxJlZXFbpr2KwydaEyK6GgNL0hmVy
	jP+SeHP5GUWrTWcCjlkQ3qSABtjhB5mInWKDSUALpPaHMMP0FvyDbsRkMgRDsFP7fkwokxETpn5
	eHbyGwQr5bvK35m9+FKfRvI25MrpTojjnLuG8SZoGMEb1Y/6wYtw7wVds
X-Received: by 2002:a05:6122:3714:b0:559:ef6d:b3fa with SMTP id 71dfb90a1353d-559ef6dceeemr260915e0c.3.1762956177621;
        Wed, 12 Nov 2025 06:02:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDhrwzbfO9vyPZvREpumsSUOwwsoGszLlpvZhnJmg8bsJRAFxwMnbB6qzgmnQ6CjNSL43L9Q==
X-Received: by 2002:a05:6122:3714:b0:559:ef6d:b3fa with SMTP id 71dfb90a1353d-559ef6dceeemr260791e0c.3.1762956175682;
        Wed, 12 Nov 2025 06:02:55 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e9d7sm15873200a12.36.2025.11.12.06.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:02:54 -0800 (PST)
Message-ID: <02d7c0a9-0d24-4fd8-980a-da9d7307588a@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 15:02:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: add actlr settings for mdss and fastrpc
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, dmitry.baryshkov@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bibek.patro@oss.qualcomm.com
References: <20251105075307.1658329-1-charan.kalla@oss.qualcomm.com>
 <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
 <c4b1df46-e4b6-4d95-971c-7aaf33bd35f1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c4b1df46-e4b6-4d95-971c-7aaf33bd35f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qPGQvADkRnJJjqfqA96YLO4M8d906lmF
X-Authority-Analysis: v=2.4 cv=Hpl72kTS c=1 sm=1 tr=0 ts=69149394 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COuKgFje69h7aUJomk8A:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: qPGQvADkRnJJjqfqA96YLO4M8d906lmF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExNCBTYWx0ZWRfXyFWNTK2HG5lV
 qMdR43BXkeNU24+Bw8Ejk8bNB3U5ZMZuEn4QwYQX8D+YIkJpw1+8TOLq5oewao1hz2ZUC7NOogK
 Q8+MYRtP1DPp+Ow33Hi+lQ11sxFqVp4vlIyDgn53iSWDraz86S6f7SI48fCyYry7D042bU4bcoY
 M44qj/z57skSOqcp4j3INn59AJ8F7CbeF+FM+pthbOb0WaIrRlbvczA+tFCLOY+TtQsdARjsTly
 gvw9DMaLHfhfu3OweZYC4YEa9RVg7zXHO1YffUv11hJDslWbaYJttHmyV7dnvBr4PcZy8CR/DhJ
 SIQvh7wqnPqn1TT6dhoU3ZWzX8LSPiRt+ajrWYxaSqCDIzhh4owkGBECog/vJxU6GYHvhcysIQW
 8TSKbJsO2z92lSSyCqdoOEpwjM4Zzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120114

On 11/11/25 3:02 PM, Charan Teja Kalla wrote:
> 
> 
> On 11/5/2025 2:44 PM, Konrad Dybcio wrote:
>>> +	{ .compatible = "qcom,fastrpc-compute-cb",
>>> +			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>> This will be globally applied to all smmu-v2 targets with fastrpc,
>> starting from MSM8996 ending at Kaanapali and everything inbetween
>>
>> Are these settings always valid?
> Oops, you are correct...this settings are not always applicable it seems.
> 
> Example: lpass compute and cdsp compute node uses the
> "qcom,fastrpc-compute-cb", but it is for the later that ACTLR settings
> are valid.
> 
> Then for these cases, should we be extending the actlr match array with
> additional compatible string and then add them in all the device nodes
> that require actlr setting? example:
> 
> @@ -3119,7 +3119,8 @@ fastrpc {
>       compute-cb@1 {
> -         compatible = "qcom,fastrpc-compute-cb";
> +         compatible = "qcom,fastrpc-compute-cb",
> +                      "qcom,fastrpc-compute-cb-actlr";

dt-bindings (and especially compatible strings) must not be altered solely
to work around a driver being suboptimal

But because you reported that these settings can change both between
platforms and instances of the same devices on these platforms, we could
possibly reconsider adding ACTRL settings to the consumer device nodes
where they stray away from the otherwise seemingly reasonable baseline
we have in the driver so far..

Or we could introduce some more bespoke matching logic.

I would like to know more about the scope of this issue, i.e. the matrix
of (soc, device, actlr_val) that needs special handling.

Konrad
