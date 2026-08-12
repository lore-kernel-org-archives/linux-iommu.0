Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B42D7398
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786501985; cv=pass; b=gkCA1lhHd20UQ/LTwvYcgi+GjzpB5Vgf8pkeKujaSy5JtDISJ7zt08TqPR8JZVh8+DmrxhmydJoYxWzVOa3GsjnLlGSlEcG82sdlw5q8mGa+tNOc/SNjPP2EYHbOgr0VHXa9i32iPQxXbdEr27DMtL+C7l6SzN1Jv/VZOJKXAmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786501985; c=relaxed/simple;
	bh=Q6qQHVSg2A0pusNqlHUO6ccG/0BmwRkp9wplW5UwomM=;
	h=References:In-Reply-To:Mime-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlzOefj/d7WZ1kTofp+2XgLA9nhgFUoMNyxmDG26G2tBG0vwEQz5R+MF0XwjWUdYop1nM+QxT3eth9zpd5g1aGE9XMNVUMishREo1kr0+DN1oFtUsliY/svUvB2HIEdmrGygcJC5ZFVWVmL+yvX7Di04O9gra08k36al7hEn/QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dlduIwTD; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dlduIwTD"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b01cb18515so351366e87.2
        for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 19:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786501982; cv=none;
        d=google.com; s=arc-20260327;
        b=n94TRKW2nCkpZVMBnpWgTS8Uy0kvQDf27jlOTK6ZY8DwezPcW1iQccVNUmpzG0JH0L
         S5awbSxQW1kIJVhiAw/RaAxzI98Ai/8W1wWwG4tH4jle3T5CR5zwm+l0OtXPkcXGiz5t
         tcjtmu0KZXBatk1amMJ8TI8n0pWkSfgvMU99JHNvDdjoAdJekP0foK75epgTjUPg/lxh
         SASrEk07L6DzQoasWkv6phozzs5psdWYHLHrsriokQ8oTOOQTeV1jo82iyoH4etipbyt
         boz6mX+4C8HiHfrKYFlWIr1tQE74Rxu6Dzc+7Nom1E/AUceklETedPNwYk677lH+oOKO
         9h7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:user-agent
         :in-reply-to:references:dkim-signature;
        bh=jE3vNWzPKFqJXOD6wSjLs1YSOlszFJSXmdSNJJf+nTQ=;
        fh=S5YNjVOSz7sTFwTXwRPYu0SpLQvgzRQoOM4TmCr6h9w=;
        b=hIUx1C6n8mXi2S3gtTrvrZTfUQ+dB4KiAxEy0Em3c+7jger2KNwiTpPSlwBIpfjcHv
         SWwPk9EALQ/rgjVQXvGuEGbapfCvaW1DHaj50C1mfd0wZqhjQDWAVCwnrcgfhFDFk4Q+
         oGCPJjaqooXS9+vN9JbSrH4pnVEonVQzICKjef9NJhsqu95S3WD/a+tR02alOTVYh0PQ
         tCP1YcOPGtd6FXX1DNyWRlOPtWrtrwQIks1LzzCdYTN862mrI2gdimIz6AxWorc4VhTJ
         qbiclp90bJ49EjhrUMxM/ihsrXJL9jWLU93jYB8HxZ43lkjifnkLYT0Z0K751mzTYc+4
         Himw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786501982; x=1787106782; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :user-agent:in-reply-to:references:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jE3vNWzPKFqJXOD6wSjLs1YSOlszFJSXmdSNJJf+nTQ=;
        b=dlduIwTDKm0BXMmugVwrjLbs6UtSGJ8BRJdyZToMccWOQVLD8h6t5zbbUJIJZj3eHW
         qXyfuUqoYrqThPhCwpzR5c4xNDwGX7aK0p8GibYuRZ9ndkdFwiz7oLcsspnR3Rh8md2Z
         uFwSp5XBKbIFLH9tHSgZ9GAAyuhL2Eni9aqgmSo5WOPpeb/zvBt7RfHs1czKvk7USHe/
         WavNNu17uVirauNyIj4fJitBxhsh5s5TYjFkl+YFjhy3Dl9SemMgcFXgNzvTCrXBiu6D
         Fw/G3fIomencfrqqLt2oNJJDAwVw5eDbMe3lOTevCn8DgUEw8d5cIDB4cj7/WiZ2pPuO
         shqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786501982; x=1787106782;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :user-agent:in-reply-to:references:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jE3vNWzPKFqJXOD6wSjLs1YSOlszFJSXmdSNJJf+nTQ=;
        b=tREXxYKGvNDBY3XB6cZRWSIoBs5JCs6l9B46IsSWAK0jWOxU3EIxm/OW7AbEulc2HD
         LeJ9oY+ld9M6qHv6NIK837eL2sPKr4VVsYBnga8Ko3F4HggORBZlLozcqedbYlYbR6B2
         /hLNVf8PhssdNlCjgMN5MV/0UceCA8qBhrCc49Ct1P6PYEFjUbgM3VhDs5uCrXgYzZZg
         krUx7dfPDhGerV4Lx+0Gi/t6CFxECgPbVunqNS9/RlKVmepbOzEDw+Boe5OV3wD3cHIz
         h1VP55bhBV9WTghGlUd+H9O3kFhgIxT3YBoFtlRLKNek4yTd1FPkVnfmw5UfgdR4xxzd
         Tlcg==
X-Forwarded-Encrypted: i=1; AHgh+RoBRuMm9D2an33H8G3SM2l+/SH3FEANWBChyvRY6IqiBmn7w2Zyp05CoWYFm7bVU0FTWkWOWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFBt1C3rdfhpuyyqbcSgF+ND/KttCa4R1u3pQjzFZiFVuQk+Zl
	fOisZuwrGor3zstxStJXKG7Yi6bNnObxWxvK7N+/hkwjVE54LSDiLPyMppTheXejDcXe/zT0L2W
	zH9vI1RlPOyu4b3FGUNjm9Gx2jbdV6tox39t2QLqniQ==
X-Gm-Gg: AR+sD12nCI9OAotm4KcKJBQLSdXDu4gf0erBeW3V9L6b5Ng+NPFKyvPHUGNlKl50OAC
	nH8ASDSvLmmQU1v9+vLveZogiGFazz1Wgig4y8RLg4dqO+Oh/N6OBCNoyCP6/Szfr28Q20R7ttT
	zkoMM0RwvLt0C3LJolePk4TTqD+Oi5nRVVDS5O/t4l/FPz4rXF7FST34bf0/N0il/tiFOpl2tCR
	NdOb9+i2BtYuiQvMr28tD5MDvOXH50o7/t2E9mx6G/5Lsjc+7gt9moxKxB0xNZ/ge03Q1F+MAbj
	vvXXZBwPk+b+avqy8Nbu9UpTGbkBxxVzRNxfbUrHZ80=
X-Received: by 2002:a05:6512:2211:b0:5b2:f211:130e with SMTP id
 2adb3069b0e04-5b44e31916amr194307e87.37.1786501981558; Tue, 11 Aug 2026
 19:33:01 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 19:33:00 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 19:33:00 -0700
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-5-zhangzhanpeng.jasper@bytedance.com> <andiWrKhz5rLPVuq@x1>
In-Reply-To: <andiWrKhz5rLPVuq@x1>
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
User-Agent: Mozilla Thunderbird
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Date: Tue, 11 Aug 2026 19:33:00 -0700
X-Gm-Features: AUfX_mzrwSJAC7ECp6FZeYOMnrio9pumdwlfO90AszxP14I4KKFHzAruOFpbNJA
Message-ID: <CACnXVndvxVx+a3U8jbyMKwFPEz_ex8u1ima5OEh+vhuV=esbuw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] iommu/riscv: Program QoS IDs for assigned groups
To: Drew Fustini <fustini@kernel.org>
Cc: joro@8bytes.org, palmer@dabbelt.com, tony.luck@intel.com, 
	reinette.chatre@intel.com, tomasz.jeznach@linux.dev, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net, 
	shuah@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com, cuiyunhui@bytedance.com, 
	yuanzhu@bytedance.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Drew,

On 8/9/26 1:07 AM, Drew Fustini wrote:
> On Tue, Jul 14, 2026 at 09:06:54PM +0800, Zhanpeng Zhang wrote:
>> Program RCID and MCID for RISC-V IOMMU groups through the device context
>> TA fields. The resctrl group assignment is per device group, so reject
>> BARE mode where only the per-IOMMU iommu_qosid global default is
>> available.
>>
>> Validate every group member, firmware ID, device context, field value,
>> and QoS ID capability before changing hardware. Then update all members
>> through the checked IOMMU group helper so a validation failure leaves the
>> group unchanged.
>>
>> Serialize DC.ta changes with context setup under qosid_lock. Change only
>> the RCID and MCID fields with ordinary accesses so fixed DDT mappings are
>> not subject to atomic LR/SC operations, invalidate active device contexts
>> after an update, and clear the IDs when a device is released.
>>
>> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> ---
>>   arch/riscv/include/asm/qos.h     |  16 +++
>>   drivers/iommu/riscv/iommu-bits.h |  15 +++
>>   drivers/iommu/riscv/iommu.c      | 200 ++++++++++++++++++++++++++++++-
>>   drivers/iommu/riscv/iommu.h      |   3 +
>>   4 files changed, 232 insertions(+), 2 deletions(-)
>>
> [..]
>> +static void riscv_iommu_dc_update_qosid(struct riscv_iommu_device *iommu,
>> +					struct riscv_iommu_dc *dc,
>> +					u32 rcid, u32 mcid)
>> +{
>> +	u64 qos_ta = riscv_iommu_qosid_ta(rcid, mcid);
>> +	u64 ta;
>> +
>> +	lockdep_assert_held(&iommu->qosid_lock);
>
> It seems that qosid_lock is not defined until the next patch. I think
> you should move the definition to this patch so that the series is
> bisectable.
>
> Thanks,
> Drew

You're right. qosid_lock is first used in this patch, so its definition
should be added here as well. I will fix the patch ordering in v2.

Thanks,
Zhanpeng
