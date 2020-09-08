Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50424C433E2
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 09:46:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF94D2076C
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 09:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqZrtcD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF94D2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9372685D6E;
	Tue,  8 Sep 2020 09:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZ2qs56J0Aok; Tue,  8 Sep 2020 09:46:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B1E3D8587E;
	Tue,  8 Sep 2020 09:46:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 950E8C0859;
	Tue,  8 Sep 2020 09:46:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0F9BC0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 09:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B4EAB8695F
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 09:46:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mHoyQ4vucg1s for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 09:46:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A18328693F
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599558379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpFRYvxB5/oyLlSWmwbvAKnlXaCKfBhqWxw1f+LqQf4=;
 b=cqZrtcD9yPUhjSczqh4FZqUItY8hyvytVHUSvkdCOizJCMc5RYpWODZ9d7GjdMi/TD+mrN
 7OlUIqr95BJc0nbuJ8/KgWFU/2zEGuvEVN2KNi60NkctiQ8AOC52nywWjAdM6Lc3uM6uuy
 K9KZ/ys6MjsPbghIBP/qLkzPpjwiCoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-suzd7PWYPUKGKe8h7pc-8Q-1; Tue, 08 Sep 2020 05:46:15 -0400
X-MC-Unique: suzd7PWYPUKGKe8h7pc-8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14A1464083;
 Tue,  8 Sep 2020 09:46:13 +0000 (UTC)
Received: from [10.36.114.107] (ovpn-114-107.ams2.redhat.com [10.36.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 859FB3A40;
 Tue,  8 Sep 2020 09:46:08 +0000 (UTC)
Subject: Re: [PATCH RESEND v9 11/13] iommu/arm-smmu-v3: Add SVA device feature
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
References: <20200817171558.325917-1-jean-philippe@linaro.org>
 <20200817171558.325917-12-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e77d3f31-020c-d5cf-1af2-d584e62112b2@redhat.com>
Date: Tue, 8 Sep 2020 11:46:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200817171558.325917-12-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: fenghua.yu@intel.com, will@kernel.org, zhengxiang9@huawei.com,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com
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

Hi Jean,

On 8/17/20 7:15 PM, Jean-Philippe Brucker wrote:
> Implement the IOMMU device feature callbacks to support the SVA feature.
> At the moment dev_has_feat() returns false since I/O Page Faults isn't
> yet implemented.
and because we don't advertise BTM, isn't it?
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 26 ++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 49 ++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 79 +++++++++++++++++++
>  3 files changed, 154 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 7b14b48a26c7..ba34914813ff 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -646,6 +646,8 @@ struct arm_smmu_master {
>  	u32				*sids;
>  	unsigned int			num_sids;
>  	bool				ats_enabled;
> +	bool				sva_enabled;
> +	struct list_head		bonds;
>  	unsigned int			ssid_bits;
>  };
>  
> @@ -687,10 +689,34 @@ bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
>  
>  #ifdef CONFIG_ARM_SMMU_V3_SVA
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
> +bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
> +bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
> +int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
> +int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
>  #else /* CONFIG_ARM_SMMU_V3_SVA */
>  static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  {
>  	return false;
>  }
> +
> +static inline bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
> +{
> +	return false;
> +}
> +
> +static inline bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
> +{
> +	return false;
> +}
> +
> +static inline int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
> +{
> +	return -ENODEV;
> +}
>  #endif /* CONFIG_ARM_SMMU_V3_SVA */
>  #endif /* _ARM_SMMU_V3_H */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index bf81d91ce71e..28027620cf2e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -10,6 +10,8 @@
>  #include "arm-smmu-v3.h"
>  #include "../../io-pgtable-arm.h"
>  
> +static DEFINE_MUTEX(sva_lock);
> +
>  /*
>   * Try to reserve this ASID in the SMMU. If it is in use, try to steal it from
>   * the private entry. Careful here, we may be modifying the context tables of
> @@ -196,3 +198,50 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  
>  	return true;
>  }
> +
> +static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
> +{
> +	return false;
> +}
> +
> +bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
> +{
> +	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
> +		return false;
> +
> +	/* SSID and IOPF support are mandatory for the moment */
> +	return master->ssid_bits && arm_smmu_iopf_supported(master);
> +}
> +
> +bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
> +{
> +	bool enabled;
> +
> +	mutex_lock(&sva_lock);
> +	enabled = master->sva_enabled;
> +	mutex_unlock(&sva_lock);
> +	return enabled;
> +}
> +
> +int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
> +{
> +	mutex_lock(&sva_lock);
> +	master->sva_enabled = true;
> +	mutex_unlock(&sva_lock);
> +
> +	return 0;
> +}
> +
> +int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
> +{
> +	mutex_lock(&sva_lock);
> +	if (!list_empty(&master->bonds)) {
> +		dev_err(master->dev, "cannot disable SVA, device is bound\n");
> +		mutex_unlock(&sva_lock);
> +		return -EBUSY;
> +	}
> +	master->sva_enabled = false;
> +	mutex_unlock(&sva_lock);
> +
> +	return 0;
> +}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 15cb3d9c1a5d..5ed5bb42298f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2163,6 +2163,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	master = dev_iommu_priv_get(dev);
>  	smmu = master->smmu;
>  
> +	/*
> +	 * Checking that SVA is disabled ensures that this device isn't bound to
> +	 * any mm, and can be safely detached from its old domain. Bonds cannot
> +	 * be removed concurrently since we're holding the group mutex.
> +	 */
> +	if (arm_smmu_master_sva_enabled(master)) {
> +		dev_err(dev, "cannot attach - SVA enabled\n");
> +		return -EBUSY;
> +	}
> +
>  	arm_smmu_detach_dev(master);
>  
>  	mutex_lock(&smmu_domain->init_mutex);
> @@ -2310,6 +2320,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  	master->smmu = smmu;
>  	master->sids = fwspec->ids;
>  	master->num_sids = fwspec->num_ids;
> +	INIT_LIST_HEAD(&master->bonds);
>  	dev_iommu_priv_set(dev, master);
>  
>  	/* Check the SIDs are in range of the SMMU and our stream table */
> @@ -2362,6 +2373,7 @@ static void arm_smmu_release_device(struct device *dev)
>  		return;
>  
>  	master = dev_iommu_priv_get(dev);
> +	WARN_ON(arm_smmu_master_sva_enabled(master));
>  	arm_smmu_detach_dev(master);
>  	arm_smmu_disable_pasid(master);
>  	kfree(master);
> @@ -2479,6 +2491,69 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>  	iommu_dma_get_resv_regions(dev, head);
>  }
>  
> +static bool arm_smmu_dev_has_feature(struct device *dev,
> +				     enum iommu_dev_features feat)
> +{
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +
> +	if (!master)
> +		return false;
> +
> +	switch (feat) {
> +	case IOMMU_DEV_FEAT_SVA:
> +		return arm_smmu_master_sva_supported(master);
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool arm_smmu_dev_feature_enabled(struct device *dev,
> +					 enum iommu_dev_features feat)
> +{
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +
> +	if (!master)
> +		return false;
> +
> +	switch (feat) {
> +	case IOMMU_DEV_FEAT_SVA:
> +		return arm_smmu_master_sva_enabled(master);
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int arm_smmu_dev_enable_feature(struct device *dev,
> +				       enum iommu_dev_features feat)
> +{
> +	if (!arm_smmu_dev_has_feature(dev, feat))
> +		return -ENODEV;
> +
> +	if (arm_smmu_dev_feature_enabled(dev, feat))
> +		return -EBUSY;
> +
> +	switch (feat) {
> +	case IOMMU_DEV_FEAT_SVA:
> +		return arm_smmu_master_enable_sva(dev_iommu_priv_get(dev));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int arm_smmu_dev_disable_feature(struct device *dev,
> +					enum iommu_dev_features feat)
> +{
> +	if (!arm_smmu_dev_feature_enabled(dev, feat))
> +		return -EINVAL;
> +
> +	switch (feat) {
> +	case IOMMU_DEV_FEAT_SVA:
> +		return arm_smmu_master_disable_sva(dev_iommu_priv_get(dev));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static struct iommu_ops arm_smmu_ops = {
>  	.capable		= arm_smmu_capable,
>  	.domain_alloc		= arm_smmu_domain_alloc,
> @@ -2497,6 +2572,10 @@ static struct iommu_ops arm_smmu_ops = {
>  	.of_xlate		= arm_smmu_of_xlate,
>  	.get_resv_regions	= arm_smmu_get_resv_regions,
>  	.put_resv_regions	= generic_iommu_put_resv_regions,
> +	.dev_has_feat		= arm_smmu_dev_has_feature,
> +	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
> +	.dev_enable_feat	= arm_smmu_dev_enable_feature,
> +	.dev_disable_feat	= arm_smmu_dev_disable_feature,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  };
>  
> 
Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
