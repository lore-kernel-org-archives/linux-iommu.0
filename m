Return-Path: <SRS0=d63v=UZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FE7C4646B
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 03:41:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF8A2168B
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 03:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnSsdWGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF8A2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 16887D7F;
	Wed, 26 Jun 2019 03:41:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4FB40D88
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 03:41:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1335F82F
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 03:41:40 +0000 (UTC)
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net
	[107.77.172.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AC977214DA;
	Wed, 26 Jun 2019 03:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520499;
	bh=42DavxmMtdOChN4Oo9N6dOlybAxZJaVMXYFtZzoSW/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hnSsdWGT9jNveGAooIb4wdW5urd1OFoSu9ZwnEGyVNiyF8u+Sb291lOqI8C6qsNZl
	DW6VL17spALLCOiU4p34FMNvQyR/yYmdukvz0+H9fArof1jFd9zcEvyDJOI1xlY6vp
	7AVuFRwMaoyHRSRAdpPj9buX9hPa9OIEcaPxWQaE=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 10/51] iommu/vt-d: Set the right field for Page
	Walk Snoop
Date: Tue, 25 Jun 2019 23:40:26 -0400
Message-Id: <20190626034117.23247-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034117.23247-1-sashal@kernel.org>
References: <20190626034117.23247-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
	Joerg Roedel <jroedel@suse.de>, Dave Jiang <dave.jiang@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 66d78ad316b0e1ca5ae19663468554e2c0e31c26 ]

Set the page walk snoop to the right bit, otherwise the domain
id field will be overlapped.

Reported-by: Dave Jiang <dave.jiang@intel.com>
Fixes: 6f7db75e1c469 ("iommu/vt-d: Add second level page table interface")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 03b12d2ee213..fdf05c45d516 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -387,7 +387,7 @@ static inline void pasid_set_present(struct pasid_entry *pe)
  */
 static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
 {
-	pasid_set_bits(&pe->val[1], 1 << 23, value);
+	pasid_set_bits(&pe->val[1], 1 << 23, value << 23);
 }
 
 /*
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
