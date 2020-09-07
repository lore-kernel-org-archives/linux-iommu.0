Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E29C433E2
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 16:06:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39012145D
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 16:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDL9drJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39012145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2CC5F2151F;
	Mon,  7 Sep 2020 16:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rmX5i38cPDg6; Mon,  7 Sep 2020 16:05:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D12EB21519;
	Mon,  7 Sep 2020 16:05:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A824EC0052;
	Mon,  7 Sep 2020 16:05:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8530EC0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 16:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7F85485E99
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 16:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K05e7V1jPj4z for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 16:05:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1F98485A96
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 620D621556;
 Mon,  7 Sep 2020 16:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599494757;
 bh=b1c3/5vixoTN8qQUUEqsJnN0P1lI4upW6sd1VV9JiEQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TDL9drJO2D5KHZ1D0/9PR3WTCMvf3wwt4ctNx4sj3sSMIm8Z+GVMzICPu0eXTDzL+
 Hepr24Lpuz7X5u4mtBO2Ugd1XtoNgWrQ4fXoZ0xK8Ele5dWDAe2H9MbiujFtDFZcn/
 CwJqT8jjg2DNvEZh8CKL1Y2yd+ysqH4EG/CJZJ7w=
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v5 0/3] iommu/arm-smmu-v3: permit users to disable msi
 polling
Date: Mon,  7 Sep 2020 17:05:36 +0100
Message-Id: <159948463819.582597.2124631770380758600.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827092957.22500-1-song.bao.hua@hisilicon.com>
References: <20200827092957.22500-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, kernel-team@android.com, robin.murphy@arm.com,
 Will Deacon <will@kernel.org>
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

On Thu, 27 Aug 2020 21:29:54 +1200, Barry Song wrote:
> patch 1/3 and patch 2/3 are the preparation of patch 3/3 which permits users
> to disable MSI-based polling by cmd line.
> 
> -v5:
>   add Robin's reviewed-by
> 
> -v4:
>   with respect to Robin's comments
>   * cleanup the code of the existing module parameter disable_bypass
>   * add ARM_SMMU_OPT_MSIPOLL flag. on the other hand, we only need to check
>     a bit in options rather than two bits in features
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/3] iommu/arm-smmu-v3: replace symbolic permissions by octal permissions for module parameter
      https://git.kernel.org/will/c/fea9ae18cf77
[2/3] iommu/arm-smmu-v3: replace module_param_named by module_param for disable_bypass
      https://git.kernel.org/will/c/9305d02adcc1
[3/3] iommu/arm-smmu-v3: permit users to disable msi polling
      https://git.kernel.org/will/c/bd07a20a38b6

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
