Return-Path: <SRS0=OBKs=IG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFAAC43381
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 19:48:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81529652B1
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 19:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81529652B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37FF883A5C;
	Mon,  8 Mar 2021 19:48:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v_ZrZznJ577T; Mon,  8 Mar 2021 19:48:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2303283843;
	Mon,  8 Mar 2021 19:48:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0920DC000A;
	Mon,  8 Mar 2021 19:48:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F89FC0001
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 19:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3739749CA1
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 19:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nl7ZhzmuW2ow for <iommu@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 19:47:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AF1349C90
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 19:47:57 +0000 (UTC)
IronPort-SDR: Uc+PRtGkCIQh/bMsOqqJvdDr+cDSe51nlYYhmFrftK8ODhn7iWlKwbXwzYrVXacFXuAx7Vlyp7
 zajkdGzhbcmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="187458675"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; d="scan'208";a="187458675"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 11:47:48 -0800
IronPort-SDR: WOrCr/EqVp4x85cVw8oQ1HycY/InT6iNHA86LctH221jXzosfr12XCVnXT7H06dpcJKIKTCRZi
 9DhoNBcArcgQ==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; d="scan'208";a="509034146"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 11:47:48 -0800
Date: Mon, 8 Mar 2021 11:47:46 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove WO permissions on second-level
 paging entries
Message-ID: <20210308194746.GA15436@otc-nc-03>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
 <20210225062654.2864322-3-baolu.lu@linux.intel.com>
 <20210304122623.GD26414@8bytes.org>
 <c7bffaee-6c3c-3254-a71a-d66d023d1e58@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c7bffaee-6c3c-3254-a71a-d66d023d1e58@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: kevin.tian@intel.com, Ashok Raj <ashok.raj@intel.com>,
 sanjay.k.kumar@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Will Deacon <will@kernel.org>
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

Hi Joerg

On Mon, Mar 08, 2021 at 09:58:26AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> On 3/4/21 8:26 PM, Joerg Roedel wrote:
> >On Thu, Feb 25, 2021 at 02:26:51PM +0800, Lu Baolu wrote:
> >>When the first level page table is used for IOVA translation, it only
> >>supports Read-Only and Read-Write permissions. The Write-Only permission
> >>is not supported as the PRESENT bit (implying Read permission) should
> >>always set. When using second level, we still give separate permissions
> >>that allows WriteOnly which seems inconsistent and awkward. There is no
> >>use case we can think off, hence remove that configuration to make it
> >>consistent.
> >
> >No use-case for WriteOnly mappings? How about DMA_FROM_DEVICE mappings?
> >
> 
> The statement of no use case is not correct. Sorry about it.
> 
> As we have moved to use first level for IOVA translation, the first
> level page table entry only provides RO and RW permissions. So if any
> device driver specifies DMA_FROM_DEVICE attribution, it will get RW
> permission in the page table. This patch aims to make the permissions
> of second level and first level consistent. No impact on the use of
> DMA_FROM_DEVICE attribution.
> 

That is the primary motivation, given that we have moved to 1st level for
general IOVA, first level doesn't have a WO mapping. I didn't know enough
about the history to determine if a WO without a READ is very useful. I
guess the ZLR was invented to support those cases without a READ in PCIe. I

Early Intel IOMMU's didn't handle ZLR properly, until we fixed it in the
next generation. It just seemed opposite to the CPU page-tables, and we
wanted to have consistent behavior. After moving to 1st level, we don't
want things to work sometimes, and break if we use 2nd level for the same
mappings.

Hope this helps

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
