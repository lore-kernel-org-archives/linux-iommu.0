Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31B5C433E4
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 01:04:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5F22074B
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 01:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5F22074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6AE078935E;
	Wed, 15 Jul 2020 01:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QRj8Lneuhlwq; Wed, 15 Jul 2020 01:04:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DE26D86FBB;
	Wed, 15 Jul 2020 01:04:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3890C0888;
	Wed, 15 Jul 2020 01:04:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D189FC0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 01:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BA92A204BA
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 01:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iM33UBNMhw32 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 01:04:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id CB143204B4
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 01:04:42 +0000 (UTC)
IronPort-SDR: D5nkxoC34j+73pGWSns4SSTjxEclP3pSMD9fD1IAyXQ8pu1jRssa55PcQqWFfLVavUnFXOIk3X
 RaPZQKey4o5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="137187575"
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; d="scan'208";a="137187575"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 18:04:41 -0700
IronPort-SDR: gbYlDs4Ly5SqxpHpBIogAaCvu597r+FyU8UGFhHgLyt2iKxmSwIjEagGJ2FHxrymAQvdzZX+Ad
 hhl4enV8Ea0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; d="scan'208";a="459891197"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by orsmga005.jf.intel.com with ESMTP; 14 Jul 2020 18:04:36 -0700
Subject: Re: [PATCH v3 4/4] vfio/type1: Use iommu_aux_at(de)tach_group() APIs
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-5-baolu.lu@linux.intel.com>
 <20200714082514.GA30622@infradead.org>
 <20200714092930.4b61b77c@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ac4507d5-a5fc-d078-9bfc-f9e9fd1244e7@linux.intel.com>
Date: Wed, 15 Jul 2020 09:00:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714092930.4b61b77c@jacob-builder>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>,
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

Hi Christoph and Jacob,

On 7/15/20 12:29 AM, Jacob Pan wrote:
> On Tue, 14 Jul 2020 09:25:14 +0100
> Christoph Hellwig<hch@infradead.org>  wrote:
> 
>> On Tue, Jul 14, 2020 at 01:57:03PM +0800, Lu Baolu wrote:
>>> Replace iommu_aux_at(de)tach_device() with
>>> iommu_aux_at(de)tach_group(). It also saves the
>>> IOMMU_DEV_FEAT_AUX-capable physcail device in the vfio_group data
>>> structure so that it could be reused in other places.
>> This removes the last user of iommu_aux_attach_device and
>> iommu_aux_detach_device, which can be removed now.
> it is still used in patch 2/4 inside iommu_aux_attach_group(), right?
> 

There is a need to use this interface. For example, an aux-domain is
attached to a subset of a physical device and used in the kernel. In
this usage scenario, there's no need to use vfio/mdev. The device driver
could just allocate an aux-domain and call iommu_aux_attach_device() to
setup the iommu.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
