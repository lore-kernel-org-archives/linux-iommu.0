Return-Path: <SRS0=5HPr=TQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12EDC04E84
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 06:48:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06952082E
	for <iommu@archiver.kernel.org>; Thu, 16 May 2019 06:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ip+KhnSD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i8Skn8GM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06952082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 591E98E2;
	Thu, 16 May 2019 06:48:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 72C682F
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 06:48:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0F16342D
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 06:48:10 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C806F60CF0; Thu, 16 May 2019 06:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1557989290;
	bh=ZG75f0lAOy1l5nnTA2W31hBIGHC2MtPKNbbEUIh5Wf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ip+KhnSDwqQ6o84dfRIgliZ9j6YSTEa9vIzYvXc943S2AD3mA8aQ+Z0lkcoi/m49p
	7aMiny8cvc23arEec0ailuT7eJKEu+iZqrEv3Uvhpfs7pXfdnVzTNs6zAzJA1zNZs0
	NfoQDxOP6wNxrgjB0i1sbFBmV0CzKI9A98mS5vQo=
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
	[209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D91C60C72
	for <iommu@lists.linux-foundation.org>;
	Thu, 16 May 2019 06:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1557989287;
	bh=ZG75f0lAOy1l5nnTA2W31hBIGHC2MtPKNbbEUIh5Wf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i8Skn8GMp5Ca9Xq4RekrA/tI7vqbQdhgnWOmKSuIrmQ1hdYfYfUDwAIyRZea+9d+G
	WUE6mX2GhMtI+iPujURAFxvOvZfEuvFPjDKiHlJCif+q4kZ70YgN4D9tX1B83SWBW5
	/EQyE2vOidCqzDcB15dYsgku1yKEywtYvDOrkzVU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D91C60C72
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f43.google.com with SMTP id p26so3625853edr.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 15 May 2019 23:48:06 -0700 (PDT)
X-Gm-Message-State: APjAAAWjOFW1FG94Gn3kEYgSrnj7TPHadp1vvpy8zu7BJLVIOJSgWbcy
	ThnuZxqeo9/7dk8o+UMGrzSkVvzojSUYsIrGpnQ=
X-Google-Smtp-Source: APXvYqwE4sv9OWAdotkgId+uAs3Ngm4nCDGeM/ygr0LbOzm5ahsK2cp4+ig58+Nr8zmvRko1JQyh3Xh0k05F1GQXZQg=
X-Received: by 2002:a50:94db:: with SMTP id t27mr1721377eda.173.1557989284710; 
	Wed, 15 May 2019 23:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190515233234.22990-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190515233234.22990-1-bjorn.andersson@linaro.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Thu, 16 May 2019 12:17:53 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEMQd1uAWdkLysYWt0et8eRojoivG6+e78y0DU+4=H+_g@mail.gmail.com>
Message-ID: <CAFp+6iEMQd1uAWdkLysYWt0et8eRojoivG6+e78y0DU+4=H+_g@mail.gmail.com>
Subject: Re: [PATCH] iommu: io-pgtable: Support non-coherent page tables
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Vivek Gautam <vgautam@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Thu, May 16, 2019 at 5:03 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> Describe the memory related to page table walks as non-cachable for iommu
> instances that are not DMA coherent.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 4e21efbc4459..68ff22ffd2cb 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -803,9 +803,15 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>                 return NULL;
>
>         /* TCR */
> -       reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> -             (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> -             (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> +       if (cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA) {
> +               reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> +                     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT) |
> +                     (ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT);
> +       } else {
> +               reg = (ARM_LPAE_TCR_SH_IS << ARM_LPAE_TCR_SH0_SHIFT) |
> +                     (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT) |
> +                     (ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT);
> +       }

This looks okay to me based on the discussion that we had on a similar
patch that I
posted. So,
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

[1] https://lore.kernel.org/patchwork/patch/1032939/

Thanks & regards
Vivek

>
>         switch (ARM_LPAE_GRANULE(data)) {
>         case SZ_4K:
> --
> 2.18.0
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
