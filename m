Return-Path: <SRS0=LVl/=KN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F29C433B4
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 06:53:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84567611BD
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 06:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84567611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 563FA40376;
	Tue, 18 May 2021 06:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YxR_YrD88yp5; Tue, 18 May 2021 06:53:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56932403AB;
	Tue, 18 May 2021 06:53:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34A04C000E;
	Tue, 18 May 2021 06:53:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63830C0001
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 06:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79B87400BE
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 06:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1FQKQhcoI_mJ for <iommu@lists.linux-foundation.org>;
 Tue, 18 May 2021 06:53:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D156140246
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 06:53:54 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id ez19so4451910qvb.3
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 23:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3HopsH6N9F8FpkG4FSoTMtRMwuiSWSuF3ZB9X+VJCjU=;
 b=LETfA+HNnfbbscLemZLHMHTU1ucDVUTbar59Z+Ip1n1aOSxU2vCiyi6AnzZ7ISe1Ci
 d5+6nDZp7u09C4wccj2HMQoLbhxVgGmyilxSsMMqy6XnJ9Gh0XN/+XAYDZzV88am1gOT
 FB7ehF0SoAEZFAQ80iPByl3CmJPeIGWiXIdbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3HopsH6N9F8FpkG4FSoTMtRMwuiSWSuF3ZB9X+VJCjU=;
 b=NRZGe+qGlcmSTgJqFUlGbVo0VJd03pgmIaoTgIbkK/J8o67n+mGb80HSj1j1bGEBm2
 ScdX5+mb94dOhC2FU4dqU8+UO51Dy/iNiaAVrZsXihYrfdei/Vs12C5PDLb3XL/0wjcI
 MtRpSRu6HI6se5rorpunkFPR6rBOGLvRJPNDYJ3wnOeRnVsaTSMH0ypvLb+O8yx3SryV
 Kb5JlGh/1t7UpHKG67YL+a2hdFPOYAR+nA2cCXNwqW0Lpxzv4MyNO3dYfWzGXWsbu8i9
 7SIhQuYpajEkVdjQu2gcyr/yu+nEHw370Z8XV9MOrtQEjYQYgVtLy/jtpg0bIh53uABw
 fIgw==
X-Gm-Message-State: AOAM530KWBK9Jy4+nuVyNjOcEZwjLhLc1P+fQfs7iG1xD7TiYv9acPFC
 P6ltS80R7q+eFmgeyJr0Cy4eeh90mMAl8Q==
X-Google-Smtp-Source: ABdhPJxsYNMJxDuPtnkbPrW4V6gWrQUnhZiEIOb8C084rhgWIr5Wf6H41gT5vV95kEPfN3tlEju8yA==
X-Received: by 2002:ad4:420b:: with SMTP id k11mr4154100qvp.18.1621320833566; 
 Mon, 17 May 2021 23:53:53 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com.
 [209.85.160.171])
 by smtp.gmail.com with ESMTPSA id g64sm12286360qkf.41.2021.05.17.23.53.53
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 23:53:53 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id c10so6716629qtx.10
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 23:53:53 -0700 (PDT)
X-Received: by 2002:a05:6638:32a8:: with SMTP id
 f40mr3969029jav.84.1621320526895; 
 Mon, 17 May 2021 23:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-5-tientzu@chromium.org>
In-Reply-To: <20210518064215.2856977-5-tientzu@chromium.org>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 18 May 2021 14:48:35 +0800
X-Gmail-Original-Message-ID: <CALiNf2_AWsnGqCnh02ZAGt+B-Ypzs1=-iOG2owm4GZHz2JAc4A@mail.gmail.com>
Message-ID: <CALiNf2_AWsnGqCnh02ZAGt+B-Ypzs1=-iOG2owm4GZHz2JAc4A@mail.gmail.com>
Subject: Re: [PATCH v7 04/15] swiotlb: Add restricted DMA pool initialization
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

I didn't move this to a separate file because I feel it might be
confusing for swiotlb_alloc/free (and need more functions to be
non-static).
Maybe instead of moving to a separate file, we can try to come up with
a better naming?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
