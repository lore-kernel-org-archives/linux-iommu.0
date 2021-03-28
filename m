Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F10C433EB
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1AF6192F
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1AF6192F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ECA7607A4;
	Mon, 29 Mar 2021 00:11:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y4pHvpuAgH6Z; Mon, 29 Mar 2021 00:10:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D50B5607B4;
	Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FFBAC001C;
	Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B0A6C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D1194030C
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AqEV3iAftdHm for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:57:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C13D40214
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:37 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id j7so8225608qtx.5
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qTMepEQ2KULfrsHgV8Kxlgt84PsBxxGqM80tVNIqbWY=;
 b=bTEbIGlULsXvf6mp9eD0MKL9UGtjeyV3vz6uIDnSq3FIpNNN4nSxkCxJXDeGfDDYyB
 zrGFOLTVdImkvTyvLeq0/4E+jnMEn98Q26GKTp+Nz0mhhF+ZDnkEgHrk7CFt7Ca0UvL4
 zn/PcJ5S81UeZvLDHEV66orBfcuymqrZb2/bTljWCMBn9pDs5sHfT9lWNzoSKvdiRlgf
 XdUsJFchXNreOvNlDTRTJnKriv/0ujteXmBg14gklE8iTN8dRgUSPOi0bMkwDOBHnpR4
 zgdlEoqgFMO6iS16vaq1e+iDX2yJvKTuHCAjQVE2Bd5zNUG+/3CwHCC8hFaVUgmb1NiM
 gWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qTMepEQ2KULfrsHgV8Kxlgt84PsBxxGqM80tVNIqbWY=;
 b=FpCaKdM6ZnLH8A+83gvTvG28P4RxuOBF/tu+kcmgv0nUGxq7IK7rsVsKA8mJlMSeHM
 oh2dwXpxsAZs6sLzUS/dNYmODl8ReopMoBY8hoSgd38yEIiU5eu31ahtB/7SSJHGYmOS
 SMxVsFxvjfD1Jzp72cN2NVf+noekZNf+kntKERdv/Rd52PW0TA3qaOgGYIS9hJPERCCI
 G424xUETeEJA3xIq4wWFxr8T8+W5f0fumBV1qy6yCVfuDuHyzYITPKozxjgfIBkICJIt
 DKtEBVq7ANlkjo22vk6EqM3PG9D68L0pJYDnGZdFZ2sV9l9iqFfhIgKVxObuGCmUbq4T
 l6mQ==
X-Gm-Message-State: AOAM53073pwXlHCll7eYh+PkS/MfKbSauXuvhCc4XRE9VfBILZaHij17
 fnVGoZ2ibffw/Pe8JQ4kEG0=
X-Google-Smtp-Source: ABdhPJwRTC1BpC2ZmqFvyCckRvvuwnANkqHAZvJtuc4Mu8nM99Nfdg+GTNYLo2psV/k5ZUFbmcYhiA==
X-Received: by 2002:ac8:dcc:: with SMTP id t12mr13997202qti.219.1616975856552; 
 Sun, 28 Mar 2021 16:57:36 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:57:36 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 20/30] at_hdmac.c: Quite a few spello fixes
Date: Mon, 29 Mar 2021 05:23:16 +0530
Message-Id: <d4e6597ed691d7faf4b35ca75e392706bdb16d1d.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Mar 2021 00:10:51 +0000
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 linux-kernel@vger.kernel.org
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

s/tranfers/transfers/
s/maxium/maximum/
s/previouly/previously/
s/broked/broken/
s/embedds/embeds/ .... three different places.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/at_hdmac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 30ae36124b1d..02c09532a9e4 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -374,11 +374,11 @@ static int atc_get_bytes_left(struct dma_chan *chan, dma_cookie_t cookie)
 		 * a second time. If the two consecutive read values of the DSCR
 		 * are the same then we assume both refers to the very same
 		 * child descriptor as well as the CTRLA value read inbetween
-		 * does. For cyclic tranfers, the assumption is that a full loop
+		 * does. For cyclic transfers, the assumption is that a full loop
 		 * is "not so fast".
 		 * If the two DSCR values are different, we read again the CTRLA
 		 * then the DSCR till two consecutive read values from DSCR are
-		 * equal or till the maxium trials is reach.
+		 * equal or till the maximum trials is reach.
 		 * This algorithm is very unlikely not to find a stable value for
 		 * DSCR.
 		 */
@@ -403,7 +403,7 @@ static int atc_get_bytes_left(struct dma_chan *chan, dma_cookie_t cookie)

 			/*
 			 * DSCR has changed inside the DMA controller, so the
-			 * previouly read value of CTRLA may refer to an already
+			 * previously read value of CTRLA may refer to an already
 			 * processed descriptor hence could be outdated.
 			 * We need to update ctrla to match the current
 			 * descriptor.
@@ -564,7 +564,7 @@ static void atc_handle_error(struct at_dma_chan *atchan)
 	spin_lock_irqsave(&atchan->lock, flags);
 	/*
 	 * The descriptor currently at the head of the active list is
-	 * broked. Since we don't have any way to report errors, we'll
+	 * broken. Since we don't have any way to report errors, we'll
 	 * just have to scream loudly and try to carry on.
 	 */
 	bad_desc = atc_first_active(atchan);
@@ -870,7 +870,7 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		atc_desc_chain(&first, &prev, desc);
 	}

-	/* First descriptor of the chain embedds additional information */
+	/* First descriptor of the chain embeds additional information */
 	first->txd.cookie = -EBUSY;
 	first->total_len = len;

@@ -1199,7 +1199,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	/* set end-of-link to the last link descriptor of list*/
 	set_desc_eol(prev);

-	/* First descriptor of the chain embedds additional information */
+	/* First descriptor of the chain embeds additional information */
 	first->txd.cookie = -EBUSY;
 	first->total_len = total_len;

@@ -1358,7 +1358,7 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	/* lets make a cyclic list */
 	prev->lli.dscr = first->txd.phys;

-	/* First descriptor of the chain embedds additional information */
+	/* First descriptor of the chain embeds additional information */
 	first->txd.cookie = -EBUSY;
 	first->total_len = buf_len;

--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
