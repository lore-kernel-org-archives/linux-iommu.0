Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F9183CA5
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664385; cv=none; b=T99yBiK5RTgRHXSyXbcytRkWewHWKkoxdwR+feRhsNl8IziYywC3cBS8hHNbB7YSKak6Icn8Rr2IsWNR+xzSKtUu3qGd7jNg2NIkfK7rVsU8d1vRWuiKNAh9PcktmvJYhfc7LgLVTHEwcNJRAtH3ebc2DuxQxpGOamFF4KdHqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664385; c=relaxed/simple;
	bh=xbQaPynXdEpvRxqGa7X5AdacfjDSR/YzwITPO53jrz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMfLYHJysmIOMrivIR1wKBsR82qIBiNAx9XqkuD5uHj7hQjySWoZ+aQeSYHtocKIZw5+82Qk9WMPmOVUCZm/RDQGEkgYcWHJEWAqPAuPiYRClUnQCTP1W2vsOD4zHjSWKAsUXgza7x+7TwGnzyc1aetr/zJtNnItw6paD7wr6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LBXNlCoQ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LBXNlCoQ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb82317809so16111976d6.0
        for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 09:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728664383; x=1729269183; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOLTO6qowPv73dfBzIlXGTy79lrTXY1ifwKbI9Z39rY=;
        b=LBXNlCoQMbCOOt6EKmzbvRjN31SUxiB5Gf2og0uTSEQDSvO/KynfrJKsgZbz2Gp0NF
         N5RwWvqe6qWh93q+VH2fdLUhpx8UUBcVI4PV8bwQNZfgMYOH+4Bn9Mx9UfsU3yzaOA8a
         /aYJwtQbX0wI3UywhmLd6Nqg2cj20Od01u8Je7r0XULmNRzSTbIAP+sZaSJ4xN1fsk6r
         fqk3BtGb+4CwaCZ3k/t5AXz7HdXgMWrcRLJfj6rS5k3h+6hJStnVBTe2uEhpKHDzjGFx
         N/nvUKbtbaoMpOaYolDST5m8vbRr4QzJinkDaGzabAYCAyF/NsJKphcCNyGAA1IZjTMh
         9lmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664383; x=1729269183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOLTO6qowPv73dfBzIlXGTy79lrTXY1ifwKbI9Z39rY=;
        b=ecDO17GZmosk1pZJw+aA3tbGFvSVwNYyJzqMlEkwvJz5APrBkRjYOnUbH79ChmPQ1D
         zH/PD2qlq00T+jCyno5KI8NvhqhJQ3oP1IoCIXlgaKiWu4Q/3mKm5BpWPzt1p/O7qjSd
         RZSBbbcoHjVxD6fhArvrlSNmeA9o9VmO8pSxtNDPCov4mbE8LCgMpxYyJmGKIjsb14nG
         YUd/4clZE8JGZ7+oTKkgihZ1EIR99AF0DFKjICPUwugShVsbRkmVUgfURy1MuKVFJw7k
         mdgrFq2Q2jkG3Nl/svndMLGMiObCUMk4ntf+v+r5Xlo19fB3gTd7u3zxWFaY0PdwTBej
         XOHw==
X-Gm-Message-State: AOJu0YxPpTifN1sI21RQaHD3thjAa4mnI6mVt6PNDa4GD8LxN9ZqFVJK
	ETw0mYuV/Zmg80VFg/F7gutXGwoEt8WnVSkQR0umS8ApM7BCBj7D4mpUCSAERHg=
X-Google-Smtp-Source: AGHT+IEEs/9BNK3lbSt1K/hYPpP58NiKoems4hd75VVnpLGrm2nR2TXu9DwOV4j9JmofQupNl7DYHw==
X-Received: by 2002:a05:6214:5913:b0:6cb:e69d:4c0a with SMTP id 6a1803df08f44-6cbf0102302mr47652796d6.48.1728664382945;
        Fri, 11 Oct 2024 09:33:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608d7esm16733616d6.100.2024.10.11.09.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 09:33:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1szIZZ-007ekU-To;
	Fri, 11 Oct 2024 13:33:01 -0300
Date: Fri, 11 Oct 2024 13:33:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iommu/vt-d: Add domain_alloc_paging support
Message-ID: <20241011163301.GQ762027@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-2-baolu.lu@linux.intel.com>
 <20241011132252.GJ762027@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011132252.GJ762027@ziepe.ca>

On Fri, Oct 11, 2024 at 10:22:52AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 11, 2024 at 12:27:16PM +0800, Lu Baolu wrote:
> 
> > +static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
> > +{
> > +	struct dmar_domain *dmar_domain;
> > +	bool first_stage;
> > +
> > +	first_stage = first_level_by_default(0);
> > +	dmar_domain = paging_domain_alloc(dev, first_stage);
> > +	if (IS_ERR(dmar_domain))
> > +		return ERR_CAST(dmar_domain);
> > +
> > +	return &dmar_domain->domain;
> > +}
> 
> With the direction that Vasant's series is going in, I think this
> should be skipped and instead your other patch to make
> domain_alloc_user (which we will rename) a full functional replacement
> is the right thing.

Though I guess for patch ordering purposes it makes sense to just
leave this and remove it the next cycle

Jason
