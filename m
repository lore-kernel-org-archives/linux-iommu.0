Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A38C4346E
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 01:16:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428B920809
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 01:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428B920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D57F686BCB;
	Fri, 25 Sep 2020 01:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x-03CM2YbV1i; Fri, 25 Sep 2020 01:16:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3A8F88699C;
	Fri, 25 Sep 2020 01:16:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23635C0890;
	Fri, 25 Sep 2020 01:16:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD7D9C0859
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 01:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D4B9A203EE
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 01:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3EygLdfw6bq0 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 01:16:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 41FBA203B9
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 01:16:03 +0000 (UTC)
IronPort-SDR: LNQ6JLi75Dz4jXGkLb98wts7GahplBkWOzJ3ZZ8Y5wG2gIjJRhy87BchzjspK3z+g3wSeSarZQ
 nRMEA/pjDZIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="149055956"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; d="scan'208";a="149055956"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 18:16:02 -0700
IronPort-SDR: NZiMjqbn0XOVlDBtUX7zjoy1iC028gY+0yUIsaChkilRAW690kEwU+Ebuf7GqU8PCaib8RhSY3
 jII3vzjkPEyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; d="scan'208";a="413553113"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2020 18:15:59 -0700
Subject: Re: [PATCH v5 0/5] iommu aux-domain APIs extensions
To: Joerg Roedel <joro@8bytes.org>
References: <20200922061042.31633-1-baolu.lu@linux.intel.com>
 <20200924095532.GK27174@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <71f1fa5e-f468-0498-1ab4-1c2af9424d2d@linux.intel.com>
Date: Fri, 25 Sep 2020 09:09:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924095532.GK27174@8bytes.org>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
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

Hi Joerg,

On 9/24/20 5:55 PM, Joerg Roedel wrote:
> On Tue, Sep 22, 2020 at 02:10:37PM +0800, Lu Baolu wrote:
>> Hi Jorge and Alex,
>>
>> A description of this patch series could be found here.
>>
>> https://lore.kernel.org/linux-iommu/20200901033422.22249-1-baolu.lu@linux.intel.com/
> 
> Hmm, I am wondering if we can avoid all this hassle and special APIs by
> making the mdev framework more visible outside of the vfio code. There
> is an underlying bus implementation for mdevs, so is there a reason
> those can't use the standard iommu-core code to setup IOMMU mappings?

The original purpose of this series is to enable the device driver to
retrieve the aux-domain through iommu core after iommu
ops.aux_attach_dev().

The domain was allocated in vfio/mdev, but it's also needed by the
device driver in mediated callbacks. The idea of this patch series is to
extend the aux-API so that the domain could be saved in group->domain
and get by the mediated driver through the existing
iommu_get_domain_for_dev().

Back when we were developing the aux-domain, I proposed to keep the
domain in vfio/mdev.

https://lore.kernel.org/linux-iommu/20181105073408.21815-7-baolu.lu@linux.intel.com/

It wasn't discussed at that time due to the lack of real consumer. Intel
is now adding aux-domain support in idxd (DMA streaming accelerator)
driver which becomes the first real consumer. So this problem is brought
back to the table.

> 
> What speaks against doing:
> 
> 	- IOMMU drivers capable of handling mdevs register iommu-ops
> 	  for the mdev_bus.
> 
> 	- iommu_domain_alloc() takes bus_type as parameter, so there can
> 	  be special domains be allocated for mdevs.
> 
> 	- Group creation and domain allocation will happen
> 	  automatically in the iommu-core when a new mdev is registered
> 	  through device-driver core code.
> 
> 	- There should be no need for special iommu_aux_* APIs, as one
> 	  can attach a domain directly to &mdev->dev with
> 	  iommu_attach_device(domain, &mdev->dev).
> 
> Doing it this way will probably also keep the mdev-special code in VFIO
> small.

Fully understand now. Thanks for guide.

> 
> Regards,
> 
> 	Joerg
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
