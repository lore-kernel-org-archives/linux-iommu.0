Return-Path: <SRS0=AIpH=VN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67206C7618F
	for <iommu@archiver.kernel.org>; Tue, 16 Jul 2019 00:01:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E8320880
	for <iommu@archiver.kernel.org>; Tue, 16 Jul 2019 00:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E8320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 06A1DD8B;
	Tue, 16 Jul 2019 00:01:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DEF23D56;
	Tue, 16 Jul 2019 00:01:49 +0000 (UTC)
X-Greylist: delayed 00:37:19 by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7A18D63D;
	Tue, 16 Jul 2019 00:01:47 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6FNO7XS032164;
	Mon, 15 Jul 2019 18:24:08 -0500
Message-ID: <d5b4f80db724da9d7571b614be76dd8b2b57432e.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
Date: Tue, 16 Jul 2019 09:24:06 +1000
In-Reply-To: <8736j7neg8.fsf@morokweng.localdomain>
References: <20190323165456-mutt-send-email-mst@kernel.org>
	<87a7go71hz.fsf@morokweng.localdomain>
	<20190520090939-mutt-send-email-mst@kernel.org>
	<877ea26tk8.fsf@morokweng.localdomain>
	<20190603211528-mutt-send-email-mst@kernel.org>
	<877e96qxm7.fsf@morokweng.localdomain>
	<20190701092212-mutt-send-email-mst@kernel.org>
	<87d0id9nah.fsf@morokweng.localdomain>
	<20190715103411-mutt-send-email-mst@kernel.org>
	<874l3nnist.fsf@morokweng.localdomain>
	<20190715163453-mutt-send-email-mst@kernel.org>
	<8736j7neg8.fsf@morokweng.localdomain>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Cc: Mike Anderson <andmike@linux.ibm.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Paul Mackerras <paulus@ozlabs.org>,
	iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, 2019-07-15 at 19:03 -0300, Thiago Jung Bauermann wrote:
> > > Indeed. The idea is that QEMU can offer the flag, old guests can
> > > reject
> > > it (or even new guests can reject it, if they decide not to
> > > convert into
> > > secure VMs) and the feature negotiation will succeed with the
> > > flag
> > > unset.
> > 
> > OK. And then what does QEMU do? Assume guest is not encrypted I
> > guess?
> 
> There's nothing different that QEMU needs to do, with or without the
> flag. the perspective of the host, a secure guest and a regular guest
> work the same way with respect to virtio.

This is *precisely* why I was against adding a flag and touch the
protocol negociation with qemu in the first place, back when I cared
about that stuff...

Guys, this has gone in circles over and over again.

This has nothing to do with qemu. Qemu doesn't need to know about this.
It's entirely guest local. This is why the one-liner in virtio was a
far better and simpler solution.

This is something the guest does to itself (with the participation of a
ultravisor but that's not something qemu cares about at this stage, at
least not as far as virtio is concerned).

Basically, the guest "hides" its memory from the host using a HW secure
memory facility. As a result, it needs to ensure that all of its DMA
pages are bounced through insecure pages that aren't hidden. That's it,
it's all guest side. Qemu shouldn't have to care about it at all.

Cheers,
Ben.


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
