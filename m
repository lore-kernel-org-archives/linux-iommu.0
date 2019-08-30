Return-Path: <SRS0=ODk1=W2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8926BC3A5A4
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 13:24:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553C821670
	for <iommu@archiver.kernel.org>; Fri, 30 Aug 2019 13:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553C821670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1D85660A6;
	Fri, 30 Aug 2019 13:24:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A69AD606D
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 13:22:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 40C0CEC
	for <iommu@lists.linux-foundation.org>;
	Fri, 30 Aug 2019 13:22:43 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 6F54CB03D;
	Fri, 30 Aug 2019 13:22:41 +0000 (UTC)
Date: Fri, 30 Aug 2019 15:22:39 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/iova: avoid false sharing on fq_timer_on
Message-ID: <20190830132239.GK17192@suse.de>
References: <20190828131338.89832-1-edumazet@google.com>
	<20190830104925.GI17192@suse.de>
	<3ffd6989-229b-9c67-d9fb-7a8e413c1336@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3ffd6989-229b-9c67-d9fb-7a8e413c1336@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, Jinyu Qi <jinyuqi@huawei.com>,
	Eric Dumazet <edumazet@google.com>, Will Deacon <will@kernel.org>
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

On Fri, Aug 30, 2019 at 01:27:25PM +0100, Robin Murphy wrote:
> On 30/08/2019 11:49, Joerg Roedel wrote:
> > Looks good to me, but adding Robin for his opinion.
> 
> Sounds reasonable to me too - that should also be true for the majority of
> Arm systems that we know of. Will suggested that atomic_try_cmpxchg() might
> be relevant, but AFAICS that's backwards compared to what we want to do
> here, which I guess is more of an "atomic_unlikely_cmpxchg".
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Great, thanks for looking into it, Robin.

Applied now, thanks Eric.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
