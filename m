Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853413FF4
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 19:04:30 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-65637f0d10eso6741136d6.1
        for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695323069; x=1695927869; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72sbDhRS8Dzkt1xA5dO7DmLpaXJoMznOGL4Bfx40IFU=;
        b=lwc/6Hw7ViXNJD33ZCZzGkbv6vosSDVNBEnSYoRemUGfPmdRP1oONYUcu1+3Z7cSTD
         E6h2/mNOXIZuaEiRF7aIMXvVqzQnHC3/I2ZSCHHu75+8VmE7YmBC46Oen/T3vpzZqNq/
         jzoWOZYDtjcQDy090tUURlQh0VaALY4FipW4lM9z0ORYZV/4cGWPNZqbtHsTsUqMM2jO
         U1hSyABl4lgC1R1WwGfkNh2nYdt9leV1WORrCfhFAdlIDHMy+FzZbxO0y68tBu5wZJcE
         OTBCychHODUpG7zvFbpcBSrbQKMqgjiUnCbRXbe74tj0mHXWN7nUpM5Nr3HbtIrFRLPv
         3j7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323069; x=1695927869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72sbDhRS8Dzkt1xA5dO7DmLpaXJoMznOGL4Bfx40IFU=;
        b=Dzw5grm7oT2F3Nerw4+czykDjEmt2VUzmLgJRgi2taHBEVo0Gf+Ru6ju+FBPUNyQzN
         kA3EFWYRfwHgDUUzW7ULKxDe9pMIH0oL6z7U/H9R4UHQ3ANH3eBbgKlRowfMmHMrsI5v
         0KgaQDqP1HV9Iu23SjXzZMhFRWj2npM7OcUPZZcUV2z9q60NhCZyNYtyAJw1MSWavPGM
         /m+EFm4BnV4Lz9LUDIRz4u4jQ1t6GmkJVrjk4npcEta4UBMb9+mMvqefYjcLTsbXJX2e
         DWVTDgSM++8pMaIcvmqhB7DDiiQgFYYvqGk0Z5zCH97NPzJ0YnFtga1+5tiYCHqzTMV3
         fSnw==
X-Gm-Message-State: AOJu0YzSD0re9Z570xD00GjRy8BGdMOnOwqgr9Snqk91Fs+auVRawsw5
	7STI+NFOIio14dg+LcBjL4qsXQ==
X-Google-Smtp-Source: AGHT+IH13k+gaZje9K+RHnKkR06Ap+odjdEBfUpCNJgKS/I8QTQFYuTV8YnbuGPHw9wUe5fDUUE36A==
X-Received: by 2002:a05:6214:2a82:b0:656:3035:1b65 with SMTP id jr2-20020a0562142a8200b0065630351b65mr655517qvb.3.1695323069061;
        Thu, 21 Sep 2023 12:04:29 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id c11-20020a0cd60b000000b00659ab059d73sm553412qvj.0.2023.09.21.12.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:04:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qjOyR-000TZ1-JK;
	Thu, 21 Sep 2023 16:04:27 -0300
Date: Thu, 21 Sep 2023 16:04:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mm: Add structure to keep sva information
Message-ID: <20230921190427.GA13795@ziepe.ca>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-5-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912125936.722348-5-tina.zhang@intel.com>

On Tue, Sep 12, 2023 at 08:59:34PM +0800, Tina Zhang wrote:
> Introduce iommu_mm_data structure to keep sva information (pasid and the
> related sva domains). Add iommu_mm pointer, pointing to an instance of
> iommu_mm_data structure, to mm.
> 
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  include/linux/iommu.h    | 5 +++++
>  include/linux/mm_types.h | 2 ++
>  2 files changed, 7 insertions(+)

This is not a great way to structure the patches

This patch should move the pasid into the struct and do all the
infrastructure to allocate/free the struct.

The next patch should just add the list head to the now existing struct:

> +struct iommu_mm_data {
> +	u32			pasid;
> +	struct list_head	sva_domains;
> +};

The code looks fine though

Jason
