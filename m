Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACD6C433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 06:18:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8693D2071B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 06:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8693D2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5FBE3861C8;
	Tue,  1 Sep 2020 06:18:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7RwvR6_La4lf; Tue,  1 Sep 2020 06:18:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 30E4E861C7;
	Tue,  1 Sep 2020 06:18:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20D89C0052;
	Tue,  1 Sep 2020 06:18:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 397B7C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 06:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 15AA820430
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 06:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7buMuq8lcHpK for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 06:18:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id B3E1020409
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 06:18:14 +0000 (UTC)
IronPort-SDR: OO87zDeLXtFn4H5w2J6T8A27Du/MOV0l8s+XpgAV1wJSjVM6owFL6NoLPsExvXfleAOcA64rRC
 F47Y3xawhHNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="157114455"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; d="scan'208";a="157114455"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 23:18:14 -0700
IronPort-SDR: nFa3g5/kWJDLubhnL29MkE2NKcYNROw0N4lxPN+5GWf5Brn+2Yec+1oRg8AQnFy7oOWhovaKe5
 oPNVSOdO7VqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; d="scan'208";a="325219893"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2020 23:18:11 -0700
Subject: Re: [PATCH v3 2/2] iommu/vt-d:Add support for probing ACPI device in
 RMRR
To: FelixCuioc <FelixCui-oc@zhaoxin.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
References: <20200827100217.21324-1-FelixCui-oc@zhaoxin.com>
 <20200827100217.21324-3-FelixCui-oc@zhaoxin.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e5b1daaf-f073-94c9-714c-832b10d284f4@linux.intel.com>
Date: Tue, 1 Sep 2020 14:12:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827100217.21324-3-FelixCui-oc@zhaoxin.com>
Content-Language: en-US
Cc: TonyWWang-oc@zhaoxin.com, CobeChen-oc@zhaoxin.com
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

Hi Felix,

On 8/27/20 6:02 PM, FelixCuioc wrote:
> After acpi device in RMRR is detected,it is necessary
> to establish a mapping for these devices.
> In acpi_device_create_direct_mappings(),create a mapping
> for the acpi device in RMRR.
> Add a helper to achieve the acpi namespace device can
> access the RMRR region.

Are those ACPI devices visible to kernel? If so, any device driver bound
for it?

Best regards,
baolu

> 
> Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
> ---
>   drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c       |  6 ++++++
>   include/linux/iommu.h       |  3 +++
>   3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 208a91605288..51d7a5b18f41 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4799,6 +4799,21 @@ static int __init platform_optin_force_iommu(void)
>   	return 1;
>   }
>   
> +static int acpi_device_create_direct_mappings(struct device *pn_dev, struct device *acpi_device)
> +{
> +	struct iommu_group *group;
> +
> +	acpi_device->bus->iommu_ops = &intel_iommu_ops;
> +	group = iommu_group_get(pn_dev);
> +	if (!group) {
> +		pr_warn("ACPI name space devices create direct mappings wrong!\n");
> +		return -EINVAL;
> +	}
> +	__acpi_device_create_direct_mappings(group, acpi_device);
> +
> +	return 0;
> +}
> +
>   static int __init probe_acpi_namespace_devices(void)
>   {
>   	struct dmar_drhd_unit *drhd;
> @@ -4813,6 +4828,7 @@ static int __init probe_acpi_namespace_devices(void)
>   			struct acpi_device_physical_node *pn;
>   			struct iommu_group *group;
>   			struct acpi_device *adev;
> +			struct device *pn_dev = NULL;
>   
>   			if (dev->bus != &acpi_bus_type)
>   				continue;
> @@ -4823,6 +4839,7 @@ static int __init probe_acpi_namespace_devices(void)
>   					    &adev->physical_node_list, node) {
>   				group = iommu_group_get(pn->dev);
>   				if (group) {
> +					pn_dev = pn->dev;
>   					iommu_group_put(group);
>   					continue;
>   				}
> @@ -4831,7 +4848,19 @@ static int __init probe_acpi_namespace_devices(void)
>   				ret = iommu_probe_device(pn->dev);
>   				if (ret)
>   					break;
> +				pn_dev = pn->dev;
> +			}
> +			if (!pn_dev) {
> +				dev->bus->iommu_ops = &intel_iommu_ops;
> +				ret = iommu_probe_device(dev);
> +				if (ret) {
> +					pr_err("acpi_device probe fail! ret:%d\n", ret);
> +					goto unlock;
> +				}
> +				goto unlock;
>   			}
> +			ret = acpi_device_create_direct_mappings(pn_dev, dev);
> +unlock:
>   			mutex_unlock(&adev->physical_node_lock);
>   
>   			if (ret)
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 609bd25bf154..4f714a2d5ef7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -779,6 +779,12 @@ static bool iommu_is_attach_deferred(struct iommu_domain *domain,
>   	return false;
>   }
>   
> +void  __acpi_device_create_direct_mappings(struct iommu_group *group, struct device *acpi_device)
> +{
> +	iommu_create_device_direct_mappings(group, acpi_device);
> +}
> +EXPORT_SYMBOL_GPL(__acpi_device_create_direct_mappings);
> +
>   /**
>    * iommu_group_add_device - add a device to an iommu group
>    * @group: the group into which to add the device (reference should be held)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index fee209efb756..9be134775886 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -514,6 +514,9 @@ extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
>   extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
>   			      unsigned long iova, int flags);
>   
> +extern void __acpi_device_create_direct_mappings(struct iommu_group *group,
> +						struct device *acpi_device);
> +
>   static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
>   {
>   	if (domain->ops->flush_iotlb_all)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
