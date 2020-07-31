Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD787C433E0
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 05:52:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8F22084D
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 05:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+HPx65f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8F22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2D40A88639;
	Fri, 31 Jul 2020 05:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xvmCuZxYwMEs; Fri, 31 Jul 2020 05:52:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 48ED688642;
	Fri, 31 Jul 2020 05:52:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36C6CC004F;
	Fri, 31 Jul 2020 05:52:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73DD4C004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 05:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3A01120498
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 05:52:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PqdorRNJDj-i for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 05:52:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 803E32048B
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 05:52:38 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id mt12so6353002pjb.4
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jul 2020 22:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Is9oz0WcdC4oayT0KXurF1vgNIwYI6FKERnV58px2yQ=;
 b=T+HPx65fgNudEBURjrQX4qo0u8tnu0dj3iDP1cV+BTCL8y/j4LUor93lChMKi1Jsk+
 vdg9mhmNbqrhL9/udDjUihbN5Bolx1RV8wDqTi5lomByyhQ8dJ4yBgxcielqGHS62Ea7
 rx9xxs5NmTukhbJaOzLTmx/OknOZlhE1tHBWwB0Bi45k68GIGqA7DH65mPwxMsc4OJIe
 GvZvqU28Mnpfeynbn4fyApxImnpsNCDKfN78nVugs8mWGW0rEHNnd0a/vN0NvkpDtyU4
 nrKtl3z8E6o8rnS8LVFBrZh2yKKD006qOH/vwY4THo3iltRqVVrYWuUafHyOnmLnzuIE
 xRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Is9oz0WcdC4oayT0KXurF1vgNIwYI6FKERnV58px2yQ=;
 b=saYkRh6fIlYYjOjDPr6nfhGqIcZ7t1EFN9rnICnAX7Vcf8mxsoFNVoDGKZr8NRWfYp
 XBdkgn/3Gp7bEBqFaZwQCZEkJxPToabHLtrkdq0zLrexCcl1M6D9scubHtJaCcj7EaIo
 y3k72WYovQy4/hac46zCRildZFJ4Au/VbvawoD/IdbvhXOpPrSq2DCnp0SiY+5IpxeHD
 mh7/GBKaq9RuxXpxSbvKH6KJt67G3K63CZGIcE7biC1H54fMsFOF9UWPsY1OterFvfDI
 pzuAFIuyL0A6dip0JkC7gq6qHEhAvYmpN3Sh8lzVbBwPZquy1v833e8q+u86QWp4KhXY
 KpZw==
X-Gm-Message-State: AOAM533BmTzbR7NoHMzDqdJzukuLO1oqrftj5gpO+tJ7CuwLiBiXctZ0
 MzlKteMaPmpzynGaZPt/yFJksw==
X-Google-Smtp-Source: ABdhPJwx3vBThEbfSeGBoL9hNvNZyU1Q4RNIGLqBu9j0WBIoW6X1bMtfz0R1dAPxFdWb26AAhctwbQ==
X-Received: by 2002:a17:90a:fd82:: with SMTP id
 cx2mr2664842pjb.67.1596174757993; 
 Thu, 30 Jul 2020 22:52:37 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id k6sm4360389pfp.87.2020.07.30.22.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 22:52:37 -0700 (PDT)
Date: Thu, 30 Jul 2020 22:48:50 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Konrad Dybcio <konradybcio@gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
Message-ID: <20200731054850.GA20825@builder.lan>
References: <20200704122809.73794-1-konradybcio@gmail.com>
 <20200704130922.GB21333@willie-the-truck>
 <20200705033511.GR388985@builder.lan>
 <CAMS8qEWO-1mNd12Zs-2WogCrgNF5=6RkF=Z1pTeOZxSuKjx+qg@mail.gmail.com>
 <20200721154415.GA5758@jcrouse1-lnx.qualcomm.com>
 <CAMS8qEXNh6n9SpMkPAr8cPneasPvJPELD2TZ4gxUf0byxNePbg@mail.gmail.com>
 <20200721235650.GN388985@builder.lan>
 <CAMS8qEVXGddTdbrPwK3NJMx71HH0hoVyqiJG6-g9tiBRMRYZ8w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMS8qEVXGddTdbrPwK3NJMx71HH0hoVyqiJG6-g9tiBRMRYZ8w@mail.gmail.com>
Cc: DTML <devicetree@vger.kernel.org>, skrzynka@konradybcio.pl,
 Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 John Stultz <john.stultz@linaro.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Wed 22 Jul 13:11 PDT 2020, Konrad Dybcio wrote:

> >Is the problem on SDM630 that when you write to SMR/S2CR the device
> >reboots? Or that when you start writing out the context bank
> >configuration that trips the display and the device reboots?
> 
> I added some debug prints and the phone hangs after reaching the
> seventh CB (with i=6) at
> 
> arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
> 
> line in arm_smmu_device_reset.
> 

Sounds like things are progressing nicely for a while there, presumably
until the next time the display is being refreshed.

Would you be willing to try out the following work in progress:
https://lore.kernel.org/linux-arm-msm/20200717001619.325317-1-bjorn.andersson@linaro.org/

You need to adjust drivers/iommu/arm-smmu-impl.c so that
arm_smmu_impl_init() will invoke qcom_smmu_impl_init() as it spots your
apps smmu.

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
