Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB80EC636C8
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 17:45:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40593613C4
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 17:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40593613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9EA8423DA;
	Thu, 15 Jul 2021 17:45:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SDJumFmUiNzs; Thu, 15 Jul 2021 17:45:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BC5D423D4;
	Thu, 15 Jul 2021 17:45:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11AD2C001A;
	Thu, 15 Jul 2021 17:45:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08EA8C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA7FD840F9
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:45:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xeJnCr6dQoCo for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 17:45:51 +0000 (UTC)
X-Greylist: delayed 00:29:48 by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73623840DB
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=zhc7pzLmZmjUsLXsFnMXewKeUUfUybMjLBdEKzxTgWI=; b=a4eD7Hw2j62J4jmrqG3qM9ka82
 5k5K5mLQB+hZHZqXGBpC8vAokNP0Ip4On3I09UBGqNxaWIRq2dmyriwR06pgFKl9jIT5xqRBf9vsD
 YwuOCb9uZhKtsGIHsKDWUmojgkYI2/2LwIaMUocRxIEBx7IUQ/6yxeiqqZGnSG4a85UbkDOZqICEa
 lG9jcrA6QbuiJkY03RA7uB1x8xSEwzPTD/kmMZHa3L73KtXI/2a8MW52t16HXK3n1ZJYijnMXJyfP
 O/wyAVK1kdSyrErsaIIRyaT5BgNIbq1xTAmZfgnfhUHzVRbyGsOS/vCEnIuD/1MU7ahfhlv+CI82Y
 BmE/J6uw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1m44eg-0002EB-Nd; Thu, 15 Jul 2021 10:56:11 -0600
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <20210715164544.6827-1-logang@deltatee.com>
 <20210715165309.GO22278@shell.armlinux.org.uk>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aa33d2bf-8324-5647-b800-3a2e3e774e80@deltatee.com>
Date: Thu, 15 Jul 2021 10:56:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715165309.GO22278@shell.armlinux.org.uk>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: martin.oliveira@eideticom.com, sbates@raithlin.com,
 robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de,
 xen-devel@lists.xenproject.org, linux-parisc@vger.kernel.org,
 iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mips@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v1 00/16] .map_sg() error cleanup
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, Stephen Bates <sbates@raithlin.com>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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




On 2021-07-15 10:53 a.m., Russell King (Oracle) wrote:
> On Thu, Jul 15, 2021 at 10:45:28AM -0600, Logan Gunthorpe wrote:
>> Hi,
>>
>> This series is spun out and expanded from my work to add P2PDMA support
>> to DMA map operations[1].
>>
>> The P2PDMA work requires distinguishing different error conditions in
>> a map_sg operation. dma_map_sgtable() already allows for returning an
>> error code (where as dma_map_sg() is only allowed to return zero)
>> however, it currently only returns -EINVAL when a .map_sg() call returns
>> zero.
>>
>> This series cleans up all .map_sg() implementations to return appropriate
>> error codes. After the cleanup, dma_map_sg() will still return zero,
>> however dma_map_sgtable() will pass the error code from the .map_sg()
>> call. Thanks go to Martn Oliveira for doing a lot of the cleanup of the
>> obscure implementations.
>>
>> The patch set is based off of v5.14-rc1 and a git repo can be found
>> here:
> 
> Have all the callers for dma_map_sg() been updated to check for error
> codes? If not, isn't that a pre-requisit to this patch set?

No. Perhaps I wasn't clear enough: This series is changing only
impelemntations of .map_sg(). It does *not* change the return code of
dma_map_sg(). dma_map_sg() will continue to return zero on error for the
foreseeable future. The dma_map_sgtable() call already allows returning
error codes and it will pass the new error code through. This is what
will be used in the P2PDMA work.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
