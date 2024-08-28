Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA04186E2C;
	Wed, 28 Aug 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853298; cv=none; b=jlLFW+hJz4/JE7CVe3mrHH254DaSeWPNSt4pasHQZXfClI17wVwoazyxUjUJViAic94RuP45hHCB0fWAX5xxTU84/YB2FNzbeSY0KL1ab71+hfYbXXOtFYAQSXbH1dLIwAO2DxiCEria7LVllbrOc0UJHji3XBucxvl+I1RBXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853298; c=relaxed/simple;
	bh=F1Jo7BH5OwhaSaFdA3taRByWkWSgKRB+CgkFv6y/++g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CS1WbpsEZa2Z34dvXodcl3d4t3+lW5Q1f6TdM//+lZ4KoJxov0/g2yvCJ/ScZFTxJIQbEGF8bQLftGGI70qsSZQzkrRoG9ibPfk1sESXR2/HX+M63EVf4jNi+Z31BBtdMwfdx90T0Vi0M4HBVEOY516yvOMc7zkRf3CFdNz1pSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv5Rp09ZYz6K5r0;
	Wed, 28 Aug 2024 21:51:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 51655140AA7;
	Wed, 28 Aug 2024 21:54:52 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 14:54:51 +0100
Date: Wed, 28 Aug 2024 14:54:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Alex Williamson
	<alex.williamson@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
	<pratikrajesh.sampat@amd.com>, <michael.day@amd.com>, <david.kaplan@amd.com>,
	<dhaval.giani@amd.com>, Santosh Shukla <santosh.shukla@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Michael Roth" <michael.roth@amd.com>, Alexander
 Graf <agraf@suse.de>, "Nikunj A Dadhania" <nikunj@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, "Lukas Wunner" <lukas@wunner.de>
Subject: Re: [RFC PATCH 03/21] pci: Define TEE-IO bit in PCIe device
 capabilities
Message-ID: <20240828145451.000050c1@Huawei.com>
In-Reply-To: <20240823132137.336874-4-aik@amd.com>
References: <20240823132137.336874-1-aik@amd.com>
	<20240823132137.336874-4-aik@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 23:21:17 +1000
Alexey Kardashevskiy <aik@amd.com> wrote:

> A new bit #30 from the PCI Express Device Capabilities Register is defined
> in PCIe 6.1 as "TEE Device Interface Security Protocol (TDISP)".
No it isn't.

TEE-IO supported - When Set, this bit indicates the Function implements the TEE-IO
functionality as described by ....

So it is defined as TEE-IO not TDISP even though that definition is in the
TDISP section fo the spec.

As Bjorn said, spec reference.

Jonathan

> 
> Define the macro.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>  include/uapi/linux/pci_regs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 94c00996e633..0011a301b8c5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -498,6 +498,7 @@
>  #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
>  #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
>  #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
> +#define  PCI_EXP_DEVCAP_TEE_IO  0x40000000 /* TEE-IO Supported (TDISP) */
>  #define PCI_EXP_DEVCTL		0x08	/* Device Control */
>  #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
>  #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */

