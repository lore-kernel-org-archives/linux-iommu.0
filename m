Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226BC140E34
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440242; cv=none; b=NKdKMAjKu6uPpQtRWHAjQhYwNnyPG3d9j4Cp/4X9DrzGAMgunvQUsTPXV4OEHVznrZ9tfQf/G2m7zJlT4b8N3bomhNJuTbobeomOC94ukFx/DohSmlPYYbD715gvkujn5FBTYn+k5yeWPYMTRL3MLeh2tQFd3Xr5TPMaSuNtw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440242; c=relaxed/simple;
	bh=wM5KftaeQRn6qwIcY5rniJjwgWxiV9BfDTasKj4vsFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n344jz9kCqkDSb6JHg7OtXLPHRkZicojkw7kPWDSrz9G7a0yf1/RIBQIQuoL8DxMjTlph0J8l5zEWHZMTbH/GuJrQvbj/DSFowELk8dj73LxAUDNb18IYL2PAo7Y2Z7rVqg3dBjmYEkSTYK1Qog4sKeyNZ5omruR7Te1tM/+EAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KeAvkgy7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KeAvkgy7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561N7h6L029816
	for <iommu@lists.linux.dev>; Wed, 2 Jul 2025 07:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RCA3laQUQgLfr4d3l5ToyQ/eRvjHKHLDwpnt3NLlado=; b=KeAvkgy7miYsdzsE
	076/VOy1kJ3L98Gd5ihfqHoKdRQ/AYP8yI3ee9KhynregnxtjLo3AJYMAR02gAix
	RuwjdIKO39fyJZJsvOedZe/KOAs9qzlu6Hcs3mSu1OKYKzdaLjwZVtyHInEWJj2j
	WAOsZb3sNlPKuCU8WgGNEM6XuKuO16v+g18wo/AB3ddyDYUHeCeJXNq/GRIVjddp
	1cC5PWoWGvIjYjba7ggfjlrfWuo0f3n3fbW8DoQdzVqf9Zk7BB71f5OSuJXXV8Xp
	X662SA3//wsU5iDyZ055lwbjiCLmFNCzZE8xK3+pTF5qE/7YSyeW1dol+G9NXXeW
	qpTgLw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47m02v5kbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 02 Jul 2025 07:10:39 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso6423019b3a.3
        for <iommu@lists.linux.dev>; Wed, 02 Jul 2025 00:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751440239; x=1752045039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCA3laQUQgLfr4d3l5ToyQ/eRvjHKHLDwpnt3NLlado=;
        b=wKkIapIGBEjY8c7dUJ+1KA4Wyf4PlQj55QkMSdfEckNXSA3wC2amAYEw6BluiT8iF3
         6QKftA94LO/djO5divNgcyB/XL2pB4mFKgI6x7cwpvN++wuTJEJHhc0vIgnugLcNnOM/
         6HrQgGenfxYAkwsVBTVGYlpTxe9ssfdMODgz9ybiFDhiph0NOTPLZUFFb0AIpmP/pM/b
         ZoXtR5WkmXcfy/XYg0yVn5JNnMDU4w03bzodGWvuOu2zSArMckU/xGM7rXxxh3WXQwgg
         4w59TI5EtBSfAPUiMkUQIMDfD9qDIK+LQ3RSzerWX2n4J/MptK7ewqn3n0O2JPxFRh50
         Zn9g==
X-Forwarded-Encrypted: i=1; AJvYcCX/DXey5+X4actlE+NbBcokDUus0Aw6wHD5krP4wd1rdpoO9nN2NRcCcYPjunOK7V5kxFRnkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFs3zSJYhu7XS9mOFsq840lU5ptRmGCOzC6qTZpxXzKCWy2IWJ
	akaLhi9aJdZ16keYYU5JsHN1VCbSQ46vbp3StRpQtkJF/1V5Eoy6jvZeJiIohIYEZtrKE+UHj9K
	qL38kjr/pg9jOVoNJHjbsb3hDB+0G/z1EnQQPShayj3dwbJ+uhotLQqcUuQ==
X-Gm-Gg: ASbGnctgRzKpNI14O1kJ4Sl5dxqYnFbGPyIetvg+I3F4+sI9g9PVTWEFWFYmPPyb8aQ
	e5awx5GAejc7EveAB+AKG8YQ4LxXevaqKtvJ5iU5s2M5ZYnwiCF1s07e5dpwCC9k2YR2oUTF7gE
	vb7nlaVyPpSVHRaQ0EJYBGnPDuXUFv+9FtbIENGerMCmDgeihDKroqjsKBl8USJklD5xuxN5SXy
	21qDVTgqLxkR1BNm/1E6yvqnUQtrT3aDtJSB6TRSEqSgVgLZT/8m6PuaGpofbMCN8aaEIC79UvN
	CZv6jZOHzVHMVKIA3zGzlJXSrCoAjvtsRXE7abINTd9fQ2dVjoxvfMSPEHE2KxSO/UZ0NgnsSgV
	8UhIAyLJurvvWdl0=
X-Received: by 2002:a05:6a00:1a8e:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-74b51513b5bmr2503476b3a.24.1751440239063;
        Wed, 02 Jul 2025 00:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuPtEnawlGMpCtfFrj4XZgsJyOlvmqGRqt3CEEGBVF1/+L6vgFtb/yE1jQDvC02NOyWgzA9A==
X-Received: by 2002:a05:6a00:1a8e:b0:748:2ac2:f8c3 with SMTP id d2e1a72fcca58-74b51513b5bmr2503447b3a.24.1751440238639;
        Wed, 02 Jul 2025 00:10:38 -0700 (PDT)
Received: from [10.133.33.132] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ed353sm13034533b3a.153.2025.07.02.00.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 00:10:38 -0700 (PDT)
Message-ID: <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com>
Date: Wed, 2 Jul 2025 15:10:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Matt Mower <mowerm@gmail.com>, Vasant Hegde <vasant.hegde@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jeff Johnson <jjohnson@kernel.org>,
        will@kernel.org, joro@8bytes.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, 1107521@bugs.debian.org,
        iommu@lists.linux.dev
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com>
 <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com>
 <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA1NiBTYWx0ZWRfXy42N5wrRwkZ9
 fgmCc6TIhHKisC68AT3/qqfnAky7hv8kmcj0h0E/MQR98vDc+Lj1A14Xpv3l68ZaG+EB++iRu03
 vYssmZhWccNnKe4aNMe41G/bJ/Y2E44BhzpyjquoFu4RBQ23vS3tRIi76A5c1Po3VhWmqCnxjXW
 ucDgWeZ/BantzxS5I595CLBZ7UEovbrqJZn7M9i8jfKVhE0/zhg0FgWze2F+ifdsq6KzZ+h1JP+
 Yc+tHD86YsfHC4rq/+EYR5NhofeaGpkinoqAf6gXfK6yY0gfAPOZgJU8chyKmw26Mk00+qQYHHP
 tPEcnLcYnkBxDKGzCbuHtZV7QxrF6zAEYOdVsroHhTzKoZaI1+FQS3ZxgkjvjktB0dznJzqX7Pe
 Ku5Jj+8Ca5cwRWBskPAGYogexjF5HN/u+kHAxiMxfRuHmHIuev4Rs3V/b+YlBeBqUD2TgxlN
X-Authority-Analysis: v=2.4 cv=Y8L4sgeN c=1 sm=1 tr=0 ts=6864db70 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=1xDctz_ZAAAA:8 a=PsUJ3HgR6tW1sV_hUDoA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=1a1P4aADmYxDp9Cj9Seq:22
X-Proofpoint-GUID: N0I-4p1DCHeyLujMXH7lzlpIJIqwZyhm
X-Proofpoint-ORIG-GUID: N0I-4p1DCHeyLujMXH7lzlpIJIqwZyhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020056



On 7/2/2025 1:17 PM, Matt Mower wrote:
>> A couple more things I'd try on the ath12k side: firstly, boot with
>> "iommu.strict=1" and see if that makes the faults any more
>> frequent/reproducible;
> 
> The issue is easy enough to reproduce in 6.12.27 onward and I may be
> mistaken about the rarity in 6.12.22; I reproduced it relatively
> quickly in .22 today, so if this was the primary purpose for setting
> iommu.strict=1, then testing with or without strict works. FWIW, I did
> test iommu.strict=1 with 6.15.3 and still have not reproduced this
> issue there.
> 
>> if a fault is fairly easily reproducible, then
>> use the DMA API and/or IOMMU API tracepoints to compare the fault
>> address to prior DMA mapping activity - that can usually reveal the
>> nature of the bug enough to then know what to go looking for.
> 
> This is unfamiliar territory for me, so I hope the following is at
> least close to what you requested. If not, happy to provide more test
> results based on a set of instructions. Here's what I did:
> 
> 1. Set CONFIG_DMA_API_DEBUG=y
> 2. Set kernel command line to: iommu.strict=1 log_buf_len=100M
> dma_debug_driver=ath12k_pci trace_event=dma:*,iommu:*
> 3. Booted and waited for page fault, then cat'd
> /sys/kernel/tracing/trace to a file.
> 
> Additionally, though I'm pretty sure this is irrelevant now, I added
> logging after each dma_map_single() in the ath12k driver to print the
> function name and resultant address to the kernel log.
> 
> Comparing the addresses of several io_page_fault lines in the trace
> and in the kernel log, they line up. So, I'm hopeful this is on the
> right track.
> 
> DMA/IOMMU trace: https://cmphys.com/ath12k/iommu_dma_trace-20250701.log
> Kernel log with additional logging:
> https://cmphys.com/ath12k/dmesg-6.12.35-20250701.log
> Diff showing extra logging added to v6.12.35:
> https://cmphys.com/ath12k/ath12k-extra-logging-6.12.35-20250701.diff

Thanks, the log is helpful.

So the whole thing is:

#1 ath12k allocates/maps it at a very early stage:
   (udev-worker)-532     [010] .....     4.878076: map: IOMMU: iova=0x00000000fe980000 -
0x00000000fea00000 paddr=0x000000010ec80000 size=524288
   (udev-worker)-532     [010] .....     4.878079: dma_alloc: 0000:c2:00.0
dma_addr=fe980000 size=524288 virt_addr=000000006cadbcb1 flags=GFP_KERNEL attrs=

#2 here it is unmapped/freed
   kworker/u64:0-12      [011] .....   327.747763: dma_free: 0000:c2:00.0
dma_addr=fe980000 size=524288 virt_addr=000000006cadbcb1 attrs=
   kworker/u64:0-12      [011] .....   327.747766: unmap: IOMMU: iova=0x00000000fe980000 -
0x00000000fea00000 size=524288 unmapped_size=524288

#3 then the page fault
irq/26-AMD-Vi-154     [006] .....   327.753942: io_page_fault: IOMMU:ath12k_pci
0000:c2:00.0 iova=0x00000000fe980000 flags=0x0001

#4 here seems ath12k is recovering
[  327.849022] mhi mhi0: Requested to power ON

This gives me the impression that the IOMMU page fault is caused by misbehaved firmware
which crashes. The sequence is, first firmware crashes, then host gets that event and
begins to recover, during which some DMA buffer is freed/unmapped. However the firmware
does not know that and continues to access it, and hence the page fault.


Matt, could you help enable verbose ath12k log to verify my guess?

modprobe ath12k debug_mask=0xffffffff

note this would make ath12k throws lots of logs. Here the purpose is to check whether
firmware crash happens before the page fault. You may monitor

	ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset starting\n");

in ath12k_core_reset(), which is the entry of ath12k recovery process.

And one more thing, the issue buffer is handled by dma_alloc/free_xxx API family, so
adding logs to dma_map/unmap_xxx API does not help here.

> 
> Thanks,
> Matt

