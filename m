Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00E20EF
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 11:58:35 +0000 (UTC)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32E491EC04DA;
	Fri, 20 Jan 2023 12:58:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1674215913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=5sRgTMv+ImX0RHcEs9fymhJia2CIfblYcntDjPRHUWE=;
	b=E/n8jPTElF3/IUDz38TCo4i4iuS3yqWh+E8bFIsd/mmdqN0/oOImwTweHtLWYcepufJDte
	6PbiavIjYpDXgD+XrLl8Psjxm8wnXKG+ieevXzsdua3qXDfU4iUasrODH+afXOzBRu6iY9
	muTGoo6GBbrfl7WO8EdfMnrBocSFgfU=
Date: Fri, 20 Jan 2023 12:58:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Wei Liu <wei.liu@kernel.org>
Cc: Michael Kelley <mikelley@microsoft.com>, hpa@zytor.com,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	luto@kernel.org, peterz@infradead.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
	bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
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
Message-ID: <Y8qB5ZN5Czj9lQVK@zn.tnic>
References: <1669951831-4180-1-git-send-email-mikelley@microsoft.com>
 <Y7xhLCgCq0MOsqxH@zn.tnic>
 <Y8ATN9mPCx6P4vB6@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8ATN9mPCx6P4vB6@liuwe-devbox-debian-v2>

On Thu, Jan 12, 2023 at 02:03:35PM +0000, Wei Liu wrote:
> I can take all the patches if that's easier for you. I don't think
> anyone else is depending on the x86 patches in this series.

But we have a bunch of changes in tip so I'd prefer if all were in one place.

> Giving me an immutable branch works too.

Yap, lemme do that after applying.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
