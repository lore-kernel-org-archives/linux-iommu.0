Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A67C07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 15:38:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FDF61402
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 15:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FDF61402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DE5260689;
	Fri,  4 Jun 2021 15:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-bTdBVJY7Qk; Fri,  4 Jun 2021 15:38:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF847606F8;
	Fri,  4 Jun 2021 15:38:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9E29C000D;
	Fri,  4 Jun 2021 15:38:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F2DAC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1D66400E4
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VMshkah0g6si for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 15:38:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3C40400AB
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 15:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622821079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHiBAl8+vXrofNAjjOJ84eNcT7KcR0jKQ6aIcGHntvY=;
 b=AyLmExAftWus6g4Y4zVqwExnvnsdPsFhk3A1a2DLPmMcD1ErYW/Ut/snuDKPrMHA1ftCwl
 3UEkfugykVz8u9ywT2davlyvFvoCTPOu1uSVttGPO6A/0ii8YxyjzBLXXNYLFN5iIiZWnX
 r/d3wQBOeB/BunDmbmef0NLU36VWNyw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-rj1Xb4d9PuyogyblTK3RLQ-1; Fri, 04 Jun 2021 11:37:57 -0400
X-MC-Unique: rj1Xb4d9PuyogyblTK3RLQ-1
Received: by mail-il1-f197.google.com with SMTP id
 n18-20020a92d9d20000b02901d7b2ca03e6so6739450ilq.1
 for <iommu@lists.linux-foundation.org>; Fri, 04 Jun 2021 08:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=pHiBAl8+vXrofNAjjOJ84eNcT7KcR0jKQ6aIcGHntvY=;
 b=RSjTKBIxwC5xkZOfjlWLxAYVMKRlbO3/5QPDQ+hf0SBBdG+0/1faBClbRhArwP5Q7+
 V1/UflOudFg+Ao2CfS4b9yWvqpDVnXsujE2/puOyhkeXg0f51P/mwCrBv7xtsFzfmlpq
 sr7yWfTI6WM9+kXvF1B/3vMCSp/x3nHfgiKw/Q6nCK/0AscGKplIdRL6gKeTgT6pyy7+
 O5BSlD3s7JbOJAv5XzaS07Yqz0eOGBoyAuME4SYFnAomeApRugbuip90GfMy4kCxp1Yg
 R8urCINyNoU6BFCg1rETsmV4sMoHpDsh+n2AZV+sASDCV7VTkWc6sSCrFcOes/IAjDY+
 JZQA==
X-Gm-Message-State: AOAM531WW146a7VYZPbXGhVR05go0iDAAet1+oIgBw+HG3xVK/lGb6/t
 k6eD3FutB6e8TGntiF3HCHJTWUGw8/+BOuhh/jyIPDjH5ptP7IY2Y487ZHrl5kfCG0GLZ0J6mft
 jLW2syNvl1A/Xm8qt32mpBsUFv9hfCg==
X-Received: by 2002:a05:6638:183:: with SMTP id
 a3mr4732208jaq.47.1622821076889; 
 Fri, 04 Jun 2021 08:37:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQxo+zfw3yLheApkfMNT19Kxv+RF4mWzeBkwzbgyKeWykIJlgSP3F1B+dw6s35/Bocj5BfPQ==
X-Received: by 2002:a05:6638:183:: with SMTP id
 a3mr4732182jaq.47.1622821076638; 
 Fri, 04 Jun 2021 08:37:56 -0700 (PDT)
Received: from redhat.com (c-73-14-100-188.hsd1.co.comcast.net.
 [73.14.100.188])
 by smtp.gmail.com with ESMTPSA id d2sm3775869ilu.60.2021.06.04.08.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jun 2021 08:37:56 -0700 (PDT)
Date: Fri, 4 Jun 2021 09:37:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604093755.1d660a47.alex.williamson@redhat.com>
In-Reply-To: <MWHPR11MB1886C4BC352DDE03B44070C08C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <MWHPR11MB1886DC8ECF5D56FE485D13D58C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603124036.GU1002214@nvidia.com>
 <20210603144136.2b68c5c5.alex.williamson@redhat.com>
 <MWHPR11MB1886C4BC352DDE03B44070C08C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, 4 Jun 2021 09:19:50 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, June 4, 2021 4:42 AM
> >   
> > > 'qemu --allow-no-snoop' makes more sense to me  
> > 
> > I'd be tempted to attach it to the -device vfio-pci option, it's
> > specific drivers for specific devices that are going to want this and
> > those devices may not be permanently attached to the VM.  But I see in
> > the other thread you're trying to optimize IOMMU page table sharing.
> > 
> > There's a usability question in either case though and I'm not sure how
> > to get around it other than QEMU or the kernel knowing a list of
> > devices (explicit IDs or vendor+class) to select per device defaults.
> >   
> 
> "-device vfio-pci" is a per-device option, which implies that the
> no-snoop choice is given to the admin then no need to maintain 
> a fixed device list in Qemu?

I think we want to look at where we put it to have the best default
user experience.  For example the QEMU vfio-pci device option could use
on/off/auto semantics where auto is the default and QEMU maintains a
list of IDs or vendor/class configurations where we've determined the
"optimal" auto configuration.  Management tools could provide an
override, but we're imposing some pretty technical requirements for a
management tool to be able to come up with good per device defaults.
Seems like we should consolidate that technical decision in one place.
Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
