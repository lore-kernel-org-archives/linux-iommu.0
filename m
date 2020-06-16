Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2C8C433E3
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 01:18:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C65206F7
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 01:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vzILdiTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C65206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A6E9187E6E;
	Tue, 16 Jun 2020 01:18:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2TTThepGK36O; Tue, 16 Jun 2020 01:18:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 476CF87D51;
	Tue, 16 Jun 2020 01:18:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40641C0890;
	Tue, 16 Jun 2020 01:18:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49643C0890
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 01:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3563888BCD
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 01:17:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OhbkMx-N5tEB for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 01:17:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com
 [209.85.219.201])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 469C288ACE
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 01:17:57 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id c3so22832604ybi.3
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 18:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=kh7TdnSzjMmv55tOoFOguM4fQKcmXvzqJelRJT/2fHA=;
 b=vzILdiTcV8zGZvfxPJjrCDkaIiDK8KCwgVW5sP5e/czfC9CFBD+4ikfLr1nNZiLCG4
 yExyajLI5z2tPj5jVUXTZlmBhGBcd6BGVc1XxIDjdNS3taX9qDYcvZx28CMqEi9ygJgA
 MWL6ea5rsIGkxxLvlq7vvECQtGR9tvELA1ucICg5NNO8B8aWbqA2h64ZsHzjXsnB1YQW
 4b2MdI3q0G8zF3rBfgke02muupsh2/pTPE8RoaCWeIK9EoWZZ89jLrd6Hi0IDaGyOVQO
 vuDTYNL7FXPLpo9k/VkK76GyxrbKc0NHqjiyuMipoIOah7pHfFDxwNZAF35HnrttIiGX
 Sfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=kh7TdnSzjMmv55tOoFOguM4fQKcmXvzqJelRJT/2fHA=;
 b=MtVdnorpUbsd+G4sPkFE1G2QP15kleM9XR9m3aA3VH1suAF0GWl8tvyKQFHpOX0LLI
 TEhSJgcwvIFl5gxjI4Id8TS8jGovAXeWRgRRZIeMK6xlzW1hJCr2UpS0ZhQPSbcxS+Rw
 gplui/C8/n2g+S8sVWFENWQgJoq6se7BJiXLG+zZOKwypEXYX+mbe2UB/6ZHDiHu4cGJ
 ELgskX3yi4KNr9ILwhqtYKA0/mZf/x2Y5Cc7BAVqprE5QvU7OwV2WxyImRUvZ+BxJEOA
 CLTTyxhEYuxJanIM2mKndeDlfLJUBsOfyAJjrZ6cyXJ8hBnjpGgZr3LbCtffqZGzEPc3
 LJlA==
X-Gm-Message-State: AOAM531D/tmdXe6xNfxSIpud+JifywMUZW/U5jcpcb+/S1VFA7Tp0qyq
 uCidI2myyZUp8qIV1eDX2qwYHmHmI9oW
X-Google-Smtp-Source: ABdhPJxAth06oSMz+frpUoX8kGWlQJ8aihUMBynZvrDOTpUM1ErZyuW821epnFDUXXRGd/C8nOzICVaMXji/
X-Received: by 2002:a25:9746:: with SMTP id h6mr429416ybo.409.1592270276282;
 Mon, 15 Jun 2020 18:17:56 -0700 (PDT)
Date: Mon, 15 Jun 2020 18:17:42 -0700
In-Reply-To: <20200616011742.138975-1-rajatja@google.com>
Message-Id: <20200616011742.138975-4-rajatja@google.com>
Mime-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 4/4] pci: export untrusted attribute in sysfs
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 iommu@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>, 
 lalithambika.krishnakumar@intel.com, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Prashant Malani <pmalani@google.com>, 
 Benson Leung <bleung@google.com>, Todd Broch <tbroch@google.com>,
 Alex Levin <levinale@google.com>, 
 Mattias Nissler <mnissler@google.com>, Rajat Jain <rajatxjain@gmail.com>, 
 Bernie Keany <bernie.keany@intel.com>, Aaron Durbin <adurbin@google.com>, 
 Diego Rivas <diegorivas@google.com>, Duncan Laurie <dlaurie@google.com>, 
 Furquan Shaikh <furquan@google.com>, Jesse Barnes <jsbarnes@google.com>, 
 Christian Kellner <christian@kellner.me>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, oohall@gmail.com
Cc: Rajat Jain <rajatja@google.com>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This is needed to allow the userspace to determine when an untrusted
device has been added, and thus allowing it to bind the driver manually
to it, if it so wishes. This is being done as part of the approach
discussed at https://lkml.org/lkml/2020/6/9/1331

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6d78df981d41a..574e9c613ba26 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -50,6 +50,7 @@ pci_config_attr(subsystem_device, "0x%04x\n");
 pci_config_attr(revision, "0x%02x\n");
 pci_config_attr(class, "0x%06x\n");
 pci_config_attr(irq, "%u\n");
+pci_config_attr(untrusted, "%u\n");
 
 static ssize_t broken_parity_status_show(struct device *dev,
 					 struct device_attribute *attr,
@@ -608,6 +609,7 @@ static struct attribute *pci_dev_attrs[] = {
 #endif
 	&dev_attr_driver_override.attr,
 	&dev_attr_ari_enabled.attr,
+	&dev_attr_untrusted.attr,
 	NULL,
 };
 
-- 
2.27.0.290.gba653c62da-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
