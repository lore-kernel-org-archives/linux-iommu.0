Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84872C10F03
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 20:04:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2DD217D9
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 20:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mI8yGQTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2DD217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0EDC1E50;
	Tue, 23 Apr 2019 20:04:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 811D8E47
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 20:04:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
	[209.85.208.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 06FDC829
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 20:04:35 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id d55so13837787ede.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=from:to:cc:subject:date:message-id;
	bh=vFjhjgT8J7J/y48rMlFt3N0exp7AnVL6x1jQtFEwJmA=;
	b=mI8yGQTMJJh7Cn3t53GITJ7AnDAMMH3Gb2+EvEuxbUvz/yvODXcDKLwCkoVfk3Xi1U
	d+3QlmYt52HZ7SqMCsb5IOvyluTstovnK7WcalvZOCL/dpCx854RM2+qody/rxdiYaeg
	PRZ905oyROMMLv6teBg61hvKM8bMjuStQWeiSfLPkV2W1KKLs0rk68A7z9mRE08hBF2B
	Evtau2ZxHslCFl2aaJlixONLIUBiMoEXlgSfng1Bz6R3SaFpxpiMT/Eplda4Y9XtDXC3
	II/fe0MFVcY7l+nK4XoOtL/PUcwhwV3Ay/RH/O1TfJFXkuRValyvEZ5fTV6XXdqMUqJB
	o6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=vFjhjgT8J7J/y48rMlFt3N0exp7AnVL6x1jQtFEwJmA=;
	b=CD0Xbpf8p15lWlJ0hyhh5oj/hNKx72Dguqp6x4TH+yc35uQlvdqqwN+iWnW5DlwW5g
	uyGs+U1cE0qDN8wD+2Det6p8VLh69EZrfSNhvDFf+MAbgZceFqSaFFO4kYgbLrAXPJwE
	D9HN07M6KMZHzu8m7l5buS5zq/GiP2OkjObZlemsKdp3Bx/IjuFANmVCIVl8sIar0f38
	mjg+NAEZJlKTjVMbDr++PjbOBf3fJPKKy1iDu1QpikxgjoMNLHNDTExPXKKLx2dvkUZK
	NIMvkhYkE7tdFIhm6CjMeGY1Dqnt4iTlKWldO52a4KwDv32KV5xPniV4Lo8QJ5ETTgqI
	5Hgg==
X-Gm-Message-State: APjAAAWZzuAP/deDT4pIAND805iOS+jkMQEoBKjn8t1TBFBBNBIcKRXr
	2wQ/ESHy+4WrarhfQNo2DS+jIlpL5eBnuA==
X-Google-Smtp-Source: APXvYqxaAnK6AtYePG+GxF6pAlJM0XJ8IeMly8zDdWCF2/Fo0nOgrbK6yfMwfKMwpIbSiDRpd+YOHQ==
X-Received: by 2002:a17:906:c389:: with SMTP id
	t9mr5089629ejz.64.1556049874311; 
	Tue, 23 Apr 2019 13:04:34 -0700 (PDT)
Received: from linux-ThinkPad-X1-Carbon-5th.Hitronhub.home ([80.111.101.37])
	by smtp.gmail.com with ESMTPSA id l10sm3762140eda.8.2019.04.23.13.04.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 13:04:33 -0700 (PDT)
To: iommu@lists.linux-foundation.org
Subject: [PATCH] Remove old no iommu direct mapping code
Date: Tue, 23 Apr 2019 21:03:34 +0100
Message-Id: <20190423200335.3888-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
Cc: Tom Murphy <tmurphy@arista.com>, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423200334.xnqIFUG1xKLticwKs5JBmn678BLuSxenkCrYAn8k2iE@z>

These checks were intended to handle devices not mapped by the IOMMU.
Since the AMD IOMMU driver uses per-device dma_ops these functions can
no longer be called by direct mapped devices. So these checks aren't
needed anymore.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b319e51c379b..67cdc9e5304b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2503,9 +2503,7 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	u64 dma_mask;
 
 	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL)
-		return (dma_addr_t)paddr;
-	else if (IS_ERR(domain))
+	if (IS_ERR(domain))
 		return DMA_MAPPING_ERROR;
 
 	dma_mask = *dev->dma_mask;
@@ -2676,11 +2674,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	struct page *page;
 
 	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL) {
-		page = alloc_pages(flag, get_order(size));
-		*dma_addr = page_to_phys(page);
-		return page_address(page);
-	} else if (IS_ERR(domain))
+	if (IS_ERR(domain))
 		return NULL;
 
 	dma_dom   = to_dma_ops_domain(domain);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
