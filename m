Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B075314D29E
	for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842918; cv=none; b=mIYgAiypI7N33WktlufyoDg8RPqYRH5FjE3thqR62l4PaWUeUtJtnyo+TsouJV5EHzNcrHAvGVR6cefga5tNINWLS7ltbY725rfwDVQSBIcx8LvMcZ+uCuBDgvwky/A9UrbDQM52YWKjw7WbXhq4rvzSuJAiHaTRFPWdG9NTiTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842918; c=relaxed/simple;
	bh=3oGpsXWmc3HGA7rtUUVqBCocMMuUmgvht732EoPs5XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpTQdExcyJtUJiWBrILNKms/sdFSbeY7dKMoOB/rCATi4UphPPeV432lp5TMhBO1q+5SukQ1UugIDNCfb+GVytQcfgP/E5pGZ6xErP5dK7edsv5+pERjfhzvKCSMJQ6n8a6y/5pMiNatTGHcSGXX6JESi5e30qhDCmmGA7skCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JmvCSLXq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JmvCSLXq"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43492c1a8a4so21004901cf.1
        for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 06:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712842915; x=1713447715; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9v9IYMurW1GEHuOD/BlZrlZ0U0DSGWxEk7s+eTR4EGo=;
        b=JmvCSLXqykfGXBF12XQRSswa5sOaDngM4FoW38aEMPyItHUSl2q97oUUaccMRXojK5
         5s1SVbrG252C1FdB2o9Wg1YATYqR/dv0H9Ee+TjRP++eUPzapP0A/bzQo0v6aiiDcIdF
         hQHLgacaXDUXqkNRNCgSy+4soc+aamrAUt6rpZ/VzJI8Tl7iniRMEzsShg4PSWUhOCjB
         FkDZYiqENxYbpf99eol45H0/DWCtBVawZ4wQdZsz1J/zHDXuOvQUcsv8zEMlrbfjW2RJ
         K00C75SzYIvatfkHZxa4kgz/QwpGHBBnTcctF+ZmKYVax6MvVdxF3rGRsXMk3xojL0Xb
         +cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842915; x=1713447715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v9IYMurW1GEHuOD/BlZrlZ0U0DSGWxEk7s+eTR4EGo=;
        b=MeDe9BdwoS5fLxcuiz5UENr9jVKm4tXgsNCm2avvyb14+I/aYLOzCxOTcgI0kSu47k
         GD7dRm3PRJBEnOHxa3hSsJfpCv7tlgQt0ss0gC19Gy4GDt+BTMtvqhoGWY0uHmPKlNod
         k1qMGR6kfH15fFFtyugRpUVJwK/zNHghZ9MsyxE4iHb6hv6coljP5GSdqzFBeGemQVDn
         V+7FFV3nKNj5C1ELlKgnuuSqGkt/vBIaYZIpPk+PWhMBMxtaHkaQPcYyLt6eNAsbdQh3
         /iwGEBbKsVW7YNRM7/q++fgYFzl9wIKLdd0LEOab3hO1GAZ1FYvmiD+IkXNAF7wqiypx
         Np/w==
X-Forwarded-Encrypted: i=1; AJvYcCUhRPGBSjzp+Ezt0LUj8LM8ZYm2G50AJoYRJrHSK52xQqeJ/exXpEmFiNtFAMzCba+bUiXH+mqOQXzPKXzlpwqZUsP6TRw=
X-Gm-Message-State: AOJu0Yx49XgVtla+9tEVi9gva7VRXCiu5XIDPpGVvUdLUeBiwxcidGaO
	CMu0dbCkHa7YBqMUkNCu19Wxj4nRceAwC1i8m58JRuyp3om89Zuf8QpX69G7ciI=
X-Google-Smtp-Source: AGHT+IG6lO9jxLBIJJs8K37+TPzJ2KkipZ7o4L5la7Szplwxm+9SeI0AwZXwIBZX1UouadNZz1E2sg==
X-Received: by 2002:a05:6214:5090:b0:69b:17b4:dbb with SMTP id kk16-20020a056214509000b0069b17b40dbbmr6353521qvb.13.1712842915668;
        Thu, 11 Apr 2024 06:41:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id r18-20020ad44052000000b00698e65cdfefsm944079qvp.87.2024.04.11.06.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:41:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ruugc-00AkN5-Ab;
	Thu, 11 Apr 2024 10:41:54 -0300
Date: Thu, 11 Apr 2024 10:41:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Eric Badger <ebadger@purestorage.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iommu: Add static iommu_ops->release_domain
Message-ID: <20240411134154.GK223006@ziepe.ca>
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
 <20240305013305.204605-2-baolu.lu@linux.intel.com>
 <20240410152606.GF223006@ziepe.ca>
 <0dda6ce6-1b82-4168-93b7-a0e847ce9b08@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dda6ce6-1b82-4168-93b7-a0e847ce9b08@arm.com>

On Wed, Apr 10, 2024 at 05:37:06PM +0100, Robin Murphy wrote:
> > We should probably be sensitive to the
> > dev->iommu->require_direct flag - generally drivers should prefer the
> > blocked for the release domain, but in case the FW ias asking for
> > require_direct we need to switch to identity.
> 
> At this point do we even need release_domain?

Ultimately ideally not, but I feel better going through the exercise
driver-by-driver before we just make the core code do it
automatically. Maybe I'm being overly pessimistic about the drivers..

Have all the drivers setting identity/blocked domain set release
domain before we switch to this unconditional method.

Anyhow, I just noticed it went into -rc1 already, so may as well keep
going.

> static void iommu_set_release_domain(struct device *dev)
> {
> 	const struct iommu_ops *ops = dev_iommu_ops(dev);
> 	struct iommu_domain *rd;
> 
> 	/*
> 	 * Static domains are expected not to track any device state,
> 	 * and thus be tolerant of devices disappearing once "attached"
> 	 */
> 	if (ops->blocked_domain && !(dev->iommu->require_direct ||
> other_arch_or_platform_reason))
> 		rd = ops->blocked_domain;
> 	else if (ops->identity_domain)
> 		rd = ops->identity_domain;
> 	else /* Hope release_device does the right thing! */
> 		return;
> 
> 	if (!dev->iommu->attach_deferred && rd != dev->iommu_group->domain)
> 		__iommu_attach_device(rd, dev);
> }

Yeah, this is a good end goal.

Jason
