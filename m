Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE03AC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 09:45:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D270611CE
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 09:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D270611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C00B608A2;
	Tue, 28 Sep 2021 09:45:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WKMvOseAFMLi; Tue, 28 Sep 2021 09:45:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 40B6960AE3;
	Tue, 28 Sep 2021 09:45:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13896C000F;
	Tue, 28 Sep 2021 09:45:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0576BC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 09:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E338A404B3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 09:45:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5rErrAZG7RkY for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 09:45:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 646B5403EF
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 09:45:21 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 01515310; Tue, 28 Sep 2021 11:45:17 +0200 (CEST)
Date: Tue, 28 Sep 2021 11:45:15 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Hook up r8a77980 DT matching code
Message-ID: <YVLkK9mAe1lwMOAv@8bytes.org>
References: <20210923191115.22864-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210923191115.22864-1-nikita.yoush@cogentembedded.com>
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
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

On Thu, Sep 23, 2021 at 10:11:16PM +0300, Nikita Yushchenko wrote:
>  drivers/iommu/ipmmu-vmsa.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
