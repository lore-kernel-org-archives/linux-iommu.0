Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F734DC54E
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694518; cv=none; b=FOJCkySguutkCNu9oUIvrB0RSCVAzJOqpIZuJOVQlkgU13tQXcS9hjZa2ll0fckhfmWfpcAvdpk/rGdqmBCGkWQzZ5ektkkpCDz1LIKz+OZvHwBbdQDNCPMCM9WpMDlEd3uJli0MyO2261wKIRqXwa+6ON15tqaNUSEb3XDimQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694518; c=relaxed/simple;
	bh=4XTXWoeBGoxsSNoPRmhV9IH/BD3AGgF+Q6dkrFYVktM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtcSSiZZSsgWB+0CKG5d6zcevL4RvZOFo31mX/4E0qI84fHlxxmVPdizEGNMBAKcj417ZjFeNBZiNlsnWg8V4K1oBH5peXVk8uDwet+nVx+SOC3Sy9BGT9Fs/432OtS3YTrIcSfS3H7tkXogJkaeiLfiqSrMETh3FrTOT26cMTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAYW4sVk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAYW4sVk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba180a022dso4465ad.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778694517; x=1779299317; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxDXIXDykFSIYFprkEjbA73LH9dL5dkUsPQlXSJlaIw=;
        b=XAYW4sVkyLWRgY/z0hqZ0Vg8iExp420jSuPuT8ydjgrpgibcskLQfhz5tua1XAEW7c
         wYqzdwFwrGUjwH7Idb6rSNLIi6Vem/nWv4w8z/eR7yDD9lkuH9MXJozTisUdtI7duUSj
         NCSmit4xzDrd8nR5sKzRGPFtv5cqUkH9Y+KSGbK0hLIl2oACtjjxaCeeTbPPGauXWUzU
         evkGRBQMWWGliC2TzBWoZcztKwz75oxv/rkaK6pbGZMf48DyDXSXwBcIXTS0vRsCLvWY
         2U1VRjUn0sKgASuJOmVWng6iAF9674QXAXbeVntH3pL0au5pyihNQ+GjvQsq+7yW1DIu
         zr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694517; x=1779299317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxDXIXDykFSIYFprkEjbA73LH9dL5dkUsPQlXSJlaIw=;
        b=ba+gcRyzO6NKnDxS6pOo2FzfcaKDljF2xRvs7XTQFyVajOyZuJjb6smANFTDeKTDwT
         FVfvNwZnxnBbNvq9YXlU4WU0SaUDuJFfy5fMfxRhNPaGnflxGuUWlStPsaGXVlwIoLPI
         Aq+lGMZ8l2I2KsY4SOl1UeuVGu0OhZ6+/7V40JI9AexQ68zcRqKoe+lviXWczXG7GPtT
         9x2xEhjbEVpSRFBnANSLKMgo0YGh6Ut3oDxotwyx7LpWtCNBvxrYAQksyd2YozWvnsz5
         kFOjHHfQA8u4nmYRlBD5vN93e1byn3vpHXaHpqCxECF6wlYr0m1WWdYuT+xc1F+pAQlq
         pR8Q==
X-Gm-Message-State: AOJu0YyZjaujewbcbJDPmIrtXJzLyc1ilYEelahfHM6lCi8G5XkAiyx5
	zT3rZuGBKnNvGzfxow0dXABXhvoIlfOKXZla1WG4tHG9pJSFFh0OHAiqHT+rLt8HPg==
X-Gm-Gg: Acq92OHvG2l7rOdUj54HkWCol6BUeNAmk7uzJOcFmhhQlNPEqRmjic83C/EANzJGCMp
	TXDtZSeDZkpjfMESVpUrJlVMEVYIfrG3FdsQq6gKh3DwyBxhxj6rhJZcLHaWAqBT+6cODtK/leh
	7IqMe7jV97QEnyD3ANPa1XjvGbQIBuD8rtHmneKx3Y7Olq8sDOspULtk5apnhLLnxb/r3Le614I
	x+ueicZCAYlngYQ0LJ1BoQ/qVj+XdyP2LDbonS2lxSwW5qyUlDXxAefEPpAKlAYXkhynUWaIXlK
	EBDbOrRkkO2UgUyStrQpWzTkPYhXMUOOMB9rrrYQDp7T62QdbLOrdcG/p7TLTMx3YLB4+T1Hk97
	2k2ApxQkC5BQ05RCFAIg9shUFXtCFCt45FvWE47U/pD+r+oy/xovpE9UL1M4edMQ3ccAD142osk
	1M/KGcS8G42GGfODJXaOy16blCn0Vkw6ZXphIi6lqkleM6RAzLztkQppRZMv4TAxWxcSkr
X-Received: by 2002:a17:903:2a8d:b0:2ba:67f6:643a with SMTP id d9443c01a7336-2bd568fd5d4mr144045ad.11.1778694516241;
        Wed, 13 May 2026 10:48:36 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ebesm178951275ad.43.2026.05.13.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:48:35 -0700 (PDT)
Date: Wed, 13 May 2026 17:48:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Josua Mayer <josua@solid-run.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 4/5] iommupt: Check for missing PAGE_SIZE in the
 pgsize_bitmap
Message-ID: <agS5bRPHjB1h22BP@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>

On Tue, May 12, 2026 at 01:46:16PM -0300, Jason Gunthorpe wrote:
> Sashiko pointed out that the driver could drop PAGE_SIZE from the
> pgsize_bitmap. That is technically allowed but nothing does it, and
> such an iommu_domain would not be used with the DMA API today.
> 
> Still, it is against the design and it is trivial to fix up. Lift
> the PT_WARN_ON to the if branch and just skip the fast path.
> 
> Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks
