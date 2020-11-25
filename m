Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C9EC5519F
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 14:05:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626C7206E5
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 14:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVnOunIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626C7206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 005F42E0BD;
	Wed, 25 Nov 2020 14:05:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z400O+wR0M91; Wed, 25 Nov 2020 14:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5E5F72E0EA;
	Wed, 25 Nov 2020 14:05:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4888FC0891;
	Wed, 25 Nov 2020 14:05:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A71EDC0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 14:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 92DDA86D2C
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 14:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4sqFAV2JtT0V for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 14:05:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2E98C86D24
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 14:05:29 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EE7B620684;
 Wed, 25 Nov 2020 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606313128;
 bh=nQ5hup1fwwMSQrELeFpnjHs2tiNhQ+aN5OpbuL8bPIA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AVnOunIj2kQNdkIW6L3SbrZ+v0kGNwsoPv2GtVlUXyyzlXJP4jdFboN8acLulnAso
 s5DujBJ9qKxE5XqV6zIxB57UyG/FWo2oUZiem3aIptBf3T/7ZNbxNceF0fzJm+mMC3
 ud+nxxBIQ9wQgOPF4/7pUDB3GZmV0/kjFtaFWd6k=
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v10 0/4] iommu: Add support to change default domain of an
 iommu group
Date: Wed, 25 Nov 2020 14:05:16 +0000
Message-Id: <160630647396.4097517.6548182516752300652.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124130604.2912899-1-baolu.lu@linux.intel.com>
References: <20201124130604.2912899-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel-team@android.com,
 Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
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

On Tue, 24 Nov 2020 21:06:00 +0800, Lu Baolu wrote:
> The last post of this series:
> 
> https://lore.kernel.org/linux-iommu/20201121135620.3496419-1-baolu.lu@linux.intel.com/
> 
> Change log in this series:
>  1. Changes according to comments at
>     https://lore.kernel.org/linux-iommu/20201123120449.GB10233@willie-the-truck/
>     - Remove the unnecessary iommu_get_mandatory_def_domain_type()
> 
> [...]

Applied to arm64 (for-next/iommu/default-domains), thanks!

[1/4] iommu: Move def_domain type check for untrusted device into core
      https://git.kernel.org/arm64/c/28b41e2c6aeb
[2/4] iommu: Add support to change default domain of an iommu group
      https://git.kernel.org/arm64/c/08a27c1c3ecf
[3/4] iommu: Take lock before reading iommu group default domain type
      https://git.kernel.org/arm64/c/0b8a96a3120f
[4/4] iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file
      https://git.kernel.org/arm64/c/63a816749d86

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
