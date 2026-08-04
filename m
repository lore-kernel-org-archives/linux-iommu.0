Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086426ED33
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825815; cv=none; b=L8jUEWQFWFEoNGY2QQfflpEkWW1ljk2lmvbopNihVTiQPhxwA7IwFUkc3BUsi4n6xvDjg6xEJlYyaDLDsjhXSQe4V0sU1jiIjhxgLgWVGHHZCrDp7H/RBvcDGy/mOQ8WXPi2UjcYEygQipcodUG3GMCBCmY2NHsW8p1uJ6nTmcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825815; c=relaxed/simple;
	bh=yL1mdYdeU4Q86xQ5+DJK/R11hKApPW9BV32LAm3pEcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0mdwAXUbeJ72ntDlDonxKIZMQZqF6HCBqhazz+gNqliuFxoSVYPl9Pwd4pdXr0uF6jpytWuKTjPzL2/E4C933wVa35KlmwNet1dU21MpglEDK8G07i56JJR0qHNpeZJExxBBEyXDJfb6z27eFLp4dG6PhxPmf3UfFQixeiQBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p1RiAgE1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S+rtlHKq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1RiAgE1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S+rtlHKq"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67418OdS2265107
	for <iommu@lists.linux.dev>; Tue, 4 Aug 2026 06:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P4hFWZPTgwOL+XjLNG+cDq4GULAAwRZpS1PblWfC2LU=; b=p1RiAgE1p8lfFyhL
	kDtdS+UZZzKTbpZgWmv19fAeW+Jv9IKrNMHg6ta4Oso0aY5X+xuW6wFnh4LgHAlq
	Yl6YEl7vJiAVvDjJJ9Evb8rhhIBUKL5Jm3h0f+bqZ0BkXEzTNL6aGb98nfWLeNYp
	it4F2c4q5orV2WwBBJ/I0X+4c0COA+pOEp/XOY/E8On0Hnba06hgXGf5NeIINp/y
	zfb7Qkq680YP7FxOcjuK8rHSRZ4LiGCbTTKx2N7qjzBOsx5sS+fG03QeZM5ywFl7
	ItVfg6iPO5uba0GWI3xN3OzXdrI9/4bb0lQnAWlRIPhBK4MoIxvMWSth6t1Wdi/D
	W8PEbA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty5sauvb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 04 Aug 2026 06:43:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca124bf0189so571904a12.0
        for <iommu@lists.linux.dev>; Mon, 03 Aug 2026 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785825812; x=1786430612; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4hFWZPTgwOL+XjLNG+cDq4GULAAwRZpS1PblWfC2LU=;
        b=S+rtlHKqF9pX9ikZBmLFhYJtOkj2slN9tVbA+0U06mI6srHWrknRwQXzP7U3Lc0uym
         y6vU77Ln2UKwHpPreKx7eb2Pnn1VCrGzlYeSMQIqE4oYr4sjhoRcrsaRBZVY6LEgIitR
         tXnn/9LsOidbM8AyTXSNR2HSrsw5Soxefkgov8SiCIpc0jTD5xakvswOtEn7r59OH/kX
         ZcimDP3KAuLc5pyCsBKN/6AaIvps9PAmc7KDcfeZauxzn+WpDFP3pJXn8qbFtnsVx/Xs
         zcS97u/TvyIkRCpshBBuiPRntr/ilGCJvkutFWcrMZlhNRkaK0qsuV2Rd8wlUjSsvsSy
         fPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785825812; x=1786430612;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P4hFWZPTgwOL+XjLNG+cDq4GULAAwRZpS1PblWfC2LU=;
        b=M7CmMXJmj/ttBFuFaPGIM0n8Mz92VktGjsGmDQtRwSw65x7QrN9XQy93WkcsFknjLB
         KC88I5mzMDz/mXXy6oyk9QD4lfp4CwEdF6p29aklClp/S5N0V/0vQnou7fMm+xR/A62F
         zxwW/c/Sz5ldyQofDrMlNTxvx2/iFkV5wuuzpSBvVVrzTPgCLNNhD7d1oTgVd5cckhpz
         bg+kWBfoVrg74G6cHWjfEF1NsIUeo7VuSm1fvtIjaRN0cBL0GitolegIR3vzszoQNLKy
         fFre71ZQQrY7xW4ftbT3GfwgsryVVbWpTrSMK5VAh5E2TnMJTwhC5KgdF9aJ9xUL1XMA
         AA3A==
X-Forwarded-Encrypted: i=1; AHgh+RpgvlZWb13YiejleESmRw8fCpFBVGoOFOqQADOoSqi978tSFOdbv+D3Yd/nOopxIci+IX7scQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQClZ3KDJ9Itww6mtsLwPyvWE6HNsN25j/du1kJWqg1SUct0z3
	5BuD+I2iE4ZPz1pk1tbdV4BoVIM53bj0gwpxtHqa47V4OPjAlB3mG/eUBsGD6wPdHAt17W+Zypu
	PjuHOUb5cEbYoW37GpRSAQB/3cu05FZDmIEJwQ/3Px6Iu9fNldfAqQuvuCQ==
X-Gm-Gg: AR+sD12neetB0djUPJPVCm/BrUnVYBYiPvbi2i4DKCsNKvrayiAUuT+WFYosN6MbT6M
	Gw5yc4Wwq5BL41Iy5Zji6r5/i4V9QjWWOjD6yNa/JYTfAsaAXfwkDktySOzuv6dk4s93wNSVPfv
	4YMzoZBe9nXxkiPQkl74gV8WcLh3VmNtAi/hQY914ss2CDdczy0YbkqimcDQUAelm/i4jsZvVAA
	hRzld0o/ibLCSch7sghyNc4OgkML/WaPByq1ehxbYHVThejsnW6jGUtjfDPIyRvN0xCuNfPUUIt
	ZSH71nprMaqnVJhCjXpPAJuGmiL+oq7f8X6SIy3JU0w+vASp+vtPOEaML/I5s6uwcaI8uJtnLGp
	OLwcNUsHeMGwawfvDZmchYCdFFtsSOxVsHMXysi2TBSAg
X-Received: by 2002:a17:903:388b:b0:2c7:c385:c5a7 with SMTP id d9443c01a7336-2d08abc8099mr22212035ad.26.1785825812090;
        Mon, 03 Aug 2026 23:43:32 -0700 (PDT)
X-Received: by 2002:a17:903:388b:b0:2c7:c385:c5a7 with SMTP id d9443c01a7336-2d08abc8099mr22211805ad.26.1785825811627;
        Mon, 03 Aug 2026 23:43:31 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f9371asm1019725ad.13.2026.08.03.23.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 23:43:31 -0700 (PDT)
Message-ID: <c3c01f2e-9070-4603-a5b2-9b404ab2b94d@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 12:13:26 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: qcom: add compatible for
 IPQ9650 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260731-ipq9650_smmu_binding-v2-1-143a51c8ffce@oss.qualcomm.com>
 <20260803-therapeutic-coua-of-judgment-5c6cdf@quoll>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20260803-therapeutic-coua-of-judgment-5c6cdf@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPJykuvH c=1 sm=1 tr=0 ts=6a718a15 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=tA7aZXjiAAAA:8 a=JfrnYn6hAAAA:8 a=e03i7Ra0A83BTa4Xh-cA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=FO4_E8m0qiDe52t0p3_H:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: wLFeerUY78KTmPFKPdtj8ilBgPY8iQ0q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MSBTYWx0ZWRfX9VquGfabtXip
 HGnuIDV5tuRciXPx4tFN/FQ6lrn7LsN9dON7R52qB/rXiVScDrGBWHRRwpPncpg2NH3npioQPj9
 8KiL6ArVtb2uPiFOIhhnsl1K2ZYvZu6g7OLvuqk20OjN7bvwZ2Yxdv1wXIj0V5jd0aR9BKS2X+t
 YD+GZL+gts/lAuo/qqu6VJpBxsbXNnsbO7VP61lQybRCzPk77UC8O76MavtTfUDp0E70Coxer/R
 852n5pl3IC92A3B/6DfynGss8chWmIJviO28zYTyfMVO5IcS4omt15pdvd7Tg2piCcrfKQx0kOR
 ND2aPSf99TgoKyW1v0K/OYgn5loqp0AQDd0RASaDw9wyLXjVMJjXeQF5dzCJMMZVUaTHihAfsZR
 8KU+dYO6HHokzEEmxJKhokxdvIUQC2ZMkO3T5XStuZX0VnbfLB1S3ZALwWQdCczIKWizbGFmVKj
 zGuAQWVVXmdt6MWBGCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MSBTYWx0ZWRfX3YLi8Yioutrw
 TH8jUuiI6dU3Q0sbD8+N4AnGFtg9UZYxKqGMieDMGuqTbEtjc5AGI8G1Im8MgorB/LjAOdXpq8c
 rsmXtPKspCdm8yliKVCrcl7dx2QZwnw=
X-Proofpoint-GUID: wLFeerUY78KTmPFKPdtj8ilBgPY8iQ0q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040051


On 8/3/2026 2:54 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 31, 2026 at 11:01:26AM +0530, Kathiravan Thirumoorthy wrote:
>> Add the compatible string for the APPS SMMU present on the Qualcomm
>> IPQ9650 SoC.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Add the proper constraints - no clocks needed for IPQ9650
>> - Link to v1: https://patch.msgid.link/20260512-ipq9650_smmu_binding-v1-1-04defdaa140c@oss.qualcomm.com
>>
>> To: Will Deacon <will@kernel.org>
>> To: Robin Murphy <robin.murphy@arm.com>
>> To: "Joerg Roedel (AMD)" <joro@8bytes.org>
>> To: Rob Herring <robh@kernel.org>
>> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> To: Conor Dooley <conor+dt@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: iommu@lists.linux.dev
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index f2188942f877..ffa33b7f4a96 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -38,6 +38,7 @@ properties:
>>                 - qcom,eliza-smmu-500
>>                 - qcom,glymur-smmu-500
>>                 - qcom,hawi-smmu-500
>> +              - qcom,ipq9650-smmu-500
>>                 - qcom,kaanapali-smmu-500
>>                 - qcom,maili-smmu-500
>>                 - qcom,milos-smmu-500
>> @@ -625,6 +626,7 @@ allOf:
>>                   - qcom,eliza-smmu-500
>>                   - qcom,glymur-smmu-500
>>                   - qcom,hawi-smmu-500
>> +                - qcom,ipq9650-smmu-500
> This will disallow clocks also for the Adreno one, so confirm that it
> also does not have clocks.

IPQ9650 doesn't have Adreno IP. Please let me know if I need to explicit 
about it in the commit message or this is fine?

>
> Best regards,
> Krzysztof
>
