Return-Path: <SRS0=ml75=6Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ECDC54E8E
	for <iommu@archiver.kernel.org>; Sun, 10 May 2020 23:20:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC24E20725
	for <iommu@archiver.kernel.org>; Sun, 10 May 2020 23:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC24E20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8130D868B5;
	Sun, 10 May 2020 23:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SriVZQxVF-TA; Sun, 10 May 2020 23:20:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBAED866C8;
	Sun, 10 May 2020 23:19:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0E44C0888;
	Sun, 10 May 2020 23:19:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCAD9C016F
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 23:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9A82422882
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 23:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNMHxBxFXCI9 for <iommu@lists.linux-foundation.org>;
 Sun, 10 May 2020 23:19:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 7EAA522846
 for <iommu@lists.linux-foundation.org>; Sun, 10 May 2020 23:19:57 +0000 (UTC)
IronPort-SDR: 5IQoU251DZuylIG+aKfz0HBBZAUFRwjzCC8q0Ommx1M5+FKsHbSpIrs1eRZ35S6sbMlhfrGK9t
 MKMxk2y6I4eQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2020 16:19:56 -0700
IronPort-SDR: bMVr+HfzhLC7IDcW8Rgd6plGgxxu9+/Eji/jiXNKDERKa1e19pHZ6VicKFtf8Dpfrh0Rmd2H7z
 fTYtNw4Yfwng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,377,1583222400"; d="scan'208";a="279614189"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by orsmga002.jf.intel.com with ESMTP; 10 May 2020 16:19:53 -0700
Subject: Re: [PATCH v4 0/3] Replace private domain with per-group default
 domain
To: Joerg Roedel <joro@8bytes.org>
References: <20200506015947.28662-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7928dd48-93da-62f0-b455-6e6b248d0fae@linux.intel.com>
Date: Mon, 11 May 2020 07:16:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506015947.28662-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
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

On 5/6/20 9:59 AM, Lu Baolu wrote:
> Some devices are required to use a specific type (identity or dma) of
> default domain when they are used with a vendor iommu. When the system
> level default domain type is different from it, the vendor iommu driver
> has to request a new default domain with either
> iommu_request_dma_domain_for_dev() or iommu_request_dm_for_dev() in the
> add_dev() callback. Unfortunately, these two helpers only work when the
> group hasn't been assigned to any other devices, hence, some vendor iommu
> driver has to use a private domain if it fails to request a new default
> one.
> 
> Joerg proposed an on-going proposal which makes the default domain
> framework to support configuring per-group default domain during boot
> process.
> 
> https://lkml.org/lkml/2020/4/14/616
> [This has been applied in iommu/next.]
> 
> Hence, there is no need to keep the private domain implementation
> in the Intel IOMMU driver. This patch series aims to remove it.

Can you please take this series to iommu/next for wider test?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
