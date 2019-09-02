Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5885C3A59E
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4DE21883
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 13:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4DE21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0007EEA8;
	Mon,  2 Sep 2019 13:39:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A6157E9D
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 13:39:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2FFA9709
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 13:39:16 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id n10so3982149wmj.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 02 Sep 2019 06:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:date:from:subject:references
	:in-reply-to:cc:cc:to;
	bh=mdMEyHANWr3uFXlguLTgUNjt9G7yervbWu2Ux/GAB0I=;
	b=oCiKV6boH2HplTBqXdV2Oa/XLIdIBg0zIpAb4u1IndtYM+V5U5lPWI+tCOxA+bQNqM
	XWSQAI3X9eyk9X3Wpm+4V2/8nhIS7XIgqneBIP+YRQqjFWIOX8X8jqt/o51n9yHBjfKo
	oIpswEWiX6TuIHHud2JqQ39ViP/MfW+MtIJVRqXBMvYCqEfG/Qhg6b9qDfpX4tazs1zt
	8ARnhMjCnRwOqTtSIT+DbTPyw+fowWG+QhY8Tw3Kq/XezmaROoI8/aLdCJ6V9MbRRGwo
	FoeU4Fm6J6yhI9MG2qcQsxbkbB4a6qr0iSzYEblBBsP5JXXCPVEolm5Iy1j+7V0v7baI
	mzKQ==
X-Gm-Message-State: APjAAAUpdAWmQfYoOgTKnPM9eMOPJYK5xZaD9qg12LDtwj7Jx8k2egpf
	jDyLaAkSY5rVTEnwh25wSQ==
X-Google-Smtp-Source: APXvYqwMzwv1OFbk9jMbIrvjNPmwN4pGid61E7yY74F5cVWue5sDTckRsA9VxA03xcI175B+qRSeCw==
X-Received: by 2002:a7b:c84e:: with SMTP id c14mr36008947wml.46.1567431554729; 
	Mon, 02 Sep 2019 06:39:14 -0700 (PDT)
Received: from localhost ([212.187.182.166]) by smtp.gmail.com with ESMTPSA id
	i73sm5116549wmg.33.2019.09.02.06.39.13
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 02 Sep 2019 06:39:14 -0700 (PDT)
Message-ID: <5d6d1b82.1c69fb81.de44.60b9@mx.google.com>
Date: Mon, 02 Sep 2019 14:39:13 +0100
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PCI: Remove unused includes and superfluous struct
	declaration
References: <20190901112506.8469-1-kw@linux.com>
In-Reply-To: <20190901112506.8469-1-kw@linux.com>
To: Krzysztof Wilczynski <kw@linux.com>
Cc: , devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Sun,  1 Sep 2019 13:25:06 +0200, Krzysztof Wilczynski wrote:
> Remove <linux/pci.h> and <linux/msi.h> from being included
> directly as part of the include/linux/of_pci.h, and remove
> superfluous declaration of struct of_phandle_args.
> 
> Move users of include <linux/of_pci.h> to include <linux/pci.h>
> and <linux/msi.h> directly rather than rely on both being
> included transitively through <linux/of_pci.h>.
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  drivers/iommu/of_iommu.c                          | 2 ++
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  drivers/pci/controller/pci-aardvark.c             | 1 +
>  drivers/pci/pci.c                                 | 1 +
>  drivers/pci/probe.c                               | 1 +
>  include/linux/of_pci.h                            | 4 +---
>  6 files changed, 7 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
