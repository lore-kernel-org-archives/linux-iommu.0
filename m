From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] iommu/rockchip: Handle errors returned from PM framework
Date: Mon, 6 Aug 2018 13:32:57 +0100
Message-ID: <9914232f-7b64-dcc8-8033-757e272be7c4@arm.com>
References: <20180805124616.18020-1-marc.zyngier@arm.com>
 <2071881.EAoDzUiQGL@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2071881.EAoDzUiQGL@phil>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Heiko,

On 06/08/18 13:09, Heiko Stuebner wrote:
> Hi Marc,
> 
> Am Sonntag, 5. August 2018, 14:46:16 CEST schrieb Marc Zyngier:
>> pm_runtime_get_if_in_use can fail: either PM has been disabled
>> altogether (-EINVAL), or the device hasn't been enabled yet (0).
>> Sadly, we ignore the first case at the moment, and end up treating
>> it as if we had received a valid interrupt.
>>
>> The first case could happen because the interrupt line is shared
>> (with the VOP for example), and although that device hasn't been
>> programmed yet, an interrupt may be pending (think kexec/kdump).
>>
>> The second case means that we've enabled the IOMMU, but it is
>> not powered-on just yet. This could be another instance of the
>> above, but as it deserves investigation, let's output a single
>> warning (instead of flodding the console).
>>
>> In both cases, bail with an IRQ_NONE.
>>
>> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Hmm, maybe my thinking is flawed, but to me it looks a bit different.
> 
> I.e. the iommu, as well as the vop have the capability to check if the irq
> is for them via their status registers (INT_STATUS and MMU_STATUS).
> 
> For this to happen the power-domain must be active and the device clocked.
> Clock handling is done on both the vop and iommu and in the !CONFIG_PM
> case all power-domains are left on.
> 
> Right now a !CONFIG_PM just passes through the driver unnoticed but with
> this change, we would actually make it depend on PM?
> 
> What am I missing?

I'm not sure you're missing anything, except that what I'm reporting 
here has nothing to do with !CONFIG_PM, but with the state of runtime PM 
when an interrupt gets delivered.

> Also there are quite a bit more instances of pm_runtime_get_if_in_use
> present in the iommu driver.

Indeed. Most of the are mishandling the return value by ignoring the 
error cases. And the more I look at it, the more I think I'm just fixing 
an effect, and not the root cause. See when the IOMMU interrupts get 
requested, long before pm_runtime_enable() is called.

If you get an interrupt at that point (which is perfectly likely given 
that the VOP shares the IRQ line), you handle it in an unexpected 
context. I should have spotted that yesterday...

I've quickly hacked the (untested) following patch, which should do the
trick (I'll test it tonight).

Thanks,

	M.

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 054cd2c8e9c8..94942712959d 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1152,17 +1152,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (iommu->num_mmu == 0)
 		return PTR_ERR(iommu->bases[0]);
 
-	i = 0;
-	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
-		if (irq < 0)
-			return irq;
-
-		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
-				       IRQF_SHARED, dev_name(dev), iommu);
-		if (err)
-			return err;
-	}
-
 	iommu->reset_disabled = device_property_read_bool(dev,
 					"rockchip,disable-mmu-reset");
 
@@ -1219,6 +1208,19 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	i = 0;
+	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
+		if (irq < 0)
+			return irq;
+
+		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
+				       IRQF_SHARED, dev_name(dev), iommu);
+		if (err) {
+			pm_runtime_disable(dev);
+			goto err_remove_sysfs;
+		}
+	}
+
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);

-- 
Jazz is not dead. It just smells funny...
