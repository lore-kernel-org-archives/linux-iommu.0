Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4A1C9456
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330426; cv=none; b=I44v8FqIsE0FYjXhpUV7AuEy1vyCqMc1hdCV3baHFr/LswfaXG1+Y8waxYcVNoxjTaxv1tsmdANAXLdQLWD94Koh1i24nNY10yUnk1UwFONcU3ee29iTw5sKC420E5fhoSvlxA6hfCDhX4yGlBOp2KkTnEnM+s/FnE0YWN9VR5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330426; c=relaxed/simple;
	bh=u+lXq+rdYCQEjcryBuQAHbD+XaWF43UBvvjt3/Pt76w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvM265K4i1RMqVHTiSxNMNqu2edqYPgkRlQ0epbqSOJFLdT2skzk0clDsTzgGb3nDb+0kc9h5sZL0rRJKCC+ttpL6X1KO+j5XYjVfdJSsJYbrje9ENpPrpLgsn4LEPCHGHho8AAAq/n8+Hnb9i7t+b6bv8XxUrYO/DxSLveR+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g0zmM2H0; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g0zmM2H0"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44febbc323fso3916871cf.1
        for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724330423; x=1724935223; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwL5lZSwcP38wh+9snCenmXBLa+f3hQFwMyRu7mV9sE=;
        b=g0zmM2H0/19Mirj/6kkY1FXnG28tIJVbIhf5ePyXXbNsyX4LC12WkoLx7EhwBZio/E
         oyRZvjTve8YiZ4c53B1KyBRYT1fBI0ivNyN5J+hSvpAzR6e1haN5fySUPw5gCCkuTwye
         bT74KIpoeRVPhQmt+6dFvhBP6dLN/OcENBtXkaquCmVgEOgCV35bybhtvnEr3YDaR/Pb
         Ud+BM7kLsBRoOvA2Vf2rN/7kOr9Q003YhemD+hndGsRM1YgN+ZrHdc6Rzm9/FgXMHP+m
         XfP/bEKVysOO8i11rJZ53FLnyBeBLFkpSRie6TgDHljVycEyHf4uyEYeoJkDXj3CGSTR
         01yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330423; x=1724935223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwL5lZSwcP38wh+9snCenmXBLa+f3hQFwMyRu7mV9sE=;
        b=hHBosN97/5us5CwBI7/qVdrQ1lMPhaOUnCKpT9P1Z4lGo0XYbFHeo/euf/ohathdUV
         YI/bv3HY2JJvLr+dym/4DrUZaXGTN/J9XfnG68c6HEzzUT0M/JXuSNTVc2cwfk1v4ctV
         46HKM3ysMydK+S3Z6AWCd8/z/KEZC/Dz4z0ComA9waem/xXYhpxSiwtXLVmwMH8DgJT0
         WFCAVl5mV2Ub/S6XqitQ2+ndWow7S7vwLF7DJX3jHklGP7wjJ1mbrGcjNc5jVnaH2a0E
         QYmIQvg0CQE9RM80xo+RSBuEFHXIoj/SP7hGHZrC3hjazmsSDBBqGSpfsc13LeWBVhmA
         YPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYjP8Zlw8+B/dfTukR1S8smoUtJZFmypLeDNz0cY1Ggs7J3cHZ4ogw3tP0kRxJAZs68HYOHw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxs3w3x1BhZCdmDNUVIPD6lyNFv0FilCEtDcd+LOcESQQJTqzNH
	4djIB0KoL898FFWtS3FiumuVnnPHLY8wh88s2OVBoXjTG/vX2PrRFc3aGd5RXC0=
X-Google-Smtp-Source: AGHT+IEOaM9aQiEIDU9dqB2L4+Iszy8IjFMLyoyEw/Nkp/EzJHhPVct5UTICEsElf5k4fbw6ecN27w==
X-Received: by 2002:a05:622a:550c:b0:44f:ff87:f0d8 with SMTP id d75a77b69052e-454f2281578mr60265291cf.39.1724330422717;
        Thu, 22 Aug 2024 05:40:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe196812sm6210311cf.65.2024.08.22.05.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:40:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sh76z-00HP4k-La;
	Thu, 22 Aug 2024 09:40:21 -0300
Date: Thu, 22 Aug 2024 09:40:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240822124021.GB3468552@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <a85e4bc3-0046-46fd-91e4-bac451574d11@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a85e4bc3-0046-46fd-91e4-bac451574d11@linux.intel.com>

On Thu, Aug 22, 2024 at 09:38:31AM +0800, Baolu Lu wrote:

> > -EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
> > +EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
> 
> Some external modules are still using iommu_paging_domain_alloc(). Would
> it break the kernel build if you simply remove it here?

modules have to be recompiled if the kernel is changed, they will pick
up the inline in the header and shift to this API. But generally we
don't worry about external/out of tree modules..

Jason
