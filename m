Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BB341655
	for <iommu@lists.linux.dev>; Tue,  9 Sep 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426706; cv=none; b=IzY5XER5o0NdCPFMqZzYD3ppBsh9GByC1iAbCKWYiNFnE/upkzwJi/GAxHdIobDVCPgfYkwzhswCRP+g6xUMAoAtOeoJSC2MTXNfCWqj2rNhUTOKcG8cp2OhZRWqHdQZ9KnKsY23zjH7MCQtq2iDuQxGzXw1LEY4hUJIdJnXw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426706; c=relaxed/simple;
	bh=clM7aLTtKAK7jZjYjncRZofJKFUx38XMNJRsm1RWznI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9cPHRPi9zYxsZj2MPOFr70R5/iYas8iZiJCTLmKLL+Vs6g3PSaWA8kemwHB0ZQhqufvRFQ+uSkoIKnAcbJl3FXV17r4e2FhLOGDBoZYDMOoRioXvd4UkZXTgI4RFa/nXf2VuztXcHhbpSQfRFsvCmEqW6FsMjQftKtLhUsK3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hDh+n9YH; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hDh+n9YH"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-812bc4ff723so341627485a.0
        for <iommu@lists.linux.dev>; Tue, 09 Sep 2025 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757426703; x=1758031503; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=utwHzRT7iB9cYx3/XQysOeMpg5Sajk+mgTCKLtOFq20=;
        b=hDh+n9YHpLUhntWLzSt37M0vXqFtSHMI/2C4jDgy3w2BIEMPz+Oa6LgZba2yz3XBU4
         ZZr0BS+Zv8L5U23mCE+Y4x/0W1t+UkGr7Rld5rchtf3xFptbM7moAIm4FeN6r5simgbB
         VhNaBAwJRfj2xCCzvgNMaXBOmy4CLsGl+uEvaH9DSYIxU2mbOzsGkIQfxIvPlhVmV+m1
         8hgOQoqb38PqgMpShtrVrB2051nVajg/g2xtwvMxYiDIor5TU7h0Am0qLHSRmcu6g0+v
         +5QDIU392M2Fy14yOg564PpyXOavGP7alCcGzDXZ0gndY5DXWazBgHtei1obdCPx/Rbi
         IGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426703; x=1758031503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utwHzRT7iB9cYx3/XQysOeMpg5Sajk+mgTCKLtOFq20=;
        b=uWCM+IveDxMbmZyMxRPjUY2pdmmC+wN+mOsExfheJ9eyXYUxUFx//AIgFpE/Wyf0bz
         Zv4OQKodpLbWU1MAPLZEk5ZsLiqqi/jCEzCgJ3J0NltrvtslyUTek1WAsUBHmjQdbLyP
         WkEkdccrT5QcpuqmOUE9MYSvqummLoNpD71xxsk7fVu63aDLwGBHjv4IwBZC+Az18L/m
         jcDRproigllgsAWiJGRGx5rGUcB+IDknCqhG5lzrqwQu+XBnDUHFO0CXqrAvmxxsp5P0
         9zooDmm7vR2/isKKPsAo0Y3rvR07j6uvZt2iBAxxxPP5tnoE8gTtG3zxZ1lXn/oeBAJ+
         BUhg==
X-Forwarded-Encrypted: i=1; AJvYcCVPiSjiFN3sQ/lS/DBsQhqAWOUcqFU5SX89eT447CD0k7Q4XYdIpBKNAn6tH4gIOMIItyC7zA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyd8heNfTsJaR/0G+wrphhdRNZNCc4OSjR2k/YJt+vTQ/37Iwpy
	ThccX40BhTSwjhjXZVL4SAOR5/1/AZIuGRrTjChFNdIpThcT+DnMDyuPWu7WKDzDjgI=
X-Gm-Gg: ASbGncuapT/fIkUBfXbkkEwAv+NASNrRN3ZYeBTCdAAtk8uRJVgdjhVNwwZK/FBd1UO
	5RnTdnV8o7/0PXzQXYVz0lfXgPQsPoSDNSLvRdlq+BelHw0lfRqlo8LSwQXqDqeVPsvMs79U21y
	jc5otiStxzFoI2clOUFU3rRLQgBU+2j4okn0qZ1AjdoFbAzMgqh7OSUYGCcFK0wiACCLKR/NjGE
	eDDn2ROalE+IyOHb36YkACAlak5shnvbivUyJZB7bhc/adYh2mhT3jHT2xt+/djdLqDW3ZndTOv
	yeA7F5ZZBt1IdrNFLjnu8yZY3nsfNEfvKxPauVPCt4xN6t0pAdXD0+BtDzi1uRzqzQLB+XXxUEd
	te+QYDS+8UVz0XS9UjEFwaVLnj53/Vy8+lE4tT3p73reWICM+muyHBsvq0YOGiCmp8Z/wfXZzjT
	LbdBo=
X-Google-Smtp-Source: AGHT+IHn4ooZWCIZc4ogNpsIZRBiaT3ofZHlT1zKT17WVO49rUVbhh4EUwx+BmIhm6cOoaFhu0drYg==
X-Received: by 2002:a05:620a:4512:b0:80b:981:a0e4 with SMTP id af79cd13be357-813c39a14afmr1279442685a.70.1757426702851;
        Tue, 09 Sep 2025 07:05:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5faec7bbsm124986185a.63.2025.09.09.07.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:05:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uvyxw-00000003X7t-1fUb;
	Tue, 09 Sep 2025 11:05:00 -0300
Date: Tue, 9 Sep 2025 11:05:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu: Fix iommu selftest running test mock domain fail
Message-ID: <20250909140500.GC699673@ziepe.ca>
References: <20250909125552.125969-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909125552.125969-1-kanie@linux.alibaba.com>

> +	mutex_lock(&iommu_probe_device_lock);
> +	rc = iommu_fwspec_init(&mdev->dev, mock_iommu.iommu_dev.fwnode);
> +	if (rc) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		dev_err(&mdev->dev, "init fwspec failed:%d\n", rc);

No prints, we use fault injection to test these error paths, do not
print.

> +		goto err_put;
> +	}
> +	mutex_unlock(&iommu_probe_device_lock);

Is this lock necessary? The device isn't added yet so it should be
impossible for the probe side to observe it, right?

Exporting the lock is my biggest concern with this..

Jason
