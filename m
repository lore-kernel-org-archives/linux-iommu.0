Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E014CC2D0EB
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 08:41:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B461A2073B
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 08:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B461A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B375B22865;
	Mon, 30 Mar 2020 08:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zf+p0ICEuRDb; Mon, 30 Mar 2020 08:41:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 01B7D20531;
	Mon, 30 Mar 2020 08:41:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2371C1D7E;
	Mon, 30 Mar 2020 08:41:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30291C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 08:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1E9F0883A8
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 08:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yBwAG5NVn7xp for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 08:41:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4CCC6883AD
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 08:41:12 +0000 (UTC)
IronPort-SDR: XUaqLw1KS9eiWvr6qwwLgex+DY8AzJ4h3r8USMqvZAFpsr/sAT/UOBIP5RZXVJvVzRKTsbPCb0
 dxQOrCV0nDhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 01:41:11 -0700
IronPort-SDR: wGVeRflbVpIH9JGxfzE+chG8cDJEH2vJJukJndIH4VToaUYWtUGnyBgb5ToVkdYz99P+KrnrCz
 RqZPZB/2TjIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,323,1580803200"; d="scan'208";a="237283947"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga007.jf.intel.com with ESMTP; 30 Mar 2020 01:41:10 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 01:40:59 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 01:40:59 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.129]) with mapi id 14.03.0439.000;
 Mon, 30 Mar 2020 16:40:55 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 2/8] vfio/type1: Add vfio_iommu_type1 parameter for
 quota tuning
Thread-Topic: [PATCH v1 2/8] vfio/type1: Add vfio_iommu_type1 parameter for
 quota tuning
Thread-Index: AQHWAEUbX2o9koiJmUSoQpAjbhigyahg28IA
Date: Mon, 30 Mar 2020 08:40:55 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF3C5@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-3-git-send-email-yi.l.liu@intel.com>
In-Reply-To: <1584880325-10561-3-git-send-email-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Sunday, March 22, 2020 8:32 PM
> 
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> This patch adds a module option to make the PASID quota tunable by
> administrator.
> 
> TODO: needs to think more on how to  make the tuning to be per-process.
> 
> Previous discussions:
> https://patchwork.kernel.org/patch/11209429/
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/vfio.c             | 8 +++++++-
>  drivers/vfio/vfio_iommu_type1.c | 7 ++++++-
>  include/linux/vfio.h            | 3 ++-
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index d13b483..020a792 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -2217,13 +2217,19 @@ struct vfio_mm *vfio_mm_get_from_task(struct
> task_struct *task)
>  }
>  EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
> 
> -int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> +int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int quota, int min, int max)
>  {
>  	ioasid_t pasid;
>  	int ret = -ENOSPC;
> 
>  	mutex_lock(&vmm->pasid_lock);
> 
> +	/* update quota as it is tunable by admin */
> +	if (vmm->pasid_quota != quota) {
> +		vmm->pasid_quota = quota;
> +		ioasid_adjust_set(vmm->ioasid_sid, quota);
> +	}
> +

It's a bit weird to have quota adjusted in the alloc path, since the latter might
be initiated by non-privileged users. Why not doing the simple math in vfio_
create_mm to set the quota when the ioasid set is created? even in the future
you may allow per-process quota setting, that should come from separate 
privileged path instead of thru alloc...

>  	pasid = ioasid_alloc(vmm->ioasid_sid, min, max, NULL);
>  	if (pasid == INVALID_IOASID) {
>  		ret = -ENOSPC;
> diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c
> index 331ceee..e40afc0 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -60,6 +60,11 @@ module_param_named(dma_entry_limit,
> dma_entry_limit, uint, 0644);
>  MODULE_PARM_DESC(dma_entry_limit,
>  		 "Maximum number of user DMA mappings per container
> (65535).");
> 
> +static int pasid_quota = VFIO_DEFAULT_PASID_QUOTA;
> +module_param_named(pasid_quota, pasid_quota, uint, 0644);
> +MODULE_PARM_DESC(pasid_quota,
> +		 "Quota of user owned PASIDs per vfio-based application
> (1000).");
> +
>  struct vfio_iommu {
>  	struct list_head	domain_list;
>  	struct list_head	iova_list;
> @@ -2200,7 +2205,7 @@ static int vfio_iommu_type1_pasid_alloc(struct
> vfio_iommu *iommu,
>  		goto out_unlock;
>  	}
>  	if (vmm)
> -		ret = vfio_mm_pasid_alloc(vmm, min, max);
> +		ret = vfio_mm_pasid_alloc(vmm, pasid_quota, min, max);
>  	else
>  		ret = -EINVAL;
>  out_unlock:
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 75f9f7f1..af2ef78 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -106,7 +106,8 @@ struct vfio_mm {
> 
>  extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task);
>  extern void vfio_mm_put(struct vfio_mm *vmm);
> -extern int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int min, int max);
> +extern int vfio_mm_pasid_alloc(struct vfio_mm *vmm,
> +				int quota, int min, int max);
>  extern int vfio_mm_pasid_free(struct vfio_mm *vmm, ioasid_t pasid);
> 
>  /*
> --
> 2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
