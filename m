Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACB16FC2
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 13:29:11 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-649463dc0b8so19663036d6.3
        for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692624550; x=1693229350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBAQrP26vJVOfmsOMcR0qxRLdWikQyilzgRugYDZ3xU=;
        b=EeurDYxjq5aHwqbqbqiUGXl6RMNIBNPIBxBTtsrbUwbaW/Bot01d0AVT1zRfC0G51L
         f486l6xkRKxReut8ZT9bq4mJwQyayaclSWdi8QWliJG/arWi3jbfNrBQM/zT9TbDe2eL
         KODpjbjImIWfTi2Z3m24aoD0rQLY/95gZnfO9W8beZue7OwdSUZlYUTXU5Fir8Bm6xr3
         YJFN/VbRmKJZzGS221yEKLSrvv+wI5gFRAKryg1mrrijenEuZOHy5beCNF07S+sdVzac
         hi9aTyz6Yaj1PviTv5VrUz5j0VOWwFps0VhFPUp9wnUZAfMiRL2lygypyWlSP7vM5/18
         aXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692624550; x=1693229350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBAQrP26vJVOfmsOMcR0qxRLdWikQyilzgRugYDZ3xU=;
        b=Ka1Jp4O/4Ky9PsjaOjjJ0WdQE25pmtSle5+7AOB45C98IkS5z/zAJo7B7T7KKTlYlb
         ZiisuYIOeTIQ4i3dFh+CDTZDlmkz/bAmfS9ST9wkI0UYGTE7592d87CYilxFuVs3smUI
         NZlWlJjowiqnJDlHtno9FkDLGjrpLxFnzLWxgm16VWb8XqHp1tH0WD4Rhl1pGILBhBX/
         3d/S/F1YPraObBRYPtUtjyk1FTdb7fBRkwJ+HhSFsew1ZAn40JVUpo4fH+EifKW8JJY1
         R7TeGFlW9ljT7zIGPe8SxBKTgUKhQw5CnTK8Vpgj4erykR6u3iHh6+dPhYnelYF6vrA5
         HLPg==
X-Gm-Message-State: AOJu0Yy4tuatCOvkgwP6MYPoa9XgN2X8MkafT0BgQUR+i1or5m2YdMgN
	1xPLOdH4M7LeRJfnLBprIZqi4Q==
X-Google-Smtp-Source: AGHT+IHRJi7Q/hhCD1hYuX6lICrpYtp/yd+SR12R7LIMwsFs730+J2oJcdUb85gGBdjJU6vzVV4pgw==
X-Received: by 2002:a05:620a:28d0:b0:767:9d40:a3b7 with SMTP id l16-20020a05620a28d000b007679d40a3b7mr11298533qkp.21.1692624550251;
        Mon, 21 Aug 2023 06:29:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id v11-20020a05620a122b00b0076cc0a6e127sm2459385qkj.116.2023.08.21.06.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 06:29:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qY4xw-00DhuD-VB;
	Mon, 21 Aug 2023 10:29:08 -0300
Date: Mon, 21 Aug 2023 10:29:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 08/14] iommu/amd: Consolidate feature detection and
 reporting logic
Message-ID: <ZONmpPcN7EQIHJET@ziepe.ca>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821104227.706997-9-vasant.hegde@amd.com>

On Mon, Aug 21, 2023 at 10:42:21AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Currently, IOMMU driver assumes capabilities on all IOMMU instances to be
> homogeneous. During early_amd_iommu_init(), the driver probes all IVHD
> blocks and do sanity check to make sure that only features common among all
> IOMMU instances are supported. This is tracked in the global amd_iommu_efr
> and amd_iommu_efr2, which should be used whenever the driver need to check
> hardware capabilities.
> 
> Therefore, introduce check_feature() and check_feature2(), and modify
> the driver to adopt the new helper functions.
> 
> In addition, clean up the print_iommu_info() to avoid reporting redundant
> EFR/EFR2 for each IOMMU instance.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       | 17 ++++--
>  drivers/iommu/amd/amd_iommu_types.h |  4 ++
>  drivers/iommu/amd/init.c            | 89 ++++++++++++-----------------
>  drivers/iommu/amd/iommu.c           |  4 +-
>  4 files changed, 54 insertions(+), 60 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
