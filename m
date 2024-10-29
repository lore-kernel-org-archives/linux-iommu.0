Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E53204035
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202186; cv=none; b=AORCbr0DAj025awdp+/zXiU4h3NpcFAqkX3udhBSZw0c8A8ZrUD011r6aCUOBVHkaT8B7BgrTbfAxeeZault/b2AHAip5LNCkQXLF+O+XpOtLTsc2Aylb3NIBfVU9UmBaS8uq9XHm/6j6EW+iX5SvL2S5dyBwqU4FPAwXClwPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202186; c=relaxed/simple;
	bh=s0NtxfN0YKYoxUnO3lQNTiob9NH9vvfb67Uvl0Fh7ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mwb32qfuuxMuwxkTSQAp3h4smm6MBbhMG/trhKVt/KWraw9mvOp37FH0xlpcUWSTUK7Nccl+hRA/9zVO+3v7tIVVGNCBjr38rm5bPuCPQtzyUahd8c3jfb1txdID7kglYbVIRV8hrXOcr60jzaZOaJUrPTC1bMVo5VYkCOy8byg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ihluS9A4; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ihluS9A4"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4609d75e2f8so52745851cf.1
        for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730202184; x=1730806984; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvHsIFSTi0XZdx0k62e6OyvWU9dWkoQVlshw4U0DAXg=;
        b=ihluS9A4QfrGSp7eP9FucL7hmqhWjbxFwWakdsrgISmck3RhhBr+XtxugbP9ZmGWrM
         ouE1dHjkTdtGbi8PdlCFMwVdd3kQHvJnewR6P9j4L52qIukhQOHBMTNJjmm9pAaCz4U3
         EjuU5hbvxSoZfjxcSaana3FlVxydoPdNxx7IuHrIHNKsYZVJC7+Tkr9Rw3U3GLZjqOqN
         4wNFMJ1ueNg49Ee2y+gFx0U/whjm+qzeia7bujU4uP1GY7nAX7KOInBh0Do52nyFcgqN
         NP/jfFnqBXhNvwAmMFHIvezXVpyG04q3PH/VMfxUw2tEfI6gFjKzASznmUGlW7+mLnHC
         QDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202184; x=1730806984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvHsIFSTi0XZdx0k62e6OyvWU9dWkoQVlshw4U0DAXg=;
        b=ZUf3L2tQ9hFt8G/0JZ9F2aTMTbkHD5FUGb6/UT5gZ6a2O3yfGbv3LHQMSopo73po7W
         6hd541QN63TJ3c0U0w5i79M9TTardh2CBJaBqlJW1QxsZyltlYcUgMIDnFuAqVsVipO0
         0O68brJ9m+gy8u5bvuw78/U0jEjVmZY+akoxVH2kWRQUi3auh52hsvrCB1gbtTr2iuUL
         vvNh6EQo8idNYz1gBkYBLt+qaTes2DP60DFHXyAcABsiPXwn9sTp7j0Gkz1R/KUegABl
         2gZz5yysS96TjXq6I9gBYRcBzYvPBwpzlEDgLWCcxiOBeoS+AJgnLLbivdGImVTMLy2L
         6OTw==
X-Gm-Message-State: AOJu0YxHw5uB2MF8NQYYX4KwcHCskq+H89Bgwfg9YQ/beUZYLy5VBBXM
	qZriQk0NcHTseDxpoo4+sBSc1OZnnZfo4tajRie7yGfy2swv03eBYG9mD3Fs79k=
X-Google-Smtp-Source: AGHT+IHB2/Bh0ErrimuBLBmKhlXWmOBNgnoxFGD8U46br8NjpRaYQXlpVMZjkh13p9UY1aPjaplOlQ==
X-Received: by 2002:ac8:5741:0:b0:460:3f3c:b3ba with SMTP id d75a77b69052e-4616814a7a8mr30157081cf.25.1730202183823;
        Tue, 29 Oct 2024 04:43:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323741c0sm43669641cf.61.2024.10.29.04.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:43:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t5kco-00000000nXZ-1YVu;
	Tue, 29 Oct 2024 08:43:02 -0300
Date: Tue, 29 Oct 2024 08:43:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH] iommu: Fix prototype of iommu_paging_domain_alloc_flags()
Message-ID: <20241029114302.GI20281@ziepe.ca>
References: <20241029105849.52069-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029105849.52069-1-joro@8bytes.org>

On Tue, Oct 29, 2024 at 11:58:49AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The iommu_paging_domain_alloc_flags() prototype for
> non-iommu kernel configurations lacks the 'static inline'
> prefixes.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Fixes: 20858d4ebb42 ("iommu: Introduce iommu_paging_domain_alloc_flags()")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Lacking 0-day again..

Jason
