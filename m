Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527CC31E840
	for <iommu@lists.linux.dev>; Sat, 21 Mar 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774099633; cv=none; b=OgjQypHxTCRURiLRiaUOeGcpkFeJNQqHsFL76VUhwu+ZkZCd8slG2fAKPu9K8yUAxxcmtGgQDBaeUmxTcqKX7CYCk9Q4JNoCvNKhWy60zqrAe3xHGX+bzw1pAdqfxHP14cGUDXrcu34bfpUmYfWQ+JwXvyAilHBQ6Cu/9cV0eGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774099633; c=relaxed/simple;
	bh=pi5Cr+wPz3p8f6WVyTUc6OTVwoqra6jg8txqrOsu920=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As2SkKiKantbm/4S/2zV9iw3tvh3gdYP7Qct5jcqBgaepvgZ+cOsjrvxmTn34L64GM083Zgwp5cXRAcw7L7wn/OMphn91TfvSgsOrMDWBx6UA9vJ1Mna/eJ5AE3yvBBgko1Fgv+XWxKHnNAKswNRoIkUBc7dYGkCzttpiuZnuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFFEu4eZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFFEu4eZ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aeab6ff148so57785ad.1
        for <iommu@lists.linux.dev>; Sat, 21 Mar 2026 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774099632; x=1774704432; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1Fj4N/UpgbJKkAFov6kcwTbNCL5sZLLzanhyYdr1VI=;
        b=VFFEu4eZ14is6AJwXBezMytRTxz5KVYIzf9aEvoicOYdLRlhb97w8FRvP0To2Bsgol
         Rhwo4SVVD0z0HlcZLlsKQxvJpsCBj7hV9rrTrkIy1PElhXQMZLttSJXM55aQTg0T4Hqp
         CDDGGaLixl5kRinWM1cr8bgUaUFYEHNEXu04zPTIa1cLq2MwONKQRF1A6Bim51jxPEwR
         pRjiwq93QicZuVNqbkiaqsWFHWkRLE/leVybGP23yBpNdhJ001OSzwmd7j5/cY56Jkqd
         Ww/7Vz4PCvKyso1fj6eKJ+4vgGKxIWVZOuU0ACcakwWPxfoTjs3NNOV+iB0EdjGyNC6X
         f7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774099632; x=1774704432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1Fj4N/UpgbJKkAFov6kcwTbNCL5sZLLzanhyYdr1VI=;
        b=f/3EBp4GjuzRksv+GH0NK1t0zW1kAa5vAShMffvE09Qx+UhPEaMQHXGeT77FvJLPpJ
         ip06SGvpixX88wwPfdsl9a8QraCeBzrSqsPLRZJLHb6V9kAURAu2FDBs4RS1bPiwuZ+/
         7uTnbRfK0YtH/C8OMWnBwaBSGvCLogJF1pFnVJe9eUP/Tm+G7eKShgN3Nzei+Suyg/XH
         gT30Jw/f/TRDTGBlYEDfZ/pL2ZZoPoNwz9RaG7tK/3dkiu6mbobAOJ71C6JiEmG0i9SH
         AigZn/vhHPq2a/M98zeN8uyElVwF1VkRkFbpxUi2JXtIY1JI6Uc3bqewiadlti/BuR3v
         hsWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq14aqvohvb9qI+b5VV4aTSN1rpd7QjYeO3bd46/e0pIQOYDDxpNb0zOMObrQCGv9j2HzOiA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9VEedFTd1Zkn83BCoTzKuNvI1yn38s3Jv36aoQ1qEW2blUyaG
	asyBa6vM7KNPslGknsvAIEh0EffFkgZ/dQdCbzVumBbJCykA+phjpmZzQJpFEZtmRA==
X-Gm-Gg: ATEYQzwu7qz9aueUqToPTAHqrVT+jegFoTlYcJ8kNhOd74+QMJFlJrdfj7Xz+YT1PhX
	02jsyO7nyr1P/Loz7Rb4nPqrgZV0kM14ORdNEl17eTQL73sQ9BZD+yHVANacdIoORpC2A1P0Nqt
	+Uf/6jnE1NCxnQC3Qe4JLN7bsObSEDpbZhj64YRa8Driv6eCX8gKEd27uNFpoEuHOLHasPvGUxK
	Js4yMeh4cqWkPtOhrVb6l2TTyzjeQ6yBWkZ5YTQOcejxSHjX8Qvj2A6UgzURYnHh3i0kBTP/Cu3
	N8VBRqXLqBDaijkjBpWnalgZLkleEwz2Usi5THXBrG8NS4RSRYgRaUn/QtpWpo8Y5qkucf2bDJ1
	QNn6Jl3pJ2jMWvgNKHiOled9BwxQTZh72mvj1sb0uJly4WIWuqQ0IelibahnatDptC72ss+bBAe
	vFx0w/RCXzNWnXmJsUELC8viNVMfcJHszVNsXPrTOHepmZkAebAeIC3NJkDdHe7WMKx04u
X-Received: by 2002:a17:902:db0d:b0:2ae:d10c:6382 with SMTP id d9443c01a7336-2b08b4432c2mr2182545ad.20.1774099630892;
        Sat, 21 Mar 2026 06:27:10 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd26cde44sm1729954a91.4.2026.03.21.06.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 06:27:09 -0700 (PDT)
Date: Sat, 21 Mar 2026 13:27:00 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 06/14] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <ab6cpNWZetBokbG8@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-7-skhawaja@google.com>
 <ab3R54-kyHGDEW9L@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3R54-kyHGDEW9L@google.com>

On Fri, Mar 20, 2026 at 11:01:59PM +0000, Pranjal Shrivastava wrote:
> On Tue, Feb 03, 2026 at 10:09:40PM +0000, Samiullah Khawaja wrote:
> > Add implementation of the device and iommu presevation in a separate
> > file. Also set the device and iommu preserve/unpreserve ops in the
> > struct iommu_ops.
> > 
> > During normal shutdown the iommu translation is disabled. Since the root
> > table is preserved during live update, it needs to be cleaned up and the
> > context entries of the unpreserved devices need to be cleared.
> > 
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > ---
> >  drivers/iommu/intel/Makefile     |   1 +
> >  drivers/iommu/intel/iommu.c      |  47 ++++++++++-
> >  drivers/iommu/intel/iommu.h      |  27 +++++++
> >  drivers/iommu/intel/liveupdate.c | 134 +++++++++++++++++++++++++++++++
> >  4 files changed, 205 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/iommu/intel/liveupdate.c
> > 
> > diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
> > index ada651c4a01b..d38fc101bc35 100644
> > --- a/drivers/iommu/intel/Makefile
> > +++ b/drivers/iommu/intel/Makefile
> > @@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
> >  obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
> >  obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
> >  obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
> > +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 134302fbcd92..c95de93fb72f 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/crash_dump.h>
> >  #include <linux/dma-direct.h>
> >  #include <linux/dmi.h>
> > +#include <linux/iommu-lu.h>
> >  #include <linux/memory.h>
> >  #include <linux/pci.h>
> >  #include <linux/pci-ats.h>
> > @@ -52,6 +53,8 @@ static int rwbf_quirk;
> >  

[ ---- snip >8 ----- ]
 
> > +
> > +int intel_iommu_preserve(struct iommu_device *iommu_dev, struct iommu_ser *ser)
> > +{
> > +	struct intel_iommu *iommu;
> > +	int ret;
> > +
> > +	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
> > +
> > +	spin_lock(&iommu->lock);
> 
> Minor note: We call this with the session->mutex acquired which is a
> sleepable/preemptable context whereas spin_lock disables preemption and
> puts us in an atomic context. 
> 
> While iommu_context_addr() happens to be safe here because it uses
> GFP_ATOMIC & we pass alloc=0, we are heavily relying on the assumption
> that iommu_context_addr() or other helpers will never sleep or attempt
> a GFP_KERNEL allocation under the hood.
> 
> Given how easy it would be for a future refactor to accidentally
> introduce a sleeping lock inside any of the other helpers, I'd recommend
> adding an explicit comment here warning that this runs in an atomic
> context (same for unpreserve below).
> 

Thinking a little more about this, I think we shall instead add a
comment in the core API docs, mentioning that these helpers (like
iommu_preserve_page etc.) can be called from atomic context and hence
should not acquire any mutexes as we can't be certain of the context the
drivers call them in. 
 
Thanks,
Praan
