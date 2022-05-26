Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD43C433FE
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 12:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF15A845C7;
	Thu, 26 May 2022 12:01:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Wb5boQhkT5V; Thu, 26 May 2022 12:01:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BCFD1845E7;
	Thu, 26 May 2022 12:01:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 832EAC0032;
	Thu, 26 May 2022 12:01:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85039C002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 12:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74DCF845EB
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 12:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qDz1NSZvy5IW for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 12:01:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48831845C7
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 12:01:21 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id 137so1161625pgb.5
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 05:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oaqG6keHyyCSAVb73eGtDPFdUcregAH3H4j2SG+oYUM=;
 b=kJazciJ8tosHNjEcGmQPRBsvV97CnX70u9eK1RMlJ7V8o0r69g17gCeql6TfT+VBhX
 b4cMWi4Vynnv0NTYxJgk1dNRtzcobgplTF+zC1VmCzXPBsk1NEmKS4IbkpPrA2jw4skU
 uRTzcZEwW/+oVg9UZJUsxMbFQ+rzfMvx6al2/hSBbUmaJq36/1MoI759wCzU4FDN3eib
 ebc0SfzXGHwpq/TsybeSupVrN7GlsXmhFaK7e/hDvHqlV/+epOYsvvATdIW3I8YBpo/g
 7yDlGNoT9YK7Vyvvew/SrrKf07ENspk3z2GefeXk7ZOA/Abdi/+EuqFzZ9wVtlMpnOP3
 vzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oaqG6keHyyCSAVb73eGtDPFdUcregAH3H4j2SG+oYUM=;
 b=6GvoPQf0D1zbDshrN5UZ8EXTRC0a9FNsEBIjifYjqPUjTYDPR9VcXNbTfnt+KzI9rA
 YApsio97C98pSdUaSFgmRY8gNgkOJJnBJ3JpNzBwIVhS29ukpFBkyOBWLqVCRIvwhCGy
 EVuI4vs9RpVKJeQUj9k8uHYYnXhkVn36jEznDpH5ZNA8lf8NEftxeOAKVs83DDnMtJYl
 yFuURXVkPNTilx3t6O2dUsAtEJRfcoSvh10Tz72w9h1P3FDzlNcQAH9a6s4klsXKNmQV
 yTENWUpguhjUBSY7zoiPIBpcpHAQpIbvbQvaOYcKZD3DkreDOAWLjOBY4i9z2CZGVR9q
 F4Qg==
X-Gm-Message-State: AOAM532NEySejghjtO9jRan0k8bfwQe52LxaAD9IB+Mpn+BlVa9uiME6
 lVOtH65H1zT7KwOBKEXY9s8=
X-Google-Smtp-Source: ABdhPJwX2SpqKU5d/cL5IEDu3OEqy5GvPcCmDcmiNn5GROww05NYfwGcdG7Hd0ARlyh8HFsXeDYNUA==
X-Received: by 2002:a63:5:0:b0:3c6:dcb2:428 with SMTP id
 5-20020a630005000000b003c6dcb20428mr32725819pga.73.1653566480747; 
 Thu, 26 May 2022 05:01:20 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:1:45c7:d5e2:7b45:3336])
 by smtp.gmail.com with ESMTPSA id
 bi7-20020a170902bf0700b0015e8d4eb282sm1328190plb.204.2022.05.26.05.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 May 2022 05:01:20 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 michael.h.kelley@microsoft.com
Subject: [RFC PATCH V3 2/2] net: netvsc: Allocate per-device swiotlb bounce
 buffer for netvsc
Date: Thu, 26 May 2022 08:01:12 -0400
Message-Id: <20220526120113.971512-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526120113.971512-1-ltykernel@gmail.com>
References: <20220526120113.971512-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 konrad.wilk@oracle.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kirill.shutemov@intel.com, iommu@lists.linux-foundation.org,
 andi.kleen@intel.com, vkuznets@redhat.com, hch@lst.de
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

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Netvsc driver allocates device io tlb mem via calling swiotlb_device_
allocate() and set child io tlb mem number according to device queue
number. Child io tlb mem may reduce overhead of single spin lock in
device io tlb mem among multi device queues.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/net/hyperv/netvsc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 9442f751ad3a..26a8f8f84fc4 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -23,6 +23,7 @@
 
 #include <asm/sync_bitops.h>
 #include <asm/mshyperv.h>
+#include <linux/swiotlb.h>
 
 #include "hyperv_net.h"
 #include "netvsc_trace.h"
@@ -98,6 +99,7 @@ static void netvsc_subchan_work(struct work_struct *w)
 	struct netvsc_device *nvdev =
 		container_of(w, struct netvsc_device, subchan_work);
 	struct rndis_device *rdev;
+	struct hv_device *hdev;
 	int i, ret;
 
 	/* Avoid deadlock with device removal already under RTNL */
@@ -108,6 +110,9 @@ static void netvsc_subchan_work(struct work_struct *w)
 
 	rdev = nvdev->extension;
 	if (rdev) {
+		hdev = ((struct net_device_context *)
+			netdev_priv(rdev->ndev))->device_ctx;
+
 		ret = rndis_set_subchannel(rdev->ndev, nvdev, NULL);
 		if (ret == 0) {
 			netif_device_attach(rdev->ndev);
@@ -119,6 +124,10 @@ static void netvsc_subchan_work(struct work_struct *w)
 			nvdev->max_chn = 1;
 			nvdev->num_chn = 1;
 		}
+
+		/* Allocate boucne buffer.*/
+		swiotlb_device_allocate(&hdev->device, nvdev->num_chn,
+				10 * IO_TLB_BLOCK_UNIT);
 	}
 
 	rtnl_unlock();
@@ -769,6 +778,7 @@ void netvsc_device_remove(struct hv_device *device)
 
 	/* Release all resources */
 	free_netvsc_device_rcu(net_device);
+	swiotlb_device_free(&device->device);
 }
 
 #define RING_AVAIL_PERCENT_HIWATER 20
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
