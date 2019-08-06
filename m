Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26519C0650F
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 00:07:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016612070D
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 00:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016612070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C1348CE5;
	Tue,  6 Aug 2019 00:07:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2B278AB5
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 00:07:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 870984C3
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 00:07:41 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Aug 2019 17:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; d="scan'208";a="185478216"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga002.jf.intel.com with ESMTP; 05 Aug 2019 17:07:38 -0700
Subject: Re: [PATCH v4 12/15] iommu/vt-d: Cleanup get_valid_domain_for_dev()
To: Alex Williamson <alex.williamson@redhat.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
	<20190525054136.27810-13-baolu.lu@linux.intel.com>
	<20190717211226.5ffbf524@x1.home>
	<9957afdd-4075-e7ee-e1e6-97acb870e17a@linux.intel.com>
	<20190719092303.751659a0@x1.home> <20190801193013.19444803@x1.home>
	<5258f18f-101e-8a43-edea-3f4bb88ca58b@linux.intel.com>
	<20190802105406.53cd9977@x1.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <605e3cdb-35bd-45c6-73be-d3263c11def8@linux.intel.com>
Date: Tue, 6 Aug 2019 08:06:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190802105406.53cd9977@x1.home>
Content-Language: en-US
Cc: kevin.tian@intel.com, Joerg Roedel <jroedel@suse.de>, ashok.raj@intel.com,
	dima@arista.com, tmurphy@arista.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Alex,

On 8/3/19 12:54 AM, Alex Williamson wrote:
> On Fri, 2 Aug 2019 15:17:45 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi Alex,
>>
>> Thanks for reporting this. I will try to find a machine with a
>> pcie-to-pci bridge and get this issue fixed. I will update you
>> later.
> 
> Further debug below...
> 
>> On 8/2/19 9:30 AM, Alex Williamson wrote:
>>> DMAR: No ATSR found
>>> DMAR: dmar0: Using Queued invalidation
>>> DMAR: dmar1: Using Queued invalidation
>>> pci 0000:00:00.0: DMAR: Software identity mapping
>>> pci 0000:00:01.0: DMAR: Software identity mapping
>>> pci 0000:00:02.0: DMAR: Software identity mapping
>>> pci 0000:00:16.0: DMAR: Software identity mapping
>>> pci 0000:00:1a.0: DMAR: Software identity mapping
>>> pci 0000:00:1b.0: DMAR: Software identity mapping
>>> pci 0000:00:1c.0: DMAR: Software identity mapping
>>> pci 0000:00:1c.5: DMAR: Software identity mapping
>>> pci 0000:00:1c.6: DMAR: Software identity mapping
>>> pci 0000:00:1c.7: DMAR: Software identity mapping
>>> pci 0000:00:1d.0: DMAR: Software identity mapping
>>> pci 0000:00:1f.0: DMAR: Software identity mapping
>>> pci 0000:00:1f.2: DMAR: Software identity mapping
>>> pci 0000:00:1f.3: DMAR: Software identity mapping
>>> pci 0000:01:00.0: DMAR: Software identity mapping
>>> pci 0000:01:00.1: DMAR: Software identity mapping
>>> pci 0000:03:00.0: DMAR: Software identity mapping
>>> pci 0000:04:00.0: DMAR: Software identity mapping
>>> DMAR: Setting RMRR:
>>> pci 0000:00:02.0: DMAR: Setting identity map [0xbf800000 - 0xcf9fffff]
>>> pci 0000:00:1a.0: DMAR: Setting identity map [0xbe8d1000 - 0xbe8dffff]
>>> pci 0000:00:1d.0: DMAR: Setting identity map [0xbe8d1000 - 0xbe8dffff]
>>> DMAR: Prepare 0-16MiB unity mapping for LPC
>>> pci 0000:00:1f.0: DMAR: Setting identity map [0x0 - 0xffffff]
>>> pci 0000:00:00.0: Adding to iommu group 0
>>> pci 0000:00:00.0: Using iommu direct mapping
>>> pci 0000:00:01.0: Adding to iommu group 1
>>> pci 0000:00:01.0: Using iommu direct mapping
>>> pci 0000:00:02.0: Adding to iommu group 2
>>> pci 0000:00:02.0: Using iommu direct mapping
>>> pci 0000:00:16.0: Adding to iommu group 3
>>> pci 0000:00:16.0: Using iommu direct mapping
>>> pci 0000:00:1a.0: Adding to iommu group 4
>>> pci 0000:00:1a.0: Using iommu direct mapping
>>> pci 0000:00:1b.0: Adding to iommu group 5
>>> pci 0000:00:1b.0: Using iommu direct mapping
>>> pci 0000:00:1c.0: Adding to iommu group 6
>>> pci 0000:00:1c.0: Using iommu direct mapping
>>> pci 0000:00:1c.5: Adding to iommu group 7
>>> pci 0000:00:1c.5: Using iommu direct mapping
>>> pci 0000:00:1c.6: Adding to iommu group 8
>>> pci 0000:00:1c.6: Using iommu direct mapping
>>> pci 0000:00:1c.7: Adding to iommu group 9
> 
> Note that group 9 contains device 00:1c.7
> 
>>> pci 0000:00:1c.7: Using iommu direct mapping
> 
> I'm booted with iommu=pt, so the domain type is IOMMU_DOMAIN_PT
> 
>>> pci 0000:00:1d.0: Adding to iommu group 10
>>> pci 0000:00:1d.0: Using iommu direct mapping
>>> pci 0000:00:1f.0: Adding to iommu group 11
>>> pci 0000:00:1f.0: Using iommu direct mapping
>>> pci 0000:00:1f.2: Adding to iommu group 11
>>> pci 0000:00:1f.3: Adding to iommu group 11
>>> pci 0000:01:00.0: Adding to iommu group 1
>>> pci 0000:01:00.1: Adding to iommu group 1
>>> pci 0000:03:00.0: Adding to iommu group 12
>>> pci 0000:03:00.0: Using iommu direct mapping
>>> pci 0000:04:00.0: Adding to iommu group 13
>>> pci 0000:04:00.0: Using iommu direct mapping
>>> pci 0000:05:00.0: Adding to iommu group 9
> 
> 05:00.0 is downstream of 00:1c.7 and in the same group.  As above, the
> domain is type IOMMU_DOMAIN_IDENTITY, so we take the following branch:
> 
>          } else {
>                  if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
> 
> Default domain type is IOMMU_DOMAIN_DMA because of the code block in
> device_def_domain_type() handling bridges to conventional PCI and
> conventional PCI endpoints.
> 
>                          ret = iommu_request_dma_domain_for_dev(dev);
> 
> This fails in request_default_domain_for_dev() because there's more
> than one device in the group.
> 
>                          if (ret) {
>                                  dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
>                                  if (!get_private_domain_for_dev(dev)) {
> 
> With this commit, this now returns NULL because find_domain() does find
> a domain, the same one we found before this code block.
> 
>                                          dev_warn(dev,
>                                                   "Failed to get a private domain.\n");
>                                          return -ENOMEM;
>                                  }
> 
> So the key factors are that I'm booting with iommu=pt and I have a
> PCIe-to-PCI bridge grouped with its parent root port.  The bridge
> wants an IOMMU_DOMAIN_DMA, but the group domain is already of type
> IOMMU_DOMAIN_IDENTITY.  A temporary workaround is to not use
> passthrough mode, but this is a regression versus previous kernels.
> Thanks,
> 

I can reproduce this issue with a local setup. I will submit the fix and
cc it to you. Please let me know if that fix doesn't solve this problem.

Best regards,
Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
