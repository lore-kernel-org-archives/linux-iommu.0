Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B69C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 13:44:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0675D2133D
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 13:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0675D2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C644427C9;
	Thu, 11 Apr 2019 13:44:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6228225F0
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 13:43:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BA195F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 13:43:15 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id A327A42D; Thu, 11 Apr 2019 15:43:13 +0200 (CEST)
Date: Thu, 11 Apr 2019 15:43:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH] iommu/iova: Separate atomic variables to improve
	performance
Message-ID: <20190411134312.GC4518@8bytes.org>
References: <1554280521-18375-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1554280521-18375-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jinyu Qi <jinyuqi@huawei.com>, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411134312.MGyhXQA2ToUdOIZmMGEt7hpA8PBcHKQAEoVWUB7Vzgw@z>

On Wed, Apr 03, 2019 at 04:35:21PM +0800, Shaokun Zhang wrote:
> From: Jinyu Qi <jinyuqi@huawei.com> 
> 
> In struct iova_domain, there are three atomic variables, the former two
> are about TLB flush counters which use atomic_add operation, anoter is
> used to flush timer that use cmpxhg operation.
> These variables are in the same cache line, so it will cause some
> performance loss under the condition that many cores call queue_iova
> function, Let's isolate the two type atomic variables to different
> cache line to reduce cache line conflict.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Jinyu Qi <jinyuqi@huawei.com>
> ---
>  include/linux/iova.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
