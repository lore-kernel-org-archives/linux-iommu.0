Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D35201106
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920433; cv=none; b=AgChe2BUvnIAzeskRGfmm2u1mkODDyFeJrjYYqONqG/Xt5N05aUj5QcxLlmOmdaL3qK3muTIlDKyFnSENOB7Oc+LzV0arobL+jR1nquqmAdnlAraQZ4Mayyfln0oNDgOui5Y4bPAUDn8Qj3yRT/W4B3d+zyHl01drxm8QoELRfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920433; c=relaxed/simple;
	bh=V3WOdQDunnGssZvP2vElRHU+Jjz3dxyDOM+Bff9E36M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iJ9MiTbWSpi7d4otLN1WHy/zv0XyRbqLRXGpB2UjShQVz2DObz9zA2SpjUd4m1tZ9NkUZ0fzwXfuG0gvoFBRlDW9Io92rQniFzqw8rwZdSK70eLgPVWEnSDA1u6yXNoSSCbSx8iJrMEUZ9JwYoTvfMA3CKdPhXr1pV+cpU2pQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O53Rgx/h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O53Rgx/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730920429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3WokkPwMK4/QtOwYlc4n1kISM22eOS86REe3kHYM/3c=;
	b=O53Rgx/hnaEgC/InePmJCwFUO36CZFILnOCYcbAFs5AkzYrdvjDsyUJ5+nKqbzKvUID1GD
	QX3UzNijJea5ERdLJQv2UOuqZJlrkHMEcUauIiISFPWWOA/cUDLpm4gjhuC6i76aOA1p3W
	VurqgtzZjUM3d6t27OlB0ItoHSN0Kyc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-alDHASUNND6tIOwS6zlQIw-1; Wed, 06 Nov 2024 14:13:48 -0500
X-MC-Unique: alDHASUNND6tIOwS6zlQIw-1
X-Mimecast-MFC-AGG-ID: alDHASUNND6tIOwS6zlQIw
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7181c3a0119so1042877a34.1
        for <iommu@lists.linux.dev>; Wed, 06 Nov 2024 11:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730920427; x=1731525227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WokkPwMK4/QtOwYlc4n1kISM22eOS86REe3kHYM/3c=;
        b=hYYGVMl9qSkjxC/EBuOELogEuYSNZiwFVAnIHlk+HDX6375wUYu2EvF5zDrUUrZf+c
         7OQRLYjUM0GFWOg9qydJuQGdSC/RZ8W5KxgA3fjYuH7/O336T9CnHuYR8OBRx256Fj9u
         ScZgRkK8+FT4xargcRs7negh+wvy2Uqj8LeGqVXoBsMQgljtFr/cOxVR6iaXY4DINp4G
         wEY3gvoXR0vJTGermrkLp1AkDchEFk+aEONH2YIOFoTaHzunmuBgoC7k6ObHvKjv49MP
         YGvbADg8hqOfCi+ACXtDo4xJo/nwo5xM5tinu3Qs7sD0vMY4pD/YLghnoashbDbV9w1k
         s1uA==
X-Gm-Message-State: AOJu0YwxHYM4ElwWCwlihSzo4Gnfk3hjipNb4k1yGrmxHDyiRn8P1Bnz
	QC5aq4eQ8DZoXqD+TN2gAROh9HrFylrYym2RxV2pY9PePxahUqiuvm7Fm0vbA49gSlcphHbzI+6
	ODjDaGTM+R9ZN18Vknf+S/zqjpcI6yChbnt2mjpSJKomh7BJ4VL5DIywpZuK0MMDlgMV2B7WkBh
	EOpWtRyBqXf1VX6JJM2HpDKFRIET7a5FKnvHa8
X-Received: by 2002:a9d:6b82:0:b0:716:a99b:8f0a with SMTP id 46e09a7af769-71a0ee6ee40mr274811a34.1.1730920427609;
        Wed, 06 Nov 2024 11:13:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/gon6zRkOlaDedChecm4iprBQV15ZZVZ/MPHiCJKeuNBXkYHTN1ZbTWFZUZXsiCPjMLVfYQ==
X-Received: by 2002:a9d:6b82:0:b0:716:a99b:8f0a with SMTP id 46e09a7af769-71a0ee6ee40mr274793a34.1.1730920427233;
        Wed, 06 Nov 2024 11:13:47 -0800 (PST)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189ccb125dsm2945140a34.56.2024.11.06.11.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 11:13:46 -0800 (PST)
Date: Wed, 6 Nov 2024 12:13:45 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Reserve iova ranges for reserved regions of
 all devices
Message-ID: <vup5ms2p5o4ao3t57kfgqtnnna7e4jcvkvup2vmyf6o4qrb3qu@3aanawjzggyh>
References: <20241024153412.141765-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241024153412.141765-1-jsnitsel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gn1xczfBAVCVd05TN2WzQdLnRxHG1NUyVrACTjui7TA_1730920428
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2024 at 08:34:12AM -0700, Jerry Snitselaar wrote:
> Only the first device that is passed when the domain is set up will
> have its reserved regions reserved in the iova address space.  So if
> there are other devices in the group with unique reserved regions,
> those regions will not get reserved in the iova address space.  All of
> the ranges do get set up in the iopagetables via calls to
> iommu_create_device_direct_mappings for all devices in a group.
> 
> In the case of vt-d system this resulted in messages like the following:
> 
> [ 1632.693264] DMAR: ERROR: DMA PTE for vPFN 0xf1f7e already set (to f1f7e003 not 173025001)
> 
> To make sure iova ranges are reserved for the reserved regions all of
> the devices, call iova_reserve_iommu_regions in iommu_dma_init_domain
> prior to exiting in the case where the domain is already initialized.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
> Robin: I wasn't positive if this is the correct solution, or if it should be
>        done for the entire group at once.
> 
>  drivers/iommu/dma-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2a9fa0c8cc00..5fd3cccbb233 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -707,7 +707,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
>  			goto done_unlock;
>  		}
>  
> -		ret = 0;
> +		ret = iova_reserve_iommu_regions(dev, domain);
>  		goto done_unlock;
>  	}
>  
> -- 
> 2.44.0
> 

Robin,

Any thoughts on this patch? In the case where this originally popped
up it was likely a crap DMAR table in an HPE system with an ilo, as
the RMRR in question had a device in the list that as far as I could
tell didn't actually exist. The 2nd function of the sata controller
was in the list, but not the first, and the first function was the
device where the group/domain was initialized. With some debugging
code I could see it set up the ioptes for the 2nd function, but it
wasn't reserving the range of iovas.


Regards,
Jerry

