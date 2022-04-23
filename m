Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976BEC433EF
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 06:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2227460BA6;
	Sat, 23 Apr 2022 06:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wlfPKnqJ7r55; Sat, 23 Apr 2022 06:49:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C93506058B;
	Sat, 23 Apr 2022 06:49:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 968FDC0032;
	Sat, 23 Apr 2022 06:49:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAC28C002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 06:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFD9140198
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 06:49:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EVNIbn_Owa0M for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 06:49:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D691C40012
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 06:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650696592; x=1682232592;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/TgZTP8Sb4P0FH9slFXu/lphspGv+TGMH48WzenOT9M=;
 b=CgLv0cNokeVuUc3sPD/1E8DHwcNLhxdF2M9XMrt7IVRTWO2dfb+Nmmjz
 jv/wumVJ8SHweS0qUGLrlzCcGONGTySvXdvDCr+4pH4ynzSsJg1sX1tNy
 hURvwnyHX+hWdV+kSr3hBpixlKTLx4x6trrvW6X8fGImBI0RpXoCkclHf
 O/UyiiRBtVzEPhyq5eO2jAaergFn3ylNyLITwvwsqDe5p95V4AWScoLuz
 xS1HAcxD0X2BRt6ufjIfONpMeLLW1WyXwYLC191hiRcxQMR3aIOgsXJY4
 nRdeOJu90R44M0s8Zmqd4wrIF0m5mMik3oD/Klqy69EBMztsRv249KDyv w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="252193144"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="252193144"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2022 23:49:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; d="scan'208";a="627297258"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 22 Apr 2022 23:49:48 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1ni9aW-000B6g-75;
 Sat, 23 Apr 2022 06:49:48 +0000
Date: Sat, 23 Apr 2022 14:49:23 +0800
From: kernel test robot <lkp@intel.com>
To: Miles Chen <miles.chen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] iommu/mediatek: fix NULL pointer dereference when
 printing dev_name
Message-ID: <202204231446.IYKdZ674-lkp@intel.com>
References: <20220422223549.4173-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220422223549.4173-1-miles.chen@mediatek.com>
Cc: kbuild-all@lists.01.org, llvm@lists.linux.dev,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Miles Chen <miles.chen@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

Hi Miles,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on joro-iommu/next]
[also build test WARNING on v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Miles-Chen/iommu-mediatek-fix-NULL-pointer-dereference-when-printing-dev_name/20220423-070605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: hexagon-randconfig-r041-20220422 (https://download.01.org/0day-ci/archive/20220423/202204231446.IYKdZ674-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/85771767e503ca60069fe4e6ec2ddb80c7f9bafa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Miles-Chen/iommu-mediatek-fix-NULL-pointer-dereference-when-printing-dev_name/20220423-070605
        git checkout 85771767e503ca60069fe4e6ec2ddb80c7f9bafa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iommu/mtk_iommu.c:605:6: warning: variable 'larbdev' is uninitialized when used here [-Wuninitialized]
           if (larbdev) {
               ^~~~~~~
   drivers/iommu/mtk_iommu.c:597:24: note: initialize the variable 'larbdev' to silence this warning
           struct device *larbdev;
                                 ^
                                  = NULL
   1 warning generated.


vim +/larbdev +605 drivers/iommu/mtk_iommu.c

   592	
   593	static void mtk_iommu_release_device(struct device *dev)
   594	{
   595		struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
   596		struct mtk_iommu_data *data;
   597		struct device *larbdev;
   598		unsigned int larbid;
   599	
   600		if (!fwspec || fwspec->ops != &mtk_iommu_ops)
   601			return;
   602	
   603		data = dev_iommu_priv_get(dev);
   604		larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
 > 605		if (larbdev) {
   606			larbdev = data->larb_imu[larbid].dev;
   607			device_link_remove(dev, larbdev);
   608		}
   609	
   610		iommu_fwspec_free(dev);
   611	}
   612	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
