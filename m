Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B6F194137
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933407; cv=none; b=fM7AE3mIEcV9UAwUavM+BxmoscDQtMyzY2k8AqIwpLYcaDJh5YsTqSI3GxP/4B4ojvIWr3vED1xnhE2gLWCiPHHFfAg9se84h7RAnTgVyRL3QRPJQBbmzI+t23SaeFmn1shBxn2GlWegQs2qLM2J3lcpLGcK8bM2m8HvtKrfTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933407; c=relaxed/simple;
	bh=a0vR4rif+JV7hdr86WDYGx2GJsPb6xmv3+Fa2nSVcAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSaP7FshUIGwsjYc+8A8g2s+rnuooLoKATMpiMLwbM07VDhTIdCsYGZ36vSU1SeE2bSikAum9w0gQZtJxaW899nlw5ZVUMOtrblX3F9txquI3gJVL2Z7MnuYN0ZjmSpMUcj3gt/yvjTVTD8Z2W2hdLRtQeJXhVj9N9fSaWnlq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bbqN/cNu; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bbqN/cNu"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bf84c3d043so2943306d6.3
        for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724933405; x=1725538205; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swBcjf0q9GyzpcvXnkxgogsvjegTDsraSd89NhgjMPM=;
        b=bbqN/cNuR4OmGDGAvVt6lxw9djHhCJyfnwBMSp3GPceTjkj5AbcdXcErsMlCBr/Hdd
         6QzwTgAVbcM5FcQZl7+GDNvfIqXjjYL+gDhQI7ZkJhhIHBCWmo9z4o3IReMmM6jnoqY6
         1ljgqkfAj7ZNIIZJOGLiemUs643Vq8mD89jG6VO3t07yEs0jwSxNN+numrY1a69aDr7B
         QmsbY2z501NDMavcLfqGXXgyyhjTeNQXa960EscvJasvDf9Ad5QU1gvsUAQz/Kx6poLm
         0c1XIAsC2XlxHlO2sSvL4QTgqGHy3RaJmPdisIjQJbZaorhXKvNMTFD2zkCyv6D8nV/b
         /YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724933405; x=1725538205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swBcjf0q9GyzpcvXnkxgogsvjegTDsraSd89NhgjMPM=;
        b=uzsWWn4P5422bcGTLT5Sb8SvHHzpmmSfVc5WQR0DeeuAT30YD15VMZ07JMTk+66yLi
         bZEGCJpuvIaodVcANBVwgLulLsAYeU0rhPC/QVvEzHtNPa48Nlqf2GsibFRCC6DrjotM
         fPZE75grUiuY0xGWW56eOanBOo4Zxvb8Ec0CXRtPKwha/U9GKVMaQLu0XJmjurUSSW5X
         lhFrN4TBgp5J0gUla9Xglmr1s+FdvXvWU8y6PjvqtA5JR06zC0lo3GFvvx2qhySa/DZn
         Hv6NlYWpGoXjrnsAOvvVX68bIKoIPLlCTQTjlTHuWD3JrowpZmjsRxuxTT5dqn1iazUh
         NyKg==
X-Forwarded-Encrypted: i=1; AJvYcCWwDjZK9a9fVpIW8VwtYO/cVZbovg9B6D2iHt40XUjoTvkZPnIhtWMg7+XKmmsBxn6i7v1VRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YygraY7gHAatZQA5uU1jijZ/saz907PEXXJomWU63JjrdV8b7P6
	QY0MjKCGGc8QnzFTOaR6gAWMGwmbPHvw0c3p5wrazmgeb0UPwLvnoz4dHPPwC+KpdDZgK1dDNT/
	9
X-Google-Smtp-Source: AGHT+IG6fb/fEJ0Eif8x8gUooGZ3k8bjl0nOY81ugldiI/emGaaSU8TQh8A3Ph1Te9pqyyfip35mzw==
X-Received: by 2002:a05:6214:3982:b0:6b5:eba0:d0ab with SMTP id 6a1803df08f44-6c33e616300mr27703546d6.15.1724933404577;
        Thu, 29 Aug 2024 05:10:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bff540sm4651516d6.34.2024.08.29.05.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:10:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sjdyU-007Tow-N1;
	Thu, 29 Aug 2024 09:10:02 -0300
Date: Thu, 29 Aug 2024 09:10:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240829121002.GV3468552@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <67436cba-3d05-4528-9519-231b8396ed51@intel.com>
 <20240822124433.GD3468552@ziepe.ca>
 <0ca31cc6-1741-40d1-b8c1-20e6b4fc955a@intel.com>
 <8215e4d4-2077-4fca-a002-27ddbfc0ddf2@amd.com>
 <20240828145224.2e949806@DESKTOP-0403QTC.>
 <6741bdcc-d9ca-4090-805b-3a7f4a4d650a@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6741bdcc-d9ca-4090-805b-3a7f4a4d650a@amd.com>

On Thu, Aug 29, 2024 at 04:21:32PM +0530, Vasant Hegde wrote:
> >> Note that when we use NESTED page table it will have both v1 (L2 /
> >> stage 2 level) and v2 page table (L1 / stage 1 level). Even in this
> >> setup V2 page table inside guest can support PASID.
> >>
> > Sorry I am still confused. So V2 can support both PASID and no PASID
> > (untagged DMA). For the nested case, if the guest wants to allocate
> > a UNMANAGED domain, would you use V1? If this code in [3/5] below runs
> > in the guest:
> 
> In nested scenario, Guest will always use V2 page table (and host will use V1
> page table).

Sure, that is how it must work but..

> > static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
> > 
> > 	/*
> > 	 * Force IOMMU v1 page table when allocating
> > 	 * domain for pass-through devices.
> > 	 */
> > 	if (type == IOMMU_DOMAIN_UNMANAGED)
> > 		pgtable = AMD_IOMMU_V1;
> > 
> > Hardware-wise, in nested case, can V1 be used in L1/S1 for DMA w/o
> > PASID?
> 
> Actually no. L1 (Guest) will use V2 page table. 

Where is the code for this? How does it work today?

I have the same confusion as Jacob where I don't see the driver making
the distinction - ie as above...

Jason
