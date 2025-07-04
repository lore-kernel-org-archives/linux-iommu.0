Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84881EE7B7
	for <iommu@lists.linux.dev>; Fri,  4 Jul 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651669; cv=none; b=hYvKDTjCS6FuVjO+Vbe6U4fiR7cGxIb6nh4+SnXP9AVpKtcYZdNiYTpTr7ljUOCyVeybULiwVnxNjHdTD1xBnSFucccsPYIWU/KQwATxla3W9P/klzD0qouKXRlPtqO77COmJNSJrJu34rrlN2jdBwc5ZzT8bcxrYleVLXwMS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651669; c=relaxed/simple;
	bh=qTNc7+1p4sx/z+Ihm4/J09j0G//xpF1WUSAnIfFyOOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngoI/H/E8EHcSvdAS56HaUaZ3jN/0h/++TMurozW5xiy9H8sz3KfEEun1utnyh0uUGdJ1Msei+ZTCyvNm2LOf+hPa+YCdTunBLx3oc9tnCQJpZon0heTnlFruxTCFOKfody2JUe25Gu1WSbQNHTXz/TNbYbXNVf75YpXS/RDs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IU9VG1dM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IU9VG1dM"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af51596da56so906253a12.0
        for <iommu@lists.linux.dev>; Fri, 04 Jul 2025 10:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1751651667; x=1752256467; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XuxUGCJzgBIyontDTdqwJrs5j4TnI5gqZ41JcRqn9+o=;
        b=IU9VG1dMGOPB5Fnkb5AZd7p4O+XXFXpPqHf7Bq17JX4VoosOK/AOmKLBTvK1V1UwlL
         CS1ozUfA+YqrB7C5nhH+wpQDu09XOOViP8dvxUy57BBOcdVUh4wHxbuhcvZcGWmj5rsH
         WPot0nHmUaNVsVQ0LkTpKr6p9xYuoSYZIXty4qNQVJNqyYG/zOSwxwN0lrgsO1oxuwrC
         Lnno2gsYEjjzggyxn2ebNHPJup5hEuXMlRwrDa7zyDG2k9cXCv5NSQsvQbBF5yqlWAxu
         70+dqP4vPPyB7U6NbMIyzSauczmLOzeMXdnU0oJ7SK5q30/qUoQaqomORHedNYZtaWI9
         kPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751651667; x=1752256467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuxUGCJzgBIyontDTdqwJrs5j4TnI5gqZ41JcRqn9+o=;
        b=tBx6qMHbiZ+YVLu+tegxxdYmIbqvaid3nm920IRGhPHlrhMg2FcSwTg8mJ8l+0JjT3
         HUHre1UwHDVa4nhptg6aZiYMXvpLj2ByFzxy5O/TPcxiS5nrsM3czu9+HphPcFY9iYRL
         X/NuQ25MqitV/qgjO48VnqiBtzQ7nyYu2rj/9fyHWC0vuh1ooGad3enxcpP875trtlol
         CCLQOIECHWrkmEOgNbcSQ2qNuAGuwb111AX/1aAOCXxvCMWat+FNEC/8lQOMnCEqHpYO
         r6sUwx9zkuVFElSEn2yWSzfZGmuNbAAdWfXuGFWMByeJ1MMq9/vGgEk1g8uyfDUa71/M
         3VUg==
X-Forwarded-Encrypted: i=1; AJvYcCXzgSz57/YvquABJVZw2CT5bzU7dolH3NNcNXwdE0A/k/RNQkVmDjA5XU3sIpSGYxsXcysf1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLWUky8OWMZa/jSTxjCQRRVXrKVvc/ZMGcbCOj21ox514JfQzA
	uuDbN8omTmckoWQnB9Ig5K8CaZOT1nVmQXQ2G9XJOgLEE9+3P5B/5/FzzphLYKBK7DM=
X-Gm-Gg: ASbGncs33FxjGKCU9l7rbNkN7D95WLdv1JNd5y3ZHoykFGU+PaOu25oUKdY30pP0UJF
	zbN8jt3nO1wQFY0XRzPx3oUBPzB1JhuwwZ+wX5j0/3KltqnsAGlxw8OIVQk9nqTOe3iSuW7ZDaD
	LXa4itednWbJompyPLCIVhjQOk9fXEQ16xJwrY72/3MhHBTfX/+0AE/3apBUkUfQdH+RSRsA4/i
	zygtChkoxfrC8q6FVexDEagVSaSEHmuiwDG1icIMMUuwgPPylIsgcVLuLaT9evtpSCq75DGIH/M
	mBSB8DaZcEQpmiLRjyRMUlEuUsG3gzZRPAAR
X-Google-Smtp-Source: AGHT+IEh1aJoFY/nLlH7wiffnloJQKoRXxbF/IF6yLU1DedrCGkd2rfvxrkg/X7+7Uo3KEx9efT39g==
X-Received: by 2002:a17:90a:dfcc:b0:313:1e9d:404b with SMTP id 98e67ed59e1d1-31aadcf8e2bmr4389360a91.2.1751651667045;
        Fri, 04 Jul 2025 10:54:27 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae4095asm2682225a91.8.2025.07.04.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:54:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uXkcD-00000005zua-0liE;
	Fri, 04 Jul 2025 14:54:25 -0300
Date: Fri, 4 Jul 2025 14:54:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250704175425.GM904431@ziepe.ca>
References: <20250623153931.158765-1-benjamin.gaignard@collabora.com>
 <20250623153931.158765-4-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623153931.158765-4-benjamin.gaignard@collabora.com>

On Mon, Jun 23, 2025 at 05:39:27PM +0200, Benjamin Gaignard wrote:
> The Verisilicon IOMMU hardware block can be found in combination
> with Verisilicon hardware video codecs (encoders or decoders) on
> different SoCs.
> Enable it will allow us to use non contiguous memory allocators
> for Verisilicon video codecs.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> change in version 4:
> - Kconfig dependencies
> - Fix the remarks done by Jason and Robin: locking, clocks, macros
>   probing, pm_runtime, atomic allocation.

It broadly seems OK to me

Though I did notice this:

> +static struct iommu_domain *vsi_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
> +	struct vsi_iommu_domain *vsi_domain;
> +
> +	vsi_domain = kzalloc(sizeof(*vsi_domain), GFP_KERNEL);
> +	if (!vsi_domain)
> +		return NULL;
> +
> +	vsi_domain->iommu = iommu;

So we store the iommu in the domain? And use the iommu->lock all over
the place

> +static int vsi_iommu_attach_device(struct iommu_domain *domain,
> +				   struct device *dev)
> +{
> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	ret = pm_runtime_resume_and_get(iommu->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	spin_lock_irqsave(&iommu->lock, flags);
> +	/* iommu already attached */
> +	if (iommu->domain == domain)
> +		goto unlock;

But here we don't check that the domain matches the iommu of dev.

This seems a bit weird to me, I didn't quite get why the domain uses
iommu->lock instead of just having its own per-domain lock?

But if it does use iommu->lock then this does need to prevent using
domains with the wrong iommu because the also use the wrong lock and
then this:

> +
> +	vsi_iommu_enable(iommu, domain);
> +	list_add_tail(&iommu->node, &vsi_domain->iommus);

Is not safe?

Jason
