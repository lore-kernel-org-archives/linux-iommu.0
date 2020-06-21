Return-Path: <SRS0=X07A=AC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81825C433DF
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 11:01:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4430523F2C
	for <iommu@archiver.kernel.org>; Sun, 21 Jun 2020 11:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3Y7KXSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4430523F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 99A8C2CB5C;
	Sun, 21 Jun 2020 11:01:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TER1a3ibXTcd; Sun, 21 Jun 2020 11:01:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A9B2725A2F;
	Sun, 21 Jun 2020 11:01:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78D24C0891;
	Sun, 21 Jun 2020 11:01:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAEE7C016F
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 11:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D014F86E76
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 11:01:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ulPWZOZmmZc5 for <iommu@lists.linux-foundation.org>;
 Sun, 21 Jun 2020 11:01:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 33FD886916
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 11:01:31 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id u26so11636261wmn.1
 for <iommu@lists.linux-foundation.org>; Sun, 21 Jun 2020 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DE8N2s1fR94hJYhgdJimowfZbLOPMYaMOhxTPe2h8LM=;
 b=D3Y7KXSPLEXBLJGFpQpM+Q33ApO5B+1YsMIkbr5BTt/uFjVGGlcSCWC88sUpZGXWrh
 Hg5ubH+yhqM9edat+F4k9sQ0uWmOgD0f67y9S8fZQIhJPpWymYHpDmh8D+QMstD3OY4M
 htF3R53tLvFsTU3Zpd4/K0pCnl8V6yEQwNIJaSXcAg1Z2KejQo7qqaTcGH24CYdJTLPT
 gQ62ZP4j3Eo/3SVuQpxTU/955QwNczJHEjMQMUAM3h63DxNsuSu0ey4KUaXS320J3MXM
 QpF1A4sdZVHBy/wP7ASUDC2WVCww8qYf3Rai/Xd9ii6a7mOVNAQ1uG7TqDdsO5Mt8gTG
 vW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DE8N2s1fR94hJYhgdJimowfZbLOPMYaMOhxTPe2h8LM=;
 b=QdM3fFCncRLOUdMqKFbvL0nQYbdJPKX6kWRWPt7LrltU27/Mm79qrNNDaNpbbI0UpI
 QW7yZIe9hdrCT06hjZdVihAViqJUK8qOlmRHgrIhqbLeGGAGLbzy9Iotc/hdjUcEQ47f
 TcPbCW0kaU95d8KORH7lLc2DXwlW1hPlVPTsnhoHsjQgvvXCuf4+Js+pfriNKyzQyuBj
 St+tPn280FzC0pzDGp73yZxDPEj8H1iCQrPXx3kmCU1Q8rl7n5NqIzlJMLTG2dB+K1h+
 aDJJNd9zdetR56FC9QHxzUBzxNBVjgh/cuIJyslBdM7Z9JayRg8KV58pVXgxG9A2LfRf
 pH0Q==
X-Gm-Message-State: AOAM533DrMQxBGn53a585PzV9ZYkpj3C3/2R8isfa+RPt3I365BkQHaZ
 txVZao5eZzCpyhdpmmQoN6s=
X-Google-Smtp-Source: ABdhPJwXrTFQ19BxYZwsniZT3H/XfcX0QfsOcIAt4PLGCFMr0ATNjal5p1Cwh8g7jWUez+x26DP0CA==
X-Received: by 2002:a1c:2cd7:: with SMTP id
 s206mr12380713wms.109.1592737289473; 
 Sun, 21 Jun 2020 04:01:29 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.138])
 by smtp.gmail.com with ESMTPSA id x24sm8101107wmj.28.2020.06.21.04.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 04:01:28 -0700 (PDT)
Subject: Re: [PATCH v4 6/7] iommu/mediatek: Add REG_MMU_WR_LEN definition
 preparing for mt6779
To: chao hao <Chao.Hao@mediatek.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
 <20200617030029.4082-7-chao.hao@mediatek.com>
 <9e2c52d6-a887-1977-8877-fbcd30cb4261@gmail.com>
 <1592564184.5692.6.camel@mbjsdccf07>
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABtClNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPokCUgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyybkCDQRd1TkHARAAt1BBpmaH+0o+
 deSyJotkrpzZZkbSs5ygBniCUGQqXpWqgrc7Uo/qtxOFL91uOsdX1/vsnJO9FyUv3ZNI2Thw
 NVGCTvCP9E6u4gSSuxEfVyVThCSPvRJHCG2rC+EMAOUMpxokcX9M2b7bBEbcSjeP/E4KTa39
 q+JJSeWliaghUfMXXdimT/uxpP5Aa2/D/vcUUGHLelf9TyihHyBohdyNzeEF3v9rq7kdqamZ
 Ihb+WYrDio/SzqTd1g+wnPJbnu45zkoQrYtBu58n7u8oo+pUummOuTR2b6dcsiB9zJaiVRIg
 OqL8p3K2fnE8Ewwn6IKHnLTyx5T/r2Z0ikyOeijDumZ0VOPPLTnwmb780Nym3LW1OUMieKtn
 I3v5GzZyS83NontvsiRd4oPGQDRBT39jAyBr8vDRl/3RpLKuwWBFTs1bYMLu0sYarwowOz8+
 Mn+CRFUvRrXxociw5n0P1PgJ7vQey4muCZ4VynH1SeVb3KZ59zcQHksKtpzz2OKhtX8FCeVO
 mHW9u4x8s/oUVMZCXEq9QrmVhdIvJnBCqq+1bh5UC2Rfjm/vLHwt5hes0HDstbCzLyiA0LTI
 ADdP77RN2OJbzBkCuWE21YCTLtc8kTQlP+G8m23K5w8k2jleCSKumprCr/5qPyNlkie1HC4E
 GEAfdfN+uLsFw6qPzSAsmukAEQEAAYkEbAQYAQgAIBYhBOa5khjA8sMlHCw6F9kUC7JWEwLx
 BQJd1TkHAhsCAkAJENkUC7JWEwLxwXQgBBkBCAAdFiEEUdvKHhzqrUYPB/u8L21+TfbCqH4F
 Al3VOQcACgkQL21+TfbCqH79RRAAtlb6oAL9y8JM5R1T3v02THFip8OMh7YvEJCnezle9Apq
 C6Vx26RSQjBV1JwSBv6BpgDBNXarTGCPXcre6KGfX8u1r6hnXAHZNHP7bFGJQiBv5RqGFf45
 OhOhbjXCyHc0jrnNjY4M2jTkUC+KIuOzasvggU975nolC8MiaBqfgMB2ab5W+xEiTcNCOg3+
 1SRs5/ZkQ0iyyba2FihSeSw3jTUjPsJBF15xndexoc9jpi0RKuvPiJ191Xa3pzNntIxpsxqc
 ZkS1HSqPI63/urNezeSejBzW0Xz2Bi/b/5R9Hpxp1AEC3OzabOBATY/1Bmh2eAVK3xpN2Fe1
 Zj7HrTgmzBmSefMcSXN0oKQWEI5tHtBbw5XUj0Nw4hMhUtiMfE2HAqcaozsL34sEzi3eethZ
 IvKnIOTmllsDFMbOBa8oUSoaNg7GzkWSKJ59a9qPJkoj/hJqqeyEXF+WTCUv6FcA8BtBJmVf
 FppFzLFM/QzF5fgDZmfjc9czjRJHAGHRMMnQlW88iWamjYVye57srNq9pUql6A4lITF7w00B
 5PXINFk0lMcNUdkWipu24H6rJhOO6xSP4n6OrCCcGsXsAR5oH3d4TzA9iPYrmfXAXD+hTp82
 s+7cEbTsCJ9MMq09/GTCeroTQiqkp50UaR0AvhuPdfjJwVYZfmMS1+5IXA/KY6DbGBAAs5ti
 AK0ieoZlCv/YxOSMCz10EQWMymD2gghjxojf4iwB2MbGp8UN4+++oKLHz+2j+IL08rd2ioFN
 YCJBFDVoDRpF/UnrQ8LsH55UZBHuu5XyMkdJzMaHRVQc1rzfluqx+0a/CQ6Cb2q7J2d45nYx
 8jMSCsGj1/iU/bKjMBtuh91hsbdWCxMRW0JnGXxcEUklbhA5uGj3W4VYCfTQxwK6JiVt7JYp
 bX7JdRKIyq3iMDcsTXi7dhhwqsttQRwbBci0UdFGAG4jT5p6u65MMDVTXEgYfZy0674P06qf
 uSyff73ivwvLR025akzJui8MLU23rWRywXOyTINz8nsPFT4ZSGT1hr5VnIBs/esk/2yFmVoc
 FAxs1aBO29iHmjJ8D84EJvOcKfh9RKeW8yeBNKXHrcOV4MbMOts9+vpJgBFDnJeLFQPtTHuI
 kQXT4+yLDvwOVAW9MPLfcHlczq/A/nhGVaG+RKWDfJWNSu/mbhqUQt4J+RFpfx1gmL3yV8NN
 7JXABPi5M97PeKdx6qc/c1o3oEHH8iBkWZIYMS9fd6rtAqV3+KH5Ors7tQVtwUIDYEvttmeO
 ifvpW6U/4au4zBYfvvXagbyXJhG9mZvz+jN1cr0/G2ZC93IbjFFwUmHtXS4ttQ4pbrX6fjTe
 lq5vmROjiWirpZGm+WA3Vx9QRjqfMdS5Ag0EXdU5SAEQAJu/Jk58uOB8HSGDSuGUB+lOacXC
 bVOOSywZkq+Ayv+3q/XIabyeaYMwhriNuXHjUxIORQoWHIHzTCqsAgHpJFfSHoM4ulCuOPFt
 XjqfEHkA0urB6S0jnvJ6ev875lL4Yi6JJO7WQYRs/l7OakJiT13GoOwDIn7hHH/PGUqQoZlA
 d1n5SVdg6cRd7EqJ+RMNoud7ply6nUSCRMNWbNqbgyWjKsD98CMjHa33SB9WQQSQyFlf+dz+
 dpirWENCoY3vvwKJaSpfeqKYuqPVSxnqpKXqqyjNnG9W46OWZp+JV5ejbyUR/2U+vMwbTilL
 cIUpTgdmxPCA6J0GQjmKNsNKKYgIMn6W4o/LoiO7IgROm1sdn0KbJouCa2QZoQ0+p/7mJXhl
 tA0XGZhNlI3npD1lLpjdd42lWboU4VeuUp4VNOXIWU/L1NZwEwMIqzFXl4HmRi8MYbHHbpN5
 zW+VUrFfeRDPyjrYpax+vWS+l658PPH+sWmhj3VclIoAU1nP33FrsNfp5BiQzao30rwe4ntd
 eEdPENvGmLfCwiUV2DNVrmJaE3CIUUl1KIRoB5oe7rJeOvf0WuQhWjIU98glXIrh3WYd7vsf
 jtbEXDoWhVtwZMShMvp7ccPCe2c4YBToIthxpDhoDPUdNwOssHNLD8G4JIBexwi4q7IT9lP6
 sVstwvA5ABEBAAGJAjYEGAEIACAWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCXdU5SAIbDAAK
 CRDZFAuyVhMC8bXXD/4xyfbyPGnRYtR0KFlCgkG2XWeWSR2shSiM1PZGRPxR888zA2WBYHAk
 7NpJlFchpaErV6WdFrXQjDAd9YwaEHucfS7SAhxIqdIqzV5vNFrMjwhB1N8MfdUJDpgyX7Zu
 k/Phd5aoZXNwsCRqaD2OwFZXr81zSXwE2UdPmIfTYTjeVsOAI7GZ7akCsRPK64ni0XfoXue2
 XUSrUUTRimTkuMHrTYaHY3544a+GduQQLLA+avseLmjvKHxsU4zna0p0Yb4czwoJj+wSkVGQ
 NMDbxcY26CMPK204jhRm9RG687qq6691hbiuAtWABeAsl1AS+mdS7aP/4uOM4kFCvXYgIHxP
 /BoVz9CZTMEVAZVzbRKyYCLUf1wLhcHzugTiONz9fWMBLLskKvq7m1tlr61mNgY9nVwwClMU
 uE7i1H9r/2/UXLd+pY82zcXhFrfmKuCDmOkB5xPsOMVQJH8I0/lbqfLAqfsxSb/X1VKaP243
 jzi+DzD9cvj2K6eD5j5kcKJJQactXqfJvF1Eb+OnxlB1BCLE8D1rNkPO5O742Mq3MgDmq19l
 +abzEL6QDAAxn9md8KwrA3RtucNh87cHlDXfUBKa7SRvBjTczDg+HEPNk2u3hrz1j3l2rliQ
 y1UfYx7Vk/TrdwUIJgKS8QAr8Lw9WuvY2hSqL9vEjx8VAkPWNWPwrQ==
Message-ID: <e9a62fd8-ed8c-05d6-1eaa-49d5a471cd3a@gmail.com>
Date: Sun, 21 Jun 2020 13:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592564184.5692.6.camel@mbjsdccf07>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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



On 19/06/2020 12:56, chao hao wrote:
> On Wed, 2020-06-17 at 11:22 +0200, Matthias Brugger wrote:
>>
>> On 17/06/2020 05:00, Chao Hao wrote:
>>> Some platforms(ex: mt6779) have a new register called by REG_MMU_WR_LEN
>>> to improve performance.
>>> This patch add this register definition.
>>
>> Please be more specific what this register is about.
>>
> OK. thanks.
> We can use "has_wr_len" flag to control whether we need to set the
> register. If the register uses default value, iommu will send command to
> EMI without restriction, when the number of commands become more and
> more, it will drop the EMI performance. So when more than
> ten_commands(default value) don't be handled for EMI, IOMMU will stop
> send command to EMI for keeping EMI's performace by enabling write
> throttling mechanism(bit[5][21]=0) in MMU_WR_LEN_CTRL register.
> 
> I will write description above to commit message in next version
> 
>>>
>>> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
>>> ---
>>>  drivers/iommu/mtk_iommu.c | 10 ++++++++++
>>>  drivers/iommu/mtk_iommu.h |  2 ++
>>>  2 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index a687e8db0e51..c706bca6487e 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -46,6 +46,8 @@
>>>  #define F_MMU_STANDARD_AXI_MODE_BIT		(BIT(3) | BIT(19))
>>>  
>>>  #define REG_MMU_DCM_DIS				0x050
>>> +#define REG_MMU_WR_LEN				0x054
>>> +#define F_MMU_WR_THROT_DIS_BIT			(BIT(5) |  BIT(21))
>>>  
>>>  #define REG_MMU_CTRL_REG			0x110
>>>  #define F_MMU_TF_PROT_TO_PROGRAM_ADDR		(2 << 4)
>>> @@ -581,6 +583,12 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>>>  		writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
>>>  	}
>>>  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
>>> +	if (data->plat_data->has_wr_len) {
>>> +		/* write command throttling mode */
>>> +		regval = readl_relaxed(data->base + REG_MMU_WR_LEN);
>>> +		regval &= ~F_MMU_WR_THROT_DIS_BIT;
>>> +		writel_relaxed(regval, data->base + REG_MMU_WR_LEN);
>>> +	}
>>>  
>>>  	if (data->plat_data->reset_axi) {
>>>  		/* The register is called STANDARD_AXI_MODE in this case */
>>> @@ -737,6 +745,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
>>>  	struct mtk_iommu_suspend_reg *reg = &data->reg;
>>>  	void __iomem *base = data->base;
>>>  
>>> +	reg->wr_len = readl_relaxed(base + REG_MMU_WR_LEN);
>>
>> Can we read/write the register without any side effect although hardware has not
>> implemented it (!has_wr_len)?
> 
> It doesn't have side effect. Becasue all the MTK platform have the
> register for iommu HW. If we need to have requirement for performance,
> we can set it by has_wr_len.
> But I'm Sorry, the name of flag(has_wr_len) is not exact, I will rename
> it in next version, ex: "wr_throt_en"
> 
>>
>>
>>>  	reg->misc_ctrl = readl_relaxed(base + REG_MMU_MISC_CTRL);
>>>  	reg->dcm_dis = readl_relaxed(base + REG_MMU_DCM_DIS);
>>>  	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
>>> @@ -761,6 +770,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>>>  		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
>>>  		return ret;
>>>  	}
>>> +	writel_relaxed(reg->wr_len, base + REG_MMU_WR_LEN);
>>>  	writel_relaxed(reg->misc_ctrl, base + REG_MMU_MISC_CTRL);
>>>  	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
>>>  	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
>>> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
>>> index d51ff99c2c71..9971cedd72ea 100644
>>> --- a/drivers/iommu/mtk_iommu.h
>>> +++ b/drivers/iommu/mtk_iommu.h
>>> @@ -25,6 +25,7 @@ struct mtk_iommu_suspend_reg {
>>>  	u32				int_main_control;
>>>  	u32				ivrp_paddr;
>>>  	u32				vld_pa_rng;
>>> +	u32				wr_len;
>>>  };
>>>  
>>>  enum mtk_iommu_plat {
>>> @@ -43,6 +44,7 @@ struct mtk_iommu_plat_data {
>>>  	bool		    has_misc_ctrl;
>>>  	bool		    has_sub_comm;
>>>  	bool                has_vld_pa_rng;
>>> +	bool                has_wr_len;
>>
>> Given the fact that we are adding more and more plat_data bool values, I think
>> it would make sense to use a u32 flags register and add the appropriate macro
>> definitions to set and check for a flag present.
> 
> Thanks for your advice.
> do you mean like this:
> struct plat_flag {
> 
>         #define  HAS_4GB_MODE   BIT(0)
>         #define  HAS_BCLK       BIT(1)
>         #define  REST_AXI       BIT(2)
>         ... ...
> 
>         u32 flag;
> };
> 
> struct mtk_iommu_plat_data {
>         ......
>         struct plat_flag flag;
>         ......
> };
> 

Nearly, I mean something like this:

#define  HAS_4GB_MODE   BIT(0)
#define  HAS_BCLK       BIT(1)
#define  REST_AXI       BIT(2)

#define MTK_IOMMU_HAS_FLAG(pdata, _x)	\
		((((pdata)->flags) & (_x)) == (_x))

struct mtk_iommu_plat_data {
	...
	u32 flags;
	...
}

if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_BCLK)
...

Regards,
Matthias

> 
>> Regards,
>> Matthias
>>
>>>  	bool                reset_axi;
>>>  	u32                 inv_sel_reg;
>>>  	unsigned char       larbid_remap[8][4];
>>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
