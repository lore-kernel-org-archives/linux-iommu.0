Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644356EB7C
	for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741555; cv=none; b=tx/CTPBzpVZkWTG4jk8vgYTcBjg47JPNE10aO5vxdcix/zF4Cq22BFStlnRTiukkIYmaUIYD9PeCnthihWCDNzr0vrwx+Pz+QY2ifMh2R8R+eY5pF3SG1nw9OZcYDrLTY9rN2UHMrwsjfy4DE/aY0dFC9GZdgxoeR2lCTDaDuK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741555; c=relaxed/simple;
	bh=ixwHm9s164H7lhleYumN5xZomvZGH6ly6DxBenbRgNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8FjTiB+LizB5FtWiqM2aE6RoqZzr9xv4hdBKc0RMR01jIcMSU6IvsgATnUecxhissetvg7nLPQFl9nJB84IMJUhYkT6FQHy4AdxFt9VO/1sXE6TLyd3bZQeJsgfnQjQ+HLVUrTYhrj2oqT9Q/7dQqiWciMNMXy2/jliumCrAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bklwkHd1; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bklwkHd1"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44c21981043so7820801cf.2
        for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 16:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720741553; x=1721346353; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CClLV1tB51ZaX86iB9FDhvujW8hrz0rku38BFiYHCho=;
        b=bklwkHd1KA1TokrTHeM3TJJKvIN7kmnh+ETIoKLcIqmc9shWcepovUCcgf+xFuaCaD
         xGLVEx2tSL8L3lDuVJu8I2vBij10nktATbcLeaj/i55jNyMY2CXv0o/EiG9xmccw8bUI
         s6JOmqilmG6tR4hzAZqnx+eu63lOoYR8LE5LZ4Rve8KE7LuusMHHg5Dmc71TsNd6DZ7V
         Ge8jx5Z1mzkz9Jt1lk8Kjnq7rRrWWhtytHuwgab0AisL24p8PKbRlv5HQ8t8yzGmzo1o
         6W/PaXdUI8Wco4ewpJRkxZmUfcHsyNiV0jPlaEpmKfa59G3pkscusmSVt+Q/IXqSqbAK
         Fsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720741553; x=1721346353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CClLV1tB51ZaX86iB9FDhvujW8hrz0rku38BFiYHCho=;
        b=cE17SQ7WBKndZcWYd2D+mtPr/HWo98yuhtcICvFb21vKC3gLexcGy18nsa/udDSj5f
         lD7kvRDcK0zi0JulmqnKlj5Rq6r3bTFykY9/P2t3Yr2X1lq2DnN+5KQo3tfCt1iURn6G
         OBONFSzD2NAo6IapKVFGkoEEz89LEY1tsqz2LRNFRmW+645Dl9qq59moxBR87QNKl8fl
         KU4sDkdSHXAjNUYStFn39LrnugkuruPaC7M+jtHsWL+ziJFtj+jIW4d16ynSDT5e8uLW
         Y37NZD26j+b+LcApWPOHUA50c07DjPU9XmrBFn5zNdapKaT64yzGTz5LPuo51kc5SdT0
         7OLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL300eZo9TksT4wMPleAq8V85ygsgB+G81YFIsyH2BrrxHnatzO2WVI99uDuuz+G1MrYMVfI3oc87Ec8bY6Fr8LnvrF2U=
X-Gm-Message-State: AOJu0YwB02vRiOvl7epCiOKVblIGTOVTaqLpCKmxqpX/ZKuNfiTzy01w
	1VvdOkqoZkT5otiC7lYlbqNssvLAIkE/PX3a+TyUXiN+ZsKgs3o6MLXSHN71o54=
X-Google-Smtp-Source: AGHT+IGCxyT9qIVCEjXNFSJHXsvAlc0MYxLm+Aq0I+IiARoMTxGfb8kiptQiG1V3+Q00EN8jXeloBw==
X-Received: by 2002:ac8:5848:0:b0:447:e364:ab41 with SMTP id d75a77b69052e-447faa495d3mr115034431cf.59.1720741553352;
        Thu, 11 Jul 2024 16:45:53 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b2690csm35263031cf.1.2024.07.11.16.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:45:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS3Tz-00FUa5-38;
	Thu, 11 Jul 2024 20:45:51 -0300
Date: Thu, 11 Jul 2024 20:45:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommufd: Avoid PRI Response Failure
Message-ID: <20240711234551.GV14050@ziepe.ca>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710083341.44617-1-baolu.lu@linux.intel.com>

On Wed, Jul 10, 2024 at 04:33:38PM +0800, Lu Baolu wrote:
> This series is a follow-up for the discussion that happened here.
> 
> https://lore.kernel.org/linux-iommu/20240709173643.GI14050@ziepe.ca/
> 
> It prevents user space from responding to a group of page faults with a
> response code other than IOMMUFD_PAGE_RESP_SUCCESS and
> IOMMUFD_PAGE_RESP_INVALID, which will be treated by the device as
> Response Failure according to the PCI spec.
> 
> Please help review and comment.
> 
> Lu Baolu (3):
>   iommufd: Remove IOMMUFD_PAGE_RESP_FAILURE
>   iommufd: Add check on user response code
>   iommu: Convert response code from failure to invalid

Applied to iommufd for-next

Thanks,
Jason
