Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E31DDA0B
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323436; cv=none; b=YxGGgbOziYCoRoUI9uz1h2zufn4d1uZWynNpbpfs6GoRjwL3NA9cq6QXH3FG/pJfWXl5qR4F7pWZ8GtPXc5fnB1Kr/5ecJlIo6QXSffDD+tHCsl7LA1JvApfh2Fg/dAEnZRHWOHgmA+obbHKmqyRU4JaUpekINsnPHi8vGWbqBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323436; c=relaxed/simple;
	bh=VDQOtunXaBm327yhGFJI4mV/zWjpno00O6cueSpmoHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akuvHD5DiokuTGMa34awIHmKDp9dlYYTkso0JPGwOVqbgzmrsiHFQ+WybTJvRud8OIovW/F6J8qF7gEPD/O5SjN63ycXaJcR7z82qOf1Co4h6w/5kdkztEV2ZCkG7k438H3/EhHvzu7NKroL4nB7EgHA6vJAnsK7pRv9TWjjhLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XSgq4eeG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XSgq4eeG"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4582f9abb43so33142851cf.2
        for <iommu@lists.linux.dev>; Mon, 07 Oct 2024 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728323433; x=1728928233; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ic8at5+otSdzszh8Cqp2pOJxMeWQBAZY6eTCFkXBnAk=;
        b=XSgq4eeGnrQVX1XJwRVwtufyKhDqDUcC+is2xPEgUingpV2ekzPteswRv8vOggQBDJ
         szKtysyD4GHxDWCHgH3/Vgv3u/L6dj7sN3xulpqhZNPCV8XPjMfLbSBFKwCssXQ1g1PC
         mLn1rJcS+Wrajd80QDQdgT0sx9s0h5R2BHDswpSvf5zanzUpfxUZUPzqz9qOVXDichSg
         4qirR5Oe4O84zsdYlGlIlwVrwgiAtABFPT/xtRerGwN9HSYXSbWcRjq2YQ8FhvhEeru9
         jzp6++Fyw8X/RIcoTnLG6HCO9K8wGgXu4m8oPlZpNrNoCe8FM7Vhc585db/csv9zJeeW
         fWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728323433; x=1728928233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ic8at5+otSdzszh8Cqp2pOJxMeWQBAZY6eTCFkXBnAk=;
        b=Fst/JXuNs3As5ia7DBQ5yTKmJW7wS8OZQ3yiugyWxPAROiEaGnIAc8n1auVUctQWSf
         j8k2lTK++DzAmB7v04Ui58XgRX0rAf6zj/uiC+o+LteKFsm87uTEeAohRskp/xDwT8ml
         6V9HaKBtvdWzAZYBc2GKVXM85DmIMQaOu9PJNaFbUKHQe2qn81xYG/gfZt8xDz7gFB2S
         GnuyWoUjxYZw/+Oq6Al3PSr7BkAH1uuKWGnQ6Nf72bP0EtoNJSzZIsVmzq4Wpuw4PTZD
         c7+BPVW2uhssNw4xsipeKB574RiGwLen/Un9ZjDSUy+djBP00yKT9TD21S5Tp90CKv04
         tb3w==
X-Forwarded-Encrypted: i=1; AJvYcCW0zS/IhYrFiMzM6yiH5U7DeQRwJYl2+BU9SssWfpA0VQ3MQQ8Dj8ZN7I3D0T9pI39qkl529g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbYJ8E9bo/mapWeKhRWOOxQTk/3mSLDFS5SjoqWXY3klmPrOXv
	k0x0b3CZo4E3rDIOs7ZBHdfKFdGQUL5f+7m+vXJcn+NXcKriFzChx6kp4PTleK0=
X-Google-Smtp-Source: AGHT+IH8DysIajFIpReTEYO72Lftr4AtqQsuMgp01JqOWKWeypQD47i7esStBCXc03ss2SVLA+5wRw==
X-Received: by 2002:a05:622a:199e:b0:456:937e:2f76 with SMTP id d75a77b69052e-45d9bb5b3f0mr209203021cf.39.1728323433395;
        Mon, 07 Oct 2024 10:50:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da7506d6csm28564521cf.37.2024.10.07.10.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:50:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sxrsO-003MTO-2i;
	Mon, 07 Oct 2024 14:50:32 -0300
Date: Mon, 7 Oct 2024 14:50:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Daniel Mentz <danielmentz@google.com>, nicolinc@nvidia.com,
	james.morse@arm.com, will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241007175032.GA762027@ziepe.ca>
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com>
 <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
 <CAE2F3rARZ_qq7MYnAT7nNKcNsL3DzaTH+ehPTNrwaaP20d9Cag@mail.gmail.com>
 <faf12f39-0048-4e47-b600-e686cf82afe1@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf12f39-0048-4e47-b600-e686cf82afe1@os.amperecomputing.com>

On Fri, Oct 04, 2024 at 06:53:25PM -0700, Yang Shi wrote:

> Yes, SIZE_MAX is ~(size_t)0, but size_t is unsigned long on ARM64. So the
> check actually doesn't do what I expect it should do. U32_MAX should be
> used.

SIZE_MAX is right:

static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
		dma_addr_t *dma_handle, gfp_t gfp)

It is up to dmam_alloc_coherent() to not truncate it's arguments, when
you pass the u64 bounded to SIZE_MAX you guarentee that size will be a
valid value.

> > I think it should be capped to STRTAB_MAX_L1_ENTRIES
> 
> I'm not expert on SMMU. Does the linear stream table have the same cap as
> 2-level stream table? Is this defined by the hardware spec? If it is not,
> why should we pick this value?

Well, the way the driver works is in the 2 level mode it caps the
whole table to STRTAB_MAX_L1_ENTRIES * STRTAB_NUM_L2_STES total SIDs
which is 0x2000000 or 26 bits

I guess there is a reasonable argument that linear or 2 level should
have the same software enforced max size. Though would put it at a max
2G linear STE which is still larger than Linux can allocate, so it
doesn't really make any practical difference compared to SIZE_MAX.

Jason
