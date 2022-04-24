Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C12EC433F5
	for <iommu@archiver.kernel.org>; Sun, 24 Apr 2022 23:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A7E440292;
	Sun, 24 Apr 2022 23:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yl_aU_TRzNlp; Sun, 24 Apr 2022 23:28:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E2DD440223;
	Sun, 24 Apr 2022 23:28:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95BC7C0032;
	Sun, 24 Apr 2022 23:28:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BDE6C002D
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 23:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8440B81A12
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 23:28:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XV6DRdu2sfnd for <iommu@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 23:28:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92C0C8145E
 for <iommu@lists.linux-foundation.org>; Sun, 24 Apr 2022 23:28:52 +0000 (UTC)
X-UUID: 00ee9c86a97c4fefb6413aecf8b0bc94-20220425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:70be6383-2c7f-43e8-bd62-9674791f3e6c, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:45
X-CID-INFO: VERSION:1.1.4, REQID:70be6383-2c7f-43e8-bd62-9674791f3e6c, OB:0,
 LOB:
 0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
 N:release,TS:45
X-CID-META: VersionHash:faefae9, CLOUDID:e410efef-06b0-4305-bfbf-554bfc9d151a,
 C
 OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:-5,EDM:-3,File:n
 il,QS:0,BEC:nil
X-UUID: 00ee9c86a97c4fefb6413aecf8b0bc94-20220425
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <miles.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 2081701411; Mon, 25 Apr 2022 07:28:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 25 Apr 2022 07:28:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Mon, 25 Apr 2022 07:28:45 +0800
To: <lkp@intel.com>
Subject: Re: [PATCH] iommu/mediatek: fix NULL pointer dereference when
 printing dev_name
Date: Mon, 25 Apr 2022 07:28:45 +0800
Message-ID: <20220424232845.25277-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <202204231446.IYKdZ674-lkp@intel.com>
References: <202204231446.IYKdZ674-lkp@intel.com>
MIME-Version: 1.0
X-MTK: N
Cc: miles.chen@mediatek.com, mchehab@kernel.org, kbuild-all@lists.01.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, hverkuil@xs4all.nl,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, linux-media@vger.kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, angelogioacchino.delregno@collabora.com
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
From: Miles Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Miles Chen <miles.chen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

>Hi Miles,
>
>Thank you for the patch! Perhaps something to improve:
>
>[auto build test WARNING on joro-iommu/next]
>[also build test WARNING on v5.18-rc3 next-20220422]
>[If your patch is applied to the wrong git tree, kindly drop us a note.
>And when submitting patch, we suggest to use '--base' as documented in
>https://git-scm.com/docs/git-format-patch]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/Miles-Chen/iommu-mediatek-fix-NULL-pointer-dereference-when-printing-dev_name/20220423-070605
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
>config: hexagon-randconfig-r041-20220422 (https://download.01.org/0day-ci/archive/20220423/202204231446.IYKdZ674-lkp@intel.com/config)
>compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
>reproduce (this is a W=1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # https://github.com/intel-lab-lkp/linux/commit/85771767e503ca60069fe4e6ec2ddb80c7f9bafa
>        git remote add linux-review https://github.com/intel-lab-lkp/linux
>        git fetch --no-tags linux-review Miles-Chen/iommu-mediatek-fix-NULL-pointer-dereference-when-printing-dev_name/20220423-070605
>        git checkout 85771767e503ca60069fe4e6ec2ddb80c7f9bafa
>        # save the config file
>        mkdir build_dir && cp config build_dir/.config
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iommu/
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>
>All warnings (new ones prefixed by >>):
>
>>> drivers/iommu/mtk_iommu.c:605:6: warning: variable 'larbdev' is uninitialized when used here [-Wuninitialized]
>           if (larbdev) {
>               ^~~~~~~
>   drivers/iommu/mtk_iommu.c:597:24: note: initialize the variable 'larbdev' to silence this warning
>           struct device *larbdev;
>                                 ^
>                                  = NULL
>   1 warning generated.

Thanks for catching this, I will fix this in next version.

thanks,
Miles
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
