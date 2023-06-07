Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670D34448
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 14:22:46 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b038064d97so5232505ad.0
        for <iommu@lists.linux.dev>; Wed, 07 Jun 2023 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686147766; x=1688739766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqYHTiTmt+6bkokPZgd7QYzZ8bhU2nwFDSU1EUKZZAw=;
        b=jb0R5N3wy/ARkSOwsfs8wIpDDWZOCLPYl9Oylyey830OFdJtm87SmtHdCKAq/LQiAH
         rwmGPpis5/8ni1oCofH2ZuRgryc+pv4WcEqnuqYTAg3Gp8+4YPPM7cn0aSLFPow92ive
         zO6VbcvKOoYyTZyZyvaLI4/CuMqtSKrcrWSPWpSYujBhp5yu5UqKDeJAKqSNFOEFJK4d
         vAbCGYfDWHdiMs69lm2mYNNPLeMTouW43dNA61gH5G1HAiY6XAUx11v4rL7/3Dh1hjgY
         ZUkfV0zNnYQwii3B6T8cgOvuTKx7NCF7GOwF4oGn+x5QXORzo99WY8cgEBI4GqS2tzKK
         pINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686147766; x=1688739766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqYHTiTmt+6bkokPZgd7QYzZ8bhU2nwFDSU1EUKZZAw=;
        b=cpis67PH/8IxuVyLgJstyoipznM7zD+kUixWranTzwaxmj7WCilKIHVeamG7KVPPnO
         stKP1jRlk9IkuIhnZLAxMsiqaztpVr85co7H3QsB3TUr0tA+KJgircOEatOHYtONwFGH
         YWw/dOKw9UFtrLHhjg7EkamZhNUTkUSNM5PRjD4Ee+lbhTKva3+Luv7PIg8Hq9hG0Jua
         N6hvTVC7PIBk4zJXWL/PA9TrWiEbuGs+rin6k/nyk3dbg1LCyQTGmnih7POFYV8+2jXG
         a9v9IW4FLMKJvZemcXEl9x6U/HtB3/ZADm+GzYvZ1/Lid2S5l+JXe+X7+FYUsQPHBQFa
         FjfQ==
X-Gm-Message-State: AC+VfDzAqnATKm3suShEa0MEqhpS07V0rfj8ThNHhtuwI4DM4iB1kg0C
	9/3nqb9Q6a/mLhsh1QVQVqO+MA==
X-Google-Smtp-Source: ACHHUZ7qxQnVsqExHvsQTLbMLN28JDeSFBHVrePVBcZm0TOoDtDb8z0JSeFAJkTeo16Nx5mU1Bim0A==
X-Received: by 2002:a17:903:244d:b0:1b0:56cf:b8c0 with SMTP id l13-20020a170903244d00b001b056cfb8c0mr7246032pls.13.1686147765817;
        Wed, 07 Jun 2023 07:22:45 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f23-20020a170902ab9700b001b1a2bf5274sm10497227plr.22.2023.06.07.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 07:22:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1q6u3e-003A3r-Kv;
	Wed, 07 Jun 2023 11:22:42 -0300
Date: Wed, 7 Jun 2023 11:22:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Su Hui <suhui@nfschina.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	kevin.tian@intel.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix possible memory leak of 'domain'
Message-ID: <ZICSskXNlR+ckKvC@ziepe.ca>
References: <20230606070742.139575-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606070742.139575-1-suhui@nfschina.com>

On Tue, Jun 06, 2023 at 03:07:42PM +0800, Su Hui wrote:
> free memory of domain before return NULL.
> 
> Fixes: 29f54745f245 ("iommu/amd: Add missing domain type checks")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index dc1ec6849775..f08e65629c74 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2094,7 +2094,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
>  		pgtable = amd_iommu_pgtable;
>  	} else {
> -		return NULL;
> +		goto out_err;
>  	}

It might be nicer to order to allocation after the type checks, it is
more consistent with the other drivers

This is fine too

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
