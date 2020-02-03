Return-Path: <SRS0=8Bah=3X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA6C33CAC
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 10:58:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7194C20658
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 10:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="UOVYXCRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7194C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 760B0204A5;
	Mon,  3 Feb 2020 10:58:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UtPPdy6CLu41; Mon,  3 Feb 2020 10:58:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6FFAC2041C;
	Mon,  3 Feb 2020 10:58:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50D80C1D81;
	Mon,  3 Feb 2020 10:58:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3CD2C0174
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 09:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AF33484D16
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 09:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TlAoA1YK2oIX for <iommu@lists.linux-foundation.org>;
 Mon,  3 Feb 2020 09:39:33 +0000 (UTC)
X-Greylist: delayed 00:21:19 by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EADC284B8B
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 09:39:32 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id c16so14138184oic.3
 for <iommu@lists.linux-foundation.org>; Mon, 03 Feb 2020 01:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GdnNdnWJaDcUVCq0geRe2WaQj8c2WK+3ArcS2rroge4=;
 b=UOVYXCRF/dwVfkMz296E3J0RLNs+wrhtscM2WLQx4lk6yMElzwISgevk4+XQKZ+y6V
 qQ8jwMV/J9mo7H+NecThRw9nqL6wv1hnjBNkQfhHYEiNxIUSZ5yoDFoBryoz5XFsdOhp
 HMbIqXCzYjtJcfTQbl0LjPXzigxCuwm21l5fcM5hLp/SbPgWTvxOOEVB9QTaFcrp/xkQ
 u7n9rcJ4WwXaVTVV0hwbnl98dUm74f5xpMd/wRZ5xxdbtpOQd2gA2olp5x13GO70OtvK
 0LBOuia+qGKcu7BbsFIZnOHjxzZC4uCqprY7HEZUi0Uh49tmuKy1irn0U9luirZIW59x
 IPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GdnNdnWJaDcUVCq0geRe2WaQj8c2WK+3ArcS2rroge4=;
 b=VP5f7RYIrPiuxjMznU9q/FlyLUpH/HggwIlsayEdcrBnuGxwTpTRht+D792faf53YM
 G77G71AImvzSWE0C7cDHVk4GNtInis4ADEuXQhANI2W3EbciWLyN9n/7Wb2eZ+oCgOEq
 hAFl52lV5kJ2ysDGG+oQEZMZTnjNm0bqododoqXU5+PvvCHpXiHgosbO5Konb5uM44tf
 mGx74trCFb8zUp+ys9xdU23PaRdg8fm2QF97alxdMi4lNBFsPgvLu+W+CNpEc1hDmr/k
 2H/aGvozwHlWCAa68CkxJLYGJexUHWbvI/KMyJdGcKoZnlW/RrUZA1xEtPAjutLgMWr6
 PgSA==
X-Gm-Message-State: APjAAAVK2tXpqeA0h1p835aKOh78x7ILaatyJJ3JWvKBaHHjCTQqJVN1
 m/LvhrhpemLsrRAFjx+GW7fXdqXn9kO42g==
X-Google-Smtp-Source: APXvYqwvYee9a5uw5VUUf+RdsWW8I+Awo/lkJG9Is5/tHstxlBEp+lghT9F7sKZzDVA6ixGfnzHjJw==
X-Received: by 2002:a17:90a:8a8f:: with SMTP id
 x15mr28788646pjn.87.1580721036957; 
 Mon, 03 Feb 2020 01:10:36 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
 by smtp.googlemail.com with ESMTPSA id y64sm14300390pgb.25.2020.02.03.01.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:10:36 -0800 (PST)
From: Jian-Hong Pan <jian-hong@endlessm.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no IOMMU
Date: Mon,  3 Feb 2020 17:10:10 +0800
Message-Id: <20200203091009.196658-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 03 Feb 2020 10:58:01 +0000
Cc: Jian-Hong Pan <jian-hong@endlessm.com>, iommu@lists.linux-foundation.org,
 linux@endlessm.com, linux-kernel@vger.kernel.org
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

If the device has no IOMMU, it still invokes iommu_need_mapping during
intel_alloc_coherent. However, iommu_need_mapping can only check the
device is DUMMY_DEVICE_DOMAIN_INFO or not. This patch marks the device
is a DUMMY_DEVICE_DOMAIN_INFO if the device has no IOMMU.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/iommu/intel-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 35a4a3abedc6..878bc986a015 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5612,8 +5612,10 @@ static int intel_iommu_add_device(struct device *dev)
 	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
+	if (!iommu) {
+		dev->archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;
 		return -ENODEV;
+	}
 
 	iommu_device_link(&iommu->iommu, dev);
 
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
