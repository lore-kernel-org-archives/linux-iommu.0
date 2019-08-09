Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA7CC433FF
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 15:37:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0209F2171F
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 15:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0209F2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CB6A8DA7;
	Fri,  9 Aug 2019 15:37:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 37E91DA3
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 15:37:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D6F6B76F
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 15:37:33 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 5AFDF3D0; Fri,  9 Aug 2019 17:37:32 +0200 (CEST)
Date: Fri, 9 Aug 2019 17:37:31 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/8] iommu/omap: misc fixes
Message-ID: <20190809153730.GF12930@8bytes.org>
References: <1565166412-31195-1-git-send-email-t-kristo@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1565166412-31195-1-git-send-email-t-kristo@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org
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

On Wed, Aug 07, 2019 at 11:26:44AM +0300, Tero Kristo wrote:
> Here are a few fixes for OMAP IOMMU. These are mostly towards getting
> runtime PM support functional again for the IOMMU.

Applied all, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
