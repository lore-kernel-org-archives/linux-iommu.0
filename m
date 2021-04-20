Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F30C433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDFD613C9
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDFD613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 472FD405D1;
	Tue, 20 Apr 2021 17:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XhmMsh4ZItOH; Tue, 20 Apr 2021 17:25:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B140B405D2;
	Tue, 20 Apr 2021 17:25:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 915BBC001E;
	Tue, 20 Apr 2021 17:25:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17BCEC000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC39E83C2C
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GjFOHUs057FL for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:25:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D347283C2A
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:48 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id r20so9697789ejo.11
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W5UrtoQDzYhhXQZ+XkLu2njhk4Xp/wDLXcLYbSMA/yg=;
 b=XpwtLWOSoQR1QtEWD8GMgIN2RBFLB7cxWIEInu+qLwsVn1ly7V8iDqH95dlgRe0HhQ
 vpV0gFCYGpqXwzIvzHZviqQeOqKPuwfP02iFsidvQXbXO6Uyqt5AvN1vZIAtlpKGw0rX
 M8JUSEcdXVcCUehGTs1EG219XNqWcxWIoHyLMIvD2+++Fd6Y4xLuaqo/dnj/9i6zZ1P3
 3FiOPCbfYvk4e1HL/7ojC5sFvncfgzcA4mvOdVWSFb3B5SjVZ9Q6cEtDZsN2LD7h6bl5
 iUz793C/I3b+13v3KVi90MWAkvi4OkZdy1r/7ifxCgwFclz09JlfsEnz5642qQu5eFNC
 IMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W5UrtoQDzYhhXQZ+XkLu2njhk4Xp/wDLXcLYbSMA/yg=;
 b=Scnc4JTF4wGMWRznMnm0s+GosIUT7wNRUR9kxNkHcv3SY7P1re9SXk/uzMaGx8JTfE
 Qj/W7Wzwo4ZHFKuwDd8qs4VHFg8M2Xk+ZB6oXjcyVvmv9aCXMpzRC29c3oJmEtIxtzZA
 TcoHXbrs+5lxJ1MqAjSZq3UV/PXjSq9kSK7PLFiVawzdnrRZYNKsybBteVFXlDpsjInf
 VXGg9ZZKTlOkqH1S2cJjuQhRQ1H2LfCeYQQWZtvQCs7FNwLlcNKNcH60SOl2lTOtrv/k
 xcADQISLalpB2BBQOrvcYgZu3YY3m6T2WdM7vgedSyRh2falRIs260UFvmWXUEjiJl4g
 RTdg==
X-Gm-Message-State: AOAM531sgzAY2BV9T+mmodzpPK0IPPGte/+iavIpT3xub6UWh6/xRkd1
 723A6vZBJnkixSTIWmVziMQ=
X-Google-Smtp-Source: ABdhPJwKl5oMBkMmu3QRwZHqPJ9Nw9u91Wp1V1p2Ah525YJNuiVx6SoahW6CizH+rRNSBL3vkoEEiA==
X-Received: by 2002:a17:906:fb90:: with SMTP id
 lr16mr28515953ejb.173.1618939547098; 
 Tue, 20 Apr 2021 10:25:47 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id t15sm15984883edr.55.2021.04.20.10.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 10:25:46 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 05/10] iommu/arm-smmu: tegra: Implement SID override
 programming
Date: Tue, 20 Apr 2021 19:26:14 +0200
Message-Id: <20210420172619.3782831-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420172619.3782831-1-thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Thierry Reding <treding@nvidia.com>

The secure firmware keeps some SID override registers set as passthrough
in order to allow devices such as the display controller to operate with
no knowledge of SMMU translations until an operating system driver takes
over. This is needed in order to seamlessly transition from the firmware
framebuffer to the OS framebuffer.

Upon successfully attaching a device to the SMMU and in the process
creating identity mappings for memory regions that are being accessed,
the Tegra implementation will call into the memory controller driver to
program the override SIDs appropriately.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 32 ++++++++++++++++++--
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 0e547b29143d..01e9b50b10a1 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -7,6 +7,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include <soc/tegra/mc.h>
+
 #include "arm-smmu.h"
 
 /*
@@ -15,10 +17,17 @@
  * interleaved IOVA accesses across them and translates accesses from
  * non-isochronous HW devices.
  * Third one is used for translating accesses from isochronous HW devices.
+ *
+ * In addition, the SMMU driver needs to coordinate with the memory controller
+ * driver to ensure that the right SID override is programmed for any given
+ * memory client. This is necessary to allow for use-case such as seamlessly
+ * handing over the display controller configuration from the firmware to the
+ * kernel.
+ *
  * This implementation supports programming of the two instances that must
- * be programmed identically.
- * The third instance usage is through standard arm-smmu driver itself and
- * is out of scope of this implementation.
+ * be programmed identically and takes care of invoking the memory controller
+ * driver for SID override programming after devices have been attached to an
+ * SMMU instance.
  */
 #define MAX_SMMU_INSTANCES 2
 
@@ -26,6 +35,7 @@ struct nvidia_smmu {
 	struct arm_smmu_device smmu;
 	void __iomem *bases[MAX_SMMU_INSTANCES];
 	unsigned int num_instances;
+	struct tegra_mc *mc;
 };
 
 static inline struct nvidia_smmu *to_nvidia_smmu(struct arm_smmu_device *smmu)
@@ -237,6 +247,17 @@ static irqreturn_t nvidia_smmu_context_fault(int irq, void *dev)
 	return ret;
 }
 
+static void nvidia_smmu_probe_finalize(struct arm_smmu_device *smmu, struct device *dev)
+{
+	struct nvidia_smmu *nvidia = to_nvidia_smmu(smmu);
+	int err;
+
+	err = tegra_mc_probe_device(nvidia->mc, dev);
+	if (err < 0)
+		dev_err(smmu->dev, "memory controller probe failed for %s: %d\n",
+			dev_name(dev), err);
+}
+
 static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.read_reg = nvidia_smmu_read_reg,
 	.write_reg = nvidia_smmu_write_reg,
@@ -246,6 +267,7 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.tlb_sync = nvidia_smmu_tlb_sync,
 	.global_fault = nvidia_smmu_global_fault,
 	.context_fault = nvidia_smmu_context_fault,
+	.probe_finalize = nvidia_smmu_probe_finalize,
 };
 
 static const struct arm_smmu_impl nvidia_smmu_single_impl = {
@@ -264,6 +286,10 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
 	if (!nvidia_smmu)
 		return ERR_PTR(-ENOMEM);
 
+	nvidia_smmu->mc = devm_tegra_memory_controller_get(dev);
+	if (IS_ERR(nvidia_smmu->mc))
+		return ERR_CAST(nvidia_smmu->mc);
+
 	/* Instance 0 is ioremapped by arm-smmu.c. */
 	nvidia_smmu->bases[0] = smmu->base;
 	nvidia_smmu->num_instances++;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
