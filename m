Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFACCC433F5
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 23:24:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26716831AE;
	Wed, 15 Dec 2021 23:24:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3c3i6IquKGpF; Wed, 15 Dec 2021 23:24:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0141583143;
	Wed, 15 Dec 2021 23:24:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8C95C001E;
	Wed, 15 Dec 2021 23:24:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BE44C0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 23:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23A7941699
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 23:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HcHbg1-XYNLk for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 23:24:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0DE6941696
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 23:24:34 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id a23so16782968pgm.4
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 15:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ayBO3fheqltGpQuWWy/ylkJKTwFSYRcjXfWCB08z91I=;
 b=jqteNayx6//raCiQTS4nAXfjev6anJEbYPoCILHayKrjHpgTJGAT2R1MELBRXXqoHB
 YpmZc0iNX4O1z50B684EvtfRqiYuQ+0WK56Y49DoxTrJliTE6tSkBl0HXXUStxYLr1LY
 PMEUdOHfdH5DC0fpHxdu0tHnDV89ly/jSI22w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ayBO3fheqltGpQuWWy/ylkJKTwFSYRcjXfWCB08z91I=;
 b=Ynhj9ceG5pk7Hhhie+sjw26Y1c42y6BK6AYfbahEmx+I1lCPGXJypr0+sKmwybmdCE
 mv6KwzihkWbtaKYhgzKlOjPrQS6lsovGWeJS+iH4D/bv1EvmbgAdnQaoQrq0OpOumbNX
 0xum0xl/8X+RBrgPLSsoUzHQtzhg54IgZ9+67NLlu7BpHX22c9oEZ4b9t6Z5YRLhzpVo
 uuB9Z6mk/knFZwbz6T1rpWDQcPGpWMIIdCtJS0h4RGCNkiEFcMiNjt+K5WLikBX/ZUYK
 JJrJ5WVCci6QwARyAZTwZI3DtcEU5mZcybj/KdHp1rwWCSIxYVHTliHNOp/faumXlhVG
 V2MQ==
X-Gm-Message-State: AOAM5323xrkSdug7jcqwH/iCSlgEF2f4xGJ0N3SDBpUtuz28MzGw9dAS
 uArlZ4s+GWIElwI/bJJY654w+Q==
X-Google-Smtp-Source: ABdhPJwrZkD0iKdINA4QR7VSHJa604alVBLeOr1zMA+cOIjJtV0eFPZKqX9zwyo/2NvOHdJ9J0GPYQ==
X-Received: by 2002:a65:4889:: with SMTP id n9mr9635992pgs.303.1639610674215; 
 Wed, 15 Dec 2021 15:24:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id z6sm4157129pjr.57.2021.12.15.15.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Dec 2021 15:24:33 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH] iommu: Use correctly sized arguments for bit field
Date: Wed, 15 Dec 2021 15:24:32 -0800
Message-Id: <20211215232432.2069605-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614; h=from:subject;
 bh=DHxJ43DwsvodL9fr243QH0FkW2/Hzca3VP7CBqjLMoI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhunkv1AK+0eSVn76RoUsVTovgFFDeNYkloZE8C4IZ
 Y+Eh7buJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbp5LwAKCRCJcvTf3G3AJv24D/
 wL8hOVWaupn+8pSw5h5luG10DqIeT1kD2UWy3//byDHbeVZsw/Kb8liFDJLwAxS/t1ElXINwmH0r9W
 jjdJhYm1/FxF2FIF4KORdBXP9NaUtVU3ce+Tdb9OFOUg6LMyU8BPdEBzzMhUrrgTYS8jjbBtJzTtv4
 qCUKzNby6lLTH4YMC+ClGdcpk7WySgsjuC71f5dvcVLuyoFLFOpbD6vqpxIcWtCElfE/sdKIVD08SS
 WwxrfVSWzTWwKe3LOU5Cc9szQBXZvqORZkTI/PlVDpWB5YNYTYjo538m0T0H6gci+Xz1bp8/qBWKIq
 xuNEb4PbJCWCYk6Zt/RFwAqF6uG70vCTppiJ3JTL3YpcsuX66gNgSEZhzuA2QMJfdXYqkJ7c1nlDGw
 6jx4eNMDfwZqR6Lcf239ftgHck7jbgjBYEmtm7MRdwj1mkc7V+QQaYRaElX0Wk65nIjJQ2a++urkCn
 t0Y386EjikhGtvRcL/Wo0b0DmhSyBs5j9TZ82oOE7GfvwEX0dcRnG0F4Gdb78Kyufa9j4osv8K9+NI
 8uTAlm00UChCMAZyqKxXHvFrmjlwpTPy60+q3ylWsuEkgTVSw5B1O0n+kMhmgdeEHEnXhnOiY3HTAk
 xvWz+OkATj9r1TGDfrSvJvhJFLiufZc6c9PPgdcyYVmD66B8j0aS6iUPW9Ag==
X-Developer-Key: i=keescook@chromium.org; a=openpgp;
 fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Cc: Kees Cook <keescook@chromium.org>, Yury Norov <yury.norov@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-hardening@vger.kernel.org,
 Will Deacon <will@kernel.org>
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

The find.h APIs are designed to be used only on unsigned long arguments.
This can technically result in a over-read, but it is harmless in this
case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
which we'd like to enable globally:

In file included from ./include/linux/bitmap.h:9,
                 from drivers/iommu/intel/iommu.c:17:
drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
./include/linux/find.h:119:37: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Warray-bounds]
  119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                     ^~~~~
drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
 2115 |         int pds, max_pde;
      |                  ^~~~~~~

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b6a8f3282411..99f9e8229384 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2112,10 +2112,10 @@ static void domain_exit(struct dmar_domain *domain)
  */
 static inline unsigned long context_get_sm_pds(struct pasid_table *table)
 {
-	int pds, max_pde;
+	unsigned long pds, max_pde;
 
 	max_pde = table->max_pasid >> PASID_PDE_SHIFT;
-	pds = find_first_bit((unsigned long *)&max_pde, MAX_NR_PASID_BITS);
+	pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
 	if (pds < 7)
 		return 0;
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
