Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E164C433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 08:12:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B33920716
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 08:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B33920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3263F89456;
	Tue, 23 Jun 2020 08:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6n5fuqcx+MmF; Tue, 23 Jun 2020 08:12:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CC7E088C40;
	Tue, 23 Jun 2020 08:12:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B31F6C0891;
	Tue, 23 Jun 2020 08:12:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0D52C016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 08:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 903D086D42
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 08:12:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1TYaNC3vzG6W for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 08:12:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5BA9186D3C
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 08:12:25 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 7EACA2AF; Tue, 23 Jun 2020 10:12:22 +0200 (CEST)
Date: Tue, 23 Jun 2020 10:12:19 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/6] [PULL REQUEST] iommu/vt-d: fixes for v5.8
Message-ID: <20200623081218.GK3701@8bytes.org>
References: <20200622231345.29722-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200622231345.29722-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org
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

On Tue, Jun 23, 2020 at 07:13:39AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> Below fix patches have been piled up for v5.8. Please consider them for
> your fix branch.
> 
> Best regards,
> Lu Baolu
> 
> Lu Baolu (5):
>   iommu/vt-d: Make Intel SVM code 64-bit only
>   iommu/vt-d: Set U/S bit in first level page table by default
>   iommu/vt-d: Enable PCI ACS for platform opt in hint
>   iommu/vt-d: Update scalable mode paging structure coherency
>   iommu/vt-d: Fix misuse of iommu_domain_identity_map()
> 
> Rajat Jain (1):
>   iommu/vt-d: Don't apply gfx quirks to untrusted devices
> 
>  drivers/iommu/Kconfig       |  2 +-
>  drivers/iommu/intel/dmar.c  |  3 +-
>  drivers/iommu/intel/iommu.c | 59 ++++++++++++++++++++++++++++++++-----
>  include/linux/intel-iommu.h |  1 +
>  4 files changed, 56 insertions(+), 9 deletions(-)

Applied to iommu/fixes, thanks Baolu.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
