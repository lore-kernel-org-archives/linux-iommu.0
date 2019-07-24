Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FA0C76186
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 17:06:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C8820659
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 17:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C8820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5719010AF;
	Wed, 24 Jul 2019 17:06:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 088EE10A7
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 17:06:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id A189B775
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 17:06:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 464CE28;
	Wed, 24 Jul 2019 10:06:14 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 769E73F71F;
	Wed, 24 Jul 2019 10:06:12 -0700 (PDT)
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
	DMA masks
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
	<20190724155530.hlingpcirjcf2ljg@box>
	<acee0a74-77fc-9c81-087b-ce55abf87bd4@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a89e7574-096d-9105-45ff-34bbb74918a5@arm.com>
Date: Wed, 24 Jul 2019 18:06:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <acee0a74-77fc-9c81-087b-ce55abf87bd4@amd.com>
Content-Language: en-GB
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Lianbo Jiang <lijiang@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
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

On 24/07/2019 17:42, Lendacky, Thomas wrote:
> On 7/24/19 10:55 AM, Kirill A. Shutemov wrote:
>> On Wed, Jul 10, 2019 at 07:01:19PM +0000, Lendacky, Thomas wrote:
>>> @@ -351,6 +355,32 @@ bool sev_active(void)
>>>   }
>>>   EXPORT_SYMBOL(sev_active);
>>>   
>>> +/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>>> +bool force_dma_unencrypted(struct device *dev)
>>> +{
>>> +	/*
>>> +	 * For SEV, all DMA must be to unencrypted addresses.
>>> +	 */
>>> +	if (sev_active())
>>> +		return true;
>>> +
>>> +	/*
>>> +	 * For SME, all DMA must be to unencrypted addresses if the
>>> +	 * device does not support DMA to addresses that include the
>>> +	 * encryption mask.
>>> +	 */
>>> +	if (sme_active()) {
>>> +		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>>> +		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>>> +						dev->bus_dma_mask);
>>> +
>>> +		if (dma_dev_mask <= dma_enc_mask)
>>> +			return true;
>>
>> Hm. What is wrong with the dev mask being equal to enc mask? IIUC, it
>> means that device mask is wide enough to cover encryption bit, doesn't it?
> 
> Not really...  it's the way DMA_BIT_MASK works vs bit numbering. Let's say
> that sme_me_mask has bit 47 set. __ffs64 returns 47 and DMA_BIT_MASK(47)
> will generate a mask without bit 47 set (0x7fffffffffff). So the check
> will catch anything that does not support at least 48-bit DMA.

Couldn't that be expressed as just:

	if (sme_me_mask & dma_dev_mask == sme_me_mask)

?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
