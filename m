Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AEF45BE3
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785283829; cv=none; b=MlMSHL92dZKBnepou+kJh9t2Jj42tNY8yujs3QoJpyFTGdde4c/QQ9r/16hK0jdM/qB68eDkTCNzm+EtPnft8LxbEI2gfCWo1k/XcwKGJ2FljfkeTyTz3O+RF6Pky+yyev3mpl0T0V1cXETtp7sltri4KWVQQM1cC7Xzq5a9HK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785283829; c=relaxed/simple;
	bh=KkoSOGKlusTnK+ZdAUdTrIWUD8iRGveY1t8vcyjuTsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiRtm/xEBNF/Dj4laEVndSkll8VuDgggZWdP+vnOwc3OOUFWaok5a9Z7ht/26JE5swa6wYQiRNcSoQQJ+JDU7wsTLNXVjUVuvvp6Ojb0nwVQdqSh5nBPbHe+m2ZynTDuwuqbnCg1L/ohPKNCFItjz5vO4E1bvdSDx0iJOnElzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=an8Jhubp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="an8Jhubp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc73e322dbso5184005ad.1
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 17:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785283827; x=1785888627; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n+eyuJJuDqUpzb7f6fRfbazX81T9EOhy1ShTPafeE64=;
        b=an8Jhubp+7Il7KF0FTu9mfca31B1oyRrzgeGzUGDp80CGipGMVYyoPWTbIig9nbvrP
         zoleZptklZiVUHKt6bp4gEkOEQ4DTF9chzfpAtUv3fKZhppxZ6Nzgz7gXfGbeaCL7Nms
         Pb/S0UIxY74/vFzyRyqIudI21GEpTxoQhy69OelHs135lDCfOFuvXhbCsooiKhUdeEKN
         /OwdE4H0rCBalT7R9g1rZk5c9PfNV/xZRTkbOWl2usOaO8kUA/s8ld/DhHK6gQKRBsB1
         LQtrGskjZ2XuJrXqsEKCJN4ZZWemVXqtTxxx8EV5uN6Ft5biDwZ2/BJHslvAdeotiGKd
         4sJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785283827; x=1785888627;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n+eyuJJuDqUpzb7f6fRfbazX81T9EOhy1ShTPafeE64=;
        b=KzmdHvIuBTUCRyOI7i4ZF13x1wGFNyFb1+ku0jBJIQJkiQvuDFvegm6PQLU6lKwzI2
         MXau/XoHIeYXX6+PMtMuoWNnS68VPWt61E774vZKOm3mMFAcvohm9TAuGEJ2W+w6XzkL
         oU1Ks3Mufuu8RZGfFX2yOvUDS+pcNw2Cpd5FNNlNPDZ+TdW00DLwDynVDvY/lSRz4ZOu
         pP9TgLOP+9bNf1cfE79BlRYj+vXgMY/oPH4upRrCnkpqf+lIwuVSxs9MnmbgDkeTUQdv
         cQ5lGuE0aqFc8s5aAy/vDFHD1pzRC3ZJzjvdmnSYJ9PjnQuoWzC2ElVQQooppRCTTJTw
         WA/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqpAGbhHBhOj4LXn/HhfurhvIWazA1o1Aj13v/OobFash+fHY9fUJBCQDhHuGaBlsljuuCbsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHNxemq02pogKScSLVGmpK+5utTiz5mix0zPqMTwuzjZ27ipuC
	tGN7CZrZuFNCkFHWWJrd+zEH2y/8xuKyTrlssA0OICn4BvfEsOXj1NUpOCbn9PIGz84=
X-Gm-Gg: AR+sD12S4eTQI0mdf9N/isQLr6q8QbOa1P/czSOCSQT2omMWIfHngILzQQAnsXDiWdZ
	aHcX2sLcg0FXK6eQ+6LnwYwt922OpYko7aPV8Vj9kw0q3rWsC9o63qW90j3n+PJyjTZ69L8LL5e
	ysrJOh6ygyBJ9v5YTYpf5Wn0HO3ijfi/vRo4+7O7xAcGVLjvQi/7jkcOURLFEABycuXb1xS0YQI
	LWQ9YELNISYcJHLs/c8ot77jlznZ4Ig/tkdiTWElAG1sLNGAluNbpdBH7vV0uYLi71/Z5G6SkKV
	cxyyhbsnlkBbLeLKBQCiZt2BwfBOLnA+sX78xyctOGOxSy5efQSfHn0JhrJMa0vOrHzVRCbdrF3
	NWi7BFnqNVMwb4kvtnnipKinEh71/P81Jgj3VrTB2Z5hItU3b/LURWcU1X2v0NY39S7yNBj0SQI
	cDg5s6laAVKf9kT/UxFqXIOaR0jSOclG1/8KkzLF8/YJf1I9a7tn+XBS2YVSyTrHn4
X-Received: by 2002:a17:903:46cd:b0:2cc:f7c6:8353 with SMTP id d9443c01a7336-2d015da2cdcmr51336395ad.41.1785283827557;
        Tue, 28 Jul 2026 17:10:27 -0700 (PDT)
Received: from ziepe.ca (d50-92-54-205.bchsia.telus.net. [50.92.54.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a4596esm2962495ad.23.2026.07.28.17.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:10:26 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1worsQ-0002DH-GU;
	Tue, 28 Jul 2026 21:10:26 -0300
Date: Tue, 28 Jul 2026 21:10:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Daniel Drake <dan@reactivated.net>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	nick.hollinghurst@raspberrypi.com
Subject: Re: [PATCH v2 4/5] iommu: Add Broadcom BCM2712 IOMMU driver
Message-ID: <amlE8rEgryPqrUZd@ziepe.ca>
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
 <20260727-bcm2712-iommu-submit-v2-4-0247b5c03de8@reactivated.net>
 <3e7ba95b-51e7-48e4-aea5-f86db1739ac2@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7ba95b-51e7-48e4-aea5-f86db1739ac2@arm.com>

On Tue, Jul 28, 2026 at 11:51:04AM +0100, Robin Murphy wrote:
> > +	ret = pt_iommu_bcm2712_init(&domain->pt, &cfg, GFP_KERNEL);
> > +	if (ret)
> > +		goto err;
> > +
> > +	/* Set up a default (error) page used to catch illegal reads/writes */
> > +	domain->default_page = iommu_alloc_pages_sz(GFP_KERNEL, PAGE_SIZE);
> > +	if (!domain->default_page)
> > +		goto err;
> > +
> > +	domain->base.geometry.aperture_start = BCM2712_APERTURE_BASE;
> > +	domain->base.geometry.aperture_end = BCM2712_APERTURE_END - 1;
> > +	domain->base.geometry.force_aperture = true;
> 
> ...and thus (as things stand) this is a lie :(

Well, it shouldn't be here, the iommupt core code should be setting
this from its own internal information. If there is something missing
to add in the full_va_prefix we should fix it.

But, AFAIK this is the correct way to declare a page table that has a
range of IOVA - which I think is what this is doing..

> If you want to operate like an IOMMU, then the translation aperture and the
> bypass window should really be mutually-exclusive;

I think it is operating like an iommu..

It uses generic_single_device_group() so there is only ever one
translation.

If identity is attached then it clears MMMU_CTRL_OPERATING_FLAGS which
I guess fully disables the IOVA aperture

If paging is attached then it sets MMMU_CTRL_OPERATING_FLAGS and
places the aperture at 40G. Based on the comments about blocking I
wonder if the "bypass" even works when paging is on?

If blocking is attached then it sets MMMU_CTRL_OPERATING_FLAGS with
some 0 address cap which aborts everything?

It looks to me like some of those comments and choices don't reflect
what the driver actually does. Since there is only ever one
translation we never need to be worried about where the aperture is,
it could be anything so long as the HW gives it priority to bypass.

Could the aperture be placed at 0 with the bypass fully disabled? Then
it would basically be a normal iommu.

Jason
