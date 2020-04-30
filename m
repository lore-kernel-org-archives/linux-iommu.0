Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8A4C47259
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50442137B
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="To4rDTgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50442137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ABAE025067;
	Thu, 30 Apr 2020 14:40:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RkJp34SB7ufN; Thu, 30 Apr 2020 14:40:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F107E24F97;
	Thu, 30 Apr 2020 14:40:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7995C0864;
	Thu, 30 Apr 2020 14:40:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EAF6C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2D89187F00
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mt1ZOE5cFFQ4 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 14:40:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2732387708
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:18 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id e26so2149106wmk.5
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 07:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JE1ADcc++3Vo3M85Nsq6iA6oMNESnLaCpD2Oim3Sh4w=;
 b=To4rDTgBB0L+90TpdlToDyTHhOTZj6qgWdXHCq8rL1YycyE+18LW7Zf89m+U1MgVk8
 +89saYtKLC3GQTyPik+jhwX+aQBQqrNZ4WAaBc81x5L7V2vIZ7XFNEV/ge8dD5ZI3D5c
 Ky1IsNUlR6HCYrPrzPKso3RM3HEViU0cFo2w3w0DZL/QuZLpSZOx9atlH5Jsmi0Ms8Vr
 u2AWoTd5OM4H1HJBzbAVpKLc8NupQiOKgBHwOjQ95DBXB8CytUigHuiBI45tM4iuk42Y
 bxPd271XeYNTljj1NAR5ciuWUHZ4qD6eBIS0O6tVRLdGsDXU0GOH+yzvHKWV4kkY+zxV
 HwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JE1ADcc++3Vo3M85Nsq6iA6oMNESnLaCpD2Oim3Sh4w=;
 b=a+pxnXvR3jXLmPH5xnp7sEcxJGIPlKmjoj31j6EdltKh9e1+k8h8iZACBXjk4mplIo
 3sg9v8I24wgvIbq4cXm5g3xNHI4Q3H1i0ad+5sUPBhRGIzLpyRJhBQMz4N1uyCkZ5TiW
 NpoyvTA0NWxhVDo//Dyho2JToA6Y2fw3ew1u0/xNUJTTsRwVEv39eAvj05UvGEtf82MV
 aI7WvnArnLEvIO9SoG60cNg3IHRDwoFD9T+gn41pkTZtDXCtWCcesxMqW5xOCI6ZYjSx
 wZBzn6ueTJLXnXP4mXFHcsg++LTOfRqlMV3PgOwd6IM6NkhBK34Vpl+VOaOp2/V7LUSn
 Rrsw==
X-Gm-Message-State: AGi0PuYuEDh2o6bUh6kQPodsTWJCZjgK8OZw2PM4XQLwSAgTPgohsZVY
 sbBbYP9bFv23mg8LHNZ18fhuHMqsAOk=
X-Google-Smtp-Source: APiQypLUKpU9EiJvK1iecbIeHBOlrvMyuNzM5Gu2fzf4ff9woYknhWdO7VYVk5snGgyndqBMx/wwdg==
X-Received: by 2002:a1c:7d15:: with SMTP id y21mr3195383wmc.57.1588257616098; 
 Thu, 30 Apr 2020 07:40:16 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 07:40:15 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v6 01/25] mm: Add a PASID field to mm_struct
Date: Thu, 30 Apr 2020 16:34:00 +0200
Message-Id: <20200430143424.2787566-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
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

Some devices can tag their DMA requests with a 20-bit Process Address
Space ID (PASID), allowing them to access multiple address spaces. In
combination with recoverable I/O page faults (for example PCIe PRI),
PASID allows the IOMMU to share page tables with the MMU.

To make sure that a single PASID is allocated for each address space, as
required by Intel ENQCMD, store the PASID in the mm_struct. The IOMMU
driver is in charge of serializing modifications to the PASID field.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
For the field's validity I'm thinking invalid PASID = 0. In ioasid.h we
define INVALID_IOASID as ~0U, but I think we can now change it to 0,
since Intel is now also reserving PASID #0 for Transactions without
PASID and AMD IOMMU uses GIoV for this too.
---
 include/linux/mm_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4aba6c0c2ba80..8db6472758175 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -534,6 +534,10 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+#ifdef CONFIG_IOMMU_SUPPORT
+		/* Address space ID used by device DMA */
+		unsigned int pasid;
+#endif
 	} __randomize_layout;
 
 	/*
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
