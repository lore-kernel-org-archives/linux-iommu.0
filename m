Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B7DC433E0
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 08:13:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2668217D8
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 08:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaeiwFlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2668217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CFB2E8A7F1;
	Tue, 14 Jul 2020 08:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1YDk-O8ESTyL; Tue, 14 Jul 2020 08:13:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5EE528A7EF;
	Tue, 14 Jul 2020 08:13:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EE65C0888;
	Tue, 14 Jul 2020 08:13:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5913C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 07:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9570D87C7B
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 07:34:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vpnw2XBwaPX3 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 07:34:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C638A87C3C
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 07:34:07 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id g2so10797781lfb.0
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vSZCdTeq5IZuIT/5K6A9iU6I7B62mfuU1w1ZeNdxwsA=;
 b=IaeiwFlo8/BnwFbIg9V+kT/A3MGOXKWrL8aFqD7RmTg7SL/L0Ik13tc0GNKZ+nqBr2
 n6F22egPYYSTnoei5lFzP64BmWd0JJUHEc7ShDJoqOV3hqZ+5S46F0Q6UWfsyW3oCbWR
 II4204xpQRJckdYQnNR5iH5fKM8TrMWfCUI9r9unii/uFJIgewAX57yEQnRWe2Nyig1V
 K3fhA8dFPJoDcAKjTEgfTrlTQTafus7qfE+HvYl8EAzwF2Zd9/T+TFq7NexCd5riqzry
 aFclxGUkc8bCLkIWlVKylGLHnyGT62Q5XJ/1uH5hsjLSwD0qXzLWrnGYLX3HaTMI7PRJ
 BmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vSZCdTeq5IZuIT/5K6A9iU6I7B62mfuU1w1ZeNdxwsA=;
 b=GikPFln7BZu08mcSP4c290mpPmuwwpYHF2OTI2uceYHOuaok+wQWxPWA6FYcrBiZEr
 74bLAjcJO2irdgAQiAlnWPZsMsfSW0W1ltSxJo+g7LiF51D8ptG5kd7U1d2n7y9qw/sr
 vw0NHbhaD2YZrWtvdpedJVEZvaPVFXeaJ4Dq7QigiKD8ft3Ze0DEEYzlMzf4epaeBKGF
 fZc2t0lsEylxx/NSLKYkyXHkeAJftcpRLu6FjFMjLQEFr0mpTyPGEjEdIQN3XLp1OuKX
 YyO1jb3qwJpQ4r7ms0ggrEOERghgTxMeBTG+/67/l0ByW1G+3i3AZ5+FksULBNtTZJyp
 uYuQ==
X-Gm-Message-State: AOAM530pKZZ0BidM4kDeYScO//jigPGY9OL95m1OdBATAz6tgWvcFgVH
 9vGQ/Nz8Md9cwlGa1jE2NZg=
X-Google-Smtp-Source: ABdhPJwKAOzh6OpUd3ef4QZMtDjWIvyqfzukJI4zVQgp0Iw73r7ql8TL8LKN16oTjdOmjeR1GQGBJg==
X-Received: by 2002:a19:6a02:: with SMTP id u2mr1568163lfu.9.1594712045894;
 Tue, 14 Jul 2020 00:34:05 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:809:9719:3978:b690:7798:aa4b?
 ([2a00:1fa0:809:9719:3978:b690:7798:aa4b])
 by smtp.gmail.com with ESMTPSA id u9sm4468057ljk.44.2020.07.14.00.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 00:34:05 -0700 (PDT)
Subject: Re: [PATCH 8/9] dt-bindings: net: renesas,ravb: Add support for
 r8a774e1 SoC
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Joerg Roedel <joro@8bytes.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <db415d4f-e563-81f4-2202-5eea57f91a6d@gmail.com>
Date: Tue, 14 Jul 2020 10:34:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594676120-5862-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 14 Jul 2020 08:13:31 +0000
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Prabhakar <prabhakar.csengg@gmail.com>,
 dmaengine@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hello!

On 14.07.2020 0:35, Lad Prabhakar wrote:

> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> 
> Document RZ/G2H (R8A774E1) SoC bindings.
> 
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>

[...]

MBR, Sergei
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
