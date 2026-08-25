Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519403BE174
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684903; cv=none; b=NEOTyrxL2BskFcxetAoXDWzqbUxq/dyE5xPQkAfUNi1YNzGzNFekBpjSHDb8m0Md90m0qIWC8XYt0VaWnQmkA+gh305OWVXrbDAaScVwEHRLTfuRoxYB3x5fwIrUYPkPr/TsOImSqLAITOAiRkN0iFAlJ63vasQYanHcduOtGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684903; c=relaxed/simple;
	bh=VgttgqeeOlrykLZCGS/qEjZQQbVFLqSvRQ4792GQ6P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8O86qz0m4ADPei1pHaE2mxqqrdPYW9fuXQEb4JhE68qimFYlW/A/d5okQ4uoxbA322NAcCGUy76vHsdlh06Eb31eIlYK1htwpZ/V+aEv4H1cFS7cNWih+/RViI3E6mWbnPuTUTDSLePTE2SgY0jBt7ruTm51cEmDozV/CMmDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPza1WPL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPza1WPL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdf36f63dso25995ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787684902; x=1788289702; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qTbnZdKCLLlaDJ0a/A2nFTAg6s9FohnWs0NnAWaP8fU=;
        b=sPza1WPLHDAVU2lUHqeQ0FuDZPOsCoabTnl0+1qCiEETqGzxdyU6cNZK3uIedar0Jq
         wqrS3TPb+AEVNHcbVyjTdevYy1AE5fdekBKra7DEdkIyjiT3fysusjrOPOd/apUllElj
         DnZ1XS5ZJmqw5lF4sG/InQfanb6kG3BQI7NnDgpyZV5wueiEsFvMAW8boGPXA6nHm1wc
         vP2UfAewaBt7c4Dhf2BEk2McHBtAriyf8JZcKfCkb+fQODzrm6TNdEvm//hoCh0MLZ+j
         vJ8A+7DAsS5wzpYGwgwHTUyvkOr6I8lxaYAeaAHxUgLP91LaCMAH9ur7Zb9C1eH/zBwP
         0LZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684902; x=1788289702;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qTbnZdKCLLlaDJ0a/A2nFTAg6s9FohnWs0NnAWaP8fU=;
        b=XwKffg/thbRFkLpGW33HVyiTseL9b5iKrGWE772ODBPhmE3EbmVzmOqvqRm0RPxNwU
         DszVSEq50N3S/DdIe4xsDpOVnVtiPeAWD2eReglCx2G6PslycUql77HKrSn2k0aAImiC
         sNz/ta4X912BKqFHbjD36LG2m6WvHbhIqeNIfHIqgzYtuQhMSKChU1UOqD31FbGtjPk3
         340d20tiCIZAUE9ix+VNqYiRSzKmJrf9u5sFnF6bMTAuu/E4jopzY1Zd1qajth+IDniC
         bMXSQCZQxAisJzJr8+EuToms580d/xSQ+C7x1WX8UoaRInC+UbB6O97+0lbD2kvR/ESz
         svXA==
X-Gm-Message-State: AFuF++nBMqV0H50ihV+7K9ctmJWRAH9EBfUDFsvedun3k7fYLb7MfpGA
	HhaMBbCz591nYDmoWttvl0mjn14oLcc2fZ0ql3M4Ivec1LiUdU5uYjhMZ4bwtU1m7Q==
X-Gm-Gg: AR+sD12BdjoGPYWnn3tX/80R2C6KROFIb3INBlfurkZicW8UM6jDG9ccBDq3H3MxNA0
	QUTQt6bgovm7QNZoyrKdKBtSCZkKOu6K6Wp9Mz925i1q90Pw9t0Lz1h5slxXFCOJ0IuristeR15
	jFT5uE4xTJj86sYHzntINCPKk6Y9IHMJMG4z5DzUm0U/VhBgRK1IxaJOak+pZj1SJS9VuAaC3dT
	KdLwfV1uriehf4cij2zOjggXRWTQvJSRIdc8V2GJ0jl5iDDFAz9TNrbW/QrS30cZUSIRGimIcx9
	XKwPu6Re9zRwUMs25cleAdgw0NWgOzA59u/pUBemRsNro7qT+7fLjyjnKBpaozlLXPRlxgbehky
	ZYh1YTRQU6hpZP5ylSwl3Y1URDtdbAMjz6e38OsAXmAwUN8eoACb2+H7EW31q1AfZIMRgNXMS2j
	X93gegB3KphUt4V7H157sRJwqYAadKD7CQTbFhdashg1trEWrnOyQKcC/3217dJJtVLax4MDztT
	qzWFnqeyUCZ6j/KfIHSwKc3CA2H8lQ9T9QIVQ==
X-Received: by 2002:a17:902:e545:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2d707bc9904mr640115ad.11.1787684900811;
        Tue, 25 Aug 2026 12:08:20 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39668a5832bsm805257a91.15.2026.08.25.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:08:20 -0700 (PDT)
Date: Tue, 25 Aug 2026 19:08:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <ao3oHn8HiXIx5Wrl@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
 <ao1vJxkZsJpr1qXG@google.com>
 <20260825114916.GT244917@nvidia.com>
 <ao3RF0w_AXo5EXxv@google.com>
 <20260825175315.GD3325090@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825175315.GD3325090@nvidia.com>

On Tue, Aug 25, 2026 at 02:53:15PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 25, 2026 at 05:29:59PM +0000, Pranjal Shrivastava wrote:
> 
> > I agree, but I wonder why the existing code used memset here 
> > (in ignore_device):
> > 
> > memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> > 
> > I was thinking it might've been done for probe failures in a kdump
> > kernel (normal kexec would've called shutdown for clearing all DTEs).
> > (I see this was added long time back and existed when PCI segments were
> > added [1]).
> 
> For kdump you'd want to keep the original translation running in this
> case.
>  
> > Are you suggesting to remove the DTE clearing from this path entirely?
> 
> Yes
> 

Even I'm not sure why we had this memset here, I'll just dig into
the history once if there's anything. Otherwise, I'll simply drop this.

Vasant, please let us know if there was a different context to it?

Thanks,
Praan
