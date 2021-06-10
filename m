Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18993C47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 16:37:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05A3613DD
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 16:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05A3613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63B7B40600;
	Thu, 10 Jun 2021 16:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yLxPhyWYfruq; Thu, 10 Jun 2021 16:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C55DF405B6;
	Thu, 10 Jun 2021 16:37:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7DC9C000E;
	Thu, 10 Jun 2021 16:37:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33402C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 16:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AB1840133
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 16:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cT5EmbZ7aUu7 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 16:37:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9AEB44010B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 16:37:52 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 h22-20020a05600c3516b02901a826f84095so6808765wmq.5
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=f8rhLdT0RKsyrunOn+7eaHkk+cg4cuRYRCg5AglwD7I=;
 b=pU/ofemaNwl6En1anEcPanaJr5czdL+/043dbE3PYDPOwBdaT5TUOt349W02sZi+sv
 t6ODWBuf4ZgX3HNJe92GOr3030uvz4FkjbWakVSnf99CKsqpL3DVtansnRfHB18lhGdn
 pgUN6VViDGoqTWYV4BYZsE4KWHTXLZ/TX4L6hgVPJUyrI1D28PZhCgt+Hrwv5Jt6KZxe
 gnsazP38W0WBiNsAw+NRcC5C0xWBjhApsTDqhw9qyQD5Eo6XJmza/uwiG/7esq66b3kF
 8AVHa8vtfDehBAP2nPcUMj0thcLICnFWxKCLWqb4aFnNLnPzI1hIi1jZv/a1ZTlU+RX7
 4OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f8rhLdT0RKsyrunOn+7eaHkk+cg4cuRYRCg5AglwD7I=;
 b=olPKwSfcW8f7ysZFMblgBgKE0OkmB86ESEai4V0I3SBkxn8kNJGvEv4OlFRMdYFZ83
 fCTg/SH1nORQQ8+dGBRhMbY4nXt8gFDXC0ku+uOXYpytruKeZk+SuJt5ist8Gwa4oUOb
 BCp489MDvoLUygjWNdSGJzUDt7FYhzfsILwOAXQrmcJLr8rN9Ib7xILocFSRNMa/Q3Gb
 bgJE6bUy4RLGXhD5SmiaBCG5u2i2RBEli7QpaCFJKh+2X+jmrmDMMZ13pkUv8sW+c0o9
 poZLgyFmkgWUUxj/Tdf+DCBuhSIvjKrYRThVIn2NWv+lReZjoR2+NR/oNKq0OSPNgeYD
 Mx/g==
X-Gm-Message-State: AOAM532x5mD6ZBo5AzyUQyAz+F4bLrilEmSYZKZNMO1TWS/0GlsnJuwS
 NOJOTvtS2ua7CL9tQqg2z7DKag==
X-Google-Smtp-Source: ABdhPJyYTImEurcnl5VwC5/pGAvjj9znK3+1Ick0kYtmO7fcvkXgpcxi4OyPNC6HVoE4nyUJwSKq+Q==
X-Received: by 2002:a05:600c:4148:: with SMTP id
 h8mr15886906wmm.176.1623343070684; 
 Thu, 10 Jun 2021 09:37:50 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id f13sm4039814wrt.86.2021.06.10.09.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 09:37:49 -0700 (PDT)
Date: Thu, 10 Jun 2021 18:37:31 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YMI/yynDsX/aaG8T@myrica>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com> <YLcpw5Kx61L7TVmR@yekko>
 <20210602165838.GA1002214@nvidia.com> <YLhsZRc72aIMZajz@yekko>
 <YLn/SJtzuJopSO2x@myrica> <YL8O1pAlg1jtHudn@yekko>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YL8O1pAlg1jtHudn@yekko>
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

On Tue, Jun 08, 2021 at 04:31:50PM +1000, David Gibson wrote:
> For the qemu case, I would imagine a two stage fallback:
> 
>     1) Ask for the exact IOMMU capabilities (including pagetable
>        format) that the vIOMMU has.  If the host can supply, you're
>        good
> 
>     2) If not, ask for a kernel managed IOAS.  Verify that it can map
>        all the IOVA ranges the guest vIOMMU needs, and has an equal or
>        smaller pagesize than the guest vIOMMU presents.  If so,
>        software emulate the vIOMMU by shadowing guest io pagetable
>        updates into the kernel managed IOAS.
> 
>     3) You're out of luck, don't start.
>     
> For both (1) and (2) I'd expect it to be asking this question *after*
> saying what devices are attached to the IOAS, based on the virtual
> hardware configuration.  That doesn't cover hotplug, of course, for
> that you have to just fail the hotplug if the new device isn't
> supportable with the IOAS you already have.

Yes. So there is a point in time when the IOAS is frozen, and cannot take
in new incompatible devices. I think that can support the usage I had in
mind. If the VMM (non-QEMU, let's say) wanted to create one IOASID FD per
feature set it could bind the first device, freeze the features, then bind
the second device. If the second bind fails it creates a new FD, allowing
to fall back to (2) for the second device while keeping (1) for the first
device. A paravirtual IOMMU like virtio-iommu could easily support this as
it describes pIOMMU properties for each device to the guest. An emulated
vIOMMU could also support some hybrid cases as you describe below.

> One can imagine optimizations where for certain intermediate cases you
> could do a lighter SW emu if the host supports a model that's close to
> the vIOMMU one, and you're able to trap and emulate the differences.
> In practice I doubt anyone's going to have time to look for such cases
> and implement the logic for it.
> 
> > For example depending whether the hardware IOMMU is SMMUv2 or SMMUv3, that
> > completely changes the capabilities offered to the guest (some v2
> > implementations support nesting page tables, but never PASID nor PRI
> > unlike v3.) The same vIOMMU could support either, presenting different
> > capabilities to the guest, even multiple page table formats if we wanted
> > to be exhaustive (SMMUv2 supports the older 32-bit descriptor), but it
> > needs to know early on what the hardware is precisely. Then some new page
> > table format shows up and, although the vIOMMU can support that in
> > addition to older ones, QEMU will have to pick a single one, that it
> > assumes the guest knows how to drive?
> > 
> > I think once it binds a device to an IOASID fd, QEMU will want to probe
> > what hardware features are available before going further with the vIOMMU
> > setup (is there PASID, PRI, which page table formats are supported,
> > address size, page granule, etc). Obtaining precise information about the
> > hardware would be less awkward than trying different configurations until
> > one succeeds. Binding an additional device would then fail if its pIOMMU
> > doesn't support exactly the features supported for the first device,
> > because we don't know which ones the guest will choose. QEMU will have to
> > open a new IOASID fd for that device.
> 
> No, this fundamentally misunderstands the qemu model.  The user
> *chooses* the guest visible platform, and qemu supplies it or fails.
> There is no negotiation with the guest, because this makes managing
> migration impossibly difficult.

I'd like to understand better where the difficulty lies, with migration.
Is the problem, once we have a guest running on physical machine A, to
make sure that physical machine B supports the same IOMMU properties
before migrating the VM over to B?  Why can't QEMU (instead of the user)
select a feature set on machine A, then when time comes to migrate, query
all information from the host kernel on machine B and check that it
matches what was picked for machine A?  Or is it only trying to
accommodate different sets of features between A and B, that would be too
difficult?

Thanks,
Jean

> 
> -cpu host is an exception, which is used because it is so useful, but
> it's kind of a pain on the qemu side.  Virt management systems like
> oVirt/RHV almost universally *do not use* -cpu host, precisely because
> it cannot support predictable migration.
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
