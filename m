Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D53921DE
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247192; cv=none; b=th+6p1H5Spyw/FPWVgvlYPcfRjSo0jLOFddPClr6wWuzOjRsQ+M9LXQIu/sC+QRKhCBF0FXyY2YXn/OLjjYepZgwxUoDs3qCZ7U2gayHoxLe09xlZWSOvzxEwRByJuNAm4tFcjsUYdFyG6pqfebUgetrGxnXbbTQFoTvVftdMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247192; c=relaxed/simple;
	bh=YjiDVVzZWacAL/M5Ubr5olPaoNX77xqsVgKjn5ZivrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiZnBtjiPfAmuvHctLivPT4oxQFSWAHQY/Lrt/tXGX5nqMoLr7cYEDVcf2HQxca3xtsFOGRuongCBPOCJ+Li5CAXGtPmqIEFTS2Nng1yvioBHPI+wuz5Iv/ZzoyM7r96BJicfAD7SgrdKyQJNhfs/s9BYmsx9tEk6puAuZSrnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NAItmfHt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAItmfHt"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf2d865383so1085ad.1
        for <iommu@lists.linux.dev>; Sun, 31 May 2026 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780247189; x=1780851989; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmuO3W1I2r8igx3GUMilp2TWl+RQ7oW1rVuzlsosPns=;
        b=NAItmfHtY8UW/KNEuL0TsiMWQWZT0eWEwaWlxKSLWLg3JtArw6C70BUzPgdT00cZyS
         EVyvb7HBHQPwlDPIOGBGW62v1VONKtxopw5RV2ES7Tu7LiozI00gaKbn5bVwgB9+u47m
         +1/MsHecNSUFW3xXiJwJp/JOss6UYn3BOzh5fAc0U19sK7H11ouHEz7NjaRxVCLkxOxk
         uVPFrWCAUvQmLKL1L2h1Z1d9Xun0XPP+yjAeVj4bQnErSpAR+G6o8mffx813lU+7o2um
         sg5yqUp+XuLQqddFE497OUP/c1P9demewWQsoOLqVi1di4NkMNiv11GrnaB3k4E3hg1x
         lfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780247189; x=1780851989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmuO3W1I2r8igx3GUMilp2TWl+RQ7oW1rVuzlsosPns=;
        b=ZtNwl3/Kc9ygiS88kpk77Kvu6SrKhYf5T/MW5C4/NQ543ZM4MAYCtPNlWph9ohu3xG
         0SeXWepESyt5HemTD/FcmH5bSH7VOUVDm1v++/jqmO9k3EJSw/Yf4jEdZvz3EUJOzI2k
         rKQCLZAe6+1AM1q7dYzB8l8GgPMB7TJGD/IlvhR6S+9Ok8EsOGlHrvqt9LJVLwSgVFqL
         yduXg7aFBGKx5T0qQpCI18FBfXmEIOMP0nxsEiQ6M3nM2e3VVv9XNPwYUjAVDJOB4VNn
         WMQoHqZrngbr6bComxgI3lOLmXXgU/CviyKJnYNPo7PVLTDAbLD5bHDh87ewkw0h1sYN
         Y3nw==
X-Gm-Message-State: AOJu0Yzbime5LOBOXq54T52QlD9Kq0Z85EBdFQBwpV4hf4uDkxhp13F/
	xvY1TbdRFQ4Gu/YLdLJUYzI9Kf/qBTbpS8mtF11CACDPDk2p0ByltiTkcp/rTCS8ug==
X-Gm-Gg: Acq92OG7w7U00i1TJfc2HxuOhKZRKHYPDb2nedhVydasDSbmGpgmofscM3HLnBs060K
	KKUfxhgFTIes+F5U4NY5gJhVhYHvKhm5Zz+CkarJ+tIL6wctYb8niUqpsEOIiSLFPrUTeG5jgeS
	/iKxpCUnhWs0ZgdaZpYrlKsWOJxAX4s4Hy+Sj5QP8cXCih127LqwlYYR6C7n9kwdli+YK53rPtf
	LaMyV9WnAwRGG9RUa2yEHQcwTCbQ0i1T/ffPVSPSKjdrN0XgVwzXYd49qpPl8EQHJwRoDqz9df1
	ToqE8vsGo8/9X3Zh31C3kpc1LzpVHUIsiOftkc53LJzGcszqsjIGd78iJk+IZ3I/sXQhFVk8gTz
	u+f4v09gcLexAwOEdteAndvTR5xJ6xjBomkaFChPTCG98jLnQkYMn4O1NnvuFqMb9fULU0AfCGb
	l772W5jNb5CMtYlv64rAwPgIlvNocUwDMFLjqMbceNUBMqkb6DPhi1ie6U3t3Div6w9OF6/7Y=
X-Received: by 2002:a17:902:d4c5:b0:2bd:6dad:7cca with SMTP id d9443c01a7336-2bf975b1f95mr4195355ad.22.1780247187838;
        Sun, 31 May 2026 10:06:27 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c2da36sm97965615ad.69.2026.05.31.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:06:27 -0700 (PDT)
Date: Sun, 31 May 2026 17:06:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 3/6] PCI/ATS: Mandate checking pci_ats_supported()
 before pci_prepare_ats()
Message-ID: <ahxqjLg3yRzWhgqE@google.com>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-4-praan@google.com>
 <ahoLccjQvmoE90sx@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahoLccjQvmoE90sx@Asurada-Nvidia>

On Fri, May 29, 2026 at 02:56:01PM -0700, Nicolin Chen wrote:
> On Fri, May 29, 2026 at 11:12:05AM +0000, Pranjal Shrivastava wrote:
> > Currently, pci_prepare_ats() internally calls pci_ats_supported() and
> > returns -EINVAL if the device does not support ATS. While this provides
> > a silent safety check, it conflates support detection with configuration.
> > 
> > Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
> > a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
> > the function supports ATS.
> > 
> > Update the function documentation to mention that callers must verify
> > ATS support (via pci_ats_supported()) before calling pci_prepare_ats().
> > 
> > Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> Sashiko pointed out a bisect issue. So, you might want to reorder
> a bit. The patch itself looks good to me.
> 

Ack. I'll re-order for bisectibility.

> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
Praan
