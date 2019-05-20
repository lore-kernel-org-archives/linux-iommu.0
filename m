Return-Path: <SRS0=A2w3=TU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5F3C04AB4
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 03:02:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE769205ED
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 03:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE769205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E1CEEA70;
	Mon, 20 May 2019 03:02:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 96AE5A55
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 03:02:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A1B047ED
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 03:02:22 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 May 2019 20:02:21 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
	by fmsmga005.fm.intel.com with ESMTP; 19 May 2019 20:02:19 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
	(envelope-from <lkp@intel.com>)
	id 1hSYZ8-00023d-Qb; Mon, 20 May 2019 11:02:18 +0800
Date: Mon, 20 May 2019 11:02:15 +0800
From: kbuild test robot <lkp@intel.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] vfio: vfio_iommu_type1: implement
	VFIO_IOMMU_INFO_CAPABILITIES
Message-ID: <201905201003.EM66D2dQ%lkp@intel.com>
References: <1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com,
	alex.williamson@redhat.com, kvm@vger.kernel.org,
	heiko.carstens@de.ibm.com, sebott@linux.vnet.ibm.com,
	walling@linux.ibm.com, linux-kernel@vger.kernel.org,
	borntraeger@de.ibm.com, iommu@lists.linux-foundation.org,
	kbuild-all@01.org, schwidefsky@de.ibm.com, robin.murphy@arm.com,
	gerald.schaefer@de.ibm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Pierre,

I love your patch! Perhaps something to improve:

[auto build test WARNING on s390/features]
[also build test WARNING on v5.1 next-20190517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pierre-Morel/s390-pci-Exporting-access-to-CLP-PCI-function-and-PCI-group/20190520-025155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/vfio/vfio_iommu_type1.c:1707:5: sparse: sparse: symbol 'vfio_iommu_type1_caps' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
