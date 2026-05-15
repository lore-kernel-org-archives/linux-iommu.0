Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547EC3F44FB
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883564; cv=none; b=P2Sc289pqNfhfUXiQuJv/dK2qYtDgL634kL37Inqabmx9y9hUSorDaqCPLKt3MhZiY+6W+c/GahBSuOMjJOLEdFmOWI5NUzLEuMXq9ylEWq1wefviHZNAcColNdW0/jp1TSsK8OWjc0ippSHTTI80hCDSmQGG+j0jgfi5zp7JUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883564; c=relaxed/simple;
	bh=8SzpbZgJBvBRL/hzxIjQ/9GeIwvuw2el3nJZdpXd+WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPTvDI7R2pmIImpj+crok5nno7MjifgW22jJ2DJ8GXm4PqBLRpBP+7Wpk4ijbLxvalz/56VGcBENKwP25XPG9H6Cl+saxj9pQVSNq8YPKBCkOxxaGYEfQQo9VNKaUf+AT6lAlPjoQ/kjXt+xdi9KMDiSveCvMMdEAQG1b/1LoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IRxG6WCc; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IRxG6WCc"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e63771d91so5304951cf.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778883560; x=1779488360; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz77QHSF30CmLvYON6sVw/Gk6vw94UV9wtrxbUX8y+M=;
        b=IRxG6WCc1ZtEhjv6viZgCws1IAvl1xe0mIgz9htC3MSD0BYElovf/tT20dJxpkQqzk
         hdFA2q3Mu8ZQuKg75eryn71iLoVX33/8CKsyhSL2mul8B9Cu+lwRE+w839nFMshihJxO
         rpEVnOFx3CiK5oetHFmwX8cKYkZQOgyGkObzZj/nRQzQ8gHmJwXpYCcPrv34ZOAygYUs
         Tw91oFLXJCkjwobh/tfL+3Wi8LRNo4nefUS8yz9ik3eCYx2oDjaEhRALRDFR4NgYUHMd
         nDbHr8AG5ztf++nMf6R/Ica4onFF3SVZ5w8IFDexrE5MNSn/b9u6/1Pc39U3ZKKzZJ9W
         vuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883560; x=1779488360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz77QHSF30CmLvYON6sVw/Gk6vw94UV9wtrxbUX8y+M=;
        b=eSxrKPP9JPneGfTVLXnciD/GEK2ewGXpo+DPVSUvdoo1CQ5RyTWZGJif03+xbvp1QW
         i8Yi74tUe5PWRctkVrcohnjcFnJbcejaHh6AiRrfkj2CY9f2zrfBWFJvt6poBJZemX2R
         yViv3pJzjO5gyz6BF3es4Fvh64UGZO/dq/8tbFwHABZbhOIrVScEmdnvG1FS6b0bjpNP
         wN1fYdRvI5ePkDbon5I+VXhcK+rNQlVx1JvQCI6xB4KpBXGe4nRNe1jHyui0i87Z9aGX
         EKcTXjxeUz98ZOVOS/9Qbwq15kVdJJhhpqZi7rGZ2iYM78Lc1L4LZv7G5sHK7+ieqMk6
         +rlQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fLdl5sSbN/dN1YLbhPyrZsKS6oYwpF57VL+F9TAo49s11KaaBiEfQeTfgnOwQPCfr/gCpEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQqnxv4Md5Q3emuLtQyMRqEQGvyhp8yn904vG+VIXot4CwEps9
	Eu5UozR0KAWC4r7Ijs3P1bMm6AytrW0FN4vOM/+unhTnlSzOupRwEgAbl4Ch+OLewUs=
X-Gm-Gg: Acq92OHRWU9enOPDCMc1lVYch49/DpOS/ObB6f3SCmqA66jrrz6D5ym3SNIOIn1zL/3
	lCaUTwCwDtxMs0jEOTykG0V0dpkfnDQkAtdBTY1ODSA2BBhJNFg6cofvlehF9wUQB9hV4mL14NY
	U/gBN0KXe8B/GWNL8FRhpD6H2bzaTUchAWNo90z7bLUkW6bUnc90HwoBfi3XkOsYxLHSfR8OAYY
	ujQp1xMqqj1zItz0D1Jz+TcNXNW6KOGyZuJmWQ9p0rgkc5jWHOTmYI8KhTsM1L4bkvmDeFxTfKw
	liW0fZo04jSAbiqj/n2WAd7oC63YI27W8UGKOYHLeTwdvSO1tTahz0COQk/9U10C9XoAaZO+cli
	W79Y9Hv1zqpf2wmni5heLIMKPvRrq9iA6A5ihED5jNzhxLTdq8eRbh8kUYDeXTxLznBjSAzf2X1
	G+L6g3ty3RC0D62yFjvIN6oVjWhzDKtWkIb6S6KDvFkXUC0yrHl0UjkTlwJfQ+By5ntHNwiJXsO
	AO2LEA958TlZ6Q9
X-Received: by 2002:ac8:5742:0:b0:509:2858:3c63 with SMTP id d75a77b69052e-5165a0703c1mr85536381cf.23.1778883559652;
        Fri, 15 May 2026 15:19:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516460cda02sm58162851cf.18.2026.05.15.15.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:19:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO0sI-00000008D1f-2Swb;
	Fri, 15 May 2026 19:19:18 -0300
Date: Fri, 15 May 2026 19:19:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 1/4] iommu: Move Hyper-V IOMMU driver to its own
 subdirectory
Message-ID: <20260515221918.GJ7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511162408.1180069-2-zhangyu1@linux.microsoft.com>

On Tue, May 12, 2026 at 12:24:05AM +0800, Yu Zhang wrote:
> From: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> The Hyper-V IOMMU driver currently only supports IRQ remapping.
> As it will be adding DMA remapping support, prepare a directory
> to contain all the different feature files.

Any possibility we could put the irq remapping thing under the irq
directory?

The other drivers have it here because they are co-mingled with their
iommu HW, will hyperv have the same issue?

Jason
