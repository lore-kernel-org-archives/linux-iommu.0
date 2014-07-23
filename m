From: Greg Edwards <gedwards-LfVdkaOWEx8@public.gmane.org>
Subject: [PATCH v2] iommu/vt-d: race setting IRQ CPU affinity while freeing IRQ
Date: Wed, 23 Jul 2014 10:13:26 -0600
Message-ID: <20140723161326.GB32422@psuche.datadirectnet.com>
References: <20140722142719.GA28143@psuche.datadirectnet.com>
	<20140723144024.GA14017@8bytes.org>
	<20140723144917.GA26986@psuche.datadirectnet.com>
	<20140723151040.GB14017@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140723151040.GB14017-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

A user process setting the CPU affinity of an IRQ for a KVM
direct-assigned device via /proc/irq/<IRQ#>/smp_affinity can race with
the IRQ being released by QEMU, resulting in a NULL iommu pointer
dereference in get_irte().

Signed-off-by: Greg Edwards <gedwards-LfVdkaOWEx8@public.gmane.org>
---

Dropped the Cc: for stable since this likely wouldn't ever be seen in
the real world.  We saw it on an automated CI stress test.

 drivers/iommu/intel_irq_remapping.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 9b17489..d926676 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -70,6 +70,11 @@ static int get_irte(int irq, struct irte *entry)
 
 	raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
 
+	if (unlikely(!irq_iommu->iommu)) {
+		raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
+		return -1;
+	}
+
 	index = irq_iommu->irte_index + irq_iommu->sub_handle;
 	*entry = *(irq_iommu->iommu->ir_table->base + index);
 
-- 
1.9.3
