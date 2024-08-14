Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD11B8EBF
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651999; cv=none; b=QplGbf3vgdnvVKmZbFBAg95tbF5D8H5IhL8tkQtLboBHOajCvJ/10s9HUoNe69YKm8K+LkOFVp3rwl/fKmtHBZHo1vAvNT8T8o5xGqCTsD1Sj60Gl/iSrYtAb16yDIgQSXW9g49e/qmKKg9C32D2O95juhF3Mjz+VzEooiLatJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651999; c=relaxed/simple;
	bh=d44m1S8mwmHexTAfN1Gv9j6XmNoZXCXnN2acC6FhLOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ds/G4PmnoEx6TpNpJhQmscCdPEt25xz6xKK1NSa5X97/UzDFN8mXR/2E1SDCKz+bJCSvGrVHuTobaiW5k8yTeydxXsYrKLCVA+BDFE9wTtuNApMgThDLUnC4INivmv7Vt5z5nH01Y4Oe367NDTIT0ZPBqJ1nkz36jH9JHbkHjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZbY0Jv/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZbY0Jv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723651995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n8l/e+/hw38ZTc3H1Sjqvh3fnMtNpnbvEnIVnHb6Kn8=;
	b=JZbY0Jv/r8t9/ftRKXV3mSflLjkufpwrxF5dHBOqdyhfXGoP4hRIQegQQn7g0lE0yhgoqB
	C1iQKAQIepEZ1aTF5ryWlvnr4PSe+xUw9hYwUik35EvVyeWX2Jsv9dr1TQLsm9Vi84ehhM
	4KWOkri1W1MQeyCOF/SeTDf3LgZ18Q4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Tvu1MZ9qPdGhvL6k-mFLWA-1; Wed, 14 Aug 2024 12:13:14 -0400
X-MC-Unique: Tvu1MZ9qPdGhvL6k-mFLWA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-709664a6285so5833439a34.3
        for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 09:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651993; x=1724256793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8l/e+/hw38ZTc3H1Sjqvh3fnMtNpnbvEnIVnHb6Kn8=;
        b=BPxlqnUnaVhvEjoGsSWVhptgeFdkysGA0/vTvjoBTLZr3o5iLPLPUDhCeWqMfvIXJO
         k0bqpYlABSNpD/efuImckqb4dPpaRqczRbh2Tx8U9TV0hYnF9rWw6SZQQbVvP9sxHbDe
         Bg4zuSoYf+pDiGWQFddeJ54zTHrPqFpANOuTSsugTWQIQ3rJs0EcnSzea14DtB2auqjf
         BTokAvkDnUjwvMvISMskXli4hRN/v0IOlJWPyJ2eZdmUNToVTNc9ai5pCd52h8Ev5iM9
         Zs8ULl3owlUoLeEGenXgIaHRu6ximqD3/brGP/smhS1u4aBpETp6b0iYLLPYuCwr8LyV
         r8Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXswhu2sQIg6rch2BfoV63eUXn3mCyicB8VJyI9PrJ4+92wn0vd53/U1E0Hy7HK7nWAlt7WxGZdkEqMv/I6ZzKSjKnb69o=
X-Gm-Message-State: AOJu0YzCX0NBnR3s1S5huXClF8RW3SFnm+veK57fAj2TK/tPOX4fjSDQ
	Mbe0K7LZS9aUI1j7Lbxcav+LgmN4Jr1mW1T63O+IsWoSNtAn/MV/fiSQrV12EkOifBQN8qUGK30
	JO0LM2fqJ/G9i5jj0G1bouFbJTf6p54hjK11k77vzAKinF2NZgOl5xh8n3WQF
X-Received: by 2002:a05:6830:210d:b0:709:450b:a3aa with SMTP id 46e09a7af769-70c9d9d54bemr3985230a34.21.1723651992910;
        Wed, 14 Aug 2024 09:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET4fUVUg5Ku8gd0F4+hHNEqb77dViMPB9mv2/u4HKBnP/huGni2r7nkTEqdDY6xTD0gAHK3w==
X-Received: by 2002:a05:6830:210d:b0:709:450b:a3aa with SMTP id 46e09a7af769-70c9d9d54bemr3985203a34.21.1723651992516;
        Wed, 14 Aug 2024 09:13:12 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c5ee71sm45692186d6.18.2024.08.14.09.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:13:12 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:13:10 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] iommu/vt-d: Require DMA domain if hardware not
 support passthrough
Message-ID: <6t4vbpxwibd2egshbgro3mixmnfdhioy57fb46bpc35hjhzdoi@l2ck53gfq63z>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240806023941.93454-2-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2024 at 10:39:35AM GMT, Lu Baolu wrote:
> The iommu core defines the def_domain_type callback to query the iommu
> driver about hardware capability and quirks. The iommu driver should
> declare IOMMU_DOMAIN_DMA requirement for hardware lacking pass-through
> capability.
> 
> Earlier VT-d hardware implementations did not support pass-through
> translation mode. The iommu driver relied on a paging domain with all
> physical system memory addresses identically mapped to the same IOVA
> to simulate pass-through translation before the def_domain_type was
> introduced and it has been kept until now. It's time to adjust it now
> to make the Intel iommu driver follow the def_domain_type semantics.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/intel/iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9ff8b83c19a3..90ad794a1be7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2149,6 +2149,16 @@ static bool device_rmrr_is_relaxable(struct device *dev)
>  
>  static int device_def_domain_type(struct device *dev)
>  {
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +
> +	/*
> +	 * Hardware does not support the passthrough translation mode.
> +	 * Always use a dynamaic mapping domain.
> +	 */
> +	if (!ecap_pass_through(iommu->ecap))
> +		return IOMMU_DOMAIN_DMA;
> +
>  	if (dev_is_pci(dev)) {
>  		struct pci_dev *pdev = to_pci_dev(dev);
>  
> -- 
> 2.34.1
> 

