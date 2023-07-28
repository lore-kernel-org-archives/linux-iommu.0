Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA79C8C9
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:27:21 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso17715895ad.2
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690554440; x=1691159240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FiBsAz6oHMjsmuBTPJwKrqJY6p4fEOGaVCY7HI31F40=;
        b=Rp6T3oxsUSJ27vElTP+ab3w5iKMyKxsf2IIibZ7hjnQJCDIO8+eBRjeWW5dZqj7/BQ
         cEMfCG7jgdB0dZY6gDUmF7yVDFL1tJ8clhDvd1nfKNQwxkrTwiGG1JLvZK57uZuGHd8H
         iY/i0qjEIdyy7r5DcjyGSpM07W8Yi8XrrNVUKTzjAxN/NiWXFmI5jPfgJwiMx2qyQeFt
         W+z8qjCgKF9uWRCOR/NKTFFEQ8WKf4nwJeF/Tw7pOvbJj86j8m1N0OGueVkwsbfdWjYn
         NB83h5i92i5stZShQsxU3NAMILlyPL/7mSGGjOwuG2Y4bxwDIGLP6TxN3liTlx5wMPbh
         sqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554440; x=1691159240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiBsAz6oHMjsmuBTPJwKrqJY6p4fEOGaVCY7HI31F40=;
        b=LBo8XUEiwgRj9YpVAJF8OptPxRFIMY7rHuE2LWGo1esiqop3UKTW6LZeyAkGfQotWt
         iYu+0aR2lJQewYjXYWCisOn/iucIuXmuStQu9y1T4kQjgCWSLFjXjYrJIYXgNFjWlR6o
         f2Q0FQ6gdcmzH3gfagPB+jY9s9SkD6JsUgnUzJ5CHTP2ifvGCZapO9tmqn2/cQ602LdG
         Qh6OtUhBMjmEBiNeSjiwgxOQOLqwCIAZVgbIRam5JuYl5x8gvehmc4iGitgS1JYc9Lc3
         P7FibZr1dcq8P3uLiRH9srE0xiBYAWfXkaFH7eAB4hBRmWiZA/PVg/yWrNHevEX59iBq
         eshQ==
X-Gm-Message-State: ABy/qLb+DO2zO2SCQp+JRW+7JyjYwvCfqLILOT85oAY8CNDGGb2THs/M
	2YRFsSC7YpCgakGgFfHWTZ+YAw==
X-Google-Smtp-Source: APBJJlHGVoxc/0CJui9PEsuUVmtExsRXy7vbwMWJmKIRmVrpdhS7uo7Ac7qOVZEZAEWETz/4RNJRqg==
X-Received: by 2002:a17:902:ee4d:b0:1b8:a31b:ac85 with SMTP id 13-20020a170902ee4d00b001b8a31bac85mr1968836plo.41.1690554440655;
        Fri, 28 Jul 2023 07:27:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001b53c8659fesm3649918plq.30.2023.07.28.07.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:27:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPOR5-001bn0-0m;
	Fri, 28 Jul 2023 11:27:19 -0300
Date: Fri, 28 Jul 2023 11:27:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 11/16] iommu/amd: Rename ats related variables
Message-ID: <ZMPQR+Cx3q5jf04X@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-12-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:36:04AM +0000, Vasant Hegde wrote:
> Remove nested structure and make it as 'ats_{enable/qdep}'.
> 
> No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  6 ++----
>  drivers/iommu/amd/iommu.c           | 26 +++++++++++++-------------
>  2 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index bbb5ac4f0d39..a066f375ba87 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -816,10 +816,8 @@ struct iommu_dev_data {
>  	struct device *dev;
>  	u16 devid;			  /* PCI Device ID */
>  	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
> -	struct {
> -		bool enabled;
> -		int qdep;
> -	} ats;				  /* ATS state */
> +	int  ats_qdep;
> +	bool ats_enabled;		  /* ATS state */
>  	bool pri_tlp;			  /* PASID TLB required for
>  					     PPR completions */
>  	bool use_vapic;			  /* Enable device to use vapic mode */

Linus does not like lists of bools like this, you should try to write
it as

u8 ats_enabled:1;
u8 pri_tlp:1;

etc

Otherwise it looks good

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
