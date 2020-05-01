Return-Path: <SRS0=bJ3n=6P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13DDC4724C
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 14:41:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CD320708
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 14:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSkRbiye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CD320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6C56225AA6;
	Fri,  1 May 2020 14:41:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XrrHAJWVWM6L; Fri,  1 May 2020 14:41:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F3E67221A9;
	Fri,  1 May 2020 14:41:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0D58C0864;
	Fri,  1 May 2020 14:41:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6746AC016F
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 14:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 55ECD25AA6
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 14:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mZni1lu+UyHy for <iommu@lists.linux-foundation.org>;
 Fri,  1 May 2020 14:41:34 +0000 (UTC)
X-Greylist: delayed 00:06:44 by SQLgrey-1.7.6
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com
 [209.85.217.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 405C1221A9
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 14:41:34 +0000 (UTC)
Received: by mail-vs1-f67.google.com with SMTP id g2so6388845vsb.4
 for <iommu@lists.linux-foundation.org>; Fri, 01 May 2020 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OafIZu0wl5yq5qjn+apPMv+CXZqAeKvj/lS9W7KUmfg=;
 b=bSkRbiyeyKlAUXC/Tij0LYdPA/GCDrTqy+eOsvg+0HMnmGzomgcFgIZwMrkFKKVTFx
 rY8tpU0oqwWB6Dgr1WBXsWo+XG8OHxSQyZFNutZh6UJLWPxJ5JTiiUQc32rVT9J+WYwK
 FlXoxI2nbxZJsuVKCqKMo1d+Br/kZKZFVpkOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OafIZu0wl5yq5qjn+apPMv+CXZqAeKvj/lS9W7KUmfg=;
 b=lbB9U13AKjCen9hSIgXQQUqDPQlxzoO0dr6x51wt5mLjIedPB+FoIQ0UnnYQrfXIrT
 QpkiT3V3bEGgYPpFC86tdP4s1Nhj6MWs8DpySJ8BWki4ejLf0P890zAE6c6BfPLW7myt
 tYk2M0RAC6VXiWcXEhj2hvoJiN3SJkHtFZufO2gu0HBKFzHDSfyr5hNr1Ejx0OEAIAwl
 juVov2VDj/jTWtc9SpY5IjQjQWidaY3TgmguD7oCHXd08x1QuTSdt450v65sRi/Su1i2
 nhZpjDtqwHQfAUcefSs4S1fXkkJpry8mHkaYlNkj2S12LIr/QwJmIas88gCkD0HXQK4u
 IZqA==
X-Gm-Message-State: AGi0PuazTmn8qhzl0tSrqO6djYMSZRnq270xX6OCBvKZJTYcds6zjckl
 GC4KxGLG94qms97dUeQvA3kazrXN5xY=
X-Google-Smtp-Source: APiQypLzLbi7tSSbeeCcVMQGwfVPLbKkBFPB5fTpZUqWKJZjIyK8GMEcmwzwXhRzFiTDK5SICDxMrg==
X-Received: by 2002:a67:b107:: with SMTP id w7mr3286118vsl.231.1588343688829; 
 Fri, 01 May 2020 07:34:48 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com.
 [209.85.222.42])
 by smtp.gmail.com with ESMTPSA id x6sm842833vkx.1.2020.05.01.07.34.48
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 07:34:48 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id 36so3766447uaf.9
 for <iommu@lists.linux-foundation.org>; Fri, 01 May 2020 07:34:48 -0700 (PDT)
X-Received: by 2002:ab0:b13:: with SMTP id b19mr3050483uak.91.1588343683637;
 Fri, 01 May 2020 07:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <1588329036-18732-1-git-send-email-smasetty@codeaurora.org>
 <1588329036-18732-2-git-send-email-smasetty@codeaurora.org>
In-Reply-To: <1588329036-18732-2-git-send-email-smasetty@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 1 May 2020 07:34:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X76J9FAwtx4-8pjEkEqSo=2rz4Wv2ZR6c1Zps21b1E7w@mail.gmail.com>
Message-ID: <CAD=FV=X76J9FAwtx4-8pjEkEqSo=2rz4Wv2ZR6c1Zps21b1E7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm-smmu: Add sc7180 compatible string
To: Sharat Masetty <smasetty@codeaurora.org>
Cc: freedreno <freedreno@lists.freedesktop.org>, Will Deacon <will@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Matthias Kaehlcke <mka@chromium.org>, dri-devel@freedesktop.org,
 Robin Murphy <robin.murphy@arm.com>
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

Hi,

On Fri, May 1, 2020 at 3:30 AM Sharat Masetty <smasetty@codeaurora.org> wrote:
>
> This patch simply adds a new compatible string for SC7180 platform.
>
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
