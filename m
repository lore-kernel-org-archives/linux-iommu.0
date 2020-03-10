Return-Path: <SRS0=VQ5+=43=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF07EC10F25
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 01:26:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD7624654
	for <iommu@archiver.kernel.org>; Tue, 10 Mar 2020 01:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD7624654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C319887B0;
	Tue, 10 Mar 2020 01:26:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xrHIFyNJL+te; Tue, 10 Mar 2020 01:26:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E5428879C;
	Tue, 10 Mar 2020 01:26:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44F13C1D74;
	Tue, 10 Mar 2020 01:26:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E02FC0177
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 01:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 220832045F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 01:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zhSndUbXUV70 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Mar 2020 01:25:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 28B7C2044C
 for <iommu@lists.linux-foundation.org>; Tue, 10 Mar 2020 01:25:58 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 18:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; d="scan'208";a="235771173"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.55])
 ([10.254.215.55])
 by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2020 18:25:56 -0700
Subject: Re: [Patch V1 1/2] iommu/vt-d: Fix debugfs register reads
To: Megha Dey <megha.dey@linux.intel.com>, dwmw2@infradead.org,
 iommu@lists.linux-foundation.org
References: <1583784587-26126-1-git-send-email-megha.dey@linux.intel.com>
 <1583784587-26126-2-git-send-email-megha.dey@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6d55f086-7c84-c9fa-6207-387ccf1ef9a9@linux.intel.com>
Date: Tue, 10 Mar 2020 09:25:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583784587-26126-2-git-send-email-megha.dey@linux.intel.com>
Content-Language: en-US
Cc: megha.dey@intel.com
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

On 2020/3/10 4:09, Megha Dey wrote:
> Commit 6825d3ea6cde ("iommu/vt-d: Add debugfs support to show register
> contents") dumps the register contents for all IOMMU devices.
> 
> Currently, a 64 bit read(dmar_readq) is done for all the IOMMU registers,
> even though some of the registers are 32 bits, which is incorrect.
> 
> Use the correct read function variant (dmar_readl/dmar_readq) while
> reading the contents of 32/64 bit registers respectively.
> 
> Signed-off-by: Megha Dey <megha.dey@linux.intel.com>

Fixes: 6825d3ea6cdea ("iommu/vt-d: Add debugfs support to show register 
contents")
Cc: Cc: stable@vger.kernel.org # v4.20

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
