Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E38154433
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578400; cv=none; b=naGwCmzJujLFjIr092IDcpSiCsbNE0k7/gidXNYyoNyvAIXos8Lnk2CoL1LcFG3+TYdnCPBv5UxUAWYd3iqE2t98qszt1M7kDbHtW20Jcto8fpxTTa15wlhASWnfgAU+MYi9jeFTtqTSilVB6YDYoWOIjSm1GIViAxqmrs4t6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578400; c=relaxed/simple;
	bh=UyRqRzbJ9Nie3cIoqfa8TIBdZp5bApSAkz6k3dwlxm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB4unSt78tm8ZEPJEAhCqRL47PTp8YgoEyk++cVbakwYn0AD+lwMAeQ1M8x39x5PNuhWnqdsi8cUFUwd6RhCFSsHEID1KUL8GW5LwEoH7416q667fjr6Hh7Cht4p2FvYbBLDkEBvyho67QMRam3RDgIuKYVkhJ4tnQCGH3rictQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7215106F;
	Fri, 28 Jun 2024 05:40:21 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79DD13F6A8;
	Fri, 28 Jun 2024 05:39:54 -0700 (PDT)
Message-ID: <f2fee806-09bc-4b0a-a77e-3bf12c329ecb@arm.com>
Date: Fri, 28 Jun 2024 13:39:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update IOMMU tree location
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
References: <20240628123132.8690-1-joro@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240628123132.8690-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/06/2024 1:31 pm, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Update the maintainers entries to the new location of the
> IOMMU tree.

FWIW that's working for me;

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   MAINTAINERS | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aacccb376c28..c48c9e772517 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1044,7 +1044,7 @@ M:	Joerg Roedel <joro@8bytes.org>
>   R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>   L:	iommu@lists.linux.dev
>   S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>   F:	drivers/iommu/amd/
>   F:	include/linux/amd-iommu.h
>   
> @@ -11156,7 +11156,7 @@ M:	David Woodhouse <dwmw2@infradead.org>
>   M:	Lu Baolu <baolu.lu@linux.intel.com>
>   L:	iommu@lists.linux.dev
>   S:	Supported
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>   F:	drivers/iommu/intel/
>   
>   INTEL IPU3 CSI-2 CIO2 DRIVER
> @@ -11529,7 +11529,7 @@ IOMMU DMA-API LAYER
>   M:	Robin Murphy <robin.murphy@arm.com>
>   L:	iommu@lists.linux.dev
>   S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>   F:	drivers/iommu/dma-iommu.c
>   F:	drivers/iommu/dma-iommu.h
>   F:	drivers/iommu/iova.c
> @@ -11541,7 +11541,7 @@ M:	Will Deacon <will@kernel.org>
>   R:	Robin Murphy <robin.murphy@arm.com>
>   L:	iommu@lists.linux.dev
>   S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>   F:	Documentation/devicetree/bindings/iommu/
>   F:	Documentation/userspace-api/iommu.rst
>   F:	drivers/iommu/
