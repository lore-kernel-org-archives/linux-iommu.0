Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1210FC282CE
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FB12083E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FB12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B570FC11;
	Tue,  9 Apr 2019 10:07:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A6AD425A
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 10:07:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 56147CF
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 10:07:23 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Apr 2019 03:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; d="scan'208";a="162683267"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
	by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2019 03:07:19 -0700
Received: from andy by smile with local (Exim 4.92)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1hDnew-0001Y2-9k; Tue, 09 Apr 2019 13:07:18 +0300
Date: Tue, 9 Apr 2019 13:07:18 +0300
From: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 08/18] iommu: Introduce cache_invalidate API
Message-ID: <20190409100718.GE9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1554767973-30125-9-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1554767973-30125-9-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Liu@smile.fi.intel.com, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409100718.8H4dGPllEg9liAGpco-Fb9n40xRqJ7yhZxp2Sn84JiE@z>

On Mon, Apr 08, 2019 at 04:59:23PM -0700, Jacob Pan wrote:
> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
> In any virtualization use case, when the first translation stage
> is "owned" by the guest OS, the host IOMMU driver has no knowledge
> of caching structure updates unless the guest invalidation activities
> are trapped by the virtualizer and passed down to the host.
> 
> Since the invalidation data are obtained from user space and will be
> written into physical IOMMU, we must allow security check at various
> layers. Therefore, generic invalidation data format are proposed here,
> model specific IOMMU drivers need to convert them into their own format.

> +int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> +			   struct iommu_cache_invalidate_info *inv_info)
> +{
> +	int ret = 0;

Redundant assignment.

> +
> +	if (unlikely(!domain->ops->cache_invalidate))
> +		return -ENODEV;
> +
> +	ret = domain->ops->cache_invalidate(domain, dev, inv_info);
> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
