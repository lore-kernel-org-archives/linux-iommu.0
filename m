Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D72C34031
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F52B207FD
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ts8VDPPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F52B207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2349A842A5;
	Wed, 19 Feb 2020 02:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b5kFrHcfmmrU; Wed, 19 Feb 2020 02:18:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8FF2485190;
	Wed, 19 Feb 2020 02:18:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78DC3C1D84;
	Wed, 19 Feb 2020 02:18:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A447C013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 02:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 848438783F
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 02:18:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZqjsrvTrF2tl for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 02:18:27 +0000 (UTC)
X-Greylist: delayed 00:22:34 by SQLgrey-1.7.6
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 18A398782E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 02:18:27 +0000 (UTC)
Received: by mail-il1-f193.google.com with SMTP id t17so19129586ilm.13
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mCpHqL2j5BnpvPO+BvKBhD4kS+poF12ECCa7tnpH+YM=;
 b=ts8VDPPBuLBZSekAbBB4AA9teS6dDAo1HBlFrWgCyrq8tuMc3thxftGa4AHpAl9HfC
 u7yxDltYVpeECwcY8RzDqO6Oc+ujMt1LKMzE60hyRUp4CRmsuXIAURjdU5sPKFRoFEwm
 6FN7vQ7hbitggAiOqBJscQwLzxfsXk6P3kE/ijGHV8xJt/0agF6tzs7iGM9/TJ0Fvy9F
 ArDT1pSLD7/sstOaJU2GCdk92lHOemZWj0EQ3zQfulnRwfJ76bPc+DDLQ9ZRE1nVboYb
 jR7FRhkDaPhSRUnmUrrhkxZbwc53oVyaoPQDanlDY6cxtAjJ8vR46+8/3WdA4kMg6eXF
 I4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mCpHqL2j5BnpvPO+BvKBhD4kS+poF12ECCa7tnpH+YM=;
 b=Fmi+YCk7bNW4a8wYbwcLpeIvmTdyfn+IfOuKZX4mJo2N2vL3F373HjKRfByQV5kpIf
 qXUlvYcQrMJE5u+YR+AbPkmw9FF3LtxZdg93UtaqeDb63b+wMWdzSFtMxrBGw4RjIWMR
 Q5+7V3Hc/LyH4ViPwGNGhCJx4V764fzzNfts+SmRFSwv6MJSghaSyIx2nuBc81zvFY6b
 ePD04/KDAbtJ2tRXQ4+LZYjdo6vHruXYr/o02xF4CBdMq123bWGeifnHZj0X0/dpnsGy
 OtDKqIF1IUeZ9OT0wDqZzPecGMgFjHVVqzrcLMsQhfmlAR0ASp9tQ0jBjGMggGLgEhtF
 /eNg==
X-Gm-Message-State: APjAAAWK+JHHZWywfcC+029NfCZaP1i0RLcEi56E3OePfwVJ9Te+KTZP
 mmm3Gg/6yPj53d0IdlWqPpLtJ6q1l/4=
X-Google-Smtp-Source: APXvYqywbiuEpD1gaeQyiKrj/G0fRGBegWe1kQhCb3QNT2ZiaM+5B/V4zEAel8kBFDrwr4m3Dknbgg==
X-Received: by 2002:a63:2266:: with SMTP id t38mr26477980pgm.145.1582076994532; 
 Tue, 18 Feb 2020 17:49:54 -0800 (PST)
Received: from localhost ([223.226.55.170])
 by smtp.gmail.com with ESMTPSA id q25sm288920pfg.41.2020.02.18.17.49.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Feb 2020 17:49:53 -0800 (PST)
Date: Wed, 19 Feb 2020 07:19:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 04/11] cpufreq: Remove Calxeda driver
Message-ID: <20200219014951.2o2diuw5dzooafji@vireshk-i7>
References: <20200218171321.30990-1-robh@kernel.org>
 <20200218171321.30990-5-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200218171321.30990-5-robh@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Mark Langsdorf <mlangsdo@redhat.com>, kvm@vger.kernel.org,
 linux-ide@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, soc@kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org,
 Jon Loeliger <jdl@jdl.com>, linux-pm@vger.kernel.org,
 Andre Przywara <andre.przywara@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Alexander Graf <graf@amazon.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Matthias Brugger <mbrugger@suse.com>,
 Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robert Richter <rrichter@marvell.com>, James Morse <james.morse@arm.com>,
 Borislav Petkov <bp@alien8.de>, Robin Murphy <robin.murphy@arm.com>,
 "David S. Miller" <davem@davemloft.net>
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

On 18-02-20, 11:13, Rob Herring wrote:
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Do not apply yet.
> 
>  drivers/cpufreq/Kconfig.arm          |  10 ---
>  drivers/cpufreq/Makefile             |   3 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c |   3 -
>  drivers/cpufreq/highbank-cpufreq.c   | 106 ---------------------------
>  4 files changed, 1 insertion(+), 121 deletions(-)
>  delete mode 100644 drivers/cpufreq/highbank-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
