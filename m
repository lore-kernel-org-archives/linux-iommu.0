Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C696EC282CE
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 18:09:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4292146F
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 18:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4292146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 73D90261D;
	Fri,  5 Apr 2019 18:09:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 56F522612
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 18:08:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id F06F47E9
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 18:08:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B73E0168F;
	Fri,  5 Apr 2019 11:08:18 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E50FD3F557;
	Fri,  5 Apr 2019 11:08:16 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 2/4] iommu/arm-smmu-v3: Link domains and devices
To: Will Deacon <will.deacon@arm.com>
References: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
	<20190320173634.21895-3-jean-philippe.brucker@arm.com>
	<20190404143924.GB27823@fuggles.cambridge.arm.com>
	<312d33a5-8eca-3fae-fd8b-8325e045761b@arm.com>
	<20190405163949.GA19828@fuggles.cambridge.arm.com>
Message-ID: <b21e1dc0-c0c8-6c48-fd3f-cd6c9653434b@arm.com>
Date: Fri, 5 Apr 2019 19:07:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190405163949.GA19828@fuggles.cambridge.arm.com>
Content-Language: en-US
Cc: linux-acpi@vger.kernel.org, zhongmiao@hisilicon.com, rjw@rjwysocki.net,
	okaya@kernel.org, iommu@lists.linux-foundation.org,
	sudeep.holla@arm.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190405180756.PAlnnz1sBdcDeSbHXF8Q8UlVVYbyac1TP1KwAVF0b7Q@z>

On 05/04/2019 17:39, Will Deacon wrote:
>>> I'm wondering whether we can't take this a bit further and re-organise the
>>> data structures to make this a little simpler overall. Something along the
>>> lines of:
>>>
>>> 	struct arm_smmu_master_data {
>>> 		struct list_head		list; // masters in the same domain
>>> 		struct arm_smmu_device		*smmu;
>>> 		unsigned int			num_sids;
>>> 		u32				*sids; // Points into fwspec
>>> 		struct arm_smmu_domain		*domain; // NULL -> !assigned
>>> 	};
>>>
>>> and then just add a list_head into struct arm_smmu_domain to track the
>>> masters that have been attached (if you're feeling brave, you could put
>>> this into the s1_cfg).
>>
>> I'm not sure about that last bit, shouldn't the list of masters apply to
>> both s1 and s2?
> 
> I was assuming that (a) we were only using ATS with stage-1 and (b) we only
> need the masters list for ATC invalidation. Did I go wrong somewhere?

Hmm, I messed that up in patch 3, actually. I'm still unsure about it,
but in the end I was meaning to enable ATS for both stage-1 and stage-2
domains. We could make it stage-1 only, but VFIO can assign a device
with a stage-1 domain to userspace. That's the case with QEMU, which
doesn't use VFIO_TYPE1_NESTING_IOMMU at the moment. So I don't think
limiting ATS to stage-1 protects against anything.


For (b), the master list will likely also be used for PASID support, to
invalidate cached CDs for each device in a domain, but that's only stage-1.

Then the current patchsets for nested translation also rely on the
master list to bind guest PASID tables to all devices attached
to a domain. But with those patches, s1_cfg and s2_cfg aren't in an enum
anymore and we could still keep the list in s1_cfg.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
