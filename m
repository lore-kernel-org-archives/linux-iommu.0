Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42F127E0D
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348360; cv=none; b=AaeLQTfn33+IFlnDuaVdf/T2Fm2zadVusbtw1DOj6ZL930VPhQrjKOtxkHvAabN/I2Bmch8YmEdSv8X6AVCMrQvbzhGd/tCOBfRsyxQ+Kts5OW9nJ9/jHsNTLbvuDU8LTRpP8cq3hYMb0Hup2GUxjSqtLcwkRfxY7Sgl6OKmly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348360; c=relaxed/simple;
	bh=S3PWVcPLr1dX8LF8lbNqL9BTLtoY8MY8E4uSnFJY7DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ1LKNth4ztpkGacqNdFPTJ+hg/AhXD/72Y/RB8n40pt+LDeqUxwDrz8meMvTVUOg2aLYpvQAU8PQDuxbs3wY/iQHUzs7t2Ypvt7AE4QP8UBzz1dUaPghu91mgRKHWwaz/zm1+re5ocwP3zlFQ3JTwBblp67jdYSWc6LZv8PsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bZ3hE23W; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bZ3hE23W"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43de92e234dso20696721cf.1
        for <iommu@lists.linux.dev>; Fri, 10 May 2024 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715348358; x=1715953158; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+RTUECXr8LV6dsVCr+XO/1bNGoM61WJWMM3wIZuHWM=;
        b=bZ3hE23WFG2BLiKFItdBNgaTz+RgGSdu3kt9fBRyM9Uq4Efq7QoeYyk6uJ5XpdCNhQ
         xa8YlrtVSb/h1dLCReU5JfcrM2ghyzTJrTewFB9xVZnxWOQW9gvuC1k5i7/Iot4eoGxp
         SXPqMtyWiGQxh7hY+rII/wNfZeViMNKkRskMgf4y2lFwQdvRipPun25xyu0NL9cjcoM9
         yCOpu+Oq1DTtP9StlThhnikTZ04aoLuO3Efv6+6u7UEkQgkTrlghPqaEirZV3XBUb51g
         Aox1/K9eP82+nb+j3OA1rtbI/74IRvw6Kb5e6kDd2iOSQ/G/FeV0wnMnBpWvuBeEo5ML
         zhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348358; x=1715953158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+RTUECXr8LV6dsVCr+XO/1bNGoM61WJWMM3wIZuHWM=;
        b=kyq3ZaU7UFZ5WzLL6KclBnPd7cTkA64Tv5Cqa1b8tlIoX7NjdcxBOsrDYwL7/vxHal
         YFf9pTVdnsJfvyweAZzomOlAWWR9Em+2U0cUxvA4kvq51i01++Jf3OkKQxEGJoUcs9V6
         87Z6WlxW1Q5Fqrnqvkc44tCJyPvrbGvulPfe45i1KsITqL2HHwwXp/HPdlKllM/Gp7I4
         vICULMD4hCu+iXegkOEJEwzkGAisI2gt1T9UdtDR4KdR4BGp3JOFPm91K/Hnef1ZIQmX
         zbphmV8l05PeZwGn9ereT+NxhfDjHMrwK9AyAimJ3S5wjLU8xZXysg80WcWSjCd6pqxv
         3pkA==
X-Forwarded-Encrypted: i=1; AJvYcCWIK0WT8pM+sGGe3PlOyPA9ZdvnDb8O7gdpgPuWdD3ShqnvL6DyUTr7X/oWO0dR60sQ9DnPU5NhkIW3aUY47bxIB9Vybz8=
X-Gm-Message-State: AOJu0YyvPgKWERYoFcsn6Hv3pcaivmn8URC4pt6nwP6cn0RTdCHfaRCW
	sRo0Df3n1X0H9HfiKB4IOsEA7FNG838NOcCrtOXXWptbzF0cUOK0dOE+tDpGQTY=
X-Google-Smtp-Source: AGHT+IH6Xw8gGuqZr95qyqNM0r9axJP/CbWZNxoYFGO4ShQvgevQy0mPDi2AqZ8yxbLD2P81pSHTKA==
X-Received: by 2002:a05:622a:1988:b0:439:baf4:619a with SMTP id d75a77b69052e-43dec29796emr107215871cf.22.1715348357837;
        Fri, 10 May 2024 06:39:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df569ba65sm21354511cf.70.2024.05.10.06.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 06:39:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s5QSy-006Cvp-GK;
	Fri, 10 May 2024 10:39:16 -0300
Date: Fri, 10 May 2024 10:39:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
Message-ID: <20240510133916.GX4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
 <20240508001840.GO4718@ziepe.ca>
 <065cfc43-b164-4817-9be7-8f37585742ec@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065cfc43-b164-4817-9be7-8f37585742ec@linux.intel.com>

On Fri, May 10, 2024 at 11:20:01AM +0800, Baolu Lu wrote:
> On 5/8/24 8:18 AM, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2024 at 10:57:07PM +0800, Lu Baolu wrote:
> > > diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> > > index 13125c0feecb..6357229bf3b4 100644
> > > --- a/drivers/iommu/iommufd/fault.c
> > > +++ b/drivers/iommu/iommufd/fault.c
> > > @@ -15,6 +15,124 @@
> > >   #include "../iommu-priv.h"
> > >   #include "iommufd_private.h"
> > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (idev->iopf_enabled)
> > > +		return 0;
> > > +
> > > +	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	idev->iopf_enabled = true;
> > > +
> > > +	return 0;
> > > +}
> > I would greatly prefer we remove this from the drivers :\ I guess it
> > is Ok for now
> > 
> > Doesn't this need a counter? We can have many fault capable PASIDs?
> > That will get changed in the PASID series?
> 
> Okay, let's design this more gracefully after the PASID interfaces are
> landed. For now, we assume that the device driver will do this.

Well, for now to work the device drivers do still need these calls.

I'm trying to get them into NOPs in the drivers so we can remove this.

Jason
