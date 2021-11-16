Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB362C433FE
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 11:31:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C44561360
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 11:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C44561360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 528A380EE6;
	Tue, 16 Nov 2021 11:31:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XcGyBJXECqmC; Tue, 16 Nov 2021 11:31:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24BE780EE4;
	Tue, 16 Nov 2021 11:31:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F11C5C001E;
	Tue, 16 Nov 2021 11:31:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 712EEC0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 58BE3607D7
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WLWRkkalXCD1 for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 11:31:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95C6360766
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:31:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E535B1FB;
 Tue, 16 Nov 2021 03:31:54 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 584EE3F766;
 Tue, 16 Nov 2021 03:31:54 -0800 (PST)
Message-ID: <73f5c70b-033c-f676-8ae9-4e89d5b043f1@arm.com>
Date: Tue, 16 Nov 2021 11:31:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: dma-direct fixes and cleanups v3
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211111065028.32761-1-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211111065028.32761-1-hch@lst.de>
Cc: David Rientjes <rientjes@google.com>
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

On 2021-11-11 06:50, Christoph Hellwig wrote:
> Hi all,
> 
> Linus complained about the complex flow in dma_direct_alloc, so this
> tries to simplify it a bit, and while I was at it I also made sure that
> unencrypted pages never leak back into the page allocator.

Before I forget, I've had a quick skim of the remaining patches and 
nothing more stands out. Let me know if you'd like me to find time to 
check everything over in detail again for a proper review, but otherwise 
I reckon we may as well get this baking in -next sooner rather than later.

Cheers,
Robin.

> Changes since v2:
>   - don't call dma_set_decrypted on remapped memory
>   - move the leak printk into dma_set_encrypted
>   - add another local variable to clean up dma_direct_alloc
>   - return NULL when the is no way to make the memory coherent
> 
> Changes since v1:
>   - fix a missing return
>   - add a new patch to fix a pre-existing missing unmap
>   - various additional cleanups
>   
> Diffstat:
>   direct.c |  234 +++++++++++++++++++++++++++++++++++++--------------------------
>   1 file changed, 138 insertions(+), 96 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
