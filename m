Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DBFC433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 20:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4D1E80C3F;
	Mon,  6 Dec 2021 20:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9R_gdmUi0DkH; Mon,  6 Dec 2021 20:03:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E474980DEC;
	Mon,  6 Dec 2021 20:03:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7E70C002F;
	Mon,  6 Dec 2021 20:03:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4B12C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 20:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D44AF80E28
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 20:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cxz5eStPBLWO for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 20:03:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9982E80DEC
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 20:03:55 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 9CC0FCE17BE
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 20:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4DAC341C1
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 20:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638821026;
 bh=+kDhCbS4MC6s87gk/hqVpCOT11rigfeiUnE60NGNue4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TqXb1o09pzzAyZnhphRi6zhR0nR0J0ZfQXgZ2W+8iWznQHDXsfhe8xgzlujcb8CaF
 2xkA+UIKoCW5U1pQ66tkL1DHai1FvWRJEnHWcm9npJoskMS886GnBUj9EpR9uYgupm
 OVQv9Z3LMkE21b54+0e09iBtrOIe0Vfz1QEsOKoWmZI1gNWOoH9sdIycnnoQII2BgX
 hFAXoy4MOgPJkz+prVhLy884l50CC7hWIO4bkenz5/Y5bQsxDe/DDjzLf9PYLFGI7d
 RuCIZuBTeZUye8klN87O5vBCW5wIAON9iY52UkbWM2W4Rhpccbm+K2g2dddZ57lhDh
 4H1zCXn67k3Xw==
Received: by mail-ed1-f50.google.com with SMTP id l25so47518722eda.11
 for <iommu@lists.linux-foundation.org>; Mon, 06 Dec 2021 12:03:46 -0800 (PST)
X-Gm-Message-State: AOAM532CZRNJPAFIDdhVtkEwX9PQyYHIpUNSrWNIG4BgwdBzJQg+GV3E
 LcEPRcmCjCsN8LwNji6sBo8LErZHODlpfXiW+A==
X-Google-Smtp-Source: ABdhPJyCFtv6blqxShf0Ee/DkuII0HgNMAAxcboZkr2vCOEDnBoXPgE9wT4RXkjxOTkQvnAm0/E5m3qKXiAfZxiIHsc=
X-Received: by 2002:a05:6402:35ce:: with SMTP id
 z14mr1787984edc.197.1638821025123; 
 Mon, 06 Dec 2021 12:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20211201155716.149543-1-jonathanh@nvidia.com>
In-Reply-To: <20211201155716.149543-1-jonathanh@nvidia.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 6 Dec 2021 14:03:33 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9aMp2w-GUCsvjdm_8n73mSe3idGwn+FMDA4q8oNPQ9Q@mail.gmail.com>
Message-ID: <CAL_Jsq+9aMp2w-GUCsvjdm_8n73mSe3idGwn+FMDA4q8oNPQ9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Fix json-schema for Tegra
To: Jon Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Wed, Dec 1, 2021 at 9:57 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> The dt_binding_check currently issues the following warnings for the

dtbs_check

> Tegra186 and Tegra194 SMMUs ...
>
>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dt.yaml: iommu@12000000:
>   'nvidia,memory-controller' does not match any of the regexes: 'pinctrl-[0-9]+'
>         From schema: Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>   DTC     arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dt.yaml
>   CHECK   arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dt.yaml
>
> Add the missing 'nvidia,memory-controller' property to fix the above
> warning.

Thierry sent the same change, but made it required. That's not a
compatible change, but could be justified. Please sort out which one
you need applied.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
