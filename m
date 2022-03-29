Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B857BC433FE
	for <iommu@archiver.kernel.org>; Tue, 29 Mar 2022 12:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 504DB40B0B;
	Tue, 29 Mar 2022 12:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VUdF4kqQtLG4; Tue, 29 Mar 2022 12:15:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F26B400A6;
	Tue, 29 Mar 2022 12:15:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4834C001D;
	Tue, 29 Mar 2022 12:15:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75361C0012
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 12:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70EBD610E2
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 12:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8xWID_RY2P2 for <iommu@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 12:15:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3D22610DF
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 12:15:32 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id r64so10160398wmr.4
 for <iommu@lists.linux-foundation.org>; Tue, 29 Mar 2022 05:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T2jLrwWe1iSHMc5kpeBG3DQY2pIuRegpnsz85M8uusM=;
 b=SOmNcjeK1QJNNsqJ+AsIpmCMKYetH67cNp5iTXV9teMOpSplA382FX0HhjTI1CzTc6
 N8Km2W8xqTQrrHDTjD2JZkewPt4o7ap22PEKtYWw1aN9x+Tt84N4unrSRPJQVkwzReCF
 e9uuHq2jDA4DRhElwAfhMP6uroKhuDZtthP1aklrHxLHch/AqjqKtraWhH2Y7wBwYXGF
 CawzM2kdIQsJSaXekn6pOuSMH5zq26QfBhNrF7o5rleazINBPGzlz7exGGotNOicZiMN
 rs73gpDMMUctIfrcY0JoMF0X7Scr3RGtFU7mLWrvnJAzrbyOoBLaRAnvd1aB2KbfAWY2
 uBFA==
X-Gm-Message-State: AOAM5301uQoLb1cnjqb1HtvKbnlQebXxRuf9LpPc0ILdmrzgJ57bEYQe
 Dm90jxgIXQNfp+HplaWMP/0=
X-Google-Smtp-Source: ABdhPJxXuTcR3NfAkRsxJHv6E8qdHUJogLPiA+Q9aX4xvsnU07sHIdhCXFrrTUWp10zLcRWE4C3qjw==
X-Received: by 2002:a05:600c:4ec9:b0:38c:9146:563 with SMTP id
 g9-20020a05600c4ec900b0038c91460563mr6670263wmq.198.1648556130816; 
 Tue, 29 Mar 2022 05:15:30 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a5d4141000000b00205d3d37dcdsm904568wrq.103.2022.03.29.05.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Mar 2022 05:15:30 -0700 (PDT)
Date: Tue, 29 Mar 2022 12:15:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3 0/2] Fix coherence for VMbus and PCI pass-thru devices
 in Hyper-V VM
Message-ID: <20220329121528.lrk4fjfgpw3yg3bg@liuwe-devbox-debian-v2>
References: <1648138492-2191-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1648138492-2191-1-git-send-email-mikelley@microsoft.com>
Cc: robh@kernel.org, wei.liu@kernel.org, sthemmin@microsoft.com,
 linux-acpi@vger.kernel.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 haiyangz@microsoft.com, decui@microsoft.com, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, iommu@lists.linux-foundation.org,
 linux-hyperv@vger.kernel.org, kw@linux.com, kys@microsoft.com,
 robin.murphy@arm.com, hch@lst.de, lenb@kernel.org
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

On Thu, Mar 24, 2022 at 09:14:50AM -0700, Michael Kelley wrote:
> Hyper-V VMs have VMbus synthetic devices and PCI pass-thru devices that are added
> dynamically via the VMbus protocol and are not represented in the ACPI DSDT. Only
> the top level VMbus node exists in the DSDT. As such, on ARM64 these devices don't
> pick up coherence information and default to not hardware coherent.  This results
> in extra software coherence management overhead since the synthetic devices are
> always hardware coherent. PCI pass-thru devices are also hardware coherent in all
> current usage scenarios.
> 
> Fix this by propagating coherence information from the top level VMbus node in
> the DSDT to all VMbus synthetic devices and PCI pass-thru devices. While smaller
> granularity of control would be better, basing on the VMbus node in the DSDT
> gives as escape path if a future scenario arises with devices that are not
> hardware coherent.
> 
> Changes since v2:
> * Move coherence propagation for VMbus synthetic devices to a separate
>   .dma_configure function instead of the .probe fucntion [Robin Murphy]
> 
> Changes since v1:
> * Use device_get_dma_attr() instead of acpi_get_dma_attr(), eliminating the
>   need to export acpi_get_dma_attr() [Robin Murphy]
> * Use arch_setup_dma_ops() to set device coherence [Robin Murphy]
> * Move handling of missing _CCA to vmbus_acpi_add() so it is only done once
> * Rework handling of PCI devices so existing code in pci_dma_configure()
>   just works
> 
> Michael Kelley (2):
>   Drivers: hv: vmbus: Propagate VMbus coherence to each VMbus device
>   PCI: hv: Propagate coherence from VMbus device to PCI device

Patch 2 will not be very useful without patch 1 so I've applied the
whole series to hyperv-fixes. Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
