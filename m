Return-Path: <SRS0=ehRZ=VM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D12C76195
	for <iommu@archiver.kernel.org>; Mon, 15 Jul 2019 22:16:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909C72145D
	for <iommu@archiver.kernel.org>; Mon, 15 Jul 2019 22:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909C72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 58935DCE;
	Mon, 15 Jul 2019 22:16:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2C6EFCBC;
	Mon, 15 Jul 2019 22:16:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9AA0B63D;
	Mon, 15 Jul 2019 22:16:21 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9D85C0495A6;
	Mon, 15 Jul 2019 22:16:20 +0000 (UTC)
Received: from redhat.com (ovpn-125-108.rdu2.redhat.com [10.10.125.108])
	by smtp.corp.redhat.com (Postfix) with SMTP id AB0995D71B;
	Mon, 15 Jul 2019 22:16:15 +0000 (UTC)
Date: Mon, 15 Jul 2019 18:16:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190715181449-mutt-send-email-mst@kernel.org>
References: <20190520090939-mutt-send-email-mst@kernel.org>
	<877ea26tk8.fsf@morokweng.localdomain>
	<20190603211528-mutt-send-email-mst@kernel.org>
	<877e96qxm7.fsf@morokweng.localdomain>
	<20190701092212-mutt-send-email-mst@kernel.org>
	<87d0id9nah.fsf@morokweng.localdomain>
	<20190715103411-mutt-send-email-mst@kernel.org>
	<874l3nnist.fsf@morokweng.localdomain>
	<20190715163453-mutt-send-email-mst@kernel.org>
	<8736j7neg8.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8736j7neg8.fsf@morokweng.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 15 Jul 2019 22:16:20 +0000 (UTC)
Cc: Mike Anderson <andmike@linux.ibm.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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

On Mon, Jul 15, 2019 at 07:03:03PM -0300, Thiago Jung Bauermann wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Mon, Jul 15, 2019 at 05:29:06PM -0300, Thiago Jung Bauermann wrote:
> >>
> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >>
> >> > On Sun, Jul 14, 2019 at 02:51:18AM -0300, Thiago Jung Bauermann wrote:
> >> >>
> >> >>
> >> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >> >>
> >> >> > So this is what I would call this option:
> >> >> >
> >> >> > VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS
> >> >> >
> >> >> > and the explanation should state that all device
> >> >> > addresses are translated by the platform to identical
> >> >> > addresses.
> >> >> >
> >> >> > In fact this option then becomes more, not less restrictive
> >> >> > than VIRTIO_F_ACCESS_PLATFORM - it's a promise
> >> >> > by guest to only create identity mappings,
> >> >> > and only before driver_ok is set.
> >> >> > This option then would always be negotiated together with
> >> >> > VIRTIO_F_ACCESS_PLATFORM.
> >> >> >
> >> >> > Host then must verify that
> >> >> > 1. full 1:1 mappings are created before driver_ok
> >> >> >     or can we make sure this happens before features_ok?
> >> >> >     that would be ideal as we could require that features_ok fails
> >> >> > 2. mappings are not modified between driver_ok and reset
> >> >> >     i guess attempts to change them will fail -
> >> >> >     possibly by causing a guest crash
> >> >> >     or some other kind of platform-specific error
> >> >>
> >> >> I think VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS is good, but requiring
> >> >> it to be accompanied by ACCESS_PLATFORM can be a problem. One reason is
> >> >> SLOF as I mentioned above, another is that we would be requiring all
> >> >> guests running on the machine (secure guests or not, since we would use
> >> >> the same configuration for all guests) to support it. But
> >> >> ACCESS_PLATFORM is relatively recent so it's a bit early for that. For
> >> >> instance, Ubuntu 16.04 LTS (which is still supported) doesn't know about
> >> >> it and wouldn't be able to use the device.
> >> >
> >> > OK and your target is to enable use with kernel drivers within
> >> > guests, right?
> >>
> >> Right.
> >>
> >> > My question is, we are defining a new flag here, I guess old guests
> >> > then do not set it. How does it help old guests? Or maybe it's
> >> > not designed to ...
> >>
> >> Indeed. The idea is that QEMU can offer the flag, old guests can reject
> >> it (or even new guests can reject it, if they decide not to convert into
> >> secure VMs) and the feature negotiation will succeed with the flag
> >> unset.
> >
> > OK. And then what does QEMU do? Assume guest is not encrypted I guess?
> 
> There's nothing different that QEMU needs to do, with or without the
> flag. the perspective of the host, a secure guest and a regular guest
> work the same way with respect to virtio.

OK. So now let's get back to implementation. What will
Linux guest driver do? It can't activate DMA API blindly since that
will assume translation also works, right?
Or do we somehow limit it to just a specific platform?

> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
