Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A9DC433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 09:08:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8824464EEC
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 09:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8824464EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 440AB83126;
	Fri, 19 Mar 2021 09:08:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecfSdrsOr8qE; Fri, 19 Mar 2021 09:08:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6B6E82B1A;
	Fri, 19 Mar 2021 09:08:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8569EC000A;
	Fri, 19 Mar 2021 09:08:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1125FC0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 09:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3AAD40110
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 09:08:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nHKNNOsd5kza for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 09:08:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 40595400FC
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 09:08:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 6BE362DA; Fri, 19 Mar 2021 10:08:46 +0100 (CET)
Date: Fri, 19 Mar 2021 10:08:43 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix lockdep splat in
 intel_pasid_get_entry()
Message-ID: <YFRqG3DW8k0Zrk0w@8bytes.org>
References: <20210317005834.173503-1-baolu.lu@linux.intel.com>
 <YFMpmLNd73IVcgWq@8bytes.org>
 <89f87115-32dc-205e-61e0-71de0d626303@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <89f87115-32dc-205e-61e0-71de0d626303@linux.intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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

Hi Baolu,

On Fri, Mar 19, 2021 at 09:02:34AM +0800, Lu Baolu wrote:
> This code modifies the pasid directory entry. The pasid directory
> entries are allocated on demand and will never be freed.
> 
> > What you need to do here is to retry the whole path by adding a goto
> > to before  the first get_pasid_table_from_pde() call.
> 
> Yes. Retrying by adding a goto makes the code clearer.
> 
> > 
> > Btw, what makes sure that the pasid_entry does not go away when it is
> > returned here?
> 
> As explained above, it handles the pasid directory table entry which
> won't go away.

Okay, I think the goto is a good idea anyway, in case this changes
someday. Please also add a comment to this code stating that the entries
are never freed.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
