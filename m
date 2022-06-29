Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A337E0
	for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 06:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656483349; x=1688019349;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MIRJXsI3AGI9TOUBaCXQFdgFRZepMITCdgAbqxVUet0=;
  b=J5dhK/r8VgiCoHB5/jwDISC4q1Sp2Yd+NwHR1BQ8vuUx/woryIqdmSOI
   wD7szY1EAeAX1ZJeR+gpdmXpc/kU+gDwHzgNVFmFnk1xfSCx/yGg+ZVmm
   T1ET/BDMjP29liyg0xYztYe/IpRu/QCdSJB+AXFQvC6YS19ZY+mzsbe71
   gbvVq9tOSb+geyBnKDflGoCPmNzv2pE6wHEJPEyNaEXRrtEpOMZboLfiH
   4VzRFeNYdcEzFU89xJN/8Hr+TwTBBZ1TpaYnVImY3aAbN+A4KfnlTq6ej
   ePcMEsS7O3qbwB4J/G25ETazt3O6KYdjIHm4iqxRLUYbT/LLPkJkd4YHW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270699441"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="270699441"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 23:15:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="595103334"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.214.131]) ([10.254.214.131])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 23:15:30 -0700
Message-ID: <2e99710b-becc-1e03-fa10-ad5f2dd06802@linux.intel.com>
Date: Wed, 29 Jun 2022 14:15:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
 <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
 <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
 <YrsOO9E+j+CMgKMA@myrica>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <YrsOO9E+j+CMgKMA@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20220629061528.YCke_W-NGPXTPmuSnnv4TiKBna6KAyv4IAPyyHmYsMo@z>


在 2022/6/28 22:20, Jean-Philippe Brucker 写道:
> On Tue, Jun 28, 2022 at 07:53:39PM +0800, Baolu Lu wrote:
>>>>> Once the iopf_handle_single() is removed, the name of
>>>>> iopf_handle_group() looks a little weired
>>>>>
>>>>> and confused, does this group mean the iommu group (domain) ?
>>>>> while I take some minutes to
>>>> No. This is not the iommu group. It's page request group defined by the
>>>> PCI SIG spec. Multiple page requests could be put in a group with a
>>>> same group id. All page requests in a group could be responded to device
>>>> in one shot.
>>> Thanks your explaination, understand the concept of PCIe PRG.  I meant
>>>
>>> do we still have the necessity to mention the "group" here in the name
>>>
>>> iopf_handle_group(),  which one is better ? iopf_handle_prg() or
>>>
>>> iopf_handler(),  perhaps none of them ? :)
>> Oh! Sorry for the misunderstanding.
>>
>> I have no strong feeling to change this naming. :-) All the names
>> express what the helper does. Jean is the author of this framework. If
>> he has the same idea as you, I don't mind renaming it in this patch.
> I'm not attached to the name, and I see how it could be confusing. Given
> that io-pgfault is not only for PCIe, 'prg' is not the best here either.
> iopf_handle_faults(), or just iopf_handler(), seem more suitable.

Both iopf_handle_faults() and iopf_handler() looks straight, iopf_handler()

saves one word 'faults', iopf already has the meaning 'io page fault' , so

iopf_handler() is clear enough I think.


Thanks,

Ethan

>
> Thanks,
> Jean

-- 
"firm, enduring, strong, and long-lived"

