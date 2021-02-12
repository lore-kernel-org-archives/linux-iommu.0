Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D593DC433DB
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 10:47:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518C464DCD
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 10:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518C464DCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 108C26F5E0
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 10:47:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3KFdFxVN4hi9 for <iommu@archiver.kernel.org>;
	Fri, 12 Feb 2021 10:47:29 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 881BB6F5EC; Fri, 12 Feb 2021 10:47:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EA726F5C7;
	Fri, 12 Feb 2021 10:47:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 001FAC0174;
	Fri, 12 Feb 2021 10:47:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEDA2C013A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 10:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B5A7F87140
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 10:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JQ8PHe1htc6m for <iommu@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 10:47:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 70C1A86FF6
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 10:47:24 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 38751310; Fri, 12 Feb 2021 11:47:21 +0100 (CET)
Date: Fri, 12 Feb 2021 11:47:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix performance counter initialization
Message-ID: <20210212104717.GF7302@8bytes.org>
References: <20210208122712.5048-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210208122712.5048-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
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

On Mon, Feb 08, 2021 at 06:27:12AM -0600, Suravee Suthikulpanit wrote:
>  drivers/iommu/amd/init.c | 45 ++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 11 deletions(-)

Applied, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
