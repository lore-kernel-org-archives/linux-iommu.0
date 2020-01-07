Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4374FC33C8C
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 13:16:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18DA52072A
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 13:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DA52072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8DA184BBE;
	Tue,  7 Jan 2020 13:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zKASeT3To42Z; Tue,  7 Jan 2020 13:16:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7E52784A6C;
	Tue,  7 Jan 2020 13:16:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72710C1796;
	Tue,  7 Jan 2020 13:16:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3155AC0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1C5A720364
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:16:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cH58g0zqz+eq for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 13:16:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id AE2C120362
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 13:16:46 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id ACC3F2AA; Tue,  7 Jan 2020 14:16:44 +0100 (CET)
Date: Tue, 7 Jan 2020 14:16:43 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Subject: Re: [PATCH 1/1] iommu/amd: Fix typos for PPR macros
Message-ID: <20200107131643.GB30750@8bytes.org>
References: <20191230055654.16029-1-ahuang12@lenovo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191230055654.16029-1-ahuang12@lenovo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

On Mon, Dec 30, 2019 at 01:56:54PM +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> The bit 13 and bit 14 of the IOMMU control register are
> PPRLogEn and PPRIntEn. They are related to PPR (Peripheral Page
> Request) instead of 'PPF'. Fix them accrodingly.
> 
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/iommu/amd_iommu_init.c  | 4 ++--
>  drivers/iommu/amd_iommu_types.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
