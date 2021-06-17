Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A850C2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 06:47:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB00760200
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 06:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB00760200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9CE66077A;
	Thu, 17 Jun 2021 06:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R-Qf_PnUcSMG; Thu, 17 Jun 2021 06:47:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD8BC60792;
	Thu, 17 Jun 2021 06:47:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93297C000E;
	Thu, 17 Jun 2021 06:47:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9BC5C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 06:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C830F60792
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 06:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nx81_PmbuOUR for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 06:47:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B3296077A
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 06:47:05 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id z26so4203187pfj.5
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IqsCA/yjikDS1aCYzllqiH9HoLVcQQhYIn5qSeonABE=;
 b=GiFPgetacPTJVsGZ3MFWgSvQPnCdoTJhc4FxcdhnTR1mIKLWNYkC5qsclOh1Nu4T0t
 2JBHLcEHEvZiTaAAwPJzRshEva/oe1afpxIyCNXuS6Yc5SEiWBAid4ULBNFnG08bi+4b
 5Y3w62S7YQM/biDmcuEcWF0r86zBUuRahetbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IqsCA/yjikDS1aCYzllqiH9HoLVcQQhYIn5qSeonABE=;
 b=DZvIqtaSgBnvhtHqPINgT9Tw1TgcxAFYEwEREc6h6IBaHx9HYRxtob7xIy/CUajJpa
 WvJ4Bli7FcJUrWyYkP8IQoyuUSC2671n9TqIb/DTzjNwTyDFd5cqdQgQFNlH2plZRYwS
 kxv83UOiteeoRN1d7uuZCFIGUr6D+7ktAvXHJLhybSBUPydFQ8kxDCdHvddhf1NgCCOi
 RmOlXta6Ta10wwT0fnqsDshlZXSkkLisVH4NG04Pw+FOr5oean+2XCNFoGKe1EeGDo/L
 4cDw47YoZx2mrXVcMEBXIScu/Mj/628ap8MSLSpziTTOvUlCfZv+CHFik8EG6yl892Vq
 ctow==
X-Gm-Message-State: AOAM530zLMblLwC74tnKyn0ttO5qyMtmNeVxZJwNFY+BEjF7D+4AL4h0
 QkRN6AGSsdmaqO/YwDdmuQ5Juu4YO5qQPQ==
X-Google-Smtp-Source: ABdhPJxE0bl35+o1FBK9Wmvw1pdbzPTQYcB8CTlIgf96JqvN+iZ+4hy/B8XkedFbt4rh2IgzCNfDLg==
X-Received: by 2002:a05:6a00:26c6:b029:2f5:358c:6761 with SMTP id
 p6-20020a056a0026c6b02902f5358c6761mr3910684pfw.50.1623912424395; 
 Wed, 16 Jun 2021 23:47:04 -0700 (PDT)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com.
 [209.85.210.171])
 by smtp.gmail.com with ESMTPSA id v7sm4085344pfi.187.2021.06.16.23.47.03
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 23:47:04 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id s14so4190949pfd.9
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 23:47:03 -0700 (PDT)
X-Received: by 2002:a05:6602:2344:: with SMTP id
 r4mr2559955iot.69.1623912068770; 
 Wed, 16 Jun 2021 23:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210616062157.953777-1-tientzu@chromium.org>
 <20210616120837.GA22783@willie-the-truck>
In-Reply-To: <20210616120837.GA22783@willie-the-truck>
From: Claire Chang <tientzu@chromium.org>
Date: Thu, 17 Jun 2021 14:40:57 +0800
X-Gmail-Original-Message-ID: <CALiNf28SSxhs_+9Oq=pyOc7OWWDyWrtZLUqXKQKin6dRyXwo=w@mail.gmail.com>
Message-ID: <CALiNf28SSxhs_+9Oq=pyOc7OWWDyWrtZLUqXKQKin6dRyXwo=w@mail.gmail.com>
Subject: Re: [PATCH v12 00/12] Restricted DMA
To: Will Deacon <will@kernel.org>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
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

v13: https://lore.kernel.org/patchwork/cover/1448001/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
