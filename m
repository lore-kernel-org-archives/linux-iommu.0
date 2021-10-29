Return-Path: <SRS0=EsFc=PR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35064C433EF
	for <iommu@archiver.kernel.org>; Fri, 29 Oct 2021 17:35:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B1660FF2
	for <iommu@archiver.kernel.org>; Fri, 29 Oct 2021 17:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1B1660FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63D6280F3F;
	Fri, 29 Oct 2021 17:35:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GKkin8hKXnCk; Fri, 29 Oct 2021 17:35:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2884380E1F;
	Fri, 29 Oct 2021 17:35:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5F6AC001E;
	Fri, 29 Oct 2021 17:35:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 152BFC0012
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 17:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01900401E5
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 17:35:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ONyYRXHg07QF for <iommu@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 17:35:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F193340146
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 17:35:53 +0000 (UTC)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 757A43F17A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1635528948;
 bh=jvV6mA1s9hOJyCsNlRY4ar4PhiLrM2nEHfaCHa+wtwI=;
 h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
 In-Reply-To:Content-Type;
 b=TRysrsLPHcqxR7esUa3LCDjvbaubjeiqZ6WhCEwJ6BQ0wKTOSPvgk5KTWdWLkTIXB
 7uMoJCNebomP1t9ULSm65wxOAl3Iv0QSNXCZ1bWzpUrDozA5sHBsgEHmbWnPdIIGHx
 T7xxE/+Prs6cNpEyp0d7fyaXNYJl3Cs0UkGwaqhgFSQeP9FtTqz18Puk/6kGMvIJh+
 mvWqfm+wDECuVmtbTPFN4FiXhCYkRLcvL+wfo1F70V0c6QX76082i7VMtqPW7Hf68y
 8/PuD0wHANpL4+2eqErNbYKdxUqrc8z5D0pBtnVd7hWwtQhv09rPXEZFhR8wNHowNB
 A+nvVjjcDXd9w==
Received: by mail-lf1-f70.google.com with SMTP id
 b12-20020a0565120b8c00b003ffa7050931so4333779lfv.13
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 10:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jvV6mA1s9hOJyCsNlRY4ar4PhiLrM2nEHfaCHa+wtwI=;
 b=rl3z2DFLgjIdhR1o+EwrQyVpnoABNgEjsDbFGKt6e1JqOlZlltgGCBa1nFEj6m3Uo8
 CaeIvFCVYikX2fG4z3EQgp1DaDjGU3IgGixPvHZuSiGAUa1nN5RxliB28QO9sW0xKMPc
 2apWKol0ZV3+1THmzzV5UDuFu0XMLJ0r3t3PIGugXd9fNrMcXXCa+6Ll/YTtvkLMjicI
 s3B+spiiNXJAOG2Jp+EtCrKlgUwWrdDsKNDa5OSj5UVV8vvKdV4lIDzcLKXb3Xu8oaTv
 QtACR6OP8ByrvOsE/HO1LCCUEMCSF8CaG0MWHSh2fM1KkwgnmLSqdaJWbfP92XhrwUf5
 C9gQ==
X-Gm-Message-State: AOAM531v273ztLjHegH14IzwSo9n3dNstUCQbH99tytH1wVHLbjZeWfx
 L4YhuYt2FmJMXjHrhVudku5JrpF0vv0V9tpvr0f5ziFCdjZzVsTCuBZfTprwZ+a9nJrVV6oCvJH
 YpC4Fr6V+QrVGgDb4V0ul6/pn9XrpefAVY8scUSznHL13FRg=
X-Received: by 2002:a2e:7617:: with SMTP id r23mr12947343ljc.187.1635528947763; 
 Fri, 29 Oct 2021 10:35:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBv6+kvbnDwAjjNuXfYL+0ezjFAhs3r2BkTi8MNivnnR7id+AwsxbYbbuG2Mbqzl68kUEMrA==
X-Received: by 2002:a2e:7617:: with SMTP id r23mr12947326ljc.187.1635528947569; 
 Fri, 29 Oct 2021 10:35:47 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id s4sm182963lfi.180.2021.10.29.10.35.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Oct 2021 10:35:47 -0700 (PDT)
Subject: Re: [PATCH] memory: mtk-smi: Fix a null dereference for the ostd
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20211028055056.26378-1-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <23b036d1-bdc4-da55-a800-03fc3dabd48e@canonical.com>
Date: Fri, 29 Oct 2021 19:35:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028055056.26378-1-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, anthony.huang@mediatek.com,
 yi.kuo@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 Ikjoon Jang <ikjn@chromium.org>, linux-arm-kernel@lists.infradead.org
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

On 28/10/2021 07:50, Yong Wu wrote:
> We add the ostd setting for mt8195. It introduces a abort for the
> previous SoC which doesn't have ostd setting. This is the log:
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000080
> ...
> pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
> lr : mtk_smi_larb_resume+0x54/0x98
> ...
> Call trace:
>  mtk_smi_larb_config_port_gen2_general+0x64/0x130
>  pm_generic_runtime_resume+0x2c/0x48
>  __genpd_runtime_resume+0x30/0xa8
>  genpd_runtime_resume+0x94/0x2c8
>  __rpm_callback+0x44/0x150
>  rpm_callback+0x6c/0x78
>  rpm_resume+0x310/0x558
>  __pm_runtime_resume+0x3c/0x88
> 
> In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
> if "larb->larb_gen->ostd" is null, the "larbostd" is the offset, it is
> also a valid value, thus, use the larb->larb_gen->ostd as the condition
> inside the "for" loop.

You need to write more clearly, what you are fixing here.

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Hi Krzysztof,
> Could you help review and conside this as a fix for the mt8195 patchset?
> The mt8195 patchset are not in mainline, thus, I don't know its sha-id,
> and don't add Fixes tag.
> Thanks
> ---
>  drivers/memory/mtk-smi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b883dcc0bbfa..0262a59a2d6e 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -257,7 +257,7 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
>  	if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_SW_FLAG))
>  		writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base + SMI_LARB_SW_FLAG);
>  
> -	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd && !!larbostd[i]; i++)
> +	for (i = 0; i < SMI_LARB_PORT_NR_MAX && larb->larb_gen->ostd && !!larbostd[i]; i++)
>  		writel_relaxed(larbostd[i], larb->base + SMI_LARB_OSTDL_PORTx(i));

The code does not look good. You have already a dereference at line 244:

	const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];

You are not fixing the NULL pointer dereference.

>  
>  	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> 


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
