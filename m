Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA582115
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 19:12:23 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-4a263c4ddbaso298855107b3.0
        for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 11:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5iYIwF91luR1VZkU1kFZWYlc/TF+s0pTovA3mLd0lqA=;
        b=hddSQOS//qdQ19X2kZYXTd0mWRpEk4u7YwwDO4WLuBHsHLlzrUxcrDSaa5dHUimcjy
         s69l9mUWoN2A964v9h9Md6s9NAE/2+HeZj11EE8aks0f3Hd/dDQttfuOQCjyCmq7Pwrp
         vo0+OA8NXH7iIPW1T9GdGMCK+e/Ms4pU9PCu3b7ce76Y4sxCchUBERqfJgRoWuu8YLUR
         wuf3neZOPxtSixAes71yxvXuoKfayR7bH3zTuFs8YkuczGEWguYHIFKrxbg+/6/PE7nx
         Y46vvshIFKydrTwfeGYXo15MQuLMSq6k1xUK94rbLI9JGotaYrW0ENpex81ERXN3w/Rx
         +Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iYIwF91luR1VZkU1kFZWYlc/TF+s0pTovA3mLd0lqA=;
        b=3bqpeDf7R6USsqralg6iYheUcpPPt9Sns6SVl/s5eiXIkCiPyJKE/Sl7yY8u+90hWc
         pm+9Bf1tUM9Rg/5mciCm9E3YzPgXvOqaBUz34bGKpW6xWD8hdqkymtFNFOXH5SGR+EUw
         LidQxnJeAGTYvT19MpkDqcN6/MU4TcD/of4STPbV1H21hY6sGRUIamJRV4nZadK5ORmy
         P3+9j/jF29NoKo+jSvYl7HjLMRAWsZSIBTD4YnkD3QofmN27/0UOEtv0Bg6Xkn6fWWlG
         u3Aa9RI+72ZHM/w4V2UOqgtrsN31CkuLLMmWaeHxrAqN3ZmPqWZvrl2Cg7jasM0hQyvD
         B+gw==
X-Gm-Message-State: AFqh2kpiMYJAzv5+FnAL9TXq/ubyLgU5BBrBrybIoM5GA16XjJiwTWZs
	Fpcjhf+AvaK++QcFRl5zQAbRWA==
X-Google-Smtp-Source: AMrXdXsum8aqm1WNhNOBVlO48D1fGi+7wn4gYXl7+Vzmlg3sRxY54ROiPYFHuAbab2aFSRZT5DBGDw==
X-Received: by 2002:a81:4e0d:0:b0:4dc:6471:9bf1 with SMTP id c13-20020a814e0d000000b004dc64719bf1mr4705770ywb.32.1673637143071;
        Fri, 13 Jan 2023 11:12:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b007055dce4cecsm13393336qkn.97.2023.01.13.11.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:12:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pGPTR-00Afl3-V8;
	Fri, 13 Jan 2023 15:12:21 -0400
Date: Fri, 13 Jan 2023 15:12:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Sven Peter <sven@svenpeter.dev>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Remove ipmmu_utlb_disable()
Message-ID: <Y8GtFcNq2jugBpI3@ziepe.ca>
References: <20230113185640.8050-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113185640.8050-1-joro@8bytes.org>

On Fri, Jan 13, 2023 at 07:56:40PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The function is unused after commit 1b932ceddd19 ("iommu:
> Remove detach_dev callbacks") and so compilation fails with
> 
> drivers/iommu/ipmmu-vmsa.c:305:13: error: ‘ipmmu_utlb_disable’ defined but not used [-Werror=unused-function]
>   305 | static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
>       |             ^~~~~~~~~~~~~~~~~~
> 
> Remove the function to fix the compile error.
> 
> Fixes: 1b932ceddd19 ("iommu: Remove detach_dev callbacks")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 12 ------------
>  1 file changed, 12 deletions(-)

I'm surprised the 0-day bot didn't notice?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
