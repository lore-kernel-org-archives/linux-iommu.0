Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16038C433E3
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 12:02:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC85C20760
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 12:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHV4KnYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC85C20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9140320337;
	Thu, 16 Jul 2020 12:02:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N8bqUAQszhtT; Thu, 16 Jul 2020 12:02:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5C6E622270;
	Thu, 16 Jul 2020 12:02:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3954EC0893;
	Thu, 16 Jul 2020 12:02:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71E05C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 12:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 57F4122270
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 12:02:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lp9eWFOww6GG for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 12:02:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 76F4622735
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 12:02:08 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 103B820760;
 Thu, 16 Jul 2020 12:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594900928;
 bh=7Iqze3aCKTzGVZ3weRCFFcPpfvMEeMQ6YLx2H6XwexA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GHV4KnYsXxST+2z6LAqo10KTo00UVUVTgIiq9sBwY3Uho5g5NGlcbdJcI6TjYZvYb
 rI5dEhHh3U+SQcsxC7NecKQ34qblRCi7T6fXXsTq19Zb2P+3V2AZgv0z9Zk33DC3LI
 vUVjHrZwTvFC4TrJVLKNynFaXN2SxkT8kGyMHfV4=
Date: Thu, 16 Jul 2020 13:02:03 +0100
From: Will Deacon <will@kernel.org>
To: robh+dt@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 Tomasz Nowicki <tn@semihalf.com>, hannah@marvell.com,
 gregory.clement@bootlin.com
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
Message-ID: <20200716120202.GA7485@willie-the-truck>
References: <20200715070649.18733-1-tn@semihalf.com>
 <159488817559.3788855.4350396507732052751.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <159488817559.3788855.4350396507732052751.b4-ty@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com, kernel-team@android.com,
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

On Thu, Jul 16, 2020 at 01:00:43PM +0100, Will Deacon wrote:
> On Wed, 15 Jul 2020 09:06:45 +0200, Tomasz Nowicki wrote:
> > The series is meant to support SMMU for AP806 and a workaround
> > for accessing ARM SMMU 64bit registers is the gist of it.
> > 
> > For the record, AP-806 can't access SMMU registers with 64bit width.
> > This patches split the readq/writeq into two 32bit accesses instead
> > and update DT bindings.
> > 
> > [...]
> 
> Applied to will (for-joerg/arm-smmu/updates), thanks!
> 
> [1/3] iommu/arm-smmu: Call configuration impl hook before consuming features
>       https://git.kernel.org/will/c/6a79a5a3842b
> [2/3] iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #582743
>       https://git.kernel.org/will/c/f2d9848aeb9f
> [3/3] dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806 SMMU-500
>       https://git.kernel.org/will/c/e85e84d19b9d

(note that I left patch 4 for arm-soc, as that's just updating .dts files)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
