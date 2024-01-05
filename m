Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531836082
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xf8Hru/u"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68015293aa3so7881306d6.1
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 11:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704482524; x=1705087324; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ju6RzmrIg7+r2kmHy1lMH3C5ek+CbXRDBgiJF/XUEs=;
        b=Xf8Hru/uzlQtVzLbYr2DBhxvDsfQpBfPwhnOq3Yfc5x+arGCy15wxLxk428Ydda99Z
         MJii7VfXJGq2cQVPrb7E0IJpy4H15qRYHy/9oYezholIoFHHbRl2gLpuzqAONsuKy42P
         Vd2Vl3wdKzqFMcIkRQ5K54OSaabrH6ArOXuncvTWj5cyZy38hAMGhnjAloCTyJf3DLkk
         21LDAEi5OCSNSJSqGROb6o/wpDu5x3B0XsVQ+TBapxlPmPBSG02EaLOZ3wztOXy/VChJ
         a0nyzJoMXDDx/xNnj1XVlqYN9BVkrUYUc817+iF8/vBMbIlbgJs3nTtlRNfIvq/GsQ4X
         Xbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704482524; x=1705087324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ju6RzmrIg7+r2kmHy1lMH3C5ek+CbXRDBgiJF/XUEs=;
        b=ruBE+3tUrh/IO2F4gphB7CWOeIWL9+X0ZDArnMHyr97rIQ2vIy3n6uWgqUIkJBQipZ
         8owWToNvtomoadwHDKRKgzSHCd9xoKkieVq78GDuZGDqfSLdgPo4Aui9s+RRgSqFwjMj
         101lMkzbBtOrfpFK/I2Flea3b0gvqwCxsOZEKVfKzWzC4ym5i7xxzNe01O7PyNR99vKg
         +KalFXKtW3oD6/HcHOflHKhZyISYTL2TMEuOarCih5x1tP0vh5+6115CuhsazJRgmha3
         cbOuzliZBy3wWwBI+MtwnKho3idWzoWrQNDWQZc4ElNi3t+eqfCXSLjSOHdCYYqYRui4
         rHIQ==
X-Gm-Message-State: AOJu0YwIa5N+6V7AanCIcRxLbpDPKrH12EMC0ll4dTBFZRqH/s5zi2RE
	VtvY9nFuKDRDOTW/n7vcKJcvUk/M+roXdPNaXscJgkkTd5Q=
X-Google-Smtp-Source: AGHT+IHCxP63X6TGssxj3/CquQ9xnPrTwbDyUQCKmS1Xca9ur0bhpHNZGssaQG+lksonus1Nt3Ddvg==
X-Received: by 2002:a05:6214:1c4e:b0:67f:6208:b0f with SMTP id if14-20020a0562141c4e00b0067f62080b0fmr2670262qvb.44.1704482524083;
        Fri, 05 Jan 2024 11:22:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id h13-20020a0562140dad00b00680cbea3c84sm823702qvh.84.2024.01.05.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 11:22:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLplb-001Vda-4y;
	Fri, 05 Jan 2024 15:22:03 -0400
Date: Fri, 5 Jan 2024 15:22:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 14/16] iommu/amd: Remove unused flush pasid functions
Message-ID: <20240105192203.GS50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-15-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212085224.6985-15-vasant.hegde@amd.com>

On Tue, Dec 12, 2023 at 08:52:22AM +0000, Vasant Hegde wrote:
> We have removed iommu_v2 module and converted v2 page table to use
> common flush functions. Also we have moved GCR3 table to per device.
> PASID related functions are not used. Hence remove these unused
> functions.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |   3 -
>  drivers/iommu/amd/iommu.c     | 100 ----------------------------------
>  2 files changed, 103 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
