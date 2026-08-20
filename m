Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78F39CCF9
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269047; cv=none; b=KuJyxfuAyKqzeSYnChpWTHOJensLa5UYtO7/ZHIHZFDx0iJXoNeMKiVbgCcRFOzuOiqSPKKapinKOu3xVPIKbKWtkQ9KEXmMKzwN4nrDn/FIHNsY2/KakVtpjSNuHJelMLjvVJxovZ2PKDMYxLbbmGs7kt1Wm86m47jFuxdNJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269047; c=relaxed/simple;
	bh=InEVFTLgsWT02bOUOgnGmif6wey2/aq2SBg+dMmvUA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekbZD5bkW8evrNFxv3u7LNMNOoJwrWRPe4aIetrfje0VmmPGDfVcMNSn06BYIer/dAEQcNQo9jhC0IiUlVzZmk9Nn9B8w/P5NBcmaExnUwXm8z17FEV5J+Cib0WWcwNBP3iWzU15ECsm3Cve+Eun0I1w5cabJygdZkEoOpcjh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WeAVsCu/; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WeAVsCu/"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92ed3993c1eso21492985a.1
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1787269044; x=1787873844; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TwdiO/ha14aqZZoymZaYgDW2JuO6Qn7ZG4BkebgqYts=;
        b=WeAVsCu/1Txq+1rh+TkQyL+wmAFvOWuhXr9nZ+GmQia/Y9tPEM1McFGfH7vjG/8hMi
         00WH1T0JzXrScFea56SfpcnUUKc//q7l3Jk7AmusmzOjRIcZVz4yeFs9mWDk0EuNzOTD
         0FcigWGngd7xMPqdJLUX/QwiKBvJjdqBuKrKiO3qaLzTMLftplRRJJTcxfd8xy23llFa
         nV9ttkTpNz38hhVpQhbmuEP3oV0X+GqGIhKmKDRuTtIyds9HYavT28ddkKkmnNumo/6L
         9ayc4DzmItBLeTR9u6qlG4RcEetk9QimEIUc64oAS4rm/ARIExf3aSc8gGx91ePcAxcC
         7ZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269044; x=1787873844;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TwdiO/ha14aqZZoymZaYgDW2JuO6Qn7ZG4BkebgqYts=;
        b=gc84A+9DG1iO404Wcl51w3bqTGRUOn6bipLhfuLHPDepYRpJgVL4zSJyvFZ2wtvbpk
         DJusVum8gBzSM5RJGeAL8Qzo1fONyptGbTi4oVJ9rXoJ1hsW8unRZN1QvwqwnuizDZNv
         dI9MD6GdtEPXXXTopCoivM/gL+/8tAT1JEOZ4ijXTn+ZZrTbEmNE2xdQx+BK2w2xXaxU
         wPr1l1NLVUZZBe6iO1ASRkS3UE39hWsPAIohKT7ROJc4qw4WzLzgN2Kty3YOwhT3WLvd
         Ai1d5MQFK33zyPBJMVlk4XD3ebfiMHSHXbV0JYUBHAE7Lxi1f/SYOkDrESvMFQoDSIte
         ua9Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpic28JJi2tm03pnhB0fUgCTcN5xqyzvEiZuBSa/qTLoJMLVdsGiaF+3IfT/Z0yWNgN2r77eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvPVO6h1pj2MTCXy4wuAvhMSX/Wlz1xl8pG09l1BeFa5HoYH9H
	zmhqIoBHHlO5IYU0L1r9L6V8DoH9dNttdFD9yOfsDgT91v31YKMtT8rInbtZ6O51Mes=
X-Gm-Gg: AR+sD12y9lzcJvHUFhfG9k4mzQMRMkAF3fOpeAKqCE53diwPLHnnVRpscz/6GByf/FN
	SDGW52tAChtGU8ye46Q5ZMUsW2OuJk3DnqxwgWK5yOWPTI67muv3YhD7hLInszxa1fDZdD1ON02
	MV5DJHSC3aGqvlGxWBbWGg/kYnk/iE5T4elGPKI8fpHa4YWG9iTQOGHYiCJRKP6biS56aJsKP+i
	TZJyYDdOA8vTSk/FVQXb9193PHD79qB6sp5heQS4FEwzy7Qwrhhy9VMK/Q1k9k5eBpe62+Yw41i
	t0BYxv29Qfo5yJ6Mjp8bgXPmvgFFrwMGQte/d+4dPVYjphGflo6R2qXHZVN5NqAqt+rFJPLjRgY
	a5LLWmCgXhs5qL1DDmpHtXSg5JtesaqouP6WV1pBVFZcv/7k5c9xQbjFT0SwicNzMe6whqcic8R
	cdcy8glrozw9gvl1ZCUknclOwgy7WwNJ8H9j3DwEmBuYciDqo8A2jbG1itkYfMBRKJ/ASTqWxHp
	wRRI/+wJo4TFk9OuDsto9g4Vtt+CvgdeiD8Tq4PX8j2B1g=
X-Received: by 2002:a05:620a:2910:b0:937:1e9b:be6c with SMTP id af79cd13be357-9373942b0e3mr192488885a.10.1787269044209;
        Thu, 20 Aug 2026 16:37:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720586ea5sm470176585a.38.2026.08.20.16.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:37:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wxCK2-00000004fvf-3PzW;
	Thu, 20 Aug 2026 20:37:22 -0300
Date: Thu, 20 Aug 2026 20:37:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <20260820233722.GA1110819@ziepe.ca>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
 <20260817121810.GC933791@ziepe.ca>
 <CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
 <20260818140304.GC5482@ziepe.ca>
 <20260818143906.1f58aecb@nvidia.com>
 <aod22_H66eUth9av@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aod22_H66eUth9av@google.com>

On Thu, Aug 20, 2026 at 10:38:07PM +0000, Samiullah Khawaja wrote:

> > The blocking domain operation looks like it might be simplest to
> > implement in the IOMMU core.  We can set a flag for a default blocking
> > domain on the IOMMU group when we take_dma_ownership of the group.  Then
> > release_dma_ownership picks the blocking rather than default domain.
> > 
> > This is then unwound in use_default_domain, called via dma_configure,
> > attaching the device to the default domain in probe of the next driver.
> > Therefore until probe by another driver, a device used by vfio would
> > remain in a blocking domain even while unused and unbound.
> 
> The devices are expected to be attached to the default_domain even when
> these are unbound and the use_default_domain assumes that, and it only
> checks the ownership and doesn't switch the domain to default_domain. I
> guess we should add a WARN in use_default_domain() if that is not true.
> I will probably send out a patch for that separately.
> 
> I think we can move the device back to default_domain after reset after
> unbind, maybe it can be done in pci_dma_cleanup() based on
> driver_managed_dma?

This blocking domain stuff sounds very similar to what Nicolin
implemented for the per-function ATS issue?

Broadly we must setup a blocking domain in the iommu if ATS is
available across reset or you get these ATS related issues.

I think at the time he looked at doing SRIOV as well but it was
tricky..

Jason
