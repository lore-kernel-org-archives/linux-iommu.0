Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B9CC2BA80
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:09:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37912076D
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37912076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DB7EF87EA9;
	Wed,  8 Apr 2020 12:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6-eYktmgmf0M; Wed,  8 Apr 2020 12:09:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F391B81BC8;
	Wed,  8 Apr 2020 12:09:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEAC6C1AE8;
	Wed,  8 Apr 2020 12:09:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CC42C0177;
 Wed,  8 Apr 2020 12:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3B70E86777;
 Wed,  8 Apr 2020 12:09:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fa7AP9wjnWHy; Wed,  8 Apr 2020 12:09:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 004018618E;
 Wed,  8 Apr 2020 12:09:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5703C31B;
 Wed,  8 Apr 2020 05:09:47 -0700 (PDT)
Received: from [10.57.55.221] (unknown [10.57.55.221])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA7BA3F73D;
 Wed,  8 Apr 2020 05:09:43 -0700 (PDT)
Subject: Re: [RFC PATCH 17/34] iommu/arm-smmu: Store device instead of group
 in arm_smmu_s2cr
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson
 <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200407183742.4344-1-joro@8bytes.org>
 <20200407183742.4344-18-joro@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <98c10a41-d223-e375-9742-b6471c3dc33c@arm.com>
Date: Wed, 8 Apr 2020 13:09:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407183742.4344-18-joro@8bytes.org>
Content-Language: en-GB
Cc: linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
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

On 2020-04-07 7:37 pm, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This is required to convert the arm-smmu driver to the
> probe/release_device() interface.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/arm-smmu.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index a6a5796e9c41..3493501d8b2c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -69,7 +69,7 @@ MODULE_PARM_DESC(disable_bypass,
>   	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
>   
>   struct arm_smmu_s2cr {
> -	struct iommu_group		*group;
> +	struct device			*dev;
>   	int				count;
>   	enum arm_smmu_s2cr_type		type;
>   	enum arm_smmu_s2cr_privcfg	privcfg;
> @@ -1100,7 +1100,7 @@ static int arm_smmu_master_alloc_smes(struct device *dev)
>   	/* It worked! Now, poke the actual hardware */
>   	for_each_cfg_sme(cfg, fwspec, i, idx) {
>   		arm_smmu_write_sme(smmu, idx);
> -		smmu->s2crs[idx].group = group;
> +		smmu->s2crs[idx].dev = dev;
>   	}
>   
>   	mutex_unlock(&smmu->stream_map_mutex);
> @@ -1495,11 +1495,15 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>   	int i, idx;
>   
>   	for_each_cfg_sme(cfg, fwspec, i, idx) {
> -		if (group && smmu->s2crs[idx].group &&
> -		    group != smmu->s2crs[idx].group)
> +		struct iommu_group *idx_grp = NULL;
> +
> +		if (smmu->s2crs[idx].dev)
> +			idx_grp = smmu->s2crs[idx].dev->iommu_group;

For a hot-pluggable bus where logical devices may share Stream IDs (like 
fsl-mc), this could happen:

   create device A
   iommu_probe_device(A)
     iommu_device_group(A) -> alloc group X
   create device B
   iommu_probe_device(B)
     iommu_device_group(A) -> lookup returns group X
   ...
   iommu_remove_device(A)
   delete device A
   create device C
   iommu_probe_device(C)
     iommu_device_group(C) -> use-after-free of A

Preserving the logical behaviour here would probably look *something* 
like the mangled diff below, but I haven't thought it through 100%.

Robin.

----->8-----
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 16c4b87af42b..e88612ee47fe 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1100,10 +1100,8 @@ static int arm_smmu_master_alloc_smes(struct 
device *dev)
         iommu_group_put(group);

         /* It worked! Now, poke the actual hardware */
-       for_each_cfg_sme(fwspec, i, idx) {
+       for_each_cfg_sme(fwspec, i, idx)
                 arm_smmu_write_sme(smmu, idx);
-               smmu->s2crs[idx].group = group;
-       }

         mutex_unlock(&smmu->stream_map_mutex);
         return 0;
@@ -1500,15 +1498,17 @@ static struct iommu_group 
*arm_smmu_device_group(struct device *dev)
         }

         if (group)
-               return iommu_group_ref_get(group);
-
-       if (dev_is_pci(dev))
+               iommu_group_ref_get(group);
+       else if (dev_is_pci(dev))
                 group = pci_device_group(dev);
         else if (dev_is_fsl_mc(dev))
                 group = fsl_mc_device_group(dev);
         else
                 group = generic_device_group(dev);

+       for_each_cfg_sme(fwspec, i, idx)
+               smmu->s2crs[idx].group = group;
+
         return group;
  }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
