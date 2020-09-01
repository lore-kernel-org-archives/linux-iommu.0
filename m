Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66032C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 17:03:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFE4206FA
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 17:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxO1NOeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFE4206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F184D85D3D;
	Tue,  1 Sep 2020 17:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ibjN2PRrr-j7; Tue,  1 Sep 2020 17:03:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1544184CC2;
	Tue,  1 Sep 2020 17:03:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC773C0052;
	Tue,  1 Sep 2020 17:03:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E7A2C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8A70D8693F
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id giNof+jrpX7L for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 17:03:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9D048869AD
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598979811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWFn91v9jwxb4FQ+OzyyCBPLeQ75xcVaOZUTQVfcSyQ=;
 b=IxO1NOePKW/eMeSN5IJR0jdxbtHaRagApRRQ5CmByTgICO7KzCJEZgP+xswgP7m69h1XNE
 +zCgECAdBxziLGhfK/e/P09My1zYNEW0jsb+KMEt5XPOMgCtKsMcSJypr3x46z8Ky9ZgQE
 5iaDFb9TPf2cKrwL+se7EQ5fqKVtfPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-TDnHW8uOOv-P_WcGfmNhSw-1; Tue, 01 Sep 2020 13:03:29 -0400
X-MC-Unique: TDnHW8uOOv-P_WcGfmNhSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ACA110ABDA1;
 Tue,  1 Sep 2020 17:03:28 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C29360BE2;
 Tue,  1 Sep 2020 17:03:25 +0000 (UTC)
Subject: Re: [PATCH v2 7/9] iommu/vt-d: Listen to IOASID notifications
To: Jacob Pan <jacob.pan.linux@gmail.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-8-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e9394a9e-c9d0-9ebc-30a7-745e6b6d8fa0@redhat.com>
Date: Tue, 1 Sep 2020 19:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1598070918-21321-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Wu Hao <hao.wu@intel.com>
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

Hi Jacob,

On 8/22/20 6:35 AM, Jacob Pan wrote:
> On Intel Scalable I/O Virtualization (SIOV) enabled platforms, IOMMU
> driver is one of the users of IOASIDs. In normal flow, callers will
> perform IOASID allocation, bind, unbind, and free in order. However, for
> guest SVA, IOASID free could come before unbind as guest is untrusted.
> This patch registers IOASID notification handler such that IOMMU driver
> can perform PASID teardown upon receiving an unexpected IOASID free
> event.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/intel-iommu.h |  2 ++
>  2 files changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 634e191ca2c3..600e3ae5b656 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -95,6 +95,72 @@ static inline bool intel_svm_capable(struct intel_iommu *iommu)
>  	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
>  }
>  
> +#define pasid_lock_held() lock_is_held(&pasid_mutex.dep_map)
put after the pasid_mutex definition?
> +static DEFINE_MUTEX(pasid_mutex);
> +
> +static void intel_svm_free_async_fn(struct work_struct *work)
> +{
> +	struct intel_svm *svm = container_of(work, struct intel_svm, work);
> +	struct intel_svm_dev *sdev;
> +
> +	/*
> +	 * Unbind all devices associated with this PASID which is
> +	 * being freed by other users such as VFIO.
> +	 */
> +	mutex_lock(&pasid_mutex);
> +	list_for_each_entry_rcu(sdev, &svm->devs, list, pasid_lock_held()) {
> +		/* Does not poison forward pointer */
> +		list_del_rcu(&sdev->list);
> +		spin_lock(&svm->iommu->lock);
> +		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
> +					svm->pasid, true);
> +		spin_unlock(&svm->iommu->lock);
> +		kfree_rcu(sdev, rcu);
> +		/*
> +		 * Free before unbind only happens with guest usaged
usaged?
> +		 * host PASIDs. IOASID free will detach private data
> +		 * and free the IOASID entry.
> +		 */
> +		ioasid_put(NULL, svm->pasid);
> +		if (list_empty(&svm->devs))
> +			kfree(svm);
> +	}
> +	mutex_unlock(&pasid_mutex);
> +}
> +
> +
> +static int pasid_status_change(struct notifier_block *nb,
> +				unsigned long code, void *data)
> +{
> +	struct ioasid_nb_args *args = (struct ioasid_nb_args *)data;
> +	struct intel_svm *svm = (struct intel_svm *)args->pdata;
> +	int ret = NOTIFY_DONE;
> +
> +	if (code == IOASID_FREE) {
> +		if (!svm)
> +			goto done;
> +		if (args->id != svm->pasid) {
> +			pr_warn("Notify PASID does not match data %d : %d\n",
> +				args->id, svm->pasid);
> +			goto done;
> +		}
> +		schedule_work(&svm->work);
> +		return NOTIFY_OK;
> +	}
> +done:
> +	return ret;> +}
> +
> +static struct notifier_block pasid_nb = {
> +	.notifier_call = pasid_status_change,
> +};
> +
> +void intel_svm_add_pasid_notifier(void)
> +{
> +	/* Listen to all PASIDs, not specific to a set */
> +	ioasid_register_notifier(NULL, &pasid_nb);
> +}
> +
>  void intel_svm_check(struct intel_iommu *iommu)
>  {
>  	if (!pasid_supported(iommu))
> @@ -221,7 +287,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
>  	.invalidate_range = intel_invalidate_range,
>  };
>  
> -static DEFINE_MUTEX(pasid_mutex);
>  static LIST_HEAD(global_svm_list);
>  
>  #define for_each_svm_dev(sdev, svm, d)			\
> @@ -342,7 +407,14 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  			svm->gpasid = data->gpasid;
>  			svm->flags |= SVM_FLAG_GUEST_PASID;
>  		}
> +		svm->iommu = iommu;
> +		/*
> +		 * Set up cleanup async work in case IOASID core notify us PASID
> +		 * is freed before unbind.
> +		 */
> +		INIT_WORK(&svm->work, intel_svm_free_async_fn);
>  		ioasid_attach_data(data->hpasid, svm);
> +		ioasid_get(NULL, svm->pasid);
>  		INIT_LIST_HEAD_RCU(&svm->devs);
>  		mmput(svm->mm);
>  	}
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index b1ed2f25f7c0..d36038e6ae0b 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
>  int intel_svm_get_pasid(struct iommu_sva *handle);
>  int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
>  			    struct iommu_page_response *msg);
> +void intel_svm_add_pasid_notifier(void);
>  
>  struct svm_dev_ops;
>  
> @@ -770,6 +771,7 @@ struct intel_svm {
>  	int gpasid; /* In case that guest PASID is different from host PASID */
>  	struct list_head devs;
>  	struct list_head list;
> +	struct work_struct work; /* For deferred clean up */
>  };
>  #else
>  static inline void intel_svm_check(struct intel_iommu *iommu) {}
> 

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
