Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C4CC43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 13:27:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0588206C1
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 13:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0588206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A683027D1;
	Fri, 26 Apr 2019 13:26:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E0E6727B4
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 13:25:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8D7F8786
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 13:25:12 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id E93C6447; Fri, 26 Apr 2019 15:25:10 +0200 (CEST)
Date: Fri, 26 Apr 2019 15:25:09 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [PATCH] iommu/mediatek: fix leaked of_node references
Message-ID: <20190426132509.GB24576@8bytes.org>
References: <1555468879-34684-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1555468879-34684-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: wang.yi59@zte.com.cn, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org
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
Message-ID: <20190426132509._i_EMaIoa8dDD29sEXVDOgmb5L90pauBYYpM5rSm130@z>

On Wed, Apr 17, 2019 at 10:41:19AM +0800, Wen Yang wrote:
>  drivers/iommu/mtk_iommu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
