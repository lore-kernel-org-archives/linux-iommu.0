Return-Path: <SRS0=orEQ=4R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C01AC3F2C6
	for <iommu@archiver.kernel.org>; Sat, 29 Feb 2020 14:24:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E27924650
	for <iommu@archiver.kernel.org>; Sat, 29 Feb 2020 14:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E27924650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EC8E2881D9;
	Sat, 29 Feb 2020 14:24:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PmcF-yYdgPoN; Sat, 29 Feb 2020 14:24:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 832518818B;
	Sat, 29 Feb 2020 14:24:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74618C1D84;
	Sat, 29 Feb 2020 14:24:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47DBDC0177;
 Sat, 29 Feb 2020 14:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3F5008818E;
 Sat, 29 Feb 2020 14:24:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id at6KAmS3zq7K; Sat, 29 Feb 2020 14:24:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 049948818B;
 Sat, 29 Feb 2020 14:24:12 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Feb 2020 06:24:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,500,1574150400"; d="scan'208";a="232825654"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 29 Feb 2020 06:24:10 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1j832H-0003a4-Nc; Sat, 29 Feb 2020 22:24:09 +0800
Date: Sat, 29 Feb 2020 22:23:27 +0800
From: kbuild test robot <lkp@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 3/3] iommu/virtio: Enable x86 support
Message-ID: <202002292217.iPza6SpM%lkp@intel.com>
References: <20200228172537.377327-4-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200228172537.377327-4-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 kbuild-all@lists.01.org, virtualization@lists.linux-foundation.org
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

Hi Jean-Philippe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iommu/next]
[cannot apply to pci/next linus/master v5.6-rc3 next-20200228]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Jean-Philippe-Brucker/virtio-iommu-on-x86-and-non-devicetree-platforms/20200229-085019
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-173-ge0787745-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/iommu/virtio-iommu.c:1024:9: sparse: sparse: incompatible types in comparison expression (different base types):
>> drivers/iommu/virtio-iommu.c:1024:9: sparse:    restricted __le64 *
>> drivers/iommu/virtio-iommu.c:1024:9: sparse:    unsigned long long *
   drivers/iommu/virtio-iommu.c:1036:9: sparse: sparse: incompatible types in comparison expression (different base types):
   drivers/iommu/virtio-iommu.c:1036:9: sparse:    restricted __le64 *
   drivers/iommu/virtio-iommu.c:1036:9: sparse:    unsigned long long *
   drivers/iommu/virtio-iommu.c:1040:9: sparse: sparse: incompatible types in comparison expression (different base types):
   drivers/iommu/virtio-iommu.c:1040:9: sparse:    restricted __le64 *
   drivers/iommu/virtio-iommu.c:1040:9: sparse:    unsigned long long *
   drivers/iommu/virtio-iommu.c:1044:9: sparse: sparse: incompatible types in comparison expression (different base types):
>> drivers/iommu/virtio-iommu.c:1044:9: sparse:    restricted __le32 *
>> drivers/iommu/virtio-iommu.c:1044:9: sparse:    unsigned int *
   drivers/iommu/virtio-iommu.c:1048:9: sparse: sparse: incompatible types in comparison expression (different base types):
   drivers/iommu/virtio-iommu.c:1048:9: sparse:    restricted __le32 *
   drivers/iommu/virtio-iommu.c:1048:9: sparse:    unsigned int *
   drivers/iommu/virtio-iommu.c:1052:9: sparse: sparse: incompatible types in comparison expression (different base types):
   drivers/iommu/virtio-iommu.c:1052:9: sparse:    restricted __le32 *
   drivers/iommu/virtio-iommu.c:1052:9: sparse:    unsigned int *

vim +1024 drivers/iommu/virtio-iommu.c

edcd69ab9a323b Jean-Philippe Brucker 2019-01-15   996  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15   997  static int viommu_probe(struct virtio_device *vdev)
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15   998  {
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15   999  	struct device *parent_dev = vdev->dev.parent;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1000  	struct viommu_dev *viommu = NULL;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1001  	struct device *dev = &vdev->dev;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1002  	u64 input_start = 0;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1003  	u64 input_end = -1UL;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1004  	int ret;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1005  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1006  	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1007  	    !virtio_has_feature(vdev, VIRTIO_IOMMU_F_MAP_UNMAP))
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1008  		return -ENODEV;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1009  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1010  	viommu = devm_kzalloc(dev, sizeof(*viommu), GFP_KERNEL);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1011  	if (!viommu)
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1012  		return -ENOMEM;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1013  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1014  	spin_lock_init(&viommu->request_lock);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1015  	ida_init(&viommu->domain_ids);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1016  	viommu->dev = dev;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1017  	viommu->vdev = vdev;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1018  	INIT_LIST_HEAD(&viommu->requests);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1019  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1020  	ret = viommu_init_vqs(viommu);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1021  	if (ret)
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1022  		return ret;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1023  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15 @1024  	virtio_cread(vdev, struct virtio_iommu_config, page_size_mask,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1025  		     &viommu->pgsize_bitmap);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1026  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1027  	if (!viommu->pgsize_bitmap) {
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1028  		ret = -EINVAL;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1029  		goto err_free_vqs;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1030  	}
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1031  
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1032  	viommu->map_flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1033  	viommu->last_domain = ~0U;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1034  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1035  	/* Optional features */
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1036  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1037  			     struct virtio_iommu_config, input_range.start,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1038  			     &input_start);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1039  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1040  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_INPUT_RANGE,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1041  			     struct virtio_iommu_config, input_range.end,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1042  			     &input_end);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1043  
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22 @1044  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1045  			     struct virtio_iommu_config, domain_range.start,
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1046  			     &viommu->first_domain);
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1047  
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1048  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_DOMAIN_RANGE,
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1049  			     struct virtio_iommu_config, domain_range.end,
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1050  			     &viommu->last_domain);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1051  
2a5a314874450d Jean-Philippe Brucker 2019-01-15  1052  	virtio_cread_feature(vdev, VIRTIO_IOMMU_F_PROBE,
2a5a314874450d Jean-Philippe Brucker 2019-01-15  1053  			     struct virtio_iommu_config, probe_size,
2a5a314874450d Jean-Philippe Brucker 2019-01-15  1054  			     &viommu->probe_size);
2a5a314874450d Jean-Philippe Brucker 2019-01-15  1055  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1056  	viommu->geometry = (struct iommu_domain_geometry) {
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1057  		.aperture_start	= input_start,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1058  		.aperture_end	= input_end,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1059  		.force_aperture	= true,
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1060  	};
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1061  
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1062  	if (virtio_has_feature(vdev, VIRTIO_IOMMU_F_MMIO))
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1063  		viommu->map_flags |= VIRTIO_IOMMU_MAP_F_MMIO;
ae24fb49d01103 Jean-Philippe Brucker 2019-07-22  1064  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1065  	viommu_ops.pgsize_bitmap = viommu->pgsize_bitmap;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1066  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1067  	virtio_device_ready(vdev);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1068  
169a126c6e88a9 Jean-Philippe Brucker 2019-01-15  1069  	/* Populate the event queue with buffers */
169a126c6e88a9 Jean-Philippe Brucker 2019-01-15  1070  	ret = viommu_fill_evtq(viommu);
169a126c6e88a9 Jean-Philippe Brucker 2019-01-15  1071  	if (ret)
169a126c6e88a9 Jean-Philippe Brucker 2019-01-15  1072  		goto err_free_vqs;
169a126c6e88a9 Jean-Philippe Brucker 2019-01-15  1073  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1074  	ret = iommu_device_sysfs_add(&viommu->iommu, dev, NULL, "%s",
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1075  				     virtio_bus_name(vdev));
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1076  	if (ret)
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1077  		goto err_free_vqs;
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1078  
136495ceb43b56 Jean-Philippe Brucker 2020-02-28  1079  	virt_set_iommu_ops(dev->parent, &viommu_ops);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1080  	iommu_device_set_ops(&viommu->iommu, &viommu_ops);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1081  	iommu_device_set_fwnode(&viommu->iommu, parent_dev->fwnode);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1082  
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1083  	iommu_device_register(&viommu->iommu);
edcd69ab9a323b Jean-Philippe Brucker 2019-01-15  1084  

:::::: The code at line 1024 was first introduced by commit
:::::: edcd69ab9a323b7ac7a86e1c44b6c9c46598391f iommu: Add virtio-iommu driver

:::::: TO: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
