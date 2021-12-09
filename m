Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69C1C433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 20:32:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B74A424EE;
	Thu,  9 Dec 2021 20:32:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkqyxpkj3qvM; Thu,  9 Dec 2021 20:32:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E5E064041C;
	Thu,  9 Dec 2021 20:32:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B863C0012;
	Thu,  9 Dec 2021 20:32:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2230C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FFE18609A
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="PMlHc47j";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="u5GXr0Ba"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w2khOcwOxdgi for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 20:32:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA729855EA
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 20:32:46 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639081963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2Zx4DzHcJuKFVR6I6pM84QqZd+nRGuDXek8rfRkIMk=;
 b=PMlHc47jMHeHpw99BO9sg3zedLq5d4B8nc3AxuM6euhsArxYRgHrHGCwaVgT6koam6q5Fb
 7IjyWHHcnuesdfp9jyBgc9ldc07rTB+ZCXXZ3tiHeLSgWFNSGaF11VKKpzij6SanhQ5g6i
 lZbtftMQFAmyK1fyrHXZQtwJ171iCSKKMfZep2mtrRxMd/0P3lI55EUG0HEjx2Fnz7DbeU
 DV4wBmFy7GEtXMUz0Pty++mqTHGOWwvtDvE+Jtu8ejdELCsF082WxVkklmlPlnvaqiabnt
 jEW2zMrN6ILYghH7VFsjyu4Wv7EOCKwrtDR2XCW9drIVh1aBWYRZrolwCoywWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639081963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2Zx4DzHcJuKFVR6I6pM84QqZd+nRGuDXek8rfRkIMk=;
 b=u5GXr0BaWLLYyA2le45d4B9fuhsMSv0ml5F/eXn19auKX+MOSBHJylA2QvG23s4uSJwHUK
 mZuRMCGg3H/EBLDw==
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211209162129.GS6385@nvidia.com>
References: <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com> <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com> <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
Date: Thu, 09 Dec 2021 21:32:42 +0100
Message-ID: <878rwtzfh1.ffs@tglx>
MIME-Version: 1.0
Cc: Allen Hubbe <allenbh@gmail.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zygnier <maz@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 Logan Gunthorpe <logang@deltatee.com>, "Dey, Megha" <megha.dey@intel.com>
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

On Thu, Dec 09 2021 at 12:21, Jason Gunthorpe wrote:
> On Thu, Dec 09, 2021 at 09:37:06AM +0100, Thomas Gleixner wrote:
> If we keep the MSI emulation in the hypervisor then MSI != IMS.  The
> MSI code needs to write a addr/data pair compatible with the emulation
> and the IMS code needs to write an addr/data pair from the
> hypercall. Seems like this scenario is best avoided!
>
> From this perspective I haven't connected how virtual interrupt
> remapping helps in the guest? Is this a way to provide the hypercall
> I'm imagining above?

That was my thought to avoid having different mechanisms.

The address/data pair is computed in two places:

  1) Activation of an interrupt
  2) Affinity setting on an interrupt

Both configure the IRTE when interrupt remapping is in place.

In both cases a vector is allocated in the vector domain and based on
the resulting target APIC / vector number pair the IRTE is
(re)configured.

So putting the hypercall into the vIRTE update is the obvious
place. Both activation and affinity setting can fail and propagate an
error code down to the originating caller.

Hmm?

Thanks,

        tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
