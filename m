Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBC4C433E4
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 08:28:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E28521897
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 08:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cca/sw3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E28521897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 56C632E8E4;
	Tue, 14 Jul 2020 08:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tAfvYTTAyfsc; Tue, 14 Jul 2020 08:28:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0954225296;
	Tue, 14 Jul 2020 08:28:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7799C0888;
	Tue, 14 Jul 2020 08:28:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28482C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 16B258A962
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3NnsfddHktVB for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 08:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9311289CEB
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 08:28:27 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4A18121897;
 Tue, 14 Jul 2020 08:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594715307;
 bh=pIHiPnXl29m/SBs4JyChDxAqMplo09HuFsHg6sAYMJo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cca/sw3/jyus9ULYMXo0h2TBjV/Q+OEaM3QXhOQQN9gh0rzZoCsr+lXDNe1Y8FtjC
 zH6wIyiBUzvZMiMF+TML3mUUcwPbiqsXG5lRUNj51n2NEC/bHHPxfZLPDLXc90vJzT
 9YqF/zOe/+XKPeP1v7ljoCLfGG/EMIGPkjW39ynI=
Date: Tue, 14 Jul 2020 09:28:21 +0100
From: Will Deacon <will@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] iommu: Add gfp parameter to io_pgtable_ops->map()
Message-ID: <20200714082821.GC4516@willie-the-truck>
References: <cover.1591930156.git.baolin.wang@linux.alibaba.com>
 <3093df4cb95497aaf713fca623ce4ecebb197c2e.1591930156.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3093df4cb95497aaf713fca623ce4ecebb197c2e.1591930156.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, tomeu.vizoso@collabora.com,
 airlied@linux.ie, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
 baolin.wang7@gmail.com, agross@kernel.org, linux-mediatek@lists.infradead.org,
 alyssa.rosenzweig@collabora.com, daniel@ffwll.ch, matthias.bgg@gmail.com,
 steven.price@arm.com, robin.murphy@arm.com,
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

On Fri, Jun 12, 2020 at 11:39:55AM +0800, Baolin Wang wrote:
> Now the ARM page tables are always allocated by GFP_ATOMIC parameter,
> but the iommu_ops->map() function has been added a gfp_t parameter by
> commit 781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map"),
> thus io_pgtable_ops->map() should use the gfp parameter passed from
> iommu_ops->map() to allocate page pages, which can avoid wasting the
> memory allocators atomic pools for some non-atomic contexts.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c |  2 +-
>  drivers/iommu/arm-smmu-v3.c             |  2 +-
>  drivers/iommu/arm-smmu.c                |  2 +-
>  drivers/iommu/io-pgtable-arm-v7s.c      | 18 +++++++++---------
>  drivers/iommu/io-pgtable-arm.c          | 18 +++++++++---------
>  drivers/iommu/ipmmu-vmsa.c              |  2 +-
>  drivers/iommu/msm_iommu.c               |  2 +-
>  drivers/iommu/mtk_iommu.c               |  2 +-
>  drivers/iommu/qcom_iommu.c              |  2 +-
>  include/linux/io-pgtable.h              |  2 +-
>  10 files changed, 26 insertions(+), 26 deletions(-)

I was a bit nervous about us passing GFP_KERNEL with a spinlock held, but
it looks like you've checked all the callsites and it looks fine to me, so:

Acked-by: Will Deacon <will@kernel.org>

Joerg -- not sure what you want to do with this one, as it's likely to
conflict (trivially) with unrelated driver changes.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
