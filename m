Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C7185D
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 04:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660711532; x=1692247532;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UjD+HW5PoXnqMGFz9/0Nw0PbBXNXL6BNrwD8PcumuWo=;
  b=i+0MgeuAwlq4DjQHP0cwU1pS7C5jpy8W6kbFaBOt9fnhSfwnxSszAVvw
   ZTCm+WLSe1guexTG0s8swIZ0cbH6y2oC8oxqxYBwmoCOSorBD55cC6hSg
   EC+Ocfp3n5v4VcO5fideCRNCBQ+whLF7Q2x/g5mcrNauasDmTueH+ZjDU
   ID2IASZ+lH72RnKz4JR55787GUk++IQoUibjSfUoCh9QrO/u4RLCEjKoA
   4yG0/m4Kce0jKgG6tWxU+MHcj4y9gr+3VQfcESlkpSFHQYmfv33YpQgWz
   7jNLYaAiN1gpTAREhicgWk7J7ZFieRcyZUOa6fkBCMAuB0uVIiOHA6M5j
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="289969160"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="289969160"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 21:45:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667434920"
Received: from jzhan60-mobl1.ccr.corp.intel.com (HELO [10.254.209.228]) ([10.254.209.228])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 21:45:28 -0700
Message-ID: <5f734387-9757-0670-3eef-b565116af541@linux.intel.com>
Date: Wed, 17 Aug 2022 12:45:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, linux-kernel@vger.kernel.org,
 Scarlett Gourley <scarlett@arista.com>, James Sewart
 <jamessewart@arista.com>, Jack O'Sullivan <jack@arista.com>
Subject: Re: lockdep splat due to klist iteration from atomic context in Intel
 IOMMU driver
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 Lennert Buytenhek <buytenh@wantstofly.org>, Sasha Levin <sashal@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux.dev
References: <Yvo2dfpEh/WC+Wrr@wantstofly.org>
 <ab15191c-d79f-b5de-7568-d15b8f8a8aa8@acm.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ab15191c-d79f-b5de-7568-d15b8f8a8aa8@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022/8/15 21:32, Bart Van Assche wrote:
> On 8/15/22 05:05, Lennert Buytenhek wrote:
>> On a build of 7ebfc85e2cd7 ("Merge tag 'net-6.0-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"), with
>> CONFIG_INTEL_IOMMU_DEBUGFS enabled, I am seeing the lockdep splat
>> below when an I/O page fault occurs on a machine with an Intel
>> IOMMU in it.
>>
>> The issue seems to be the klist iterator functions using
>> spin_*lock_irq*() but the klist insertion functions using
>> spin_*lock(), combined with the Intel DMAR IOMMU driver iterating
>> over klists from atomic (hardirq) context as of commit 8ac0b64b9735
>> ("iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()")
>> when CONFIG_INTEL_IOMMU_DEBUGFS is enabled, where
>> pci_get_domain_bus_and_slot() calls into bus_find_device() which
>> iterates over klists.
>>
>> I found this commit from 2018:
>>
>>     commit 624fa7790f80575a4ec28fbdb2034097dc18d051
>>     Author: Bart Van Assche <bvanassche@acm.org>
>>     Date:   Fri Jun 22 14:54:49 2018 -0700
>>
>>         scsi: klist: Make it safe to use klists in atomic context
>>
>> This commit switched lib/klist.c:klist_{prev,next} from
>> spin_{,un}lock() to spin_{lock_irqsave,unlock_irqrestore}(), but left
>> the spin_{,un}lock() calls in add_{head,tail}() untouched.
>>
>> The simplest fix for this would be to switch 
>> lib/klist.c:add_{head,tail}()
>> over to use the IRQ-safe spinlock variants as well?
> 
> Another possibility would be to evaluate whether it is safe to revert 
> commit 624fa7790f80 ("scsi: klist: Make it safe to use klists in atomic 
> context"). That commit is no longer needed by the SRP transport driver 
> since the legacy block layer has been removed from the kernel.

If so, pci_get_domain_bus_and_slot() can not be used in this interrupt
context, right?

Best regards,
baolu
