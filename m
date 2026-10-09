Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33048298CA5
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540597; cv=none; b=GY15D08iAbRkinqK61XDPwsnIQT6ZEJ5wCui6BICj4UGK2AjKYo65BcBLbacJ85DL74Q2zGTcCKQSnYagBqHCTU8kuu7w12eOvrAH0XYO/CqvM8yYa54SlRDX6YM6L9LMcQAbUdipysapWfSha7ONKH7H7pirp5/oLktQDrLT2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540597; c=relaxed/simple;
	bh=RojMG25mfLm/DZzwFxgu93kfVSJUhFHHMYlqpPJ+GL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFzqVlG6ANoJul6Afj6lQKap0EvpymqGOQw5deXkVkDAUtAPlDIXazeXxwY0BH35s9Xl0UF2Mf8larzHfGIY7Otu4hRaPKTuejhWtNUA3Th4XiaZ9QFw583AuEXYk3j52enj81QCzgVbwSOWjsBGl0AViFWbtAZVEMBDkdJb0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lSubTwXB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y4T/ZWK1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lSubTwXB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y4T/ZWK1"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KSUd907111
	for <iommu@lists.linux.dev>; Fri, 9 Oct 2026 10:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N+fBuMRCFeooJsUQbzMEzmXJA0656ALYkaVEwLsyNAc=; b=lSubTwXBIZExw0y3
	mCKZ5O4RcU+/WWJNznioXRJFmxmv2GrYHrkRjOa3R3q6tSX7A7IwWV72YHThbB1X
	BuThoo8If2omR1gAoC1f2v7eykSQhm0ccmnHC6i6CM47K9us4bBUeBOAjmN3eM4n
	GIGSlqKAfQ/9VN7U0HZSYpCQnLW5jXDly/MjbPKshHYSFObcG1UJ9C6dWVHcsF28
	80m3hnNpGuNXfSqOZ/B/RTxtQ49QS/WHvEGq3kXN072GEDoeM32Y1QN9NKKszayG
	IQB869AkZhR9JErwJOvj4U7kTI5QFl7X6qj6II8IRs6KHfN8EGJSNUQR7sqSSvj/
	wZfbLg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqu5ed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 10:09:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34ef0362d95so12858676eec.1
        for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791540594; x=1792145394; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N+fBuMRCFeooJsUQbzMEzmXJA0656ALYkaVEwLsyNAc=;
        b=Y4T/ZWK1NXVGTolsIL2n1RQv3viiNILkg+XxZm2ZafofQ6UxFpi1VYbkY/jZtqnAGv
         apCB5OP0w3e4YHushW2k6N/PlqExCvSgzUABc6ESah7seucsfNq2mc7VIBhM6QFaCNxM
         LsRTMa7YBdvy/hpJfdRgHZzSW4DxgKfe2kbNdndmIKErkj1fuB8f6eVKo4noR2du2UVa
         BUwdOSnEk1UU6YOr/0qkn/g18ube3cu1Ccw074Ibl6ZFfgKhGI4Rgnym3PdxCDdrrXXc
         to+3PgTNyMO62cI+x0DtJkyhDJDuCiDiWEkV4XT4LV4AaPbDkCYz+1f8iMAmzMeszSMl
         sfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791540594; x=1792145394;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+fBuMRCFeooJsUQbzMEzmXJA0656ALYkaVEwLsyNAc=;
        b=Oc37suItU+Me6vmauMF7hPAqTADGwztfqWo9cLUVRx+0jwIRw2HLabjjk4/ed1+7Yv
         L9Q9gAsHViDGA2vD3rlVRjOhnf+6/P5URYOawiGIzgTr+bJceBKDqdpA2q7C1mhQTd+7
         0AIPFReEH+HLNFQ/IPkqUqSzqBdf2hblM8asUnFoM0npOf53vYApBrkExeAmukSg/qqv
         FazN6ImASYiUSgS5TRiuMTl7fRUa7nGGto9JjnOQq5Qfg5E1L5159rx1uBSOiwoMQ8vE
         N9+d+hWa1/3CIK0cQyenUIvqxg3nssxXj7mAwtkS1sxfNalQW+4gbTcrZHjbHr9+Di1E
         4pzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxuZ3dtcNvsDP426maOB6vx+wQfGyIMN0k+2nKlDeSwDcdeGZEJk1NGl5CmWR0i+9ZsrB2nDw==@lists.linux.dev
X-Gm-Message-State: AFuF++nNts5z02wP8bl1CcQrpa4Wc74VA4Xz7TirS/lL9FYA+ZT8RZXa
	qElXYQqhbi09eCBKKUlf33tsGncW5QBOQpPniX7afVX7K1CUU2J6V3uLLA5LtJhMMFXNthwai6d
	29sfTN+eGKjl5FXxTaQt5GHh+hlJkB7QPKSMnsHOU8RNfPnbFkPjRrbgPIg==
X-Gm-Gg: AYBFou1TKsezqkXs4/Z9dldaDuWKAir9ZkJEna4n/FIzcjaeuTI5vdUbUAvVmPJUJZ5
	iejGU+wQO4I4LAp4Smc1FBbfeoO4o1PD4XYcbd1NRwem96Qfc7Nz0vlBTFrQtfcdvVj1x5GzD+X
	0v6N6DmCnDQjTNBxWwPMap0V0QK0q1wnD+Nd7C4JMiltCX8W2hP6xBBRTLsqtlzFlTKDqwIxuzW
	UaufrMJ44I4GrsNI9r2vTRnt4XPqN3qYtRD8kuzHp6UQoeYWtYtV+prkWbR+WGuphE/UY44g4kz
	vf/t+nDQ86XwDTO+YzDkUNtJI1Al7ri7SEJSVV16O6UnqBC+UekUUD15gvjK1fnWiKL5I+d6s92
	Bh6ucv2Cbm45fTR1H1t4E+rC/iqpqvVR6
X-Received: by 2002:a05:7022:3b87:b0:148:80d4:84b0 with SMTP id a92af1059eb24-16a60de2f7fmr2202197c88.23.1791540593818;
        Fri, 09 Oct 2026 03:09:53 -0700 (PDT)
X-Received: by 2002:a05:7022:3b87:b0:148:80d4:84b0 with SMTP id a92af1059eb24-16a60de2f7fmr2202142c88.23.1791540593160;
        Fri, 09 Oct 2026 03:09:53 -0700 (PDT)
Received: from [10.218.39.50] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1cc25sm7332804eec.8.2026.10.09.03.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 03:09:52 -0700 (PDT)
Message-ID: <7ab6eab6-ec6e-47dc-b387-eb380e2e365c@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 15:39:45 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
To: Jason Gunthorpe <jgg@ziepe.ca>, Daniel Mentz <danielmentz@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com>
 <20260924001502.GO1540250@ziepe.ca>
 <CAE2F3rCVh0CmW6+a__PcCrBgsMJVompKJX_qYBdQ=exj3bYtCg@mail.gmail.com>
 <20260924225340.GC16465@ziepe.ca>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260924225340.GC16465@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MCBTYWx0ZWRfX1jHk6L0Ww0Rp
 wg/9+1xjKGUU5kJxzjilsrpnCMfEPNKnftD5a1bsPjILadZz0slwq2qT1RQJByiFqLVFDKsBH3Y
 i17FWSrS3z/nfkHUoGhG0pZCkgIHUvs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MCBTYWx0ZWRfXwSiG7xkhuhNw
 6jgw5hDcCtfoiQWzD9Ug9/uZIOhlvXi7Pi2FMQVjH7wX6ZqABJAM2ya//Mfb8gw8USGCiNVdvVn
 vEGOj7qOU+DI6fFK8AYWgv/cy1wa0bRzD9vx0sEDmGx5aK+fNZC/F6DBYOVafH1C1JWxr2MFU/v
 tsNwtBuHV4r4ZSnB7oS1ZNlPTbjYtCgQ43Xqkx6+eT68stKWONN5yAArZ/SrHofh8HNFjhmKf2f
 bpe9xTMm2r6Q2lilO2bRd2UVqbmJosBON8aZcCTxTKQ35Ve6TTRAdcmYB1lOUu6xjf/eCvyFCLo
 vwbdsPW3yDvog7nr0T8R86mIxc5QIaVMimjwsdAPUSwZRFcXqALDWfRaRXfZkZactmpRN1nLxoA
 pm0MN9WfCOF0ShFy3ciieFsb5YxCUL83ENUqsE1jGGHFXguzhwuS4E2DmcPrhtUaxmK1cgvomcu
 +UFWpixKomku9dYgkyg==
X-Proofpoint-GUID: CYU-Vvwg88nJQVjCzRp08f_6AnjdlwTH
X-Proofpoint-ORIG-GUID: CYU-Vvwg88nJQVjCzRp08f_6AnjdlwTH
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac8bd72 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8 a=EUspDBNiAAAA:8
 a=YC-9j5RmPirwrlDSig8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090040



On 9/25/2026 4:23 AM, Jason Gunthorpe wrote:
> On Thu, Sep 24, 2026 at 11:49:50AM -0700, Daniel Mentz wrote:
>> On Wed, Sep 23, 2026 at 5:15 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>
>>> On Mon, Sep 21, 2026 at 04:44:07PM +0530, Vijayanand Jitta wrote:
>>>> From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
>>>>
>>>> Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
>>>> When a set of consecutive PTEs map a naturally aligned contiguous block of
>>>> memory, set CONT on every descriptor in that group so the hardware can
>>>> combine translations and improve TLB reach.
>>>>
>>>> Advertise the supported CONT group sizes in pgsize_bitmap. Callers select
>>>> those sizes through the normal page-size selection path; io-pgtable-arm
>>>> then installs the corresponding tagged descriptors directly. A partial
>>>> unmap of a tagged CONT group is rejected before modifying any descriptor,
>>>> so a rejected request cannot leave the group partly unmapped.
>>>>
>>>> The IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT quirk allows SMMU drivers to disable
>>>> CONT support for hardware with implementation-specific errata.
>>>
>>> smmuv3 has this errata, it must be disabled there too. I didn't notice
>>> it in this patch?
>>
>> SMMU is an architecture specification. I am not aware of errors in
>> this architecture specification that would preclude the usage of the
>> contiguous bit. I understand that Arm MMU-700 has the following
>> erratum
>>
>> 3777127 Under invalidation in TBU possible when using contiguous page
>> table entries
> 
> And a neoverse one too.
> 
>> The recommended workaround is described as
>>
>> "Ensure that contiguous page tables are removed using a single range
>> invalidation. Arm recommends using range invalidations to remove
>> contiguous entries anyway for performance reasons."
>>
>> and I believe we are already doing this.
> 
> No we aren't. Go read my fix on this:
> 
> https://lore.kernel.org/linux-iommu/1-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com/
> 
> I have another patch that fixes it for iommu domain mappings too.
> 
> Jason

Sure , will disable it for smmuv3 for now.

Thanks,
Vijay
