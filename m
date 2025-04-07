Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91C1448D5
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014790; cv=none; b=J/vbW8yqvoLw19JanLz57BM12yEWh7JlqQbyP9hqAZltPjOEITCbwAjIFqAOQtV081xYY95AoPk9WC8NPM3uw1WJ4roZl0PDfVJkfzKSX3Vm5CZu7wYKau3hPxGVrdnF6IWLjBvKct+v07tVI1Uik0LcxVsAuZRSxc19QUJEd/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014790; c=relaxed/simple;
	bh=0MJ7kNuETLjZlpYnEIkw7jNM8In9lI+eax564Kt2b3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPWqIAthurij8+MJVv63XOMKDWdRwwF0Lc3PpyrKp7K8w7I1BUd9wATFsXtRbL+W5+P9tE3GyLc1cK3Enkx+CqTc24Nt0nm0Hi01PfLk6I3KNTkgwh5/hjna26tdYli0xX+yDtRB8DGQp9F44jOGeRId22bC3gAXX3Oq+3+P1ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KImO2ntl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KImO2ntl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2264c9d0295so324235ad.0
        for <iommu@lists.linux.dev>; Mon, 07 Apr 2025 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744014788; x=1744619588; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcXjjA+jirbGtlXlcOVxvxixEqyX9/ZtaNYQ+3n7vks=;
        b=KImO2ntl8Nx1DpHbbwOrVfVJKBLz8vdlsfd32hI0IM42JJ3rTGfZDnjxsmCn4JU8y9
         BPvyyKJufc2ODKDje1JFVp/zxDk08s4l3uIJIEoR3yqDEhCKbcYPqb9w0Pk4i30oCmw7
         rvesqXSPN0f5OVVxqmsGs+O0zdWMz6o1U8JEbJBxwqj2nLcvwrfVE4iBVcxkasXA4t6B
         v3SIzSXk8eeWXiC9ze7em/8KWlJ4dL0OFUBUy7eKlg5jAdO2ecG3N3j5yhjS+4q5/Qub
         m+Ot9nJkFRCYtstCrXEMntvN+HaxZT2jREIicc1XL6WBJXl6aB9QD4dw+Hk8QL7QNBO9
         bWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744014788; x=1744619588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcXjjA+jirbGtlXlcOVxvxixEqyX9/ZtaNYQ+3n7vks=;
        b=uRcYqIS12Di/OuFF0XD5/ycvZOz0NTP14raGiWyJbzaVstL1+8YWM76Q83GgFtbsul
         kBWJAcArxBM9S9BvMWov0g2QJMbFyHen0St+mWUJwXcNliDwN/2kyz/sZiU4CCZWEX5E
         dNUS7EEVN0iOCnZaJz8YvOtDMQ3J4oWwnyKvGHHbBZajLn9Ys6yudnpVqqRK8KXMTOsY
         exGB+4aQURY/fUcyLPnp1kfAsGy+WBEIkRvIC8baVSIjIcM0S9ib+7gSXMQhcT7V+JQX
         v2PudxnHzv0Jek3Juh9MZigx+BuTb4uHWRowxqaxzQGXBViyNuVKxauGM2A5tPqCX7wb
         X7PA==
X-Forwarded-Encrypted: i=1; AJvYcCVZwU1oWQCUnSXuejyglq7gIWpyQzttznkhOf97dLqJZJD7A4S0MNdwDweCsr7WlZru6U56wg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyciCbr4BIGLgWUk+xNRg7NA4mOsegqNxEG6mNZlHja0O5t+hkL
	JO3xeOr+i0GxIGPs3IEQlSrMnpP93v8WmfT7yOqaTwlpjfOiAUAPY0+Hua5d5g==
X-Gm-Gg: ASbGncthktXdVTmgkV5tMGExX3IBPefeDKlvMXi4ZWrZfK2tucS5r39qVceOmHKEnWB
	rZWHJ0CP2F9G41m5pOAiUVU0SOWXQ1FaHNEEpM7Ta8dOPmxel12rYcRz+aUhLi/t1mUYCzFbjNj
	6f15AyMQNncBJbz4s+jVS2sDV6sehFG7LF3gh5uZRYEs2yfRYWllEUs4ikXg13x/2Mdy4LHwMGn
	VncKFGpt1KONkbwckyrVaDMj61SlqfcQEHQQ+xEogDQlXZNsZNnWPQ117CIJ2k4FqpcO6PWWkKW
	F7Z/1xdDQ6kqPrX9P+1jT66phUgLFJcAau7l/5GbGfPQsDTdXF5pxGDrgMfes1hxAH1tOEKHPCW
	uX6pTGup8VCvhtQ==
X-Google-Smtp-Source: AGHT+IGgoaBTlg9BjbIvqCWdACY/aXtozoW3tXEbZzO1wBZolldhDpZWuJ7yv4qhtjzddz/sud5TLQ==
X-Received: by 2002:a17:903:c4a:b0:215:aca2:dc04 with SMTP id d9443c01a7336-22a95eb8d41mr3228575ad.26.1744014788291;
        Mon, 07 Apr 2025 01:33:08 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c385csm75476405ad.81.2025.04.07.01.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:33:07 -0700 (PDT)
Date: Mon, 7 Apr 2025 08:32:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v1 1/4] iommu/arm-smmu-v3: Pass in vmid to
 arm_smmu_make_s2_domain_ste()
Message-ID: <Z_ONu4pIDyiWr2DK@google.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <214b10db02f1046efdc70e2c4803111357f60070.1741150594.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <214b10db02f1046efdc70e2c4803111357f60070.1741150594.git.nicolinc@nvidia.com>

On Tue, Mar 04, 2025 at 09:04:00PM -0800, Nicolin Chen wrote:
> An stage-2 STE requires a vmid that has been so far allocated per domain,
> so arm_smmu_make_s2_domain_ste() has been extracting the vmid from the S2
> domain.
> 
> To share an S2 parent domain across vSMMUs in the same VM, a vmid will be
> no longer allocated for nor stored in the S2 domain, but per vSMMU, which
> means the arm_smmu_make_s2_domain_ste() can get a vmid either from an S2
> domain (non nesting parent) or a vSMMU.
> 
> Allow to pass in vmid explicitly to arm_smmu_make_s2_domain_ste(), giving
> its callers a chance to pick the vmid between a domain or a vSMMU.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 6 ++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c    | 3 ++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 6 +++---
>  4 files changed, 10 insertions(+), 7 deletions(-)
> 

Thanks
