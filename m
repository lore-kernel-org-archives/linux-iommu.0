Return-Path: <SRS0=Mzfx=6Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91EEC47255
	for <iommu@archiver.kernel.org>; Mon, 11 May 2020 16:10:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874202070B
	for <iommu@archiver.kernel.org>; Mon, 11 May 2020 16:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGI0C7SJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874202070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B96A86D2D;
	Mon, 11 May 2020 16:10:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id loo1vKFyw9yW; Mon, 11 May 2020 16:10:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5752586D19;
	Mon, 11 May 2020 16:10:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44AC1C0176;
	Mon, 11 May 2020 16:10:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 492CCC016F
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 16:10:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 365A288856
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 16:10:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uwHr+Cn6MMQE for <iommu@lists.linux-foundation.org>;
 Mon, 11 May 2020 16:10:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 751AF881A8
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 16:10:03 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id k12so18597736wmj.3
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=expFAEx3KcJlR686GWGP3WK4IdAwv8p4OHxTjCVQ3oQ=;
 b=KGI0C7SJM4O0+0oVW8hu4IwbSVtYT2OzEYssV7mCv+SwiH0pavsRYVcUAb4fXPb9Kb
 XfaqxkWadoBR/eqojjvwKUFTpAhyIMxlskVKIIh0okUJkWlPk3TqUPfCgHPy/YwE/Xpi
 GqBuZXGSYNBzrxawLSNvKkyTD475/D0v+AvE0ZTBo9KTg1rpDKCVbCeHwk4JT52EElup
 +mR3HaId0xJvtBDKn91AAtqXmZuBNriBjGopCKzgTvDoq+qk6/vRARnnUPFE16xfgpNZ
 h4nD6MMRwY2jZj5IWkOUe3MuDfxjm7qMhxXnwiKPZHhXD+9OhVzsovSAewnOre8ow2oj
 5QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=expFAEx3KcJlR686GWGP3WK4IdAwv8p4OHxTjCVQ3oQ=;
 b=WbSPcvJHd/W25fWe7Rqf+yZNcNnamly5R6DLPR1vdfFsvSifcNrXNlDqSptDDP5uHR
 X143OTH2A2C/Ge05ZoA3V/D6aYDJVDnFhzO07bLIE5X0cJkLqMQwo6583mf5NTUZy431
 ARClRg/4ZJazMF/nufBTgzJxA/2vkCzigVNYF3zNNHC4sfhrWvaD5eq24/IhchcbOdXA
 VvWGcO+CDiSRE0rIGQtHOF9u6N0f9ySpyoZFnsC7g1majHJdfmktC+Un4zrArHHHCdfl
 rgr8qrE1fg3ZPSDV1MVZsHF49g2wMaxpSsADUbKCNRE0GqKcMr9Wp9L1S1YdsQEzOKvk
 q3qQ==
X-Gm-Message-State: AGi0PubzcvAh7OJ8EOhqjAhV9WysKR96d+1d+EiLQSrf2pnfEVium1NQ
 4RQn/IcZfOXpPDdJjFAsNjE=
X-Google-Smtp-Source: APiQypIuOa0PjdW52RSoC9IMLqxX7YmIsli3gjxPPf9Eb9KTtVcfb55uQODjKXTqQ0qGdQWYSGrE5g==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr35184292wmk.68.1589213401878; 
 Mon, 11 May 2020 09:10:01 -0700 (PDT)
Received: from localhost (pD9E51079.dip0.t-ipconnect.de. [217.229.16.121])
 by smtp.gmail.com with ESMTPSA id b14sm15300418wmb.18.2020.05.11.09.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 09:10:00 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: Do not probe devices on IOMMU-less busses
Date: Mon, 11 May 2020 18:10:00 +0200
Message-Id: <20200511161000.3853342-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jon Hunter <jonathanh@nvidia.com>
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

The host1x bus implemented on Tegra SoCs is primarily an abstraction to
create logical device from multiple platform devices. Since the devices
in such a setup are typically hierarchical, DMA setup still needs to be
done so that DMA masks can be properly inherited, but we don't actually
want to attach the host1x logical devices to any IOMMU. The platform
devices that make up the logical device are responsible for memory bus
transactions, so it is them that will need to be attached to the IOMMU.

Add a check to __iommu_probe_device() that aborts IOMMU setup early for
busses that don't have the IOMMU operations pointer set since they will
cause a crash otherwise.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Note that this is probably also required for the BCMA bus implemented in
drivers/bcma/main.c since no IOMMU operations are ever assigned to that
either.

 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9888a3c82b15..4050569188be 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -196,6 +196,9 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	struct iommu_group *group;
 	int ret;
 
+	if (!ops)
+		return -ENODEV;
+
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
 
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
