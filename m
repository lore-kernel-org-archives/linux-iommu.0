Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568C4C11F65
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 12:59:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B02A6140B
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 12:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B02A6140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB40183B4E;
	Wed, 30 Jun 2021 12:59:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DolHiG3U-ajt; Wed, 30 Jun 2021 12:59:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BE09F83B3A;
	Wed, 30 Jun 2021 12:59:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78ABDC001A;
	Wed, 30 Jun 2021 12:59:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 681C6C000E
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 12:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 555CB83B42
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 12:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MJ2aN86TpBsh for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:59:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4238083B3A
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 12:59:47 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B50961364;
 Wed, 30 Jun 2021 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625057986;
 bh=4UI5RKPIij7TUgl1lgCZCSJpLQ2Uyt70B7pj+JIfU14=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dU0v1zwuPzsz8RuFIlMI7GqlG64x4T7MGB7PSTKUoHcWcPgpIRNzgVIVu5MLB4Uvs
 1A8/Wmc++QCeqkzSJOHkRFhPZhAjb9R0zKhRNB1Ob4lQ+dTuYzUSs7/0Enx6Myzgvc
 FNyFQ010U0PvFlOFUytjoYE+NyOaFbCdhJX8bpRLGGCEqb8PrONHUSNI9xUgBbkeNl
 hlrjZnBcz7csJ9FIWy5d5CD6EJfN6S87J9X5kUs3/6Nr1sn7F/OjVbz7p0CmwH65sj
 QPkqz2gnczZWWQm7cpqLA7HOAwZzVM7vXNyj9bME416DpUTo763YA/kQZ5QsMngLdL
 agMk7aRtUe27w==
Date: Wed, 30 Jun 2021 13:59:40 +0100
From: Will Deacon <will@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] iommu/arm: Cleanup resources in case of probe error path
Message-ID: <20210630125940.GA8515@willie-the-truck>
References: <20210608164559.204023-1-ameynarkhede03@gmail.com>
 <CGME20210630124816eucas1p27563f0a456c0196e20937619aa2f8d26@eucas1p2.samsung.com>
 <26f6a765-37c8-d63a-a779-384f095d5770@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26f6a765-37c8-d63a-a779-384f095d5770@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Amey Narkhede <ameynarkhede03@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jun 30, 2021 at 02:48:15PM +0200, Marek Szyprowski wrote:
> On 08.06.2021 18:45, Amey Narkhede wrote:
> > If device registration fails, remove sysfs attribute
> > and if setting bus callbacks fails, unregister the device
> > and cleanup the sysfs attribute.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> =

> This patch landed in linux-next some time ago as commit 249c9dc6aa0d =

> ("iommu/arm: Cleanup resources in case of probe error path"). After =

> bisecting and some manual searching I finally found that it is =

> responsible for breaking s2idle on DragonBoard 410c. Here is the log =

> (captured with no_console_suspend):
> =

> # time rtcwake -s10 -mmem
> rtcwake: wakeup from "mem" using /dev/rtc0 at Thu Jan=A0 1 00:02:13 1970
> PM: suspend entry (s2idle)
> Filesystems sync: 0.002 seconds
> Freezing user space processes ... (elapsed 0.006 seconds) done.
> OOM killer disabled.
> Freezing remaining freezable tasks ... (elapsed 0.004 seconds) done.
> Unable to handle kernel NULL pointer dereference at virtual address =

> 0000000000000070
> Mem abort info:
>  =A0 ESR =3D 0x96000006
>  =A0 EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>  =A0 SET =3D 0, FnV =3D 0
>  =A0 EA =3D 0, S1PTW =3D 0
>  =A0 FSC =3D 0x06: level 2 translation fault
> Data abort info:
>  =A0 ISV =3D 0, ISS =3D 0x00000006
>  =A0 CM =3D 0, WnR =3D 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000008ad08000
> [0000000000000070] pgd=3D0800000085c3c003, p4d=3D0800000085c3c003, =

> pud=3D0800000088dcf003, pmd=3D0000000000000000
> Internal error: Oops: 96000006 [#1] PREEMPT SMP
> Modules linked in: bluetooth ecdh_generic ecc rfkill ipv6 ax88796b =

> venus_enc venus_dec videobuf2_dma_contig asix crct10dif_ce adv7511 =

> snd_soc_msm8916_analog qcom_spmi_temp_alarm rtc_pm8xxx qcom_pon =

> qcom_camss qcom_spmi_vadc videobuf2_dma_sg qcom_vadc_common msm =

> venus_core v4l2_fwnode v4l2_async snd_soc_msm8916_digital =

> videobuf2_memops snd_soc_lpass_apq8016 snd_soc_lpass_cpu v4l2_mem2mem =

> snd_soc_lpass_platform snd_soc_apq8016_sbc videobuf2_v4l2 =

> snd_soc_qcom_common qcom_rng videobuf2_common i2c_qcom_cci qnoc_msm8916 =

> videodev mc icc_smd_rpm mdt_loader socinfo display_connector rmtfs_mem
> CPU: 1 PID: 1522 Comm: rtcwake Not tainted 5.13.0-next-20210629 #3592
> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=3D--)
> pc : msm_runtime_suspend+0x1c/0x60 [msm]
> lr : msm_pm_suspend+0x18/0x38 [msm]
> ...
> Call trace:
>  =A0msm_runtime_suspend+0x1c/0x60 [msm]
>  =A0msm_pm_suspend+0x18/0x38 [msm]
>  =A0dpm_run_callback+0x84/0x378

I wonder if we're missing a pm_runtime_disable() call on the failure path?
i.e. something like the diff below...

Will

--->8

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/ar=
m-smmu/qcom_iommu.c
index 25ed444ff94d..ce8f354755d0 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -836,14 +836,14 @@ static int qcom_iommu_device_probe(struct platform_de=
vice *pdev)
        ret =3D devm_of_platform_populate(dev);
        if (ret) {
                dev_err(dev, "Failed to populate iommu contexts\n");
-               return ret;
+               goto err_pm_disable;
        }
 =

        ret =3D iommu_device_sysfs_add(&qcom_iommu->iommu, dev, NULL,
                                     dev_name(dev));
        if (ret) {
                dev_err(dev, "Failed to register iommu in sysfs\n");
-               return ret;
+               goto err_pm_disable;
        }
 =

        ret =3D iommu_device_register(&qcom_iommu->iommu, &qcom_iommu_ops, =
dev);
@@ -869,6 +869,9 @@ static int qcom_iommu_device_probe(struct platform_devi=
ce *pdev)
 =

 err_sysfs_remove:
        iommu_device_sysfs_remove(&qcom_iommu->iommu);
+
+err_pm_disable:
+       pm_runtime_disable(dev);
        return ret;
 }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
