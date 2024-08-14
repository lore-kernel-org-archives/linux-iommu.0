Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32502BB1C
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653120; cv=none; b=a/4niUVqp1CpbDoT0vQk9PeZTB/cUzJX7QFFGtMl2trUf/NZE8AtQET8V17Af1KcSfQ/YDQQ1Io4Bxmiq+yT1ItMZAG93rHczJz8Cw3P16oINwWSTb5sC1J8Z5T5Qx0tAYcc2+Xze+0RUfnbduTAmu3jZfM9NAq01wpGyXRpS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653120; c=relaxed/simple;
	bh=sjmlatt2FALf0Ln7dqSn1SM9Qe1qHhGhBTGOwE8pY3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f84dPPCT6PZOlTqYng7SCU879SJYP1gdNTijsqBi1GkNoDY+c+TZ27NfdQ37TSXOdxPMMHbFn7zOIylou4Qei8URE6jGm/96tU9nY2Rnd3qlSvehLDQao+fDhuZcv5tMZV4RohDUML/6geKkIwm7OLOpDt8JjlOlIM/xQTYoPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbzmBJrE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbzmBJrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723653117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAJHyDS3x0gvP3kndDtDDCyfUKvxnbZEPAFmNsdiAMA=;
	b=IbzmBJrEh4P/NLmf1lrpOhdFNt8aiqj3lZ079U7z9sy86cALnGvms7Wb4bJjoj853ccN99
	RNQI0euOxNp4UZmwm4NyWcZdzkQ+qVRbshXn+e/8T6jlCAUxsOHOaE1H7aat1SsvxRJ5pi
	6v8ddU8Q0kcJWZV6clpoeB60620VxEo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-QCGVNBdDPQOuOcazlTEeJA-1; Wed, 14 Aug 2024 12:31:26 -0400
X-MC-Unique: QCGVNBdDPQOuOcazlTEeJA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a1de8a2adbso46685a.1
        for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 09:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723653086; x=1724257886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAJHyDS3x0gvP3kndDtDDCyfUKvxnbZEPAFmNsdiAMA=;
        b=am1VN/2c0p4j89VdxDaACY5Hv+WssMV4jM9Nm7bndGm5/EjyDnte1WotnimvjQQoap
         ee9FAGf/XXxId1cpAxJv0/yf1Gq1FVjMqWCBSDtPG6drq/NUBmedjDEvkbxVNtiHDbAh
         WdFnarLWP3uMGtyEkR2qKykholAB4SjexDCHy8dFuhfCVp6/3hhDTdnLN5yy9nkWhV6Y
         dinLnHUOPhfouGvkGfvjIbVTu6jjs+bePvJcvgLubkgULwi1sKhHJwft8MEI3thiSq4O
         kasRrJmB30Nb/NbebMvqWCBT11KEu6h6nlZegiuQJDzFga2LPF0suyWI5tYFXz0X0Ois
         bLhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8sj7lXjSorGTSZJfxzcX4b9ByEYce0+ykWMZFR/ykVUbz43eeT9oPlSCOLMGbb+LXbinNmjfExnGxMeFGE2I4420A/Gs=
X-Gm-Message-State: AOJu0YxDtS+k98Te9lWSBfNsa2GrP6kJUSDufGCzJ7ZUFztoufMdC2JI
	DAPXpCKxnebc6d1zrfeuDuWKn4L6jlfLCLcpM0/okG8+t9fy0QGsXe6ol89VqeOqSxOCCqIhqGY
	x9lOF2xCZv3sYRR6bbQucS64y83tV9orn6XDtqQr8MAGjSPe7tAIZ
X-Received: by 2002:a05:620a:4007:b0:7a1:d73f:53d2 with SMTP id af79cd13be357-7a4ee32e764mr396351885a.20.1723653085777;
        Wed, 14 Aug 2024 09:31:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcPEkykVU98AdM6W9o/QSTPGbN3EfEAVyCEDTjPHObiNLTpHiFF4NBrrvxVGHGtrmageAm9w==
X-Received: by 2002:a05:620a:4007:b0:7a1:d73f:53d2 with SMTP id af79cd13be357-7a4ee32e764mr396349385a.20.1723653085500;
        Wed, 14 Aug 2024 09:31:25 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e13605sm447993785a.135.2024.08.14.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:31:25 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:31:23 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iommu/vt-d: Always reserve a domain ID for
 identity setup
Message-ID: <ykrcnvpm2wbiwepykl2wmitaabyp3yngw4dborhnlm65ek3ctl@6wteh2n6zrzk>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240806023941.93454-4-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2024 at 10:39:37AM GMT, Lu Baolu wrote:
> We will use a global static identity domain. Reserve a static domain ID
> for it.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/intel/iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 723ea9f3f501..c019fb3b3e78 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
>  	 * entry for first-level or pass-through translation modes should
>  	 * be programmed with a domain id different from those used for
>  	 * second-level or nested translation. We reserve a domain id for
> -	 * this purpose.
> +	 * this purpose. This domain id is also used for identity domain
> +	 * in legacy mode.
>  	 */
> -	if (sm_supported(iommu))
> -		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
> +	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 

