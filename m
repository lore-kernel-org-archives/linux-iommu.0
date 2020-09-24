Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBCAC4727D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:52:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD0F23A34
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD0F23A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BD3F86A88;
	Thu, 24 Sep 2020 10:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Ech9WbUvt8p; Thu, 24 Sep 2020 10:52:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DBC1986A79;
	Thu, 24 Sep 2020 10:52:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7B5AC0889;
	Thu, 24 Sep 2020 10:52:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F133AC0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DB92586BAC
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cd1iynbIg4-M for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 10:52:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4E23586BA8
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:52:03 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D8328295; Thu, 24 Sep 2020 12:52:01 +0200 (CEST)
Date: Thu, 24 Sep 2020 12:52:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 0/3] amd : iommu : Initial IOMMU support for SNP
Message-ID: <20200924105200.GP27174@8bytes.org>
References: <20200923121347.25365-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200923121347.25365-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Jon.Grimm@amd.com, brijesh.singh@amd.com,
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

On Wed, Sep 23, 2020 at 12:13:44PM +0000, Suravee Suthikulpanit wrote:
> Suravee Suthikulpanit (3):
>   iommu: amd: Use 4K page for completion wait write-back semaphore
>   iommu: amd: Add support for RMP_PAGE_FAULT and RMP_HW_ERR
>   iommu: amd: Re-purpose Exclusion range registers to support SNP CWWB

Applied, thanks. I am slightly concerned about the re-purposing of the
exclusion-range registers based on a feature bit being set. This makes
the hardware incompatible to older IOMMU drivers which do not check the
FEATURE_SNP bit.

It will probably work in this case, as the firmware on systems with
IOMMU-SNP support will not declare exclusion ranges at all and
exclusion-ranges in the IOMMU hardware have been a bad idea since
forever, but it would have been nicer if hardware actually
provided a bit to enable this behavior.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
