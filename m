Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613CAC4363A
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 12:56:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39A1206ED
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 12:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39A1206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F97286927;
	Fri, 30 Oct 2020 12:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id taclTzjoT5n4; Fri, 30 Oct 2020 12:56:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B0A94868EB;
	Fri, 30 Oct 2020 12:56:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A568FC088B;
	Fri, 30 Oct 2020 12:56:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1CC4C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 12:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E0D7686927
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 12:56:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QxolzAnZGUFt for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 12:56:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4DEA3868EB
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 12:56:43 +0000 (UTC)
IronPort-SDR: U7+gfr/m3Mj8vooFBRI3KKbO5E59C4EFylcF8NQ8wA8DEa5a6WNIIl70XDhS1Xrt97TwZ1xISd
 7McaJukXByGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="147886300"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; d="scan'208";a="147886300"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2020 05:56:42 -0700
IronPort-SDR: mfZBZuCyvqRQfQgXl5o5aDDGACTbwr1Tf7cOv/s5vxTubptdl3crp5CdmHeMk5lezIl91PgvRo
 Ear1wf7vEgFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; d="scan'208";a="425339020"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2020 05:56:40 -0700
Subject: Re: [PATCH v2 2/2] iommu/vt-d: Fix a bug for PDP check in
 prq_event_thread
To: Yi Sun <yi.y.sun@linux.intel.com>, joro@8bytes.org, dwmw2@infradead.org,
 jean-philippe@linaro.org
References: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
 <1604025444-6954-3-git-send-email-yi.y.sun@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <429b63d1-1692-2244-f69b-a924e8534131@linux.intel.com>
Date: Fri, 30 Oct 2020 20:49:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604025444-6954-3-git-send-email-yi.y.sun@linux.intel.com>
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

On 10/30/20 10:37 AM, Yi Sun wrote:
> From: "Liu, Yi L" <yi.l.liu@intel.com>
> 
> In prq_event_thread(), the QI_PGRP_PDP is wrongly set by
> 'req->pasid_present' which should be replaced to
> 'req->priv_data_present'.
> 
> Fixes: 5b438f4ba315 ("iommu/vt-d: Support page request in scalable mode")
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>

Cc: stable@ver.kernel.org
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 7584669..3242ebd 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -1035,7 +1035,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
