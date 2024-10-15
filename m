Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB501C07DB
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996533; cv=none; b=XAkIWbOFpQpI5OPDa1udKQdJsRDlnuwpeVprS8826eClGSiMVurQq7iYDcRHuYBcOpwwGcvPcsgKCl6SKGkhZ74VPJjSMtet29mF492xAdhZQKGa5J1Ea1/UscgkTch/6B0gULIXzpFT1VsIzwIUzbKS5418hRReGyi868+ZGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996533; c=relaxed/simple;
	bh=xv4oxzeLoZf2P8oJquHhc7sTymUcPArbhn84jCettC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtzHX1W5NrOvuKAsA8RH6jJSW8hcytPu57AFryErmfE8JUqPmhlbzjMKoE2ww0XvbbcJtZoO6oROFFtFja4ahs9FOPG7/HYwNf9IXMA3cfoEUs7tT3F5I1wLh+06vAxTPFGb/xKywIeuAXzS8uOn/WQHQOW8rorY3PT3OFECK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Pl2cAvOs; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pl2cAvOs"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b11692cbcfso398017485a.0
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728996530; x=1729601330; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0LbqFnwstwONCcUk9HDP0yNXp/TQA5wML1UbSxY6v8=;
        b=Pl2cAvOs4XOUv7JLMlF/6UBxj79DjpjDueb3SLOKW6MEhgu3HMUO4VH6nw/j5Z/wu/
         gvIcJp49bMQCIUup1qVT4W29CDGiTR7w8u7z7DQ/A4q6YSJRj8oZCZzLfAY4Rv86FlfK
         rQ2DpFcA6xSFod3Li1MZh+IBRRloN1vsYn03PmCUF9do1blRUyh/2qYyy4dY8kwTW+Ki
         odAtV/tiC1glSTQE9tDGIeVxz+ef4kAEKIWP6rL9mNdxVnv+/vSfNu6r0ix+mI1icIKQ
         uapErz8JvDiCP46lfOhNjJkwmTQ7s8hgF4nsLmlAicqK9VUk+KrdhOtRB9Y6juVP7hOd
         Hp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728996530; x=1729601330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0LbqFnwstwONCcUk9HDP0yNXp/TQA5wML1UbSxY6v8=;
        b=K/9FPFlI6vKK2mELR5+cexBh/W9CUYpBoI3Pv3ebkjShhh251neILo4WSWcP/1SASy
         6bNUa8stgzTgXnAcI3A+SGn7Pj6bDFgm4KYOhSuwip3dWB5+B0P/DMl8k7eD68ncICUY
         l+uR2S54nNXLSUk4m01fNrwe7dM7ZqSjTD1rZhqrfrsZIOYOf3wZ8GRMXKwcNrOIyL/1
         tAXvQUzmTbDKZuLYcGi9eT8mfoHyJQtCvnJwrBheq5s8n1CBcFR/XrL20s2mED8VKeiz
         rfHC8P+lOikXGLJj5q7nBYLUJvTdqsmGe9AUm0DPJ7xXwyHkCdFnAUkR6Xu+hNDX5lg3
         bD1g==
X-Gm-Message-State: AOJu0YzC4ET1aosVqrv0FnD3S0GHsR47tctlroW5uBgsdHwhuoulNWtU
	49W97PPXerQVtlGOOEWnMAdphQp6DNkzqGB6IvnakOImcMFo+N0Tghl/T8d0zgs=
X-Google-Smtp-Source: AGHT+IFfGrKb2jqjuhBXp45+Ef97XFQVZea+RfwF3v+6xAAVLEpIItEAvCxqERFCRQeeKiMz3E4FBw==
X-Received: by 2002:a05:620a:f01:b0:7b1:1cf6:cfb9 with SMTP id af79cd13be357-7b14189f662mr38898785a.55.1728996530513;
        Tue, 15 Oct 2024 05:48:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13616e947sm67046185a.40.2024.10.15.05.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:48:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0gyn-00D2jO-If;
	Tue, 15 Oct 2024 09:48:49 -0300
Date: Tue, 15 Oct 2024 09:48:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iommu/vt-d: Enhance compatibility check for paging
 domain attach
Message-ID: <20241015124849.GJ1825128@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-4-baolu.lu@linux.intel.com>
 <20241011162703.GL762027@ziepe.ca>
 <7f829e9e-5db9-4861-8a58-27a57edbd9da@linux.intel.com>
 <20241014192436.GD1825128@ziepe.ca>
 <a95e8a10-6240-41db-b234-d9f29386694c@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a95e8a10-6240-41db-b234-d9f29386694c@linux.intel.com>

On Tue, Oct 15, 2024 at 10:52:19AM +0800, Baolu Lu wrote:
> On 2024/10/15 3:24, Jason Gunthorpe wrote:
> > On Mon, Oct 14, 2024 at 09:25:03AM +0800, Baolu Lu wrote:
> > > > > +	if (domain->type & __IOMMU_DOMAIN_PAGING) {
> > > > It looks like this entire function is already never called for
> > > > anything but paging?
> > > > 
> > > > The only three callers are:
> > > > 
> > > > 	.default_domain_ops = &(const struct iommu_domain_ops) {
> > > > 		.attach_dev		= intel_iommu_attach_device,
> > > > 		.set_dev_pasid		= intel_iommu_set_dev_pasid,
> > > > 
> > > > and
> > > > 
> > > > static const struct iommu_domain_ops intel_nested_domain_ops = {
> > > > 	.attach_dev		= intel_nested_attach_dev,
> > > > 
> > > > And none of those cases can be anything except a paging domain by
> > > > definition.
> > > A nested domain is not a paging domain. It represents a user-space page
> > > table that nested on a parent paging domain. Perhaps I overlooked
> > > anything?
> > It only calls it on the s2_parent which is always a paging domain?
> > 
> > 	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
> 
> Yea, you are right. I overlooked that part.  I'll remove the 'if'
> statement and utilize a WARN_ON() function instead.
> 
> And also, I will rename this function with a meaningful name,some like
> paging_domain_is_compatible()?

That sounds good too

Ultimately you want to try to structure the driver so that there is a
struct paging_domain that is always the paging domain type and
everything is easy to understand. Don't re-use the same struct for
identity/blocked/nested domains.

Jason
