Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD78C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:12:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0B264E98
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 09:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0B264E98
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7FCD84182;
	Thu, 18 Mar 2021 09:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fqMtNYr_cD5X; Thu, 18 Mar 2021 09:12:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7F878405C;
	Thu, 18 Mar 2021 09:12:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77248C000A;
	Thu, 18 Mar 2021 09:12:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2010C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C38D8430A2
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:12:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iihXt-pns1Op for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 09:12:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A352C4309F
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 09:12:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BF6D82D8; Thu, 18 Mar 2021 10:12:47 +0100 (CET)
Date: Thu, 18 Mar 2021 10:12:46 +0100
From: Joerg Roedel <joro@8bytes.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove WO permissions on second-level
 paging entries
Message-ID: <YFMZjiGT13S2TZ6H@8bytes.org>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
 <20210225062654.2864322-3-baolu.lu@linux.intel.com>
 <20210304122623.GD26414@8bytes.org>
 <c7bffaee-6c3c-3254-a71a-d66d023d1e58@linux.intel.com>
 <20210308194746.GA15436@otc-nc-03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210308194746.GA15436@otc-nc-03>
Cc: kevin.tian@intel.com, sanjay.k.kumar@intel.com,
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

Hi,

On Mon, Mar 08, 2021 at 11:47:46AM -0800, Raj, Ashok wrote:
> That is the primary motivation, given that we have moved to 1st level for
> general IOVA, first level doesn't have a WO mapping. I didn't know enough
> about the history to determine if a WO without a READ is very useful. I
> guess the ZLR was invented to support those cases without a READ in PCIe. I

Okay, please update the commit message and re-send. I guess these
patches are 5.13 stuff. In that case, Baolu can include them into his
pull request later this cycle.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
