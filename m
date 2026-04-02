Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448353E3DA0
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775134571; cv=none; b=j3gzTTddf+Ayj20RL9T/va54J4+fB4hAcz2EKd+fnQz/NiPnAs+njfWwbvg8GBafzO4I6y2swDCPkp5/Tritf3ei4thqK/0qy+5XygUBA/wgC6uzJnablpVVoUBAMVyJ/N2qBAI4cwKcVkt6KZTGkzgqnwQab2s0jNS8Kqo4mk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775134571; c=relaxed/simple;
	bh=2p+a85skg1xtIimTdmJjZJySYA2FlAdgDf3eby1isD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc1Gw71IGyQY92MuL0vPvlPppLDU5TB4AT69Y0yCLckDpt6ytnHZVys7h3+jkn6N0zRpGdU7gGQoG9o6hw04iV36y81A2NkgsANpxVHNqetlWot2JBG4zqr/vy+g+yLcK0fcu917CabKupxfdxdGRFejP4tRvcJOmgG84VuQ5/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Y+tnG1FR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Y+tnG1FR"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso6821635e9.3
        for <iommu@lists.linux.dev>; Thu, 02 Apr 2026 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1775134563; x=1775739363; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdBGEtOVUOrqsu+m2DU0Xpq65+UG7RkCtVPt0Shx5yg=;
        b=Y+tnG1FRZculBCfN5RP271aj6wD6+fvevy+vMc8n9UNBHnOnOltAAf8Gq30RQVFD7C
         awd6muoodRarFwF2EG+wNTPg3aT/6/8wzsackyyDrrQh/jGyfEIo4kDf8CfzRmcJzaZd
         gHc/u9kRX1wvu5Jhk+1AFaftY+gE2o68NVhsZX1fOQr/1869Yqyg1xkQ185U0gVv8atY
         u583PNkLXGdUzzUbwGV9nZ8U9Q7pvHcKEOpb91USlaHjVCOzb0JYGAJ2SsahPAZXb4Y9
         +GPC7dxDa0Sum1t2ZZQU1my05f20p6X+XrmjOmhfG5JkHkzCm6S1QMA6+AO914q6FNY0
         9Tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775134563; x=1775739363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdBGEtOVUOrqsu+m2DU0Xpq65+UG7RkCtVPt0Shx5yg=;
        b=EyyFvwkX/79UtS1hoxXKJQaPf09xY2TEIlpIgDNKvK826bpmhi/rfMLNkQ+fauOZpV
         MmXDqO7n6mm7UO6jKQpcqNCUzOW4IZIy6k7y7y8W3wt2tuwz/GJJVdlcOwvvsO6RImm6
         OBwVnQk1N0qmL5K3SoQ+qlv70S0deVW72zZOxrUXyraTsrE4+uMKEvD+CxaY/iuXdGl4
         MIl/XSd4dUo0csLKHz8LxoOZ7xDwjyiSn3+6eE7DTpI0EMWpwDJDGcT2pL5YtJM66aYY
         ZH8zLHed45h4xV2VdMSNnsncAno5fzEWFra8YQAFjvpt/tSv5TDTobECR2M4HJb947VZ
         K3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGjJ8VDKtxyNTU0nWz0Cmrldt//bx70GF7HgKz6uEFa6dprzDuHWWrnW1zOKtgzZaJWZsqSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxY/+jYxykzRwBItwApVCdlxCAKwch5PR2i63KxyaLTWS/VD1u0
	oJnOWAhLaR9FbmEzHox+amxumrw1ADAWqdV8+zH7VZaNKPS6GuQtl9jW+QKYlfz0JL0=
X-Gm-Gg: ATEYQzwoESEZxUPaC4vN9j1kAy+GiZUKTXWd67bJ11T8q4Ndnf5OzhX27B+HCQL9/vB
	Ok4j2zn6jL7RfxgZueMkxNLP8pYSd4oo1AjZ7Ku+RGrcr2wf5FMuIBx67ByjzLSeGn1PjAmOrvV
	ftXM4queOpGaoLqAGQO4g/Rw0TGw4qkhv3KTkZAo1kMAp/3QjNTdMg5BLjVuIdTRus28pTRGrtu
	oUKq3wdzhuvAqDt4ZpnjGFKhmfQoi1nIEk/Ob7pYFXMmpkyx61pDuuGLkqytYFCs0PT5Bksjf6q
	C50picrr7j4M97nqZYKNLVUHlvBYqoThNJI64nc5N1oqEpNw2VFdSMlUC2v0kFyJB0OugWS8wNa
	23itGlXc5GCeahbe+AJ0AA+EpInWe9hwnNPqlPLJ74mJySFOwutfAON7vNZ8HiwFAMO/79M34Lw
	6dElzgnCOgSrpUDuFsz5xHSRI91uc+wsI=
X-Received: by 2002:a05:600c:a31c:b0:487:338:b4eb with SMTP id 5b1f17b1804b1-4888b7b89a1mr36557135e9.28.1775134563095;
        Thu, 02 Apr 2026 05:56:03 -0700 (PDT)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e56fesm7943310f8f.27.2026.04.02.05.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 05:56:02 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:56:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Maxime Ripard <mripard@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, jgg@ziepe.ca, 
	leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 2/2] dma-buf: heaps: system: add system_cc_shared heap
 for explicitly shared memory
Message-ID: <qvp2zepvwnlgcw36bcx47xouskuqk3tzjuomnhnwwg5ahiswt3@zbseau5arjho>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-3-jiri@resnulli.us>
 <20260402-discreet-glossy-perch-bda4f9@houat>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-discreet-glossy-perch-bda4f9@houat>

Thu, Apr 02, 2026 at 02:23:12PM +0200, mripard@redhat.com wrote:
>Hi Jiri,
>
>On Wed, Mar 25, 2026 at 08:23:52PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Add a new "system_cc_shared" dma-buf heap to allow userspace to
>> allocate shared (decrypted) memory for confidential computing (CoCo)
>> VMs.
>> 
>> On CoCo VMs, guest memory is private by default. The hardware uses an
>> encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
>> Intel TDX) to control whether a given memory access is private or
>> shared. The kernel's direct map is set up as private,
>> so pages returned by alloc_pages() are private in the direct map
>> by default. To make this memory usable for devices that do not support
>> DMA to private memory (no TDISP support), it has to be explicitly
>> shared. A couple of things are needed to properly handle
>> shared memory for the dma-buf use case:
>> 
>> - set_memory_decrypted() on the direct map after allocation:
>>   Besides clearing the encryption bit in the direct map PTEs, this
>>   also notifies the hypervisor about the page state change. On free,
>>   the inverse set_memory_encrypted() must be called before returning
>>   pages to the allocator. If re-encryption fails, pages
>>   are intentionally leaked to prevent shared memory from being
>>   reused as private.
>> 
>> - pgprot_decrypted() for userspace and kernel virtual mappings:
>>   Any new mapping of the shared pages, be it to userspace via
>>   mmap or to kernel vmalloc space via vmap, creates PTEs independent
>>   of the direct map. These must also have the encryption bit cleared,
>>   otherwise accesses through them would see encrypted (garbage) data.
>> 
>> - DMA_ATTR_CC_SHARED for DMA mapping:
>>   Since the pages are already shared, the DMA API needs to be
>>   informed via DMA_ATTR_CC_SHARED so it can map them correctly
>>   as unencrypted for device access.
>> 
>> On non-CoCo VMs, the system_cc_shared heap is not registered
>> to prevent misuse by userspace that does not understand
>> the security implications of explicitly shared memory.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>I'm a bit late to the party, sorry.
>
>This new heap must be documented in
>Documentation/userspace-api/dma-buf-heaps.rst, but (and especially since
>it seems like it was merged already) it can be done as a follow-up
>patch.

Okay, will send a follow-up. Thanks!

>
>Maxime


