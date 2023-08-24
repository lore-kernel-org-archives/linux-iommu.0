Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8CE7E
	for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 22:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692917129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/isAHXc58a0i3SzdKAVUt3SbMycL7ICVzy3Ln518nso=;
	b=c2q8AhJMRW4M8VFsNv5gMU+UOHLTICsG51pjsKCLpyb24fNolnf7KUtUdDqikExapxPxBR
	ws2V4EtKPb8hu6oJQtSNMd0z14JkTr/qy07Ff5PJuuzQxRySf5rZfZOedYxt3IUomOPBa8
	ycU1eL9XQFqt3hd4iIbkdRJvhdSjGWw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-BIDtidVbM6GUvsRf92SErw-1; Thu, 24 Aug 2023 18:45:27 -0400
X-MC-Unique: BIDtidVbM6GUvsRf92SErw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-64f3fb8b296so4422846d6.3
        for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 15:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692917127; x=1693521927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/isAHXc58a0i3SzdKAVUt3SbMycL7ICVzy3Ln518nso=;
        b=YCDYfGjnkFEDBBoBotKFMI5W6aLJ7atOiLJHJ2f/Dttd5KVd4I2BJgRaUMWFAY7P1x
         1HKqcil1FF/IoRMfO93tDBtPJz/+I/sIx9yVdiYEjtpqEkWza4x1LgdIRMvZpcRJI6sY
         tAECD55zrCBm5EJ5mDquR0cxQeDCH/mfFo/+GrlmO4VKCRxLoGId+7MBQe12MolYgpe6
         4k/s5SRZ2B5kS9PQ2WD+56cvvYUPIf0yIvjdc5IPA9APgd6H26+iMlTQhMZgjNV60255
         Prs4KOE1/49tJYz+zjHwlU5X22P7nA4ytktBF8UVkoUNLDxNtkjKgMbD40Gs+RV3eOmi
         J3Ag==
X-Gm-Message-State: AOJu0YzJhWLVKoJSlZU0EJlqm+sPi7efHTdz1rP8w9IwRi7U8/FvUVHv
	Xy99rfzCzdjmeB4FS/6rAvDU+i1EOFr9MDgT5ZZV495dh4dpXB7/nLCfOYu8x8PWRq3D6caqEm5
	znYIUD/6j5EMkptw=
X-Received: by 2002:a0c:b345:0:b0:64f:3bee:93a6 with SMTP id a5-20020a0cb345000000b0064f3bee93a6mr12499126qvf.42.1692917127280;
        Thu, 24 Aug 2023 15:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWXahZGAODep29pDU9NV5NBU1N4bZZHi2n6HZ5DbzmvwRuzAWcnKGvnMOTVdL9je5XGmYpqA==
X-Received: by 2002:a0c:b345:0:b0:64f:3bee:93a6 with SMTP id a5-20020a0cb345000000b0064f3bee93a6mr12499112qvf.42.1692917127041;
        Thu, 24 Aug 2023 15:45:27 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id e4-20020a0ce3c4000000b006262de12a8csm113914qvl.65.2023.08.24.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 15:45:26 -0700 (PDT)
Date: Thu, 24 Aug 2023 15:45:25 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Alex Deucher <alexander.deucher@amd.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2 1/5] iommu/amd: Remove iommu_v2 module
Message-ID: <wp7gpzbxrzvxhygq3527cxwjb7c3jhqb5n64g7vcweey5rmifl@eoerdqtrvnsn>
References: <20230821104956.707235-1-vasant.hegde@amd.com>
 <20230821104956.707235-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104956.707235-2-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:49:52AM +0000, Vasant Hegde wrote:
> AMD GPU driver which was the only in-kernel user of iommu_v2 module is
> removing dependency on iommu_v2 module [1].
> 
> [1] https://patchwork.freedesktop.org/series/122124/
> 
> Also we are working on adding SVA support in AMD IOMMU driver. Device
> drivers are expected to use common SVA framework to enable device
> PASID/PRI features.
> 
> Removing iommu_v2 module and then adding SVA simplifies the development.
> Hence remove iommu_v2 module.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

