Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EDFC433EF
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 07:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DA5341707;
	Wed, 18 May 2022 07:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eeIyk21i9VON; Wed, 18 May 2022 07:38:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1ED70416F1;
	Wed, 18 May 2022 07:38:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E65A9C0032;
	Wed, 18 May 2022 07:38:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 135E5C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 07:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 022958333E
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 07:38:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5l8eevkmfV_N for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 07:38:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D7FC6832DC
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 07:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652859499; x=1684395499;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rK9Kd22X5mr1Q7KtU0cqXcihhnCmtCTuqikltUyWYO8=;
 b=DAlBXXXZ8eRfhlJkIGKMOfkFlNC09iuRWojQy2j2/738vTggoSNwFjry
 rXho/+YAdXQyCDN13M0nzxBha+zW1RdJ/hN2Kd7X9zoD24l4wTC4mv9vL
 2gow2gL6x3FkWO8ZE+4ntlEKZgeZt5cfvOzP4yYGVKh64QJ9qAV7bg8hW
 9BkL/EzQk/7Mebhqi0ENwYOdBzmUL/QYEFNvmVgBtIaiuerzkmOdFW4x7
 BLwc8Q+j4vyJX22VkPaSOx8HbKs4RIhCuvm/7/tvdfDD6sv+PkTabqUbf
 FWTSY+whRTphaqzqzgnoQdR914NxWTkbDjXNfnoqBIuCuhAzYeJUeYT2i A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="253579579"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; d="scan'208";a="253579579"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 00:38:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; d="scan'208";a="545307262"
Received: from lenawanx-mobl.ccr.corp.intel.com (HELO [10.255.28.87])
 ([10.255.28.87])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2022 00:38:10 -0700
Message-ID: <efab101f-14e2-ab5c-810d-c355aebaad52@linux.intel.com>
Date: Wed, 18 May 2022 15:38:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 6/7] x86/boot/tboot: Move tboot_force_iommu() to Intel
 IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-7-baolu.lu@linux.intel.com>
 <20220516180628.GL1343366@nvidia.com>
 <6cdc43a3-72ba-5360-0827-6915ef563d64@linux.intel.com>
 <20220517111350.GR1343366@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220517111350.GR1343366@nvidia.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Ashok Raj <ashok.raj@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Ning Sun <ning.sun@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Borislav Petkov <bp@alien8.de>, Robin Murphy <robin.murphy@arm.com>
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

On 2022/5/17 19:13, Jason Gunthorpe wrote:
> On Tue, May 17, 2022 at 10:05:43AM +0800, Baolu Lu wrote:
>> Hi Jason,
>>
>> On 2022/5/17 02:06, Jason Gunthorpe wrote:
>>>> +static __init int tboot_force_iommu(void)
>>>> +{
>>>> +	if (!tboot_enabled())
>>>> +		return 0;
>>>> +
>>>> +	if (no_iommu || dmar_disabled)
>>>> +		pr_warn("Forcing Intel-IOMMU to enabled\n");
>>> Unrelated, but when we are in the special secure IOMMU modes, do we
>>> force ATS off? Specifically does the IOMMU reject TLPs that are marked
>>> as translated?
>>
>> Good question. From IOMMU point of view, I don't see a point to force
>> ATS off, but trust boot involves lots of other things that I am not
>> familiar with. Anybody else could help to answer?
> 
> ATS is inherently not secure, if a rouge device can issue a TLP with
> the translated bit set then it has unlimited access to host memory.

Agreed. The current logic is that the platform lets the OS know such
devices through firmware (ACPI/DT) and OS sets the untrusted flag in
their device structures. The IOMMU subsystem will disable ATS on devices
with the untrusted flag set.

There is some discussion about allowing the supervisor users to set the
trust policy through the sysfs ABI, but I don't think this has happened
in upstream kernel.

> Many of these trusted iommu scenarios rely on the idea that a rouge
> device cannot DMA to arbitary system memory.

I am not sure whether tboot has the same requirement.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
