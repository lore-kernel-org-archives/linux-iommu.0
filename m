Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB76BC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 18:09:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EDA461A2C
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 18:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDA461A2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E53A840F3E;
	Thu, 25 Mar 2021 18:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zdbZpCPrqDMO; Thu, 25 Mar 2021 18:09:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8352D40F23;
	Thu, 25 Mar 2021 18:09:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A3C2C000E;
	Thu, 25 Mar 2021 18:09:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7468FC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CB3840F2F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7-Hj36m8TtVS for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 18:09:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6CE0240F2D
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:09:37 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C74661A26;
 Thu, 25 Mar 2021 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616695775;
 bh=IK7RaZ38tGD05wufzzYh3po/BlI1i3qxmYoN/2G5xlw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d03GQxWjOKR/Hapbm4ncwQi/8OHaSBsGSa2lDmC6zPtc7zBDSWTYYAuAvroWSAIs3
 5okV+oLX+ErRAH6wTFdm4IHNsP3U4cHcfhApRTn4WZZO24+FVP0Hl85lGkDHhRcHkg
 p5AgpDJ3Ad0I78pmH15edRLP+zbYLcxcd8YrbeZ+iPk8zEOC71tQSFqszraM7lFi/e
 TWanVSyFnDVj4tGYLJuM+F80nEhtxeDjFKSBwVF8T8nI+FtIr4jV6lR2QFDcjdDpV6
 QDR6uzOn1PmMXcwRzWfdj7LpDrK9hGAN5OCvHKUB17Eb3IB2YNoVX4MYgDc202ULm9
 lcQlLEJC3jgNg==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>, Zhen Lei <thunder.leizhen@huawei.com>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: add bit field SFM into
 GERROR_ERR_MASK
Date: Thu, 25 Mar 2021 18:09:27 +0000
Message-Id: <161669343969.1653955.1039033291680251791.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210324081603.1074-1-thunder.leizhen@huawei.com>
References: <20210324081603.1074-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, kernel-team@android.com,
 Will Deacon <will@kernel.org>, Rui Zhu <zhurui3@huawei.com>
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

On Wed, 24 Mar 2021 16:16:03 +0800, Zhen Lei wrote:
> In arm_smmu_gerror_handler(), the value of the SMMU_GERROR register is
> filtered by GERROR_ERR_MASK. However, the GERROR_ERR_MASK does not contain
> the SFM bit. As a result, the subsequent error processing is not performed
> when only the SFM error occurs.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: add bit field SFM into GERROR_ERR_MASK
      https://git.kernel.org/will/c/655c447c97d7

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
