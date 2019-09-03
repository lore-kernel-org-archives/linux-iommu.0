Return-Path: <SRS0=5lac=W6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B15C3A5A2
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 17:20:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A8421881
	for <iommu@archiver.kernel.org>; Tue,  3 Sep 2019 17:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A8421881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5A3FFE3C;
	Tue,  3 Sep 2019 17:20:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9655EDB3
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 17:20:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 44801709
	for <iommu@lists.linux-foundation.org>;
	Tue,  3 Sep 2019 17:20:14 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id l16so30273wrv.12
	for <iommu@lists.linux-foundation.org>;
	Tue, 03 Sep 2019 10:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=rar4+uC5q12KPtiyVYMv+PjJypYyOCyJrBGvZDXzi2k=;
	b=kNU9O4ambQOiNj0dLmFvVHuxS79iAmySpuNuNqM5SV+PknwTob3GoIAOqqbYq50lPt
	762EeGhI2+nS8y5RuflJyH7dpuDM8EehqspEoN9CPbwIZscs8nenZpc583LliyGOLrT4
	Xg+WZY/SiTEd5CPWVg4RDIVLSgwVc4ejfcG6APRAOzR8MMpGXahCX60PStVwT3zEME76
	SBAV/I7s/CpuJcG89dksFjUO27HL9eNGz+dEwkMsjI0Vxme7Esi3lBkyNSk6JQwey/pL
	5haLSVLZK/yfv+aCJDLDlVgSVgby3I/s9CnUOZWt3YB3LhQlwLUqqL7qHKLTuanKZTV6
	UhXw==
X-Gm-Message-State: APjAAAXNwGgxucgAVPT0rZOhqENs+JxTdCZGWJAWXRWoNogMprP+/Q5P
	/JzfMPJ9yJbl3IrdWTuy1g==
X-Google-Smtp-Source: APXvYqyjkukxdrT5Es1J9haZ+DcUHsFn8ngRxdUl3OZDcQKy38QGzV98Fy3y/684yQ4P6QtkGLVBdA==
X-Received: by 2002:adf:c613:: with SMTP id n19mr24481531wrg.109.1567531212863;
	Tue, 03 Sep 2019 10:20:12 -0700 (PDT)
Received: from localhost ([176.12.107.132]) by smtp.gmail.com with ESMTPSA id
	f10sm14511981wrm.31.2019.09.03.10.20.11
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 03 Sep 2019 10:20:12 -0700 (PDT)
Date: Tue, 3 Sep 2019 18:20:10 +0100
From: Rob Herring <robh@kernel.org>
To: Krzysztof Wilczynski <kw@linux.com>
Subject: Re: [PATCH v2] PCI: Remove unused includes and superfluous struct
	declaration
Message-ID: <20190903172010.GA26505@bogus>
References: <20190901112506.8469-1-kw@linux.com>
	<20190903113059.2901-1-kw@linux.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190903113059.2901-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Sep 03, 2019 at 01:30:59PM +0200, Krzysztof Wilczynski wrote:
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
>  drivers/irqchip/irq-gic-v2m.c                     | 1 +
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c          | 1 +
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  drivers/pci/controller/pci-aardvark.c             | 1 +
>  drivers/pci/controller/pci-thunder-pem.c          | 1 +
>  drivers/pci/pci.c                                 | 1 +
>  drivers/pci/probe.c                               | 1 +
>  include/linux/of_pci.h                            | 5 ++---
>  9 files changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
