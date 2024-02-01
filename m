Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701D3FB14
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824193; cv=none; b=SxOa6S2HcLN+zs9KVgbiJwNFZIH5pHYq+uUhJel8f+pdt62JFEWr7Py6v67OmLUPasAcnl/z5zJ8XirtvZ0oCzEgbCro7uRJUTd7SyLWxMWvMcJ/8Vtdwty5eN1TT8uXUShO3HXG1gUfOaSuRYI/7iIMo3dwWmzqxzaKWRyRWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824193; c=relaxed/simple;
	bh=IN4BvpOjL9qSgp0/BJuRT4ahZDX+uOcMGsbgrjBrOso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiSfuIxL7G9UPYDl+vSxLdnXfG8C+fD/7qGTf/qUwwvzJFqWCt6qEK1yJOjnKaSF492fhqbetoRl8+xohAYI0gxmvhrQOnuL64vxx+HIr1bXTUkET6iptvimUrq2wV2E0pnE0wFWnSvE09GDoYZS+juXWWiCZc6aomqlW5yrh7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=h1HiCArz; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h1HiCArz"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59a146e8c85so784548eaf.0
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 13:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706824190; x=1707428990; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsWysjAI+XR7eHxRPvsGHm7kY2YQ+TkRU39kaMmFqfA=;
        b=h1HiCArzAKGRpYWoY9xqaSd0PZjzQ3ycCoyDHIlMPe1JPI3Ii3B8JBxG1907o0pjI4
         JEnyPmRJKM+3B35BNbB/AJk1uAQxozaRCb09ybyk6bryPIOpjudXhC3WwNF0Fp1aqA4N
         ngYu0YltARQdSwV5ebcv4j9evpHlpizuFRNhfZ7u4xyK3QcaUmy1cLdiAsJn2tA5Ls+/
         w/7KhPQU+vbdeMQ/cEuTjiaLq8ZX64CY1mmF8KNu+TMWjq3ZZic3KSZe1qDmf9qbs2lg
         mdhOAbFlq+NSIjW9PYJmln2gcY6lsbIAE+fHdOyYKSjdark89JtvKwScINA2kEBoMGQ5
         8M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824190; x=1707428990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsWysjAI+XR7eHxRPvsGHm7kY2YQ+TkRU39kaMmFqfA=;
        b=c5tD5HvyS1OBtsZKsv//AXhQmDSZsOLO3BzPrtq6YWqFvWdPzn82JyJtOkTJd0JMbo
         sGlqEjas66A77VERQN7u3w8YP8w3uMtwrUijfGkaJy0BfLnwponPyx1EsrvlT38ILMTb
         x6dcSRzakFBGhkFaQw1dkuQj3nSs5qeEovukTcJRGvdrGOJitJ1JarapTXG8/Umr5v7u
         bbP2rD9a0SBuXwe5mIRA9ElBnHhewhTFJXv2ulhw+dMYZRORPCivQr8qzoAu2xIPdRJy
         3XTAZu0pF6ithVlhe1C+4f3pNYyUFJTEUB+lxLvBReSGADrq97F1Etx2D5aNFE+Lf/hv
         Y9tw==
X-Gm-Message-State: AOJu0YytCHfKTr8EISNe+YQFZInsJMKcx9dtvMJBqTiT5swKbgSk+ara
	DKbmaqkYFlk+zhZFcj4fSBj5lHwQPnObaKUybQ2YRidhb15pEb5zyAL/V2hmrUI=
X-Google-Smtp-Source: AGHT+IHQRyTNcbToF+z+5rqpEo7/OWbu4USYSxdLgoCGqVteK3lxmQY0UaQ6vfcgxWIJg/0xJUxkDQ==
X-Received: by 2002:a4a:91d3:0:b0:59a:8713:90c3 with SMTP id e19-20020a4a91d3000000b0059a871390c3mr5686421ooh.6.1706824190488;
        Thu, 01 Feb 2024 13:49:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsfYr8I8rSA3YbnekV9AveEAa3WfzIOg5iyH0KQ9/JYTqTyps8ouoci8LuXie4wUBYNJN5gCeLR7f5uoURUEsO1dzj0G5Yzaa68BfmjQoI7ShDKl0OeqASjqulS4Dr7eC23G95wTSP/BneDNd1OwNPy3OnT27Xat5PqaSkYoxK1b8ik9N8MKI=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id w21-20020a05620a445500b0078553387247sm91304qkp.74.2024.02.01.13.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 13:49:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVewP-00ApNb-EJ;
	Thu, 01 Feb 2024 17:49:49 -0400
Date: Thu, 1 Feb 2024 17:49:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 10/14] iommu/amd: Introduce logic to enable/disable
 IOPF
Message-ID: <20240201214949.GT50608@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118073339.6978-11-vasant.hegde@amd.com>

On Thu, Jan 18, 2024 at 07:33:35AM +0000, Vasant Hegde wrote:
> diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
> index 02d912b9f618..e1b3d579772f 100644
> --- a/drivers/iommu/amd/ppr.c
> +++ b/drivers/iommu/amd/ppr.c
> @@ -295,3 +295,60 @@ int amd_iommu_iopf_remove_device(struct amd_iommu *iommu, struct device *dev)
>  	raw_spin_unlock_irqrestore(&iommu->lock, flags);
>  	return 0;
>  }
> +
> +static int iopf_update_device(struct device *dev, bool enable)
> +{
> +	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct protection_domain *pdom = dev_data->domain;
> +	int ret = 0;
> +
> +	if (!pdev || !pdom)
> +		return -EINVAL;
> +
> +	spin_lock(&dev_data->lock);
> +
> +	if (enable) {
> +		if (dev_data->ppr)
> +			goto out;
> +
> +		ret = amd_iommu_iopf_add_device(iommu, dev);
> +		if (ret)
> +			goto out;
> +
> +		dev_data->ppr = true;
> +	} else {
> +		ret = amd_iommu_iopf_remove_device(iommu, dev);
> +		dev_data->ppr = false;
> +	}
> +
> +	amd_iommu_dev_update_dte(dev_data, true);

This dte change is in the wrong place. When the domain is first
attached we know if it requires PRI or not. At that moment the DTE
should be set properly, it should not be set wrong and then changed
later.

Remember what I said earlier there should be one DTE write on the
attach paths.

So probably all of this should go away and be moved into set dte

(and again the whole dte setting flow needs cleaning, I think you
should do that before trying to build more complex stuff on top)

Jason
