Return-Path: <SRS0=Veyj=Z6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160BFC43603
	for <iommu@archiver.kernel.org>; Sun,  8 Dec 2019 00:48:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06AB205F4
	for <iommu@archiver.kernel.org>; Sun,  8 Dec 2019 00:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06AB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9254C20412;
	Sun,  8 Dec 2019 00:48:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CvAWOU4FPvrD; Sun,  8 Dec 2019 00:48:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 881F0203AA;
	Sun,  8 Dec 2019 00:48:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B50AC1D7E;
	Sun,  8 Dec 2019 00:48:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB8C1C077D
 for <iommu@lists.linux-foundation.org>; Sun,  8 Dec 2019 00:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BF41D86759
 for <iommu@lists.linux-foundation.org>; Sun,  8 Dec 2019 00:48:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8JPEqA2ap4kJ for <iommu@lists.linux-foundation.org>;
 Sun,  8 Dec 2019 00:48:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9182886747
 for <iommu@lists.linux-foundation.org>; Sun,  8 Dec 2019 00:48:42 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Dec 2019 16:48:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,290,1571727600"; d="scan'208";a="202479633"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 07 Dec 2019 16:48:39 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1idkkY-00094a-Do; Sun, 08 Dec 2019 08:48:38 +0800
Date: Sun, 8 Dec 2019 08:48:29 +0800
From: kbuild test robot <lkp@intel.com>
To: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH v6 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
Message-ID: <201912080729.iJaJfY0k%lkp@intel.com>
References: <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Alex Williamson <alex.williamson@redhat.com>, kbuild-all@lists.01.org,
 Dmitry Safonov <dima@arista.com>, linux-pci@vger.kernel.org,
 Dmitry Safonov <0x7f454c46@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>
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

Hi James,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.4-rc8]
[also build test WARNING on next-20191206]
[cannot apply to pci/next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/James-Sewart/PCI-Fix-off-by-one-in-dma_alias_mask-allocation-size/20191204-034421
base:    af42d3466bdc8f39806b26f593604fdc54140bcb
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-91-g817270f-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/iommu/amd_iommu.c:288:34: sparse: sparse: not enough arguments for function pci_add_dma_alias

vim +288 drivers/iommu/amd_iommu.c

e3156048346c28 Joerg Roedel   2016-04-08  234  
e3156048346c28 Joerg Roedel   2016-04-08  235  static u16 get_alias(struct device *dev)
e3156048346c28 Joerg Roedel   2016-04-08  236  {
e3156048346c28 Joerg Roedel   2016-04-08  237  	struct pci_dev *pdev = to_pci_dev(dev);
e3156048346c28 Joerg Roedel   2016-04-08  238  	u16 devid, ivrs_alias, pci_alias;
e3156048346c28 Joerg Roedel   2016-04-08  239  
6c0b43df74f900 Joerg Roedel   2016-05-09  240  	/* The callers make sure that get_device_id() does not fail here */
e3156048346c28 Joerg Roedel   2016-04-08  241  	devid = get_device_id(dev);
5ebb1bc2d63d90 Arindam Nath   2018-09-18  242  
5ebb1bc2d63d90 Arindam Nath   2018-09-18  243  	/* For ACPI HID devices, we simply return the devid as such */
5ebb1bc2d63d90 Arindam Nath   2018-09-18  244  	if (!dev_is_pci(dev))
5ebb1bc2d63d90 Arindam Nath   2018-09-18  245  		return devid;
5ebb1bc2d63d90 Arindam Nath   2018-09-18  246  
e3156048346c28 Joerg Roedel   2016-04-08  247  	ivrs_alias = amd_iommu_alias_table[devid];
5ebb1bc2d63d90 Arindam Nath   2018-09-18  248  
e3156048346c28 Joerg Roedel   2016-04-08  249  	pci_for_each_dma_alias(pdev, __last_alias, &pci_alias);
e3156048346c28 Joerg Roedel   2016-04-08  250  
e3156048346c28 Joerg Roedel   2016-04-08  251  	if (ivrs_alias == pci_alias)
e3156048346c28 Joerg Roedel   2016-04-08  252  		return ivrs_alias;
e3156048346c28 Joerg Roedel   2016-04-08  253  
e3156048346c28 Joerg Roedel   2016-04-08  254  	/*
e3156048346c28 Joerg Roedel   2016-04-08  255  	 * DMA alias showdown
e3156048346c28 Joerg Roedel   2016-04-08  256  	 *
e3156048346c28 Joerg Roedel   2016-04-08  257  	 * The IVRS is fairly reliable in telling us about aliases, but it
e3156048346c28 Joerg Roedel   2016-04-08  258  	 * can't know about every screwy device.  If we don't have an IVRS
e3156048346c28 Joerg Roedel   2016-04-08  259  	 * reported alias, use the PCI reported alias.  In that case we may
e3156048346c28 Joerg Roedel   2016-04-08  260  	 * still need to initialize the rlookup and dev_table entries if the
e3156048346c28 Joerg Roedel   2016-04-08  261  	 * alias is to a non-existent device.
e3156048346c28 Joerg Roedel   2016-04-08  262  	 */
e3156048346c28 Joerg Roedel   2016-04-08  263  	if (ivrs_alias == devid) {
e3156048346c28 Joerg Roedel   2016-04-08  264  		if (!amd_iommu_rlookup_table[pci_alias]) {
e3156048346c28 Joerg Roedel   2016-04-08  265  			amd_iommu_rlookup_table[pci_alias] =
e3156048346c28 Joerg Roedel   2016-04-08  266  				amd_iommu_rlookup_table[devid];
e3156048346c28 Joerg Roedel   2016-04-08  267  			memcpy(amd_iommu_dev_table[pci_alias].data,
e3156048346c28 Joerg Roedel   2016-04-08  268  			       amd_iommu_dev_table[devid].data,
e3156048346c28 Joerg Roedel   2016-04-08  269  			       sizeof(amd_iommu_dev_table[pci_alias].data));
e3156048346c28 Joerg Roedel   2016-04-08  270  		}
e3156048346c28 Joerg Roedel   2016-04-08  271  
e3156048346c28 Joerg Roedel   2016-04-08  272  		return pci_alias;
e3156048346c28 Joerg Roedel   2016-04-08  273  	}
e3156048346c28 Joerg Roedel   2016-04-08  274  
5f226da1b1d706 Bjorn Helgaas  2019-02-08  275  	pci_info(pdev, "Using IVRS reported alias %02x:%02x.%d "
5f226da1b1d706 Bjorn Helgaas  2019-02-08  276  		"for device [%04x:%04x], kernel reported alias "
e3156048346c28 Joerg Roedel   2016-04-08  277  		"%02x:%02x.%d\n", PCI_BUS_NUM(ivrs_alias), PCI_SLOT(ivrs_alias),
5f226da1b1d706 Bjorn Helgaas  2019-02-08  278  		PCI_FUNC(ivrs_alias), pdev->vendor, pdev->device,
e3156048346c28 Joerg Roedel   2016-04-08  279  		PCI_BUS_NUM(pci_alias), PCI_SLOT(pci_alias),
e3156048346c28 Joerg Roedel   2016-04-08  280  		PCI_FUNC(pci_alias));
e3156048346c28 Joerg Roedel   2016-04-08  281  
e3156048346c28 Joerg Roedel   2016-04-08  282  	/*
e3156048346c28 Joerg Roedel   2016-04-08  283  	 * If we don't have a PCI DMA alias and the IVRS alias is on the same
e3156048346c28 Joerg Roedel   2016-04-08  284  	 * bus, then the IVRS table may know about a quirk that we don't.
e3156048346c28 Joerg Roedel   2016-04-08  285  	 */
e3156048346c28 Joerg Roedel   2016-04-08  286  	if (pci_alias == devid &&
e3156048346c28 Joerg Roedel   2016-04-08  287  	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
7afd16f882887c Linus Torvalds 2016-05-19 @288  		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
5f226da1b1d706 Bjorn Helgaas  2019-02-08  289  		pci_info(pdev, "Added PCI DMA alias %02x.%d\n",
5f226da1b1d706 Bjorn Helgaas  2019-02-08  290  			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias));
e3156048346c28 Joerg Roedel   2016-04-08  291  	}
e3156048346c28 Joerg Roedel   2016-04-08  292  
e3156048346c28 Joerg Roedel   2016-04-08  293  	return ivrs_alias;
e3156048346c28 Joerg Roedel   2016-04-08  294  }
e3156048346c28 Joerg Roedel   2016-04-08  295  

:::::: The code at line 288 was first introduced by commit
:::::: 7afd16f882887c9adc69cd1794f5e57777723217 Merge tag 'pci-v4.7-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
