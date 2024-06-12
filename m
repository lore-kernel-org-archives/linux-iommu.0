Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48D17B4F9
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199457; cv=none; b=jB9EcMv/l8ot4uZeZ7FZ84BKbJS1RhQc7VwgV94NgUckLp0bndacpk7fjyNH/msO4hvSiDM5Op8DuRGnx+mirfI3UywX/KwPVMSzZN2VXZcBAYGwJeK5QZQYroFLLIvvFVDdb2+Hx5D67uY5ALMKufZUW4TxygrH+3PYYh7XyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199457; c=relaxed/simple;
	bh=fe0VWMI+8IbOduW8IuBosS5lQngZX3belBNixyoqkno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtdoLU2uIz2M8bp8WgRXkM4X6XEDHTubFBeBjC0uFgKgZAHo920tmcnJ9bORgRmseaxZwPlloKGqGb/pNbpYuR0NvthpKtctTWgzk3gCVBW6L26wW2jnru40RdrbGtOolYPC0VkQwMQM53ILqYo+1EKIMpztQdiRQC978YbZEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iZf3oQqc; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iZf3oQqc"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b07712207cso19157586d6.0
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718199454; x=1718804254; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K139GCQM1afDeL9T5S7IFhFlKLj20Oeajk42+esr2l0=;
        b=iZf3oQqclbatfcj0qmVm17mVoKa3UgODokcVR4xN2pp0C7NYIRvcwvLhxSsXwnRoOU
         Ogam6HZOqtzBTlUQspt+wPmg4IqWcOcbyP3CPC7qyXmpmWZOpDfyHiVSX0DePB4ex7BT
         KUXdl7/0BV0cPK1LoQFPPQI3ZK8FvlZwLROfsTDQXAvDXvMVrS+h1QN0wQo4S9pLHvSV
         obdfwOBSnvPJsrkRGcV8y97y7ktTlxxtLs88X8o19U8nuQhAMwGogpMoGbWyamqv5NM1
         gP3Xpe5yj++1ehnOqERihrG1QnNZejdKu87u2rE0mS7riULxWGBEQLhail5X2cjQBvgS
         7tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718199454; x=1718804254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K139GCQM1afDeL9T5S7IFhFlKLj20Oeajk42+esr2l0=;
        b=njtKMOn+k9Mk+Wx3tEVYlSF3qph6xwkUcAlf6EuwOXqdmNZ6Q1tPizKwylIjYrPxnX
         UYwtGiNUA9luY7q5tLXsgEHGWMW8PcTL+GvUCxVy5Kr01ERE73wqcLtMzGgv/Y98zRmA
         tHaAXZHv+YRir4HPQ8TbJcCt2ay/N+d5ptGOyKhaCrpWN/sOum/nOjgHpi4r04Whvv7P
         y3n3nEtJ2p/oCurt5ds61l1eiJCM24lwbV4Rh7qQb8b+tZzDMBZ+o8Mk0tdCxDdEq4XZ
         WFLwrMTeRHJVqiF86Pje5wAQHaP+lN4gwdOFqK1Jx0f35ZAbtofBqowGz00mTRbfPNlX
         ghxg==
X-Forwarded-Encrypted: i=1; AJvYcCUhB8h3EF1Ma97rnIBoOBaHi9EYDWPF0ZqtZj7ptDjpNRGMedPMKAgHQQjN8jk/R8SjPEljj31TYV2qrmRMyT+ctn/QKL8=
X-Gm-Message-State: AOJu0YzKcH3+X9bCF8RxR0EbOR4e5PiQkS7cD2MPzM9oipvX/CPJgCua
	F84SkEm2zIFlZSQMyg0zH2mZR3ow7sKpLTipj8UJhDUEMGHAMVrlI7a6gEqc6LU=
X-Google-Smtp-Source: AGHT+IHSfEYGwDvsij2R0661tz6O7lYNLUUlm/+RnRLZK7C4edHuNG4iu5XV2Em15wUQSAV1AhEuuw==
X-Received: by 2002:a05:6214:5889:b0:6b0:6671:86a with SMTP id 6a1803df08f44-6b1a7ad4be4mr16867256d6.48.1718199454661;
        Wed, 12 Jun 2024 06:37:34 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b091d55c30sm11949346d6.87.2024.06.12.06.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:37:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOAO-008wzF-E8;
	Wed, 12 Jun 2024 10:37:32 -0300
Date: Wed, 12 Jun 2024 10:37:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
Message-ID: <20240612133732.GW791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527040517.38561-4-baolu.lu@linux.intel.com>

On Mon, May 27, 2024 at 12:05:10PM +0800, Lu Baolu wrote:
> @@ -206,20 +182,49 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>  	if (group == &abort_group)
>  		goto err_abort;
>  
> -	group->domain = get_domain_for_iopf(dev, fault);
> -	if (!group->domain)
> +	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
> +		group->attach_handle = iommu_attach_handle_get(dev->iommu_group,
> +							       fault->prm.pasid,
> +							       0);
> +		if (IS_ERR(group->attach_handle)) {
> +			if (!device_iommu_capable(dev, IOMMU_CAP_USER_IOASID_TABLE))
> +				goto err_abort;

I'm not excited about calling a function pointer on every fault. Let's
just add a constant flag to iommu_ops?

Jason
