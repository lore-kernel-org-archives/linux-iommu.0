Return-Path: <SRS0=wlUX=KJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAACC43460
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 13:31:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A5A613B9
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 13:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A5A613B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C8F0A4010F;
	Fri, 14 May 2021 13:31:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WcS89OdVIuiL; Fri, 14 May 2021 13:31:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC2704010C;
	Fri, 14 May 2021 13:31:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84504C000D;
	Fri, 14 May 2021 13:31:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE43EC0001
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 13:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A3189405D6
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 13:31:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQK0dcj8b60s for <iommu@lists.linux-foundation.org>;
 Fri, 14 May 2021 13:31:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9648D405D4
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 13:31:45 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id o59so2202615qva.1
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oibZ2encQTXVcTS46xz1aln4vXwMiQRn+5Ve6HidmyY=;
 b=P01L9ipF0WXXprGU/TPHMse5/2JNa5KJigLzB+MgLrkiRFpKV1d2TmruEIRGE/O2rT
 iiF42kQ3dw4/Ch/XtfZOpwpxPBgVZKlZepQw/F1pT5ms+OVjo7ydBxwBFLOD4pFck3pX
 f/NebrrJv+SMBUTHk3L2av0vieMiDpXGBAKiDs5U2/zXF1qRjy2armYsx39Ght5EFKH2
 d91amYNGXarhYvHIiJ3JkLOljk4RqMqWPMXK+okMlwkVyKMoLFmm5GfL7XMQtlV2jACI
 37Vdw6Mcy5n9S1ZpNBhtDgbvyBrqIrFPqfhlZc44jM/ZWDIhGcb0mFlhmSHuVzBytMpF
 on1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oibZ2encQTXVcTS46xz1aln4vXwMiQRn+5Ve6HidmyY=;
 b=gpXvIegqmPgD+IiVnbVf1aDJgo7f08B+g4xspTpY+eV9+w5uWJuL/gs5dGp6jc55In
 uWXuEBuIGRk9brbGiB5BNnGVHxB/udqb4ddTEImtsLf4ChyGYtEf56iVSRRiHCDlvC2t
 hBclBrUcz8laLXO3hTrTyle2v3adrkmqfBqta1Gg5hlTZb5m3YcTR/IeYqd81e42QYCB
 7VHdCLsOvNeXUuXdnv7Ob+t/45njOcIKlwcvfbQqCxMspCszujuhpyFwqImXc5L7TKGL
 2BU9JvQTLTf72JpSu80VGuSWBiZV5plFMo7MzOcbhfeMtwHkKOtn9DsRIzh137whkAVI
 BHuQ==
X-Gm-Message-State: AOAM5315KQJKWCYzNgy3g3uklQ2KOwdDNzq3ksi6WhnXG/gIGpk4lTXC
 fZWkgE6CicXFLyyezmvkNNkLyw==
X-Google-Smtp-Source: ABdhPJz/Gqut1q/aFEFJ4dhIoQHY99jUDAFFC+RcHlUQEp277wF1zYHdBA3LTZbkkjtOGNdQocIJpQ==
X-Received: by 2002:a0c:c488:: with SMTP id u8mr45442908qvi.47.1620999104308; 
 Fri, 14 May 2021 06:31:44 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id y1sm4582720qkp.21.2021.05.14.06.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 06:31:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lhXup-007RZ1-4c; Fri, 14 May 2021 10:31:43 -0300
Date: Fri, 14 May 2021 10:31:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210514133143.GK1096940@ziepe.ca>
References: <20210510065405.2334771-1-hch@lst.de>
 <20210510065405.2334771-4-hch@lst.de>
 <20210510155454.GA1096940@ziepe.ca>
 <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210513120058.GG1096940@ziepe.ca>
 <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514121925.GI1096940@ziepe.ca>
 <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Fri, May 14, 2021 at 12:58:10PM +0000, Tian, Kevin wrote:

> This avoids changing every iommu ops to include a PASID and forcing
> the upper-layer drivers to do it differently between pdev and mdev.
> Actually this was a main motivation when working out aux domain
> proposal with Joerg two years ago.

Well, usually when people say stuff like that it means it is a hack..

Oh, this does look like a big hack, yes.

/dev/ioasid is focused on IOASIDs. As an API you have to be able to use
it to create all kinds of IOASID's *against a single HW struct
device*.

In this world you can't create domains for every struct device as hack
to pass in the PASID.

The IOASID itself must be an object that contains the HW struct device
and the PASID. IOASID must be a first class object in the entire API.

Remember, when a driver wants to connect to an IOASID it wants to make
some very simple calls like:

   iommu_attach_ioasid_rid(&pci_device->dev, ioasid_ptr);
   iommu_attach_ioasid_pasid(&pci_device->dev, ioasid_ptr);

Which is based *only* on what the PCI device does. If the device issues
TLPs without PASID then the driver must use the first. If the device
issues TLPs with a PASID then the driver must use the latter.

There is no place for "domain as a carrier of PASID"
there. mdev_device should NOT participate in the IOMMU layer because
it is NOT a HW device. Trying to warp mdev_device into an IOMMU
presence is already the source of a lot of this hacky code.

To juggle multiple IOASID per HW device the IOMMU API obviously has to
be made IOASID aware. It can't just blindly assume that a struct
device implies the single IOASID to use and hope for the best.

> The reason is that iommu domain represents an IOVA address
> space shareable by multiple devices. It should be created at the 
> point where the address space is managed. 

IOASID represents the IOVA address space.

Two concepts that represent the same thing is not great :)

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
