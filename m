Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4151C433F5
	for <iommu@archiver.kernel.org>; Sat, 28 May 2022 02:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C369847AD;
	Sat, 28 May 2022 02:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YloWBcVLX5pX; Sat, 28 May 2022 02:04:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED8D6847A1;
	Sat, 28 May 2022 02:04:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2B02C0039;
	Sat, 28 May 2022 02:04:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D079BC002D
 for <iommu@lists.linux-foundation.org>; Sat, 28 May 2022 02:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA3D460F71
 for <iommu@lists.linux-foundation.org>; Sat, 28 May 2022 02:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O2SUQjql_Zqh for <iommu@lists.linux-foundation.org>;
 Sat, 28 May 2022 02:04:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70A7560F4A
 for <iommu@lists.linux-foundation.org>; Sat, 28 May 2022 02:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653703477; x=1685239477;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zKpOzm/saM2/CRUSIPJrmqPjQqBfbs2x0FE088yI5cU=;
 b=QfU8mcs/G6H5Di02tzgCE65rMmRtU2VCSpFa5UozRDY2P5CX0tP5DmB/
 aD9z68SWRal7I42Av1pVZsdguM2Q6dzQSGQ6YGE681urbJS41zJvoa/Ol
 o+zfx4XoDR3G8WWVMp5JcbFMXfOZaiRTj39X//ejmjhNAv+yuy6rEJ57G
 DtqAT093TlVkSTEbT7Z5kGUIYq3ktIIukf9RCXiL/Qpb7ajjcaoVwMyA8
 OIUtOzx3YDw5skrAwn+L2vgAs5aocvDqIZaCy1xzsi2Ap6tTFoyVvVSd/
 YAF1aKHOfxLR4aY766wmDMsITkLiUTKU46nMcd5vvIF/pN+Z9wkafIZ9F Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="254485833"
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; d="scan'208";a="254485833"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2022 19:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,257,1647327600"; d="scan'208";a="719134865"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 27 May 2022 19:04:33 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1nuloe-0005MT-Bh;
 Sat, 28 May 2022 02:04:32 +0000
Date: Sat, 28 May 2022 10:03:51 +0800
From: kernel test robot <lkp@intel.com>
To: Konrad Dybcio <konrad.dybcio@somainline.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 4/6] iommu/qcom: Add support for AArch64 IOMMU pagetables
Message-ID: <202205280904.vsNCfpph-lkp@intel.com>
References: <20220527212901.29268-5-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220527212901.29268-5-konrad.dybcio@somainline.org>
Cc: devicetree@vger.kernel.org, kbuild-all@lists.01.org,
 Robin Murphy <robin.murphy@arm.com>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, linux-kernel@vger.kernel.org,
 jamipkettunen@somainline.org, Rob Herring <robh+dt@kernel.org>,
 Andy Gross <agross@kernel.org>, martin.botka@somainline.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org,
 Will Deacon <will@kernel.org>
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

Hi Konrad,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on joro-iommu/next]
[also build test WARNING on v5.18 next-20220527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/iommu-qcom-Use-the-asid-read-from-device-tree-if-specified/20220528-062952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220528/202205280904.vsNCfpph-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0744f7d6ebfff8d6854a24d0f95f8e58885b5212
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Konrad-Dybcio/iommu-qcom-Use-the-asid-read-from-device-tree-if-specified/20220528-062952
        git checkout 0744f7d6ebfff8d6854a24d0f95f8e58885b5212
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/iommu/arm/arm-smmu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iommu/arm/arm-smmu/qcom_iommu.c: In function 'qcom_iommu_tlb_inv_range_nosync':
>> drivers/iommu/arm/arm-smmu/qcom_iommu.c:174:58: warning: left shift count >= width of type [-Wshift-count-overflow]
     174 |                         iova |= (unsigned long)ctx->asid << 48;
         |                                                          ^~


vim +174 drivers/iommu/arm/arm-smmu/qcom_iommu.c

   157	
   158	static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
   159						    size_t granule, bool leaf, void *cookie)
   160	{
   161		struct qcom_iommu_domain *qcom_domain = cookie;
   162		struct iommu_fwspec *fwspec = qcom_domain->fwspec;
   163		unsigned i, reg;
   164	
   165		reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
   166	
   167		for (i = 0; i < fwspec->num_ids; i++) {
   168			struct qcom_iommu_dev *qcom_iommu = qcom_domain->iommu;
   169			struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
   170			size_t s = size;
   171	
   172			if (qcom_iommu->use_aarch64_pt) {
   173				iova >>= 12;
 > 174				iova |= (unsigned long)ctx->asid << 48;
   175			} else {
   176				iova &= (1UL << 12) - 1UL;
   177				iova |= ctx->asid;
   178			}
   179			do {
   180				iommu_writel(ctx, reg, iova);
   181				iova += granule;
   182			} while (s -= granule);
   183		}
   184	}
   185	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
