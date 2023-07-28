Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96390134BD
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 13:48:32 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bb81809ca8so16390445ad.3
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690552112; x=1691156912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7sHGqng8PVtNT8ly167589U9+Sy7wrCK1wbpgL7DB0=;
        b=FR10/DU3ic/bYtWaJr2uiQ8j3bkDzFUDkY7uegDPeJzrxzWk2d57/cpO9lK65o4Blr
         QBcLVsCS7iYIn6F8V/u0LoJVeb4P7SBJ6Lf2uP4H5UojC73InnT8wGKPMFACropR57/u
         qQ/1Ox8jWFT8w44wrp05SSqxPxhNmkvPRryWvhjKSWaD77P2bZmQXKqH6lQiaHIUavk4
         loPQDHO763tyqdAz0oCB/UKESfc/ugf2h2jTC5Hi459N56KZdEJFsOWcU8L3WzlOKUQv
         HsAIZTin0i2UVUyRZYCejiNsGYHK2shrD/y4cLJSa0dboaJ88GKUoLF/CDhFXke1Kbvf
         pkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690552112; x=1691156912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7sHGqng8PVtNT8ly167589U9+Sy7wrCK1wbpgL7DB0=;
        b=mFU+4r6Dn4YRK5JTpWg/xU0XZeJL63RYeFOWYACKu2Ou2tZY6OVTTM8hgItKAFEwgv
         Juf+D7wtICOuB2USIrRQUhoSIPmBOrddXlkg3y1b3yDPsXENjdxykHRlIlco6c7uUd6p
         0HvYU4EONNDQRr8YrDB7MmAjMHCyqNrLRKU5W67jqX3FdmDJOSf95fn+tuS5GgBkzczF
         ItwHmP5g0Dn3QqcwMVWxvOPaxALjSS4txdJIokFIW08zuLpYt+qKBGQ/4VYeyPlk3rzq
         fvKl0A88jWjKoQu4iUxlXCKuAD9i2KcCiwIKs6gSV/FN8JOLQC9L1Dw4H6sgwk1jVq4M
         e7cw==
X-Gm-Message-State: ABy/qLaEGkcWdOYeBPJg69ML+uChmrR85TOJLqyx4B5+bELAF2sy0sDc
	jrdQFRoXk7MHvspQ3wxP2HFzow==
X-Google-Smtp-Source: APBJJlFzXpL8LMS6uKXpuCQUck4D4tnYh053c6lc4SKE92E3KYAiYbKUhy/a0LNnc1/E+bid5EKxyg==
X-Received: by 2002:a17:902:b590:b0:1bb:7b6c:983a with SMTP id a16-20020a170902b59000b001bb7b6c983amr1560398pls.59.1690552111716;
        Fri, 28 Jul 2023 06:48:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001b9f032bb3dsm3601606plp.3.2023.07.28.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:48:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPNpV-001at7-Fl;
	Fri, 28 Jul 2023 10:48:29 -0300
Date: Fri, 28 Jul 2023 10:48:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 02/16] iommu/amd: Consolidate timeout pre-define to
 amd_iommu_type.h
Message-ID: <ZMPHLQwPpdDMIW3q@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-3-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:35:55AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> To allow inclusion in other files in subsequent patches.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  4 ++++
>  drivers/iommu/amd/init.c            | 10 ++++------
>  drivers/iommu/amd/iommu.c           |  2 --
>  3 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
