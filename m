Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFCEC433DB
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 11:16:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA182063A
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 11:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA182063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 83CF986742;
	Tue, 19 Jan 2021 11:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B09jrPk5PQxr; Tue, 19 Jan 2021 11:16:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A78B866F1;
	Tue, 19 Jan 2021 11:16:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14435C088B;
	Tue, 19 Jan 2021 11:16:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F898C013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 11:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7D637866F1
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 11:16:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d+drWVfwvauF for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 11:16:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C29B6860A3
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 11:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611054986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc; bh=prchNfDbXNCFUPpFnz6BKtCHGpSZan3ogM0IdWmrA6A=;
 b=U465nRgB4u4OU/aHNvwOPLgZQbJyUnArxWy83Znlx49RrV2xhkqBcVAcR6WFZE1lscT4BM
 inSa2CbGgR9HTt0SkDQhtsHO0SqTaIhIL4Ko1MDUjspVZK1GgfYk/y+11D7KO9X/q6PaFI
 FD7YCE5M1PPfceUl0jVlt7H4sRfMImw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-XNmkh8scP7mYNZInh_xJjA-1; Tue, 19 Jan 2021 06:16:24 -0500
X-MC-Unique: XNmkh8scP7mYNZInh_xJjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70610802B45;
 Tue, 19 Jan 2021 11:16:23 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-117.pek2.redhat.com
 [10.72.12.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9ED0D36FA;
 Tue, 19 Jan 2021 11:16:19 +0000 (UTC)
From: Lianbo Jiang <lijiang@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2 v2] iommu: fix the failure of deferred attach for iommu
 attach device
Date: Tue, 19 Jan 2021 19:16:14 +0800
Message-Id: <20210119111616.12761-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: thomas.lendacky@amd.com, will@kernel.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com
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

This patchset is to fix the failure of deferred attach for iommu attach
device, it includes the following two patches:

[1] [PATCH 1/2] dma-iommu: use static-key to minimize the impact in the fast-path
    This is a prepared patch for the second one, move out the is_kdump_kernel()
    check from iommu_dma_deferred_attach() to iommu_dma_init(), and use the
    static-key in the fast-path to minimize the impact in the normal case.

[2] [PATCH 2/2] iommu: use the __iommu_attach_device() directly for deferred attach
    Move the handling currently in iommu_dma_deferred_attach() into the
    iommu core code so that it can call the __iommu_attach_device()
    directly instead of the iommu_attach_device(). The external interface
    iommu_attach_device() is not suitable for handling this situation.

Changes since v1:
[1] use the __iommu_attach_device() directly for deferred attach
[2] use static-key to minimize the impact in the fast-path

Lianbo Jiang (2):
  dma-iommu: use static-key to minimize the impact in the fast-path
  iommu: use the __iommu_attach_device() directly for deferred attach

 drivers/iommu/dma-iommu.c | 29 +++++++++++------------------
 drivers/iommu/iommu.c     | 12 ++++++++++++
 include/linux/iommu.h     |  2 ++
 3 files changed, 25 insertions(+), 18 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
