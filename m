Return-Path: <SRS0=aUVl=TX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30988C04AAC
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 08:45:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E4620881
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 08:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E4620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 75BDAD7D;
	Thu, 23 May 2019 08:45:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8B3E9A7F
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 08:45:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BA6835D0
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 08:45:01 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 May 2019 01:45:00 -0700
X-ExtLoop1: 1
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
	by fmsmga001.fm.intel.com with ESMTP; 23 May 2019 01:45:00 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
	fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Thu, 23 May 2019 01:45:00 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
	fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Thu, 23 May 2019 01:44:59 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.33]) by
	SHSMSX103.ccr.corp.intel.com ([169.254.4.70]) with mapi id
	14.03.0415.000; Thu, 23 May 2019 16:44:58 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"kwankhede@nvidia.com" <kwankhede@nvidia.com>
Subject: RE: [RFC v3 0/3] vfio_pci: wrap pci device as a mediated device
Thread-Topic: [RFC v3 0/3] vfio_pci: wrap pci device as a mediated device
Thread-Index: AQHU+pmUgYQWOZcgyUar+GqJiI6/NqZ4kV4g
Date: Thu, 23 May 2019 08:44:57 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439EB884E@SHSMSX104.ccr.corp.intel.com>
References: <1556021680-2911-1-git-send-email-yi.l.liu@intel.com>
In-Reply-To: <1556021680-2911-1-git-send-email-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2M0ZDE2YWUtNWFmNS00OTc5LWI2OTEtZjM0MGU2ZGZkYWMwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUU9yeGtsbDQ2aDFqQm82akQxQkJDOVVPY2Y1cE9Vck9JZlJYRDhnYzQrM0t6aWMwemNyWHNKWjBGbmFJSHczbyJ9
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
	"Sun, Yi Y" <yi.y.sun@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Hi Alex,

Sorry to disturb you. Do you want to review on this version or review a rebased version? :-) If rebase version is better, I can try to do it asap.

Thanks,
Yi Liu

> -----Original Message-----
> From: Liu, Yi L
> Sent: Tuesday, April 23, 2019 8:15 PM
> To: alex.williamson@redhat.com; kwankhede@nvidia.com
> Cc: Tian, Kevin <kevin.tian@intel.com>; baolu.lu@linux.intel.com; Liu, Yi L
> <yi.l.liu@intel.com>; Sun, Yi Y <yi.y.sun@intel.com>; joro@8bytes.org; jean-
> philippe.brucker@arm.com; peterx@redhat.com; linux-kernel@vger.kernel.org;
> kvm@vger.kernel.org; yamada.masahiro@socionext.com; iommu@lists.linux-
> foundation.org
> Subject: [RFC v3 0/3] vfio_pci: wrap pci device as a mediated device
> 
> This patchset aims to add a vfio-pci-like meta driver as a demo user of the vfio
> changes introduced in "vfio/mdev: IOMMU aware mediated device" patchset from
> Baolu Lu.
> 
> Previous RFC v1 has given two proposals and the discussion could be found in
> following link. Per the comments, this patchset adds a separate driver named vfio-
> mdev-pci. It is a sample driver, but loactes in drivers/vfio/pci due to code sharing
> consideration.
> The corresponding Kconfig definition is in samples/Kconfig.
> 
> https://lkml.org/lkml/2019/3/4/529
> 
> Besides the test purpose, per Alex's comments, it could also be a good base driver
> for experimenting with device specific mdev migration.
> 
> Specific interface tested in this proposal:
> 
> *) int mdev_set_iommu_device(struct device *dev,
> 				struct device *iommu_device)
>    introduced in the patch as below:
>    "[PATCH v5 6/8] vfio/mdev: Add iommu related member in mdev_device"
> 
> 
> Links:
> *) Link of "vfio/mdev: IOMMU aware mediated device"
> 	https://lwn.net/Articles/780522/
> 
> Please feel free give your comments.
> 
> Thanks,
> Yi Liu
> 
> Change log:
>   v2->v3:
>   - use vfio-mdev-pci instead of vfio-pci-mdev
>   - place the new driver under drivers/vfio/pci while define
>     Kconfig in samples/Kconfig to clarify it is a sample driver
> 
>   v1->v2:
>   - instead of adding kernel option to existing vfio-pci
>     module in v1, v2 follows Alex's suggestion to add a
>     separate vfio-pci-mdev module.
>   - new patchset subject: "vfio/pci: wrap pci device as a mediated device"
> 
> Liu, Yi L (3):
>   vfio_pci: split vfio_pci.c into two source files
>   vfio/pci: protect cap/ecap_perm bits alloc/free with atomic op
>   smaples: add vfio-mdev-pci driver
> 
>  drivers/vfio/pci/Makefile           |    7 +-
>  drivers/vfio/pci/common.c           | 1511 +++++++++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_mdev_pci.c    |  386 +++++++++
>  drivers/vfio/pci/vfio_pci.c         | 1476 +---------------------------------
>  drivers/vfio/pci/vfio_pci_config.c  |    9 +
>  drivers/vfio/pci/vfio_pci_private.h |   27 +
>  samples/Kconfig                     |   11 +
>  7 files changed, 1962 insertions(+), 1465 deletions(-)  create mode 100644
> drivers/vfio/pci/common.c  create mode 100644 drivers/vfio/pci/vfio_mdev_pci.c
> 
> --
> 2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
