Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF301FAF
	for <iommu@lists.linux.dev>; Thu, 29 Dec 2022 16:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0105CC433D2;
	Thu, 29 Dec 2022 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672332873;
	bh=ZH9RxnFigQ3RNw39YbUtHTL0S/l1Ahl1+A4wI5byIbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=R10r7pyB/UbK+tFVrEctWZRBQDwXUu22AT9vlVvp01hWq47xoIDSjFMGjzchZHZyi
	 66/f6Fyce3eiltODaKq7VCqCK7dEcSB+AEG/RiMfCeuFs5aHKOk04bjidHv0VMJg51
	 7WmjXsXWwOfU6OTVz3GNBNxo2UPCzuJ6Lj1MVqG68xavgMqoQqQi8P+hclvXLAxICh
	 6hwmO9NJFRzLbSYZaa7hk/VMuB37tlN/9a+3qfWxOD7PCUhUlXyjN4PN9NKa9zAfRf
	 wyd25rIuT8zy8rhiE4MDUbsOUTJSpXOYH5WV+pUVRp96h/fzUefZQSawaaw4dD90Iy
	 3S049RPbLL/xQ==
Date: Thu, 29 Dec 2022 10:54:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Michael Kelley <mikelley@microsoft.com>, hpa@zytor.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
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
Subject: Re: [Patch v4 04/13] x86/mm: Handle decryption/re-encryption of
 bss_decrypted consistently
Message-ID: <20221229165431.GA611286@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y62FbJ1rZ6TVUgml@zn.tnic>

On Thu, Dec 29, 2022 at 01:17:48PM +0100, Borislav Petkov wrote:
> On Thu, Dec 01, 2022 at 07:30:22PM -0800, Michael Kelley wrote:
> > Current code in sme_postprocess_startup() decrypts the bss_decrypted
> > section when sme_me_mask is non-zero.  But code in
> > mem_encrypt_free_decrypted_mem() re-encrypts the unused portion based
> > on CC_ATTR_MEM_ENCRYPT.  In a Hyper-V guest VM using vTOM, these
> > conditions are not equivalent as sme_me_mask is always zero when
> > using vTOM.  Consequently, mem_encrypt_free_decrypted_mem() attempts
> > to re-encrypt memory that was never decrypted.
> > 
> > Fix this in mem_encrypt_free_decrypted_mem() by conditioning the
> > re-encryption on the same test for non-zero sme_me_mask.  Hyper-V
> > guests using vTOM don't need the bss_decrypted section to be
> > decrypted, so skipping the decryption/re-encryption doesn't cause
> > a problem.
> 
> Lemme simplify the formulations a bit:
> 
> "sme_postprocess_startup() decrypts the bss_decrypted ection when me_mask
> sme_is non-zero.

s/ection/section/

(In case you copy/paste this text without noticing the typo)

