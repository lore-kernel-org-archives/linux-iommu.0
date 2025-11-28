Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F3EADC
	for <iommu@lists.linux.dev>; Fri, 28 Nov 2025 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764288293; cv=none; b=tPhl/YrR/VWTlS2YM4Sb4ABMqij1rfJIaDzwmBQZ6iSUWD1J04d2fw1HWFkVf/VlgqdHLdx5dJtXSigeV4GZRbDz8+ZTzcFsOFlgDroWyaVBbh29peVfxXVSe4BLJ4GbUUTWhkz9gstHC7Ax5mX1TIB1PCo8y7V9rHwyJgjkaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764288293; c=relaxed/simple;
	bh=lJ/SOLXNmunoo+NUR3+6KmbIhabOxphiqh718CR/9a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDIvFxWsic3gR+t4wsPViS2UyaG6yvmCbq4oG2h5YtEIX3oD563wrAZDYDqHjfuAbi6xEUNe4AwbJUuO1HME39pO6auzuqsRCxBrPqnResvXCzYMH0QDtAnPEm+5OuhsbQ2EcUG7NzKjmqrs5rt+sLe8pnB8G12xVX4hCeCUlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YRc9rdem; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YRc9rdem"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8823d5127daso12843626d6.0
        for <iommu@lists.linux.dev>; Thu, 27 Nov 2025 16:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1764288289; x=1764893089; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/u3DqDofTkBTZ7opR1QZKZ+L0ZpwVhBlcL/5S5ynAh4=;
        b=YRc9rdemqazURoZRxltNHkUyLXwmweSfhLOf44s1aySb0dhLJdqOGONr6FoPHdvL5q
         UBHcuOGXe7ZUS/gCULcZF4fT4OUfSXdao/rBZT0o3rdCmOU1t898BneX/5TWvh9x0fkr
         6PN9Q7SVVxWIB5J/PUOPicTba/esEo7dItBCMLoFu0HTOAj2KInbMf1UV9D91/UF8qSQ
         AIxGKnZdLROweTug4hsUQ0I1+H7TooJ+HEdmVsqeVfCIJo+EdpLGimgVcLd1DWyfDMXN
         T+9NDtZUvtrUozSVb7/gqCa23H/zcAqc0OpCnbrpe2bF+yTIZ6sX9ML5+1ccxGeMyzBD
         GvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764288289; x=1764893089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u3DqDofTkBTZ7opR1QZKZ+L0ZpwVhBlcL/5S5ynAh4=;
        b=XDMssHzI3EdZG1VTVQ86OzRq/YOp1vdbuJAHgv7UaHuxJMFBSX8wQ454q0UT9HeYrx
         ozHkilRZ8xh8RpjoBqV4DdQp0z0iz+Q45TEGcxCnVwh3vEPX8dL1vox/ob6AptEZZhoe
         GGV1g+6csZ5bNElyzzXvKZGi2AAOWkr3WfxnH5LOfHP+U+FA6CGRMW5y8+ZNDjAOkt9z
         tAOvYgxHUmNB8yDmPA/eR2I3ii8EvJ3y5oz9gZrSNQW3kJeoYFI50mn8kjObgwWfEuUa
         pb87XvrbAWO422j5FaHLPw3AYVleGq3QM66aVnuJCY+gFHE7geDMhXXGKe9xU5WODzi8
         LCRg==
X-Forwarded-Encrypted: i=1; AJvYcCW8j9zDIMgzAn8Cg855BKvTTkK7Af5ucnaawLBUHGUMvBpGNl+PS3S1set5XvW1u1Yvc6smPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJ2W79BvwcIvJbJQvIHAd36ShBtMnIXjjzaVbQo6Q88DjphKBW
	jlnXJBx7Mq3XwHE2TYkLe1T1xDe8AAx7BOnZE3Ddk1RIfboPv45qiFgXqn/3jSrt3Xc=
X-Gm-Gg: ASbGncuLCBZrsHg+NFFLS/y/DxuRifAzlVwYzLOaxhlzhVEFGjuYie8dFeCTYTVA68h
	vlLhEitInhtH05WDQKkn1HUiiCjI4HRK9sDb/b88r2ynO1Uz/AjUQChLvRTOyq/JUoh9Kq6WxdD
	n9KjuKXkWRqUtI3V9v7L5Q5+3X+cxhuwYE82eLp9ar64uFvIDMcMI9zhq7oxWbx4V2mHDL/hj9b
	esjHa+wJd1l/D9YCYm/yAeRsB1IQNLmDHLuYWQAcoxhn0t4Rei9cc6yEF37bSgbaRIOQ/1ckq3y
	l3CVNpgpjIEqvsYRo1AxTC08OvElZEAgproWG0aqanbw5ZCXwgKqUhPZAnPdp6RHxxvwzJd2+XO
	IopRBFRLigw2BYg+9m1GpwtJ1lx2QZdnPyKnK58r47s76iSKapEC59FMqvzQhWa6ZEJQqz4XGqs
	ryWgfjLjO15YitHDHX/yzuVc7E/1yXONBRuafB5fI5EWw9KXWvAipP06TY
X-Google-Smtp-Source: AGHT+IEfcazVHExAeTNppaKhwVlOAuAKEvSGwm0KC8LB5++/v6kqKyav/EoBpEfeLnkmGsUutQRkzQ==
X-Received: by 2002:a05:6214:202d:b0:882:762c:6b7a with SMTP id 6a1803df08f44-8847c544e00mr360991956d6.43.1764288289501;
        Thu, 27 Nov 2025 16:04:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524e5cfcsm18939956d6.19.2025.11.27.16.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:04:48 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vOlyi-00000003IrO-08PY;
	Thu, 27 Nov 2025 20:04:48 -0400
Date: Thu, 27 Nov 2025 20:04:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH next] iommu/vt-d: Use shallowest supported table depth in
 sagaw
Message-ID: <20251128000448.GD738503@ziepe.ca>
References: <8f257d2651eb8a4358fcbd47b0145002e5f1d638.1764237717.git.calvin@wbinvd.org>
 <20251127183210.GC738503@ziepe.ca>
 <aSi3C5ws5mS-6NFx@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSi3C5ws5mS-6NFx@mozart.vkv.me>

On Thu, Nov 27, 2025 at 12:39:39PM -0800, Calvin Owens wrote:
> On Thursday 11/27 at 14:32 -0400, Jason Gunthorpe wrote:
> > On Thu, Nov 27, 2025 at 09:06:35AM -0800, Calvin Owens wrote:
> > > The failing condition in paging_domain_compatible_second_stage() is:
> > > 
> > >     /* Page table level is supported. */
> > >     if (!(cap_sagaw(iommu->cap) & BIT(pt_info.aw)))
> > >         return -EINVAL;
> > > 
> > > This happens because, for many domains on this machine, MGAW=39 but
> > > SAGAW=0x04: that claims a 39-bit maximum address width, but also claims
> > > to only support 48-bit/4-level paging, which seems odd.
> > 
> > This logic was intended to deal with this:
> > 
> > static int compute_vasz_lg2_ss(struct intel_iommu *iommu)
> > {
> > 	unsigned int sagaw = cap_sagaw(iommu->cap);
> > 	unsigned int mgaw = cap_mgaw(iommu->cap);
> > 
> > 	/*
> > 	 * Find the largest table size that both the mgaw and sagaw support.
> > 	 * This sets both the number of table levels and the valid range of
> > 	 * IOVA.
> > 	 */
> > 	if (mgaw >= 48 && (sagaw & BIT(3)))
> > 		return min(57, mgaw);
> > 	else if (mgaw >= 39 && (sagaw & BIT(2)))
> > 		return min(48, mgaw);
> > 	else if (mgaw >= 30 && (sagaw & BIT(1)))
> > 		return min(39, mgaw);
> > 
> > Though it is not right..
> > 
> > I didn't consider that this would come up, the only way to solve it is
> > to pass in more information so the tree can be higher than the vasz
> > requires..
> > 
> > Can you try these two commits?
> > 
> > https://github.com/jgunthorpe/linux/commits/iommu_pt_vtd/
> 
> That works on the Skylake machine. If you want it:
> 
> Tested-by: Calvin Owens <calvin@wbinvd.org>

Thanks!!

Jason
