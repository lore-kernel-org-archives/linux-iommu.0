Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574C10FA
	for <iommu@lists.linux.dev>; Thu,  2 Mar 2023 04:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677731053; x=1709267053;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v5b7ljPO/DDlID9gofehMryLNcSPUQ8+e5skFkdCs8E=;
  b=gMpRGsh7Sa3bgmNFJ3OGvonhFMC/OMaJn68VxRCXdfptd3vrrovE9F/+
   Uy0CwOtp8Eypdm0JFlwUrnOEqR0OEQ6CnzTmDylMYqHd/HytnMZYyNPcJ
   14AEsDuhHRlEwaT21nlrfPZqznnJw+x+Uq7bnRFAbuA+kWAZjtbBmpVAR
   O13kdnaBUwWTtDR6gcWj40FivR62WbvGd1zsX65SWbS+dQ3NJvmsfH3HT
   niiYT0NHId63EH6/jkzm/1HdHqj5dSHmCstK9EvoU5/jB/AEH/7PSzi5M
   lXZXPdN/W1iFjy5KdHD0g7IB1jECe18JiXdFjox94XAxsgx3FP68PPeiR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420873170"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="420873170"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 20:24:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="817836706"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="817836706"
Received: from rmarti10-mobl2.amr.corp.intel.com (HELO [10.212.193.233]) ([10.212.193.233])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 20:24:11 -0800
Message-ID: <917b1d52-54c2-ea8b-5382-dbd8ce71a76c@linux.intel.com>
Date: Wed, 1 Mar 2023 20:24:10 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/2] Add support to enable ATS on VFs independently
Content-Language: en-US
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com, will@kernel.org
Cc: jean-philippe@linaro.org, darren@os.amperecomputing.com,
 scott@os.amperecomputing.com
References: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/27/23 8:21 PM, Ganapatrao Kulkarni wrote:
> As discussed in [1], adding a helper function to configure the STU of an
> ATS capability. Function pci_ats_stu_configure() can be called to program
> the STU while enumerating the PF, to support scenarios like PF is not
> enabled with ATS, whereas VFs can enable it.
> 
> In SMMU-V3 driver, calling pci_ats_stu_configure() to confgiure the STU
> while enumerating a PF in passthrough mode.

It looks like you are fixing this issue only for your platform. Is there any
way to generically program PF STU? May be from pci_ats_init()?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
