Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4284C31E40
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 15:49:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D01520717
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 15:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D01520717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4A84DD09;
	Tue,  6 Aug 2019 15:49:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 84C299F0
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 15:49:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id EB6E88A9
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 15:49:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3DE344;
	Tue,  6 Aug 2019 08:49:03 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12FAE3F575;
	Tue,  6 Aug 2019 08:49:02 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Handle SG length overflow better
To: Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicoleotsuka@gmail.com>
References: <fbdbb8c0e550ae559ea3eedc1fea084c0111f202.1564418681.git.robin.murphy@arm.com>
	<20190806152529.GB1198@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <166ef834-c10e-5f94-ee89-6a0caedf323d@arm.com>
Date: Tue, 6 Aug 2019 16:49:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190806152529.GB1198@8bytes.org>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org
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

Hi Joerg,

On 06/08/2019 16:25, Joerg Roedel wrote:
> Hi Robin,
> 
> On Mon, Jul 29, 2019 at 05:46:00PM +0100, Robin Murphy wrote:
>> Since scatterlist dimensions are all unsigned ints, in the relatively
>> rare cases where a device's max_segment_size is set to UINT_MAX, then
>> the "cur_len + s_length <= max_len" check in __finalise_sg() will always
>> return true. As a result, the corner case of such a device mapping an
>> excessively large scatterlist which is mergeable to or beyond a total
>> length of 4GB can lead to overflow and a bogus truncated dma_length in
>> the resulting segment.
>>
>> As we already assume that any single segment must be no longer than
>> max_len to begin with, this can easily be addressed by reshuffling the
>> comparison.
> 
> Has this been triggered in the wild of can this patch wait for the next
> merge window?

My impression was that it's possible to hit this via relatively funky, 
but legitimate, use of dma-buf from userspace, however I don't know 
off-hand how many drivers actually support creating and exporting such 
crazy-large buffers in the first place.

Nicolin - is your use-case something that's easy to do with standard 
software on stable kernels, or did it only come to light as part of a 
"big stack of embedded magic" type thing?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
