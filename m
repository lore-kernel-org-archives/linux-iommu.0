Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632B44A416
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798442; cv=none; b=A9MQcTJoiSFFsz6VRXJwOK8dr3XawXjM8+xYOi8+9/cV04WYxMETj5u7y6esoJ0AUNf3Dl149CzrEh3UPydqIejniSSeT02xLrrVryhRqQpf1KtjQ8Qut7fIic0i3mKUKA4PtVerKZ+UvtvkEyXKUbOSwNISzOkRd4SZ77NhAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798442; c=relaxed/simple;
	bh=j05inaXzvotjyKWa/ZFf47qCdIej5ahkTtsZ7bh+bp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUZ6PFK7ZuLzULi6QMB4/3Vk4zt1rGYDa1Yd6es1tJihFaAV80UH04QkI8S9BaG8DG5zx9r7iL/Cam3siGENBxVjkcFKL1NGl/oAaUjCTI4ZfCGx7NmmYZlOmpFKP4O5Y7L48JIJk3K/8hfRULHCsW5Z+o7GWogpp5lDuF2hSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iIoU49bO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIoU49bO"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e2e4ef20beso18255ad.0
        for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798440; x=1791403240; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1G7G3x8CQosaH9I2KCc2mDmp0caEd6Jn1e0HXGIwM0A=;
        b=iIoU49bOGC/kSQ2MqF2qu42Lf3Bxce6n7Nja/APDxh/Nb81JeYLI1Hy8U+eG/0R2Ct
         FFKyJt6wZdr+9TrLUAGjst/WDIfYg3kBoVEQ6tjGHihEunB4TqgsnkpeiIRgfgqJ6moA
         GumO9lVEIDwVHw2yizmUfSzciTiRGczWRS3L9tAomwfKfWQP3duVv0EEFu2LsvlRHmOK
         zPH0WjRG5UxqDfBq/Q+QAMVAIj1y8AjWybLrLp25u6idsIUHwoN0MCSA4r1vV37WUQ6r
         O3JV1feS/VcFS9U0srESUE3KaJGf9KpXLgr7d8zSQO3ZWoSS2ikoPNfNdcv0drhi17u5
         9xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798440; x=1791403240;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1G7G3x8CQosaH9I2KCc2mDmp0caEd6Jn1e0HXGIwM0A=;
        b=hOOZdm9Oj+zSiKdDE50JPqR14P0yx4NbEFYW+2Pzrcd3mpi5aeLmzg0jYDHBQPZH4v
         Amd8z4thi/dt4Yyx5P1KiHLW/VWRgzjz+3fsRGJOm59dxDY4eIUBrEDMWWfKQXArrChO
         R1NnoQWFdUW2MXrS6ps80TQe7rPZarsR2Zs8JnMI4YO0RosJrfF74iqdQvJwYQ36Eahm
         BVe9/GFlHRHs2CTt2tJFUKUEYKZYLKrCgZwb5uK1bHrD9p/0OLK922riX9ZHwwmvLxUV
         Udo0q8HW/gcHzZux0PUr/DM4og0QulADravWYtW78mevppB7nUmrTWZ33vLVTwN9VjfQ
         4xVQ==
X-Gm-Message-State: AFq9FYIq5WI+rbQepzCymjWFE6/N4f/V2tBX67m+R7+bb6K6AOEqxDHa
	YCLWt9LkbIK2e0b/p7rT3p941ZoXML9ALa05mBx4eyPKbKJtm4cAN/P1WGEeZ4MhJg==
X-Gm-Gg: AYBFou2QlV8KpEEdmpRUl+YEZnFtfI081jYLvKAmYAhbmMdy0HFDIR173qQ/oA65pqb
	gFka334VgPK5V8JdyrRJPOHf3ZWhVAD1Ei6z2rI14lJp5z4UPhplY0T5KQZkoM/RCejjiWBDkEO
	X0SlUwEHg9PB9U9S2G8FwfHVTewUzTfGsMLX+6HOuz7qKhFjlStphFhXnOQY8YyzWEVEa+NPpFO
	5I6OEVA+pxxoxO7w77RfCWGnSYs4ZJVh107xmRqwGYONASCOcq91v8nSfPABww30AkyhhBYNwsR
	T1B/TlnmT7QsoWTwSaTNtiSGb/bKWTrLuRvxT1ZfmhVN6GLvm29bAR9SZlXo5TM6cFi6Yga7Jgi
	Uw3BDiIy9PKgypS/KqKklGTaTw7K6AUyJAVF2PtU4tWqQCr7pL0x81q0/r1IGn0fxAlBxsYHTlP
	p9KngQPSm8pt/3dwkn6K7auUL7wXgupCww+05Mv9szlKe/w7aXWPEg0LZ/90/3Ze8z2ErOG+AcQ
	KM2Iykf5jMfU89GY3+X2ay4Yen8K3qERDqZ
X-Received: by 2002:a17:902:e951:b0:2df:8ff7:876c with SMTP id d9443c01a7336-2e305472617mr373115ad.16.1790798439504;
        Wed, 30 Sep 2026 13:00:39 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f44d0a30sm753405a91.16.2026.09.30.13.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:00:38 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:00:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v11 10/16] iommu/arm-smmu-v3: Factor out
 arm_smmu_handle_gerror()
Message-ID: <ar1qX_Ox2ONgcZM5@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-11-praan@google.com>
 <ar1WQCud+B3nAWX6@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar1WQCud+B3nAWX6@nvidia.com>

On Wed, Sep 30, 2026 at 11:34:40AM -0700, Nicolin Chen wrote:
> On Tue, Sep 29, 2026 at 03:45:04AM +0000, Pranjal Shrivastava wrote:
> > The GERROR register's state might be lost when the SMMU is powered down
> > during runtime suspend, requiring the suspend sequence to handle any
> > pending errors before the hardware state is lost.
> > 
> > Refactor the gerror handling logic into a helper function. Subsequent
> > patches will invoke it from the runtime suspend callback after disabling
> > the SMMU, ensuring that any late-breaking gerrors are logged and ack'ed
> > before the hardware state is lost.
> 
> CMDQV has a separate IRQ, so I think it likely needs a counterpart.
> 
> I have a similar patch in one of my series:
> https://lore.kernel.org/linux-iommu/16ae24cc2a002802b990afa1a69fe4ceab1e0da2.1790188510.git.nicolinc@nvidia.com/
> 
> Mine only handles CMDQ error though..
> 

I'll add a counterpart to arm_smmu_handle_gerror() in v12, I'll factor 
out the body of tegra241_cmdqv_isr() into something like 
tegra241_cmdqv_handle_errors() (bailing out early if VINTF_ERR_MAP is
clear, so we don't warn on every suspend). The new impl->suspend op
would call it after draining the lvcmdqs, with cmdqv->irq disabled
around it, right before hw_deinit(vintf0).

Since yours is for the CMD_SYNC timeout path, I'll keep this
independent? WDYT?

Praan
