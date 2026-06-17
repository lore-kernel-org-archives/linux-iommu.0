Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98924B8DE2
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713955; cv=none; b=RGMuQoCoBLcKssws361uv9ohD3sWXEPcXJudz/eUSOVmIxhbObLciLwhOXMMnUq1KSSX7ZlXRyugAB28OkUddyNcAJPtdOnYf9YDCkCxbdVJ0IQHtI+DuQ0MAu6k1m7qfjToel9ILXZFPeb+tIJIsZQGyQeJ1pzaDaUL9o1luQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713955; c=relaxed/simple;
	bh=jz8icgNkivpi3ZbOutI3ya4laMkl7WzQNxajxvR72zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFKZeubUccnLM3FUiFXr77/ktirhXT7/puKYKhytB/fn0r+vF7eORBHL5z8f26Pjq92aMuhdulW9kqa0JEvBrqoSxOaasRoIW9pDA8sAgN27e6INAWoaRO91x8Am/mDc55joMCiWMquPtyZl2n6bCbY8pWZssPEwSloh9DGtJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FVpm4RLh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XDU56Yr5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FVpm4RLh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XDU56Yr5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HFodXs2697396
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 16:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tDODFxvqjMAAbOWBcbLxnUN/zpkolakDgolvYWIF5VY=; b=FVpm4RLhwTJ5UyC7
	B6ZGjcXa2vAgMJ+e8iK7oJvmAAqYMj/eZMOaamwFRLMl12N5FkOXZvFP4Mlp1Ajy
	x6bwywCR6e810IfnJeqOF/JG4xSZErFagttXbb78rHgDxQQIag9OmUmlk1YrlXYP
	kvPzr17u2GI0bNWkxo/Sd+lSoyF5Wy0f4QmLN7kXlraJ8weXLfKW0ZG4dbTi5QCw
	Khy2/MkzufgcxzYGeE/fkpjvVsoexrFnwKkauDqwx1sOJLiOL2jtXApBr08HgoL6
	Lysw52Cz5XlOJ8GxYoaLIvslQKM+HmuRqp/nviqEEHzfcIgyxJ4BTvNZBbJS0f7F
	QZ2D+Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueet460u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 16:32:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c6bc237b5aso151155ad.2
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781713948; x=1782318748; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDODFxvqjMAAbOWBcbLxnUN/zpkolakDgolvYWIF5VY=;
        b=XDU56Yr5FuO+YuVeYvZFjvzsyw593SFcRgu9KihsCG8gEG3MdrnTdUlUiFtCpkC9ut
         tZJ4N+NP2N2QHUImgu4yCtitTn9gjcAuOQd5TVMAe3/JX/M4+/Mdd3QSxEkS1RSKpFJX
         PlrMctvXEnWBSRxPw93WS18D3gtEbWEjr9gvBWHCI45KZc2LifgsXiQnr8SoLnLW840C
         G3xOC1GICBxtBlFYadx8M3wFek7MrMGz3P8dvIFnoa0r2sS4udJFicjgud7ucD6zzAcO
         166hLBbMnagp3M5K8sSeYB/eFvvSJi8Tublse5kh7kpTDfJ8ecFPTb00mUtKIQQtxwxH
         oDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781713948; x=1782318748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDODFxvqjMAAbOWBcbLxnUN/zpkolakDgolvYWIF5VY=;
        b=Sz7xE8O5ZwIWweoGbzbz9TVYjvJkPP0buh9hwyNkDHajtHdUSUk8QbmYN6iCKF9ozw
         t08IX7pMZCYQenW+VJ82LWPqIu1gtqfIMFdvvALlhB4Spj85eQyV2B+AAA2Em1CNx+w+
         OaxYYrZAeXZQoectkXZ/oz9AwxRWAL2uFvoZcts6uJ/QYQLCt15HkYatGSKAR/bOfPYJ
         XpMtArzbeNhYtMj5qwS3x3hLQbEPTxmcFRfHvy7TKkLinq2CJmg3zZrzMXcpl3MK/HHK
         eDHznC8tc64RCgRjC8rTLn2kXSaMU1qrCVHAOSRSmep9IBRl9adArCaK4r+Q4v3ODu91
         5mwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Jq0MnM3eMFhBOnweT1dq7I8Znybp60arWg0Vdes7h/I3x+bn/C5nzhDZ/gFZT5h7MRGLPHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPiBYWLzzZVfb1o3ThHT28ySSXkMZmi32wG40tZtQyZZ/OEhtV
	IiHhFbrUksXby58oT36J3+Y6OgvUTKxjhvZJpZD1DNxGgqKBUQ35Opcw0kcd/CXz+oDcvMmRNBj
	nwGhIWb0X1VXJfgNWTn8aTyvFeGXDhGAna97W7oSmE7dKYVwup41EGJkJ/A==
X-Gm-Gg: AfdE7cl98DyrodUF8r3+D8RaM6fhQNJWgBvULGQHQZyqSy8UsUFiVch+6euXEsgFih3
	0896DLvkCWz2HnmCjiGjNww8oXjympPKkvtEBl2xqWQ51/QLY8Zwdq/rbfJTXc9f2RPFM45/dS3
	TUSqyhCcQntg9XUWml+1FMnw+ocP/mF+s40nadgeVXQWWEtAnoQ9ijtfSwJBGoA8zRngS7v8RL6
	mvcnMd718t/EsknQcFd5rikN+72fp/oNQGhkM1soHh6vLmNwvOKuTIn8crMnvt3qFWEd1AvY8Ma
	euaG9YTu/fU2S9AJyl660ZBnEDUALGlWcrtD0N1c3MIvPPHK9jLEUA/A+F3oVC4OAf7oNBRHnmE
	rSxXGS7LvkPv9J6xiJQQPggF3A2AdPWurnukFRaI=
X-Received: by 2002:a17:903:3806:b0:2c0:b35d:ed49 with SMTP id d9443c01a7336-2c6bc09a06dmr48129675ad.2.1781713947990;
        Wed, 17 Jun 2026 09:32:27 -0700 (PDT)
X-Received: by 2002:a17:903:3806:b0:2c0:b35d:ed49 with SMTP id d9443c01a7336-2c6bc09a06dmr48129125ad.2.1781713947448;
        Wed, 17 Jun 2026 09:32:27 -0700 (PDT)
Received: from [10.219.57.228] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6d637caccsm7991475ad.20.2026.06.17.09.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 09:32:27 -0700 (PDT)
Message-ID: <984ff9c7-3eef-463c-a330-bf7acd063667@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 22:02:21 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
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
 <20260526-smmu_interconnect_addition-v2-2-2a6d8ca30d63@oss.qualcomm.com>
 <7xfxlxfqjcqdzl6gckaoyy2ioefglc7bgi66yv5khrbl6fi2zc@ivtiukdaj4jv>
 <8518a085-b8b7-4ee6-b08c-8dde3971a6f1@oss.qualcomm.com>
 <2i6yzwu2yk5bngq723g75yeqzeg4ihvtbuydzunceltl526tjp@vnt6nmxxkfut>
Content-Language: en-US
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
In-Reply-To: <2i6yzwu2yk5bngq723g75yeqzeg4ihvtbuydzunceltl526tjp@vnt6nmxxkfut>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3dPWv66Fi1obHJ-pY5ExhXA1JIYdNHgE
X-Authority-Analysis: v=2.4 cv=JufBas4C c=1 sm=1 tr=0 ts=6a32cc1c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XunzQJBhBzqSrgwI8wIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 3dPWv66Fi1obHJ-pY5ExhXA1JIYdNHgE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1OCBTYWx0ZWRfX5d5K9iIDs0mk
 emdM5BI8EZjyYTut3sW2eQFEG3nNDHG0rB19Iz8cHw80C6VirghywRs+16jMlUF3x4YkEr69LDZ
 Ij4D9wKOKuWa2qjIBrP9pONv0UdEkA9tqQGoS85emjwJoxSTLp9LVyl4OVvz/NuUUYotS+aBdxd
 yq3fnvWnQynxfNOqrmY7nJ7LAw+Vm0/gQGNZlPhp2wDTnmhSoflXcsshqQICU3ZdjHo0mWanmKE
 72A4NsZfnIGrF7b++0zU4EdZjjcI3O3r7sxVbnkj4YDYskCi06dKRwfdI1u8pMJtOgWVrdL4p3y
 JMuMrAH08DW52OsAA/GhoiG+/B2Wb14cUQWmutDL5oO+RPsRJjjKzySxINI4VJieLuiv0LlOinD
 711oLQUd/qg38Mo5n9Rh8MyUs+nUn0LBB8pnQc5HzsFW5znLf1ANPc2mYrnIAVGLj23Y0lN4U1c
 UHV+n/BpNbsbndZt/Gg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1OCBTYWx0ZWRfX5610zO1EOH6W
 PJcEwznfwU66/9FBqaNKEJ7gS0BZaGpv45+T063WlOmHPUZtgEEIrRayEXq0S7d1+rp8pyS6hQs
 sshDI9aXtR0yQ7R0tGQ0Z1z8D0Nu7QQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170158



On 6/16/2026 5:52 AM, Dmitry Baryshkov wrote:
> On Mon, Jun 15, 2026 at 06:55:45PM +0530, Bibek Kumar Patro wrote:
>>
>>
>> On 6/8/2026 7:25 PM, Dmitry Baryshkov wrote:
>>> On Tue, May 26, 2026 at 08:12:03PM +0530, Bibek Kumar Patro wrote:
>>>> On some SoCs the SMMU registers require an active interconnect
>>>> bandwidth vote to be accessible. While other clients typically
>>>> satisfy this requirement implicitly, certain corner cases (e.g.
>>>> during sleep/wakeup transitions) can leave the SMMU without a
>>>> vote, causing intermittent register access failures.
>>>>
>>>> Add support for an optional interconnect path to the arm-smmu
>>>> driver and vote for bandwidth while the SMMU is active. The path
>>>> is acquired from DT if present and ignored otherwise.
>>>>
>>>> The bandwidth vote is enabled before accessing SMMU registers
>>>> during probe and runtime resume, and released during runtime
>>>> suspend and on error paths.
>>>>
>>>> Generally, from an architectural perspective, GEM_NOC and DDR are
>>>> expected to have an active vote whenever the adreno_smmu block is
>>>> powered on. In most common use cases, this requirement is implicitly
>>>> satisfied because other GPU-related clients (for example, the GMU
>>>> device) already hold a GEM_NOC vote when adreno_smmu is enabled.
>>>>
>>>> However, there are certain corner cases, such as during sleep/wakeup
>>>> transitions, where the GEM_NOC vote can be removed before adreno_smmu
>>>> is powered down. If adreno_smmu is then accessed while the interconnect
>>>> vote is missing, it can lead to the observed failures. Because of the
>>>> precise ordering involved, this scenario is difficult to reproduce
>>>> consistently.
>>>> (also GDSC is involved in adreno usecases can have an independent vote)
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>>> ---
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++++--
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
>>>>    2 files changed, 57 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> index 0bd21d206eb3e75c3b9fb1364cdc92e82c5aa499..07c7e44ec6a5bd1488f00f87d859a20495e46601 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> @@ -53,6 +53,11 @@
>>>>    #define MSI_IOVA_BASE			0x8000000
>>>>    #define MSI_IOVA_LENGTH			0x100000
>>>> +/* Interconnect bandwidth vote values for the SMMU register access path */
>>>> +#define ARM_SMMU_ICC_AVG_BW		0
>>>> +#define ARM_SMMU_ICC_PEAK_BW_HIGH	1000
>>>
>>> totally random numbers, which might be different for non-Qualcomm platform.
>>>
>>>> +#define ARM_SMMU_ICC_PEAK_BW_LOW	0
>>>> +
>>>>    static int force_stage;
>>>>    module_param(force_stage, int, S_IRUGO);
>>>>    MODULE_PARM_DESC(force_stage,
>>>> @@ -86,6 +91,36 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>>>>    	}
>>>>    }
>>>> +static int arm_smmu_icc_get(struct arm_smmu_device *smmu)
>>>> +{
>>>> +	smmu->icc_path = devm_of_icc_get(smmu->dev, NULL);
>>>
>>> Is there always only one bus / path in question?
>>>
>>
>> <Apologies, missed to respond to this query>
>> Yes for TCU, it needs to only have a vote on GEM_NOC interconnect
>> while accessing the DDR in downstream path (client->TCU->DDR), which we are
>> addressing here.
>> Hence it's only one icc path in question here.
> 
> Again, you are describing Qualcomm platform, while the code part is
> generic.
> 

ah yes, single icc path is specific to Qualcomm platforms as of now.

As per my assumption, it's possible for other vendors/ARM-SMMU users to
have one or more than one icc path to reach DDR in downstream flow
(similar to clocks).

I will revisit the logic for icc_voting to check for possibility on
additional icc path as well, so the generic code can cater to other arm-
smmu users.

Thanks & regards,
Bibek

> 

