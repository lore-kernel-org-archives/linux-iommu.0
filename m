Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5947F
	for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 02:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692843885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5dLt/Oc8xf6KejV6RlSnV+4wGdz0oQB0ux63v8EGY4=;
	b=Z/wHZiFN3O18g36pjC2+XBxivSYwXd/lHkLVuDP1qIIVjSQ/PF20I2FSxBxLK2jgES5q1c
	+SwKEzfmLthqdwUO0Hh03mQzhMp0W2r70zheKdR5hUj5QqG3j5sNQOXxfSKbBIfivjxvJg
	Pc7yOVD7c9tcsOCrln2TWxmAz5U2puA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-TVtYSNrwNGuWKA8C455lgg-1; Wed, 23 Aug 2023 22:24:43 -0400
X-MC-Unique: TVtYSNrwNGuWKA8C455lgg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40c10c73650so76655231cf.0
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 19:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692843883; x=1693448683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5dLt/Oc8xf6KejV6RlSnV+4wGdz0oQB0ux63v8EGY4=;
        b=j47+PKvd4jiEuxUq8nagvc+1dqRU1amt1LF8UQAtxs2AZyW8HUCT2IXbEm+c154rbO
         uUVzVRAHg+tieZuzPEjVRe71ngaVaKDfvINtfWJ1j1sxn43keU63KUpgvcS0GPdh7ON1
         L8EHa9K1k+6AsTnBbjw4zvz5Kxyqu+HJYvsc7EGf8vJD4cmiNnNH1IyCTnq+g/KfFbPZ
         oiV5soIFYgRL56RWDDGt9m6SZQTmZPx00QMmf51IBUv0fM9UUT+oM78RMAxeqIpB3B1g
         MNrdNG3douT0u616LITHeJNRHmb6OolG/kq0UsjruwrErcZEEUk+C2wSWiOrU2RkF4Vw
         FoJQ==
X-Gm-Message-State: AOJu0Yzxybf3yOvkbnCgn2VRDXT/oCR2gTLfrtQJJ3Y4hMwW/qv8fBvX
	Tww+rp/1uMDp/AwTSnMdOMEChu9/3yh/BCQhUiLyzUNDNUDQRR26BIGrcz/eePN5rm0szGIcIQT
	bYwuOOsIo2TDgV6w=
X-Received: by 2002:a05:622a:164a:b0:410:a0c3:d925 with SMTP id y10-20020a05622a164a00b00410a0c3d925mr9970456qtj.37.1692843883422;
        Wed, 23 Aug 2023 19:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgJBeobghuz2yHyNVn8Zt5beLTXU75xnckG/+OV40wqVU+he/T+ciCQKl0U+oqvRtWYQ6Wxw==
X-Received: by 2002:a05:622a:164a:b0:410:a0c3:d925 with SMTP id y10-20020a05622a164a00b00410a0c3d925mr9970448qtj.37.1692843883191;
        Wed, 23 Aug 2023 19:24:43 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id c26-20020ac86e9a000000b003f6ac526568sm4055137qtv.39.2023.08.23.19.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 19:24:42 -0700 (PDT)
Date: Wed, 23 Aug 2023 19:24:41 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 14/14] iommu/amd: Initialize iommu_device->max_pasids
Message-ID: <7rhttmaul45aucfkgs4jxlmgcvd5ipnvh46lt2quywrz46op45@etczjddhv56z>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-15-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104227.706997-15-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:42:27AM +0000, Vasant Hegde wrote:
> Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
> introduced a variable struct iommu_device.max_pasids to track max
> PASIDS supported by each IOMMU.
> 
> Let us initialize this field for AMD IOMMU. IOMMU core will use this value
> to set max PASIDs per device (see __iommu_probe_device()).
> 
> Also remove unused global 'amd_iommu_max_pasid' variable.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 3 ---
>  drivers/iommu/amd/init.c            | 9 ++-------
>  2 files changed, 2 insertions(+), 10 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

