Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67114F117
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009666; cv=none; b=aj0H39sBxkXSDbiBBO119ODduPWsAg1kY98ZW7HZWVXgSaP5QoGRaa+RvZW7zPh24GrM4lfCd0OK7aoSeACK0DGaDK8BspWFwGm7CIQNHbBO2PoKNjnQ2xC/j7puKfEGRqNZNsuA3W9jG/WiONZxD6cFHsvetXukNTrQuphzOU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009666; c=relaxed/simple;
	bh=IfTx3vgL6pSLq4angIlM+l/b4KtlX0k2j+qUWgjDCxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=py+peHZ1IMViTI0ZmJKEiWLA0JvU8dGP1FHuOSOwITN8Q2acPniB/xMC4nNnwleenC5CD1A2+xfvMmxnInFvT0KD1PnKYKsTZ5jLPt0aM769WuHcZSd5FJL+t+db5JyunUXpR9MshHZJyZnAZQrQ759Rlh5kdBJDXGV/gcfeeVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=a7QDR9Y3; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a7QDR9Y3"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4603f47b2c8so58179031cf.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729009662; x=1729614462; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nYiEdfLljkLAihKzr7zxxvEFSnvCT9Qo8ze1Fo1KOo=;
        b=a7QDR9Y3NqHwStCoSs7CYBAKihEg0emtaJcuORRITZtXXnwUxrvuzjJrMD4Mo2bEgn
         qbi7WbrYOOdXrlrQDgLDPL/rKgwhlUOnwHA6negLYuJJNtd+V5oQ9NjkD1lYCTIdFfsS
         Z1HciAYeUrPAUo59PNqeGyWnfoqPUciRKp4tcdWLzH6Nwodn+NgkGXlE1LFabfM5stQf
         qvvvp0samTycobiAythRINtn0xpOo9daQ0F+RvKXosAUrNagkSwi1fSf6m8xAAVolTjt
         6AUY6myyiqsSJsLUHIRHI1nPLOV6DTjb14rUFO/GXwMGi5cHh9ckqRx0j1iVcYIm2ziD
         8m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009662; x=1729614462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nYiEdfLljkLAihKzr7zxxvEFSnvCT9Qo8ze1Fo1KOo=;
        b=a3t2hfWugXdmOgwJJRuLPrbokIFXzmKpoEN3fchMjF5CEnwqDWKzKfoQJK/2qkqlDL
         LFX0ccpDeuLOqnW6uCZLDdaTjqllQJ+To1z28ePuMBtJgaL4pbFgntQ5LedXtLG7hxhj
         2hGr7JJjPbyCnbZn1Zxr2+VxNbQzoSgfikPaapfK3mfcUnaMwySe2hIj31chJlK8HLY9
         B3wXl3AkNYP1pb7I/h019sQoVpp1VmLWFtxggIXvA3lU9qPJAgO56GNELboxpADohDnY
         WbXYSCXJnYvlCGoBkUKFoX/A9vnH40RZcwTxsVw3YLldzam/Tz2XtJlpe/loOat6IRpK
         26dw==
X-Forwarded-Encrypted: i=1; AJvYcCUskJa7wXt2Qcj3sQgsPuW5TVuoLjqptSzWXi9mPPfO6wPvZfKsOnM/1oq4fmdV/VEEXt7bNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjJ1MfCX8xwIEHxi3r944+bp5u/UGz1yLOaEUZXtm1ZiyFUGRv
	ZebrlesZLXxRauCvKXSnDw2uEji15D+12RZYLQhEa396fD3FdUhyybEDZCQRnFE=
X-Google-Smtp-Source: AGHT+IFEnSXFncC2+x06UZbubyc95m0LQJm7m6gZHQJF2kRCO9sJXD/FqqaGm4BFNB4Arf3LyOhHgw==
X-Received: by 2002:a05:622a:5408:b0:454:e669:c8dd with SMTP id d75a77b69052e-4608a4f4959mr12876331cf.20.1729009662214;
        Tue, 15 Oct 2024 09:27:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b394a7csm8001401cf.92.2024.10.15.09.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:27:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0kOa-00Dxtf-Ry;
	Tue, 15 Oct 2024 13:27:40 -0300
Date: Tue, 15 Oct 2024 13:27:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, alex.williamson@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: Re: [PATCH v2 5/6] iommu/arm-smmu-v3: Make smmuv3 set_dev_pasid() op
 support replace
Message-ID: <20241015162740.GP1825128@ziepe.ca>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-6-yi.l.liu@intel.com>
 <20241015084322.GA19079@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015084322.GA19079@willie-the-truck>

On Tue, Oct 15, 2024 at 09:43:24AM +0100, Will Deacon wrote:
> > @@ -2890,6 +2891,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
> >  		 * already attached, no need to set old_domain.
> >  		 */
> >  		.ssid = pasid,
> > +		.old_domain = old,
> 
> nit: The existing comment says "no need to set old_domain" and now you're
> doing exactly that! Please can you update the commentary (probably just
> remove the comment entirely)?

+1

Jason
