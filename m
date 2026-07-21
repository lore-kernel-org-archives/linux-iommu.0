Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493F73BBFC0
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622127; cv=none; b=EzFfFrdMglWw1XUGOQpzKoGraJYaksD8jYKksSSVETQD/v99yARxWLbliJ8Lso7ahZzp4MFoalIGvjtpQtzA3+0BagdWDCQ94DEREuiUCUDjG8PmK+olBn0O1FiFO2MZ7i0XyF8ubyYQKvsHKcZdMPNKYBmprzEzzHOb9N8zeO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622127; c=relaxed/simple;
	bh=mWumImnjUwOthCVE8QyyeWC7j1UDvdRluhSgXrAoCjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaCTMdhnq1WCSJMvsxLkb8UTlDBWI5U0Ecuvw/JU2ZcoAnURRtnHB7wUQjBz616yIODEnl48rGpfqvbbMkp1NqglIDrBcOmZbt8uFaOZ4pUO/b0mXYo2VTsLhoSoNpY0SqTWHXbKVWehyCWLXFafjYeuCTpvCwIlyh6FtxFZV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R0JoYaJJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jPIBtWUK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R0JoYaJJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jPIBtWUK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L6JxQL3884231
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 08:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KsWcVMJwJ2v5K6dzKusBzpR5lVUpfbb9D8XZrMSTi04=; b=R0JoYaJJBWBswlFL
	bDt96RZe/Db2JSAkLola8cMVGdYdnVlLgA02vGpGIntAOgfxcRKYH/L8ChPBX74X
	MXReYeJ8erk4qCDYJCh+FACaiamNN60GQlFCorU4OKfFgnVa/mYEGR2n+0CTCx0h
	vRz5Uu5HAUfNoGhNyh6Q/AVA7a8dG9Unatm6VGnHmVkBT2veQM+N4xl+5wcYtse2
	pTMJRXOOTg5AnxA1ie/rZSvGAi1o+mUATnNo27GNDblSIvWfS3mUesJggZ0VPnsz
	O5KYuyZ5iuhj6/FepSnATG1lPaT07RcHQbozmOUzfoAPX4SvpBrKUQfryiCP7m9C
	brcUIg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqvcb7hh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 08:22:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cceabd70f5so213784385ad.1
        for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784622124; x=1785226924; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KsWcVMJwJ2v5K6dzKusBzpR5lVUpfbb9D8XZrMSTi04=;
        b=jPIBtWUK1k7YlFfCldS1sOfV+UQ3R4H1rmG5U1/hA8/yS6P4DJxheYV0NLPnrQwg53
         1gsKQqkAmdmGzU2ZEGTcvmWlohC6BQMFJFzcrUZHgYDQa7tFyzoHoT9aq3jqKQVoVu1O
         q61WXobIj6EFnVAjFBaNqqqLXIEsJZOENq3v7CgeqazaihZ8DiXRMatX7EV8KelIT5Uf
         SBYIqo5Ke8DNtk7x8/jwcCo0it/IfyivX36e1BBLOGxVGLVpcjqYYy4nBxBSXj1tkv0T
         sib2PxK5ndm170deLqJ08rUSKOmvew7eoQf9iuYhtArMk5mvyU9baRKoxkr/F+vRcP1l
         IWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784622124; x=1785226924;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KsWcVMJwJ2v5K6dzKusBzpR5lVUpfbb9D8XZrMSTi04=;
        b=KtXpUcFT0gQUCDeOTZQI7Kzs5KkplZqV9SETx8XNviEXXleRjAlNuWjwgDNXqwdVw/
         aDviKfcmSNz8CAQb555oDgbNeeiDYNeLrG5eECXnBZwZ7VzSXJ11NO/LhO37iVeqx4Nm
         FgVzN62ybW5mmxtgFrFt+eS4RxFV+Go5mBLFz4D/hiybYJ8ydtITj+6yQ3w86bQr/ODV
         o+Qe4J8iSoeGKrPHEZPxzVfRPfyY+WZxh3AMG2txkWs+CaMfCr1me90B9D6sePjnSXOD
         mXUZQHK5oM+KWhFf3cYu6thrG2G1OkbGHjBHTOKUhyrGWQlnf1yW82B+xZ2TKowHfohQ
         299g==
X-Forwarded-Encrypted: i=1; AHgh+RqlyNCQz9+AnQatIl6Xslc6dtjEAxDptJ0Znvy84IkkCcaxXKRJg45TahnHtx3Wq/MMXoI01w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHSlixQ+Z0TKdRNuCqMa9pln4goZNHbvqJAhNEeonrh2yEgTex
	NgqJzI16WYl4DC1wCYxNjvtrZ89Nv2Neseb+Tq15ppUKmaa2M3eyAtYyVb9tL7xd5q5eDdF1MiR
	xPaK/M9w/iDSCasBY+EgZ5eShsM0NxedeentWnQJDGyaP43jSNIq3ejzZPg==
X-Gm-Gg: AR+sD13ldVrZCn0VcKqeaI3XY8MGgA5fNlEXWtTffd4Form0/iPq7AlMP495bmad7fn
	yallhBFPtPGdnX2hAa2QlxxgWQXtfr6pXDSUqu7BWk1Zvq4+4GAIZmUOSvX2mFbxk5c47G0Ewh1
	yLCQULU/L/If3G6Ytc6PP75kw9qgFNa21TLDdWom1Jvd2O11uGi1YDTK6bsdwYA29AOb4bq+BJ3
	BWLUN4EJMmJWTY6HGYZS8N5wpEGi9iJ/qXtWYfkTS0GnDs3rX62lkWtqGtmAYUTOSYtEETiSD/+
	cV181gekTOn40gefj6rF54dUdgNv1oxTc4SyQaQ7Bgc6FSsaWSKLZDEVQtMARPKckCPqpKcDcYb
	bmNxNziBgS7bs9YJ2BglMvEWebtn76D87PQ==
X-Received: by 2002:a17:903:37c5:b0:2ca:5d9a:ecc6 with SMTP id d9443c01a7336-2cf3494af91mr190418435ad.28.1784622124125;
        Tue, 21 Jul 2026 01:22:04 -0700 (PDT)
X-Received: by 2002:a17:903:37c5:b0:2ca:5d9a:ecc6 with SMTP id d9443c01a7336-2cf3494af91mr190418205ad.28.1784622123656;
        Tue, 21 Jul 2026 01:22:03 -0700 (PDT)
Received: from [10.218.39.50] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3476ba24sm70079565ad.75.2026.07.21.01.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 01:22:03 -0700 (PDT)
Message-ID: <efd5167f-48bf-4dba-b968-d1dac65ccfb8@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 13:51:30 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add support for contiguous hint bit
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com>
 <20260703161228.GA1948451@nvidia.com>
 <b7224dff-7e51-49cb-8421-14d090492dfc@oss.qualcomm.com>
 <20260715113913.GA3775915@nvidia.com> <ald3CuddY6I7gml1@willie-the-truck>
 <2ce09e84-c57f-4087-9dda-07245fadfc02@arm.com>
 <20260715125039.GA50536@nvidia.com>
 <d20d258d-d970-4ef1-bbb6-cdc83fc20c9d@arm.com>
 <20260715180949.GD3775915@nvidia.com>
 <787fa0d3-c1d4-442e-beaa-91a03238f511@arm.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <787fa0d3-c1d4-442e-beaa-91a03238f511@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NyBTYWx0ZWRfX5MH74S5Ez8IM
 N7pU1eXwor71Rbgr9X4my6QxJ9g6a1Dy+dS52kqlK2AyuoJX/wJ7cwPS59EWrxUtNIbNelUClKA
 xoSZ4NvWxjN+98ax3OOhl8zQfW0YJNg=
X-Proofpoint-GUID: DDf_uTHIDwsce2geZYHY95z_PusKPLSq
X-Authority-Analysis: v=2.4 cv=OMYXGyaB c=1 sm=1 tr=0 ts=6a5f2c2d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=sSvbjkl6__CUZ7MaMMgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: DDf_uTHIDwsce2geZYHY95z_PusKPLSq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NyBTYWx0ZWRfX4daN1AKiIwL6
 2jKCZYB04WGpVW87iGWwQSMBJuRLRArDpE8DKNxM2GQkQLVYIO07mqEqVT8YPY4oP/9YqDkZj+z
 aQbLb6ZhmJFYYlqfZSfjtHZjoSIj4CELGXO4wspxqAWf5ODa8fl3WHvKYU1NP222vYilzGFl/uo
 068cUm1bHh12md3bY0a2/rH0RYfs3S9JuS9VSgJUH3Qg51lCFjzpHIIAGN53MPb8pHbcup1a5EO
 LCFlo3gKJ6SCG6Gohu3Ect1YPe+KpueTwiQHQY2RQDl8yrQUm/flfUjzjQFtURBr2ieBG5bBayn
 BFlSkO+Q5QZM0LdF4IfHjPAGSZC8TYMsBN+pjIPjNgxYKpKgTVreRHyPtieq733lRn6nx6VHwz/
 ZBUhVlQfRmY6hiQYB1jS1/7v4K3q8xMFLM6JaNu2iLfGMIvTEF3CKLBZr9rGzgDnTNoiA8WAi+H
 BxqoDCnRTWIVonYLQxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210087



On 7/16/2026 5:29 PM, Robin Murphy wrote:
> On 15/07/2026 7:09 pm, Jason Gunthorpe wrote:
>> On Wed, Jul 15, 2026 at 06:45:09PM +0100, Robin Murphy wrote:
>>
>>>> AFAICR the biggest issue with arm-smmu was it using IO_PGTABLE_ARMV7S
>>>> as well. I think it would be fine to implement all the unique LPAE
>>>> features it needs in iommupt, I did most of them already.
>>>>
>>>> I do have an ARMV7S implementation for iommupt, but I did not solve
>>>> the sub page problem. So while it is functionally working it is not
>>>> usable since it wastes so much memory. That's a tricky problem to
>>>> solve since the algorithms depend on the gather->freelist.
>>>>
>>>> I didn't spend any time trying to do anything about this as I was not
>>>> intending to touch arm-smmu
>>>
>>> Indeed between the irregular table sizes (before you even get to the
>>> Mediatek shenanigans...), and the awkward GFP_DMA limitations and/or reality
>>> that many of the systems using it really don't have memory to waste, I'd
>>> have considered v7s pretty much terminally incompatible with iommu_pages and
>>> the abstraction that iommupt is trying to be... :/
>>
>> At least Matthew has talked about having a sub page allocator with
>> meta data, maybe with the memdesc support someday. Even today we could
>> have iommu-pages allocate a companion struct pointed to from struct
>> page that was sized 4x so it could be used for the freelist.
>>
>> There are some other options for alterantive algorithms that could
>> work without requiring the free list. I had some thoughts about placing
>> the free list inside the data itself as a non-present entry.
>>
>> It is not insolvable, I'm just not sure it is worth doing vs leaving
>> arm-smmu to keep using iopgtable from ARMv7.
> 
> Yeah, if you did want to keep bashing at it, then ultimately there are at least a couple more short-descriptor inspired implementations in exynos and omap too, however at this point I don't see the cost:benefit ratio looking at all favourable...
> 
>> Otherwise to have arm-smmu use iommupt you'd end up with two
>> iommu_domains specialized to 32 and 64 bit page tables, with their own
>> ops and a shared invalidation like how the tlbi struct is providing
>> for smmuv3.
>>
>> It is not outrageously bad, but it certainly is a chunk of work.
>>
>> If the goal is arm-smmu support of CONT then maybe there is some merit
>> in doing iopgtable as a one off feature. But there have been many
>> attempts so far to add CONT and they all had troubles, I had the
>> impression is is not so easy..
> 
> I think now that partial unmaps are firmly ruled out and we already have the multi-page map/unmap design it should be pretty minor. I'm also more than happy to stop there, have dirty tracking, splitting/merging and all the fancy new IOMMUFD stuff require iommupt, and keep io-pgtable strictly for the GPUs and "media" IOMMUs that only need to keep providing map/unmap/iova_to_phys for iommu-dma or equivalent usage. By now I'd also say we can reasonably park arm-smmu in the latter category - while technically it could try to support stuff like nesting and vIOMMU (at least on MMU-500), the hardware is in embedded platforms which either don't care at all, or at worst where virtualisation is Xen's problem not ours. As far as I'm aware even the NXP Layerscape platforms are happy with the status quo of just basic VFIO type 1 for DPDK.
> 
> Thanks,
> Robin.


FYI, I've just posted v2 addressing the review comments from the
earlier round — it doesn't touch the io-pgtable/iommupt split discussed
above, just the CONT-hint quirk in the existing io-pgtable-arm code.

Thanks,
Vijay
