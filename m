Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E17FB
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200226; cv=none; b=iYbEJ3KmXAvhFNx5zsLF4MmH5vpQDOAtnW5x4c0NivR9HnOOj/fGmLUJKNobWLbC7JwRTIhEYbUcfjZJUK1xGyXXrDlzek77cMR6hnREG5Gxxbm/M1fEV73UHRjR4ggYGawce0jeKc4S163cbs0WGIlqFLehKB1o9/h1tl/5XDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200226; c=relaxed/simple;
	bh=hXC97HFGx9ulznhCQ/2sutiUlN20FWDeS6s8GSoSCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKtjMurHlBJlC4AYmYTb6oITTlcj4aD0zpt3RInGwtVAh4Wpg2jUgxiHKwRbsgaIxGTUbhUQl+396zNEdy9EkjTmpfRWwaW5p8szXsae/1W24n72AVKGboHJTa4QzJRBl28xsmSYzFGbDtWfVM5XnmHpa7C5dKkYvVFV3ZUAosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=S3wshtf/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S3wshtf/"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b06b78e716so25107486d6.3
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718200224; x=1718805024; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFYWkqrPwpmWXwb+4x3mhR3bmPCPe0lnYFyAxL0zKS8=;
        b=S3wshtf/ExpYgzp27oygmGvtd8SEktCUf/6FHpAT1MlR5FFAWzBbgH8Cf/exK6SRFm
         uvwFVwWwzeLQ04iAxipcZzuOn5n0Ytk1J6psEn97vFgvYWG0rf5g1kL4Rxk91+3JRVn1
         mBeC4AylZTQWQc4ZNiXT/PG9KX3bzcySiYOfsXpkPY356vH/1DnBudk67xdOQix6ElqR
         ROVWLwLNhCIwlr2gqY6DvW7ynSGDTanLOIi779BFfVud/U+VixVD8CIuqFLGMr5TgYoZ
         yPL9QDF0C2MPyytvRKXiGF+z4Dy56WT6KPk3ZB2I281ZoLJJGQ4CNicndFTXP5TQkely
         x14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200224; x=1718805024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFYWkqrPwpmWXwb+4x3mhR3bmPCPe0lnYFyAxL0zKS8=;
        b=V3YXojNxmchc6vqudk1+bcCeyxqsPy87X3jxvNHpiVZO7F73e547AkLclC/AK1iEdx
         2cj/DtoatejdX9fVGpDtUuP38LfLAKegqHA05l9q3KYz9aSUnj77DRfIs7fiStr1+o6W
         tBeTMa9OoWvYMCYe88+FHtTSGqML3sPlEVt62/ZBT4JBrHyTQ8fDxkN31br0LeCQKvAh
         m+u0qSvSis4sCqcGVFt7kjTe8NaNAH8cBV6dAijs3HJatRTrb8VvJ11hXu6iBtIF3Kvb
         J4wrFW4hynx+jO3AP8mOREPhdyoIqp06xVeoKawZEQpiKodLswfDrzZEvhqWvfMCYbXV
         EXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf3DD5VGp3amx35dgG2/kuJz4KBdjHHExKCpyDgMOTV4MOPr8x7Qv+8lz95BV04DfYuvFgeeONF1DrmR+GYwD6JwJUPlE=
X-Gm-Message-State: AOJu0Yw9byc5F1wvzbtT+IfYoDsGiOrGS4TSaSds9voDOqs/0GIQ+vNn
	ZvS7NDae7TxMQVoWQE5lWK/Pbk8esE2cNrqscHKfBWOydxbyWxxsKuwRfkvo0DU=
X-Google-Smtp-Source: AGHT+IFqkOQ425CZ9HmV0W9cSIsAGs7sDRjX0/G/h21LJTdrIAx//TCFVCjqyP6rhlEYuwiQiSdwcw==
X-Received: by 2002:a05:6214:5d0e:b0:6b0:72ef:2877 with SMTP id 6a1803df08f44-6b1a7ad4ca7mr21677346d6.40.1718200223971;
        Wed, 12 Jun 2024 06:50:23 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b075e37080sm39031086d6.46.2024.06.12.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:50:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHOMn-0090iX-Nk;
	Wed, 12 Jun 2024 10:50:21 -0300
Date: Wed, 12 Jun 2024 10:50:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Message-ID: <20240612135021.GY791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
 <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240612131946.GT791043@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612131946.GT791043@ziepe.ca>

On Wed, Jun 12, 2024 at 10:19:46AM -0300, Jason Gunthorpe wrote:
> > > I prefer not to mess the definition of user API data and the kernel
> > > driver implementation. The kernel driver may change in the future, but
> > > the user API will remain stable for a long time.
> > 
> > sure it remains stable for reasonable reason. Here we defined some
> > fields but they are even not used and checked in the kernel. IMHO it
> > suggests redundant definition. If there is value to keep them, do we
> > need to at least verify them same as the completion record?
> 
> They are not here for the kernel, they are here for userspace.
> 
> A single HWPT and a single fault queue can be attached to multiple
> devices we need to return the dev_id so that userspace can know which
> device initiated the PRI. Same with PASID.
> 
> The only way we could remove them is if we are sure that no vIOMMU
> requires RID or PASID in the virtual fault queue PRI fault message.. I
> don't think that is true?
> 
> Cookie is not a replacement, cookie is an opaque value for the kernel
> to use to match a response to a request.

Oh I got this wrong, the above is the response, yeah we can ditch
everything but the cookie, and code right?

struct iommu_hwpt_page_response {
       __u32 cookie;
       __u32 code;
};

What is the workflow here? We expect the VMM will take the vIOMMU
response and match it to a request cookie for the kernel to complete?

Jason
