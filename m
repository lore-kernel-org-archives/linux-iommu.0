Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1505CC433E3
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 12:30:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE13C2065F
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 12:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE13C2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 97E0C21561;
	Fri, 24 Jul 2020 12:30:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0YhJxXpEnRYQ; Fri, 24 Jul 2020 12:30:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 78F8A2010B;
	Fri, 24 Jul 2020 12:30:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 488A8C004E;
	Fri, 24 Jul 2020 12:30:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EEBCC004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 12:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DB3B1203C8
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 12:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sBDOb1kZC31p for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 12:30:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 784042010B
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 12:30:33 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 88ADF46A; Fri, 24 Jul 2020 14:30:31 +0200 (CEST)
Date: Fri, 24 Jul 2020 14:30:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] iommu: Add gfp parameter to io_pgtable_ops->map()
Message-ID: <20200724123030.GT27672@8bytes.org>
References: <cover.1591930156.git.baolin.wang@linux.alibaba.com>
 <3093df4cb95497aaf713fca623ce4ecebb197c2e.1591930156.git.baolin.wang@linux.alibaba.com>
 <20200714082821.GC4516@willie-the-truck>
 <20200723113652.GA104096@VM20190228-100.tbsite.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200723113652.GA104096@VM20190228-100.tbsite.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, tomeu.vizoso@collabora.com,
 airlied@linux.ie, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 baolin.wang7@gmail.com, agross@kernel.org, linux-mediatek@lists.infradead.org,
 alyssa.rosenzweig@collabora.com, daniel@ffwll.ch,
 linux-arm-msm@vger.kernel.org, matthias.bgg@gmail.com, steven.price@arm.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Thu, Jul 23, 2020 at 07:36:52PM +0800, Baolin Wang wrote:
> Thanks Will. Joerg, could you apply this 2 patches if no objection from
> your side? Thanks.

Applied both, thanks. Modified the first patch because another patch
already made __iommu_map static.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
