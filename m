Return-Path: <SRS0=ejku=BW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA10C433E0
	for <iommu@archiver.kernel.org>; Wed, 12 Aug 2020 15:16:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20969207F7
	for <iommu@archiver.kernel.org>; Wed, 12 Aug 2020 15:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20969207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E693286940;
	Wed, 12 Aug 2020 15:16:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ka3vHEeXo6Zx; Wed, 12 Aug 2020 15:16:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC6A286934;
	Wed, 12 Aug 2020 15:16:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1887C07FF;
	Wed, 12 Aug 2020 15:16:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3975C004D
 for <iommu@lists.linux-foundation.org>; Wed, 12 Aug 2020 15:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DCE1387C17
 for <iommu@lists.linux-foundation.org>; Wed, 12 Aug 2020 15:16:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vLDU-yHDG2jn for <iommu@lists.linux-foundation.org>;
 Wed, 12 Aug 2020 15:16:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3834787B32
 for <iommu@lists.linux-foundation.org>; Wed, 12 Aug 2020 15:16:13 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 6C0BF2C3; Wed, 12 Aug 2020 17:16:10 +0200 (CEST)
Date: Wed, 12 Aug 2020 17:16:09 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [PATCH 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
Message-ID: <20200812151608.GG3721@8bytes.org>
References: <1593785835-27250-1-git-send-email-vjitta@codeaurora.org>
 <1593785835-27250-2-git-send-email-vjitta@codeaurora.org>
 <29f44540-44f8-570d-886f-2090596a3b8e@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <29f44540-44f8-570d-886f-2090596a3b8e@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: vinmenon@codeaurora.org, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linux-kernel@vger.kernel.org
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

On Mon, Aug 03, 2020 at 03:30:48PM +0530, Vijayanand Jitta wrote:
> ping?

Please repost when v5.9-rc1 is released and add

	Robin Murphy <robin.murphy@arm.com>

on your Cc list.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
