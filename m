Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1B2C3F68F
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 01:17:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B275720678
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 01:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B275720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8B6F588391;
	Fri, 10 Jan 2020 01:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oZeMyE5gGuFd; Fri, 10 Jan 2020 01:17:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E658A8838C;
	Fri, 10 Jan 2020 01:17:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C224EC1796;
	Fri, 10 Jan 2020 01:17:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74FC8C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 01:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5E66286ACE
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 01:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1sEWtBp9oT0r for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 01:17:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3FA9D86ACB
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 01:17:05 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jan 2020 17:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; d="scan'208";a="246846711"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2020 17:17:02 -0800
Subject: Re: [PATCH v8 02/10] iommu/vt-d: Add nested translation helper
 function
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1576524252-79116-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <6192b57c-12ab-ec6c-ab95-d9b9bff3efad@linux.intel.com>
 <20200109103908.4c306b06@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <89cc7a91-f645-e331-8f02-62c281c0ea3d@linux.intel.com>
Date: Fri, 10 Jan 2020 09:15:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109103908.4c306b06@jacob-builder>
Content-Language: en-US
Cc: Yi L <yi.l.liu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On 1/10/20 2:39 AM, Jacob Pan wrote:
> On Wed, 18 Dec 2019 10:41:53 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi again,
>>
>> On 12/17/19 3:24 AM, Jacob Pan wrote:
>>> +/**
>>> + * intel_pasid_setup_nested() - Set up PASID entry for nested
>>> translation
>>> + * which is used for vSVA. The first level page tables are used for
>>> + * GVA-GPA or GIOVA-GPA translation in the guest, second level
>>> page tables
>>> + *  are used for GPA-HPA translation.
>>> + *
>>> + * @iommu:      Iommu which the device belong to
>>> + * @dev:        Device to be set up for translation
>>> + * @gpgd:       FLPTPTR: First Level Page translation pointer in
>>> GPA
>>> + * @pasid:      PASID to be programmed in the device PASID table
>>> + * @pasid_data: Additional PASID info from the guest bind request
>>> + * @domain:     Domain info for setting up second level page tables
>>> + * @addr_width: Address width of the first level (guest)
>>> + */
>>> +int intel_pasid_setup_nested(struct intel_iommu *iommu,
>>> +			struct device *dev, pgd_t *gpgd,
>>> +			int pasid, struct
>>> iommu_gpasid_bind_data_vtd *pasid_data,
>>> +			struct dmar_domain *domain,
>>> +			int addr_width)
>>> +{
>>> +	struct pasid_entry *pte;
>>> +	struct dma_pte *pgd;
>>> +	u64 pgd_val;
>>> +	int agaw;
>>> +	u16 did;
>>> +
>>> +	if (!ecap_nest(iommu->ecap)) {
>>> +		pr_err("IOMMU: %s: No nested translation
>>> support\n",
>>> +		       iommu->name);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	pte = intel_pasid_get_entry(dev, pasid);
>>> +	if (WARN_ON(!pte))
>>> +		return -EINVAL;
>>> +
>>> +	pasid_clear_entry(pte);
>>
>> In some cases, e.g. nested mode for GIOVA-HPA, the PASID entry might
>> have already been setup for second level translation. (This could be
>> checked with the Present bit.) Hence, it's safe to flush caches here.
>>
>> Or, maybe intel_pasid_tear_down_entry() is more suitable?
>>
> We don't allow binding the same device-PASID twice, so if the PASID
> entry was used for GIOVA/RID2PASID, it should unbind first, and
> teardown flush included, right?
> 

Fair enough. Can you please add this as a comment to this function? So
that the caller of this interface can know this. Or add a check in this
function which returns error if the pasid entry has already been bond.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
