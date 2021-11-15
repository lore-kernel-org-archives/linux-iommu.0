Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967FAC433F5
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 14:10:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E81761C4F
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 14:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E81761C4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07974402BC;
	Mon, 15 Nov 2021 14:10:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JOvughptB-Mw; Mon, 15 Nov 2021 14:10:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EEFA1402C1;
	Mon, 15 Nov 2021 14:10:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD287C001E;
	Mon, 15 Nov 2021 14:10:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3BB8C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 14:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91E64605FC
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 14:10:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FcohMQX7AeEB for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 14:10:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CFD7F605F9
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 14:10:32 +0000 (UTC)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E254B3F1CC
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1636985429;
 bh=pfr1cDNzcAoQOpDJQS2N+lpkCMkGHO9LO6u1gxB8aGM=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=ctNqT7HEX4QQTepOUtE/pPA69s+PbJpIXCDGH07HxDEie0T5HH0oRzR8kidQ3M6Wq
 QxCzGr4xpdId0V5CgDg6TGaydn0dptwB8DWjy6W5aVaLN5kR9WxQOty5ZcNDDbrgdq
 i3nk7+kWfxr2kFTwHB11GU53AjxO+Jq/qugipgE7oEhVwF49j7NnamPisA1Ge6qq67
 i57xPXmHTVru/Y1jfHIubA08VuL8Z08SUbwZVZOgHn2UpZti79IKE6NR0JV9ZwHz/P
 Hkat6arT3SLctNw+X8tbt3sUktB0/wvZTyAC6PeGyNi69LJzLa+zo610LtnlDx+jib
 uWOtb8wIHVNdA==
Received: by mail-lj1-f199.google.com with SMTP id
 g19-20020a2eb5d3000000b00219f21cb32bso3850968ljn.7
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 06:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pfr1cDNzcAoQOpDJQS2N+lpkCMkGHO9LO6u1gxB8aGM=;
 b=6nul4fa7E1dHwyhuUaRbNrnbY4Xxuz6qPddjmFj8rnwuTkrwu0LgHPKEiY4aQBAmq+
 SjsqNPfGEvg8dmurusgC45YlOCFESsAoD6bCQAd4TyIzpi8Cxumzn9c7t360pZtjqi2O
 oJ/Njr9Ui8Qt/UnWg4PQJKXnSK53C0vMwyeraJmZcaji8MNZMrDpbihUQlfr6UUxKGn/
 WLo14fcWVn7FU9D1k6TIeuJkJ9/D7xgCBX5lSsXuS0thCHH+38hPmdnrF0uXXBDx+2OE
 Ye8uz02cgdlJzGhM19ZAjpPm/MnLMvcIE9aaqsvwh4nd7RNpn+1i2BniGI/Cx1gaUzB+
 wrog==
X-Gm-Message-State: AOAM533fx0jrBq/mpRuXO3x02bGbY9WCdUNcA5KmodDVpcFAuoicu3Eo
 ht9wk0wiTiY7LNCJYLhkJRxLP1ECkIyl781+8rDsdCBZYU7bdf8zHersPs2GlPKKE3hr4a18Q0G
 KIphHJ/ROvaldEzSfGYy+eAoPVVTdlN49TvNIKScU9RUNccY=
X-Received: by 2002:a05:6512:20e:: with SMTP id
 a14mr18304388lfo.192.1636985429217; 
 Mon, 15 Nov 2021 06:10:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+mI02/0nQEVJ716rf5CIjp6Bip28AWoCb8f30KO4Aj7CFe5qZ574+bCxyzb4bWi3fMN8Ywg==
X-Received: by 2002:a05:6512:20e:: with SMTP id
 a14mr18304343lfo.192.1636985428995; 
 Mon, 15 Nov 2021 06:10:28 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id p17sm1508215ljm.138.2021.11.15.06.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Nov 2021 06:10:28 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v2] memory: mtk-smi: Fix a null dereference for the ostd
Date: Mon, 15 Nov 2021 15:10:25 +0100
Message-Id: <163698542257.136651.14853548122836494400.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211108082429.15080-1-yong.wu@mediatek.com>
References: <20211108082429.15080-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Cc: anan.sun@mediatek.com, youlin.pei@mediatek.com, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, yi.kuo@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anthony.huang@mediatek.com,
 Will Deacon <will@kernel.org>, Ikjoon Jang <ikjn@chromium.org>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, 8 Nov 2021 16:24:29 +0800, Yong Wu wrote:
> We add the ostd setting for mt8195. It introduces a KE for the
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
> [...]

Applied, thanks!

[1/1] memory: mtk-smi: Fix a null dereference for the ostd
      commit: 8c5ba21c16bd7f8e23b8740dead6eaf164b8caa0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
