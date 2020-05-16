Return-Path: <SRS0=RRah=66=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346F1C433DF
	for <iommu@archiver.kernel.org>; Sat, 16 May 2020 06:02:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BD0206D4
	for <iommu@archiver.kernel.org>; Sat, 16 May 2020 06:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BD0206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C363E897FE;
	Sat, 16 May 2020 06:02:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SlRje06t1cgQ; Sat, 16 May 2020 06:02:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2858E897EC;
	Sat, 16 May 2020 06:02:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 061EEC0865;
	Sat, 16 May 2020 06:02:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79CD0C016F
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 61A4A88FE3
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tCkR9CgHYZdh for <iommu@lists.linux-foundation.org>;
 Sat, 16 May 2020 06:02:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A8FDF88FE0
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:02:29 +0000 (UTC)
IronPort-SDR: +4ttMGKXgImk+HzKIGz76mgsuJDENkcvbkwQw2BCdM77GDreYH580HvzUeTAmZY4BmGdZCFlVk
 Bt2RIhfdGGyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 23:02:29 -0700
IronPort-SDR: 3GJ8TXEoFW0EIiFZDPBR6yeHboZpe9vfcLmgL3m9fnWovY/Jny8IZYD6zHr1LD+Pv7F5CDjJWh
 lO0Ic4xBJQkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,397,1583222400"; d="scan'208";a="281439251"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.172.124])
 ([10.249.172.124])
 by orsmga002.jf.intel.com with ESMTP; 15 May 2020 23:02:25 -0700
Subject: Re: [PATCH v13 4/8] iommu/vt-d: Add bind guest PASID support
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1589410909-38925-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200514055930.GD22388@infradead.org>
 <20200514085745.105af4fb@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <462cad5b-624d-6f77-9503-82d2c5142940@linux.intel.com>
Date: Sat, 16 May 2020 14:02:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514085745.105af4fb@jacob-builder>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Jonathan Cameron <jic23@kernel.org>
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

On 2020/5/14 23:57, Jacob Pan wrote:
> Hi Christoph,
> 
> Thanks a lot for the reviews, comments below.
> 
> Jacob
> 
> On Wed, 13 May 2020 22:59:30 -0700
> Christoph Hellwig<hch@infradead.org>  wrote:
> 
>>> +	if (dev_is_pci(dev)) {
>>> +		/* VT-d supports devices with full 20 bit PASIDs
>>> only */
>>> +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
>>> +			return -EINVAL;
>>> +	} else {
>>> +		return -ENOTSUPP;
>>> +	}
>> This looks strange.  Why not:
>>
>> 	if (!dev_is_pci(dev)) {
>> 		return -ENOTSUPP;
>>
>> 	/* VT-d supports devices with full 20 bit PASIDs only */
>> 	if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
>> 		return -EINVAL;
>>
> That is better, will do.
> 
>>> +		for_each_svm_dev(sdev, svm, dev) {
>>> +			/*
>>> +			 * For devices with aux domains, we should
>>> allow multiple
>>> +			 * bind calls with the same PASID and pdev.
>>> +			 */
>>> +			if (iommu_dev_feature_enabled(dev,
>>> IOMMU_DEV_FEAT_AUX)) {
>>> +				sdev->users++;
>>> +			} else {
>>> +				dev_warn_ratelimited(dev, "Already
>>> bound with PASID %u\n",
>>> +						svm->pasid);
>>> +				ret = -EBUSY;
>>> +			}
>>> +			goto out;
>> Is this intentionally a for loop that jumps out of the loop after
>> the first device?
>>
> The name is confusing, it is not a loop. I will change it to
> find_svm_dev() and comments like this?
> 
> /*
>   * Find the matching device in a given SVM. The bind code ensures that
>   * each device can only be added to the SVM list once.
>   */
> #define find_svm_dev(sdev, svm, d)			\
> 	list_for_each_entry((sdev), &(svm)->devs, list)	\
> 		if ((d) != (sdev)->dev) {} else
> 

The for_each_svm_dev() is not added by this series and is also used by
other functions. How about changing it in a separated patch?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
