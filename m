Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608AC23C3
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 07:03:01 +0000 (UTC)
Received: (Authenticated sender: alex@ghiti.fr)
	by mail.gandi.net (Postfix) with ESMTPSA id 39B5D240003;
	Tue, 16 May 2023 07:02:50 +0000 (UTC)
Message-ID: <280c0994-f7cd-bb0e-8c68-62f72a4a38ca@ghiti.fr>
Date: Tue, 16 May 2023 09:02:50 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] iommu: PGTABLE_LPAE is also for RISCV
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, Robin Murphy
 <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, Conor Dooley <conor@kernel.org>,
 linux-riscv@lists.infradead.org
References: <20230330060105.29460-1-rdunlap@infradead.org>
 <2529dd93-2cb2-6ed8-20c0-c424e6613717@arm.com>
 <833203b0-aee5-eb23-afb4-ff71a3024258@infradead.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <833203b0-aee5-eb23-afb4-ff71a3024258@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Randy,


On 3/30/23 18:49, Randy Dunlap wrote:
>
> On 3/30/23 09:34, Robin Murphy wrote:
>> On 2023-03-30 07:01, Randy Dunlap wrote:
>>> On riscv64, linux-next-20233030 (and for several days earlier),
>>> there is a kconfig warning:
>>>
>>> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>>>     Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>>>     Selected by [y]:
>>>     - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>>>
>>> and build errors:
>>>
>>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L140':
>>> io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_io_pgtable_ops'
>>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L168':
>>> io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_io_pgtable_ops'
>>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
>>> ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable_ops'
>>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
>>> ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtable_ops'
>>>
>>> Add RISCV as an allowed ARCH dependency to fix these problems.
>>>
>>> Fixes: d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
>> BTW that doesn't look like the right fix target - this presumably dates back as far as when ARCH_RENESAS was added to RISCV, such that it was possible to start selecting IPMMU_VMSA without COMPILE_TEST?
> OK, I can go with that. Thanks for your help.
>

Any updates on this fix?


Thanks,


Alex

