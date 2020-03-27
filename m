Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865FDC43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 10:09:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AD3206F8
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 10:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AD3206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 386C089505;
	Fri, 27 Mar 2020 10:09:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OTuvW0ezqQ9M; Fri, 27 Mar 2020 10:09:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C98E3894D6;
	Fri, 27 Mar 2020 10:09:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B36BFC18DA;
	Fri, 27 Mar 2020 10:09:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7970C0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C51FF8789F
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1PXCm3-9QzbK for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 10:09:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AE3C88867B
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 10:09:08 +0000 (UTC)
IronPort-SDR: yDq8S/E+UvzEs1Iy19/ypSwwPROUug49xgm4Cel/qLfi+oB1CQQJMsClz1X7LPJbg8zKuTsVGm
 DFpyomQgH8AQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 03:09:08 -0700
IronPort-SDR: vYNik5jRlOr1t9iI7u03fg1FpbbkeW0t06X+6TIFEEXJ5ibMLcNTeAMGrPiGEsY/K3vQlgNWh8
 AaF9N4NHtYfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; d="scan'208";a="239064083"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga007.fm.intel.com with ESMTP; 27 Mar 2020 03:09:07 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 03:09:08 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Mar 2020 03:09:07 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 27 Mar 2020 03:09:07 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.137]) with mapi id 14.03.0439.000;
 Fri, 27 Mar 2020 18:09:05 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Alex Williamson <alex.williamson@redhat.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>
Subject: RE: [PATCH 09/10] iommu/ioasid: Support ioasid_set quota adjustment
Thread-Topic: [PATCH 09/10] iommu/ioasid: Support ioasid_set quota adjustment
Thread-Index: AQHWAs3NK42wQfu7/kyYiimhS040MqhcOJaQ
Date: Fri, 27 Mar 2020 10:09:04 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED605@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-10-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1585158931-1825-10-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Cameron <jic23@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 26, 2020 1:56 AM
> 
> IOASID set is allocated with an initial quota, at runtime there may be
> needs to balance IOASID resources among different VMs/sets.
> 

I may overlook previous patches but I didn't see any place setting the
initial quota...

> This patch adds a new API to adjust per set quota.

since this is purely an internal kernel API, implies that the publisher
(e.g. VFIO) is responsible for exposing its own uAPI to set the quota?

> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 44
> ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |  6 ++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 27dce2cb5af2..5ac28862a1db 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -578,6 +578,50 @@ void ioasid_free_set(int sid, bool destroy_set)
>  }
>  EXPORT_SYMBOL_GPL(ioasid_free_set);
> 
> +/**
> + * ioasid_adjust_set - Adjust the quota of an IOASID set
> + * @quota:	Quota allowed in this set
> + * @sid:	IOASID set ID to be assigned
> + *
> + * Return 0 on success. If the new quota is smaller than the number of
> + * IOASIDs already allocated, -EINVAL will be returned. No change will be
> + * made to the existing quota.
> + */
> +int ioasid_adjust_set(int sid, int quota)
> +{
> +	struct ioasid_set_data *sdata;
> +	int ret = 0;
> +
> +	mutex_lock(&ioasid_allocator_lock);
> +	sdata = xa_load(&ioasid_sets, sid);
> +	if (!sdata || sdata->nr_ioasids > quota) {
> +		pr_err("Failed to adjust IOASID set %d quota %d\n",
> +			sid, quota);
> +		ret = -EINVAL;
> +		goto done_unlock;
> +	}
> +
> +	if (quota >= ioasid_capacity_avail) {
> +		ret = -ENOSPC;
> +		goto done_unlock;
> +	}
> +
> +	/* Return the delta back to system pool */
> +	ioasid_capacity_avail += sdata->size - quota;
> +
> +	/*
> +	 * May have a policy to prevent giving all available IOASIDs
> +	 * to one set. But we don't enforce here, it should be in the
> +	 * upper layers.
> +	 */
> +	sdata->size = quota;
> +
> +done_unlock:
> +	mutex_unlock(&ioasid_allocator_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_adjust_set);
> 
>  /**
>   * ioasid_find - Find IOASID data
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 32d032913828..6e7de6fb91bf 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -73,6 +73,7 @@ int ioasid_alloc_set(struct ioasid_set *token, ioasid_t
> quota, int *sid);
>  void ioasid_free_set(int sid, bool destroy_set);
>  int ioasid_find_sid(ioasid_t ioasid);
>  int ioasid_notify(ioasid_t id, enum ioasid_notify_val cmd);
> +int ioasid_adjust_set(int sid, int quota);
> 
>  #else /* !CONFIG_IOASID */
>  static inline ioasid_t ioasid_alloc(int sid, ioasid_t min,
> @@ -136,5 +137,10 @@ static inline int ioasid_alloc_system_set(int quota)
>  	return -ENOTSUPP;
>  }
> 
> +static inline int ioasid_adjust_set(int sid, int quota)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> --
> 2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
