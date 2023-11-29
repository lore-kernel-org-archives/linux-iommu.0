Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12D5EE9A
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dz+0lW0E"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce2988d62eso140593a34.1
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 12:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701288621; x=1701893421; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHJA5Yeky915FldzKVWXmcEmJkb/NyXXE4CZH+o9wtk=;
        b=Dz+0lW0EhFbrDu00Gm1CVLestsPZmZQyFyw2UU5brTGShhzRO9BZtedqAwoLVQEycz
         OU82AftkaB6sSSEQLRkEhYPVhiTur43We1CvxW7qAORVzoaSsRjciUO/gWeJM4rl75Sr
         5/naXMvjiahxYMzPws5Uv3QACI+ENxUp9wIfb4F5ox4+YfYpp5/7+7yqLQj5d0RNEqml
         i/WMxbd3wDfTXSwafsf+Ch/pyG0p4+dS+COn4hWuV61NH9QPPOf/+gSnU9EiMZ++yMGt
         OaYdc9thAg48320Sysx5uJqs34eQsnLOtiqKV8sfEiKlLfchuUv+y9FSD5aA6t58jL6J
         NoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288621; x=1701893421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHJA5Yeky915FldzKVWXmcEmJkb/NyXXE4CZH+o9wtk=;
        b=MNyMzglJrZfe3d9yJ3+cx+COxxNwrEiuR6SwpIZ4cJxgez2DK/5OpmOpDaiDTf7rVz
         PLi4IU4pDvlIb7lM45EDuJ/iPRGbx0IOLftvMPfbwhJ7xBIEW+uxRYMX/VbnSJDPyk8K
         FeAtBH4y6JtdwyB6ppg5lejGFMgbwTfRyHr2GmUZJ3nTU7pKdYgLsObvySKnzuNIoSmr
         iNhD/7dagKv3fTn1RNgSmoY/AJMTPH4OA6mHMUjefU9hDYOW9/0aqRdxc7rlR0L68CyG
         Ab1XNXS9rN8sUhwjazEmcpWG4dgpm4U8gOpWlnqy76v6k61x4dkQhrxA7v7A2fN20Tuh
         E7nQ==
X-Gm-Message-State: AOJu0YxWiCT3Y7es1JGs+olHJW0fxcVSBimaflHeLy+BHCcQN7ANZMrB
	Iv1A4vicaRQW1/vhygXj1Qjtew==
X-Google-Smtp-Source: AGHT+IGPGnuc5Am8VWo68rNz8SzuiAXNuTN8/tCcUTvWfbbrTAaPJlaetZ3rzD+6iGGYpZmalGlQAw==
X-Received: by 2002:a9d:6f01:0:b0:6bd:93e:460b with SMTP id n1-20020a9d6f01000000b006bd093e460bmr21088456otq.19.1701288621545;
        Wed, 29 Nov 2023 12:10:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id s8-20020a9d7588000000b006b753685cc5sm2083142otk.79.2023.11.29.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:10:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8Qt2-005pR2-Ao;
	Wed, 29 Nov 2023 16:10:20 -0400
Date: Wed, 29 Nov 2023 16:10:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
Message-ID: <20231129201020.GK1312390@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114011036.70142-2-baolu.lu@linux.intel.com>

On Tue, Nov 14, 2023 at 09:10:34AM +0800, Lu Baolu wrote:
> The latest VT-d spec indicates that when remapping hardware is disabled
> (TES=0 in Global Status Register), upstream ATS Invalidation Completion
> requests are treated as UR (Unsupported Request).
> 
> Consequently, the spec recommends in section 4.3 Handling of Device-TLB
> Invalidations that software refrain from submitting any Device-TLB
> invalidation requests when address remapping hardware is disabled.
> 
> Verify address remapping hardware is enabled prior to submitting Device-
> TLB invalidation requests.
> 
> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

How did you get to the point where flush_dev_iotlb could even be
called if the iommu has somehow been globally disabled?

Shouldn't the attach of the domain compeltely fail if the HW is
disabled?

If the domain is not attached to anything why would flushing happen?

Jason
