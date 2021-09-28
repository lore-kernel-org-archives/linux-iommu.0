Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA31C433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:47:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204106109E
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 204106109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7C7B60B1C;
	Tue, 28 Sep 2021 19:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6cvgc8edJ0Kt; Tue, 28 Sep 2021 19:47:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E226607BA;
	Tue, 28 Sep 2021 19:47:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8151DC000F;
	Tue, 28 Sep 2021 19:47:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B623DC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F05B401F5
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lmtZ3et0h6HW for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 19:47:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0974401EF
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:47:09 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id d207so42216089qkg.0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EVzDoSDqJZmi4ToqJEIddbvRD+vlWsRISaT7f2OXukE=;
 b=EO1kDwzeZuMv1jUFt2pmKX8GvyZQAUMBJiLy1x1SVytxwcplVnv2ywT1ffuJvbGzDe
 SqreChLnqXdZ3bmpOGx1lq6jv+yPr/cOeERvwxCekQ+2pAL/hPpshqhIf/ZGdT33EAIM
 lOon8sIgHYjE/rwWroGijsvQ3Sfl16uYtuTJKv69ByO+2IJKaQCkRs4E+itlOn/VuGnJ
 ObcFwFaFhFQuJrFju9q8374g29cj0NSSZZgWhx88Ckt7Rqd+521BC3qoxSNjSsHzeMSW
 tdbGfXJrW/lc1jL/isk876EABn7Hc3z0lVBV5inoZjNRJpGnlQE9c49iUQf8C8yixnTL
 5Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EVzDoSDqJZmi4ToqJEIddbvRD+vlWsRISaT7f2OXukE=;
 b=zskawVSn4O4yHUgsg9A4TN+qPaeyA7sHRfUB5MQrpuQNuDaMxUsCb6fJJRVatEFZ5D
 qU6I6S4YMeuP4p43QRdgRxhyVtmwi6q0liTFENCw5BAq/svH6WsotIw117VDcI8WTkgJ
 cJqv3QrT4mt7Sp4jNUHjxfo1PVAWdcmoz6eeKfHmCqGn061PsonZ/AMddE1IWYR6kHNL
 HT19wKx2/owZiWiykwEFIucFTICU8OnKHspKjj1dkz3q+YEWHAhUk9QpWj4b0urpQ7FY
 bNy2BRo9Y4+Y2/9eKXUXlG4qM4sPxxft2NkfBGy+4APPdGQ1hVEaIv6qAmvxNuAZGybo
 6BYw==
X-Gm-Message-State: AOAM531X04161E5qcgUHJl74B8LFbN1/J6giyZWpcYtk7iHVVHapMLxi
 UbAWWh1gbiA0jOMrR65fBQ2wpQ==
X-Google-Smtp-Source: ABdhPJxxZpC5AepjHCbAmIQaz4Zogx1HRof8bzNZRXH/My30paIzwcLwvreCcb7Df5Gio9BelRE2TQ==
X-Received: by 2002:a37:8242:: with SMTP id e63mr1886625qkd.294.1632858428465; 
 Tue, 28 Sep 2021 12:47:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d14sm79297qkg.49.2021.09.28.12.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:47:08 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJ4F-007GbK-31; Tue, 28 Sep 2021 16:47:07 -0300
Date: Tue, 28 Sep 2021 16:47:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 14/20] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <20210928194707.GU3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-15-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Thu, Sep 16, 2021 at 05:40:54PM -0600, Logan Gunthorpe wrote:
> Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> allow obtaining P2PDMA pages. If a caller does not set this flag
> and tries to map P2PDMA pages it will fail.
> 
> This is implemented by adding a flag and a check to get_dev_pagemap().

I would like to see the get_dev_pagemap() deleted from GUP in the
first place.

Why isn't this just a simple check of the page->pgmap type after
acquiring a valid page reference? See my prior note

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
