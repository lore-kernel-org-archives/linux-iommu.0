Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B931C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 12:26:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF3164F11
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 12:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF3164F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77C0442FBA;
	Thu,  4 Mar 2021 12:26:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LP47wexfe6ef; Thu,  4 Mar 2021 12:26:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6F8E8431CD;
	Thu,  4 Mar 2021 12:26:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38E52C000A;
	Thu,  4 Mar 2021 12:26:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 398A6C0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 12:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B13C431CD
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 12:26:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NRM-fLVmeckW for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 12:26:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87F4342FBA
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 12:26:27 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BA31A447; Thu,  4 Mar 2021 13:26:24 +0100 (CET)
Date: Thu, 4 Mar 2021 13:26:23 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove WO permissions on second-level
 paging entries
Message-ID: <20210304122623.GD26414@8bytes.org>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
 <20210225062654.2864322-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210225062654.2864322-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kevin.tian@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com, Will Deacon <will@kernel.org>
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

On Thu, Feb 25, 2021 at 02:26:51PM +0800, Lu Baolu wrote:
> When the first level page table is used for IOVA translation, it only
> supports Read-Only and Read-Write permissions. The Write-Only permission
> is not supported as the PRESENT bit (implying Read permission) should
> always set. When using second level, we still give separate permissions
> that allows WriteOnly which seems inconsistent and awkward. There is no
> use case we can think off, hence remove that configuration to make it
> consistent.

No use-case for WriteOnly mappings? How about DMA_FROM_DEVICE mappings?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
