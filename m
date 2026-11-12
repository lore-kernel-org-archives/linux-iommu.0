Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448146;
	b=21/IrL9r2dyloiZ1hsy0v4hunAWzVXT7EwoMAbXYEHncpaxm3qFUGfVkOBHKdsiXGSeD
	 +fCq+XO003hsKHZ6U+HAecI2xgSLj325ioyiuEKVIHAX+NFn56jo+ipnhMj4zNwNulKdb
	 2fgIlrzronZJOOm/XgX1D0p1oyoWBiijZADczn9KRG7iuwyLSTMdIVn1BCJXlBXwTaYWK
	 UM+5PBTQVfquDAkcchP9NVpP6wqb2bg/2q60wW6WyM/xNBx9pCX/1a45KJy8u2n4l/T3U
	 8KoY2F/ffDjMb1vEJAm6S2W26xXPJMb80weuYctL+xSZlZdMOWAyzU7slxhKaRo/5GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448146;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8vIz8xYau+WtFrk0xTr9b5QoDkJ8T5uH0TopCPW+Ht0=;
	b=VAAccSG3qITPuS52fMaR/1XIs9B6B7lURoi/qsQqlXV/goMjv/IsjrbjItYhsOnNRie0
	 b6kuakT87QMq96QFrGriKORYui0NNhrBgqffMorzgKQDlc8L7QJ0Zw5kKh0Ejw7GLsLN9
	 8fr7x8be7kQupDVAFUoT3/8BHY/DqtO0ZJcqsLJxcvSEjF5g4EKF24L7KuA5Uy8x+TIh+
	 Oje424A7U3UuwdqebSdYnF/qZreGm78ZwgaOVKKKBH2r5pRBelrdiXTFwNkSCYItRsJ//
	 mo+1oEVNmOGmS+B6aLm8y/PMZMJWXyptR1Y35V4ZsTNlYZG4sieMRl05cHeKV3uTngA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZUR1Pivf;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023FB606A323;
	Thu, 12 Nov 2026 01:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 023FB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZUR1Pivf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8vIz8xYau+WtFrk0xTr9b5QoDkJ8T5uH0TopCPW+Ht0=; b=ZUR1Pivf7YfAPwvJVMDDsk3Jzp
	0grOW/HpN24mmm5CWYJw548vD7py3YwdfURplC+tK3WNgHgaeIg97N5X5IGC60uprIDaFcaXyldV0
	2DDUf82sallNIesdaI5ir+Q5DxcH4WUNSi3ZaXYfklmnu+JhczffaiyoWlhpis9DDh7ke2D0Wnm1/
	E8ejpeBozWlDmjGCvrWyNho5YVnSCC5MJdfvxhCr1tpAItxFYwXbla0UNRiy8fC7NOVOGZgzTMGDD
	cy9/lqEVBA9tJCrOPHsaM7rk7Dslgfi23hgjhP/gtg02gehiZhyG+jNlFvmxiYZaacJUI0k6lYz0T
	MxJBZESQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRJvz-00000008RjV-3qVJ;
	Thu, 12 Nov 2026 01:49:03 +0000
Message-ID: <e6f8e81b-3c49-4112-b119-778fb8b89f38@infradead.org>
Date: Wed, 11 Nov 2026 17:49:02 -0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/40] nitro_enclaves: Add support for Nitro Sandboxes
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
 iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 nh-open-source@amazon.com, linux-mm@kvack.org,
 Jonathan Corbet <corbet@lwn.net>
References: <cover.1794300002.git.graf@amazon.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cover.1794300002.git.graf@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/26 2:41 PM, Alexander Graf wrote:
> 
> Alexander Graf (40):
>   nitro_enclaves: Allow the CPU pool to span NUMA nodes
>   nitro_enclaves: Add NE_ADD_ANY_VCPU
>   nitro_enclaves: Expose CPU pool state under sysfs
>   nitro_enclaves: Document multi-NUMA CPU pools
>   dma-contiguous: add dma_get_numa_cma_area() accessor
>   nitro_enclaves: Allocate physically contiguous enclave memory
>   nitro_enclaves: Add NE_MEMORY_SHARED
>   nitro_enclaves: Add NE_ADD_MEMORY_REGION
>   nitro_enclaves: Document the memory pool
>   nitro_enclaves: Add NE_CREATE_VM2 with a launch flag word
>   nitro_enclaves: Add NE_ENCLAVE_PCIE_MODE launch flag
>   nitro_enclaves: Name the device's error codes in the UAPI header
>   nitro_enclaves: Log a reached device limit at info level
>   nitro_enclaves: Add NE_SET_INFO_PAGE
>   nitro_enclaves: Document the info page in the memory pool
>   nitro_enclaves: Turn the command reply into a per-command union
>   nitro_enclaves: Add the slot pool donation commands
>   nitro_enclaves: Donate memory for the slot pool
>   nitro_enclaves: Add the slot pool growth commands
>   nitro_enclaves: Add a helper to grow the slot pool
>   nitro_enclaves: Document the slot pool
>   nitro_enclaves: Expose slot pool state under sysfs
>   nitro_enclaves: Add the device add command
>   nitro_enclaves: Add NE_ADD_DEVICE
>   nitro_enclaves: Read the interrupt multiplexer geometry at probe
>   nitro_enclaves: Donate a bitmap page per multiplexed vector
>   nitro_enclaves: Dispatch multiplexed interrupts to per-queue bindings
>   nitro_enclaves: Add NE_SET_NOTIFY_EVENTFD
>   nitro_enclaves: Report the device's info notification
>   nitro_enclaves: Count multiplexed interrupts under debugfs
>   nitro_enclaves: Map the doorbell window at probe
>   nitro_enclaves: Add NE_SET_VRING_CALL
>   nitro_enclaves: Assert the layout of the ioctl argument structs
>   nitro_enclaves: Pass on the Nitro Sandbox launch flags
>   nitro_enclaves: Add NE_ENCLAVE_DIRECT_MODE
>   nitro_enclaves: Add NE_ENCLAVE_PCIE_HOTPLUG_MODE
>   nitro_enclaves: Add NE_ENCLAVE_CPU_OVERCOMMIT_MODE
>   nitro_enclaves: Add NE_GET_CAPS
>   nitro_enclaves: Add NE_UPDATE_DEVICE_CONFIG
>   nitro_enclaves: Document the driver side of Nitro Sandboxes
> 
>  .../sysfs-devices-virtual-misc-nitro_enclaves |  232 +
>  Documentation/virt/ne_overview.rst            |  256 +-
>  MAINTAINERS                                   |    1 +
>  drivers/virt/nitro_enclaves/Kconfig           |   19 +
>  drivers/virt/nitro_enclaves/ne_misc_dev.c     | 4832 +++++++++++++++--
>  drivers/virt/nitro_enclaves/ne_misc_dev.h     |  206 +-
>  drivers/virt/nitro_enclaves/ne_pci_dev.c      | 1568 +++++-
>  drivers/virt/nitro_enclaves/ne_pci_dev.h      |  599 +-
>  include/linux/dma-map-ops.h                   |    7 +
>  include/uapi/linux/nitro_enclaves.h           | 1182 +++-
>  kernel/dma/contiguous.c                       |   36 +
>  samples/nitro_enclaves/ne_ioctl_sample.c      |   10 +-
>  12 files changed, 8282 insertions(+), 666 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-virtual-misc-nitro_enclaves
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

That's 7.4-rc1, but I can't get this series to apply cleanly to
7.4-rc1 or linux-next...

IMO it would be better if the series applied to something
newer than 7.4-rc1.

> prerequisite-patch-id: 542b3d78fda912095b75a49becd1b93109befdbc
> prerequisite-patch-id: 318368e966c1925652b7976948f435d42b87c72f
> prerequisite-patch-id: eb35b5d713e7f50f6d1d02310c9afe10b1628fc6
> prerequisite-patch-id: 223bf6e60620ca8fe72f3ff6f3bd3f5839cdd6d5
> prerequisite-patch-id: e5305ce0515a02f7f88e72adf02c6a2bee2fd2e0
> prerequisite-patch-id: 759b5920f842d70e675770608d9088639c10559e
> prerequisite-patch-id: e1837df37663da3d3ce53afa4594828b2d602152
> prerequisite-patch-id: f0d4302bd36f94de95951a0db1ae9eb9747076aa
> prerequisite-patch-id: 41159b92e250fef705be52f714b6e2761a2cd1f7
> prerequisite-patch-id: a0c3a56907acac2297c800209faa2849a8df0e48
> prerequisite-patch-id: a80a95bd682b540be5760e8fdf7044379fe32d61
> prerequisite-patch-id: 9c01e0fecd6810f3448582715c87cd3dd7a6cdf1
> prerequisite-patch-id: b94dfc8bb1039740d88a30535445bb7b3dd1fe74
> prerequisite-patch-id: bd76f15728dc0ee2ca3417cd95a6b23a7d63e91f
> prerequisite-patch-id: 0c60f1574b590f68885a25760017e9ff87752f66
> prerequisite-patch-id: 63dff43da52934a6e6f5e65c3e235a7114b6b4dc
> prerequisite-patch-id: af52cf938525874cadd6d879aa76495e563876d2
> prerequisite-patch-id: f53ee22764b5f13708cacd3e48a59a82d71a270c
> prerequisite-patch-id: 258b8c18168db49aacbda5156e33978b539666ab

-- 
~Randy

