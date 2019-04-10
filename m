Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03940C10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 12:26:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33032083E
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 12:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33032083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 984A717FC;
	Wed, 10 Apr 2019 12:26:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7AB7D17BA
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 12:25:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EFEBE17E
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 12:25:50 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
	[66.24.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D9C852083E;
	Wed, 10 Apr 2019 12:25:49 +0000 (UTC)
Date: Wed, 10 Apr 2019 08:25:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Message-ID: <20190410082548.04c2e0aa@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
References: <20190410102754.387743324@linutronix.de>
	<20190410103646.130022106@linutronix.de>
	<20190410110818.GA13904@lst.de>
	<alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, Alexander Potapenko <glider@google.com>,
	Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Message-ID: <20190410122548.UtGg2J04fADjfPyNel3PfBQdxXWdmT4qEBjdSRsr6oA@z>

On Wed, 10 Apr 2019 14:08:19 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 10 Apr 2019, Christoph Hellwig wrote:
> > 
> > Please always send the whole series out to everyone on the To and Cc
> > list, otherwise patch series are not reviewable.  
>  
> Bah. People complain about overly broad cc-lists and the context is on
> lkml. But sure, I just bounced it to you.
> 

What I think is the best in between is to have the cover letter sent to
everyone in the patch series, and then individual patches sent to those
that need to know. git sendmail does this but quilt sendmail does
not :-(   I've been looking at fixing quilt to do the same.

-- Steve
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
