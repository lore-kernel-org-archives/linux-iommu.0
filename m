Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A4CC43461
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 08:04:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE3C21741
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 08:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE3C21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 21035854DB;
	Mon, 14 Sep 2020 08:04:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rL1yjGl-Q5ma; Mon, 14 Sep 2020 08:04:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 81C6085045;
	Mon, 14 Sep 2020 08:04:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57E01C088B;
	Mon, 14 Sep 2020 08:04:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B08CCC0859
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 08:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9ADFD8694B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 08:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xe9Eq5llH59o for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 08:04:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7608B868FE
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 08:04:45 +0000 (UTC)
IronPort-SDR: gPUdYk9uFebmhIWx0tY3r2lPI+eSHYefju2kEgtt8868me95NEBKEcmooTfEQwWpTZgiGnrmhC
 /gJq98CKTsgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="220594630"
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; d="scan'208";a="220594630"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 01:04:44 -0700
IronPort-SDR: DB8QUYdnbcfSQP+fpUX9hltyKe3dQXbD75vf1SHVjvGqPh4EuHDGa2g4kwTZbb62YTNL6atH/W
 s3L3V+6Wn31A==
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; d="scan'208";a="507043788"
Received: from matancoh-mobl2.ger.corp.intel.com (HELO [10.255.198.45])
 ([10.255.198.45])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 01:04:41 -0700
Subject: Re: [PATCH v3 0/6] Convert the intel iommu driver to the dma-iommu api
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Tom Murphy <murphyt7@tcd.ie>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20200912032200.11489-1-baolu.lu@linux.intel.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <51a1baec-48d1-c0ac-181b-1fba92aa428d@linux.intel.com>
Date: Mon, 14 Sep 2020 09:04:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200912032200.11489-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: Intel-gfx@lists.freedesktop.org, Ashok Raj <ashok.raj@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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


Hi,

On 12/09/2020 04:21, Lu Baolu wrote:
> Tom Murphy has almost done all the work. His latest patch series was
> posted here.
> 
> https://lore.kernel.org/linux-iommu/20200903201839.7327-1-murphyt7@tcd.ie/
> 
> Thanks a lot!
> 
> This series is a follow-up with below changes:
> 
> 1. Add a quirk for the i915 driver issue described in Tom's cover
> letter.

Last week I have copied you on an i915 series which appears to remove the need for this quirk. so if we get those i915 patches reviewed and merged, do you still want to pursue this quirk?

> 2. Fix several bugs in patch "iommu: Allow the dma-iommu api to use
> bounce buffers" to make the bounce buffer work for untrusted devices.
> 3. Several cleanups in iommu/vt-d driver after the conversion.

With the previous version of the series I hit a problem on Ivybridge where apparently the dma engine width is not respected. At least that is my layman interpretation of the errors. From the older thread:

<3> [209.526605] DMAR: intel_iommu_map: iommu width (39) is not sufficient for the mapped address (ffff008000)

Relevant iommu boot related messages are:

<6>[    0.184234] DMAR: Host address width 36
<6>[    0.184245] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
<6>[    0.184288] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c0000020e60262 ecap f0101a
<6>[    0.184308] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
<6>[    0.184337] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap c9008020660262 ecap f0105a
<6>[    0.184357] DMAR: RMRR base: 0x000000d8d28000 end: 0x000000d8d46fff
<6>[    0.184377] DMAR: RMRR base: 0x000000db000000 end: 0x000000df1fffff
<6>[    0.184398] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
<6>[    0.184414] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
<6>[    0.184428] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
<6>[    0.185173] DMAR-IR: Enabled IRQ remapping in x2apic mode

<6>[    0.878934] DMAR: No ATSR found
<6>[    0.878966] DMAR: dmar0: Using Queued invalidation
<6>[    0.879007] DMAR: dmar1: Using Queued invalidation

<6>[    0.915032] DMAR: Intel(R) Virtualization Technology for Directed I/O
<6>[    0.915060] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
<6>[    0.915084] software IO TLB: mapped [mem 0xc80d4000-0xcc0d4000] (64MB)

(Full boot log at https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_7054/fi-ivb-3770/boot0.txt, failures at https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_7054/fi-ivb-3770/igt@i915_selftest@live@blt.html.)

Does this look familiar or at least plausible to you? Is this something your new series has fixed?

Regards,

Tvrtko

> 
> Please review and test.
> 
> Best regards,
> baolu
> 
> Lu Baolu (2):
>    iommu: Add quirk for Intel graphic devices in map_sg
>    iommu/vt-d: Cleanup after converting to dma-iommu ops
> 
> Tom Murphy (4):
>    iommu: Handle freelists when using deferred flushing in iommu drivers
>    iommu: Add iommu_dma_free_cpu_cached_iovas()
>    iommu: Allow the dma-iommu api to use bounce buffers
>    iommu/vt-d: Convert intel iommu driver to the iommu ops
> 
>   .../admin-guide/kernel-parameters.txt         |   5 -
>   drivers/iommu/dma-iommu.c                     | 229 ++++-
>   drivers/iommu/intel/Kconfig                   |   1 +
>   drivers/iommu/intel/iommu.c                   | 885 +++---------------
>   include/linux/dma-iommu.h                     |   8 +
>   include/linux/iommu.h                         |   1 +
>   6 files changed, 323 insertions(+), 806 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
