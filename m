Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C124C433EF
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 03:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99860830A7;
	Wed,  9 Feb 2022 03:28:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P0Xqzq133hoP; Wed,  9 Feb 2022 03:28:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A97982FE7;
	Wed,  9 Feb 2022 03:28:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6513BC0011;
	Wed,  9 Feb 2022 03:28:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E32EC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 03:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 715EC830A7
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 03:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IuPdjj_0efp8 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 03:28:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73EC482FE7
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 03:28:15 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id
 u25-20020a4ad0d9000000b002e8d4370689so993483oor.12
 for <iommu@lists.linux-foundation.org>; Tue, 08 Feb 2022 19:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HSxopZsSnPsRcG33HAAgco1k+vDXFb3VtI2j2ntI5qQ=;
 b=3O9LnBrixL+1kQ29Cs0AydpYlUcN8wJNJRx9nS2aYHw6u4QDvqIu5mrCLibF5x8H2e
 /8RGI0bjBgUFurrH3/3En/siRJbnZyjHxoB4ts9yiXS9s9BCYgsY/JxsP4FXO8k50xfQ
 DzGZPyExyAd3WzbHhpbu39PZ3s1ikR56F/ChLSt3IeXspWGapfKvWc94bscp90WQDypa
 Md2CImMEBHNnRomtBsXwPIFit8F2wV+dtIR5lXchEQRCCR46y6rgGHggLodunhBFLvYI
 Htbq0okrDzl5PufMAwdwA1XI/qOIn8QYqIEe2RDihu3+ZzZcSt9rXaZaW5bAvNuCzbkt
 5KpQ==
X-Gm-Message-State: AOAM533JlBBIe6zZYTkvYrhxJqDJQKXfJj7xHI0D6s910VY6NNqs8IsP
 w8x21H4p8yl5FleLB+c04w==
X-Google-Smtp-Source: ABdhPJzmourstxCxRDZaZsvmrYvqzfZpgNTTlzuYJ8p7hxNsFseigsd8IWKAou7GDbUe5LrZxMXBnQ==
X-Received: by 2002:a4a:e742:: with SMTP id n2mr172803oov.1.1644377294315;
 Tue, 08 Feb 2022 19:28:14 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id 21sm6031798otj.71.2022.02.08.19.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Feb 2022 19:28:13 -0800 (PST)
Received: (nullmailer pid 3579348 invoked by uid 1000);
 Wed, 09 Feb 2022 03:28:12 -0000
Date: Tue, 8 Feb 2022 21:28:12 -0600
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: Reformat
 renesas,ipmmu-main description
Message-ID: <YgM0zKJz+R5Nfm2/@robh.at.kernel.org>
References: <ea2205791573e6d99f3cb65cae99bdbfa4f65c97.1643199809.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea2205791573e6d99f3cb65cae99bdbfa4f65c97.1643199809.git.geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Wed, Jan 26, 2022 at 01:24:32PM +0100, Geert Uytterhoeven wrote:
> Remove trailing whitespace and break overly long lines.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I fixed this and other whitespace in my tree from commit 'dt-bindings: 
Improve phandle-array schemas'.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
