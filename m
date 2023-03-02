Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5A9EA1
	for <iommu@lists.linux.dev>; Thu,  2 Mar 2023 01:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677722254; x=1709258254;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VRqd90hY1t2FT2RytSp8WhhcLmPRYFAUnVuH7PxZTFs=;
  b=kr80JiXYb+yZMpD9ZDCREiMLEB0p+uITzNXcctb1Cw4KrFrpA3JQNLfu
   LDF/2sfLO9Ks+qbBMPru8MwHhYlvyMdJitAYzoyhyZaa11cklpofvwriI
   Xd03aK8w+pqpHF+AWrisgqOXZqqFflZyfgbzFTvq6CRpEBQf2gb9D5pRf
   BkHptXfurO0FrflFm4wwKvadk4hGbLoQllMUIgKGutK10HG3aBo8w4i9N
   2AKVtfy4gL7d0fUJIUn5HEqI2rU350L46A5Ux8poS16vgktLklXR7sHq1
   YUgmWbaDkEUsU4b2b+J7NTjmsH9k+UjiLeRZxh9/CVvsKlWemmzztFzUj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336084411"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="336084411"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:57:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="624728809"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="624728809"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 01 Mar 2023 17:57:31 -0800
Message-ID: <f0ddf129-ec38-05d2-07dc-be5f97d37c78@linux.intel.com>
Date: Thu, 2 Mar 2023 09:56:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
 <Y/3yNaQD5Pkvf61k@nvidia.com>
 <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
 <Y/9bWMoAYF10ynO3@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y/9bWMoAYF10ynO3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/23 10:04 PM, Jason Gunthorpe wrote:
>> Here we are talking about soc-integrated devices vs. discrete PCI
>> devices (connected to the system through internal PCI slot). The problem
>> is that the DMAR ACPI table only defines ATS attribute for Soc-
>> integrated devices, which causes ATS (and its ancillary features) on the
>> discrete PCI devices not to work.
> So, IMHO, it is a bug to set what Linux calls as untrusted for
> discrete slots. We also definately don't want internal slots forced to
> non-identity mode either, for example.

Linux doesn't set untrusted for PCI discrete slots. It reads port's
ExternalFacingPort property and set pdev->untrusted for all devices
underneath it. For ACPI compatible platforms, this property is only set
for thunderbolt ports as far as I have seen.

drivers/pci/pci-acpi.c:
1373 static void pci_acpi_set_external_facing(struct pci_dev *dev)
1374 {
1375         u8 val;
1376
1377         if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
1378                 return;
1379         if (device_property_read_u8(&dev->dev, 
"ExternalFacingPort", &val))
1380                 return;
1381
1382         /*
1383          * These root ports expose PCIe (including DMA) outside of the
1384          * system.  Everything downstream from them is external.
1385          */
1386         if (val)
1387                 dev->external_facing = 1;
1388 }

and

drivers/pci/probe.c:
1597 static void set_pcie_untrusted(struct pci_dev *dev)
1598 {
1599         struct pci_dev *parent;
1600
1601         /*
1602          * If the upstream bridge is untrusted we treat this device
1603          * untrusted as well.
1604          */
1605         parent = pci_upstream_bridge(dev);
1606         if (parent && (parent->untrusted || parent->external_facing))
1607                 dev->untrusted = true;
1608 }

> 
> This should be addressed at the PCI layer. Untrusted should always
> mean that the iommu layer should fully secure the device. It means
> identity translation should be blocked, it means the HW should reject
> translated requests, and ATS thus is not supported.
> 
> Every single iommu driver should implement this consistently across
> the whole subsystem.
> 
> If you don't want devices to be secured then that is a PCI/bios layer
> problem to get the correct data into the untrusted flag.
> 
> Not an iommu problem to ignore the flag.

The problem here is that, even for PCI *trusted* devices, the IOMMU
drivers (Intel and SMMUv3) still have a allowed list for ATS. Only
devices in this list are allowed to use ATS. This cause some PCI
discrete devices not able to use ATS even its pdev->untrust is *not*
set.

The purpose of this patch is to allow privileged users to choose to skip
the allowed list according to their wishes. So that, as long as the PCI
layer treats the device as trusted, it can use ATS in the IOMMU layer.

At present, this patch is only for VT-d driver, but I have no objection
to bring it up to the core as a common mechanism.

Best regards,
baolu
