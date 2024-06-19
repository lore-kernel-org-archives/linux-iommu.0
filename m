Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A41CF8D
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807265; cv=none; b=ngb1PBPGM5JK9IC3uI4J1M6di2294WoMdZhsaP1ryL2IfrBeZR+Sp/3PCUQR8lDEFsvN3dAHOplgazex+rYake19l8UIoZ+FMGQaxYxQRVhjcfhUhsyVTNNMj+S7VfsqrYPG8mSMw3OtE7B9HkYdP+CeKelOcqZUue/mkWB8/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807265; c=relaxed/simple;
	bh=ARGivhwyahyrBFKF7xVHfpn6+bz5Ma82X1RKuPLYRfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXXxzI63CIHS7qORvVbMaSoxg7KFqQ1wMFEebtpA+uhNTCxkbm/HH54UE4Qvlj7Its3vuykkGa6akk0B5urKSr1EjOwiQXgsiXFFjtDwwQtejfjY6dwQUKupWjz41Nu0l1qbyS0ZWqmerRLTR9B03D6nFlBPzV6+zmzAXpmqXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=L9mnBiGS; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L9mnBiGS"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-795ca45c54cso357851585a.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807262; x=1719412062; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIX8MgTBAh7QnNhNTPIeyUxRJPYUCCcH54QxTjKMhwQ=;
        b=L9mnBiGShNzJ4UP12692yGFox/I8+57WH/z2vTgksd62pxcJDtGkmAo0u7H9mfKJzN
         QKOlu+12VpP+x+g1Ia4nLSaSE3Jo0qCWp5Ereio/d5lrU1UTbCAmlSHbQP04icCz/Zqa
         kTMRE9EKkfMeCEZV7p51TKe1WQuzVjtrn1Ff33bYOCORe3EfH3yRZfUzks7embPurGPn
         7lhjPtSqbgZjyaqU+P+at9bTx05mns9I1JNJQoQ3fmT0qAZulSjhAX0c1DqYNw/X0oOP
         kTfWqtIpvejkDxsBUPcfA3J03kAc1D8VEfEMrreuchrILtS4Ww+SWiWLj5bFbuz9fy//
         ddzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807262; x=1719412062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIX8MgTBAh7QnNhNTPIeyUxRJPYUCCcH54QxTjKMhwQ=;
        b=sD49cVLQ8vhJ0tC9icT9JJu7QZBU6dILhop4y8rrGFtIeoajvFpDFujwCQ2UM0nc+f
         XV6eCQgHX+7859b7zC7TF98b5g6nCAyZJ1SiG6D4jkzYQucPEl2ab8IczGWMxqfZddBD
         PW7vib2e//nKxEIPzFCYZqoY1WAokWTqmCcI7oCGOD17y59DP9j/HANPuKYCz7G8Tawt
         U/wL6RqrVDUagDKxEEd3h6TjC0paIHfIKzny5w2ruDFKsQI9HQJRSL1i3eM3jg4o/Ewr
         zP76L/FOnrq40TJuQaBvmwxEBCSX8li1rp77ABJ6I1ykOTr1OQNER+4MCRS2dVPXO5tz
         bc4A==
X-Forwarded-Encrypted: i=1; AJvYcCWAhqGZ3T3QKlh227DzbxVY3HX3JLhldur/YknyHW0FdRutPQ52wsjNdBwgmNUEhq7tz5GbLEnrh5PhX26mfo94iFGO0Xk=
X-Gm-Message-State: AOJu0YxlVIhSoKOsENA7lr3Fe+a6R76yDdcGmu8QOE8QT9X3STq5xacb
	xvTwbVB1K91DN9K0jT2QFcKG06mlX7KaolHiCEdqldSJdsNiCSgetPOkgL/26lY=
X-Google-Smtp-Source: AGHT+IEeEBRvNzwpSD8Fs1Imp5pVXlsQQfg/ZiA1zsRiN4FF/aYn4Gxlj7EWTGzB/0ufExiA5d7ZKQ==
X-Received: by 2002:a05:620a:4450:b0:795:507b:6dac with SMTP id af79cd13be357-79bb3ee2f81mr279621685a.75.1718807262304;
        Wed, 19 Jun 2024 07:27:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe279a8sm609903885a.106.2024.06.19.07.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:27:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwHk-004aSD-L0;
	Wed, 19 Jun 2024 11:27:40 -0300
Date: Wed, 19 Jun 2024 11:27:40 -0300
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
Subject: Re: [PATCH v3 04/21] vhost-vdpa: Use iommu_paging_domain_alloc()
Message-ID: <20240619142740.GA1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-5-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:38PM +0800, Lu Baolu wrote:
> Replace iommu_domain_alloc() with iommu_paging_domain_alloc().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/vhost/vdpa.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
