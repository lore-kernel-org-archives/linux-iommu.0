Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53037EFEB
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641447; cv=none; b=gyA1GDZFkNPWSwDgacYPkMf/tRrxtTHEMZ/E41cAF+OROYmvMsWk1f8avE7Kb4TDaVJRZ0/6dGRBTyyKFiO9GncykHkyHuQpi5oZhrB1Gc9atp8SkWJ42to99dyvOuBscqSmBT6SSTRCQ3p/nd7eKYa7tFaDDT+ObZ8U5kSysIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641447; c=relaxed/simple;
	bh=wJ4jATmZAaYHYCiMTe56z06RxcEqjzIUlyvbNzhT0IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INorrl/DPOC9WZ+GFeaCESDW9IUW4Q8PBulrnI7labfC0ubgF+C5ws2LEAgCuDEoRLYBEIfB0EBYA4fjQodqQd6hrL4VYOwKNYSBX/cervqcBqDfueUbEuXphVxuhOGgBulXCTxIbCwPDI9rTnMzAqUmjickJJdKb1CN2p1wvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlDSDjMa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlDSDjMa"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2d865383so4275ad.1
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781641445; x=1782246245; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qM0oSfMYs+BER1k9auvbtpQ8dGe9BcnZ1e4yBJcikTU=;
        b=qlDSDjMaO9sZCSdl8WYVAy7cjQtwNJwa9y+vE8/gEBjPj//EK81Yrv/xTitwWs62ZQ
         HaX17bVDfEWYgcz2uvBStvmIfhPZcgiodT0EYaOU8YLNwX+UaqrLXu22P0DX+QiP34BN
         qoEmO8d5aSHDLh0AY6XRxWnAuNUIrP8waSFFl+pa+p+Sy852XHUjC/OLhLIZF1uZcDpJ
         Yrg8CpZoB1ClOMbNLR6uLLXtX+OmhFxNhGIAuDjCpVJBehnDXr7NpbgPsCoJn66+DZa9
         8/xi/H8IAO1qLkBua8oG3iXerx5KLE7rGTY3OMEja5gt65uaL/sFnqEj+gBlVu7jxXsc
         AVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781641445; x=1782246245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qM0oSfMYs+BER1k9auvbtpQ8dGe9BcnZ1e4yBJcikTU=;
        b=HGdSQEDDKKSeErvP2tWVQz1NNQbsboaiilmtbtJFyRhw/LIqktAtMAncPE+IscW3m9
         cR38QitKA9hGUNjRwiT2iFAeUD7z54cOUPTKKOWK5CO0WiFo91pp0FWSE8c3gy1fG4Wp
         uGkxV5a/UGOHL3NGbJe2/N7XvBETCwPuJ3Ppdm22XtXQL/F+hsrys0a1bMEj+r8BwR+n
         SvusYNh+KZ8v6iafdaZwIslPFC/1rfu7IAA/S3WbxqMb0UEEEJ21tzmLsjrevAeHkcXo
         fv72fbeTNKl0XS31tKmpnYw09Q9lhRe0Gb6KbiwOIp3vGdgMuG5E1F42dG3lbUS3oQkz
         VcmA==
X-Forwarded-Encrypted: i=1; AFNElJ9q7vmGvisjZKWwrJMWLYQXYlnGvecDzbTnNh9u3yumx/5kphXqBClwbjk0Odz8+OkEM6TD0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdzBKbzLLAme0dOjoqkMiLZOauM4CC3nU0nL7Ecq5fGlwm/rja
	8zFDJ7mAOFrzcRtPNNDCVBvZUzX69uK2QW9wLBr67FP6u1ZwtNkJ1D0/p9uow4XOUg==
X-Gm-Gg: AfdE7cl7lDko+AvHULWTiWByk2qbxFZvZH4pexp7PeO1XvTuDHRqffkWfhadBNxiPky
	uO7yz2vs4gbLTDI//5+WTU6jVNfIVs2jlkeVCiYP6cVUEFOqYpnpfcBzAN/sXuDYxDnFNHFfkmu
	tpMWTbuxdQzOqYqjFaXWOvYsxglMwt/VzV+6rMt6vwE62L8TuadqltD98xO3jCaVwgA85qwi/WU
	2NUD9CprDYc3rHht90ym0XeB89FqBdSUhGUqIrKiF3R8eDSgZ4zcXe/9wmvEih46TrU105OeUFK
	NuUUEMXqGxmZ5QzEWh1D4mk2Jsw/ZxTgzp+Pv1mvneb4VvIbko4Ape1cwoMuci4MgfpN2pcK9MP
	7rnlnbDszjmKOEdbj2glcX4SzDgs4QpepjMt5Ykfrv4HoKghuNk+vKmb9HqFGq7QBcotH33WQXJ
	mu+9Bj/K2yfHko3J5ng+S7+9jeAeEB38ovRPEAYLQoDTQVGOBpQthWcB6P/MTgQzhPjFrIBlo=
X-Received: by 2002:a17:903:388f:b0:2bf:3579:cdaa with SMTP id d9443c01a7336-2c6bb8b0caamr605145ad.10.1781641444107;
        Tue, 16 Jun 2026 13:24:04 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc9fa8sm14375404b3a.32.2026.06.16.13.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 13:24:03 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:23:56 +0000
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
Subject: Re: [PATCH v9 2/6] iommufd: Move igroup allocation to a function
Message-ID: <ajGw3KZ60dUrvdiZ@google.com>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
 <20260611172658.3421138-3-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611172658.3421138-3-jacob.pan@linux.microsoft.com>

On Thu, Jun 11, 2026 at 10:26:54AM -0700, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> So it can be reused in the next patch which allows binding to noiommu
> device.
> 
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
