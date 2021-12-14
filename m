Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EF1C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 199BA60BD0;
	Tue, 14 Dec 2021 15:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zz3Qh46rBHXT; Tue, 14 Dec 2021 15:18:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F78060BC6;
	Tue, 14 Dec 2021 15:18:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE755C002F;
	Tue, 14 Dec 2021 15:18:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E191C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D6D24055C
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ah6Ky7mCBF4H for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 15:18:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D95240563
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:45 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 610E86156F;
 Tue, 14 Dec 2021 15:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CDBC34606;
 Tue, 14 Dec 2021 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639495123;
 bh=EtXNCqqEF5z7tNX4x034w1DmPhsexirc5bJSadieaTU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oVm5vp4S50b4rGVhdHXirrlW9wzjjz4QmXBPKuTPQVSv/iN+1KZIYc+ukAokyG3NL
 5EYAUnXwYT8ooc8tJFGmtoEDjqtHvO/PwLht9tW7rIei49/5ZuWUxgnlpm7jakwUu4
 RuZaKfNUYRG5L0hCu6TcCcKyzOWrAVuaD+FuRTe4jxKgYgYc9svs4ZyN6qkE8nUKwS
 BBukGp4WcOJykx+A28YWnsysRITIEDLDwZiQ5HX90vpD9G0x8B4JfDDHdcfWMZtmGM
 APhy0y3yr6Hpsir8HXkbr5sLUFrMdYOmyezphCTsrTIhyRE4DNECZMowppwfbBJRHo
 peKqoXbWSIPFw==
From: Will Deacon <will@kernel.org>
To: yf.wang@mediatek.com
Subject: Re: [PATCH v3] iommu/io-pgtable-arm-v7s: Add error handle for page
 table allocation failure
Date: Tue, 14 Dec 2021 15:18:17 +0000
Message-Id: <163949313634.2865984.16870619152235318237.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211207113315.29109-1-yf.wang@mediatek.com>
References: <20211207094817.GA31382@willie-the-truck>
 <20211207113315.29109-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Cc: Guangming.Cao@mediatek.com, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 wsd_upstream@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Libo.Kang@mediatek.com,
 matthias.bgg@gmail.com, stable@vger.kernel.org, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com
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

On Tue, 7 Dec 2021 19:33:15 +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> In __arm_v7s_alloc_table function:
> iommu call kmem_cache_alloc to allocate page table, this function
> allocate memory may fail, when kmem_cache_alloc fails to allocate
> table, call virt_to_phys will be abnomal and return unexpected phys
> and goto out_free, then call kmem_cache_free to release table will
> trigger KE, __get_free_pages and free_pages have similar problem,
> so add error handle for page table allocation failure.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/io-pgtable-arm-v7s: Add error handle for page table allocation failure
      https://git.kernel.org/will/c/a556cfe4cabc

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
