Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47E1DDA1E
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349358; cv=none; b=m+Cp4Er5JeLK+1dV+HhFF8v9f8PjaTP4D258dEF0ynVN2JIEdoSDYiAtZ3swKLtOdUFI/nvdwqFingsVGmyUPYnbnaJDT+vskiuApWj0a58waCmhWr5y4CUYGH+DzCVV8npXbWFZJF0Xec/Umr/ThmHM+5pD4Hsm7sCkXyVGxSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349358; c=relaxed/simple;
	bh=jB3to8XLVxQJ5LgCGbXnmbBfUdZvBo80bwAjGWX1FM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4O5xXM4C2BaBU6swK6AuIOtpcYzYGmlvYnDGiN93vi7Qop8bN7Sn1aAP1ON3YSSw3/g1FWIR+wfD7KFzDelOvtiMrXzmOtbzTE08TiwtO+JAvS9HiWUN8NBI1WNzIVIicIisSmqo/DiKn+Ha/AX+5M+0g/wZ0TH2/V6AdX1aHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y88LmWzR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y88LmWzR"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8f7019422so55141506d6.1
        for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745349355; x=1745954155; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7d1mGroBPaOn9o0uqCQCDJCnumJpud9iMfGSCI94QIs=;
        b=Y88LmWzRTeN1jCJb1SZPo9AnVG8+zATZr8j0GhAnxlBKbmR8lHLqxpBOmjHqEV+6r2
         oKPnsofC5eZvlam/1JdoO4Yt8GYd+8eoEpBbAyu5KC/fOl1lGVjPAf7W7ruco6xxN2Y9
         7gN1lUjgOzQIIzBM6NOYAfqOgTFk/B+7uO+afCtof61VCwjVYx4iJHXFBE2FHnGZAenw
         TlvfmThEEb/PrEPj81qdohxk8XbeLDO7AEBL8y9nogBLmaj35VQcirIGI/k55d5tYDpX
         BiKOyLWPT/jSH4ZZDsyCHOI0Ys63///idKSN6Z3OZX8mSAJXGVpvp/aXh+cagAHqHQOi
         QGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745349355; x=1745954155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d1mGroBPaOn9o0uqCQCDJCnumJpud9iMfGSCI94QIs=;
        b=jTA/qfXIg6pKTFLG6gXmq6g34cm4u+/j/oAo4Arsc363Yk/J8ZYYrCWZxF++LQduUo
         G1rOX5X6rbduZ3ewkub/G2ks/6gJOV1hx5qKMWWYYHCqP4CvtU6MSjTvXvGlwMGO4jny
         4UjQ8Xnv71GLIC8AU3ZS11lozpLeH8D7V8COaOaqaFbeNEkjevUeS6GKF6O5gGBoxqd9
         grnbDHPYMRKL22fCVIPlGrLRlmnaO/8RkQYR+SbUDrWHYhUTdIAA+hRKS+Qv0pkz4Ptr
         qxRRUSrUZYW1MPwwFyFV6NOiPxTuGrPoc56ONBTy55ypOVLo5oF5Clgu7jqimNVC1oR6
         9XTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5iLW7JXahA0JB+VUdwLFER/fuXOrXqq0sVPzrrP4XpJfnvu1n/88kCHPVukwTbKJcSyKJaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5sgBY8lp99zgXswGfYMIdp8nVUMDPj7znyE03APbPSY14KGqi
	5ejWvYMtVtz1H3usTm2S5e2tnYzPGflPgsLpYj3ITdfYozOURFIc3xptADnPfzo=
X-Gm-Gg: ASbGncvma0kGk2Me5MdlS7kh+f6dmZrC4VWHqvcbdED10FsK53JXkQ0IhqxMFryoXFV
	cwpi6m4Quxm5Mw8c3aJEIWhC/EXVFviTX2OdtPnL/IEVR56T8D1u2O74G8MxeGNhGJOKQLIgZeI
	sE7yDw1HEK291mZdjaDK4yz3oej9yMmwXWxRY0cuXSPGdVbJUNbAPZVJ8e+3vRK+FRbFzjkYU9n
	CDA2kvpt+AZLSPJi7ZwFbn5JORqzL/JAo9qxypBmwXtfg1rLIh3gLS8dgqvN009Dog/AIT2TjeL
	iZxlpVGyK6uFTew6Cca/sOQ/zZKP/lTatuGH9xnl/EDjJqrUKFcbEGtK2RyM1wTUwyq7lkpglLT
	Nw1hWe5s7DsCU2R5dotM=
X-Google-Smtp-Source: AGHT+IG42qweyJjGbw7NVAt4l3iMAAjkcjftIU8iawlPjM1u7hmAqwA2QfyxHlkDQd215RnDOqjHbQ==
X-Received: by 2002:ad4:5f07:0:b0:6e8:f464:c9a9 with SMTP id 6a1803df08f44-6f2c44ee6femr255140626d6.2.1745349355218;
        Tue, 22 Apr 2025 12:15:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b775c1sm588323385a.97.2025.04.22.12.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:15:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7J62-00000006vnm-1E8m;
	Tue, 22 Apr 2025 16:15:54 -0300
Date: Tue, 22 Apr 2025 16:15:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, shangsong2@lenovo.com,
	Dave Jiang <dave.jiang@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Assign owner to the static identity
 domain
Message-ID: <20250422191554.GC1213339@ziepe.ca>
References: <20250422075422.2084548-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422075422.2084548-1-baolu.lu@linux.intel.com>

On Tue, Apr 22, 2025 at 03:54:22PM +0800, Lu Baolu wrote:

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cb0b993bebb4..63c9c97ccf69 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4385,6 +4385,7 @@ static struct iommu_domain identity_domain = {
>  		.attach_dev	= identity_domain_attach_dev,
>  		.set_dev_pasid	= identity_domain_set_dev_pasid,
>  	},
> +	.owner = &intel_iommu_ops,
>  };

Is this a systemic mistake in all the static domains in all the
drivers?

Maybe a bigger check is a more complete fix:

static bool iommu_domain_compatible(struct device *dev,
				    struct iommu_domain *domain)
{
	const struct iommu_ops *ops = dev_iommu_ops(dev);

	if (domain->owner == ops)
		return true;

	/* For static domains owner isn't set */
	if (ops->blocked_domain == domain || ops->identity_domain == domain)
		return true;
	return false;
}

Jason
