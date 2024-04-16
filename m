Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CC41292DE
	for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267581; cv=none; b=Ntkqn6rIBESVpObrgCLcICzccQh2XevYf6n765+sHLUG2PtvOmM9cz6SIbhs6BzMxTQ0R8NgJhSliR90xkVlUbphipyDeMrCH4JYUAsSq0FbSpX4cPpOdKArRXcY2seXiigK6KfJFi5SCJGnQPDGOegVC6qI9P5+CEdyYmhuKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267581; c=relaxed/simple;
	bh=InoIyfxzvCQPOkhkpXX4VHXf6BcyC7JfNME5c9a2Ef8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdfM8xBxyqb18nRzsB7F/7Ow9pgQ2nYpyUfhYFcLYILSNue+GkwhSgriVZxkmTnNK70WaCgWlL87C5P6SU2zWRcOpJjBOSIXy0SklelQW27IHb4v2uOfBacFd2LUpfQsQjvNKPAOp53XRAdQxWuivj0eiphrgccJk4JWp4TzxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Mr20Pv9a; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mr20Pv9a"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78d743f3654so399517585a.0
        for <iommu@lists.linux.dev>; Tue, 16 Apr 2024 04:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1713267579; x=1713872379; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z9PVIz4MTE4YzFeH8WAZ9AriysdnNs2lDXckOOjjO0Y=;
        b=Mr20Pv9aLyNdEVmG5dV0+cya+nQAIe6mA9NdJFZFrwrf3+OW+9LVvxqR2qpmkYrCzB
         oG0YV0omVDp+7dUyVicdScp3nmAnv5LLeax85887I8gk0HrAg8F5881Bxx/XFY2xiP/Z
         bkNY3b8nX5/UhacRjsRh2XuHYpWsyZ+W6inAKEYKO5+dca+807sF/SjqnOCaSf/5gxc2
         t59cjnvijyitsBg2NDpUA0z5dN1I2i6D3GZATog8Xbh+YwJB5ysywu4CxEwqcP2C20Cu
         RV8o8zDLvq2xfLIGlpFHffqhNQu/cTMXUZu04e52Yc4lA7bK5k+C4PqodpQ57MDT2h+1
         wbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267579; x=1713872379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9PVIz4MTE4YzFeH8WAZ9AriysdnNs2lDXckOOjjO0Y=;
        b=M/FVqtKttcr8OaXPQT/1Dxrw67VrO5IsZV+NhEUSkZCN/JHXKzBnk6XhvqjAgCe9f3
         Fv3BiafRitA3h4awv8egLOaj+TG04eoEQDw6ChxoGqnUaAOAjp0AVufJALDLjwRLPUiu
         LHBuyoHpne0vVax3/TjBkWFSZsT43ek5U17c9KOo8r5Z5QXZz6pltZPsqopxHf2OHpXP
         rr6Li9UkFSJw/ejJeJVtNF0Fuk2saxzroqrnjAHcwrmJTJbGyDO+boIPauasE44pgLxV
         Y4KoY+yWGC1ePbeSbk0iJ0rmkIvwAO4sDNCfwr4lhMkXozK9p9JLh0f5SwIqs4bHAOai
         CifA==
X-Forwarded-Encrypted: i=1; AJvYcCWkgQWBpFOVjCCt1L72xtWKpah3QHGPofOAClk7HbCKNpTVx03TxUO7GFTJ7EMNzInoOi5L9+it320TV6zEgAl4h5mo98o=
X-Gm-Message-State: AOJu0YzLe4rDD8q9WME3WRBg8QOw+lbsLNGX2wY/PJoveaf9AEjzerQn
	ENLCiYh/U/gez0+tOKgxsTVBFhvYHgy+b2siEE2fgzPW3/Qt5zLLxmj/kySWEA4=
X-Google-Smtp-Source: AGHT+IGnl3TattqJdjvTobzss8eUIeX4uff21Y1NqSeGZBSY761Ab4B/DJXPR8G80OCLuExKCWZJng==
X-Received: by 2002:a0c:eac6:0:b0:69b:5f38:1a47 with SMTP id y6-20020a0ceac6000000b0069b5f381a47mr9693763qvp.42.1713267578889;
        Tue, 16 Apr 2024 04:39:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id l18-20020ad44532000000b0069cc3a02eebsm920453qvu.4.2024.04.16.04.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:39:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rwhA1-008Zp0-S0;
	Tue, 16 Apr 2024 08:39:37 -0300
Date: Tue, 16 Apr 2024 08:39:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vashegde@amd.com>
Cc: Eric Wagner <ewagner12@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
Message-ID: <20240416113937.GS223006@ziepe.ca>
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
 <20240415163056.GP223006@ziepe.ca>
 <CAHudX3zhagFWBv4isZzAtC8dA7EAAtY6Yk7fkJ31hf0D9zrNqw@mail.gmail.com>
 <65d4d7e0-4d90-48d7-8e4a-d16800df148a@arm.com>
 <20240416003903.GR223006@ziepe.ca>
 <CAHudX3x-ofB=-K6UwWpf4r7Ge9AQbvLQ2qq2C7N-R5LG2qMz7Q@mail.gmail.com>
 <a80df9b9-92a5-4430-8802-1f8d159d6162@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a80df9b9-92a5-4430-8802-1f8d159d6162@amd.com>

On Tue, Apr 16, 2024 at 04:23:38PM +0530, Vasant Hegde wrote:
> >     Yes, if the driver wants to force a domain type it should be
> >     forced. Driver knows best. Eg AMD forces IDENTITY when the HW/driver
> >     is incapable of supporting otherwise.
> 
> 
> @Jason,
> 
> Looks like before commit 59ddce4418da483, core IOMMU layer was enforcing
> 'IOMMU_DOMAIN_DMA' for untrusted device. If its trusted device then it was
> letting HW IOMMU driver to pick best domain type.

If the driver wants to force identity because paging doesn't work then
yes it needs to figure something out..

Really the drivers should not be designed to do this, they need to
accommodate paging domains in all cases if things are going to work
correctly. The def_domain callback should be a last resort.

> >     diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> >     index d35c1b8c8e65ce..f3da6a5b6cb1cb 100644
> >     --- a/drivers/iommu/amd/iommu.c
> >     +++ b/drivers/iommu/amd/iommu.c
> >     @@ -2758,11 +2758,16 @@ static int amd_iommu_def_domain_type(struct device *dev)
> >               *    and require remapping.
> >               *  - SNP is enabled, because it prohibits DTE[Mode]=0.
> >               */
> >     -       if (pdev_pasid_supported(dev_data) &&
> >     -           !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
> >     -           !amd_iommu_snp_en) {
> >     +       if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && !amd_iommu_snp_en)
> >     +               return IOMMU_DOMAIN_IDENTITY;
> >     +
> >     +       /*
> >     +        * For now driver limitations prevent enabling PASID as a paging domain
> >     +        * on the RID together.
> >     +        */
> >     +       if (dev_is_pci(dev) && !to_pci_dev(dev)->untrusted &&
> >     +           pdev_pasid_supported(dev_data))
> >                      return IOMMU_DOMAIN_IDENTITY;
> >     -       }
> > 
> >              return 0;
> >       }
> > 
> > 
> > As it booted ok with Robin's patch above, these changes to
> > drivers/iommu/amd/iommu.c didn't seem to make a difference for me. I was
> > testing with amd iommu v2 off in the kernel config and I also have TSME
> > enabled in the BIOS if that matters.

There must be a mistake in the above then, it would be good to sort it
out because something like that is the right fix.

Jason
