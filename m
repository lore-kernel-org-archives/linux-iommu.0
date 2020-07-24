Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED13C433E8
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 12:34:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DCB2074B
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 12:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DCB2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B7C5522CB0;
	Fri, 24 Jul 2020 12:34:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q6YyG4EbPHlx; Fri, 24 Jul 2020 12:34:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0D25720347;
	Fri, 24 Jul 2020 12:34:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6CCFC004E;
	Fri, 24 Jul 2020 12:34:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDAB1C004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 12:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9F1168880C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 12:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gA7rVF3AVosg for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 12:34:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 551BA88809
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 12:34:24 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B18DF7DD; Fri, 24 Jul 2020 14:34:21 +0200 (CEST)
Date: Fri, 24 Jul 2020 14:34:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Skip TE disabling on quirky gfx
 dedicated iommu
Message-ID: <20200724123420.GU27672@8bytes.org>
References: <20200723013437.2268-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200723013437.2268-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Koba Ko <koba.ko@canonical.com>, Jun Miao <jun.miao@windriver.com>
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

On Thu, Jul 23, 2020 at 09:34:37AM +0800, Lu Baolu wrote:
> The VT-d spec requires (10.4.4 Global Command Register, TE field) that:
> 
> Hardware implementations supporting DMA draining must drain any in-flight
> DMA read/write requests queued within the Root-Complex before completing
> the translation enable command and reflecting the status of the command
> through the TES field in the Global Status register.
> 
> Unfortunately, some integrated graphic devices fail to do so after some
> kind of power state transition. As the result, the system might stuck in
> iommu_disable_translation(), waiting for the completion of TE transition.
> 
> This provides a quirk list for those devices and skips TE disabling if
> the qurik hits.
> 
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=208363
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=206571
> Tested-by: Koba Ko <koba.ko@canonical.com>
> Tested-by: Jun Miao <jun.miao@windriver.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Applied for v5.9, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
