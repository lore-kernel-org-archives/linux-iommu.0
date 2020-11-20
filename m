Return-Path: <SRS0=3eTK=E2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC975C5519F
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 13:39:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE67222C3
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 13:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE67222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 94E2286EB1;
	Fri, 20 Nov 2020 13:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YMurCN_Ex9bW; Fri, 20 Nov 2020 13:39:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1D36986EA2;
	Fri, 20 Nov 2020 13:39:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00A83C1825;
	Fri, 20 Nov 2020 13:39:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0301C0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 13:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A7B0A871AB
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 13:39:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WPTit07ExFEM for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 13:39:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E5B39871A5
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 13:39:41 +0000 (UTC)
IronPort-SDR: rnU/9/TXD6Da5BGkgxD8YntK86yArcTjl7QgccCbT/E3Ldqgqj+1aCjhJ38g2Z85kb9h4aalVv
 MKMsqAFwB3yA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="159242245"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; d="scan'208";a="159242245"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2020 05:39:41 -0800
IronPort-SDR: zcG5jgBnh2cMRVml9SIPx982RrslX9yNsB54Wl4V064d/Q6eIpva3+ifWf9WrQEC7BZslaVb/d
 ov8mxQPySJwQ==
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; d="scan'208";a="360447085"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.97])
 ([10.254.215.97])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2020 05:39:38 -0800
To: Chris Wilson <chris@chris-wilson.co.uk>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse
 <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Tom Murphy <murphyt7@tcd.ie>, Will Deacon <will@kernel.org>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
 <160587504147.19364.17448380121292539865@build.alporthouse.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 0/7] Convert the intel iommu driver to the dma-iommu api
Message-ID: <2ff7be9f-75e8-03a2-8030-92cb734faa61@linux.intel.com>
Date: Fri, 20 Nov 2020 21:39:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <160587504147.19364.17448380121292539865@build.alporthouse.com>
Content-Language: en-US
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org
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

Hi Chris,

On 2020/11/20 20:24, Chris Wilson wrote:
> Quoting Lu Baolu (2020-11-20 10:17:12)
>> Lu Baolu (3):
>>    iommu: Add quirk for Intel graphic devices in map_sg
>>    iommu/vt-d: Update domain geometry in iommu_ops.at(de)tach_dev
>>    iommu/vt-d: Cleanup after converting to dma-iommu ops
>>
>> Tom Murphy (4):
>>    iommu: Handle freelists when using deferred flushing in iommu drivers
>>    iommu: Add iommu_dma_free_cpu_cached_iovas()
>>    iommu: Allow the dma-iommu api to use bounce buffers
>>    iommu/vt-d: Convert intel iommu driver to the iommu ops
> 
> Something that may be of interest is that we encounter problems with
> using intel-iommu across a PCI remove event. All HW generations fail
> with faults like:
> 
> DMAR: DRHD: handling fault status reg 3
> DMAR: [DMA Write] Request device [00:02.0] PASID ffffffff fault addr 4b822000 [fault reason 02] Present bit in context entry is clear
> 
> i.e. they all report missing present bit after re-adding the device to the
> iommu group. Forcing an identity map (or disabling iommu) works fine.
> 
> I applied this series just on the off-chance it changed the symptoms; it
> does not. If you have any ideas on how to chase down this fault, that
> would be very useful. We have a few other DMAR faults visible on many
> platforms, all "[fault reason 07] Next page table ptr is invalid" that
> are again not affected by this series, that we also need to resolve.

This series only replaces the previous vt-d self-made dma api's with the
generic one (which has already been used by some other vendor iommu
drivers). It shouldn't solve the problem you're having.

How about reporting them in https://bugzilla.kernel.org/? I have
interests to help to figure out possible fixes.

> -Chris
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
