Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C02AC2D0F2
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 22:11:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCFD206CC
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 22:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCFD206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D2B45866A7;
	Mon, 30 Mar 2020 22:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HA7e6U3sSExr; Mon, 30 Mar 2020 22:11:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3D16C8666C;
	Mon, 30 Mar 2020 22:11:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B7E2C1AE8;
	Mon, 30 Mar 2020 22:11:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A3BAC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 22:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 86F4888176
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 22:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W1h03mpy1Mvc for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 22:11:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 12B3888168
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 22:11:12 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id n13so10164285ilm.5
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 15:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Gej1ukEzef5kQg6YLiAXZ8FMZy3ON+jYs0LTpdTxAeY=;
 b=TZbFKCD183Hp6m74nO5x3tqQpqgVP3H0pBp0Cg0HeRwxcnfxGsR96lPO6oNqEiLouB
 i96yzYL/9DrCuWniDC2tezfRbBRAvYvqLhUfG7TyD8MsPjzwRg2W3IrOZWe58jVwzVT7
 rvOLiRUBEzllnfvnYH+OZr5AFnjUbF3mM2nSMfG7ECiq6AUTbspxWiTXGz9SpsVHUDNI
 B6KN0Y0wSajVD8pkXcc/f9EckQsbDDkKJ3xaYgTWP+bC6xYcIcIy+rFRXaeoIymJdGtc
 4Xj/A+79rZipMC8Yv9cNEXiF+vuUYkUjNEPrrz1yoUuojjOK3sRuPQrPDMs69ZrkAP0J
 mADw==
X-Gm-Message-State: ANhLgQ1OPFjOT/MlcjARASc1LEQ9EmfgprUhpcL+QohkXIqMI5IhcbXw
 cTo/8G8AoT4gmP7HukITJw==
X-Google-Smtp-Source: ADFU+vseMwBWRiWNnvqHDls55gkMPjZLcdFN53VAHUJfvtwLdCe+R59lZx97hWKbGwQtot2UEN0jmg==
X-Received: by 2002:a92:7a0d:: with SMTP id v13mr14199608ilc.175.1585606271334; 
 Mon, 30 Mar 2020 15:11:11 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
 by smtp.gmail.com with ESMTPSA id z20sm4498542ioj.4.2020.03.30.15.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 15:11:09 -0700 (PDT)
Received: (nullmailer pid 17820 invoked by uid 1000);
 Mon, 30 Mar 2020 22:11:06 -0000
Date: Mon, 30 Mar 2020 16:11:06 -0600
From: Rob Herring <robh@kernel.org>
To: Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: remoteproc: qcom: Add iommus property
Message-ID: <20200330221106.GA17769@bogus>
References: <20200317150910.26053-1-sibis@codeaurora.org>
 <20200317150910.26053-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200317150910.26053-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ohad@wizery.com, devicetree@vger.kernel.org, dianders@chromium.org,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, agross@kernel.org,
 robin.murphy@arm.com, Sibi Sankar <sibis@codeaurora.org>
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

On Tue, 17 Mar 2020 20:39:08 +0530, Sibi Sankar wrote:
> Add iommus property to allow Q6 modem to boot on platforms which do
> not have trustZone.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
