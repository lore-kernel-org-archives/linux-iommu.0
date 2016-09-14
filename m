From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Wed, 14 Sep 2016 11:35:53 +0100
Message-ID: <d03ea5e7-59f1-8b49-4ba2-d05fc2030ebc@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
 <11ebd81e-2ea5-5ff3-35b3-be95f03e05bd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <11ebd81e-2ea5-5ff3-35b3-be95f03e05bd-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 14/09/16 09:41, Auger Eric wrote:
> Hi,
> 
> On 12/09/2016 18:13, Robin Murphy wrote:
>> Hi all,
>>
>> To any more confusing fixups and crazily numbered extra patches, here's
>> a quick v7 with everything rebased into the right order. The significant
>> change this time is to implement iommu_fwspec properly from the start,
>> which ends up being far simpler and more robust than faffing about
>> introducing it somewhere 'less intrusive' to move toward core code later.
>>
>> New branch in the logical place:
>>
>> git://linux-arm.org/linux-rm iommu/generic-v7
> 
> For information, as discussed privately with Robin I experience some
> regressions with the former and now deprecated dt description.
> 
> on my AMD Overdrive board and my old dt description I now only see a
> single group:
> 
> /sys/kernel/iommu_groups/
> /sys/kernel/iommu_groups/0
> /sys/kernel/iommu_groups/0/devices
> /sys/kernel/iommu_groups/0/devices/e0700000.xgmac
> 
> whereas I formerly see
> 
> /sys/kernel/iommu_groups/
> /sys/kernel/iommu_groups/3
> /sys/kernel/iommu_groups/3/devices
> /sys/kernel/iommu_groups/3/devices/0000:00:00.0
> /sys/kernel/iommu_groups/1
> /sys/kernel/iommu_groups/1/devices
> /sys/kernel/iommu_groups/1/devices/e0700000.xgmac
> /sys/kernel/iommu_groups/4
> /sys/kernel/iommu_groups/4/devices
> /sys/kernel/iommu_groups/4/devices/0000:00:02.2
> /sys/kernel/iommu_groups/4/devices/0000:01:00.1
> /sys/kernel/iommu_groups/4/devices/0000:00:02.0
> /sys/kernel/iommu_groups/4/devices/0000:01:00.0
> /sys/kernel/iommu_groups/2
> /sys/kernel/iommu_groups/2/devices
> /sys/kernel/iommu_groups/2/devices/e0900000.xgmac
> /sys/kernel/iommu_groups/0
> /sys/kernel/iommu_groups/0/devices
> /sys/kernel/iommu_groups/0/devices/f0000000.pcie
> 
> This is the group topology without ACS override. Applying the non
> upstreamed "pci: Enable overrides for missing ACS capabilities" I used
> to see separate groups for each PCIe components. Now I don't see any
> difference with and without ACS override.

OK, having reproduced on my Juno, the problem looks to be that
of_for_each_phandle() leaves err set to -ENOENT after successfully
walking a phandle list, which makes __find_legacy_master_phandle()
always bail out after the first SMMU.

Can you confirm that the following diff fixes things for you?

Robin

--->8---
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fa892d25004d..ac4aab97c93a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -477,7 +477,7 @@ static int __find_legacy_master_phandle(struct
device *dev, void *data)
 			return 1;
 		}
 	it->node = np;
-	return err;
+	return err == -ENOENT ? 0 : err;
 }

 static struct platform_driver arm_smmu_driver;

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
