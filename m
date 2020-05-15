Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294E6C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 01:05:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DED2206D8
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 01:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DED2206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 445E588C73;
	Fri, 15 May 2020 01:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cyaVf3WEF8hm; Fri, 15 May 2020 01:05:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7792088BD3;
	Fri, 15 May 2020 01:05:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A96EC0863;
	Fri, 15 May 2020 01:05:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8FE4C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 01:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8D71D2D811
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 01:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5FoM-F3cW8BS for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 01:05:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 2832C2D50A
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 01:05:05 +0000 (UTC)
IronPort-SDR: n22IuN8vxSxldvZq+k960apCp7PoP9+Sqbjfhu9O5+NB0IcxGsIgZTnj1F2YStj91JrpaIf1GT
 gbEV3SApJvqw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2020 18:05:04 -0700
IronPort-SDR: AYRvp11Pc5HEpo+NJXF+QFbw5OWo1DhY/86LeyFxGIGf2xtYb+az13nP3hvVxmbZ3weePZQjRx
 b8V1QiW3INNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; d="scan'208";a="281051242"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by orsmga002.jf.intel.com with ESMTP; 14 May 2020 18:05:00 -0700
Subject: Re: [PATCH v13 4/8] iommu/vt-d: Add bind guest PASID support
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1589410909-38925-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200514055930.GD22388@infradead.org>
 <20200514085745.105af4fb@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b21488f2-e389-72de-421f-71d2d9525c06@linux.intel.com>
Date: Fri, 15 May 2020 09:01:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
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

On 5/14/20 11:57 PM, Jacob Pan wrote:
>>> +	/*
>>> +	 * PASID table is per device for better security.
>>> Therefore, for
>>> +	 * each bind of a new device even with an existing PASID,
>>> we need to
>>> +	 * call the nested mode setup function here.
>>> +	 */
>>> +	spin_lock(&iommu->lock);
>>> +	ret = intel_pasid_setup_nested(iommu,
>>> +				       dev,
>>> +				       (pgd_t *)data->gpgd,
>>> +				       data->hpasid,
>>> +				       &data->vtd,
>>> +				       dmar_domain,
>>> +				       data->addr_width);
>> Why not:
>>
>> 	et = intel_pasid_setup_nested(iommu, dev, (pgd_t *)data->gpgd,
>> 			data->hpasid, &data->vtd, dmar_domain,
>> 			data->addr_width);
>>
>> ?
>>
> I thought we want to align the parentheses? Either way is fine.
> Baolu?
> 

Let's keep the code style consistent in this file.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
