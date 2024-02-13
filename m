Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567AE41C75
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828790; cv=none; b=uj3FfhxcjTYPdaztXKAvQ0lcZ6sEmrj8ysYEgoyIb02IIVK+bKYw0r8ruR9gTXc+9bGtKnUpZJ1RSNXZydMMQO/jQ3DGVc+pHHTBe0kATYMnzTBMsE/GTQtDFukBKceJif2sK5ZCAfouL1FFMALUlkHjxsjETEgoDpYy/v69i+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828790; c=relaxed/simple;
	bh=4QiDVmG8Pu10No36/bjRL+lJTGWGAeI7JyqY2zIafd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGobYEWWoYJnidU2ApZioBLPcrMM9AruQd7ysPooclWZiKEDfoskwfLVkavE1F6AFrOROGE+QVt8TRE4lqBy0qC+xxLn5cWy/TiPNerrlmKUrZGeVy7GgFt+4naTAouKCnqriKNJWhBPbd/kZ1+uWwnkEOcbOXOvjEOlHonLflo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gpF/Y3st; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gpF/Y3st"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-218eea4f1a7so2384372fac.3
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 04:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707828786; x=1708433586; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYlY4epw8eo23hBH5onki0iwHafDPOFpum80B41NzZM=;
        b=gpF/Y3st+/aWvlkeZdqGTLlBFeUmie6EUH1SJt/5/kAQWXMd4KQ1KglmIkc7pyNJTH
         OXj8Em8VOtS5YsvT8xfc/hXxLO92jnFi5uF536suNwpjSSDMycxkAeSzr+dUkkYHRH1Q
         Sj72XIpAeMXhYJ0S2v9qS8o2jqEvkGoPLpbRHvVzPn7CrtnwyP+UvVsjD+IYSa486K/1
         UxxCYhBGNx/BlL9+UnHDX59bic9t5aHjTJFfM9NgCKEi3m6EOZEfVlwJaFttnnvasFWL
         71Mu14N1P3pi7WQFTSzd2b7r6WWqavy8b5oE5mnrAOkVIaeKtRO1qgQqcnzk5zKkxpRn
         R34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828786; x=1708433586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYlY4epw8eo23hBH5onki0iwHafDPOFpum80B41NzZM=;
        b=GHcxF8/fZF6Mi1oW9kN/8297mOV9nVJkw7xS0Hu7Hu5gfwKgb2+LrIVCQF4VCLwBLI
         alFcuDiINrizOLz1vFhLjb3eFHInE6PAyIZn+at1FcjUakX+ZafBIRv5uTYCqUAL6nYT
         5KjoKyT1E5lNFeCl7lDkXAlfQ37KssYJww1dBABeHE3kp6FWEkjEAjMQcFUOI/yEzds6
         sbCl5PzhlNuspvBMSCkSoxbrVsRIp4YSuJK0ApdoKsMDsiD0Ci8QAzuf84c+RzpfzH4N
         i/B12QNUxalyi0wjtmGxK5C7DLMsGkrduI9CqpX8MVboezgH+dq5ImcD8rjNb9D/EZf/
         5LMA==
X-Gm-Message-State: AOJu0YxYpoHcZzzuWiUgOCiCuCj41Q+a3rIzCcg9iHyimrLF5cLoqTdl
	VTtplX6MXMxqgd1M0DJSDygAQ58GJDAJMDvoNt6oBEl+ACiQYYf9XXuXW/eUF5E=
X-Google-Smtp-Source: AGHT+IGXkMm8BsVHGtdwe6ZYkH1WocH0C7Za2EnH5WwIcROjlfnVZ2BR2bYIkyqLIlksNy6/7ZFRdg==
X-Received: by 2002:a05:6870:5246:b0:218:f129:8a98 with SMTP id o6-20020a056870524600b00218f1298a98mr9525379oai.42.1707828784969;
        Tue, 13 Feb 2024 04:53:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXH/vangM+zSm7yay+2+1sIJ4NTSgXE8HgI1nWybWorcFukbgqOIOm6VMAJ5kCF1To1NOYQ9+ty/g2/Dt1TQ2VjkwVQfPQIEDIabvSg9RseMpSokfeENM0DTL+kDfGOYbyWuj6LKI9N2Bd86AClZZAil1QlHaLfl7pTiydNo9Bp2oX1Kgz6R2b42UApdFW2J9x6KzZA6VpJfIW4MBwlflRudb2eNoXbaT7hbaw79qLz5lj0omrABNtOVLwJ9QELiQqDkWM7tIE=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id hz10-20020a05687153ca00b0021a714d556asm683907oac.41.2024.02.13.04.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:53:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rZsHX-0048lN-Hc;
	Tue, 13 Feb 2024 08:53:03 -0400
Date: Tue, 13 Feb 2024 08:53:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robdclark@gmail.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] Revert "iommu/arm-smmu: Convert to domain_alloc_paging()"
Message-ID: <20240213125303.GJ765010@ziepe.ca>
References: <20240213-iommu-revert-domain-alloc-v1-1-325ff55dece4@linaro.org>
 <20240213121257.GI765010@ziepe.ca>
 <20240213121934.GA28726@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213121934.GA28726@willie-the-truck>

On Tue, Feb 13, 2024 at 12:19:34PM +0000, Will Deacon wrote:
> > > @@ -875,15 +879,6 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
> > >  	mutex_init(&smmu_domain->init_mutex);
> > >  	spin_lock_init(&smmu_domain->cb_lock);
> > >  
> > > -	if (dev) {
> > > -		struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> > > -
> > > -		if (arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev)) {
> > > -			kfree(smmu_domain);
> > > -			return NULL;
> > > -		}
> > > -	}
> > > -
> > >  	return &smmu_domain->domain;
> > >  }
> > 
> > Everything else is fine, you already tested with that arrangement.
> 
> Partial reverts are a recipe for confusion, so I'll take this and if you'd
> like to bring back some of the hunks, please can you send a patch on top
> that does that?

The typical kernel standard is to fix bugs in patches and only reach
for a wholesale revert if the community is struggling with bug
fixing. Dmitry already tested removing that hunk, Robin explained the
issue, we understand the bug fix is to remove the
arm_smmu_init_domain_context() call. Nothing justifies a full scale
revert.

I'll send another patch if you want, but it seems like a waste of all
our time.

Jason
