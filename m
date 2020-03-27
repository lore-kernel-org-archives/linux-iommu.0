Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFADC2D0E7
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 09:36:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D59220717
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 09:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D59220717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 30CE98948E;
	Fri, 27 Mar 2020 09:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HyobL26YvKG8; Fri, 27 Mar 2020 09:36:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ECA6C89483;
	Fri, 27 Mar 2020 09:36:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0608C1D7C;
	Fri, 27 Mar 2020 09:36:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30A7EC0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 09:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1BA5B876A3
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 09:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7e0g0rwzx4IU for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 09:36:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 28F84876A2
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 09:36:03 +0000 (UTC)
IronPort-SDR: NU1hpC+zVwe+sBKPkEKt3NQ1+AmPOOxVQLb2HjZjVjihYVmjXAeO/4PpPoWPIDGSrrugKBiSd5
 DA8l6lmX/xgg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 02:36:02 -0700
IronPort-SDR: +J6BhKHwDJRbb0Qqdjfe7GOiwm1GBFBtGnQvQ6vcJoYTo4kyFYkOsyLHALdnMb9MDfqiiLkhO8
 MImk396YjJtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; d="scan'208";a="447352296"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga005.fm.intel.com with ESMTP; 27 Mar 2020 02:36:02 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 02:36:01 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Mar 2020 02:35:58 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 27 Mar 2020 02:35:58 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.201]) with mapi id 14.03.0439.000;
 Fri, 27 Mar 2020 17:35:53 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Alex Williamson <alex.williamson@redhat.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>
Subject: RE: [PATCH 04/10] iommu/ioasid: Rename ioasid_set_data to avoid
 confusion with ioasid_set
Thread-Topic: [PATCH 04/10] iommu/ioasid: Rename ioasid_set_data to avoid
 confusion with ioasid_set
Thread-Index: AQHWAs3JwTfH78x/akKyskCgOsBZeahcMC4g
Date: Fri, 27 Mar 2020 09:35:51 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED499@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-5-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1585158931-1825-5-git-send-email-jacob.jun.pan@linux.intel.com>
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
> IOASID set refers to a group of IOASIDs that shares the same token.
> ioasid_set_data() function is used to attach a private data to an IOASID,
> rename it to ioasid_attach_data() avoid being confused with the group/set
> concept.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 11 ++++++-----
>  drivers/iommu/ioasid.c    |  6 +++---
>  include/linux/ioasid.h    |  4 ++--
>  3 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index b6405df6cfb5..1991587fd3fd 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -319,14 +319,15 @@ int intel_svm_bind_gpasid(struct iommu_domain
> *domain,
>  			svm->gpasid = data->gpasid;
>  			svm->flags |= SVM_FLAG_GUEST_PASID;
>  		}
> -		ioasid_set_data(data->hpasid, svm);
> +
> +		ioasid_attach_data(data->hpasid, svm);
>  		INIT_LIST_HEAD_RCU(&svm->devs);
>  		mmput(svm->mm);
>  	}
>  	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
>  	if (!sdev) {
>  		if (list_empty(&svm->devs)) {
> -			ioasid_set_data(data->hpasid, NULL);
> +			ioasid_attach_data(data->hpasid, NULL);
>  			kfree(svm);
>  		}
>  		ret = -ENOMEM;
> @@ -346,7 +347,7 @@ int intel_svm_bind_gpasid(struct iommu_domain
> *domain,
>  		 * was allocated in this function.
>  		 */
>  		if (list_empty(&svm->devs)) {
> -			ioasid_set_data(data->hpasid, NULL);
> +			ioasid_attach_data(data->hpasid, NULL);
>  			kfree(svm);
>  		}
>  		goto out;
> @@ -375,7 +376,7 @@ int intel_svm_bind_gpasid(struct iommu_domain
> *domain,
>  		 */
>  		kfree(sdev);
>  		if (list_empty(&svm->devs)) {
> -			ioasid_set_data(data->hpasid, NULL);
> +			ioasid_attach_data(data->hpasid, NULL);
>  			kfree(svm);
>  		}
>  		goto out;
> @@ -438,7 +439,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int
> pasid)
>  				 * that PASID allocated by one guest cannot
> be
>  				 * used by another.
>  				 */
> -				ioasid_set_data(pasid, NULL);
> +				ioasid_attach_data(pasid, NULL);
>  				kfree(svm);
>  			}
>  		}
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 27ee57f7079b..6265d2dbbced 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -292,14 +292,14 @@ void ioasid_unregister_allocator(struct
> ioasid_allocator_ops *ops)
>  EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
> 
>  /**
> - * ioasid_set_data - Set private data for an allocated ioasid
> + * ioasid_attach_data - Set private data for an allocated ioasid
>   * @ioasid: the ID to set data
>   * @data:   the private data
>   *
>   * For IOASID that is already allocated, private data can be set
>   * via this API. Future lookup can be done via ioasid_find.
>   */
> -int ioasid_set_data(ioasid_t ioasid, void *data)
> +int ioasid_attach_data(ioasid_t ioasid, void *data)
>  {
>  	struct ioasid_data *ioasid_data;
>  	int ret = 0;
> @@ -321,7 +321,7 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
> 
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(ioasid_set_data);
> +EXPORT_SYMBOL_GPL(ioasid_attach_data);
> 
>  /**
>   * ioasid_alloc - Allocate an IOASID
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index be158e03c034..8c82d2625671 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -39,7 +39,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  		  bool (*getter)(void *));
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
> -int ioasid_set_data(ioasid_t ioasid, void *data);
> +int ioasid_attach_data(ioasid_t ioasid, void *data);
>  void ioasid_install_capacity(ioasid_t total);
>  int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
>  void ioasid_free_set(int sid, bool destroy_set);
> @@ -79,7 +79,7 @@ static inline void ioasid_unregister_allocator(struct
> ioasid_allocator_ops *allo
>  {
>  }
> 
> -static inline int ioasid_set_data(ioasid_t ioasid, void *data)
> +static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
>  {
>  	return -ENOTSUPP;
>  }
> --
> 2.7.4

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
