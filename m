From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: PCIe oops for NULL pointer dereference during next-20170807 and
	next-20170815
Date: Thu, 17 Aug 2017 09:21:29 +0100
Message-ID: <94b7e141-362d-02f3-1403-af7a1dfc8c4e@arm.com>
References: <c6ae57b6-1175-4ba4-b66d-d2f5393d06fc@rock-chips.com>
	<2ac52f40-c34f-6c31-b8db-868c40a977a3@rock-chips.com>
	<20170817075825.GR30515@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170817075825.GR30515-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17/08/17 08:58, Joerg Roedel wrote:
> On Thu, Aug 17, 2017 at 03:02:31PM +0800, Shawn Lin wrote:
>> So should we revert this commit or maybe we could add some checking
>> into gic-v2m and gic-v3-its to see if the dev is iommu-capable? If not,
>> we should create another routine to map MSI msg.
> 
> Yes, fixing this in gic code is the right approach. I usually don't
> revert patches to hide problems somewhere else.
Here's what it would look like:

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b47097a3e4b4..5e81ad62c801 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1125,6 +1125,8 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_node *its;
+	struct iommu_group *group;
+	struct device *dev;
 	u64 addr;
 
 	its = its_dev->its;
@@ -1134,7 +1136,12 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	msg->address_hi		= upper_32_bits(addr);
 	msg->data		= its_get_event_id(d);
 
-	iommu_dma_map_msi_msg(d->irq, msg);
+	dev = msi_desc_to_dev(irq_get_msi_desc(d->irq));
+	group = iommu_group_get(dev);
+	if (group) {
+		iommu_dma_map_msi_msg(d->irq, msg);
+		iommu_group_put(group);
+	}
 }
 
 static int its_irq_set_irqchip_state(struct irq_data *d,

I'm not convinced  that playing with the group refcount in an irqchip
is the right approach...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
