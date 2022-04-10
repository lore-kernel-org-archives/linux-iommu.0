Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECF4C433F5
	for <iommu@archiver.kernel.org>; Sun, 10 Apr 2022 14:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB2F683F87;
	Sun, 10 Apr 2022 14:32:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IAsrDA6EUcoj; Sun, 10 Apr 2022 14:32:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA53883F68;
	Sun, 10 Apr 2022 14:32:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 747FEC0084;
	Sun, 10 Apr 2022 14:32:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D82CBC002C
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 11:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D56D283F53
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 11:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tAVtE79-1kq8 for <iommu@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 11:00:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA1AF83F46
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 11:00:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 203ADB80AEC
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 11:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4873C385A1
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649588410;
 bh=HG3EYnk4+K3Kn+2yIOOHTNYQ+C3e3gphCbEHyUI4A8I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nHk6K+bBTC7SGUoNcLoDXEzcjhofVL0Ib2CakzlQNMt8menqJY6qEgWMQodIH7svR
 qzGlUslGLGtJE7psJw9RY4gWushtxo1/oS+0QNBnzRkPhGbcAKAsbFwCHaXusQ35dB
 G0+BeFLKQdwaQcYbW4iYDPUlO0flA8LhN/3m4nhB7oc3y5+HoyhFw6foKdfrW7PeJI
 KWjwluWT62exUetgW3V2JIXHCNIec/TUx98NQncqf7oPwba0mlYh0eA3g6nX08hMcp
 GGNZzMsHslnVDrldLnElEn2a8wjbjJcXwgK/TVSN1fhDLE87s0ut5B3tE0TVo5dvN/
 4MF93a2dppkmQ==
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-2eafabbc80aso137202897b3.11
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 04:00:10 -0700 (PDT)
X-Gm-Message-State: AOAM5328OxfOnKhH0DdNcRkAfRiCa6eISSRqXBFOcOlYvmj6iFRtzMJI
 fQCKK8Kol35/JP+9sF+tLfMGvXNVNe2BTuLNh2U=
X-Google-Smtp-Source: ABdhPJxBxfZ0z3pnWvMZWbELdbyMq5gxlXwDGYBc87VCrQWqRYDGvz/w/hx27YUP7/lwCMS8Ng/VQQO7MjnHMKnxe0U=
X-Received: by 2002:a81:6188:0:b0:2eb:4bd3:9b86 with SMTP id
 v130-20020a816188000000b002eb4bd39b86mr21098036ywb.46.1649588409982; Sun, 10
 Apr 2022 04:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <8201946a5b8b26dab35738b87da24ff27a9f9270.1649166391.git.robin.murphy@arm.com>
In-Reply-To: <8201946a5b8b26dab35738b87da24ff27a9f9270.1649166391.git.robin.murphy@arm.com>
From: Oded Gabbay <ogabbay@kernel.org>
Date: Sun, 10 Apr 2022 13:59:43 +0300
X-Gmail-Original-Message-ID: <CAFCwf10bwtpC=syFgcz8Ym5S797x3wmkGx3RFnUNkSsjdeyGgw@mail.gmail.com>
Message-ID: <CAFCwf10bwtpC=syFgcz8Ym5S797x3wmkGx3RFnUNkSsjdeyGgw@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Stop using iommu_present()
To: Robin Murphy <robin.murphy@arm.com>
X-Mailman-Approved-At: Sun, 10 Apr 2022 14:32:01 +0000
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
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

On Tue, Apr 5, 2022 at 4:46 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device
> we care about. Replace iommu_present() with a more appropriate check.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 8 ++++----
>  drivers/misc/habanalabs/goya/goya.c   | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 21c2b678ff72..5dc66dc7618e 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -6133,7 +6133,7 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>
>                 *val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
>
> @@ -6176,7 +6176,7 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>
>                 *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>
> @@ -6223,7 +6223,7 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>
>                 *val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
>
> @@ -6268,7 +6268,7 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>
>                 *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index ec9358bcbf0b..0c455bf460f4 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -4309,7 +4309,7 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>                 *val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
>
>         } else {
> @@ -4369,7 +4369,7 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>                 *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>
>         } else {
> @@ -4418,7 +4418,7 @@ static int goya_debugfs_read64(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>                 *val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
>
>         } else {
> @@ -4465,7 +4465,7 @@ static int goya_debugfs_write64(struct hl_device *hdev, u64 addr,
>                         rc = -EIO;
>
>         } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
> -                       user_address && !iommu_present(&pci_bus_type)) {
> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>                 *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>
>         } else {
> --
> 2.28.0.dirty
>

Hi Robin,
Can you please rebase this over the latest habanalabs-next ?
The code was totally changed, but I think your core change is
definitely relevant.
Thanks,
Oded
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
