Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED82C433DF
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 01:44:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB98B207F5
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 01:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB98B207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D929987C5A;
	Fri, 31 Jul 2020 01:44:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oBLuBWnWKFQU; Fri, 31 Jul 2020 01:44:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7618487D1A;
	Fri, 31 Jul 2020 01:44:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6058BC004F;
	Fri, 31 Jul 2020 01:44:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E231FC004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 01:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D6E96203D3
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 01:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XsSnPaooUnFs for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 01:44:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id A9C302033D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 01:44:41 +0000 (UTC)
IronPort-SDR: aAbXZVJk0F2gZMq4vIiao/Bul/6VxDWZ7HHFXPXgITwAUkqNtLqOz/OT+kfrdQJO0Wengdv7np
 ucbqhOhZR3Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="149184605"
X-IronPort-AV: E=Sophos;i="5.75,416,1589266800"; d="scan'208";a="149184605"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2020 18:44:35 -0700
IronPort-SDR: cfRKvsDxm4yOMDLo81V0xyyXW4gTHfvlBOsPcObRur/TTiR45aV6gEteo0ZencSLtnrg/c93LC
 B3Ay+1LJP/Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,416,1589266800"; d="scan'208";a="395179334"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2020 18:44:32 -0700
Subject: Re: [PATCH v3 4/4] vfio/type1: Use iommu_aux_at(de)tach_group() APIs
To: "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-5-baolu.lu@linux.intel.com>
 <DM5PR11MB14351AE909E031B578EA3170C3710@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <72cfd471-5cb3-3b3c-b0bf-c8413991acac@linux.intel.com>
Date: Fri, 31 Jul 2020 09:39:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM5PR11MB14351AE909E031B578EA3170C3710@DM5PR11MB1435.namprd11.prod.outlook.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi Yi,

On 7/30/20 5:36 PM, Liu, Yi L wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, July 14, 2020 1:57 PM
>>
>> Replace iommu_aux_at(de)tach_device() with iommu_aux_at(de)tach_group().
>> It also saves the IOMMU_DEV_FEAT_AUX-capable physcail device in the vfio_group
>> data structure so that it could be reused in other places.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 44 ++++++---------------------------
>>   1 file changed, 7 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 5e556ac9102a..f8812e68de77 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -100,6 +100,7 @@ struct vfio_dma {
>>   struct vfio_group {
>>   	struct iommu_group	*iommu_group;
>>   	struct list_head	next;
>> +	struct device		*iommu_device;
> I know mdev group has only one device, so such a group has a single
> iommu_device. But I guess may be helpful to add a comment here or in
> commit message. Otherwise, it looks weird that a group structure
> contains a single iommu_device field instead of a list of iommu_device.
> 

Right! I will add some comments if this is still needed in the next
version.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
