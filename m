Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E72C07E95
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 00:06:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68237613C1
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 00:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68237613C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 298BB60087;
	Wed, 14 Jul 2021 00:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DuUeXKEFKL_9; Wed, 14 Jul 2021 00:06:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0C08C60009;
	Wed, 14 Jul 2021 00:06:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE566C001A;
	Wed, 14 Jul 2021 00:06:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2430C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 00:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC062405F0
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 00:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I7-qRBL7ahCh for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 00:06:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EBCE1405B1
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 00:06:38 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id z9so9551778qkg.5
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BRzBORQqhYkIvSSgRD10J8EaiYQ9ItZJaai9Sym40Us=;
 b=teI5WRKub2F/rwFPxCg0ZINCjBfRJc54nJqUFdAMXpGIMiTspU9RrcrUvARcHwoeMd
 CQXv1wJ/Fog/rhWZSvumcNrgcq+BxotT51h+tTiRDV8aZpevQuwsLDR4vyQtZSmmoC6h
 F9IEcsAuWnvI+dAhgG0Eo2jqsi01XmkKdYdzhKwGl4vTdbqsh5/P7DXsca+16o6s1nU2
 2kLICjJFyej3TGeGHMleEoqCSW2m15wa6CXhxq4NskVTucQzPb/x7tap01fpFeI4k0/I
 0oDywPh08J0yunT5JHEEyAcZVTBsHz7FszjRqikpByO6wq8hJu89C/WxnMp4EIv1s5qc
 +urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=BRzBORQqhYkIvSSgRD10J8EaiYQ9ItZJaai9Sym40Us=;
 b=AkMZlBWykxJt7z1rwVmYgnpcE2nYgCrJgzHkVVHVJj1vPmKCmHS9PozG6y84K5KOvA
 MS2xwO+LtlGeSf0i36xgRsHlQH+0X6v4GMgq2RvhmaNT70NwjxBfKy8cg94cbdqTef6f
 2I8EE+3FCIEPEnclEmNQujrRUsJW2mJREGrMTu4cbD6dzzHwfInnZLG+efZSYRUMJ3R6
 ivcEQEqW0nJ9jpo9qHybrDFew1ydpLg9XgzdcTompPN1ekH3Gkb/9hw2ejZa47PEeXM7
 jPnbPiYzzWTR4+bx+VGWS7XbokBXNBXbCchmyRjUKon+Ru5W7aTeoHFSVygOAy6YhDt3
 cnUw==
X-Gm-Message-State: AOAM533PkVyY/E86KTCNErXZwzaphZT839RM+6AToM02TmgwMKXoHoov
 aRtCCq96MZQ8rszLhHmuav8=
X-Google-Smtp-Source: ABdhPJwNdfUqk7dW6v+BkJSkD78e6Hf5RHfzRN9m+TvOapNBOx9APu0hdr4kc7VyqpHBok4bqL0fFQ==
X-Received: by 2002:a05:620a:b85:: with SMTP id
 k5mr282577qkh.219.1626221197830; 
 Tue, 13 Jul 2021 17:06:37 -0700 (PDT)
Received: from fedora ([130.44.160.152])
 by smtp.gmail.com with ESMTPSA id o1sm128098qta.87.2021.07.13.17.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 17:06:37 -0700 (PDT)
Date: Tue, 13 Jul 2021 20:06:33 -0400
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v15 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
Message-ID: <YO4qifiYjL4BTMv4@fedora>
References: <YN/7xcxt/XGAKceZ@Ryzen-9-3900X.localdomain>
 <20210705190352.GA19461@willie-the-truck>
 <20210706044848.GA13640@lst.de>
 <20210706132422.GA20327@willie-the-truck>
 <a59f771f-3289-62f0-ca50-8f3675d9b166@arm.com>
 <20210706140513.GA26498@lst.de>
 <YORsr0h7u5l9DZwh@char.us.oracle.com>
 <20210706165720.GC20750@willie-the-truck>
 <YOSMDZmtfXEKerpf@char.us.oracle.com>
 <20210712135645.GA28881@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210712135645.GA28881@willie-the-truck>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, heikki.krogerus@linux.intel.com,
 linux-devicetree <devicetree@vger.kernel.org>, peterz@infradead.org,
 benh@kernel.crashing.org, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 grant.likely@arm.com, paulus@samba.org, Frank Rowand <frowand.list@gmail.com>,
 mingo@kernel.org, Jianxiong Gao <jxgao@google.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, xypron.glpk@gmx.de,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, matthew.auld@intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, thomas.hellstrom@linux.intel.com,
 jgross@suse.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 jani.nikula@linux.intel.com, Nathan Chancellor <nathan@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, Claire Chang <tientzu@chromium.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 boris.ostrovsky@oracle.com, airlied@linux.ie, linuxppc-dev@lists.ozlabs.org,
 Randy Dunlap <rdunlap@infradead.org>, Qian Cai <quic_qiancai@quicinc.com>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Greg KH <gregkh@linuxfoundation.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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

..snip..
> > > I think the main question I have is how would you like to see patches for
> > > 5.15? i.e. as patches on top of devel/for-linus-5.14 or something else?
> > 
> > Yes that would be perfect. If there are any dependencies on the rc1, I
> > can rebase it on top of that.
> 
> Yes, please, rebasing would be very helpful. The broader rework of
> 'io_tlb_default_mem' is going to conflict quite badly otherwise.

There is a devel/for-linus-5.15 (based on v5.14-rc1) now.

Thank you!
> 
> Cheers,
> 
> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
