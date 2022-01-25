Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D72C433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 16:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29E9560B0C;
	Tue, 25 Jan 2022 16:56:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AsPXvKXBL9jN; Tue, 25 Jan 2022 16:56:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0989660807;
	Tue, 25 Jan 2022 16:56:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4D88C0031;
	Tue, 25 Jan 2022 16:56:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CF7EC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 16:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84EC482890
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 16:56:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xv3U82kEMJFI for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 16:56:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 116BE827CE
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 16:56:16 +0000 (UTC)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 53D053F1C4
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1643129774;
 bh=5eYae9BZCoH9A4LgUvrM4idND+AMgsOC/mtccDlQNMY=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=g+ed2Wu2MHE6j33NttKTnYQAUHXYukbYhaFr+iu0TOew/PLr4caAoRfBKRo5EAszf
 GWqyBP4n4+iOvXGBfu8yYWFMv70siAVddt8icHy+FRaH4oC3kSfjZf9NPZ8UVIOdVu
 /nwZIZGlurs4uhj/ZOhgzZbmeDFkoUdXpoS00AIl5H+Zp66gpqTcMXYgTjbaUtAG2+
 77xAkuXlvUWJv92fr/zpmeIy5BzUCfMpS5n27ROd6YfzrnyMXUjO2KbfGoBH1jgT0M
 tGKKmpOz8L43MAhnEVzGlFCsofRhePz7IyW3EuK8gO+F98WGBpdV5SSuZgnFinm5u5
 augWlT724hFtA==
Received: by mail-wr1-f72.google.com with SMTP id
 k12-20020adfe3cc000000b001d6806dfde1so3313600wrm.16
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 08:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5eYae9BZCoH9A4LgUvrM4idND+AMgsOC/mtccDlQNMY=;
 b=PBM0N9427NykV+H5GXIsY/Pek5FS/k07iLP+CfhApNuKiTzsO8YkxJ+2+WNyJ3bkW2
 IUzX3aZ0VCnuO6qdxUIl6N9yJr/m6061I/KXPbQ89579uswue//ULABgzJQURCo/N+aE
 wicnsbzsxXlAFS62gkNg+Bfalf9D0JXS5QputbFtkZRxN6K/3vFQsg2Lk8yRbyCz8U66
 6irXD2RUUmwTinGeJRAHzJ0oAlLgzIBSRt1EHuDfLUnBfGEJse5NYXuaoog+vhGsq6Xy
 O6rWo+xem2zANolV4I89u8V8+MadCkIdTZb6MLK4U/9ezSIu75OfVncdvBQppz5opseH
 ikfg==
X-Gm-Message-State: AOAM532xh/8+FXGog2Xk27ZVlSqEk1g7+i1vh9Z3dKAQF7LpACDGvTf7
 h0a43g6qWYUbjGNuoNbAm9+n1xZEXgUWbCrNaNmm4lfhRnZjBjo9zxM98gM1DK62vvFrr0a7dcQ
 Be2wDnyi7Fedl/4OazJsbvrTKDnOd7GaCI9jgCkT3dYj94X4=
X-Received: by 2002:a05:6000:1447:: with SMTP id
 v7mr19423992wrx.492.1643129773875; 
 Tue, 25 Jan 2022 08:56:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyl6s7vxqqP7feCQXJb4rhGDy+l7w2eRsOoKxYvFlhqNY7yJ2EtAmgMJCoih+WZhX4X2VwszQ==
X-Received: by 2002:a05:6000:1447:: with SMTP id
 v7mr19423977wrx.492.1643129773650; 
 Tue, 25 Jan 2022 08:56:13 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch.
 [188.155.168.84])
 by smtp.gmail.com with ESMTPSA id o15sm1058724wms.9.2022.01.25.08.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 08:56:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 0/7] MT8186 SMI SUPPORT
Date: Tue, 25 Jan 2022 17:55:38 +0100
Message-Id: <164312972455.77587.5523685649094227634.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220113111057.29918-1-yong.wu@mediatek.com>
References: <20220113111057.29918-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Cc: anan.sun@mediatek.com, youlin.pei@mediatek.com, srv_heupstream@mediatek.com,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, lc.kan@mediatek.com,
 anthony.huang@mediatek.com, yi.kuo@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Thu, 13 Jan 2022 19:10:50 +0800, Yong Wu wrote:
> This patchset adds mt8186 smi support.
> mainly adds a sleep control function.
> 
> Change note:
> v3: a) Add a new binding patch for renaming "clock" to "clocks".
>     b) Reword the title for the binding patches, more detailed.
>     c) Add the sleep control error path: if err, return directly.
>        also change the log from dev_warn to dev_err.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: memory: mtk-smi: Rename clock to clocks
      commit: 5bf7fa48374eafe29dbb30448a0b0c083853583f
[2/7] dt-bindings: memory: mtk-smi: No need mediatek,larb-id for mt8167
      commit: ddc3a324889686ec9b358de20fdeec0d2668c7a8
[3/7] dt-bindings: memory: mtk-smi: Correct minItems to 2 for the gals clocks
      commit: 996ebc0e332bfb3091395f9bd286d8349a57be62
[4/7] dt-bindings: memory: mediatek: Add mt8186 support
      commit: 6d86f23c35fe7b479ceef4d3f1eef925996945fd
[5/7] memory: mtk-smi: Fix the return value for clk_bulk_prepare_enable
      commit: a6945f4566d4f77a4054720f6649ff921fe1ae64
[6/7] memory: mtk-smi: Add sleep ctrl function
      commit: 8956500e5d5bf541a945299999b0bf4866dc0daf
[7/7] memory: mtk-smi: mt8186: Add smi support
      commit: 86a010bfc73983aa8cd914f1e5f73962b0406678

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
