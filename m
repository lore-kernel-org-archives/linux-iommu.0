Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA976AB0
	for <iommu@lists.linux.dev>; Wed,  8 Feb 2023 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675877030; x=1707413030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P9o81TrnMYv/0lzBvAqefabI0OL+xE9TlzWfKBiybMI=;
  b=C0WLMg2AL96BZx1Gfs7XW9DWhZUbYMowmRxp1RauX08AS8ohVOfid6SX
   4FbN0dlsd7Tx6DBPeRivZAUrKX6TNLk3fX5qBKVJNqJmQdPXFG9QYUD/H
   nxZH7nuWzDTRP+k6sWU1GTGZsuTx+8RupduhFVLy8idPsv2GP0ZwYJKRc
   VTyqAuCH4xyhH2xy++Nxbf3NPKrDiN3QoZEojJkVebDJmudE9RTLSBfum
   cgCvAcxh/hcm0Sfz8ySLBxHB2a8jkMct56I9sSL6270PXJrfzmcQBzWuq
   CxQ7WFp77D4aY084q3OayKzJvyR/3fEJZFG5/tQ6jGzVB7VItx9eHs2+p
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309515354"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="309515354"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 09:23:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="699726611"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="699726611"
Received: from tbacklun-mobl.amr.corp.intel.com (HELO [10.209.14.225]) ([10.209.14.225])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 09:23:47 -0800
Message-ID: <4216dea6-d899-aecb-2207-caa2ae7db0e3@intel.com>
Date: Wed, 8 Feb 2023 09:23:46 -0800
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
 <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>,
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
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y+JG9+zdSwZlz6FU@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/23 04:41, Borislav Petkov wrote:
> Or are there no similar TDX solutions planned where the guest runs
> unmodified and under a paravisor?

I actually don't think paravisors make *ANY* sense for Linux.  If you
have to modify the guest, then just modify it to talk to the hypervisor
directly.  This code is... modifying the guest.  What does putting a
paravisor in the middle do for you?

It might help with binary drivers, but we don't do upstream kernel work
to make silly binary Linux drivers happy.

So, no, there's no similar TDX solutions planned, at least for Linux
guests.  Unless I missed the memo.  Kirill?
