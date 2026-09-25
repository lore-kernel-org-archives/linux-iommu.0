Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454C477E53
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327585; cv=none; b=T2YoZMdq91r6ja72p48teYFSMoRIwtMdZZ6PhFjAKv6SE7ZkW9XUpXYcAbak/OH8RMCqds08lrFfGb/eXNGo1PJJYpuSI59mug5V1YGVDvLnWnVs6OtVnFzM35i7Awwyh1mdbxWPkKl27vHiAalMc+h1QLr39W+Wj2vEaLpqFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327585; c=relaxed/simple;
	bh=1Z3pKVsAB7cGlrs84ql54irrn4EOTKXXllBebSmuuGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuuNJuSTYMaA8HDi0UEYyP9JfiDXoq5LgRYtWGUOtlVhjQXBsYXtJZs2bIoSZLVyDxRI2xh+fQZwRFn1bFbaon8pDdmd+c7JHolWvlK4eVBiYa6610IeUSQinQEctB0jN+54r+Eq3xSjCckJ0cyDfp+m3ywWPwh6072wILqafow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaX8jgz9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaX8jgz9"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d3b445a84fso32765ad.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790327583; x=1790932383; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CTMJNzZxuTPM6C0AemlJt6uT6H/3eGpfCZ5SiFyGRfQ=;
        b=PaX8jgz9KW9YePUBcx1suT91l/J+eA/O/IXLQV18SthdwFBlQXBO7hXcr0zZpiHz/c
         USxb8pzyXyRiUTaiMi+xDhV5TXkPQd95pOR/BLYqF+q+N4vzolnBTvJkhcMu+ETOn7sz
         WZGvjyBlYFu5lHjSONDvVa4KjbVSCIcBcGqnMhdJIQHXssiwoC1iKWr/fdnnJfVxYi9s
         A7U58As1EXZUrRLqY168yEGZNXQqFi6mLQjQ7cafdywg4i0T1r0luKE4f3gpXGU7tQg+
         Y7w4VgNf425Hb1wrtzZOddVyM4LTCvyOnBdRZ89yR+NCajtFtlVs4vAcwxOvGcCnXGEe
         2LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327583; x=1790932383;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CTMJNzZxuTPM6C0AemlJt6uT6H/3eGpfCZ5SiFyGRfQ=;
        b=kxmqf7C/7YHl8LVF1LLyfQlkZuef/sbA0VGdPDSKvrfhWVCDeG7mgPJP5NXzAsd8Hf
         TWCMaK5ClsbXUy9dvBbxkvuZ0ZMRLxMVyLC8V8oZcgXuI3RsHXfH/uaCaaw9/Mh/X8pX
         3f8ni4IqODPYbVzV6Bh/OMPLf0KS5vQs7Txu2HggFxAcG+6lp9fgMnCQgmkW+NGXUce3
         GvNRRk9+2JiPdKTm0S3eJ9aibHUfOu4VbJ+LbxWJkol86BHFkxrWCnCwEl11cfmgCBOL
         9cEG0K9y5Vw/4yJFXOTgGZj4jipu0ZcJeCxW9cDgfks1DexGcLB5DotjwZIHT4k8czef
         U98w==
X-Gm-Message-State: AFuF++mQaXskEgbAZ9nG+fqoTMh0Y0ZdBBW22KT/4fCEQmnm1KrNo1R7
	hyp50STwgRbJKvCzV5Qx8exvqNSObVZ5AfLWxqyTImPSkgxpxcJAJMhVYkSt4dSjng==
X-Gm-Gg: AYBFou2VKv4J52pzt7f8ND4GYQgBxk/aNCBapYivuQjfU41S8BvkOeYekma/6tXJwDP
	PnK/JrKg4lCIZVTr194k58nT5IulY1HSs6cfeSeLyK9rkd3+H1Nw0j/d2FEaOHO3gi0vvu3P1ra
	jKE8jz5AhW2h+nm41y+q2A61ZjMWorS9ggI0mNMsO0IVF7qlEAktImLTylfsgXZzKWrUg2NGeR+
	DIg4JmBIr7umKABLDICY6JdzBNlcWuh89qV9TZyUWnRA9t58oIRTgaeFAe27dospJ5xZik64fq7
	mQsuj5vtwe5qo9JPqd0rui8OAEohOLseYEaGQYdvC/gXdGtBG3XRRuU8tGaK2wZcWrAphCYmeCM
	0TgDRl8QhfEGUFQNbDAN52kgI/7T6fSTsn2yLopxzc6nUCRW1omI22+IZogZqZnF0+3ag1aZW06
	lq4K9CFYihdSfEElt0VECI3bSB7SehbGhraGCV47i8839ofzhk5Vu9nZopFkaRC/8KbdGL3f7M5
	QgEZfwpA9pgAKco//zMwpY/ydRqdzkXJcgQ
X-Received: by 2002:a17:902:cf03:b0:2d5:db3d:1a42 with SMTP id d9443c01a7336-2df94314b89mr3126305ad.15.1790327582104;
        Fri, 25 Sep 2026 02:13:02 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm3426477a91.6.2026.09.25.02.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:13:00 -0700 (PDT)
Date: Fri, 25 Sep 2026 09:12:53 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v4 0/4] iommu/amd: Refactors for ATS robustness
Message-ID: <arY7FeYaOG9oglgI@google.com>
References: <20260910142655.3281464-1-praan@google.com>
 <arUOoLwpfNlIvIXy@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arUOoLwpfNlIvIXy@8bytes.org>

On Thu, Sep 24, 2026 at 01:51:45PM +0200, Joerg Roedel wrote:

Hi Bjorn / Joerg,

> On Thu, Sep 10, 2026 at 02:26:51PM +0000, Pranjal Shrivastava wrote:
> > Pranjal Shrivastava (4):
> >   iommu/amd: Refactor device probe and capability initialization
> >   iommu/amd: Remove iommu_ignore_device()
> >   iommu/amd: Fail probe on ATS configuration failure
> >   PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
> > 
> >  drivers/iommu/amd/iommu.c | 164 +++++++++++++++++++-------------------
> >  drivers/pci/ats.c         |   6 +-
> >  2 files changed, 86 insertions(+), 84 deletions(-)
> 
> Applied the iommu parts (1-3), please submit patch 4 through the PCI tree.

Thanks for applying patches 1-3.

Shall I send patch 4 separately or can it be picked into the PCI tree
directly?

Thanks,
Praan
