Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711E23BF
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692830163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yq3/NSk6tGd/+FXZvVxtaEaQfcV7mnWsa5HA0Y8PWrg=;
	b=SgC/VPsl+bhojw7RwZL3Kbl+j6Qujkq+jgBTVqeLGX1YAIgGP+D5R04JkDzqfGa0QikjT3
	v4Y7c9MdQBCkQryM1dwtwa2NPdBcDNSEd1otfMruF8QjkVYJjIaOxydFwkIYIDNB+2wHb9
	mA5IVqkZyxlUuMH+xd+zy5MmVlVr86U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-NDqqB2x2NdSigIFrTxfk_g-1; Wed, 23 Aug 2023 18:36:01 -0400
X-MC-Unique: NDqqB2x2NdSigIFrTxfk_g-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76d86b5e2f1so872663085a.2
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 15:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830161; x=1693434961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yq3/NSk6tGd/+FXZvVxtaEaQfcV7mnWsa5HA0Y8PWrg=;
        b=ieZBz64W2T728RZe1GdbxJI4NcuZQ4HxJevU477F7/9obCImWjdzQQb2MQ/LsZXIud
         3Etj7kiW0hVqxMUON0Fb3d6ZjaHjyu9Ku8WmlSVIHdz8ck+0/kW/SsvuCVUXuzTOwV/8
         0wE5v5LJ2MxnFo/0htb+UlxWjv5MAugc3VbpBi0z/kCBVIwTUCpvZiyuaHpJh7NOyOxB
         iCyQeglbWQa97NE7umj5rYffsPGstG0Bi1GapdjQm/yGmon6UtTEoAQGlLFlsWhltDCI
         stYfAgOUCcgsGXSKJ3GXl0yR5qtwEeqGNiHSq/Ev19EdJWawSJkGsB7krfvqAd5unWcd
         0EDw==
X-Gm-Message-State: AOJu0YwgnQxpTzUjujSnSerAp3PIUgRY06zCNpwB7Xb2NHkb9d70W8GF
	2DCOzqEqoOdi1NdhZ571HPQk4NDlh3dGHZ4L/rqo4yILZhD+1mR6kK/fDMBvH3/EhwOdmLCtTmQ
	8cttx0zjDfrKKvdY=
X-Received: by 2002:a05:620a:24ca:b0:76d:7fe4:4a with SMTP id m10-20020a05620a24ca00b0076d7fe4004amr17167782qkn.16.1692830161192;
        Wed, 23 Aug 2023 15:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdij5qIZZotSBEtN5O4wf/v7A7I5zUgO5YrWRB9il9L8OAz9dmfPW/cfEO3XHWkpjpDTTJ1Q==
X-Received: by 2002:a05:620a:24ca:b0:76d:7fe4:4a with SMTP id m10-20020a05620a24ca00b0076d7fe4004amr17167773qkn.16.1692830160960;
        Wed, 23 Aug 2023 15:36:00 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id h15-20020a05620a13ef00b0076db1caab16sm1652015qkl.22.2023.08.23.15.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 15:36:00 -0700 (PDT)
Date: Wed, 23 Aug 2023 15:35:58 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 09/14] iommu/amd: Modify logic for checking GT and PPR
 features
Message-ID: <3ilo52s3c2cx7ufyvfpmdnsj7qhaa7venbvqe7cgqmptmihkse@fyed25cv6sxy>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-10-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104227.706997-10-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:42:22AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> In order to support v2 page table, IOMMU driver need to check if the
> hardware can support Guest Translation (GT) and Peripheral Page Request
> (PPR) features. Currently, IOMMU driver uses global (amd_iommu_v2_present)
> and per-iommu (struct amd_iommu.is_iommu_v2) variables to track the
> features. There variables area redundant since we could simply just check
> the global EFR mask.
> 
> Therefore, replace it with a helper function with appropriate name.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

