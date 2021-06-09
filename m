Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE28C47095
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 09:44:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7D6613AC
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 09:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7D6613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F292783C23;
	Wed,  9 Jun 2021 09:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fZK7yJeBOWWf; Wed,  9 Jun 2021 09:44:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0126283C0B;
	Wed,  9 Jun 2021 09:44:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD0FFC000E;
	Wed,  9 Jun 2021 09:44:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB82DC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA26F4034B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s1AOH-xoavgT for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 09:44:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 745394033C
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:44:12 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id l2so24754730wrw.6
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=n+lFdIy/Fj8w641ouj5kQ8wz/6ZZG0ZHAWeOT4yzbRc=;
 b=AT64ZswDoaXLxTV5klTqoMfaholatkhAgnHUHUWahtJmGmuFXvejIFYV2hDEh4Rk3O
 PDGIZWSNjngAhf2i1GUAhAuRbdZyt4r4L6BOpuInByx9+QeUJVeV0PHMpVrQd7krsSxF
 /tBikZ50LsePM25jiogN+MPuP137zS1/Bpq+O9862lzK7vprtdrHBr+1FbJaCQYp1zBw
 xiOZYCS9lSQUuALZaaPZwSyTm392hcZhtCagAm+d01KNzUVdfqo7smulok/Utmwxg2vt
 DTGcUvy0B+AAEAhMD5XTQvmSSbd/mI0FqHAy2In9nE5SA87kIDLgx8Q2hR5YA3dBRMXw
 8cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=n+lFdIy/Fj8w641ouj5kQ8wz/6ZZG0ZHAWeOT4yzbRc=;
 b=DofMtSGroPdk9jt7S82HLzZ7G9yZoWdRVsDFM746XGjhxPEXg1gWqCDFT2QTiE4Ybk
 TOdAqlBKV0U7HJAkyZPE4tXzsBGzCmVMzcU9Ste/0OHmb/wBcdUfCbFOVW24opGAP+R8
 d5utHJ8r0V9tnMRlpBhre9ItLdW8aIwhRYB/NUuFz19lCEVsxkUiGs9fEwGYaQ7przRh
 /0buwyLqVl1hEv/vjCdiA6AiVpTTlVk9fSdogYA1BcsFK5nGQchNAq095nu7DddVUbRW
 ATCj4voLzwkrs5/OgSZvHWwAPmGTq/zzPBLGMu9kqPYQgh4Q+JhZ2HDLfJs2sk4eOEth
 MO/A==
X-Gm-Message-State: AOAM5325YdVxfW6qxF5ko9n1RIuNpRmp5MgfBcHvnjg0dwbBX+kOv5kW
 nnFeE2YU6YVazfc9BsBcyT93vQ==
X-Google-Smtp-Source: ABdhPJwO3THpKtkdcUWrskaIYkB0u8maKDhXBCguE9TgSQU4qzM70G7eqJmGWmGYL8J1rMvvo9H1PA==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr27346967wrw.228.1623231850644; 
 Wed, 09 Jun 2021 02:44:10 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id m23sm6757801wml.27.2021.06.09.02.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jun 2021 02:44:10 -0700 (PDT)
Date: Wed, 9 Jun 2021 11:43:52 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v15 0/3] iommu/arm-smmu-v3: Add stall support
Message-ID: <YMCNWOkJ/xi2Yv1U@myrica>
References: <20210526161927.24268-1-jean-philippe@linaro.org>
 <162314710744.3707892.6632600736379822229.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <162314710744.3707892.6632600736379822229.b4-ty@kernel.org>
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com, guohanjun@huawei.com,
 rjw@rjwysocki.net, robin.murphy@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 zhangfei.gao@linaro.org, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Tue, Jun 08, 2021 at 12:42:34PM +0100, Will Deacon wrote:
> On Wed, 26 May 2021 18:19:25 +0200, Jean-Philippe Brucker wrote:
> > Add stall support for SMMUv3, enabling I/O page faults and SVA for
> > compatible devices. No change since last version [1], but I'd still like
> > this to be considered for upstream, because there exists hardware and
> > applications.
> > 
> > Stall is implemented by the Kunpeng 920 processor for its compression
> > and crypto accelerators, with which I tested the SVA infrastructure.
> > Using the userspace accelerator API [2], a program can obtain a queue
> > from one of these devices and submit compression or encryption work
> > within the program's address space. UADK [3] provides a library to do
> > this, and there is an openssl plugin [4] to use it.
> > 
> > [...]
> 
> Applied to will (for-joerg/arm-smmu/updates), thanks!
> 
> [1/3] dt-bindings: document stall property for IOMMU masters
>       https://git.kernel.org/will/c/ed1d08b9d0c9
> [2/3] ACPI/IORT: Enable stall support for platform devices
>       https://git.kernel.org/will/c/6522b1e0c78f
> [3/3] iommu/arm-smmu-v3: Add stall support for platform devices
>       https://git.kernel.org/will/c/395ad89d11fd
> 

Thanks!  That concludes most of the SVA work. For SMMUv3 we still need to
figure out DVM, there will be PRI at some point, and I'm sure some
bugfixes but I don't plan to send any other major feature support for the
next cycles.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
