Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA47C
	for <iommu@lists.linux.dev>; Mon, 20 Mar 2023 18:16:57 +0000 (UTC)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 955551EC0531;
	Mon, 20 Mar 2023 19:16:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1679336212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=Su0jVvMlcA8VS9cp0F1QAxEGU0NJDxsY7JHrrw9jo40=;
	b=joiMDXgbeJuLDkYQrkuw2mdaf4RdNU+LXTis9e0EN2JNuc0tQpyM6dOFBRL655TYKP8Bpx
	TEf2daSlXJw9ifgiWxfuuSVJhbgOP9mVkwD/7SNsdyMev9W4YowMghg37YdPCzG1Bik5VS
	zBYfAqODJeMNHIuharTIGHYKQZONm74=
Date: Mon, 20 Mar 2023 19:16:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"brijesh.singh@amd.com" <brijesh.singh@amd.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jane.chu@oracle.com" <jane.chu@oracle.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v6 06/13] x86/hyperv: Change vTOM handling to use
 standard coco mechanisms
Message-ID: <20230320181646.GAZBijDiAckZ9WOmhU@fat_crate.local>
References: <1678329614-3482-1-git-send-email-mikelley@microsoft.com>
 <1678329614-3482-7-git-send-email-mikelley@microsoft.com>
 <20230320112258.GCZBhCEpNAIk0rUDnx@fat_crate.local>
 <BYAPR21MB16880C855EDB5AD3AECA473DD7809@BYAPR21MB1688.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16880C855EDB5AD3AECA473DD7809@BYAPR21MB1688.namprd21.prod.outlook.com>

On Mon, Mar 20, 2023 at 01:30:54PM +0000, Michael Kelley (LINUX) wrote:
> In a vTOM VM, CPUID leaf 0x8000001f is filtered so it does *not* return
> Bit 1 (SEV) as set.  Consequently, sme_enable() does not read MSR_AMD64_SEV
> and does not populate sev_status.

So how much of the hardware side of vTOM are you actually using besides
the actual encryption?

Virtual TOM MSR (C001_0135)? Anything else?

AFAICT, you're passing the vTOM value from CPUID from the hypervisor so
I'm guessing that happens underneath in the hypervisor?

I'd like to make sure there are no more "surprises" down the road...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
