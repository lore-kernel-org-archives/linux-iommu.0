Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48F379C43
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786502326; cv=pass; b=W0fG0NWuhzfjzCv2Z1KEGRjc0hDj5eEBRzG9QPHPIoRZgOrhX4pFioKaIIrnWDd/SceGoIvln357FJxHmkjzp0+sN8I3YVw0IxG2FydqsOzUoxDVtPzkCJ3YeD+P6GCwRMGEQ1WJLCH2lHAU/uBrvTBivWqIoZWVvlZ8Sxv5Ljg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786502326; c=relaxed/simple;
	bh=paVKL8uujOZXf9sEomzLIUC31zXEINH59NqUPFZaing=;
	h=In-Reply-To:From:Mime-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGh5D+L720N9oonEyNagR9BZHx/5mtMeUYaiF18uUzldBW2becrkehMHSfLZXz6odRVXo/LheMnrdT9kACUMqCmqRYKEibigSKoz1oYaJljsEbHXTr2he7Cijb526hhDeM/90sLR8CCyep3hh9bbIa0kz8nogRjqFxhTLBBeQkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Cq8ny6WS; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Cq8ny6WS"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39fa5e3a428so4144371fa.1
        for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 19:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786502323; cv=none;
        d=google.com; s=arc-20260327;
        b=nhViF914kvsCtTDh3Fbg0OPfaPhBmer7ig/kUHEOWXjmiVOVuS/qgfW6kM/BckF3Q8
         4qLITV/GvYwVB4VDBUuJnPcJOMdevyhSDMKjkC7/8Hzxwl+bQ6HDl8Qa2kPPQFXfg+kN
         1DUs+5Z1owfvMEVqz2O0hC3uxD5qRs3ZB3/7CarzdE52RnEVcaKZuHrkeMRsL0txEdE6
         dGZcdUT3I/PMWMuTo3waD4iY5Xj+tOmXvlrwWgwOobXNdkPxO/dIUw0PSbjmJIFxyoI3
         fodiEPBfh4i5H/VB84IbJqXLVomVV8ABpzKYa6CYq5NoBdu/xACxsdZ93j6lprKLyTOJ
         xnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:mime-version:from
         :in-reply-to:user-agent:dkim-signature;
        bh=xsPbH6RVpEmtv3mDSTBrJpAsPxSPG2QtDyPYl702kZM=;
        fh=iBSmuqFtz0vJ7F5SvWFqTCSDhJ5beSHyuss1rRI2Eyk=;
        b=nb7qaGuHdVimSh4xgVhoCbuKT1ywnU/B9AQly9V85Kk8sZupVitfJJATeU8l3/g4bu
         26SF6Y2tci0Lu8cjQ/rIxPlGTxt88qmduh+5oA6xE1bhM77S+LupcYXGL6oUGrJByUsK
         XDoKnquXqSrYxoKESpCdKfQuDxTLMzWWPlpyat0oJV0oCgt0vQr0O5N1FT0RzDLsC0Zi
         BPuVlPGzvNKMbIgju7dUS08XCEUjnG3L3VIkTtEnkllfF04Kq/WRl9deBulfL1+8oo3r
         4legquYI8lSQVGQMmcHhJk6mAYDNzZwzcxfUwZWzdnQb7gFN4Zv9JuT5BZVmMXZZPflH
         8OXw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786502323; x=1787107123; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:references:mime-version
         :from:in-reply-to:user-agent:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xsPbH6RVpEmtv3mDSTBrJpAsPxSPG2QtDyPYl702kZM=;
        b=Cq8ny6WS1FBSPBLHqkuZCc3EpHEPSUMRnNYKsioi4E4UnuZLiNTGOsd0xH4H0NLCYW
         jO1Vf/TyDiBWdVyToTecSs2UCSm0CAGoBi7V8qMZWyv5cUy/qHPNP7VDqEJwwCNAXA+g
         pli1rZnXfe/uv6/yKalGjx/ksUpIiqqPBLuMTS1W6eeQp8Lk3cKg+CN3L+nQDfLKaOnn
         r8peiUUCnRbl5e8++PKFgvnzz7pm47CnbeVf3n591qDxq9kJQNXjzAIDs6lIzSuinUql
         iI46lTPwZpOa6r0GSaArkQLVEVqhMNaWdNtFwstw4gt0z7IftPNN4A8NFd14IIuqadnL
         eX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786502323; x=1787107123;
        h=content-type:cc:to:subject:message-id:date:references:mime-version
         :from:in-reply-to:user-agent:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xsPbH6RVpEmtv3mDSTBrJpAsPxSPG2QtDyPYl702kZM=;
        b=VYm3QmCUTveRcRjYo3VqM719YuGOWokp+vuxTF+R3s8mAMgrf8nHBBEZdoJtRqCJgI
         ZS8Y8HOUWiR77oeGiZQKIjeL4CclqEUMbADu0rbDEZiVVS2y2ujZM/P/soeBFLhvufCR
         9ibB0TnHWx/ziSqHp6KDWTSAMfAA6p1xAXzQ2ITAzyI/+KkS3kvxWMjI0da44H1PwSC4
         QoxUUPEvyIvUNSZHbjwGynZKrPe/fMfwmD8EE6VJVV4tH//BUDc7IuyF7u8FtGWgOnQj
         ePy1N86TRjM3VbMjoUqasu+je/BOvaWs2oxP4aXX+WE6Q2TNWDaJL620hbN4d0za1QcQ
         AXlg==
X-Forwarded-Encrypted: i=1; AHgh+Roce87CCGp++p9jL+F5Pxhu7SpM2J5nEWqfd1hCRXKC7ioO6H/WI7ftNalK6nB2RHzy+hx8DA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXpdGdEKjjyre96vl9cp7F/fbwdzqBgvb25W3SXp+4Tz5ppM/0
	uVFhsa8fiNZT2gx7MCRRiINwkPUuhSaJAa6Qoo98g7Lxd9yp/TN4ISg1o2E+1B/R4FpKGZVFO/0
	ZcCsOyHHkIJOY7mS7oql0EwJe9ayaLadfc4EqvcbEvw==
X-Gm-Gg: AR+sD11XSVECqxHqm/mHpq4DGU9S15iYIpT153Uo5VPN4jqzdh/QC2Ri/vWnb3l8NRP
	Z/9XThcV0Y6sCblJYHJNdqa+tF7wKJw/LumzuLkxBfjkKm71FyYfQGok0T4pfI5D759aQuSHk6C
	y+b9PLkYXbUj6sf7VwWHRwQzUr2lEaM4ocbnZcRd4OMEI0xP2YRPORoTjzY9Vb6VZC/Thw6LHNO
	Gx2Lbq5F+3foi/ypYbAvH+z7hQ0LQP8KuilKLncFs54VambWvdzAQQPYNA8piiMX0/cbcmNAUGc
	xnmVBfXVTJcVCT2ITZqW/pUS3BeO3kvR42hV25tO+54=
X-Received: by 2002:a05:651c:b21:b0:39c:753a:853f with SMTP id
 38308e7fff4ca-3a10d18f514mr1416711fa.3.1786502323254; Tue, 11 Aug 2026
 19:38:43 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 19:38:42 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 11 Aug 2026 19:38:42 -0700
User-Agent: Mozilla Thunderbird
In-Reply-To: <andiub47zsUsL4qh@x1>
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <20260714130657.46963-6-zhangzhanpeng.jasper@bytedance.com> <andiub47zsUsL4qh@x1>
Date: Tue, 11 Aug 2026 19:38:42 -0700
X-Gm-Features: AUfX_mzVF_qtHGnSgVqubj7FrTSqgmuPuhnXiNhwESKsg66sjHqWMZRBEXVi9Ls
Message-ID: <CACnXVnd14LEAOfakzpasXnteaVfZo3nsH1a4fEjvHNOQ8bMeXg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] iommu/riscv: Expose global QoS IDs in sysfs
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

On 8/9/26 1:09 AM, Drew Fustini wrote:
> On Tue, Jul 14, 2026 at 09:06:55PM +0800, Zhanpeng Zhang wrote:
>> The RISC-V IOMMU QoS extension provides iommu_qosid as a per-IOMMU
>> global default tag. It is used for IOMMU-originated DDT, CQ, FQ, PQ, and
>> MSI accesses, and for device-originated requests when DDTP is in BARE
>> mode.
>>
>> Initialize iommu_qosid to RCID 0 and MCID 0 when the hardware advertises
>> QOSID support. Preserve reserved and WPRI bits with read-modify-write,
>> and use register readback to reject values which the WARL fields do not
>> retain.
>>
>> Add a qosid attribute to the RISC-V IOMMU class device. Reading returns
>> the current RCID and MCID values. Writing the documented
>> 'rcid=<rcid> mcid=<mcid>' form updates both fields while preserving the
>> other register bits.
>>
>> Keep this interface separate from resctrl group QoS. The sysfs attribute
>> controls the IOMMU-wide default, while resctrl device assignment programs
>> per-device DC.ta in translated modes.
>>
>> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> ---
>>   .../ABI/testing/sysfs-class-iommu-riscv-iommu |  27 +++
>>   MAINTAINERS                                   |  10 ++
>>   drivers/iommu/riscv/iommu.c                   | 159 +++++++++++++++++-
>>   drivers/iommu/riscv/iommu.h                   |   9 +-
>>   4 files changed, 202 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu b/Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
>> new file mode 100644
>> index 000000000000..b0cd68997f17
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
>> @@ -0,0 +1,27 @@
>> +What:		/sys/class/iommu/<iommu>/qosid
>> +Date:		June 2026
>> +KernelVersion:	6.18
>> +Contact:	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> +Description:
>> +		The RISC-V IOMMU global default QoS IDs for this IOMMU.
>> +		The file is present only when the IOMMU reports the QOSID
>> +		capability.
>> +
>> +		Reading the file returns the RCID and MCID fields from the
>> +		iommu_qosid register:
>> +
>> +		  rcid=<rcid> mcid=<mcid>
>> +
>> +		Writing the file updates the RCID and MCID fields while
>> +		preserving reserved/WPRI bits:
>> +
>> +		  rcid=<rcid> mcid=<mcid>
>
> I think it might fit sysfs better if the rcid and mcid are separate
> files in that directory. Is there a reason you combine them into one
> file?
>
> Thanks,
> Drew

Agreed. There is actually no particular need to update the two fields
together; combining them was mostly a habit on my part... I will split
the interface into qosid/rcid and qosid/mcid in v2.

Thanks,
Zhanpeng
