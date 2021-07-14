Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0C9C07E9C
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 11:18:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A206128C
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 11:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A206128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8E6541485;
	Wed, 14 Jul 2021 11:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AE6hp6HuE2EE; Wed, 14 Jul 2021 11:18:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 90DE9415AE;
	Wed, 14 Jul 2021 11:18:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DBEBC0010;
	Wed, 14 Jul 2021 11:18:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F061C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4085B60B19
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id laMGQFO14jEG for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 11:18:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC156605D1
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 11:18:27 +0000 (UTC)
X-UUID: a0124a582aaf4af196a2e5fb2fc74a12-20210714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=jGb3Fw2ghMBhqRR5HNnLI1fFNCmMhlcMRemz5Ei6vYI=; 
 b=DCftle3drc3MLosi/1G5PTrEmJcKPQwKoFJBBWP8jbqdXE2DwHhL/y3EVLXW5YANSgbS/Pi0bYnAo7u2MVCr6NlEqOVKM2vXtCC3VLIDi98+2EbsC6oEdymQP2ti9WJkBIZ/Zez8o49ktXGUyTMm/NnCJfjYvHiYTIF+DfjmUuQ=;
X-UUID: a0124a582aaf4af196a2e5fb2fc74a12-20210714
Received: from mtkmrs31.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 119119299; Wed, 14 Jul 2021 19:18:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 14 Jul 2021 19:18:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 19:18:16 +0800
Message-ID: <1626261496.14352.16.camel@mhfsdcap03>
Subject: Re: Aw: [PATCH v6 00/11] Clean up "mediatek,larb"
From: Yong Wu <yong.wu@mediatek.com>
To: Frank Wunderlich <frank-w@public-files.de>
Date: Wed, 14 Jul 2021 19:18:16 +0800
In-Reply-To: <trinity-7d9ebdc9-4849-4d93-bfb5-429dcb4ee449-1626253158870@3c-app-gmx-bs01>
References: <20210714025626.5528-1-yong.wu@mediatek.com>
 <trinity-7d9ebdc9-4849-4d93-bfb5-429dcb4ee449-1626253158870@3c-app-gmx-bs01>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 194C4630574F716762D04534E2ED131E926154033AFA8FFE4228D830E0E139F02000:8
X-MTK: N
Cc: Xia Jiang <xia.jiang@mediatek.com>,
 Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, David Airlie <airlied@linux.ie>, Will
 Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Evan Green <evgreen@chromium.org>, Eizan
 Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Tiffany Lin <tiffany.lin@mediatek.com>,
 yi.kuo@mediatek.com, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com, Mauro
 Carvalho Chehab <mchehab@kernel.org>, linux-arm-kernel@lists.infradead.org,
 anan.sun@mediatek.com, acourbot@chromium.org, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, 2021-07-14 at 10:59 +0200, Frank Wunderlich wrote:
> Hi,
> 
> sorry this (or the 2 depency-series) cause a NULL Pointer deref in iommu_group_remove_device on mt7623/bpi-r2

Hi Frank,

Thanks for your report. mt7623 use mtk_iommu_v1.c.

I will try to reproduce this locally.

> 
> i wonder why on bootup a cleanup is run, but have no hint about this.
> 
> since "dts: mtk-mdp: remove mediatek, vpu property from primary MDP device" all is good, i guess problem comes up while removing larb with DT
> 
> this is backtrace
> 
> [    6.274465] PC is at iommu_group_remove_device+0x28/0x148
> [    6.279877] LR is at iommu_release_device+0x4c/0x70
> 
> [    6.674347] Backtrace:
> [    6.676797] [<c0c9c37c>] (iommu_group_remove_device) from [<c06bf028>] (iomm)
> [    6.686221]  r7:00000000 r6:c06bf04c r5:c0d7a1ac r4:c21fc010
> [    6.691883] [<c06befdc>] (iommu_release_device) from [<c06bf064>] (remove_io)
> [    6.700689]  r5:00000000 r4:00000000
> [    6.704265] [<c06bf04c>] (remove_iommu_group) from [<c0733434>] (bus_for_eac)
> [    6.712725] [<c07333ac>] (bus_for_each_dev) from [<c06bf658>] (bus_set_iommu)
> [    6.720753]  r6:c331f440 r5:c1406f58 r4:ffffffea
> [    6.725370] [<c06bf5a0>] (bus_set_iommu) from [<c06c1e88>] (mtk_iommu_probe+)
> [    6.733484]  r7:c32db0b8 r6:c21f9c00 r5:c331f1c0 r4:00000000
> [    6.739145] [<c06c1bfc>] (mtk_iommu_probe) from [<c0738c14>] (platform_probe)
> [    6.747176]  r10:c21f9c10 r9:c2496f54 r8:c14623b8 r7:c14623b8 r6:c1405b90 r50
> [    6.755012]  r4:00000000
> [    6.757544] [<c0738ba8>] (platform_probe) from [<c0735968>] (really_probe.pa)
> [    6.766006]  r7:c14623b8 r6:c1405b90 r5:00000000 r4:c21f9c10
> [    6.771667] [<c07358a0>] (really_probe.part.0) from [<c0735cec>] (really_pro)
> [    6.779866]  r7:c21f9c10 r6:c2549e74 r5:c1405b90 r4:c21f9c10
> [    6.785527] [<c0735ca4>] (really_probe) from [<c0735de0>] (__driver_probe_de)
> [    6.793984]  r5:c1405b90 r4:c21f9c10
> [    6.797560] [<c0735d30>] (__driver_probe_device) from [<c0735fa0>] (driver_p)
> [    6.806543]  r9:c2496f54 r8:00000008 r7:c21f9c10 r6:c2549e74 r5:c14c6ec8 r4:4
> [    6.814291] [<c0735f5c>] (driver_probe_device) from [<c0736410>] (__device_a)
> [    6.823448]  r9:c2496f54 r8:00000000 r7:c21f9c10 r6:c2549e74 r5:c1405b90 r4:1
> [    6.831196] [<c073635c>] (__device_attach_driver) from [<c0733540>] (bus_for)
> [    6.840007]  r7:c14623b8 r6:c073635c r5:c2549e74 r4:00000000
> [    6.845669] [<c07334ac>] (bus_for_each_drv) from [<c07357e8>] (__device_atta)
> [    6.854044]  r6:00000001 r5:c21f9c54 r4:c21f9c10
> [    6.858662] [<c07356e4>] (__device_attach) from [<c073662c>] (device_initial)
> [    6.867207]  r6:c21f9c10 r5:c1406f58 r4:c1406ca0
> [    6.871825] [<c0736610>] (device_initial_probe) from [<c07346dc>] (bus_probe)
> [    6.880454] [<c0734648>] (bus_probe_device) from [<c0734cc8>] (deferred_prob)
> 
> 
> bisect shows this commit as breaking:
> 
> Author: Yong Wu <yong.wu@mediatek.com>
> Date:   Wed Jul 14 10:56:17 2021 +0800
> 
>     iommu/mediatek: Add probe_defer for smi-larb
> 
>     Prepare for adding device_link.
> 
> regards Frank

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
