Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950FAC433F5
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 01:57:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30FFE63238
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 01:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30FFE63238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C27AB401D0;
	Tue, 16 Nov 2021 01:57:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8hSFI9FIxDMq; Tue, 16 Nov 2021 01:57:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B5B44011F;
	Tue, 16 Nov 2021 01:57:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19F7AC002E;
	Tue, 16 Nov 2021 01:57:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 014BDC0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 01:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF0BB80D36
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 01:57:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6t-_1IH7EhUv for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 01:57:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A86080D22
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 01:57:22 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="233543207"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; d="scan'208";a="233543207"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 17:57:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; d="scan'208";a="494266192"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 15 Nov 2021 17:57:15 -0800
Subject: Re: [PATCH 01/11] iommu: Add device dma ownership set/release
 interfaces
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20211115203848.GA1586192@bhelgaas>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6a2e3d54-8c7f-0367-081b-5448d93f5ca5@linux.intel.com>
Date: Tue, 16 Nov 2021 09:52:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115203848.GA1586192@bhelgaas>
Content-Language: en-US
Cc: Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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

Hi Bjorn,

On 11/16/21 4:38 AM, Bjorn Helgaas wrote:
> On Mon, Nov 15, 2021 at 10:05:42AM +0800, Lu Baolu wrote:
>>  From the perspective of who is initiating the device to do DMA, device
>> DMA could be divided into the following types:
>>
>>          DMA_OWNER_KERNEL: kernel device driver intiates the DMA
>>          DMA_OWNER_USER: userspace device driver intiates the DMA
> 
> s/intiates/initiates/ (twice)

Yes.

> 
> As your first sentence suggests, the driver doesn't actually
> *initiate* the DMA in either case.  One of the drivers programs the
> device, and the *device* initiates the DMA.

You are right. I could rephrase it as:

"From the perspective of who is controlling the device to do DMA ..."

> 
>> DMA_OWNER_KERNEL and DMA_OWNER_USER are exclusive for all devices in
>> same iommu group as an iommu group is the smallest granularity of device
>> isolation and protection that the IOMMU subsystem can guarantee.
> 
> I think this basically says DMA_OWNER_KERNEL and DMA_OWNER_USER are
> attributes of the iommu_group (not an individual device), and it
> applies to all devices in the iommu_group.  Below, you allude to the
> fact that the interfaces are per-device.  It's not clear to me why you
> made a per-device interface instead of a per-group interface.

Yes, the attributes are of the iommu_group. We have both per-device and
per-iommu_group interfaces. The former is for device drivers and the
latter is only for vfio who has an iommu_group based iommu abstract.

>> This
>> extends the iommu core to enforce this exclusion when devices are
>> assigned to userspace.
>>
>> Basically two new interfaces are provided:
>>
>>          int iommu_device_set_dma_owner(struct device *dev,
>>                  enum iommu_dma_owner mode, struct file *user_file);
>>          void iommu_device_release_dma_owner(struct device *dev,
>>                  enum iommu_dma_owner mode);
>>
>> Although above interfaces are per-device, DMA owner is tracked per group
>> under the hood. An iommu group cannot have both DMA_OWNER_KERNEL
>> and DMA_OWNER_USER set at the same time. Violation of this assumption
>> fails iommu_device_set_dma_owner().
>>
>> Kernel driver which does DMA have DMA_OWNER_KENREL automatically
>> set/released in the driver binding process (see next patch).
> 
> s/DMA_OWNER_KENREL/DMA_OWNER_KERNEL/

Yes. Sorry for the typo.

> 
>> Kernel driver which doesn't do DMA should not set the owner type (via a
>> new suppress flag in next patch). Device bound to such driver is considered
>> same as a driver-less device which is compatible to all owner types.
>>
>> Userspace driver framework (e.g. vfio) should set DMA_OWNER_USER for
>> a device before the userspace is allowed to access it, plus a fd pointer to
>> mark the user identity so a single group cannot be operated by multiple
>> users simultaneously. Vice versa, the owner type should be released after
>> the user access permission is withdrawn.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
