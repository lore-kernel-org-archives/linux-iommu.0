Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645815C3
	for <iommu@lists.linux.dev>; Mon,  3 Jun 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421754; cv=none; b=ergob/8TqEPkQkMK0xF6wpvuCjf0lY+oxmAJcP1rMSiA9SmZQT2vSLOZJHcQWn/aGx5KUJ9IxEV6eTqv+QQfhjgR5KWuc/Ir55AL8VNjJtgsonuxjWqA4XxCFCrHvKMbYnK3cLqBlObSR07z7jpc9RN1iQDQ4vtRI3LBjhnKoQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421754; c=relaxed/simple;
	bh=5vkjRRpZm+wtBgmWH3raHLW2cMefR+vkRLLw6ojp6zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPUtfG2p4ogLBrvJHwUz7IQ2LHbqHR6IFvPoPtHoWIgkt6MVKo3fRJLK1kKksQ7lfTHe5mwcVXx0Fpt8ZU14kNoSf+BY6qom5DFGYlqc7FCKv6bFIJgq42n6yH6l6jkmpieo40vHiOvnlJ8RXnaxkWZTXOhDw2StND8PeOBHYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dKQ4yKo+; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dKQ4yKo+"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-250ac3acc6cso1054813fac.1
        for <iommu@lists.linux.dev>; Mon, 03 Jun 2024 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717421752; x=1718026552; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dpQgkoNkKgb0seCNmhxhfzV1gHyMbT/I1OQXluiQxwc=;
        b=dKQ4yKo+sa2v+HQFIaSfSKjVexXPXvWRLJLeifTSmvq3hs7t3CbkkwmnVO6W+9iXEI
         8qW8XtRsaOu4JvvhQSzViZVwdibhTHFiD5Qjz7VanS1Lht6aiNA/TmqV2KfKF+QeBCpG
         hXz0CHOfAfgHP443hGUeYMdEbscwL1wvxd0/q1GBt9Js9gahhGulwuj9vZGNM7n3KqKI
         A0w63jAsiW2SNOz3FpzNVF9j8QuDcc4alhl8CymOJe9eRnIscej0w3hQmQgWA19lqX+p
         09DU6Cybt2T9n3Y44iAx07CcmEKLVj5raR64KOQmhO3KZ7N/UZKQh99VcvMi8c9/r5hz
         sW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717421752; x=1718026552;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpQgkoNkKgb0seCNmhxhfzV1gHyMbT/I1OQXluiQxwc=;
        b=KrRwsNzGTdwod8sX8WevJAdSQOqUXy0+aJted4XbJXRcIQpBesJtEQyOtquvPRXS1A
         27thvs5PscI0F0F8e6+IDob5hLxYJkrId2/F5AA9OjaNHXpeOXKLuhq5qyL78niZe9iV
         dRt31PNeFY008iPe0Y7nx0FeOSjEygc2fZXDhYrECGOyO1piDJCFNQXfY1I9ezesRIl6
         ZJ+AgKURdh8l9jEnPOmbriD5CWtO+TFTk7PGAOn/oSXGq8tF1cTXAJ+MPjOZDu96ZKrj
         mY9DDavUEDP3PZoNQZU1jBHFqfhI4B2qw60q652RU1GoHbmQaeeEN/CJ5PsEIFCGzs0I
         rfQw==
X-Forwarded-Encrypted: i=1; AJvYcCWpQ0iERYgvImt468ICR2U2KQrbFsg7BRGpKRboRJfyExLplQX9GpZwcYHC2o94cnPBO061D8QCn2eFnen69OBPJBYOZDo=
X-Gm-Message-State: AOJu0YwMgM9gH2s8MTu0Yma0qBassrO54MsFB1jybNRfGjSzb467SDep
	InZ8PcQZZ8t0wy8q0xkrJaytb/CLLPKI9PZd2wDWVWlq8rWp85rEZUP846aOcb0=
X-Google-Smtp-Source: AGHT+IFk+PIg9jr3UzWb/ecm5ANWBtqD6TQzpjGRhkl/ZcSOByIZ3UxqiIS2caCT2io9CTuWhRCjQQ==
X-Received: by 2002:a05:6870:c1cc:b0:24c:ae57:b4b9 with SMTP id 586e51a60fabf-2508b7e469cmr11967214fac.14.1717421751641;
        Mon, 03 Jun 2024 06:35:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f3172d05sm283188385a.113.2024.06.03.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:35:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sE7qo-000Eba-Az;
	Mon, 03 Jun 2024 10:35:50 -0300
Date: Mon, 3 Jun 2024 10:35:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] iommu: Refactoring domain allocation interface
Message-ID: <20240603133550.GA21513@ziepe.ca>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <efd902f6-eafc-4a26-8057-bdd9d7d6e535@intel.com>
 <a1f2c08a-e92f-4080-b55e-8d6dbd94db78@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1f2c08a-e92f-4080-b55e-8d6dbd94db78@linux.intel.com>

On Wed, May 29, 2024 at 08:02:12PM +0800, Baolu Lu wrote:
> > > drivers/infiniband/hw/usnic/usnic_uiom.c:       pd->domain = domain
> > > = iommu_domain_alloc(dev->bus);
> > > 
> > > This series leave those cases unchanged and keep iommu_domain_alloc()
> > > for their usage. But new drivers should not use it anymore.
> > 
> > does it mean there is still domains allocated via iommu_domain_alloc()
> > on VT-d platform?
> 
> I think the drivers mentioned above do not run on x86 platforms, or do
> they?

usnic does.. What was preventing converting it?

Jason
