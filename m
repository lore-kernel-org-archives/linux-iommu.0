Return-Path: <SRS0=qXOr=FH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A5C71156
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 11:53:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921892086A
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 11:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921892086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0CDF287A35;
	Thu,  3 Dec 2020 11:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QlchlCXxBN61; Thu,  3 Dec 2020 11:53:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4473F879EF;
	Thu,  3 Dec 2020 11:53:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26B8EC163C;
	Thu,  3 Dec 2020 11:53:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C964FC0FA7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 11:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B0E7A873AB
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 11:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gkceu1UODfDw for <iommu@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 11:53:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CF31787396
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 11:53:16 +0000 (UTC)
Date: Thu, 3 Dec 2020 11:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1606996396;
 bh=2j9fWjCkqKCoHT9xIh7hghfL78crppBPjSaMaUXDoYY=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=A0UDfFqlLtETJD75Yl5RAWp1KV5tqcTwRPIopAzSrJR9HvaNG1KREMDyqAwJF5xlZ
 M/yBC5lUKVu9flpaC1awMgw0In4UE75VfsaIyQThiGFt9Je09wNotz6B+c8QPvmt0C
 XTy5HZTVZ63ptNIh2iK7jVirr/msEdzin3ib7rDuhymchQycZlJSWKQZ+OsVk8ZO2b
 scCbjmQ1rOBhGExxE60lO32sX69i4cT/aa9DmiKMK8IkubKLCxhOutiL/MksHnti2f
 ap5kPwsX9zpRCthSiPzo3l6MDx98K3UqiXRRgkaJ05Itd4rdEu9cJT0D0aDVfMq+hY
 eF8gmVdjygfVQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable: Remove tlb_flush_leaf
Message-ID: <20201203115310.GC31188@willie-the-truck>
References: <9844ab0c5cb3da8b2f89c6c2da16941910702b41.1606324115.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9844ab0c5cb3da8b2f89c6c2da16941910702b41.1606324115.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, tomeu.vizoso@collabora.com,
 dri-devel@lists.freedesktop.org, steven.price@arm.com,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Wed, Nov 25, 2020 at 05:29:39PM +0000, Robin Murphy wrote:
> The only user of tlb_flush_leaf is a particularly hairy corner of the
> Arm short-descriptor code, which wants a synchronous invalidation to
> minimise the races inherent in trying to split a large page mapping.
> This is already far enough into "here be dragons" territory that no
> sensible caller should ever hit it, and thus it really doesn't need
> optimising. Although using tlb_flush_walk there may technically be
> more heavyweight than needed, it does the job and saves everyone else
> having to carry around useless baggage.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Reviewing the Mediatek TLB optimisation patches just left me thinking
> "why do we even have this?"... Panfrost folks, this has zero functional
> impact to you, merely wants an ack for straying outside drivers/iommu.

Thanks, this looks good to me, but I'll defer queuing it until the last
minute so that I can merge all the iommu component branches together
first and then apply this on top. Should happen next week.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
