Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688B2C80
	for <iommu@lists.linux.dev>; Wed,  8 Feb 2023 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675869225; x=1707405225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S9tdno62LdkcJlHA3/wN/huJrL89J4P/0p6DKCZ9KvM=;
  b=YU12lj0YkpBet0BeyJPJ/MaY6cbbDX6p9h/pemORmBE06uxqtfTNI6yw
   YqbbBKLaBftQQX26Mt9VWgWNJaG4cwR78KGNMMn0xdkhOrNM12kJwUQt3
   /UiXC5ZeBjRIZyf3sNjLj0DfMt9IIpzP9R0GtQbqhSqwC4NoDr/JCRYmV
   rrPZJdZt+zR9he2JEEAB/l3p6/tsigB5mlWvX53LWjylpNwyFBJTTWYfM
   jqrRYDckEMt7dJPfJUkQc6RRCm8LMQgFSyxMhmWw4G4mGLPD/ZNpZTfup
   opAI1v94yxLlKOhblzIR6LMHpAZVm1ul9vBc/XezL/SXtIb0rPv7knK4Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="317824125"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="317824125"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:09:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="735971467"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="735971467"
Received: from tbacklun-mobl.amr.corp.intel.com (HELO [10.209.14.225]) ([10.209.14.225])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:09:38 -0800
Message-ID: <76566fc4-d6be-8ebf-7e9d-d0b7918cb880@intel.com>
Date: Wed, 8 Feb 2023 07:09:36 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 06/14] x86/ioremap: Support hypervisor specified range
 to map as encrypted
Content-Language: en-US
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 Borislav Petkov <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, Tianyu Lan
 <Tianyu.Lan@microsoft.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "ak@linux.intel.com" <ak@linux.intel.com>,
 "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "jane.chu@oracle.com" <jane.chu@oracle.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "tony.luck@intel.com" <tony.luck@intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <1673559753-94403-1-git-send-email-mikelley@microsoft.com>
 <1673559753-94403-7-git-send-email-mikelley@microsoft.com>
 <Y8r2TjW/R3jymmqT@zn.tnic>
 <BYAPR21MB168897DBA98E91B72B4087E1D7CA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y9FC7Dpzr5Uge/Mi@zn.tnic>
 <BYAPR21MB16883BB6178DDEEA10FD1F1CD7D69@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+JG9+zdSwZlz6FU@zn.tnic>
 <BYAPR21MB1688A80B91CC4957D938191ED7DB9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+KndbrS1/1i0IFd@zn.tnic>
 <BYAPR21MB1688608129815E4F90B9CAA3D7DB9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+KseRfWlnf/bvnF@zn.tnic>
 <BYAPR21MB16880F67072368255CBD815AD7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <BYAPR21MB16880F67072368255CBD815AD7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/23 16:18, Michael Kelley (LINUX) wrote:
> In v2 of this patch series, you had concerns about CC_ATTR_PARAVISOR being too
> generic. [1]   After some back-and-forth discussion in this thread, Boris is back to
> preferring it.   Can you live with CC_ATTR_PARAVISOR?  Just trying to reach
> consensus ... 

I still think it's too generic.  Even the comment was trying to be too
generic:

> +	/**
> +	 * @CC_ATTR_HAS_PARAVISOR: Guest VM is running with a paravisor
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine with
> +	 * a paravisor in VMPL0. Having a paravisor affects things
> +	 * like whether the I/O APIC is emulated and operates in the
> +	 * encrypted or decrypted portion of the guest physical address
> +	 * space.
> +	 *
> +	 * Examples include Hyper-V SEV-SNP guests using vTOM.
> +	 */
> +	CC_ATTR_HAS_PARAVISOR,

This doesn't help me figure out when I should use CC_ATTR_HAS_PARAVISOR
really at all.  It "operates in the encrypted or decrypted portion..."
Which one is it?  Should I be adding or removing encryption on the
mappings for paravisors?

That's opposed to:

> +	/**
> +	 * @CC_ATTR_ACCESS_IOAPIC_ENCRYPTED: Guest VM IO-APIC is encrypted
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine with
> +	 * an IO-APIC that is emulated by a paravisor running in the
> +	 * guest VM context. As such, the IO-APIC is accessed in the
> +	 * encrypted portion of the guest physical address space.
> +	 *
> +	 * Examples include Hyper-V SEV-SNP guests using vTOM.
> +	 */
> +	CC_ATTR_ACCESS_IOAPIC_ENCRYPTED,

Which makes this code almost stupidly obvious:

> -	flags = pgprot_decrypted(flags);
> +	if (!cc_platform_has(CC_ATTR_ACCESS_IOAPIC_ENCRYPTED))
> +		flags = pgprot_decrypted(flags);

"Oh, if it's access is not encrypted, then get the decrypted version of
the flags."

Compare that to:

	if (!cc_platform_has(CC_ATTR_PARAVISOR))
		flags = pgprot_decrypted(flags);

Which is a big fat WTF.  Because a paravisor "operates in the encrypted
or decrypted portion..."  So is this if() condition correct or inverted?
It's utterly impossible to tell because of how generic the option is.

The only way to make sense of the generic thing is to do:

	/* Paravisors have a decrypted IO-APIC mapping: */
	if (!cc_platform_has(CC_ATTR_PARAVISOR))
		flags = pgprot_decrypted(flags);

at every site to state the assumption and make the connection between
paravisors and the behavior.  If you want to go do _that_, then fine by
me.  But, at that point, the naming is pretty worthless because you
could also have said "goldfish" instead of "paravisor" and it makes an
equal amount of sense:

	/* Goldfish have a decrypted IO-APIC mapping: */
	if (!cc_platform_has(CC_ATTR_GOLDFISH))
		flags = pgprot_decrypted(flags);

I get it, naming is hard.
