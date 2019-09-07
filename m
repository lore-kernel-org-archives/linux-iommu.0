Return-Path: <SRS0=yK3q=XC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D97C43331
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 05:54:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9351E21670
	for <iommu@archiver.kernel.org>; Sat,  7 Sep 2019 05:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9351E21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 45C5EE1B;
	Sat,  7 Sep 2019 05:54:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3201A2961
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 00:14:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
	[148.163.158.5])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DEECF756
	for <iommu@lists.linux-foundation.org>;
	Sat,  7 Sep 2019 00:14:02 +0000 (UTC)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x8707cvU014844; Fri, 6 Sep 2019 20:13:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2uv1jrrden-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 06 Sep 2019 20:13:57 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x87092bj017643;
	Fri, 6 Sep 2019 20:13:56 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
	[169.53.41.122])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2uv1jrrdee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 06 Sep 2019 20:13:56 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id
	x8709OHn006177; Sat, 7 Sep 2019 00:13:56 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
	[9.57.198.28]) by ppma04dal.us.ibm.com with ESMTP id 2uqgh7t8ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Sat, 07 Sep 2019 00:13:56 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
	[9.57.199.107])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x870Drx652887816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Sat, 7 Sep 2019 00:13:53 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 427A8124053;
	Sat,  7 Sep 2019 00:13:53 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B21D5124052;
	Sat,  7 Sep 2019 00:13:52 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.134.207])
	by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
	Sat,  7 Sep 2019 00:13:52 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: sebott@linux.ibm.com
Subject: [PATCH v4 0/4] Retrieving zPCI specific info with VFIO
Date: Fri,  6 Sep 2019 20:13:47 -0400
Message-Id: <1567815231-17940-1-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-09-06_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1906280000 definitions=main-1909070000
X-Mailman-Approved-At: Sat, 07 Sep 2019 05:54:18 +0000
Cc: linux-s390@vger.kernel.org, walling@linux.ibm.com,
	alex.williamson@redhat.com, gor@linux.ibm.com,
	kvm@vger.kernel.org, pmorel@linux.ibm.com, cohuck@redhat.com,
	heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
	pasic@linux.ibm.com, borntraeger@de.ibm.com,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Note: These patches by Pierre got lost in the ether a few months back
as he has been unavailable to carry them forward.  I've made changes
based upon comments received on his last version.

We define a new configuration entry for VFIO/PCI, VFIO_PCI_ZDEV
to configure access to a zPCI region dedicated for retrieving
zPCI features.

When the VFIO_PCI_ZDEV feature is configured we initialize
a new device region, VFIO_REGION_SUBTYPE_ZDEV_CLP, to hold
the information from the ZPCI device the userland needs to
give to a guest driving the zPCI function.


Note that in the current state we do not use the CLP instructions
to access the firmware but get the information directly from
the zdev device.

-This means that the patch 1, "s390: pci: Exporting access to CLP PCI
function and PCI group" is not used and can be let out of this series
without denying the good working of the other patches.
- But we will need this later, eventually in the next iteration
  to retrieve values not being saved inside the zdev structure.
  like maxstbl and the PCI supported version

To share the code with arch/s390/pci/pci_clp.c the original functions
in pci_clp.c to query PCI functions and PCI functions group are
modified so that they can be exported.

A new function clp_query_pci() replaces clp_query_pci_fn() and
the previous calls to clp_query_pci_fn() and clp_query_pci_fngrp()
are replaced with calls to zdev_query_pci_fn() and zdev_query_pci_fngrp()
using a zdev pointer as argument.

Changes since v3:
- New patch: define maxstbl
- Remove CLP_UTIL_STR_LEN references from uapi header
- Fix broken ifdef CONFIG_VFIO_PCI_ZDEV
- Change Kconfig option from tristate to bool
- Remove VFIO_REGION_TYPE_IBM_ZDEV, move VFIO_REGION_SUBTYPE_ZDEV_CLP to a 1014 subtype
- reject iswrite in .rw callback
- Remove rw restriction on identical buffer sizes
- Allow arbitrary sized read

Pierre Morel (4):
  s390: pci: Exporting access to CLP PCI function and PCI group
  s390: pci: Define the maxstbl CLP response entry
  vfio: zpci: defining the VFIO headers
  vfio: pci: Using a device region to retrieve zPCI information

 arch/s390/include/asm/pci.h         |  3 ++
 arch/s390/include/asm/pci_clp.h     |  2 +-
 arch/s390/pci/pci_clp.c             | 71 ++++++++++++++++---------------
 drivers/vfio/pci/Kconfig            |  7 +++
 drivers/vfio/pci/Makefile           |  1 +
 drivers/vfio/pci/vfio_pci.c         |  9 ++++
 drivers/vfio/pci/vfio_pci_private.h | 10 +++++
 drivers/vfio/pci/vfio_pci_zdev.c    | 85 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h           |  1 +
 include/uapi/linux/vfio_zdev.h      | 35 +++++++++++++++
 10 files changed, 189 insertions(+), 35 deletions(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c
 create mode 100644 include/uapi/linux/vfio_zdev.h

-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
