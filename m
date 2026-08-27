Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2601E495527
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857068; cv=none; b=rk7oz1Izy63d3cABb4bBG+GOrhP9yd6K3swjF5XpaBTQLUN2N5bfz+Yt/PSuaeVvvB+ZvpF7sRi9kwz0UKdf3drScjYJyssZ6rn4R+ZjqcduJ3TD54OI1OXtJwoJrC166syIjWaNIr5LlevyI3kysrwtmF4XCmhJbgaVUDs4GCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857068; c=relaxed/simple;
	bh=mAHHUsoZXJKt4PRoppmG4agr4sysisrSRDaStOA5n88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u28ga93Q3DMgEmJJsPer4IsMCegNp5BG21GjhTI+T2abhB1RBPzKh3q8MyzwBplvgjp9emj3TqrWBAx/h9YNhtSLjSp12Er0U06Tsb4ug4yj1Y3Iwu2LmsgWeqiqc4xhwxRSMH5rzJVdHNSnz+Ur0pjGCXrAudQegaa5caul9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzncRZWE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzncRZWE"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d3b445a84fso23175ad.1
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787857054; x=1788461854; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aX0MxhiMRKYlP1maDxCRQnyd/bhRIltclM/n9JE7KG8=;
        b=dzncRZWEi5Yh8sHaccb/+dbuOWRGBAgOUlM0whoNAHXDMWWfhiXZlcEGQ4TOws6qCa
         UHowIngVkaV1DHlWjWALgSGSkuv8GZpy3RgrVHNUcS9dAU+Sy/Hyx1bi9s5akldx2T8q
         XbE4FZ5wCvRoMKg2CWfXVqYcAIn+PFkhTavsUFZptOQh/ycPb1RYBho05LRpX18Qhkig
         NX4JIhMxcUUjdRV47nR3lEGyMQTHsX2MbYzDNvXKsnE6s+RYiYcUw8ceuuV1I1woBNbM
         3plg1VUjkPmTdA9X5VJf/O8U4t8YLqglvHqz6TwUjwVMBCKqnpmVan3C6gSB1FvV5v2p
         ah/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787857054; x=1788461854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aX0MxhiMRKYlP1maDxCRQnyd/bhRIltclM/n9JE7KG8=;
        b=iGtRxO5mZtGAy5bZNmhGPNqLGih2CLzv42lSLM6U1lHcOr/sc9iWlLFj58aVyRJs8w
         J8pxkUhQ0wVWhGc9gBeqaq2QsByI73fuaXyDkrqtGmadBDFBJjBIxNlPbMa7dDGEgiio
         bLx0JwwuowhvgaHGbIi3Siq/Y49SI5hIWX1saLlvQLUDZV2FFzbckMQTC9nNMa8+UNrJ
         NCfYRPHvB6pqQXPrbXlQi5wUJIvZ+fr3TblKpdVsdmBHkhmyfaMFaJTxyQ7PaUhmLP7a
         oO7xHNybt0GVJgycGu/+CvTWIbf7ECXXRTQlsSz4sx05ziFChlPmw19USKmaP6OTCMKs
         vSaA==
X-Forwarded-Encrypted: i=1; AHgh+RokCygQuGxVa0GQp0XPAmjIpgnRuIFSrSSPtkwq7uL1MQJsRMH+9OtJTDQQ3nUxA7MDoER3mg==@lists.linux.dev
X-Gm-Message-State: AFuF++nh0BiMoewGilPsY3Z52W0aGdQvx3/rn2p/+ylGwWE2IhHrczs7
	GlJhl2WX5kxBPBDsSaoDUtDRvTWoGAbDfMvYJRrCRa+I8AVLeXaamwZuJdnutFbO5Q==
X-Gm-Gg: AR+sD11v+4xSetTkzSHBRiqmnIT8simOSDQrEQ3oGOeTbCIsB8kk3LQ69X1glKqXcaI
	vL1a00kEX/J4sHb9MvOe/+to+MQq3iR71y0wDnmV3gNoSgAOAjTCQZkDiygBaH7CDkOg6F81Dhv
	NIxSvEBM9DCBFiqZzEQRkRzQ3p8FQdVh8S4EMcM1e0Mp9exQiBmWjPq9MJPNwP7GVzYEeZDlZYF
	oi/4WVvms9zpVtKQFtPspoUiLaCEEfQaCQFNcOx8xl0CkZdA1RY18muAvvbAZtdaj2GX7+Xaya8
	SSyd8c3mufFpM4J3UC7eACausX1DwNQ9W113gSiMD9HK4st6bM5QXT/WVEMzl4ZxcfowN7sYw1e
	NsUR1hNGaIA0izUEXd2IfYsxUpQ7yMFbm+65NZWlYZikzf9BrIA8BeiHfK+WNVw5rKYyjjiUhKA
	urPVwTZZ/uLpkG6t79lbNy9L2Aale77hDEYNpTOjMYiJgTibyUSrDpn/ArH5DZ391b1bkj7rcGx
	xnxqDZ2IBNnay4xYETY3tD0vd413zlIV4iObMYhzwZJbQ/zvDGRi/0cq2E=
X-Received: by 2002:a17:903:2283:b0:2c7:a13a:7fe6 with SMTP id d9443c01a7336-2d74f558e3amr1143855ad.10.1787857053361;
        Thu, 27 Aug 2026 11:57:33 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0d44651sm3782064a91.4.2026.08.27.11.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:57:32 -0700 (PDT)
Date: Thu, 27 Aug 2026 18:57:28 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 08/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
Message-ID: <apCGj7ePWtmpnOzk@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-9-skhawaja@google.com>
 <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>
 <ao9ADjoGzgNX4t1M@google.com>
 <5862e3cc-e7e4-43be-a829-8569d12d6bb4@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5862e3cc-e7e4-43be-a829-8569d12d6bb4@linux.intel.com>

On Thu, Aug 27, 2026 at 02:09:26PM +0800, Baolu Lu wrote:
>On 8/27/26 04:30, Samiullah Khawaja wrote:
>>
>>>>+static void clear_unpreserved_context(struct device_domain_info 
>>>>*info, u8 bus, u8 devfn)
>>>>+{
>>>>+    struct context_entry *context;
>>>>+
>>>>+    /*
>>>>+     * This cleanup is done during shutdown, so it should be 
>>>>fine to only
>>>>+     * clear the entries here and issue one global invalidation 
>>>>later to
>>>>+     * invalidate all cleared entries.
>>>>+     *
>>>>+     * Note that the device IOTLB invalidation for unpreserved 
>>>>devices is
>>>>+     * skipped this way, but that should not be needed as the 
>>>>devices are
>>>>+     * quiesced at this point. This should improve the 
>>>>performance of the
>>>>+     * cleanup process and avoids any invalidation timeouts 
>>>>because drivers
>>>>+     * might have moved devices to D3 state.
>>>>+     */
>>>>+    context = iommu_context_addr(info->iommu, bus, devfn, 0);
>>>>+    if (context) {
>>>>+        context_clear_entry(context);
>>>>+        __iommu_flush_cache(info->iommu, context, sizeof(*context));
>>>
>>>For tearing down a present context entry, please follow the VT-d
>>>recommended sequence:
>>>
>>>- clear only the Present bit,
>>>- flush the updated entry to memory if necessary,
>>>- issue the required cache invalidations,
>>
>>Do we still need the individual cache invalidations if we issue global
>>invalidations (context, pasid-cache and iotlb), after clearing all
>>entries, as they would be done if a new root table was being setup?
>>
>>Looking at the VT-d specs (Invalidation of Translation Caches), each
>>invalidation type (cache, pasid and iotlb) defines granularity in both
>>register and queue based interface. And the granularity indicates that
>>Global invalidations clear the cached entries for that specific type.
>>For example following text is used for each cache type (in queue
>>interface):
>>
>>   Context-cache:
>>   Global Invalidation (01b): All context-cache entries cached at the
>>   remapping hardware are invalidated.
>>
>>   Pasid-cache:
>>   Global Invalidation (11b): All PASID-cache entries are invalidated.
>>
>>   Iotlb:
>>   Global Invalidation (01b):
>>   - All IOTLB entries are invalidated.
>>   - All paging-structure-cache entries are invalidated.
>>
>>A similar note about using Global invalidation is suggested in the specs
>>when setting up root table (Set Root Table Pointer Operation).
>>
>>   ... software must perform a global invalidate of the contextcache,
>>   PASID-cache (if applicable), and IOTLB, in that order. This is
>>   required to ensure hardware references only the remapping structures
>>   referenced by the new root table pointer and not stale cached entries.
>>
>>Also please note that this is happening during dmar unit teardown and
>>system shutdown, and while the context table entries in root table are
>>being cleared, the memory is not freed until the global invalidation is
>>issued.
>>
>>Since this is during shutdown, issuing global invalidations instead of
>>multiple individual invalidations for devices and aliases is simpler and
>>would likely also have shutdown time improvements and reduce the
>>blackout time during liveupdate.
>>
>>Please let me know if my global invalidations and granularity
>>understanding is not correct.
>
>The global-invalidation approach (similar to the “set new root table”
>flow) looks correct to me.
>
>On the device side: if ATS is enabled, some translations may still be
>cached in the device. My understanding is that unpreserved devices are
>already DMA-quiesced and then go through reset + reprobe (as in a normal
>reboot), which should flush those device-side caches. Are we aligned on
>that assumption?

Yes, we are aligned on it. I already added a note about unpreserved
devices being quiesced at this point, in a comment above in this
function.
>
>>
>>I added a comment at the top of this function to explain this, let me
>>know if you want me to expand it with more details.
>>
>>>- then clear the remaining fields of the entry.
>
>One important point remains: even if cache invalidation is deferred and
>done globally, we should still clear the Present bit before clearing the
>rest of a context entry. While Present is set, hardware may fetch the
>256-bit entry in multiple chunks. Rewriting the full entry is not atomic
>(it becomes multiple CPU writes), so hardware could observe a torn value
>(a mix of old and new fields), which may lead to undefined behavior or
>spurious faults.

Ah yes, I wanted to write that in my previous reply but it seems I
missed that.
>
>So the recommended sequence is:
>- clear only the Present bit,
>- flush the updated entry to memory if necessary,
>- [add a comment about the delayed global invalidation approach,]
>- then clear the remaining fields of the entry.

This is exactly my plan for the next revision. We are aligned on it.
>
>Thanks,
>baolu
>

Thanks,
Sami
