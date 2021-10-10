Return-Path: <SRS0=jhW9=O6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952C6C433EF
	for <iommu@archiver.kernel.org>; Sun, 10 Oct 2021 17:42:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC8E60EE4
	for <iommu@archiver.kernel.org>; Sun, 10 Oct 2021 17:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3AC8E60EE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09DC182848;
	Sun, 10 Oct 2021 17:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZzuQV5kf2IH; Sun, 10 Oct 2021 17:42:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E641182784;
	Sun, 10 Oct 2021 17:42:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B768AC0011;
	Sun, 10 Oct 2021 17:42:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1E58C000D
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 17:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5FFC60669
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 17:42:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YXgjh6Feyt6v for <iommu@lists.linux-foundation.org>;
 Sun, 10 Oct 2021 17:42:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C671605FD
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 17:42:19 +0000 (UTC)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MirSu-1nETMb3McW-00etPt for <iommu@lists.linux-foundation.org>; Sun, 10 Oct
 2021 19:42:17 +0200
Received: by mail-wr1-f41.google.com with SMTP id o20so47997826wro.3
 for <iommu@lists.linux-foundation.org>; Sun, 10 Oct 2021 10:42:17 -0700 (PDT)
X-Gm-Message-State: AOAM531uoLmpKfwRYP5GsqRcUOEgbALitDh0tH7avcsWzwtMsHvEknki
 rh/7iv2GRbBbammmf8ypBP9Mxi8jjjZeK0eTBU0=
X-Google-Smtp-Source: ABdhPJxAjKU8yfXgt2rjYVImjIKCImbIW4poCzzJGpBcz8kno/AlWQFANYktYRG2caQHUL2ye2HhyFkPp3obwvzre5s=
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr6006483wma.98.1633887737269;
 Sun, 10 Oct 2021 10:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211010023350.978638-1-dmitry.baryshkov@linaro.org>
 <YWJpJnaQ2Nr4PUwr@yoga>
In-Reply-To: <YWJpJnaQ2Nr4PUwr@yoga>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 10 Oct 2021 19:42:00 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
Message-ID: <CAK8P3a3irqEVH2e9wCK4MSSBKRW-n8pFSzYBks9ri-hepewkUw@mail.gmail.com>
Subject: Re: [PATCH] iommu: fix ARM_SMMU vs QCOM_SCM compilation
To: Bjorn Andersson <bjorn.andersson@linaro.org>
X-Provags-ID: V03:K1:AQoRvVtQ646JNA6FZwDyf4utLAc1aoq10ALMAirmo4fCmpIGsP4
 sz4itH7yYtG6AAegqtj6s6KoKr+XKVFecuRgj4ibubFvcrrNCwe8YX814TRZ6N+se+5sO9m
 4qDvr/YJmJu+/2Mp0JbHt2QoX5UY+qLuWCdi7IEMYNbiDyovvEY2pjjiinQlrjxrKn1EEYb
 3h2KZ0ClCktQKeX+kfDCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ihID6QCAQhU=:IJiWDzmJkRTBDLtJc8LJKG
 BaKTNCdE59ydsYQSSQIt2PILm5kEr1ymmxDHw4bBWQmX5LK8SO5QHDw12JJgva+XmT6OH2buu
 TFVWanAe4qJW+MjOHWXc24RcLfxALrPCKn7AaP3iUH/WagxH+h37upoICYNDTe1QEl8fPgKm+
 hp4HIOLcKZfb4iPeHBjJLPeY8ppin8ERTLvFmE8cWInSaj7mdM5+yE9mMgr48zXA0vH9UjUAT
 61B2UJzo9y/t8aTUCCwon3422Cf+3Uq/Ux9GgAPPA8wJXzUuWUZrwLliHvhPmXCzVwv1R2NMa
 ruztMasT0u5TwFhT5/uL53yz6tiFmUH6wKQ2avSCw4I/VnGXtSEF9ThfdG2ztIb01GlZ2WRDB
 w1RGQanbNR58X8Q0rteo4gbCZBfYlsVJsJtgf+a3t7Lr1M+0yyx9k3pBk1GIXxMlvPqbp//4Q
 CCTuJSGXnECtxeEHK5Hbcnv+nlGy3aSWyF1JX8k0hc0oeEj4sArfHCFV+hdfVw6vB5AKriTa8
 d/ld8ZF/t/B8grCtG/QzTJ3O5OYeQQYu2UnZfd8vCJN1x3DnzeC6d7Ua6TAx28+UgADI+qltz
 U8Ej7UHmPjumBJcO3ARwXBYy8Z0E2UKw1ukFf70QQM3vGic2GTp+P7cTbJvBP0xBhT7Tn/YXT
 GPuL6ivBpLnETNoUgEn6vWOk1gUxMnXR8QzV+XYX5wihoePXdEXoL9l5IwjydayBZ8C+B0o7o
 5dY7+SuuAdL7//dWncmaw/94iCkFsGNeoglyVfThDcuwKYu5qtAxSDugMyoAWCsTTc7TG52Jn
 Fx1Cjy1RJFuEg81mdtPIJfErlJ+CEMYVgJmcVKfZHZutYAD9Nm7YCrT2wkAtmbRd2nDzdqEEx
 evpRjKvfhjX3lzw3NH9g==
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Kalle Valo <kvalo@codeaurora.org>
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

On Sun, Oct 10, 2021 at 6:17 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Sat 09 Oct 21:33 CDT 2021, Dmitry Baryshkov wrote:
>
> > After commit 424953cf3c66 ("qcom_scm: hide Kconfig symbol") arm-smmu got
> > qcom_smmu_impl_init() call guarded by IS_ENABLED(CONFIG_ARM_SMMU_QCOM).
> > However the CONFIG_ARM_SMMU_QCOM Kconfig entry does not exist, so the
> > qcom_smmu_impl_init() is never called.
> >
> > So, let's fix this by always calling qcom_smmu_impl_init(). It does not
> > touch the smmu passed unless the device is a non-Qualcomm one. Make
> > ARM_SMMU select QCOM_SCM for ARCH_QCOM.

Sorry about this bug. I was sure I had it working, but I lost part of the commit
during a rebase, and my randconfig builds still succeeded without it, so I
sent a wrong version.

> Arnd's intention was to not force QCOM_SCM to be built on non-Qualcomm
> devices. But as Daniel experienced, attempting to boot most Qualcomm
> boards without this results in a instant reboot.
>
> I think it's okay if we tinker with CONFIG_ARM_SMMU_QCOM for v5.16, but
> we're getting late in v5.15 so I would prefer if we make sure this works
> out of the box.

Yes, makes sense. For reference, see below for how I would fix this properly,
this is what I had intended to have in the patch. Feel free to pick
either version
as the immediate bugfix. I'll give the below a little more randconfig testing
overnight though. The pasted version of the patch is probably
whitespace-damaged,
let me know if you would like me to send it as a proper patch.

       Arnd

8<-----
Subject: iommu: fix ARM_SMMU_QCOM compilation

My previous bugfix ended up making things worse for the QCOM IOMMU
driver when it forgot to add the Kconfig symbol that is getting used to
control the compilation of the SMMU implementation specific code
for Qualcomm.

Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c5c71b7ab7e8..2dfe744ddd97 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -311,6 +311,7 @@ config ARM_SMMU
        select IOMMU_API
        select IOMMU_IO_PGTABLE_LPAE
        select ARM_DMA_USE_IOMMU if ARM
+       select QCOM_SCM if ARM_SMMU_QCOM
        help
          Support for implementations of the ARM System MMU architecture
          versions 1 and 2.
@@ -355,6 +356,13 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
          'arm-smmu.disable_bypass' will continue to override this
          config.

+config ARM_SMMU_QCOM
+       def_bool y
+       depends on ARM_SMMU && ARCH_QCOM
+       help
+         When running on a Qualcomm platform that has the custom variant
+         of the ARM SMMU, this needs to be built into the SMMU driver.
+
 config ARM_SMMU_V3
        tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
        depends on ARM64
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
