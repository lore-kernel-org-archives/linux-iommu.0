Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260A6C47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:51:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D2E613EE
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D2E613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70A5A404F7;
	Thu,  3 Jun 2021 06:51:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LjAKjsXB4BR9; Thu,  3 Jun 2021 06:51:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BA93404F5;
	Thu,  3 Jun 2021 06:51:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0839AC000E;
	Thu,  3 Jun 2021 06:51:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B923CC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98C68405AD
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:51:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IfEoMOPHf5ta for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 06:51:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C75F405A9
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:51:27 +0000 (UTC)
IronPort-SDR: 6KdJ6di1mI8rmJdogw3tl1USkar6PVs0/2TjtemIQpuTyyAUE5vO0Uybhob1W/AMlJFtTWz+on
 BGOIUjL9YKAQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="202119528"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="202119528"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 23:51:26 -0700
IronPort-SDR: 3vUZ5TeuGZxxfh6ulpxTYfX9fSHdBUpI4kW9u8qn89MnNIc6zr2G/2jkVM+gNfeqamv9P3xQEy
 hTXdL4MsDSvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="633593787"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105])
 ([10.239.159.105])
 by fmsmga006.fm.intel.com with ESMTP; 02 Jun 2021 23:51:22 -0700
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: David Gibson <david@gibson.dropbear.id.au>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <786295f7-b154-cf28-3f4c-434426e897d3@linux.intel.com>
 <YLhupAfUWWiVMDVU@yekko>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e2dc8e4d-1f62-36d5-b303-18c82b6a6770@linux.intel.com>
Date: Thu, 3 Jun 2021 14:50:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLhupAfUWWiVMDVU@yekko>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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

Hi David,

On 6/3/21 1:54 PM, David Gibson wrote:
> On Tue, Jun 01, 2021 at 07:09:21PM +0800, Lu Baolu wrote:
>> Hi Jason,
>>
>> On 2021/5/29 7:36, Jason Gunthorpe wrote:
>>>> /*
>>>>     * Bind an user-managed I/O page table with the IOMMU
>>>>     *
>>>>     * Because user page table is untrusted, IOASID nesting must be enabled
>>>>     * for this ioasid so the kernel can enforce its DMA isolation policy
>>>>     * through the parent ioasid.
>>>>     *
>>>>     * Pgtable binding protocol is different from DMA mapping. The latter
>>>>     * has the I/O page table constructed by the kernel and updated
>>>>     * according to user MAP/UNMAP commands. With pgtable binding the
>>>>     * whole page table is created and updated by userspace, thus different
>>>>     * set of commands are required (bind, iotlb invalidation, page fault, etc.).
>>>>     *
>>>>     * Because the page table is directly walked by the IOMMU, the user
>>>>     * must  use a format compatible to the underlying hardware. It can
>>>>     * check the format information through IOASID_GET_INFO.
>>>>     *
>>>>     * The page table is bound to the IOMMU according to the routing
>>>>     * information of each attached device under the specified IOASID. The
>>>>     * routing information (RID and optional PASID) is registered when a
>>>>     * device is attached to this IOASID through VFIO uAPI.
>>>>     *
>>>>     * Input parameters:
>>>>     *	- child_ioasid;
>>>>     *	- address of the user page table;
>>>>     *	- formats (vendor, address_width, etc.);
>>>>     *
>>>>     * Return: 0 on success, -errno on failure.
>>>>     */
>>>> #define IOASID_BIND_PGTABLE		_IO(IOASID_TYPE, IOASID_BASE + 9)
>>>> #define IOASID_UNBIND_PGTABLE	_IO(IOASID_TYPE, IOASID_BASE + 10)
>>> Also feels backwards, why wouldn't we specify this, and the required
>>> page table format, during alloc time?
>>>
>> Thinking of the required page table format, perhaps we should shed more
>> light on the page table of an IOASID. So far, an IOASID might represent
>> one of the following page tables (might be more):
>>
>>   1) an IOMMU format page table (a.k.a. iommu_domain)
>>   2) a user application CPU page table (SVA for example)
>>   3) a KVM EPT (future option)
>>   4) a VM guest managed page table (nesting mode)
>>
>> This version only covers 1) and 4). Do you think we need to support 2),
> Isn't (2) the equivalent of using the using the host-managed pagetable
> then doing a giant MAP of all your user address space into it?  But
> maybe we should identify that case explicitly in case the host can
> optimize it.
> 

Conceptually, yes. Current SVA implementation just reuses the
application's cpu page table w/o map/unmap operations.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
