Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64809C3A5A4
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 10:51:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F70F21897
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 10:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F70F21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E5E655DC5;
	Fri, 30 Aug 2019 10:51:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B83835BD3
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 10:49:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 160B9E6
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 10:49:29 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 484C5AC1C;
	Fri, 30 Aug 2019 10:49:27 +0000 (UTC)
Date: Fri, 30 Aug 2019 12:49:25 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Eric Dumazet <edumazet@google.com>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/iova: avoid false sharing on fq_timer_on
Message-ID: <20190830104925.GI17192@suse.de>
References: <20190828131338.89832-1-edumazet@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190828131338.89832-1-edumazet@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jinyu Qi <jinyuqi@huawei.com>, iommu@lists.linux-foundation.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Eric Dumazet <eric.dumazet@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Looks good to me, but adding Robin for his opinion.

On Wed, Aug 28, 2019 at 06:13:38AM -0700, Eric Dumazet wrote:
> In commit 14bd9a607f90 ("iommu/iova: Separate atomic variables
> to improve performance") Jinyu Qi identified that the atomic_cmpxchg()
> in queue_iova() was causing a performance loss and moved critical fields
> so that the false sharing would not impact them.
> 
> However, avoiding the false sharing in the first place seems easy.
> We should attempt the atomic_cmpxchg() no more than 100 times
> per second. Adding an atomic_read() will keep the cache
> line mostly shared.
> 
> This false sharing came with commit 9a005a800ae8
> ("iommu/iova: Add flush timer").
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jinyu Qi <jinyuqi@huawei.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/iova.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 3e1a8a6755723a927a7942a7429ab7e6c19a0027..41c605b0058f9615c2dbdd83f1de2404a9b1d255 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -577,7 +577,9 @@ void queue_iova(struct iova_domain *iovad,
>  
>  	spin_unlock_irqrestore(&fq->lock, flags);
>  
> -	if (atomic_cmpxchg(&iovad->fq_timer_on, 0, 1) == 0)
> +	/* Avoid false sharing as much as possible. */
> +	if (!atomic_read(&iovad->fq_timer_on) &&
> +	    !atomic_cmpxchg(&iovad->fq_timer_on, 0, 1))
>  		mod_timer(&iovad->fq_timer,
>  			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
>  }
> -- 
> 2.23.0.187.g17f5b7556c-goog
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
