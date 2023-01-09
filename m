Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD223D64
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 18:05:33 +0000 (UTC)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB1891EC0104;
	Mon,  9 Jan 2023 19:05:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1673287531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=XBiZaY8u/xswQXku80iay8s8oLX/++H7HyqUoTlyF68=;
	b=kcAdnQBIIy7MSK2sQNbH9rDC7UYggpUWp+SUKhbFXMbLFwt9+GLk4C19RGTuIy7szr7sPK
	cptGfbWN0EH4V+NeGAnuUqDIBMeAeuq00m5Rcn2aM0Rp0sno1bVKd8zzl3BTThGv6ET/Qm
	BDMmgGyHmVJp9Fh7DX2vXSPjXYEXZZM=
Date: Mon, 9 Jan 2023 19:05:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Michael Kelley <mikelley@microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, luto@kernel.org,
	peterz@infradead.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lpieralisi@kernel.org,
	robh@kernel.org, kw@linux.com, bhelgaas@google.com, arnd@arndb.de,
	hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
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
Subject: Re: [Patch v4 07/13] swiotlb: Remove bounce buffer remapping for
 Hyper-V
Message-ID: <Y7xXZ9CKijXo5XQS@zn.tnic>
References: <1669951831-4180-1-git-send-email-mikelley@microsoft.com>
 <1669951831-4180-8-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1669951831-4180-8-git-send-email-mikelley@microsoft.com>

On Thu, Dec 01, 2022 at 07:30:25PM -0800, Michael Kelley wrote:
> With changes to how Hyper-V guest VMs flip memory between private
> (encrypted) and shared (decrypted), creating a second kernel virtual
> mapping for shared memory is no longer necessary. Everything needed
> for the transition to shared is handled by set_memory_decrypted().
> 
> As such, remove swiotlb_unencrypted_base and the associated
> code.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Acked-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/kernel/cpu/mshyperv.c |  7 +------
>  include/linux/swiotlb.h        |  2 --
>  kernel/dma/swiotlb.c           | 45 +-----------------------------------------
>  3 files changed, 2 insertions(+), 52 deletions(-)

Patches removing crap are always nice:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
