Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9D39A07B
	for <iommu@lists.linux.dev>; Sat, 10 Oct 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791646426; cv=none; b=GnwlHNnpNdAxnJSf0xBHXXppAU6nSkJXjJJ8e/zg5ONwRa+QRuyAwaZyG+94H0sMCieUEKdRyPeedw8e3UNYJAFyYmQyDazccgClQv19T2raYQM08L2cqUWX4dJS67qT30CDkv2Tbm33qA2xudSbCrGJ9FzNXtw4qvkZRrXEHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791646426; c=relaxed/simple;
	bh=1Q+7jEa9BSz60lWJHvLNDWD6zcWHlYFWTg8yp+VGCIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBtD76qii4fJ3xJekjOi8nkQqfKxW4vAD7entQ0mG1YkKBThwWiBOTMwe9KuoFCjE7ojyQZ6nz5WCzXaDUD7XmMTLjdwN5KSY9xJ/QyQy3k6uI6qB/UQfGHqCSJT8Y76aglfUaNg1b8H2uQfgXCilVi+T7myr/F+nUMJzIXNcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crB1t+7o; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crB1t+7o"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-398b9f722abso397186a91.0
        for <iommu@lists.linux.dev>; Sat, 10 Oct 2026 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791646425; x=1792251225; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wozdN+r/GgwZxNj7OpCytBKWiEzKlAUU4sPZrHIAwLY=;
        b=crB1t+7os3950w/Snq753T+Y62wVZlc2xv9nJ6JIYsUPQMg5z5Dac+53MLp1bXazQG
         nPBiSaCiH48yDL+7A4cBtPiQPZZMGcEMQ4JxDPYYZ6twOAQaCQsoQ76cXeDTUKYLuXKC
         EKT4impGuBdkZXK5xs+48Y47QXodvaiTXy8rtdsXT5J+VlvHTy8BMhHdFl5+jSYL17Gc
         ZFMcqpudAnZs8IVHpR/KipZBnubxJ1hYvFVFVLgLhJfL7B54sFMTLIPpTOM4mtI8zVp0
         EyH9IGqpUvapDUxMn5fwyD4wA/i3lj4cTdPFzQDM2yntdxP7yo36n8qzf9DMz+WNK8OP
         +kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791646425; x=1792251225;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wozdN+r/GgwZxNj7OpCytBKWiEzKlAUU4sPZrHIAwLY=;
        b=pvqsHTO9tqi/SqqoQ5EOjcor55pYrHOxdboNjJKLu2dZsJaLjgu7/kM8KRTDsrUEZK
         tc5pILCZA+2mt5k6s38O2QF+XxtHTDMKgMYS25OT2h7xVPFvMfEIHQu7lRS+fPYVvwzM
         glBWX/yj55JX00modC0felSStJb+oKlC1dqhuLMm/ipRk60Sy3fYfNDioFfElMeVt4H9
         2OGf+JuzOnQjCsqA9PLB5O1/eLS5VssHcsxDHcRXLJJvnTBmwXbzLGt883RtSbvjqK0i
         SfXwn5DwywxkuyFjry3nDrfMJhxuckGzZ1Cu5mwZWT9rPJTaP9U9CsMF3ms5mj915wU4
         Zw2A==
X-Forwarded-Encrypted: i=1; AKwUvBzputmUEek3332nzdXLAYzqo6oqzos13hABgB78DVus0YZpjUS/P0Q+aP6/iO7O60Io/yg7Dw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJu18AoYSReIHw7FsUC1mdulx85KgFSN3/BtlXfpsm+zrrYwr1n
	ozAWEDWYQsNbzIMXb1ZesBQ1WTakbFf+9l9zvG8PyyYECh/SNDS5ua3t
X-Gm-Gg: AYBFou1DFaxDUcZ7q2oexL5qEvZMjOTR1SoysYSDF6wiBaP3FSk0h7HW5m+3myWd7Gb
	HrhQyY3tU671VcoOGCITArCFSrK/PHNO3EoP9y3gLSDdk8hCz05YbwvIoEnM79VhqMqQ3w7RWON
	1L3iRm2KNZbSO2zWH9v3Y/H2btEkMvLrEDYoqWbZLxS1B7zegswkqSrIX0qQYRJ2dKpmwaHrrbY
	agQ8mcpFI7lgIYe3dcmRR1S+3vmh6Ai0Dx/L/pXhzUmezwk4YUSR4Dq4l74H2yah/kRt8nc1avR
	F98c5dMrEQGb5OToRKK19xARzf8OumdIP21Ra5JVKwMEh8QHDaImcO5wOU7lzeisIj3FA9sAcEb
	7AD2M1HHkCfSxwt54ok40sX7LggZb1IOvZCeVb+DKpltAUot7lo3MXZiqN6wGGOrWppH0TPsin5
	ViMyRsxpmv8nh5KaFbUN8sJDNjjMupNyhRZdhuk42QYLuMiAQwxAkZ9TCbZiNmsp0euxLYSXmkt
	ZUEa7aNMQsxHpo3yIo=
X-Received: by 2002:a17:90b:3b48:b0:3ab:22b5:3bdd with SMTP id 98e67ed59e1d1-3ab3ae77cecmr4773108a91.45.1791646424758;
        Sat, 10 Oct 2026 08:33:44 -0700 (PDT)
Received: from [192.168.50.100] ([111.199.56.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab338676besm4966303a91.1.2026.10.10.08.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 08:33:44 -0700 (PDT)
Message-ID: <1f9158d3-fb05-4100-9e7b-9519a62d089d@gmail.com>
Date: Sat, 10 Oct 2026 23:33:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] iommu/riscv: Add guest IMSIC GPA mapping helpers
To: fangyu.yu@linux.alibaba.com, gong.shuai@sanechips.com.cn
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu,
 guoren@kernel.org, iommu@lists.linux.dev, jgg@nvidia.com, jgg@ziepe.ca,
 joro@8bytes.org, kvm-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
 tomasz.jeznach@linux.dev, will@kernel.org, zong.li@sifive.com
References: <202610090853.6998rsRH081065@mse-db.zte.com.cn>
 <20261010111837.15424-1-fangyu.yu@linux.alibaba.com>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20261010111837.15424-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fangyu,

On 10/10/2026 7:18 PM, fangyu.yu@linux.alibaba.com wrote:
>>Hi Fangyu,
>>
>>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>>
>>> IOMMU implementations without the MSI_FLAT capability translate MSI
>>> writes through the second-stage page table, so IRQ forwarding on them
>>> will need guest IMSIC pages mapped into the second-stage domain.
>>>
>>> Add an xarray to the MSI table that tracks the HPA installed for each
>>> mapped guest IMSIC GPA, and two helpers for use with the MSI table lock
>>> held: riscv_iommu_msi_table_map_gpa() installs the initial 4 KiB
>>> mapping, and riscv_iommu_msi_table_replace_gpa_leaf() atomically swaps
>>> the leaf PTE's PFN when a vCPU's VS-file host page moves, rejecting
>>> leaves that do not map the expected old HPA.
>>>
>>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>> ---
>>>  drivers/iommu/riscv/iommu.c | 94 +++++++++++++++++++++++++++++++++++++
>>>  drivers/iommu/riscv/iommu.h | 12 +++++
>>>  2 files changed, 106 insertions(+)
>>>
>>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>>> index e2e77469ea3c..48fc57d6409c 100644
>>> --- a/drivers/iommu/riscv/iommu.c
>>> +++ b/drivers/iommu/riscv/iommu.c
>>> @@ -24,6 +24,7 @@
>>>  #include <linux/moduleparam.h>
>>>  #include <linux/mutex.h>
>>>  #include <linux/pci.h>
>>> +#include <linux/pgtable.h>
>>>  #include <linux/generic_pt/iommu.h>
>>>
>>>  #include "../dma-iommu.h"
>>> @@ -1217,6 +1218,92 @@ void riscv_iommu_msi_table_inval_all(struct riscv_iommu_msi_table *msi_table)
>>>  	riscv_iommu_iotlb_inval(domain, &gather);
>>>  }
>>>
>>> +int riscv_iommu_msi_table_map_gpa(struct riscv_iommu_msi_table *msi_table,
>>> +				  dma_addr_t gpa, phys_addr_t hpa)
>>> +{
>>> +	struct riscv_iommu_domain *domain =
>>> +		container_of(msi_table, struct riscv_iommu_domain, msi_table);
>>> +	const int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>>> +
>>> +	/* Guest IMSIC GPA mapping only exists in second-stage translations. */
>>> +	if (!domain->gscid)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	return iommu_map(&domain->domain, gpa, hpa, IMSIC_MMIO_PAGE_SZ, prot,
>>> +			 GFP_ATOMIC);
>>> +}
>>> +
>>> +int riscv_iommu_msi_table_replace_gpa_leaf(struct riscv_iommu_msi_table *msi_table,
>>> +					   dma_addr_t gpa, phys_addr_t old_hpa,
>>> +					   phys_addr_t new_hpa)
>>
>>
>>This might fit better inside generic_pt rather than in the driver,
>>since it walks the page tables on its own and duplicates things
>>the library already owns, like the per-level index widths, the
>>x4 root size, and the PTE layout.
>>
>>I recently tried something very similar, and doing this inside
>>generic_pt turned out to be quite feasible (only a quick experiment,
>>not cleaned up for posting).
>>
> 
> Hi Shuai,
> 
> Thanks for the review. I agree the driver shouldn't carry format
> knowledge that belongs to the library, but I think this particular
> operation doesn't fit generic_pt.
> 
> This is not a generic page-table operation. It is a special
> requirement of RISC-V IOMMU IRQ forwarding (irqbypass) on
> implementations without an MSI page table: the guest IMSIC GPA
> must be mapped into the second-stage domain, and when a vCPU's
> VS-file host page migrates, its leaf must be replaced atomically.

To be clear, I also meant updating the leaf in place,
not unmap + map.

> Because a device may write an MSI at any moment, unmap + map
> would fault. This operation is driven by the IRQ forwarding
> state machine, and because I don't see another generic_pt format
> sharing this flow, I think these helpers would be better placed
> outside generic_pt. I plan to move them into iommu-ir.c so the
> feature-scoped code stays together.

I'm fine with keeping it out of generic_pt. Respect your design.

Thanks,
Shuai

> 
> Thanks,
> Fangyu
> 
>>Thanks,
>>Shuai

