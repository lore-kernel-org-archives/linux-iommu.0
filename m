Return-Path: <SRS0=Jdo0=25=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F60C282DD
	for <iommu@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DF220692
	for <iommu@archiver.kernel.org>; Wed,  8 Jan 2020 16:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DF220692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CDCCF87952;
	Wed,  8 Jan 2020 16:58:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fk8jpZnjVuoJ; Wed,  8 Jan 2020 16:58:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 177AC87482;
	Wed,  8 Jan 2020 16:58:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE2C5C1796;
	Wed,  8 Jan 2020 16:58:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD5EDC0881
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 16:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A63B685124
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 16:58:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bWL5EqXxq7wW for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jan 2020 16:58:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0C774847EB
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 16:58:48 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id z64so3251008oia.4
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jan 2020 08:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TEWqrKckxXi7QmpFNDQI2lr/8vlOr4RUJSG6WcBUQm8=;
 b=E5WKt78s1Qise4kLvjX12M8hzW5/mCd8zOnMgi0E5v0eguDZfW6+4JvYbqTKOETZgL
 2sSOxB6kLmIRvojwmdx4VSoKfpQwmJcqGVjnJqBd/r9NU4oGkOTfqdsM0WaQvMeeKP4v
 QWsWpFCIb8HFCns4RSpTEf0PGQW3wlnIT8SK1Mn/epvvflSvYff5wiwzC6EAufQQL3Hv
 ekGstjGGYbzDbCexN9Y/HrRXv8kbiUMkoPGgL1beouyO5y2UTtBb5/n9vxChCetxlYmO
 RqvNIzFKfrG1K7Rr3DMpjLAjOuuqbFD946cBkYOCmNbE1WBdyYOWa+7LbcQgpnFGX8qR
 AjAQ==
X-Gm-Message-State: APjAAAW4QtehwxVZwOuI1BJXRR4QMAormNrvICke2zhR/CxdSWWfa6bW
 rJQvEST2sk/roPyBh+MIIorlVJw=
X-Google-Smtp-Source: APXvYqzNCAIwNthZdk6DNgYGJA5QO+HQEejtO4lPfZED8W/uLyzPoKK3RRarPQWoMWeFexM+p8t0lw==
X-Received: by 2002:aca:d0b:: with SMTP id 11mr3919947oin.71.1578502726987;
 Wed, 08 Jan 2020 08:58:46 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id g61sm1293055otb.53.2020.01.08.08.58.45
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 08:58:46 -0800 (PST)
Received: from rob (uid 1000) (envelope-from rob@rob-hp-laptop) id 220333
 by rob-hp-laptop (DragonFly Mail Agent v0.11);
 Wed, 08 Jan 2020 10:58:45 -0600
Date: Wed, 8 Jan 2020 10:58:45 -0600
From: Rob Herring <robh@kernel.org>
To: Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: iommu: Add binding for MediaTek MT8167
 IOMMU
Message-ID: <20200108165845.GA8360@bogus>
References: <20200103162632.109553-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200103162632.109553-1-fparent@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
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

On Fri,  3 Jan 2020 17:26:31 +0100, Fabien Parent wrote:
> This commit adds IOMMU binding documentation for the MT8167 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iommu/mediatek,iommu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
