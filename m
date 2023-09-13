Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134DB8F68
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 14:43:57 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6516a8e2167so42454766d6.2
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694616237; x=1695221037; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0cbqkEduU01nLH1Y89HfiElcJwA0c0qIffqWqEitJ0=;
        b=Z2CJiSzOSFHmy2S6QFlw5CROvpNTJzCnrJ+C4Vu8MfxEjwVTVdXHAtjLSyi0mbPV0h
         bI3mJaSrGJ42YuoS6BD1XdPNEmA2vfYOBO0YVYcBfr7HzZwUdWqFQF2DWlddpVuqriuG
         XF0PWaSlteOlr8hqsjQTrfJVmJJd9m2GU0ZZsXsL1gUIIGbSs65L7SjkejOPwUDo+gEi
         CTQLpKx6IxJgLLs94nRG6eRzu91ZTa++pdyWEoCBucTT6ngvDbf94uvh9Zp3lUf0gEFU
         5RicykWjVa/eyDSE2mJVbRoaiWwklaY45twvQIBR9oObwlcKMRekY2YD9tUKe9XU4Dhv
         bKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694616237; x=1695221037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0cbqkEduU01nLH1Y89HfiElcJwA0c0qIffqWqEitJ0=;
        b=r+lE784j8kDX8rckdyZw+4U7UMY3rtdc4srzfgjXRhYX5boXlUHiaFeU0v53JhRwkp
         BQf62l9fQVcnGiQrdL9M9jV9jpgBzh+alpCHL4ztCUneZAsCINI8Rgs/iG/iwdjWJexk
         yuhW+yhd9kbkmHgYXzmWNVppNj34rAfrmodx+DKPnKt5N7gGTKTJmXub7TKB2i7P6MgR
         2ijxrp8ItSL4CxNBMOoon13YXdEyaM1MUC+adbN83FjkOrZzDSbCO4XreRDw3H7ZiIP/
         58Q0OS08WV2Eic1Xj3dHkxNFD1xB7GYrN+eBJFu6taSW96RERUZse/fJ1QsnhNTWhJl4
         AJ9Q==
X-Gm-Message-State: AOJu0YxlkZjecDKVineGU/Djkm1RdMK6k98NjSTeUOTT0wG87ut2dIZX
	nrsOBIgUzwZlLLK4KSkUPKlXWw==
X-Google-Smtp-Source: AGHT+IEr++u7cNiFpU4qQY5b8fkOiQu5VZQfEBcGWMzNhk+sAJVUiRmhjaLbI/jmI6zfn/hMEnstpA==
X-Received: by 2002:a05:6214:458e:b0:641:88e0:9f67 with SMTP id op14-20020a056214458e00b0064188e09f67mr2573788qvb.64.1694616236989;
        Wed, 13 Sep 2023 07:43:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id p4-20020a05620a112400b007675c4b530fsm3947235qkk.28.2023.09.13.07.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 07:43:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qgR5w-003egk-3T;
	Wed, 13 Sep 2023 11:43:56 -0300
Date: Wed, 13 Sep 2023 11:43:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 05/10] iommu/amd: Use protection_domain.flags to check
 page table mode
Message-ID: <ZQHKrKouDOD8FEAt@ziepe.ca>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816174031.634453-6-vasant.hegde@amd.com>

On Wed, Aug 16, 2023 at 05:40:26PM +0000, Vasant Hegde wrote:
> Page table mode (v1, v2 or pt) is per domain property. Recently we have
> enhanced protection_domain.pd_mode to track per domain page table mode.
> Use that variable to check the page table mode instead of global
> 'amd_iommu_pgtable' in {map/unmap}_pages path.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
