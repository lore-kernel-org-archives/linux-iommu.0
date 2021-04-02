Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C36C43460
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:45:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7DD61165
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7DD61165
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0A2440272;
	Fri,  2 Apr 2021 14:45:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cgVwP3QBAN7g; Fri,  2 Apr 2021 14:45:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id A57EF400AF;
	Fri,  2 Apr 2021 14:45:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AF76C000B;
	Fri,  2 Apr 2021 14:45:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03E68C000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E60C940210
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:44:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GuExsKScf3uI for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 14:44:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49924400AF
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:44:59 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2051768BEB; Fri,  2 Apr 2021 16:44:56 +0200 (CEST)
Date: Fri, 2 Apr 2021 16:44:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] dma-mapping: make map_benchmark compile into module
Message-ID: <20210402144455.GA19264@lst.de>
References: <1616552258-22282-1-git-send-email-tiantao6@hisilicon.com>
 <20210324071305.GB647@lst.de>
 <6153f9d247214d58b5eb7a76cb1258b3@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6153f9d247214d58b5eb7a76cb1258b3@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "paulmck@kernel.org" <paulmck@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "ast@kernel.org" <ast@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "tiantao \(H\)" <tiantao6@hisilicon.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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

On Wed, Mar 24, 2021 at 07:33:23AM +0000, Song Bao Hua (Barry Song) wrote:
> The requirement comes from an colleague who is frequently changing
> the map-bench code for some customized test purpose. and he doesn't
> want to build kernel image and reboot every time. So I moved the
> requirement to Tao Tian.
> 
> Right now, kthread_bind() is exported, kthread_bind_mask() seems
> to be a little bit "internal" as you said, maybe a wrapper like
> kthread_bind_node() won't be that "internal", comparing to exposing
> the cpumask?

I really don't think we should be exporting more low-level kthread
APIs.  Especially as we've been trying to get most users off the
kthread API and to workqueues instead.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
