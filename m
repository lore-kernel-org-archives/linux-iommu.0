Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132873222
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669141833; x=1700677833;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BEn7669Y/qpoLWxlJH/t+9MokSfp1qnFTNQyr2DK8ug=;
  b=NLKhuUwpA8xhRgJ7+iDAVcAnyB1ZK9VBZjuJQYRDM84oF7dW5JwK1zzi
   sCjKzcmy73Joktwhm87gK2fwGb7Ux02Q6GZr9Bgxj1rG83uz5wH28bzf6
   ICwxxSbWxFZachgcPzfqyBrsi/KKDAVlSFTFo5z6E8wr1QkqH5T0BFvYJ
   7l38yirM+dWvISSb996HPqxBFm+hQcRpBWJpEB2NFC4wuJYMCL610DY4w
   B5vSunYHNXzu/bZ1fPEVIwwAMcucoDXBu1jZr+7bRRhEzAC45mkGFOvRb
   qdGE125cLLJY+PS7jpmLqsz2rXmDgiXY5S0ru1XYzv/9t6ewAKUuFieXT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="312586014"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="312586014"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 10:30:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="783936620"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="783936620"
Received: from coltsavx-mobl1.amr.corp.intel.com (HELO [10.255.0.114]) ([10.255.0.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 10:30:25 -0800
Message-ID: <cff68b1a-c239-4d52-27b0-536079243981@intel.com>
Date: Tue, 22 Nov 2022 10:30:23 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [Patch v3 07/14] x86/hyperv: Change vTOM handling to use standard
 coco mechanisms
Content-Language: en-US
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 Borislav Petkov <bp@alien8.de>
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
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
 <1668624097-14884-8-git-send-email-mikelley@microsoft.com>
 <Y3uTK3rBV6eXSJnC@zn.tnic>
 <BYAPR21MB16886AF404739449CA467B1AD70D9@BYAPR21MB1688.namprd21.prod.outlook.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <BYAPR21MB16886AF404739449CA467B1AD70D9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/22 10:22, Michael Kelley (LINUX) wrote:
> Anyway, that's where I think this should go. Does it make sense?
> Other thoughts?

I think hard-coding the C-bit behavior and/or position to a vendor was
probably a bad idea.  Even the comment:

u64 cc_mkenc(u64 val)
{
        /*
         * Both AMD and Intel use a bit in the page table to indicate
         * encryption status of the page.
         *
         * - for AMD, bit *set* means the page is encrypted
         * - for Intel *clear* means encrypted.
         */

doesn't make a lot of sense now.  Maybe we should just have a:

	CC_ATTR_ENC_SET

which gets set for the "AMD" behavior and is clear for the "Intel"
behavior.  Hyper-V code running on AMD can set the attribute to get teh
"Intel" behavior.

That sure beats having a Hyper-V vendor.
