Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB139F19E
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220923; cv=none; b=Ow46UJGzeJPVfBMx50z0e8w6AAkAsQV6azSF+OANgPQBbjjHKELWQ/5VdDdBptLRuuriSObxPXSzabsHp87woLmLPHLAl799z2NNWH5fGqIruYjqk5XSi/hMNy95lxR4102IA62MtS85zMoPrt1siUYu+WrH1SAPLBMbl/EOj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220923; c=relaxed/simple;
	bh=jVbSLT4eZONXCbzPo5oDjs53UjPhjZF26rMvREPsuGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLwyFtDwoHWjSnVA9a1sOD9gj/Tfa1DfcRCUk8qhpBJii64zQ9j6udVJQXWBC5ubNZdThtuJpddCW0a3wlnZxe9A9gi2qMUriTIOw+OJdYhwKcaaamwbuAw0euiYJklithqxIEARMSfbzKcyFS0cAhzSOK/jdmOFxXiLBu9E7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OlQKfy+J; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlQKfy+J"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso3715ad.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779220921; x=1779825721; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yXDj/DTIeAGhrO/gWWaG2rh6poiOMsEC8DlUT/nKHTY=;
        b=OlQKfy+JkHzD4wNnlcsowj8O9/6NlSEHunpNUgCL30BXrp5KgGwhdijcQ1KF3yv82M
         Y11UvyFzFc3wR+xx1mPTKX3INKfPgHgjNfzwBoQFWte4MBaCX7OsTb5cNRckf3N1LexE
         hJsj8UsHFGXsTgkIOx7JnadW6EtDT2yfM77DRx+KuLaVEju/zrxXcTsntBlOXrKeE4Wf
         02QwhPlYhr56kfOXrPiXb6QpIt9cr6oyhlK5I9eITOvFmCeqYnbn7zBQoVKPAwmz4zL9
         BDEg1YlDwMEGbiySdDdDHQY9XQNOaThe6AZzbIw7G/ew67Cf/2UyUWjVCRhtd0yC/RnE
         3mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220921; x=1779825721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXDj/DTIeAGhrO/gWWaG2rh6poiOMsEC8DlUT/nKHTY=;
        b=exMu3nQOjZwuvQZOqiYY5qbzgXGa6CXKzqIauRTXVU6Cqrd1YkcUS9yPigT4ZnmHmc
         Ui3m+vVT89bZ8xRL39cRCjgdm+gSCS8vKLqefH2GdA3Nch8ufB6h7CKLVfjGRbzgq1eU
         ewIaNH4q5Rsl7PqC0IdOV9TYMuAoukwMVKpnVMKO1G1adABRzHb5mw8SU15A7gmMXsVo
         xHPrd9d4e0xhJoHHpY9ZnBI40pyUIgingKJgIgloGRJwibvgD/JJND7rsupT/85NASiq
         qMWfMN4XPZt1QdlXFhQpQZIRaoGntq691GwTF8RSUb3QsU1/Tco7NrEnO8pHG++zDkFM
         gzbA==
X-Forwarded-Encrypted: i=1; AFNElJ+MhwlC0Vs7+wpDDAum19pxxbPiWI70SqvUeLnUtYwXSi0z7i/lFuVbnYkF0+AMCWaiPNJ72w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyuJSqy5TnWJL7yel7rx4Edmow1IAwS7Jwyb8VZfG3fl06ROJlT
	PA8OR0daCe0RL+u4PLRiuSWUaRn7tE0CrYhPnrQnkllfYMmYDVQSvBPKSzmoAnrjcw==
X-Gm-Gg: Acq92OEkhBVc8Ms0WcqlulTHb1Gj4IymntuZmDS/Rt901mEjfJxOgnVC9CoBGloANx8
	mq8A7AKAEZNbUoi48fxLZFzTrXCtmjP+2e2Z2YFDwHHWRXY2P6j0zW7nufABjlzUUdWYSy2ZEMK
	XOQs6Jd0Qj1NIFvqy3A/WFo/5tHOBUJ52TbeihoKapHiUWZuZvKlfwPwTwYdEA2srJHeVtTgV+l
	B9V0rAE9jUIQd7BPBM/c8u3r0I+2C/uwI5mbC8BAn6Ps3/COgfOHOhsr8gzNp+SUEUhK8VO6bqT
	L87zN9L/fFiNApZDExqOzb/nigmtmXpgJR8/ZljVE5OIfiFbQrI0wiDa53k8OLRSRvm2HRTFBBv
	5GekkBYmv5WWrDtNLdOBKJptx7vwPdS7b5Sc/sbCfVGYBMFUJd0d44LJ1oUhe/bzECnkMEIpfBS
	+LfTJiTMqaPZmaGl44vlSlP7ILTHtltruWSBCqYPto/RJHid5Bo0GmgNjUXI7j9koClY85KxbtX
	cR6M/aI
X-Received: by 2002:a17:902:f64e:b0:2bd:5fc9:27b9 with SMTP id d9443c01a7336-2bdb303b125mr3099215ad.3.1779220919888;
        Tue, 19 May 2026 13:01:59 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517a820fsm15139452a91.10.2026.05.19.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:01:59 -0700 (PDT)
Date: Tue, 19 May 2026 20:01:55 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev, 
	linux-pci@vger.kernel.org, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Daniel Mentz <danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <agy2uGGC6wXhG91Z@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519145947.GK7702@ziepe.ca>

On Tue, May 19, 2026 at 11:59:47AM -0300, Jason Gunthorpe wrote:
>On Tue, May 19, 2026 at 02:55:54PM +0000, Pranjal Shrivastava wrote:
>> On Tue, May 19, 2026 at 11:44:30AM -0300, Jason Gunthorpe wrote:
>> > On Tue, May 19, 2026 at 01:53:22PM +0000, Pranjal Shrivastava wrote:
>> > > @@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>> > >  	if (dev_is_pci(dev)) {
>> > >  		unsigned int stu = __ffs(smmu->pgsize_bitmap);
>> > >
>> > > -		pci_prepare_ats(to_pci_dev(dev), stu);
>> > > +		if (!pci_prepare_ats(to_pci_dev(dev), stu))
>> > > +			master->ats_prepared = true;
>> > >  	}
>> >
>> > This should fail not keep going, it is a kernel bug if
>> > pci_prepare_ats() fails.

I agree with this approach, as it captures the bug at right place and we
can fix it. This maybe changes the simantics of prepare_ats(), but I
agreed with this.
>>
>> Are you suggesting it's a kernel bug if the STU doesn't match?
>> IIUC, it can fail because of the following cases (including the PF STU):
>>
>> 	if (!pci_ats_supported(dev))
>> 		return -EINVAL;
>
>It should not be called if ats is not supported, iommu driver bug.

So basically iommu drivers should call pci_ats_supported(dev) before
calling prepare_ats() and probe fails if prepare_ats() fails.
>
>> 	if (WARN_ON(dev->ats_enabled))
>> 		return -EBUSY;
>
>It should not be called if ats is already enabled, iommu driver bug.
>
>> 	if (ps < PCI_ATS_MIN_STU)
>> 		return -EINVAL;
>
>PAGE_SIZE is illegal somehow, build bug.
>
>> 	if (dev->is_virtfn) {
>> 		struct pci_dev *pdev = pci_physfn(dev);
>>
>> 		if (pdev->ats_stu != ps)
>> 			return -EINVAL;
>
>The kernel failed to setup the PF, iommu driver bug.
>
>> If ats isn't supported or if there's a STU mismatch, shuoldn't we just
>> ensure that we don't try enabling ATS for that device?
>
>No, the kernel is broken somehow.
>
>> Returning an error here would fail the device probe.. which seems like a
>> big hammer for devices that can't reliably use ATS..
>
>It has nothing to do with devices, the kernel is broken if it fails.
>
>> We have a special case in SMMUv3 where we pre-allocate stuff in prepare
>> but actually enable ATS in attach_commit, which IMO neeeds to be gated
>> based on client device's ATS capabilities?
>
>Yes, all of this should be gated by pci_ats_supported()
>
>But also failing to enable should translate into a failed attach.
>
>Jason

Sami
