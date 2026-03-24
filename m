Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E63E9589
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374174; cv=none; b=e7iC/IidJr53ol24jhQ/zOQ3kfdNZ8Xi31KcO5MEuNLjm8iNPbQ8jaGioKkkzj7TvT3SEOmlKXcITR1ZFxLVtIxPCm79HIRKGP3VZ94UfXprX75G0uuVC0EEivSge8X9pPD+115AtIKFu9bX3R1Gs+4dTVhx1d2WANBWSbxFAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374174; c=relaxed/simple;
	bh=QWIkD2dNPOWDG2iaQmcQwa3qfpALdnFK4jzk/uKN3dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZvdkHFodmEMimwbhphzo2Feq4CXYGKL9BBHrBah4oox2p7kZK7JvGessjQ3M3+litScwALTPuNNRsHRXmnNOwePyWvoKjHTpyYl13QqxONd8sh8AAYlb4hFJJO8BgGzbn4Bs98MbvfysSBY1xW1KFPDbo4GpVvWW4sgpw5k0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8XjNVRS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8XjNVRS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b052ec7176so7245ad.1
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 10:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774374172; x=1774978972; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELBKqo9znGMFulJJKIvGt1/Dgj2lLtKy7Txs2TxgETo=;
        b=G8XjNVRSVtDlGLWZZn8CKCvGqdo7UJMbq8zzuUNfU4eXeGFQQRxSaJFYygQyYroIkk
         DRgkljptXyhseTPZipkwZoSPHYsM9KOYPuI55/tksrc1C5flf2LGLunBEFc+3U/bwMAZ
         Zlt/zcEclXxzxIkVExJpoD2yHQxGUoLaSaB9XxP4pYDGbg2QT/XP2C/JIiwpo1Jd5GT9
         iRzCgROt30hg+ZKF0NNE0oAF6IgB1pcYnd0uCLIizlwTlXn17E7TOUoYBvuGqzcUeXzD
         NJyGN3coecQ3ZiaIkfRSSL15FjUjgQ15Vdw/NDcQMq7ZUxYeugtVk5H29JrryW42gTHg
         Gknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774374172; x=1774978972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELBKqo9znGMFulJJKIvGt1/Dgj2lLtKy7Txs2TxgETo=;
        b=Pj89xp6z+xpQq4a68XiCXoN+GRIdo/+VmI/xvXTQprWVZADMhoDtswnXTLh48P3uzV
         qa0YFXX4haVk5k9yrTu79zF9pr5kfy114T60InMOIOKAl5hizK0kScstnLxqfhbaGC/F
         OH45b5eF4U3jQEeoCet7vq0RpMEz38jJ0itXnxXRZ3hdm5F3Q1UAXuCEuR9tyhtYEk/H
         Qnp29MErRVIjOGxitC9rVHID7EoroEzYvsZttVox1MmXsSrkvgSsT5NA2lR2U3L/ukmx
         cW6PlIpyKVgzgKcmEAi+b8pz9sWmJ2U0OtyG98ua1eeiE47bK72LwNh70cY8HXG3QgvP
         RJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCXE9gG7VSzlZ9ipX6B+FvZjDIgE5rtcLObqYl38+d50IhyHIKi2hp0+P+mzpm+IKqNHtbaa4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh0QUREycoN4iEZTKK4sw5j/QxkA35tIlEqvYwMGs+TNZ+xLFk
	Mlx3T+BafZjHZC2S4GKt3C22xLhgbgW1K/wctDjuxk/9M7z3ET8XrIm2STYeC7qheg==
X-Gm-Gg: ATEYQzyWLAk/O4eYKkp2roxvxUcDEmD4wo7Bg8O7Wb4C4IA3e3fG0QWUTijoxCwUbup
	rH7zbWQOxiLkP1BeqS6T0iRxhcbE70SwJKDWS1yMnLAus5+iX8/SuyOGdBY5SXuQbx1idi1bv7z
	kbNXyAan4Klouiois8g6VVZaFYcbCQFrFri/ADxWoNDk90CGlxPBlCSubNxXXqFBjvLey30xgsk
	FmnKC1ugEUcHpCiFf89cp2Q0PJJFhuORskrcLJ4/eToALGxexTCnH2n/pm29O+b8hATj/iqySd7
	uL/Ies+AKBuFOyI9maG5vn2ei5TbF6OBkJ3SZvOzJnpyTOkM6b7klkNGUshB6bjULjnX3O5BAej
	zvjEyQFkEZAu76kmO77oxe//lnbITlhpUVM04Sf5/mYGziBYTKKC44bkpMW2Q29QoyxRSU68kLL
	35KqiHRQA8XIXwGRZg0Wq+hr2OzkEHFDQWKzW98L6jmX7L4ziakJsvYXKUBh5fVA==
X-Received: by 2002:a17:902:e543:b0:2ae:ca87:b1c2 with SMTP id d9443c01a7336-2b0b1568883mr235975ad.8.1774374171614;
        Tue, 24 Mar 2026 10:42:51 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0af2e9dabsm8104685ad.69.2026.03.24.10.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:42:50 -0700 (PDT)
Date: Tue, 24 Mar 2026 17:42:46 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, 
	linux-kernel@vger.kernel.org, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, 
	David Matlack <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
	Yi Liu <yi.l.liu@intel.com>, pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>, 
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 01/11] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <acLMZtuJ5EEqRCwW@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-2-jacob.pan@linux.microsoft.com>
 <abrvYSZ425p6a17D@google.com>
 <20260323131714.GG7340@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260323131714.GG7340@nvidia.com>

On Mon, Mar 23, 2026 at 10:17:14AM -0300, Jason Gunthorpe wrote:
>On Wed, Mar 18, 2026 at 06:38:14PM +0000, Samiullah Khawaja wrote:
>
>> > +static const struct iommu_domain_ops noiommu_amdv1_ops = {
>> > +	IOMMU_PT_DOMAIN_OPS(amdv1),
>>
>> I understand that this fits in really well into the iommufd/hwpt
>> construction, but do we need page tables for this as all the
>> iova-to-phys information should be available in the IOPT in IOAS?
>
>Yes we do! That is the whole point.
>
>In iommufd once you pin the memory the phys is stored in only two
>possible ways:
>
>1) Inside an xarray if an access is used
>2) Inside at least one iommu_domain
>
>That's it. So to fit noiommu into this scheme, and have it rely on the
>existing pinning, we either have to make it use an access or make it
>use an iommu_domain -> a real one that can store phys.

Thanks for the explanation.

I missed the part where once pinning is done, the pfns are only
available in those two places.
>
>Maybe a comment is helpful, but using the domain like this to store
>the pinned phys has been the vfio design from day 1..
>
>> get_pa() function introduced in the later patch is only used for noiommu
>> use-cases, it can use the IOPT to get the physical addresses?
>
>No.
>
>Jason
