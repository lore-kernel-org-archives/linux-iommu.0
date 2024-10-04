Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C11E3DD7
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055908; cv=none; b=rkDIUpyzLgKqlzW1flzPSE/8yYS6sC3INU4doywM1E9YE5SUpyS9bmrdYMPoyQa/aBfH4b+PvQhCQ8OZIRWaoUn1qvZnp0dnGwzAEsU7a7DfGwOKV8vZSaCKpl9tZu/e3HHedxZ+HucjrWUjgDu4T4SlR2YA6vYSbHPt/upOnk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055908; c=relaxed/simple;
	bh=Gqk4mDcFzBVevxCSuWfb1IkFnn2QXTe8muucY2+Ijao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTQ2rvDO2TVN9A2ynpl44ojWB7+kpl0Apgz8b2w+BLwmxVCUCMZ92LvgmBdrTP6dSXeC14Lk9mtojjoHApPgSraDGzVCRK3R35HSbWKD7Y2UXIUZDy9Sja+m9fNkeFAc/Syb1kVytDJbgbuklmAcrOxHdvH6xH+e3QiqVa0UQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NVjwxVS4; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NVjwxVS4"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71116d8504bso1390599a34.3
        for <iommu@lists.linux.dev>; Fri, 04 Oct 2024 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728055905; x=1728660705; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/r0XcxwvX8DGEJaetAH8HLEcHZJ0Nm0nno+bUbMhbw=;
        b=NVjwxVS4J3nJbMX7f5myHTnRHyqwwwrfPF2aj0/0Ijsn+NPG8S7fsQDSXMnP8aSgw/
         3RHpVZ2lBNRA8uIspB8rPQ/1y7dB86+zMGMmN6508oI4TZA7tY/T0JZGBOOtM8IXvv/J
         8RtvsYM34hzmPCrp3BeOqQkT2h1giE/IvSO9Lj71XrPSwrLfq9kjRhN/LFNfvSZEll4X
         P3A53SlJqjg05xxY4We4UpBWWp5oGzkoIjf4sBxhMi7HMOxExyyOmgRlT+4w/EVVYJGk
         5fMlEHMUTa6tDnOckQUb/W3kZ0JrJ57BQjTialcnOxynOB3NCqc9k1tGvSNtNbrW4gvZ
         RWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728055905; x=1728660705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/r0XcxwvX8DGEJaetAH8HLEcHZJ0Nm0nno+bUbMhbw=;
        b=Rpv3t6JukjP88f/1NNO6MoNpLxPsp1DPQjgUjB0iGINnZdbTA8B8kSFv55F5ym73kj
         D0kMc8CI2Mc6lTjhRIYV31pAnKVgl6bzxAiMu8AdGV8P+E+Uwdjmtn0dsdVHlUI/66m7
         02YuTRB2IYmpjyt0AG5zHPyam2HvuVfDSxzsO1J6JXdWTggIQra31YawPzExwNq20cgq
         2aUu78VKl6gUAnR6UC6/3saskE54mCf7QWFDgaaA5XTzkCdtlC27/F48rxGjojkYNVbR
         c83apVKAUBPkcwzJz5zmh+aYKOISXxK4ZwVvNEUeEzl7elmtfvPxVgSXoeEZd4pFuFuK
         W1Pg==
X-Gm-Message-State: AOJu0Ywb0rvGl2Yn0mnSfBNqnNrTTtK0UwULc6w1RiRKkRkb+CnYJCAm
	+d+/D1KXTYi66pVw5GCH7B3s38rKmJeDWKAXGxuXTHtsWfpe/X47MhIjEn+1kh2h4fNUUOuHzf6
	6
X-Google-Smtp-Source: AGHT+IEVBqEReJJMXxhaMwmoooubLLpX90dZRANcC76XtkyBvt0yxNG6/LfTcW2KU1CY2q8cUN1rLA==
X-Received: by 2002:a05:6358:e4a7:b0:1bc:d1ba:225 with SMTP id e5c5f4694b2df-1c2b7f6efc1mr112473155d.10.1728055905325;
        Fri, 04 Oct 2024 08:31:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da760f2f0sm41961cf.78.2024.10.04.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 08:31:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swkHQ-00DKdI-0k;
	Fri, 04 Oct 2024 12:31:44 -0300
Date: Fri, 4 Oct 2024 12:31:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 7/8] iommu/amd: Add iommu_ops->domain_alloc_paging
 support
Message-ID: <20241004153144.GI2456194@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-8-vasant.hegde@amd.com>
 <20241002193345.GR1369530@ziepe.ca>
 <1f6110a2-a21d-45e9-bfcb-7d3650ff889d@amd.com>
 <20241004125606.GH2456194@ziepe.ca>
 <a604541d-6de5-49f4-a8c2-190e68356acf@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a604541d-6de5-49f4-a8c2-190e68356acf@amd.com>

On Fri, Oct 04, 2024 at 08:00:15PM +0530, Vasant Hegde wrote:
> >> I thought eventually we want to remove ops->domain_alloc() interface. Hence I
> >> introduced domain_alloc_paging(). I didn't remove amd_iommu_domain_alloc() in
> >> this series. I was planning to do it in later.
> > 
> > We do want to remove domain_alloc
> > 
> >> If we are fine to keep ops->domain_alloc() then I can just drop this patch.
> > 
> > But why not just remove it and not add amd_iommu_domain_alloc_paging ?
> 
> Because we have __iommu_domain_alloc() which calls domain_alloc_paging /
> domain_alloc().

Oh, I see what you are worried about. __iommu_domain_alloc() is almost
never called now that most of Lu's patches are merged, and it is not
needed for any x86 platform case.

Here are two more patches you can grab that will remove it from the
remaining core cases and then you don't need to worry about it,
everything for AMD will go through __iommu_paging_domain_alloc_flags():

  https://github.com/jgunthorpe/linux/commits/for-vasant

Lu should be able to delete the function this cycle as well.

Also I noticed a little mistake:

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2071,7 +2071,7 @@ static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev
        else if (ops->domain_alloc_user)
                domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
        else if (ops->domain_alloc && !flags)
-               domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
+               domain = ops->domain_alloc(type);
        else
                return ERR_PTR(-EOPNOTSUPP);

Jason
