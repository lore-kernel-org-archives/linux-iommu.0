Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2012DC2D0C8
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 10:14:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E773C207FF
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 10:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E773C207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B226C8610A;
	Tue, 17 Dec 2019 10:14:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id teqhr7RQ43Sj; Tue, 17 Dec 2019 10:14:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 131D885E14;
	Tue, 17 Dec 2019 10:14:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C783C1AE8;
	Tue, 17 Dec 2019 10:14:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23392C077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 124B88790F
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ajWeZMfVzv-T for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 10:14:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 898138789D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:14:00 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 14A50286; Tue, 17 Dec 2019 11:13:59 +0100 (CET)
Date: Tue, 17 Dec 2019 11:13:57 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Xiaotao Yin <xiaotao.yin@windriver.com>
Subject: Re: [PATCH V3] iommu/iova: Init the struct iova to fix the possible
 memleak
Message-ID: <20191217101357.GK8689@8bytes.org>
References: <20191210042704.14693-1-xiaotao.yin@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191210042704.14693-1-xiaotao.yin@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, Kexin.Hao@windriver.com
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

On Tue, Dec 10, 2019 at 12:27:04PM +0800, Xiaotao Yin wrote:
> Fixes: bb68b2fbfbd6 ("iommu/iova: Add rbtree anchor node")
> Signed-off-by: Xiaotao Yin <xiaotao.yin@windriver.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iova.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Okay, missed that. Replaced the previous patch by this one. Thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
