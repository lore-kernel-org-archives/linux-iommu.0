Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98C10786
	for <iommu@lists.linux.dev>; Mon, 21 Nov 2022 22:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669068417; x=1700604417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7JevZklHRhgjJyAYKj9U70VX+jOIJ49nUGohqNammx8=;
  b=OAR7gfR0NuHDfY/kWoz6CMumxjPywqwY7ivJaLcafKzSA+5Axnef3VmL
   q54dnT4+sWGOoVjHoh3KoN4mEAOS1eXtZ8vWjXHlvgjotabtMC5/Msr6p
   OT3DcMMfuxQNhqm2hXrhpVeLSv/yNMnPGm1F/ZHqdEaMxytgmOnqc6TGc
   yA8Z7WdYdVh+PNZBy2TIrMrzVVJZIq/GlV/4GXUP3PSrKNyJrGeU54CK5
   lHNWs7b/mUgVjoC9YNYMVM2BqhYABxQ9XaTLNnzzAspETGTYCiwV0+mRs
   1/wqY2XyeglwiXNryVy2JYZDZ49cYWLjuyHomcJ7qcRrSDzLgVtjgY8Om
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="375816719"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="375816719"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 14:06:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672250971"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="672250971"
Received: from dylanhol-mobl.amr.corp.intel.com (HELO [10.212.242.103]) ([10.212.242.103])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 14:06:54 -0800
Message-ID: <6b5129cf-6986-bbb1-7e60-37849fc383fc@linux.intel.com>
Date: Mon, 21 Nov 2022 14:06:54 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [Patch v3 05/14] x86/mm: Handle decryption/re-encryption of
 bss_decrypted consistently
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>,
 "Michael Kelley (LINUX)" <mikelley@microsoft.com>
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
 <arnd@arndb.de>, "hch@infradead.org" <hch@infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "ak@linux.intel.com" <ak@linux.intel.com>,
 "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
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
References: <1668624097-14884-1-git-send-email-mikelley@microsoft.com>
 <1668624097-14884-6-git-send-email-mikelley@microsoft.com>
 <01d7c7cc-bd4e-ee9b-f5b2-73ea367e602f@linux.intel.com>
 <BYAPR21MB1688A31ED795ED1B5ACB6D26D7099@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y3uNj0z26EjkHeCn@zn.tnic>
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Y3uNj0z26EjkHeCn@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/22 6:39 AM, Borislav Petkov wrote:
> On Fri, Nov 18, 2022 at 02:55:32AM +0000, Michael Kelley (LINUX) wrote:
>> But I had not thought about TDX.  In the TDX case, it appears that
>> sme_postprocess_startup() will not decrypt the bss_decrypted section.
>> The corresponding mem_encrypt_free_decrypted_mem() is a no-op unless
>> CONFIG_AMD_MEM_ENCRYPT is set.  But maybe if someone builds a
>> kernel image that supports both TDX and AMD encryption, it could break
> 
> sme_me_mask better be 0 on a kernel with both built in and running as a
> TDX guest.
> 

Yes. It will be 0 in TDX. In sme_enable(), AMD code checks for CPUID
support before updating the sme_me_mask.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
