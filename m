Return-Path: <SRS0=6vqp=5Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B8BC43331
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 01:46:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696AC206CC
	for <iommu@archiver.kernel.org>; Tue, 31 Mar 2020 01:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ctgs+uuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696AC206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3650F86C12;
	Tue, 31 Mar 2020 01:46:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oyh3+Jl2veg5; Tue, 31 Mar 2020 01:46:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7837A86B30;
	Tue, 31 Mar 2020 01:46:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F45BC1AE8;
	Tue, 31 Mar 2020 01:46:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09E5AC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 01:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ECF8585910
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 01:46:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ni5jGGaklgpL for <iommu@lists.linux-foundation.org>;
 Tue, 31 Mar 2020 01:46:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [216.205.24.74])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 177CB8511B
 for <iommu@lists.linux-foundation.org>; Tue, 31 Mar 2020 01:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585619213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uo+1bM5jLbPf26TN6zEnjUeeLZzs+2jX0NNWi8ZBweA=;
 b=Ctgs+uuGyFpZmpYA0RLEQk9mYj5KxxtMSSUS3MAdBMO6ifNm2y0rLkdVuml12pB4oda7Da
 f+yxaD22cAapiGP0//Ep6E9+xXuvuWfv5xMu8sVbpamtJTmlmHJeymZ/3evGZ9OopkszTL
 hMr2I7zJOqt9PfBo2avkDpuvrtTmUNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-ByELsUk1MmGYaIeZ40WgHg-1; Mon, 30 Mar 2020 21:46:50 -0400
X-MC-Unique: ByELsUk1MmGYaIeZ40WgHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C48291005509;
 Tue, 31 Mar 2020 01:46:46 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-247.pek2.redhat.com
 [10.72.12.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20332100EBB3;
 Tue, 31 Mar 2020 01:46:36 +0000 (UTC)
Date: Tue, 31 Mar 2020 09:46:32 +0800
From: Dave Young <dyoung@redhat.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
Message-ID: <20200331014632.GA81569@dhcp-128-65.nay.redhat.com>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
 <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
 <20200330134004.GA31026@char.us.oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200330134004.GA31026@char.us.oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Mark Rutland <mark.rutland@arm.com>, brijesh.singh@amd.com,
 Lianbo Jiang <lijiang@redhat.com>, linux-doc@vger.kernel.org,
 Jan Kiszka <jan.kiszka@siemens.com>, Christoph Hellwig <hch@lst.de>,
 the arch/x86 maintainers <x86@kernel.org>, anthony.yznaga@oracle.com,
 Laszlo Ersek <lersek@redhat.com>, aggh@amazon.com, "Lendacky,
 Thomas" <thomas.lendacky@amd.com>, alcioa@amazon.com,
 Alexander Graf <graf@amazon.com>, dhr@amazon.com,
 Jan Setje-Eilers <jan.setjeeilers@oracle.com>, benh@amazon.com,
 Kairui Song <kasong@redhat.com>, kexec@lists.infradead.org,
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

On 03/30/20 at 09:40am, Konrad Rzeszutek Wilk wrote:
> On Mon, Mar 30, 2020 at 02:06:01PM +0800, Kairui Song wrote:
> > On Sat, Mar 28, 2020 at 7:57 PM Dave Young <dyoung@redhat.com> wrote:
> > >
> > > On 03/26/20 at 05:29pm, Alexander Graf wrote:
> > > > The swiotlb is a very convenient fallback mechanism for bounce buffering of
> > > > DMAable data. It is usually used for the compatibility case where devices
> > > > can only DMA to a "low region".
> > > >
> > > > However, in some scenarios this "low region" may be bound even more
> > > > heavily. For example, there are embedded system where only an SRAM region
> > > > is shared between device and CPU. There are also heterogeneous computing
> > > > scenarios where only a subset of RAM is cache coherent between the
> > > > components of the system. There are partitioning hypervisors, where
> > > > a "control VM" that implements device emulation has limited view into a
> > > > partition's memory for DMA capabilities due to safety concerns.
> > > >
> > > > This patch adds a command line driven mechanism to move all DMA memory into
> > > > a predefined shared memory region which may or may not be part of the
> > > > physical address layout of the Operating System.
> > > >
> > > > Ideally, the typical path to set this configuration would be through Device
> > > > Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
> > > > in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
> > > > instead configure the system purely through kernel command line options.
> > > >
> > > > I'm sure other people will find the functionality useful going forward
> > > > though and extend it to be triggered by DT/ACPI in the future.
> > >
> > > Hmm, we have a use case for kdump, this maybe useful.  For example
> > > swiotlb is enabled by default if AMD SME/SEV is active, and in kdump
> > > kernel we have to increase the crashkernel reserved size for the extra
> > > swiotlb requirement.  I wonder if we can just reuse the old kernel's
> > > swiotlb region and pass the addr to kdump kernel.
> > >
> > 
> > Yes, definitely helpful for kdump kernel. This can help reduce the
> > crashkernel value.
> > 
> > Previously I was thinking about something similar, play around the
> > e820 entry passed to kdump and let it place swiotlb in wanted region.
> > Simply remap it like in this patch looks much cleaner.
> > 
> > If this patch is acceptable, one more patch is needed to expose the
> > swiotlb in iomem, so kexec-tools can pass the right kernel cmdline to
> > second kernel.
> 
> We seem to be passsing a lot of data to kexec.. Perhaps something
> of a unified way since we seem to have a lot of things to pass - disabling
> IOMMU, ACPI RSDT address, and then this.

acpi_rsdp kernel cmdline is not useful anymore.  The initial purpose is
for kexec-rebooting in efi system.  But now we have supported efi boot
across kexec reboot thus that is useless now.

Thanks
Dave

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
