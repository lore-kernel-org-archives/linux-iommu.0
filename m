Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8925C33C8C
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 13:25:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB48207E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 13:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB48207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5C7C220362;
	Tue,  7 Jan 2020 13:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3IarDYlOsC67; Tue,  7 Jan 2020 13:25:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 13D4020352;
	Tue,  7 Jan 2020 13:25:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F381EC1796;
	Tue,  7 Jan 2020 13:25:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F9BFC0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EC72920352
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:25:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f8wi+SxtARDV for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 13:25:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 56BC82034C
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:25:33 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id AB6472AA; Tue,  7 Jan 2020 14:25:31 +0100 (CET)
Date: Tue, 7 Jan 2020 14:25:30 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH] iommu/qcom: fix NULL pointer dereference during probe
 deferral
Message-ID: <20200107132530.GC30750@8bytes.org>
References: <20200101033949.755-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200101033949.755-1-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, agross@kernel.org, bjorn.andersson@linaro.org
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

On Tue, Dec 31, 2019 at 10:39:49PM -0500, Brian Masney wrote:
>  drivers/iommu/qcom_iommu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Shortened commit-message a bit and applied for v5.5, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
