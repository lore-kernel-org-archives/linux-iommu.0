Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3928AC47083
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 19:01:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03BB613DE
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 19:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03BB613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A917282B9F;
	Wed,  2 Jun 2021 19:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E0LwoQ8p6p6A; Wed,  2 Jun 2021 19:01:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A5BE82A6C;
	Wed,  2 Jun 2021 19:01:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5EDB5C000E;
	Wed,  2 Jun 2021 19:01:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32819C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 19:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D043401EC
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 19:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K3y3YCu_3Nbw for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 19:00:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5339C400DC
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 19:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622660458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXz63wHFCtBChG1iHvZvXLJp7K/v2y7oMTVIZRydq2I=;
 b=LuxVBJcy6m4hMqmTohuhwgy5dCwRtGE37+AC5VwiaPEDUZVyBhA6SOv+BzNY9BFS7AZCUR
 P0buUxbJNgRDyfPOtQLTSVoZZV5hYLPn9VZY7jfb3DdCs7a74OMgmCAfc0mfXNmDPxcEdF
 tRH4a56EHLzLFClYCRQ1XVKJYRVpmMU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-TbRn2J0DPIqznk8IPD1xJQ-1; Wed, 02 Jun 2021 15:00:56 -0400
X-MC-Unique: TbRn2J0DPIqznk8IPD1xJQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 e10-20020a4ab14a0000b029020e1573bdb7so2016032ooo.9
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 12:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MXz63wHFCtBChG1iHvZvXLJp7K/v2y7oMTVIZRydq2I=;
 b=NrxXACcKsUBaTyjJXcFjHCJou8+avwiM//scnLdIo3MdSztaIzJ2htbxALxzWPmqMx
 0TEHK2O1nFDwHTaTzITQgFCadOJL12UrF5ZjSw5ri9l7HRxxF74COx0DnAizG13XZVCP
 eIsGCq1IX+S0jIu8y2b2s1PTLpECh0zGGJMTb50rKmVUcQjoTmZHLNEd4KU0xY65a1sS
 sXUZVF1qRAfC9zMe3zqDxsAABrp9TqvzVA+QwkqBDmCdEIH2OWNfKX3y3SL80ga7EKPG
 gTmcWuC1neIHE010/L4AdWy6Gj0TnN5MBQm+55SWE6LWXS3bZVEozqz5riX0cgME8lGb
 0AxA==
X-Gm-Message-State: AOAM530wCh7Xo3MYZ7Vava7EwAuq5V62M97ImP5Hu+JJFN9h4aonZsGa
 ncDmUHJ5YzszNjD2AhrHmezZDOKHwC0eO75PvOSm/eBF2mgtv5kkDClqH1AuLZdNQAwMjQSSFjY
 CNPNkYyiiZzNA4fnykCuX5UhA7FHSuw==
X-Received: by 2002:a05:6830:15c2:: with SMTP id
 j2mr26008327otr.367.1622660455933; 
 Wed, 02 Jun 2021 12:00:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/5Q90CWT9NIdQ1XwO+Gtz3HwUCNmtONxlvq8I6Bn9cXQgzMIAVDQ/kll8JXgHVYLqh2a7KA==
X-Received: by 2002:a05:6830:15c2:: with SMTP id
 j2mr26008303otr.367.1622660455621; 
 Wed, 02 Jun 2021 12:00:55 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id q5sm163159oia.31.2021.06.02.12.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 12:00:54 -0700 (PDT)
Date: Wed, 2 Jun 2021 13:00:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602130053.615db578.alex.williamson@redhat.com>
In-Reply-To: <20210602180925.GH1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601162225.259923bc.alex.williamson@redhat.com>
 <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160140.GV1002214@nvidia.com>
 <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Wed, 2 Jun 2021 15:09:25 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 02, 2021 at 12:01:11PM -0600, Alex Williamson wrote:
> > On Wed, 2 Jun 2021 14:35:10 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Wed, Jun 02, 2021 at 11:11:17AM -0600, Alex Williamson wrote:
> > >   
> > > > > > > present and be able to test if DMA for that device is cache
> > > > > > > coherent.      
> > > > > 
> > > > > Why is this such a strong linkage to VFIO and not just a 'hey kvm
> > > > > emulate wbinvd' flag from qemu?    
> > > > 
> > > > IIRC, wbinvd has host implications, a malicious user could tell KVM to
> > > > emulate wbinvd then run the op in a loop and induce a disproportionate
> > > > load on the system.  We therefore wanted a way that it would only be
> > > > enabled when required.    
> > > 
> > > I think the non-coherentness is vfio_device specific? eg a specific
> > > device will decide if it is coherent or not?  
> > 
> > No, this is specifically whether DMA is cache coherent to the
> > processor, ie. in the case of wbinvd whether the processor needs to
> > invalidate its cache in order to see data from DMA.  
> 
> I'm confused. This is x86, all DMA is cache coherent unless the device
> is doing something special.
> 
> > > If yes I'd recast this to call kvm_arch_register_noncoherent_dma()
> > > from the VFIO_GROUP_NOTIFY_SET_KVM in the struct vfio_device
> > > implementation and not link it through the IOMMU.  
> > 
> > The IOMMU tells us if DMA is cache coherent, VFIO_DMA_CC_IOMMU maps to
> > IOMMU_CAP_CACHE_COHERENCY for all domains within a container.  
> 
> And this special IOMMU mode is basically requested by the device
> driver, right? Because if you use this mode you have to also use
> special programming techniques.
> 
> This smells like all the "snoop bypass" stuff from PCIE (for GPUs
> even) in a different guise - it is device triggered, not platform
> triggered behavior.

Right, the device can generate the no-snoop transactions, but it's the
IOMMU that essentially determines whether those transactions are
actually still cache coherent, AIUI.

I did experiment with virtually hardwiring the Enable No-Snoop bit in
the Device Control Register to zero, which would be generically allowed
by the PCIe spec, but then we get into subtle dependencies in the device
drivers and clearing the bit again after any sort of reset and the
backdoor accesses to config space which exist mostly in the class of
devices that might use no-snoop transactions (yes, GPUs suck).

It was much easier and more robust to ignore the device setting and rely
on the IOMMU behavior.  Yes, maybe we sometimes emulate wbinvd for VMs
where the device doesn't support no-snoop, but it seemed like platforms
were headed in this direction where no-snoop was ignored anyway.
Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
