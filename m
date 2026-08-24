Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB023F2118
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566056; cv=none; b=BZtHQJXhxggVoyGRJY9uM9N6LoZrJAw0TMDKsZkGeAMZ8tPsfV4zwijp3ghf9cxVGAC6V1c5HmQUn/7zvjYOdKuout6v0hmJ+38S5wDBTnkXlJsjvbrH4aQUFTLgRjdb5WxZ5BIPtgDH9kaFvsC52rG7oOVABOod1XzE4SW/gC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566056; c=relaxed/simple;
	bh=tiMiPtTKlfHRwgEibcz8vFhTykbZbs0vaWu8IsiI8W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui8/TKlOqpt40CseDxc/8dlMAIVUwMaiaS7gkJ8LcnzjP5OcS/yQJgWW8PudZ/RInU1CFfbcwnIEHecYTemra0DC2W+gfMPTHGUle1g7El0mIZ7PI40AB20JccCC0Kex58u6+Wqsx5nC16lx5Ji3imtCpUu8TaYE9ZzYK/cIaso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QnTg6ii0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnTg6ii0"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdf36f63dso137905ad.0
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787566054; x=1788170854; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1zbz0UezBRokFCxPAADPzNNnQ2q3uFS8kgDI9OKirCA=;
        b=QnTg6ii06PP17ZftT++0PdcOcMcA78t1Il4g8VM9cuuAX2CM5eavJJlJEIQYXpHvRf
         b5oDUL/j11qRhY+62xK0y9tujliqmlbQjAtUf+tPV3xELfkXm2p5ezlgcajmrg2m8qoV
         zKZt9ZDEMXLFAgtGNHmjMihH+HzOoeCLXPPn6CHS7arW+HLBYeG/fWpxQvQTkyAsfPn1
         8hnhNsynBvvs6U3lqsJH5rTT2LnqQnr7AjVnQ+gxambhGYmHil3bgE+bvlRbReudxp+/
         05ZM3H3FFsYo9/QwGJbY5pqahzn0hpCMtwe+EYqJFByl5AhfnzgY82yl5MurRJoTg1LY
         jTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566054; x=1788170854;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1zbz0UezBRokFCxPAADPzNNnQ2q3uFS8kgDI9OKirCA=;
        b=VEr93KDMg2SMKAQ//h96Tva+Amoh5JEujHkD0ni3evUrZQRwtoPccsGu0ApcaNUeZK
         c4uPwXo/XILSVxRAedpw9VYHFr8U/wldawJMJZjhg5WlWNS5KCb28Gu5b2H5OOXyPWFI
         nJHYMErG8tGwxOz6b68GaEt+2CRwWVhnZVdQC+bVOIPSD1ZUsuzbJXZTTTM/vwSJLgZR
         Gscg1xJBkKBU0LYC5Bw5/1CJHvMT4oAWzD1SvdK20XY31C5KNWJ0v5vyiTSzaf5IkUwq
         OhGf87PG7fYyNqggo2j66+hIWVYWwoWybmgYhKjsJFm1ylPCmqYtQQowVPp0lYZqyyEb
         9CNw==
X-Gm-Message-State: AFuF++mylCSOUAkvtswiBcNhOz4ouIi3GR5HfrFUDY2QxBd+wdsPyaHJ
	8u7Es/oQ3M/cL95P1kgcVm9hC9OgV49PST/Z+/Vd+WrvFDCMdNWo4q6fuDexgH5etA==
X-Gm-Gg: AR+sD11q6K0JUL8T8hPmTeVVK/1Y1nOcDmgBqb2xenui+tS6J7ADDRr9jAe+4xIZ8HA
	HWU2GK/efA05rcsuewghZEhVc+90awJQefL5DIgoFfD8L2rXVsFEt2BdvHFDuigws4xSOlxqs4z
	tYEYYcUOiLzlolXNsU7D8bgeSlSLsChlIE8q6IuNpiMB6Yux1b3zLt8RjFR9wgJCQ0sw0V6SWWj
	CoOjOkPSmx2bBbgQmwaIvgLTHdEhJXVQFz+g2pvpdVOx07i/g5oMZQEgOIrE/NJFESbZfGslhsj
	gTyJZEBh+RkeR18whwa9io+gouqMhHuqVhvzzW3P3/SgPjJiTqcVV6/Sngvq97ldprnZqPupSj9
	bzVp2tU9QAoVST/i8MDOb6leMzB18iIQBIInCxl0zBsEJ5rX5d+s2wKK+j301NtwFrZ8qYh/ttP
	XcROt0FxLDmPfSWMmz+hrPw91Or6+jsihqaig4gu80S6bOnEYf+Yxq7Mst7OtTKbxeGT2+G0EWA
	Eag1cq6BOpDkse4LmJmsQI/3g==
X-Received: by 2002:a17:902:ced1:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2d673bdc43fmr8073435ad.11.1787566053791;
        Mon, 24 Aug 2026 03:07:33 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b065sm1758681b3a.32.2026.08.24.03.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:07:33 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:07:27 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v2 1/5] iommu/amd: Refactor device probe and capability
 initialization
Message-ID: <aowX3yLlstXoCfKa@google.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-2-praan@google.com>
 <ecb70415-05c9-40bd-8ddb-173267a7a30d@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb70415-05c9-40bd-8ddb-173267a7a30d@amd.com>

On Sat, Aug 22, 2026 at 06:34:42PM +0530, Vasant Hegde wrote:
> Pranjal,
> 
> 
> On 8/14/2026 7:26 AM, Pranjal Shrivastava wrote:
> > Restructure the device probe path to improve readability and prepare for
> > cleaner error handling. Refactor check_device() into iommu_lookup_device
> > to explicitly validate and return the amd_iommu ptr & devid. Refactor
> > iommu_init_device() to return the allocated dev_data. Consolidate all
> > PCI cap inits (MSI domains, PASID, ATS) into a new helper:
> > iommu_init_device_caps().
> > 
> > Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/amd/iommu.c | 114 +++++++++++++++++++-------------------
> >  1 file changed, 56 insertions(+), 58 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 4c31294fabc5..9b8ad131ba79 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -675,7 +675,8 @@ static void pdev_disable_caps(struct pci_dev *pdev)
> 
> 
> .../...
> 
> > -	amd_iommu_set_pci_msi_domain(dev, iommu);
> > +	iommu_init_device_caps(dev_data, dev, iommu);
> >  	iommu_dev = &iommu->iommu;
> >  
> > -	/*
> > -	 * If IOMMU and device supports PASID then it will contain max
> > -	 * supported PASIDs, else it will be zero.
> > -	 */
> > -	dev_data = dev_iommu_priv_get(dev);
> > -	if (amd_iommu_pasid_supported() && dev_is_pci(dev) &&
> > -	    pdev_pasid_supported(dev_data)) {
> > -		dev_data->max_pasids = min_t(u32, iommu->iommu.max_pasids,
> > -					     pci_max_pasids(to_pci_dev(dev)));
> > -	}
> > -
> 
> Can you add something like below comment so that we know why we are not calling
> iommu_ignore_device in error path.

Ack, I'll add a comment about this.

> 
> +        * When DMA translation is unavailable return error so the iommu core
> +        * won't attempt domain attach for this device. But interrupt-remap
> +        * is still supported. Hence do not ignore the device.
> 
> -Vasant
> 

Thanks,
Praan
