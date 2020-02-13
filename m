Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D9CC3B189
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C2324650
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSxmEE/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C2324650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B59F62152C;
	Thu, 13 Feb 2020 16:40:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FNINa+S6mrua; Thu, 13 Feb 2020 16:40:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D9EDB21526;
	Thu, 13 Feb 2020 16:40:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4A0FC07FE;
	Thu, 13 Feb 2020 16:40:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57064C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 46A5D87F9C
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L7rnpLiy8b+S for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 16:40:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 88FCE87F48
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:40:13 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id g1so6984903wmh.4
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 08:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WYs51DTWcpY/Z0Mrusx8O/2oW5iuRXCgerYN0ZZKm9Y=;
 b=RSxmEE/jHbfX+qZPdrlhKUfzfZB0bOqYvOreeIMwy4VplOCTAPR6mhE8oQfjshT1U9
 5vYdcMghcYmzE4iAQHAUxqnfxAhfDHq63+XWobt34fNdDBrHbkXZ1okFQy3xLwbinAdO
 t4yRTBfxS7O9wiBOKiCCIjuvS4Pw2s8DYtvTJuIMZKkDtLy77EAdqJPzrGO0LdI/tdas
 adTfiqeBzrx/DvG6UZxpPKOHhR+hJF4T6CxRxiVsbTQo6tjfE286KoXQvV0IRHI27OTl
 SGovm73hq2DEDoElDGTDLsZPGcLCdRzEFSwfRkA1nfQc/ui+1CBhTG1bqmZMgTipkVHO
 v3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WYs51DTWcpY/Z0Mrusx8O/2oW5iuRXCgerYN0ZZKm9Y=;
 b=WhF4CklV+z6dcxaanJQP+9fDTRfW/6Eh02jWCtMWPtSJqqzh/Qm5M9xwD2gS0IwIho
 eE748gmt6e3PFmzfCqeZNFJCIv/fNfzv8XHky7mv2n1WacxJPAPiE/hawh4ikBHp3kKu
 wYtJ92/tuQXr+wK0YynznwdmqyFtac0iZDJ9fWIF4sPX7foCl/8lPDFT+GdppNs1KMee
 /FGsdaKP6DvT+zUxnR5KCiX0k/X3aa19hQFAftcrwUTAneAyx86ipIPCnI3ZDrcRJfYu
 f+3pNFb7JU8BAwN7sr2oYQzNwgF2UQNJxu1VR9VS2uvllTFwPb3sD2B1qbegEPGiOp5g
 WtOw==
X-Gm-Message-State: APjAAAV61wKu0z76RjqIdxkrNMvhjWbRcUf02lKKtgQEe0+CDUtMlIK5
 I6HwZgh4rQMe7Ha6JCHVyjw=
X-Google-Smtp-Source: APXvYqw7j8Tekzs4LcNAuJ1ri+Mrd+LCBOLE2GE/xwhUFmLwrvqbghwhx63vfIvD8Gy3IDaZ3tHtcw==
X-Received: by 2002:a1c:e007:: with SMTP id x7mr6518555wmg.3.1581612012009;
 Thu, 13 Feb 2020 08:40:12 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
 by smtp.gmail.com with ESMTPSA id q1sm3347264wrw.5.2020.02.13.08.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 08:40:11 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 2/5] of: Use memory-controllers property for DMA parent
Date: Thu, 13 Feb 2020 17:39:56 +0100
Message-Id: <20200213163959.819733-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213163959.819733-1-thierry.reding@gmail.com>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

Prefer the memory-controllers property to determine the DMA parent of a
device over the interconnects property, which can be ambiguous since it
can be used to describe multiple paths to system memory.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/of/address.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index e8a39c3ec4d4..ae841bd36bb0 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -697,17 +697,24 @@ static struct device_node *__of_get_dma_parent(const struct device_node *np)
 	struct of_phandle_args args;
 	int ret, index;
 
-	index = of_property_match_string(np, "interconnect-names", "dma-mem");
-	if (index < 0)
-		return of_get_parent(np);
+	ret = of_parse_phandle_with_args(np, "memory-controllers",
+					 "#memory-controller-cells",
+					 0, &args);
+	if (!ret) {
+		return of_node_get(args.np);
+	}
 
-	ret = of_parse_phandle_with_args(np, "interconnects",
-					 "#interconnect-cells",
-					 index, &args);
-	if (ret < 0)
-		return of_get_parent(np);
+	index = of_property_match_string(np, "interconnect-names", "dma-mem");
+	if (index >= 0) {
+		ret = of_parse_phandle_with_args(np, "interconnects",
+						 "#interconnect-cells",
+						 index, &args);
+		if (!ret) {
+			return of_node_get(args.np);
+		}
+	}
 
-	return of_node_get(args.np);
+	return of_get_parent(np);
 }
 
 static struct device_node *of_get_next_dma_parent(struct device_node *np)
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
