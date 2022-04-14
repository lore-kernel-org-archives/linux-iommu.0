Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFCBC433EF
	for <iommu@archiver.kernel.org>; Thu, 14 Apr 2022 12:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FA78418D0;
	Thu, 14 Apr 2022 12:49:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JK70X__R2M6m; Thu, 14 Apr 2022 12:49:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 19C5F408F8;
	Thu, 14 Apr 2022 12:49:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE88EC0033;
	Thu, 14 Apr 2022 12:49:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D163C002C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2637840C7E
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:49:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wRwmYcRlbXCV for <iommu@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 12:49:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76B71400D6
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:49:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 243D66203E
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2ECC385AB
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649940586;
 bh=C2Kk6JG6xL+z4XI22pXh4XkU/JyALopXrnZXdcSiBcM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Xa3C4nEoqfvQL8zuDvgpCLQj0Qk/QJEXWk+3W1puxrfxKl7iWROEdmTsWgFJiAtZP
 iYjH2NEKwA6beHxy+6CB5Ywbj6NUeKCzVIJkEdmGpifjMBZtzmv9ceNfnbpv66Ss02
 JOvre9x1D3VpOgEZKeutvcVjO7W2VZ2yoP5Kqxr0gZzxIYyQgaP2HsEyUZewQXBiib
 PHUMnQjLQ3tarSu/SJPPs7PjvAtf/ikEWTC9uT/6QhF4xo9rNTE4mIb1HyMzag2fF4
 x9oqU2+69EiT6904G+8XTJ3q1gmUb3MXkpTf3MCRowyt5phT8F6LStrp2hxw0KTCLY
 ZOZ7AZJwE+54A==
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-2ec04a2ebadso53663187b3.12
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 05:49:46 -0700 (PDT)
X-Gm-Message-State: AOAM532TXRaNQfVnmNN63yRCt8d0lJhwPJjlXU9RR5HTWLGlTa8kFye4
 nzcN8V3vzFR8R4IJWZETQ9JaITdWUGywfsBJb8I=
X-Google-Smtp-Source: ABdhPJwNoPoFyfzZdliodNDCsFHXTluyQSmLzZQoxfspDcuXCQmbBNngdY7NkJvPwUXIL347E5RiBgkrECUaEOYobFE=
X-Received: by 2002:a81:6188:0:b0:2eb:4bd3:9b86 with SMTP id
 v130-20020a816188000000b002eb4bd39b86mr1702227ywb.46.1649940585554; Thu, 14
 Apr 2022 05:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <bec0fe9659f832715295f9895025ee8fd91847f3.1649680490.git.robin.murphy@arm.com>
In-Reply-To: <bec0fe9659f832715295f9895025ee8fd91847f3.1649680490.git.robin.murphy@arm.com>
From: Oded Gabbay <ogabbay@kernel.org>
Date: Thu, 14 Apr 2022 15:49:18 +0300
X-Gmail-Original-Message-ID: <CAFCwf12J8FMen1-nRMnp=fjNEFJdKsGB8qnV_NLYbG9COX3BAQ@mail.gmail.com>
Message-ID: <CAFCwf12J8FMen1-nRMnp=fjNEFJdKsGB8qnV_NLYbG9COX3BAQ@mail.gmail.com>
Subject: Re: [PATCH v2] habanalabs: Stop using iommu_present()
To: Robin Murphy <robin.murphy@arm.com>
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

On Mon, Apr 11, 2022 at 3:36 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device
> we care about. Replace iommu_present() with a more appropriate check.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> v2: Rebase on habanalabs-next
>
>  drivers/misc/habanalabs/common/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
> index 7c4a4d504e4c..a94f01713efd 100644
> --- a/drivers/misc/habanalabs/common/debugfs.c
> +++ b/drivers/misc/habanalabs/common/debugfs.c
> @@ -722,7 +722,7 @@ static int hl_access_mem(struct hl_device *hdev, u64 addr, u64 *val,
>         if (found)
>                 return 0;
>
> -       if (!user_address || iommu_present(&pci_bus_type)) {
> +       if (!user_address || device_iommu_mapped(&hdev->pdev->dev)) {
>                 rc = -EINVAL;
>                 goto err;
>         }
> --
> 2.28.0.dirty
>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Thanks,
Oded
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
