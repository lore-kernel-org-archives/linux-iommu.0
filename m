Return-Path: <SRS0=bYB5=FF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DE1C64E7A
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 21:45:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4C8208DB
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 21:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDmejFDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4C8208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C38B48793F;
	Tue,  1 Dec 2020 21:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DNKFby6x1yse; Tue,  1 Dec 2020 21:45:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 91962879E5;
	Tue,  1 Dec 2020 21:45:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80E34C163C;
	Tue,  1 Dec 2020 21:45:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7938BC0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 21:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 551432E1D5
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 21:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8MuMxrDJa2ZI for <iommu@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 21:45:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 4028D2E1CC
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C277B2086A;
 Tue,  1 Dec 2020 21:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606859112;
 bh=igMPQDgWyk4OwUBpic5849I/GvbC4s/vhJKvmdqlYrk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JDmejFDMD/rtDxapX57p0nYlMv6KRDODRxhn/cQLkReBNsTnxtuL89r9ztwdXILT0
 WwI28A4U/Gw4oJJbRR0ZGWmN2D4jY50psn8XxB84lhuFskgJyfEbMiB/E7okPp7UKa
 7qFvnNYMsVTkWeRY8QMQpvrnstKBbXCtQPyYYhjo=
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, robin.murphy@arm.com
Subject: Re: [RESEND PATCH v3 0/4] iommu/iova: Solve longterm IOVA issue
Date: Tue,  1 Dec 2020 21:45:05 +0000
Message-Id: <160685669713.992935.17438167536143205811.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 xiyou.wangcong@gmail.com, kernel-team@android.com
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

On Tue, 17 Nov 2020 18:25:30 +0800, John Garry wrote:
> This series contains a patch to solve the longterm IOVA issue which
> leizhen originally tried to address at [0].
> 
> A sieved kernel log is at the following, showing periodic dumps of IOVA
> sizes, per CPU and per depot bin, per IOVA size granule:
> https://raw.githubusercontent.com/hisilicon/kernel-dev/topic-iommu-5.10-iova-debug-v3/aging_test
> 
> [...]

Applied the final patch to arm64 (for-next/iommu/iova), thanks!

[4/4] iommu: avoid taking iova_rbtree_lock twice
      https://git.kernel.org/arm64/c/3a651b3a27a1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
