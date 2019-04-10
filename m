Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6E7C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 12:08:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B2820818
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 12:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B2820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4F8D117B1;
	Wed, 10 Apr 2019 12:08:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EF7161750
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 12:08:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from Galois.linutronix.de (Galois.linutronix.de [146.0.238.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9DBF07ED
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 12:08:32 +0000 (UTC)
Received: from [147.83.201.128] (helo=nanos)
	by Galois.linutronix.de with esmtpsa
	(TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.80)
	(envelope-from <tglx@linutronix.de>)
	id 1hEC1h-0006u2-4B; Wed, 10 Apr 2019 14:08:25 +0200
Date: Wed, 10 Apr 2019 14:08:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
In-Reply-To: <20190410110818.GA13904@lst.de>
Message-ID: <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
References: <20190410102754.387743324@linutronix.de>
	<20190410103646.130022106@linutronix.de>
	<20190410110818.GA13904@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
	SHORTCIRCUIT=-0.0001
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, iommu@lists.linux-foundation.org,
	Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190410120819.Uzyc-s8ILBWOEUuKIPVzgygI3cZ6YL2lD9CznCGWcJ0@z>

On Wed, 10 Apr 2019, Christoph Hellwig wrote:

> On Wed, Apr 10, 2019 at 12:28:22PM +0200, Thomas Gleixner wrote:
> > Replace the indirection through struct stack_trace with an invocation of
> > the storage array based interface.
> 
> This seems to be missing some context, at least stack_trace_save does
> not actually exist in mainline.
> 
> Please always send the whole series out to everyone on the To and Cc
> list, otherwise patch series are not reviewable.
 
Bah. People complain about overly broad cc-lists and the context is on
lkml. But sure, I just bounced it to you.

Thanks,

	tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
