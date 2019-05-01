Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFD8C43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 20:09:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9484920578
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 20:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9484920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 364AD2B70;
	Wed,  1 May 2019 20:09:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CD2C12B69
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 20:08:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
	[209.85.167.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 997B0775
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 20:08:51 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id k9so11648033oig.9
	for <iommu@lists.linux-foundation.org>;
	Wed, 01 May 2019 13:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=MhhNnHbahaGD1ttZfVO4EhM/RU7xN3mKfU+xr7R87yk=;
	b=ZdtqPw1fxB1HTEb1JeguNfaFPnHUJNp2WJ0s++mLq7JC+D0XlXfheun3FhBiuJvu6D
	opQLsKqqSqV7r5zzbAq77kT2Kuk04ysxsviXkmq/Xo26AvZvR1fKpKhqn7zR+WVrC8rq
	1stCbw1NYc6rahiK02FePEUTtjT/f+xiqqNWsQowXJf1fyJBjpk5PzI1I5u+5eAt8VIq
	mnImK9HFHyWOBp5q1ZMtIAucO78ZM0KO7ptVI9e2E4mT6RpcckrZeoJdO+TR1tVHmvYq
	yOMkHtFZ50yIwOb0yw31J4j5gwXxbWuZE13PEYKYSsDhlIH5hm8vxIMNhw06Zc45c71H
	8Whg==
X-Gm-Message-State: APjAAAUoPGM11PRAJiQNk/ZPsRX0qbH5NFvGdfhnLNXLGPPaIjioEqJp
	I+aWNeC8aZZPkv/N6RuZk4ZVCmc6PUE=
X-Google-Smtp-Source: APXvYqxxuBA+o/64bKbtn57dSkxXX2vMf2mMb9X9x4kDh8mXMqhhKIy0U8bzwseST8HiVrailiyFow==
X-Received: by 2002:aca:dcc4:: with SMTP id t187mr71236oig.3.1556741330399;
	Wed, 01 May 2019 13:08:50 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com.
	[209.85.167.182])
	by smtp.gmail.com with ESMTPSA id o11sm55178oti.69.2019.05.01.13.08.49
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 13:08:49 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id k9so11647992oig.9
	for <iommu@lists.linux-foundation.org>;
	Wed, 01 May 2019 13:08:49 -0700 (PDT)
X-Received: by 2002:aca:4e83:: with SMTP id c125mr62690oib.13.1556741329634;
	Wed, 01 May 2019 13:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com>
	<20190427071031.6563-2-laurentiu.tudor@nxp.com>
In-Reply-To: <20190427071031.6563-2-laurentiu.tudor@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 1 May 2019 15:08:38 -0500
X-Gmail-Original-Message-ID: <CADRPPNRGxEz_YXhzrJPCZrz_Xc-9Fh21tgbjERoOazMMQmiVbA@mail.gmail.com>
Message-ID:
 <CADRPPNRGxEz_YXhzrJPCZrz_Xc-9Fh21tgbjERoOazMMQmiVbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] soc/fsl/qman: fixup liodns only on ppc targets
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: madalin.bucur@nxp.com, Netdev <netdev@vger.kernel.org>,
	Roy Pledge <roy.pledge@nxp.com>, lkml <linux-kernel@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>, camelia.groza@nxp.com,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Miller <davem@davemloft.net>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190501200838.8gv41fv2AKcvhKFBB1N_qAUUgKmTz68KfCcybLGX_-A@z>

On Sat, Apr 27, 2019 at 2:14 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> ARM SoCs use SMMU so the liodn fixup done in the qman driver is no
> longer making sense and it also breaks the ICID settings inherited
> from u-boot. Do the fixups only for PPC targets.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Applied for next.  Thanks.

Leo
> ---
>  drivers/soc/fsl/qbman/qman_ccsr.c | 2 +-
>  drivers/soc/fsl/qbman/qman_priv.h | 9 ++++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index 109b38de3176..a6bb43007d03 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -596,7 +596,7 @@ static int qman_init_ccsr(struct device *dev)
>  }
>
>  #define LIO_CFG_LIODN_MASK 0x0fff0000
> -void qman_liodn_fixup(u16 channel)
> +void __qman_liodn_fixup(u16 channel)
>  {
>         static int done;
>         static u32 liodn_offset;
> diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman_priv.h
> index 75a8f905f8f7..04515718cfd9 100644
> --- a/drivers/soc/fsl/qbman/qman_priv.h
> +++ b/drivers/soc/fsl/qbman/qman_priv.h
> @@ -193,7 +193,14 @@ extern struct gen_pool *qm_cgralloc; /* CGR ID allocator */
>  u32 qm_get_pools_sdqcr(void);
>
>  int qman_wq_alloc(void);
> -void qman_liodn_fixup(u16 channel);
> +#ifdef CONFIG_FSL_PAMU
> +#define qman_liodn_fixup __qman_liodn_fixup
> +#else
> +static inline void qman_liodn_fixup(u16 channel)
> +{
> +}
> +#endif
> +void __qman_liodn_fixup(u16 channel);
>  void qman_set_sdest(u16 channel, unsigned int cpu_idx);
>
>  struct qman_portal *qman_create_affine_portal(
> --
> 2.17.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
