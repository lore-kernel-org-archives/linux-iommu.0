Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D593357D11
	for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789880784; cv=none; b=Rawv9npQi3/z3p3ysTnbo6HHtcqJGwUZvO0wkBpvg9U3XByhOkYxrsPliN2kmDYOg4o/dMfuXHecn84wyz3Uxt27VwQA/PuQrOh6K5zQFnJqD5cw+dM7s4GDw9BSfOWgMi95z9AGi+/rKmhUtnaWT2aCthzhkpmqnPpkBqsnzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789880784; c=relaxed/simple;
	bh=H8h65/c7zaftwh3/OIrA0+6Kpnt/HU9wP6V2ImpalYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1b97zFAbgcu+mgzJOdt1FBaHb/RsITuDqfHADRSeAD7xp0KcxACqSERPGaW69GtAxWCtU2GaY0WNWPta2Cdxg8a6GvaEr6vXIjdhDpUmxG9CrmZ2Ae2UpB+YtAvXT9jMifFj8HbOxJB0zoK1NdrzyNYE4RsykJaEvF67Xxg868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEE55uxD; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEE55uxD"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3965683e9e9so1495842a91.1
        for <iommu@lists.linux.dev>; Sat, 19 Sep 2026 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789880773; x=1790485573; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ataTrCoeuQQFtL3tpWSQNBrTWuZ8RuoviVcaS8zLYpE=;
        b=WEE55uxDv3OLeHeJ9A9q90J+hkNlHBUGYX36d5jSWsKvbeKmH7C8kVQ1W3HbudHfWv
         l7upe8vi8T1onuLfCUtIvYjcd0l9k4eYMnEiU7nm8B4IVey8gVegD3eOjg35BX0Nh+oH
         YwjnzzrahDFkicZJDDQRLaLLk9QBp/9CY8D+M1vObb6uFyxTjozJW77JJA0Caqnr9gNy
         uPH5yrBmG1lDXrIggMTMzwXUdeGmNLgXOlLvnhlxvPQhl2SpSFK3lB3EmRloDk2urgi4
         tNjyBEI0qAeNjNxG3meCWYjD5NnuvVhGPMbc3gtMd3SxLUYTHHm0Z5AShNhpO0IjvNaY
         Cv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789880773; x=1790485573;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ataTrCoeuQQFtL3tpWSQNBrTWuZ8RuoviVcaS8zLYpE=;
        b=v6DIr8n6oEGU9A5FbxoaoA9TjV8M1Z2EJT2PB5J/BeJe65kHPb8f4ZVsA/nylYAdP2
         VtGbfKKhFNWR4jyMP/EJzKUgtYx08mFmndRElq7gDDehFi3RgPiR5lR0hfFoGFSzyqGS
         WbivBnl+mb8YVsldBLL0EQsHwj2PzYpqOlb8q6RQS5xK0tDqGKsDIJjObuo48Owo/I2t
         J6H9RyFitRQwGa2yokX0uxz/Za62yPhPm2BAuvaOJfS2BLKPj/vnZ+RasfyN2q7+iQmv
         rPH/4xfNXWiPVYZu5+zYW1+caNV9cqMF+HD+LUF1X+ti9fIn15y8ygNQ7AbiqkA1+k3P
         lCcA==
X-Forwarded-Encrypted: i=1; AKwUvByMRPPRhJ10Kvru90vKYB73xpZFvY58ox1HXoA1Q8zKjMo7GKxiU2wNIDWd59SDonzUxPU1PQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lY1WFh+k470JuTOLy2zszw6HXUAW4fRepRVwMCkf3m0aARu2Jq
	IxDNYnouQhIgwqMXktlWpVOZeTX3+Nv85vKgG1QobuXcihTtjiLWxuVW
X-Gm-Gg: AYBFou1UT6PGui/gWn9l+fDiEDwMq65XLSU5bEdcPmQ9yjhQbW7zV7JrE378OjtfixL
	VXpDVY3qbQ+0Sk3LIr/ccmHn69vJi0xv4eErSOjjIa3svK+9qPl6hfHGpTn6RkowZVTJzz5dOqh
	Fs2oOYoQS1d3/o/57fwQctrF1+6CI+ipsCPdyq9RSYoBeBJWCk45gQFY9GrME5nfUq9TK4VRI+o
	xV9on8RVvkh2VFkdPcdpIz9u/zdhsZ9r6cYbPmEHCRc1/i/7j+wA4GDZ6Fl80HMIRIXtYfMp0pY
	4YK5tFkR95PRvR9xwk0X4BR57fDdEYg2OmjvOJOpBCxofRjqdyZA7ZqUH9w1BDJ07253dwK/wgW
	v8cP6aDxVmx5LMld6MwTVIaVBnuJM7BVOVX24vIeONDx/CXVQWmLqlI2SJPTy5YjV4M96+weNpX
	fy1W6BzjAd9wKiI60rkJwgxO/EjdjsdZfYrFnj7neWV8BxY/Mkeu70dJ6DZkQlL8Mtb6CvUS80z
	TvQH9el90smvO5p
X-Received: by 2002:a17:90b:3eca:b0:39e:6a7f:1dc6 with SMTP id 98e67ed59e1d1-39e6a7f2209mr6292197a91.34.1789880772639;
        Sat, 19 Sep 2026 22:06:12 -0700 (PDT)
Received: from [192.168.50.174] ([124.64.19.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145dasm7433814a91.4.2026.09.19.22.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 22:06:12 -0700 (PDT)
Message-ID: <8572d404-8a33-4cd3-a14f-ebff7c2ac487@gmail.com>
Date: Sun, 20 Sep 2026 13:05:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 08/10] iommu/riscv: Pre-enable GADE for
 second-stage domains
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, anup@brainfault.org,
 aou@eecs.berkeley.edu, atish.patra@linux.dev, baolu.lu@linux.intel.com,
 gong.shuai@sanechips.com.cn, guoren@kernel.org, iommu@lists.linux.dev,
 jgg@nvidia.com, jgg@ziepe.ca, joerg.roedel@amd.com, joro@8bytes.org,
 jroedel@suse.de, kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
 skhawaja@google.com, tomasz.jeznach@linux.dev, vasant.hegde@amd.com,
 will@kernel.org, zong.li@sifive.com
References: <90826872-1374-49e4-832d-555abf8e8369@gmail.com>
 <20260920031259.20950-1-fangyu.yu@linux.alibaba.com>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20260920031259.20950-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Fangyu,

On 9/20/2026 11:12 AM, fangyu.yu@linux.alibaba.com wrote:
>>Hi Fangyu,
>>
>>On 9/15/2026 11:28 AM, fangyu.yu@linux.alibaba.com wrote:
>>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>>
>>> Pre-enable RISCV_IOMMU_DC_TC_GADE in the device context when
>>> attaching a second-stage domain, if the IOMMU supports AMO_HWAD.
>>>
>>> Software pre-populates second-stage page tables with D set, so
>>> enabling GADE by default does not change normal behavior. When
>>> dirty tracking is enabled, iommufd clears the pre-set D bits and
>>> GADE becomes necessary for hardware to update the dirty bit on
>>> write access.
>>>
>>> This avoids toggling GADE dynamically and keeps device context
>>> setup consistent with second-stage domain attachment.
>>>
>>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>> ---
>>>   drivers/iommu/riscv/iommu.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>>> index 16779877351b..f01fd4e2f840 100644
>>> --- a/drivers/iommu/riscv/iommu.c
>>> +++ b/drivers/iommu/riscv/iommu.c
>>> @@ -1330,6 +1330,8 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>>>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
>>>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
>>>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
>>> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
>>> +			dc.tc |= RISCV_IOMMU_DC_TC_GADE;
> 
> Hi Shuai:
> 
>>
>>I might be missing something, but I don't see how the GADE bit set
>>here reaches the hardware IOMMU DC. In riscv_iommu_iodir_update()
>>(in patch 04/10), it looks like only the V bit is taken:
>>
>>	tc = READ_ONCE(dc->tc);
>>	tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
>>	...
>>	WRITE_ONCE(dc->tc, tc);
>>
> 
> You’re right — this is a real issue.
> 
> GADE was being set in the software-side dc, but it was not
> propagated into the hardware DC in riscv_iommu_iodir_update().
> 
> I have already fixed this in my local tree, and I’ll include the
> change in the next version of the patchset:
>      tc &= ~RISCV_IOMMU_DC_TC_GADE;
>      tc |= new_dc->tc & RISCV_IOMMU_DC_TC_GADE;
>      tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
> 

One thought here, instead of updating individual TC bits one by one
in riscv_iommu_iodir_update(), could we transfer all software-configurable
bits from the incoming DC to the hardware DC in one go?

Something like:
	...
	tc = (READ_ONCE(dc->tc) & ~GENMASK_ULL(11, 0)) |
		 (new_dc->tc & GENMASK_ULL(11, 0));
	...
	WRITE_ONCE(dc->tc, tc);

I’m not sure whether this could have negative side effects.

>>I saw that you mentioned you tested it on QEMU. As far as I know,
>>mainline QEMU has not yet declared the AMO_HWAD capability. Could
>>you clarify whether you used a modified QEMU for this test?
>>
> 
> I used mainline QEMU, not a modified one.
> 
> In QEMU, I only tested the second-stage path with a
> VM using device passthrough.
> 
> I did not test the dirty-log related part there,
> so that path cannot be covered there.
> 
> That is why I noted in the TODO that I will build a
> dedicated test case for dirty log handling later.

Sorry, I missed that TODO.


Thanks,
Shuai

> 
> Thanks,
> Fangyu
> 
>>Thanks,
>>Shuai
>>
>>>   	} else {
>>>   		if (!riscv_iommu_fsc_supported(iommu, pt_info.fsc_iosatp_mode))
>>>   			return -ENODEV;

