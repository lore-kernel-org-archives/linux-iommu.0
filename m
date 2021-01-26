Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AABC433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 11:53:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD172311C
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 11:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD172311C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F3C178701A;
	Tue, 26 Jan 2021 11:53:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a8f+avtD3tZe; Tue, 26 Jan 2021 11:53:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3F62D87004;
	Tue, 26 Jan 2021 11:53:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09100C08A1;
	Tue, 26 Jan 2021 11:53:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1200C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 11:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A4B59203BB
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 11:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1pCXxmPqWt9W for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 11:53:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 1DC6120396
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 11:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611662027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc; bh=tf6SOP1+uSuFzlR74PmLs+Qb9Jg6cZLWh14S6+CIZes=;
 b=MhkV411IRAlYwWWABWXrSaKKYvTCqAsKHZjXfEB7WWPrWljBWI4AFJhu4VES4w5UxHZCCQ
 eWlM9XvZyTjpkRbGGGZ0plB/N7q8q5jaTpVk8dpgYpoOdhUWli5cIDaEgFkBDUoUcYZoZV
 mds9aMP5+whLl9ktPQDB2u9U7bwjsrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-GJ2V3kJMNZOg9DuCyXGLxQ-1; Tue, 26 Jan 2021 06:53:46 -0500
X-MC-Unique: GJ2V3kJMNZOg9DuCyXGLxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A71C5180A096;
 Tue, 26 Jan 2021 11:53:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-72.pek2.redhat.com
 [10.72.12.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7095710016F7;
 Tue, 26 Jan 2021 11:53:40 +0000 (UTC)
From: Lianbo Jiang <lijiang@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iommu: fix the failure of deferred attach for iommu
 attach device
Date: Tue, 26 Jan 2021 19:53:35 +0800
Message-Id: <20210126115337.20068-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: thomas.lendacky@amd.com, will@kernel.org, hch@infradead.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

Changes since v2:
[1] remove the underscores for the variable "__deferred_attach", and change
its name to iommu_deferred_attach_enabled [Suggested by Christoph Hellwig]
[2] remove the "do_" from the iommu_do_deferred_attach(), and change its
name to iommu_deferred_attach()
[3] remove the "extern" from the definition of iommu_deferred_attach() in
include/linux/iommu.h

Lianbo Jiang (2):
  dma-iommu: use static-key to minimize the impact in the fast-path
  iommu: use the __iommu_attach_device() directly for deferred attach

 drivers/iommu/dma-iommu.c | 29 +++++++++++------------------
 drivers/iommu/iommu.c     | 10 ++++++++++
 include/linux/iommu.h     |  1 +
 3 files changed, 22 insertions(+), 18 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
