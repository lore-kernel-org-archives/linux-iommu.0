Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C08C433EF
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 18:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 64ED6404EE;
	Wed,  9 Feb 2022 18:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30n-d1--L6BT; Wed,  9 Feb 2022 18:58:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1CFA3403A7;
	Wed,  9 Feb 2022 18:58:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E31B7C001A;
	Wed,  9 Feb 2022 18:58:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05A52C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 18:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D768960681
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 18:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rmezLR8rB4bt for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 18:58:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B1766060A
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 18:58:26 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 l43-20020a9d1cab000000b005aa50ff5869so2221085ota.0
 for <iommu@lists.linux-foundation.org>; Wed, 09 Feb 2022 10:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kfS2tc0AzsIzDQltvbOtE1I0l9vkTyfE/J6yUpGln0c=;
 b=eMnPEsnadM46V0Ufum4e8ns1B1Je7Vwuu9KuwGNBui+Ti9n2FZMAQz0eWc99NlWjlk
 W0CIHUZr/I+h9d+f/CA/SVdHei8IRL08+aZxepQ6YBbmI6fWb2NZgK7C92ZWPL1l2JRT
 w3KuptXbYOssIrx2flR4Jr7sCgX3igoZZ6+OtUx3qamzkriFS/VhtmdEhUFqhPQDMeUM
 fGCWv5l4rKDpTcbARxKPBAKk9KOfCtG3a1IhvPMTfpDNLnPSFveswc6NzTdaP8Z5hrwa
 PdeMi5M+sfLf9OtN2TGU/d675bwv4W+1q/wPErOhjeV/yqhFudmG68/NLIafj8foeIrS
 JstQ==
X-Gm-Message-State: AOAM530P0ZdFqJ8/pmVr21KUr8DohLtnDt5o962E2fXH73yLqZyVP2Gn
 0maw2ZmLUMnDIcubU+ZYMg==
X-Google-Smtp-Source: ABdhPJy1QLereUHPHn+KQEWWdGdMvIbLw4PjCtA2U9SLf9F3FBDMGU46oKwFhWmbysAO9gyuABLqbA==
X-Received: by 2002:a05:6830:1019:: with SMTP id
 a25mr1520526otp.28.1644433105193; 
 Wed, 09 Feb 2022 10:58:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id n24sm7838348oao.40.2022.02.09.10.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 10:58:24 -0800 (PST)
Received: (nullmailer pid 692950 invoked by uid 1000);
 Wed, 09 Feb 2022 18:58:23 -0000
Date: Wed, 9 Feb 2022 12:58:23 -0600
From: Rob Herring <robh@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: renesas,ipmmu-vmsa: add
 r8a779f0 support
Message-ID: <YgQOz+YIkWJJFp/M@robh.at.kernel.org>
References: <20220208002030.1319984-1-yoshihiro.shimoda.uh@renesas.com>
 <20220208002030.1319984-2-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220208002030.1319984-2-yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, will@kernel.org
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

On Tue, 08 Feb 2022 09:20:29 +0900, Yoshihiro Shimoda wrote:
> Document the compatible values for the IPMMU-VMSA blocks in
> the Renesas R-Car S4-8 (R8A779F0) SoC and R-Car Gen4.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
