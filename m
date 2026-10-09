Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780E48594A
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576262; cv=none; b=r9Qxqn/PHMRWhIXMO+1twkkl9nfsaA1YWsmi+yXMq2xBf7UjFy+JG9dZqBZUunYBJTasKLfNEg7AnopFbX/aa7ubM19dQtorAp8tI5/bKeUvHFAOSXfCgO8Zk7DXIrIjPB7SxP3MJgQyo/eaEo3o3mu3kWjUeprM984J4n3/WaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576262; c=relaxed/simple;
	bh=hAluV0ZsKWum/hosRJaag7DxK3pHK5KP5bP9qisBpl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPpmg7+zTuZ198LR5aMHdGruSR/lvpgTeeotyHzkXYLmU8EDKiSpcpYXjQxuWhB16F7TSHJqplGX8kUaJ+okvH1UW0YfOujs9qrA46CZ4cAS7BfnGcOJSP4G2Gk0K93scVA6xhOZ/BVjOum9riWMG9SHdRzEHRqOQ73YXqrdgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XPJ2gK+I; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XPJ2gK+I"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9199927cb42so1519576d6.2
        for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1791576254; x=1792181054; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F4LeZey2LdZLtm6I9smRb+XZ/TgW85BBKXmmgDgTNho=;
        b=XPJ2gK+IYIpqKutQoQgrk/yo1f8z5/wTmmMnFS8DjKnsjhIgTwOGevHmt+2cp4aQ7p
         I5P/KIPXjFJCuDB8LVXmMVChaCAJOiRvgdB70ZIKnYTk5r4A0j6R66yq+DsHDQCJcDxq
         Y2BJCDamlSvuVx+i9Is4abxITbqTZR4LRrftLuLo7c7CG4RIdUvWHBzoMjbA59MS+smw
         tulLMC8XXvgdcM6L7UchAq9sz67l2kusKq2umraIcTEsjJ0DOMqAuHRKgFIZZsNvm4pE
         StX1h/RnIzoIa9X4h/H149MzbPtGM2UODXqZa1BzIYWr17oFTfnxd1S3WuqO6yHK6Rg6
         QjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576254; x=1792181054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F4LeZey2LdZLtm6I9smRb+XZ/TgW85BBKXmmgDgTNho=;
        b=jK7i7DqE+PHzPrNr9eBtVpX36iNfClS/RsVJIkRVMYG0Iaxb9pF2GQU6I2dtdrKq/4
         wCjCAUNHL2Q0sFVYKAsdSWEIAqttBrPzCCYcGuwo37PfN6IRscjMJkFU/Vz2ZIGMUkt+
         O4rNhXDLdER4fY/lWasRkAgd1QWWzvFoO/1Ff8LMpLMKb5wm/zevI09dGpqgw/U09eZJ
         +ktJwyCYLS618SFQa2cJq2EKmS4A3jjcly4i1DgVVnwOT03Q1C9hw3LfOFvxaaHQCayc
         vfUmr5BoZVrAE4tTKhlXSBEAjYzpihLslH5NgEPqWKM2ZyDTL97NmU9iV4y/AGgXawZd
         rKbg==
X-Forwarded-Encrypted: i=1; AKwUvBz5dj3k0fhGqdJZE1WLTnAgjP0P6QtAbAM7UCT3ZwGlZ2aTwW2sMosZIGW9f3s+DZQTI03EjA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKIHgqgfsQduATNQpPKbpqedozPCmtV3I0XUBn5pzFnXg0HQdCD
	0UWqxItj4k1/+obtoTvoyvk0aDoAD1NpL6rts2BcCY+Nx8JCjgruSGrg06RDYoJXarY=
X-Gm-Gg: AYBFou2QB8W6KG8Y65W30SdCHt0998HdfriZsq093IXh5ZYJNt5WOAaE6U6NX7kRIQu
	qOWVXvWTazP8u1zl+MMAdGT1SAnI6j1LMib3AZzE07LXHxoA+EDfyBOKn7PCtS+fj90m99InmUd
	DtPAhH3C1T2YUokCaFRO8ffmxq+SihSXN2ET8lAHJBnu70Nwc1d8KyI69vIpKsSrGNOUebs/RI8
	1fg7r1iq7FU6hZJPG5BXY1HaO/Su/o/JC5CPsnt0gBQfgtvaYv7WQin9Gms4AOyRigcwKAy1QK7
	zgrmu4o3sMC+zjZaxc+uiocbC1w0LUDKwjLGnZU/gCnxAJ7QnEd8JMiy5+a9Xxp0JxtbFAgqAO8
	s3uhhe7vCt4NhbUw+aZkIXKyRl1jIayT83C8bthRh3aj59eLOWdLoozVFbZ8J2At9HyebVrMQLo
	xMUem4D67XYhBEtce0Vv9vAgzQhNSYO7/SZ9Vd7FUDfeUqWH4bm6qnTiDxn3sznIkATaGVJGvda
	zH5dBCLYoaVBis2BhgaFhYxHF62smQXptAIbiigHgrrKZrD8RIZCeeq
X-Received: by 2002:ad4:5aae:0:b0:917:aeed:9240 with SMTP id 6a1803df08f44-91b5555f788mr51483116d6.31.1791576253590;
        Fri, 09 Oct 2026 13:04:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550ddf7csm26430326d6.42.2026.10.09.13.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:04:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xFGp8-00000000uLx-2ouW;
	Fri, 09 Oct 2026 17:04:10 -0300
Date: Fri, 9 Oct 2026 17:04:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kevin Mitchell <kevmitch@arista.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
	stable@vger.kernel.org, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: allow identity domain during device release
Message-ID: <20261009200410.GC14213@ziepe.ca>
References: <20261008202530.14501-2-kevmitch@arista.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008202530.14501-2-kevmitch@arista.com>

On Thu, Oct 08, 2026 at 01:25:27PM -0700, Kevin Mitchell wrote:
> @@ -2548,11 +2548,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>  	return iommu_dev;
>  }
>  
> +static struct protection_domain identity_domain;
> +
>  static void amd_iommu_release_device(struct device *dev)
>  {
>  	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>  
> -	WARN_ON(dev_data->domain);
> +	/*
> +	 * Devices with direct mapped regions are attached to the
> +	 * identity_domain as their release_domain.
> +	 */
> +	WARN_ON(dev_data->domain && dev_data->domain != &identity_domain);

At this point I think you can probably just delete this WARN_ON
instead of trying to fiddle it like this.

Ultimately the dev_data->domain should not be set by the identity
domain, Vasant said he was going to work on that clean up..

Jason
