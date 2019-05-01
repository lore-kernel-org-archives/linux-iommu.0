Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7C3C43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 13:59:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383EF21670
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 13:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383EF21670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C0DBC3B53;
	Wed,  1 May 2019 13:59:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9BBC73965
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 13:58:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4E4FF189
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 13:58:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2366215AD;
	Wed,  1 May 2019 06:58:49 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com
	[10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C884F3F5AF;
	Wed,  1 May 2019 06:58:46 -0700 (PDT)
From: Julien Grall <julien.grall@arm.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 5/7] irqchip/ls-scfg-msi: Don't map the MSI page in
	ls_scfg_msi_compose_msg()
Date: Wed,  1 May 2019 14:58:22 +0100
Message-Id: <20190501135824.25586-6-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190501135824.25586-1-julien.grall@arm.com>
References: <20190501135824.25586-1-julien.grall@arm.com>
Cc: jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com,
	robin.murphy@arm.com, Julien Grall <julien.grall@arm.com>,
	miquel.raynal@bootlin.com, tglx@linutronix.de,
	logang@deltatee.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190501135822.8O0A6xffVRyjAWw8QpZrCsGKlNsShk6dfaheqH4N9TQ@z>

ls_scfg_msi_compose_msg() may be called from non-preemptible context.
However, on RT, iommu_dma_map_msi_msg() requires to be called from a
preemptible context.

A recent patch split iommu_dma_map_msi_msg() in two new functions:
one that should be called in preemptible context, the other does
not have any requirement.

The FreeScale SCFG MSI driver is reworked to avoid executing preemptible
code in non-preemptible context. This can be achieved by preparing the
MSI maping when allocating the MSI interrupt.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Rework the commit message to use imperative mood
---
 drivers/irqchip/irq-ls-scfg-msi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index c671b3212010..669d29105772 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -100,7 +100,7 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 		msg->data |= cpumask_first(mask);
 	}
 
-	iommu_dma_map_msi_msg(data->irq, msg);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
 
 static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
@@ -141,6 +141,7 @@ static int ls_scfg_msi_domain_irq_alloc(struct irq_domain *domain,
 					unsigned int nr_irqs,
 					void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct ls_scfg_msi *msi_data = domain->host_data;
 	int pos, err = 0;
 
@@ -157,6 +158,10 @@ static int ls_scfg_msi_domain_irq_alloc(struct irq_domain *domain,
 	if (err)
 		return err;
 
+	err = iommu_dma_prepare_msi(info->desc, msi_data->msiir_addr);
+	if (err)
+		return err;
+
 	irq_domain_set_info(domain, virq, pos,
 			    &ls_scfg_msi_parent_chip, msi_data,
 			    handle_simple_irq, NULL, NULL);
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
