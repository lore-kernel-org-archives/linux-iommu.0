Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A38F51
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 15:45:49 +0000 (UTC)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 166621EC01A9;
	Mon, 28 Nov 2022 16:45:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1669650347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=iioGKCFJMZT/5gejig6GxY5Ze8xPsQovHxxD/i23AQg=;
	b=MxEbuMHOtz+1KChAjvy7/PsrxmtXLm6tlHY8yLpAxmTLsQohcs8n6qbe1xjjbSrk/43sGk
	Xp6zuxW6rn1wPSAyhsiiJgIiVVg5AIdU7U48fiU0v6Dg1YC1xqLdkehunZ9CoakSLjysbg
	8SeUS2+CgMKqKlRL/0chNt0OSVW+Z/c=
Date: Mon, 28 Nov 2022 16:45:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
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
	"arnd@arndb.de" <arnd@arndb.de>,
	"hch@infradead.org" <hch@infradead.org>,
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
	"Williams, Dan J" <dan.j.williams@intel.com>,
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
Subject: Re: [PATCH v4 1/1] x86/ioremap: Fix page aligned size calculation in
 __ioremap_caller()
Message-ID: <Y4TXpW6vN4j9bULs@zn.tnic>
References: <1669138842-30100-1-git-send-email-mikelley@microsoft.com>
 <Y4DdCD7555d2SpkZ@liuwe-devbox-debian-v2>
 <BYAPR21MB1688F9B7FC41946DBD9F8784D7139@BYAPR21MB1688.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688F9B7FC41946DBD9F8784D7139@BYAPR21MB1688.namprd21.prod.outlook.com>

On Mon, Nov 28, 2022 at 02:43:28PM +0000, Michael Kelley (LINUX) wrote:
> Boris -- you were going to pick up this patch separately
> though urgent.  Can you go ahead and do that?

Did you not get the tip-bot notification?

https://lore.kernel.org/r/166911713030.4906.16935727667401525991.tip-bot2@tip-bot2

you're on Cc there too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
