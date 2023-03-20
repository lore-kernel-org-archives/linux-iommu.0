Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F5E4D5
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 11:27:15 +0000 (UTC)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1134D1EC0662;
	Mon, 20 Mar 2023 12:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1679311634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=PE0V7lE9EfhB921N//zo5ZjSYSOvTBfEu1v7T+9F1sY=;
	b=dCu69jjGMO1potJ7a2X20nTWZx06nNYsCEepX6UJ7SL80wE9zvtHc3bymc6rx6Q2Vjhq4N
	bE3iqcCbsNY1tBR/XZefUmkzRnn3IQ7NwEVoQHjxjCi0vQW3RsK6EroJZUqdMq+F5X9WWd
	xW9Kn/hEDhTI+D/D6kYApwf4ub1HsGM=
Date: Mon, 20 Mar 2023 12:27:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Michael Kelley <mikelley@microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, luto@kernel.org,
	peterz@infradead.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lpieralisi@kernel.org,
	robh@kernel.org, kw@linux.com, bhelgaas@google.com, arnd@arndb.de,
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
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
Subject: Re: [PATCH v6 00/13] Add PCI pass-thru support to Hyper-V
 Confidential VMs
Message-ID: <20230320112713.GDZBhDESaTus4AR3SJ@fat_crate.local>
References: <1678329614-3482-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1678329614-3482-1-git-send-email-mikelley@microsoft.com>

On Wed, Mar 08, 2023 at 06:40:01PM -0800, Michael Kelley wrote:
>  arch/x86/coco/core.c                |  42 +++++--
>  arch/x86/hyperv/hv_init.c           |  18 +--
>  arch/x86/hyperv/ivm.c               | 148 +++++++++++++----------
>  arch/x86/include/asm/coco.h         |   1 -
>  arch/x86/include/asm/hyperv-tlfs.h  |   3 +
>  arch/x86/include/asm/mshyperv.h     |  16 ++-
>  arch/x86/include/asm/x86_init.h     |   4 +
>  arch/x86/kernel/apic/io_apic.c      |  16 ++-
>  arch/x86/kernel/cpu/mshyperv.c      |  22 ++--
>  arch/x86/kernel/x86_init.c          |   2 +
>  arch/x86/mm/ioremap.c               |   5 +
>  arch/x86/mm/mem_encrypt_amd.c       |  10 +-
>  arch/x86/mm/pat/set_memory.c        |   3 -

...

>  29 files changed, 440 insertions(+), 439 deletions(-)

The x86 bits look pretty much ready modulo some uncertainties in patch 6.

When this has all been clarified I'm thinking of taking patches

1-2,4-6

through tip and giving an immutable branch to HyperV maintainers to base
the rest ontop...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
