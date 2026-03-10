Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F45355F55
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171665; cv=none; b=iunXjVm/tFyFDhqtpGtYv0F8byzIfauICiHwKMsXuk6u4AEWIBfpKZLJ3IwhAvit/kjdLZGnaKiAB/l4UkMlBvW4bQLkURp8uZc9nZ+vA54JAEjpN3H5IPjOh5qL5JX/daP4GznBHD/HsCTSgSxf34staDCH3adp23906uf8rFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171665; c=relaxed/simple;
	bh=z/fFABH/LSxyYxaRcuJi/CZHyJnomjsXZwC51ucCpW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erubjPITQBN0PfFWQ9moI9kllJEFW2iLZEFsXB22D5Yo75vCB+7UfZQzfJgfUYyqMfERHEOMYfOsxWaiwSH1gKiIWgslAElLER9jU9d6IUIwOas3w+LxjvytT6X0a8HigAohp+kXeSH2+flKovELXQEqScyXh2wHaPJTpkcinxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pi+2f1Ut; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pi+2f1Ut"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae3f822163so28785ad.0
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773171664; x=1773776464; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7vY2UrB9SGH6OvdmDiCHyzJiFowvOHfRjqE+9AkweY=;
        b=Pi+2f1Utnp/WnufyIQHRZoMWrTxPkz4dZhDOm4oIYZUXz0FtCqtt+MC5CPV2tW8p3p
         gO3HjbPmsXm9uwefHekdu9WDARITrfg6qZDs/18OPuenk0+OZA32j4L9wHUrzoiQoXXj
         IXfUlffRjf3UaT4D8UWGsyhVOWtB4aJM+AaDO4Vg2RybA31mo+mTs1Alhm6tteixc4j8
         vSZaOUSq5lb0+xxdEVMXK04wWzn0WHCTRQlISHvlQsBt4Xt0QaTbyPj78OmKlREECi0D
         miTJFilbUv/uE/J4tHM9IiwD9LqwinDlaC5lQPfzZr32z5gYBbSHvsyy0b7rnhaEukzV
         Wmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773171664; x=1773776464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7vY2UrB9SGH6OvdmDiCHyzJiFowvOHfRjqE+9AkweY=;
        b=tkMhMo8rMR7d4Imdfuy0YZcjSi5oshUEwIj2CUIrlZUNk6CMjahAHlXTFNiZEd7LM/
         izCsKp8e4jP72qu5O2QUkoekrThoByUR7fL1peUG7I5hILFN8Evr8w094kjb3qw1KDjv
         bvzNEEOVfhMIEWWqJ5XWNxX8KEjdyOJgwbUJW0Kn2Lg3aisNyA1Xk3dfWvqqhlwf7hCb
         HHxP7DjjMsxcDt8hQAPO59J49wxz6LPENMgyx7hyc4g18xeYZh/XuswZA18aCda0ElEx
         qenPltcJlvuceNVNgA7nRarr2L+8sL57U6DVIsNwJwNAYWWdTjsqjsSO8xxXKUVW+Ff6
         4u/w==
X-Forwarded-Encrypted: i=1; AJvYcCWQpy5gdvLljwyrmd5SUXePbE/kYq+ztVkVUn3LJ1X836C1byQHPGBx/3xREy0NUAGWUX+nDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFSk/Y/niOxEUyDeIP+OuvGI26WcAxB8topx/fPtYrfCiehknM
	E866tHUEEdkEywnBxywY3TJKlzr9+vHL496wXh7bqbkLsPYbP011U0Z8SR4OyIxEPA==
X-Gm-Gg: ATEYQzzPDzhjXwP33vuh/DiDMH9qbKWOWSPv7iNkAymUgF42lG5yP2Hh/LJiMR5sbq1
	NDm4XS8NUSiY9YXrqR3PeKROb1d74+nSv7Q+5u7PntBJNgBOKW2ilbBNdwvpTcuSO+vYYKh/T02
	G42E9GcS6oHYX2L/aDO0Ok/cjvFYzVTp2RqcuewAQpQkocJbChdJ3DJSvUBKIX5A7M3dUCiqDqZ
	3LYOb6xreo6mqQJio6oyXFmx8iQkcEPwcVtUNM07ItVQw2vXM800DckpNXEl2u2aiQEMRg+cPjU
	K4i7yPqFWNMJvmzU2DQpBkB8gpQdv6v7N2ITlM5AiL5Axy5+G4v8yhRgHnwRfV04wgfWKE6reDd
	IDN3574vuDarivWnpnWY52JTtdQl6bVB9NYcPHdLMkf4Zqini20gtihSJmrWbJ01mwIBVlcVq/9
	i56BUwqvQpmAQ2XRq/fKhzbZw0GDWzZHLNuAyh0QJIPWjEVn0fNuYsKHzvqw==
X-Received: by 2002:a17:903:191:b0:2ae:44ff:5f42 with SMTP id d9443c01a7336-2aead3e3606mr687905ad.20.1773171663319;
        Tue, 10 Mar 2026 12:41:03 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f05edd69sm3807665a91.1.2026.03.10.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 12:41:02 -0700 (PDT)
Date: Tue, 10 Mar 2026 19:40:56 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	rafael@kernel.org, lenb@kernel.org, kees@kernel.org,
	baolu.lu@linux.intel.com, smostafa@google.com,
	Alexander.Grest@microsoft.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abBzyKNZRzRykRV5@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <aanygWWZLA1htDdQ@Asurada-Nvidia>
 <20260305234158.GB1651202@nvidia.com>
 <aaot8uRsli5jNPzH@Asurada-Nvidia>
 <20260306013347.GD1651202@nvidia.com>
 <aapgyXadT1TEz29u@Asurada-Nvidia>
 <20260306130202.GG1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306130202.GG1651202@nvidia.com>

On Fri, Mar 06, 2026 at 09:02:02AM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 05, 2026 at 09:06:17PM -0800, Nicolin Chen wrote:
> > On Thu, Mar 05, 2026 at 09:33:47PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Mar 05, 2026 at 05:29:22PM -0800, Nicolin Chen wrote:
> > > 
> > > > But arm_smmu_cmdq_issue_cmdlist() doesn't know when to push another
> > > > CMD. In my case where ATC_INV irq occurs, the return value from the
> > > > arm_smmu_cmdq_poll_until_sync() in the Step 5 is 0, and prods/cons
> > > > are also matched. Actually, at this point that NOP ISR has already
> > > > finished.
> > > 
> > > Yes, you'd need a sneaky way to convay the error from the ISR to the
> > > cmdlist code that didn't harm performance. Maybe we could come up with
> > > something, but if it works replacing the NOP with flush sounds fairly
> > > appealing - though can you do a single WORD edit to the STE that will
> > > block translated requests? Zero EATS?
> > 
> > Yea. I can give that a try.
> 
> This also really needs to go after the invalidation changes because it
> is feasible to also edit the lockless RCU invalidation list from the
> ISR and disable the ATC for the failed device too.
> 
> > > Also, will the SMMU start spamming with blocked translation events or
> > > something that will need suppression too?
> > 
> > CD.R=0 can suppress fault records, but we would need to override
> > that in every CD of the device.
> 
> That's too much to do from ISR, but maybe we can do it from a WQ..
> 

(Skimming through these, apologies if I'm losing context), shouldn't we
do all that (marking it as an inv STE / abort STE, suppressing the
faults) in the worker instead of trying to reset/recover the device?

> Jason

Thanks
Praan
