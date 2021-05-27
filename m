Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF83C4708E
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 13:00:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F8C61355
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 13:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F8C61355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 13D91400F4;
	Thu, 27 May 2021 13:00:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJtVIU1mipuf; Thu, 27 May 2021 13:00:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0FF7340284;
	Thu, 27 May 2021 13:00:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD800C000E;
	Thu, 27 May 2021 13:00:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F880C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 13:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49C58608C0
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 13:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r3QItCdctjiK for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 13:00:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 745D460798
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 13:00:22 +0000 (UTC)
Received: by mail-il1-x136.google.com with SMTP id o9so150630ilh.6
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tgPMjyY5jAkXYAxU2M6Xs7JOfdHxgDuWupSEgAOvuBU=;
 b=HyAvfwEBrieOghAofexhSawgJJukm2YnQ2fAt2CFdEKEbDS1O9qhSu7HLdewyRfCVz
 gEA6t08wyk35Bk0UPING6Rrv8blJD9d3z2B2GuwI2wJTrYZe4msm0UUHcQ98yGMgAfAw
 jsaa2ecYO9Gel1C3uwINW+EKRzQM0HGE52Gr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tgPMjyY5jAkXYAxU2M6Xs7JOfdHxgDuWupSEgAOvuBU=;
 b=n9UwpS3b4RomyOqIjRnxVumU3b1PV3N3bwABnDWYxN5bfP5AnqO8cj1itbJPhuzOI1
 +cHJADE2D8JmgK+5WgjaPAkI31UCu9nmdR7hlFJxHgmGdzVTbP0Gx6FYvKbIHL4BORHc
 0IwiaraiGRp3ZRL306foGE1FopxlQ5Qnb49b3RGciOsuFLd8UgHJ9DnzkaWQUhtINR2M
 1xIKWe0jjepRneONpwUQH+HuzZIElRyzhfWskT4jGFk3PwFSRpEE6BuAFmotgnH2awdz
 XHUlQvBccUbBXs0ZPslkRrLX+XhADY7XGL+ZtW/sg0s72iKhYdXciY6VikRFFQEVyhkq
 1Sdw==
X-Gm-Message-State: AOAM5328ciYZMACtVx/T9FTs+UDvgA85Qkg5TAD+tQu7r+sIeb1NnHcm
 HT+ZM3ER1KVwGv87Uq1xWLdiu0HmUqHVOQ==
X-Google-Smtp-Source: ABdhPJyE1qD2V2OB8Fk0aCGTybALXelNenbwhB7D5rKPmEaG8iVxmLGWRDup463RAyEdaRKE1yFv7w==
X-Received: by 2002:a92:b102:: with SMTP id t2mr2889258ilh.102.1622120421202; 
 Thu, 27 May 2021 06:00:21 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com.
 [209.85.166.52])
 by smtp.gmail.com with ESMTPSA id x5sm1041240iom.43.2021.05.27.06.00.19
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 06:00:20 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id k16so322491ios.10
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 06:00:19 -0700 (PDT)
X-Received: by 2002:a02:a505:: with SMTP id e5mr3414377jam.10.1622120419476;
 Thu, 27 May 2021 06:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
In-Reply-To: <20210518064215.2856977-1-tientzu@chromium.org>
From: Claire Chang <tientzu@chromium.org>
Date: Thu, 27 May 2021 21:00:07 +0800
X-Gmail-Original-Message-ID: <CALiNf2-dUFSCOz4=jmEm8ZcX+zQXKzo6yPg31iLLLG3FAr+g1w@mail.gmail.com>
Message-ID: <CALiNf2-dUFSCOz4=jmEm8ZcX+zQXKzo6yPg31iLLLG3FAr+g1w@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] Restricted DMA
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, 
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, Jianxiong Gao <jxgao@google.com>, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
 maarten.lankhorst@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Nicolas Boichat <drinkcat@chromium.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
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

v8 here: https://lore.kernel.org/patchwork/cover/1437112/
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
