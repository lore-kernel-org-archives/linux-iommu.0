Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C0100B9
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:28:47 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6bd0425ad4fso760382a34.2
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691508526; x=1692113326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2o+PM/HHKCRmWj11mqOHqyguktcNxiaGLUTwfaC4eI=;
        b=jU1YpQhx4y6rryTVLVlPuViIUpRHDsbDv1vSnrgZveeVblXqMq4QSPXVT8P6rqcDyj
         4RX9d1mmVauWspfg2xFAsHcAV8o9ZDQOpDTvWxSFDeKo/L455rmzMeLJxG9gHN+UIHdl
         fHVyt+HqlAfW34b1ftRh4gLISkZsllx9Xr8GB9B3EOYduInunILS1mQG2HHMF7ZTl2qH
         wDHfyygskmc6vkB/tE3Cwgm1+KwBIAa56m26pEhBQkQ/xDEGa2e85sDxLl23Q//Gv+uO
         /+EXt7dqGZ81LNbgryTnrvjcb3IKyyiR5ZocMAP+eWV6VzY7qQZ2Idivnyw+uLedWuCy
         Sbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691508526; x=1692113326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2o+PM/HHKCRmWj11mqOHqyguktcNxiaGLUTwfaC4eI=;
        b=kfGq/1bdM7mmctfVjvwygSdICg7sFOEztVviqEwrEzJ0Qu4J+89PozGj2oTeg/+42d
         +dWxSb2uadlZiqh/UfPxDpFAT0NLN0CwjTBrAO7zCAKzooepJesaxQmpw7/yT6qX6d58
         y4X+jjpVM0RXe+I2E1xcFXxXq7VqTTFSXKL+uvugsqN+G84IePr4rJ2czNx+eF7wq4vY
         Xt8btFeVsF7tpHN3iWvJ2iNZlYCkQPXdAN4d/v8lRoh+rid95L4+97boVlGt10Lt2J6Z
         6ut73mfF+mYfKIJgR51M1LmGg+a95NGik4A0dggEtDw5+GfobGlP04mObe5GZfUiNwGt
         GOnw==
X-Gm-Message-State: AOJu0Ywd2X9aR3HnaPZEm8SEJ9tDtzhS9kIC4Q52gswbmqHiZCJIA9GA
	tsZeh3NY0+q6HN70ikAsMTQw7w==
X-Google-Smtp-Source: AGHT+IHIW80ocn2px4/mSvPMYZaDrwux8LTqqIWK/akYjlkt3tSL/bNkLftU0uqqE52Ci+rLW4ntcg==
X-Received: by 2002:a05:6358:3183:b0:135:499a:382b with SMTP id q3-20020a056358318300b00135499a382bmr10239406rwd.7.1691508526002;
        Tue, 08 Aug 2023 08:28:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id f6-20020ac81346000000b0040f200feb4fsm3395594qtj.80.2023.08.08.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:28:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTOdZ-004dJf-1c;
	Tue, 08 Aug 2023 12:28:45 -0300
Date: Tue, 8 Aug 2023 12:28:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 01/11] iommu/amd: Rename helper function
 rlookup_amd_iommu()
Message-ID: <ZNJfLQTJhOgorIHB@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808100232.5977-2-vasant.hegde@amd.com>

On Tue, Aug 08, 2023 at 10:02:22AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Rename and make it available to other code.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  1 +
>  drivers/iommu/amd/iommu.c     | 30 +++++++++++++++---------------
>  2 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 56996dc2868d..1471ab2dddd1 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -24,6 +24,7 @@ int amd_iommu_init_devices(void);
>  void amd_iommu_uninit_devices(void);
>  void amd_iommu_init_notifier(void);
>  void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
> +struct amd_iommu *amd_iommu_rlookup_iommu(struct device *dev);
>  
>  #ifdef CONFIG_AMD_IOMMU_DEBUGFS
>  void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 26e509ffe77a..77b913211c35 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -164,7 +164,7 @@ static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
>  	return NULL;
>  }
>  
> -static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
> +struct amd_iommu *amd_iommu_rlookup_iommu(struct device *dev)
>  {

Er, wah? This is a really confused function. It should just be:

static inline struct amd_iommu *amd_device_to_iommu(struct device *dev)
{
	return container_of(dev->iommu->iommu_dev, struct amd_iommu, iommu);
}

Right? At least for many of the call sites.

The core code maintains the association of the iommu_device with each
probe'd device automatically. The drivers don't need tables and
searching.

Jason 

