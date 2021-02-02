Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B15C433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 12:08:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107AA64F61
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 12:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107AA64F61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AD96E8677C;
	Tue,  2 Feb 2021 12:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aJxIl9RT71As; Tue,  2 Feb 2021 12:08:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0C3C084973;
	Tue,  2 Feb 2021 12:08:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2335C0FA7;
	Tue,  2 Feb 2021 12:08:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEDD6C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 12:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EA66F849A6
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 12:08:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TDueJXcOXb-8 for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 12:07:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id EB86384973
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 12:07:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED3261396;
 Tue,  2 Feb 2021 04:07:57 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13D6C3F718;
 Tue,  2 Feb 2021 04:07:54 -0800 (PST)
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jianxiong Gao <jxgao@google.com>
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
 <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
 <CAMGD6P0uwVxKuG503ahGTbPcwb+y2wRXSiE_gvzfdUrMfZ5YbA@mail.gmail.com>
 <YBk1pUbQ/JZQ7WZe@smile.fi.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a34328d1-3918-1eca-b632-57be6a40baee@arm.com>
Date: Tue, 2 Feb 2021 12:07:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBk1pUbQ/JZQ7WZe@smile.fi.intel.com>
Content-Language: en-GB
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>, bgolaszewski@baylibre.com,
 Marc Orr <marcorr@google.com>, gregkh@linuxfoundation.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 axboe@fb.com, iommu@lists.linux-foundation.org, jroedel@suse.de,
 Keith Busch <kbusch@kernel.org>, dan.j.williams@intel.com,
 Christoph Hellwig <hch@lst.de>
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

On 2021-02-02 11:21, Andy Shevchenko wrote:
> On Mon, Feb 01, 2021 at 04:25:55PM -0800, Jianxiong Gao wrote:
> 
>> +       if (dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
> 
> Side note: we have DMA_BIT_MASK(), please use it.

FWIW I'd actually disagree on that point. Conceptually, this is a very 
different thing from dev->{coherent_}dma_mask. It does not need to 
handle everything up to 2^64-1 correctly without overflow issues, and 
data alignments typically *are* defined in terms of sizes rather than 
numbers of bits.

In fact, it might be neat to just have callers pass a size directly to a 
dma_set_min_align() interface which asserts that it is a power of two 
and stores it as a mask internally.

Robin.

> 
>> +               dev_warn(dev->dev, "dma_set_min_align_mask failed to
>> set offset\n");
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
