Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277C0ECE588
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 12:34:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16BE20854
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 12:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVPxJXaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16BE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B567CDE1;
	Tue, 15 Oct 2019 12:34:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 477F3491
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 12:34:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9ACD08B0
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 12:33:59 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id p7so20690778wmp.4
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 05:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=pta6WG0m1licwTELBUahHWPs5ve4bkpHKrIjLjCTFXo=;
	b=pVPxJXaEKScekgPoPiNAztYkLRcCZHIbAT9TrvXta0ONBRWEGtWWmDyDTvU4IALvw6
	p52Mouf6ymoyAv56OHrE7V9tM+AV30j8jcB+BwQIc29tsM8G5QjyF1wzLxreWY+g2kIc
	zEo2p+9kLl6C6eb2RyRmD5yuA/z2ekFqFwJJpd9siU1dhmGrj+DN0oKxsYzjdBVm422O
	eo+Rt+HV36fr2zGHuTHHchy7uVFaSxNbSMzQFcE2zZt544Gp16hAzbNAFrYBD7lQes1Y
	kceoEPVazIrBythxCusA2aVFbRNfHg/CSzNBY8XdslzAbkSAxzZfnU3XAsn4AYvKGlth
	nlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=pta6WG0m1licwTELBUahHWPs5ve4bkpHKrIjLjCTFXo=;
	b=PWhxTWfG8E9P6NgQlaVcfB39pz4hr7hNhEGVhJvGNejE89UWB+5P+buYYJhrviejX1
	HXONZ57VHkkyYASssCbxbeEEqqirUQrcaARIu/6+VfgcaA/kNAm5kL6/ZbkskxIt/bRW
	dyFQYaHmQkz4N1TZcwxK/S5dnKG7W5nYFAl05+0KMT3FFzs4n+nnlvCou0XYJ+LLqeYS
	Nn50o95TNdEOC79UAszpMb5t+2mK+8rR6A9YgEkadDuXKh9x3fstZ3FzqbOxETztukxx
	M3N+MYpXca/Um1EjCl6ATM/HmWYYWF6Xf4nr6mqjaiCxRIaQkEMWBbWIwJJOQc9PPbux
	jP+g==
X-Gm-Message-State: APjAAAXpLV0MWKjUITOIITc3wSIh8Gsq0ITWj3ayxry2xhMmXvwQcYXK
	xrdQY9RGjow3T/gGvggiMCEX42ZsiEwHE8wxdsU=
X-Google-Smtp-Source: APXvYqwfSxDz4F0TO4TR3MMN5xI7DrzuI/j7paSKEi/qey1AGBdwGOds15+WV0NSvEUuUdy9kHQCCY1WBrnecFqjjwo=
X-Received: by 2002:a7b:c4d4:: with SMTP id g20mr17887838wmk.123.1571142838002;
	Tue, 15 Oct 2019 05:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191001220205.6423-1-kholk11@gmail.com>
	<20191001220205.6423-2-kholk11@gmail.com>
	<20191015111454.GG14518@8bytes.org>
In-Reply-To: <20191015111454.GG14518@8bytes.org>
From: AngeloGioacchino Del Regno <kholk11@gmail.com>
Date: Tue, 15 Oct 2019 14:33:47 +0200
Message-ID: <CAK7fi1YZXW=mqC5HWtfBWsioAq-duejAk6RgtD8npKZR=af38w@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] firmware: qcom: scm: Add function to set IOMMU
	pagetable addressing
To: Joerg Roedel <joro@8bytes.org>
Cc: MSM <linux-arm-msm@vger.kernel.org>, iommu@lists.linux-foundation.org,
	Andy Gross <agross@kernel.org>, marijns95@gmail.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Il giorno mar 15 ott 2019 alle ore 13:14 Joerg Roedel
<joro@8bytes.org> ha scritto:
>
> On Wed, Oct 02, 2019 at 12:01:59AM +0200, kholk11@gmail.com wrote:
> > From: "Angelo G. Del Regno" <kholk11@gmail.com>
> >
> > Add a function to change the IOMMU pagetable addressing to
> > AArch32 LPAE or AArch64. If doing that, then this must be
> > done for each IOMMU context (not necessarily at the same time).
>
> This patch lacks a Signed-off-by.
>

I'm sorry for that. Should I resend or is it enough for me to write it here?

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
