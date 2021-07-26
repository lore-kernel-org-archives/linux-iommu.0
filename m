Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1003AC4338F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 11:54:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27A060F38
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 11:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B27A060F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 751068379C;
	Mon, 26 Jul 2021 11:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uhin_kRI9pve; Mon, 26 Jul 2021 11:54:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 608FE836F6;
	Mon, 26 Jul 2021 11:54:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F48FC001A;
	Mon, 26 Jul 2021 11:54:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF84EC000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 11:54:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB8F860708
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 11:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k38LJxLGFpgr for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 11:54:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56B87606B6
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 11:54:53 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8E53D46E; Mon, 26 Jul 2021 13:54:50 +0200 (CEST)
Date: Mon, 26 Jul 2021 13:54:49 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH,RFC] iommu/amd: Use report_iommu_fault()
Message-ID: <YP6iiR8wuszflhnN@8bytes.org>
References: <YPVL41ZO8Ih8WrKa@wantstofly.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YPVL41ZO8Ih8WrKa@wantstofly.org>
Cc: iommu@lists.linux-foundation.org
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

Hi Lennert,

On Mon, Jul 19, 2021 at 12:54:43PM +0300, Lennert Buytenhek wrote:
> +	if (dev_data) {
> +		int report_flags;
> +
> +		/*
> +		 * AMD I/O Virtualization Technology (IOMMU) Specification,
> +		 * revision 3.00, section 2.5.3 ("IO_PAGE_FAULT Event") says
> +		 * that the RW ("read-write") bit is only valid if the I/O
> +		 * page fault was caused by a memory transaction request
> +		 * referencing a page that was marked present.
> +		 */
> +		report_flags = 0;
> +		if ((flags & (EVENT_FLAG_TR | EVENT_FLAG_PR | EVENT_FLAG_I)) ==
> +								EVENT_FLAG_PR) {
> +			if (flags & EVENT_FLAG_RW)
> +				report_flags |= IOMMU_FAULT_WRITE;
> +			else
> +				report_flags |= IOMMU_FAULT_READ;
> +		}
> +
> +		if (!report_iommu_fault(&dev_data->domain->domain,
> +					&pdev->dev, address, report_flags))
> +			goto out;
> +	}

I'd like to limit calling report_iommu_fault() to dma-faults and leave
IRQ remapping faults unreported. The IOMMU layer does not really care a
lot about IRQs and a potential domain handler will also not be prepared
to handler IRQ specific faults (there is no generic way to detect them).

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
