Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30342F2351
	for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175760; cv=none; b=FmIZbInu4IdJjgVj92G38hmVSLrwkwTOJlk8yasz2xUSoAXGdS+xqWS9RBu95ZVzJiDuOxBAgOxlCOK9vEgjA2aFvaVH5UfBSxBbb4CYuQwl8WvCfklWq6x0W96RLIH1hhY5duPGzibLNdKtNCCT95DSBHH6Ht8D5+pFep/mAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175760; c=relaxed/simple;
	bh=lOPGK2wBLpYT3HGjJWtnyQuuaqNgrLPd838FyM47en4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlPJBQNd21BBn91AwDXrMegFeCVJv+aRNC0gYfAJABJBl8lxllXE5TuUG1fwUP8PW1/ePE1Ozegqral8Cy3C2N/pWV9fv87vUNeqw/qlltZcU78aaCkznzfvJGn8Q5TJLLsdqZzh5B5dcEs4bEA2sJ2VDJZPDzvrGVQitXfMfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hRBojH2e; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hRBojH2e"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a43972dcd7so75440361cf.3
        for <iommu@lists.linux.dev>; Tue, 17 Jun 2025 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750175758; x=1750780558; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHiEAfP4gzQlO3+hd3Pxtez8+k1aqfmRcE8i41PL3io=;
        b=hRBojH2eyzfi/kT7hIVM+LeRcNFjC8GJPiKobK6kfx9nkikpbhOFQFVeBGRzT5QHXP
         saOv8y5H7LFxZVVsyaX8m5Cp6171A24+4L09R1S0ub2GhiRnnkeRq1OQZ+J/Z9VdEQjH
         0ahbV7DoeHxWGDESHswIWJHMsM5np9ST1WLd2X+T1TpljrFDwCTKjfKZUvwfo54XCQpC
         FygKDI86UPGwKBsA8gC58BwXOWDTpza8hV1gNi9W5yKBXaKXB/qFTjmxmHkLBEq9r0Fc
         FmgJCFA+wVlsmdojW8ft/DjzNQJTgLSz7I9ihCvHX6edMHN99DQ094VaWqIk3OmD0kJe
         5Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175758; x=1750780558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHiEAfP4gzQlO3+hd3Pxtez8+k1aqfmRcE8i41PL3io=;
        b=tjLORmyvH14fvtYR4PZt27nJzbXhFn8oyCQkq3quDiZ7XodTCP4uoP9/PDPqz58SU8
         HldYZveIjYwlRKeOC3dj2K35mnUNqTIek1uFMh53opg5XeR8bfkaL5pXw0RIF3edF2sW
         vFWaXjIDKQZvWB2+rzOPDnN5w7SPKpGXuKJV5W5e4XruvERS+MAQvKPes0IZvY21qpgm
         SM8zHPh2KORDM/MgkXIfwY4yxpBf3dGacNOZlY/UgttnUnbLcDItk3FMDv1S/sMCtk9T
         Rxy7aJ6tEUroHBLlmcbWc9Z/c4CFciMYjOqdiAb2ZyMRx1sgdSiOeZiSaNafP9ezIElI
         GPGA==
X-Forwarded-Encrypted: i=1; AJvYcCWAwf5M4C0HVE5GkpSQyo1bs38wAsSdrO1l+WcFv1b2+KV+yQMKgVOi6AOUJDqvSgPJZD35IA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8lGf6C3FkdYq6rzaHh/RF4/HwV+GaP06p3aWSrDsnuRcWCtPU
	h8JmNazysIiCkN9g9Sf99aa+uT2LXRAVD+t4JZjXLIaMUY14XoKasXUEQT1U6eUFCp0=
X-Gm-Gg: ASbGnct6ASaFS91cd9Z3kifxoY0eaqFPBnYwzqVpIYPrLg3h1/isN/tOcEL+16HySbl
	iqKZ/1I5KcT1t4ulSCWZj21DXcNJgo+q5iC3KkOlXbPybXsrbQNBSTPvXb9rSLgiUdFyqhv0jMJ
	0s580dRWgnoPzw1rcZKh/000gV3BDRVAWkFO9LjHyjMU2T5QiP1Vq4IcP0PPM8y6a7ngUk13Afd
	Y8uJfiapKU53UBvdKVzg+XvJO0t6HwutwK+3p2qH4iwcY1HsokXel9SFp5LY+v270PGRULnSRSh
	hgtbAtcfQdvM5wFaLsKxV3uHprxj7vC7vQ2AtGsnhoHiwTKAOHyndIpyqL0wHAiGKcJxfW7UeTI
	sNYmscSsJNNV/uJMdbfdfqG97isZqhVXa87cFRA==
X-Google-Smtp-Source: AGHT+IF+swq02oh++ntG5sh43vHbq7dO0kIbycrQJMgIerbV6mkh1G31T9NFcVqlSDZb4DoN622u4g==
X-Received: by 2002:ac8:7d55:0:b0:4a4:41a1:b944 with SMTP id d75a77b69052e-4a73c51f7b3mr222738671cf.1.1750175757496;
        Tue, 17 Jun 2025 08:55:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a2c0506sm62393121cf.3.2025.06.17.08.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:55:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRYfE-00000006WT1-2PJ0;
	Tue, 17 Jun 2025 12:55:56 -0300
Date: Tue, 17 Jun 2025 12:55:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com,
	fujita.tomonori@lab.ntt.co.jp, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/vt-d: remove the CONFIG_X86 wrapping from iommu
 init hook
Message-ID: <20250617155556.GD1376515@ziepe.ca>
References: <20250616131740.3499289-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616131740.3499289-1-vineeth@bitbyteword.org>

On Mon, Jun 16, 2025 at 09:17:36AM -0400, Vineeth Pillai (Google) wrote:
> iommu init hook is wrapped in CONFI_X86 and is a remnant of dmar.c when
> it was a common code in "drivers/pci/dmar.c". This was added in commit
> (9d5ce73a64be2 x86: intel-iommu: Convert detect_intel_iommu to use iommu_init hook)
> 
> Now this is built only for x86. This config wrap could be removed.
> 
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> ---
>  drivers/iommu/intel/dmar.c | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
