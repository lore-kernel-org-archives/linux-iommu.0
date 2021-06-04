Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD14AC07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 10:24:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C49961404
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 10:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C49961404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F12440104;
	Fri,  4 Jun 2021 10:24:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3SEYXpbgpAa6; Fri,  4 Jun 2021 10:24:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0FA344016D;
	Fri,  4 Jun 2021 10:24:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEE35C000E;
	Fri,  4 Jun 2021 10:24:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D43A7C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 10:24:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB27B606F3
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 10:24:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sOeUH1x6qZoo for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 10:24:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7AA7606E9
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 10:24:30 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id g8so13756421ejx.1
 for <iommu@lists.linux-foundation.org>; Fri, 04 Jun 2021 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Vp5nodV8czU8XoGNBzmhcKT/5Cx+STD3G/uISCrpGY4=;
 b=Qy8oqCe9C3GIl3agw3bRS8rRWoOouva9dfQcVbDisTWeICLzPGNplyubb2CL7VqHSz
 orrVtrrbGENaTdVW1MigH2RXegdWfTY2nVGgSzKlZNPLj9HMmF+yMuOr8cjwDcDrgsHV
 n9JZnrXxv4zuJiNwb19p/di+oEb26GirvxUlLG9QExhKhz31Am5W/vNWLKNnN4KhjXaI
 HERJ2vRCBpAAFKDiFexTZLPh1iFOdMHNMJIT0IOLQkh/rQzHq3Z1BwZNLvh0RmLF484Z
 MQ0F1vbL/gc6DbMU664oR5/V/vcn77rw8gZSK3D9CkAccd92hj4183FzXwaOzw43K2/b
 R1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Vp5nodV8czU8XoGNBzmhcKT/5Cx+STD3G/uISCrpGY4=;
 b=rgw1rGR9Ry/fQ7y4XWyRH+1gzfAe7aLQZ6LdxwgByROH53RH/15mUhmRVdv8QlH1uB
 llvj4RM1WWBHFDT2A1XjHSv2PFSCaYxmQ1+RjpNqorETfXdZBvC0ViLWssmwL/6KYAH+
 vsmGldGB09LogOflcVKS9W3Aogdz9FFPoA0oyXYqzj0An43QlsTvwHTFzuGqgv/IIzLI
 cBuWmcONqGB8yglySlRZXRxpblB20mac+NVJopVxrKHy10zl5ZD8w3PRmmemkh/nOT3V
 KedulNzTAfo05PE3OLLi7gUipuSgtS7/D2qDwu5vwoPQbbvvOh+B0gq0jV6ApiajUUXl
 YWNA==
X-Gm-Message-State: AOAM532XemlmyjUWXw8elI8jC1SJvUSGhp73i63oFxdf75r4SERb06tS
 tRizxcA9sDyeGHMApmJxV8eqnA==
X-Google-Smtp-Source: ABdhPJyHncQfqj5pHRaAtZdltZJ3jUVuJI0Mj2xvK2vlD6pzD7aL91GaglI4VA6WW/8WtGakQzwRBA==
X-Received: by 2002:a17:906:fa13:: with SMTP id
 lo19mr3560274ejb.468.1622802268470; 
 Fri, 04 Jun 2021 03:24:28 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id f6sm2586850eja.108.2021.06.04.03.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jun 2021 03:24:27 -0700 (PDT)
Date: Fri, 4 Jun 2021 12:24:08 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLn/SJtzuJopSO2x@myrica>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com> <YLcpw5Kx61L7TVmR@yekko>
 <20210602165838.GA1002214@nvidia.com> <YLhsZRc72aIMZajz@yekko>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLhsZRc72aIMZajz@yekko>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)"
 <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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

On Thu, Jun 03, 2021 at 03:45:09PM +1000, David Gibson wrote:
> > > But it would certainly be possible for a system to have two
> > > different host bridges with two different IOMMUs with different
> > > pagetable formats.  Until you know which devices (and therefore
> > > which host bridge) you're talking about, you don't know what formats
> > > of pagetable to accept.  And if you have devices from *both* bridges
> > > you can't bind a page table at all - you could theoretically support
> > > a kernel managed pagetable by mirroring each MAP and UNMAP to tables
> > > in both formats, but it would be pretty reasonable not to support
> > > that.
> > 
> > The basic process for a user space owned pgtable mode would be:
> > 
> >  1) qemu has to figure out what format of pgtable to use
> > 
> >     Presumably it uses query functions using the device label.
> 
> No... in the qemu case it would always select the page table format
> that it needs to present to the guest.  That's part of the
> guest-visible platform that's selected by qemu's configuration.
> 
> There's no negotiation here: either the kernel can supply what qemu
> needs to pass to the guest, or it can't.  If it can't qemu, will have
> to either emulate in SW (if possible, probably using a kernel-managed
> IOASID to back it) or fail outright.
> 
> >     The
> >     kernel code should look at the entire device path through all the
> >     IOMMU HW to determine what is possible.
> > 
> >     Or it already knows because the VM's vIOMMU is running in some
> >     fixed page table format, or the VM's vIOMMU already told it, or
> >     something.
> 
> Again, I think you have the order a bit backwards.  The user selects
> the capabilities that the vIOMMU will present to the guest as part of
> the qemu configuration.  Qemu then requests that of the host kernel,
> and either the host kernel supplies it, qemu emulates it in SW, or
> qemu fails to start.

Hm, how fine a capability are we talking about?  If it's just "give me
VT-d capabilities" or "give me Arm capabilities" that would work, but
probably isn't useful. Anything finer will be awkward because userspace
will have to try combinations of capabilities to see what sticks, and
supporting new hardware will drop compatibility for older one.

For example depending whether the hardware IOMMU is SMMUv2 or SMMUv3, that
completely changes the capabilities offered to the guest (some v2
implementations support nesting page tables, but never PASID nor PRI
unlike v3.) The same vIOMMU could support either, presenting different
capabilities to the guest, even multiple page table formats if we wanted
to be exhaustive (SMMUv2 supports the older 32-bit descriptor), but it
needs to know early on what the hardware is precisely. Then some new page
table format shows up and, although the vIOMMU can support that in
addition to older ones, QEMU will have to pick a single one, that it
assumes the guest knows how to drive?

I think once it binds a device to an IOASID fd, QEMU will want to probe
what hardware features are available before going further with the vIOMMU
setup (is there PASID, PRI, which page table formats are supported,
address size, page granule, etc). Obtaining precise information about the
hardware would be less awkward than trying different configurations until
one succeeds. Binding an additional device would then fail if its pIOMMU
doesn't support exactly the features supported for the first device,
because we don't know which ones the guest will choose. QEMU will have to
open a new IOASID fd for that device.

Thanks,
Jean

> 
> Guest visible properties of the platform never (or *should* never)
> depend implicitly on host capabilities - it's impossible to sanely
> support migration in such an environment.
> 
> >  2) qemu creates an IOASID and based on #1 and says 'I want this format'
> 
> Right.
> 
> >  3) qemu binds the IOASID to the device. 
> > 
> >     If qmeu gets it wrong then it just fails.
> 
> Right, though it may be fall back to (partial) software emulation.  In
> practice that would mean using a kernel-managed IOASID and walking the
> guest IO pagetables itself to mirror them into the host kernel.
> 
> >  4) For the next device qemu would have to figure out if it can re-use
> >     an existing IOASID based on the required proeprties.
> 
> Nope.  Again, what devices share an IO address space is a guest
> visible part of the platform.  If the host kernel can't supply that,
> then qemu must not start (or fail the hotplug if the new device is
> being hotplugged).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
