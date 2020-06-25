Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41A9C433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 12:54:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7285C204EA
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 12:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7285C204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 48D2786905;
	Thu, 25 Jun 2020 12:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s3AMEAEthf56; Thu, 25 Jun 2020 12:54:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6A32D86091;
	Thu, 25 Jun 2020 12:54:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D3A0C088E;
	Thu, 25 Jun 2020 12:54:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B019C016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 12:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EE673868E5
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 12:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5fdUFuPZvn4i for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 12:54:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3BCFC86091
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 12:54:26 +0000 (UTC)
IronPort-SDR: KgIAc3Hf2rKjzDe3sCI1cC16lPXIy281uuPZcHx2c8yenEZubab7xdFY/1S4XbbT7ouWV6N74j
 pnPglmaMLFlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="143962333"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="143962333"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 05:54:25 -0700
IronPort-SDR: 604t9fzSsToorAiXk1e2QV9ssp+DA11lpkBgLXjc441qtWdtpCW7bq++NhHiVciHxVJKCHpF1O
 AKsWP6VHxW3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="263914182"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.28.52])
 ([10.255.28.52])
 by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2020 05:54:23 -0700
Subject: Re: [PATCH 7/7] iommu/vt-d: Disable multiple GPASID-dev bind
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-8-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e8725709-8720-ade2-34a3-999f0cf61fde@linux.intel.com>
Date: Thu, 25 Jun 2020 20:54:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592926996-47914-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

On 2020/6/23 23:43, Jacob Pan wrote:
> For the unlikely use case where multiple aux domains from the same pdev
> are attached to a single guest and then bound to a single process
> (thus same PASID) within that guest, we cannot easily support this case
> by refcounting the number of users. As there is only one SL page table
> per PASID while we have multiple aux domains thus multiple SL page tables
> for the same PASID.
> 
> Extra unbinding guest PASID can happen due to race between normal and
> exception cases. Termination of one aux domain may affect others unless
> we actively track and switch aux domains to ensure the validity of SL
> page tables and TLB states in the shared PASID entry.
> 
> Support for sharing second level PGDs across domains can reduce the
> complexity but this is not available due to the limitations on VFIO
> container architecture. We can revisit this decision once sharing PGDs
> are available.
> 
> Overall, the complexity and potential glitch do not warrant this unlikely
> use case thereby removed by this patch.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Fixes: 56722a4398a30 ("iommu/vt-d: Add bind guest PASID support")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/svm.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 6c87c807a0ab..d386853121a2 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -277,20 +277,16 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   			goto out;
>   		}
>   
> +		/*
> +		 * Do not allow multiple bindings of the same device-PASID since
> +		 * there is only one SL page tables per PASID. We may revisit
> +		 * once sharing PGD across domains are supported.
> +		 */
>   		for_each_svm_dev(sdev, svm, dev) {
> -			/*
> -			 * For devices with aux domains, we should allow
> -			 * multiple bind calls with the same PASID and pdev.
> -			 */
> -			if (iommu_dev_feature_enabled(dev,
> -						      IOMMU_DEV_FEAT_AUX)) {
> -				sdev->users++;
> -			} else {
> -				dev_warn_ratelimited(dev,
> -						     "Already bound with PASID %u\n",
> -						     svm->pasid);
> -				ret = -EBUSY;
> -			}
> +			dev_warn_ratelimited(dev,
> +					     "Already bound with PASID %u\n",
> +					     svm->pasid);
> +			ret = -EBUSY;
>   			goto out;
>   		}
>   	} else {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
