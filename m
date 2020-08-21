Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F60AC433E1
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 16:11:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A8AE207DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 16:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yrHjjTtz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8AE207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3062A86BB2;
	Fri, 21 Aug 2020 16:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ucTNv1Bi1eQZ; Fri, 21 Aug 2020 16:11:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 20B9286B9A;
	Fri, 21 Aug 2020 16:11:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05044C07FF;
	Fri, 21 Aug 2020 16:11:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AC23C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 16:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 54A9886B9E
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 16:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPjqCcEEhiag for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 16:11:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EA18C86B9A
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 16:11:06 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AEF24207BB;
 Fri, 21 Aug 2020 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598026266;
 bh=KoJWYj9R3egfhrmAUtzdmQ4aHcirpe1luSVDllQR65M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yrHjjTtz8bmAAarxqFRyCKp+eUzDy45aPAVgTpRquqvqFnM2Q3B/KMmajkF5M6yRP
 JyG3hI6KbQmfq//EsQ6UFchVq138yTLtw8f6zx0ArEmlIXMNHfioz5ksl7E4tQk5La
 UeC/R4IRIiGU3nWuuLWAUqlvju6DQl64nMKyW+is=
Date: Fri, 21 Aug 2020 17:11:01 +0100
From: Will Deacon <will@kernel.org>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update QUALCOMM IOMMU after Arm SSMU
 drivers move
Message-ID: <20200821161101.GF21517@willie-the-truck>
References: <20200802065320.7470-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200802065320.7470-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, linux-arm-msm@vger.kernel.org,
 Joe Perches <joe@perches.com>,
 Pia Eichinger <pia.eichinger@st.oth-regensburg.de>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org
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

On Sun, Aug 02, 2020 at 08:53:20AM +0200, Lukas Bulwahn wrote:
> Commit e86d1aa8b60f ("iommu/arm-smmu: Move Arm SMMU drivers into their own
> subdirectory") moved drivers/iommu/qcom_iommu.c to
> drivers/iommu/arm/arm-smmu/qcom_iommu.c amongst other moves, adjusted some
> sections in MAINTAINERS, but missed adjusting the QUALCOMM IOMMU section.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches    F:    drivers/iommu/qcom_iommu.c
> 
> Update the file entry in MAINTAINERS to the new location.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Will, please ack.

Typo in subject: s/SSMU/SMMU/

With that:

Acked-by: Will Deacon <will@kernel.org>

> Joerg, please pick this minor non-urgent patch for your -next branch.

Joerg -- can you queue this as a fix for 5.9-rc, please?

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
