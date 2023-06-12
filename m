Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB721CF2
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 18:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686593716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t6mC2Gj4NTSoNkT1TGWH5FyPDTv10EwEaEEXjwoc+qg=;
	b=iFW04Dy6HHPAck33nqu6VuAP/xbm1wMy6ozeFALp7/RhT8NC8gBrDdwb7ZXHGRt6+4XvTi
	RWvalRShWI80OYceXzdbhhF6y3XKnzNAkvID8t/kbWQCyGxh4TZkKLPo08oM/D5L30cRLn
	INfnjd/2wUmbLvQH9JUpXxQMjti+nb8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-lJH94mqjNCClGIF7o-6OKw-1; Mon, 12 Jun 2023 14:15:13 -0400
X-MC-Unique: lJH94mqjNCClGIF7o-6OKw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62621cdb1f0so2122086d6.0
        for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 11:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686593711; x=1689185711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6mC2Gj4NTSoNkT1TGWH5FyPDTv10EwEaEEXjwoc+qg=;
        b=DQGtNtgJdpisvOS9nl6/PBow27EjfViySni9UcgWnLzvOXqAnHcfhsJOgWd5ll8xVR
         SssNFFLFI9lMfWGTYRjWQ0sFUh2pXw5rhK4O/M87w66GKHy1YvljKmSGPAaadLEb7W5s
         bLhsL3Iq3v2blismk6DT/McrNhOhV4etqn5ObFOOYtoJKtGH9q8WIZhL22FzB2jv6W/f
         p8U5vzQcw4/GLYdgFgaptOZ7eJ2c3JXOoIbDnmSLb4MfX2vNW6FiD/Gjy4J6q1aFkvLU
         771RqN9cFUEcEt/qbQIheysfe4EJ4ehqGHcWJuZ4qTrrigbkM3C8PaYtioQQygLjbSlT
         Y/fA==
X-Gm-Message-State: AC+VfDyiL+pZYQQRs4FIN9oLyiUXnvzegwYlu7gOf20q7h/IpNYQBFi6
	ypQofi6Ubi6pG1x0EtVUIGCoZ1QoI7OKikk5Ow1HRHZYyoDj8vwyQh2QY/cUiXH473IZIE7x+hX
	kjdBZ25Tt3HZRYMs=
X-Received: by 2002:ad4:5e89:0:b0:626:272b:28e9 with SMTP id jl9-20020ad45e89000000b00626272b28e9mr11413979qvb.24.1686593711637;
        Mon, 12 Jun 2023 11:15:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bESJW0vHksEPcPPYKyF5PSn9yIzTWoB+yYciwXrI3nT+mM8U9XGVRMWRepJDjc2th5lgO8w==
X-Received: by 2002:ad4:5e89:0:b0:626:272b:28e9 with SMTP id jl9-20020ad45e89000000b00626272b28e9mr11413960qvb.24.1686593711414;
        Mon, 12 Jun 2023 11:15:11 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id s5-20020a05621412c500b006255bcfca88sm3391563qvv.7.2023.06.12.11.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:15:10 -0700 (PDT)
Date: Mon, 12 Jun 2023 11:15:09 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove commented-out code
Message-ID: <54wdooghiofgutm73l6klmr6kkalwxuw46l3kxqgccwkta3brz@dezrf7rslvl7>
References: <20230609060514.15154-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230609060514.15154-1-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 02:05:14PM +0800, Lu Baolu wrote:
> These lines of code were commented out when they were first added in commit
> ba39592764ed ("Intel IOMMU: Intel IOMMU driver"). We do not want to restore
> them because the VT-d spec has deprecated the read/write draining hit.
> 
> VT-d spec (section 11.4.2):
> "
>  Hardware implementation with Major Version 2 or higher (VER_REG), always
>  performs required drain without software explicitly requesting a drain in
>  IOTLB invalidation. This field is deprecated and hardware  will always
>  report it as 1 to maintain backward compatibility with software.
> "
> 
> Remove the code to make the code cleaner.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/intel/iommu.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4c0b7424c45e..e5c111ff4dd9 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1312,15 +1312,7 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
>  			iommu->name, type);
>  		return;
>  	}
> -	/* Note: set drain read/write */
> -#if 0
> -	/*
> -	 * This is probably to be super secure.. Looks like we can
> -	 * ignore it without any impact.
> -	 */
> -	if (cap_read_drain(iommu->cap))
> -		val |= DMA_TLB_READ_DRAIN;
> -#endif
> +
>  	if (cap_write_drain(iommu->cap))
>  		val |= DMA_TLB_WRITE_DRAIN;
>  
> -- 
> 2.34.1
> 

