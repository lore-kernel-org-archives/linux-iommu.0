Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383621D9A6C
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981488; cv=none; b=kvCXXPnQRrNF8PD9j7Z+zr8Jd1XHMHTuhJh/gtvtPgWQ7b6oTStR/wbRevLTZlMygx/4MtOAQ/hr5mw6uzKv8p7R+SABtvTFA6T2m/qZhSti+i8FRqA0opCBlEjQUU4AWdwrfbyW/4PRw9faL6hvazAow7pxvuD85Of2BFbPmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981488; c=relaxed/simple;
	bh=tL/ImxZ5Dco+UASt7226pxQcMtF1YqZ3WR/bJaUZU3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coLZAbXcKVYnas9hWy7PfYto718ZcGYMnhhinBxgdmFX+U0XuRvQSJQElqyfQKoZ6b9FrtQ3V8P/553NtxpeH3PldOceWgKZ64IF7yktki/p/YjzOaSnGMBNNCTDAXulaFzvidjAXRZoNmPaiA5jjGd1gpxjf8n79tKPy3/OsJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=AYj8YF8A; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="AYj8YF8A"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 23DAC2A6C15;
	Tue, 15 Oct 2024 10:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728981485;
	bh=tL/ImxZ5Dco+UASt7226pxQcMtF1YqZ3WR/bJaUZU3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYj8YF8AOYrLPg1nIM2sY1j+KWFuKjAGaaxNlruXHklnJkBTBCX9uoI1Lj7BufTvp
	 QwjRm3YGKi8ymPJEq8bFRQFqAY/ptDMZWfKKzMdZ+GTDrMg1bujGazEOKmrSQ0Oq87
	 oXBecW6kp1BqddrjIxPwGFIBkYpvwYEB9tHfRniDwwTzl0WRDPpEKOBo4utdKkpi9E
	 YpLfXjmcjJO3FcuOK+SczTNGJpBw2iAtQxE79n13BqGtOZYBwfRsbkz8TgxcFBX8lC
	 iqe+qjZT/VkntTAOs4UbmLIVOC7yRuZ28retoBkicTdr3XW8LrRQyBvHjUMu5sGXbV
	 nqPYQugFDm1Uw==
Date: Tue, 15 Oct 2024 10:38:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 06/10] iommu/amd: Reduce domain lock scope in attach
 device path
Message-ID: <Zw4p7Gc099DtQ_f1@8bytes.org>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910065812.6091-7-vasant.hegde@amd.com>

Hi Vasant,

On Tue, Sep 10, 2024 at 06:58:08AM +0000, Vasant Hegde wrote:
> @@ -2119,11 +2135,8 @@ static int attach_device(struct device *dev,
>  			 struct protection_domain *domain)
>  {
>  	struct iommu_dev_data *dev_data;
> -	unsigned long flags;
>  	int ret = 0;
>  
> -	spin_lock_irqsave(&domain->lock, flags);
> -
>  	dev_data = dev_iommu_priv_get(dev);
>  
>  	spin_lock(&dev_data->lock);

This patch inverses the locking order of domain->lock and
dev_data->lock, have you checked all places to make sure it is safe to
do so? Has this change been tested with lockdep enabled?

If so, please document that aspect in the changelog and why it is safe.

Regards,

	Joerg
