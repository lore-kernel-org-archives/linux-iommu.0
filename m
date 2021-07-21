Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B304CC12002
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:39:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F9E6120D
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F9E6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F25040206;
	Wed, 21 Jul 2021 18:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ApZWh17-KwY4; Wed, 21 Jul 2021 18:39:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC328401E2;
	Wed, 21 Jul 2021 18:39:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3C24C0010;
	Wed, 21 Jul 2021 18:39:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DB9BC000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6764C401ED
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pHUtDLjAP7N3 for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 18:39:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F3BC401E2
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:39:18 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id t20so4255487ljd.2
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XVG+jbRDBSu+eXxXtQp1KBYPh+7m/khOUuuf9tJsJlQ=;
 b=o0knBKRqF+/V/tbZpHxFHljIbk4FsvpfHxd1B4gIGEd6eXlgdOM3oy0vhGXit4qYj3
 Eau+h3HBB/pRHR7jWtV+eRigTywh20vgTGPLE+kHjvhHEv1ehZ01GA/4VF8wU23W+Ykv
 EAJaX4O9jgr3FMsTBKsz07UN/lmzQ6HdWBm6TBVUW892tdubZjbTaGBZjMx8ZAQYJ7cO
 SIVhMpC2buXAwwPSCIZ6N/RAcaDc5RF3LZMUFdeqUaD0NYg0nDfSDZZ7xZPyjVy6dWbV
 rhw5saUHGPTXtEGx/ZJc07ntkyzEClVwkS6wR2VacLMcAJDIjYQMxoqoQLbUfqU+ZYCH
 QWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XVG+jbRDBSu+eXxXtQp1KBYPh+7m/khOUuuf9tJsJlQ=;
 b=H2EVy1T9sy1lRzmm41nru/cgzUSzVsNm7CdKrKgvNDtRQQtaBoyMzAZLDzYoIflvKf
 N/2FwY+5TYRXgeNsk+4vn35a3Xouv4xx0oCH4SymjfTLCjRoXVLZBlK/yalNdZ/F6DR8
 ivMSrCNViJrwE2yKd5qFScx7kr9/nkyMR5BVJ58i+piKTLSNFDCmKPf2v/jIZbp9dTTb
 ZeZtSUAlD/50von+0VWW/s097PWEqkDV2CV84dgXSt/lg4xuHtIVfjh6gx3wr3Uwnuwj
 xoxcm21pnwmkF0CgZQNCLBToliZ43nfLgky6LuBboSaQBUSYB+7z/gt7Q3+sDttmMhaL
 q2cA==
X-Gm-Message-State: AOAM533NrOa0Heoa0pTaS1kQb6Lc0UhxBai3D6AvMiEqgFUPiVpCdAUZ
 jqdM/laeGJq2FE18pOBp7Ou21pU46aQfeCBkyc0=
X-Google-Smtp-Source: ABdhPJwoLGwmM+TS2dyBgKCbp5Ry4yu+pA8iXsy3Lf/VOi5eurQ/S0y3MgQ+JBpzeMSSwEoknDX2czlo24N5L0fkqf8=
X-Received: by 2002:a2e:890f:: with SMTP id d15mr31953878lji.37.1626892756146; 
 Wed, 21 Jul 2021 11:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210715170011.GA17324@lst.de>
 <20210716083934.154992-1-rm.skakun@gmail.com>
 <20210716093551.GA17981@lst.de>
 <CADu_u-OYA+Z_y-DBLxyUYGhmLVMtLggmZ_SnRiEtw9EGrO4oGg@mail.gmail.com>
 <alpine.DEB.2.21.2107160828430.3916@sstabellini-ThinkPad-T480s>
 <CADu_u-Psn5QpOyZ18_NCPx14DYxmGmSqVod=_RBC3A_A93tGUw@mail.gmail.com>
 <20210719092235.GA31566@lst.de>
In-Reply-To: <20210719092235.GA31566@lst.de>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Wed, 21 Jul 2021 21:39:05 +0300
Message-ID: <CADu_u-OVTGFpDw9cP+VHMAW8fdG3mtMZDCG3Tu92fF286zVFDA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
To: Christoph Hellwig <hch@lst.de>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Andrii Anisov <andrii_anisov@epam.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org, Roman Skakun <rm.skakun@gmail.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Roman Skakun <Roman_Skakun@epam.com>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
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

> Fine with.  I've queued up the modified patch.

Good. Thanks!

>
> On Sat, Jul 17, 2021 at 11:39:21AM +0300, Roman Skakun wrote:
> > > We can merge this patch and create a new one for
> > > xen_swiotlb_free_coherent() later.
> > > Yeah, no worries, I didn't know that exposing dma_common_vaddr_to_page
> > > was problematic.
> > >
> > > This patch is fine by me.
> >
> > Good. I'm agreed too. Waiting for Christoph.
>
> Fine with.  I've queued up the modified patch.



--
Best Regards, Roman.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
