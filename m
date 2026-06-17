Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AEB48094B
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713262; cv=none; b=ONSsMs6OqoGAEvscvwgt0DfBjnZk+RfGx/XiR3bBIBcPAHTeXOxxgkMoX+inMmCdS+9e1iQ3rMDsg/OlCITt4OzWuIfJb7WmZE0/IvDT4iIZZi4bJURegpIWYu+N7QcaTs/GGqSFiTCgplMj+a/CRuVZS1IuSni7CP+9pGihByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713262; c=relaxed/simple;
	bh=mQL3uNLDtBiRA6dMV1diarsQjL8zJFnVODKJvmajvLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0VOijOOpSTUirkUIO3NiedB2J3suT7vZomjd67IJrvapiuQFbKTIeJAq5twADOMVnjhDUl2xnSrGyao2bVrMWPIHg6bv5lHk+zUdoWjInY0TMMAS7E1uLkCUL2QOI8Bhw/EXszmWNrSsj1sZ6DQQOhpFw1xbGf2n5CKmRJV3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f0pnPqch; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FWzYoE5A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f0pnPqch";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FWzYoE5A"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HFoUeG2731327
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 16:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	losT85IqK/EGuwOmznCnocjfeG/q92lYBlNczhHDlvs=; b=f0pnPqchVoogz6/I
	7qY7Zy0N0sPnMYAGbR3Ni/JchJirqBjSIf0FEFAGrYXGHNjJDUNQRXY0O3dxxlhQ
	D9z2LPFkwQ75jW7TKH7X/a4KRNXTk21TLCie/tBmkJje5mJ3rh5h+M+DcdSHQF7A
	GWW7VIoEFiwWZmNkOh2Ac6+PTZUCyartF6XC6T2WyDcCihAFjk/0X1hFnV3lG1jw
	vzQuTOws47CjxLE6DjewKykJIS0BM+YLdvWiQCRvgceZZFIuzESEqck+e6T6a5Qt
	m3DViBp3zGi6TpHjVU4DD06jY6agaXMxoPFb55efKjd6inBTF/fmZtNcvqrJGXCC
	5z+5HA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2c8b8u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 16:20:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88e0f04e51so11992a12.0
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781713256; x=1782318056; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=losT85IqK/EGuwOmznCnocjfeG/q92lYBlNczhHDlvs=;
        b=FWzYoE5ApnsrXD46nwEXHKZThJ7i6qJbFU6/EqCRvBTN8KEILB/4IZMUnww1G/JJpD
         w6jXF/BVDRv8C5AdD9gIZo0s2ZPklqA9/6dUf7wt3TKr5RvDvE41n8MLDFvzqgCnETFC
         KHJdrTfe9awO8pCtiQ3yqrz3TbSWKPtY+vLS2U4sfJVN6iHBq+YWIQT2uIIKdfo8lp0F
         NjpLZ+eY0IFJdScxoQXgBj1bIkQr7zWBEZisSp+xuVKCRqRJrlepnpk+crWwmSamjVOd
         McKiH2zmZkTXeZAl6FDnHrHFaMFi/IAIEDym9iw5x/9vxqAaJKeLzYVzpJ1300sTN4lu
         WydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781713256; x=1782318056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=losT85IqK/EGuwOmznCnocjfeG/q92lYBlNczhHDlvs=;
        b=ilnIf56djBr0iVBTg+EsGWK9BeuJ02gMxplbg+4i7CpyrHUEJ5L4cqBhEykyHtDIGO
         BrghVA04453NXtDp7DeJefB32PxZGZOzdFlyaB71NOllTqyM1zfyq0ZVRBFUsGZs8JmV
         6zlgEZYMH2pLTE/kRR7iCBEwdaY0hgGHcU1FBSlFXVj2Vpev+CGXVqVWmqNjgmO+sL7q
         x/Bj9mL15LOcs7McNtu235wR7wcOW9RawDnKmo9yfLg1b5S1gFu8l54TMQaqPjvfRrm5
         +UAm1vxHkNR7qsa6ZgP6CnlHLc9ymEiMGUBUBwgGT792FUYN90zp/nosBQTivd5xyHQ+
         uj5A==
X-Forwarded-Encrypted: i=1; AFNElJ80DlYSxPc8gkP8sqeApFeRBc8yTG1TUZPsH446YVa3wMgp+qUUUtOFRA+tdCszHPsxBC2t/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4LNczOoQlQbxEejZsyGxxWTf8ROT48FV4f/xr114gcyWAn3nW
	6lBECX867SjcamuW7/aj1z3rfS8ws4FWQZsWj+DEg0oRB2igdgiWh6SV4mHju0af/hYKqefek7o
	dDvF+HygQU6vMvKuD42Ljzyd2GzAf9tjFDGCXytKm7i0wmzZ2JrTq0btTbQ==
X-Gm-Gg: Acq92OEvJGyh8Lr+hA4nZ75Sx3g9W1ZP2tefEAgHIThtc3zlLNDq4/QE5XGZoOkYMx5
	OQtHBVc4RdOZEttXrfDgjEq352avkNVSGB/vTyJD+LSurRLrXMah0CIS8xG/WwtgkdFifRiZ3ZA
	G0sSOhmTTLUq8CgEq2OgyYPksBDyYtb3YJQp0TS3vbCYSIYkGtTT1DmmOrviCgyKgE0PaQXKMbI
	b2+KW6WDNipKmlqJFTMnTf/4SJZy+mI6+Tdeb2yYsuPsImkKJdbdWiUG8HLRy/CQAlZ32YtdJ7w
	HiIPuPdLrlIqydEF/osXdCzOtPi2hWhtk923tT2tnSSI2cr1jhjKpA+G1AJY8LDQxVHfncCGVdp
	pz53d9CQWHA/mTdncJYOf8GFvg0XJ1ERaQJyVpz4=
X-Received: by 2002:a05:6a20:c79a:b0:3aa:c93b:6266 with SMTP id adf61e73a8af0-3b8b64824a0mr5231199637.19.1781713256324;
        Wed, 17 Jun 2026 09:20:56 -0700 (PDT)
X-Received: by 2002:a05:6a20:c79a:b0:3aa:c93b:6266 with SMTP id adf61e73a8af0-3b8b64824a0mr5231159637.19.1781713255883;
        Wed, 17 Jun 2026 09:20:55 -0700 (PDT)
Received: from [10.219.57.228] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm15074358a12.5.2026.06.17.09.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 09:20:55 -0700 (PDT)
Message-ID: <1bf2708a-bd2a-46a9-97ea-8c1ad96e7ac3@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 21:50:50 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: kodiak: Add GEM_NOC interconnect
 for adreno SMMU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-3-2a6d8ca30d63@oss.qualcomm.com>
 <p4xnrkcpbufkkbv4kq5civbt6hiwv3warrz7jiyinsfkihfedh@jfa7sgyzot6j>
 <26d51cbb-2d87-4564-b3c6-cc61ab900e19@oss.qualcomm.com>
 <zhdacu4upv5kyvyqx5hcm6im4p7r3z5bsnup7hqu2okxyxmeib@snpseurpvhtc>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <zhdacu4upv5kyvyqx5hcm6im4p7r3z5bsnup7hqu2okxyxmeib@snpseurpvhtc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1NiBTYWx0ZWRfX11MQnK0cL41n
 /iNNkYYhRXkOtOCO25me3Xl0bhmE1JEKPzXLP0WOLF1AdFQ7HuybfjvEBXVtY+CY1qg0QpjxTpr
 xa8/1IW5iKUamo2k5gcxEGnDB94ezMEesO0Du51fnNsF0ib8xh8VUIFwH1hQ+BpaSD2hXaDwKxJ
 vGYXOoUoYHp0diWdF8R9tv34M9F13a++YdCqokSEOdKKwdyT8noVd6kX/zbDEZnh7nOWqBg/wSv
 u6b5fyL+vnlmRzEeIp9ql+ScHQrj8Yx6+qxG/i2TjzDKvyYxDYdf3K3KgglkS8qpuDdwmpmfC48
 TNXIY7fW3SYTArgM1/Ntwa6gA1PUDDdRIMDF0DPcheKysw2Gvmi7Ji46wgopqb4ByoKJKAHDuD+
 OVhpRqW/wkSXPFcZhylavxu1QzaY5Uj4x4ysa57rU1Y7bK7qNG3smt0O6/q9tUcpsDTsyd80uF8
 t5VjZ3wPkWz1h7MYRBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1NiBTYWx0ZWRfXwvYLDdadw3QP
 odWFmZjF57hzWMUsAtCWKAmltdJDyEkNFjZRSWhGIa3I1OaV9OTRVc+S8VDXE2MQy1V1QQt8c2J
 eIyQH9Wj9o8iyTP18UdFUHkVwWHTxyY=
X-Proofpoint-GUID: NSuGl2q5HE_Oxc2G-Ws1QsJTTCy9AmGR
X-Proofpoint-ORIG-GUID: NSuGl2q5HE_Oxc2G-Ws1QsJTTCy9AmGR
X-Authority-Analysis: v=2.4 cv=WN1PmHsR c=1 sm=1 tr=0 ts=6a32c969 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Rg3GaRgnNXoUDx2UCPMA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170156



On 6/16/2026 5:49 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 08, 2026 at 08:07:07PM +0530, Bibek Kumar Patro wrote:
>>
>>
>> On 6/8/2026 7:27 PM, Dmitry Baryshkov wrote:
>>> On Tue, May 26, 2026 at 08:12:04PM +0530, Bibek Kumar Patro wrote:
>>>> On Kodiak platforms, the Adreno SMMU requires a bandwidth vote on
>>>> the GEM_NOC path (MASTER_GPU_TCU -> SLAVE_EBI1) before its registers
>>>> are accessible. Without this vote, the SMMU may become unreachable,
>>>> leading to intermittent probe failures and runtime issues.
>>>>
>>>> Add the required interconnect to ensure reliable register access.
>>>
>>> Does it only concern the GPU SMMU? What about the APPS SMMU? Should it
>>> be voting on other interconnects too? I guess so, because currently I
>>> see that TBUs vote for various interconnects. BTW: should apps_smmu also
>>> vote on the power domains?
>>>
>>
>> This race mainly occurs in GPU SMMU, where the GDSC can have an
>> independent vote on the Adreno SMMU. However, the GEM_NOC vote may
>> already have been removed by the GPU (or any consumer of adreno_smmu,
>> e.g gmu), unless it is explicitly voted by the GPU SMMU (which acts as a
>> supplier for the GPU). This mismatch can lead to SHUB timeouts or NoC
>> errors.
>>
>> Mostly this race reported in suspend/resume cycle (when gpu/gmu devices
>> moves to slumber/suspend state before adreno_smmu powers down
>> and the later doesn't have explicit interconnect voting).
>>
>> In the case of APPS SMMU, such a race is not expected for any known
>> use case. APPS SMMU is part of a shared infrastructure block, and its
>> power is typically kept enabled as long as attached master devices are
>> active. Therefore, explicit power-domain voting from APPS SMMU may not
>> be required.
> 
> This looks like a good part of the commit message. Please add it where
> it belongs.
> 

Ack, thanks for this suggestion. It seems like i haven't explained this 
specific info in any of the patches in this series.
Will take care of this in the next revision.

Thanks & regards,
Bibek

>>
>> Thanks,
>> Bibek
>>
>>
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/kodiak.dtsi | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>> index fa540d8c2615dc02d941eb16bc7253204c2750bd..eefa4b836a81374ff437ab4bbcbc3fecc1590ab6 100644
>>>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>>>> @@ -3386,6 +3386,8 @@ adreno_smmu: iommu@3da0000 {
>>>>    			power-domains = <&gpucc GPU_CC_CX_GDSC>;
>>>>    			dma-coherent;
>>>> +			interconnects = <&gem_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
>>>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>>>>    		};
>>>>    		gfx_0_tbu: tbu@3dd9000 {
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>
> 

