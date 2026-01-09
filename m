Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788BF204583
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988274; cv=none; b=Qbf9fb/13VZUdRkP7rKIYOzB38wtI0Z+yhO+pOaMS+gwN2wOphXrsG/hoX4YU6pX+Sdy0C+8gufWHRrVOA8OQwr92gh0iO86IZfwEQlABPowHfexxGZF9Ten8N8U5Z/HaXVVdFcXmc8wjWfUeW/2ZHNDW/L3BgHTm9k/MUkQALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988274; c=relaxed/simple;
	bh=4j8mSXXSQlh/FE4IkZdDwk7n5+vtZGmT0Vq4KXerTeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCUv4Qlypzn8RcC5B/JWrFIoGOR7KTXDioGLd4SNZwdk2jihG19zclvgtOIVWqI44hnLXgzcNpKkHiqI+YtCqJ1juwdmvcJ+fF7Q3wrllWj0VkvCRvrBiTHp9pCkB2QylyMNas71kV6HRMmYAzVtE8/KdjRTcW5BT+HYbjWTVTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HfbBeLz1; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HfbBeLz1"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ba3ffd54dbso677818185a.1
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 11:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767988272; x=1768593072; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HhQrwHPYHs7tKqcm2gO84BH3BiFPGmtv9DkIKXa95Q=;
        b=HfbBeLz1R+k+jDRDUVxhApeRAGdLvMuszK6JXczSqfj8Bco7oJpAunvciSijT8vU3J
         zpgRKuej7kCpcQpl+tCEDEd2WFD2wm5k4vXRtn6nhTG81ga9SyzWizfOjrbeF6HDMGIN
         zofrl6hiVwmVURG0JSTEb0QHKB8AZ40hk6MJTAdzDtu+IdDlCXzNEUKTi0vWXIPwCtxs
         rjexZMtYzx57AyC9SXRuG4tyvaGdfvuFgG86nfrRKqT7LxzA1W3+uD5EfOL8ZZa36ITu
         SCrvTaHPelNr6wbcXMsqEVlRdY6MGIGzcHc3Su3z+oysMgQnUPW2Yd2m6VIEnJ7zncP6
         utFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767988272; x=1768593072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HhQrwHPYHs7tKqcm2gO84BH3BiFPGmtv9DkIKXa95Q=;
        b=QzSY84IggpRXVcV1Fvwu9ndfN+kbtzk9NPREFTcvEmSdBOuKZDpJ9NKDDgSzkG9azu
         ylrhcpBk/MjCXKSFVC3iYszEmM+XodJCcXpqdMhuoxiY3ePL8t+JOaMYJ9JOeOdpjvKI
         OWwaaZomoHDkwe6oHpnH2xVCHhd39rCaGsF+IkMgWzahGdD0F4dnVWU49XoETOcrh+x6
         UYw7KX9qe+i88TcaDp1KYBG9Ewk0Xn1eIdyq8e/UBVaKeWijzypzTl02Ex3k8CbtZb3I
         nHXHeTFxYwYz6fzxbeVuNsmTu4/agw1xsLcNCAHLcgAyPGovY4RaPUkl863DFYfBsKeZ
         MThQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR2W8vLeWdZ8QjFsL7c3ziWC7rcltf+8ZVSZwf/F97IUgyRl3c5QKcUKN2CHwDdqJdPEXNhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyd/QUf7HkClVdHTVjXSxWLhaOfOngDMaP3cUQeJaPRhZtWRt/N
	wY4HENLZEkvgoNIfsTQFqbvuiGMqrckhozZEo9HCkg6nvlA7w2sHhAYIvg2OGiTR94g=
X-Gm-Gg: AY/fxX4zi6yD9pohPHK58aFVekfjMohYw+CAe5BDkBaJN1p8GTlF6PpvvFmcESdmKBm
	aDLXGfH6H/f0bUcqMNX2XuV9vrdjVTRUwCo5Trs78UFJXklZ+Ub6R9Tq7oYYiYuXLhn0JRkJcFJ
	0eRlV3yQG7IxLQsXgBqS5la3ij/t7ROk/fv/uau7GlXxVM/uZY9BJtle5u8yDgNozjxhGD+stA4
	FbWWWD4QtUuuqv2PDEyE8Dzh4QXf3ckn10ezGGedYutm92pju+V1vRQ049RJFsaOlH29rDsW9SO
	YMzuQBESykORiHQZcERzko469BO8J3A6lmyT+43tRQy00s0Av6bASeoJDgVtj8Q/b7BP6wI+pX8
	SqX++kBj8X7Vf10ym+NLNBtyNDDspGYiSbmhYvpYPMC346rRiJhMkbvkRGL69wYBgU48xknuwVY
	iG3EA10gxvxSgpZeIvN38XOULbCLhCGzT+dlwvoybJ7+swbnRwHbhlqSmqRN0Jx40t8x4=
X-Google-Smtp-Source: AGHT+IEZlrPxi+avVlluweNPtX7JEzZwtpBy5iyUb1htiohwK8TIi/Gv4SrQxJebEESGgl3Hi3a9jA==
X-Received: by 2002:a05:620a:414a:b0:8c0:995b:e729 with SMTP id af79cd13be357-8c3893aa18cmr1552234485a.38.1767988272405;
        Fri, 09 Jan 2026 11:51:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f400b59sm888623785a.0.2026.01.09.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 11:51:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1veIVr-0000000381J-1kSA;
	Fri, 09 Jan 2026 15:51:11 -0400
Date: Fri, 9 Jan 2026 15:51:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	baolu.lu@linux.intel.com, rdunlap@infradead.org,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
Message-ID: <20260109195111.GQ545276@ziepe.ca>
References: <20260109171805.901995-1-smostafa@google.com>
 <20260109171805.901995-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109171805.901995-4-smostafa@google.com>

On Fri, Jan 09, 2026 at 05:18:04PM +0000, Mostafa Saleh wrote:
> +static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
> +{
> +	struct page *page = phys_to_page(phys);
> +	struct page_ext *page_ext = page_ext_get(page);
> +
> +	return page_ext;
> +}
> +
> +static struct iommu_debug_metadata *get_iommu_data(struct page_ext *page_ext)
> +{
> +	return page_ext_data(page_ext, &page_iommu_debug_ops);
> +}
> +
> +static void iommu_debug_inc_page(phys_addr_t phys)
> +{
> +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> +	struct iommu_debug_metadata *d = get_iommu_data(page_ext);

You cannot do this - phys_to_page() can only be called if we already
know that phys is a struct page backed item and by the time you get
here that information is lost.

Probably the only way to resolve this is to somehow pass in an iommu
prot flag that can tell the difference between struct page and
non-struct page addresses.

But I have to NAK this approach of blindly calling phys_to_page().

Jason
