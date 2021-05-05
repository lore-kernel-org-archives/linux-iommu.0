Return-Path: <SRS0=LdVQ=KA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7109AC433B4
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 13:06:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2E861222
	for <iommu@archiver.kernel.org>; Wed,  5 May 2021 13:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2E861222
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12BAB40445;
	Wed,  5 May 2021 13:06:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tlSUcNn1ZYd7; Wed,  5 May 2021 13:06:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF71D40411;
	Wed,  5 May 2021 13:06:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88339C000D;
	Wed,  5 May 2021 13:06:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A9E5C0001
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 13:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E7A983D93
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 13:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HyDWyxWHZR0S for <iommu@lists.linux-foundation.org>;
 Wed,  5 May 2021 13:05:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C22DE83C21
 for <iommu@lists.linux-foundation.org>; Wed,  5 May 2021 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=kj3lk+MzppwZnR4pyZdWYqNDn2L5VLUwXkqm3e6rR9s=; b=IcRzhmy3e3QVV24Wb/38lgZKdv
 sToVrmEzizW7NxLWDO+fD+mh0CDfrQSBuQ13qVXeOpcizNeTdVuacmPo3XrSw81+31tkcQFXH1Al0
 i/ueRj/Poi8z1POz6VbBtkD7hdQsg47KGMcDS8quFo4FwvjYLwnjA6Up2Ve8w1c12jrkrCmTj6AMs
 snNqpQIQ1qgDkc6OQV24oyvU6eqsD0ySV0fKp5X/ZtjDRRCcnzqJS5J4j1sHotocr8EhU8CmIBHrM
 dVGzUkcR6HxsPMjxN092z6w3Nthn4EOizVNcET3qjdH4FgEsTizIhA3X0ZG1cEZvozuAMqNzGnsCi
 TDpZTrdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1leHDA-000LSn-UF; Wed, 05 May 2021 13:05:20 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CD993001CD;
 Wed,  5 May 2021 15:05:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 2E32A203E67C5; Wed,  5 May 2021 15:05:06 +0200 (CEST)
Date: Wed, 5 May 2021 15:05:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] x86/events/amd/iommu: Fix invalid Perf result due to
 IOMMU PMC power-gating
Message-ID: <YJKYAiC8GiiFPrWk@hirez.programming.kicks-ass.net>
References: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
 <YJEWWbEeDm0rUyC+@hirez.programming.kicks-ass.net>
 <e9769da5-3d2a-6e86-8ebd-feb00b567bba@amd.com>
 <YJE6eCyHtIONCJet@hirez.programming.kicks-ass.net>
 <ad67d625-9e59-2216-0f2a-88635a212595@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad67d625-9e59-2216-0f2a-88635a212595@amd.com>
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

On Wed, May 05, 2021 at 07:39:14PM +0700, Suthikulpanit, Suravee wrote:
> Peter,
> 
> On 5/4/2021 7:13 PM, Peter Zijlstra wrote:
> > On Tue, May 04, 2021 at 06:58:29PM +0700, Suthikulpanit, Suravee wrote:
> > > Peter,
> > > 
> > > On 5/4/2021 4:39 PM, Peter Zijlstra wrote:
> > > > On Tue, May 04, 2021 at 01:52:36AM -0500, Suravee Suthikulpanit wrote:
> > > > 
> > > > > 2. Since AMD IOMMU PMU does not support interrupt mode, the logic
> > > > >      can be simplified to always start counting with value zero,
> > > > >      and accumulate the counter value when stopping without the need
> > > > >      to keep track and reprogram the counter with the previously read
> > > > >      counter value.
> > > > 
> > > > This relies on the hardware counter being the full 64bit wide, is it?
> > > > 
> > > 
> > > The HW counter value is 48-bit. Not sure why it needs to be 64-bit?
> > > I might be missing some points here? Could you please describe?
> > 
> > How do you deal with the 48bit overflow if you don't use the interrupt?
> 
> The IOMMU Perf driver does not currently handle counter overflow since the overflow
> notification mechanism (i.e. IOMMU creates an EVENT_COUNTER_ZERO event in the IOMMU event log,
> and generate an IOMMU MSI interrupt to signal IOMMU driver to process the event.) is not
> currently supported. When counter overflows, the counter becomes zero, and Perf
> reports value zero for the event.
> 
> Alternatively, to detect overflow, we might start counting with value 1 so that
> we can detect overflow when the value becomes zero in which case the Perf driver
> could generate error message.

Urgh.. the intel uncore driver programs an hrtimer to periodically fold
deltas. That way the counter will never be short.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
