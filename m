Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E0D3563E8
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647407; cv=none; b=CfKeOLN791ZJZ+roq7YYzxxcLogiMft7eksSDcedUY4IAQW0DPgBECdDLOcpvmUQOfPTnXhoM51VXh4dSWDsLcZBlRf2rWOiVLSWNjlNhn1CMJE5nUlWZ6PT0dpuJFTiPVbwc3YwYl2Uc5iDvAEbuWcJaW2q8rFuLxEeT+MyBiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647407; c=relaxed/simple;
	bh=n+DrKzVlK4Vo1TC5awVrKdPz1JHSoXcF53SqsJK9/YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDEQNqK3T7xR+ZXltjXAIM1VhZsAuxNQuE0eW3jIsSu22w6nVkIKYO0x8ljOmW94jaXHsmiMu1BPDeaI3rI0sRToJuKZVxPYiV5Z0VCNJTt4YrWVTFdu17hGdmehYqvzbuFggQxh748j3C3EekDREcJ8QmxyowziBe1jo31Xohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BiLg0Ad/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiLg0Ad/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf2d865383so8995ad.1
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781647406; x=1782252206; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NoLcumEN/kPT7/CRK96A5RBRgsnrugeYjsKegpzlXQg=;
        b=BiLg0Ad/T7SjDoO4k4pJBucmpB00gryFpATRrK53pZFElLIdxeJBFVIDlzJsgiG21a
         /wT/AQJS2t0XWFjEqAcM7hgcrjFrpFwLceHUhT8SwWFpqWkL4VSHa8mIt4NnSoRI2Kom
         L02Te2uYBLNYjotB87rNF/Ea2Tt3ioJThTZpUs3ErOtS+g0CWua0mYXSYK5jsbx+mdiB
         x8PXnZEtulIEmjO6aJgetm007lsU9JP6weosx4pGUxwo8eSGuExqQsjT4qouZh3zyy/H
         fW0EWBBpbuu7ABRdJRkzKVWGUcT/jgflbKKwQZHokDZxXp05ffg66fZgnZEJ2FWBojqV
         NdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781647406; x=1782252206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoLcumEN/kPT7/CRK96A5RBRgsnrugeYjsKegpzlXQg=;
        b=sHlLtNa8JuOOAIoEMMHIqH9nUBkyaE5zl9GKW1cdQ8YiHxX74WOzKfFGxRUqjuciJM
         Mbucu5yrOOHOkxEv65b41yv3zDvZsHQn6lNlRXyq9JzPS6e5kwMBIT4Y28WxP3nkrMH4
         VB4DQZt+cW5v41jRO7YDouElWL0An0KzS67s7kTFPjjJLhElK2YL2hFRmf6LGvyNV/7I
         BBDKikAMBaLZ7aPCnpMkr3gkdl5+GxFytALLqrg2c8AsThaRcbSHnYawdhGXfjVbvw70
         FbpfLr8xHlVcBnTe4y00vODXy1gURJvsntC+e/OGzZjAo/fTQRC4Zi/K/WCVclLADfwc
         hzMw==
X-Forwarded-Encrypted: i=1; AFNElJ99ykGbAqX2HA4QteLY2ovoGCCTEDvRs0Mu3ylBewZrQaZ783YnjqVRh9BSYZokgQQFNsgl8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAxhh2jtLw42+XnygyhZ73TQi08Pt8PPj0Dh+J0eA8px9dmNe0
	Hg1XX3H2F+qW2wIrz3ip9kCg+k4hqDxVA3GUBZSzai0TEfWS8zNLfVRnVNYInP5QAPmVvECnaHQ
	DtbZWUA==
X-Gm-Gg: AfdE7cnO2owzxSKXrr2pOtbEbMdIMeSOuetX7LmYzldXmUPvtJYKaRf2F8iEORfubKC
	+gPQwclHcAvZ7paQG2CFESOP4ea2YmFOis1CakuKdA03NihSDjT92NrnoUkaIXjYDuchh0KtEWN
	IbiE6QkLLsrS7x+ejlU91w+cIUzSTn1RmAreY0AunlBtUwRwMMFuILfrakhSpnviMF6QJKSys/H
	XxXa0VGhq12dzFlzChAue8SXYONLznPrrB7wESSZhY1bVgCULOkpt6XujbKmYz7Frux6nLvGgBu
	e06RU1cRMijOQaS9elnRMJZlQilGmUPxVHKuDvryl3cNhGKzG1zY0/EZVmmFm3mr3Zk3466sIre
	vUn9dA03ObY2YIxPUmJk4L90RiB26cDdbWcH/1hLpJ0QdagAYjntXQBj47+klJJ+kmQk+ybt+0j
	L7AhQgDGDRmSsFdoE3wPdcCrCtq7OUGGCUhluTWvqylBSVuiO5XtvEY3jU6+aE
X-Received: by 2002:a17:902:e94e:b0:2c1:ee6e:be1e with SMTP id d9443c01a7336-2c6bbb0fb90mr786055ad.28.1781647405537;
        Tue, 16 Jun 2026 15:03:25 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4330782b2sm153062475ad.67.2026.06.16.15.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:03:24 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:03:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 5/6] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <ajHIJfV_oSvpooT6@google.com>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
 <20260611172658.3421138-6-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611172658.3421138-6-jacob.pan@linux.microsoft.com>

On Thu, Jun 11, 2026 at 10:26:57AM -0700, Jacob Pan wrote:
> Now that devices under noiommu mode can bind with IOMMUFD and perform
> IOAS operations, lift restrictions on cdev from VFIO side.
> Use cases are documented in Documentation/driver-api/vfio.rst
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
