Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB320C005
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750110318; cv=none; b=PLCABuQ85xN6P9vz87tmDaeOXQaaKZdZ4T0KBO3mkUtj6y9yQu7OR4CnMovMB7Xc7FNlk0YDrWKy1D6p85152+lPbiWqSx3ac6m7S3c7BfSTMsmz2ZSWH432WBvedAiijTeTKo8YQMF4OkMfBSYWD8u4ib4V7NID1HUSLpJipQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750110318; c=relaxed/simple;
	bh=ue0zZGnlayFFocKO6DHpjurxQEhp5y8cZT9f9F34YpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br1Ow19/pGhrSsT6W2IPkdD38j6U0n/lZS5FR/lWUXGkNBNtvl542cXOHB3pXpUxiOiNbVhB9HFvvriDRW3YFcPylY1eHesH4oWv3xmu5tKjChZs0iNkGTVQ/hUvfYjW8fmFgBdnnb8nvLre9THgD0haksPOaTOM7kxPtAJJg/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ziS4kUSo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ziS4kUSo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2348ac8e0b4so26205ad.1
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750110316; x=1750715116; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkxtSh5lJN8oDluqdUpIdBWts0li7o6KCp4HMQP+7eU=;
        b=ziS4kUSoEOCzZhZW5Yy3B4YOYWa+J7hhw+EXghANMe5sH/9gc8sTEqZvvIhJGZolS1
         9JLWzKRIc/S+QiX2Z2JtQxI796cmhpTZg74aQ0ui+DBY79smYj6BEpXjtCGoD8xFPCzf
         HPZ6P8zeAx4tJFrI6qSJ3ERP6Lqfq4qQ2LBpx6tuy4PLp0tTs/TKzNVzG7Dpp5idbODs
         zEZfAP49+kOZycziiM80aHeGvo84QEFqwfFSDhM2GDwvs5QqTHxjy/XWhzOinAiFyYmU
         PES7/ReQpz8HlvOpd7ejPleLv9pHXanOrdb8b6wFD19/67wkW6hKTrjvBM+x+dEwBUdA
         LDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750110316; x=1750715116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkxtSh5lJN8oDluqdUpIdBWts0li7o6KCp4HMQP+7eU=;
        b=gHQ1eb/XWfmROz/w9oqo+U3H6FRhIoUkFKom9gFz/CYndALK2XNLiuNhgGFC+WA82R
         w4jM9i93M9DHc6igi7DFy53cG0HrByjYW+JT/xurY9VAugLOigSA7qJOIJIhydqnwZPb
         JE/DTew8VUDt67/f1SFRtDpYeJ3fNhRERqjRC/on34yhDfbAMoiIXkay6ABxsijSPCkg
         Ev1W1W+KOQXNeRd95KTl13VxH8U399Ty+QV5opqeOrhOn/HLNddzmqbWiexYr9eT7QHi
         KCKPDLuRw5gOJik2+oxWhaowbT93qyM9t5T9I3u1BQdXgfQqXlJ8JUK00RVpWDM81W+t
         bTWg==
X-Forwarded-Encrypted: i=1; AJvYcCXo6PjENLZn63kQ2JJe5LzACmNTkrY1b+/9QkTdiBIj1tEvS/r5kC9OiIs7I4wfzIL6JPi2jQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUntFTgc7ioheoTkG8GBxJ3Lq870jtnH0gNAQNZ00cJyhZGqIV
	4BmFoDXm20fcTvM9qwWNE6PlzuXQr0qsj7DEj/yKqTTgfzHyDOdKGaBE25P8z5vrXg==
X-Gm-Gg: ASbGncu9lIni6azYucy1zSVmEYvqJT+lHa3rsi0WVApPIMMRJ1dk6uzMyAW4HNXAG4A
	cwDzLCgQQsoaMBRKZYcOTBs/HdVUNPKvaUNZX3llV8Z7wPttPioOapepvHMWMly9HsxJvVlkeGC
	NUX4U1WUcf4WPnfyiArBzj7DlDaPNn/d8MJL2XulpiFrh5NO8n2GoP59dDLyyz9RwMWIGfaITu1
	EuugtZxBg3wAMKLpD6ds22F5AqZHKtRP3loh8wuQ8OHn3uEt8Uurr27ZRcS0BVyrLfUeXwuRBSK
	sQo8BQu3jL06N85mgvzYfcihpOhBG2mRqrUIuFQt+tJhKBLiOr0ElnzHsQYaqRiWQY2L/k7BfPp
	DDtfbn9jFmcyNGLQ08Mbw
X-Google-Smtp-Source: AGHT+IHrQDyvVnwCf9csPzPlw1hS7k+ZaNmE2pdHcui8ltcFiMTENAodaPPmibhzeNqADUXMrthyDA==
X-Received: by 2002:a17:903:1a27:b0:234:bf4:98ba with SMTP id d9443c01a7336-2366c5bf768mr6063095ad.6.1750110315130;
        Mon, 16 Jun 2025 14:45:15 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d1ceesm7328258b3a.161.2025.06.16.14.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 14:45:14 -0700 (PDT)
Date: Mon, 16 Jun 2025 21:45:06 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, yi.l.liu@intel.com,
	peterz@infradead.org, jsnitsel@redhat.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 03/14] iommufd: Use enum iommu_viommu_type for type in
 struct iommufd_viommu
Message-ID: <aFCQYqHostKg0YVt@google.com>
References: <cover.1749882255.git.nicolinc@nvidia.com>
 <6c6ba5c0cd381594f17ae74355872d78d7a022c0.1749882255.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c6ba5c0cd381594f17ae74355872d78d7a022c0.1749882255.git.nicolinc@nvidia.com>

On Fri, Jun 13, 2025 at 11:35:15PM -0700, Nicolin Chen wrote:
> Replace unsigned init, to make it clear. No functional changes.

Super nit: Typo: s/init/int

> 
> The viommu_alloc iommu op will be deprecated, so don't change that.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommufd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 498c9a768506..ac98e49e44fe 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -101,7 +101,7 @@ struct iommufd_viommu {
>  	struct list_head veventqs;
>  	struct rw_semaphore veventqs_rwsem;
>  
> -	unsigned int type;
> +	enum iommu_viommu_type type;
>  };

Reviewed-by: Pranjal Shrivastava <praan@google.com>

>  
>  /**
> -- 
> 2.43.0
> 
