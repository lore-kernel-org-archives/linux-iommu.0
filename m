Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E76FC433B4
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 18:06:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D58610E9
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 18:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D58610E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 517BF40EC7;
	Wed, 19 May 2021 18:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ppBqBt9GDudC; Wed, 19 May 2021 18:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4C4B40EC0;
	Wed, 19 May 2021 18:06:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9221AC000E;
	Wed, 19 May 2021 18:06:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B15B0C0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 18:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98DA18435A
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 18:06:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sc7SU2CKsL2X for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 18:06:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79F9084355
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 18:06:38 +0000 (UTC)
Received: by mail-qv1-xf2b.google.com with SMTP id w9so7234003qvi.13
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tImv3Ted6BARmz7M+tuEIdrP9JRn+bjF1ToIbRbbDJ8=;
 b=Bbfl7flyMPWNyDLufCNwLW0WE4SyDnLCleDYtN7/u2gC0bb9iO/Hkj1b1N8LaK9jVj
 fFv21pHhR5afJPiTABu+Ns9UNr+b/IYRlZTXuZKrDtFJJ4kpcYylkACvXknYC/tu6iwZ
 aHZcmydArLtG5/HbT3w8d1hPAEd3OXLH52ztw2rDziHqk6aPSr7SCDOHthEKfk90OyfU
 AwNjxGHXHO6Kcj6FHUcEI5ANW2fXnbX8TXUtHFrHnkiCemekTOsHtUHxJHpMPhlG6HEU
 k175NImjnc4rhOfcgzYSFll8wC69/QQbK3OpIkUQKd4DZhvtTDNmCmYiosX/qIG+M9ig
 aA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tImv3Ted6BARmz7M+tuEIdrP9JRn+bjF1ToIbRbbDJ8=;
 b=TyEcLA+hPm82Zuz+oZ4BPVwyX/O4OQwyqNDvUqL0uBQj+DcwNlHQl1DaNA9MmsoPFZ
 k3CacKJZw52k72rCCfZC0quk7xaGoPOKC1xNdvvkewOOK4cstmGPwmFkRafHplIczDlx
 VJbUP/i86TGVDm4LJyQflnMvTQvP/6MmyFnieBYpsgbg2TvH6LimR1FOI9+KUltoumCa
 /WlIJUhl6UCjVwZ4TIZJXPWmQiAXkohGphUwZoy5K7r3pwmCvCCDSfFNeN4r9Nw9rcHH
 U9s5CYRwDrUULDbzbf7U/XWEpHf64L6C1W5SlmyuvED3IprzrlZAzDkYeebuecg9kccJ
 HSTQ==
X-Gm-Message-State: AOAM533zN+kbhagRPefUxj7Kzbwb/uzK4IH4SYVEuqB+Iy6GmLfE5klG
 X8pIyuxh4Vs8f0gjMShiTdisFw==
X-Google-Smtp-Source: ABdhPJxfdVisFtDoBA6vNWNzXoLMLU8eFLwTJh2Zrfswd3jA5ooaEQhDs9SHMkNr9LB1GfQ5Oi4EbQ==
X-Received: by 2002:a0c:ee62:: with SMTP id n2mr906256qvs.20.1621447597322;
 Wed, 19 May 2021 11:06:37 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id w5sm321655qkf.14.2021.05.19.11.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 11:06:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1ljQaZ-00AnII-Nw; Wed, 19 May 2021 15:06:35 -0300
Date: Wed, 19 May 2021 15:06:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210519180635.GT1096940@ziepe.ca>
References: <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514121925.GI1096940@ziepe.ca>
 <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133143.GK1096940@ziepe.ca> <YKJf7mphTHZoi7Qr@8bytes.org>
 <20210517123010.GO1096940@ziepe.ca> <YKJnPGonR+d8rbu/@8bytes.org>
 <20210517133500.GP1096940@ziepe.ca> <YKKNLrdQ4QjhLrKX@8bytes.org>
 <131327e3-5066-7a88-5b3c-07013585eb01@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <131327e3-5066-7a88-5b3c-07013585eb01@arm.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
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

On Wed, May 19, 2021 at 04:23:21PM +0100, Robin Murphy wrote:
> On 2021-05-17 16:35, Joerg Roedel wrote:
> > On Mon, May 17, 2021 at 10:35:00AM -0300, Jason Gunthorpe wrote:
> > > Well, I'm sorry, but there is a huge other thread talking about the
> > > IOASID design in great detail and why this is all needed. Jumping into
> > > this thread without context and basically rejecting all the
> > > conclusions that were reached over the last several weeks is really
> > > not helpful - especially since your objection is not technical.
> > > 
> > > I think you should wait for Intel to put together the /dev/ioasid uAPI
> > > proposal and the example use cases it should address then you can give
> > > feedback there, with proper context.
> > 
> > Yes, I think the next step is that someone who read the whole thread
> > writes up the conclusions and a rough /dev/ioasid API proposal, also
> > mentioning the use-cases it addresses. Based on that we can discuss the
> > implications this needs to have for IOMMU-API and code.
> > 
> >  From the use-cases I know the mdev concept is just fine. But if there is
> > a more generic one we can talk about it.
> 
> Just to add another voice here, I have some colleagues working on drivers
> where they want to use SMMU Substream IDs for a single hardware block to
> operate on multiple iommu_domains managed entirely within the
> kernel.

If it is entirely within the kernel I'm confused how mdev gets
involved? mdev is only for vfio which is userspace.

In any event, if you are kernel only it is not quite as big a deal to
create what you need. A 'substream domain' disconnected from the
struct device is not unreasonable.

> an mdev-like approach with aux domains is pretty much the ideal fit for this
> use-case, while all the IOASID discussion appears centred on SVA and
> userspace interfaces, and as such barely relevant if at all.

/dev/ioasid is centered on userspace, but usually the way this works
is a user API like that will be close to a mirror kernel
implementation if someone needs such a thing.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
