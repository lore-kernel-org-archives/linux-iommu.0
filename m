Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7765C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 12:55:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3012074D
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 12:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3012074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7C5DA22FB9;
	Fri, 15 May 2020 12:55:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eMEn3FkbDUVr; Fri, 15 May 2020 12:55:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BCC7D204BB;
	Fri, 15 May 2020 12:55:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1D1AC0178;
	Fri, 15 May 2020 12:55:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C711C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E3EFC267D6
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XeSMrvzoW-xy for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 12:55:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id B73FE204BB
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:55:45 +0000 (UTC)
IronPort-SDR: cyidQqC4xgW3bILWGEDQTeIadYAxQY0n+0vzu+qVVjpyC3v9Zfy6NFs2zsOBgpY2sSS7g+pX87
 kFrZtp4ixmnw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 05:55:44 -0700
IronPort-SDR: /DXxWDNVhssNJwfawhWb7WyLbW4yhlrxjXwLgUDJ73JwgdyAz1t4QMeOcwjtIhjbgggZFXTafh
 T4OAKpEKH7MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; d="scan'208";a="372681995"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.171.19])
 ([10.249.171.19])
 by fmsmga001.fm.intel.com with ESMTP; 15 May 2020 05:55:43 -0700
Subject: Re: [PATCH] iommu: Remove functions that support private domain
To: Joerg Roedel <joro@8bytes.org>,
 "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
References: <20200513224721.20504-1-sai.praneeth.prakhya@intel.com>
 <20200514131315.GJ18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6427@ORSMSX114.amr.corp.intel.com>
 <20200514183233.GO18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A651E@ORSMSX114.amr.corp.intel.com>
 <20200514195615.GP18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6672@ORSMSX114.amr.corp.intel.com>
 <20200515095919.GQ18353@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9d65b30a-d22e-d566-d740-601f8d638bfd@linux.intel.com>
Date: Fri, 15 May 2020 20:55:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515095919.GQ18353@8bytes.org>
Content-Language: en-US
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Hi,

On 2020/5/15 17:59, Joerg Roedel wrote:
> On Thu, May 14, 2020 at 11:12:52PM +0000, Prakhya, Sai Praneeth wrote:
>> +static int is_driver_bound(struct device *dev, void *not_used)
>> +{
>> +	int ret = 0;
>> +
>> +	device_lock(dev);
>> +	if (device_is_bound(dev))
>> +		ret = 1;
>> +	device_unlock(dev);
>> +	return ret;
>> +}
> 
> This locks only one device, so without lock-conversion there could be a
> driver probe after the device_unlock(), while we are probing the other
> devices of the group.
> 
>> [SNIP]
>>
>> +	/*
>> +	 * Check if any device in the group still has a driver binded to it.
>> +	 * This might race with device driver probing code and unfortunately
>> +	 * there is no clean way out of that either, locking all devices in the
>> +	 * group and then do the re-attach will introduce a lock-inversion with
>> +	 * group->mutex - Joerg.
>> +	 */
>> +	if (iommu_group_for_each_dev(group, NULL, is_driver_bound)) {
>> +		pr_err("Active drivers exist for devices in the group\n");
>> +		return -EBUSY;
>> +	}
> 
> The lock inversion comes into the picture when this code is called from
> device(-driver) core through the bus-notifiers. The notifiers are called
> with the device already locked.
> 
>> Another question I have is.. if it's racy then it should be racy even
>> for one device iommu groups.. right? Why would it be racy only with
>> multiple devices iommu group?
> 
> Valid point. So the device needs to be locked _while_ the default domain
> change happens. If triggered by sysfs there should be no locking
> problems, I guess. But you better try it out.

It seems that we can do like this:

[1] mutex_lock(&group->lock)
[2] for_each_group_device(device_lock())
[3] if (for_each_group_device(!device_is_bound()))
	change_default_domain()
[4] for_each_group_device_reverse(device_unlock())
[5] mutex_unlock(&group->lock)

A possible problem exists at step 2 when another thread is trying to
lock devices in the reverse order at the same time.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
