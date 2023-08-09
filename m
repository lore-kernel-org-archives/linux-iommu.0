Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9D1BB30
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 16:59:00 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-403a85eb723so53434911cf.1
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691600340; x=1692205140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePlScrnrPWgYIwkxSFrLYux3pUaMlgw2BLgxuxovAOE=;
        b=APERFP272SNMr7Kw8WPTlRK9wuiXOkBrHzhp907/GMoSm1zJmJ+zVc0XLVRCb8Hp5r
         oDYmxkKqYtZVSaIVIOtFE8VD1XC6MrZw4rfutzfDAHGRGeDMsGfRyibOsQLu5Rk3UHlO
         8lp6MfIpcQmkREuqswrbOVMsGLhvnGvzz29P1qExW+y2ueTRPgaAhTSRaNCxFru7S0FE
         9nZb2LXh0h2eh3FY44jue9GibBj6BFa+VkJ2cx8b5BBxpWlFPQ8pUnLsjIevV1yBkdog
         OWYKNHhj9XxsnUKtHE8dtD1Hqvh2qpnfMa/G6nAldcNk8JowFS35OsPbNtUuyW5ZZ7nQ
         ouRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600340; x=1692205140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePlScrnrPWgYIwkxSFrLYux3pUaMlgw2BLgxuxovAOE=;
        b=FHbheokfnudnEc55ee6oWFik7ayCeGS+s3IcJNKSFfbbEkQUYzwvT2w7EWzmI3qaf1
         oHvAchJP5uT0fJwexK58QlEBZAuMXyayC1rSi+PmqK0jRgMo7uDBg7LiY0UJYZohKOTM
         cADhOiRSCzbJfwmxEqPtbekdlMn2ZpPU8A8S9iaxX8UjaBaLywZjYzOBEmudPgzC+8xL
         h3aE7sPGbrbDinXVX2zHFiPKIB75e3FJmWIC8ob5C31Nw49OM4H+dSFzfHrXQSUcPTkS
         nah1nSl1rzLfyKf5V9FCFLzwHTnueUf6JqMKhBbmneoJEjqdyaGUpVgJQIY3fGB1ZhOz
         5Q1A==
X-Gm-Message-State: AOJu0YyeF8PN+dUW8zwzReZxRBVZsPgae0UBF61DqJaPGhOQdhNca3WY
	Nf2uSNbNLb4iPvUOmpkUU4Se6w==
X-Google-Smtp-Source: AGHT+IE6HAHRe9rLHLimsKF4h4cWp3x4JMrWEIQz7rmXWl2on/DzudkcyWasVh7uCL4uXrL1ZUciAw==
X-Received: by 2002:a05:622a:2d2:b0:40f:d1df:fa10 with SMTP id a18-20020a05622a02d200b0040fd1dffa10mr4859881qtx.31.1691600339792;
        Wed, 09 Aug 2023 09:58:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id w26-20020a05622a191a00b0040ff2a9ca0asm4154988qtc.67.2023.08.09.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:58:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTmWQ-005518-EA;
	Wed, 09 Aug 2023 13:58:58 -0300
Date: Wed, 9 Aug 2023 13:58:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] iommu: Move iommu fault data to linux/iommu.h
Message-ID: <ZNPF0rLiMruBeGpD@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-2-baolu.lu@linux.intel.com>

On Thu, Jul 27, 2023 at 01:48:26PM +0800, Lu Baolu wrote:
> The iommu fault data is currently defined in uapi/linux/iommu.h, but is
> only used inside the iommu subsystem. Move it to linux/iommu.h, where it
> will be more accessible to kernel drivers.
> 
> With this done, uapi/linux/iommu.h becomes empty and can be removed from
> the tree.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h      | 152 +++++++++++++++++++++++++++++++++-
>  include/uapi/linux/iommu.h | 161 -------------------------------------
>  MAINTAINERS                |   1 -
>  3 files changed, 151 insertions(+), 163 deletions(-)
>  delete mode 100644 include/uapi/linux/iommu.h

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
