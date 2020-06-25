Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F1FC433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 12:59:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406BB206C3
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 12:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406BB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 016EC230BD;
	Thu, 25 Jun 2020 12:59:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VlN1N9vy7PsZ; Thu, 25 Jun 2020 12:59:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1065022D10;
	Thu, 25 Jun 2020 12:59:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE282C088E;
	Thu, 25 Jun 2020 12:59:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BC7DC016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 12:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 129D288713
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 12:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9tVCijo6TYrI for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 12:59:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5E40C886A8
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 12:59:10 +0000 (UTC)
IronPort-SDR: 1OQ+hMOn4HBAnW+ssLWgvmYM6Aa+J7JjCC14eY+ttCr7m2oMqWbBbtrVbLMLD1KUHhGNSwOGT4
 01Q2gU2Fs62g==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="162956441"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="162956441"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 05:59:10 -0700
IronPort-SDR: i6Ys0T4ZOGQuhdpYBW4th9+MHEGWasefrCfEyP583mQ83surcbs8r/lE9QXtG4LHsDnzCDnO2D
 g00PWCTwU2WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; d="scan'208";a="263915035"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.28.52])
 ([10.255.28.52])
 by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2020 05:59:07 -0700
Subject: Re: [PATCH v3 5/5] iommu/uapi: Support both kernel and user unbind
 guest PASID
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592931837-58223-6-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8d9d5692-b603-19eb-3f69-c18cfef7b450@linux.intel.com>
Date: Thu, 25 Jun 2020 20:59:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592931837-58223-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jacob,

On 2020/6/24 1:03, Jacob Pan wrote:
> +int __iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +			struct iommu_gpasid_bind_data *data)
>   {
>   	if (unlikely(!domain->ops->sva_unbind_gpasid))
>   		return -ENODEV;
>   
> -	return domain->ops->sva_unbind_gpasid(dev, pasid);
> +	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
> +}
> +EXPORT_SYMBOL_GPL(__iommu_sva_unbind_gpasid);

__iommu_sva_unbind_gpasid() looks more like an internal only helper. How
about something like iommu_sva_kunbind_gpasid()?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
