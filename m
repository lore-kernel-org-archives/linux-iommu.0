Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190E8C433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 00:11:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7123A225AB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 00:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7123A225AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E252C86027;
	Tue, 26 Jan 2021 00:11:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PGYmoAlNFCXk; Tue, 26 Jan 2021 00:11:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 74C3E85C32;
	Tue, 26 Jan 2021 00:11:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5930BC08A1;
	Tue, 26 Jan 2021 00:11:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A16A1C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 00:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 963B3870EA
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 00:11:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7FXB2gZc4YSH for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 00:11:40 +0000 (UTC)
X-Greylist: delayed 00:55:18 by SQLgrey-1.7.6
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8A86E8706C
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 00:11:40 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id ew18so2951429qvb.4
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 16:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pr+2CvKWSXQlcfbagHzf9FCH1wHTJk+YNUukuggEowE=;
 b=MPHMowxrctdI061dZikfB78k3kxJo7RV7pqbovUiUMGwLMx5mqeqVdd8BY75mLwS/U
 86aVmxSp3sp0NfyjYsQORyQ313BLeOnaF7UX0hMGJTbhPPTepqaouuIKpVXygcWMsM4Z
 QsVhyYYFAeq1iiJUujMomSxuVWJUU3HZcn+eO2EOg6EaKLJhuGCMEF+aAeneZN2CZgUP
 GS4DEay3LHU1iFNBJ3pB0b/I8zPMgmLsSITxXEQbpsLsYzU5KZ+Gf0hjrx+zl4KQ8TkW
 6K78hQCeKEqBkB2Cp6MuJB0zcVq6xgrOEn2t1t6hpBpHYXFzcBfAXmNCTo367HUJsMXA
 o23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pr+2CvKWSXQlcfbagHzf9FCH1wHTJk+YNUukuggEowE=;
 b=MtiqieP1KHb92y49EMDOg5zilN0d3nmxs2f7LKUxtidbzuku0KegtkJBPS4TbcgdN8
 bH3xZ7KJXMm46+chOg8cOT1QQ/QFRQP3D/dv2tPzne8K147kXbHVAFSyUFh2li6OY0kh
 nU9jfnMNsP1pMLMOjh9zocVGuhKwmkHKPCF0cP15fG4oeEVD170xO1UPVdbsU0O1gnCf
 wdxHMXA18cLJr5AiRiwiQAWa1I8pYPhQrm7/6tASONHHRaVLOc84/ZXhejXJB/TK/Mxj
 SZXtonEkJh9VXsd24c1OuGlRnZtk1IbaFTZXjWRee1CQjJVyseXO4CHWxTA4uPXgIiPo
 NHFw==
X-Gm-Message-State: AOAM5312XVfOVIuDrFxiP0KfE3KgCBAV+Z2xtPQrTjjwYo43hc4hzsjk
 8GjZIlwU0glOlS+yZ6DmghBnadMGL1/q4Q1Y
X-Google-Smtp-Source: ABdhPJyGDZ0yKVIVXVyamsLCpnaLzzwlkeMkZZGH66Bz7h7jySB+qEi/pLU/0Wjd+fPB0jo3AzFjjA==
X-Received: by 2002:a0c:c583:: with SMTP id a3mr3118919qvj.15.1611616581170;
 Mon, 25 Jan 2021 15:16:21 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id w9sm13608151qka.76.2021.01.25.15.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 15:16:20 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1l4B5o-006pqt-00; Mon, 25 Jan 2021 19:16:20 -0400
Date: Mon, 25 Jan 2021 19:16:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Message-ID: <20210125231619.GY4605@ziepe.ca>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <96b655ade2534a65974a378bb68383ee@hisilicon.com>
Cc: "chensihang \(A\)" <chensihang1@hisilicon.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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

On Mon, Jan 25, 2021 at 10:21:14PM +0000, Song Bao Hua (Barry Song) wrote:
> mlock, while certainly be able to prevent swapping out, it won't
> be able to stop page moving due to:
> * memory compaction in alloc_pages()
> * making huge pages
> * numa balance
> * memory compaction in CMA

Enabling those things is a major reason to have SVA device in the
first place, providing a SW API to turn it all off seems like the
wrong direction.

If the device doesn't want to use SVA then don't use it, use normal
DMA pinning like everything else.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
