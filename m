Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EE3C433E7
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 08:19:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D57F821841
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 08:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwN9vIxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57F821841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B0DC888F74;
	Tue, 14 Jul 2020 08:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mCb4AXD8Iv9w; Tue, 14 Jul 2020 08:19:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7A66C88B7C;
	Tue, 14 Jul 2020 08:19:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E15FC0888;
	Tue, 14 Jul 2020 08:19:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAEE4C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9A04C8A898
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V9BLxogI4NRj for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 08:19:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 286B989D9E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:19:55 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DE03B21841;
 Tue, 14 Jul 2020 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594714795;
 bh=y+kMcjwj62DUaai6UaM9R3NF5UPVqYjpo4MPe+fl5/M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EwN9vIxQSjaO9e8cUaJo+M3xEPCfTIwpe+D7LX6937JtKIX+pAe1YSSToA2FrjOt9
 BILjibwYsmo1ymsbfg8G9rGHEfj2UVC/9m9Np3VWOIAbcuAqD+976EzWmJBTPeUh6t
 AdZFrIsLB/+40Nck+WUu2TdBz3I+bLlgf4iFlT1k=
Date: Tue, 14 Jul 2020 09:19:49 +0100
From: Will Deacon <will@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH v3 0/4] Add system mmu support for Armada-806
Message-ID: <20200714081949.GA4516@willie-the-truck>
References: <20200702201633.22693-1-tn@semihalf.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200702201633.22693-1-tn@semihalf.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, gregory.clement@bootlin.com,
 catalin.marinas@arm.com, hannah@marvell.com, linux-kernel@vger.kernel.org,
 nadavh@marvell.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 mw@semihalf.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

Hi Tomasz,

On Thu, Jul 02, 2020 at 10:16:29PM +0200, Tomasz Nowicki wrote:
> There were already two versions of series to support SMMU for AP806,
> including workaround for accessing ARM SMMU 64bit registers.
> First [1] by Hanna Hawa and second [2] by Gregory CLEMENT.
> Since it got stuck this is yet another try. I incorporated the V2 comments,
> mainly by moving workaround code to arm-smmu-impl.c as requested.
> 
> For the record, AP-806 can't access SMMU registers with 64bit width,
> this patches split the readq/writeq into two 32bit accesses instead
> and update DT bindings.
> 
> The series was successfully tested on a vanilla v5.8-rc3 kernel and
> Intel e1000e PCIe NIC. The same for platform devices like SATA and USB.
> 
> [1]: https://lkml.org/lkml/2018/10/15/373
> [2]: https://lkml.org/lkml/2019/7/11/426

Do you have a v4 of this series? It looks like there were a few comments
left to address, but with that I can pick it up for 5.9.

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
