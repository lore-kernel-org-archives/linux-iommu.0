Return-Path: <SRS0=QcZA=YE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D121C47404
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 09:43:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F52A21A4A
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 09:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F52A21A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B349EF68;
	Fri, 11 Oct 2019 09:43:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 25DE8102E
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 09:33:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B05A114D
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 09:33:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E49D3337;
	Fri, 11 Oct 2019 02:33:50 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25DC13F703;
	Fri, 11 Oct 2019 02:33:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dma-mapping: Add vmap checks to dma_map_single()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>
References: <20191010222829.21940-1-keescook@chromium.org>
	<20191010222829.21940-2-keescook@chromium.org>
	<20191011050208.GA978459@kroah.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4f559fe1-a867-c3ca-eed2-1962d01d5346@arm.com>
Date: Fri, 11 Oct 2019 10:33:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
	Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191011050208.GA978459@kroah.com>
Content-Language: en-GB
Cc: Semmle Security Reports <security-reports@semmle.com>,
	linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
	iommu@lists.linux-foundation.org, Dan Carpenter <dan.carpenter@oracle.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Laura Abbott <labbott@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Allison Randal <allison@lohutok.net>
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

On 2019-10-11 6:02 am, Greg Kroah-Hartman wrote:
> On Thu, Oct 10, 2019 at 03:28:28PM -0700, Kees Cook wrote:
>> As we've seen from USB and other areas[1], we need to always do runtime
>> checks for DMA operating on memory regions that might be remapped. This
>> adds vmap checks (similar to those already in USB but missing in other
>> places) into dma_map_single() so all callers benefit from the checking.
>>
>> [1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb
>>
>> Suggested-by: Laura Abbott <labbott@redhat.com>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>   include/linux/dma-mapping.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 4a1c4fca475a..ff4e91c66f44 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -583,6 +583,12 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
>>   static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>>   {
>> +	/* DMA must never operate on areas that might be remapped. */
>> +	if (unlikely(is_vmalloc_addr(ptr))) {
>> +		dev_warn_once(dev, "bad map: %zu bytes in vmalloc\n", size);
> 
> Can we get a bit better error text here?  In USB we were at least giving
> people a hint as to what went wrong, "bad map" might not really make
> that much sense to a USB developer as to what they needed to do to fix
> this issue.

Agreed, something along the lines of "dma_map_single of vmalloc'ed 
buffer..." might be clearer. Also I'd be inclined to use dev_WARN_ONCE() 
to include a diagnostically-useful backtrace, as the existing USB code 
would.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
