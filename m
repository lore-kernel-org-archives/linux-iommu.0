Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A18C33CA2
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 03:03:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3B32070E
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 03:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDMFSUZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3B32070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 95ED787E14;
	Thu,  9 Jan 2020 03:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wZblnoYYeglk; Thu,  9 Jan 2020 03:03:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8DB6587D75;
	Thu,  9 Jan 2020 03:03:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CAF9C1796;
	Thu,  9 Jan 2020 03:03:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89DA2C0881
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 03:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7338620489
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 03:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qrUKHVbnSpFa for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 03:03:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by silver.osuosl.org (Postfix) with ESMTPS id F07C82047E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 03:03:31 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id n59so488668pjb.1
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jan 2020 19:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Cs8uiG4Otj89DPGdhYY7Tkm53Fm3KjMymBAJH7/ZQxE=;
 b=iDMFSUZ9zInAEOvOr/Vtpcj+n2AotBpOV/pbfmQXH+pOtraZEVbBZyNisseU6I7RxD
 gDlRHyCJoPOxtPhx3ecq35zAWHyOWhdAqUfAgGkkmkwmyO3pMYdmqt5sS9CbJ/JCHbsK
 E9MhM3ImEQRrUzncFVDEGlovLlYRmCCYxVi0BvP4xSVIJgVDUPxZCy+vb4SDRsua2h4v
 hir+BIP3R4bmsRyxH3QYAxAQ+97zs6jCcK8pzoc1VfMJWXOrCIs2FPpZF/5O4rwwm4bc
 4luUPtQ+lDDmS2h8hPDSTOdGllftYfEYH2Z5TwM7ievUPUayRtISf1uN6guh/mGkNCaq
 vqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Cs8uiG4Otj89DPGdhYY7Tkm53Fm3KjMymBAJH7/ZQxE=;
 b=g8TAlpOw+dRHEz4LTZ3Kbq9ZQawrSlIStqzNiDNuQ90oSTGbjTG1UPmpwJxighe4XZ
 lA84jYe1TS0tXQ63aw3FBxpXF0P9LGg8nK1nCMktG8DvU7UxkpvPX1PcATzo6lSlMgSN
 bfubLks4VhUWrqSxyPSl7eMKu50EF8mBt4w7ABl943y0/Rp/cSxaLtIh2xbFn+7BILX7
 PCGuhFjiiIMMaULPaIzTd+5V2s+XqoWiXrzc/4tioQiUwajeGh1xS2qwbt70m0sP/nb8
 xnHckQxHBlXe34RSw2YsOgA3I1rCZ9CJF9qdiSQPk03xXPXZnZNlWU2lWRdkSDvKIhKp
 tRNw==
X-Gm-Message-State: APjAAAWgEwlypFdQKhAO1G41pszv7ti7ZcKIxMBKIWGdyMJ4r3bESmX3
 Q16CWgL8VvjzRK6ZQ97dllpIXbJxbus=
X-Google-Smtp-Source: APXvYqxRB06G0gx44RsiKdMMCqIWu5FO+Szfr4gaMOkcczZBkrHftuT/qo6ZzB7YaKehOzRbd2SM/A==
X-Received: by 2002:a17:90a:e657:: with SMTP id
 ep23mr2415673pjb.105.1578539011577; 
 Wed, 08 Jan 2020 19:03:31 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com (114-27-47-65.dynamic-ip.hinet.net.
 [114.27.47.65])
 by smtp.googlemail.com with ESMTPSA id r37sm684072pjb.7.2020.01.08.19.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 19:03:31 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu/amd: Remove unused struct member
Date: Thu,  9 Jan 2020 11:02:51 +0800
Message-Id: <20200109030251.5782-3-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109030251.5782-1-ahuang12@lenovo.com>
References: <20200109030251.5782-1-ahuang12@lenovo.com>
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

From: Adrian Huang <ahuang12@lenovo.com>

Commit c805b428f206 ("iommu/amd: Remove amd_iommu_pd_list") removes
the global list for the allocated protection domains. The
corresponding member 'list' of the protection_domain struct is
not used anymore, so it can be removed.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/iommu/amd_iommu_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 500f0b78879d..f8d01d6b00da 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -463,7 +463,6 @@ struct amd_irte_ops;
  * independent of their use.
  */
 struct protection_domain {
-	struct list_head list;  /* for list of all protection domains */
 	struct list_head dev_list; /* List of all devices in this domain */
 	struct iommu_domain domain; /* generic domain handle used by
 				       iommu core code */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
