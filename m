Return-Path: <SRS0=4Gp4=44=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5443C10F25
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 06:51:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F459208C4
	for <iommu@archiver.kernel.org>; Wed, 11 Mar 2020 06:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F459208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 66588881BF;
	Wed, 11 Mar 2020 06:51:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mcSbbgQgR3Ve; Wed, 11 Mar 2020 06:51:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8440088189;
	Wed, 11 Mar 2020 06:50:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65A18C18D3;
	Wed, 11 Mar 2020 06:50:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F860C0177
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 06:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4637C878F0
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 06:50:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FbuZcpJgulGF for <iommu@lists.linux-foundation.org>;
 Wed, 11 Mar 2020 06:50:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 60B3C8742D
 for <iommu@lists.linux-foundation.org>; Wed, 11 Mar 2020 06:50:44 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Mar 2020 23:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; d="scan'208";a="242588178"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.137])
 ([10.254.208.137])
 by orsmga003.jf.intel.com with ESMTP; 10 Mar 2020 23:50:40 -0700
Subject: Re: [PATCH 0/6] Replace private domain with per-group default
To: Joerg Roedel <joro@8bytes.org>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
 <20200310111503.GF3794@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cd0f526c-da68-ef59-580f-665ad08a395f@linux.intel.com>
Date: Wed, 11 Mar 2020 14:50:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310111503.GF3794@8bytes.org>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
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

Hi Joerg,

On 2020/3/10 19:15, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Sat, Mar 07, 2020 at 02:20:08PM +0800, Lu Baolu wrote:
>> Lu Baolu (5):
>>    iommu: Configure default domain with dev_def_domain_type
>>    iommu/vt-d: Don't force 32bit devices to uses DMA domain
>>    iommu/vt-d: Don't force PCI sub-hierarchy to use DMA domain
>>    iommu/vt-d: Add dev_def_domain_type callback
>>    iommu/vt-d: Apply per-device dma_ops
>>
>> Sai Praneeth Prakhya (1):
>>    iommu: Add dev_def_domain_type() callback in iommu_ops
> 
> I like this patch-set, but I fear some regressions from patch
> "iommu/vt-d: Don't force 32bit devices to uses DMA domain". Have you
> tested this series on a couple of machines, ideally even older ones from
> the first generation of VT-d hardware?

The oldest hardware I have is Ivy Bridge. :-) Actually, The effect of
using identity domain for 32-bit devices is the same as that of adding
intel_iommu=off in the kernel parameter. Hence, if there is any
regression, people should also find it with intel_iommu=off.
intel_iommu=off support is added at the very beginning of VT-d driver.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
