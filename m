Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEFA39281F
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083620; cv=none; b=E948FDEpIWX/aVJ42iY/EITQXIWqn25DyDrmwLoY8ba0EUZML0Qqp99/I7hD+R0U9CERbdW8xLCeFVLW1Gc+N2SsS/gb+TkgFo9YNfQZhlzT6bqGeL5OGN5ScU5Qwkcvb8Ksryf2MtuKf05yB4oKExf4zcE7kP26U7+wJ7igqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083620; c=relaxed/simple;
	bh=xA4n+GiO2krYOwYXl5HG2bO+X2yuhqHCokSQuZD8nPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IttZrZZmDFdM7wASGqLT69UxXLqdFxx32Cf/xz4BykvR0QesI+AhQr0IdB37nilktLQmdNlHavKgwXLZUQt3hnj0Z+Ebj7rg8ldP0RdSE/QaqER8ldu9Fifr8tByoZhkUxMv3eFJS8lgxnrj0axxW8Touz603FKHiSRN1eI76UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JUhQIYfn; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JUhQIYfn"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d7e7f48499so428887585a.1
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776083617; x=1776688417; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3PbZPnXvhTGMf08wp4zGUyWkrOGmA6vnbkCFh7iCiM=;
        b=JUhQIYfnjFMT2tN3iDvNp80RZ6OtbNJGcgQtjra8mjsyTN44yhYv0GrWpj1hHgIOmb
         fAE7OdPKXMzGGa84EbpbZBeVMMZSCvNulEffw65z5N1129rQmdXnIDwl29RXdmL8Us3L
         vNIP/J7+YKbgmiCAKLP0NhoDIuRmayyUqQlYFB5wde1YNqtUdGpVCiAJBZNJxp2hnf05
         1FrspUNonFwow5GymHGPywz1iChmR9lArc+k3K2Jo249oFjiXqqmIPgDdExccO6KJcpL
         XELv9blnh2/YZxp0+6Lb7GIJpR5MZgxaNQp603r2k3OvF3MG/j2cC7q1XM/pVCZEzq8m
         jiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083617; x=1776688417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3PbZPnXvhTGMf08wp4zGUyWkrOGmA6vnbkCFh7iCiM=;
        b=NIOuhmbdohSMt0q+d/Xn6M38J3mMhJ6IxMiocVzDpWQITUd3g7QJrXg75fM26Z9wJR
         EcHMssR+tMeU/mYB5tFeuMYGjcmexb4MwyHoUaBdjuRyqZHoxwfxEBcxsACbb4wj7Qhx
         Xf9evWntwAnDKu1d6zdgOTQGsW+Lc017y0QY/ZNFTO9DaBEDLXtoh+kZTVFsRaZW61o+
         hCHeFRJTVTYuV5TZdTcuakBq5h3Ru6bv1e6kuIcPValaru7qmO/GKKMBqqgUJX56FDHx
         rnQcfMiaknREahjh3emOLNdX9mc6UTLGy4Fguhp7n06VzVoocU6uwAmByMK6T4KciK3K
         sJyA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZKiq37OHG9fNIb18EsBQXlSSnjkU3d9AoF7pIGVMfJAsRaeJ3AhmY2A8uc/uzhkbGyMbznw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywtt3CGk8zPbZ/7nVmQG5DY+qusuCOPRHj86FApAVtE3cXR2l7s
	2aKW/xhMGLnh4uuYuIwy59mH3w+jUOt9x8oQm3L0ggClkOqMKb92QNHy9p1+luodrd8=
X-Gm-Gg: AeBDievePm+1JXHARvUt8jXn3YwfHW8wbquM6n9zl4c3rWCMILFGDWK7lWdAo4qanlE
	Up7iPOsuPAOKivvUhw9RnVa45vOaYLwo4mHN4oW1Lk7WUnPafYDqOHBsbgxF4NvNfNUrktyO92t
	D0587714DQl/hwWY6vGtaA+kCvI2WSl2zz5AiNZ4kpxeDRFXKTv7sECYHjz7V8GRZ5Cx7B7SlAc
	YBj3FVnsVoJ2zzNOPSBNuE9XyqsCx3exkmpTEBVPM/h2e+iUyvW+o2Af6WP2kpLVIY6RHW3HZ9z
	/QTgBoSVY7/wVt23PEqGeu5QgK2eQ+k4+c6WDIU2WuyKTP2tDxHpazINGG2jjjX7cyrqIzCZrFH
	f58EZHxmAeo3maK6AtTmw7sygaiQmt7gS18/Cgn1jNs9LHX7b63GY96WuOrc/6UylGuWpkQClbo
	OQHFfzcN/69jah3KMTwUqolAdHolap3uQ/QD0sV+GfG/qctlnfTkt0T/EVE9oE686A00tEMS4ge
	vLqKw==
X-Received: by 2002:a05:620a:3729:b0:8d7:cf69:3bf3 with SMTP id af79cd13be357-8ddcfea032emr2045008085a.54.1776083617086;
        Mon, 13 Apr 2026 05:33:37 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9637c5esm840380785a.38.2026.04.13.05.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:33:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCGTv-00000005Acj-2B2K;
	Mon, 13 Apr 2026 09:33:35 -0300
Date: Mon, 13 Apr 2026 09:33:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "fangyu.yu@linux.alibaba.com" <fangyu.yu@linux.alibaba.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"pjw@kernel.org" <pjw@kernel.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"alex@ghiti.fr" <alex@ghiti.fr>,
	"tjeznach@rivosinc.com" <tjeznach@rivosinc.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"guoren@kernel.org" <guoren@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommu/riscv: Advertise Svpbmt support to generic
 page table
Message-ID: <20260413123335.GH3694781@ziepe.ca>
References: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com>
 <20260411022223.91029-2-fangyu.yu@linux.alibaba.com>
 <BN9PR11MB527696935354C345259C39E18C242@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527696935354C345259C39E18C242@BN9PR11MB5276.namprd11.prod.outlook.com>

On Mon, Apr 13, 2026 at 06:45:07AM +0000, Tian, Kevin wrote:
> > From: fangyu.yu@linux.alibaba.com <fangyu.yu@linux.alibaba.com>
> > Sent: Saturday, April 11, 2026 10:22 AM
> > 
> > diff --git a/include/linux/generic_pt/common.h
> > b/include/linux/generic_pt/common.h
> > index fc5d0b5edadc..dfadf8a5752a 100644
> > --- a/include/linux/generic_pt/common.h
> > +++ b/include/linux/generic_pt/common.h
> > @@ -188,6 +188,7 @@ enum {
> >  	 * Support the 64k contiguous page size following the Svnapot
> > extension.
> >  	 */
> >  	PT_FEAT_RISCV_SVNAPOT_64K = PT_FEAT_FMT_START,
> > +	PT_FEAT_RISCV_SVPBMT,
> > 
> 
> nit - every feature has a comment.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Oh that's right, please add a good comment!

Jason
