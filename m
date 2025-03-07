Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15421D3E6
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360670; cv=none; b=qlx7hG32L+IayxIkletRN+4y3BxFSERWVQ0WxrlUJPELhogd3IObLuZjjRKzHO6kz274CNcOGLGuXhoDxfIv+3XFu6bsT8NM2rabfOk035VilYKJjNNhb+vh7gHpE4dPhOMediGy+mwb40LfOl83YnCJEAU77EG4NSkNN5jxO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360670; c=relaxed/simple;
	bh=rX0uMtq0RVZw5cLocHPJ4iQ1QgIw8r0WsZ5PnIUFg/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT4/yZrihuJc2++bjOzdKvM1cUgYt0LLNaMtd9e1fGn7XzK+fWSauYRZsiWIX6FdgztY23v5AQKxS/Kbu6KGi/Utg0hxlp02oGkZhxpYz4JXQoBHa8z3ew0kmeH6uQsjVPIFzzkoMswoQD22H8ntmq6m70r6g7efhn24eNMk3PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NVgUr+gh; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NVgUr+gh"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3d0e90c4eso309227385a.1
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 07:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741360667; x=1741965467; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kCAKy1MLCn9h59tEwZqypamw7ZoTBGTa4RgpePYYALo=;
        b=NVgUr+gh110f1ia5jXFsJEmet0ykiaqBwnqAukW4DDZcsm0moCTZOZF/wQyx4D8csh
         xL3shuAVh/YP6Y0Hy/jkfhq+lzo7xt3Z9wh5oRMWPQy+yAZFGpfUIA5lQ6g7jwkINB9G
         GjQNvdNOlZZhNLvbEkN8nRop8wx07SMvo3rw5BCwrvGBSyulzBdTbJyZgsQ+Jowroff2
         TUmQrZeIeU6Y8Tni5goIGRFZQ91l3fLGYOUYbT2t+8xYZa7dtNOufN7LuMzqSPITwS6d
         DvGTpGjtmYCFiNUz1SvVTcX9I3WnEVE2yblyO7wQduwaz7Kuot1eIVrGkUw6b1bAtksW
         2TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360667; x=1741965467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCAKy1MLCn9h59tEwZqypamw7ZoTBGTa4RgpePYYALo=;
        b=EY+u6nx0eIjmtCc6shStoyNUrvQb0UJKiEQQSOxRTgwZulvwhAlvQw4d2R1XyaEXLo
         fm80LHY9KflfaQCPsGZhJ2XTrAW3LSfX3Cl6RgQR/LBnKtETJ4nGOkDA3YdmLd1gDtPB
         3J9b6ALQrGFC5HWWWjWgu8vKN0htBPDpzsfTuwBseX22pRF3FVum60/bHAAoi8VZOxgt
         F3O8JqOgiluikFEm7ncy1C5FEvuD7zDSy+43NO3dHujdYQI9RIwoc1YE14WLJ+zHLCpo
         Tsp3eUz6pEHIMnuy+JgbOzcdDlF1JENRWynFg3JK6qZ/dsPFTYjf5/Eu8x8ibZf0bsqr
         /qNQ==
X-Forwarded-Encrypted: i=1; AJvYcCViJe3LALQPUrScPP2y5wvgU6JR1s1eyQ//E1YzSuMr0FObLYkwxSoe83bG6eKYDr5SUaTPZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyT4zxfwHSnEx7Q0gPE+mqLcCqNp35bCA7f9yM74rtpIliZVhyN
	vmGw2EAJyl9Z1+OQiR102QIjYaw/LZ0nrrETVK5N6w4ZIkfLXYUcDFPbWZWB3T0=
X-Gm-Gg: ASbGncvnA7EawjY/bAuTr073n8hhH6isaKK7AQQRrw7OeOzu9Jt2Xw72iNfEQQYShnk
	fFttPbs3X/hCcEwV6gi5yJwot5lTRxT4giv1HY7C7CcLrLfooernQUwOTz74XkG0PPGCUZhD9Zr
	gp0IoBmgn8cZYYec8iPWBIn36Bih9B3lRI/IZbe17gv3+HNGu7K/HKpKCqJkEfZNvUNOFwi3OzP
	TCHs19oX4NDq056lkDz5zzli/uQglcRdZMLwNIvq1H8Dvnr71+PKSaTaLh1Esk8UFh7zn01FVL+
	QSnuyGxAo/BW6h3Fd1CX8atu4KDDQEvT1ozLkybogwUNl9SzbxuNy8fJ+T9DRMl+8ixzpcKUzyD
	QwMFNph7APE/P6CH6IA==
X-Google-Smtp-Source: AGHT+IGPtlWnpTlq97dHBsYv9Qj2zzhftXBWiYKJa7fQGbPL61VR64KLpfRR/UmiZXjz25h9+jNuNw==
X-Received: by 2002:a05:620a:27ce:b0:7c3:cbad:5735 with SMTP id af79cd13be357-7c499d46c20mr545047685a.28.1741360667128;
        Fri, 07 Mar 2025 07:17:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511328sm252963085a.105.2025.03.07.07.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:17:46 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tqZSL-00000001ljV-3gSE;
	Fri, 07 Mar 2025 11:17:45 -0400
Date: Fri, 7 Mar 2025 11:17:45 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org,
	kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Message-ID: <20250307151745.GH354403@ziepe.ca>
References: <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050>
 <20250226131202.GH5011@ziepe.ca>
 <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050>
 <20250301003711.GR5011@ziepe.ca>
 <Z8U+/0IYyn7XX3ao@yilunxu-OptiPlex-7050>
 <20250305192842.GE354403@ziepe.ca>
 <Z8lE+5OpqZc746mT@yilunxu-OptiPlex-7050>
 <c5c31890-14fc-4fab-8cd4-d4dcfdecdd2d@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c31890-14fc-4fab-8cd4-d4dcfdecdd2d@amd.com>

On Fri, Mar 07, 2025 at 01:19:11PM +1100, Alexey Kardashevskiy wrote:
> > > Part of my problem here is I don't see anyone who seems to have read
> > > all three specs and is trying to mush them together. Everyone is
> > > focused on their own spec. I know there are subtle differences :\
> 
> One is SEV TIO (earlier version published), another one TDX Connect (which I
> do not have and asked above) and what is the third one here? Or is it 4 as
> ARM and RiscV both doing this now? Thanks,

ARM will come with a spec someday, I don't know about RISCV. Maybe it
is 4..

Jason
