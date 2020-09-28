Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5AAC2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 09:44:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A590B221E8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 09:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A590B221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4D9BF85361;
	Mon, 28 Sep 2020 09:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id araKGj8fYGi7; Mon, 28 Sep 2020 09:44:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8668B84AE1;
	Mon, 28 Sep 2020 09:44:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B982C016F;
	Mon, 28 Sep 2020 09:44:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC58C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 09:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 372DC84C36
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 09:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pXatOxWKNcXv for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 09:44:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9B85484AE1
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 09:44:47 +0000 (UTC)
IronPort-SDR: YIzEBJbUCFnjYuyksplidK4zvXTYktL0JhYNHjBhyJnHgDHzW03BpViqSLeoGupTMRT2IXSdDu
 V7PYppvE0fvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="246708863"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; d="scan'208";a="246708863"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 02:44:46 -0700
IronPort-SDR: 2tjmcGEZ/+K7vGu4mwps+Jnj56puQNgH9yUuCen7PBQdlOZ1+OafMXAQ8apkeDOTbbN8SnOE58
 9OPrz021udJw==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; d="scan'208";a="456757836"
Received: from agal3-mobl1.ger.corp.intel.com (HELO [10.214.224.94])
 ([10.214.224.94])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 02:44:43 -0700
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu api
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Tom Murphy <murphyt7@tcd.ie>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
Date: Mon, 28 Sep 2020 10:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200927063437.13988-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: Intel-gfx@lists.freedesktop.org, Ashok Raj <ashok.raj@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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


On 27/09/2020 07:34, Lu Baolu wrote:
> Hi,
> 
> The previous post of this series could be found here.
> 
> https://lore.kernel.org/linux-iommu/20200912032200.11489-1-baolu.lu@linux.intel.com/
> 
> This version introduce a new patch [4/7] to fix an issue reported here.
> 
> https://lore.kernel.org/linux-iommu/51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com/
> 
> There aren't any other changes.
> 
> Please help to test and review.
> 
> Best regards,
> baolu
> 
> Lu Baolu (3):
>    iommu: Add quirk for Intel graphic devices in map_sg

Since I do have patches to fix i915 to handle this, do we want to 
co-ordinate the two and avoid having to add this quirk and then later 
remove it? Or you want to go the staged approach?

Regards,

Tvrtko

>    iommu/vt-d: Update domain geometry in iommu_ops.at(de)tach_dev
>    iommu/vt-d: Cleanup after converting to dma-iommu ops
> 
> Tom Murphy (4):
>    iommu: Handle freelists when using deferred flushing in iommu drivers
>    iommu: Add iommu_dma_free_cpu_cached_iovas()
>    iommu: Allow the dma-iommu api to use bounce buffers
>    iommu/vt-d: Convert intel iommu driver to the iommu ops
> 
>   .../admin-guide/kernel-parameters.txt         |   5 -
>   drivers/iommu/dma-iommu.c                     | 228 ++++-
>   drivers/iommu/intel/Kconfig                   |   1 +
>   drivers/iommu/intel/iommu.c                   | 901 +++---------------
>   include/linux/dma-iommu.h                     |   8 +
>   include/linux/iommu.h                         |   1 +
>   6 files changed, 336 insertions(+), 808 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
