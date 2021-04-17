Return-Path: <SRS0=S5kk=JO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6DEC433B4
	for <iommu@archiver.kernel.org>; Sat, 17 Apr 2021 01:13:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2FC6115B
	for <iommu@archiver.kernel.org>; Sat, 17 Apr 2021 01:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2FC6115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07E17606F3;
	Sat, 17 Apr 2021 01:13:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZoDbetxc1HRB; Sat, 17 Apr 2021 01:13:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93C156064B;
	Sat, 17 Apr 2021 01:13:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AEC0C000B;
	Sat, 17 Apr 2021 01:13:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEB34C000A
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 01:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCA2060669
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 01:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2HYIZ1Te3M5J for <iommu@lists.linux-foundation.org>;
 Sat, 17 Apr 2021 01:13:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 090A36064B
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 01:13:10 +0000 (UTC)
IronPort-SDR: We13nNMWNFMXV2HKb4qBKg26Ko2eKOf3U5nw3ib+mBBXtPAZo0g/LlIwtfHUibBUwKoo+lR5vO
 QhSn96SL55PQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="194694047"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
 d="gz'50?scan'50,208,50";a="194694047"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 18:13:10 -0700
IronPort-SDR: DqM1todN+3WtJoKFM7bKo1IZPalVm4SbzzNh1vcfBHdp0M91b1ZyKU8A0mcJIbUFkHqLetKZkJ
 OcDYWYVNyCIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
 d="gz'50?scan'50,208,50";a="462142101"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
 by orsmga001.jf.intel.com with ESMTP; 16 Apr 2021 18:13:05 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lXZWD-0000cK-87; Sat, 17 Apr 2021 01:13:05 +0000
Date: Sat, 17 Apr 2021 09:12:05 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: Re: [PATCH v3 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <202104170909.PiIfA5HA-lkp@intel.com>
References: <1618577114-30156-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <1618577114-30156-3-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, kbuild-all@lists.01.org,
 Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jacob,

I love your patch! Yet something to improve:

[auto build test ERROR on e49d033bddf5b565044e2abe4241353959bc9120]

url:    https://github.com/0day-ci/linux/commits/Jacob-Pan/Simplify-and-restrict-IOMMU-SVA-APIs/20210417-052451
base:   e49d033bddf5b565044e2abe4241353959bc9120
config: arm64-randconfig-r022-20210416 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6d85fee95bdcd7e53f10442ddc71d0c310d43367
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jacob-Pan/Simplify-and-restrict-IOMMU-SVA-APIs/20210417-052451
        git checkout 6d85fee95bdcd7e53f10442ddc71d0c310d43367
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2631:15: error: initialization of 'struct iommu_sva * (*)(struct device *, unsigned int)' from incompatible pointer type 'struct iommu_sva * (*)(struct device *, struct mm_struct *, unsigned int)' [-Werror=incompatible-pointer-types]
    2631 |  .sva_bind  = arm_smmu_sva_bind,
         |               ^~~~~~~~~~~~~~~~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2631:15: note: (near initialization for 'arm_smmu_ops.sva_bind')
   cc1: some warnings being treated as errors


vim +2631 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

f534d98b9d2705 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c Jean-Philippe Brucker 2020-09-18  2608  
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2609  static struct iommu_ops arm_smmu_ops = {
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2610  	.capable		= arm_smmu_capable,
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2611  	.domain_alloc		= arm_smmu_domain_alloc,
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2612  	.domain_free		= arm_smmu_domain_free,
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2613  	.attach_dev		= arm_smmu_attach_dev,
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2614  	.map			= arm_smmu_map,
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2615  	.unmap			= arm_smmu_unmap,
07fdef34d2be68 drivers/iommu/arm-smmu-v3.c                 Zhen Lei              2018-09-20  2616  	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
32b124492bdf97 drivers/iommu/arm-smmu-v3.c                 Robin Murphy          2017-09-28  2617  	.iotlb_sync		= arm_smmu_iotlb_sync,
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2618  	.iova_to_phys		= arm_smmu_iova_to_phys,
cefa0d55da3753 drivers/iommu/arm-smmu-v3.c                 Joerg Roedel          2020-04-29  2619  	.probe_device		= arm_smmu_probe_device,
cefa0d55da3753 drivers/iommu/arm-smmu-v3.c                 Joerg Roedel          2020-04-29  2620  	.release_device		= arm_smmu_release_device,
08d4ca2a672bab drivers/iommu/arm-smmu-v3.c                 Robin Murphy          2016-09-12  2621  	.device_group		= arm_smmu_device_group,
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2622  	.domain_get_attr	= arm_smmu_domain_get_attr,
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2623  	.domain_set_attr	= arm_smmu_domain_set_attr,
8f78515425daea drivers/iommu/arm-smmu-v3.c                 Robin Murphy          2016-09-12  2624  	.of_xlate		= arm_smmu_of_xlate,
50019f09a4baa0 drivers/iommu/arm-smmu-v3.c                 Eric Auger            2017-01-19  2625  	.get_resv_regions	= arm_smmu_get_resv_regions,
a66c5dc549d1e1 drivers/iommu/arm-smmu-v3.c                 Thierry Reding        2019-12-18  2626  	.put_resv_regions	= generic_iommu_put_resv_regions,
f534d98b9d2705 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c Jean-Philippe Brucker 2020-09-18  2627  	.dev_has_feat		= arm_smmu_dev_has_feature,
f534d98b9d2705 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c Jean-Philippe Brucker 2020-09-18  2628  	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
f534d98b9d2705 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c Jean-Philippe Brucker 2020-09-18  2629  	.dev_enable_feat	= arm_smmu_dev_enable_feature,
f534d98b9d2705 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c Jean-Philippe Brucker 2020-09-18  2630  	.dev_disable_feat	= arm_smmu_dev_disable_feature,
32784a9562fb05 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c Jean-Philippe Brucker 2020-11-06 @2631  	.sva_bind		= arm_smmu_sva_bind,
32784a9562fb05 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c Jean-Philippe Brucker 2020-11-06  2632  	.sva_unbind		= arm_smmu_sva_unbind,
32784a9562fb05 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c Jean-Philippe Brucker 2020-11-06  2633  	.sva_get_pasid		= arm_smmu_sva_get_pasid,
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2634  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2635  };
48ec83bcbcf509 drivers/iommu/arm-smmu-v3.c                 Will Deacon           2015-05-27  2636  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RgXMOA3TlEUTnKtI7kBqInF1xeaOQ3NDlma+000WhY8oGsh4yFY1mTac1QwHa9j/EcUHcuKs
sZUBA05f+oABfOZv0vPr6/lNV6LTBPp9p2JqtJkaRflUxOq+nFapLlqzeign+SH5soko1ztk
ImC3gYq1Rr9oHJKSDZwShVV+Zbmb+MZ6lHuAFicDJ9RtI7PADx38O0IzxiEzj15WgCIzvgoE
EomCIPYgOCXLjboBTtcQxH5jEpOmYBwRerMGjxQAcRgXCTGvPhoyDtVE6EXmAcWXBQIJucE8
dI3fM7OqCVmVn/NOg8tasrZPhqfiHCwyUrDXW0jxR3HwjM1mOBEzF7tcw3YPCWuhT18TqtDz
ybjRXHoKXFNqC6KJ5cOFpNmcdJYDTOzh05N/lBN5ZmBiiQiCOSWoSuQc3boVLHS12uU51ge/
HLIQX9lPMuYh5zdfvr++/lCKZouDSDVwtquqB5LlWRWoVKHH//1+fHv6ccN+vF2+Hj9O/wcR
frOM/V6XZf96Lc2PhInG4+X8/nt2+ri8n/77HeIHoGMpi6341ciCaaIKGbfq6+PH8beSkx2/
3JTn87ebX3gXfr35c+jih9ZF3OxyRpstCszc1Yf6nzYzJu+8OlKILT7/eD9/PJ2/HXlf+rN7
vJAxN3Tw9RBAKJBdDzJ4itCDTeyhJDs0zIvpUeCoWYAO+pUbWr/Ng1/AEKNbHhLm8XuRTjfC
cHkNbuYeqHe+EzgTqh917Kwemq3UNFknkkBB7LUraIgKbaLbFb9SOdS+sydMCgTHx5fLV00A
66Hvl5vm8XK8qc5vpwue32U+m+EcKRJEi8+g3XcmL5qA8vT+kk1rSL23sq/fX09fTpcf2kIc
+1X9P2NP0tw4rvP9+xWpPk/XxGucr6oPtCTbamuLSDtOLqpM4u52TbbKUm/m/foHkKJMkJBn
DjNpAxBXEARJLMMRexCIV8qVYis8gbjG4QAYkviKKyWH7mnG/Kbs0MIIO63UhkbBlymoh1yT
EDEkUxf0zIhJkC8fGK/8aX/3/vm2f9qDZv4JIxUsQXIL24KmIehiEoCoxpx6CyllFlLKLKRS
zi68pMYtrGdddGhS0DrfubpAWmybNMrHICXOeain/7kYqv0BBhbqVC9U8hLiIvyyLIJTJDOZ
T2O564OziqnFnSivSUdkLz3BAm4BOJk0QrMLPb6kmFDaOqcst4bi73EjR+zVlYg3eLHk8lQ2
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
8iQIduQ74P8ApydZpqX5AQA=

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--u3/rZRmxL6MmkK24--
