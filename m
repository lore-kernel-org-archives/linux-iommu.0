Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C95EC4741F
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 19:04:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BB92083B
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 19:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BB92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1A1F18584A;
	Thu,  5 Nov 2020 19:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bVWSi9lOEr_t; Thu,  5 Nov 2020 19:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 926E28575E;
	Thu,  5 Nov 2020 19:04:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83F7FC0893;
	Thu,  5 Nov 2020 19:04:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A355AC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8FC1786687
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GSsFYW6PAI9M for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 19:04:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD0E086663
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 19:04:33 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id o20so2686477eds.3
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 11:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zqyCE8j+KUun/fJoeSvUEUCu9rjigk9T/yqFJYAG6HE=;
 b=sUHCjB2mGTLyKbE6wdn/XJ9eDMa/HdrPMlDDs4vSJbNTHtnf+vZGxVEkWCMKQOEhjZ
 X1gJwlrUgpJX5txdFZY5RljA08mnuCNnEvvDGhsIOuk+CExEN0hsX7kFft10fwrsLrs8
 TKzLbPR3DyRRrIdtwMtgoPW1JOPeen0Ht8apeCAgu8K13N4MyxrPQv2dGL8WBBVt7xZG
 4X+jYL3ys3YGEcLDGDYKyoFunStqkrRCyf0Gwnk0Nae6gpk5Um/1H9n4UHOnlMdyC5vf
 8XNq8lxuwGFkLH1G6+zXec93lKss56XvavLN5+v4Qvr+O/2N1vjDt5+z34c734Y1F9jt
 RalA==
X-Gm-Message-State: AOAM533ZCXK57S0bU4eLsZzY/Za2rLGwd21WCcR8MsMzu6xP7veeSgM9
 FsOiBhc9jcYZuZUZFq4eD8Y=
X-Google-Smtp-Source: ABdhPJz1Vs7KZFfoAlojBxrrmYqF0uUmNwhflz1BNcxZt0QGdXEDkjrc6x/XVjVsJtmzvIn+5lPqDw==
X-Received: by 2002:aa7:cb58:: with SMTP id w24mr4093038edt.35.1604603072260; 
 Thu, 05 Nov 2020 11:04:32 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id k23sm1490058ejo.108.2020.11.05.11.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 11:04:31 -0800 (PST)
Date: Thu, 5 Nov 2020 20:04:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 3/3] memory: mtk-smi: Add mt8192 support
Message-ID: <20201105190429.GC217610@kozik-lap>
References: <20201103054200.21386-1-yong.wu@mediatek.com>
 <20201103054200.21386-4-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201103054200.21386-4-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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

On Tue, Nov 03, 2020 at 01:42:00PM +0800, Yong Wu wrote:
> Add mt8192 smi support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 19 +++++++++++++++++++

Thanks, applied.

Best regards,
Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
