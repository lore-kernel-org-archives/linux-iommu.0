Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6A15CA1
	for <iommu@lists.linux.dev>; Sat, 29 Oct 2022 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667031129; x=1698567129;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=0l8conNN1TjxcoCVVzLHCVgHjFaZt6Qyb2532sp6hBU=;
  b=aaavpMVJvBJAyntBjbba0VWwyKf8IZ8fURbwF+L+wLN6IeHoZ313qqiK
   TgPkSISxYDCwZ8YpIHnH/dJCCSlG9jckfmsto3kx9SnrwC1Gwq0wIjFW6
   f3q8qsfn5vNwZQSVPaZuBs2NLeF/806AYuXSYZk3z/MQslH/d39dA/sLY
   N6HV05xIj1nfFjM36Wx9F/7Jj2MFNiQzqtu/6nM8NWEycdDiYvzaywE19
   V0F68zfj2A9PS3s0JdXNU2RP6gP2Av5sN/DHHcrYB6o6LmQD/i8P6XoZU
   QGg7No0mFNZqSSYAriDqzp4/HTK1S0VZ0+SUPtfThfDGHvz0nC3DjGlm1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="296057517"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="296057517"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 01:12:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="878230034"
X-IronPort-AV: E=Sophos;i="5.95,223,1661842800"; 
   d="scan'208";a="878230034"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.211]) ([10.254.215.211])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 01:12:06 -0700
Message-ID: <1ea0d41c-906a-38a0-adb8-60a7b63ad65b@linux.intel.com>
Date: Sat, 29 Oct 2022 16:12:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Scarlett Gourley <scarlett@arista.com>,
 James Sewart <jamessewart@arista.com>, Jack O'Sullivan <jack@arista.com>
Content-Language: en-US
To: Lennert Buytenhek <buytenh@wantstofly.org>
References: <Y1eZbXKdJDoS8loC@wantstofly.org>
 <028e2c63-939b-af31-88b9-b479b41ce67c@linux.intel.com>
 <Y1o/EhV+XLgA9s2r@wantstofly.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH,RFC] iommu/vt-d: Convert dmar_fault IRQ to a threaded IRQ
In-Reply-To: <Y1o/EhV+XLgA9s2r@wantstofly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/10/27 16:19, Lennert Buytenhek wrote:
>>> iommu/amd already uses a threaded IRQ handler for its I/O page fault
>>> reporting, and so it already has this advantage.
>>>
>>> When IRQ remapping is enabled, iommu/vt-d will try to set up its
>>> dmar_fault IRQ handler from start_kernel() -> x86_late_time_init()
>>> -> apic_intr_mode_init() -> apic_bsp_setup() ->
>>> irq_remap_enable_fault_handling() -> enable_drhd_fault_handling(),
>>> which happens before kthreadd is started, and trying to set up a
>>> threaded IRQ handler this early on will oops.  However, there
>>> doesn't seem to be a reason why iommu/vt-d needs to set up its fault
>>> reporting IRQ handler this early, and if we remove the IRQ setup code
>>> from enable_drhd_fault_handling(), the IRQ will be registered instead
>>> from pci_iommu_init() -> intel_iommu_init() -> init_dmars(), which
>>> seems to work just fine.
>> At present, we cannot do so. Because the VT-d interrupt remapping and
>> DMA remapping can be independently enabled. In another words, it's a
>> possible case where interrupt remapping is enabled while DMA remapping
>> is not.
> Is there a way I can test this easily?
> 
> I think we should be able to handle the "interrupt remapping enabled
> but DMA remapping disabled" case in the same way, by registering the
> dmar_fault IRQ sometime after kthreadd has been started.  I don't think
> the dmar_fault handler performs any function that is critical for the
> operation of the IOMMU, and I think that we can defer setting it up
> until whenever is convenient.

Another possible way is not to split VT-d DMA remapping and interrupt
remapping. The possible case of "intr remapping enabled but DMA
remapping not" that I can imagine is that the guest VM doesn't want DMA
translation because of poor efficiency. If so, the overhead impacted by
DMA translation can be eliminated through "iommu=pt" or kernel build
configuration. Of course, there may also be some special needs that I
did not think of.

Best regards,
baolu
