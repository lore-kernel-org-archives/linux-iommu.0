Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200973C17
	for <iommu@lists.linux.dev>; Thu,  8 Aug 2024 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079794; cv=none; b=oGgCoRj5S8c3FcPAjqatLDsq925vhxzcVQqgNGjPwtYv4YiF1hnx2qBktAmcATtQLa0YfdPiyONNuBGhzWNGuK36DUwJdb+jDryLZuo8x5ABgxRtIBBMEDahKlOizyi0cSTnYBFd+NWjpoPNUwHILHEgdFw0NxO5SuVOCxeDoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079794; c=relaxed/simple;
	bh=ybz5l+gJpdSoJnU0pvRa21wFjluBhBZ8euKtKE9Kr1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXowpiS4x064Vscf25DkGcU0Y4ccHoSqXnO4I326NVvX/I8TQZrgYnPsAeADesh8UYLGT4GwCo/BfyYR9ACEHBCjku2S4DPM9T33nAUaX5gZ9tvya9fLWdsVGQHm21RsuQsF54jhq6mgnPHyV9Pd1HYjXVtS/rVs+KWzBwhQJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aGtNH8j1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aGtNH8j1"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1d3e93cceso142736685a.1
        for <iommu@lists.linux.dev>; Wed, 07 Aug 2024 18:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723079792; x=1723684592; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gv2EGN5gjJumkrdprLJXKZiGNp2Wg4Lm7KKvE/0bwjI=;
        b=aGtNH8j175mSgLZcFXy0OawWAQN66+9whs3oKiE8LAPkUiBrI2v9nVfG0gg9TtN9tg
         wa4YSz2S2BOgm0x4wrMsttyb38m+VP1pxuTdBiEQPsZshPX5ErW2h0KomVXm0zh+2L0Z
         AMh6+7hb9GyOLCzKRw51iDNwBJXyQRRS20BdjcXLwdL1lOyeVNzyMdYNgKEXSowYkrxX
         I1lAwc9aNryBGoDP3ZLPs4cCS6Uw0gxnHQwas5mVEDMj3NMo7GKdgfVJWljBlz30Gwn6
         939XTi203udRipFyHGt0R/mc6hO6F2c04IY/oz0rwblZyEYo+OuQUt3ytQBNlldHL/sQ
         x7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723079792; x=1723684592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gv2EGN5gjJumkrdprLJXKZiGNp2Wg4Lm7KKvE/0bwjI=;
        b=Pyb2gX5ZHSYexcjECD1ZE++bYJKCINAVKiYelpe2n3vPr7K6+0GuuEKD/C+Yjsv5l4
         9bZhUS8v2HBIPT0smiCrHlorxehnlKkF3Oa0ZxFj0tVBmIyQPle63LgJz5R2Rqp7s+a0
         L8oo5uVmUIUExTeMGcZXoeE4zIPaXjTCqRo3D/9PJ6C9/4r08e6uNwNAMFY4C9L5t/5y
         T5lS3xHGer3ZLxICCXsTXU8sYhltDyvUugluHGKBcrDdxuTWOhHb3EaLPNwcl0J4PWuE
         wYxPrcbOpwdSPAoIy86c00JvxKeUcOxVmxY644nL6Xli9ERIhZKCBUqxu4XZyrDadc1m
         QGlw==
X-Forwarded-Encrypted: i=1; AJvYcCUZVhtqrNOiY+rUU0DpGo55tsBBn/iQ/5iRFEUl/rj7viSvg5OqxoSvkq8X1+rVEgVGR3TC7RiUZfohpsN8prY/RrkK+Rg=
X-Gm-Message-State: AOJu0YwJPm5Ux9Q1owdaxq8bTAvTz7+IYcCAwgexktiDKhJ3PPA2DlrD
	zKsbZ4gGnCsAeqaLwxqeoiZA8Xi4k5aUCwQpY+yw65ZE2gC4vQnvq037JYiN5uk=
X-Google-Smtp-Source: AGHT+IFXv9OqT6Ny+obe68f+nz0cN+YlhFWVdV/y79aqYTYDGAjilKEvHJ43TCPNbfUrKHbQbEfcaw==
X-Received: by 2002:a05:620a:318f:b0:7a1:e341:d543 with SMTP id af79cd13be357-7a3824f4553mr26823185a.28.1723079791865;
        Wed, 07 Aug 2024 18:16:31 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786c1d63sm108831785a.102.2024.08.07.18.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 18:16:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbrlV-005Y8C-Rh;
	Wed, 07 Aug 2024 22:16:29 -0300
Date: Wed, 7 Aug 2024 22:16:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240808011629.GJ8473@ziepe.ca>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807182947.GI8473@ziepe.ca>

On Wed, Aug 07, 2024 at 03:29:47PM -0300, Jason Gunthorpe wrote:
> > @Baolu, Do we need to make any changes to intel driver?
> 
> I think Intel ignores this issue, they have nice HW and their RID can
> use both of their supported domain formats in all cases.

On second thought it does need to accept, but ignore the new flags..

Jason
