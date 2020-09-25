Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F39FC4346E
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 01:58:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C155B20874
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 01:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C155B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 79B1287547;
	Fri, 25 Sep 2020 01:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ceu-31FCnX7u; Fri, 25 Sep 2020 01:58:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 78E798754A;
	Fri, 25 Sep 2020 01:58:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52A1EC0890;
	Fri, 25 Sep 2020 01:58:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04C77C0859
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 01:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E183686746
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 01:58:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HukjvvojUyfq for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 01:58:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 07693866FB
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 01:58:38 +0000 (UTC)
IronPort-SDR: WRxbixhaNbkYXB9Xp6l+GBLoZAuKrFlQJT6jyrAOBOLxuSJLR7EAFVWlXK18/JgPvr8SN8As+x
 FOYcq0adcJvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="162302803"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; d="scan'208";a="162302803"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 18:58:38 -0700
IronPort-SDR: ryCbZmWDtOB6DSv3hehGloQ3E1prN5hO4Ut/05E3X1P0GApbZCTnwH5aj2ZLE+cXFT1i8QWiXY
 MJGtzH5yw2EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; d="scan'208";a="413576666"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2020 18:58:36 -0700
Subject: Re: [PATCH] iommu/vt-d: gracefully handle DMAR units with no
 supported address widths
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <549928db2de6532117f36c9c810373c14cf76f51.camel@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6872be84-2df5-e4a5-d656-64249dab88dd@linux.intel.com>
Date: Fri, 25 Sep 2020 09:52:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <549928db2de6532117f36c9c810373c14cf76f51.camel@infradead.org>
Content-Language: en-US
Cc: iommu <iommu@lists.linux-foundation.org>
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


On 9/24/20 10:08 PM, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Instead of bailing out completely, such a unit can still be used for
> interrupt remapping.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   drivers/iommu/intel/dmar.c | 46 +++++++++++++++++++++++++-------------
>   1 file changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 93e6345f3414..4420a759f095 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1024,8 +1024,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   {
>   	struct intel_iommu *iommu;
>   	u32 ver, sts;
> -	int agaw = 0;
> -	int msagaw = 0;
> +	int agaw = -1;
> +	int msagaw = -1;
>   	int err;
>   
>   	if (!drhd->reg_base_addr) {
> @@ -1050,17 +1050,28 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   	}
>   
>   	err = -EINVAL;
> -	agaw = iommu_calculate_agaw(iommu);
> -	if (agaw < 0) {
> -		pr_err("Cannot get a valid agaw for iommu (seq_id = %d)\n",
> -			iommu->seq_id);
> -		goto err_unmap;
> -	}
> -	msagaw = iommu_calculate_max_sagaw(iommu);
> -	if (msagaw < 0) {
> -		pr_err("Cannot get a valid max agaw for iommu (seq_id = %d)\n",
> -			iommu->seq_id);
> -		goto err_unmap;
> +	if (cap_sagaw(iommu->cap) == 0) {
> +		pr_info("%s: No supported address widths. Not attempting DMA translation.\n",
> +			iommu->name);
> +		drhd->ignored = 1;
> +	}
> +
> +	if (!drhd->ignored) {
> +		agaw = iommu_calculate_agaw(iommu);
> +		if (agaw < 0) {
> +			pr_err("Cannot get a valid agaw for iommu (seq_id = %d)\n",
> +			       iommu->seq_id);
> +			drhd->ignored = 1;
> +		}
> +	}
> +	if (!drhd->ignored) {
> +		msagaw = iommu_calculate_max_sagaw(iommu);
> +		if (msagaw < 0) {
> +			pr_err("Cannot get a valid max agaw for iommu (seq_id = %d)\n",
> +			       iommu->seq_id);
> +			drhd->ignored = 1;
> +			agaw = -1;
> +		}
>   	}
>   	iommu->agaw = agaw;
>   	iommu->msagaw = msagaw;
> @@ -1087,7 +1098,12 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   
>   	raw_spin_lock_init(&iommu->register_lock);
>   
> -	if (intel_iommu_enabled) {
> +	/*
> +	 * This is only for hotplug; at boot time intel_iommu_enabled won't
> +	 * be set yet. When intel_iommu_init() runs, it registers the units
> +	 * present at boot time, then sets intel_iommu_enabled.
> +	 */
> +	if (intel_iommu_enabled && !drhd->ignored) {
>   		err = iommu_device_sysfs_add(&iommu->iommu, NULL,
>   					     intel_iommu_groups,
>   					     "%s", iommu->name);
> @@ -1117,7 +1133,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   
>   static void free_iommu(struct intel_iommu *iommu)
>   {
> -	if (intel_iommu_enabled) {
> +	if (intel_iommu_enabled && iommu->iommu.ops) {
>   		iommu_device_unregister(&iommu->iommu);
>   		iommu_device_sysfs_remove(&iommu->iommu);
>   	}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
