Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7BC388E6B
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504897; cv=none; b=iYjWJGtsm7FsBbfPuPoId9uqbPkEtPoVXAGHsLmLp7mAHhZYPb58F1SvBDGjItF4T4RPsEyqQyYhV27Zdn+Xl1go/SuYEb20Jc9YgCytqfe1f70r31dxvafwuQWfXEr3D2874qoJ2VzctDUCCa646kI9bzr0kfwoFGyFtPAuZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504897; c=relaxed/simple;
	bh=oKVfH/0Hygcklu+R5xYMT12z1eblv56XDMwOFHZZNzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9XRFZpLdt5r4AV67x3jlXIBuQ3mIRaahVKTitF3fSucu+huigFjVNPhjcS/ljQmnufwOiA1Al4fyFlsrMQO/u6E2du+KHWREzOCBkqVLeqN/F82T8PdKxRKiwQ+tClQTga8IR24atSEqfb8XvNIsUKEEVpZemd01I4INSESOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oltHG4ZG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F3GsR4+D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oltHG4ZG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F3GsR4+D"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688A8gD2222678
	for <iommu@lists.linux.dev>; Wed, 8 Jul 2026 10:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XQ9AX7OhkLOaP+j4lLrbeTNcxF7e4kwK6kGQsbCEXA8=; b=oltHG4ZG0U80gfpJ
	tYRua4KBzGf901wPuYRVh2i5a1FPhwH/fr5a0zAjX3VDEublxoHPSvbZVaHRjjT5
	CVNGhLqADIgdvEh+ShfpeXP7RXFgIQ32QbejmmRBpxzEg243jUP69Vl3QIpt/3ue
	wOlVnwQMI5cMt5cnRPvam1Gpq/+FxAldRghc0cFUCAhGcdwDssjsTTQtE/2Cv2ZD
	IWjMXV6OPjWh7LeTjXNlTovAKeiijLRzgWQqQQt4W9x5DEJhXHA5z98Sm5mYdGVJ
	a1ACK+xTymCfENv1pL85ypKsPEXw7JDCXTDpWaCUDQ4ZEwRMav11ZN4OetgL0ZVW
	+LRCmw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9csssw5n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 10:01:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-845e6a11332so893064b3a.3
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 03:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783504894; x=1784109694; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQ9AX7OhkLOaP+j4lLrbeTNcxF7e4kwK6kGQsbCEXA8=;
        b=F3GsR4+DlPNvWPaVLAUTWQhDYhyyIKWpFNYMR6p1uf1MMTUEaNYq9mKyrCNfgIvXLC
         BJAwgcKbM93gtavmxHK2a4ncke0sWa0YTSqzwnykzubuuzhn+KUZ5TIO7ZbNIBV5BoBb
         hmQ4QkDAemYUKA7ovRejekxXaQNa5zhSygGgOHfTvFPgB/LAgkXkgvPNcw3augaA+GTT
         Qnmey6Y//+yFR2KMfnW96LxOnRbBeptevNgadgiuLqm3oh9J6t7M6nDBU1KGqnA00lb6
         dXPPlz86HRFChK8aPnKMQnwZY58yPm56J9C7rkd+I3dWaa6c8nQU0tSKg9YV+up4q118
         h+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783504894; x=1784109694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQ9AX7OhkLOaP+j4lLrbeTNcxF7e4kwK6kGQsbCEXA8=;
        b=PmcRU7iAJSGkLd0XuVh7FrNKfCKq2vDzGAUwo+LLKyCgn478zS3FhkLS7LgWjcOLSv
         9+Z2Rb+XCjZ/ZkiekKebgzwNddSlAeOi3m3EyS5kEtOfbCASgFY7xqIwsg0A3SgylT7m
         4sucxWtZkGbKevxlsEIBl2zVtbsVFADmWHtSwdeAJzx5B+um1i/5OI/ZU7ndffhh7lAM
         R3+1lsKSQAum7kaNzeD4S/x+ELkVSxSNC6yzsrj3cldJqY2FKLVTWJsr5t0In6IYZ1Am
         D+LIog1n3O3Wva2Qt92z2Oz/damtCTmp3OH7WnmjQztIeEoPbFwixmCPgovCfm2rbxrH
         3JSw==
X-Forwarded-Encrypted: i=1; AHgh+Roy3L36d5h9tIiHGKxQQiqaprKPY/ZY8CaUjwDKO1upB+x9hOiRbFp3Lx5r9qsL4nQPencgPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEL5500C34oh8pxxXD51Wv7Mt3p7NUKQeQTqnizmJw3k2zcm4V
	BaX/42yfwHA+n9Qx7vO3uPs67IXk04MkFa++GRAYWIKwD8FyPksSEnNrD3+YXV6w1v5nK58go5e
	ySd2NcXHNpBEqepCOkgIY+gPE27B0CiHfXqnJJfRyEX3EidIFWNEVvpJO7g==
X-Gm-Gg: AfdE7cnpTzGxCRzzELjsRnc2Y841pWrU+QRhLPXGuGHXW6mQ5NBaQ9vcU8FNuZauUwy
	0pCsq2jRvBJHA1JO9vg34gX4oFX5ij42e0WZC5eZgijKhyKUMzz2r1FOjkBx79xVdTKaCQVeC7T
	fNt60aCBFtVEjT1K2ezwYT3SkwCpogzjzsOzRSYe0SBCcylQt3yJD1RaWI7ROJyOYeA6XbkFqKi
	v9bgNuztiQCzMQPzSYKA0PJg/bO+TMQbqpcrX9S/k6/ZmyZFJ3EAzfRdCwj9eyqJsyqXR82Ld7b
	rQbFKifSa2GT4qyYiNbkKiMNuGnxvSFWcDD1EFvWxGgHmOwzTlnhILcpHBm1SnDHx5ZuRn/dzr0
	XnHjl4vAHT407hQP9KifQ8c69B+alivUJ7vDseog=
X-Received: by 2002:a05:6a00:2e24:b0:82f:3a1e:5618 with SMTP id d2e1a72fcca58-84842ee9c8emr1865645b3a.22.1783504894034;
        Wed, 08 Jul 2026 03:01:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e24:b0:82f:3a1e:5618 with SMTP id d2e1a72fcca58-84842ee9c8emr1865535b3a.22.1783504892128;
        Wed, 08 Jul 2026 03:01:32 -0700 (PDT)
Received: from [10.219.56.198] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4e741sm6916358b3a.28.2026.07.08.03.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 03:01:31 -0700 (PDT)
Message-ID: <4e5a3d82-b946-4490-885a-ea7061939c32@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 15:31:07 +0530
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
 <807f145d-88d3-460a-9862-b63fe2a52cf7@oss.qualcomm.com>
 <a4f5sod3aflubxkk4mm4k5ozddydqcnqeac4s6vnozkd2nvxbi@hmh6zclsw5z3>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <a4f5sod3aflubxkk4mm4k5ozddydqcnqeac4s6vnozkd2nvxbi@hmh6zclsw5z3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4e1fff cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Gb3r-SE-3tiIfwJ9XNYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5NiBTYWx0ZWRfXxcNpnZNs7pd5
 rRgMSvJDldxIKTbTm8Dnj+nbFisUEKK/4ScXZPW7SSsaENinkZLt7qxekbnQC9gWGkNWKdUuESa
 UnV4riVz7ltTmTyN05MrLTK46P8LfskHv0De4NbQxd4fR5vNS7ABOkpVsekVMyt6k8ymUjmTYet
 HmE3Fwg/j8Y2pYfJpGTn8lmO66Q6TQmceUuQLqYKOdVFou23OumWYIMnU2uQjy4JWorlF0cVBCv
 RQj58xY7yb3jeE63/0/dka5XxVtNcPRbgwfgdcECunHVmOaezg3i8nbJiew+umXlmzAUsxJ9GgE
 6D+WS0kiBRuDVb9/9yjQTmHt4y+ISnIjILw5N4K8PI8LAloZIu+VqnwUphv9S8cPaW2zMNE+eyo
 dtW6pAzsAloNUUBJoIoiAWtotUhsW/Z87tkMzgYSsi/D3huvIGS9dkMa6O283xiItjeQvT2iZT2
 YZli1ZU9lWFFATzfwhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5NiBTYWx0ZWRfX3jGwnqfsszf4
 NherMOdT6iR2CC8ekk62wrD4NDfRseOgH5usJptdy0ENrqiROtMpufr1yS0oBUg/cjKVA7KE46+
 wEmxJU+VY2Fe5o5zT5jZvrIKEl13YcE=
X-Proofpoint-GUID: cellYttBS1a1bt7ROT9f7T-iiLSICVDn
X-Proofpoint-ORIG-GUID: cellYttBS1a1bt7ROT9f7T-iiLSICVDn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080096



On 7/7/2026 10:14 PM, Dmitry Baryshkov wrote:
> On Tue, Jul 07, 2026 at 06:37:24PM +0530, Bibek Kumar Patro wrote:
>>
>>
>> On 7/6/2026 11:12 PM, Dmitry Baryshkov wrote:
>>> On Mon, Jul 06, 2026 at 10:26:36PM +0530, Bibek Kumar Patro wrote:
>>>> On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
>>>> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
>>>> are accessible. Without this vote, the SMMU may become unreachable,
>>>> leading to intermittent probe failures and runtime issues.
>>>>
>>>> Add the required interconnect to ensure reliable register access.
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>> index 90e50c245c0c..721526f023dd 100644
>>>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>> @@ -3389,6 +3389,8 @@ adreno_smmu: iommu@3da0000 {
>>>>    			power-domains = <&gpucc GPU_CC_CX_GDSC>;
>>>>    			dma-coherent;
>>>> +			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
>>>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>>>
>>> Why is it ALWAYS? Would it be better to declare it as ACTIVE_ONLY and
>>
>> Added QCOM_ICC_TAG_ALWAYS, to hold the vote in SLEEP bucket as well
>> preventing gem_noc going to sleep when icc_set_bw is being called.
> 
> _why_?
> 

Now when i think of where we implemented the hooks, ALWAYS is not 
needed. We should keep it ACTIVE_ONLY since we are already voting it
back in resume pah. I'll fix it in next revision.

>>
>>> then drop the extra suspend/resume play?
>>
>> Not sure if I understood it correctly.
>> Did you mean the extra suspend/resume play in arm_smmu_runtime_suspend
>> or in arm_smmu_device_shutdown() path?
> 
> runtime_suspend/resume. I might be incorrect here, but I think it is
> exactly what you need.
> 

Yes, I think we should go with the ACTIVE_ONLY flag and we would need
this voting in suspend resume path (For the same reason mentioned in 
commit description and cover letter of the series).

ALWAYS would avoid the need for this handling, it would keep the vote 
active unnecessarily, but still that would have been nondeterministic.

Thanks & regards,
Bibek

>>
>> Thanks & regards,
>> Bibek
>>
>>>
>>>>    		};
>>>>    		gfx_0_tbu: tbu@3dd9000 {
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>
> 

