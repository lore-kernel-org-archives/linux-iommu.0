Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C516155C88
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579815; cv=none; b=P1KvPUsCukNInErcJpVvtlCoEUcZ3HtOF4+6PxcVo2mB4SgIcWHcH8MftkElNo/lWpQvzW3kS7v7Dl/dsCV8cbl5ZC+S/aEWRzFwEADENDpZOih5JuXEHqCVPw6yoQ+kdQEzoYQ7v1bcjD/14qn5+2nG5Ctt6IiB58Zd1XD9X+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579815; c=relaxed/simple;
	bh=9CJrx6jbKFJbmIwdD2wTYCswgZRqzCBPQbud3FA7y7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7VHD869pMFGq5En5tuh4qnbc6jjo+c8qACAE9mYhYGgEQ2Q2afqTHBSYMa1QH6HpwWed/smXytzNRgUMiCXVSJPbf0R18cF24rLL7QYpT0UIrPcHUJZgWn+LT27m0mNR6EooKFPWmxGIcuzRofKY+czyL3/tKF8pEUufvdSMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Yo0tgHfY; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Yo0tgHfY"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44637e13866so3972171cf.3
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 06:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719579812; x=1720184612; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GTPHVIaJYyys/fKqJcqAuexCknLcHthIDRHne5Vs/4=;
        b=Yo0tgHfYi8RNRLGX74CGz97tUiGf59VbACjGTA+slU+iwf7G3H+1rUGm+yLhoRebhn
         eCHs/NG7f5Li0BFGMt+nCrFm/pPzxxBcDmY4Xzp/Dg/DV3AG9ri8w6hpOWDQRBffbd/C
         tXDzGXZp2yRc1zOB5D+QbNoU6oVj7MAgAE0DRq4ABYDip+kcn1mZB6BDf8JjxmPapAca
         JFDC0pm1tmvfEBRuc1gv1aEOW6+OZCAdfA44q2kwZ33BB4YJXot1mv0QHR6g8aNUXdee
         P2taAMninsiqBTZIEvVRAOsJl843jdINNa7Jh/AftoylrliQjkJT2r+3zTZuY791IZZa
         M1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719579812; x=1720184612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GTPHVIaJYyys/fKqJcqAuexCknLcHthIDRHne5Vs/4=;
        b=mduVmAngJldKhwrLDpr+6Lvzt+ZNyLJlkuDjRQqGdkk2TdJSuuvTNC0+3u4IWq82IK
         QIAFEfNMvDpdOEcPH1syNXSNaIoEpUsS8Xzw94TK8nMvCy/n5K+8a8cIKIBEcC5qF00i
         4awAaaQRZUOz17eP59I+SOpI/w3KPYwZqvisFXxBM2HaWxTsfTyYcNUNoxx7l0M9Oxss
         MiPzrcwBGk+Q48kZaZGKrKM6fnKhWX66TderGXMoenGd5hSK1lMg+FxyzIKXgODWpB2U
         qprvbS2lpjzTzaKVkhSILut/Fw92ExShg+nGKSaQlBmNMYhfmTzPIf6Fcc42bIWDZ/DW
         ohuw==
X-Forwarded-Encrypted: i=1; AJvYcCUQprofiWpZ+nt5YQ1x6noIsLevv32teQu3CchkPlGlZfxK7DV3wFizAsftgTd0A3EWgzq8PrfkuYeaqtRhswD8MiCLgfE=
X-Gm-Message-State: AOJu0Yz1iGqUCwoLYc6buSPCG77aNhq9NbVzNUedp7B0Lic78AwMnkju
	AJpjpSUaK/IO0a5JlZYtS2pnAYUQ8PIb1b4216P3ueZH+k132EKaWvxBaiz7XOg=
X-Google-Smtp-Source: AGHT+IG+vVcp55WR5ong5p/T43VN7Bjp2HVVqgjrMaXKo4RWyLzJNQLgsY2Vd2jsLCTYI6FSOS5/bw==
X-Received: by 2002:a05:622a:490:b0:444:d80e:9f9f with SMTP id d75a77b69052e-444d91795e8mr182192021cf.3.1719579812258;
        Fri, 28 Jun 2024 06:03:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143e983sm6924071cf.49.2024.06.28.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 06:03:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNBGF-003dph-0A;
	Fri, 28 Jun 2024 10:03:31 -0300
Date: Fri, 28 Jun 2024 10:03:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support
 AMD IOMMU driver
Message-ID: <20240628130330.GY791043@ziepe.ca>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>

On Fri, Jun 28, 2024 at 12:13:43PM +0530, Vasant Hegde wrote:
> Hi All,
> 
> We are working on adding domain_alloc_paging() support in AMD driver and came
> across below issue.
> 
> BACKGROUND:
> ============
> - AMD IOMMU HW has two different page tables : V1 (host page table) and V2
> (guest page table). Only V2 page table supports PASID and PRI features.
> 
> - With V2 page table we have an aliasing issue. Hence we added
> per-device-domain-id when domain is configured with v2 page table. See upstream
> commit 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix potential
> TLB aliasing issue")

Yes, but IIRC this is a shortcut to developing a proper packing
algorithm to optimize the IOTLB. HW like this that has aliasing issues
needs some more complex SW support to get optimal usage.

ie you can share DIDs if devices have a logically equivilant GCR3
table. Optimizing this is a SW problem inside the driver and should
not leak out to API.

> With iommu_ops->domain_alloc_paging(dev) API AMD driver will chose best page
> table based on device capabilities (V2 for PASID capable device and V1 page
> table for rest of the devices).

Yes, this is correct.

> But we would like to continue enforcing V1 page table for UNMANAGED domain. As
> in terms of IOMMU caching, it performs better than V2 page table.

We are getting rid of UNMANAGED domains. And we are adding PASID
support to VFIO.

There is no reason VFIO should have a V1 domain by default and end up
with a non-working VFIO PASID API. That doesn't make any sense.

You need to actually explain when and why you need V1 page table
support in the VFIO context.

> Also while adding SVA in AMD driver Jason mentioned that we should support PASID
> with UNMANAGED domain. As I understand currently we don't have this feature in
> upstream but we would like to support it in future.

My patch series enables it on SMMUv3 and Intel VT-d already supports
it. Only AMD is missing the funtionality, which is why I keep asking
you to structure things properly so it gets it too :)

> Please let us know which one is preferred -OR- is there any other better way to
> handle this.

Neither is really going to work. VFIO will have to assume the user
will want to use the PASID API and will always request a PASID capable
domain anyhow.

We already have a path where the VFIO userspace can request a v1
domain by using the NESTING_PARENT flags during user domain
allocation.

If it is really important and logical we could also add a NO_PASID
flag to hint to the driver that userspace doesn't want to use PASID in
combination with this domain. That could also trigger v1.

But I don't see any option here that doesn't involve userspace itself
making a request and indicating it wants a degrated VFIO
functionality.

Jason
