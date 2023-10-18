Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B215AFB
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mway+Tzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697672455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mx4Dk0ISS6YatUHGy78AukoYqcfDmzrebgNaNGWUWvw=;
	b=Mway+TzvuOr1Y5/T5eIqBOTOqTGokK7CAv2XRi0opeMLUau0WnaPh2bwnZUDbJ0SWvJuUK
	L5mQRUQVvTB7wdGP6fgpVgAyoG9Gr+pVfO9SYmocEzswHB2u0H2iFdtRrDuRk34X7olbZw
	DcuITGDCtZdYnsVoiVmny65E4YGfr9I=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-X2CqstriNGqkDPVezVG-hw-1; Wed, 18 Oct 2023 19:40:44 -0400
X-MC-Unique: X2CqstriNGqkDPVezVG-hw-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-49a55457534so2432886e0c.0
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 16:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697672444; x=1698277244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx4Dk0ISS6YatUHGy78AukoYqcfDmzrebgNaNGWUWvw=;
        b=ghnXmslPlpkLkDr+xbIUnQ5RDNnTKuKgf4bAVeViLQRcLYJXRhEvd0tqhKwmFfseMv
         YQAUDdi2Wh5UTrT1XLEsYizA7yLlNChM34CCSkBh0omi97UN2xnFfyOxUK/Wry7uCWkn
         SivV0fGRgsqvmv8+Gh/M7Izyh/If6b6FSEn9EIk2xq98dpgoRBvqkxSEZv8vhSf+jdoi
         vouO10YyHYO9jc0siijTG1LA5RAgqCAX0bwQxaiI4O0AapZDph9V37Nf/qYDv2CAFHBH
         wSeb0+k15TTmvu8fR/g00GszY/Vjpn1MsD1syLy22564zz9tctnN47S7ltrItYvmsE3i
         RtEQ==
X-Gm-Message-State: AOJu0YxtdikbGL1sjUSWPQRROkCfxKweoF6m7IjtOO2EaDKPtAYaCdRl
	pIOP0hnMDWBxoBpxPfQzBhebfn9MVWrNEMHl2cuCAaYFwlLOzQozNcivcbq14qU4E8pywAtuRy8
	x9+dczfLtXNpdICc=
X-Received: by 2002:a1f:a647:0:b0:49d:9916:5740 with SMTP id p68-20020a1fa647000000b0049d99165740mr492342vke.9.1697672444092;
        Wed, 18 Oct 2023 16:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtVCzczZg3feC3qrpPkD5F8AncaRNB0ei1DknIl2GHSrsaIA3JO0sFERrgMYAXmOWYnrMV1w==
X-Received: by 2002:a1f:a647:0:b0:49d:9916:5740 with SMTP id p68-20020a1fa647000000b0049d99165740mr492329vke.9.1697672443750;
        Wed, 18 Oct 2023 16:40:43 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id k7-20020ac80747000000b00418142e802bsm325108qth.6.2023.10.18.16.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:40:43 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:40:42 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] iommu: Clean up open-coded ownership checks
Message-ID: <2nsto6kbvxzuoods66reiyiw72sqgwwhgnhtoop567l3kopaer@afoq5xd5obvm>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <0d68867cec0fb90578d50cc145f7f9a180407f20.1697047261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0d68867cec0fb90578d50cc145f7f9a180407f20.1697047261.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 11, 2023 at 07:14:54PM +0100, Robin Murphy wrote:
> Some drivers already implement their own defence against the possibility
> of being given someone else's device. Since this is now taken care of by
> the core code (and via a slightly different path from the original
> fwspec-based idea), let's clean them up.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  9 +--------
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 16 +++-------------
>  drivers/iommu/mtk_iommu.c                   |  7 +------
>  drivers/iommu/mtk_iommu_v1.c                |  3 ---
>  drivers/iommu/sprd-iommu.c                  |  8 +-------
>  drivers/iommu/virtio-iommu.c                |  3 ---
>  7 files changed, 6 insertions(+), 43 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

