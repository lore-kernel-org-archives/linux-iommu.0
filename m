Return-Path: <SRS0=ehPZ=2S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D24C2D0C3
	for <iommu@archiver.kernel.org>; Sat, 28 Dec 2019 02:47:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDB820882
	for <iommu@archiver.kernel.org>; Sat, 28 Dec 2019 02:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDB820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 157D78140D;
	Sat, 28 Dec 2019 02:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uuGj-zpTdsuJ; Sat, 28 Dec 2019 02:47:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8F295811DC;
	Sat, 28 Dec 2019 02:47:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CB41C18DD;
	Sat, 28 Dec 2019 02:47:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29382C0881
 for <iommu@lists.linux-foundation.org>; Sat, 28 Dec 2019 02:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1811B85618
 for <iommu@lists.linux-foundation.org>; Sat, 28 Dec 2019 02:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0kqtSg9REYcY for <iommu@lists.linux-foundation.org>;
 Sat, 28 Dec 2019 02:47:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 822B3822C6
 for <iommu@lists.linux-foundation.org>; Sat, 28 Dec 2019 02:47:38 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Dec 2019 18:47:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,365,1571727600"; d="scan'208";a="243382294"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2019 18:47:35 -0800
Subject: Re: [PATCH v5 0/8] VT-d Native Shared virtual memory cleanup and fixes
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1575316709-54903-1-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a42c945a-2c64-8f2d-d211-396a4f3f753f@linux.intel.com>
Date: Sat, 28 Dec 2019 10:46:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575316709-54903-1-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Joe Perches <joe@perches.com>
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

On 12/3/19 3:58 AM, Jacob Pan wrote:
> Mostly extracted from nested SVA/SVM series based on review comments of v7.
> https://lkml.org/lkml/2019/10/24/852
> 
> This series also adds a few important fixes for native use of SVA. Nested
> SVA new code will be submitted separately as a smaller set. Based on the
> core branch of IOMMU tree staged for v5.5, where common APIs for vSVA were
> applied.
> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git core

Queued the whole series for v5.6.

Thanks,
-baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
