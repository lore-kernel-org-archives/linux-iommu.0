Return-Path: <SRS0=z+Ry=HS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458C9C433DB
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 09:04:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA9F64DF0
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 09:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA9F64DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 89D3F87074;
	Tue, 16 Feb 2021 09:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yMYALaEvUzkZ; Tue, 16 Feb 2021 09:04:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17A918703C;
	Tue, 16 Feb 2021 09:04:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2D02C0174;
	Tue, 16 Feb 2021 09:04:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59F4BC013A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 09:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 48049844C3
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 09:04:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CXfor_X8gkd2 for <iommu@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:04:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8EDE5844BC
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 09:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613466278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKGsnpF0DwP41FkOz2ejwPVACGeq38/XH7vk2Mr5Zog=;
 b=i0Pq0BwkNqjo2MyotGEa33TTeR7s1KuDul+JdAYRk02hzEdRBW4Tg2VeQhRP/rVyApUU0z
 wtvCwvbYc3Czc2BswzvVvUnf3CmduRzPEtMDr/stW4HSvHBViCP3sv67r5EwjnGErcb1JI
 eqtl+KesqYCl69Ezk4QZXS+1sZbvvzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Lll_nZ2oNxqUAwYKWmpAUQ-1; Tue, 16 Feb 2021 04:04:34 -0500
X-MC-Unique: Lll_nZ2oNxqUAwYKWmpAUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A5A91020C20;
 Tue, 16 Feb 2021 09:04:31 +0000 (UTC)
Received: from [10.36.114.70] (ovpn-114-70.ams2.redhat.com [10.36.114.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC869163F1;
 Tue, 16 Feb 2021 09:04:28 +0000 (UTC)
Subject: Re: [PATCH 0/3] mm/page_alloc: Fix pageblock_order with
 HUGETLB_PAGE_SIZE_VARIABLE
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 akpm@linux-foundation.org, will@kernel.org
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
 <683c812a-ce3d-ef74-10d1-eaf8a3ae93d4@redhat.com>
 <fb562021-9981-4434-cc4a-e813a7752adb@arm.com>
 <cb92e4a0-47fc-f461-3189-a99142bbed4c@redhat.com>
 <0609df35-dd69-54a7-e839-2d97d77e0016@arm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <337123b0-b2af-a522-3dfe-fd1098a0cad9@redhat.com>
Date: Tue, 16 Feb 2021 10:04:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <0609df35-dd69-54a7-e839-2d97d77e0016@arm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
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

>>
>>
>> But again, if there are valid use cases then sure, let's make the code fully compatible with HUGETLB_PAGE_ORDER > MAX_ORDER.
> 
> Given that gigantic HugeTLB allocation can fallback on alloc_contig_pages()
> or CMA if/when available, is there a real need for HUGETLB_PAGE_ORDER to be
> upto MAX_ORDER, used as pageblock_order or as COMPACTION_HPAGE_ORDER ? With
> gigantic HugeTLB pages being available, HUGETLB_PAGE_ORDER seems to be just
> detached from the buddy allocator. But I am not sure, will keep looking.

Having HPAGE_PMD_ORDER >>= MAX_ORDER ("significantly larger") will make 
it very unlikely that you are able to reliably allocate any huge pages 
at all dynamically at runtime without CMA.

Gigantic pages are problematic by nature :)

-- 
Thanks,

David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
