Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5212B16B38B
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070587; cv=none; b=r8gc6ezuPPOuCwV4jSWN3q+2mxufP62zKTHgbcaGVd30IZHcBpjiNWwsMz0GoRcJTePOnauvKSDNKwvR0kBJjL2GLrkqZ45fXJPBYs+b6SrTC0cHysFbKQhHnzDyodQRo63kCazoMlWqIM+ntI7ABS7zNS3fc7J+vW3jUbnpXcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070587; c=relaxed/simple;
	bh=bSNUXKGBjQKQmux5zNRZzh5oU+ewiugPLqR2rBPhmek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkMrPrDKudt1I5xDMVkkv937xcNxsiuIIZP1p/W7737I7y/G8a0Yf0SawScVJbet7OHhYEUty7AtsHoPHjrUwRIWxUaG+ot1fYmQckZQX5zlW6GsauyvgBOO79aBT1THkYzCc2YVmR9UtsLoqgP3o8WZTlryhWuQ0EVa3/xnJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BU+KRQR9; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BU+KRQR9"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5c7f24372so2779960eaf.0
        for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724070585; x=1724675385; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2uduvQHU7RcRy7PnMogFpv26XgB0YOKAwBeGf5yMFQ=;
        b=BU+KRQR9LQHNgZGV/dbYVk+l85Y2qP9Vjk67IiUnAKxlgPQEQCq6sYFitkNmGLybHq
         5gx3rPEr/2seiTmK1sWcpYXBLvcqGygNp0hHZah7DjuJxKHC1nKGqr1IzKqoRCis8dvG
         vn8wBzwZ94ZAoSUtiy1EObhl+uPi40/f27LOT9pWx8lQPbwQjEEe8rfZom0xxZZ1VA0d
         PjlE3qpcjzcw0Bp9oLCQCM+xCzCap4sCD9Vn2HqQI1EqhHtQTaiP/6P7iOtmhjnJfGhJ
         PTxM4A3iAMjfvQG0V9igyDLQrR0MjiemKUMcff3iYNazj7q2yPT6Kx90SAnoY70yU9a8
         JFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724070585; x=1724675385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2uduvQHU7RcRy7PnMogFpv26XgB0YOKAwBeGf5yMFQ=;
        b=fUYSI7kChhdxk1r+N/m3vdqhnr3yyeCCdbgYf/vUviOwmTejIRZVMo9W8ZL/6CNkUm
         l5UxfuttYSFKtuVKyXf4kIqHb/tKQUgTxfwcodwlJYRPlOvO/9jNmkhbIZ4B57IhpM/m
         rj9NE3kgrrlFyK/Rq71PNH/X8TudL8QpN2RN5u8ppRwlI48r9alTwTNQIcd7JU6xJ2uu
         cSrFexjJIqz2w0zlDszrP1Sg5pn5gTrw6Uu9l7j3AnFzkkUZZeCx6nmAr7IoXBgDs//Y
         pI8cdIUTi+0M3Zyh8gbhprAf4EsZiu7yVxOU+0jzA4bTUjW3lWx/UWvL0p0m9/HG3aQ9
         lbRA==
X-Forwarded-Encrypted: i=1; AJvYcCXxsd+lbC1rQmJnehDP3NHBzFjfKTT00EWs1fq7Vi091t933goca/KhwH3vIbTjLC/2TKn9xQNTtu63ca+SlAJ34v8HYQg=
X-Gm-Message-State: AOJu0YySJO90IfVD/NV1SHxIftimoscvT00CosHtDR95aTGZCr4NaSWN
	RnOvyVXp4BTxECQvkXCp4dWQsAf1AKsv9f8Y2Kp/6VirawN2X6uiR0UO9YLnu0Q=
X-Google-Smtp-Source: AGHT+IEq64EJCggEORBlIJB1OWGqyMwlcWFmqpkNavRqagxVZRYkxxK0bKpUF6pEa88q/AkIt4dLtg==
X-Received: by 2002:a05:6358:2923:b0:1ac:65e7:9399 with SMTP id e5c5f4694b2df-1b393183744mr1458504855d.9.1724070585139;
        Mon, 19 Aug 2024 05:29:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff0ec9sm40028471cf.26.2024.08.19.05.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:29:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sg1W4-00CHou-2H;
	Mon, 19 Aug 2024 09:29:44 -0300
Date: Mon, 19 Aug 2024 09:29:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move PCI PASID enablement to probe
 path
Message-ID: <20240819122944.GT3468552@ziepe.ca>
References: <20240819051805.116936-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819051805.116936-1-baolu.lu@linux.intel.com>

On Mon, Aug 19, 2024 at 01:18:05PM +0800, Lu Baolu wrote:
> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
> attached to the device and disabled when the device transitions to block
> translation mode. This approach is inappropriate as PCI PASID is a device
> feature independent of the type of the attached domain.
> 
> Enable PCI PASID during the IOMMU device probe and disables it during the
> release path.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> Change log:
> v2:
>  - Move pasid enablement the last step in intel_iommu_probe_device().
>  - Clear pasid enabled flags after pci_disable_pasid().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
