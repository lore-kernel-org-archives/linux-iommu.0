Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A4C433E8
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8F46193E
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8F46193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 136894034D;
	Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6BY2hGXOKIzI; Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 084C34032C;
	Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB306C0025;
	Mon, 29 Mar 2021 00:10:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B6B6C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D3144030C
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YmPEuMhpDp8D for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:56:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4FFD440214
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:28 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id q26so10931743qkm.6
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b+g6kPIG/jwFitPzoitjd4fSzc6P/hya8rywnHeMN/8=;
 b=HBBLF/SJTiVQWcLhNqq7bzpHR2fKW9LP6DWRvUsmYI7rcgdhmE09hx9CIxGfTsumKX
 isRs8nn27xIKkAFpC/ZbyFrFtAkA1tz5NS7xJ3Ovmkz+afQ30TBK5a8we2BRZXGgjxxr
 z6kTysKHQ1ynwBd9QItRNqLsEpW7uXvoTnvwnv8XkMp+fdf3Uuptl6dTZMalYNMRHWxF
 NM0QNQoHDeEh0fx03RO8xhl/6Q0tu1MW6TIguY4L/6GIaX3v1qxLcUp3UUYUodE+6H6H
 XAXaSfBSUy0AypaInMTUVAZebzJYkGqKi/dXcHv+x3xT9jmB94ueRb/JpcSu+XrxdLCF
 ALaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b+g6kPIG/jwFitPzoitjd4fSzc6P/hya8rywnHeMN/8=;
 b=bP8Sa8Ww8Aoz8pV5csLbM1rLyzHdeJi3cbI0i3WME2vTdbu8keqEjWeLauLenSnUw9
 MwqUzHAugV5HTWKaBL8FVMJH1U55edKZyVoUq3DVO4fGc2gxy4Vzj3TnEErZHysU1Iqp
 b0TYP0MG97NQr1p6oiDyFiGbkjUdC2rSVhaexbSbwlR6BtlPGSbT2/8m1TDh+kp/UIk9
 3J+QlHHfrQSjL2cyofsxoPmftTf2lwuXz3tLLbzoy7RDqU9bUH49xMHeky7nC/j2S0Cw
 21cWDtulssWh9euX/oybG6CyVNOw2kRNHI/22LoWZejfn4UUTVuL9wEKYYGTbx7fkSvW
 ertg==
X-Gm-Message-State: AOAM533WAk2ZjPhsU6l86VeDn+k25LIU3ty0VKq7CYgBAw0o3/OD5mBY
 91iWPF79punc8Fgp8ZzMgNE=
X-Google-Smtp-Source: ABdhPJyldMxvnEBh7c5nmTQttLQPp8mr5BNjSHH3pinXqHmSCm2R9IbveYuxti7c4ebHxEhEJg5Pcg==
X-Received: by 2002:a05:620a:cf4:: with SMTP id
 c20mr22555044qkj.134.1616975787315; 
 Sun, 28 Mar 2021 16:56:27 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:26 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 06/30] idma64.c: Fix couple of typos
Date: Mon, 29 Mar 2021 05:23:02 +0530
Message-Id: <0e722d154cb5b29d8bad59481e74fc4853ee930e.1616971780.git.unixbhaskar@gmail.com>
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

s/transfered/transferred/  ...two different places

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/idma64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index f4c07ad3be15..3d0d48b12e28 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -282,7 +282,7 @@ static void idma64_desc_fill(struct idma64_chan *idma64c,
 		desc->length += hw->len;
 	} while (i);

-	/* Trigger an interrupt after the last block is transfered */
+	/* Trigger an interrupt after the last block is transferred */
 	lli->ctllo |= IDMA64C_CTLL_INT_EN;

 	/* Disable LLP transfer in the last block */
@@ -356,7 +356,7 @@ static size_t idma64_active_desc_size(struct idma64_chan *idma64c)
 	if (!i)
 		return bytes;

-	/* The current chunk is not fully transfered yet */
+	/* The current chunk is not fully transferred yet */
 	bytes += desc->hw[--i].len;

 	return bytes - IDMA64C_CTLH_BLOCK_TS(ctlhi);
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
