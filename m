Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7473BC433FE
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 21:54:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1859E60B74;
	Tue, 31 May 2022 21:54:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EXkImwPIxGnJ; Tue, 31 May 2022 21:54:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1201E60B6C;
	Tue, 31 May 2022 21:54:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1977C0032;
	Tue, 31 May 2022 21:54:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 473D5C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:54:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32E5B81B72
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id psguhw8pmirW for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 21:54:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE75681B69
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 21:54:28 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E5C586131B;
 Tue, 31 May 2022 21:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F48FC385A9;
 Tue, 31 May 2022 21:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654034067;
 bh=p1OW3169Xm6Eo04hC32FJFeedrLyv3PKo3DiY4M7gOc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gIb1CqARRBC6qSSdyiOWLJrKknzwu45ZhejlZUVs8aK0HhuFvWbQsRBGPsJR86/IF
 ydAqEZDaqp0qAoApwZ31qSdQweyQnLiq7CMvgF4o2a8zxonxmUVuyiWet0x8kc+dth
 JcrxCYsUr27twnEjiFxlzj2Myh3Yetj+mvOfsvIJz0NLoKLkRKIy3jcVkx64NXnRpY
 aROv1sCg7zzz17tttNDeYWua5QNEII+OJN4GKM/I99E4Nh8sNmtxDgB43pV9QKLAnA
 0Ba9+Dk451XP8orDqNcpihNf0vtbYaqn24YZvJUKTy/jtSpp2kGfqobjaAiZWtEEfi
 /l1eOJiXn6Zog==
Date: Tue, 31 May 2022 15:54:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tony Battersby <tonyb@cybernetics.com>
Subject: Re: [PATCH 10/10] dmapool: improve scalability of dma_pool_free
Message-ID: <YpaOj/C1SA8y1VCg@kbusch-mbp.dhcp.thefacebook.com>
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <801335ba-00f3-12ae-59e0-119d7d8fd8cd@cybernetics.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <801335ba-00f3-12ae-59e0-119d7d8fd8cd@cybernetics.com>
Cc: Tony Lindgren <tony@atomide.com>, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 kernel-team@fb.com, Robin Murphy <robin.murphy@arm.com>
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

On Tue, May 31, 2022 at 02:23:44PM -0400, Tony Battersby wrote:
> dma_pool_free() scales poorly when the pool contains many pages because
> pool_find_page() does a linear scan of all allocated pages.  Improve its
> scalability by replacing the linear scan with a red-black tree lookup.
> In big O notation, this improves the algorithm from O(n^2) to O(n * log n).

The improvement should say O(n) to O(log n), right?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
