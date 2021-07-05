Return-Path: <SRS0=3QBT=L5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C204C07E99
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 15:21:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C08561968
	for <iommu@archiver.kernel.org>; Mon,  5 Jul 2021 15:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C08561968
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34501607C5;
	Mon,  5 Jul 2021 15:21:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EJ2JTa2prrDf; Mon,  5 Jul 2021 15:21:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2084F605E5;
	Mon,  5 Jul 2021 15:21:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAC92C0010;
	Mon,  5 Jul 2021 15:21:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54B96C000E
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 15:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 336CB83503
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 15:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X8BKqkgrVobz for <iommu@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 15:21:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E81A683498
 for <iommu@lists.linux-foundation.org>; Mon,  5 Jul 2021 15:21:41 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id x24so2627380qts.11
 for <iommu@lists.linux-foundation.org>; Mon, 05 Jul 2021 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EQF1PASyvqSifzSlB1BTrhSt5sT6rp3hwdnxdUVfuqA=;
 b=kmDpglpc3RH0U5xRmBUJk9QboHSHOdWADEPFPwVaQEubGzRnQRRT1SHHBfce7nQKCa
 TRq6ezuT4wo5LOH+ImCdmvwlFyLjejhxNqQWbyAalAxbWsHjdGDhB/vw7rNRktkG9VtR
 E62LMBPwmoFKoqMyuO+MpS/Nm27YZcQ3krKENaRE4KZAlfEhUag8bmyciSrNxjBWPu02
 V1kwt9lHg7OwLc36pRJ9AJn39+4/vCQ0wNP0qLRiZ2YurHA2UO01EGrayBp9VSkrlxCa
 Av0fPe3v8n+hSQyizmYXzW7axfQdHqaMbdxJrXL50juFxWnbUtpid7xdH61Jii4Jv//E
 NWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EQF1PASyvqSifzSlB1BTrhSt5sT6rp3hwdnxdUVfuqA=;
 b=qKKSxGirFuEK6l3fseUZ1tRXuAmIH5xFmsLsRN5BvRi8LENfSoIpYEWDxZoE4DRWFr
 zfnDMsfrICXD+I1+w6KC+aXW2OmoJ3qOnJ+OW3zoEyis3lg/VuGFtVdRMXMlZDfiDToa
 ZVlO1/TsZl5W0T0+l8gFWIV1y10b6//LdoZESKHyNfo9HEG8uWpRRUauoKSDeM8QiUUK
 QciHLPtywvS3b4c0YbfcTip1PuUDOTpeIE3qw5i+xfaTov2MF+Wqq2a/6lGTRfo7M2ol
 wkW/DT04tKMCaOhNa1/xtTxPzFSCMqx6CwesoCaoXEbpmDU06Jr80w4ny0jZie09Utpd
 Zk0g==
X-Gm-Message-State: AOAM532NaIBLVHRnPg5TObXMUlY2/u4gbAHYF9qUPm9vN28Me1Sajuie
 RzOM32IQnZAXETLNkmT62V7/eQ==
X-Google-Smtp-Source: ABdhPJzqbfejz7owHserpym0js6NKw6M0U6WSIEmDVGhY5KKmty1j6Zlb4e8E5uTCQb/l0OoL09K9w==
X-Received: by 2002:a05:622a:3d4:: with SMTP id
 k20mr12966495qtx.177.1625498500633; 
 Mon, 05 Jul 2021 08:21:40 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id s77sm4474299qke.85.2021.07.05.08.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 08:21:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1m0QPi-003qD0-UT; Mon, 05 Jul 2021 12:21:38 -0300
Date: Mon, 5 Jul 2021 12:21:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>, Christian Benvenuti <benve@cisco.com>,
 Nelson Escobar <neescoba@cisco.com>
Subject: Re: [bug report] IB/usnic: Add Cisco VIC low-level hardware driver
Message-ID: <20210705152138.GH4604@ziepe.ca>
References: <YOLdvTe4MJ4kS01z@mwanda>
 <0b8a876b-f71d-24a2-1826-07aa54248f40@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0b8a876b-f71d-24a2-1826-07aa54248f40@arm.com>
Cc: linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org,
 umalhi@cisco.com, Dan Carpenter <dan.carpenter@oracle.com>
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

On Mon, Jul 05, 2021 at 02:47:36PM +0100, Robin Murphy wrote:
> On 2021-07-05 11:23, Dan Carpenter wrote:
> > [ Ancient code, but the bug seems real enough still.  -dan ]
> > 
> > Hello Upinder Malhi,
> > 
> > The patch e3cf00d0a87f: "IB/usnic: Add Cisco VIC low-level hardware
> > driver" from Sep 10, 2013, leads to the following static checker
> > warning:
> > 
> > 	drivers/iommu/iommu.c:2482 iommu_map()
> > 	warn: sleeping in atomic context
> > 
> > drivers/infiniband/hw/usnic/usnic_uiom.c
> >     244  static int usnic_uiom_map_sorted_intervals(struct list_head *intervals,
> >     245                                                  struct usnic_uiom_reg *uiomr)
> > 
> > This function is always called from usnic_uiom_reg_get() which is holding
> > spin_lock(&pd->lock); so it can't sleep.
> 
> FWIW back in those days it wasn't really well defined whether iommu_map()
> was callable from non-sleeping contexts (the arch/arm DMA API code relied on
> it, for instance). It was only formalised 2 years ago by 781ca2de89ba
> ("iommu: Add gfp parameter to iommu_ops::map") which introduced the
> might_sleep() check that's firing there. I guess these calls want to be
> updated to iommu_map_atomic() now.

Does this mean this driver doesn't work at all upstream? I would be
quite interested to delete it.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
