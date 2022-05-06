Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E76DC433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 05:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DF1B40890;
	Fri,  6 May 2022 05:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WxS2BR8pK8tF; Fri,  6 May 2022 05:37:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B56C640308;
	Fri,  6 May 2022 05:37:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD22C0032;
	Fri,  6 May 2022 05:37:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A9EAC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECF3283227
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j4BVBQR2Vmjl for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 05:37:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9EC4882951
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:37:00 +0000 (UTC)
X-UUID: 99276821f63d41eba8be54a5f69d820e-20220506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:a2fff786-43df-4c17-bbf4-cf9bbb76b9ac, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:faefae9, CLOUDID:da196916-2e53-443e-b81a-655c13977218,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 99276821f63d41eba8be54a5f69d820e-20220506
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1157542387; Fri, 06 May 2022 13:36:55 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Fri, 6 May 2022 13:36:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 May 2022 13:36:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 May 2022 13:36:53 +0800
Message-ID: <59df49f47ecf000ef40e432d82bd96338f4da69a.camel@mediatek.com>
Subject: Re: [PATCH v3] iommu/mediatek: Fix NULL pointer dereference when
 printing dev_name
To: Miles Chen <miles.chen@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 "Will Deacon" <will@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>
Date: Fri, 6 May 2022 13:36:53 +0800
In-Reply-To: <20220505132731.21628-1-miles.chen@mediatek.com>
References: <20220505132731.21628-1-miles.chen@mediatek.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 2022-05-05 at 21:27 +0800, Miles Chen wrote:
> When larbdev is NULL (in the case I hit, the node is incorrectly set
> iommus = <&iommu NUM>), it will cause device_link_add() fail and
> kernel crashes when we try to print dev_name(larbdev).
> 
> Let's fail the probe if a larbdev is NULL to avoid invalid inputs
> from
> dts.
> 
> It should work for normal correct setting and avoid the crash caused
> by my incorrect setting.
> 
> Error log:
> [   18.189042][  T301] Unable to handle kernel NULL pointer
> dereference at virtual address 0000000000000050
> ...
> [   18.344519][  T301] pstate: a0400005 (NzCv daif +PAN -UAO)
> [   18.345213][  T301] pc : mtk_iommu_probe_device+0xf8/0x118
> [mtk_iommu]
> [   18.346050][  T301] lr : mtk_iommu_probe_device+0xd0/0x118
> [mtk_iommu]
> [   18.346884][  T301] sp : ffffffc00a5635e0
> [   18.347392][  T301] x29: ffffffc00a5635e0 x28: ffffffd44a46c1d8
> [   18.348156][  T301] x27: ffffff80c39a8000 x26: ffffffd44a80cc38
> [   18.348917][  T301] x25: 0000000000000000 x24: ffffffd44a80cc38
> [   18.349677][  T301] x23: ffffffd44e4da4c6 x22: ffffffd44a80cc38
> [   18.350438][  T301] x21: ffffff80cecd1880 x20: 0000000000000000
> [   18.351198][  T301] x19: ffffff80c439f010 x18: ffffffc00a50d0c0
> [   18.351959][  T301] x17: ffffffffffffffff x16: 0000000000000004
> [   18.352719][  T301] x15: 0000000000000004 x14: ffffffd44eb5d420
> [   18.353480][  T301] x13: 0000000000000ad2 x12: 0000000000000003
> [   18.354241][  T301] x11: 00000000fffffad2 x10: c0000000fffffad2
> [   18.355003][  T301] x9 : a0d288d8d7142d00 x8 : a0d288d8d7142d00
> [   18.355763][  T301] x7 : ffffffd44c2bc640 x6 : 0000000000000000
> [   18.356524][  T301] x5 : 0000000000000080 x4 : 0000000000000001
> [   18.357284][  T301] x3 : 0000000000000000 x2 : 0000000000000005
> [   18.358045][  T301] x1 : 0000000000000000 x0 : 0000000000000000
> [   18.360208][  T301] Hardware name: MT6873 (DT)
> [   18.360771][  T301] Call trace:
> [   18.361168][  T301]  dump_backtrace+0xf8/0x1f0
> [   18.361737][  T301]  dump_stack_lvl+0xa8/0x11c
> [   18.362305][  T301]  dump_stack+0x1c/0x2c
> [   18.362816][  T301]  mrdump_common_die+0x184/0x40c [mrdump]
> [   18.363575][  T301]  ipanic_die+0x24/0x38 [mrdump]
> [   18.364230][  T301]  atomic_notifier_call_chain+0x128/0x2b8
> [   18.364937][  T301]  die+0x16c/0x568
> [   18.365394][  T301]  __do_kernel_fault+0x1e8/0x214
> [   18.365402][  T301]  do_page_fault+0xb8/0x678
> [   18.366934][  T301]  do_translation_fault+0x48/0x64
> [   18.368645][  T301]  do_mem_abort+0x68/0x148
> [   18.368652][  T301]  el1_abort+0x40/0x64
> [   18.368660][  T301]  el1h_64_sync_handler+0x54/0x88
> [   18.368668][  T301]  el1h_64_sync+0x68/0x6c
> [   18.368673][  T301]  mtk_iommu_probe_device+0xf8/0x118 [mtk_iommu]
> ...
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 635319a4a744 ("media: iommu/mediatek: Add device_link between
> the consumer and the larb devices")
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

And this doesn't conflict with the MT8195 patchset.

Thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
