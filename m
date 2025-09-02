Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1BA32A823
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830543; cv=none; b=qf1TtiJdE8gBzBoKQcce69vT/eeLTlFwi/VC9lvo1EiBSWRqNF/ae0VQEY2TsJI1RMve0918BBVbE0T2Eeh/B7AspDOabG1I/lIj+0Px5bBwiYpLw/nWixohXCqFvTBbIk7cXNEnBGjTsZREW6ILtWHralPQGRpz98IuU4+PDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830543; c=relaxed/simple;
	bh=TIGUtVmXfyG5AOMlrQu/Tk0wWcNgx23M3QCPxT9Z208=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pow1jYsABLs0MMTNsc52eTpbc+nxiWyldCESYDl1OJs1x+DSGttKEWm/tmvOVjE9o3SN1Om99Amvho8R+vINdvZ0VjD9/+5FfAYI/x85+HjkHaoqf5XFDKlu0WeIbNGT387b5b5ePu20vz0HkWh16mN2hTpaJ2uob21C8Vhx/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aY7P301g; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aY7P301g"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8080a88a32aso47209885a.0
        for <iommu@lists.linux.dev>; Tue, 02 Sep 2025 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756830541; x=1757435341; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzNFRizoK0DA+pBHHDrMUD4m1SbYvscM/f3av0PJpIQ=;
        b=aY7P301giDjctvrc15X3WcLhyAx7JCcwDW/wdkNyNwtsIJF2ns3x3q39W34R1dsoLa
         /bUYv9WB0vXiKivxBZH3uKKqF90h8WNj9x2kN4TA3H/1FdjLCUagXzyKcLWggLszsULd
         4uB3W8NdtIArjq53+CAO6O8PihSBhlXN5jSzwYUGhECvqyD/w8oXlPxvZ8S26VLsN8Mp
         tEF2oRZvh7j24irAExWftbrrzXyEzknnSmxztLxf7oBUfNqYzDUiie/cTjXIP89k5mfa
         XiAUbjtbSZ5fOz7JaZFn0mEwRUyvk6kSGTsUsvKbri26PsaeIU5AMu4MdmHdsImRNKFp
         FpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830541; x=1757435341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzNFRizoK0DA+pBHHDrMUD4m1SbYvscM/f3av0PJpIQ=;
        b=wYEuDbLnB7UrW9+8HR86t7KTeAO/pvVRjXU0EGa/TuT7jJ2GqNV/A/8WTC+g/HcK9y
         5hnndk/JWmHgpILvzMXaTGo406vUUgeIPX1m39DF5K/a4g1K3NITtjKVST+EAg161jdA
         VIlCuByxMPDoaqLIRTyngsGebWNiTpYl/5Q5YBFBbuG4cLVyjvclOFB8TZjM1XZL/tec
         xgD8rKwp/2QcS5K9F7F0ejifVXSdLvDiR07m9Jkrz/Dl5jziaV5uI7/gvOUdaB53cMbK
         lNr4GhInhFMUp9r6+3/+HkqtUw1VoFWsf9oagp8CFr/b8T+knXR5NryU9dBHSy0vTrQj
         J3ng==
X-Forwarded-Encrypted: i=1; AJvYcCWsyuEcOhUGGbIipXwUbldO0q1zu2gM5A1yfO1sMPM0L92oUQVC+sPA+NZkSlS55Ob2VhfUPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfCMTdsSDIfcDLSPkBLn6pXVWblS5ltVHptliMPUtlTI+oJzmT
	ScwpphpzSJWk/+iI3zyBr7C3syMLMnuVtzCPIWepsxs2MRhjBPjC4qnp9pgnPD2UItQ=
X-Gm-Gg: ASbGncu88Qy+6Y86IOvhXkEXsU04G7P6mGfozAWpH0Lfvi8lXYLo5AJ0vpRu7GsSyWI
	KKZBqx7E8oSHdtQ8gP9ACMcyUswuErqS56hMzPkpHropVej9m/1s3eqK2Yf733SpUDE1GQJ7Jra
	d5r+jpAJTLGotJhEpZsneMv8XT6OoZljU6R50i5oWfXfHJSktwH2XpVJ4dNDKr7Gp09Pbz5/Gzm
	kSH89X3ypfUnJcv8WHR0ZHNqEpKQO4QuKCoi3xXM2JJj8//2NmBXjYG1fE3UFq23x3KP1KeBLKb
	x3BETbc+0G8zhUqtMDg7GmRI0Hn8QWQcQLOEw55dhLNPd8Dahqe3+mXJA+uaCqjAqBY8qwD3346
	RlI6oOpD7sfg+XVe+OJElPIsL5wD4ZhFi26rCONRDD9bMgTxOBfLglBf5+bAXv4i/vk00
X-Google-Smtp-Source: AGHT+IGlkUdvrs/4d/cbiDbFE0x0xyuHO/9lDjr2DrV2pOTG2L8+cMT8JXT2TmmRvRF3DAjlGXP+KA==
X-Received: by 2002:a05:620a:3193:b0:7e8:324e:ba20 with SMTP id af79cd13be357-7ff2aa20af1mr1183564585a.48.1756830541067;
        Tue, 02 Sep 2025 09:29:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069d6b1ff7sm162410985a.69.2025.09.02.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:29:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1utTsR-00000001ZjP-3QE9;
	Tue, 02 Sep 2025 13:28:59 -0300
Date: Tue, 2 Sep 2025 13:28:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>, dwmw2@infradead.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH] iommu/vt-d: fix iommu pasid memory alloc & max pasid err
Message-ID: <20250902162859.GE184112@ziepe.ca>
References: <20250830130737.1930726-1-guanghuifeng@linux.alibaba.com>
 <cdd1c8ff-6bb5-4665-a55a-9d86cd81a8ef@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdd1c8ff-6bb5-4665-a55a-9d86cd81a8ef@linux.intel.com>

On Mon, Sep 01, 2025 at 03:28:29PM +0800, Baolu Lu wrote:
> On 8/30/25 21:07, Guanghui Feng wrote:
> > When intel_pasid_alloc_table allocates memory for Scalable Mode PASID
> > directories, the specified memory page order is incorrect, and an
> > additional PAGE_SHIFT is added. There is also an error in calculating
> > the maximum number of supported PASID directories. In the revised
> > implementation, 1 << (order + PASID_PDE_SHIFT - 3) represents the memory
> > occupied by the Scalable Mode PASID directory, divided by 8 to represent
> > the number of PASID directories, and then multiplied by the number of (1
> > << PASID_PDE_SHIFT) entries in each PASID directory.
> 
> Do you see any specific issues if the changes described in this patch
> are lacking?
> 
> > 
> > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > ---
> >   drivers/iommu/intel/pasid.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index 52f678975da7..9969913b600b 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -61,14 +61,14 @@ int intel_pasid_alloc_table(struct device *dev)
> >   	size = max_pasid >> (PASID_PDE_SHIFT - 3);
> >   	order = size ? get_order(size) : 0;
> >   	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
> > -					1 << (order + PAGE_SHIFT));
> > +					1 << order);
> 
> This converts the order to the allocation size.

Yeah, I don't understand this patch at all, 

iommu_alloc_pages_node_sz() takes bytes and get_order(size) returns
order.

  bytes == 1 << (get_order(size) + PAGE_SHIFT)

Is correct

So why is this being changed?

Jason
