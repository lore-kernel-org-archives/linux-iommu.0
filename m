Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D7163
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 18:47:14 +0000 (UTC)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E62A21EC0104;
	Mon,  9 Jan 2023 19:47:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1673290032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=11LnUf4MhejKfgisfPSyS9B0B0xaSZCrX17MQeoncqE=;
	b=sAByOsc/+Oj0INi0+tr34pMFzTLKYdE0Sr9YpSor17uoouv6rwXdWzR47sn0Zolbt29b6f
	gsg8XJ7C2pb+Kcg1pn60LMqgasxwuYbWtcF9SA0noFAmkwEsX+HalnvnH2QPTIxXMsCoGF
	qf5/yHPQ0ycrMslQs6xaSQRFnJsU084=
Date: Mon, 9 Jan 2023 19:47:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Michael Kelley <mikelley@microsoft.com>, wei.liu@kernel.org
Cc: hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
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
Message-ID: <Y7xhLCgCq0MOsqxH@zn.tnic>
References: <1669951831-4180-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1669951831-4180-1-git-send-email-mikelley@microsoft.com>

On Thu, Dec 01, 2022 at 07:30:18PM -0800, Michael Kelley wrote:
> This patch series adds support for PCI pass-thru devices to Hyper-V
> Confidential VMs (also called "Isolation VMs"). But in preparation, it
> first changes how private (encrypted) vs. shared (decrypted) memory is
> handled in Hyper-V SEV-SNP guest VMs. The new approach builds on the
> confidential computing (coco) mechanisms introduced in the 5.19 kernel
> for TDX support and significantly reduces the amount of Hyper-V specific
> code. Furthermore, with this new approach a proposed RFC patch set for
> generic DMA layer functionality[1] is no longer necessary.

In any case, this is starting to get ready - how do we merge this?

I apply the x86 bits and give Wei an immutable branch to add the rest of the
HyperV stuff ontop?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
