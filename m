Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A2C433E0
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 13:03:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523D023372
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 13:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523D023372
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E654886AEE;
	Thu,  7 Jan 2021 13:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8nXL3rQI6E7r; Thu,  7 Jan 2021 13:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AB05486A7D;
	Thu,  7 Jan 2021 13:03:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D5B1C088B;
	Thu,  7 Jan 2021 13:03:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEC4BC013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 13:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AACD7865C1
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 13:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ayE_wzOtK776 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 13:03:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F25BE865AB
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 13:03:24 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12F6722D01;
 Thu,  7 Jan 2021 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610024604;
 bh=GfXmkqoELy/f9VuG/jwzCEOi96GnRIiD/hBd6Kv7aZs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aNhNwduW7Bg+R6qpPnF4Fq0VsiF2LfWeRBt+esJh1uVeUagrdZBEELfG85NXoiz0z
 thcm7Ygu/Xfdsrw/wLEiIDnrzqFSwb3Y1xwcARMmlx7eNboKJfDRgxZZwsGp1OIH6A
 kE6gmllZqZB1mUNkDOJ6yd3o1EmsL0HANMbACyuIHcD8kgeLC0Qjxc9A99fFdw2fsw
 pOePow6JWtEW5zFXk/zv4Ru4zlnF01wtWh4S/kJovjk4xpYd4vfD13Jspe4kTMsCez
 FTazW/3YzmYXr+9M+7rONP3e/w9T9esoC6PhhM14U1hNOXizdjVRVY067qQnzs7axF
 aHWn0xT9+JCiA==
Date: Thu, 7 Jan 2021 13:03:19 +0000
From: Will Deacon <will@kernel.org>
To: Ajay Kumar <ajaykumar.rs@samsung.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Handle duplicated Stream IDs from
 other masters
Message-ID: <20210107130319.GA2986@willie-the-truck>
References: <CGME20210107092826epcas5p100f2c57a63715baa2b3fa7219ab58c7b@epcas5p1.samsung.com>
 <20210107093340.15279-1-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210107093340.15279-1-ajaykumar.rs@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, robin.murphy@arm.com,
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

On Thu, Jan 07, 2021 at 03:03:40PM +0530, Ajay Kumar wrote:
> When PCI function drivers(ex:pci-endpoint-test) are probed for already
> initialized PCIe-RC(Root Complex), and PCIe-RC is already bound to SMMU,
> then we encounter a situation where the function driver tries to attach
> itself to the smmu with the same stream-id as PCIe-RC and re-initialize
> an already initialized STE. This causes ste_live BUG_ON() in the driver.

I don't understand why the endpoint is using the same stream ID as the root
complex in this case. Why is that? Is the grouping logic not working
properly?

> There is an already existing check in the driver to manage duplicated ids
> if duplicated ids are added in same master device, but there can be
> scenarios like above where we need to extend the check for other masters
> using the same stream-id.
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++++++++
>  1 file changed, 33 insertions(+)

It doesn't feel like the driver is the right place to fix this, as the same
issue could surely occur for other IOMMUs too, right? In which case, I think
we should avoid getting into the situation where different groups have
overlapping stream IDs.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
