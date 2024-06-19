Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFADDBB
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807419; cv=none; b=ifYaDC467fPxU2ov0zcfEq3n9UWboi95d9AMDcOUGrPgKHvKPGRZZ8PlyJG9pGjhbti6bRSaAolx+kLZ7MsgGQFqsIAzLvI1JOja9W1EzEDBwZkImWSBQf079i82G5aInlD9KgQTUqWjLiCUFPfpqTdgfRVVGySqp/yjAfpqSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807419; c=relaxed/simple;
	bh=TjKbxUpEnUKyFS7Yuulo+6m9UXLUpDXtWXUFSK0+KOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us+TLj7Pa3fjK84MbJ/AcGTXDgjyB5So8rrFO+YYMrAXHnqbKvy172sCG6nclJF6bkgNXykvRjm+7oVuhQJKc6ootH0CUmI2mJj7i/ncBoJqzDjNeLG5bX+VqI0PD+gGqwif2zGqHRJ8kFIbjUIYXB+L1N1/Ln4aos23tsczSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q7ab5mSA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q7ab5mSA"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-797fb0b4832so325249885a.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718807417; x=1719412217; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KkVwYQV/6jkEu0gAJvlVuepnjhHRXhEpVh+YOuYu3ZA=;
        b=Q7ab5mSANhOlemOWJRbIJmHXhse6fk1rDHvtbFvovGkKmw8N+PDK5MVL7lSViS9BOB
         82lpCzwJxn+QBCmQ8BfbTcansKutatLcqn+SIbXjoR6XLTbKQgei/g5jP9AuZnqQ0yWA
         wd+7EjgVZtEYO+wU8xUHj0kabOaOH7cPMQ9Qv99A2mn5BxIPcDmDPHHJqesyOOnytLwa
         RQ9LvjyIWU9I7rHdmnZcRxiuSRxiZyspJ7zBbKcS4ogQdymDBpa+sCsLUSw4jRS8pPcZ
         1oK7t2lMbDyCxXU/GXWyRq6yNRMK2hOese8KfJsDiViFfIwTOWvT/nse5oiEXpt3G4MP
         ypYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807417; x=1719412217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkVwYQV/6jkEu0gAJvlVuepnjhHRXhEpVh+YOuYu3ZA=;
        b=usWubfkDWtKoXnIqcFHr9bK+0q5PHIdcDF+RpHa5zc1TIPos3yR4SIqxGUXbBUdXYP
         mdnr7cEQ+c1GPYIjqx6JsdS+gzVBrtpSNJdyYT/9+sEY5OxryuBHcxWimzPdRqKxiHTK
         P0iPsUOc5h0HngqPFhIJ+GnB9Qrn1ChupQnWfGqnQa06kl2ytIrK4d9jX/51WjKz/bxx
         41i1z9wB7/nXBFJn6HhMYP4KBUGG6JaU6a3hOihptl/pvzTNL3DW1vm+QprdDEVCXhNE
         D8lPTkZotH9gwPTBDrYacwq7AHl/lajsaB6E0KO5/HedJu0z2GgfIzvw837gDJp3MmS5
         kYUg==
X-Forwarded-Encrypted: i=1; AJvYcCVBPzGtvqdMIhTdalzBhBdw1pbkQtZwOmocFkTYrvxATTr7ZdMUAHVu3eFntbd3rc3DqMXh3GbtxMg/AywTBODctweK+jk=
X-Gm-Message-State: AOJu0YxwsJu/3ltQDD3JffnGZFbQlhnKbu+hX10qF3Croi4P/Xmbc8rq
	vCw1kn6NTzX00yiwfjcDkaNq+47EVMDRkCD87x66eda3d0QWCr6IEuePBbt+bww=
X-Google-Smtp-Source: AGHT+IEtPhZvg8s2LGCIdwsd0X9DzLfBviQVD0T9AfPrmuxMxUw2V/bv52uCre/jcfSESaPOk4IESg==
X-Received: by 2002:a05:620a:4721:b0:795:4fee:81aa with SMTP id af79cd13be357-79bb3e55a93mr284092385a.33.1718807416680;
        Wed, 19 Jun 2024 07:30:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bc1352ab4sm16883085a.70.2024.06.19.07.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:30:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJwKF-004bBv-Kr;
	Wed, 19 Jun 2024 11:30:15 -0300
Date: Wed, 19 Jun 2024 11:30:15 -0300
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
Subject: Re: [PATCH v3 07/21] gpu: host1x: Use iommu_paging_domain_alloc()
Message-ID: <20240619143015.GB1091770@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610085555.88197-8-baolu.lu@linux.intel.com>

On Mon, Jun 10, 2024 at 04:55:41PM +0800, Lu Baolu wrote:
> An iommu domain is allocated in host1x_iommu_attach() and is attached to
> host->dev. Use iommu_paging_domain_alloc() to make it explicit.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/host1x/dev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
