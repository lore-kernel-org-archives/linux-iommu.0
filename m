Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449F9C433EF
	for <iommu@archiver.kernel.org>; Sun,  3 Jul 2022 03:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0BAC4022C;
	Sun,  3 Jul 2022 03:57:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0BAC4022C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sg0Mf81A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hp2h5omfF7QJ; Sun,  3 Jul 2022 03:57:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 804704002B;
	Sun,  3 Jul 2022 03:57:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 804704002B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43D3DC0032;
	Sun,  3 Jul 2022 03:57:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD412C002D
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 03:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F168400D6
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 03:57:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F168400D6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3NM8uFjPT1-k for <iommu@lists.linux-foundation.org>;
 Sun,  3 Jul 2022 03:57:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8444D4002B
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8444D4002B
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 03:57:14 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-101dc639636so8835494fac.6
 for <iommu@lists.linux-foundation.org>; Sat, 02 Jul 2022 20:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8pyUyqVKFfsPns6kkRYcl2oPKrKQVySYYiE4xgpYN7k=;
 b=sg0Mf81AA/jHMB1Cnn1hgvmo9Je2PEjby6cq8FtWMppDV0dwTUm//kJBHbv8pR4BwB
 j/FtBj4e+TRgW0b8LLpE75Wl/UfDgN709J3WOsfkzkGqFrIy564VLTVlm0+sHgOW5DKX
 MSChhovfWwB/MwOeg3N7teweUFs8YJabN58sYDuRd6ZkoX14s1xq1HxH6K3VyF0Bwjry
 i+veKmfxr+3s/KqsXC6tv8EpMERmtrqerMQkdN72RjBqsfbB4eGnIPTLngTx4y1hItZk
 pcd18M4XQ7uT8kIY6cHEz++jthJoe+kJSmxLt8i7cpOKc53OBfjFf7+CQSb5Ufla3+Re
 QOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8pyUyqVKFfsPns6kkRYcl2oPKrKQVySYYiE4xgpYN7k=;
 b=JEG8g6ZcfQTOrpgxXdaAdZafucQjUWVS0G8q79AFxmdN0z+nPf8BlWedCP7WSziots
 1xvPcRKtFOWQglMv9SvPqLygFAi/+5xFlHEeZcpuaFbgzYMrvAkw/KARw4od6e68f1im
 j0NM6zFasGp5ViptkJ6RZXGLy6Wd3t3utnMR6pyZe5L2cbK6WjiiXLzF3RFVNU6NwA6W
 F+YtR5SVC3CICUQVCvRkYQZ9LUyYI768dueRGmKDFLYLk9p6AZNP1ShKz0IDhUt8uuOy
 UorWrlKnBSQCudtWwHIz2zna1N9yKInLr/kOiGGN62mi9nJs6daAGe4e/flUTrS1n+qD
 CdSA==
X-Gm-Message-State: AJIora+JacB8/4/diMH/NyZ7pky17Zjv28nv0y1KDp6yJ+srUg4LbNGg
 +kpThHN0XMXkYzNk3C+7y+GVKQ==
X-Google-Smtp-Source: AGRyM1uiElpgE5xH020B9DsxznQsQNmrJaanTne9n2tfx5H6+oy7R6pbP02jWzluWtfowxz9M4K1wQ==
X-Received: by 2002:a05:6870:8292:b0:101:c67e:1b4d with SMTP id
 q18-20020a056870829200b00101c67e1b4dmr14586983oae.88.1656820633300; 
 Sat, 02 Jul 2022 20:57:13 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186]) by smtp.gmail.com with ESMTPSA id
 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Jul 2022 20:57:12 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
 Jordan Crouse <jcrouse@codeaurora.org>, Emma Anholt <emma@anholt.net>,
 freedreno@lists.freedesktop.org
Subject: Re: (subset) [PATCH 2/2] arm64: dts: qcom: sm8250: Enable per-process
 page tables.
Date: Sat,  2 Jul 2022 22:56:09 -0500
Message-Id: <165682055971.445910.5959383973914812219.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220614230136.3726047-2-emma@anholt.net>
References: <20220614230136.3726047-1-emma@anholt.net>
 <20220614230136.3726047-2-emma@anholt.net>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

On Tue, 14 Jun 2022 16:01:36 -0700, Emma Anholt wrote:
> This is an SMMU for the adreno gpu, and adding this compatible lets
> the driver use per-fd page tables, which are required for security
> between GPU clients.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sm8250: Enable per-process page tables.
      commit: 213d7368723709cf4567488e63dd667802378202

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
