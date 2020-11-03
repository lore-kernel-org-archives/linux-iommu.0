Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7613C55179
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 05:29:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F3A2225E
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 05:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F3A2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 08345862D2;
	Tue,  3 Nov 2020 05:29:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyBmYkk025DF; Tue,  3 Nov 2020 05:29:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0DDA186124;
	Tue,  3 Nov 2020 05:29:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E650DC088B;
	Tue,  3 Nov 2020 05:29:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60810C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 05:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 48AC985F5A
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 05:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B2RfsEU-VN3i for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 05:28:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A0D8285F5B
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 05:28:59 +0000 (UTC)
IronPort-SDR: RH3SKB0R0IkPDq5Qk/99B59Znks8fLYEREZqwEtpuNo7CulOqjjWX7+8gN+Vcbo9W53x2LBsNL
 XgaGl8R9gOiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="253709791"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; d="scan'208";a="253709791"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2020 21:28:59 -0800
IronPort-SDR: RDhRvVovQrB2WmyVPN9C3DGOD+0DTYEeV85cbZ6D+ifryHL2iUZD9eku3p2W4KWpCtDjNG/NZs
 4ml2Ftc5gAGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; d="scan'208";a="426194676"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 02 Nov 2020 21:28:56 -0800
Subject: Re: [PATCH v6 5/5] vfio/type1: Use mdev bus iommu_ops for IOMMU
 callbacks
To: Alex Williamson <alex.williamson@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>
References: <20201030045809.957927-1-baolu.lu@linux.intel.com>
 <20201030045809.957927-6-baolu.lu@linux.intel.com>
 <MWHPR11MB1645DEBE7C0E7A61D22081DD8C150@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20201030150625.2dc5fb9b@w520.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5802fc4a-7dc0-eda7-4e7c-809bcec6bd90@linux.intel.com>
Date: Tue, 3 Nov 2020 13:22:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030150625.2dc5fb9b@w520.home>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
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

Hi Alex,

On 10/31/20 5:06 AM, Alex Williamson wrote:
> On Fri, 30 Oct 2020 06:16:28 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>> Sent: Friday, October 30, 2020 12:58 PM
>>>
>>> With the IOMMU driver registering iommu_ops for the mdev_bus, the
>>> IOMMU
>>> operations on an mdev could be done in the same way as any normal device
>>> (for example, PCI/PCIe). There's no need to distinguish an mdev from
>>> others for iommu operations. Remove the unnecessary code.
>>
>> This is really a nice cleanup as the output of this change! :)
> 
> It's easy to remove a bunch of code when the result is breaking
> everyone else.  Please share with me how SR-IOV backed mdevs continue
> to work on AMD platforms, or how they might work on ARM platforms, when
> siov_iommu_ops (VT-d only) becomes the one and only provider of
> iommu_ops on the mdev bus.  Hard NAK on this series.  Thanks,

I focused too much on a feature and forgot about university. I should
apologize for this. Sorry about it!

Back to the original intention of this series. The aux domain was
allocated in vfio/mdev, but it's also needed by the vDCM component of a
device driver for mediated callbacks. Currently vfio/mdev or iommu core
has no support for this.

We had a proposal when we first did aux-domain support. But was not
discussed since there was no consumer at that time.

https://lore.kernel.org/linux-iommu/20181105073408.21815-7-baolu.lu@linux.intel.com/

Does it look good to you? I can send patches of such solution for
discussion if you think it's a right way.

Extending the iommu core for subdevice passthrough support sounds an
interesting topic, but it will take much time before we reach a
consensus. It sounds a good topic for the next year's LPC/MC :-).

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
