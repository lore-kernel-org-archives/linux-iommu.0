Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C699621A0C
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nolxKVAU"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-58d956c8c38so130518eaf.2
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 12:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701288516; x=1701893316; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsP0DQHpiXNbk6VOGkakvcLwir1Z3HAMieU28c9jQgE=;
        b=nolxKVAUY7QPk+/K2GHmLFG+FMxgJ7IH+av6cr85MPHWdWBswSzL8ku4MXguOgqmva
         dJL65bPyJ3XWZi1zMxn9XbRWMv2hI+KzEY52ZnQ00sho9Xk753PUac8HSeezb5WezV/4
         KcgTAx+GdF2ij+tXwZJ/7gViD7n6931UJNFATdTMxEtMsypgZsZLIQzkNy+F4AgH8niO
         gjWPMxeGf6NWVvlILn47m/SKwULCPTe/6T7Nm0+37Q9mgMr+ChSKm+aN3JihG9yyPkYD
         pGhBwcgHYOCcOJx4S/Ya7eImJGzXY1xnPyusmAlVbl1N1yJ10jKcXM9cYTNzpTUOze8s
         Rbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288516; x=1701893316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsP0DQHpiXNbk6VOGkakvcLwir1Z3HAMieU28c9jQgE=;
        b=miDzQcKigvEQm9DG5xIBibfcQhg2L3VYDgSrg2GfeMon7l7UmVu9BsJPlQYXiyFY4K
         r5sg+DMeCvEilH4RNE1VOpa81XPlZcH1tMc8PWVkxiB0ueN4VzaaJ8/QW15gnM951wzW
         t827Xqm/seURuxxpNe8KrBig8MIIhcRdehOSoWXXott4VS+rJaamgWuVxuKaQVS/7R93
         86QPTJbBqSP4mj9xHq2wjyz3unp7i84rzzXpk/87sa7SlfZUkKt27kwzUyitlq7oWgWw
         frfWrQ2cVy03E6KEE+5jE5r0J5bi1KDl2n4P5azGSiim71gl9LfyQR+ZFuL8Lpu3mw36
         Szeg==
X-Gm-Message-State: AOJu0YwhKAW0idXhLdhsBIrICzeNpZdAdxZty+zmTP5ehtFn/x4Tz449
	4e5Ue95UakvdRSsdJDu8slXW+A==
X-Google-Smtp-Source: AGHT+IF2DmngnaCYi3zuAHFgnZ3DUfiOj93dwxgBEsP3uuFuleePYML8J8jh4Z0n1YU6yjF7zHrasQ==
X-Received: by 2002:a05:6820:1506:b0:589:db63:bfd1 with SMTP id ay6-20020a056820150600b00589db63bfd1mr27351574oob.8.1701288515551;
        Wed, 29 Nov 2023 12:08:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id y9-20020a4aaa49000000b0058a0809ea25sm2352146oom.21.2023.11.29.12.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:08:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8QrK-005pQ9-1x;
	Wed, 29 Nov 2023 16:08:34 -0400
Date: Wed, 29 Nov 2023 16:08:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Support enforce_cache_coherency only for
 empty domains
Message-ID: <20231129200834.GJ1312390@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114011036.70142-1-baolu.lu@linux.intel.com>

On Tue, Nov 14, 2023 at 09:10:33AM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 65d37a138c75..ce030c5b5772 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -602,6 +602,9 @@ struct dmar_domain {
>  					 */
>  	u8 dirty_tracking:1;		/* Dirty tracking is enabled */
>  	u8 nested_parent:1;		/* Has other domains nested on it */
> +	u8 has_mappings:1;		/* Has mappings configured through
> +					 * iommu_map() interface.
> +					 */

Is it racey?

The other option is to make iommfd do this and forbid it from
switching the enforce_cache_coherency if the IOAS has any maps
attached. We can get the correct locking at that point.

AMD has the same issue if it ever wants to implement its per-PTE bit

Jason
