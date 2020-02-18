Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56E5C34026
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 10:44:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB0D206E2
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 10:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYGDLS0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB0D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6EAC38731A;
	Tue, 18 Feb 2020 10:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31kqX3-J2VsV; Tue, 18 Feb 2020 10:44:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BAF14872E8;
	Tue, 18 Feb 2020 10:44:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEB36C1D84;
	Tue, 18 Feb 2020 10:44:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E476CC013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 10:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CFD4484BB6
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 10:44:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qmFtaCOdvXvZ for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 10:44:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CC4ED845D4
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 10:44:10 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id h23so22369608ljc.8
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 02:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=9B/QxKVuiURH3pVLZixFChf8RZ4EihaeCFIEBe9FLXg=;
 b=CYGDLS0wV8PjqWKaaZmkoGFC02/y3nYxs490raBABLKlCi6EAZRGyn19r2Hfrht20I
 6yxFOMmiy6rVJ08eLzlTb116WQz5bNJrXfI3B4BZH7kAqtrv8Man7mWbirWWvNCvTViK
 LTx72ATb/Td+8yOSBn4vh+R5IpD6uWfSJlmzZ6XsHtflLkAwMNoGlrdjLeAmWFxNV/k3
 YyzJzbDu+8yr9ymJ/juzOYYvs8e9f3C5kH9rLbaKCOxrN5wgstvRX1pmSY1/IDV0lCeq
 ANPzsLrtXcwbVC+fb41ot+W+JJDrGtQbgtEFV+J6CgkI2WH4KqlbPktq391xmmVlCXGb
 79Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=9B/QxKVuiURH3pVLZixFChf8RZ4EihaeCFIEBe9FLXg=;
 b=B1WFUVmHjp/j8HKBLX4ohJOf2bZodljbJdz60QLV+cazN6AsRA057BjUPOUy5B9lGR
 0IiwVxgTQkc0uBbMTBTN5Ptotg1roLK0/kuUmOajizL2nq8aO/8ubhKjIdM/+17ZYIPm
 03xKDripoqLhipLIlF0YSZWIkB+dQwk1rKdl92thwrh7B92BWJteAWQg42T7kyR1516F
 ahngwyUYgF69DnYoBRwyYyHnSRUlBsEErX/OPUJCm+2afnAvSYoN8WcbSbKCMECpVV7Z
 FReT5uoe7Or0hG4qXWXkO/iaC02h3aE/alEeM6Pk+Qc4fF6uVQVqG3AY8WNfcBi3k+tT
 VhGA==
X-Gm-Message-State: APjAAAWceQmjH04A63j4gJKTlTfvhICcbZsSWoNVqo7bEb/713/4Hy9l
 6X0T8BKxaHQeqIuZb7cQgCa9a9Dm/AJfIq4aSU7zow==
X-Google-Smtp-Source: APXvYqyVX3qjW5PxzmcH4J0BT9LVYaHpB9JgdP5H5Us+FR/4ieEjcpZUqMgI2zexcNOvu49gcWlCbynP2TdmlJtwhjY=
X-Received: by 2002:a05:651c:414:: with SMTP id
 20mr11868059lja.165.1582022648492; 
 Tue, 18 Feb 2020 02:44:08 -0800 (PST)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 18 Feb 2020 16:13:57 +0530
Message-ID: <CA+G9fYtScOpkLvx=__gP903uJ2v87RwZgkAuL6RpF9_DTDs9Zw@mail.gmail.com>
Subject: drivers/iommu/qcom_iommu.c:348 qcom_iommu_domain_free+0x5c/0x70
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, 
 iommu@lists.linux-foundation.org, robdclark@gmail.com, 
 bjorn.andersson@linaro.org
Cc: robin.murphy@arm.com, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, linux- stable <stable@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Will Deacon <will@kernel.org>, masneyb@onstation.org
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

We have noticed these kernel warnings on APQ 8016 SBC  (dragonboard
410c ) running stable rc 5.5, 5.4 branches and linux mainline and
linux-next master branches.

This warning started happening from linux mainline 5.3 onwards (2019-08-29)

[    5.488128] ------------[ cut here ]------------
[    5.488161] WARNING: CPU: 3 PID: 221 at
drivers/iommu/qcom_iommu.c:348 qcom_iommu_domain_free+0x5c/0x70
[    5.491817] Modules linked in: crct10dif_ce(+) adv7511(+) cec
msm(+) mdt_loader drm_kms_helper drm fuse
[    5.491842] CPU: 3 PID: 221 Comm: systemd-udevd Not tainted
5.4.21-rc1-00037-g6f8f5c79416e #1
[    5.491844] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    5.491849] pstate: 00000005 (nzcv daif -PAN -UAO)
[    5.491858] pc : qcom_iommu_domain_free+0x5c/0x70
[    5.491865] lr : iommu_group_release+0x44/0x60
[    5.491867] sp : ffff800011e83600
         Starting Network Manager...[    5.491870] x29:
ffff800011e83600 x28: 0000000000000100
[    5.491893] x19: ffff000036a9e500 x18: 0000000000000001
[    5.491898] x17: 0000000000000000 x16: 0000000000000000
[    5.491902] x15: 0000000000000004 x14: 0000000000000000
[    5.491907] x13: 0000000000000000 x12: ffff00003a137aa0
[    5.491911] x11: ffff00003a137908 x10: 0000000000000000
[    5.491916] x9 : ffff00000eb2c098 x8 : ffff00000eb2c090
[    5.491920] x7 : 00000000400c0000 x6 : 0000000000000004
[    5.491924] x5 : 0000000000000001 x4 : 0000000000000000
[    5.491929] x3 : 0000000000000000 x2 : 0000000000000000
[    5.491933] x1 : ffff00003bdb9680 x0 : ffff000036aa0ab0
[    5.491938] Call trace:
[    5.491946]  qcom_iommu_domain_free+0x5c/0x70
[    5.491951]  iommu_group_release+0x44/0x60
[    5.491957]  kobject_put+0x6c/0xf0
[    5.491962]  kobject_del+0x50/0x68
[    5.491966]  kobject_put+0xd0/0xf0
[    5.491972]  iommu_group_remove_device+0xd8/0xec
[    5.491977]  qcom_iommu_remove_device+0x44/0x60
[    5.491982]  iommu_release_device+0x28/0x40
[    5.491987]  iommu_bus_notifier+0xac/0xc0
[    5.491993]  notifier_call_chain+0x58/0x98
[    5.491998]  blocking_notifier_call_chain+0x54/0x78
[    5.492003]  device_del+0x224/0x348
[    5.492008]  platform_device_del.part.0+0x18/0x88
[    5.492012]  platform_device_unregister+0x20/0x38
[    5.492019]  of_platform_device_destroy+0xdc/0xf0
[    5.492023]  device_for_each_child+0x58/0xa0
[    5.492028]  of_platform_depopulate+0x38/0x78
[    5.492155]  msm_pdev_probe+0x1c0/0x308 [msm]
[    5.492166]  platform_drv_probe+0x50/0xa0
[    5.682404]  really_probe+0xd4/0x308
[    5.686388]  driver_probe_device+0x54/0xe8
[    5.690035]  device_driver_attach+0x6c/0x78
[    5.693940]  __driver_attach+0x54/0xd0
[    5.698020]  bus_for_each_dev+0x6c/0xc0
[    5.701838]  driver_attach+0x20/0x28
[    5.705572]  bus_add_driver+0x140/0x1e8
[    5.709390]  driver_register+0x60/0x110
[    5.712950]  __platform_driver_register+0x44/0x50
[    5.716886]  msm_drm_register+0x54/0x68 [msm]
[    5.721633]  do_one_initcall+0x50/0x190
[    5.725972]  do_init_module+0x50/0x208
[    5.729615]  load_module+0x1d1c/0x2298
[    5.733435]  __do_sys_finit_module+0xd0/0xe8
[    5.737169]  __arm64_sys_finit_module+0x1c/0x28
[    5.741598]  el0_svc_common.constprop.0+0x68/0x160
[    5.745851]  el0_svc_handler+0x20/0x80
[    5.750709]  el0_svc+0x8/0xc
[    5.754443] ---[ end trace 0ebe200932dd18fc ]---


Full test log link,
https://lkft.validation.linaro.org/scheduler/job/1226062#L3841
https://lkft.validation.linaro.org/scheduler/job/1227242#L3877

Ref:
https://bugs.linaro.org/show_bug.cgi?id=5460

-- 
Linaro LKFT
https://lkft.linaro.org
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
