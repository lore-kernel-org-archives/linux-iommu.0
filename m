Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA17C432C0
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 18:38:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B120E207DD
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 18:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pETy2f8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B120E207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 72E0C2277A;
	Wed, 27 Nov 2019 18:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id THPwZ-qozRjE; Wed, 27 Nov 2019 18:38:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6CBD32154E;
	Wed, 27 Nov 2019 18:38:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64545C1DD5;
	Wed, 27 Nov 2019 18:38:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D2E9C0881
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 18:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 47EDC8329B
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 18:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hdZvIhOF0L4w for <iommu@lists.linux-foundation.org>;
 Wed, 27 Nov 2019 18:38:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7B57B8263D
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 18:38:42 +0000 (UTC)
Received: by mail-qt1-f194.google.com with SMTP id y39so26382582qty.0
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=wdp1lywqmKgyuKU1G9KHrqyijHJooeS6kbCPCzKFfhw=;
 b=pETy2f8iLffpdhZh+eVuVvnU3GhOO1uvMItulY+h7B3z85q6xdoNYd4SKAstjtNEvB
 8BJ5NgiNYX/Fio5ruP0etID8HD3CQP+lpSz1GKxz74Vo0ee9rgUHWK/kIDavvhRzf+Si
 vuOKZi2OE49OG9mPUdlJfMRkEE3ZYcTtRGC2uYBTv6reipUO2En4vIHVcCSI9e+Mo9ms
 0AFi67qx/YHk4j1ZfaKdoYBxt1nk6PWRNsS10d15FWf5FwYEiuH77ac6cCzKjMDOwu6/
 ISiJMPFZW02dTFvIEvRdQ6jJxYGiTscLb8e4fXne/hIccz8E+BkRJyV+ckSXg4rghckV
 /e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=wdp1lywqmKgyuKU1G9KHrqyijHJooeS6kbCPCzKFfhw=;
 b=krlPr4TGgb/iCgr3TRojRQPo1mrTAhRmo6NQ83fp610xMRqtjdhWvPdie5Reh3EA95
 DHS7c9MTRPeIqft1X98cakdVFu2XSO+RP/TwftscrNU0YCzGSRm6im0hutoylZ8Qzns/
 JX1ct1Xmzgs/0u/NMsz8g6Xkm5fnb7pTI+HOKTaTY1kGnzUGQig43tJaZxuLZDoIRFc3
 nRaSgXhPSW1m0vC9DosaAOPbKGztf93C7AiitPzBq/DAO4zkQCIIB9aneSWFPSODoV2n
 7oQQrqiMSZqtg1nDfNZRu7dYQ9mghRbplLMk8VyB8Odlf5QVeqvGEOsEJCu7tnxe2QAU
 gpOA==
X-Gm-Message-State: APjAAAVGNeBFByh1DlH2esHzQfj4dWwumCv1yHI9eAOL3KJ6NTPZ8ouT
 scHQAI4McneNoF4BGtw7q14ZoqAHmBjTDQ==
X-Google-Smtp-Source: APXvYqyqhtOn92/ve8YTh8k7+IFMsV1kDxuJs8W1r/wyRn3LTpEBKCwZy8HajcqXt77kdv+Abk7yaQ==
X-Received: by 2002:ac8:7612:: with SMTP id t18mr30473363qtq.143.1574879921076; 
 Wed, 27 Nov 2019 10:38:41 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id o62sm2739257qte.76.2019.11.27.10.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 10:38:40 -0800 (PST)
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] iommu: match the original algorithm
Date: Wed, 27 Nov 2019 13:38:39 -0500
Message-Id: <FD54B9BA-53FE-4CF0-954F-8DC8418DAE3F@lca.pw>
References: <9ac29292-bc3d-ae57-daff-5b3264020fe2@huawei.com>
In-Reply-To: <9ac29292-bc3d-ae57-daff-5b3264020fe2@huawei.com>
To: John Garry <john.garry@huawei.com>
X-Mailer: iPhone Mail (17A878)
Cc: Cong Wang <xiyou.wangcong@gmail.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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



> On Nov 27, 2019, at 1:01 PM, John Garry <john.garry@huawei.com> wrote:
> 
> I haven't gone into the details, but this patch alone is giving this:
> 
> root@(none)$ [  123.857024] kmemleak: 8 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> 
> root@(none)$ cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff002339843000 (size 2048):
>  comm "swapper/0", pid 1, jiffies 4294898165 (age 122.688s)
>  hex dump (first 32 bytes):
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>  backtrace:
>    [<000000001d2710bf>] kmem_cache_alloc+0x188/0x260
>    [<00000000cc229a78>] init_iova_domain+0x1e8/0x2a8
>    [<000000002646fc92>] iommu_setup_dma_ops+0x200/0x710
>    [<00000000acc5fe46>] arch_setup_dma_ops+0x80/0x128
>    [<00000000994e1e43>] acpi_dma_configure+0x11c/0x140
>    [<00000000effe9374>] pci_dma_configure+0xe0/0x108
>    [<00000000f614ae1e>] really_probe+0x210/0x548
>    [<0000000087884b1b>] driver_probe_device+0x7c/0x148
>    [<0000000010af2936>] device_driver_attach+0x94/0xa0
>    [<00000000c92b2971>] __driver_attach+0xa4/0x110
>    [<00000000c873500f>] bus_for_each_dev+0xe8/0x158
>    [<00000000c7d0e008>] driver_attach+0x30/0x40
>    [<000000003cf39ba8>] bus_add_driver+0x234/0x2f0
>    [<0000000043830a45>] driver_register+0xbc/0x1d0
>    [<00000000c8a41162>] __pci_register_driver+0xb0/0xc8
>    [<00000000e562eeec>] sas_v3_pci_driver_init+0x20/0x28
> unreferenced object 0xffff002339844000 (size 2048):
>  comm "swapper/0", pid 1, jiffies 4294898165 (age 122.688s)
> 
> [snip]
> 
> And I don't feel like continuing until it's resolved....

Thanks for talking a hit by this before me. It is frustrating that people tend not to test their patches properly  with things like kmemleak.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
