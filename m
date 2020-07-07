Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559C2C433E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 02:01:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15DA206F6
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 02:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15DA206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AF172884D6;
	Tue,  7 Jul 2020 02:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id di-qUQ8l8LNv; Tue,  7 Jul 2020 02:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E7F6388471;
	Tue,  7 Jul 2020 02:01:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1884C0893;
	Tue,  7 Jul 2020 02:01:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30178C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 02:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1EE6E88E9B
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 02:01:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IchX94KsmR9U for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 02:01:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn
 [202.108.3.163])
 by whitealder.osuosl.org (Postfix) with SMTP id 8938988E97
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 02:01:07 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([221.219.171.29])
 by sina.com with ESMTP
 id 5F03D73B00025EFF; Tue, 7 Jul 2020 10:00:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 97444749284134
From: Hillf Danton <hdanton@sina.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [RFC PATCH] vfio: type1: fix kthread use case
Date: Tue,  7 Jul 2020 10:00:17 +0800
Message-Id: <20200707020017.1816-1-hdanton@sina.com>
In-Reply-To: <20200707003140.GA20022@joy-OptiPlex-7040>
References: <20200706104915.11460-1-hdanton@sina.com>
 <20200706124241.4392-1-hdanton@sina.com>
MIME-Version: 1.0
Cc: Hillf Danton <hdanton@sina.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Markus Elfring <Markus.Elfring@web.de>, Christoph Hellwig <hch@lst.de>
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


On Tue, 7 Jul 2020 08:31:41 +0800 Yan Zhao wrote:
>
> I think "current->mm == NULL" in itself implies kthread and not use_mm,
> as a user thread is not able to have "current->mm == NULL", right?

Nope, it's the fix target as checking the current mm does not make
sense without current being kthread.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
