Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27420C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 23:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A330382457;
	Tue,  7 Dec 2021 23:09:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QwQgPndPWnYG; Tue,  7 Dec 2021 23:09:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 20ED880CD5;
	Tue,  7 Dec 2021 23:09:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA594C002F;
	Tue,  7 Dec 2021 23:09:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED195C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 23:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D5E6582457
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 23:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W5J7CdfTFWug for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 23:09:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B776E80CD5
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 23:09:39 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 j5-20020a17090a318500b001a6c749e697so2885212pjb.1
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 15:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qKDd1VX3hBC89im9d4I56OuLVc25eiwTlx+sbQdp+Sw=;
 b=vnRocbhNrruqT81hYa0+LL1YmTd03xre0R39dPhTL0Iz+ndRyi8Kk2j4vncEtIedml
 5RWbyz49x2iypSewBHEWmhUYR0VuL5cEhUkN98ZUxvT6HS/VyG0I0qMdRscK/WNR2DzI
 dB92AVMKkDTkNdE63WRtE0QzmrymcC1lL2mSUXhMPJ7x/2TV60k32n1ycoojIp/UExzR
 fc6k80Qup2+U+AI6C7WOejJzHM7rcFKuzGjy1pgiKFxywby8bw80rj64B0R02Fi6e6vv
 fL+92ombKOd2u0jrHgMNUN/EW+PdkCFpJ2gNZo1sByZ9x4wqg7GRifEO4/ue6Cqc/Sfp
 0iYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qKDd1VX3hBC89im9d4I56OuLVc25eiwTlx+sbQdp+Sw=;
 b=m0l/flnz8J0GuEiAYnfaTyCqyJOs/oPQY+K9t7Pnn6oO9uyM7BIC991wjlEuVNvkDg
 kyeVy/LSDPRtko0btOCbP24c/ZMDVYzZQxEVBixeN+ttQzAosVTWQM5NS2zufvhSNX2U
 kbHprqy4GJzWT7CkhK3WmYUDNwyZ/n64WvdNCaaxMORQPKW1BLRnjy33YI2LD9W14eZD
 56RfFwis+rm/8ZeS1uzlSWoEGc0Bh+8QjzM8bzcJ0KlVzQAnvLCUOWM0hMMGAYEvYoaA
 UvKcjCR5gK4pV2fukCYQKgJY1dDI6+ZHIs5DnOPzYQbY2VNbIMqufzKZuz7XmZ2Bc8qq
 HMUQ==
X-Gm-Message-State: AOAM5327bi83W6ieUWfzxR7w0Ll3OUtqLdzKF9f4o95Hpkgum5caKj97
 Y5CJSapsmvdVL2itddEm1/gVK+4k/IVPZ1OLDW4OsA==
X-Google-Smtp-Source: ABdhPJzZdj71AnZbqQAjVBfM6MMhRIMl5UOIfQgG74lXBky1qWNCtCR6rgJiwzjurPqRAgI5uDkweOykjFQBpapU+Vk=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr54368732plb.4.1638918579107; Tue, 07
 Dec 2021 15:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-4-baolu.lu@linux.intel.com> <Ya3BYxrgkNK3kbGI@kroah.com>
 <Ya4abbx5M31LYd3N@infradead.org> <20211206144535.GB4670@nvidia.com>
 <Ya4ikRpenoQPXfML@infradead.org> <20211206150415.GD4670@nvidia.com>
In-Reply-To: <20211206150415.GD4670@nvidia.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Dec 2021 15:09:28 -0800
Message-ID: <CAPcyv4gS8fxx_QP43ShhLysRgy0XH-4KS_e3WO56k6gNMQqaJA@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] driver core: platform: Rename
 platform_dma_configure()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 David Airlie <airlied@linux.ie>, Linux PCI <linux-pci@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, KVM list <kvm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Li Yang <leoyang.li@nxp.com>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Dec 6, 2021 at 7:04 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Dec 06, 2021 at 06:47:45AM -0800, Christoph Hellwig wrote:
> > On Mon, Dec 06, 2021 at 10:45:35AM -0400, Jason Gunthorpe via iommu wrote:
> > > IIRC the only thing this function does is touch ACPI and OF stuff?
> > > Isn't that firmware?
> > >
> > > AFAICT amba uses this because AMBA devices might be linked to DT
> > > descriptions?
> >
> > But DT descriptions aren't firmware.  They are usually either passed onb
> > the bootloader or in some deeply embedded setups embedded into the
> > kernel image.
>
> Pedenatically yes, but do you know of a common word to refer to both
> OF and ACPI that is better than firmware? :)
>
> AFAICT we already use firwmare for this in a few places, eg
> fwnode_handle and so on.

I've always thought 'platform' was the generic name for otherwise
non-enumerable platform-firmware/data things enumerated by ACPI / OF.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
