Return-Path: <SRS0=OBKs=IG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11113C433DB
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 02:07:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920ED6513A
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 02:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920ED6513A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 51E4142C2D;
	Mon,  8 Mar 2021 02:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G235sRQMDGc3; Mon,  8 Mar 2021 02:07:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4FF0F42C2B;
	Mon,  8 Mar 2021 02:07:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16545C000A;
	Mon,  8 Mar 2021 02:07:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6652EC0001
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 02:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 418AE606EC
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 02:07:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id goJgiCqwXaFp for <iommu@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 02:07:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4304605CC
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 02:07:30 +0000 (UTC)
IronPort-SDR: KC5a5JZVeFWUifDRLaURna1d6TLXKwlvbdxhZPgVToGSrWgK2Zs/HhsNqkifw+vZf/mul2WR15
 YsEvm5njXdzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="175566480"
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; d="scan'208";a="175566480"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2021 18:07:29 -0800
IronPort-SDR: UdQgNuwx5+ufsJ4dlq+lt4nLz79o1bEti5AcVcisLcTvMff4/Zi7EFkWaOBGKy/4+B2g0cwYdZ
 ou0Nno+JiegA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; d="scan'208";a="430183307"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2021 18:07:27 -0800
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove WO permissions on second-level
 paging entries
To: Joerg Roedel <joro@8bytes.org>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
 <20210225062654.2864322-3-baolu.lu@linux.intel.com>
 <20210304122623.GD26414@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c7bffaee-6c3c-3254-a71a-d66d023d1e58@linux.intel.com>
Date: Mon, 8 Mar 2021 09:58:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210304122623.GD26414@8bytes.org>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Joerg,

On 3/4/21 8:26 PM, Joerg Roedel wrote:
> On Thu, Feb 25, 2021 at 02:26:51PM +0800, Lu Baolu wrote:
>> When the first level page table is used for IOVA translation, it only
>> supports Read-Only and Read-Write permissions. The Write-Only permission
>> is not supported as the PRESENT bit (implying Read permission) should
>> always set. When using second level, we still give separate permissions
>> that allows WriteOnly which seems inconsistent and awkward. There is no
>> use case we can think off, hence remove that configuration to make it
>> consistent.
> 
> No use-case for WriteOnly mappings? How about DMA_FROM_DEVICE mappings?
> 

The statement of no use case is not correct. Sorry about it.

As we have moved to use first level for IOVA translation, the first
level page table entry only provides RO and RW permissions. So if any
device driver specifies DMA_FROM_DEVICE attribution, it will get RW
permission in the page table. This patch aims to make the permissions
of second level and first level consistent. No impact on the use of
DMA_FROM_DEVICE attribution.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
