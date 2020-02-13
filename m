Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037E7C2BA83
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 18:27:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61AD21734
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 18:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz+2U90q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61AD21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AC32585DF7;
	Thu, 13 Feb 2020 18:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p71sJ5g-5bCK; Thu, 13 Feb 2020 18:27:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2FF2C85424;
	Thu, 13 Feb 2020 18:27:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22F3EC07FE;
	Thu, 13 Feb 2020 18:27:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 854B1C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 18:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 73C572153B
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 18:27:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vzEJ-aaknFbv for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 18:26:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id C01882036D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 18:26:59 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7612A218AC
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581618419;
 bh=Tgkvt23nlRf0XRm+t9xKVRBeZnNy7mLvrbdLPrq1dno=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bz+2U90q4xyRoqgdjfbIX6rHvFOv6QdyFS6R6dKIw0F240hKve4cOqhYLU6RzTo0/
 xYdsNw0MvvYnOGpW6fTmgezOVEAz5tB7pLxYFgxHqnypwKMrBJCb0typQTORRXWsQ1
 h3oFcMDISvLmyBj62uGuw7KgJxdfMKD092DRS7Qc=
Received: by mail-qk1-f175.google.com with SMTP id w25so6655928qki.3
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:26:59 -0800 (PST)
X-Gm-Message-State: APjAAAXfhkHlc5KExo3pR23IB42Kwpyz9TOAIce/K6oDewtdP4CsKMQN
 0qFSVzbx/2Mu+tFMiIrIrCjXb9npwpjBv6BY2A==
X-Google-Smtp-Source: APXvYqydhKuBg+/ZrL4Cf+7gEQaOWH7r03zYxO/RkcD73vQs6Tc8XsgSRSpX2/PYrxCooFDmMvbFm0IEPx+1x/u9y3A=
X-Received: by 2002:a37:85c4:: with SMTP id
 h187mr17247898qkd.223.1581618418620; 
 Thu, 13 Feb 2020 10:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20200213165049.508908-1-jean-philippe@linaro.org>
 <20200213165049.508908-4-jean-philippe@linaro.org>
In-Reply-To: <20200213165049.508908-4-jean-philippe@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 13 Feb 2020 12:26:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZP9u7bFsVT=5TzqmnHWm_bvH39ffkbN3q9-k32ynVig@mail.gmail.com>
Message-ID: <CAL_JsqKZP9u7bFsVT=5TzqmnHWm_bvH39ffkbN3q9-k32ynVig@mail.gmail.com>
Subject: Re: [PATCH 03/11] PCI: OF: Check whether the host bridge supports ATS
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 PCI <linux-pci@vger.kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Hanjun Guo <guohanjun@huawei.com>, Frank Rowand <frowand.list@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, David Woodhouse <dwmw2@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Andrew Murray <amurray@thegoodpenguin.co.uk>
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

On Thu, Feb 13, 2020 at 10:52 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Copy the ats-supported flag into the pci_host_bridge structure.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/pci/controller/pci-host-common.c | 1 +
>  drivers/pci/of.c                         | 9 +++++++++
>  include/linux/of_pci.h                   | 3 +++
>  3 files changed, 13 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index 250a3fc80ec6..a6ac927be291 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -92,6 +92,7 @@ int pci_host_common_probe(struct platform_device *pdev,
>                 return ret;
>         }
>
> +       of_pci_host_check_ats(bridge);
>         platform_set_drvdata(pdev, bridge->bus);
>         return 0;
>  }
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 81ceeaa6f1d5..4b8a877f1e9f 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -576,6 +576,15 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_ranges);
>
> +void of_pci_host_check_ats(struct pci_host_bridge *bridge)
> +{
> +       struct device_node *np = bridge->bus->dev.of_node;
> +
> +       if (!np)
> +               return;
> +
> +       bridge->ats_supported = of_property_read_bool(np, "ats-supported");
> +}

Not really any point in a common function if we expect this to be only
for ECAM hosts which it seems to be based on the binding.

Otherwise, needs an export if not.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
