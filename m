Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF715A4
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 03:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683259128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tH+520r474W0EaWreOQEgyySbc0VeetwS26CDQJ8oaI=;
	b=KM4DQPlDJO8VNTAY/CdBTouQs1Kl4uoCa4W36WOsNeqWoLJ1TdLhvIwRThIfLTkuYkyFXm
	GtjA4pNP7w3AFPuaa0cdmidgFRahDJkOJ5DTL36veqEkHxF+qpj5wFiioqfprqc45yV60l
	YNDhQPzh/7JpKYVjWpfYE6PzZQOH0Lk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-rMasm0rtMki-oLitRpu_Pw-1; Thu, 04 May 2023 23:58:47 -0400
X-MC-Unique: rMasm0rtMki-oLitRpu_Pw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ef5e75e89cso6549501cf.2
        for <iommu@lists.linux.dev>; Thu, 04 May 2023 20:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683259127; x=1685851127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tH+520r474W0EaWreOQEgyySbc0VeetwS26CDQJ8oaI=;
        b=BkKHA+7ZhAfNr3DyodfaGW9zuLYhKCVYCpMFodVSsUAJTK10pyvY1cfKGf06jl2OvV
         YOOXl1r3+ylkf2eBMjpxziZBuRJcwQx91MfUs97r0KUs+eM2sUsqtv8W+ha6JfBuLINP
         znHo2b33FrWQ2BCdHZ66S5465PuPVRuyUnwVt6qu1CpF78MLWgpJc01D63QOZToNsJY2
         rYJ2fCdX6egjeBeE1UelqeWPhD6FEDHH5OC7u4alQHrLHRymIsLtkh/MJHz+7h30g/ua
         IO/oT7WvYQ8WN7kFqn02rXDfGNqA7M2R9hdCz/DOF/AzyxBd8hT7zqA20ZhlKrxNl6ih
         DzQg==
X-Gm-Message-State: AC+VfDyNOcbWiF6uMXPwjwKMWfVAYUzLlb9tXxzZtconB0lcqzqv7iiS
	zF4ojA8qWjYW50yOgG0nEfkLD3nMCTnsadB507pa6k8xqEiqai68Is0hnAQo+T9gGKSqOZ6GZm+
	KRdz0bOPPYzyyQVk=
X-Received: by 2002:ac8:7dd0:0:b0:3d9:525d:f024 with SMTP id c16-20020ac87dd0000000b003d9525df024mr615922qte.28.1683259127006;
        Thu, 04 May 2023 20:58:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HljWG5lKdnlv7HrzHEGfdqrCMyIpIUtW0Wyv9AWvnlrQpWhfgZvYO/v6iA+J6Gr157rfTCA==
X-Received: by 2002:ac8:7dd0:0:b0:3d9:525d:f024 with SMTP id c16-20020ac87dd0000000b003d9525df024mr615910qte.28.1683259126781;
        Thu, 04 May 2023 20:58:46 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id ca21-20020a05622a1f1500b003e68dfab0b4sm246722qtb.95.2023.05.04.20.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 20:58:46 -0700 (PDT)
Date: Thu, 4 May 2023 20:58:44 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, jgg@nvidia.com, will@kernel.org, 
	schnelle@linux.ibm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Make flush queues a proper capability
Message-ID: <nbkz5p4gvzzc5763j6iclsagjkf7jfmxlkcl5bmzfavigqu7wr@ey3ih27y2n2e>
References: <cover.1683233867.git.robin.murphy@arm.com>
 <ol6xsnchb5od2br6qor6mdm3b6jedtwlbivfvx46dwx5bwm56w@ub47yn62g4ch>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ol6xsnchb5od2br6qor6mdm3b6jedtwlbivfvx46dwx5bwm56w@ub47yn62g4ch>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 04, 2023 at 07:54:44PM -0700, Jerry Snitselaar wrote:
> On Thu, May 04, 2023 at 10:10:54PM +0100, Robin Murphy wrote:
> > Hi all,
> > 
> > Since it came up in discussion on the default domain series, it seemed
> > pertinent to dig this idea up, whcih I started a while ago, and finish
> > it off.
> > 
> > Cheers,
> > Robin.
> > 
> > 
> > Robin Murphy (2):
> >   iommu: Add a capability for flush queue support
> >   iommu: Use flush queue capability
> > 
> >  drivers/iommu/amd/iommu.c                   | 2 ++
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 4 ++--
> >  drivers/iommu/dma-iommu.c                   | 3 ++-
> >  drivers/iommu/intel/iommu.c                 | 2 +-
> >  drivers/iommu/iommu.c                       | 3 ++-
> >  include/linux/iommu.h                       | 6 ++++++
> >  7 files changed, 16 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.39.2.101.g768bb238c484.dirty
> > 
> 

Tested-by: Jerry Snitselaar <jsnitsel@redhat.com> # amd, intel, smmu-v3

> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 

