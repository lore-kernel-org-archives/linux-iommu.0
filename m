Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2D8C433B4
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 10:34:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0E1613BE
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 10:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0E1613BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC05840563;
	Tue,  4 May 2021 10:34:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OjW8TF96DQYx; Tue,  4 May 2021 10:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C07B84056A;
	Tue,  4 May 2021 10:34:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A315C000E;
	Tue,  4 May 2021 10:34:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B66EDC0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 10:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D6A5843B1
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 10:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Ft1LejKmIHh for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 10:34:05 +0000 (UTC)
X-Greylist: delayed 00:54:20 by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B69B84399
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 10:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=cbJaT3WauSqqefXiQhipxL5QKWvgRRw7UQHpsath+Uk=; b=Fh34MW0SJTuy07liXxCF50N1v5
 UsnNeTvC+HKGbxyV5M1xr2rQelNWMXX9IWoY6Tbzyx0oYm7eXDki2pHgQEx4um74tCoQ7/J2c/3O2
 IT0vqGHPLWuxKpHv5s4Ro9DMP2G1JaIjotX5SMqxYOvvUXIaboSoepUfRxlxPVTvS30lxOIAY9wWj
 2VZnjiI7aDjJSf4xdI5yFB+pZC2YtdmyWdpUX/yrqvXNiJ2W4fhmnDPqQ432A5Q24tqH03jnfBBd/
 GR1C3IcSA9c5RkJGXVfvXIzs14PCtbByXnfcDNOAVmRa6kzy6l75DJnJXHN5WsRK0IIMqmiK7n4+o
 jJrpY65g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ldrWl-00Ftkl-44; Tue, 04 May 2021 09:39:39 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 017023001D0;
 Tue,  4 May 2021 11:39:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id AAB992026F4BB; Tue,  4 May 2021 11:39:37 +0200 (CEST)
Date: Tue, 4 May 2021 11:39:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] x86/events/amd/iommu: Fix invalid Perf result due to
 IOMMU PMC power-gating
Message-ID: <YJEWWbEeDm0rUyC+@hirez.programming.kicks-ass.net>
References: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
Cc: David Coe <david.coe@live.co.uk>, amonakov@ispras.ru, Jon.Grimm@amd.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 iommu@lists.linux-foundation.org, mingo@redhat.com
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

On Tue, May 04, 2021 at 01:52:36AM -0500, Suravee Suthikulpanit wrote:

> 2. Since AMD IOMMU PMU does not support interrupt mode, the logic
>    can be simplified to always start counting with value zero,
>    and accumulate the counter value when stopping without the need
>    to keep track and reprogram the counter with the previously read
>    counter value.

This relies on the hardware counter being the full 64bit wide, is it?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
