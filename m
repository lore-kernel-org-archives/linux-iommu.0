Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155142C506
	for <iommu@lists.linux.dev>; Mon,  3 Aug 2026 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781183; cv=none; b=HQJ0mVEglr8PLrFWAD++nIJqTaUhjNDooyk/i0IaZGa17hXPZBsZKUWEXkqUt2Tobv8b08MpRyF83ygqUzCvDzjTpIkZRH5829VyiZljUY04mdbbx/7TpFMxwEo9HPBhTKceCSlW4UJMtWtMGr85xUqtx/l1mXLtwRsNJhEzVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781183; c=relaxed/simple;
	bh=dT3CK7NGp5t69RaPY8skYZh7DTJ8Ou8/q30Q/gQN4VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JexUMYSlq5uU91y1MdL6ZIoH9PzQjbO+/EV9y/19RGkDA9wBjCtlwJB6S241Iqy182pLBgJ5Fzgdi0e6AoPHVNaFB8716qWI62ulQw7Kj4SkaPtcMCAO+X2si264rb8np5cRW+raubvmdiDKnhPnVammgEU/k04x5FZBr/XRQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E384cUOt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E384cUOt"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab97c86bdso21735ad.1
        for <iommu@lists.linux.dev>; Mon, 03 Aug 2026 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785781181; x=1786385981; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dT3CK7NGp5t69RaPY8skYZh7DTJ8Ou8/q30Q/gQN4VE=;
        b=E384cUOtMtmi4UipKWGrB4l61Zj0kjF6l9Oh0P0GOA0iYR3Jf7oubc5CkQE+/+83T9
         WSFeQNRvu5I+yXDxMUndWq2yEH0Mlg+/T/rBVnTLh/BssRohGC3AWCA3I2Zz5c1E3gnv
         MNdDgk/EYnq3PTy1VccLIG3S40I2vgKWBPyNf0MWdhWLcmN2lakUcYXbnGvysePemfuv
         KuIDX38yUpOMBaTepG3cH78WTjLGuW0hl62cFV3SYr+hUmrfJKrOmalxwWX9ODdZALfa
         b/KacSEbealLuEaGbGPY8B0BJXQHdu0rtA7G5NnZjMg9Mht//gWlrxikhoai5ksuOxuX
         LqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785781181; x=1786385981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dT3CK7NGp5t69RaPY8skYZh7DTJ8Ou8/q30Q/gQN4VE=;
        b=INFFMkn/P4QMifV0zIMRvlKT/eCycG8/xvXqQ45kQmkKEuNTHOTvRGXY9AuKPCs0lF
         L1wIiV5fX575zANKfY216sVXNdrpSOuoH+uiBoSlp9CTApZqnwTFl+9zHeYvJB1HbBta
         CSw37vmMvbjTrsaGxM6d3X53fS2HWKXkDtT+rUZd9COa7BunYRlKGDowuzt1fzwYHucu
         AutIKoloUxbIotA2hEPGZGcNLA22EzOtaxmkPE8ROguzut+mga6v6/32YHu/47Oz7gmF
         gK7EC9JOLjEEvU5mWVxvqGcbX0pHfGDvjLoscbDutvpp5/4VtdiQMytk5QYxn3RK9RQD
         /Ltg==
X-Forwarded-Encrypted: i=1; AHgh+RpVDYUCqNBm8o/vdJKdKAEJ+2v3e405SsZ+5swYZoF72YroPacq7CPBhJQ2aemKmqhDEy7fHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVBXlUrXlForoT9+HdJFzPDB5+WX1gRytwrnPXjWWSj4vwfjO0
	83T9Ox80ljdrH8dDb7s+PGuaFc4NF9JCpczI4IWcoyTfBsjOP8LTA50Zz8WlHAL56Q==
X-Gm-Gg: AR+sD12yOmht7LUdeQR6DnFnw/dDS0DD++8JIP6Xnn9taydFakGIppFPowf274Sq8LV
	/gjXD8gcGR2lxxeCAUnQnpcorVEYlKGpiCBI8AgEahAmnW+D5mcZIQ/UsM3hf1/njo35qbc7wTT
	s49FhIqHVQaHnfKLLqr02iilJz8BNVg6hXIqndWQpETEkK+iq4UqUvdPCqiSKTDv0oOYT++F+Y2
	ehzEjsVcJlRPDhM7t6xxOTaSfTaWjPmwVtgEma/humF1nuLuh21ie+T95ouk4MxyYjCwTe8ysGt
	lv7be/NTfVrlQCBcmnIf1N3jnlAucXQpCy4CMNiuqZDKIa67jNsRr0J9GBo5hPrvk2CJCy7+pKA
	G1wIYN+N15rmizn25LyJpQrRcl3aRo2W+CCi7DeMB6PpMrMJZ3QRmxB91+ud7L+MUpzzQ9oGxOR
	9TW32YVLR5iN9h2XtuSMLCh6dzS73qZkVfaQHy0nEqa46+9DNsRpSFGRibXPV6ej48glL0kCq8H
	aAr0KD8+T+6hrUuHiqZgLnWmIXxD37SKH62nn7Zj+1dW8t/CzjfXYV6bxc=
X-Received: by 2002:a17:903:8cd:b0:2c0:defb:557e with SMTP id d9443c01a7336-2d08cda9b92mr1073765ad.1.1785781180682;
        Mon, 03 Aug 2026 11:19:40 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b165e99sm41804515ad.83.2026.08.03.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:19:40 -0700 (PDT)
Date: Mon, 3 Aug 2026 18:19:36 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 5/5] iommu/vt-d: Flush context cache with correct SID
 when tearing down aliases
Message-ID: <anDbfCdtFJ7SViYU@google.com>
References: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
 <20260731054329.2948252-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731054329.2948252-6-baolu.lu@linux.intel.com>

On Fri, Jul 31, 2026 at 01:43:29PM +0800, Lu Baolu wrote:
>domain_context_clear_one() and device_pasid_table_teardown() are both
>invoked once per DMA alias of a device. Each function locates the context
>entry using the bus/devfn pair provided by the pci_for_each_dma_alias()
>callback, then calls intel_context_flush_no_pasid(), which constructs a
>device-selective context-cache invalidation from info->bus and
>info->devfn (that is, always the requester ID of the device itself).
>
>As a result, for every alias other than the device’s own RID, the context
>entry that was just cleared in memory is never invalidated in the context
>cache. Hardware may continue using that stale cached entry. In the
>scalable-mode teardown path, intel_pasid_free_table() can then free the
>PASID directory still referenced by that stale entry, allowing the IOMMU
>to walk freed memory.
>
>Fix this by passing the source ID of the entry being torn down to
>intel_context_flush_no_pasid(), instead of deriving it from @info.
>
>Fixes: f90584f4beb84 ("iommu/vt-d: Add helper to flush caches for context change")
>Reported-by: Sashiko <sashiko-bot@kernel.org>
>Closes: https://sashiko.dev/#/patchset/20260602233426.357499-1-baolu.lu%40linux.intel.com
>Assisted-by: Claude:claude-opus-5
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>---
> drivers/iommu/intel/iommu.h | 2 +-
> drivers/iommu/intel/iommu.c | 2 +-
> drivers/iommu/intel/pasid.c | 9 ++++++---
> 3 files changed, 8 insertions(+), 5 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Sami
