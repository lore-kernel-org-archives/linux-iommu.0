Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE58C34047
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:24:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12EF2468B
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 18:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh9z0R7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12EF2468B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 800C584DFD;
	Tue, 18 Feb 2020 18:24:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oEfKm4UNxwZ6; Tue, 18 Feb 2020 18:24:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EDC4182465;
	Tue, 18 Feb 2020 18:24:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCE38C1D84;
	Tue, 18 Feb 2020 18:24:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D984AC013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C7E368407F
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:24:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RNJEsOFOPOOm for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 18:24:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 318C782465
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 18:24:02 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 80AE024682;
 Tue, 18 Feb 2020 18:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582050242;
 bh=ASjGey5IRlaeQ/Z754o2YVsdRd0Ueh/TIybWHFvqs10=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Oh9z0R7uVWsNoanIfPLH6kzQEVZKdQuMFqGN2LdhZN66r5LvbdurCtGv6r2mqWCWQ
 D80LJJ8Zuj3A/WJMP3eu72JL35HM9RUUnyByMlq5aY3c2xVeAY/rbDhs0o/GtDyvXu
 2MolCJKYuoV+iRMHs5Q1SxjzLmKyiV2BhQ3xnk08=
Date: Tue, 18 Feb 2020 19:23:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: drivers/iommu/qcom_iommu.c:348 qcom_iommu_domain_free+0x5c/0x70
Message-ID: <20200218182359.GC2635524@kroah.com>
References: <CA+G9fYtScOpkLvx=__gP903uJ2v87RwZgkAuL6RpF9_DTDs9Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYtScOpkLvx=__gP903uJ2v87RwZgkAuL6RpF9_DTDs9Zw@mail.gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, bjorn.andersson@linaro.org,
 iommu@lists.linux-foundation.org, linux- stable <stable@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 robin.murphy@arm.com, Will Deacon <will@kernel.org>, masneyb@onstation.org
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

On Tue, Feb 18, 2020 at 04:13:57PM +0530, Naresh Kamboju wrote:
> We have noticed these kernel warnings on APQ 8016 SBC  (dragonboard
> 410c ) running stable rc 5.5, 5.4 branches and linux mainline and
> linux-next master branches.
> 
> This warning started happening from linux mainline 5.3 onwards (2019-08-29)
> 
> [    5.488128] ------------[ cut here ]------------
> [    5.488161] WARNING: CPU: 3 PID: 221 at
> drivers/iommu/qcom_iommu.c:348 qcom_iommu_domain_free+0x5c/0x70
> [    5.491817] Modules linked in: crct10dif_ce(+) adv7511(+) cec
> msm(+) mdt_loader drm_kms_helper drm fuse
> [    5.491842] CPU: 3 PID: 221 Comm: systemd-udevd Not tainted
> 5.4.21-rc1-00037-g6f8f5c79416e #1
> [    5.491844] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [    5.491849] pstate: 00000005 (nzcv daif -PAN -UAO)
> [    5.491858] pc : qcom_iommu_domain_free+0x5c/0x70
> [    5.491865] lr : iommu_group_release+0x44/0x60
> [    5.491867] sp : ffff800011e83600
>          Starting Network Manager...[    5.491870] x29:
> ffff800011e83600 x28: 0000000000000100
> [    5.491893] x19: ffff000036a9e500 x18: 0000000000000001
> [    5.491898] x17: 0000000000000000 x16: 0000000000000000
> [    5.491902] x15: 0000000000000004 x14: 0000000000000000
> [    5.491907] x13: 0000000000000000 x12: ffff00003a137aa0
> [    5.491911] x11: ffff00003a137908 x10: 0000000000000000
> [    5.491916] x9 : ffff00000eb2c098 x8 : ffff00000eb2c090
> [    5.491920] x7 : 00000000400c0000 x6 : 0000000000000004
> [    5.491924] x5 : 0000000000000001 x4 : 0000000000000000
> [    5.491929] x3 : 0000000000000000 x2 : 0000000000000000
> [    5.491933] x1 : ffff00003bdb9680 x0 : ffff000036aa0ab0
> [    5.491938] Call trace:
> [    5.491946]  qcom_iommu_domain_free+0x5c/0x70
> [    5.491951]  iommu_group_release+0x44/0x60
> [    5.491957]  kobject_put+0x6c/0xf0
> [    5.491962]  kobject_del+0x50/0x68
> [    5.491966]  kobject_put+0xd0/0xf0
> [    5.491972]  iommu_group_remove_device+0xd8/0xec
> [    5.491977]  qcom_iommu_remove_device+0x44/0x60
> [    5.491982]  iommu_release_device+0x28/0x40
> [    5.491987]  iommu_bus_notifier+0xac/0xc0
> [    5.491993]  notifier_call_chain+0x58/0x98
> [    5.491998]  blocking_notifier_call_chain+0x54/0x78
> [    5.492003]  device_del+0x224/0x348
> [    5.492008]  platform_device_del.part.0+0x18/0x88
> [    5.492012]  platform_device_unregister+0x20/0x38
> [    5.492019]  of_platform_device_destroy+0xdc/0xf0
> [    5.492023]  device_for_each_child+0x58/0xa0
> [    5.492028]  of_platform_depopulate+0x38/0x78
> [    5.492155]  msm_pdev_probe+0x1c0/0x308 [msm]
> [    5.492166]  platform_drv_probe+0x50/0xa0
> [    5.682404]  really_probe+0xd4/0x308
> [    5.686388]  driver_probe_device+0x54/0xe8
> [    5.690035]  device_driver_attach+0x6c/0x78
> [    5.693940]  __driver_attach+0x54/0xd0
> [    5.698020]  bus_for_each_dev+0x6c/0xc0
> [    5.701838]  driver_attach+0x20/0x28
> [    5.705572]  bus_add_driver+0x140/0x1e8
> [    5.709390]  driver_register+0x60/0x110
> [    5.712950]  __platform_driver_register+0x44/0x50
> [    5.716886]  msm_drm_register+0x54/0x68 [msm]
> [    5.721633]  do_one_initcall+0x50/0x190
> [    5.725972]  do_init_module+0x50/0x208
> [    5.729615]  load_module+0x1d1c/0x2298
> [    5.733435]  __do_sys_finit_module+0xd0/0xe8
> [    5.737169]  __arm64_sys_finit_module+0x1c/0x28
> [    5.741598]  el0_svc_common.constprop.0+0x68/0x160
> [    5.745851]  el0_svc_handler+0x20/0x80
> [    5.750709]  el0_svc+0x8/0xc
> [    5.754443] ---[ end trace 0ebe200932dd18fc ]---
> 
> 
> Full test log link,
> https://lkft.validation.linaro.org/scheduler/job/1226062#L3841
> https://lkft.validation.linaro.org/scheduler/job/1227242#L3877
> 
> Ref:
> https://bugs.linaro.org/show_bug.cgi?id=5460

Can you bisect to find the offending commit?

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
