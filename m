Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5AFCA906B
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6066120873
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+4aT9+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6066120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3293F87F08;
	Thu, 30 Apr 2020 14:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HZwJxMlckEUi; Thu, 30 Apr 2020 14:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 87B18877A7;
	Thu, 30 Apr 2020 14:40:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76C40C0864;
	Thu, 30 Apr 2020 14:40:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65928C0864
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 627B487F34
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id REdhI7-b0KbV for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 14:40:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7EB6A87708
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:45 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id 188so2156114wmc.2
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 07:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3qbDs4Y7WviMOr0GSY4nlY77EsYqapJLb3Db4qcN97M=;
 b=t+4aT9+cYprXrpA/0QMDQLTv35ltZRsIzsJhL6WzRIlkGwHMzV+TsilZsqBdYO9os+
 LEmbI9poZBOZzYV00yYcZ2MTRGrHanuT7mbSIOQBDmN22wolY/5LERCWxTie3xScd5i+
 mfXPYaSrV/1gc4GJ4hkv337jnn0KZarzUW+GAESnsUgwH5AStIsuGwjPrCaZW9BXvAda
 ze1VdbzDZPXGJXDAcZRAe+Vz+LRVXXtQ68AFPgXXtAqojny8CzAUyLGsI4qjUN9mU9b9
 QuzOYgjkRq/kGh890dDfQT+uQE4XjhOzPT2Qd7+Ro83BK/yAfy1ITFBBF/jLhKZ5c5sA
 0KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3qbDs4Y7WviMOr0GSY4nlY77EsYqapJLb3Db4qcN97M=;
 b=PPDQBAISiKkSwV3B/G++BqvGBGrnU9+wNI9gFKK4Z/zSWEnjWRX/JuLsJm1QKrIxac
 N8BBZ53+cLUpqavsv1LSDkXyxVWmt/GDqWwdMAz4vr7p7fP/QoEPkuzBQ3XarWL4W/wN
 TxthGTKXpb/nDdzDYoMh7w6P9q5FeP5l2CzxrCHEW22vC4N9zpJ43+tRc+yXvCEjFJSg
 1eC/5CmHHwE9v5ECZy6213H25uJrWrMcDcdfizEVOFlwKnsNVa5vHLYpRCHD4H9+MonX
 it8ptOPjjD0N4vrkwt2+Olksk5mZVlfYeFwDNS6/ntcnDEpvU3zqttWUNmlUOaCSGPAn
 e9Ng==
X-Gm-Message-State: AGi0PuZ4unSUO5L4XpXIXs4oia3Oz+QKM3d+TZQQI9qPokv/8LMfilxn
 1dS4pMvaUje+UqSdJnwwtl+VjlQXFUg=
X-Google-Smtp-Source: APiQypIZMn/sX8HP3LNRMIS2Wr5t5ivHYBY9IZ/xvKKh7rTp8GxPMClKn6Q3u2r37yB03vTCOANl8Q==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr3255113wmi.72.1588257643793; 
 Thu, 30 Apr 2020 07:40:43 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 07:40:43 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v6 21/25] dt-bindings: document stall property for IOMMU
 masters
Date: Thu, 30 Apr 2020 16:34:20 +0200
Message-Id: <20200430143424.2787566-22-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Rob Herring <robh@kernel.org>, fenghua.yu@intel.com, kevin.tian@intel.com,
 jgg@ziepe.ca, catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 felix.kuehling@amd.com, will@kernel.org, christian.koenig@amd.com
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

On ARM systems, some platform devices behind an IOMMU may support stall,
which is the ability to recover from page faults. Let the firmware tell us
when a device supports stall.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../devicetree/bindings/iommu/iommu.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 3c36334e4f942..26ba9e530f138 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -92,6 +92,24 @@ Optional properties:
   tagging DMA transactions with an address space identifier. By default,
   this is 0, which means that the device only has one address space.
 
+- dma-can-stall: When present, the master can wait for a transaction to
+  complete for an indefinite amount of time. Upon translation fault some
+  IOMMUs, instead of aborting the translation immediately, may first
+  notify the driver and keep the transaction in flight. This allows the OS
+  to inspect the fault and, for example, make physical pages resident
+  before updating the mappings and completing the transaction. Such IOMMU
+  accepts a limited number of simultaneous stalled transactions before
+  having to either put back-pressure on the master, or abort new faulting
+  transactions.
+
+  Firmware has to opt-in stalling, because most buses and masters don't
+  support it. In particular it isn't compatible with PCI, where
+  transactions have to complete before a time limit. More generally it
+  won't work in systems and masters that haven't been designed for
+  stalling. For example the OS, in order to handle a stalled transaction,
+  may attempt to retrieve pages from secondary storage in a stalled
+  domain, leading to a deadlock.
+
 
 Notes:
 ======
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
