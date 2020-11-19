Return-Path: <SRS0=wYjh=EZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB31C63697
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 18:18:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0C824199
	for <iommu@archiver.kernel.org>; Thu, 19 Nov 2020 18:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0C824199
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3DDCC86BA4;
	Thu, 19 Nov 2020 18:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9q56-q_SB1y7; Thu, 19 Nov 2020 18:18:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7F8F086B8D;
	Thu, 19 Nov 2020 18:18:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 667DFC1825;
	Thu, 19 Nov 2020 18:18:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4911AC0891
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 18:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2FA6686D90
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 18:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PZpsdcRm3Enc for <iommu@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 18:18:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id B580A86D8D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Nov 2020 18:18:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCDF11595;
 Thu, 19 Nov 2020 10:18:28 -0800 (PST)
Received: from [192.168.2.21] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DD923F70D;
 Thu, 19 Nov 2020 10:18:25 -0800 (PST)
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
 <20201103173159.27570-2-nsaenzjulienne@suse.de>
 <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
 <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
From: James Morse <james.morse@arm.com>
Message-ID: <f15ad06d-faa8-65fc-6fc1-d5c77115b1f1@arm.com>
Date: Thu, 19 Nov 2020 18:18:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, ardb@kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com, will@kernel.org,
 hch@lst.de, linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com
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

(sorry for the late response)

On 06/11/2020 18:46, Nicolas Saenz Julienne wrote:
> On Thu, 2020-11-05 at 16:11 +0000, James Morse wrote:>> We also depend on this when skipping the checksum code in purgatory, which can be
>> exceedingly slow.
> 
> This one I don't fully understand, so I'll lazily assume the prerequisite is
> the same WRT how memory is mapped. :)

The aim is its never normally mapped by the kernel. This is so that if we can't get rid of
the secondary CPUs (e.g. they have IRQs masked), but they are busy scribbling all over
memory, we have a rough guarantee that they aren't scribbling over the kdump kernel.

We can skip the checksum in purgatory, as there is very little risk of the memory having
been corrupted.


> Ultimately there's also /sys/kernel/kexec_crash_size's handling. Same
> prerequisite.

Yeah, this lets you release PAGE_SIZEs back to the allocator, which means the
marked-invalid page tables we have hidden there need to be PAGE_SIZE mappings.


Thanks,

James


> Keeping in mind acpi_table_upgrade() and unflatten_device_tree() depend on
> having the linear mappings available. I don't see any simple way of solving
> this. Both moving the firmware description routines to use fixmap or correcting
> the linear mapping further down the line so as to include kdump's regions, seem
> excessive/impossible (feel free to correct me here). I'd be happy to hear
> suggestions. Otherwise we're back to hard-coding the information as we
> initially did.
> 
> Let me stress that knowing the DMA constraints in the system before reserving
> crashkernel's regions is necessary if we ever want it to work seamlessly on all
> platforms. Be it small stuff like the Raspberry Pi or huge servers with TB of
> memory.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
