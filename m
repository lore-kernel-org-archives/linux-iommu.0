Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65E5C433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 08:20:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D26E64FB1
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 08:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D26E64FB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9E36C203DC;
	Fri,  5 Feb 2021 08:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I1a9luBFtdYI; Fri,  5 Feb 2021 08:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C390E20377;
	Fri,  5 Feb 2021 08:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6176C0174;
	Fri,  5 Feb 2021 08:20:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A813C013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 08:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1F36B86398
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 08:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BPD24EVZSMnk for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 08:20:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3449386073
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 08:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612513252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EeBF5bycuJCMZzkkGmudP+Cph0B7XaVDWKDDmeU89sk=;
 b=W++mGzvmpWwH3B/Sis6jIzMNNPsQyINo23PrO7VewKwuHXw8YQCeYukMVFT6pCwud9oZXW
 FjUy8kfo81o6nnLB2XLsKHDIuLe6Z2DyN8FaiMh61mkvPBw77Jloq1hIbJX4F/tzB0v9Da
 LUe+A9pilY6cFwkkqsDpQC65Ft2eRLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-bodImPgyO6i9pzDC4fIUgg-1; Fri, 05 Feb 2021 03:20:48 -0500
X-MC-Unique: bodImPgyO6i9pzDC4fIUgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47C9A8030D1;
 Fri,  5 Feb 2021 08:20:46 +0000 (UTC)
Received: from [10.36.113.156] (ovpn-113-156.ams2.redhat.com [10.36.113.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E754A1971C;
 Fri,  5 Feb 2021 08:20:43 +0000 (UTC)
Subject: Re: [RFC 2/3] arm64/hugetlb: Enable HUGETLB_PAGE_SIZE_VARIABLE
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 akpm@linux-foundation.org
References: <1612422084-30429-1-git-send-email-anshuman.khandual@arm.com>
 <1612422084-30429-3-git-send-email-anshuman.khandual@arm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <616578ec-8a61-ce0a-a467-50915b3a9967@redhat.com>
Date: Fri, 5 Feb 2021 09:20:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1612422084-30429-3-git-send-email-anshuman.khandual@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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

On 04.02.21 08:01, Anshuman Khandual wrote:
> MAX_ORDER which invariably depends on FORCE_MAX_ZONEORDER can be a variable
> for a given page size, depending on whether TRANSPARENT_HUGEPAGE is enabled
> or not. In certain page size and THP combinations HUGETLB_PAGE_ORDER can be
> greater than MAX_ORDER, making it unusable as pageblock_order.

Just so I understand correctly, this does not imply that we have THP 
that exceed the pageblock size / MAX_ORDER size, correct?


> 
> This enables HUGETLB_PAGE_SIZE_VARIABLE making pageblock_order a variable
> rather than the compile time constant HUGETLB_PAGE_ORDER which could break
> MAX_ORDER rule for certain configurations.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 175914f2f340..c4acf8230f20 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1918,6 +1918,10 @@ config ARCH_ENABLE_THP_MIGRATION
>   	def_bool y
>   	depends on TRANSPARENT_HUGEPAGE
>   
> +config HUGETLB_PAGE_SIZE_VARIABLE
> +	def_bool y
> +	depends on HUGETLB_PAGE
> +
>   menu "Power management options"
>   
>   source "kernel/power/Kconfig"
> 


-- 
Thanks,

David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
