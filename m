Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74927C4332D
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 09:07:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503A820752
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 09:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503A820752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 39507889C0;
	Fri, 20 Mar 2020 09:07:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EqnmosyMIFjS; Fri, 20 Mar 2020 09:07:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C5867889E8;
	Fri, 20 Mar 2020 09:07:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4DBEC07FF;
	Fri, 20 Mar 2020 09:07:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7479BC1D89
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 09:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 529B081CB7
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 09:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tKP2RA4ncic9 for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 09:06:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BCA99885FC
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 09:06:38 +0000 (UTC)
IronPort-SDR: bh4ly17Mfe5usieQ+kKwhICjr02B4slwBLLdTsUUZl9JzLJteW7Qg4VArIbmSpmf1jPaTxhx+u
 tK9HZfOpSKBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 02:06:38 -0700
IronPort-SDR: VJr/NqfJMjzoPVDYl8u2FKpHQk4dwgxi5zGyEvuGtewNYa2JidH3t/JuF8Q6f2198qBZPFuK1I
 GB9URtnpP+1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; d="scan'208";a="356354058"
Received: from sxu27-mobl2.ccr.corp.intel.com (HELO [10.254.214.109])
 ([10.254.214.109])
 by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2020 02:06:34 -0700
Subject: Re: [PATCH v2 2/6] iommu: Configure default domain with
 def_domain_type
To: Joerg Roedel <joro@8bytes.org>
References: <20200314010705.30711-1-baolu.lu@linux.intel.com>
 <20200314010705.30711-3-baolu.lu@linux.intel.com>
 <20200319140321.GA5122@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e8f0980c-8431-593c-f9ef-f8f6104e60ec@linux.intel.com>
Date: Fri, 20 Mar 2020 17:06:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319140321.GA5122@8bytes.org>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
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

Hi Joerg,

On 2020/3/19 22:03, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Sat, Mar 14, 2020 at 09:07:01AM +0800, Lu Baolu wrote:
>> +static int iommu_group_change_def_domain(struct iommu_group *group, int type)
>> +{
>> +	struct group_device *grp_dev, *temp;
>> +	struct iommu_domain *new, *old;
>> +	const struct iommu_ops *ops;
>> +	int ret = 0;
>> +
>> +	if ((type != IOMMU_DOMAIN_IDENTITY && type != IOMMU_DOMAIN_DMA) ||
>> +	    !group->default_domain || type == group->default_domain->type ||
>> +	    !group->default_domain->ops)
>> +		return -EINVAL;
>> +
>> +	if (group->domain != group->default_domain)
>> +		return -EBUSY;
>> +
>> +	iommu_group_ref_get(group);
>> +	old = group->default_domain;
>> +	ops = group->default_domain->ops;
>> +
>> +	/* Allocate a new domain of requested type. */
>> +	new = ops->domain_alloc(type);
>> +	if (!new) {
>> +		ret = -ENOMEM;
>> +		goto domain_out;
>> +	}
>> +	new->type = type;
>> +	new->ops = ops;
>> +	new->pgsize_bitmap = group->default_domain->pgsize_bitmap;
>> +
>> +	group->default_domain = new;
>> +	group->domain = new;
>> +	list_for_each_entry_safe(grp_dev, temp, &group->devices, list) {
>> +		struct device *dev;
>> +
>> +		dev = grp_dev->dev;
>> +		if (device_is_bound(dev)) {
>> +			ret = -EINVAL;
>> +			goto device_out;
>> +		}
>> +
>> +		iommu_group_create_direct_mappings(group, dev);
>> +		ret = __iommu_attach_device(group->domain, dev);
>> +		if (ret)
>> +			goto device_out;
> 
> In case of a failure here with a group containing multiple devices, the
> other devices temporarily lose their mappings. Please only do the
> device_is_bound() check in the loop and the actual re-attachment of the
> group with a call to __iommu_attach_group().

Sure. I've post a v3 of this patch according to your comments here.
Please help to review.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
