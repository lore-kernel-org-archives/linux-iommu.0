Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18214F100
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674455; cv=none; b=mfb9QW2bZzXU4YdbQCKK3L3Qxw0U+E8BM/nzzjX6umIOGKmd1ZX8ScpqirVEfF8RQb+mf1RweuOA4cUUj++SOk50cwybkxc0ytpX9FnjM5ig4MpP1RP/0lWGE++Xo+wVImmmg+QitCqf3aVJo04mSmerM2+j3ekSqcjZ0093X44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674455; c=relaxed/simple;
	bh=WxId2LvoUbIR/HU8RV62Ck6iciJvrd83qvLCCe9IHtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=te9Q0LDBIF4AtaH9n7csTeKg8tskVrgRDTA2JM/DHr2XS/RlS8D1gbHWRjR4mfF2ly/uZPGjzbP0bFuTuf4Rq6SSAmg0FXPNXH42/F757nxv5fBUV4JXVacBGJR2amBZpTUG91xIOZjCVhL24nqfQoXOmaNTk9dvqsQybsbI9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8HvTNMu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8HvTNMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723674453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEl+MLJRfedULB1aDJQko5v2A6SsiXNnJ73kd73YG9M=;
	b=A8HvTNMuaApcWUgXaVssCWb1wzHlZJk0ORBJO4RulH6vJu3M3HDWf2k84ujR0R8204WHxD
	T9H3Bc+C0J667y9vulRMIrbRhgDTs976L0N+ubBj0Py2sT5Hya7wNlDDfvx9ijm/0tcrEj
	XD38syI5+GrSUs2TQ0Nq8X6oXbGjPeE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-0Rxh85GUP0WwSUvgdD2kjA-1; Wed, 14 Aug 2024 18:27:29 -0400
X-MC-Unique: 0Rxh85GUP0WwSUvgdD2kjA-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39827d07ca7so4040485ab.3
        for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 15:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723674449; x=1724279249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEl+MLJRfedULB1aDJQko5v2A6SsiXNnJ73kd73YG9M=;
        b=FImRVWOzuRY2WzBVcXdO0vn2xGy3JksM91/dZx+/raQTnMpxzJJIkywtqGXRZTx8J+
         1AkGfpFJf1LDn+HGGjQ2XIOdwXB3SKcYelnM2rWLr/YalffPSsmXuXMhhd3q5K17TOn9
         5lpPdvUix7IF6SFXi90/Hz0UnRw7b8WrqieKSZ3XfbYKeF66sfunVsmY5MJViargy5ci
         myH5Q3hLE39n7qqoLu3BkrmpdQkpSMih02OSj1dZPjUjUBmFW4sg2HA5z3qaDEZnZDQY
         Mg2GvJwtmign3KjDey8cyl/iM2e5MjelOLwEH8TtX+Xjtl62l6vgpB5lbILvOGXOVbE0
         O4nA==
X-Forwarded-Encrypted: i=1; AJvYcCWNqUWHJ30+cvJ4mWnl00NEkeAaSVjZnYCpvJ+1FwXiTMAesYzfRVee29yx2+/Oar4yIiKhsDxK+JDOS3GIue04TfjDx+I=
X-Gm-Message-State: AOJu0YwvGWXrT8+LzxQO0SkSYNNywaQc/ehs/XG3DjKTuJ0O89/xa+F5
	7dGfHWwbm6ayC7dJ72i2XyllB5io2sBo4COPdRNQC8FVyhOS1ngfRDW2uOvBACRvGt7hUPBV8Ty
	ZNjPuMNTr2QnwejfYZvk5NUWReZLvA4DuP07833pRO4wTukkEnx+f
X-Received: by 2002:a05:6e02:1546:b0:398:36c0:7968 with SMTP id e9e14a558f8ab-39d124412abmr55043125ab.6.1723674448864;
        Wed, 14 Aug 2024 15:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0XnB3zAv8wIE4zKw7V690F2HnrtkA+wzWRAYAy01bH2r2yleRktwbE5PM1Fe9xVttrUfSjg==
X-Received: by 2002:a05:6e02:1546:b0:398:36c0:7968 with SMTP id e9e14a558f8ab-39d124412abmr55042975ab.6.1723674448610;
        Wed, 14 Aug 2024 15:27:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ead55aasm662305ab.13.2024.08.14.15.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 15:27:27 -0700 (PDT)
Date: Wed, 14 Aug 2024 16:27:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu/vt-d: Add helper to flush caches for context
 change
Message-ID: <20240814162726.5efe1a6e.alex.williamson@redhat.com>
In-Reply-To: <20240702130839.108139-7-baolu.lu@linux.intel.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
	<20240702130839.108139-7-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Baolu,

This appears to be non-functional and breaks device assignment...

On Tue,  2 Jul 2024 21:08:38 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1f0d6892a0b6..e84b0fdca107 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
...
> @@ -1959,7 +1944,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
>  {
>  	struct intel_iommu *iommu = info->iommu;
>  	struct context_entry *context;
> -	u16 did_old;
>  
>  	spin_lock(&iommu->lock);
>  	context = iommu_context_addr(iommu, bus, devfn, 0);
> @@ -1968,24 +1952,10 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
>  		return;
>  	}
>  
> -	did_old = context_domain_id(context);
> -

    static inline int context_domain_id(struct context_entry *c)
    {
            return((c->hi >> 8) & 0xffff);
    }

>  	context_clear_entry(context);

    static inline void context_clear_entry(struct context_entry *context)
    {       
            context->lo = 0;
            context->hi = 0;
    }

>  	__iommu_flush_cache(iommu, context, sizeof(*context));
>  	spin_unlock(&iommu->lock);
> -	iommu->flush.flush_context(iommu,
> -				   did_old,
> -				   (((u16)bus) << 8) | devfn,
> -				   DMA_CCMD_MASK_NOBIT,
> -				   DMA_CCMD_DEVICE_INVL);
> -
> -	iommu->flush.flush_iotlb(iommu,
> -				 did_old,
> -				 0,
> -				 0,
> -				 DMA_TLB_DSI_FLUSH);
> -
> -	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
> +	intel_context_flush_present(info, context, true);
>  }
>  
>  static int domain_setup_first_level(struct intel_iommu *iommu,
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index aabcdf756581..d6623d2c2050 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
...
> +void intel_context_flush_present(struct device_domain_info *info,
> +				 struct context_entry *context,
> +				 bool flush_domains)
> +{
> +	struct intel_iommu *iommu = info->iommu;
> +	u16 did = context_domain_id(context);

Whoops, did is always zero here, intel_context_flush_present() precedes
all callers.

> +	struct pasid_entry *pte;
> +	int i;
> +
> +	/*
> +	 * Device-selective context-cache invalidation. The Domain-ID field
> +	 * of the Context-cache Invalidate Descriptor is ignored by hardware
> +	 * when operating in scalable mode. Therefore the @did value doesn't
> +	 * matter in scalable mode.
> +	 */
> +	iommu->flush.flush_context(iommu, did, PCI_DEVID(info->bus, info->devfn),
                                          ^^^ Bogus
> +				   DMA_CCMD_MASK_NOBIT, DMA_CCMD_DEVICE_INVL);
> +
> +	/*
> +	 * For legacy mode:
> +	 * - Domain-selective IOTLB invalidation
> +	 * - Global Device-TLB invalidation to all affected functions
> +	 */
> +	if (!sm_supported(iommu)) {
> +		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
                                                ^^^ etc...
> +		__context_flush_dev_iotlb(info);
> +
> +		return;
> +	}

Thanks,
Alex

