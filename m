Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B7FC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:07:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B618611C9
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B618611C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3716C406D2;
	Wed, 22 Sep 2021 05:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jazjSGuazQtp; Wed, 22 Sep 2021 05:07:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2CF3A4068F;
	Wed, 22 Sep 2021 05:07:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07019C000F;
	Wed, 22 Sep 2021 05:07:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2578C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93AEB40245
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vT3UhCYElqQY for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 05:07:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A368400F5
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:07:52 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2FB4667373; Wed, 22 Sep 2021 07:07:46 +0200 (CEST)
Date: Wed, 22 Sep 2021 07:07:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC 04/20] iommu: Add iommu_device_get_info interface
Message-ID: <20210922050746.GA12921@lst.de>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-5-yi.l.liu@intel.com>
 <20210921161930.GP327412@nvidia.com>
 <a8a72eba-bae3-9f42-f79c-c5646e425255@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a8a72eba-bae3-9f42-f79c-c5646e425255@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com,
 parav@mellanox.com, alex.williamson@redhat.com, lkml@metux.net,
 david@gibson.dropbear.id.au, dwmw2@infradead.org, jun.j.tian@intel.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Sep 22, 2021 at 10:31:47AM +0800, Lu Baolu wrote:
> Hi Jason,
>
> On 9/22/21 12:19 AM, Jason Gunthorpe wrote:
>> On Sun, Sep 19, 2021 at 02:38:32PM +0800, Liu Yi L wrote:
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>
>>> This provides an interface for upper layers to get the per-device iommu
>>> attributes.
>>>
>>>      int iommu_device_get_info(struct device *dev,
>>>                                enum iommu_devattr attr, void *data);
>>
>> Can't we use properly typed ops and functions here instead of a void
>> *data?
>>
>> get_snoop()
>> get_page_size()
>> get_addr_width()
>
> Yeah! Above are more friendly to the upper layer callers.

The other option would be a struct with all the attributes.  Still
type safe, but not as many methods.  It'll require a little boilerplate
in the callers, though.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
