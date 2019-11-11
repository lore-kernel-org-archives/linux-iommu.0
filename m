Return-Path: <SRS0=z06/=ZD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A40C43331
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 14:03:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9B721783
	for <iommu@archiver.kernel.org>; Mon, 11 Nov 2019 14:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9B721783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E774DCF6;
	Mon, 11 Nov 2019 14:02:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 20479CF6
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 14:02:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 944338B4
	for <iommu@lists.linux-foundation.org>;
	Mon, 11 Nov 2019 14:02:56 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 77629120; Mon, 11 Nov 2019 15:02:53 +0100 (CET)
Date: Mon, 11 Nov 2019 15:02:52 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 0/7] Improve tlb range flush
Message-ID: <20191111140251.GA18333@8bytes.org>
References: <1572850868-22315-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572850868-22315-1-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	edison.hsieh@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Mon, Nov 04, 2019 at 03:01:01PM +0800, Yong Wu wrote:
> Yong Wu (7):
>   iommu/mediatek: Correct the flush_iotlb_all callback
>   iommu/mediatek: Add a new tlb_lock for tlb_flush
>   iommu/mediatek: Use gather to achieve the tlb range flush
>   iommu/mediatek: Delete the leaf in the tlb_flush
>   iommu/mediatek: Move the tlb_sync into tlb_flush
>   iommu/mediatek: Get rid of the pgtlock
>   iommu/mediatek: Reduce the tlb flush timeout value

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
