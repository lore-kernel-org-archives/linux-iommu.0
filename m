Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E357C433E2
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 11:50:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607E420663
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 11:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSls9zjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607E420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0151586DF4;
	Tue, 26 May 2020 11:50:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ozjt15WDmkdn; Tue, 26 May 2020 11:50:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5437786E1F;
	Tue, 26 May 2020 11:50:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40D5BC088D;
	Tue, 26 May 2020 11:50:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A812C016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 11:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 68F1786E1F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 11:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ClOlbSPuVjoY for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 11:50:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C793886DF4
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 11:50:16 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id fs4so1332148pjb.5
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rzP5fzn/E340EPlW7gDpFBlyEkfSVaF1oJz6fYo76k8=;
 b=cSls9zjl0whNH0eR/l2i02O95OOhgGrNGwM26ZGFvkQW9VtZxJfxlywizJRke/rmbm
 DjeTG2qfQRIUFCJCYqf3IQGjZY5BYNOiPnuTiljaUSiUooWYyRzwspOmUiqDqG0M0ZC0
 NH/f8WAxs2sULx5ClU2rSJ/IVPF1eLlml+6rdIo1i25jIwEm+AfsqPAhvJRo8r0X4r3K
 IiHWdbIh+eGq5kqb6u0B/VzWcIY6fcWtE+dhbKonQdK7ew/58LBw5We1pNCxs/7oweP5
 Jjm4EUWxVNg2+Xy8U6NcCfQFYKXK3ubEYUyGEqX5s/R/MQ0L946l4eUlakQO2SpHpvOw
 LfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rzP5fzn/E340EPlW7gDpFBlyEkfSVaF1oJz6fYo76k8=;
 b=nNsjkhkBIPaJDKflJ/tE00N/6RmJB2d+GmvyWi4MMkVknZh7o5Q+l0EC9LWOMebmWq
 yOmWsOu8Pd0598U8JYiajJ+eXtG1XetCpTMiRCQnfCz9RwXeWLEb2YlXsaN3hh53vBSp
 YAu+ZbTP/AB47Zf/iOvGsX9QsOhPAMFzobOab0tFtLfhkUJL50QcavmupCNLWsvesOZj
 zUrlSdNP5xsKA85b70gsnHAfx8aKqXjrJQDoiMfkPtBR03VzXKJlZFvqsl9IbP2iAPDO
 EEs1r+N4oZoTmeLdmqVYFdgyee8bPs9CGHWhm9JS2WlWoLuLs/jt2wnJo1CqJ0CM/Iac
 M4wQ==
X-Gm-Message-State: AOAM5317mdrjlGzBE7EADFzHSgfcZ5xLRXoUzOAxeLLRErGJ9BUn/Mwr
 2R7vT4jgkRkH7UWkYh8ZcOQTWA==
X-Google-Smtp-Source: ABdhPJzHFiU9uQ9tpgEPP89QRh+ApddGGVo2/M4MgxGlH4yKc3wRc1jVL2ox1xaiLvr1T78JAyGRGQ==
X-Received: by 2002:a17:90a:4809:: with SMTP id
 a9mr26082742pjh.196.1590493816386; 
 Tue, 26 May 2020 04:50:16 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.9])
 by smtp.gmail.com with ESMTPSA id c12sm15586567pjm.46.2020.05.26.04.50.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 May 2020 04:50:16 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 jean-philippe <jean-philippe@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, kenneth-lee-2012@foxmail.com,
 Wangzhou <wangzhou1@hisilicon.com>
Subject: [PATCH 2/2] iommu: calling pci_fixup_iommu in iommu_fwspec_init
Date: Tue, 26 May 2020 19:49:09 +0800
Message-Id: <1590493749-13823-3-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Calling pci_fixup_iommu in iommu_fwspec_init, which alloc
iommu_fwnode. Some platform devices appear as PCI but are
actually on the AMBA bus, and they need fixup in
drivers/pci/quirks.c handling iommu_fwnode.
So calling pci_fixup_iommu after iommu_fwnode is allocated.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7b37542..fb84c42 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	fwspec->iommu_fwnode = iommu_fwnode;
 	fwspec->ops = ops;
 	dev_iommu_fwspec_set(dev, fwspec);
+
+	if (dev_is_pci(dev))
+		pci_fixup_device(pci_fixup_iommu, to_pci_dev(dev));
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
