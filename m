Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39B9C4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 11:09:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B449613B6
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 11:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B449613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00D974027D;
	Tue,  1 Jun 2021 11:09:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0IcydJ3jmPr1; Tue,  1 Jun 2021 11:09:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id F08474026D;
	Tue,  1 Jun 2021 11:09:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7BCDC000E;
	Tue,  1 Jun 2021 11:09:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2C14C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 11:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A7C64026D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 11:09:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zMJebh8nXgRC for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 11:09:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDEB540243
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 11:09:29 +0000 (UTC)
IronPort-SDR: qpTdACJW2DAiZhB1Gc37TkfCrdhjA2uE7tdVZsl2Kkokoln+wq+BcR7nZfx6flx4oJdsp74Ch6
 gWK65BrU3waw==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="190878878"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="190878878"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 04:09:28 -0700
IronPort-SDR: WZDegxNp3wP/q9jDqwvfXA6qZogcEqh5JoBYq/igauYkrmanJiiBAFQsG4FtYSwyipOd9u7o5j
 CsavuhDtdc4g==
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="479239460"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.9])
 ([10.254.213.9])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 04:09:24 -0700
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <786295f7-b154-cf28-3f4c-434426e897d3@linux.intel.com>
Date: Tue, 1 Jun 2021 19:09:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528233649.GB3816344@nvidia.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Alex Williamson \(alex.williamson@redhat.com\)"
 <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

Hi Jason,

On 2021/5/29 7:36, Jason Gunthorpe wrote:
>> /*
>>    * Bind an user-managed I/O page table with the IOMMU
>>    *
>>    * Because user page table is untrusted, IOASID nesting must be enabled
>>    * for this ioasid so the kernel can enforce its DMA isolation policy
>>    * through the parent ioasid.
>>    *
>>    * Pgtable binding protocol is different from DMA mapping. The latter
>>    * has the I/O page table constructed by the kernel and updated
>>    * according to user MAP/UNMAP commands. With pgtable binding the
>>    * whole page table is created and updated by userspace, thus different
>>    * set of commands are required (bind, iotlb invalidation, page fault, etc.).
>>    *
>>    * Because the page table is directly walked by the IOMMU, the user
>>    * must  use a format compatible to the underlying hardware. It can
>>    * check the format information through IOASID_GET_INFO.
>>    *
>>    * The page table is bound to the IOMMU according to the routing
>>    * information of each attached device under the specified IOASID. The
>>    * routing information (RID and optional PASID) is registered when a
>>    * device is attached to this IOASID through VFIO uAPI.
>>    *
>>    * Input parameters:
>>    *	- child_ioasid;
>>    *	- address of the user page table;
>>    *	- formats (vendor, address_width, etc.);
>>    *
>>    * Return: 0 on success, -errno on failure.
>>    */
>> #define IOASID_BIND_PGTABLE		_IO(IOASID_TYPE, IOASID_BASE + 9)
>> #define IOASID_UNBIND_PGTABLE	_IO(IOASID_TYPE, IOASID_BASE + 10)
> Also feels backwards, why wouldn't we specify this, and the required
> page table format, during alloc time?
> 

Thinking of the required page table format, perhaps we should shed more
light on the page table of an IOASID. So far, an IOASID might represent
one of the following page tables (might be more):

  1) an IOMMU format page table (a.k.a. iommu_domain)
  2) a user application CPU page table (SVA for example)
  3) a KVM EPT (future option)
  4) a VM guest managed page table (nesting mode)

This version only covers 1) and 4). Do you think we need to support 2),
3) and beyond? If so, it seems that we need some in-kernel helpers and
uAPIs to support pre-installing a page table to IOASID. From this point
of view an IOASID is actually not just a variant of iommu_domain, but an
I/O page table representation in a broader sense.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
