Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B27E3FC7
	for <iommu@lists.linux.dev>; Thu, 15 Sep 2022 10:21:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A981692;
	Thu, 15 Sep 2022 03:21:48 -0700 (PDT)
Received: from [10.57.18.118] (unknown [10.57.18.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E1A53F73B;
	Thu, 15 Sep 2022 03:21:41 -0700 (PDT)
Message-ID: <b9e3f5cd-8888-cfc1-94a6-35ad54cd0122@arm.com>
Date: Thu, 15 Sep 2022 11:21:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [bug report] iommu/vt-d: Fix kdump kernels boot failure with
 scalable mode
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@oracle.com>, baolu.lu@linux.intel.com
Cc: iommu@lists.linux.dev
References: <YyL5Bzy/QfUS5XDa@kili>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YyL5Bzy/QfUS5XDa@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-15 11:05, Dan Carpenter wrote:
> Hello Lu Baolu,
> 
> The patch 0c5f6c0d8201: "iommu/vt-d: Fix kdump kernels boot failure
> with scalable mode" from Aug 23, 2022, leads to the following Smatch
> static checker warning:
> 
> drivers/iommu/intel/iommu.c:224 set_context_copied() warn: set_bit() takes a bit number
> drivers/iommu/intel/iommu.c:230 clear_context_copied() warn: clear_bit() takes a bit number
> 
> drivers/iommu/intel/iommu.c
>      221 static inline void
>      222 set_context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
>      223 {
> --> 224         set_bit(((long)bus << 8) | devfn, iommu->copied_tables);
>      225 }
> 
> This is trying to set a mask

No, it's simply composing a full 16-bit PCI requester ID from its two 
8-bit components.

> but it will instead corrupt a bit way out
> in the middle of your memory.

	iommu->copied_tables = bitmap_zalloc(BIT_ULL(16), GFP_KERNEL);

Again slightly non-obvious, but AFAICS the bitmap is sized appropriately.

>  The set_bit function will only set one
> bit at a time.  If we want to set bit zero:
> 
> 	set_bit(0, iommu->copied_tables);
> 
> Or if we have a whole page full of bits then we could set the last one:
> 
> 	set_bit(32767, page);

I believe that's exactly what we're doing here, setting one bit for each 
PCI ID processed. It's just a very big bitmap thanks to the size of the 
PCI ID space.

Cheers,
Robin.
