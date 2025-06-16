Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437622539E
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111829; cv=none; b=uQU4Q84Ad7dj7Iw4CWsLqqqUKScd4tQbP4/hjwVytSKscXbsJfT7p3PFIJR3X8IV1YHA0lkcH2X7fxIMmlT5n6Q3CqlP8123nu8xduzCCrjDC1Kw7T/nqulSA4FW1t72uoyqVxYGHUVjc4HCyAuHU37LmJHlFxeHIphRKkWNHGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111829; c=relaxed/simple;
	bh=8MpOJnSEQjfDa1EhgGnvBups2yrDGZ61bYb4+vQnEzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BreJ49w2y+Z4ibgV9o9gPqMS0KsDbqpoC24cHjK1Uy9yPPWyguYMn4twxTD7rbPbmG+2cSl5NNq7yLdFV3kqx6/Fzh4eHtKAYu8auLuFxl3/VBnnbDeAf7NAhrd9U87592R/OXxYm8GFKA9+Y/uxgZ3uV4U+Fw44ni3UFPuztTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T8T7j3Qg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T8T7j3Qg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235ca5eba8cso61005ad.0
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750111827; x=1750716627; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kNU98GqvoY/2N+rHSgzZWQGmQpqcL99KyddV2L+Mps=;
        b=T8T7j3Qg5F8pUQ+8bklhyEt6QUu4Up4D/hTq63kHZibN/xMaJwqOJv+lZgciNB1MdP
         FRLo2boYCcWrcom81G+uGcic6v0Ao81xYYU4nDYyllPHZMirxGkIdfDJNoJqK4Vbs5V5
         HywIgxEyXH5/TDh3MZ9HAwIxgzboZBLXkm5greWJ7aaCebVZePsHZBm3DelMs9buMLuZ
         j3k/s2FdbiVO+woN83toTrcrYJnL5T4Z1JIwh3uV2XpgW68cPnv4QrSLdbMgpqlBhmLC
         i689IbUY3vBa77+uoFvik8PeAtYQzRHgGC54ZzNOM1jEtwUqhtRjyWMUsDHPnpUXmuVd
         jHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750111827; x=1750716627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kNU98GqvoY/2N+rHSgzZWQGmQpqcL99KyddV2L+Mps=;
        b=NzcnOkIJ/C5n3i9+a2QSp8z5LGEYHEcF0Y1QSEtQunJU+feDnHDnV5QLqhH6u65odJ
         9g+QoRekNKCUYgVBymzqH8Hf97qbPl71YxIneOXpwtOqY92WXixs38issOTizDvzOkWv
         DaYHcI+gBKRvKBLi3zoJ+b1QB49ghaq1+A5xS8r/qIq6zNh1cYYlgOnyY2Y0qsjNMjDF
         YQJl28M1Fb4d91nCavZsmbcFYG0BaODxnDP+6M5MSRiW7uG63rXvRR2g4+ieiLoeDrTQ
         O+Gd+Wq0T63W2K4orNqgiBF8+56I0Nr6KbPNjskRzDU0yywi9zWJpMdfWU08PPfbJ/vw
         KujQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/R+Vs0V91DavA0Qt8sKQcsgWrOAtKY/tggLUryiMIZ2ohLn7Co95A6JfZHHpJbUEwiHFIeA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/zPUz43c5kB/hwYBUje47Q+KBeYXdOaB2qrp71Q9NKUeqVKvE
	ZquaaKOSjoMgusyjEFjJJnui0uIKz91h9d7usAZeV+SX4YV/fqVHHWH+zPI0+I0h0w==
X-Gm-Gg: ASbGncuZeVYAG2TBi6EdeXPGBEbva3BvpiJS+O+i9ixGh54s4pTaq9xbs9lE8fbPJbV
	OgtB/MCdY7e9OdKiD0LbzwHWnPjyjAIDQXicSfNg+APXKvV6D3W9p7Fz2yJu5sAkC2DWZf/GUMy
	DdIjOjsVK+uyVdOr/bDgqXsG3tB9eT7RzhLmg6Dn367zLpbC2ETPiblWLqhLllXzeyJtfOA4SPN
	TdirMRgeSLjhdI6+f7gmZG17hX5LxW/iVhTPbmid71utDtk/4gvCp9bWecEomY7koqnQK1bZt/w
	ee1DjdpGIrMdhBPn20JrQW9QEy8/bPxA76KW8FFHcE0G+oJG04TFtrUC9JToYWAeAeI0aAy1eSm
	2mGYLcZikW5JcbErvxuzz
X-Google-Smtp-Source: AGHT+IHafQhQzPRhJ3j9d6qdD5hPqdbdu9Gdsdh0mrYjgCf+ykHfOaUnI39p3vGID7jjfHRJysZXkA==
X-Received: by 2002:a17:902:d48f:b0:223:2630:6b86 with SMTP id d9443c01a7336-2366eef035dmr5556855ad.7.1750111826636;
        Mon, 16 Jun 2025 15:10:26 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de78e8asm66412495ad.132.2025.06.16.15.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 15:10:26 -0700 (PDT)
Date: Mon, 16 Jun 2025 22:10:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, yi.l.liu@intel.com,
	peterz@infradead.org, jsnitsel@redhat.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 06/14] iommu: Introduce get_viommu_size and
 viommu_init ops
Message-ID: <aFCWSZpFuhAweGdb@google.com>
References: <cover.1749882255.git.nicolinc@nvidia.com>
 <3ab52c5b622dad476c43b1b1f1636c8b902f1692.1749882255.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab52c5b622dad476c43b1b1f1636c8b902f1692.1749882255.git.nicolinc@nvidia.com>

On Fri, Jun 13, 2025 at 11:35:18PM -0700, Nicolin Chen wrote:
> So far, a vIOMMU object has been allocated by IOMMU driver and initialized
> with the driver-level structure, before it returns to the iommufd core for
> core-level structure initialization. It has been requiring iommufd core to
> expose some core structure/helpers in its driver.c file, which result in a
> size increase of this driver module.
> 
> Meanwhile, IOMMU drivers are now requiring more vIOMMU-base structures for
> some advanced feature, such as the existing vDEVICE and a future HW_QUEUE.
> Initializing a core-structure later than driver-structure gives for-driver
> helpers some trouble, when they are used by IOMMU driver assuming that the
> new structure (including core) are fully initialized, for example:
> 
> core:	viommu = ops->viommu_alloc();
> driver:	// my_viommu is successfully allocated
> driver:	my_viommu = iommufd_viommu_alloc(...);
> driver:	// This may crash if it reads viommu->ictx
> driver:	new = iommufd_new_viommu_helper(my_viommu->core ...);
> core:	viommu->ictx = ucmd->ictx;
> core:	...
> 
> To ease such a condition, allow the IOMMU driver to report the size of its
> vIOMMU structure, let the core allocate a vIOMMU object and initialize the
> core-level structure first, and then hand it over the driver to initialize
> its driver-level structure.
> 
> Thus, this requires two new iommu ops, get_viommu_size and viommu_init, so
> iommufd core can communicate with drivers to replace the viommu_alloc op:
> 
> core:	viommu = ops->get_viommu_size();
> driver:	return VIOMMU_STRUCT_SIZE();
> core:	viommu->ictx = ucmd->ictx; // and others
> core:	rc = ops->viommu_init();
> driver:	// This is safe now as viommu->ictx is inited
> driver:	new = iommufd_new_viommu_helper(my_viommu->core ...);
> core:	...
> 
> This also adds a VIOMMU_STRUCT_SIZE macro, for drivers to use, which would
> statically sanitize the driver structure.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h   | 15 +++++++++++++++
>  include/linux/iommufd.h |  6 ++++++
>  2 files changed, 21 insertions(+)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>


