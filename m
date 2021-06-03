Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B29AC47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 19:51:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7EE613F9
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 19:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7EE613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B273401C7;
	Thu,  3 Jun 2021 19:51:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HaO0i0dwbhD0; Thu,  3 Jun 2021 19:51:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D0A940001;
	Thu,  3 Jun 2021 19:51:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72CABC000E;
	Thu,  3 Jun 2021 19:51:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD24FC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 19:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B94434010C
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 19:51:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id No3_4qgOkQsc for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 19:51:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB71B40001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 19:51:28 +0000 (UTC)
Received: from mail-ej1-f71.google.com ([209.85.218.71])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lotNH-0007IR-25
 for iommu@lists.linux-foundation.org; Thu, 03 Jun 2021 19:51:27 +0000
Received: by mail-ej1-f71.google.com with SMTP id
 eb10-20020a170907280ab02903d65bd14481so2333773ejc.21
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 12:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vJZ+G8sCfXxUci2WJeauNczN90DwVJP1oUWm75cpx6c=;
 b=B7iD1N11ObBkuQuGIdtOvpxTo2Mnu1DN+I3oFSBNASQF4YiNUBfWMxF0nyMogpyGfr
 1QhQ91rvYxmEOW/0IklPCKkj0F8Pss3dGtSrQkormtC+hls+nu54Seq+FSn8gVEJC7mN
 zXPAN1h3ERO4D+/nX9CKmSmsEHC4CrwAWZNSJ95JqUzvJuHEsYezXA9lJe0BWDbpvpiY
 GADWZiSKhm39UYgrEUopB3RYMt6U81SnnAvYNwZI/7dxX2KxelpAjNBRHZxUWmuqFUyg
 Ws12oxJro/rhNhjw7m5VxV70ytndpopBlwhIkChqtjegl8ZRo5h/nDlBmYR5VDPv4Xo1
 /u+A==
X-Gm-Message-State: AOAM5300uzd61fBGZ/OvuLVRDMjUtARSJ6cc/EUyz42l1yQZY2l9RXun
 hrdXPCzcabSGM+yUyRrE2q6nX+i9dT587khNlyrRFUmC6xwQiphgeVGIQ197vNt0ZW+cdeg2KBB
 ZfbT32mEJGskbNh0UI0JMY8f4zDpFoYcQSA1YN0Ezt2b0Wz8=
X-Received: by 2002:aa7:c450:: with SMTP id n16mr1062127edr.386.1622749886848; 
 Thu, 03 Jun 2021 12:51:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5tmDUGs4U6g+UPVgs3XLfovlFqRM0G4ESDQqLS/sOG1jvSmsdXwNULc9nDt6jQqOsdsnYUA==
X-Received: by 2002:aa7:c450:: with SMTP id n16mr1062113edr.386.1622749886743; 
 Thu, 03 Jun 2021 12:51:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch.
 [188.155.185.9])
 by smtp.gmail.com with ESMTPSA id n15sm2185505eds.28.2021.06.03.12.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 12:51:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>
Subject: Re: (subset) [PATCH v3 0/9] arm64: tegra: Prevent early SMMU faults
Date: Thu,  3 Jun 2021 21:51:22 +0200
Message-Id: <162274987317.22918.7304733660172079088.b4-ty@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210603164632.1000458-1-thierry.reding@gmail.com>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Jon Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, 3 Jun 2021 18:46:23 +0200, Thierry Reding wrote:
> this is a set of patches that is the result of earlier discussions
> regarding early identity mappings that are needed to avoid SMMU faults
> during early boot.
> 
> The goal here is to avoid early identity mappings altogether and instead
> postpone the need for the identity mappings to when devices are attached
> to the SMMU. This works by making the SMMU driver coordinate with the
> memory controller driver on when to start enforcing SMMU translations.
> This makes Tegra behave in a more standard way and pushes the code to
> deal with the Tegra-specific programming into the NVIDIA SMMU
> implementation.
> 
> [...]

Applied, thanks!

[1/9] memory: tegra: Implement SID override programming
      commit: 393d66fd2cacba3e6aa95d7bb38790bfb7b1cc3a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
