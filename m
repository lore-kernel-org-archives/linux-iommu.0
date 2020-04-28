Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E353C83003
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 01:47:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699C0206D6
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 01:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699C0206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 45CEE87DBA;
	Tue, 28 Apr 2020 01:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KmQwo5LL3wvX; Tue, 28 Apr 2020 01:47:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 67F2287D5E;
	Tue, 28 Apr 2020 01:47:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DA23C013E;
	Tue, 28 Apr 2020 01:47:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CF3CC003B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 01:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 73FCF20372
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 01:47:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uM-cCmvy--Mj for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 01:47:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id AD77B20021
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 01:47:11 +0000 (UTC)
IronPort-SDR: B3ECw5g02uyRqkBqg35JUarhXzgCdP9KwO5ni62dON1/5LwEJ/5MBDPsjxMYfdlef7QVepaysC
 LljBvBXnuHeQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 18:47:11 -0700
IronPort-SDR: HHrSf2zNwP3Z3RdFg6IPqorcVVnRcv8CQUZlxIpElwsFxEhIW4hgKIVeSHPlUpIKgKgfaU1bzD
 H6EaVfMXZcxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; d="scan'208";a="367345195"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.128])
 ([10.254.212.128])
 by fmsmga001.fm.intel.com with ESMTP; 27 Apr 2020 18:47:09 -0700
Subject: Re: [PATCH v3 0/4] iommu/vt-d: Add page request draining support
To: kevin.tian@intel.com
References: <20200422080611.15689-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <714e0552-ae31-fa4a-76fe-d3c38e064e0a@linux.intel.com>
Date: Tue, 28 Apr 2020 09:47:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422080611.15689-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

Hi Kevin,

On 2020/4/22 16:06, Lu Baolu wrote:
> When a PASID is stopped or terminated, there can be pending PRQs
> (requests that haven't received responses) in the software and
> remapping hardware. The pending page requests must be drained
> so that the pasid could be reused. The chapter 7.10 in the VT-d
> specification specifies the software steps to drain pending page
> requests and responses.
> 
> This includes two parts:
>   - PATCH 1/4 ~ 2/4: refactor the qi_submit_sync() to support multiple
>     descriptors per submission which will be used in the following
>     patch.
>   - PATCH 3/4 ~ 4/4: add page request drain support after a pasid entry
>     is torn down.
> 
> Please help to review.
> 
> Best regards,
> baolu
> 
> Change log:
>   v2->v3:
>    - Address Kevin's review comments
>      - Squash the first 2 patches together;
>      - The prq thread is serialized, no need to consider reentrance;
>      - Ensure no new-coming prq before drain prq in queue;
>      - Handle page request overflow case.

Very appreciated for your review comments.

How about these changes? Any comments?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
