Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4835EE5
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XZQaPGgn"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-680a13af19bso9422756d6.0
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 11:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704481406; x=1705086206; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGc5OXGC33E4WMg/knjf5W8E1Ft7smVVfA4Rnv7iOaI=;
        b=XZQaPGgnTqFufelrz4UQCiDWB8PEuIaSXvLGw9rwbxj8stllHAo5nuln9QPIaYzDnm
         v/s+yfBUZQ9Bs+ZPDND4aYat9UmnjdjlE8VQeOl6YCRkz/+wfmmdcRUbt2FnG+kb70e9
         3x6siO8I7+VJeJExaabPoka9NfpjbjzVIUqR4C7dwEj108E8AozIkourfyGygbh4juw6
         pg/Oll1yVePOIX9pRvaK/sQmV+eRIY/IsHRmCtz55ehByXWE2/aTjkHNy1euNnIGz9e0
         xDDJQnNAhq9glnnU7syyeI90PKLlxPVrSpbJWsYUSeNPKl1G8i2qzt1aPLfFHx5k8Q9/
         R5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704481406; x=1705086206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGc5OXGC33E4WMg/knjf5W8E1Ft7smVVfA4Rnv7iOaI=;
        b=U8ipxXhpEr5qpM8y2Zl3DqXsgTY3vabE9XioxxPGLt48Pkdm6UfSE+LVNW+kQwHBDS
         +p3VgLY3FXYrmqX9s2IIwzdliiVz3/47+80ouqPQLRSmrHzP9r7QN01VmQmhTZoqhuuc
         pwkY56tvfT6J0Qg6AAqIoWrDcNWOK6uM8eHqoae8aw8HUz4wV4sNMdpQ4GfnXlZPelVF
         hOCtVUeM8ZL68buZjj4CYIrowwD6mnOpx2/zb84KBBVMpcubKv1RpcKd8GkewiO0ktdW
         cWR+Z5qYI9N6bcPl+u+wylwIS43vHH6EdS+yC/ztKBFavh0HlBVqVj4Af4gKCitQeCJa
         nxxw==
X-Gm-Message-State: AOJu0Ywp7PXUR55bAYUWmuilxb5xfOLr7uVCFu++IemtleL9WK+9cfCl
	bdEaUeYWmDJggAvtXKhVBBaYep1QMoRaqXHNctxAj479wSA=
X-Google-Smtp-Source: AGHT+IET3aTZnTnAkaN2NWfUXQYX1bObFnqgsnEN6KQZKXq2Kq2jfUWs1jB6vp/PCifNDaikW4NszA==
X-Received: by 2002:a05:6214:e41:b0:67f:6296:ad0c with SMTP id o1-20020a0562140e4100b0067f6296ad0cmr2857921qvc.55.1704481406557;
        Fri, 05 Jan 2024 11:03:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id wa16-20020a05620a4d1000b00782873d7202sm795968qkn.61.2024.01.05.11.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 11:03:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLpTZ-001VWk-KD;
	Fri, 05 Jan 2024 15:03:25 -0400
Date: Fri, 5 Jan 2024 15:03:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 08/16] iommu/amd: Add support for device based TLB
 invalidation
Message-ID: <20240105190325.GN50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212085224.6985-9-vasant.hegde@amd.com>

On Tue, Dec 12, 2023 at 08:52:16AM +0000, Vasant Hegde wrote:
> Add support to invalidate TLB/IOTLB for the given device.
> 
> These functions will be used in subsequent patches where we will
> introduce per device GCR3 table and SVA support.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  5 +++++
>  drivers/iommu/amd/iommu.c     | 23 +++++++++++++++++++++++
>  2 files changed, 28 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
