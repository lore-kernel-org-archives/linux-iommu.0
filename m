Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC024B28
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429657; cv=none; b=IqtsVcaCrkLDdLxWNo8QbctSQW4kKpKqRFG5kPbczTq0RJQUwbfe/RRToMfODX/IvpLG4Jmi0+7R7oJ0/VKIXk8sjyC0RMC4uh6hdylDbB6LRM69kf9ojTBhCJ49wq1VYrmBA1+OhQNYUYLvMVoM1tNFJ8WLG9E4GJxTiAakLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429657; c=relaxed/simple;
	bh=KpdPVz19HVrlkW48+Oy2TNpS9/8iY6PDbSnX4WVderw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUmSfbjYkW/qVrpVR2+RUrYP2XgiTgGV4l1FeD9wbPWABwtZfKsMceB2NAa/oxqV2C0PqKnWwN8/9SjsmjLjXZv7P6atQAVDL7ulQYISi01HI2ztGXFpF1ffBbzfOtcYg7NubWbEldbMhoF431I1pV7ASEpvFA5lm5vEqE1eIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L7lEwIfh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L7LH20YO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7lEwIfh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L7LH20YO"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667C8hUH3755535
	for <iommu@lists.linux.dev>; Tue, 7 Jul 2026 13:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hnXcQ3o0MMmuZU0mxgw/WDOefXkSOTgmXJB6YAntbRk=; b=L7lEwIfhmrJlWiNo
	1bnUAJMzW/LSGvniuGqYWeTH+CRlhdbiiwMOfmYghtgPHbaud1U60yXSpGBgrTwO
	+zJywcpSoeIQxfF7kb1NPliFdM9z663U9mRl0bVJ2M09b2R0l5K71RhzBOHZ8F/a
	AjKXzUTkpg9zq28puAcPT6U5NkZg/h8HOs8/B6Akgo8FvAqDrueyHe++jUNJAt5z
	SLHVNsNV/IniHraf8Q6Qk/Lv/V4WxvEx5pL7TGLWjd2eclnwa1kGiFhgEozYs3xx
	c+6yrUu2RwKh6refVw23EN5lrymswM2TSZcA3q0OOQw9tiMO9OmI0uYxhNkknl2z
	a3T8Xg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep1834-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 13:07:35 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-73843d3623dso678526137.1
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 06:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783429654; x=1784034454; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnXcQ3o0MMmuZU0mxgw/WDOefXkSOTgmXJB6YAntbRk=;
        b=L7LH20YOeLMPM8d5F9c8vuwF9w5fqhRmBCjB9nc/Dckrr0XWCPohJ5MCn67jcMBt7N
         y1+ylDfsPWPF/famWo0Z9tb5Zz0EzuSssK9WX1kiUnFkgEQ9xz2QIDSVwDCbq+qD1eD/
         k89RIJqXCMAMhlGE1GnPHi+jphK8QgztYJyuBwg5ZSkUJaRlyaDMtcJ2SzFDxUqgbz1l
         RSaRE8Ujmsn7Ui2nJwFL2w9MRwpaFxf6ZIcKaT537vyBRCJcBFFuHTEIh+PzngA6U5/1
         /XcYHLV49APLzEmhBACyG0cKCKRyRlbj44Ozi/VPw4kXT+7nQ0B3oxjEzgxTzryVoI+7
         7BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429654; x=1784034454;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hnXcQ3o0MMmuZU0mxgw/WDOefXkSOTgmXJB6YAntbRk=;
        b=E3uk6GfH7XOb6o5sznszEwcmcyyubx6MshYlDdoXhuz8Vq1Qovz0t4xvsoQEph8svu
         SDChV4kvjMcOMV/p+070W+nMOhm7c5EY1sLszXsI3Tpje56KScfC3p0OhDFYWxAs6lKB
         NOSInzm4Rc6fxVtgTZpyil4HV1GjHjOPriE+8NCOhuNnerwmtjoZzHQ5HilKBTW954sE
         MBw1eR3VDBZDR5ITfuEYaMIJLmTmhlsqN0gNhCIjoTh+jZfSY92c6Ei/c8mMMxSS+Rim
         639ciU0g7loQHwYAWzyk88uJWO5GQAKiwxxTJdmIgCNT/mte74pM4JeujwZsgiu/5ZwX
         /a8A==
X-Forwarded-Encrypted: i=1; AHgh+RoyJsiRXfWNiyCBM6eyQ8AOFqtbTlYMVy0FqkDKkX9Tvh7HpAnMxAs5Q5UgZ78jggWklSVOMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSIHEnTJugCT8bBFnrN488Id87bcxuyWsZTtG0aslMa/16lDV3
	ckkD7HSePdn3hYahZG7pfi0dHyTPzE0XUEcx5EbMRkH1HY2r+6vyLAids0b1NhoIAT9WixIyy38
	fcBSz6xuVqOkDjPbJ36LWG7KYSrOFmX3F5x169dGChardOCQTOwcBe5RaNQ==
X-Gm-Gg: AfdE7cnDxxTE6ZxQo+1YhpUbWBzO/cWRy4RtI1phHKCwvFZt3s40oWTdUeyXh7FAFdx
	YXee5jH0WSgBCYfxTbNehm8kq5IQSv0Vo6+PxyiyFQxmRCkPqwJ61xpsCK2gvucXpwOpvlFG8SO
	N11RF0AmbGUnDbwEp8yqBf3SUhVzlETRBb6o3Ovwr9p9pG1pZcDE6pufW45CwAmlj+YzFGHNrFy
	WfUQwHgapvBDkspF6MRDYLYODUDkSSBzbYy+E2d1Z2cb0aykoAtpZb+DNgtz4GA7Ls0NFlU5Q/L
	75OHtdF41kvq8ZBO2AB83PDQ5ptTx04CRqi4tWay3Awr74wnI1pjJCEl15t8zZ5lYC8YYCiVbJa
	Ab8pZXkEbxpxf1uHb3b4y53JwDFfMAet0qa9XHGs=
X-Received: by 2002:a05:6102:290c:b0:737:1ca6:84d1 with SMTP id ada2fe7eead31-744b7c5e3e3mr2503025137.24.1783429654500;
        Tue, 07 Jul 2026 06:07:34 -0700 (PDT)
X-Received: by 2002:a05:6102:290c:b0:737:1ca6:84d1 with SMTP id ada2fe7eead31-744b7c5e3e3mr2502943137.24.1783429653657;
        Tue, 07 Jul 2026 06:07:33 -0700 (PDT)
Received: from [10.219.56.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed137705dsm3703700e87.32.2026.07.07.06.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 06:07:32 -0700 (PDT)
Message-ID: <807f145d-88d3-460a-9862-b63fe2a52cf7@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 18:37:24 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC interconnect
 for adreno SMMU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
 <20260706-smmu_interconnect_addition-v3-3-afdca0125a65@oss.qualcomm.com>
 <h6opbtr2ced3sannj3ym573qc2sjk7ek3clpto5j5mtqfrfk6w@34sk2zraoqtj>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <h6opbtr2ced3sannj3ym573qc2sjk7ek3clpto5j5mtqfrfk6w@34sk2zraoqtj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lG-zTqDaZm2ahx63u1xPh-_galtfx-aE
X-Proofpoint-ORIG-GUID: lG-zTqDaZm2ahx63u1xPh-_galtfx-aE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyNyBTYWx0ZWRfX17tVzMDj7DnR
 m5TjGNxT7voTGaRKmag8QVH5R03R05RiOd7nFZGbggBhwW8Mb1Fd0Sp/W8Q62Bc6ejTWm5vcyYo
 P/l6EKVq98O1TJoWcmmAQDziDDMLmEZq2ivO9Aw2X78D2IqZP1rVlafU+j51FPRIn4jyvtkSHga
 Pyrt7e/fMO+YK3aU8d5zEp60g41rza9tshKZkMIa+ZMi5mcV6IG2XYrQqG14+9ZKglNwcFp2coX
 5nem9QhBO8oANNscRVLjcQgITOJIxFDaEdmXf5aA1BJZqqz1pjEWars1f4H8uuMfmCyFcXpamXO
 Ifzqyon7hObANuuPC/Utr06PdjqD0UAwcGuCHoC/Fwj1US1MeWwFNQ5HLGLZDVZhXr0nUFXhoGJ
 Lri56k7fz0ydlO8LpbLA7wbD788bS+dGnfTdHmoxkQbcA6zQfW4R9CH4clYDV+oYTQCGGHMv7C3
 A6bXHT5J1joUfiGxvRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyNyBTYWx0ZWRfX2lbeonbkrtgu
 NCR/o8TpX5HiFUR2/X3aIs7UWdztps1+TG2zF24d+5ydiGxnZRV9cvQjZwMUADafGU3XMfUuH3G
 vjuZnaXtMzPH6OSdTrt8slLX09YWIbY=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4cfa17 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=-8xGkPWzXzLllqT0I9MA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070127



On 7/6/2026 11:12 PM, Dmitry Baryshkov wrote:
> On Mon, Jul 06, 2026 at 10:26:36PM +0530, Bibek Kumar Patro wrote:
>> On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
>> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
>> are accessible. Without this vote, the SMMU may become unreachable,
>> leading to intermittent probe failures and runtime issues.
>>
>> Add the required interconnect to ensure reliable register access.
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> index 90e50c245c0c..721526f023dd 100644
>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> @@ -3389,6 +3389,8 @@ adreno_smmu: iommu@3da0000 {
>>   
>>   			power-domains = <&gpucc GPU_CC_CX_GDSC>;
>>   			dma-coherent;
>> +			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> 
> Why is it ALWAYS? Would it be better to declare it as ACTIVE_ONLY and

Added QCOM_ICC_TAG_ALWAYS, to hold the vote in SLEEP bucket as well
preventing gem_noc going to sleep when icc_set_bw is being called.

> then drop the extra suspend/resume play?

Not sure if I understood it correctly.
Did you mean the extra suspend/resume play in arm_smmu_runtime_suspend
or in arm_smmu_device_shutdown() path?

Thanks & regards,
Bibek

> 
>>   		};
>>   
>>   		gfx_0_tbu: tbu@3dd9000 {
>>
>> -- 
>> 2.34.1
>>
> 

