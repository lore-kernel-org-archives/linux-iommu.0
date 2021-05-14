Return-Path: <SRS0=wlUX=KJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26D4C43460
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 13:39:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5C8613CD
	for <iommu@archiver.kernel.org>; Fri, 14 May 2021 13:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5C8613CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F049940486;
	Fri, 14 May 2021 13:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gSvDPSpMifgt; Fri, 14 May 2021 13:39:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4F684010C;
	Fri, 14 May 2021 13:39:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B39CC000D;
	Fri, 14 May 2021 13:39:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0C3CC0001
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 13:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D302F82BEB
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 13:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JSQBsuQ27-hu for <iommu@lists.linux-foundation.org>;
 Fri, 14 May 2021 13:39:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EFB382A2E
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 13:39:43 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id v4so13376085qtp.1
 for <iommu@lists.linux-foundation.org>; Fri, 14 May 2021 06:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=fw8jRpLJUUiDLFl+R/OeLe/+vcSlILAW8JDLv7Pnlgw=;
 b=ZA9iIphKPPHvcLSkBu2C/QMxUDhXyUp7Ql0A7zhq+gl8tX2VVw4d6MWbL3YGt3zMia
 eovdKfEgpKv/Kc6JgMp9UCw9S8MZR5nPFduJNr7x/z0XbVlGgNLXVftzfUVKBu0b6ABm
 RinPPw/eYvAo5xq2FjGO1ry+PBwldBVbyqtEvWJumFPyH6ThWymQ9gXFH0NAf+gQaVpn
 M9srCHz/FBZ/gl8Q7AQ70j9xSGfCbxZD9KMqMhWJ8ejqfvSLeS76TlpPfl+r5p2DMKcd
 O1K+SZm8GDVksZO0NYGjA4OCifqgsBaX7QsLUNiJf774sdooSmqhK4/lbsOJfcz7ocEi
 FQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fw8jRpLJUUiDLFl+R/OeLe/+vcSlILAW8JDLv7Pnlgw=;
 b=GigzELOrJjo2E9y7OkdVWWLHuDVHz8mSB8j7aVOtyzRrNHn4v7TEVoGJZo88zSrnOn
 2VnFWsk5sSifEb2Z3DDWFx7+OJrQm51KKrih1VuLd83haxa5+labmHfcVhoOtllPEgmn
 UgmIMWdSvZmEQXYqlKaOfGFxvTCeH4UsUtAst2NG138h1kEuAAT/uhexd4uPpsiD1xbm
 e6XR7vHKNiboKjeVpEaRNawhP+4lof3Sdz9tXiW6JEsHs46fMW0rrcZIH9oJB4TA7+iW
 osRbLJo3rQrBTE1QGyawMC29ZDjhSrjFAjXyEm9siWmLKzzp5Gisqq7k556B5YRQaGjF
 p9kQ==
X-Gm-Message-State: AOAM532voLs9r0xYSH9LGSmLg2mkvzocSpr4e6EzGFhPUJv8dF1gVOvU
 whFQLXlNSqICGD4AISG+RqFp+Q==
X-Google-Smtp-Source: ABdhPJyHkmiobTC20DDQbl/CkwGCuAAsPOfAEooNlfis4Grfk/a3JX140lwF9zGRuivL/kulThANeQ==
X-Received: by 2002:a05:622a:5c9:: with SMTP id
 d9mr14474203qtb.177.1620999582009; 
 Fri, 14 May 2021 06:39:42 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id 11sm4839279qkk.31.2021.05.14.06.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 06:39:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lhY2V-007RfW-Pl; Fri, 14 May 2021 10:39:39 -0300
Date: Fri, 14 May 2021 10:39:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210514133939.GL1096940@ziepe.ca>
References: <20210510065405.2334771-1-hch@lst.de>
 <20210510065405.2334771-4-hch@lst.de>
 <20210510155454.GA1096940@ziepe.ca>
 <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210513120058.GG1096940@ziepe.ca>
 <MWHPR11MB18863613CEBE3CDEEB86F4FC8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18863613CEBE3CDEEB86F4FC8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
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

On Fri, May 14, 2021 at 01:17:23PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, May 13, 2021 8:01 PM
> > 
> > On Thu, May 13, 2021 at 03:28:52AM +0000, Tian, Kevin wrote:
> > 
> > > Are you specially concerned about this iommu_device hack which
> > > directly connects mdev_device to iommu layer or the entire removed
> > > logic including the aux domain concept? For the former we are now
> > > following up the referred thread to find a clean way. But for the latter
> > > we feel it's still necessary regardless of how iommu interface is redesigned
> > > to support device connection from the upper level driver. The reason is
> > > that with mdev or subdevice one physical device could be attached to
> > > multiple domains now. there could be a primary domain with DOMAIN_
> > > DMA type for DMA_API use by parent driver itself, and multiple auxiliary
> > > domains with DOMAIN_UNMANAGED types for subdevices assigned to
> > > different VMs.
> > 
> > Why do we need more domains than just the physical domain for the
> > parent? How does auxdomain appear in /dev/ioasid?
> > 
> 
> Another simple reason. Say you have 4 mdevs each from a different 
> parent are attached to an ioasid. If only using physical domain of the 
> parent + PASID it means there are 4 domains (thus 4 page tables) under 
> this IOASID thus every dma map operation must be replicated in all
> 4 domains which is really unnecessary. Having the domain created
> with ioasid and allow a device attaching to multiple domains is much
> cleaner for the upper-layer drivers to work with iommu interface.

Eh? That sounds messed up.

The IOASID is the page table. If you have one IOASID and you attach it
to 4 IOMMU routings (be it pasid, rid, whatever) then there should
only ever by one page table.

The iommu driver should just point the iommu HW at the shared page
table for each of the 4 routes and be done with it. At worst it has to
replicate invalidates, but that is very HW dependent.

Domain is just a half-completed-ioasid concept. It is today not
flexible enough to be a true IOASID, but it still does hold the io
page table.

Basically your data structure is an IOASID. It holds a single HW
specific page table. The IOASID has a list of RID and (RID,PASID) that
are authorized to use it. The IOMMU HW is programed to match the
RID/(RID,PASID) list and search the single page table. When the page
table is changed the IOMMU is told to dump caches, however that works.

When a device driver wants to use an IOASID it tells the iommu to
setup the route, either RID or (RID,PASID). Setting the route causes
the IOMMU driver to update the HW.

The struct device has enough context to provide the RID and the IOMMU
driver connection when operating on the IOASID.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
