Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BFCC433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 00:33:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F93564E27
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 00:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F93564E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DEE360690;
	Fri, 19 Mar 2021 00:33:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CgQX-NsEg7-W; Fri, 19 Mar 2021 00:33:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3CDC60636;
	Fri, 19 Mar 2021 00:33:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2CECC000A;
	Fri, 19 Mar 2021 00:33:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE8C0C0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90746400F2
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yi2_sAuZnVu3 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 00:33:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FD1F400F4
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 00:33:33 +0000 (UTC)
IronPort-SDR: 3gPqo08NgrkGgHzxJpGtMY0cj4vslzwA8XBpp7lEC+0JWCythEL5OewrVq3jG+96XhqBt+z83D
 JjrfxBSa5dzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="177386996"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="177386996"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 17:33:33 -0700
IronPort-SDR: 0/JsqJBylArNAIBpJ7LxsLsII1vjAYkOSgqtkQiYZdmGuvV1QVD3qNPKYKvEm5OlYlLcVAsghg
 iuULiUPWziCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; d="scan'208";a="434069868"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2021 17:33:30 -0700
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove WO permissions on second-level
 paging entries
To: Joerg Roedel <joro@8bytes.org>, "Raj, Ashok" <ashok.raj@intel.com>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
 <20210225062654.2864322-3-baolu.lu@linux.intel.com>
 <20210304122623.GD26414@8bytes.org>
 <c7bffaee-6c3c-3254-a71a-d66d023d1e58@linux.intel.com>
 <20210308194746.GA15436@otc-nc-03> <YFMZjiGT13S2TZ6H@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9b7d09e6-9295-df7c-9197-5e22f6ad2c39@linux.intel.com>
Date: Fri, 19 Mar 2021 08:24:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFMZjiGT13S2TZ6H@8bytes.org>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Joerg,

On 3/18/21 5:12 PM, Joerg Roedel wrote:
> Hi,
> 
> On Mon, Mar 08, 2021 at 11:47:46AM -0800, Raj, Ashok wrote:
>> That is the primary motivation, given that we have moved to 1st level for
>> general IOVA, first level doesn't have a WO mapping. I didn't know enough
>> about the history to determine if a WO without a READ is very useful. I
>> guess the ZLR was invented to support those cases without a READ in PCIe. I
> 
> Okay, please update the commit message and re-send. I guess these
> patches are 5.13 stuff. In that case, Baolu can include them into his
> pull request later this cycle.

Okay! It works for me.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
