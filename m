Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61729C433E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 13:33:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310D9206E2
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 13:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310D9206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EDA8988FFF;
	Tue,  7 Jul 2020 13:33:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id egZWYq0mEZ2z; Tue,  7 Jul 2020 13:33:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 309CF88FDD;
	Tue,  7 Jul 2020 13:33:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 286CBC07FF;
	Tue,  7 Jul 2020 13:33:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19034C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 13:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EBEC2899EA
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 13:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CxpqNrYoYFsq for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 13:33:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 235ED899D0
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 13:33:33 +0000 (UTC)
IronPort-SDR: gobRUoBl4aRCNSQvRZndU47eCgiCICF27wsgwC3mUP3kHrEpRisM0Xab6e9OqSQK71AO4zZBtI
 NqW051epVifA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="145686814"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; 
 d="gz'50?scan'50,208,50";a="145686814"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 06:33:32 -0700
IronPort-SDR: 7qzoBRJkNd32O8XbRkONL00AUvGafrV0B+R6V2E1ICGS/SNNFVLNKQpPUwHDQZxUbK0nJYdLbX
 FFlL6QR1YfOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; 
 d="gz'50?scan'50,208,50";a="427473081"
Received: from lkp-server01.sh.intel.com (HELO f2047cb89c8e) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 07 Jul 2020 06:33:28 -0700
Received: from kbuild by f2047cb89c8e with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1jsnix-0000EF-E3; Tue, 07 Jul 2020 13:33:27 +0000
Date: Tue, 7 Jul 2020 21:32:40 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 4/7] iommu/vt-d: Handle non-page aligned address
Message-ID: <202007072152.EVgFqx18%lkp@intel.com>
References: <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <1594080774-33413-5-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, kbuild-all@lists.01.org,
 Raj Ashok <ashok.raj@intel.com>
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


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jacob,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iommu/next]
[also build test WARNING on linux/master linus/master v5.8-rc4 next-20200707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jacob-Pan/iommu-vt-d-Misc-tweaks-and-fixes-for-vSVA/20200707-081026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-randconfig-m031-20200707 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-14) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:6,
                    from include/linux/uuid.h:12,
                    from include/linux/mod_devicetable.h:13,
                    from include/linux/pci.h:27,
                    from drivers/iommu/intel/dmar.c:19:
   drivers/iommu/intel/dmar.c: In function 'qi_flush_dev_iotlb_pasid':
   include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                            ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
>> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |  ^~
   include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:45:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro 'GENMASK_ULL'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |             ^~~~~~~~~~~
   include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                                        ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
>> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |  ^~
   include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:45:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro 'GENMASK_ULL'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |             ^~~~~~~~~~~
   include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                            ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
>> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |  ^~
   include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:45:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro 'GENMASK_ULL'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |             ^~~~~~~~~~~
   include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                                        ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
>> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |  ^~
   include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:45:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro 'GENMASK_ULL'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |             ^~~~~~~~~~~
   include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                            ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
      69 |  (cond) ?     \
         |   ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
>> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |  ^~
   include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:45:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro 'GENMASK_ULL'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |             ^~~~~~~~~~~
   include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
      26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
         |                                        ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
      69 |  (cond) ?     \
         |   ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
>> drivers/iommu/intel/dmar.c:1459:2: note: in expansion of macro 'if'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |  ^~
   include/linux/bits.h:25:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      25 |  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:45:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      45 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/iommu/intel/dmar.c:1459:13: note: in expansion of macro 'GENMASK_ULL'
    1459 |  if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
         |             ^~~~~~~~~~~

vim +/if +1459 drivers/iommu/intel/dmar.c

  1438	
  1439	/* PASID-based device IOTLB Invalidate */
  1440	void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
  1441				      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
  1442	{
  1443		unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
  1444		struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
  1445	
  1446		desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
  1447			QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
  1448			QI_DEV_IOTLB_PFSID(pfsid);
  1449	
  1450		/*
  1451		 * If S bit is 0, we only flush a single page. If S bit is set,
  1452		 * The least significant zero bit indicates the invalidation address
  1453		 * range. VT-d spec 6.5.2.6.
  1454		 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates 16KB.
  1455		 * size order = 0 is PAGE_SIZE 4KB
  1456		 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
  1457		 * ECAP.
  1458		 */
> 1459		if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
  1460			pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n", addr, size_order);
  1461	
  1462		/* Take page address */
  1463		desc.qw1 = QI_DEV_EIOTLB_ADDR(addr);
  1464	
  1465		if (size_order) {
  1466			/*
  1467			 * Existing 0s in address below size_order may be the least
  1468			 * significant bit, we must set them to 1s to avoid having
  1469			 * smaller size than desired.
  1470			 */
  1471			desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT,
  1472						VTD_PAGE_SHIFT);
  1473			/* Clear size_order bit to indicate size */
  1474			desc.qw1 &= ~mask;
  1475			/* Set the S bit to indicate flushing more than 1 page */
  1476			desc.qw1 |= QI_DEV_EIOTLB_SIZE;
  1477		}
  1478	
  1479		qi_submit_sync(iommu, &desc, 1, 0);
  1480	}
  1481	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6c2NcOVqGQ03X4Wi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--6c2NcOVqGQ03X4Wi--
