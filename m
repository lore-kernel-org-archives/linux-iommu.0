Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F663B3
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 13:29:20 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-26934bc3059so2239386a91.1
        for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691760560; x=1692365360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8LOpgoLGoY3DjpumPQsfCr46GfyFnwJ6iRRs1mZps+8=;
        b=P23nqss6FVvXml5SxPmyBOySoi8G56V8QNGw1aeNOAT1Kv2QSV9LHYmLlAxDbc2BTb
         X6o6yj1C+5iPCmclzAsBq8c01yvJd63vxN4x4DoJMg8Duwxnq4/CBUagn0SavWX0d8eG
         FJ6+frmZ0L/Z7WKdGHMkRKqKRmndj/aO/ZLYrUQk44b/3GpuP4AOux4smSG/g6cTP81L
         UQES66jdJvnUvW9fQ1TBxkUAa3lCRldj3aZOn0ttqJ3pbfrJP6ie8cgr/i6ptVkfPDIm
         bQYVuQiyXTMum16UfRPvpQLeEygFnDYFQx94Knx+zxFQuMzEy9Of8lEmoueGfMrwfH2P
         ArKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691760560; x=1692365360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LOpgoLGoY3DjpumPQsfCr46GfyFnwJ6iRRs1mZps+8=;
        b=A5nRg2GtUq5mXEtEgWWMP62fuuJJn3NHKUnDvVwV4uIYInWo43T0pXs2yJu5x4HI4+
         Dc+QVX5ttEYLC+QW7c+DmUpQjy5iJ5gRBSUEJKiq2xG/Xw743mJakvWr4cCdQfAJF3Dp
         /9L6yhe4o5mhjYfj/kPbQdAxGZbpkSly0u77g9MYGPAspAjqtecxA3SCtDcZb5HJUlii
         tiiLLk35dLf4VdQvtht2R8Apvs86+S6ZUGsto1cwIA6IdGYV7/2Dblgk006dPJQgZOcJ
         WUTo2/Jcab60dICrFQiJb31tKG3ANVyO5GGAHrKqjlMVGpee2i0SYfIE9CBKME9Bdnd+
         3Mew==
X-Gm-Message-State: AOJu0YzhteR0RWt/HyMiJmK8VimOAlFfeb8+VWSqDFUdn913CQ71eceB
	/BQjhKK/cPLy1hZP0BMuBMwvww==
X-Google-Smtp-Source: AGHT+IEufSgy3WFklLzEfOQ7QcpVLaiWk87ysEXVFOcUtUGT0SPAsgLe2hy3p5Ir4TzY4QNGL5dM/Q==
X-Received: by 2002:a17:90a:648e:b0:268:220a:7080 with SMTP id h14-20020a17090a648e00b00268220a7080mr6628903pjj.2.1691760559815;
        Fri, 11 Aug 2023 06:29:19 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id ju9-20020a170903428900b001a6d4ea7301sm3890733plb.251.2023.08.11.06.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:29:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUSCb-005RAj-Ge;
	Fri, 11 Aug 2023 10:29:17 -0300
Date: Fri, 11 Aug 2023 10:29:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/12] iommu: Make iommu_queue_iopf() more generic
Message-ID: <ZNY3rYJbBFEMFi80@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-11-baolu.lu@linux.intel.com>
 <ZNU1Zev6j92IJRjn@ziepe.ca>
 <7fc396d5-e2bd-b126-b3a6-88f8033c14b4@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fc396d5-e2bd-b126-b3a6-88f8033c14b4@linux.intel.com>

On Fri, Aug 11, 2023 at 10:21:20AM +0800, Baolu Lu wrote:

> > This also has lifetime problems on the mm.
> > 
> > The domain should flow into the iommu_sva_handle_iopf() instead of the
> > void *data.
> 
> Okay, but I still want to keep void *data as a private pointer of the
> iopf consumer. For SVA, it's probably NULL.

I'd rather give the iommu_domain some 'private' void * than pass
around weird pointers all over the place... That might be broadly
useful, eg iommufd could store the hwpt in there.

> > We need to document/figure out some how to ensure that the faults are
> > all done processing before a fault enabled domain can be freed.
> 
> This has been documented in drivers/iommu/io-pgfault.c:
> 
> [...]
>  * Any valid page fault will be eventually routed to an iommu domain and the
>  * page fault handler installed there will get called. The users of this
>  * handling framework should guarantee that the iommu domain could only be
>  * freed after the device has stopped generating page faults (or the iommu
>  * hardware has been set to block the page faults) and the pending page
> faults
>  * have been flushed.
>  *
>  * Return: 0 on success and <0 on error.
>  */
> int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> [...]
> 
> > This patch would be better ordered before the prior patch.
> 
> Let me try this in the next version.

Okay.. but can we have some debugging to enforce this maybe? Also add
a comment when we obtain the domain on this path to see the above
about the lifetime

Jason
