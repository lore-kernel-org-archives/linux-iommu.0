Return-Path: <SRS0=Ithz=52=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD9C2BA19
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 01:22:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EAB20730
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 01:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EAB20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 49CC587943;
	Fri, 10 Apr 2020 01:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oTjUoOuMf+v3; Fri, 10 Apr 2020 01:22:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6314187969;
	Fri, 10 Apr 2020 01:22:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42866C1D7E;
	Fri, 10 Apr 2020 01:22:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23A16C0177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 01:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1871A87954
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 01:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HOb3tPt7gVvm for <iommu@lists.linux-foundation.org>;
 Fri, 10 Apr 2020 01:22:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 395D887943
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 01:22:13 +0000 (UTC)
IronPort-SDR: WbHHXCa8Jk/9XDWy0jxKcGM/PVdoP2oIBuh4kSYlHRCV9lizlPoURYZ1zUTzKFCsDYiAYYtS16
 sUL5WdKR+3TA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 18:22:12 -0700
IronPort-SDR: U0LlOhp033dDpJPPRIzdr1qICn5m5DgXMkvF6UN2/gm+pVchKp5Q1VZM1s1x4NEjzo2NQHo0+X
 tFeKb4LUNZng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,364,1580803200"; d="scan'208";a="244462326"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.184])
 ([10.254.208.184])
 by fmsmga008.fm.intel.com with ESMTP; 09 Apr 2020 18:22:10 -0700
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and
 subdevices
To: Jon Derrick <jonathan.derrick@intel.com>, Joerg Roedel <joro@8bytes.org>, 
 iommu@lists.linux-foundation.org
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
 <20200409191736.6233-2-jonathan.derrick@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <09c98569-ed22-8886-3372-f5752334f8af@linux.intel.com>
Date: Fri, 10 Apr 2020 09:22:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409191736.6233-2-jonathan.derrick@intel.com>
Content-Language: en-US
Cc: linux-pci@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux@endlessm.com
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

Hi,

On 2020/4/10 3:17, Jon Derrick wrote:
> The PCI devices handled by intel-iommu may have a DMA requester on another bus,
> such as VMD subdevices needing to use the VMD endpoint.
> 
> The real DMA device is now used for the DMA mapping, but one case was missed
> earlier: if the VMD device (and hence subdevices too) are under
> IOMMU_DOMAIN_IDENTITY, mappings do not work.
> 
> Codepaths like intel_map_page() handle the IOMMU_DOMAIN_DMA case by creating an
> iommu DMA mapping, and fall back on dma_direct_map_page() for the
> IOMMU_DOMAIN_IDENTITY case. However, handling of the IDENTITY case is broken
> when intel_page_page() handles a subdevice.
> 
> We observe that at iommu attach time, dmar_insert_one_dev_info() for the
> subdevices will never set dev->archdata.iommu. This is because that function

Do you mind telling why not setting this?

> uses find_domain() to check if there is already an IOMMU for the device, and
> find_domain() then defers to the real DMA device which does have one. Thus
> dmar_insert_one_dev_info() returns without assigning dev->archdata.iommu.
> 
> Then, later:
> 
> 1. intel_map_page() checks if an IOMMU mapping is needed by calling
>     iommu_need_mapping() on the subdevice. identity_mapping() returns
>     false because dev->archdata.iommu is NULL, so this function
>     returns false indicating that mapping is needed.
> 2. __intel_map_single() is called to create the mapping.
> 3. __intel_map_single() calls find_domain(). This function now returns
>     the IDENTITY domain corresponding to the real DMA device.
> 4. __intel_map_single() calls domain_get_iommu() on this "real" domain.
>     A failure is hit and the entire operation is aborted, because this
>     codepath is not intended to handle IDENTITY mappings:
>         if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
>                     return NULL;

This is caused by the fragile private domain implementation. We are in
process of removing it by enhancing the iommu subsystem with per-group
default domain.

https://www.spinics.net/lists/iommu/msg42976.html

So ultimately VMD subdevices should have their own per-device iommu data
and support per-device dma ops.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
