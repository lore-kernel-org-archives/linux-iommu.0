Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8830C49EA6
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 09:29:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4F2613EE
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 09:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4F2613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5445E405A7;
	Thu, 24 Jun 2021 09:29:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YwTL2zUraY9W; Thu, 24 Jun 2021 09:29:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 32B3640245;
	Thu, 24 Jun 2021 09:29:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E68EBC001A;
	Thu, 24 Jun 2021 09:29:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8016C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 09:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 906104157D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 09:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0u5g9txe4TzM for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 09:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B34F341579
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624526980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eNB6QImZTsEUvPv7cFGlcy7hZAaXO3u/PVt8yIynlso=;
 b=KK4u/UPheC0vmdyfDQqJXDJUrN9A5CV/uZzYbn2dikMNpW/eH1QjI7Djdp8jgAINuWttKB
 K/6SPRZYPZvzmiW94EGiDVQyLhRmo8X6DHXkqYY7icP9yBD2EsSW/h57pNYb5pKwHfMdIf
 IyLBV2owFnysA+Mi+5mxXcmCScg6giU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-QAp785duOPGx24QidhDU9w-1; Thu, 24 Jun 2021 05:29:36 -0400
X-MC-Unique: QAp785duOPGx24QidhDU9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35FFE804140;
 Thu, 24 Jun 2021 09:29:35 +0000 (UTC)
Received: from localhost (ovpn-12-142.pek2.redhat.com [10.72.12.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD8D75C1BB;
 Thu, 24 Jun 2021 09:29:33 +0000 (UTC)
Date: Thu, 24 Jun 2021 17:29:30 +0800
From: Baoquan He <bhe@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <20210624092930.GA802261@MiWiFi-R3L-srv>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNQ258KHlzlajqo/@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, rientjes@google.com,
 robin.murphy@arm.com
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

On 06/24/21 at 08:40am, Christoph Hellwig wrote:
> So reduce the amount allocated.  But the pool is needed for proper
> operation on systems with memory encryption.  And please add the right
> maintainer or at least mailing list for the code you're touching next
> time.

Oh, I thoutht it's memory issue only, should have run
./scripts/get_maintainer.pl. sorry.

About reducing the amount allocated, it may not help. Because on x86_64,
kdump kernel doesn't put any page of memory into buddy allocator of DMA
zone. Means it will defenitely OOM for atomic_pool_dma initialization.

Wondering in which case or on which device the atomic pool is needed on
AMD system with mem encrytion enabled. As we can see, the OOM will
happen too in kdump kernel on Intel system, even though it's not
necessary.

Thanks
Baoquan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
