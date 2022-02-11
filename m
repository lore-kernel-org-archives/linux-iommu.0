Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12405C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 10:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FFDE81C04;
	Fri, 11 Feb 2022 10:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qReyIeMqSRMJ; Fri, 11 Feb 2022 10:24:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 672FB81A1C;
	Fri, 11 Feb 2022 10:24:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48431C001A;
	Fri, 11 Feb 2022 10:24:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3A02C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 10:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4880401FC
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 10:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=nxt.ru
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dMdB7lYS0BYE for <iommu@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 10:24:02 +0000 (UTC)
X-Greylist: delayed 00:05:16 by SQLgrey-1.8.0
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net
 [5.45.198.250])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A3A5401DF
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 10:24:02 +0000 (UTC)
Received: from myt6-de4b83149afa.qloud-c.yandex.net
 (myt6-de4b83149afa.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:401e:0:640:de4b:8314])
 by forward500j.mail.yandex.net (Yandex) with ESMTP id 7C1246CB6BA2;
 Fri, 11 Feb 2022 13:18:41 +0300 (MSK)
Received: from 2a02:6b8:c12:1723:0:640:c7c2:e344
 (2a02:6b8:c12:1723:0:640:c7c2:e344 [2a02:6b8:c12:1723:0:640:c7c2:e344])
 by myt6-de4b83149afa.qloud-c.yandex.net (mxback/Yandex) with HTTP id
 dIYhLv0cJCg1-Iec4T0gI; Fri, 11 Feb 2022 13:18:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxt.ru; s=mail;
 t=1644574720; bh=+QzWvPmQ9CrQg+9DVBPDGn2iMJvpYZnpZYUSGInu5DU=;
 h=References:Date:Message-Id:Cc:Subject:In-Reply-To:To:From;
 b=Awe4H7r7545QR/+EprGABpQbh5FZaCRNU9KDR/ioLqCYK/a1mLKNXi3jaQ3D5PN++
 z3fjCMFCboRoZ2yuZwBWPC5eFqS0a2yXksD8j9h8nxFKpbMwuQR1rV8HuChBo+UYci
 dSegY4N/LM9B7ol+wFKxSAllsbZM350uQp77JyPg=
Authentication-Results: myt6-de4b83149afa.qloud-c.yandex.net;
 dkim=pass header.i=@nxt.ru
Received: by myt5-c7c2e3441f25.qloud-c.yandex.net with HTTP;
 Fri, 11 Feb 2022 13:18:40 +0300
From: Aleksandr Fedorov <sanekf@nxt.ru>
To: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <b090141f-0822-609f-429d-ea790d7fc828@arm.com>
References: <5481021644415780@myt5-a5512e99e394.qloud-c.yandex.net>
 <b090141f-0822-609f-429d-ea790d7fc828@arm.com>
Subject: Re: [PATCH] iommu: explicitly check for NULL in
 iommu_dma_get_resv_regions()
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 11 Feb 2022 13:18:40 +0300
Message-Id: <10011281644574720@myt5-c7c2e3441f25.qloud-c.yandex.net>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
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

> On 2022-02-09 14:09, Aleksandr Fedorov wrote:
>> iommu_dma_get_resv_regions() assumes that iommu_fwspec field for
>> corresponding device is set which is not always true. Since
>> iommu_dma_get_resv_regions() seems to be a future-proof generic API
>> that can be used by any iommu driver, add an explicit check for NULL.
> 
> Except it's not a "generic" interface for drivers to call at random,
> it's a helper for retrieving common firmware-based information
> specifically for drivers already using the fwspec mechanism for common
> firmware bindings. If any driver calls this with a device *without* a
> valid fwnode, it deserves to crash because it's done something
> fundamentally wrong.
> 
> I concur that it's not exactly obvious that "non-IOMMU-specific" means
> "based on common firmware bindings, thus implying fwspec".

Thanks for the explanations, yes, this was the misunderstanding on my
part. Maybe add a comment?

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d85d54f2b549..ce5e7d4d054a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -379,6 +379,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
  * for general non-IOMMU-specific reservations. Currently, this covers GICv3
  * ITS region reservation on ACPI based ARM platforms that may require HW MSI
  * reservation.
+ *
+ * Note that this helper is meant to be used only by drivers that are already
+ * using the fwspec mechanism for common firmware bindings.
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
