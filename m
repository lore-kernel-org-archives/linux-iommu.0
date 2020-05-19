Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5B0C433DF
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 12:06:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5132081A
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 12:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5132081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AE8152277A;
	Tue, 19 May 2020 12:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6R09S9POSEi; Tue, 19 May 2020 12:06:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 538FC204A4;
	Tue, 19 May 2020 12:06:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37794C0881;
	Tue, 19 May 2020 12:06:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DFC5C0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 12:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3D3A287613
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 12:06:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dEQGAr+qMOC3 for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 12:06:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 16F6E86C12
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 12:06:45 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 10E3E386; Tue, 19 May 2020 14:06:40 +0200 (CEST)
Date: Tue, 19 May 2020 14:06:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] iommu/sun50i: Fix return value check in
 sun50i_iommu_probe()
Message-ID: <20200519120638.GG18353@8bytes.org>
References: <20200519091857.134170-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200519091857.134170-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-janitors@vger.kernel.org, iommu@lists.linux-foundation.org,
 Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
 Hulk Robot <hulkci@huawei.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime@cerno.tech>, Philipp Zabel <p.zabel@pengutronix.de>,
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

On Tue, May 19, 2020 at 09:18:57AM +0000, Wei Yongjun wrote:
> In case of error, the function devm_platform_ioremap_resource() returns
> ERR_PTR() not NULL. The NULL test in the return value check must be
> replaced with IS_ERR().
> 
> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/iommu/sun50i-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
