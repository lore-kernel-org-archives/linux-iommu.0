Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69599DF5D
	for <iommu@lists.linux.dev>; Wed,  6 Sep 2023 13:36:54 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2580577b3a.0
        for <iommu@lists.linux.dev>; Wed, 06 Sep 2023 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694007413; x=1694612213; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Td6a6sw5kxMExUrt1cEVr4QfSz/8/zuHKWsclB1jWMA=;
        b=AF6rbkdb8XtdGHicDtXaMgpjnKaOaKht4eAXBPAA8vE0IcmcYRvsGh+5I2qFFAdiIX
         x4cSQyZXWyf5f5kzpzAWB31Bb0xCoW2l597CzgDemZe69g0p12k89jBvT2cNS4mbpmEk
         FnAhnqOPZaAKSDK/9d1RWzF4/AtF9s1i2/TqMeFdgppuOenMfqiEQK+FUYKpJCkgcf+E
         VuaAgV6gl/ivYjOhnYPalKsLdyxUumw3YGlx6343X5XSZLEOGHzQkRZ5I8WTFjN69yJ5
         TtwRF7QPEiCkDRirvENo87hA8VO6RNneSdOO3UQhOlTAQs//76Vbk9CVmpOcD966CzMd
         2YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007413; x=1694612213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td6a6sw5kxMExUrt1cEVr4QfSz/8/zuHKWsclB1jWMA=;
        b=UFa7XFWbnfy2Bg32NajhMdbMX37Jbniyhh7zLEWz+rEGymTx6uQcDHjIT3Pdsvzjcq
         WrlpeUhz7B5IzkDuciy9SeIEXUzMKZHkMwiOeycngaZQumcJmB+REu7Wsz3zb/iCMwW6
         LtKbgnrjll4Gan5hL1tdMHI+8LJazEncset2+mVuL6oXNKeBWQxS4GXImbfT+vlp8iVZ
         pbmVD/apRNZQRSso+obKRhb7KceWwN1+xGFiXA6UYqeDPt1zRgz9DFiadaSvfd+Ho8oD
         DX5t9gOHq4WraE4DvPByuINWMsfPehxsk5kd0Y6vB2j6YksXhetlMWZRbSsArqONCkRx
         51ng==
X-Gm-Message-State: AOJu0Yx4dmY/+Zqx+t7lnUHYFT+GS3em6TUx7mjx9LCqO5BQtsO4q1RN
	B8nj64sobOtSkrkZPPQVglXNFA==
X-Google-Smtp-Source: AGHT+IGOwRHPmAKNRaGsD/hGYssr/5Y0BJzqOelNvybA7jZN/WxhNoLttPYaPUwO81J4iLj5RhHYKA==
X-Received: by 2002:a05:6a00:2e84:b0:68a:52ec:3d36 with SMTP id fd4-20020a056a002e8400b0068a52ec3d36mr17143606pfb.31.1694007413553;
        Wed, 06 Sep 2023 06:36:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g20-20020a62e314000000b00688214cff65sm10826298pfh.44.2023.09.06.06.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:36:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qdsiB-000yIl-HZ;
	Wed, 06 Sep 2023 10:36:51 -0300
Date: Wed, 6 Sep 2023 10:36:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, linux-tegra@vger.kernel.org,
	iommu@lists.linux.dev, Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] iommu/tegra-smmu: Fix the NULL vs IS_ERR() bug for
 debugfs_create_dir()
Message-ID: <ZPiAc4MuNAJfnTaY@ziepe.ca>
References: <20230831123846.3137304-1-ruanjinjie@huawei.com>
 <8830ecd1-f7a3-a708-66b1-2d9698d0d477@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8830ecd1-f7a3-a708-66b1-2d9698d0d477@linux.intel.com>

On Fri, Sep 01, 2023 at 11:05:48AM +0800, Baolu Lu wrote:
> On 2023/8/31 20:38, Jinjie Ruan wrote:
> > The debugfs_create_dir() function returns error pointers.
> > It never returns NULL. So use IS_ERR() to check it.
> > 
> > Fixes: d1313e7896e9 ("iommu/tegra-smmu: Add debugfs support")
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >   drivers/iommu/tegra-smmu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index e445f80d0226..cd1d80c4c673 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
> >   static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
> >   {
> >   	smmu->debugfs = debugfs_create_dir("smmu", NULL);
> > -	if (!smmu->debugfs)
> > +	if (IS_ERR(smmu->debugfs))
> >   		return;
> 
> There is no need to check the return value of debugfs_create_dir(). This
> change cannot fix anything as far as I can see. Just remove the
> check.

Right

Jason
