Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3733CC2D0A3
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 01:02:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592C520720
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 01:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="voOINdGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592C520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AC86486ADF;
	Fri, 30 Oct 2020 01:02:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nJz-ij3JgOe1; Fri, 30 Oct 2020 01:02:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2313185F51;
	Fri, 30 Oct 2020 01:02:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0757CC0859;
	Fri, 30 Oct 2020 01:02:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21F44C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 01:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0F17E86276
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 01:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SLDwZz0nbmW0 for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 01:02:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 440E785F51
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 01:02:27 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id n11so4217108ota.2
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 18:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8v0LR09o1q2keQ82icRFIanZ6SYH95u30bGsIWz70wM=;
 b=voOINdGME5r7SS40N5xJySdvVN2o5El+ut5jOWRTCcL4LahtOQKhNXT6J4urs1LTou
 EjsoCnUTqjs/mkPjJFz5DatBjwFhZ5PaeFK4ceTrY3kvthmHVw6z2LRxVI5KDuPDX7LY
 5uz9W+BYYLErVIKqRUcpumgTWYjPLt3JU/sGil+oilksaiRN9TfB5NM1N9U2ymv4cokn
 FBUleI8FOWmszEzDFwyLTooqujrIaQ09FE+X8gswkFeMKWGVAPUZNaeZ7+aUcsT/9j76
 6+1+/pJKAjIKf2EjZIRgIQQUliUJddMkg1D3HmHux0/vSzjhR/qbdMcTP/cck0eOGPt9
 R8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8v0LR09o1q2keQ82icRFIanZ6SYH95u30bGsIWz70wM=;
 b=MG7hBpxzCHdhU4cHIHAalDxp2O1gTBeg6Te8MKMCGS0nqgfgsPD2PTZnw42ILzn/9T
 /MX/l/2sWu1FRFJSrTsuSPGjpP3vVY0X1zHsgLZEk0kmdKpP1x4ZYMIFt/19XEuXkIMk
 Pmd75tHfkpImTkv9JlwjeLPp1K9hizZHCe7ggfmaqHKfgAEIuuVvXlOov6Qo+rTrVFkA
 oHjdOEUwWv15Q9mzRaP7YiaAR6EhaBPqHy7ETWnAITY/8i42e5AoFUFz1dvopF2y0D0g
 bFbHooBIo+vpS3EVHYs0U+h1fXrWxVyEuMYn5oYKtctHPBQ1QK8+Mdt9XElOQnEsAKfM
 7kYA==
X-Gm-Message-State: AOAM532ia1/DCv3B4tc6jDM+WHWcmvmG4HlDQBjEg++6HB6943HO6fji
 BqX/ow4oJMcczH//DMmmSbS4yeJIPNeLDjw0yQ7Shg==
X-Google-Smtp-Source: ABdhPJwTerSintYpMU7viWh2jWbkoDcom7lThKWTj8gvIHMRVeH+6XC8I1DuN16tS2twPZYOVGa/qvLBx0z24Bqky0Y=
X-Received: by 2002:a05:6830:1558:: with SMTP id
 l24mr5088291otp.352.1604019746421; 
 Thu, 29 Oct 2020 18:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200625001039.56174-1-john.stultz@linaro.org>
 <20200625001039.56174-6-john.stultz@linaro.org>
 <20200702141825.GA16941@willie-the-truck>
 <CALAqxLVZ2EhutYjOt7Be1RgnYwHT6-4m6DxA-t1wuxuSy=6yDQ@mail.gmail.com>
 <20200710075411.GA30011@willie-the-truck>
 <CALAqxLWadLrxckRHRAR0Q417RnFKquQJbRfO_DLEVH56cykRow@mail.gmail.com>
 <20200713204133.GA3731@willie-the-truck>
 <CALAqxLUDVEq4ds2Wbic6uaK3=dELKKO4eGQxjHFFz19GeUFd_w@mail.gmail.com>
 <20201028135118.GA28554@willie-the-truck>
 <ae6ba27a-d3c8-8b98-c263-ec779ef35738@arm.com>
In-Reply-To: <ae6ba27a-d3c8-8b98-c263-ec779ef35738@arm.com>
From: John Stultz <john.stultz@linaro.org>
Date: Thu, 29 Oct 2020 18:02:14 -0700
Message-ID: <CALAqxLW13=cvTX3ghskb9uG_YoVh7kvp8UQGUB8mVDGYXHWpVQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To: Robin Murphy <robin.murphy@arm.com>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
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

On Wed, Oct 28, 2020 at 7:51 AM Robin Murphy <robin.murphy@arm.com> wrote:
> Hmm, perhaps I'm missing something here, but even if the config options
> *do* line up, what prevents arm-smmu probing before qcom-scm and
> dereferencing NULL in qcom_scm_qsmmu500_wait_safe_toggle() before __scm
> is initialised?

Oh man, this spun me on a "wait, but how does it all work!" trip. :)

So in the non-module case, the qcom_scm driver is a subsys_initcall
and the arm-smmu is a module_platform_driver, so the ordering works
out.

In the module case, the arm-smmu code isn't loaded until the qcom_scm
driver finishes probing due to the symbol dependency handling.

To double check this, I added a big msleep at the top of the
qcom_scm_probe to try to open the race window you described, but the
arm_smmu_device_probe() doesn't run until after qcom_scm_probe
completes.

So at least as a built in / built in, or a module/module case its ok.
And in the case where arm-smmu is a module and qcom_scm is built in
that's ok too.

Its just the case my patch is trying to prevent is where arm-smmu is
built in, but qcom_scm is a module that it can't work (due to build
errors in missing symbols,  or if we tried to use function pointers to
plug in the qcom_scm - the lack of initialization ordering).

Hopefully that addresses your concern? Let me know if I'm still
missing something.

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
