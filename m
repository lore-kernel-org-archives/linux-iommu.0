Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C721FAC37
	for <iommu@lists.linux.dev>; Sun, 25 May 2025 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748200028; cv=none; b=tjbLq4tzBDz4cerOP9fOUVlXtlrs6h3BWSTDgaLiA3bBN8n+LcfdQgwciTlHOyP3v4BNcBMQGlbzvGoAEW/NRYb7g0SAODiA15Na+H3DltrYqebf53152vGSzHnCU326kGSf56ZVpiAq+SHK/RPJ24NsOjdDv6rHvAXUk1T8X8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748200028; c=relaxed/simple;
	bh=uXkJcfGzBIMUXOzmp9Pum4qEKxXyA66d7FwQCanN8o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/oi/lgzPi04ya4x5jWncV6wxPCQNyJMutUj2S2Y1sraLiGDkI5RXeNP8e/BvDcXk9JpnhpvJ9SlGAz5bCaL0hXAghdwdvIuffr1e17e2efLa8wa2HvIM/GO1D2m62fArw8AxbJYheHKatRVl9Ip4E8Wz7jvAeTDYfI/s00n2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YnPz4uVL; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YnPz4uVL"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47ae894e9b7so28532561cf.3
        for <iommu@lists.linux.dev>; Sun, 25 May 2025 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748200024; x=1748804824; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SlfPbl9U0b/o5N9rX3Vqr5rZsZeMWo7A8d3jNHieFXg=;
        b=YnPz4uVLqWbPMOwzL6SfHcbxNwd0rkPbmG8TozjjF7peqGZBgWbG0A+c3dae6+WdPs
         6ewl7KDFs6vDfu2FbKiHr7XdG12sRB71pHUkTBnbPP2zZjDyx8OAKn03hBGQ3BZZl7Ym
         UBeK/tAbYJaaqtIWPvVKcRVvmgwWIfkdVkkNTTDyi9cU7P6415AbOh2mTYWpkEpXUBsB
         yWcn98mkfOKRzIALkvI6zSnHSbE8O89NP6/xja/Gjz/lrCpz2SR/9hXbQ/DEk1qiDhLp
         DwukN6ke0HIlwCZGJCUVTADTMEkz5wWDs7VoqTyqNF4MsSL67LViqiL8qjiDs+XmC4yk
         6t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748200024; x=1748804824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlfPbl9U0b/o5N9rX3Vqr5rZsZeMWo7A8d3jNHieFXg=;
        b=b+8pB+9hJPcFiWAeXtVGzHHhr0c8aViTQSYycpshz09eDY6RZ4aPAT3oLivs5gejLP
         ogirygfXUdppfmSzM06vAZ5K7bLhQIwsK3ZBZ0yzaSYOFyVvzxSEZp3w5sWiSlQCEU9A
         hg8dZ9ATCMealCgnD6y8xuT72rt+scCfDcOiwmcqdj6AwK+mk3A8rFGWf5W1CXXR4Ol+
         dSsqCQ0L+GuXUoGl1u7YsEeeQnzaSx8CuHL04X+VW0vz0xllcu6IMY3D4Di6YCG9mfLq
         qKjRbc7PDkXYhjrZDETvsNzg2jA5oA57NmEZO1SHyaTO/x1uUNhJobDhEl6fWJLaf1xL
         fZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCURiDAJuVByANj/EUuUz173knHOd9MASuZPM6uOcd/MF3PEmCQj/eHTVgs7O5u9uQformSWHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5vfdan+gB4WP+S2rIwk5FdUwxjeOpAs+bvg98pjvgHJX3uzI3
	EsYMj/45Ddi2Ta/bNe2f2nhXupQpKdEGDCO/NxsqvDgbISyn7bdPbWHLRjeC7CfGAKg=
X-Gm-Gg: ASbGnctyFTjqDV6zSXmQ8lqZqRLPVTGwXrnFMFOqH/J1Up3KZoL2sAhoLbEFfr3Ht+h
	yKRiBG4oU5qSE+GkduQ/O7wO42biSNHObnBlWRGgV14YaJbVzurPAZNhN3B5VntAKScAUn3TZ+q
	KKkPBG0lPxF6vGctEagpTIYJJ5oZW5+H29jzBSscwBSRCDmoYfjFRWv95SA9mfxcHEdtkz4/d3u
	I+/KOmZzVSPkQcxuL6P4VOGGnCZFcdTgVHru/ubEKwmPpLUeTpghtT9mngh3q/TfLEPRf36Hnp9
	OeiEZsByOZ9itdDTxlJV2rTsiZijsNuQMdnqVwWafec/FPTxZIUk/3AG9C+IIZj0NWX2su1iaid
	Q8egEo9oMqaQ/tXsKhgIQQpgUASA=
X-Google-Smtp-Source: AGHT+IEsK8RsIZHAhqzNbJPFGKthMn51tZwQ52JiopY7fu+XaQ8UU+nS+s5NnIXGcLb0DNTM1neWbA==
X-Received: by 2002:a05:622a:550f:b0:494:95b5:ce38 with SMTP id d75a77b69052e-49f4781f4damr107883391cf.42.1748200024664;
        Sun, 25 May 2025 12:07:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b7400sm1472991785a.66.2025.05.25.12.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 12:07:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uJGgZ-000000003eK-2F45;
	Sun, 25 May 2025 16:07:03 -0300
Date: Sun, 25 May 2025 16:07:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com
Subject: Re: [PATCH v2 0/3] arm-smmu: select suitable IOVA
Message-ID: <20250525190703.GD12328@ziepe.ca>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
 <20250410230008.GA6905@ziepe.ca>
 <67fff12d.650a0220.208c7c.d69dSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250416181759.GF493866@ziepe.ca>
 <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520224224.GA16365@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, May 20, 2025 at 03:42:24PM -0700, Shyam Saini wrote:
> Hi Jason,
> 
> apologies for the delayed response.
> 
> > On Wed, Apr 16, 2025 at 11:04:27AM -0700, Jacob Pan wrote:
> > 
> > > Per last discussion "SMMU driver have a list of potential addresses and
> > > select the first one that does not intersect with the non-working IOVA
> > > ranges.". If we don't know what the "non-working IOVA" is, how do we
> > > know it does not intersect the "potential addresses"?
> > 
> > I had understood from previous discussions that this platform is
> > properly creating IOMMU_RESV_RESERVED regions for the IOVA that
> > doesn't work. Otherwise everything is broken..
> > 
> > Presumably that happens through iommu_dma_get_resv_regions() calling
> > of_iommu_get_resv_regions() on a DT platform. There is a schema
> > describing how to do this, so platform firmware should be able to do it..
> > 
> > So the fix seems trivial enough to me:
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index b4c21aaed1266a..ebba18579151bc 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3562,17 +3562,29 @@ static int arm_smmu_of_xlate(struct device *dev,
> >  static void arm_smmu_get_resv_regions(struct device *dev,
> >  				      struct list_head *head)
> >  {
> > -	struct iommu_resv_region *region;
> > -	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > -
> > -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> > -					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
> > -	if (!region)
> > -		return;
> > -
> > -	list_add_tail(&region->list, head);
> > +	static const u64 msi_bases[] = { MSI_IOVA_BASE, 0x12340000 };
> >  
> >  	iommu_dma_get_resv_regions(dev, head);
> 
> my understand is, this hook is not called for all the devices, eg: pcie dts node
> doesn't use [1] "iommus" property instead it uses "iommu-map" property
> as a consequence, [1] while loop exits prematurely and iommu_dma_get_resv_regions()
> is not called, so there is no IOVA reservation for the pcie device. 

I can't really understand this sentance.

The above is the only place that creates a IOMMU_RESV_SW_MSI so it is
definately called and used, right? If not where does your
IOMMU_RESV_SW_MSI come from?

This function is also the only thing that computes the reserved ranges
that iommu_get_resv_regions() returns.

As above, I've asked a few times now if your resv_regions() is
correct, meaning there is a reserved range covering the address space
that doesn't have working translation. That means
iommu_get_resv_regions() returns such a range.

If you don't have that then you have a bigger platform problem, IMHO,
as vfio/iommufd only respect reserved ranges.

Otherwise, what is the issue you see, exactly? Did you even try it?

Jason
