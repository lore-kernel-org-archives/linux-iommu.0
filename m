Return-Path: <SRS0=qRzs=4A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91418C2BA83
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 13:50:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBCA20724
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 13:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBCA20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 272E2843BB;
	Wed, 12 Feb 2020 13:50:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NcST1P6qwU6R; Wed, 12 Feb 2020 13:50:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 612F9834E6;
	Wed, 12 Feb 2020 13:50:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49A92C07FE;
	Wed, 12 Feb 2020 13:50:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77EBBC0177
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 13:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5C74F84D09
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 13:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 99A5o228KcKL for <iommu@lists.linux-foundation.org>;
 Wed, 12 Feb 2020 13:50:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 260FB84CF4
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 13:50:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FDDD328;
 Wed, 12 Feb 2020 05:50:11 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DADC3F6CF;
 Wed, 12 Feb 2020 05:50:10 -0800 (PST)
Subject: Re: [PATCH] iommu/vt-d: consider real PCI device when checking if
 mapping is needed
To: Daniel Drake <drake@endlessm.com>,
 "Derrick, Jonathan" <jonathan.derrick@intel.com>
References: <20200211091352.12031-1-drake@endlessm.com>
 <bf9337f8c4336ee3bdb123ff381ec1330bdc8150.camel@intel.com>
 <CAD8Lp47c=fq6dpGSZx3YqGk_T0CZwZcywqcA4CqDmH13d8vQzQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0a415530-5f96-87cf-242c-f4ec4f2f1920@arm.com>
Date: Wed, 12 Feb 2020 13:50:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAD8Lp47c=fq6dpGSZx3YqGk_T0CZwZcywqcA4CqDmH13d8vQzQ@mail.gmail.com>
Content-Language: en-GB
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux@endlessm.com" <linux@endlessm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
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

On 12/02/2020 3:17 am, Daniel Drake wrote:
> On Wed, Feb 12, 2020 at 12:03 AM Derrick, Jonathan
> <jonathan.derrick@intel.com> wrote:
>> On Tue, 2020-02-11 at 17:13 +0800, Daniel Drake wrote:
>>> The PCI devices handled by intel-iommu may have a DMA requester on
>>> another bus, such as VMD subdevices needing to use the VMD endpoint.
>>>
>>> The real DMA device is now used for the DMA mapping, but one case was
>>> missed earlier, when allocating memory through (e.g.) intel_map_page().
>>> Confusion ensues if the iommu domain type for the subdevice does not match
>>> the iommu domain type for the real DMA device.
>> Is there a way to force this situation for my testing?
> 
> I think you could hack device_def_domain_type() to return
> IOMMU_DOMAIN_IDENTITY for the real device, and IOMMU_DOMAIN_DMA for
> the subdevice.

As far as I'm aware that should only be possible if the subdevice has a 
distinct physical requester ID from the real device, which given the 
nomenclature I assume is not the case.

(well, technically you *can* start routing different logical streams 
from a single requester ID to multiple domains if you have PASIDs, but 
that's a whole other ball game)

Robin.

> But I got curious as to why my subdevice might be IOMMU_DOMAIN_DMA, so
> I checked, and found out that my assumptions weren't quite correct.
> The subdevice has no iommu domain recorded at all. Before applying any
> patches here, what's actually happening is:
> 
> 1. Real DMA device gets registered with the iommu as
> IOMMU_DOMAIN_IDENTITY using si_domain.
> 2. When the subdevice gets registered, the relevant code flow is
> inside dmar_insert_one_dev_info():
>   - it creates a new device_domain_info and domain->domain.type == IDENTITY, but
>   - it then calls find_domain(dev) which successfully defers to the
> real DMA device and returns the real DMA device's dmar_domain
>   - since found != NULL (dmar_domain was found for this device) the
> function bails out before setting dev->archdata.iommu
> 
> The results at this point are that the real DMA device is fully
> registered as IOMMU_DOMAIN_IDENTITY using si_domain, but all of the
> subdevices will always have dev->archdata.iommu == NULL.
> 
> Then when intel_map_page() is reached for the subdevice, it calls
> iommu_need_mapping() for the subdevice.
> This calls identity_mapping() on the subdevice, but that will always
> return 0 because dev->archdata.iommu == NULL.
> Following on from there, iommu_need_mapping() will then *always*
> return true (mapping needed) for subdevices.
> 
> That will then lead to the situation described in my last mail, where
> later down the allocation chain the request for creating a mapping
> will be handed towards the real DMA dev, but that will then fail
> because the real DMA dev is using IOMMU_DOMAIN_IDENTITY where no
> mapping is needed.
> 
> Unless I missed anything that seems pretty clear to me now, and I
> guess the only reason why you may not have already faced this in the
> vmd case is if the real DMA device is not using IOMMU_DOMAIN_IDENTITY.
> (To check this, you could log the value of the real dev
> domain->domain.type in dmar_insert_one_dev_info(), and/or observe the
> return value of identity_mapping() in iommu_need_mapping for the real
> dev).
> 
> In any case it seems increasingly clear to me that
> iommu_need_mapping() should be consulting the real DMA device in the
> identity_mapping check, and your patch likewise solves the problem
> faced here.
> 
> Thanks
> Daniel
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
