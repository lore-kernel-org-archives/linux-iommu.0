Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD52E80BF0
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810076; cv=none; b=OBGb4qzmFZNvJi3pAp7L8p1iOHBpwDidEyscrbSrYsnpKZLDcrrWTyB/i/54FQF2acbGoDu3nnDEwtG31O3td4car/dIZ1QGhL/xKzaJ3RZy3ZqUhfBxB8opMWxC5LWQo2GPc5CGHt5QJmjjz5LeKImuvErhfnLERFzpgIPig6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810076; c=relaxed/simple;
	bh=HY7zkgA9tZJI2Xa1OwMokfTgAVoJ8NTLRZ5ONf6HCvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaK50bWUxSji2YFBpGkvEDpt0tqIGFxV2CQOUl21z4Hl58eXcNGs00Jk+IOxcu6mt9U3fqAcn16VAWkPFGG5g/Rc40MMVrOtXsv6DpYjNRkX1NPyD4lEBGBNhoM+ePJkA6y/clZTxmlu8A8wC+NbapBgD/VwyXnZViLE8/t/W9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f5vEsOv3; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f5vEsOv3"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b9706c84e5so3863113eaf.1
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718810073; x=1719414873; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FK6SjWXdq6bSAPX1rh4xTRaTP0djMJZM1guOyU6PPog=;
        b=f5vEsOv3pGcbPRNE395VMQYLcwtGmSuJFwk8GObiwv7EbLuNWIVuI7qdFGtpw46fBv
         3Uji70PqRtjZOp0LtnO4/45ZfjTmrPfCDIpVM4pvFQj6m8dBeepkxqt0o5JXuJe9RfFe
         fSHAELRcFBFCBz0WakK/Dc7kE4e/EZ0JnKqnzAcvBnCpq2lhdTazHTb2SNq1wgM63lWM
         ie/cNROnjezbP+4rtU7IGhKtoyll4YyCv0hf+itBwLCn3EatPUKV79UuVPGXfdY6vQp4
         5SKz/Jhh6VUbz6yuHdVK5cyrdH3NaR6O5HRnUWBfJYZePhtLyoL85U+ApdEOkuqVOwHH
         om+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810073; x=1719414873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK6SjWXdq6bSAPX1rh4xTRaTP0djMJZM1guOyU6PPog=;
        b=wFolKgEIwKC0oo3SP8DhOWsneetvKPoQjpxIYXPwgY2Tvh9Iouwy+6i7zxOm2J9YCR
         N6fro+i83t7K8xO0AoASZq8xosPtt1QXClV/e59VBAaryZdsSdg2mviZne7rOYtn3+F+
         Y10nLHpBtPMKHxZC/pRPooGU0fnO5EKu2HZNBxmD/zuSOXerbYT7RHBiNGILq1rgohl+
         X+50XIBKiWxoHhYfNZys38i/4l45m0CK8q61vkRAFDlpC/IjG7IEznhMM0EmpN4dNq8B
         nivK5aiSWqhk6adEbUbgeOhJ3zi8ChJSXq+vE5KLyf6aRxwrbvPG8C6kKxaSlNeHIxpm
         mOMw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Qlwo/yjhtfH3OfXGCqZXUTgGV8JZ49iM1o1eqc2Ze1uEIYSeB0SyYA2TIldKvx7N495x5EPaseocd3JJhaPIgwBcRWc=
X-Gm-Message-State: AOJu0YxDD4tdbQAMzPH6CMgi9bqa4VqZBLwqffM76wxUrkXwi+6GSrt5
	cv1QWfwsdztj05viPzqD3gAJjJX1Gtl+s13T3htteBgoWYRFKLEGqa94D46VsQw=
X-Google-Smtp-Source: AGHT+IEfWtO517AiTmrP1W6dPNlAON8bn6xv/7Wv+S6voiPx4xyrmyITXKPZjbJGoypZCOWemcF1Kw==
X-Received: by 2002:a05:6358:6f11:b0:1a1:cb05:243c with SMTP id e5c5f4694b2df-1a1fd5cdffcmr360413155d.25.1718810073496;
        Wed, 19 Jun 2024 08:14:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc068sm613342485a.34.2024.06.19.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:14:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJx15-004nig-UU;
	Wed, 19 Jun 2024 12:14:31 -0300
Date: Wed, 19 Jun 2024 12:14:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] iommu: Remove iommu_present()
Message-ID: <20240619151431.GL1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-21-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-21-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:54PM +0800, Lu Baolu wrote:
> The iommu_present() interface is no longer used in the tree anymore.
> Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  6 ------
>  drivers/iommu/iommu.c | 25 -------------------------
>  2 files changed, 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
