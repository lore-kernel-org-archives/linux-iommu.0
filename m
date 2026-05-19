Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEA32571D
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202791; cv=none; b=HeGLkYmx2GJ9gbsXUWFWINAru1erk8251xvYGefvHkxhHHh6iYZa4vYoGeHVOL0OsQM3qGBGKBP9bnOcQsVq89FuBTXPHAlcQIVovlrvfL+N8vWg8O5TQWhi5CypTB7CDupEpnaCdWwgMepSTXekvyMoJ1+HMKMZpBhNsMEo8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202791; c=relaxed/simple;
	bh=VKinmpkc0sPkaF+DR1uUp82//Kl1UNBgVB3kTHmnB1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7wq7VVCpIpmXRbQbpr8ktaaTLuyi6t/lyds7mgtqNB50J5Ll9aj8Ur8NZwALhkQqzn507p22igywbjc4vg5619rKnUe/vvjV56zlNc8UHF4vfrUiDIhBkn3Nhdtqw/XtTYeGe/Rs9P7DhP/oZiBUl4L18jy0l5104q3068UqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gttEQg/y; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gttEQg/y"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e5c7eb565so43474171cf.3
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779202789; x=1779807589; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7hUyn5iO0H7X7Ga+pTWTO+vfWmix946/pxKMTlOtbo=;
        b=gttEQg/yDojrP9LH9p8S79u+fo9tZ/dLztPl4KjcKn3vy39Wt43l13pLxtz2LS3T/j
         n5WyquaQtB5I1NJ4owmUoLGlMNkaj6MXukwZN3kqDp4DAMgV9coZ67WJqRkyQBaZIyj5
         9sfnLDaDLQc/FM9nd3jLnQDGEkPQ2QEQrF7NZaUqh3cs/WpEzmuE1r/8ZICB3/bebeQl
         cuX9MWoSHdtH4TOXAVkumTRWGxvNJXEfyrQ1HEYN7Nog9dlRlBZzpXpGLzY/VSOB14Pv
         PY4H8hkHUjHXs8YdfW+w7eVwgMbbRsA/k6DchZc9q2A8rx0ij5jqm2ziNn2UPbfewmzq
         VasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779202789; x=1779807589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7hUyn5iO0H7X7Ga+pTWTO+vfWmix946/pxKMTlOtbo=;
        b=aFOITiDRxnH4hdmoulsjW6T71btYiEYHjqMKrHpIigDDA6ANJQ455Okk8qlxmzjHyc
         fNH21kt287s/NrxNpwH4YSP23b7P7iHSZB7qxDDYXHHx92+nLs6ltr07aufIjC0F1+sg
         YyNoOB0O/6XMYp5sX6se4i/3cLFUX42PLnBJt7CTIn16/WfdwjCkkdbL0jlbcNnqes/0
         tBEnPDgWvCsGYUdFvEDnBEhGl9F6cE4O0nmp7YE2eYIwrvQQj70vCFqcmUlO/Hoj8ot0
         R+g28xRPhjoQHHzfVDhXVAQNtcMQ4e0x1vZq0SzXHtKxeZz1KFF7oYRwW7ASbjHxmXan
         WkkQ==
X-Gm-Message-State: AOJu0Yyyo5CVG4ZAWSG2sNth6alSKgRlfg5cQB1MTrGozBKmspTP/zYl
	UYj7cVx835KEgRoSmJf2496C6GTLXaYBgksitvL3V/l9bID0WhcRZ7VtPbYJ8puAJeg=
X-Gm-Gg: Acq92OF0US9Ci2K67rAYM74YRcEsZPYvsg3RiBv6PQGn3ZoQltw5HAKPDDJUGYAU5Iv
	96bTqV7oUFDtDoS9P7Vb+e843vnM80P/ualBRGPYhYSymrmjoytPxM/lXIAG18dLSmqsFPb8FDA
	3/wwvhwjIv94tjl42nBX1djqWaL7k5kPv8ZXo2/CwjR3ZUTcabIMiOzZnMWR301egZqoogtM2re
	NY37kluG2OiPRcJXjAYYtVqZG3pWvJi+6tnuhhWWTgP6ndTxCPNprSgBrBQUpciWe3Bv+2VDh2r
	PQszP05LiOV+u2pu//AkfwAc+NQjv9tmwduT0a1XBj0yryrg0lpWFyHBq6ztO+DVYT3XNb+ZKnf
	0M9tII7gKjsTquhp2j+vJN/7sHWQTbQMHePoXtwPxOFXWD8iZLyMgeP+p3Oj/2/PnsanBf8/Me0
	cvM1lsU0KQkmCzIRC1g2z5a+eweWYWwZd96t9QWN5Mq/tt6H+e/u2EjnZnpoTQQRuCEm3CUTaW2
	ZEXi1WIFaNJwpuR
X-Received: by 2002:a05:622a:a911:b0:510:138e:b83c with SMTP id d75a77b69052e-5165a2760e9mr223529131cf.33.1779202788595;
        Tue, 19 May 2026 07:59:48 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm174979741cf.3.2026.05.19.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:59:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLv9-0000000F9u3-2Y6V;
	Tue, 19 May 2026 11:59:47 -0300
Date: Tue, 19 May 2026 11:59:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <20260519145947.GK7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agx5-jFkU2skyEos@google.com>

On Tue, May 19, 2026 at 02:55:54PM +0000, Pranjal Shrivastava wrote:
> On Tue, May 19, 2026 at 11:44:30AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 19, 2026 at 01:53:22PM +0000, Pranjal Shrivastava wrote:
> > > @@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> > >  	if (dev_is_pci(dev)) {
> > >  		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> > >  
> > > -		pci_prepare_ats(to_pci_dev(dev), stu);
> > > +		if (!pci_prepare_ats(to_pci_dev(dev), stu))
> > > +			master->ats_prepared = true;
> > >  	}
> > 
> > This should fail not keep going, it is a kernel bug if
> > pci_prepare_ats() fails.
> 
> Are you suggesting it's a kernel bug if the STU doesn't match?
> IIUC, it can fail because of the following cases (including the PF STU):
> 
> 	if (!pci_ats_supported(dev))
> 		return -EINVAL;

It should not be called if ats is not supported, iommu driver bug.

> 	if (WARN_ON(dev->ats_enabled))
> 		return -EBUSY;

It should not be called if ats is already enabled, iommu driver bug.

> 	if (ps < PCI_ATS_MIN_STU)
> 		return -EINVAL;

PAGE_SIZE is illegal somehow, build bug.
 
> 	if (dev->is_virtfn) {
> 		struct pci_dev *pdev = pci_physfn(dev);
> 
> 		if (pdev->ats_stu != ps)
> 			return -EINVAL;

The kernel failed to setup the PF, iommu driver bug.

> If ats isn't supported or if there's a STU mismatch, shuoldn't we just
> ensure that we don't try enabling ATS for that device?

No, the kernel is broken somehow.

> Returning an error here would fail the device probe.. which seems like a
> big hammer for devices that can't reliably use ATS.. 

It has nothing to do with devices, the kernel is broken if it fails.

> We have a special case in SMMUv3 where we pre-allocate stuff in prepare
> but actually enable ATS in attach_commit, which IMO neeeds to be gated 
> based on client device's ATS capabilities?

Yes, all of this should be gated by pci_ats_supported()

But also failing to enable should translate into a failed attach.

Jason
