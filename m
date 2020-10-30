Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDB9C00A89
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 07:29:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5432151B
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 07:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKBxh4rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5432151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3292A20468;
	Fri, 30 Oct 2020 07:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zUI8ZwB1gqut; Fri, 30 Oct 2020 07:29:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 13F9420385;
	Fri, 30 Oct 2020 07:29:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F23FFC088B;
	Fri, 30 Oct 2020 07:29:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67587C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 07:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E31D8711C
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 07:29:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NUfwT7ClifPJ for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 07:29:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 839E087115
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 07:29:45 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id m26so4744160otk.11
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x1HNzlzE8Xe7BCZntASgYibGuSDss2gCPnUeL9DbFBE=;
 b=cKBxh4rpRRVGV2Cb957tV9l6Ra66YSurvzXoClIOYdQY/ei1i3CbqFC9aTTrIw1L2t
 IpYOM8EvHbLuViHSLyypWh/CEEPPMt/liBjWKnCPQMD30F/43wG5NVHyb4FzaOpJhcp4
 vJLo2CfsImacHJBRSJ2iNDGsIhMyu/NJIo8oKczVxCpyg/gj3me0SgywvMjlIxPPqi0o
 ovmtQmRY6jxcKtuZeFQMsyx0iW+FJTAppCCcsB9BnwpJ/vB842bmFm0/xsaWWG/gtJ6m
 JlGg0yAp7p7+OdRV5nASm50hm8DWLYwP6cgXcNN58QQVzEQwQ0yyr84LGcMQ60F24wdu
 DDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x1HNzlzE8Xe7BCZntASgYibGuSDss2gCPnUeL9DbFBE=;
 b=JTxqgf2efsY0xLdaNN9N+OzE4hOGUP1zPdThONQE5jqdkG3zesW5tLrfF1OeFZdCKR
 nutzP+5ysTNUwebh2b9OqZhC9K7G8q93gItnIWlg1vF50QaOlFDqTbeFMHHR0TVe+PP+
 hGMg5dmDjkFMILhj/+prjCxKch2Mx5L5oCEiiaPP5XInje8dceUgLAgYk8C65W+j++kZ
 GP3oz6OLuFwVJ4t7xI94Z5xvfW49/XVaysyKcDs36vpxw3XZa7B+JJc4GWyrNoZKHeoA
 UNdWDgZMf8VTJJCBC/s+0+Ut0bY7ZcyYUkr0ReHsKmRJFPcm4i1HmRVNh1o2BXq3oyuA
 DxZw==
X-Gm-Message-State: AOAM532PVoZfRCdahYMIFpr3niGT1MN+Wnag0hYTXRP3JmJ3iJasoM5X
 i/fOvu13mjZKLPYLOyIXvx2NkN92v8N9E8d+Pf3sqg==
X-Google-Smtp-Source: ABdhPJyPjxqNT05hEOD1VR+nwGQUXUkiOTyHEMAQa+LIPzla6zfvuL4s6VnTUq6JP2szt+CYg3pvlE06kyUuNT13sjg=
X-Received: by 2002:a05:6830:400c:: with SMTP id
 h12mr738486ots.102.1604042984696; 
 Fri, 30 Oct 2020 00:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201030061242.92510-1-john.stultz@linaro.org>
 <20201030061242.92510-2-john.stultz@linaro.org>
In-Reply-To: <20201030061242.92510-2-john.stultz@linaro.org>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 30 Oct 2020 00:29:32 -0700
Message-ID: <CALAqxLVQDEQGfjhyu9y-jzLC727qWdj2h-bDHzag0K3o-niFBw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To: lkml <linux-kernel@vger.kernel.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Todd Kjos <tkjos@google.com>
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

> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
> index 40f91bc8514d8..a490e78890017 100644
> --- a/drivers/net/wireless/ath/ath10k/Kconfig
> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> @@ -44,6 +44,7 @@ config ATH10K_SNOC
>         tristate "Qualcomm ath10k SNOC support"
>         depends on ATH10K
>         depends on ARCH_QCOM || COMPILE_TEST
> +       depends on QCOM_QCM || !QCOM_SCM #if QCOM_SCM=m this can't be =y

Doh. Apologies! I flubbed this line (SCM not QCM).  I'll fix and
resend tomorrow.

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
