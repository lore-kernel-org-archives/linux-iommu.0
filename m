Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B51719CD19
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542704; cv=none; b=YWQ8wI08XihCTSNC2fryarQgLD7BCyNYt3O3VvSHWs3+L7bTP+Uo9pI63TQuIlhyhJ0sKARtP86rkkZuOeaxPief90IHOJrrzOQDhjwoegsAMn9Z1fCxm2ef9n+ivwxVAEuIckKUDBO+baEeeXIFhJQfHlrlWMD7jF+D42jBtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542704; c=relaxed/simple;
	bh=zDCA23YGQ/Y69ta8sNwCokd06k4hwHincXxUa2TuAnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/ZStn4SPiODH7b4HCdJ7u3HIJtgQ4VoxW3LfRawx14FjZ/KQZSkyhzQNQRf58sK5OP4eCK3D3xLSZnGUdt1xIbesfr0ZK3n8iNkq1HQ1EfGGl3MICIGBfHNhZGPLa3taPGCXZ1MwncnLTCaITDtf71eagOf276dKACwowjxP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YwMhtwPf; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YwMhtwPf"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c35b545b41so17988086d6.1
        for <iommu@lists.linux.dev>; Thu, 05 Sep 2024 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1725542701; x=1726147501; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQZ/prAHSJzNYvQ41aDnul/jxJL4VTE2Yg49JItkgwg=;
        b=YwMhtwPfHjcSA12/wiBERS36Q4IitLQQYUrVoW2TCBH5Q7GE35q72cLe2H28USZIKV
         NceRidEN2yMxKdtH6iSVjzMmsCB7i0zLFELQPTSu6phd7j3+I+39EHWr/PSmcyIUfsl2
         Y5m5U3zJppugoQwardNvGgCLGe59+1pXMX9oCL1HJcHx89QXMRdY0gtbNORr9krB84r8
         8sPn6WVNynC5sE7WLDMKoJ18pq7edPpMxi8cx3EACFSF2hulSiRkhTwan3YylhugJKxU
         V94Qi4Wyodt5TLisaq3u+Xu4oRu/1DUr1WGXmRovDKeczFPajn26HsR5SHtVn9Ucp27t
         TMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542701; x=1726147501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQZ/prAHSJzNYvQ41aDnul/jxJL4VTE2Yg49JItkgwg=;
        b=CsKC5UxI1cU2gFviZHuI3Ibe80keojjEbIm4Ywol3aYEJqsfxSL55OWMIvKZ/sPr4U
         7Qn5zOLQ5UrjslLGixQcvjfV+gYUnXRk/jl2duI8xjc0Xr30Rn81qj/+oPIy1RAK2Yyc
         1u0cSmJn/JIgx16a0O1m1y+LY3VPzgk5s0k0i6tXWUmjaf3NVN9t9WppRSjbooHKmrBk
         2tMmPiOHI43n11fMU2RBakPTaHdX3c7ooC9ytjg+421jB1vd9/JrHQcQTxCOHz5KbhwL
         JO5Lm4J2iMmEW1+enzg+r49t7CtCivD4esLpnJwOp8GD/0oy7AefBiYnGJt0IJ207cLb
         nzfA==
X-Forwarded-Encrypted: i=1; AJvYcCXCJuW/74Q71mkx9v2/Lb1B51pA4qUas9WxTIKY5Bzd5gQQGwvnLTvqqwcKg8CaGMKstg3nmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyybQlPNSI8n8rF8pIjPeqm+kkRkTsNzwuRXNz34MmcIUTPtFJ4
	OqRK2Kbe24+tqOIUr/2rJCrj9J3v3/1xNhGtqyjAkVLeG+DUdOkAFqXcnL6uiOw=
X-Google-Smtp-Source: AGHT+IEDu6pY51+TBXvcoJ6tFwe8exqs/WY3csyGmyVmQ8kYoFXlzHQS0zH+YsMUz1IR39QgtqrhaA==
X-Received: by 2002:ad4:44a8:0:b0:6c3:6799:dde3 with SMTP id 6a1803df08f44-6c5191197b4mr91124026d6.23.1725542700794;
        Thu, 05 Sep 2024 06:25:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201dff49sm7525176d6.15.2024.09.05.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:25:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1smCTr-00CTrV-Rv;
	Thu, 05 Sep 2024 10:24:59 -0300
Date: Thu, 5 Sep 2024 10:24:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Karol Herbst <kherbst@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/nouveau/tegra: Use iommu_paging_domain_alloc()
Message-ID: <20240905132459.GG1909087@ziepe.ca>
References: <20240902014700.66095-1-baolu.lu@linux.intel.com>
 <20240902014700.66095-2-baolu.lu@linux.intel.com>
 <a43c31da6a6989874eb0998dc937d7a611ec542c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a43c31da6a6989874eb0998dc937d7a611ec542c.camel@redhat.com>

On Wed, Sep 04, 2024 at 03:06:07PM -0400, Lyude Paul wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> Will handle pushing it to drm-misc in just a moment

Did you just take this one patch? 

Who will take the rest of the series for DRM?

Jason
