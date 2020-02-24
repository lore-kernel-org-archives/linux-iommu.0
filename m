Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1738AC35DE8
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 23:33:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90AF20732
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 23:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90AF20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 97A64874CF;
	Mon, 24 Feb 2020 23:33:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7icDjm8M7jgE; Mon, 24 Feb 2020 23:33:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0859C86CDC;
	Mon, 24 Feb 2020 23:33:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F03D3C07FF;
	Mon, 24 Feb 2020 23:33:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF262C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 23:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AED978733C
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 23:33:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rmqmq4YTanCV for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 23:33:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7B6F786CDC
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 23:33:46 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 15:33:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; d="scan'208";a="237485225"
Received: from jacob-xps-13-9365.jf.intel.com (HELO jacob-XPS-13-9365)
 ([10.54.75.153])
 by orsmga003.jf.intel.com with ESMTP; 24 Feb 2020 15:33:45 -0800
Date: Mon, 24 Feb 2020 15:34:10 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: report SVA feature with generic flag
Message-ID: <20200224153410.23a96bc1@jacob-XPS-13-9365>
In-Reply-To: <1582586797-61697-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1582586797-61697-2-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Please ignore this one, use "[PATCH 1/2] iommu/vt-d: Report SVA feature
with generic flag" instead. Sorry about the noise.

On Mon, 24 Feb 2020 15:26:35 -0800
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> Query Shared Virtual Address/Memory capability is a generic feature.
> Report Intel SVM as SVA feature such that generic code such as Uacce
> [1] can use it.
> [1] https://lkml.org/lkml/2020/1/15/604
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 92c2f2e4197b..5eca6e10d2a4 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6346,9 +6346,14 @@ intel_iommu_dev_has_feat(struct device *dev,
> enum iommu_dev_features feat) static int
>  intel_iommu_dev_enable_feat(struct device *dev, enum
> iommu_dev_features feat) {
> +	struct intel_iommu *intel_iommu = dev_to_intel_iommu(dev);
> +
>  	if (feat == IOMMU_DEV_FEAT_AUX)
>  		return intel_iommu_enable_auxd(dev);
>  
> +	if (feat == IOMMU_DEV_FEAT_SVA)
> +		return intel_iommu->flags & VTD_FLAG_SVM_CAPABLE;
> +
>  	return -ENODEV;
>  }
>  

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
