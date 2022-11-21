Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819053D84
	for <iommu@lists.linux.dev>; Mon, 21 Nov 2022 13:50:42 +0000 (UTC)
Received: from zn.tnic (p200300ea9733e725329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e725:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3421D1EC069C;
	Mon, 21 Nov 2022 14:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1669038640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=/C/l8FChSAmv2fYNze1TpkQLwNDUcpkHrvkPuGUNSXo=;
	b=iP5E+So87ZwsoHe1r4dkkEyROlF24pmrCcvLQa596hel34oeRumIzva71S3XXynIF6pdny
	dBTRBj8rMUWuBklA0jZ0Kwa7C4R77VNB/fPkqQBi4LhssHvGFK1AJM4F5jhi1AfmuftoRw
	KzrGWlT3s1IMi2qx0F/2OEp0zBT+pCY=
Date: Mon, 21 Nov 2022 14:50:36 +0100
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
Subject: Re: [Patch v3 02/14] x86/ioapic: Gate decrypted mapping on
 cc_platform_has() attribute
Message-ID: <Y3uCLPInEaA0ufN4@zn.tnic>
References: <1668624097-14884-1-git-send-email-mikelley@microsoft.com>
 <1668624097-14884-3-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1668624097-14884-3-git-send-email-mikelley@microsoft.com>

On Wed, Nov 16, 2022 at 10:41:25AM -0800, Michael Kelley wrote:
> Current code always maps the IOAPIC as shared (decrypted) in a
> confidential VM. But Hyper-V guest VMs on AMD SEV-SNP with vTOM
> enabled use a paravisor running in VMPL0 to emulate the IOAPIC.

"IO-APIC" I guess, in all your text.

> In such a case, the IOAPIC must be accessed as private (encrypted).

So the condition for the IO-APIC is pretty specific but the naming
CC_ATTR_EMULATED_IOAPIC too generic. Other HVs emulate IO-APICs too,
right?

If you have to be precise, the proper check should be (pseudo code):

 if (cc_vendor(HYPERV) &&
     SNP enabled &&
     SNP features has vTOM &&
     paravisor in use)

so I guess you're probably better off calling it

  CC_ATTR_ACCESS_IOAPIC_ENCRYPTED

which then gets set on exactly those guests and nothing else.

I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
