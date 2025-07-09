Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5584221FCF
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079540; cv=none; b=UlXOR3KLABNnG8llNhiA7I7xkeXQ81fWKtUj4ECch7crkI6Pa6sQcCahTudVBQgvwyy0SZ37ERXhyrHuhFxpzlYxQKPdXoO9bdJdtcwGmxL7X3mkG1O2ONIv/weWe1LnXlEUScXkR3D+0FYKjYRA0M8G5/nGSI0Irz9wsnQ2W7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079540; c=relaxed/simple;
	bh=3NUThwn3t/xkBfh4xX7xH6iEkoLptPUMCqyL6R4Ax4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5zXD771SmgaLNl3cArknbZFdHg5bWwCMoWwlBGprIn4tAy4C77UjspOa2ukWBrGZaBf6CF9VVQNwRj9Wf7RTVTtyaivxXDrpNe8AxLHLAgJP8cwhdSuZ6zfv7RqfKL7eA4idknkUHaHKZFnm+0jxVUPanNpLYXh0CDd3qIK//o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HhtEdvYn; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HhtEdvYn"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d3e7503333so7725885a.3
        for <iommu@lists.linux.dev>; Wed, 09 Jul 2025 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752079537; x=1752684337; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p78QlcMtmUxArNMXSNSzK9z/0Q60UCVFZj4PTIuJazk=;
        b=HhtEdvYnndicAbLP9YUc5b4KXugm7sHebeD1xBX58l1yN1sf2buAXRtc60qinV2Ie+
         HC+4Tb+bBnUbIbj4lqO2g4FldAN9DnOWtulQpyzhHKmPKRPs8AmNrby1EEKrmJQ1XfG0
         pxmSWQmJfgebJWLdT84PRYpyzsacuwqyBkVfKUNKPCHxE7A7mj8iAzEdwz6zXkU2a2SK
         QL+r/f/HJdRqc35t8+mOraZEyH1lkmQ2GKLbJW2bKBM7tkT5WBjx1ibgMje/pBZjQ/tI
         oy9kO++KH4W6WzShjeskJiKhAMRkG7ud3Tg4C1OFrMgjmxTcMkyJwQuCc5+DyVmX8T/Q
         /GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752079537; x=1752684337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p78QlcMtmUxArNMXSNSzK9z/0Q60UCVFZj4PTIuJazk=;
        b=EqcHItKooQ/sWppz2FidvICe0PCOjsMs8afUeW7YVGmohBjWNG/d1D9Wcy1mNgjXaV
         PrsswdYUAnVKVP2tpf1DBuwKUXhiSpIxOcg7BBgh0ukRMVjPsPf+viiP8CvXN5Y6wmIN
         FQPs60h0WIfkRpMrfnchxQTklaw45wRlVmvsbIVWzQbf5vPaRc0jay+KB8veasqvoKsK
         Hto9yEjgYDDmiInhIWI1r1CqxUJ+aR+4y+ulhgGKf1yJ6Vqmwybf2VD3xhI8qBA/yrK2
         jrd+4naKwOZecSH3mixYO2f77ri/sRa8QsG3LPfBsfpPg5XORKIx1iCg8F4PiCMeTVlm
         bh4g==
X-Forwarded-Encrypted: i=1; AJvYcCXgL4E4HdHJnodvNfK4STC8qh0VZn9SWmD8Pq9X+uJufVZ2MMKXMIIZxPzWvQ4kKCVbgqkzcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvyifeMZOK4rZpA7nZuOhr7e1ra3uUS6j78tdqu4QvKV/Mzy9P
	aYWPZLJfs1dw+t+h7+Nm9DF58mEB8Nwc/j2F85jCypdOJKzgZgWWEs+iNIowgqTDBH8=
X-Gm-Gg: ASbGncuPUvK1yz3Sq6lNZzTQ6rPfsHhqA+LCqRirpZOQ2XzOodVpVTATaBVbRBLDu/j
	zO8AGQ61P7VBsg3Rd59lHAFvxTWLOEBIRekwh87pvGnxrPK+byWvR1e4TpN8/4GEzDLjvcbH5A6
	0gcA/O21Q7BsHh5JPpJclEXLz/Ri+gdlG0Ng8w09cmYdSU5oOMpGOP31DwrRxH9H731XwH53oBU
	3Lwy9ON1CIlY2wxa31WJzNHfx121GsexWgCJgWaue9rfbTylnj2n3Unk9gnusLtRk6HMcWkT5pw
	gsN67lA3srQIB5z8xl7KF6n4pFQg1E+njcou
X-Google-Smtp-Source: AGHT+IGK03f6ZaextKn5HgBl1Cn7IIaPVEmVU0WLiCp6KHagOT5Rlof/NRcyv22KPYGKQjltoso/Xw==
X-Received: by 2002:a05:620a:294b:b0:7d4:547b:39a2 with SMTP id af79cd13be357-7dc92c86103mr31634985a.12.1752079534564;
        Wed, 09 Jul 2025 09:45:34 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe8f069sm969867685a.77.2025.07.09.09.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:45:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uZXvJ-00000007Sge-0n2C;
	Wed, 09 Jul 2025 13:45:33 -0300
Date: Wed, 9 Jul 2025 13:45:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v5 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250709164533.GA1759573@ziepe.ca>
References: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
 <20250709085337.53697-4-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709085337.53697-4-benjamin.gaignard@collabora.com>

On Wed, Jul 09, 2025 at 10:53:28AM +0200, Benjamin Gaignard wrote:
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
> +
> +	vsi_iommu_enable(iommu, domain);
> +	list_add_tail(&iommu->node, &vsi_domain->iommus);
> +	iommu->domain = domain;
> +
> +unlock:
> +	spin_unlock_irqrestore(&iommu->lock, flags);
> +	pm_runtime_put_autosuspend(iommu->dev);
> +	return ret;

I thought this was mentioned before, but this doesn't handle
attach_device being called twice without an identity attach in
between.

And now the new locking doesn't protect concurrent invalidation races,
the lock is in the wrong place.

hold the domain lock across the whole sequence to hold off any
invalidation until the linked list is consistent with the HW
programming:

 spin_lock_irqsave(&vsi_domain->lock, flags2); // Prevent invalidation

 vsi_iommu_enable(iommu, domain);
 list_del(&iommu->node);
 list_add_tail(&iommu->node, &vsi_domain->iommus);

 spin_unlock_irqrestore(&vsi_domain->lock, flags);

Then remove this:

 +	/* iommu already attached */
 +	if (iommu->domain == domain)
 +		goto unlock;

Since the fix above makes it safe regardless.

And, also feels like again, but vsi_iommu_enable() needs to fully
flush the cache since the translation is being changed, shouldn't
there also be writes to VSI_MMU_FLUSH_BASE ?

Otherwise the locking change looks OK and I don't have other comments.

Jason
