Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4870C33CB1
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 10:51:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DE62187F
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 10:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjXa6TNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DE62187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 42302878B8;
	Wed, 15 Jan 2020 10:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7znykCfRhKZs; Wed, 15 Jan 2020 10:51:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 60E3887807;
	Wed, 15 Jan 2020 10:51:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 466AEC1D82;
	Wed, 15 Jan 2020 10:51:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 487F8C077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 10:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 36CE785DF5
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 10:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UwC5kNUTOs0j for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 10:29:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 20F1784EB0
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 10:29:24 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id i6so8332601pfc.1
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 02:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=GZGVdYkXGD9r067czQDmOYY3BF/KYHfnpdKqP6c88Yw=;
 b=qjXa6TNLOt2bFuYFYscXJ1rz8enYvfZy40A1erx6lIUX9znLX5dSdk0zUHlYSjwlkk
 tMGc4xCyzOkiulAc+BtbMCialYxXCH1KX35w6bkbpPvJV4i7DJ/emLUlQiMmdTw3GLO4
 N5JbokL+Pa+xg4o1Dn4bBe4emDX6Mfcl0ifAENfNilUA1QOyIAXI27rD5WU6TJGbN5Xz
 z6ld2Dz1m2kcHMAc8x2tmFGIXXQBXKJjtPs3DBFvrfIBrkvd4sxKqfkFfv+nY1gbybb7
 Em4eEuKA7lSAsOk3+D/7F37m/MpJpqep/ZBagMP9560jqOdKLNn08PptkM10rzdGBqDt
 aLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=GZGVdYkXGD9r067czQDmOYY3BF/KYHfnpdKqP6c88Yw=;
 b=lv2L1HL9WAehV8ODjm/aXXBv1Ke2aZA9A420SBwT0S5is1x7NxamOCB/qovODFFa6I
 bNe7h933pE0QXTjU4BbD2RgKH9vFvtn+s1tZkxXEV35lfyM3odgwYwmQfwt0hoFEPD1j
 mwGO/GAviI+kJlrXd2TCqC95kZRuTMhh/faCdET1A5V06c6DuCHJMumMc3c5a7qlGAgb
 GwoQ2Xo3lmrC1Fcq+rB2AoRiKBhgs4jniO4B+L1n4DEJH13ZTXzQfuz2Lw547UNWEvbc
 xleh7xkjb6baA/TUt3cXq8CWN7mxth3WvLpQHT7RBb2Fql83AzKv0hOqr8TBY4Ars+uc
 MvXw==
X-Gm-Message-State: APjAAAXuP1XDmxwlf+Egve543v6zw02v4IPa4eaRxxPwQ6jHuceJS2fc
 G6RfWqr4XBfIXQVwyiE9sZY=
X-Google-Smtp-Source: APXvYqxAGCVejC6y4jIVoWu+VamO/gU912z2pDTtkng8WCrC9bJX7/OY1aV8VWRLTazearIqQWww9A==
X-Received: by 2002:a63:134e:: with SMTP id 14mr32789780pgt.115.1579084163792; 
 Wed, 15 Jan 2020 02:29:23 -0800 (PST)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
 by smtp.gmail.com with ESMTPSA id 11sm21756342pfz.25.2020.01.15.02.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 02:29:23 -0800 (PST)
From: Zhenzhong Duan <zhenzhong.duan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: fix the wrong printing in RHSA parsing
Date: Wed, 15 Jan 2020 18:28:15 +0800
Message-Id: <20200115102815.264-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 15 Jan 2020 10:51:39 +0000
Cc: x86@kernel.org, iommu@lists.linux-foundation.org,
 Zhenzhong Duan <zhenzhong.duan@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
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

When base address in RHSA structure doesn't match base address in
each DRHD structure, the base address in last DRHD is printed out.

This doesn't make sense when there are multiple DRHD units, fix it
by printing the buggy RHSA's base address.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 3acfa6a..78bb03e 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -475,7 +475,7 @@ static int dmar_parse_one_rhsa(struct acpi_dmar_header *header, void *arg)
 		1, TAINT_FIRMWARE_WORKAROUND,
 		"Your BIOS is broken; RHSA refers to non-existent DMAR unit at %llx\n"
 		"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-		drhd->reg_base_addr,
+		rhsa->base_address,
 		dmi_get_system_info(DMI_BIOS_VENDOR),
 		dmi_get_system_info(DMI_BIOS_VERSION),
 		dmi_get_system_info(DMI_PRODUCT_VERSION));
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
