Return-Path: <SRS0=f0z+=4K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8511BC35669
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 23:42:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53333206EF
	for <iommu@archiver.kernel.org>; Sat, 22 Feb 2020 23:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53333206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0C31A8759E;
	Sat, 22 Feb 2020 23:42:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BmqoiwJWXm8V; Sat, 22 Feb 2020 23:42:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7D85F87447;
	Sat, 22 Feb 2020 23:42:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63CEEC1AE2;
	Sat, 22 Feb 2020 23:42:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3839EC013E
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 23:42:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 22E8987482
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 23:42:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j7jL7LIO4VEV for <iommu@lists.linux-foundation.org>;
 Sat, 22 Feb 2020 23:42:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 73AA987447
 for <iommu@lists.linux-foundation.org>; Sat, 22 Feb 2020 23:42:31 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 15:42:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,473,1574150400"; d="scan'208";a="230775350"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.230])
 ([10.254.212.230])
 by fmsmga008.fm.intel.com with ESMTP; 22 Feb 2020 15:42:27 -0800
Subject: Re: [PATCH V2 2/5] iommu/vt-d: Rename device_def_domain_type() to
 intel_iommu_dev_def_domain_type()
To: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
 iommu@lists.linux-foundation.org
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
 <cd79477f93816a4b0940a8f6770327772b9786af.1581619464.git.sai.praneeth.prakhya@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5cbc8651-3a7f-95fa-3db0-704cb15978f5@linux.intel.com>
Date: Sun, 23 Feb 2020 07:42:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cd79477f93816a4b0940a8f6770327772b9786af.1581619464.git.sai.praneeth.prakhya@intel.com>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi,

On 2020/2/17 5:57, Sai Praneeth Prakhya wrote:
> The functionality needed for iommu_ops->dev_def_domain_type() is already
> provided by device_def_domain_type() in intel_iommu.c. But, every call back
> function in intel_iommu_ops starts with intel_iommu prefix, hence rename
> device_def_domain_type() to intel_iommu_dev_def_domain_type() so that it
> follows the same semantics.

How about keep device_def_domain_type() and call it in the new
intel_iommu_dev_def_domain_type()?

Best regards,
baolu

> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Sohil Mehta <sohil.mehta@intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> ---
>   drivers/iommu/intel-iommu.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 64ddccf1d5fe..68f10d271ac0 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3034,7 +3034,7 @@ static bool device_is_rmrr_locked(struct device *dev)
>    *  - IOMMU_DOMAIN_IDENTITY: device requires an identical mapping domain
>    *  - 0: both identity and dynamic domains work for this device
>    */
> -static int device_def_domain_type(struct device *dev)
> +static int intel_iommu_dev_def_domain_type(struct device *dev)
>   {
>   	if (dev_is_pci(dev)) {
>   		struct pci_dev *pdev = to_pci_dev(dev);
> @@ -5796,7 +5796,8 @@ static int intel_iommu_add_device(struct device *dev)
>   	domain = iommu_get_domain_for_dev(dev);
>   	dmar_domain = to_dmar_domain(domain);
>   	if (domain->type == IOMMU_DOMAIN_DMA) {
> -		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
> +		if (intel_iommu_dev_def_domain_type(dev) ==
> +		    IOMMU_DOMAIN_IDENTITY) {
>   			ret = iommu_request_dm_for_dev(dev);
>   			if (ret) {
>   				dmar_remove_one_dev_info(dev);
> @@ -5807,7 +5808,7 @@ static int intel_iommu_add_device(struct device *dev)
>   			}
>   		}
>   	} else {
> -		if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
> +		if (intel_iommu_dev_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
>   			ret = iommu_request_dma_domain_for_dev(dev);
>   			if (ret) {
>   				dmar_remove_one_dev_info(dev);
> @@ -6194,6 +6195,7 @@ const struct iommu_ops intel_iommu_ops = {
>   	.dev_enable_feat	= intel_iommu_dev_enable_feat,
>   	.dev_disable_feat	= intel_iommu_dev_disable_feat,
>   	.is_attach_deferred	= intel_iommu_is_attach_deferred,
> +	.dev_def_domain_type	= intel_iommu_dev_def_domain_type,
>   	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>   };
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
