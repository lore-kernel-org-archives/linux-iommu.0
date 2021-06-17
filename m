Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E92BC49361
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 17:17:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A28613FA
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 17:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A28613FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76DA660E67;
	Thu, 17 Jun 2021 17:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rv9sdqVJvHNh; Thu, 17 Jun 2021 17:17:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 65BC360E5D;
	Thu, 17 Jun 2021 17:17:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33C62C000E;
	Thu, 17 Jun 2021 17:17:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCAF0C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 17:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CCFC42238
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 17:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xo102aQUj3Sp for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 17:17:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DBAF4223D
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 17:17:04 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id b37so10006868ljr.13
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+UCmKSCa3QiyF+EVqn93Vr8LzsTTd7mIrDf+DuAyIo8=;
 b=GnIRWtOHp+scyIC0BY9GkWMc6n9RX9972fc1ku9BzR7mGKCasApJoQFVjH+bK68b6b
 nuO7MYsmXkE34O4F++2m2n4VlYsHAsGUuTWd6poGkIJBIaGPRP+gyhi3NeQKdansAuKE
 EnrvYXa7jYZUDOPXQzHXsLLiJhmcbQ/rFcme3BWB9QrEdHrq+qupHgTEUfWRC6gd8g0/
 QWiXmA55VKW5ujqD/HFlrgrWo86hEhnf5TCzPQfkozMhih+2CABhRpdVAcZ7V05l8txb
 XAnZMDk79vW42BxNLCUtSYciT27a6ZeqjLiRFAl5TBrnuHqArdAmWxK8utoCnE6uM400
 vgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+UCmKSCa3QiyF+EVqn93Vr8LzsTTd7mIrDf+DuAyIo8=;
 b=VPl2VlFXTCSiJvtL5aeYtFwAADVzsXXVj1Jq1PanvdhYRSg1+7VkFrkposBfTmCO6S
 oOXWz1oTfAhZjA8oSdmHIuZUUtwypeBgRKtk6zacXCbmUH96yqxMecvrpje5St38Oznp
 umtxfSIuJcOzjxHOrQDlGhTrixa7v90t2vj4KUPNN/oTAgT4LaFaHUIFr9kixtg1XsPn
 pk0va3on+Wjp3Cx+HzuaCGZnwMymF46HRKLCm5euHCDSD+N/81soz1K3HVpCFVv6/W8w
 jiWuwrZaYNBwdMD7U+d8/e3MEns1ik16hTU3Kem2C+3MHeT908VI0Dw6T/l9OnaPMUDX
 YAdA==
X-Gm-Message-State: AOAM532X2WVanYQLlix21JSZVEEr0VZqqxKX45w1inJnqyZyyeVij8V1
 DHg830Ci8opt9oJDE4mbV286mjHUXCMk3qqWWVscnQ==
X-Google-Smtp-Source: ABdhPJxgWkkL8Fk/SBBmYIYiPs9dkdIiTPmkNy2TuzTzUAeR2E1A8icgKJtMe2NusLT2AwOAjvy60BlA3/Wuf8+dzQM=
X-Received: by 2002:a05:651c:604:: with SMTP id
 k4mr5605183lje.244.1623950222030; 
 Thu, 17 Jun 2021 10:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210617145339.2692-1-joro@8bytes.org>
In-Reply-To: <20210617145339.2692-1-joro@8bytes.org>
Date: Thu, 17 Jun 2021 10:16:50 -0700
Message-ID: <CAKwvOd=8jUsRFKg6+sqq2-DakbRBGR6Z6mR_smuxp+cMEmCHLw@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix W=1 clang warning in intel/perf.c
To: Joerg Roedel <joro@8bytes.org>
Cc: Joerg Roedel <jroedel@suse.de>, kernel test robot <lkp@intel.com>,
 Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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
From: Nick Desaulniers via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jun 17, 2021 at 7:54 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Fix this warning when compiled with clang and W=1:
>
>         drivers/iommu/intel/perf.c:16: warning: Function parameter or member 'latency_lock' not described in 'DEFINE_SPINLOCK'
>         drivers/iommu/intel/perf.c:16: warning: expecting prototype for perf.c(). Prototype was for DEFINE_SPINLOCK() instead

I think these warnings are actually produced by kernel-doc? (not clang)

>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 55ee5e67a59a ("iommu/vt-d: Add common code for dmar latency performance monitors")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/intel/perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
> index 73b7ec705552..0e8e03252d92 100644
> --- a/drivers/iommu/intel/perf.c
> +++ b/drivers/iommu/intel/perf.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * perf.c - performance monitor
>   *
>   * Copyright (C) 2021 Intel Corporation
> --
> 2.31.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210617145339.2692-1-joro%408bytes.org.



-- 
Thanks,
~Nick Desaulniers
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
