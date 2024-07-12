Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C2171652
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792410; cv=none; b=ZvfKw2cvKGYsnMbxUGGzc4gCGOjYdUNQIiseWKvCLyyeatavOwparSbWLgHNsZFQbOWIxwcbk96Qy/qnbJyRSg7HZI1ygvBs9MZpNdNPm1r/bvINh+dPglJDbNZPKvsYmqrvVhipFuTUphKHqcI8souUFHHE5N2CPG1CQS8572Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792410; c=relaxed/simple;
	bh=AM3UxsRbcSMY/hEEjM26GU5wbnRnI1ykjxMw6M2HlN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM5oY97XmF8QTlRpTqGRS8x3oOHXtneM1IzV0cpQ7nxfr3QBrMRghkdW3cUDoWFgp7z017fkQoi/3qMPTS2WQ+dWBfL68v/Vc3GjOvYjurO/tLkzriWETYvQDvLV4NQuef1vd0WHVno5xS6pkmXgWKinSfEhfPiOiVxBXnTi6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aBUZqz4s; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aBUZqz4s"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44931f038f9so24910141cf.0
        for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720792407; x=1721397207; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=emSwf2tkvshD3dwTkkyi4AwrLVvo5Vi+88rqt0wPGb4=;
        b=aBUZqz4s+xMeZ6FTZlnzK3Z8Vo782wFMgYqB8VDsQ8V8lDnbmr2NfUky/5jZ7IkPqT
         9wzLet94mAZluw8X36TG59VVrJbFr9+5n/ATWx3Hg3u34UkWIeq+XeTXF6BAliNgaZ/V
         TXULDmLm0i26PCAADFWwGwSSAD1L49xliIQmh4QQMsNrtJt/+yyrG28QlkKsUk5OslYt
         v+ZzFolTrR6hraT2aF9GB8un4uoRPKfpjGu3jii5ADBHJDN8knfFNOpRDr16ibB9Atp1
         cLIt6+qcWsSl6+mRdBhrGTnn4DVHV3vcN8/a0cFwS9yLoppM7niKvIbrxMaXjyNJb4cz
         8rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720792407; x=1721397207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emSwf2tkvshD3dwTkkyi4AwrLVvo5Vi+88rqt0wPGb4=;
        b=gcG7ZiLWN414glBdvn3XgHv69k+7P2Thou5AGQkBnCYc15ueNGOmxnS9yYjofpfA/+
         +xV5UaXiCX5qkEXGftwps1A6Tc9SCze857t6NUFOopfKVEFL9B2pelwdBIpQa0HbzO4V
         vzQa6EqCjHch4jonOdlZqtEmJT/xwcRwR7E43zbfMzsr0LaOHc5Y2IFzNiQuCSKmHFkH
         bQNLCq3WFdE4wC/cCSSdLmor0gZfqs/MHUpBrvwRk4MixvRxadYPumAguZIMYrJpmOxH
         dpHza9Zvlf8AkRIg3bBffLrho7LlXrTEj7czkUZJhR7yJAciK+8r33PlDGtRkZNfGSll
         PGag==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2P4Xee9ZiD/y0OJxNmmCV6AUHMOqzuK0bL0+r6gj7iV7AZ5cftpit+9wYr72/zCGOpxlGASpoEgWloPyASq/CiUqSPA=
X-Gm-Message-State: AOJu0YzKSHNPl1kFw2GLxfzN2VKh/esyLIB3ZCyj3lt0rjNV4pTuciEb
	v4iCktD9ApO7ku3QOhTGMGqDh3vxwvxhx+Ym7AyG/OlCrRVsap5E0K20eMZuF4U=
X-Google-Smtp-Source: AGHT+IF1P0emocTANardbOun8fRGIF0xZEWZcLRz1+rxmOsak15gA9AZ2EnPONlmxMR+H6RWXBHUzA==
X-Received: by 2002:a05:6214:e48:b0:6b0:6625:135 with SMTP id 6a1803df08f44-6b754c1180amr45723256d6.28.1720792407098;
        Fri, 12 Jul 2024 06:53:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba77767sm35416846d6.95.2024.07.12.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:53:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSGiE-000Slh-6n;
	Fri, 12 Jul 2024 10:53:26 -0300
Date: Fri, 12 Jul 2024 10:53:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support
 AMD IOMMU driver
Message-ID: <20240712135326.GD14050@ziepe.ca>
References: <26524622-971f-47f5-936e-d0173d342288@amd.com>
 <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com>
 <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <20240709182303.GK14050@ziepe.ca>
 <3eff5c86-8b5d-491a-955e-794198350ec3@intel.com>
 <20240711234917.GW14050@ziepe.ca>
 <35ff9f32-ae60-4124-9ced-42f82c2b4f93@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ff9f32-ae60-4124-9ced-42f82c2b4f93@arm.com>

On Fri, Jul 12, 2024 at 02:40:37PM +0100, Robin Murphy wrote:
> > > BTW. SVA domain shall not be attached to RID I suppose. This should
> > > be a common restriction across vendors. Do you think it is valuable
> > > to let iommu core block such an attempt?
> > 
> > Yeah, maybe.
> 
> There's no functional reason to disallow it for Arm SMMUs, at least, so it's
> something that could potentially want relaxing back to per-driver in
> future.

I think everyone can technically do SVA as everyone should be able to
do PRI on the RID. We want PRI on RID anyhow for unpinned guest KVM
support someday.

My specific "maybe" was because SVA is troublesome for MSI, on ARM we
won't have an ITS page mapped for instance.

> I've heard murmurings over the years about potential use-cases for SVA with
> platform and/or non-PASID PCI devices, but never anything concrete for
> existing hardware. I imagine we can expect to see more SVA-interested
> on-chip accelerators in future, but whether they'll all be nice and support
> Substreams (i.e. "platform PASIDs") is the question...

So I guess they don't send MSI down those special stream ids? It makes
sense as a use case to me.

Thanks,
Jason
