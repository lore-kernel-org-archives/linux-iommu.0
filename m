Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56146AEDF
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034426; cv=none; b=kvf/OCrcKX0jYgz0QnB9NdZr6Ci5/ZfredfecuddAQF4TeL5bDQY2pLY00TZqp6lr6aGyXBI+MlQPlkQSwWCJqe4jV62qn/w/IjPB2R5vc+AoQFahJXbtSgsYlCCbZfW324uGG1i5+eMXzac6iviimDSJO+eLlRLAjIefitFFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034426; c=relaxed/simple;
	bh=V44+/Ji704/zeo6ZHmgziwcNG650omqFD+V0jFjANf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KE20FNNGto+k3S/AANU9khHX+bYWFkcrivd+B34Gc3Dh64FPioLjvaECsZomVMSsiO2XxaMAQ79XARmdMz7Mf/j+PsnEJNoSeNEVMf5RfYhbA0142xgzTOZ/zmaL4aZZmzsKg451H9TSPlciel04RjAofz89wqS+tV8a6RITwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBVxG9A4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBVxG9A4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cacef7d299so119585ad.1
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784034424; x=1784639224; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=34EVAP3xEJbniYxw7KzDG6VhCOQxXOAP3siy7t1YUHk=;
        b=sBVxG9A4BH/cHW5lRCLD4ErYXbgLA1jwtP4HCsVXd2RD8AyLpYvhUopeJwgrX3srKH
         3fcIS3SaeIFad1AX1spiGWHvl9UvLXwzEEG5CVPmeqgPT5iEjIbmrmG5WHBJfK/NFGja
         FOlChIAnjIXHmgEUpLrhMxujvanrwTiV43WNdro6wf9fF0FIMk4RDkQyhQqrcI39oUCa
         JQvBIFX08Byv0HsGhlTt6qbN+tZpeHomsmcnHW+ibj9ZUVVU4Muvv9hGUpTVQcq350a6
         kYPS8m9ar48XwSD00j1UYOsPxSs/7S4bMBhMm6BkGG/Swy1htiJJdK625cpZ/yZH2b8p
         byVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034424; x=1784639224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=34EVAP3xEJbniYxw7KzDG6VhCOQxXOAP3siy7t1YUHk=;
        b=MNVK7kq5lh1QMjzcRNWPPL304fUkaNEWPX9TpTISAixmssKWC9HdZCASX+wWzvhubA
         AlB4kSsn3gZX4vrenBbtVmqN0/PSjsRMUvPQn7DZvQGene0SK84AmzlJo+ceumOnAnkF
         LmvXNuBQ1hY8eFQGh4j8LgiTZOzCUPrABkNUocoHCQJQ8Z3j8RyH+E/D0ew++JnKSTNS
         Y5zam3FQ/sxx6sappw/qsZVoJa7Q8vbax+1fxHlAVWD4NDervUtFjdgnjNdyRT1vnOUn
         5MXSnmcWOgJchjNdCl3Rxh6uXLTMy1ycoWZvrIpJj5vTU6mS4KwtbXYnV5mPs7ZbOb+h
         58NA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+59aJ3jnwF1Ytfl+ebxcvjA8/ar7OjyriXVgwh8iVP8vOBJySy/shaETOwtFOZyIoRmLFew==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFS6DAyRCirx99Vw8i0l990Xj9NQzMrFXIqa7LrkQmvtntW6kO
	rScbi0YcDtr/VE3UtPiYkRK48ukIcY3uZTmwtMi8hmGulKsGdsycEnAPr1KjGZNNLg==
X-Gm-Gg: AfdE7ck2klxNBaW/4JP5XoTk8p1O9ckR/4z70GgUH6YtfdmR1IZ/wvUS0GHe54se2Ou
	qeSlf9xeVHKe3tzkeHAqX0xhO1+7O8aKTBbJL8QHglgoIXwdrhAaR9b4omXEQfg1wW/Cbk22u31
	EHFRTUXF6iesJFp/pqR0ypLGr3IJTXeEy5VLVRbCPcN0mYFOxNNUOXlz4pUoI+xJBrZvAXaK10D
	AVnRhzEbIrujxxQ6X5DM0/b6IUko2gDoM+1dMOBV40btuAb62/l656CozaxwWvMoq7Ki5j9d/e5
	tyfcjxFgU7DRV3uYOTB2/DZCNAw38qNKDyKwceB/xohOST4j5Bh/xkuIcWv4OBvKpRURPsg8Htd
	k2zfZpepFTQUmBug6f51zv93nUu1/8OUiiOYiUeFhMpfKbwhf3N2Z5NDlfgJWUCE7WNMf95HF6s
	Vm1GTLPuSrjF1JvQfX17oab16Ob6SmBZB/TZsIuNP/ckIM1+s=
X-Received: by 2002:a17:903:1ac6:b0:2ca:cbe5:c3af with SMTP id d9443c01a7336-2cee169252cmr5952975ad.7.1784034423917;
        Tue, 14 Jul 2026 06:07:03 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb775sm116995885ad.2.2026.07.14.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:07:03 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:06:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] iommufd/selftest: Convert cache invalidation
 mocks to the core array loop
Message-ID: <alY0ceR2leyRxXTy@google.com>
References: <cover.1783539724.git.nicolinc@nvidia.com>
 <4383c0afeba9795c9ae312826443fd7d5fc3fb58.1783539724.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4383c0afeba9795c9ae312826443fd7d5fc3fb58.1783539724.git.nicolinc@nvidia.com>

On Wed, Jul 08, 2026 at 12:44:18PM -0700, Nicolin Chen wrote:
> The vIOMMU and the nested-domain selftest invalidation mocks each used to
> walk the whole request array on their own, with the vIOMMU mock even
> allocating a buffer sized to the entire array in order to do so first.
> 
> The iommufd core now iterates the request array itself and re-invokes the
> op with the not-yet-handled sub-array, so handle just a single request per
> call out of the front of that sub-array and report one handled entry via
> the array->entry_num. Drop both of the loops and the kzalloc_objs() in the
> viommu callback function, and keep returning a success for an empty array
> as a probe of the selftest data type.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
 
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
