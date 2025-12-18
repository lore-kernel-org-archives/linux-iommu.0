Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F532D0F1
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059360; cv=none; b=WG5ETBWXqHTf1xN/Yksp9ybjWAQItaGW9nlPyxSSCTh4L8Pq83sw1mgo9zK+2wQCrIRnL715JAHndjD2ENmFdVhWV7Kxt6ec1mWAUIx/JuSnDlCCvc3m/3QH49Xvavaab6uW9eLEGDNBUq/7Bixt7CRAWhBWSp5nqa9EusVWwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059360; c=relaxed/simple;
	bh=2LkLvDuDiZF2Oqy24Wdv+QwVvSgqRTukra+AHkgkL9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0YKTf7Uf4h7jjMgOJ/wg/5ifXs4ZDgs+G7ZdSUvgksFP8sEpQrqXccD4+0uOazLWWg13DP8UiahZ3D3tmNW4/VJXatnCl1mELWWK4UvJduAW5/PSeu+WBU0pIkENGCn8op9Vq8TWSCbCCioByZg8PiK/cdOAfAwL+6q6OEkzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M4WcPmKs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QAsOibQB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M4WcPmKs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QAsOibQB"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI967HX4147974
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 12:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Vm/z6fYkdn2JoQ1TCNbeRy8mA7MaOc+Zg3cU+fK6UQ=; b=M4WcPmKsynq44HVC
	qzwxdxeLGtbtTx1v/L+iPu6krGaUVsWAcZ9heSuRjf9xH1wFTZvmq+ePxfbt6u/V
	TFipIrcMZAKSxIX7MSGivPRmU3KdGVMA90JM5BnlClmFPp21i9eO4BJzWYsFZHKS
	zRd3JloQxr1R9Y4/4717fOUj9Yu1zB8Qr7oTID3BqNWWjx1fV7IS0HFSDZtWDiqy
	pt7+sCmCDXOo9KwYVwBBl/43tMcSNN1Vp67W334a293BpHEEv2akCZwSTE74I/iH
	ilxOE9jd0G2s8KH+sPrX1uDyhwNNTEu91eVJTsZuA/rPlU1Oo4wYZGQoiP4ZOIt0
	+ZVB/Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40u7b209-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 12:02:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee05927183so278271cf.0
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 04:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766059356; x=1766664156; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Vm/z6fYkdn2JoQ1TCNbeRy8mA7MaOc+Zg3cU+fK6UQ=;
        b=QAsOibQBlDw9MriVLE7tjok9VdwXUXKnY252ieR99ciclifLGc3dkHBTuTUe6gta87
         TbHjuFqtoRrPNKOqhiZ/kPM+KwxI9NJodzQW/BuYgyMp5kIaBpCq6yZrESnDxQURd9mZ
         gI1Sn55Pqqswd/Npm+MJtdYre2J9nijuZzNan2w2JT6u8q6PTjXwUKluonttlYORWrFx
         GAqi9R3ME+xRmwv6dHrJ4HhszjQ/EtVPlFn9z1qsbyoPvxthFKCHxaD6S4KCjzVWb/EM
         gIZxVTtv/IPmxpO6gRuNzIcKFEdtPE2L7tXGkJnX9Ya0R2yt9y+F/L3K2NotgtQgdrh3
         KNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766059356; x=1766664156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Vm/z6fYkdn2JoQ1TCNbeRy8mA7MaOc+Zg3cU+fK6UQ=;
        b=OdrZrX0ETKQ0NcwvMlYjLVc3KgiCXNVSSrQ1yh2YuTQcvuE0FFIK51+3xoTTzD2AX9
         c19ItOgEne++ELC0/lfjVIW7cfCp8t0VOC7E/5bISR0pwo9faYcxdyrHf8+4Wn4stdno
         litOy6yWmmnUyLOcIlz+H9VMafAojZFtIspZcG3w8xjPnbRSkME5wxn2SlFZ6pYiMLHa
         NTEiAvTAPbI2cO7Vrw/g6Ow6qBT5ifZ6lRjeFqmEgNI4ZjRjNd8XP2S4KPhCJL2ABttS
         NeETdXQwCD9EKYMhOZNswL8lPG3Pfi1wjL4afjMvQD/ERB2BlALd/8710sMxgqY67V8I
         n8tQ==
X-Gm-Message-State: AOJu0YzoTdksowSkTH0Br+70GRY9QwFNAoiriltW4BDYR06SVqLfgPb1
	e5j3ayfLjO2C9pTPkhrrWmcpavd+7hW6H80jLGpzuUyi0gzR0t9slMKILsjiUEoM+TstRLxKyWN
	kQTljkH/CwmW27HcCKbg6Sqea6irJmaQVxYxmJ6MeR9EDDWhKeFMjH2OBSg==
X-Gm-Gg: AY/fxX7iSMlQW9yXJrVA6uIyfwF1LKzqaRP29wpTJTqmTFd8EQxWgpBvLEi2SGnfaPs
	ygobrVKVVyvH4CYCQwWtvxY12CKMStN7bRCH40B8NGVf9R7eODyMsjNd+dCxElnLVg+F7jkBHbN
	FO8ouz1se/XDWrGRqA20yrExNyFXBNvjKE9wQJkD2yHpdf9cpwz0OxcqCAKbkHsu/bgFKuOP1/y
	1Yg/2Gar0ClihCtjxC4gW58K3cWBuHNWPtt1zxeBSVg8NUNF2iybEO71VHQI5BxjSHPXDkro2cz
	hiAdVMVb3uW72/v01mQpb5WHQM9F8km2UakCP3in2YT/V6dN/7vn1kNuaQFhX8GqVVbRcIhA0eo
	du+22/SdPdLgfK5uZ7E58NT3CdqiKOvMH7Wq46YwnzuHuM/yvWeTaYES6DHM4MVCgJQ==
X-Received: by 2002:ac8:7e84:0:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4f36103f922mr18008131cf.2.1766059355667;
        Thu, 18 Dec 2025 04:02:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEjKaCrErxWCAcr66bGBT8jNIruLZAk0ai2nWX7kimbI6AaPHvw4PWGXD/l8FGMsK0GDByDA==
X-Received: by 2002:ac8:7e84:0:b0:4e0:b24a:6577 with SMTP id d75a77b69052e-4f36103f922mr18007551cf.2.1766059355003;
        Thu, 18 Dec 2025 04:02:35 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8023466d66sm204110166b.34.2025.12.18.04.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 04:02:34 -0800 (PST)
Message-ID: <bfdb1125-3dcc-496e-8380-80ba669dfe20@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 13:02:32 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: add actlr settings for mdss and fastrpc
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, dmitry.baryshkov@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251105075307.1658329-1-charan.kalla@oss.qualcomm.com>
 <eb596f7a-e13b-4edd-8ee7-05424ea3d9e5@oss.qualcomm.com>
 <c4b1df46-e4b6-4d95-971c-7aaf33bd35f1@oss.qualcomm.com>
 <02d7c0a9-0d24-4fd8-980a-da9d7307588a@oss.qualcomm.com>
 <9b4c895a-c822-40e6-bb92-8fdcd09c82d3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <9b4c895a-c822-40e6-bb92-8fdcd09c82d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2oyemZAud-CLFZahdS5b4qL_EsIiAcvo
X-Authority-Analysis: v=2.4 cv=Z8Th3XRA c=1 sm=1 tr=0 ts=6943ed5c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=Y1-X-kz94dDufzMKMX0A:9 a=UnacWq3ggp9slQcj:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 2oyemZAud-CLFZahdS5b4qL_EsIiAcvo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA5OSBTYWx0ZWRfXzQmp9g/jecTY
 M3k/7D9NOw26U3FNhB8dCWJPxxqSTnu5qSKYbrGVzjRDocnMXUEKf+TNg1PwJHB1h2QYgTupH+q
 v4hXuEpXkjqK6C7Kj66hYMH8EbvfaaO7UnD2/8RctmKO0/VTnVYjEN1VNrGRxwDXxZLQi6HyqPQ
 XTq9y3T/QvL+sciY740iAf5vEDeIA460HxInOJlJ5LPXWtiI5DKWnbeTmXodJzdYCV3ciGDQjyp
 ZLqPe20jE9Tj8jpkxHmAEnQwxS+N3RZIvc+J8P49i7t6KXJy1dNiKoU+8F7tImxSOJZdwcdyJhS
 vsp8fYqUYtPmllE8D9WHBA66lvhOf9uF6o6MP23KClx3qwbzvtgko1bt5KCgj4MpgFWolrWMLrJ
 toGFMj60H+lXVKrwrYEyZPYMxP/w/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180099

On 11/27/25 12:14 PM, Bibek Kumar Patro wrote:
> 
> 
> On 11/12/2025 7:32 PM, Konrad Dybcio wrote:
>> On 11/11/25 3:02 PM, Charan Teja Kalla wrote:
>>>
>>>
>>> On 11/5/2025 2:44 PM, Konrad Dybcio wrote:
>>>>> +    { .compatible = "qcom,fastrpc-compute-cb",
>>>>> +            .data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
>>>> This will be globally applied to all smmu-v2 targets with fastrpc,
>>>> starting from MSM8996 ending at Kaanapali and everything inbetween
>>>>
>>>> Are these settings always valid?
>>> Oops, you are correct...this settings are not always applicable it seems.
>>>
>>> Example: lpass compute and cdsp compute node uses the
>>> "qcom,fastrpc-compute-cb", but it is for the later that ACTLR settings
>>> are valid.
>>>
>>> Then for these cases, should we be extending the actlr match array with
>>> additional compatible string and then add them in all the device nodes
>>> that require actlr setting? example:
>>>
>>> @@ -3119,7 +3119,8 @@ fastrpc {
>>>        compute-cb@1 {
>>> -         compatible = "qcom,fastrpc-compute-cb";
>>> +         compatible = "qcom,fastrpc-compute-cb",
>>> +                      "qcom,fastrpc-compute-cb-actlr";
>>
>> dt-bindings (and especially compatible strings) must not be altered solely
>> to work around a driver being suboptimal
>>
>> But because you reported that these settings can change both between
>> platforms and instances of the same devices on these platforms, we could
>> possibly reconsider adding ACTRL settings to the consumer device nodes
>> where they stray away from the otherwise seemingly reasonable baseline
>> we have in the driver so far..
>>
> 
> During initial discussion of ACTLR design phase, It was concluded that
> prefetch alike QoS settings are not hardware definitions, and device
> tree would not be the right place to store such configurable/tunable
> settings [1]. So it might be contradicting to add it in consumer nodes.
> 
> For fastrpc client, there are 2 hiccups:
> 1. For a particular SoC, Different SIDs of compute client are using the
>    same compatible  "qcom,fastrpc-compute-cb" but can have different
>    prefetch settings <refer table below> e.g. CDSP and ADSP have same
>    compat string "qcom,fastrpc-compute-cb" with different labels.
> 
> e.g.
> fastrpc {
>         compatible = "qcom,fastrpc";
>         qcom,glink-channels = "fastrpcglink-apps-dsp";
>         label = "adsp"; /*---different label: adsp---*/
>         compute-cb@3 {
>                 compatible = "qcom,fastrpc-compute-cb";
>                 reg = <3>;
>         /*---Prefetch Default---*/
>                 iommus = <&apps_smmu 0x1003 0x80>,
>                          <&apps_smmu 0x1063 0x0>;
>                 dma-coherent;
> fastrpc {
>         compatible = "qcom,fastrpc";
>         qcom,glink-channels = "fastrpcglink-apps-dsp";
>         label = "cdsp"; /*---Different Label: cdsp---*/
>         qcom,non-secure-domain;
>         #address-cells = <1>;
>         #size-cells = <0>;
>         compute-cb@1 {
>                 compatible = "qcom,fastrpc-compute-cb";
>                 reg = <1>;
>         /*---Prefetch DEEP----*/
>                 iommus = <&apps_smmu 0x1961 0x0>,
>                          <&apps_smmu 0x0c01 0x20>,
>                          <&apps_smmu 0x19c1 0x10>;
> 
> 2. Different SoCs having the same compatible string and same label but
>    different prefetch settings.
>    e.g:
>    in below table sm6550, sm8250 and sm8550
>    compat string = "qcom,fastrpc-compute-cb" and label = "cdsp"
>    but prefetch settings are different
> 
> As per my idea both the above cases could be resolved by compat string addition,
> case 1 : compatible = "qcom,fastrpc-compute-cb-cdsp";
> case 2 : compatible = "qcom,sm8550-fastrpc-compute-cb-cdsp"
> 
> This discrpeancy is not applicable for other clients, except fastrpc.
> One way both the above cases could be resolved by additional fastrpc
> compat string with below format:
> compatible = "qcom,<soc_name>-fastrpc-compute-cb-<label_name>"
> 
> e.g: "qcom,sm8550-fastrpc-compute-cb-cdsp", "qcom,sm6550-fastrpc-compute-cb-adsp"
> 
> This should handle both case 1 & case 2.
> 
> But as you mentioned previously this might need change alteration of DT bindings addition which might not be allowed or favoured always.
> 
> [1]: https://lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.com/
> 
>> Or we could introduce some more bespoke matching logic.
>>
>> I would like to know more about the scope of this issue, i.e. the matrix
>> of (soc, device, actlr_val) that needs special handling.
>>
> 
> +---------+-----------------------------------------------+----------+
> | SoC     | Description                                   | Prefetch |
> +---------+-----------------------------------------------+----------+
> | sc7180  | qcom,fastrpc-compute-cb | label = cdsp        | DEEP     |
> |         | qcom,fastrpc-compute-cb | label = adsp        | DEFAULT  |
> +---------+-----------------------------------------------+----------+
> | sc7280  | qcom,fastrpc-compute-cb | label = cdsp        | DEEP     |
> |         | qcom,fastrpc-compute-cb | label = adsp        | DEFAULT  |
> +---------+-----------------------------------------------+----------+
> | sm6115  | qcom,fastrpc-compute-cb | label = cdsp        | DEFAULT  |
> |         | qcom,fastrpc-compute-cb | label = adsp        | DEFAULT  |
> +---------+-----------------------------------------------+----------+
> | sm6125  | qcom,fastrpc-compute-cb (NA upstream)         |          |
> +---------+-----------------------------------------------+----------+
> | sm6350  | qcom,fastrpc-compute-cb | label = cdsp        | SHALLOW  |
> |         | qcom,fastrpc-compute-cb | label = adsp        | SHALLOW  |
> +---------+-----------------------------------------------+----------+
> | sm8250  | qcom,fastrpc-compute-cb | label = cdsp        | DEFAULT  |
> |         | qcom,fastrpc-compute-cb | label = adsp        | DEFAULT  |
> |         | qcom,fastrpc-compute-cb | label = sdsp        | DEFAULT  |
> +---------+-----------------------------------------------+----------+
> | sm8350  | qcom,fastrpc-compute-cb | label = cdsp        | DEEP     |
> |         | qcom,fastrpc-compute-cb | label = adsp        | DEFAULT  |
> |         | qcom,fastrpc-compute-cb | label = sdsp        | DEFAULT  |
> +---------+-----------------------------------------------+----------+
> | sm8450  | qcom,fastrpc-compute-cb | label = cdsp        | DEEP     |
> |         | qcom,fastrpc-compute-cb | label = adsp        | DEFAULT  |
> |         | qcom,fastrpc-compute-cb | label = sdsp        | DEFAULT  |
> +---------+-----------------------------------------------+----------+
> | sm8550  | qcom,fastrpc-compute-cb | label = cdsp        | DEEP     |
> |         | qcom,fastrpc-compute-cb | label = adsp        | DEFAULT  |
> +---------+-----------------------------------------------+----------+
> | sm8650  | qcom,fastrpc-compute-cb | label = cdsp        | DEEP     |
> |         | qcom,fastrpc-compute-cb | label = adsp        | DEFAULT  |
> +---------+-----------------------------------------------+----------+

Thanks for the detailed explanation. It feel quite impossible to keep
track of all this in the current model.

On the other hand, the approach where a third OF cell is introduced
isn't my favorite thing in the world, and that seems to be the general
sentiment.

FWIW downstream solves this by carrying the list of <sid mask val> under
the SMMU node. Perhaps that could be reconsidered, either as a storage
for all the values, or as storage for non-default overrides.. Krzysztof,
Bjorn, opinions?

Konrad
