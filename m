Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E82F12AB
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690745; cv=none; b=icbSglWSu8fnAMzTesgmQEbN4aiU4l5A2TIO9NmJMTrEJOu5H2mQF5wMG55mYewLzO+ekGHcFZb1zN08GPE67XDz4LHKI83VzaohkmomIOh/W1G59tnNh6k9R5BfftYlEtcoRircjoW1XCXqDstdSuYNfVAmeFFodrc1qW/C0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690745; c=relaxed/simple;
	bh=G6dCLo5SpKgCvE1TFsg41MaLaUN6BhTG3vfdETy4VBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhw+gardKPu83lcPFYhwUo5r4FC5lgnm1XJSxV3a+FYIwj31E7hO/g0bIZhT9mUIOH7RxTjvKUUQvljxZXMI7DqEAImYTQk2AyAoDEaYQwc/ud1VcXK1+kBUFfubHGprAY8eWV5xApBeiDQ41QiKtN5yjOUucitYxdnTj6vFN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bk4kF3//; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bk4kF3//"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b46da8c48eso5085ad.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778690743; x=1779295543; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6dCLo5SpKgCvE1TFsg41MaLaUN6BhTG3vfdETy4VBU=;
        b=bk4kF3//rjGzn2IbdbtHbHCJTWpsP7WpTbU48V5FtBI5yftnn68eH7dmgz9uT9SFNs
         qH5LRKcTtGeSx8/sYTIsExoElZ3rQQaQbUbnkkIQcy5te3KWh8+MTlSBNLuAPmp+EcJ2
         e+feGtnNMrqObtgfggtq99HXuKsLmhD18IOF5ms06YspCTvyPGPcdEpyV4anOezldI5C
         6RibwbqvTPCxtB+gr9fTz1Q3K2lj/6VrR9znJiU6EwuIv4LGtSqj3NO67oMWZOvo0DKp
         xuPJPPC+ujLkNdvHJcYyeGEsx/tYdlx2oeAsfm5ewIt+dkwzwHhvMuVS+FycyXmDkIgs
         YNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690743; x=1779295543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6dCLo5SpKgCvE1TFsg41MaLaUN6BhTG3vfdETy4VBU=;
        b=KCNwH15aSsSpzXBmnoSHRB+sh2BM7Y9cMCgfRk4iv8OpADXtE5WESZNEChhHQRtaUo
         K5uptaJyHTQmMKSZWu2eGVRmVvsBFi0nZyiIVGxiX8smVLZGkmGcKcX7yDEhRqNHOq7X
         cH1rawKZEqPR03cGUme7DBEpliaI75pdCoDv+UEVFLzvqTC1I5pTR0fi59qfwXwRRCxn
         wNIpWkR923v7nhBdCTi3MeYmXoMgQy+FoooFrZmLprjzvkWCmRsR+7KNqJoYQkMDWFM6
         aXJgYSXfYa1d84JRr+YzBV0gXesYAxIlbVxWZRPjMFnm/McgR3x1oLgSDxQDWKclmsE1
         A80g==
X-Gm-Message-State: AOJu0Yzkue9OBrFAY8CfcxvkiIfNKdkALtaVyYBWy4LJiu9I+qXa3bQ/
	L5s4r3fR+NFWxYffAQmvOqnMPqiFtCTWhyt89iiK2tczoxl6CL53pLem8ogs3INV5w==
X-Gm-Gg: Acq92OHh5BImjLeAFupBhw1yDCONdyyROHJBtbkFdX/TP1kFGKM7X+1UE4XqVrremaR
	XDT/eJKCPEt8cTUdf1C5sghhPS+Q07U8Dc+5eoHoWjMjZ/M186+wJztWCN6KoEnV6glL7zQJ41O
	FkGvGSez43rGVboS1FpBQGcfieD1KD5h82Auf6DEhLONwZErzTFPVIZ0VyGWF4/V/0ZMovBV5fA
	31pAAiYlE/UbL7+o03kw/XYLsjHVH9ss2Uew02uOvujlBVVb36ARBXZvM1AO/5Hpua/FBgAvJeP
	y8J1Qos7xJisBHpTu7bHjWYqIg3Ca+4D3CAaRY/RV5k4vglCEMckbl/zd3qENC0n8EbowlC0w0R
	mCNCBWAn2QV+DiKPvKWiFj6FbatnyleuoO90OjGYjTeYTm32FaQjf+oAV+eCK9z0ND88mFibzpj
	RLVPGx/OaVknn697oxI7sZI1s9qZKWl6yRwfWxM+3Ckg6CFNtf4I/LBvANW4qzXyhQeRV93A==
X-Received: by 2002:a17:903:3848:b0:2ba:dfa:328d with SMTP id d9443c01a7336-2bd2c0a2bd2mr3497385ad.1.1778690742233;
        Wed, 13 May 2026 09:45:42 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267735e3fsm14858749a12.31.2026.05.13.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:45:41 -0700 (PDT)
Date: Wed, 13 May 2026 16:45:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 2/5] iommu: Fix up map/unmap debugging for iommupt
 domains
Message-ID: <agSqlM18kAJiC8-U@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <2-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>

On Tue, May 12, 2026 at 01:46:14PM -0300, Jason Gunthorpe wrote:
>Sashiko noticed a few issues in this path, and a few more were
>found on review. Tidy them up further. These are intertwined
>because the debug code depends on some of the WARN_ONs to function
>right:
>
>Lift into iommu_map_nosync():
>- The might_sleep_if()
>- 0 pgsize_bitmap WARN_ON
>- Promote the illegal domain->type to a WARN_ON
>- WARN_ON for illegal gfp flags
>
>Then remove the return 0 since it is now safe to call
>iommu_debug_map().
>
>Lift into __iommu_unmap():
>- 0 pgsize_bitmap WARN_ON
>- Promote the illegal domain->type to a WARN_ON
>- iommu_debug_unmap_begin()
>
>This now pairs with the unconditional iommu_debug_map() on the
>mapping side. Thus iommu debugging now works for iommupt along
>with some of the other debugging features.
>
>Fixes: 99fb8afa16ad ("iommupt: Directly call iommupt's unmap_range()")
>Fixes: d6c65b0fd621 ("iommupt: Avoid rewalking during map")
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/iommu.c | 43 ++++++++++++++++++++++---------------------
> 1 file changed, 22 insertions(+), 21 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
