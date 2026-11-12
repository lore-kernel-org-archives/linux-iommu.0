Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490853;
	b=WYQFDOcPtzfOKrwM8YEb1+tJk9kRPcVFgq5S9RVsX+RDZL/hBGsl6OTfm4yXuVVCGqxb
	 5ScA63ZbCUC5wYcmn0AHafoTvwI7Nr5DolwvcO1XiDt99pA1xHfVlBPoyWqM4AYArasnd
	 rVZUa8+DEh/CLUQl+3JyI5m2iFPC5GFLGXD3Hi4tWvjQZe0I9Th7D7RVKxVnREj9yF/bc
	 SVFRXKlPCz2g76Tu+nHwNXIXZMss3Uuydq+JalHOk13JfEsKugeHEIDxU63YR9db7ZJKs
	 t+Ip1+ZXeVmkdscgTNrQTknFjqgsG5lcqC4OUkVZ1GFoy1djCu6SvIQAG4T/5xXEY9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490853;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=;
	b=YZN8oZecd3rDkiDOFT37QKDkfrANW+r/4SqOykmnYyfUGTc6OaDW1qIYJ0q3uigV5QJE
	 r6VYGb13aw/fdVVU//cC+gt8PuuRKrO+URch+Wu6osZGAzfTP2k/0iwND/J3Dhxo2qOEd
	 yHBcSU3NSYPBFnNH964QBq+X22zz2Wlp9sak/fmvHZYVsNEhJ5Tlr7nhA+8xpurwWtVmT
	 GpjImjWLACLrInp1du+qDfvO3yMUdRCO2uebYyQlNaSLzOGrItd6QoFdvfVIk/EIpKS5C
	 H/kTKYg+FYPXN/8/ud275AltUnrdVYekHQUpajBSPTcQDV5uKtuZi91EEB2Jh+5LAsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MXJW4p4q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RRt3s7Ol;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F84606A883
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 13:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F84606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MXJW4p4q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RRt3s7Ol
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC7iupg126100
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 13:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=; b=MXJW4p4qCPwmk/Nj
	siwIg8CGYz4mbx14lK8b/4E+PnycciVQXlZJAZ8KGyrp72XmYPlT6XINOryUMlVD
	nDORnlOrglRbxPRrD8Ce94CVNek//0daPypSbJ7FrPd+8429gRKZ31NGBbZDFxDb
	CQt1dWund3Qs79JYMVks4RK/cbVJ1/caZ9wFdGJgKC1/BXyL6IZ5rat16Vwp5mnA
	Ec60Smk3bCyg/RuP0INway6N9K9eppnWti6IFvRizqfIFbF5MzmukU1O7+1fLGpe
	z5VKzpKHuTBX5By+fOfQ2f41A0wbe/foYCdXKRmuYzDkNkPVbdMbfQsP3lTXjq54
	YLAyEA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a097tt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 13:40:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91ec0ed4af9so12237216d6.1
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794490851; x=1795095651; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=;
        b=RRt3s7Ol6qkg0DQzIBVASk01x0cROBANeMzFD2S/H7Y/WU09sc1ajOblzd8tygp02N
         LVUlkaq2N7N/Z0qskqim45FmPdM0yFTR9cME7dYQ8mGeACLkmbF6SSX/DxJuuHBqvg0f
         Ozz5St9AuY3stMB8vhBmxAJv7ZBcRWaOIXpGxuIBtWeF10R71eArWPw61qDRAzp8MT/T
         NSXOdipVyBBrRnZE2UyzH+43+ZzasbU9mVJiAA5YBgpjO5UvmOTR9v7UYGRC0UU3TA39
         MAw8KAtdBB5niX5I8Uj7iWic0tP1N8xTWA3CkVTrer6H0Q+z8EQ+8UwlTImE0aznoymZ
         TR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490851; x=1795095651;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=;
        b=OQBWlZzFVzEq5/kXV364dQVutnySFxx3e90VFaDBq2mFUHrVB0QmGgMUZYrJil0ViY
         i8MjYU6i9PTz98uD5ez7LBPzlh6yb/9DFAM6J1bjgKSgGTg9Cqo4zeS9SLiBrCQuqUvY
         Er+BnyQH51L5d5zt7UR5p94KiLAgK2CbgeMUsviNaVHrLTBigTpWn2erwTCVXi3PkB5m
         kL2lh2UTFo+4Nq2nILi1V4rnGXitunDBrNiNYHI+goI5W0z+mKjPrwL5oapcMDUViDby
         rIvR+f33OEAHSMi6Z/XFK5tmMYiiIaslMEsM+WOAdkrBiNaCcp3ERRz/HTjuXCj6NolL
         cpjA==
X-Forwarded-Encrypted: i=1; AL+hErGVdk74KFTbAJIkjKWahXE2qqSrq8ZRCzlh+HET2VzFBbUxx/GaOYpQJ1mbWmAfz1VAKSfyWw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+4y42noCCAueYG0ZUASOmm629oium1+fKfyYoVuu0HuxrmAVEA
	CXbWDSteZXyEVSDV5K7NavwhSh8ipHxvw4pa2C9k4tGOPeq5xi1BdYUTQc1F+3R17E20zLbzEbN
	CPSV/7oAwFnCUsIaJfz1AAvb1W28R5c1p5U1P3o8LmY5oEoPGy3d+K2ILaw==
X-Gm-Gg: AYBFou0pTfBHZuTYHhShXVrx1uSl9W/SArc0bwB40pN45ODQ4Uw7rV4Ga5+Zrp94vtS
	8PA3X7RaEyWQRBAGslnOjp7ZV1GwCXpGTD3Of31I9fNTpaOWr5cI/VgKCJCsDwhcWiqmvcHC9nt
	1OJMR8mjEfXsFPedg3+NCqAc2a9JTPI9g7Ducrb9lqr9jfJRO+J93ibBZegrbiQIDsxr7+IgqH4
	Fg3kOVp1751jnTovgsuDCzv+VxqrEuTWEn7JJccKTCDxir2DhXLdLF3+nWwMua+HT/TLL+fcjyN
	Y0IkHaYi+BoZxQZIryE6FRcLkhzIVdOKgEfn9eDS5y5r7ViR5VSYd2qRwjOn3nIHHDgc4kyymN1
	dkxBoc9i0W60GREDbvq/1zuAAXobIyKO+6E20kEjpDgb4j3I9i6kOarlKG5FXMwFeiPx6foO+X5
	IYoyUy
X-Received: by 2002:ac8:5d8f:0:b0:535:b545:e926 with SMTP id d75a77b69052e-55956e5d8a7mr45380951cf.27.1794490850603;
        Thu, 12 Nov 2026 05:40:50 -0800 (PST)
X-Received: by 2002:ac8:5d8f:0:b0:535:b545:e926 with SMTP id d75a77b69052e-55956e5d8a7mr45380501cf.27.1794490850119;
        Thu, 12 Nov 2026 05:40:50 -0800 (PST)
Received: from [10.206.104.93] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b942e83sm74301171cf.18.2026.11.12.05.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:40:49 -0800 (PST)
Message-ID: <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 19:10:38 +0530
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
Subject: Re: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel
 <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
 <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Y7pcto5ryfbUa1HfSpGT3TqcpeeK7qKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX3btoIT/NPJEZ
 NMX/zs+LoZeg5Whn8JYPt+yoZhGLE5vQ7JRHNAmulYkcP0EkhZffmH9JZ0IfY3xPq7DYto/Vl4u
 IqOCPgdk3K+7XzTf2tjtWKxXCohiH8HGWKj1M9LBo501ijM5n2bGrGpnQ3XjU4SuVWTpfF/GICE
 54+FtAaJ7utsiWqO7ntBbS9B4b4ZDV0jxh2JTI8nUKwZC1ol9KIEu/ASqmXa91+Fqq3ggaZlIMG
 gKL3vTkdnSVBJTGaZvVA684KYVREVYdM0iIS+PvuNfFjtzVfJjO03eSO2Ys9g4WbdrXXTXf2h4p
 b4HdYeRvzQqKsABeHDNgXuDemDLJFBO84XBP7hVXzQBqarFmFz6K0wdUEF+Tc01kGwVcIkNsw9I
 EfuLwtXyrjbqqTR2ckwjWfg51tPoDd9KlY8I7bEjOZbbarvI3I+bZP1ejBPg7dLUTy3FUF95uJr
 h7LUqe9ScRe3aW7GTvA==
X-Proofpoint-ORIG-GUID: Y7pcto5ryfbUa1HfSpGT3TqcpeeK7qKf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX63HiwGbOf8Dw
 bNgOi78DpCcgOXI3BVITLC7lO0XcJfRNPMSooAv0imzXgXtHZIc+3XW4//8+FaOFqeX90I/jNGb
 A3Knay5nE7nTvHp3WcomOmeTTHNf57E=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af5c1e3 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UM6UlptfRCpVODDSDqIA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120054


On 11/11/2026 6:33 PM, Dmitry Baryshkov wrote:
> On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
>> The OF_IOMMU code relies on OF address parsing helpers, but the
>> dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
>> of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
>> annotation to handle configurations where OF_ADDRESS is disabled.
>>
>> Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
>> preprocessor guards and __maybe_unused annotation.
> 
> Why? What's the problem that you are solving? Why is the current code
> bad?
> 

The commit describes the problem as "The OF_IOMMU code relies on OF 
address parsing helpers, but the dependency on OF_ADDRESS is not 
expressed in Kconfig"...and instead the code had checks for config or 
__maybe_unused for cases like sparc.

It was discussed in prior rev
https://lore.kernel.org/all/20261104160346.GD3951195-robh@kernel.org/

Regards,
Vikash
>>
>> The only architecture supporting OF without OF_ADDRESS is SPARC, which
>> does not use OF_IOMMU, so no functional change is intended.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   drivers/iommu/Kconfig    | 2 +-
>>   drivers/iommu/of_iommu.c | 4 +---
>>   2 files changed, 2 insertions(+), 4 deletions(-)
>>
> 

