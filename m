Return-Path: <SRS0=wlUX=KJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E98C43460
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 12:19:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312036145A
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 12:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312036145A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7AB64045B;
	Fri, 14 May 2021 12:19:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wZIjX2TMbJ-I; Fri, 14 May 2021 12:19:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE4114011D;
	Fri, 14 May 2021 12:19:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6F87C000E;
	Fri, 14 May 2021 12:19:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A02CC0001
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 12:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8570C60ABC
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 12:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BKe26KJuQipg for <iommu@lists.linux-foundation.org>;
 Fri, 14 May 2021 12:19:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ADB0A605FF
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 12:19:27 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id a22so27876272qkl.10
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 05:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2orjcu+bFDK+ZSi8hWNlQqJx3e5HbNzAGaAd0cCLl7g=;
 b=bQUUjd0Y4a6jO+AmWs9nTp7PcXEayvZpEcpTja9XAf9f0gsuBo2iiJ+6gx+jk0U5kd
 weeVe+O5yPXANFk4bakBZ9VR+fQKl4ro6ucLBeC6rI1RoJ5zH5sj6bWeq13jzOvHJ2zW
 J/Nf0mMevGfLVFlcO+zybm8dCCfdx7uIYkH032E20HlRF+iVy4bB1b9NujfatCC/tKHr
 d7Cv6bttrnbKHyUJ9ksPbW1NNCVlgMUAQefzPXc+ZpDeAfvx9+q5INdn+Bm5+o+ngwMP
 GUyS7asnsIhk3K1BqpI1SFN+oq2oKy/e6KVLu9NSbj3c7oNMm8ghfeq84QzlZv2AQNbS
 x0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2orjcu+bFDK+ZSi8hWNlQqJx3e5HbNzAGaAd0cCLl7g=;
 b=AMaVs11J8EuSb6KLObsClt9eLZKLHBRIFylnZ1xaFwRAupKYomx7GH+Gaww5sQv9n6
 em9cNxmiKfxhhSsjTTarlEG+VJnPdnGfS8cZ4GemecaS/VENSg5k4E/+ogqOfh82phNH
 ZTIjoskiybHx3Y8/uX6FCVU7EskCM9M2MDctbX9LlWb64LIEj5rqLB+UbyVyKWzc+Eyj
 PNyAiUL03rfm1DXhmrWnsVIrHTuppJmr/ryTgyb1Iup8uaQPwsNk9g3k8VjP1eXOa4up
 G4YXgotmghfFCufQy4D/aRT+gi4Ib1Dmw98HS6stTAoJqxFaBNeEF0+1Rh7ynyFvIjrM
 5SQw==
X-Gm-Message-State: AOAM530eFQzevwRWMv5z7Jjh7B00HMTNPw6PHV/9SyUFVAWGXRRLkO5G
 JFQ2s0UTpSP+Cr1deUek015TeQ==
X-Google-Smtp-Source: ABdhPJxGyNQCvNGQGAHGa/24dlS2hhEnAClK5ht9t3tJrdkRDG96uMryqbLbGHeLVVgSRnKW4/+s6A==
X-Received: by 2002:a37:7246:: with SMTP id n67mr41596564qkc.71.1620994766455; 
 Fri, 14 May 2021 05:19:26 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id i9sm4807353qtg.18.2021.05.14.05.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 05:19:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lhWmr-007OI8-0o; Fri, 14 May 2021 09:19:25 -0300
Date: Fri, 14 May 2021 09:19:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210514121925.GI1096940@ziepe.ca>
References: <20210510065405.2334771-1-hch@lst.de>
 <20210510065405.2334771-4-hch@lst.de>
 <20210510155454.GA1096940@ziepe.ca>
 <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210513120058.GG1096940@ziepe.ca>
 <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
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

On Fri, May 14, 2021 at 06:54:16AM +0000, Tian, Kevin wrote:
> > From: Tian, Kevin
> > Sent: Friday, May 14, 2021 2:28 PM
> > 
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Thursday, May 13, 2021 8:01 PM
> > >
> > > On Thu, May 13, 2021 at 03:28:52AM +0000, Tian, Kevin wrote:
> > >
> > > > Are you specially concerned about this iommu_device hack which
> > > > directly connects mdev_device to iommu layer or the entire removed
> > > > logic including the aux domain concept? For the former we are now
> > > > following up the referred thread to find a clean way. But for the latter
> > > > we feel it's still necessary regardless of how iommu interface is
> > redesigned
> > > > to support device connection from the upper level driver. The reason is
> > > > that with mdev or subdevice one physical device could be attached to
> > > > multiple domains now. there could be a primary domain with DOMAIN_
> > > > DMA type for DMA_API use by parent driver itself, and multiple auxiliary
> > > > domains with DOMAIN_UNMANAGED types for subdevices assigned to
> > > > different VMs.
> > >
> > > Why do we need more domains than just the physical domain for the
> > > parent? How does auxdomain appear in /dev/ioasid?
> > >
> > 
> > Say the parent device has three WQs. WQ1 is used by parent driver itself,
> > while WQ2/WQ3 are assigned to VM1/VM2 respectively.
> > 
> > WQ1 is attached to domain1 for an IOVA space to support DMA API
> > operations in parent driver.

More specifically WQ1 uses a PASID that is represented by an IOASID to
userspace.

> > WQ2 is attached to domain2 for the GPA space of VM1. Domain2 is
> > created when WQ2 is assigned to VM1 as a mdev.
> > 
> > WQ3 is attached to domain3 for the GPA space of VM2. Domain3 is
> > created when WQ3 is assigned to VM2 as a mdev.
> > 
> > In this case domain1 is the primary while the other two are auxiliary
> > to the parent.
> > 
> > auxdomain represents as a normal domain in /dev/ioasid, with only
> > care required when doing attachment.
> > 
> > e.g. VM1 is assigned with both a pdev and mdev. Qemu creates
> > gpa_ioasid which is associated with a single domain for VM1's
> > GPA space and this domain is shared by both pdev and mdev.
> 
> Here pdev/mdev are just conceptual description. Following your
> earlier suggestion /dev/ioasid will not refer to explicit mdev_device.
> Instead, each vfio device attached to an ioasid is represented by either
> "struct device" for pdev or "struct device + pasid" for mdev. The
> presence of pasid decides which iommu_attach api should be used.

But you still haven't explained what an aux domain is to /dev/ioasid.

Why do I need more public kernel objects to represent a PASID IOASID?

Are you creating a domain for every IOASID? Why?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
