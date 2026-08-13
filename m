Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C933822A9
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786661192; cv=none; b=qwenCxP+mRxKAYR/Ej0RxdfBbnxAxHr4hrX2NMIsAKtp9h/5PKSsTh1EduIvS5TVUW2L78iXpSacFTUU/wKglKgIya64+TBqD/8oW6VtncIykyGVaFUaHw1lL9lYGWdN6FPHTdYyaVcaFKu7XRlaaco0BrBg/WbtPDE1fbc8ZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786661192; c=relaxed/simple;
	bh=i/6Jol0HBp5RRTvGHc5apFk8jhMg7iNWk5RSz52dbzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONHfCf0X68/7P7gEqWcVVYVc7YWzjISzouCOLXxh3Fr4hWCF1881BCYJbkwHolzpil1Vw1uQmdFsWZ1LKJ1gBU5hqJ6vl5AZhUEX/p9m2cOWVMFBJU0oxTr6/6ehsPDfLhA5VW82HTA6EaVd2Q3hGaemZQyx33zXgkrNP9pTN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UF74/En7; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UF74/En7"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-934974844ffso27275285a.0
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786661189; x=1787265989; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o5MtttmxZUrUNaLZLU+CiS25EBYvth90JdQ9xwh2RPo=;
        b=UF74/En7BuXvADHwjAxeTc8eyHusWYsGNp/PBc7e9jE4MO+ONBFlGldn5OmFF8Mc7g
         25S94cstYkW+t+SuiggRQJn0B+rf3mEYP4RweDC4aEaETygo6yAVxOugP78jB5AYqtU9
         S/tbElmJOKqShReB8uEvpfp/3jMENf8EbfTj6iRLjK99iAhno8eaYo1bBou0uWNp7UOc
         6T42F3VNmsF48mxzP3I7JoDxPDd0KMam7qpOjUeS/ueq293+SXtSNCSGs2E6QAZAFBw+
         DEo87gTkIMxJdTzxzI6TfnbhzMelBM61XPuPWZJ6qvRFNKG16VHY5zCzCIGD0DShuMfp
         TcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786661190; x=1787265990;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5MtttmxZUrUNaLZLU+CiS25EBYvth90JdQ9xwh2RPo=;
        b=DW9WQuPQ7QxatIDlJHfNt6mwZIZSGODiwNPcLe/YeiPeT0clZQKbYBLyz9ykmQCPJa
         4hh/6ZJOHTBQVM1QIy+giotd1X+FHCrApTgEzvE9TtnvQkYQuy5eJZtyNqySVt0wJNmI
         J30e+pX8RxGjWih1ogpKz43fgAZMq/tBfvaG8VmEzqHkJ1FNC5vpi6zhoWyVpbYNrV00
         Qk+wOQcB3o438NZX2JCgJ889+OS/0JSsrfwcXV9v3uQwHTOw3mLAYHgU5Wu6xzNkzT8i
         r34cLaQ3avYRGGZ4g4tgLUg0NdX+Eqkg5Wr8Emd4uBVPnLTlb61qq97TkeWlnHq/meg/
         nxhg==
X-Forwarded-Encrypted: i=1; AHgh+RpXE/dmMxWEZbDQ6MdZOPLi4Cy7UhqH6y8I7EtC124KCXYSdQociMAHGp5LOY93NmwRUcX94g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCQPJmWcdALtRhty67Irk8j9Go04Dn1Mtn4deAoBVge+e/GpIy
	jsEyaIGODTo7hr7xmUCtZ1iC4s3wVTb27SJjJoKuh/Nk3WWQ0LXab26fAeym4+4+gR4=
X-Gm-Gg: AR+sD11EvLWRHR08r72dQctXddkcopWr1OfEeCRmTgH7q3P36DSCBiMEJ7hHH6JhG7U
	uTZOSEuHy1c6c5gu1M4ZcY8VrwG6AGDD12faVMIvSUz5hNxKnk2xVaqJ5City1lSYL3CTKu52Vk
	vqXreZU7jubqLD6tjKbjDrcN5h4PehWYA8jPYSexUXp9cd+LYHWbJ76fAK8HL5htdFS4sDxE+8b
	aemJ8RYANcPpnImpBYfFUSr1FUrzqEelJlkxE31Q+eBApiXy0KKYcq6C3JhiZlSyQvzejrkgt0K
	ZnSRa+248henCaMr8JugBt/EQYOrmknlh3KoHBiEz2xoNE8HB04OOi1u3L/gUrAhfdXGsZsXA4Y
	pW0nRIcG5kCiphmZSYgXdESdccRc4dnTEpb/qWt+jPx4gefzqgJkPljQzSwxYOKIK+1eK+frmh3
	deyrBe6bz73PlgbGGoIVFm9diVjRrIgILob6eOAQ==
X-Received: by 2002:a05:620a:408c:b0:933:ada:c3b2 with SMTP id af79cd13be357-936d2382749mr132987985a.34.1786661189637;
        Thu, 13 Aug 2026 15:46:29 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce245787sm96424985a.41.2026.08.13.15.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:46:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wueBv-000000042QP-14bA;
	Thu, 13 Aug 2026 19:46:27 -0300
Date: Thu, 13 Aug 2026 19:46:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260813224627.GA933791@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813152913.00003d8a@linux.microsoft.com>

On Thu, Aug 13, 2026 at 03:29:13PM -0700, Jacob Pan wrote:

> > +static int hv_iommu_blocking_attach_dev(struct iommu_domain *domain,
> > +					struct device *dev,
> > +					struct iommu_domain *old)
> > +{
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +	struct hv_iommu_domain *hv_domain =
> > to_hv_iommu_domain(domain);
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int ret;
> > +
> > +	if (pdev->ats_enabled)
> > +		pci_disable_ats(pdev);
> > +
> > +	if (vdev->hv_domain == hv_domain)
> > +		return 0;
> It may not be needed since the core code will check this. If you keep
> this as extra precaution, should this be moved up before ats? since ats
> must be disabled already if blocking domain is attached.

Why check it at all? Is there an issue with attaching the same thing
twice? Will it blip the DMA or something?

Jason
