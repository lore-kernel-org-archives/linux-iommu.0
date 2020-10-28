Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5163DC388F7
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 05:11:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D7B22228
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 05:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D7B22228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 72624873F7;
	Wed, 28 Oct 2020 05:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MBb73Wbw8a2L; Wed, 28 Oct 2020 05:11:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7071B873FD;
	Wed, 28 Oct 2020 05:11:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A4E6C0859;
	Wed, 28 Oct 2020 05:11:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D6A5C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 05:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E7FD873FD
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 05:11:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DtYXKd7bAZhQ for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 05:11:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 862E3873F7
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 05:11:49 +0000 (UTC)
IronPort-SDR: RPexoJEZ4ekNXNnYCDzdZXgLUlhbQfEBRAEec2rck1/ypTgRQXvtLuK2H1OeMKiCeWHV/FVNKs
 R5Bm8GSL8M8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="148061352"
X-IronPort-AV: E=Sophos;i="5.77,425,1596524400"; d="scan'208";a="148061352"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2020 22:11:49 -0700
IronPort-SDR: 06Nj1yeR/gOtyPo0s3/iFBvRnOx08yW+yJMqRcUIQNe1QifzaUzY49RJPmvrknTguWtdCKAzLE
 T9f69de5Gaqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,425,1596524400"; d="scan'208";a="424622448"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 27 Oct 2020 22:11:47 -0700
Subject: Re: [PATCH v1 3/3] iommu/vt-d: Fix a bug for PDP check in
 prq_event_thread
To: Yi Sun <yi.y.sun@linux.intel.com>, joro@8bytes.org, dwmw2@infradead.org
References: <1603849018-6578-1-git-send-email-yi.y.sun@linux.intel.com>
 <1603849018-6578-4-git-send-email-yi.y.sun@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5d43f0bd-c291-204e-973d-d496488f7a9d@linux.intel.com>
Date: Wed, 28 Oct 2020 13:05:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603849018-6578-4-git-send-email-yi.y.sun@linux.intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hi Yi,

On 10/28/20 9:36 AM, Yi Sun wrote:
> From: "Liu, Yi L" <yi.l.liu@intel.com>

Can you please add some description here? How far should this patch back
ported? A Fixes tag?

Best regards,
baolu

> 
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>   drivers/iommu/intel/svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 75d9dc9..1870248 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1032,7 +1032,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   			resp.qw0 = QI_PGRP_PASID(req->pasid) |
>   				QI_PGRP_DID(req->rid) |
>   				QI_PGRP_PASID_P(req->pasid_present) |
> -				QI_PGRP_PDP(req->pasid_present) |
> +				QI_PGRP_PDP(req->priv_data_present) |
>   				QI_PGRP_RESP_CODE(result) |
>   				QI_PGRP_RESP_TYPE;
>   			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
