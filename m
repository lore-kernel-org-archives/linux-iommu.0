Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654B7F
	for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 00:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692837232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RgCljXEOq+naY59K67Rm0siD/6CCiXZwbXY0am0etbs=;
	b=EZYpgjZw+WE1CxdmqR/pZNQQvN+QboF88c05+GJeERqSINocnW6wvotLiW1g0tRPiz/GuV
	IMZ9zUACY+WgHilJApUcYD/3wq1Qjk5CgbXl6UrZWgGYXK0PuDPf88wUXkKgmUiQZoAk2w
	k/SsZcHgl06Lbl7Ec8N6fW3w9ug8OH0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-8uGQBhVEMTuNIERMoSDA1w-1; Wed, 23 Aug 2023 20:33:51 -0400
X-MC-Unique: 8uGQBhVEMTuNIERMoSDA1w-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76dbe1865c1so161279785a.0
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 17:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692837230; x=1693442030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgCljXEOq+naY59K67Rm0siD/6CCiXZwbXY0am0etbs=;
        b=cnIAWypaSVDahqJFpf9+D5A5NMmHJZRk+TYgu04BGfLPIIOKKOIKK5L9q81aqjzpRr
         L+LYh1XHptJvd7xZyV+GD4YCjV+KlJidAv/qtaIKO9ndbAgHcv48jXhq5TbcG0mL6LNl
         Aiv1Wvb0oHgUc7pcHrCPoJAK1rBPEk7MaU9OI5v5bIYEKX8VRNiEbs5G1V0QpA/+rxo6
         mWkpK0Ki0PR/uaOqPIPiY1AzCGxGA3QSIFs5sgLnDAgrEmfsJXmcAKN3h6KX2afzLYUz
         zhwnM9uSpDE9dFHE296RdNSvTQ0hoKEtaQ2fvZpXWhvu09gQDrb0kwFKdf8abuDzbBRp
         YF+w==
X-Gm-Message-State: AOJu0YxQe/QPvZXTUKGui1EWbN0kM6ZlbG3lLGJtXRq/wDUfNR1061x4
	f8SkmtmmLXQ0HMydx4G0HtHcp+vnntAAphLIWPzfHCA9eTvM7+BabqcEl01GdJsVNYDnGR+uj7T
	6ZcxI7UkTh3bylQw=
X-Received: by 2002:a05:620a:294d:b0:767:2b14:6898 with SMTP id n13-20020a05620a294d00b007672b146898mr18077737qkp.49.1692837230637;
        Wed, 23 Aug 2023 17:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQEZa8vCm12h2XNZtfSYrxizaymX1YCfslU2VMWpQUqOX/x5fzgGRflJ/leOT1Z1VRt/4esg==
X-Received: by 2002:a05:620a:294d:b0:767:2b14:6898 with SMTP id n13-20020a05620a294d00b007672b146898mr18077719qkp.49.1692837230389;
        Wed, 23 Aug 2023 17:33:50 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p6-20020a05620a132600b00767b37256ecsm4276670qkj.107.2023.08.23.17.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 17:33:49 -0700 (PDT)
Date: Wed, 23 Aug 2023 17:33:47 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 11/14] iommu/amd: Introduce iommu_dev_data.ppr
Message-ID: <hkq2qhmdmkq4b3nommy4ilz4hmpw7ul6kkjbckvcrrbqjxbual@hksk5tuinm4c>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104227.706997-12-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:42:24AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> For AMD IOMMU, the PPR feature is needed to support IO page fault (IOPF).
> PPR is enabled per PCI end-point device, and is configured by the PPR bit
> in the IOMMU device table entry (i.e DTE[PPR]).
> 
> Introducing struct iommu_dev_data.ppr track PPR setting for each device.
> 
> Also iommu_dev_data.ppr will be set only when IOMMU supports PPR. Hence
> remove redundant feature support check in set_dte_entry().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

