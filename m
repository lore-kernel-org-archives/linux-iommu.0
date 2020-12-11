Return-Path: <SRS0=kesm=FP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CF8C433FE
	for <iommu@archiver.kernel.org>; Fri, 11 Dec 2020 13:11:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570DC23EF4
	for <iommu@archiver.kernel.org>; Fri, 11 Dec 2020 13:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570DC23EF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E31DD873C8;
	Fri, 11 Dec 2020 13:11:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gfnNzEbuqCVf; Fri, 11 Dec 2020 13:11:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 31718873B8;
	Fri, 11 Dec 2020 13:11:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B964C0893;
	Fri, 11 Dec 2020 13:11:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B37DEC013B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Dec 2020 13:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AF5A186302
 for <iommu@lists.linux-foundation.org>; Fri, 11 Dec 2020 13:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OjWG4vTV-4HN for <iommu@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 13:11:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 93A2986199
 for <iommu@lists.linux-foundation.org>; Fri, 11 Dec 2020 13:11:05 +0000 (UTC)
From: Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Add sanity check for interrupt remapping table
 length macros
Date: Fri, 11 Dec 2020 13:10:59 +0000
Message-Id: <160769084268.2390072.5659488750209026923.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201210162436.126321-1-suravee.suthikulpanit@amd.com>
References: <20201210162436.126321-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, Jon.Grimm@amd.com, kernel-team@android.com,
 Will Deacon <will@kernel.org>, thomas.lendacky@amd.com
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

On Thu, 10 Dec 2020 10:24:36 -0600, Suravee Suthikulpanit wrote:
> Currently, macros related to the interrupt remapping table length are
> defined separately. This has resulted in an oversight in which one of
> the macros were missed when changing the length. To prevent this,
> redefine the macros to add built-in sanity check.
> 
> Also, rename macros to use the name of the DTE[IntTabLen] field as
> specified in the AMD IOMMU specification. There is no functional change.

Applied to arm64 (for-next/iommu/core), thanks!

[1/1] iommu/amd: Add sanity check for interrupt remapping table length macros
      https://git.kernel.org/arm64/c/5ae9a046a452

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
