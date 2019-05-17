Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FBEC46470
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 01:00:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50557206BF
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 01:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dQMpvlg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50557206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B02DEB43;
	Fri, 17 May 2019 01:00:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 732F3B2F
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 01:00:26 +0000 (UTC)
X-Greylist: delayed 00:06:54 by SQLgrey-1.7.6
Received: from prod-mx.aristanetworks.com (mx.aristanetworks.com
	[162.210.129.12])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A3FFC710
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 01:00:24 +0000 (UTC)
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
	by prod-mx.aristanetworks.com (Postfix) with ESMTP id 0883241CAC2;
	Thu, 16 May 2019 17:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1558054431;
	bh=Ur8IpLq8gF2to3WfM7YOfN36My26fjgqB6sAL0vxTRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dQMpvlg5uCPVYtQeo2HxgUYHaVALw7Q7kJIUCv21j7o7nMhoxj5YRhfNGRmZWTK0b
	eUpZhTl6jHNYju8TWV8OmjhFKZGSsznKNRpDGSSssYoqfRuKa6Dzwe9IH7EsoLBXKB
	9KEpk9beM6D3sw262x15L9LMF4lgpXmHqG5dPg6yChbIAlSDyTuJXNolenrtDpi1ut
	RlgMlChMllvAhW3Ig7Fe3nVhRm6ia6/7HAN413A34NaSYOMKyQkTloR8NaP/sssJrG
	fHUX40b1XSJ38ZHoTIyIku+oAmSC373eZoKriZCEuQAegm5grXpeUWSbqfqWFAftD3
	9anCpcbXcOPPg==
Received: from chmeee (unknown [10.95.92.211])
	by prod-mx.aristanetworks.com (Postfix) with ESMTP id F1DD341CAC1;
	Thu, 16 May 2019 17:53:50 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
	(envelope-from <kevmitch@chmeee>)
	id 1hRR7r-000203-Ll; Thu, 16 May 2019 17:53:31 -0700
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/3] iommu/amd: move gart fallback to amd_iommu_init
Date: Thu, 16 May 2019 17:52:41 -0700
Message-Id: <20190517005242.20257-3-kevmitch@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517005242.20257-1-kevmitch@arista.com>
References: <20190517005242.20257-1-kevmitch@arista.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
From: Kevin Mitchell via iommu <iommu@lists.linux-foundation.org>
Reply-To: Kevin Mitchell <kevmitch@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The fallback to the GART driver in the case amd_iommu doesn't work was
executed in a function called free_iommu_resources, which didn't really
make sense. This was even being called twice if amd_iommu=off was
specified on the command line.

The only complication is that it needs to be verified that amd_iommu has
fully relinquished control by calling free_iommu_resources and emptying
the amd_iommu_list.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 drivers/iommu/amd_iommu_init.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 3798d7303c99..5f3df5ae6ba8 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2345,15 +2345,6 @@ static void __init free_iommu_resources(void)
 	amd_iommu_dev_table = NULL;
 
 	free_iommu_all();
-
-#ifdef CONFIG_GART_IOMMU
-	/*
-	 * We failed to initialize the AMD IOMMU - try fallback to GART
-	 * if possible.
-	 */
-	gart_iommu_init();
-
-#endif
 }
 
 /* SB IOAPIC is always on this device in AMD systems */
@@ -2774,6 +2765,16 @@ static int __init amd_iommu_init(void)
 		}
 	}
 
+#ifdef CONFIG_GART_IOMMU
+	if (ret && list_empty(&amd_iommu_list)) {
+		/*
+		 * We failed to initialize the AMD IOMMU - try fallback
+		 * to GART if possible.
+		 */
+		gart_iommu_init();
+	}
+#endif
+
 	for_each_iommu(iommu)
 		amd_iommu_debugfs_setup(iommu);
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
