Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E74EC433E0
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 18:33:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A945E22D04
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 18:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A945E22D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3011186757;
	Mon, 25 Jan 2021 18:33:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9rq8ZAgferUN; Mon, 25 Jan 2021 18:33:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D51986720;
	Mon, 25 Jan 2021 18:33:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEC93C08A1;
	Mon, 25 Jan 2021 18:33:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF184C013A;
 Mon, 25 Jan 2021 18:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A3BF085B4D;
 Mon, 25 Jan 2021 18:33:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XHDJrC4rJ_s8; Mon, 25 Jan 2021 18:33:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1C0A08587E;
 Mon, 25 Jan 2021 18:33:40 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id a14so5383251edu.7;
 Mon, 25 Jan 2021 10:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VMRVhIQIXZxzucvozlD6kGt114/L0couPU+fNeFrnDQ=;
 b=B/RNvjvh+qiB40NO59Ij5acibSeJucACNTddOI5YBI8wjrLQZCGM/n6hgYcU5ZoMIc
 7el4jsKtS3gTsDSsJodd7O6v+pVrEY2qQP7g4eDvKqFVqVzQPmJ9ki4qnqYZ0Y/AuySn
 KHW49MzPLDQZXV2BHQT/lLAsDHgQN5CnfKxD6vKy8zy6mDCSXe7IS+isMaR23ExsXdEh
 CaL9wxe38Vap6EY4cP9j1pr6fUJeLVrJKQAGnhZq7M3SrXQMx3CDXcjUMfnj+rCWX7vS
 zlpZl4WtEMVhrvjaKj83VXuZpzFOE68uikLW1v51/c81VwAO9DZ3AoOvB8Sqo+bCIELe
 mbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VMRVhIQIXZxzucvozlD6kGt114/L0couPU+fNeFrnDQ=;
 b=h+rLbUBSjXZgH5hEPkIA94eaciKU5UwHmGFqc1yt127B+3G0KUsE5/sdz2AKf3c8Rm
 TygQoJd9ykw+scSM+QiTYdd51Mfw5cjALU+w4depLzZ1zzr/A0iSrS0kI4GaH3eoypvi
 hKacZzupCiDwEphB0mulfxH6d8juk9weGw0nG6OkSQV76ZDN6ntli/tNJIaXiKavVpFQ
 tO30Da49h6ppObgfILzpEWZzWdCjKgCngmBE7jbr5IKAx2mZ0fUuH8VN+K1BYa7aD7XO
 1Id7Uy2CcAzzqIVUeoOEve/2Uroew1RN3rxKiMEG0VYLMiB5xUOiZoBW/B/Zx65A/YSR
 iZpg==
X-Gm-Message-State: AOAM533NHffYOuHBKavJJIE6UUwFY+KvjrilB/RZq01e2Nm/omSx51Nu
 TupHRkuR9iSIIbUOgtHDZoQ=
X-Google-Smtp-Source: ABdhPJxUJhjHWZALtw4qPBu4yxZgE6PlX7Q+SepxYV+BseqPdze5m+o668iKAr7LDljmuCzZrtec+Q==
X-Received: by 2002:aa7:d4d7:: with SMTP id t23mr1529021edr.321.1611599618531; 
 Mon, 25 Jan 2021 10:33:38 -0800 (PST)
Received: from martin (p578aa711.dip0.t-ipconnect.de. [87.138.167.17])
 by smtp.gmail.com with ESMTPSA id ce7sm8584140ejb.100.2021.01.25.10.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 10:33:37 -0800 (PST)
Date: Mon, 25 Jan 2021 19:33:35 +0100
From: Martin Radev <martin.b.radev@gmail.com>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH] swiotlb: Validate bounce size in the sync/unmap path
Message-ID: <YA8O/2qBBzZo5hi7@martin>
References: <X/27MSbfDGCY9WZu@martin> <20210113113017.GA28106@lst.de>
 <YAV0uhfkimXn1izW@martin> <20210118151428.GA72213@fedora>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210118151428.GA72213@fedora>
Cc: thomas.lendacky@amd.com, file@sect.tu-berlin.de,
 robert.buhren@sect.tu-berlin.de, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 mathias.morbitzer@aisec.fraunhofer.de, Christoph Hellwig <hch@lst.de>,
 kirill.shutemov@linux.intel.com
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

On Mon, Jan 18, 2021 at 10:14:28AM -0500, Konrad Rzeszutek Wilk wrote:
> On Mon, Jan 18, 2021 at 12:44:58PM +0100, Martin Radev wrote:
> > On Wed, Jan 13, 2021 at 12:30:17PM +0100, Christoph Hellwig wrote:
> > > On Tue, Jan 12, 2021 at 04:07:29PM +0100, Martin Radev wrote:
> > > > The size of the buffer being bounced is not checked if it happens
> > > > to be larger than the size of the mapped buffer. Because the size
> > > > can be controlled by a device, as it's the case with virtio devices,
> > > > this can lead to memory corruption.
> > > > 
> > > 
> > > I'm really worried about all these hodge podge hacks for not trusted
> > > hypervisors in the I/O stack.  Instead of trying to harden protocols
> > > that are fundamentally not designed for this, how about instead coming
> > > up with a new paravirtualized I/O interface that is specifically
> > > designed for use with an untrusted hypervisor from the start?
> > 
> > Your comment makes sense but then that would require the cooperation
> > of these vendors and the cloud providers to agree on something meaningful.
> > I am also not sure whether the end result would be better than hardening
> > this interface to catch corruption. There is already some validation in
> > unmap path anyway.
> > 
> > Another possibility is to move this hardening to the common virtio code,
> > but I think the code may become more complicated there since it would
> > require tracking both the dma_addr and length for each descriptor.
> 
> Christoph,
> 
> I've been wrestling with the same thing - this is specific to busted
> drivers. And in reality you could do the same thing with a hardware
> virtio device (see example in http://thunderclap.io/) - where the
> mitigation is 'enable the IOMMU to do its job.'.
> 
> AMD SEV documents speak about utilizing IOMMU to do this (AMD SEV-SNP)..
> and while that is great in the future, SEV without IOMMU is now here.
> 
> Doing a full circle here, this issue can be exploited with virtio
> but you could say do that with real hardware too if you hacked the
> firmware, so if you say used Intel SR-IOV NIC that was compromised
> on an AMD SEV machine, and plumbed in the guest - the IOMMU inside
> of the guest would be SWIOTLB code. Last line of defense against
> bad firmware to say.
> 
> As such I am leaning towards taking this code, but I am worried
> about the performance hit .. but perhaps I shouldn't as if you
> are using SWIOTLB=force already you are kind of taking a
> performance hit?
> 

I have not measured the performance degradation. This will hit all AMD SEV,
Intel TDX, IBM Protected Virtualization VMs. I don't expect the hit to
be large since there are only few added operations per hundreads of copied
bytes. I could try to measure the performance hit by running some benchmark
with virtio-net/virtio-blk/virtio-rng.

Earlier I said:
> > Another possibility is to move this hardening to the common virtio code,
> > but I think the code may become more complicated there since it would
> > require tracking both the dma_addr and length for each descriptor.

Unfortunately, this doesn't make sense. Even if there's validation for
the size in the common virtio layer, there will be some other device
which controls a dma_addr and length passed to dma_unmap* in the
corresponding driver. The device can target a specific dma-mapped private
buffer by changing the dma_addr and set a good length to overwrite buffers
following it.

So, instead of doing the check in every driver and hitting a performance
cost even when swiotlb is not used, it's probably better to fix it in
swiotlb.

@Tom Lendacky, do you think that it makes sense to harden swiotlb or
some other approach may be better for the SEV features?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
