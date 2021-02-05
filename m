Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A338FC433DB
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 08:29:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8F764F9C
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 08:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8F764F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D39B3870D9;
	Fri,  5 Feb 2021 08:29:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D2P6git4gftV; Fri,  5 Feb 2021 08:29:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1339687092;
	Fri,  5 Feb 2021 08:29:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04607C0174;
	Fri,  5 Feb 2021 08:29:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C9E1C013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 08:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 13EAD2E0FE
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 08:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tRY99vE69TfI for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 08:29:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id ECA9E203DC
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 08:29:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB71331B;
 Fri,  5 Feb 2021 00:29:45 -0800 (PST)
Received: from [10.163.93.198] (unknown [10.163.93.198])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F6733F73B;
 Fri,  5 Feb 2021 00:29:42 -0800 (PST)
Subject: Re: [RFC 2/3] arm64/hugetlb: Enable HUGETLB_PAGE_SIZE_VARIABLE
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 akpm@linux-foundation.org
References: <1612422084-30429-1-git-send-email-anshuman.khandual@arm.com>
 <1612422084-30429-3-git-send-email-anshuman.khandual@arm.com>
 <616578ec-8a61-ce0a-a467-50915b3a9967@redhat.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ca668991-4ea1-6476-8be0-8c0db96a682e@arm.com>
Date: Fri, 5 Feb 2021 14:00:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <616578ec-8a61-ce0a-a467-50915b3a9967@redhat.com>
Content-Language: en-US
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2/5/21 1:50 PM, David Hildenbrand wrote:
> On 04.02.21 08:01, Anshuman Khandual wrote:
>> MAX_ORDER which invariably depends on FORCE_MAX_ZONEORDER can be a variable
>> for a given page size, depending on whether TRANSPARENT_HUGEPAGE is enabled
>> or not. In certain page size and THP combinations HUGETLB_PAGE_ORDER can be
>> greater than MAX_ORDER, making it unusable as pageblock_order.
> 
> Just so I understand correctly, this does not imply that we have THP that exceed the pageblock size / MAX_ORDER size, correct?

Correct. MAX_ORDER gets incremented when THP is enabled.

config FORCE_MAX_ZONEORDER
        int
        default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
        default "12" if (ARM64_16K_PAGES && TRANSPARENT_HUGEPAGE)
        default "11"
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
