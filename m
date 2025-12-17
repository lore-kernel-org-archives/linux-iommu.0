Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C65D3358D2
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979320; cv=none; b=KiDwrtywNjLTxIME/q+TxMg5EXzaJnQ8vVrzsAnFj6blsICHSzuCO0+xxO5BeWf7fWF7rpKOOpwhuHKAAoiw/aIcoJt+2ORybDdJcpqhhx/qpyhpD2ykJEQeK6y1Op/g+vliazq+GQADVPAFUciZjsyi8+aTNl0FmSyzs2MEZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979320; c=relaxed/simple;
	bh=uquE4H4qjt6mI4YmO8XpqFb5elPyppBqh5Yg5scPdFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpU4DRhxzqYBVZwsWiWEbhqXsjOsffJQXHd4KiHnLPFsqFBmQ/zokdcTkwBCUnmOtXo5RWd/a61ThME4ozo/BU0qUE6O8LZYh7m9qMA8+lmiYd5c7W7esODlNtCZg+Xa6NUA/MiuyAp6cJtP1R7HQOh5nRcno+JrP4syaJ05zAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8611D339;
	Wed, 17 Dec 2025 05:48:30 -0800 (PST)
Received: from [10.1.196.95] (e121345-lin.cambridge.arm.com [10.1.196.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32F313F73F;
	Wed, 17 Dec 2025 05:48:36 -0800 (PST)
Message-ID: <72c7fb61-a4b8-4443-86ff-84345fe1ced4@arm.com>
Date: Wed, 17 Dec 2025 13:48:34 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add quirk for ASPEED AST1150 bridge to prevent false
 RID aliasing
To: Nirmoy Das <nirmoyd@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 jammy_huang@aspeedtech.com
References: <20251217133232.274942-1-nirmoyd@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251217133232.274942-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2025 1:32 pm, Nirmoy Das wrote:
> ASPEED BMC controllers have VGA and USB functions behind a PCIe-to-PCI
> bridge that causes them to share the same stream ID:
> 
>    [e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Graphics Family
>                                      \-02.0  ASPEED USB Controller
> 
> Both devices get stream ID 0x5e200 due to bridge aliasing, causing the
> USB controller to be rejected with 'Aliasing StreamID unsupported'.
> 
> Per ASPEED, the AST1150 operates in PCI mode where downstream devices
> generate their own distinct Requester IDs. Set
> PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT to stop false alias detection.

I don't think that's really the right quirk - that one effectively means 
"RID aliasing upstream of this bridge is irrelevant", whereas what you 
want here is "RID aliasing *at* this bridge doesn't happen even though 
it looks like it could". With BRIDGE_XLATE_ROOT, I think if you then put 
this behind a contrived upstream chain of additional PCIe->PCI->PCIE 
bridges that *could* legitimately introduce further aliasing, it would 
give the wrong result.

Thanks,
Robin.

> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
>   drivers/pci/quirks.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b9c252aa6fe0..a7a1bf4c4354 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4453,6 +4453,20 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9084,
>   				quirk_bridge_cavm_thrx2_pcie_root);
>   
> +/*
> + * ASPEED AST1150 is a PCIe-to-PCI bridge that operates in PCI mode (not PCI-X).
> + * Although it reports as a PCIe-to-PCI bridge, the downstream PCI bus does not
> + * perform conventional Requester ID aliasing - each device behind the bridge
> + * generates its own distinct Requester ID. This quirk stops false alias
> + * detection at the bridge, fixing IOMMU StreamID conflicts that break DMA for
> + * devices like the USB controller behind this bridge.
> + */
> +static void quirk_aspeed_ast1150_bridge(struct pci_dev *pdev)
> +{
> +	pdev->dev_flags |= PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT;
> +}
> +DECLARE_PCI_FIXUP_HEADER(0x1a03, 0x1150, quirk_aspeed_ast1150_bridge);
> +
>   /*
>    * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
>    * class code.  Fix it.

