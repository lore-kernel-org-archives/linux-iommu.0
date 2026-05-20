Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096ED3EE1D3
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287401; cv=none; b=btyMWHoavbfkiQZ2UF237I+QtbaDd4TaUfataz1Pb88ldrK4dKMQ9wpgf8fvjrBdtTvzkOz6fODa12PUhbojy1n5akFhoQMFjF4Eb8laTW75CgNTCm0E9P5+zo7VaQJwYl2sjVDUIGlcRm4NIHqJdMlWneVR10wjQ6GEmjsRa0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287401; c=relaxed/simple;
	bh=TG0NKcrLjqdyQdlw2c6URhaVJV8b27piDsMO4RVMv7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+CwHoI+PAbIlg2wVsp/ktlxMSBI9tklHyBOw6+R32q7S8bv0F5Y5XdaxDSCi7kxHo0lPGYr6eAIGPonn/MtEzekcgpkyWADJLFJDZwODJi7t+G1D8QaosDISwax73h9g7tx5maGzt6Ufzte3hpaURu3bPk/loejPN0jaaTJVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=foDMoUZf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="foDMoUZf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b46da8c48eso2085ad.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779287399; x=1779892199; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hupf40yvplKJ6StYekfgG7udqF3fGQFNogF6bADkx9E=;
        b=foDMoUZftHZRGGoUSfv5Y9Ef3ioZktKoM50zNgFQ9v14mQ8rLSL3PFyWnguzvee7zy
         TSYTHN8SsHY9KpD2TL7BR/Osx+fd8uVcPDjFbBJ2JUrGULgS4aZgLHmXNlNnE1uOUnMV
         LW7iVWiACjcmCEZCWBi+uNVQWF1TEpo2IPw5jtX2MUrj8AxS/q6TYpGvZ21t0+hj+O/Y
         xp1mNyovkwTQjClqs7jf/RF3FuEK2VkZFnwtzxDyXB4ffQLmRp8vEemQiMHC2cnMG3Vv
         slPyDoQlc48DI8wJMA9FbnP59a//NYbm6IQ/Y1dTchicoTZIYKxXqsBhlohx9EpukDiu
         YYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287399; x=1779892199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hupf40yvplKJ6StYekfgG7udqF3fGQFNogF6bADkx9E=;
        b=b5flnBdKCiiWNWH+ebgEPgapB+vzgTFYKD94A2H1TOxJLm6EVkkql3qn6/y/Jrgg8N
         NH00G5sN0lFrMYUqfm2kDsuQoRzpP9s9NgtsnDBkbz8O7N3dEjf/fDRI4IAvTGlVCB68
         HwNFayTpq1tHBNXvgdP7BSOww9Cm6jMMQQ1PnfTMkJUnX94hIAPMutnpocYjkS4GyMBR
         Zo3b/BvNg+6GkJAMvNAXpNWsaBFyDfxEqh9Eqg+7BxQqncvMloCcbvuQg+qWqYXMk/+w
         j2Y7qzXIz7aaIBqXuYKCTgHHpTWGtbpZOxlDtDVGnZuh/2IrL5xfyIiWp1fLORTqISbZ
         /G+w==
X-Forwarded-Encrypted: i=1; AFNElJ/YYlMTdTb5R/7WpTiEOSebJ0ClfrIkS6swCe6uuADWuZRasDwv15YXtZBvBlfrWII8JXazfA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3zFwI2P7hk//rjPxaNBB9PuIuIyrPk631pjPFfF8rH3tmMZnN
	/tqkupsjO885VoPSlXyoeu5uQExDgJYNHazjiUmt9kvNcYSiB7XDZl+XwHv2d2Cv4A==
X-Gm-Gg: Acq92OGEH6Rfns2y3NYsOq8vmqdXrjzoErjVMTQuXiW0elE147fTnKPxcdEYAfdfXF1
	15AAQQh/UgOM1fZxncQ+Mh88GoP6JClWE+XJZEWG7mVxZv9RL3XFzWOYytVqS728KQeW/K1BhNq
	7ZCwLSS3pifDu5jR3P6bQHMnrxiy7YLLD6KZ1c6TDOSOY1vzCirXvMEHcf0/R8+HIUa9kpzCagT
	LRpc21VQ8cf6GMJJRQZcAIX5Cv9hRSMCVXvmqosE9V8DOAjiA3RPbDd9r1lSMbHv2WEiZ+wvFFI
	qVjAxt2lBRpg0kqlJ2PogYnAYZ67mJNujTe3DzR8dnJglPywSM+fwJjLjNj6XzX2wXZYl9X+5qJ
	aaxxNr20ySym35LByvCvuVzCC2b9Z3JKxxpdDuYCU9is6GacC2aebP5OY8a/lsW+6yB0/+A4xFj
	f/m+4zzftTDkXFcgT6VE3sfoaZa3xvhaRAb3B3gXw5EEulk8Grb0DtBKmT6U4ZxEG4TWes
X-Received: by 2002:a17:902:d4c4:b0:2ae:80a3:98a9 with SMTP id d9443c01a7336-2bdb32c2d37mr8481265ad.11.1779287398420;
        Wed, 20 May 2026 07:29:58 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb0csm206596705ad.17.2026.05.20.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:29:57 -0700 (PDT)
Date: Wed, 20 May 2026 14:29:51 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <ag3FX2rYHybhv7bZ@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <agy2uGGC6wXhG91Z@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agy2uGGC6wXhG91Z@google.com>

On Tue, May 19, 2026 at 08:01:55PM +0000, Samiullah Khawaja wrote:
> On Tue, May 19, 2026 at 11:59:47AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 19, 2026 at 02:55:54PM +0000, Pranjal Shrivastava wrote:
> > > On Tue, May 19, 2026 at 11:44:30AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, May 19, 2026 at 01:53:22PM +0000, Pranjal Shrivastava wrote:
> > > > > @@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> > > > >  	if (dev_is_pci(dev)) {
> > > > >  		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> > > > >
> > > > > -		pci_prepare_ats(to_pci_dev(dev), stu);
> > > > > +		if (!pci_prepare_ats(to_pci_dev(dev), stu))
> > > > > +			master->ats_prepared = true;
> > > > >  	}
> > > >
> > > > This should fail not keep going, it is a kernel bug if
> > > > pci_prepare_ats() fails.
> 
> I agree with this approach, as it captures the bug at right place and we
> can fix it. This maybe changes the simantics of prepare_ats(), but I
> agreed with this.
> > > 
> > > Are you suggesting it's a kernel bug if the STU doesn't match?
> > > IIUC, it can fail because of the following cases (including the PF STU):
> > > 
> > > 	if (!pci_ats_supported(dev))
> > > 		return -EINVAL;
> > 
> > It should not be called if ats is not supported, iommu driver bug.
> 
> So basically iommu drivers should call pci_ats_supported(dev) before
> calling prepare_ats() and probe fails if prepare_ats() fails.

Ack. I'll add those checks to Intel and AMD IOMMU too..
AFAICT, both of those too, don't fail an attach if pci_enable_ats fails
[1][2]. I'll add those in the next version as well.

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/iommu/amd/iommu.c#L2373
[2] https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/iommu/intel/iommu.c#L3340


