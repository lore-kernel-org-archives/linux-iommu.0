Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E5C48BD1
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 15:35:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460EE613E1
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 15:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460EE613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15A1B6072C;
	Fri, 11 Jun 2021 15:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gJCAW6SZ6nOr; Fri, 11 Jun 2021 15:35:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA7B2606D6;
	Fri, 11 Jun 2021 15:35:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B34DDC000E;
	Fri, 11 Jun 2021 15:35:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDD8FC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB7C9606DD
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0fS6ILMhHw78 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 15:35:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B55EB6072C
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:35:13 +0000 (UTC)
Received: by mail-il1-x12d.google.com with SMTP id d1so5550335ils.5
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AzuwWZVb0hvYDmhYzyjXOdcnRd7gmJwLqOExosCeDwM=;
 b=IRqkW7akj902Qmh2dpTJs35MbbbyYdNh845FqGa90ZgwGlX/fY4AEM0E2Tq/OkUGrx
 VVpf/9sUsDrF+Qmi4N27tWzf7jckOIK7UvGuS34GnQEYg0G4BU1Idcj7Q7ryrjHTdpBh
 ql1llzJVDf1YUXhBMlreUDeIOuUDsqa6G9X1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AzuwWZVb0hvYDmhYzyjXOdcnRd7gmJwLqOExosCeDwM=;
 b=bmZPfYQQAy/vrWgGyPgK4adU5YihtD4MjO1hUDDs6ZFsZi0oKcsI/tWxMUhqXwh8ZM
 FOImBQLKApq4rUr7tcGy4jaocK2UnlXh38jU8iODWG3xCg9M9gzInHlwFwI/FqO8wXOF
 60p/JPqhJRevunvx2uhamdjTg/gFTscT8OC1GYcJmyaKrijb9d5hUMofJqCXpFmqfQkq
 1e/cjhuu1+jb8MQrW6/a3uW0DPdT0j8EnROzzX/3Owt091WkmYpQ1aL+JENCwTLc7LWQ
 3On7zq3bxszwc97cMoEi0/Pz0XTlk6OgXm05w9jaV0mhpaPd9WgeBF15nc3HcgEnwcoo
 S27Q==
X-Gm-Message-State: AOAM532lemi2r7+TFhJVK/CB/YR/u5dRVjO6ShBZZgGJbChZFYQXO7fM
 yQXvcbEigPfHT7ct2KV2X5pxx7eBOz5Bsg==
X-Google-Smtp-Source: ABdhPJzowPYzjdzNygiFgbxPDSs9RO9wNdroNDSGKpiWuG5Mpvt6i+8/YhOpvUR2423S6Zmt+fmFLQ==
X-Received: by 2002:a05:6e02:e03:: with SMTP id
 a3mr3641377ilk.47.1623425712703; 
 Fri, 11 Jun 2021 08:35:12 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com.
 [209.85.166.51])
 by smtp.gmail.com with ESMTPSA id t15sm3489008ile.28.2021.06.11.08.35.10
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jun 2021 08:35:11 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id a6so31647604ioe.0
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 08:35:10 -0700 (PDT)
X-Received: by 2002:a05:6638:e81:: with SMTP id
 p1mr4464281jas.84.1623425710461; 
 Fri, 11 Jun 2021 08:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210611152659.2142983-1-tientzu@chromium.org>
 <20210611152659.2142983-7-tientzu@chromium.org>
In-Reply-To: <20210611152659.2142983-7-tientzu@chromium.org>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 11 Jun 2021 23:34:59 +0800
X-Gmail-Original-Message-ID: <CALiNf28OT2L1qcH4dKK8mb0=uCyaKDHW7r=LrC9MTJw0PSzSbw@mail.gmail.com>
Message-ID: <CALiNf28OT2L1qcH4dKK8mb0=uCyaKDHW7r=LrC9MTJw0PSzSbw@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] swiotlb: Update is_swiotlb_active to add a
 struct device argument
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

I don't have the HW to verify the change. Hopefully I use the right
device struct for is_swiotlb_active.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
