Return-Path: <SRS0=bJ3n=6P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00353C47254
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 22:09:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2512166E
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 22:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPQWCRRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2512166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A66718841F;
	Fri,  1 May 2020 22:09:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ITI7mK-cVT6q; Fri,  1 May 2020 22:09:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 39B71878C1;
	Fri,  1 May 2020 22:09:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 187FEC0888;
	Fri,  1 May 2020 22:09:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F38CC016F
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 22:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EB36787928
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 22:09:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M3CwWQlq--vO for <iommu@lists.linux-foundation.org>;
 Fri,  1 May 2020 22:09:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5857D878C1
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 22:09:49 +0000 (UTC)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net
 [73.231.172.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B927520857;
 Fri,  1 May 2020 22:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588370988;
 bh=hyTUi8k9QleCFVpcgAZ6YYDaMkXEa5xJb5HTy4SEi9Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GPQWCRRHLJg2Zl8cgmkGWbp7Tgn+ivU4M8hBbWb4IQI1sGAnX/mV/i1Lyh/amTZdC
 vgn21bnvxHvu7jVeG6N3ie5ON7pYY//OPHYOAyysUdpLdyFLZhzTvii7N+TQnFlEUw
 l0PKqTkdq3Hg476WHDApPzwvFSmjMv60SV2VPHc0=
Date: Fri, 1 May 2020 15:09:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: John Dorminy <jdorminy@redhat.com>
Subject: Re: [PATCH 21/29] mm: remove the pgprot argument to __vmalloc
Message-Id: <20200501150947.367ca6b38a394f1ff678ed4b@linux-foundation.org>
In-Reply-To: <CAMeeMh_9N0ORhPM8EmkGeeuiDoQY3+QoAPX5QBuK7=gsC5ONng@mail.gmail.com>
References: <20200414131348.444715-1-hch@lst.de>
 <20200414131348.444715-22-hch@lst.de>
 <20200414151344.zgt2pnq7cjq2bgv6@debian>
 <CAMeeMh8Q3Od76WaTasw+BpYVF58P-HQMaiFKHxXbZ_Q3tQPZ=A@mail.gmail.com>
 <CAMeeMh_9N0ORhPM8EmkGeeuiDoQY3+QoAPX5QBuK7=gsC5ONng@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Michael Kelley <mikelley@microsoft.com>,
 linux-mm@kvack.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
 Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>,
 Gao Xiang <xiang@kernel.org>, Laura Abbott <labbott@redhat.com>,
 Nitin Gupta <ngupta@vflare.org>, Daniel Vetter <daniel@ffwll.ch>,
 Haiyang Zhang <haiyangz@microsoft.com>, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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

On Thu, 30 Apr 2020 22:38:10 -0400 John Dorminy <jdorminy@redhat.com> wrote:

> the change
> description refers to PROT_KERNEL, which is a symbol which does not
> appear to exist; perhaps PAGE_KERNEL was meant?

Yes, thanks, fixed.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
