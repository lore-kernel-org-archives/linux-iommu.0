Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0310199923
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664290; cv=none; b=ZNMGF8ovlXfPEG793fZhwi0evnaX9SDkyIYn1hwilwyxZ0cxR1QiLvtCxGRh/nMDvnzHaoP8NS6dktp/ydp+wgDu7JRqxtekEoPCuQGX5XBshpxvEqcmbGk/dIoZCC8LqvhGxOzCUUL+dTSsEov4LXAJq3m+f4KFOnVOe8TON8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664290; c=relaxed/simple;
	bh=525ehD9jVRzxqbpKXu59TfkRlURdR2IlhfGKgW7tqZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW+aJT+SJ7wqGEsA9Tr6EYgKKUBVbF0lUNOh6pWaG2W1DQpGqlrm2KsJU/ReJltJygEUl6dc7vkQMmaaQCZBCkWJcVynG77nGwOoMqUdBs3icEI6Zijsf8eXmeUnorwglwqe2uRHXOs2+Tgb59bP8XUNfrV1LPooTTjs5ZorAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cBRjJhYt; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cBRjJhYt"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460391553ecso19678191cf.1
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664285; x=1729269085; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ATpam0YiZTzpjTWMzxJV5L02/OwsB3UVIOf2m/lEpH8=;
        b=cBRjJhYtBgG6cOQuxropjnEVownmvn9sC+mbSIO/HVEVIU5yvdlPI0wdgf/RvqHJbZ
         hxAIabKpxWueDr+1IbpZCy24qytgqumSmA5R1NwPUXOUMyixd6roZ5TEA/oZciNzTqBO
         QXA3v0GNybMrxUNXowulfl8Tjr12P4/vlQKN30Qn6mOBlYlaZQWFaChDB4SSfY5Styfw
         Vm5MM9zHp/6hNG2zAHdp/AR/KkEjreRfEE/jGChb5vlc5MgSDZyW0huoKq5Mu4uPwZ5Z
         F6shWtvTOdZnjx2vNc3MtakjHaNtBV3WkFIFXLhcpiRcXlT1Z4FCnApOBRlqpA0EhdEP
         u5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664285; x=1729269085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATpam0YiZTzpjTWMzxJV5L02/OwsB3UVIOf2m/lEpH8=;
        b=XWEUJ4I49opDbfJcWXDTYhqicSz+VrHLOPIZ9+Tzu/JHlkfPFRYzEg8dgpo22WDXac
         KzODu/tpvI/5itQ2pr6wC57faGP9l7AxVTIV4YxTEGqqixI3u0e63vqdtJjhkdZsXRzb
         zn3polSzOiMXuB7D0nSS6rGSaOx45F3KjITbVppJZlDdN8mbvXmfMCTa4588g0uN0DA3
         5hGHiIgIYBO0t+2K9IAewR8NgeRFE6XrDdqDLdeNS97P0Q2GvkVBeDj2q4GtQ+xGAMGi
         XRavK5raF4ZESkqRkk3pyYjVdm9LF3DmcJddXzZgeTCBwkUuODSfTyYjn25oPDluUvKA
         ChGA==
X-Gm-Message-State: AOJu0Yy4YBM6AelcEdXM9eaefykUrDOYtPhKam5N993XA7nzNgwJOlCt
	gmHLQBxuivoLHJDPHS64ElU65YpREnvVpvWWyM6m8k738jNJUo8jPkREBIj5iAc=
X-Google-Smtp-Source: AGHT+IG75EhZG0d5M9MeHOGeqzGArKbIsd9k8HqJa104wmM37x2TGfXxpHNROC2Jk+MqDGWYtqA4YA==
X-Received: by 2002:ac8:7d13:0:b0:458:2fb7:5035 with SMTP id d75a77b69052e-460583e8b95mr2814621cf.3.1728664284832;
        Fri, 11 Oct 2024 09:31:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460428069c6sm16882951cf.49.2024.10.11.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:31:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIXz-007eJV-Qa;
	Fri, 11 Oct 2024 13:31:23 -0300
Date: Fri, 11 Oct 2024 13:31:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu/vt-d: Refactor first_level_by_default()
Message-ID: <20241011163123.GO762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011042722.73930-7-baolu.lu@linux.intel.com>

On Fri, Oct 11, 2024 at 12:27:21PM +0800, Lu Baolu wrote:
> The first stage page table is compatible across host and guest kernels.
> Therefore, this driver uses the first stage page table as the default for
> paging domains.
> 
> The helper first_level_by_default() determines the feasibility of using
> the first stage page table based on a global policy. This policy requires
> consistency in scalable mode and first stage translation capability among
> all iommu units. However, this is unnecessary as domain allocation,
> attachment, and removal operations are performed on a per-device basis.
> 
> The domain type (IOMMU_DOMAIN_DMA vs. IOMMU_DOMAIN_UNMANAGED) should not
> be a factor in determining the first stage page table usage. Both types
> are for paging domains, and there's no fundamental difference between them.
> The driver should not be aware of this distinction unless the core
> specifies allocation flags that require special handling.
> 
> Convert first_level_by_default() from global to per-iommu and remove the
> 'type' input.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
