Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157110940
	for <iommu@lists.linux.dev>; Sun,  5 Nov 2023 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bZ/DjfKD"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-670e7ae4a2eso39981886d6.1
        for <iommu@lists.linux.dev>; Sun, 05 Nov 2023 10:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699207230; x=1699812030; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=99lX1ZTZwhQsPKHlxFI14SLH3VASGZAr41ODVTCoXmA=;
        b=bZ/DjfKD5oOPVrZU4ZfNwrQ+D/qeYl1NwD+xFzhFMVThAT10fqP92aXwrgRT45gnTF
         98doHxmWUWilvXoaQranm5uP+SdAtCVsjIYEgOb2cd8uSa18NDDgJNWdIyX6mDzV/GUF
         u4X8h5dniFoYQ5F5+QhWMS9N9FX+TpSiZoZWBl4pi6zb5XXvNgu8DbFWTwpNEgCnyVzN
         oHmx0m3b7gH/HHXE7Etq1jd79z8PE/8pDAvs6cpz1KnO+iCHg5AkDIang5omTU5sXZLJ
         HX9/weeehbAgkKw8TfC+rwU0DeYIKC4VmwZfDPCColxnE++dF86aYjiuzEKm+kx2AdQq
         0Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699207230; x=1699812030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99lX1ZTZwhQsPKHlxFI14SLH3VASGZAr41ODVTCoXmA=;
        b=WDs/SRzW350wCtjgAokapQCeLdtlTPxMJhyoLEGIGKDZWl/bwdAmhJ1c1+rvoDQ6TC
         REy8lEiPOYomgFoZYhcvH5xHHh7QRYABsRSasQVFx1E+e6hRzYKnz++NB96czmlUHzCG
         cKKeBqFM5XMJVNe6O0VnqV+sf+qSlA9AFKiskLW5K1tePCIe7qmYjpPkA4BIxP6NhS70
         KIZzpmjo4CFwoGcEKJdDNGk3uR2By3iivZfEu/5GBSkhQ+7ZRoGPT8ANI0uVBXVRnZhi
         N/95IYyIJlF4u6IrqcMUGSzFyOzaVzzDpRhM9Z6zBteVm592kA1REnY/7wyPi3ZQ/LoY
         Eo3w==
X-Gm-Message-State: AOJu0Yx5P5Q1g1nmUwlUe82ANzV7IbP+jpJRWEFRnRa1iR8ozjh2VDK3
	lf2hYqvG+tZYpmuBWBAaAKBvBw==
X-Google-Smtp-Source: AGHT+IGPNHP+G79rbSxC+VVqpNRHEygzHVp29PSjRTV1E4T6lgtFsQYHpFGdm6jGWPLMA1GMnIoDqQ==
X-Received: by 2002:a05:6214:1c4e:b0:66d:303a:46bd with SMTP id if14-20020a0562141c4e00b0066d303a46bdmr13238946qvb.13.1699207230488;
        Sun, 05 Nov 2023 10:00:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id f5-20020a0cbec5000000b00641899958efsm2712271qvj.130.2023.11.05.10.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 10:00:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qzhQC-001FZq-M1;
	Sun, 05 Nov 2023 14:00:28 -0400
Date: Sun, 5 Nov 2023 14:00:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 01/13] iommu/amd: Pass struct iommu_dev_data to
 set_dte_entry()
Message-ID: <20231105180028.GE4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013151652.6008-2-vasant.hegde@amd.com>

On Fri, Oct 13, 2023 at 03:16:40PM +0000, Vasant Hegde wrote:
> Pass iommu_dev_data structure instead of passing indivisual variables.
> 
> No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
