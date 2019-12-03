Return-Path: <SRS0=C308=ZZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC9FC43215
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 02:19:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7D220674
	for <iommu@archiver.kernel.org>; Tue,  3 Dec 2019 02:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7D220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 033A42202E;
	Tue,  3 Dec 2019 02:19:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OTlqW1Mai0W9; Tue,  3 Dec 2019 02:19:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A286620347;
	Tue,  3 Dec 2019 02:19:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8429EC1797;
	Tue,  3 Dec 2019 02:19:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2273AC087F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 02:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 193B185DDC
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 02:19:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1JKcIwFgEc6H for <iommu@lists.linux-foundation.org>;
 Tue,  3 Dec 2019 02:19:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 06CA785DD1
 for <iommu@lists.linux-foundation.org>; Tue,  3 Dec 2019 02:19:39 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Dec 2019 18:19:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,271,1571727600"; d="scan'208";a="222654206"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 02 Dec 2019 18:19:35 -0800
Subject: Re: [PATCH v2 0/8] Use 1st-level for DMA remapping
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20191128022550.9832-1-baolu.lu@linux.intel.com>
 <20191202121927.2fef85ba@jacob-builder>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <608f472b-3eb1-8ea9-1561-cdf2e8191793@linux.intel.com>
Date: Tue, 3 Dec 2019 10:19:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202121927.2fef85ba@jacob-builder>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 sanjay.k.kumar@intel.com, yi.y.sun@intel.com, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

Hi Jacob,

Thanks for reviewing it.

On 12/3/19 4:19 AM, Jacob Pan wrote:
> On Thu, 28 Nov 2019 10:25:42 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Intel VT-d in scalable mode supports two types of page talbes
> tables

Got it, thanks!

>> for DMA translation: the first level page table and the second
>> level page table. The first level page table uses the same
>> format as the CPU page table, while the second level page table
>> keeps compatible with previous formats. The software is able
>> to choose any one of them for DMA remapping according to the use
>> case.
>>
>> This patchset aims to move IOVA (I/O Virtual Address) translation
> move guest IOVA only, right?

No. In v1, only for guest IOVA. This has been changed since v2 according
to comments during v1 review period. v2 will use first level for both
host and guest unless nested mode.

>> to 1st-level page table in scalable mode. This will simplify vIOMMU
>> (IOMMU simulated by VM hypervisor) design by using the two-stage
>> translation, a.k.a. nested mode translation.
>>
>> As Intel VT-d architecture offers caching mode, guest IOVA (GIOVA)
>> support is now implemented in a shadow page manner. The device
>> simulation software, like QEMU, has to figure out GIOVA->GPA mappings
>> and write them to a shadowed page table, which will be used by the
>> physical IOMMU. Each time when mappings are created or destroyed in
>> vIOMMU, the simulation software has to intervene. Hence, the changes
>> on GIOVA->GPA could be shadowed to host.
>>
>>
>>       .-----------.
>>       |  vIOMMU   |
>>       |-----------|                 .--------------------.
>>       |           |IOTLB flush trap |        QEMU        |
>>       .-----------. (map/unmap)     |--------------------|
>>       |GIOVA->GPA |---------------->|    .------------.  |
>>       '-----------'                 |    | GIOVA->HPA |  |
>>       |           |                 |    '------------'  |
>>       '-----------'                 |                    |
>>                                     |                    |
>>                                     '--------------------'
>>                                                  |
>>              <------------------------------------
>>              |
>>              v VFIO/IOMMU API
>>        .-----------.
>>        |  pIOMMU   |
>>        |-----------|
>>        |           |
>>        .-----------.
>>        |GIOVA->HPA |
>>        '-----------'
>>        |           |
>>        '-----------'
>>
>> In VT-d 3.0, scalable mode is introduced, which offers two-level
>> translation page tables and nested translation mode. Regards to
>> GIOVA support, it can be simplified by 1) moving the GIOVA support
>> over 1st-level page table to store GIOVA->GPA mapping in vIOMMU,
>> 2) binding vIOMMU 1st level page table to the pIOMMU, 3) using pIOMMU
>> second level for GPA->HPA translation, and 4) enable nested (a.k.a.
>> dual-stage) translation in host. Compared with current shadow GIOVA
>> support, the new approach makes the vIOMMU design simpler and more
>> efficient as we only need to flush the pIOMMU IOTLB and possible
>> device-IOTLB when an IOVA mapping in vIOMMU is torn down.
>>
>>       .-----------.
>>       |  vIOMMU   |
>>       |-----------|                 .-----------.
>>       |           |IOTLB flush trap |   QEMU    |
>>       .-----------.    (unmap)      |-----------|
>>       |GIOVA->GPA |---------------->|           |
>>       '-----------'                 '-----------'
>>       |           |                       |
>>       '-----------'                       |
>>             <------------------------------
>>             |      VFIO/IOMMU
>>             |  cache invalidation and
>>             | guest gpd bind interfaces
>>             v
>>       .-----------.
>>       |  pIOMMU   |
>>       |-----------|
>>       .-----------.
>>       |GIOVA->GPA |<---First level
>>       '-----------'
>>       | GPA->HPA  |<---Scond level
>>       '-----------'
>>       '-----------'
>>
>> This patch set includes two parts. The former part implements the
>> per-domain page table abstraction, which makes the page table
>> difference transparent to various map/unmap APIs. The later part
> s/later/latter/
>> applies the first level page table for IOVA translation unless the
>> DOMAIN_ATTR_NESTING domain attribution has been set, which indicates
>> nested mode in use.
>>
> Maybe I am reading this wrong, but shouldn't it be the opposite?
> i.e. Use FL page table for IOVA if it is a nesting domain?

My description seems to a bit confusing. If DOMAIN_ATTR_NESTING is set
for a domain, the second level will be used to map gPA (guest physical
address) to hPA (host physical address), and the mappings between gVA (
guest virtual address) and gPA will be maintained by the guest with the
page table address binding to host's first level. Otherwise, first level
will be used for mapping between gPA and hPA, or IOVA and DMA address.

Best regards,
baolu

> 
>> Based-on-idea-by: Ashok Raj <ashok.raj@intel.com>
>> Based-on-idea-by: Kevin Tian <kevin.tian@intel.com>
>> Based-on-idea-by: Liu Yi L <yi.l.liu@intel.com>
>> Based-on-idea-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Based-on-idea-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Based-on-idea-by: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> Change log:
>>
>>   v1->v2
>>   - The first series was posted here
>>     https://lkml.org/lkml/2019/9/23/297
>>   - Use per domain page table ops to handle different page tables.
>>   - Use first level for DMA remapping by default on both bare metal
>>     and vm guest.
>>   - Code refine according to code review comments for v1.
>>
>> Lu Baolu (8):
>>    iommu/vt-d: Add per domain page table ops
>>    iommu/vt-d: Move domain_flush_cache helper into header
>>    iommu/vt-d: Implement second level page table ops
>>    iommu/vt-d: Apply per domain second level page table ops
>>    iommu/vt-d: Add first level page table interfaces
>>    iommu/vt-d: Implement first level page table ops
>>    iommu/vt-d: Identify domains using first level page table
>>    iommu/vt-d: Add set domain DOMAIN_ATTR_NESTING attr
>>
>>   drivers/iommu/Makefile             |   2 +-
>>   drivers/iommu/intel-iommu.c        | 412
>> +++++++++++++++++++++++------ drivers/iommu/intel-pgtable.c      |
>> 376 ++++++++++++++++++++++++++ include/linux/intel-iommu.h        |
>> 64 ++++- include/trace/events/intel_iommu.h |  60 +++++
>>   5 files changed, 837 insertions(+), 77 deletions(-)
>>   create mode 100644 drivers/iommu/intel-pgtable.c
>>
> 
> [Jacob Pan]
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
