Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC917CB
	for <iommu@lists.linux.dev>; Sun, 29 Jan 2023 08:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674981759; x=1706517759;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yj31DtnhOPC3pgFppYWP6STDM0yAE4vERS7w0dRmqG8=;
  b=cN8i4PRF334sI5pX0BpnVRQQHSJCQ44apQrKRcO845E4F2DXNd1X+ErO
   pn6CRhBK505Ke9DLQtFDm0rGfG4It0vEuma8PjXphFsc8VdSn7Tdu6/J5
   S8nrRl9V54ldhcJhdKk8N5pzPSgSg40iwj4lLMVEjJngq4lA7xtK3nri6
   Tu7asomShTj0D1nmakfDILB8Xj/rstr7ppS2AIMKhqE7dFCe7+JoD0CRp
   uO9NsNtZB2JgNEsShK/n3dJImw5j00R0fzHYmRPbSWIBm7EgMoH2dKBQ5
   5JcQnSl7zs4HvCUFYNFzWox7IFiEqFT6RsUukPXcSOkC2DK9AfpFPReH7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="354690544"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="354690544"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 00:42:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="613680311"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="613680311"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.247]) ([10.254.214.247])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 00:42:34 -0800
Message-ID: <647de371-fe11-15b4-5e11-8ca43a754180@linux.intel.com>
Date: Sun, 29 Jan 2023 16:42:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 Joerg Roedel <jroedel@suse.de>, Matt Fagnani <matt.fagnani@bell.net>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Tony Zhu <tony.zhu@intel.com>,
 linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20230127173035.GA994835@bhelgaas>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230127173035.GA994835@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bjorn,

Thanks for your review comments.

On 2023/1/28 1:30, Bjorn Helgaas wrote:
> On Sat, Jan 14, 2023 at 03:34:20PM +0800, Lu Baolu wrote:
>> The PCIe fabric routes Memory Requests based on the TLP address, ignoring
>> the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
>> Enable PASID only when ACS RR & UF enabled on upstream path") requires
>> some ACS features being supported on device's upstream path when enabling
>> PCI/PASID.
>>
>> One alternative is ATS/PRI which lets the device resolve the PASID + addr
>> pair before a memory request is made into a routeable TLB address through
>> the translation agent.
> 
> This sounds like "ATS/PRI" is a solution to a problem, but we haven't
> stated the problem yet.
> 
>> Those resolved addresses are then cached on the
>> device instead of in the IOMMU TLB and the device always sets translated
>> bit for PASID. One example of those devices are AMD graphic devices that
>> always have ACS or ATS/PRI enabled together with PASID.
>>
>> This adds a flag parameter in the pci_enable_pasid() helper, with which
>> the device driver could opt-in the fact that device always sets the
>> translated bit for PASID.
> 
> Nit: "Add a flag ..." and "Apply this opt-in ..." (below).
> 
>> It also applies this opt-in for AMD graphic devices. Without this change,
>> kernel boots to black screen on a system with below AMD graphic device:
>>
>> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
>>          [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
>>          (prog-if 00 [VGA controller])
>> 	DeviceName: ATI EG BROADWAY
>> 	Subsystem: Hewlett-Packard Company Device 8332
> 
> What is the underlying failure here?  "Black screen" is useful but we
> should say *why* that happens, e.g., transactions went the wrong place
> or whatever.

All above make sense to me. I post my new commit message at the end of
this reply.

> 
>> At present, it is a common practice to enable/disable PCI PASID in the
>> iommu drivers. Considering that the device driver knows more about the
>> specific device, we will follow up by moving pci_enable_pasid() into
>> the specific device drivers.
> 
>> @@ -353,12 +353,15 @@ void pci_pasid_init(struct pci_dev *pdev)
>>    * pci_enable_pasid - Enable the PASID capability
>>    * @pdev: PCI device structure
>>    * @features: Features to enable
>> + * @flags: device-specific flags
>> + *   - PCI_PASID_XLATED_REQ_ONLY: The PCI device always use translated type
>> + *                                for all PASID memory requests.
> 
> s/use/uses/

Yes.

> 
> I guess PCI_PASID_XLATED_REQ_ONLY is something only the driver knows,
> right?  We can't deduce from architected config space that the device
> will produce PASID prefixes for every Memory Request, can we?

No, we can't. That's the reason why we need a flag here.

[ Below is an updated commit message. Hope it can describe things
   clearly.]

PCI: Add translated request only flag for pci_enable_pasid()

The PCIe fabric routes Memory Requests based on the TLP address, ignoring
the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
Enable PASID only when ACS RR & UF enabled on upstream path") requires
some ACS features being supported on device's upstream path when enabling
PCI/PASID.

However, above change causes the Linux kernel boots to black screen on a
system with below graphic device:

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
         [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
         (prog-if 00 [VGA controller])
         DeviceName: ATI EG BROADWAY
         Subsystem: Hewlett-Packard Company Device 8332

The kernel trace looks like below:

  Call Trace:
   <TASK>
   amd_iommu_attach_device+0x2e0/0x300
   __iommu_attach_device+0x1b/0x90
   iommu_attach_group+0x65/0xa0
   amd_iommu_init_device+0x16b/0x250 [iommu_v2]
   kfd_iommu_resume+0x4c/0x1a0 [amdgpu]
   kgd2kfd_resume_iommu+0x12/0x30 [amdgpu]
   kgd2kfd_device_init.cold+0x346/0x49a [amdgpu]
   amdgpu_amdkfd_device_init+0x142/0x1d0 [amdgpu]
   amdgpu_device_init.cold+0x19f5/0x1e21 [amdgpu]
   ? _raw_spin_lock_irqsave+0x23/0x50
   amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
   amdgpu_pci_probe+0x161/0x370 [amdgpu]
   local_pci_probe+0x41/0x80
   pci_device_probe+0xb3/0x220
   really_probe+0xde/0x380
   ? pm_runtime_barrier+0x50/0x90
   __driver_probe_device+0x78/0x170
   driver_probe_device+0x1f/0x90
   __driver_attach+0xce/0x1c0
   ? __pfx___driver_attach+0x10/0x10
   bus_for_each_dev+0x73/0xa0
   bus_add_driver+0x1ae/0x200
   driver_register+0x89/0xe0
   ? __pfx_init_module+0x10/0x10 [amdgpu]
   do_one_initcall+0x59/0x230
   do_init_module+0x4a/0x200
   __do_sys_init_module+0x157/0x180
   do_syscall_64+0x5b/0x80
   ? handle_mm_fault+0xff/0x2f0
   ? do_user_addr_fault+0x1ef/0x690
   ? exc_page_fault+0x70/0x170
   entry_SYSCALL_64_after_hwframe+0x72/0xdc

The AMD iommu driver allocates a new domain (called v2 domain) for the
amdgpu device and enables its PCI PASID/ATS/PRI before attaching the
v2 domain to it. The failure of pci_enable_pasid() due to lack of ACS
causes the domain attaching device to fail. The amdgpu device is unable
to DMA normally, resulting in a black screen of the system.

However, this device is special as it relies on ATS/PRI to resolve the
PASID + addr pair before a memory request is made into a routeable TLB
address through the translation agent. Those resolved addresses are then
cached on the device instead of in the IOMMU TLB and the device always
uses translated memory request for PASID.

ACS is not necessary for the devices that always use translated memory
request for PASID. But this is device specific and only device driver
knows this. We can't deduce this from architected config space.

Add a flag for pci_enable_pasid(), with which the device drivers could
opt-in the fact that device always uses translated memory requests for
PASID hence the ACS is not a necessity. Apply this opt-in for above AMD
graphic device.

At present, it is a common practice to enable/disable PCI PASID in the
iommu drivers. Considering that the device driver knows more about the
specific device, it's better to move pci_enable_pasid() into the specific
device drivers.
[-- end --]

--
Best regards,
baolu
