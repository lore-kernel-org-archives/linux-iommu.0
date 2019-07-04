Return-Path: <SRS0=qghM=VB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5685C0650E
	for <iommu@archiver.kernel.org>; Thu,  4 Jul 2019 08:07:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EDE218A3
	for <iommu@archiver.kernel.org>; Thu,  4 Jul 2019 08:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EDE218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 70B9EC64;
	Thu,  4 Jul 2019 08:07:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 16C0AAE0
	for <iommu@lists.linux-foundation.org>;
	Thu,  4 Jul 2019 08:07:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CB85087D
	for <iommu@lists.linux-foundation.org>;
	Thu,  4 Jul 2019 08:07:44 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 9B9D42FB; Thu,  4 Jul 2019 10:07:41 +0200 (CEST)
Date: Thu, 4 Jul 2019 10:07:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Invalidate ATC when detaching a device
Message-ID: <20190704080739.GB6546@8bytes.org>
References: <20190703111920.23637-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190703111920.23637-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robin.murphy@arm.com, iommu@lists.linux-foundation.org, will@kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Jul 03, 2019 at 12:19:20PM +0100, Jean-Philippe Brucker wrote:
>  drivers/iommu/arm-smmu-v3.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
