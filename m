Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C7F1F5858
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384385; cv=none; b=lZYf4/IpK0pk/w89tgOcyq4GI0dHs1a2BbiKIzIrKtHeA56OonGuiJq912UhWKWa72+D4NKqs7ieN8HbVTmy6I++VIXdHv13+brLKkrd0vmTJzPen1giRsgCk7SFtELwDd+ytzaRoImhjgi/h3ZASrEhcfa7gjZdg8LjKOByJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384385; c=relaxed/simple;
	bh=Y+nRLc/99aU+E7mPIczUl1sCufEzfonY4yi1sESyfPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSlil2e7kU9NI8HO5XB+CAR8edXnxwo8MnKaWBsVwIg1daJVFB0XiIdocTbzVasu51EcAipRLoEF3otovohoqx2AlWMG6Dk0YzDJEPlC971DxGy6I9TivoQgWLLZyIgE+M/m7ECVdxfFsvszSaxlVUDfQjDpmuJmrh/8OqAvDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 402171007;
	Fri, 11 Apr 2025 08:13:03 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 813323F59E;
	Fri, 11 Apr 2025 08:13:02 -0700 (PDT)
Message-ID: <5c8d16f9-246e-45d0-aaac-45b7712cefb5@arm.com>
Date: Fri, 11 Apr 2025 16:13:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow stream table to have nodes with
 the same ID
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org
Cc: joro@8bytes.org, jgg@nvidia.com, jsnitsel@redhat.com, praan@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250411044706.356395-1-nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250411044706.356395-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 5:47 am, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> ASPEED VGA card has two built-in devices:
>   0008:06:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 06)
>   0008:07:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 52)
> 
> Its toplogy looks like this:
>   +-[0008:00]---00.0-[01-09]--+-00.0-[02-09]--+-00.0-[03]----00.0  Sandisk Corp Device 5017
>                               |               +-01.0-[04]--
>                               |               +-02.0-[05]----00.0  NVIDIA Corporation Device
>                               |               +-03.0-[06-07]----00.0-[07]----00.0  ASPEED Technology, Inc. ASPEED Graphics Family
>                               |               +-04.0-[08]----00.0  Renesas Technology Corp. uPD720201 USB 3.0 Host Controller
>                               |               \-05.0-[09]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
>                               \-00.1  PMC-Sierra Inc. Device 4028
> 
> Being a legacy PCI device that does not have RID on the wire, the system
> does not preserve a RID for that PCI bridge (0008:06), so the IORT code
> has to dma alias for iort_pci_iommu_init() via pci_for_each_dma_alias(),
> resulting in both of them getting the same Stream ID.

Hmm, actually, this doesn't even make a whole heap of sense, and it's
not what's happening here at all.

The bridge *does* claim its own RID, and per the aliasing rules the
devices behind it claim both their own RID and the alias to function
00.0 on the bridge's secondary bus, like so in action:

[    1.040905] pci 0000:04:00.0: arm_smmu_insert_master: SID 0x400
[    1.046988] pci 0000:04:00.0: Adding to iommu group 0
[    1.046995] pci 0000:05:04.0: arm_smmu_insert_master: SID 0x520
[    1.053750] pci 0000:05:04.0: arm_smmu_insert_master: SID 0x500
[    1.053759] pci 0000:05:04.0: Adding to iommu group 0
[    1.053765] pci 0000:05:05.0: arm_smmu_insert_master: SID 0x528
[    1.053767] pci 0000:05:05.0: arm_smmu_insert_master: SID 0x500
[    1.053768] pci 0000:05:05.0: Aliasing StreamID 0x500 unsupported, 
expect DMA to be broken

Which is a snippet from this topology:

-+-[0001:00]---00.0-[01]----00.0  Samsung Electronics Co Ltd NVMe SSD 
Controller SM981/PM981/PM983
  \-[0000:00]---00.0-[01-09]--+-00.0-[02-09]--+-08.0-[03]----00.0  VIA 
Technologies, Inc. VL805/806 xHCI USB 3.0 Controller
                              | 
+-10.0-[04-05]----00.0-[05]--+-04.0  Intel Corporation 82557/8/9/0/1 
Ethernet Pro 100
                              |               | 
   \-05.0  Broadcom Inc. and subsidiaries BCM4306 802.11b/g Wireless LAN 
Controller
                              |               +-11.0-[06]--
                              |               +-12.0-[07]----00.0 
Marvell Technology Group Ltd. Device 9170

(yes, I have a physical PCIe-to-PCI bridge board with random ancient
cards plugged into it specifically for griefing the SMMU drivers :D)

> On a kernel prior to v6.15-rc1, there has been an overlooked warning:
>    pci 0008:07:00.0: vgaarb: setting as boot VGA device
>    pci 0008:07:00.0: vgaarb: bridge control possible
>    pci 0008:07:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
>    pcieport 0008:06:00.0: Adding to iommu group 14
>    ast 0008:07:00.0: stream 67328 already in tree   <===== WARNING

However in the ASpeed VGA case, we get a single device aliasing with
*itself*, because the physical RID is already function 00.0 - this is
more obvious on our CI's Ampere Altra system where the SID mappings have
no additional upper bits:

[   22.953940] pci 0004:01:00.0: PCI bridge to [bus 02]
...
[   23.037980] pci 0004:02:00.0: [1a03:2000] type 00 class 0x030000 
conventional PCI endpoint
...
[   27.383602] pci 0004:01:00.0: Adding to iommu group 28
[   27.394562] pci 0004:02:00.0: stream 512 already in tree

512 == 0x200 == 02:00.0


Now that's supposed to have been supported since forever ago with
563b5cbe334e ("iommu/arm-smmu-v3: Cope with duplicated Stream IDs"),
however from a quick look I'm guessing cdf315f907d4 ("iommu/arm-smmu-v3:
Maintain a SID->device structure") might have broken it...

Thanks,
Robin.
