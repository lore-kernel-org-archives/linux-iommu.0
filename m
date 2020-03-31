Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65571C2D0E9
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 02:17:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBAC20732
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 02:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCCAWaEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBAC20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DCDA3869EC;
	Tue, 31 Mar 2020 02:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 36qYZmLB97Od; Tue, 31 Mar 2020 02:17:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 02DF7865CF;
	Tue, 31 Mar 2020 02:17:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF66BC1D7E;
	Tue, 31 Mar 2020 02:17:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 787BCC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 02:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6B33085EBB
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 02:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SPI2Kpq6fVTw for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 02:17:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [216.205.24.74])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9553785EAF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 02:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585621024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NoKfyvDtclhsXXCgoG9PQCptBCeb8aNEYNrgbbOSSA4=;
 b=LCCAWaEoljAZ13gZvLS81UqBr4Hypv8b7cpTcznwYZqvG7Rbi/3mRJiso9kpzvRq8sC3fP
 oQNfQBjAAblKTr3B6j3JSV4PfNIrAd7p1QKRlIwdy8oLiKlQyKy1JKpEEQM4kAMmsmLcC3
 IOx+BfiXI7l2HC4j6VHbJ++mCOS/UxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-a6JbvxOQPwahM5QOk59Uqw-1; Mon, 30 Mar 2020 22:17:00 -0400
X-MC-Unique: a6JbvxOQPwahM5QOk59Uqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5769418B9FCC;
 Tue, 31 Mar 2020 02:16:57 +0000 (UTC)
Received: from localhost (ovpn-12-117.pek2.redhat.com [10.72.12.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D63F5DC18;
 Tue, 31 Mar 2020 02:16:53 +0000 (UTC)
Date: Tue, 31 Mar 2020 10:16:49 +0800
From: Baoquan He <bhe@redhat.com>
To: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <20200331021649.GM9942@MiWiFi-R3L-srv>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
 <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
 <20200330134004.GA31026@char.us.oracle.com>
 <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Mark Rutland <mark.rutland@arm.com>, brijesh.singh@amd.com,
 Lianbo Jiang <lijiang@redhat.com>, linux-doc@vger.kernel.org,
 Jan Kiszka <jan.kiszka@siemens.com>, "Schoenherr, Jan H." <jschoenh@amazon.de>,
 Christoph Hellwig <hch@lst.de>, the arch/x86 maintainers <x86@kernel.org>,
 anthony.yznaga@oracle.com, Laszlo Ersek <lersek@redhat.com>, aggh@amazon.com,
 "Lendacky, Thomas" <thomas.lendacky@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, alcioa@amazon.com,
 dhr@amazon.com, Jan Setje-Eilers <jan.setjeeilers@oracle.com>, benh@amazon.com,
 Kairui Song <kasong@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, aagch@amazon.com,
 Robin Murphy <robin.murphy@arm.com>, dwmw@amazon.com
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

On 03/30/20 at 10:42pm, Alexander Graf wrote:
> 
> 
> On 30.03.20 15:40, Konrad Rzeszutek Wilk wrote:
> > 
> > 
> > 
> > On Mon, Mar 30, 2020 at 02:06:01PM +0800, Kairui Song wrote:
> > > On Sat, Mar 28, 2020 at 7:57 PM Dave Young <dyoung@redhat.com> wrote:
> > > > 
> > > > On 03/26/20 at 05:29pm, Alexander Graf wrote:
> > > > > The swiotlb is a very convenient fallback mechanism for bounce buffering of
> > > > > DMAable data. It is usually used for the compatibility case where devices
> > > > > can only DMA to a "low region".
> > > > > 
> > > > > However, in some scenarios this "low region" may be bound even more
> > > > > heavily. For example, there are embedded system where only an SRAM region
> > > > > is shared between device and CPU. There are also heterogeneous computing
> > > > > scenarios where only a subset of RAM is cache coherent between the
> > > > > components of the system. There are partitioning hypervisors, where
> > > > > a "control VM" that implements device emulation has limited view into a
> > > > > partition's memory for DMA capabilities due to safety concerns.
> > > > > 
> > > > > This patch adds a command line driven mechanism to move all DMA memory into
> > > > > a predefined shared memory region which may or may not be part of the
> > > > > physical address layout of the Operating System.
> > > > > 
> > > > > Ideally, the typical path to set this configuration would be through Device
> > > > > Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
> > > > > in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
> > > > > instead configure the system purely through kernel command line options.
> > > > > 
> > > > > I'm sure other people will find the functionality useful going forward
> > > > > though and extend it to be triggered by DT/ACPI in the future.
> > > > 
> > > > Hmm, we have a use case for kdump, this maybe useful.  For example
> > > > swiotlb is enabled by default if AMD SME/SEV is active, and in kdump
> > > > kernel we have to increase the crashkernel reserved size for the extra
> > > > swiotlb requirement.  I wonder if we can just reuse the old kernel's
> > > > swiotlb region and pass the addr to kdump kernel.
> > > > 
> > > 
> > > Yes, definitely helpful for kdump kernel. This can help reduce the
> > > crashkernel value.
> > > 
> > > Previously I was thinking about something similar, play around the
> > > e820 entry passed to kdump and let it place swiotlb in wanted region.
> > > Simply remap it like in this patch looks much cleaner.
> > > 
> > > If this patch is acceptable, one more patch is needed to expose the
> > > swiotlb in iomem, so kexec-tools can pass the right kernel cmdline to
> > > second kernel.
> > 
> > We seem to be passsing a lot of data to kexec.. Perhaps something
> > of a unified way since we seem to have a lot of things to pass - disabling
> > IOMMU, ACPI RSDT address, and then this.
> > 
> > CC-ing Anthony who is working on something - would you by any chance
> > have a doc on this?
> 
> 
> I see in general 2 use cases here:
> 
> 
> 1) Allow for a generic mechanism to have the fully system, individual buses,
> devices or functions of a device go through a particular, self-contained
> bounce buffer.
> 
> This sounds like the holy grail to a lot of problems. It would solve typical
> embedded scenarios where you only have a shared SRAM. It solves the safety
> case (to some extent) where you need to ensure that one device interaction
> doesn't conflict with another device interaction. It also solves the problem
> I've tried to solve with the patch here.
> 
> It's unfortunately a lot harder than the patch I sent, so it will take me
> some time to come up with a working patch set.. I suppose starting with a DT
> binding only is sensible. Worst case, x86 does also support DT ...
> 
> (And yes, I'm always happy to review patches if someone else beats me to it)
> 
> 
> 2) Reuse the SWIOTLB from the previous boot on kexec/kdump
> 
> I see little direct relation to SEV here. The only reason SEV makes it more
> relevant, is that you need to have an SWIOTLB region available with SEV
> while without you could live with a disabled IOMMU.
> 
> However, I can definitely understand how you would want to have a way to
> tell the new kexec'ed kernel where the old SWIOTLB was, so it can reuse its
> memory for its own SWIOTLB. That way, you don't have to reserve another 64MB
> of RAM for kdump.
> 
> What I'm curious on is whether we need to be as elaborate. Can't we just
> pass the old SWIOTLB as free memory to the new kexec'ed kernel and
> everything else will fall into place? All that would take is a bit of
> shuffling on the e820 table pass-through to the kexec'ed kernel, no?

Swiotlb memory have to be continuous. We can't guarantee that region
won't be touched by kernel allocation before swiotlb init. Then we may
not have chance to get a continuous region of memory block again for
swiotlb. This is our main concern when reusing swiotlb for kdump.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
