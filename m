Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B085C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 09:02:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0901A206C3
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 09:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0901A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BC2E422850;
	Mon,  1 Jun 2020 09:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h9YfFqT8z0z3; Mon,  1 Jun 2020 09:01:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 966E52156C;
	Mon,  1 Jun 2020 09:01:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74A39C088C;
	Mon,  1 Jun 2020 09:01:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F352C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 09:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 81C0D87A6E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 09:01:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Co4R0HmBXyQv for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 09:01:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.ispras.ru (winnie.ispras.ru [83.149.199.91])
 by hemlock.osuosl.org (Postfix) with ESMTP id E7BD487A56
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 09:01:52 +0000 (UTC)
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
 by smtp.ispras.ru (Postfix) with ESMTP id D9D7C203BF;
 Mon,  1 Jun 2020 12:01:48 +0300 (MSK)
Date: Mon, 1 Jun 2020 12:01:48 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
In-Reply-To: <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com>
Message-ID: <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru>
References: <20200529200738.1923-1-amonakov@ispras.ru>
 <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

On Mon, 1 Jun 2020, Suravee Suthikulpanit wrote:

> > Moving init_iommu_perf_ctr just after iommu_flush_all_caches resolves
> > the issue. This is the earliest point in amd_iommu_init_pci where the
> > call succeeds on my laptop.
> 
> According to your description, it should just need to be anywhere after the
> pci_enable_device() is called for the IOMMU device, isn't it? So, on your
> system, what if we just move the init_iommu_perf_ctr() here:

No, this doesn't work, as I already said in the paragraph you are responding
to. See my last sentence in the quoted part.

So the implication is init_device_table_dma together with subsequent cache
flush is also setting up something that is necessary for counters to be
writable.

Alexander
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
