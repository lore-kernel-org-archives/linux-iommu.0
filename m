Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D56216454
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652976; cv=none; b=t8rjiU3xZ8dm2t/S2AltNYBBlunTP1vDAjQaJJud5oGEsKq1RjODnxE8sOfNX0otgQbCPnnm33qPKHLtH9Z/SQ8RJr3ZfR95/ar31d3SLpLetSwgdTxzO6k8huDDdReRtVC60UuSx2KIjgOz60jrfkBF9SG/qkLJ/wQxG47jufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652976; c=relaxed/simple;
	bh=GKt34GZ1T3+p+//976QoqJmwGFIFvhAgBAjsahriSfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDl1pH7ELBQhq8E9/9YZG6q1V0PixFHXQFGY/9kq8EMBtAHHfRCohjFH6clZsO2WjbX6YJpY9VBS9MOYGP3UsswSwjpnRVp05CyjY2h0PaCpMrZux8hG1jGxQXtgQ6BDGe7Kh7UsES0qb70qKfz1ByVzGtkti/nbOi7cxWpa7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C2HzKCgo; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C2HzKCgo"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4604111f629so18111271cf.3
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728652974; x=1729257774; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7pTQ6QybW0xHhHwYV/6CeX01mgSlXIVQ3clJp9shcg=;
        b=C2HzKCgob5zMGwv8O3sPQv7u7fV3K49z/ianr3u8ArSLDH9q3nOtv05HL8XiRGP5rB
         dd+7+uip5WwV+Bl750AXuS1X1M2gbN08/VPMQmARjC7N6I2Y3md613YWUEAaTJ1a2eWp
         CgJ3TjS3j4M+pIPlDbR8YQ415xa0MjnayA94LO/lJ91/Gm92YPibVWbHUgMgGqadrjC9
         sIvQ8PFIjG6xkqHYy95zEvQSjmQAwJISNv3PsYk01BZWxIO1fTGSXsQ4axljRzcxxxik
         EX6nlMPLJupHlzHwk9unCeEkVGRwW8FiiGllcRfH3Ku7i4/bS25POKK8h2le6IYEvlRC
         jeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652974; x=1729257774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7pTQ6QybW0xHhHwYV/6CeX01mgSlXIVQ3clJp9shcg=;
        b=bvHHojNgIBsnw9aoiLD3kSPQjV6H6NYa5n4Ak22RsMBQMNdSzdRqVOxw+JRA9j2hOU
         CtZgCd9SWnZCr2bvaGHW0jiuMBYQNpC6pqfUSu1wvJHF3umuGNrjvHHAu0YR2pgRo3ij
         vqPqbubzL8VbkpKQNJNklfT99DjbZRXndIDp/cbNAuZfq6LPC4AdBatmsWDksTd+M2lZ
         8fzHbr+TTvBvG21CkW4ReB3A7ay1q98uy3yVuLLUsnpTSwEoXscZ0+LDEooj3gN5ZHVN
         0izXuCwOEoQu1E4mGbQGn664m3MMEj+SE35lR7/D97PJt7ExD6xNrdYrao1JfvYRe0wq
         vDHg==
X-Gm-Message-State: AOJu0Yw7tW4JLXEoqEnnBsDeHFYK0MLboC9NLoi+wGqvS/dO4euA0E67
	Rebvo59naIOYN6+txwzzlJOjEKnuupV3fH4LclRiPTpOZyVq1Wt6V5zl66HmCcg=
X-Google-Smtp-Source: AGHT+IG/p9n71JYR55kA4MXudqUnjfgmqMBmN7Ts190gYsyypsRk0Lf0RpFEuLXdfiFXh9zf5cZ9KQ==
X-Received: by 2002:ac8:7d05:0:b0:458:1dd3:e3a6 with SMTP id d75a77b69052e-4604bbc8936mr44708121cf.23.1728652974018;
        Fri, 11 Oct 2024 06:22:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427905adsm15187721cf.15.2024.10.11.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:22:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szFbY-006qTP-EG;
	Fri, 11 Oct 2024 10:22:52 -0300
Date: Fri, 11 Oct 2024 10:22:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iommu/vt-d: Add domain_alloc_paging support
Message-ID: <20241011132252.GJ762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-2-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:16PM +0800, Lu Baolu wrote:

> +static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	struct dmar_domain *dmar_domain;
> +	bool first_stage;
> +
> +	first_stage = first_level_by_default(0);
> +	dmar_domain = paging_domain_alloc(dev, first_stage);
> +	if (IS_ERR(dmar_domain))
> +		return ERR_CAST(dmar_domain);
> +
> +	return &dmar_domain->domain;
> +}

With the direction that Vasant's series is going in, I think this
should be skipped and instead your other patch to make
domain_alloc_user (which we will rename) a full functional replacement
is the right thing.

Jason
