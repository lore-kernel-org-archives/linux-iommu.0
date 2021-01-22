Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9756DC433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 21:31:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E321F23AF8
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 21:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E321F23AF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 75A2686AE2;
	Fri, 22 Jan 2021 21:31:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Jsuvy8pyTXX; Fri, 22 Jan 2021 21:31:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EAA6786AD3;
	Fri, 22 Jan 2021 21:31:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE456C08A1;
	Fri, 22 Jan 2021 21:31:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA2CEC013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 21:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B04CA87221
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 21:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ex6E1x2ByYsg for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 21:31:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 730EC8720D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 21:31:49 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id d22so8217582edy.1
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xKbz4bexTx7l/78Slh9DnlQKMn+C9Oab3FDAuPgpk2E=;
 b=XCdtNxqyh3psqYQw/BilKtLOpnB3xvrWUqGI+lLOHlOiJGL8PH5z+0lEAkRHOj+DfT
 T4ZWnYf3xp91IBfBjvqjRxYgPv8U3X1eK9/dIymqOv+pQ9WgD5W8FchvBRuUAhBvjD/0
 jpNQ0iwoMbJ7+5KRWonPpadW58/IFtNFdQmam11WzdRdtM6v6CJhMderZ8oDlM2/qU70
 jDTg9x+xSp9eIVM91fgvNZrF3rGfS/B69mVfAZfi6rRaZm1PIe9NPs+iCDERo7w44KvU
 nEIsB+or5oekq3x7D/5oAdDPxMOQxrhD3fRojHAbkP9BRQkXshpdprFJjMz1w1hQ+rTT
 Y28A==
X-Gm-Message-State: AOAM533Q/J5VFAToOVayoHUuy8zb73ak7kFfTUeXuW5wuyN1nG+Y64g5
 kcjvtOU36llGNjWwrUqjcE4=
X-Google-Smtp-Source: ABdhPJxXm/UbYQOfzbAmGUe58u7tjks2ZQmC4I68zUxUVhfyqoVwnv72PHYQdHbTCixwPsYtg2RNUA==
X-Received: by 2002:a50:934a:: with SMTP id n10mr4681152eda.26.1611351107962; 
 Fri, 22 Jan 2021 13:31:47 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id qh13sm5216877ejb.33.2021.01.22.13.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 13:31:47 -0800 (PST)
Date: Fri, 22 Jan 2021 22:31:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 1/3] memory: mtk-smi: Use platform_register_drivers
Message-ID: <20210122213145.ampvsg4egk7yiz55@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210121062429.26504-2-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 yi.kuo@mediatek.com, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
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

On Thu, Jan 21, 2021 at 02:24:27PM +0800, Yong Wu wrote:
> In this file, we have 2 drivers, smi-common and smi-larb.
> Use platform_register_drivers.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
