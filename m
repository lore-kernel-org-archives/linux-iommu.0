Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728712B7E
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 13:17:35 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-63d35aa5419so11204016d6.1
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690550254; x=1691155054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KfRXKD186KOplfTb2VVNo0awoqvDCXi/WN+PCEaK54E=;
        b=PZkyKcKKm52BQyo/PUGUk3JD/qJjgUgsAcoEtKyoV1sMDtklZMUhRzHlAJe2otzfxi
         6NKI82utY2w6QBBxDknaXXeolilZY1oLRlkvibb02vyQc6RD0OKvupKfod90oid3tedg
         omun6JGG7IR2uEbA4CBmfDgvuVb50LjmWitGcx23FJ3Zqf7YFFSgSeUdGogt14aqPPd4
         f+zOm2LlEujBB1k5mMlvuNswAGF1776OT7vy9+t6SNuI9Qff4uPGXf03MFWUGRRFME29
         cMt46597lLCObmQT+BIrgk8J6Q7ZM2i8GIO/dJPss/+vpvQx0smGgUxdR6pTk50KaJfE
         HboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690550254; x=1691155054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfRXKD186KOplfTb2VVNo0awoqvDCXi/WN+PCEaK54E=;
        b=fPnWcBxjX4GOelVskOZ9FfrEUuukhar2wxj33gKBu4Ah92razASDpaFsLZCezd63cT
         3KPbz1Lul166B3vU9NlMyjX9JLa3m0HH5AQOg9ZemgrOYOU7kjWJktaBn5M64zmS8UVP
         POViu9JvMgfIL0leZVUrFrSGPzoAGNNz0K8pIaqYaZk10aBnbs54ignnU+L/b/+JLm/z
         FdMj6nUMrYMAe4C+TFF0NY3RP6N2l9LIgqPMM5FM1dBg/dNzirxZK4BZt7Pn0V61Tfxr
         Lku+XO+xAK8l+nvWV0CxmOgBv0T/26lZFOriOlungSFvG19OxRNAYwhTLR3xHVdCpor5
         XfRA==
X-Gm-Message-State: ABy/qLYAV2ZGHSDFkFLx+6dHDXTlF1wvKClBuRCmupKFYF/hNe4200rn
	sZmsMN48JvctGEaC2K0+reW32Q==
X-Google-Smtp-Source: APBJJlHV8+FcA0WBcUFnjEpo+KYsmaTLQCWdT25E47HkLygfmJ2a565H/2LORAN/iZB2plUgstRlag==
X-Received: by 2002:a05:6214:4011:b0:632:3633:7012 with SMTP id kd17-20020a056214401100b0063236337012mr2764302qvb.8.1690550254081;
        Fri, 28 Jul 2023 06:17:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g2-20020a0ce4c2000000b006301d31e315sm1228471qvm.10.2023.07.28.06.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:17:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPNLY-001agX-Ly;
	Fri, 28 Jul 2023 10:17:32 -0300
Date: Fri, 28 Jul 2023 10:17:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 01/16] iommu/amd: Remove unused amd_io_pgtable.pt_root
 variable
Message-ID: <ZMO/7Mmh8MqXjYUS@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-2-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:35:54AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> It has been no longer used since the commit 6eedb59c18a3 ("iommu/amd:
> Remove amd_iommu_domain_get_pgtable").
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       | 1 -
>  drivers/iommu/amd/amd_iommu_types.h | 1 -
>  2 files changed, 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
