Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117DBC2D0E8
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 09:42:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2D220714
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 09:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2D220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A0A09876A0;
	Fri, 27 Mar 2020 09:42:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sz9NTSbSl4cQ; Fri, 27 Mar 2020 09:42:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C239A876A2;
	Fri, 27 Mar 2020 09:42:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8DC7C1D7C;
	Fri, 27 Mar 2020 09:42:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 926AFC0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 09:42:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7777B2634F
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 09:42:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mShaBTz7WD0C for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 09:42:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 5DF40262FC
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 09:42:02 +0000 (UTC)
IronPort-SDR: iYhllJ9xc7XJGOHEhAekWqef7EpBeuF9CTibU2ntpEn6ZNwhDWBs1QB8NKBNbRfYt/yl/zML0r
 i3pXLL4f/hGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 02:42:02 -0700
IronPort-SDR: KQao65mOFi7EgkiDDxwh0udbLC5apBGXs2lMo4Yg7em70OoLWq7BNZhQQHtkaUhSOuc1wZ7ISs
 JOC6GQbqk+kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; d="scan'208";a="271515549"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2020 02:42:02 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 02:42:01 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 02:42:01 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.96]) with mapi id 14.03.0439.000;
 Fri, 27 Mar 2020 17:41:57 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Alex Williamson <alex.williamson@redhat.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>
Subject: RE: [PATCH 05/10] iommu/ioasid: Create an IOASID set for host SVA use
Thread-Topic: [PATCH 05/10] iommu/ioasid: Create an IOASID set for host SVA use
Thread-Index: AQHWAs3KC1709AUDMEKcaU76snqwOKhcMJxw
Date: Fri, 27 Mar 2020 09:41:55 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED4DA@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
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
> Sent: Thursday, March 26, 2020 1:55 AM
> 
> Bare metal SVA allocates IOASIDs for native process addresses. This
> should be separated from VM allocated IOASIDs thus under its own set.

A curious question. Now bare metal SVA uses the system set and guest
SVA uses dynamically-created set. Then do we still allow ioasid_alloc
with a NULL set pointer?

> 
> This patch creates a system IOASID set with its quota set to PID_MAX.
> This is a reasonable default in that SVM capable devices can only bind
> to limited user processes.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 8 +++++++-
>  drivers/iommu/ioasid.c      | 9 +++++++++
>  include/linux/ioasid.h      | 9 +++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ec3fc121744a..af7a1ef7b31e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3511,8 +3511,14 @@ static int __init init_dmars(void)
>  		goto free_iommu;
> 
>  	/* PASID is needed for scalable mode irrespective to SVM */
> -	if (intel_iommu_sm)
> +	if (intel_iommu_sm) {
>  		ioasid_install_capacity(intel_pasid_max_id);
> +		/* We should not run out of IOASIDs at boot */
> +		if (ioasid_alloc_system_set(PID_MAX_DEFAULT)) {
> +			pr_err("Failed to enable host PASID allocator\n");
> +			intel_iommu_sm = 0;
> +		}
> +	}
> 
>  	/*
>  	 * for each drhd
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 6265d2dbbced..9135af171a7c 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -39,6 +39,9 @@ struct ioasid_data {
>  static ioasid_t ioasid_capacity;
>  static ioasid_t ioasid_capacity_avail;
> 
> +int system_ioasid_sid;
> +static DECLARE_IOASID_SET(system_ioasid);
> +
>  /* System capacity can only be set once */
>  void ioasid_install_capacity(ioasid_t total)
>  {
> @@ -51,6 +54,12 @@ void ioasid_install_capacity(ioasid_t total)
>  }
>  EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> 
> +int ioasid_alloc_system_set(int quota)
> +{
> +	return ioasid_alloc_set(&system_ioasid, quota, &system_ioasid_sid);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_alloc_system_set);
> +
>  /*
>   * struct ioasid_allocator_data - Internal data structure to hold information
>   * about an allocator. There are two types of allocators:
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 8c82d2625671..097b1cc043a3 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -29,6 +29,9 @@ struct ioasid_allocator_ops {
>  	void *pdata;
>  };
> 
> +/* Shared IOASID set for reserved for host system use */
> +extern int system_ioasid_sid;
> +
>  #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
> 
>  #if IS_ENABLED(CONFIG_IOASID)
> @@ -41,6 +44,7 @@ int ioasid_register_allocator(struct ioasid_allocator_ops
> *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
>  void ioasid_install_capacity(ioasid_t total);
> +int ioasid_alloc_system_set(int quota);
>  int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
>  void ioasid_free_set(int sid, bool destroy_set);
>  int ioasid_find_sid(ioasid_t ioasid);
> @@ -88,5 +92,10 @@ static inline void ioasid_install_capacity(ioasid_t total)
>  {
>  }
> 
> +static inline int ioasid_alloc_system_set(int quota)
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
