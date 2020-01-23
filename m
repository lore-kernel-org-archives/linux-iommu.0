Return-Path: <SRS0=99fx=3M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7871AC2D0DB
	for <iommu@archiver.kernel.org>; Thu, 23 Jan 2020 14:44:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A1E20704
	for <iommu@archiver.kernel.org>; Thu, 23 Jan 2020 14:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A1E20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 076B38843E;
	Thu, 23 Jan 2020 14:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqLZG5bWpG50; Thu, 23 Jan 2020 14:44:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A24587E8B;
	Thu, 23 Jan 2020 14:44:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D63EC0176;
	Thu, 23 Jan 2020 14:44:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD6EEC0174
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 14:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 95EC186092
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 14:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zUO-OdV3E37Q for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jan 2020 14:44:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ECDB386005
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 14:44:12 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id a15so2964552otf.1
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jan 2020 06:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=h4oHzrFYKqp+VGW1bsUiQD/W3J5scTqNZ8AL4zNgxc0=;
 b=hptUtlhPbQGepgu0cTulG/wsUI2pMwrjxn9C3CykGTgpU64g+gYxhk6aacnMV4FeLm
 dtR7cn1IblMWZVjP87X+H/PK4mkD0XIQH5TegzHOOsWfoXLjnh93jnk6g7McjQM09TVR
 Xz4htZZgwmBTUAcB+YTAcbxAkF4A4brvAng4PvfCTTG2tSYS28s4mbRQVpUfUwmlZXBm
 X+K8QoUq+FYoVx5sZ/FMzSN2S7Juv9lAJqkkP1BUY0bKYc0z0XeR1o2PVAxQ1HIUT80R
 RR5eP2p2cJk2T3vN4ZtDOlxh6/YE8i3j1jjYQiRxHWd3EvaY0s7uhbXrEkGwQgcEYCpQ
 BN/Q==
X-Gm-Message-State: APjAAAUpjgnjyZUUAq3R68sKjDBehCJu7taFeLCPS5ItQqSwZHkRGD6G
 46IpA+PfdT0oKjEKzhKhMA==
X-Google-Smtp-Source: APXvYqznkYyQ82Iaq8fFB0N1PdBN29CchqSiaNIZ4ovIW3gdQxYo3Z67i87qruav9akbSEbbJRCETA==
X-Received: by 2002:a05:6830:1d91:: with SMTP id
 y17mr11150667oti.276.1579790652164; 
 Thu, 23 Jan 2020 06:44:12 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id p24sm851505oth.28.2020.01.23.06.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 06:44:11 -0800 (PST)
Received: (nullmailer pid 13653 invoked by uid 1000);
 Thu, 23 Jan 2020 14:44:11 -0000
Date: Thu, 23 Jan 2020 08:44:11 -0600
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 1/3] dt-bindings: iommu: Add Allwinner H6 IOMMU bindings
Message-ID: <20200123144411.GA13589@bogus>
References: <cover.b2a9e1507135d81e726fcbb65137665a7f0ab74f.1579696927.git-series.maxime@cerno.tech>
 <3022a8d9d60f35db072b39313ec46708a567a9c5.1579696927.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3022a8d9d60f35db072b39313ec46708a567a9c5.1579696927.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
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

On Wed, 22 Jan 2020 13:44:07 +0100, Maxime Ripard wrote:
> The Allwinner H6 has introduced an IOMMU. Let's add a device tree binding
> for it.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
