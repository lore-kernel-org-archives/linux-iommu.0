Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA05C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 23:04:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D436C20849
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 23:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm+hqdIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D436C20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BA0B88671C;
	Mon, 18 May 2020 23:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fQD6Fa43TQ4i; Mon, 18 May 2020 23:04:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8698F86610;
	Mon, 18 May 2020 23:04:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76069C0881;
	Mon, 18 May 2020 23:04:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C2AEC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 23:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 08EA38888C
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 23:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id su6kZqLvOfxk for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 23:04:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8B7F088889
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 23:04:25 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D6EFA207ED;
 Mon, 18 May 2020 23:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589843065;
 bh=bitmyTr9R/oGSnaoA06CaiabbOP6nniUf9dbxg7nIgc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rm+hqdIEk+57bdOzbpbAwxmoNUH53eOvFcjC/BhxDfUMOAa28P15GZ9A3IA7uWthQ
 AGiK1xGsizoRHeV44aGcUonMII2B2Kvo3x6xbVNn5u4wNGsi2EqTMkhE5rgdQjeal0
 q45OTpjA9/jwcQMb003DJJm0zFT3htnvxclTfipk=
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Don't reserve implementation
 defined register space
Date: Tue, 19 May 2020 00:04:07 +0100
Message-Id: <158981256141.239287.4383286244395481954.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513110255.597203-1-jean-philippe@linaro.org>
References: <20200513110255.597203-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, robin.murphy@arm.com,
 tuanphan@amperemail.onmicrosoft.com, Will Deacon <will@kernel.org>
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

On Wed, 13 May 2020 13:02:57 +0200, Jean-Philippe Brucker wrote:
> Some SMMUv3 implementation embed the Perf Monitor Group Registers (PMCG)
> inside the first 64kB region of the SMMU. Since PMCG are managed by a
> separate driver, this layout causes resource reservation conflicts
> during boot.
> 
> To avoid this conflict, don't reserve the MMIO regions that are
> implementation defined. Although devm_ioremap_resource() still works on
> full pages under the hood, this way we benefit from resource conflict
> checks.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Don't reserve implementation defined register space
      https://git.kernel.org/will/c/52f3fab0067d

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
