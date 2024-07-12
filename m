Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C317108E
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792542; cv=none; b=rwXwm3LDsz0THJsMrf3fexxM84hP+61cDKx/LkwKD3142toV43Ghg5KU7vII+L/pPcsRZKPixSfNtaetxun6tGZAluOzIuaOdQa5sHSN8lJOBHlk9yuKDbgcdvL/JahJtOLaGTWX0MDjjYv1tmRu2eBDEGS6gkVBh5I8IfWK7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792542; c=relaxed/simple;
	bh=OX1cNcAqitW8bA119S8Tgq+XqWBhTQluMLuFXQwd+7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVCvI17ZFoR9qlACJ8kA+eRmtq3L3Dear3c+8UbdbTH1VcnnDlYYB6RlxSaC5toMmYyvI/o8GQ5cKYgYclZj/PmKIEO3iOmCAoLftNxGY3/jbC0l36T0DEPBtaOXidFKAAIjywo21RNtxErg7ElWSMp5Bpk6imIEnK2AvAs1lJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aiGp1bCc; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiGp1bCc"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d9dfc7c5f6so910411b6e.0
        for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720792540; x=1721397340; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEg9gQ+TETol+cKWiqjwfBqevFIwNAUK9xvVwDmLtqk=;
        b=aiGp1bCcMYEz+94dDymjJBIHo9rruuGToLC0iYN3HXQ8gy14k39uFZjMKAIVClOxnq
         YZ9+o5+d5vCK7lpKEKCNEPOjODcUT2cOHXAr8vP/vosFAw3GJ5Y6HxJYHq/iDmKS5Skn
         vcjpPA3dU2MDegWpN4TwhU7Wj4w6MhC23N+IyIWDWiLCoOiLS06abtZh2NLD2pS/EXGC
         XRI/whSSzEsA2D5KfrgD349N86ZIdrhqcCCHmu4r59/ReALAlQOLApIOnhv/OQ+l5ti/
         1lgIP6w/d0xqQ30rSwGhI/udZCXcYemZPSJkLGH7bjlJfdYrXE3I1jx8it33iU0bhHao
         TTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720792540; x=1721397340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEg9gQ+TETol+cKWiqjwfBqevFIwNAUK9xvVwDmLtqk=;
        b=Og9RwPRWS8VsdMkx+BnwxwKZkoCcvR9P9KYNfQsWyVNV0DbJFa20Dw/VkVcLd3ZsIQ
         R+1CRrTkMM2ocUftU81cxS3ocYqMepEI6Qb9eHiIEEomRnvZOZc9yB5HiwYuKJU17MG9
         mco+E/n2Eg/PkrFDNspBE2eoHOwADnlhSD6ApS90Mzcq7Hn6Rln7HcTYmWmkWYpFPVIs
         fLH6r5QeW/fWiN9T3jDitClWHCWnrC+TRN6c9gOdx3BPDcKx016X3+Z/86M4LApyCqDX
         5nqrAx0vUKgoHWWsBUXcMdcnMkcS5WsAcgvxh79if6LB1f8L+XjTRndEs2hNWFt7jpLQ
         agvQ==
X-Gm-Message-State: AOJu0YwP4eFHNTeGirAPfimDYLNneFAqIbvU4C8uObLnA1AuwT46P2Lx
	MKxa0zzLbxxB3YiJJVdweYzq873zY6YKxExh7e6v4MlbH2nx7nv5KU89Xt3mqSncwuDVKQd6hUP
	A
X-Google-Smtp-Source: AGHT+IFXUPKAMC0B69FckapVuEiezLzO4gCnS/WZNsYCZIMqdwRuMCqfYLcU8BBS/WGN90c0lzfxsQ==
X-Received: by 2002:a05:6870:459a:b0:25d:f8ac:187a with SMTP id 586e51a60fabf-25eaec60046mr8459594fac.49.1720792540302;
        Fri, 12 Jul 2024 06:55:40 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa225461sm2172853fac.45.2024.07.12.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:55:39 -0700 (PDT)
Date: Fri, 12 Jul 2024 08:55:37 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev
Subject: Re: [bug report] iommufd: Fault-capable hwpt attach/detach/replace
Message-ID: <e9379818-8aa9-4395-a7f4-22d8c5d7b16f@suswa.mountain>
References: <8bb4f37a-4514-4dea-aabb-7380be303895@stanley.mountain>
 <8674561d-f14d-4735-aa86-24032e67c928@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8674561d-f14d-4735-aa86-24032e67c928@linux.intel.com>

On Fri, Jul 12, 2024 at 10:18:06AM +0800, Baolu Lu wrote:
> On 7/12/24 2:35 AM, Dan Carpenter wrote:
> > Hello Lu Baolu,
> 
> Hi Dan,
> 
> > 
> > Commit b7d8833677ba ("iommufd: Fault-capable hwpt
> > attach/detach/replace") from Jul 2, 2024 (linux-next), leads to the
> > following Smatch static checker warning:
> > 
> > 	drivers/iommu/iommufd/fault.c:131 iommufd_device_get_attach_handle()
> > 	warn: 'handle' is an error pointer or valid
> > 
> > drivers/iommu/iommufd/fault.c
> >     125  static struct iommufd_attach_handle *
> >     126  iommufd_device_get_attach_handle(struct iommufd_device *idev)
> >     127  {
> >     128          struct iommu_attach_handle *handle;
> >     129
> >     130          handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
> >     131          if (!handle)
> > 
> > This should be if (IS_ERR(handle)) return NULL;
> 
> Yes. Good catch. I will send a formal patch to Jason.
> 
> > 
> >     132                  return NULL;
> >     133
> >     134          return to_iommufd_handle(handle);
> >     135  }
> >     136
> >     137  void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
> >     138                                       struct iommufd_device *idev)
> >     139  {
> >     140          struct iommufd_attach_handle *handle;
> >     141
> >     142          handle = iommufd_device_get_attach_handle(idev);
> > 
> > Do we need to check for NULL here as well?
> 
> I don't think we need a check here as we have the code below...
> 
>         if (hwpt->fault)
>                 iommufd_fault_domain_detach_dev(hwpt, idev);
> 
> ...to ensure we are detaching an iopf-capable domain. This code should
> be paired with iommufd_fault_domain_attach_dev(). Otherwise, there must
> be a more severe problem. A NULL kernel pointer deference warning here
> would be a good indication of such a problem.
> 

Ah.  Thanks for looking.

regards,
dan carpenter

