From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] dma-direct: always allow dma mask <= physiscal memory
 size
Date: Wed, 3 Oct 2018 11:46:45 -0700
Message-ID: <20181003184645.GA25639@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 07, 2018 at 09:31:58AM +0200, Christoph Hellwig wrote:
> This way an architecture with less than 4G of RAM can support dma_mask
> smaller than 32-bit without a ZONE_DMA.  Apparently that is a common
> case on powerpc.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

This patch causes widespread boot failures on mips and x86_64.

Common denominators:

ahci 0002:01:00.0: 32-bit DMA enable failed
ahci: probe of 0002:01:00.0 failed with error -5

sym0: No suitable DMA available
sym0: giving up ...

pcnet32 0000:00:0b.0: enabling device (0000 -> 0003)
pcnet32: architecture does not support 32bit PCI busmaster DMA
pcnet32: probe of 0000:00:0b.0 failed with error -5

There may be others; I didn't check all the logs.

Sample bisect log is attached (from mips64). Bisect on x86_64 points to
the same patch as culprit.

Guenter

---
# bad: [8f84a21675f06c8aea55148ce37a618c6fe52a0b] Add linux-next specific files for 20181003
# good: [17b57b1883c1285f3d0dc2266e8f79286a7bef38] Linux 4.19-rc6
git bisect start 'HEAD' 'v4.19-rc6'
# bad: [ab92e1776a64d9894166e771faaaeecff890ec6e] Merge remote-tracking branch 'crypto/master'
git bisect bad ab92e1776a64d9894166e771faaaeecff890ec6e
# bad: [c850e425cfa466e5ce1d59dd3aad73ae4fd52ba9] Merge remote-tracking branch 'xfs/for-next'
git bisect bad c850e425cfa466e5ce1d59dd3aad73ae4fd52ba9
# good: [56fc7d0094442afc18b5106b8df7c59a3c36869d] arm-soc: document merges
git bisect good 56fc7d0094442afc18b5106b8df7c59a3c36869d
# bad: [4a83c1f489745f8e520a0686235f3a95b9374aab] Merge remote-tracking branch 'arm64/for-next/core'
git bisect bad 4a83c1f489745f8e520a0686235f3a95b9374aab
# bad: [6de4dcae0d1577efb3a551c7933945da033e9717] Merge remote-tracking branch 'dma-mapping/for-next'
git bisect bad 6de4dcae0d1577efb3a551c7933945da033e9717
# good: [ce41c6b97f00e24bb23412e17eb0d992a97ffb48] Merge remote-tracking branch 'net/master'
git bisect good ce41c6b97f00e24bb23412e17eb0d992a97ffb48
# good: [06f60b8cb4f884ae0c37b8f7095e021a7531cb87] Merge remote-tracking branch 'scsi-fixes/fixes'
git bisect good 06f60b8cb4f884ae0c37b8f7095e021a7531cb87
# good: [f9d39ce558b1455f8f91387d7238eb837735e325] Merge remote-tracking branch 'leaks/leaks-next'
git bisect good f9d39ce558b1455f8f91387d7238eb837735e325
# good: [f3ecc0ff0457eae93503792c6fc35921fa8a6204] dma-mapping: move the dma_coherent flag to struct device
git bisect good f3ecc0ff0457eae93503792c6fc35921fa8a6204
# good: [c6d4381220a0087ce19dbf6984d92c451bd6b364] dma-mapping: make the get_required_mask method available unconditionally
git bisect good c6d4381220a0087ce19dbf6984d92c451bd6b364
# good: [b4ebe6063204da58e48600b810a97c29ae9e5d12] dma-direct: implement complete bus_dma_mask handling
git bisect good b4ebe6063204da58e48600b810a97c29ae9e5d12
# bad: [6db37ad7c27bda2f62d1ef6ad0496e359c562c1a] dma-mapping: move dma_default_get_required_mask under ifdef
git bisect bad 6db37ad7c27bda2f62d1ef6ad0496e359c562c1a
# bad: [9d7a224b463e1cf1178570b57b6497240fd79bc3] dma-direct: always allow dma mask <= physiscal memory size
git bisect bad 9d7a224b463e1cf1178570b57b6497240fd79bc3
# first bad commit: [9d7a224b463e1cf1178570b57b6497240fd79bc3] dma-direct: always allow dma mask <= physiscal memory size
