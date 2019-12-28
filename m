Return-Path: <SRS0=ehPZ=2S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA30C2D0C8
	for <iommu@archiver.kernel.org>; Sat, 28 Dec 2019 03:27:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E018520CC7
	for <iommu@archiver.kernel.org>; Sat, 28 Dec 2019 03:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E018520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ABD402040B;
	Sat, 28 Dec 2019 03:27:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fRueK6KXO4FV; Sat, 28 Dec 2019 03:27:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 57E4B203F4;
	Sat, 28 Dec 2019 03:27:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 237EAC1AE8;
	Sat, 28 Dec 2019 03:27:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D8D2C0881
 for <iommu@lists.linux-foundation.org>; Sat, 28 Dec 2019 03:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6684F81F4D
 for <iommu@lists.linux-foundation.org>; Sat, 28 Dec 2019 03:27:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id itNvBuZZBK-9 for <iommu@lists.linux-foundation.org>;
 Sat, 28 Dec 2019 03:27:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9FD5281135
 for <iommu@lists.linux-foundation.org>; Sat, 28 Dec 2019 03:27:25 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Dec 2019 19:27:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,365,1571727600"; d="scan'208";a="243387313"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2019 19:27:22 -0800
Subject: Re: [PATCH 1/1] iommu/vt-d: trace: Extend map_sg trace event
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <20191211014255.8020-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3e78f293-369b-3764-842f-7c1773b9e7b7@linux.intel.com>
Date: Sat, 28 Dec 2019 11:26:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211014255.8020-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

On 12/11/19 9:42 AM, Lu Baolu wrote:
> Current map_sg stores trace message in a coarse manner. This
> extends it so that more detailed messages could be traced.
> 
> The map_sg trace message looks like:
> 
> map_sg: dev=0000:00:17.0 [1/9] dev_addr=0xf8f90000 phys_addr=0x158051000 size=4096
> map_sg: dev=0000:00:17.0 [2/9] dev_addr=0xf8f91000 phys_addr=0x15a858000 size=4096
> map_sg: dev=0000:00:17.0 [3/9] dev_addr=0xf8f92000 phys_addr=0x15aa13000 size=4096
> map_sg: dev=0000:00:17.0 [4/9] dev_addr=0xf8f93000 phys_addr=0x1570f1000 size=8192
> map_sg: dev=0000:00:17.0 [5/9] dev_addr=0xf8f95000 phys_addr=0x15c6d0000 size=4096
> map_sg: dev=0000:00:17.0 [6/9] dev_addr=0xf8f96000 phys_addr=0x157194000 size=4096
> map_sg: dev=0000:00:17.0 [7/9] dev_addr=0xf8f97000 phys_addr=0x169552000 size=4096
> map_sg: dev=0000:00:17.0 [8/9] dev_addr=0xf8f98000 phys_addr=0x169dde000 size=4096
> map_sg: dev=0000:00:17.0 [9/9] dev_addr=0xf8f99000 phys_addr=0x148351000 size=4096
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

Queued for v5.6.

Thanks,
-baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
