From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] Revert "ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()"
Date: Mon, 14 Jan 2019 16:38:20 +0000
Message-ID: <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
 <20190114132240.12125-1-m.szyprowski@samsung.com>
 <20190114160902.GB9218@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114160902.GB9218@ulmo>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <treding@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk+kernel@armlinux.org.uk>, Ben Skeggs <bskeggs@redhat.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 14/01/2019 16:09, Thierry Reding wrote:
> On Mon, Jan 14, 2019 at 02:22:40PM +0100, Marek Szyprowski wrote:
>> This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.
>>
>> That patch broke IOMMU support for devices, which fails to probe for the
>> first time and use deferred probe approach. When non-NULL dma_ops is set
>> in arm_iommu_detach_device(), the given device later ignored by
>> arch_setup_dma_ops() and stays with non-IOMMU dma_ops.
>>
>> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_detach_device()"
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   arch/arm/mm/dma-mapping.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Can you point out exactly what drivers break because of this change? We
> need to find a solution that works for everyone. Reverting is only
> marginally useful because somebody will just end up wanting to revert
> the revert because a different driver is now broken.

At first glance, it sounds like what we really want is for 
arch_teardown_iommu_ops() to completely clear any ops that 
arch_setup_dma_ops() installed - does the below suffice?

Robin.

----->8-----
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f1e2922e447c..1e3e08a1c456 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2390,4 +2390,6 @@ void arch_teardown_dma_ops(struct device *dev)
  		return;

  	arm_teardown_iommu_dma_ops(dev);
+	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
+	set_dma_ops(dev, NULL);
  }
