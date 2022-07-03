Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49788C433EF
	for <iommu@archiver.kernel.org>; Sun,  3 Jul 2022 12:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBB1D81D18;
	Sun,  3 Jul 2022 12:33:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BBB1D81D18
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=LHTZ6sd9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pbc1F5XxvHGw; Sun,  3 Jul 2022 12:33:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 88F7181BC6;
	Sun,  3 Jul 2022 12:33:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88F7181BC6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC07C0032;
	Sun,  3 Jul 2022 12:33:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B1EBC002D
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 10:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2279F40123
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 10:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2279F40123
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=LHTZ6sd9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PVLGZoq2G4ZP for <iommu@lists.linux-foundation.org>;
 Sun,  3 Jul 2022 10:47:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1823640017
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1823640017
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 10:47:22 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id z19so8197671edb.11
 for <iommu@lists.linux-foundation.org>; Sun, 03 Jul 2022 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :content-transfer-encoding:user-agent:mime-version;
 bh=xtZe00jcrHCWayegr58xFfUp2h3js8Bof36AjGw58FU=;
 b=LHTZ6sd9Ylw0mhtbQPt/yWf3J9vu7LgLvrQ2hPvUPpfNDO/Mv4xdqmhAlOM4oVSz9+
 yP+pH7VDq5J0bfVfFX/4ofM9et9VoauQO6/67ZpO5wlZ7/nxqo8QY/sZW9qbGIMFESzJ
 y2GhjpLU1+yjhJ3o7oruqb/tO9oUHnpq3BD1WJwxTuMrbGBwkysz2KQxInZkjmd2+HKo
 9hnAbYIlJrkOlO7IkbhGKjceeqBoVi9MdS994NI3MopaLTCo2YpYK4VAArGhkCsc/AN0
 scmcnr6I9vskBSXS5H3VqnLI42uKWD0fhbgUMkZD+dkgc7swGyy/1Rn/cwisYL3CB/z3
 es1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:content-transfer-encoding:user-agent:mime-version;
 bh=xtZe00jcrHCWayegr58xFfUp2h3js8Bof36AjGw58FU=;
 b=GhKr59vsMEbPHjlVJCtwxswiwR5HyOTPCrO4DqEZZAvlGbnU+NmBJaZPMrs0DerOX1
 ZiYHwSn4lILxSv9p2RGm5hhPWGxc98zM70Zss4yeRNzJucR1HXRYV+YnhUPUwJ45Qj1P
 g5QKbXXduGO3Xfovp3fqdYeDjwr6ZbHBC2gY016/C9eR/9h9krWaRS8zi56iXvux5piX
 o9WCkHMxBVtYCh4bo7h3rW2kRCogl5r9Ixtkqqp9vvAvgEBIdfVt9HN8QoWqh2x9ar6p
 D/4SeLFKZtxKDXNUzcu7weOmVS1A5N/x2Tk2Ss1qcKHGVlK02lpeOX7VJ6hmcBkzSL5m
 Q21w==
X-Gm-Message-State: AJIora9RScHKg2zGs4deGtM5SDRjDIvOJTHiJL6KSKXVKEowhLBwZAi4
 XMNgg3pHPnQqPO6vU98Bbco=
X-Google-Smtp-Source: AGRyM1tGVPJyIq3szdnRuDtIIMLXe+/hYDrptJIGBirIXbjThF7HJVmbD5r7tXNhzxzCPtbySChhdA==
X-Received: by 2002:a05:6402:1e88:b0:435:bf05:f0f with SMTP id
 f8-20020a0564021e8800b00435bf050f0fmr31256381edf.2.1656845241327; 
 Sun, 03 Jul 2022 03:47:21 -0700 (PDT)
Received: from ?IPv6:2a02:ab88:368f:2080:5d6e:322:57b6:5f03?
 ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
 by smtp.gmail.com with ESMTPSA id
 kw24-20020a170907771800b0072a3216c23asm5791972ejc.154.2022.07.03.03.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 03:47:20 -0700 (PDT)
Message-ID: <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
Subject: Re: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
From: David Virag <virag.david003@gmail.com>
To: Sam Protsenko <semen.protsenko@linaro.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>
Date: Sun, 03 Jul 2022 14:47:20 +0200
In-Reply-To: <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com>
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com>
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 03 Jul 2022 12:33:15 +0000
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux.dev,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Cho KyongHo <pullip.cho@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-arm-kernel@lists.infradead.org
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

On Sun, 2022-07-03 at 00:48 +0300, Sam Protsenko wrote:
[...]
> Hi Marek,
> 
> As I understand, you have some board with SysMMU v7, which is not VM
> capable (judging from the patches you shared earlier). Could you
> please somehow verify if this series works fine for you? For example,
> this testing driver [1] can be helpful.
> 
> Thanks!
> 
> [1]
> https://github.com/joe-skb7/linux/commit/bbadd46fa525fe1fef2ccbdfff81f7d29caf0506

Hi Sam,

Not Marek here, but I wanted to try this on my jackpotlte (Exynos
7885). The driver reports it's DPU sysmmu as version 7.2, and manually
reading the capabilities registers it looks like it has the 2nd
capability register but not the VM capability.

After applying your patches, adding your test driver (with SYSMMU_BASE
corrected to 7885 value), and adding the sysmmu to dt, I tried to cat
the test file that it creates in debugfs and I got an SError kernel
panic.

I tried tracing where the SError happens and it looks like it's this
line:
	/* Preload for emulation */
	iowrite32(rw | vpn, obj->reg_base + MMU_EMU_PRELOAD);

Trying to read the EMU registers using devmem results in a "Bus error".

Could these emulation registers be missing from my SysMMU? Do you have
any info on what version should have it? Or maybe some capability bit?
I'll try testing it with DECON/DPP later and see if it works that way.

Best regards,
David
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
