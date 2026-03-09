Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D93BED2A
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061300; cv=none; b=PkJ8xiKGLZZxhBVskqQEUVQliuA2T3RR2d2PzVjgLVseIBoKsL390mRGIQVBP99dt20Jhwek0AEVzQK04EeR5/NOB+QdE8TBYf2uvm3uG2TEROSV1BGqgTHAPE7QVibw8IIaO5kcliUKGiFBPJUQ55yVb4g8R9zldKXZ2WuI/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061300; c=relaxed/simple;
	bh=PkTbINFVaFCLBX8INx4Y8qGhkNCUftkmgaPAZo5ZF/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQAYdokq9PIgKfN1tlONaQW6qqxPTPEXjM1p1YzlYhp1LyvkER/u8bU5WFvcf61Fe/dugG+nn9WyLHd+wQfbhLdOFDFCQbGyzNWxR8lppU5N11aQ80ljOf7iG2MmjPIbKEvPuJA9GZZJaCZW972s4gm1meILbFheWhSziooxcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CTRfsdag; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CTRfsdag"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso106651935e9.3
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773061291; x=1773666091; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1uSgKALRT8QjmGeRtwIR5Sg9BvduvH1KsXj/bwOWs0=;
        b=CTRfsdagwrZdzf2+WtqGyPNe+WZuosYE2nC+RGRKNo3sbMXwMFyfUOt+Y8jBi6R/wx
         j9itqGB5wRy854e521SRKO5820OlZZtaKdtndptszWfJfduWLnPEKG2l0RV6899+Xa3/
         sU1xsC6eAE5K+pIP4cxCXTBVZWON9bhxowu7T5ophbidriHnkGln6vB8wNsa2ru9kLkf
         OXEzQLvmBvCCrM5r+zBLsgEldzKA9K9JY4uqT6AHFVKtu3VoGWpYdq8YgNj88nFMHAsH
         io4jqxGNqnbIdps42MGRHeCHipkZN3Pgq/U6CekTM5KLVOg0PZ1bVeionHeZ5KRDAQLx
         waYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773061291; x=1773666091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1uSgKALRT8QjmGeRtwIR5Sg9BvduvH1KsXj/bwOWs0=;
        b=pOQhA/6WpDK9g0ViWCa6pBoTIiUI0ET3sLUNDR0WmgiV/AreKx+fwNa3fypZsUrsvN
         zpX3OAzFV6mWfLUaPnO+W/ZmD9rpl4IEyifa1umNEKCBgIuUsaOZk72pOx423DVrSzSa
         NPxxTHuJ2o9VPezXgdC/bzC2O6bK0vJ+Sk0JJFClyYstnjLcOIu7S7fDP6Hg2xsZ0jrD
         oLgdMLoU2t3hZR8Ni770suEJVeHh/2Z9Duc+20V7cv5uIcVboklNLI64Ws5Gj17h20jY
         Ceks/Dj4U/deHY0LARh6NMBuZMPd3jSIEjaq4yJBXsyTjsxqTuhHNn0hb0E9amge3PcZ
         FaDg==
X-Forwarded-Encrypted: i=1; AJvYcCUKVJ6zq9AP0MIR/ftglLIG1r4IdTCiWmeq4LbC0qxSj31Ato+SAVsy6ZDdc7o6oOE1WOaK1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAVSDpHk/iZ+ZnjfXVzSDZI1x26qeR6XAOsr96Jj8wJtJ7QDz9
	s7bosyeoCxpm5dBA8+VgsUNtEeC8Lqve3gd2l9qBkfo1g9S7uHAhzY3T0oAwq7+rieg=
X-Gm-Gg: ATEYQzyCB62xfexQuq3XY1JY1LzmSrZwmch3P4XaVso6E+gHqhFSQL2GCIwtPzKrK+V
	AC1bMOcFAacFZtTGH+B38kaLBSukWrCSbnCTCiaHGbQZyFnTEJ3MWkJcxtHbpiulK+TS7cg0FRh
	IBXtAKXKYTYx2JpFHlDdq+NHefcQQBsRKZJT5RuLBTSvQQYUl1bsB5jdpOF55ZUcO3eF5e1BwHM
	gW6A6mMt1/SooqfvGcpEie/x+VFeJcgV5xxvHTjVb80JlLXeJgStpf9vWl9Etr7jYkfcQ3f34oV
	8yCpomYVZ5AfUlXqA3ic3N566DbkpHrhud1vXLxvTQVruT/HYulUlhGv2nawjdfiLva5S+omjsJ
	sXMTvcroBSOLkz2HKDXt+E2pDFzNS2U1eUXM7RfbKHXN1h5P2niwEytVq+rDXBSNcMvW0GedWfy
	1muOJKphgFhT9cFvriusTdJt1b75uLx+AYVVxSAMHHHA==
X-Received: by 2002:a05:600c:8218:b0:485:3692:e8f7 with SMTP id 5b1f17b1804b1-4853692eaf6mr73833215e9.25.1773061290855;
        Mon, 09 Mar 2026 06:01:30 -0700 (PDT)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853a498afbsm64496685e9.0.2026.03.09.06.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:01:30 -0700 (PDT)
Date: Mon, 9 Mar 2026 14:01:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Tesarik <ptesarik@suse.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, jgg@ziepe.ca, 
	leon@kernel.org, sean.anderson@linux.dev, catalin.marinas@arm.com, 
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com, 
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com, 
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/2] dma-mapping: introduce
 DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
Message-ID: <byfhwrnq76ylztrjc67ia5tlzgpihh3ycv53je3jekkbqltcad@sslumibsz23v>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <20260305123641.164164-2-jiri@resnulli.us>
 <20260309135610.1f81d2df@mordecai>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309135610.1f81d2df@mordecai>

Mon, Mar 09, 2026 at 01:56:10PM +0100, ptesarik@suse.com wrote:
>On Thu,  5 Mar 2026 13:36:40 +0100
>Jiri Pirko <jiri@resnulli.us> wrote:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Current CC designs don't place a vIOMMU in front of untrusted devices.
>> Instead, the DMA API forces all untrusted device DMA through swiotlb
>> bounce buffers (is_swiotlb_force_bounce()) which copies data into
>> decrypted memory on behalf of the device.
>> 
>> When a caller has already arranged for the memory to be decrypted
>> via set_memory_decrypted(), the DMA API needs to know so it can map
>> directly using the unencrypted physical address rather than bounce
>> buffering. Following the pattern of DMA_ATTR_MMIO, add
>> DMA_ATTR_CC_DECRYPTED for this purpose. Like the MMIO case, only the
>> caller knows what kind of memory it has and must inform the DMA API
>> for it to work correctly.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - rebased on top of recent dma-mapping-fixes
>> ---
>>  include/linux/dma-mapping.h |  6 ++++++
>>  include/trace/events/dma.h  |  3 ++-
>>  kernel/dma/direct.h         | 14 +++++++++++---
>>  3 files changed, 19 insertions(+), 4 deletions(-)
>> 
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 29973baa0581..ae3d85e494ec 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -85,6 +85,12 @@
>>   * a cacheline must have this attribute for this to be considered safe.
>>   */
>>  #define DMA_ATTR_CPU_CACHE_CLEAN	(1UL << 11)
>> +/*
>> + * DMA_ATTR_CC_DECRYPTED: Indicates memory that has been explicitly decrypted
>> + * (shared) for confidential computing guests. The caller must have
>> + * called set_memory_decrypted(). A struct page is required.
>> + */
>> +#define DMA_ATTR_CC_DECRYPTED	(1UL << 12)
>
>I don't want to start a bikeshedding discussion, so if everyone else
>likes this name, let's keep it. But maybe the "_CC" (meaning
>Confidential Comptuing) is not necessary. IIUC it's the same concept as
>set_page_encrypted(), set_page_decrypted(), which does not refer to
>CoCo either.

Do I understand that correctly that you suggest DMA_ATTR_DECRYPTED ?
It's not uapi, so this is flexible for possible future renames.
