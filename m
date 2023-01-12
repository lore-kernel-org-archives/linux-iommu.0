Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8A749A
	for <iommu@lists.linux.dev>; Thu, 12 Jan 2023 14:03:40 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so16652372wmb.2
        for <iommu@lists.linux.dev>; Thu, 12 Jan 2023 06:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3Z/l312HDGa8/vxCVX5Bvnphzfpdnx1DzW2sgn2w3w=;
        b=bKtTguWn4ofCNOaZSyf5SpDxtIL/ZHErVWp6XNLu5xrg4V+SvGYsl84Kc3WvejNNMB
         2y3M6wFEvkZFt+tu3yKHzbGpCU7K9D5ESL0/tbGddNy1JBMSN8QBF8g55mBPKVLRhC4p
         uLvpwDtznPNngvk7ZXVIVt0WHG7y/7WwIeSQP6e6R/q7y+VVNuRb0dRL7b+vyEBrYEHf
         FVBNSqYj7jbRdiGpHD4QI/zLCGG5YR62zioap0cz7FCgTaxeQjTZglU9HtJ6XglRkAol
         jaQT7p79/C0gS7ortV9ewhelS5VnvH3XPkmPZj1RNPRVZ904IIb/TT0byrjNsbTROzLp
         2kag==
X-Gm-Message-State: AFqh2koERIUNo4HCB3sNv4mey2vHHb2FLH2aVNT7S5ncAGsi2im1/zld
	bOK8qE54TT4q0e5/6BJKhM8=
X-Google-Smtp-Source: AMrXdXvSq19ZKhD7XOusPuFTaVJTAHVinLgrUB+UQu5hH5s7XUOSBwHw7yRRNmdQxULBGKzHgvC0tw==
X-Received: by 2002:a05:600c:3509:b0:3c6:e60f:3f6f with SMTP id h9-20020a05600c350900b003c6e60f3f6fmr54630895wmq.38.1673532218180;
        Thu, 12 Jan 2023 06:03:38 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id y6-20020a1c4b06000000b003da119d7251sm2673448wma.21.2023.01.12.06.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 06:03:37 -0800 (PST)
Date: Thu, 12 Jan 2023 14:03:35 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Michael Kelley <mikelley@microsoft.com>, wei.liu@kernel.org,
	hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, luto@kernel.org, peterz@infradead.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lpieralisi@kernel.org, robh@kernel.org,
	kw@linux.com, bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com,
	thomas.lendacky@amd.com, brijesh.singh@amd.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com,
	Tianyu.Lan@microsoft.com, kirill.shutemov@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
	isaku.yamahata@intel.com, dan.j.williams@intel.com,
	jane.chu@oracle.com, seanjc@google.com, tony.luck@intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [Patch v4 00/13] Add PCI pass-thru support to Hyper-V
 Confidential VMs
Message-ID: <Y8ATN9mPCx6P4vB6@liuwe-devbox-debian-v2>
References: <1669951831-4180-1-git-send-email-mikelley@microsoft.com>
 <Y7xhLCgCq0MOsqxH@zn.tnic>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7xhLCgCq0MOsqxH@zn.tnic>

On Mon, Jan 09, 2023 at 07:47:08PM +0100, Borislav Petkov wrote:
> On Thu, Dec 01, 2022 at 07:30:18PM -0800, Michael Kelley wrote:
> > This patch series adds support for PCI pass-thru devices to Hyper-V
> > Confidential VMs (also called "Isolation VMs"). But in preparation, it
> > first changes how private (encrypted) vs. shared (decrypted) memory is
> > handled in Hyper-V SEV-SNP guest VMs. The new approach builds on the
> > confidential computing (coco) mechanisms introduced in the 5.19 kernel
> > for TDX support and significantly reduces the amount of Hyper-V specific
> > code. Furthermore, with this new approach a proposed RFC patch set for
> > generic DMA layer functionality[1] is no longer necessary.
> 
> In any case, this is starting to get ready - how do we merge this?
> 
> I apply the x86 bits and give Wei an immutable branch to add the rest of the
> HyperV stuff ontop?

I can take all the patches if that's easier for you. I don't think
anyone else is depending on the x86 patches in this series.

Giving me an immutable branch works too.

Thanks,
Wei.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
