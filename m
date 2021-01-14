Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4682C433DB
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 13:26:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEC523A5E
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 13:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEC523A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1858186208;
	Thu, 14 Jan 2021 13:26:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wNlZ2v5TTqFQ; Thu, 14 Jan 2021 13:26:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7523D85EB4;
	Thu, 14 Jan 2021 13:26:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59074C088B;
	Thu, 14 Jan 2021 13:26:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF22C013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 13:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 177822042E
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 13:26:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z5OSd0XRQee6 for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 13:26:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 512CF2041F
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 13:26:31 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3668623A58;
 Thu, 14 Jan 2021 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610630790;
 bh=pUHiAeG5B7eg+14rQEcLNRaPP+p/BvCBAhX+WbpqzEo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kL+7l6nV0RlFWn8vNRaoNotAHdkSEZNQTh1EFxa2ZZLqXOiOAX4Ji0NuL/7eL3sI1
 RrUcIt8olVZjn10misz9gXVu9x+wjWzv1XEs1+3xrIOFhUnMv6NOHcd4woFkej9cHi
 wi7c9P64wViO1q4AOuubR3XOUDvSP9Ck9vUbnyUm9o59jNS53aGBCttL/Ck2S2/LoC
 QCxgyFkZ4A1/xCrfN6uuejigAsjuTgY0hBtCzXaBTtKbgUE8Mfy1EP5+5G2TsdAqGl
 QQ9b3PJpBkzBDi+VyLBuULL4JiTiDtfC2GoHXkqt77ZrhzNIXbKJ+RYlfsJMq1H1nZ
 JdWjA4IjRRnjw==
Date: Thu, 14 Jan 2021 15:26:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH v3 1/2] iommu: Add capability IOMMU_CAP_VIOMMU
Message-ID: <20210114132627.GA944463@unreal>
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
 <20210114013003.297050-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210114013003.297050-2-baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 sanjay.k.kumar@intel.com, mona.hossain@intel.com, samuel.ortiz@intel.com,
 kwankhede@nvidia.com, will@kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, netanelg@mellanox.com,
 maz@kernel.org, vkoul@kernel.org, jgg@mellanox.com, yan.y.zhao@linux.intel.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, bhelgaas@google.com, tglx@linutronix.de,
 megha.dey@intel.com, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 dmaengine@vger.kernel.org, pbonzini@redhat.com, dwmw2@infradead.org
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

On Thu, Jan 14, 2021 at 09:30:02AM +0800, Lu Baolu wrote:
> Some vendor IOMMU drivers are able to declare that it is running in a VM
> context. This is very valuable for the features that only want to be
> supported on bare metal. Add a capability bit so that it could be used.

And how is it used? Who and how will set it?

>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c  | 20 ++++++++++++++++++++
>  drivers/iommu/virtio-iommu.c |  9 +++++++++
>  include/linux/iommu.h        |  1 +
>  3 files changed, 30 insertions(+)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cb205a04fe4c..8eb022d0e8aa 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5738,12 +5738,32 @@ static inline bool nested_mode_support(void)
>  	return ret;
>  }
>
> +static inline bool caching_mode_enabled(void)
> +{

Kernel coding style is not in favour of inline functions in *.c files.

> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu;
> +	bool ret = false;
> +
> +	rcu_read_lock();
> +	for_each_active_iommu(iommu, drhd) {
> +		if (cap_caching_mode(iommu->cap)) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
>  static bool intel_iommu_capable(enum iommu_cap cap)
>  {
>  	if (cap == IOMMU_CAP_CACHE_COHERENCY)
>  		return domain_update_iommu_snooping(NULL) == 1;
>  	if (cap == IOMMU_CAP_INTR_REMAP)
>  		return irq_remapping_enabled == 1;
> +	if (cap == IOMMU_CAP_VIOMMU)
> +		return caching_mode_enabled();
>
>  	return false;
>  }
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 2bfdd5734844..719793e103db 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -931,7 +931,16 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	return iommu_fwspec_add_ids(dev, args->args, 1);
>  }
>
> +static bool viommu_capable(enum iommu_cap cap)
> +{
> +	if (cap == IOMMU_CAP_VIOMMU)
> +		return true;
> +
> +	return false;
> +}
> +
>  static struct iommu_ops viommu_ops = {
> +	.capable		= viommu_capable,
>  	.domain_alloc		= viommu_domain_alloc,
>  	.domain_free		= viommu_domain_free,
>  	.attach_dev		= viommu_attach_dev,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b95a6f8db6ff..1d24be667a03 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -94,6 +94,7 @@ enum iommu_cap {
>  					   transactions */
>  	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
>  	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
> +	IOMMU_CAP_VIOMMU,		/* IOMMU can declar running in a VM */
>  };
>
>  /*
> --
> 2.25.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
