Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8534C43457
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 13:55:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342E7222C3
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 13:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hX9UyplG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342E7222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D6CB887734;
	Fri,  9 Oct 2020 13:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NkNUMP6uK0Zj; Fri,  9 Oct 2020 13:55:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 31D1987723;
	Fri,  9 Oct 2020 13:55:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14AD4C07FF;
	Fri,  9 Oct 2020 13:55:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07106C0051
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 13:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E51A32E27F
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 13:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C9oMhIRv4-l2 for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 13:55:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com
 [209.85.166.180])
 by silver.osuosl.org (Postfix) with ESMTPS id 26FBD20026
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 13:55:06 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id r10so4344535ilm.11
 for <iommu@lists.linux-foundation.org>; Fri, 09 Oct 2020 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2S3D9iYx51A87Z/QbgZ/692gZHGuP26oR+0wJ2UbLg8=;
 b=hX9UyplGhpPB5uZa13A2uK91raJ+XXjUWlWCULGthc4S0OtZCfMyA1Sc9MTHzTbgC4
 msSG67tcHwpsaaHcIcBIxD//0F918iRlSssC5PR4njAqbOOYLyKqyC5a8bmRJ+42fVIX
 m5szy0Q1jAgH4+eL9obnuOTNuNffxCrmelyiwXC67CEvoRL3Yl5tuCyUnJ8SRVUT/wwd
 h1sLQ8miFedqdQqlUJXnL3yQoAhnGJv523s7udQLzJJ8AiSS3EpjHJGGcxtnuYqvMEPB
 GokfmAsUWyD3jFdgVaVDlBKgdFPczycyRd6zaGtUR6Beyb3OEx622w4pKxPRyQvqURMf
 1iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2S3D9iYx51A87Z/QbgZ/692gZHGuP26oR+0wJ2UbLg8=;
 b=Yw6h8bWr2k6EFYFJF7E6/CDJ70nFtKnxBgfZALXhGYxSl4quEE0JmoHds7DHL91BI4
 EeXLWkb2ErMGz39Je7Mjsitj+NiIlymuNCLS++coIjvbbqrXL3eaUQsG8RDbFXCM4mW8
 2PGWNB1ZLcMuz74kyHvlzSOJYuqyG4Ty1amnIP30yItyhTQpYYIGz1AN2NxnGQ6xTUgc
 JrWvf/kx27Wu3DfBARjIIiMj8WTn4jVr9IAFmyRm0ze+yACitNhxFZHtBboL/qWIIrH0
 9qnovlnKATjXg00oTK5+27JjutAF6whfwfCZ22hLVFm1AZm79O4H/No1uESWnk7RwOVq
 +Ytg==
X-Gm-Message-State: AOAM533rPNn6Iqi65M8gPXcpmtgtYJfYzVEtPec+hjZ5xqQI6rLF35NY
 Nbbcqkmm8eeNYryUwpVa7pFUuatprZytumVGQNTxcQ==
X-Google-Smtp-Source: ABdhPJwJSrz7eUwTvUf7DlETg6YMldEBYzcCV0k+8KYceSzIWftZL4GSM73AlaH1smsxWJNOo4qH2nJDd79/yrPumYg=
X-Received: by 2002:a05:6e02:664:: with SMTP id
 l4mr11028746ilt.81.1602251705277; 
 Fri, 09 Oct 2020 06:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvuq58q+GsWnzni0sKSHbubuQz-UaK3TASX26V_a7yBVw@mail.gmail.com>
 <20200924090349.GF27174@8bytes.org>
 <ecf71b34-a104-d42a-bfcd-9570e73520a7@arm.com>
 <20200924092546.GJ27174@8bytes.org>
 <e2186418-d4d6-e1f4-5eb4-3bfafb5cebb2@arm.com>
 <20200924095629.GL27174@8bytes.org>
In-Reply-To: <20200924095629.GL27174@8bytes.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 9 Oct 2020 19:24:54 +0530
Message-ID: <CA+G9fYu42j_B+Rg2nq+KKBiKLqxVEqabQ15CujyJ+o6jqRj2uQ@mail.gmail.com>
Subject: Re: arm-smmu 5000000.iommu: Cannot accommodate DMA offset for IOMMU
 page tables
To: Joerg Roedel <joro@8bytes.org>
Cc: Poonam Aggrwal <poonam.aggrwal@nxp.com>, Rob Herring <robh@kernel.org>,
 Joerg Roedel <jroedel@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Richard Weinberger <richard@nod.at>, "Z.Q. Hou" <Zhiqiang.Hou@nxp.com>,
 Will Deacon <will@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Suram Suram <suram@nxp.com>, masonccyang@mxic.com.tw,
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

On Thu, 24 Sep 2020 at 15:26, Joerg Roedel <joro@8bytes.org> wrote:
>
> On Thu, Sep 24, 2020 at 10:36:47AM +0100, Robin Murphy wrote:
> > Yes, the issue was introduced by one of the changes in "dma-mapping:
> > introduce DMA range map, supplanting dma_pfn_offset", so it only existed in
> > the dma-mapping/for-next branch anyway.

FYI,
The reported problem still exists
>
> Okay, alright then.
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
