Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1AA21CFE0
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926766; cv=none; b=jLlYE/wGQc1/lpcsU82sXPLsbSAAdQ4EEjEgS06xgYuvkH7o2NDzYIe8Dp0zA4OyplngqtTfOT4Vi9StPaByULsM8Vn/G9X9v8jC/7gHSkrYHb/lRVZEbWV//iOY162ZeDggCnqMrw6p5cz2UCGgZoMnw5RJgVa0JdgP4uDO0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926766; c=relaxed/simple;
	bh=ZRoxIR8iUpuvzhaGrv1RGMVbu3048LD7OcEqrqpEc1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYD0ss6VAKnMxpvoUcepppCIvBjo0ks92lyhLrA4wOaxjJ03CPWxt9lNvOtRkrWepJpf5QoUb3kkab6b8Zpn0X+mOc7JzrIcMyB16AXoMfBxXRlshJuxbN7omxfs+ueOazYgZsdTopBSptVmvNAw+AsD2bO56jpKhhB8kRNRGtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KMmpulum; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QtYytS4B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KMmpulum";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QtYytS4B"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688MfuJA3653858
	for <iommu@lists.linux.dev>; Wed, 9 Sep 2026 04:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d1+atJR6FDQQspxnJlEifDjkb7d3prg4wHIrPk7shYw=; b=KMmpulumqUHxy974
	LfPhlTuVkXLjKQydr+Jk37/5pYuE/aYqT4tC0rtx0xep6Z5Zc5hGXyE6V9uyi5mI
	L/V60lpVH2wyw0p2Mlpo4yQ1GB03B1HDEsfLxPszNNFMi7DZk1e9HUT7emg9Z9+U
	eF4pf8YDJaolfMdnwLk2Ob1sp2FIqKSbWnKarkKJyWBWmndlFso0JGU1WEB8FdBd
	XQVtgWOwao48Xfz+/PMa8Wz8mhMsX0OMm7QVNVEgUiSagatS+4lNxS8npn2CZD6j
	2tPNYbq0BQEv+Gkv8oI6hdQcVuQmAs33AnuBsN8FisVBXZ1s3GOeUYeNVpULDJZQ
	QvTgpA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjppp29eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 09 Sep 2026 04:06:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so6598104a91.2
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788926763; x=1789531563; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d1+atJR6FDQQspxnJlEifDjkb7d3prg4wHIrPk7shYw=;
        b=QtYytS4B+7Jmh1Tyi+4rPAKBitx/ZWfls+4eNilh3bpSqAA1poJd9UuiHmwDH0C0eQ
         nI8yyAxzLMsPlrwDlUCtbxrcXm3/dlcQHzghbkJiJ4i7883+bCiu4PxUDI2f6pkmblZp
         1yQeRnz1Fby7gC0hOrJiaTCK4bfeUFOTEDujXmK4U6gei/8W1IC0gREGsBXQ3ipuGR9k
         AOjLZCnrMTXcoj7Nbdl0ZNI2hvLOXPLjYdb9Nb/rt9HYAIXTlqKLyBXy9AJuMrSZf2+4
         vP48IZ+UnK/GQA33tGT+o7ozdRNx6RFQWE46oYBNzcivvVOyIVQeuAmz4thwCq79//qT
         U71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788926763; x=1789531563;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d1+atJR6FDQQspxnJlEifDjkb7d3prg4wHIrPk7shYw=;
        b=dnp/vA+65K9XufGASYWFlOaQTQZ5MUaU9kz/JoGxUguEgBQQOiFFL0tiRhoMQmGoy0
         zA8OETz+04wRPvWfVo72tTGKMSq93iFDqg35JbvJ0topfhaeLmE1NO/Aw354qD/LbD2i
         NBJyADzK7WGdkm02WF1L6Wf6k/WIFP9nfZXAY3fVLuLgfLnidDOYnZAE95XdIe8CAW1G
         Y39cmrmGnzTm+zbTiLzyIQIaenRq1DHG8zT396birvnASZSC6Iymv1zUe64S79QTC+MV
         zgq5+ybOWZag1lBTv5Kgq5ChE8nJzmQmezhCjUq0vldDa2jnz11+t0fwF7nVe+VTWNq/
         Za4A==
X-Forwarded-Encrypted: i=1; AKwUvBy7jOm14oPXbW6GkT8/NsKSIwKtkJdSY61rJ2wJJNlGaOEX9HBHBRHhbHFWbAvuAqqJqONLQg==@lists.linux.dev
X-Gm-Message-State: AFuF++l1Q/LQ6XIWqEmXRlaetOO48kWIlG/amfmMdHPvbIZBeqb93VOG
	WR7Sbm0niKAieuJYJ0bECvenXDsqZ4g7dQXCLciwMboQP0fYf0+fMR9gyPNTdt+O3dUh8IfAsLE
	cNRSjZLH236DwknAZdZbwW8yg+J72E2ZuInrWDspGIpEVRBACKBsOniPAUw==
X-Gm-Gg: AYBFou0bUymxYt1xd4Tdmlxfl+Pcpx/nfHnrjMcCSvGwoXxfz+ZhCN7hHwz9fwQf4mG
	GRAogLCdmgs20T1gCKa+d3ce8dmETb0G+qvh9cfwhwMcH+fl5uTOE4UYXlvheraT3JVL1WAF72+
	DzFaqzhjdVlBZKhUDSdp9i+LeDKi6zqR2TxFc1w0kOO7v4TnJ8GryzhXZSepvBIkdjukEYQsRpB
	abHAhdphgm3LupzgQqVDjaL3aUgDg+rAJotOcAq2I22hOVk8qORFqUgiGD5EwiVQkVVpE3yKXCq
	0OudrcQOhemyrLm7H9yHquWGF+hSJMyj2Kj3k2ai4PX67gOWzkLt6YYRgccJRBlvWDuD+Wf2L4+
	SZ7tO7fnMWqciTfc3qPQDCR8Z7eDx3AnVBg==
X-Received: by 2002:a17:90b:2749:b0:398:d292:e6d5 with SMTP id 98e67ed59e1d1-39b26304385mr50410116a91.24.1788926763183;
        Tue, 08 Sep 2026 21:06:03 -0700 (PDT)
X-Received: by 2002:a17:90b:2749:b0:398:d292:e6d5 with SMTP id 98e67ed59e1d1-39b26304385mr50410062a91.24.1788926762690;
        Tue, 08 Sep 2026 21:06:02 -0700 (PDT)
Received: from [10.218.39.50] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm46654957eec.7.2026.09.08.21.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 21:06:02 -0700 (PDT)
Message-ID: <dfcecd58-d6ec-4694-81b6-fe6d45d4a7d4@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 09:35:57 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
To: Jason Gunthorpe <jgg@ziepe.ca>, Daniel Mentz <danielmentz@google.com>
Cc: Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260804-iommu_contig_hint-v4-1-d7a47ed5db98@oss.qualcomm.com>
 <CAE2F3rBQQEHsksOyE2ojQPbMd_vvFqaFMC2RzT0B6KkxMB5YgQ@mail.gmail.com>
 <c84e61b1-785e-4a47-9082-c5111bf35fd4@oss.qualcomm.com>
 <CAE2F3rC80=ZpiHVtmRDU6f8g4AwV_RrJ-Zqr0Xi7zbUc0fsQog@mail.gmail.com>
 <9c28300b-a17f-4324-b9d5-8fc800e4d794@oss.qualcomm.com>
 <CAE2F3rDdogf1jGsD2ekGqT7X692fFyqv=H-8iM5OTu8AdHHoJg@mail.gmail.com>
 <CAE2F3rAeq_CPeaDxuh40v41v2f=68oD2TqK9DYSPKz9F74kqeg@mail.gmail.com>
 <20260908164746.GC2543240@ziepe.ca>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260908164746.GC2543240@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: adVgZoiOyq8zeBIQAQxGzZlfQh1IufMd
X-Proofpoint-ORIG-GUID: adVgZoiOyq8zeBIQAQxGzZlfQh1IufMd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX42pPFQ/ctpK7
 Q1BTNqG4j3jnAwSFbW3+IKEnJyoEa6PZK2i7tmbt9NJ/D+VxMcT5eojRzDWc/Rq+5sWzGJPBibh
 XrUxT0SlbA1FbysXFcRNMjYwJwybaPIwE37zIzW6qTSHsWZG7ATqxQGGtvAdR4zH0XruuTcqC+R
 mltJrsQRan8QwMalanuZxEgnN01P9ow3O2Sn/SVULXodhZzij2sovH0P2yIty+VaQwSf7TQTor8
 YW1ffA9UW+8pa/mG8Hq2wvjlQRfMsVTrmz1xVwpnWswsVZO5BqkDxIlBRN/j9PX8y5za948JzPv
 8Y0OMiyCpzrhSvbl8I+Cd3w1E9+1aAsli6EiYjRRv9/16B02x9WyVb04N3bfubEss5Ty2K3Rykb
 KcmGrWuc/bxisG6W28KafAAwp97wrjc8wfaMl4Wwymc9aeLLdJoN0abeSCE/bk9adP14I3i5Iye
 /tsvqc0UICeTTDcmqQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA0MyBTYWx0ZWRfX9N40hvXBG3hE
 GAnO/G9c1MjffDlfCnHmA+uowV859ndlyDQ/p9ZG4g+8wzqXE1yGsyCFNu87SYUnX8EmHS75Qk5
 nobIy8q0p9MUbgG/dHz9ib6GHV6OiDA=
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=6aa0db2b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=zcW-mOqCcEHC3mfLxN4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090043



On 9/8/2026 10:17 PM, Jason Gunthorpe wrote:
> On Tue, Sep 08, 2026 at 09:36:35AM -0700, Daniel Mentz wrote:
>>>> That said, install_leaf() is shared by other callers that reach it through
>>>> ops->map_pages() directly, without going through iommu_pgsize(). panthor_vm_map_pages()
>>>> (drivers/gpu/drm/panthor/panthor_mmu.c) is one -- it allocates its io_pgtable_ops via
>>>> alloc_io_pgtable_ops(ARM_64_LPAE_S1, ...), same as any other LPAE consumer, but does its
>>>> own chunking with a local get_pgsize() that only ever returns SZ_4K or SZ_2M, with no
>>>> notion of the 64K/32M CONT boundaries. That can hand install_leaf() exactly the mixed
>>>> iova=paddr=0x1000, pgcount=34 shape in a single call (panfrost's map loop uses the same
>>>> get_pgsize() and hits the same case). So the prefix/aligned-group/suffix handling in
>>>> install_leaf() is still needed for that path.
>>>
>>> Maybe other people can chime in here, but I feel, from an API
>>> perspective, we should have only one way to make of use iopgtable. I
>>> think we should just mandate that users honor the updated value for
>>> pgtbl_cfg.pgsize_bitmap (and pgtbl_cfg.ias) after the
>>> alloc_io_pgtable_ops() call and then choose page sizes appropriately.
>>> Otherwise, we end up with two pieces of code in the kernel solving the
>>> same problem. panthor_mmu won't be able to take advantage of the
>>> contiguous bit until it gets updated accordingly, and that's ok.
>>
>> On this note, I want to point out that I tried something similar in
>> 2025 (see https://lore.kernel.org/linux-iommu/20250430231924.1481493-1-danielmentz@google.com/).
>> The feedback I received from Jason at the time was:
>>
>> "Wouldn't it be better to use the pgsize_bitmap and rely on the core
>> code to indicate that a contiguous page size is being used, so it can
>> trivially set the PTE bit without doing all this extra work?"
> 
> Still think this is right, Panthor is not using it well if it doesn't
> jump through all the hoops. Probably there should be an general entry
> point for map/unmap that does the right stuff for the DRM drivers to
> call.
> 
> Jason

Thanks Daniel and Jason for the detailed feedback.

I agree that CONT-sized mappings should be selected by the caller using the
effective pgtbl_cfg.pgsize_bitmap, rather than having io-pgtable-arm perform a
second round of prefix/group/suffix splitting.

Based on this, I will remove that logic from arm_lpae_install_leaf(). The only
effect is that direct io_pgtable_ops users such as Panthor and Panfrost will not
benefit from the contiguous hint.

Updating Panthor/Panfrost and adding a common map/unmap entry point for direct
io_pgtable_ops users are separate API changes, I think this can be taken up
as a separate follow-up series.

Thanks,
Vijay
