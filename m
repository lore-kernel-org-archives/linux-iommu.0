Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA42DC56202
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 14:40:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A30D223AB
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 14:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A30D223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EB31B214E6;
	Tue, 17 Nov 2020 14:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 33ilL2tjM95o; Tue, 17 Nov 2020 14:40:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9EDCA20111;
	Tue, 17 Nov 2020 14:40:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82C0DC0891;
	Tue, 17 Nov 2020 14:40:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BDD2C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 14:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2964D8639E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 14:40:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZXzVPH7vU3Q9 for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:40:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 41F8F86382
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 14:40:08 +0000 (UTC)
IronPort-SDR: +zbNT8AYRHHmZguVuDBC0a9eN9Nm2p9WnoXe98sWyt+/p13oqiYlX7KmY+Qvgk92EOqMfavdcg
 Nsy+PXKNRM6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="171104042"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; d="scan'208";a="171104042"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 06:40:01 -0800
IronPort-SDR: DFsIXHLgQqIVojG6gawwZvtSoSb8ApdFQe8B9nj2WzAOlvdK4OTMF/92Jcikey/4ur9YlPerar
 TBhKilJZCdmQ==
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; d="scan'208";a="367884411"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.201])
 ([10.254.210.201])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 06:39:57 -0800
To: Alex Williamson <alex.williamson@redhat.com>
References: <20201112022407.2063896-1-baolu.lu@linux.intel.com>
 <20201116125631.2d043fcd@w520.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] vfio/type1: Add subdev_ioasid callback to
 vfio_iommu_driver_ops
Message-ID: <c4526653-2e0d-2f9a-66ad-b3dba284a4d3@linux.intel.com>
Date: Tue, 17 Nov 2020 22:39:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116125631.2d043fcd@w520.home>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Alex,

On 2020/11/17 3:56, Alex Williamson wrote:
> On Thu, 12 Nov 2020 10:24:07 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> Add API for getting the ioasid of a subdevice (vfio/mdev). This calls
>> into the backend IOMMU module to get the actual value or error number
>> if ioasid for subdevice is not supported. The physical device driver
>> implementations which rely on the vfio/mdev framework for mediated
>> device user level access could typically consume this interface like
>> below:
>>
>> 	struct device *dev = mdev_dev(mdev);
>> 	unsigned int pasid;
>> 	int ret;
>>
>> 	ret = vfio_subdev_ioasid(dev, &pasid);
>> 	if (ret < 0)
>> 		return ret;
>>
>>           /* Program device context with pasid value. */
>>           ....
> 
> Seems like an overly specific callback.  We already export means for
> you to get a vfio_group, test that a device is an mdev, and get the
> iommu device from an mdev.  So you can already test whether a given
> device is an mdev with an iommu backing device that supports aux
> domains.  The only missing piece seems to be that you can't get the
> domain for a group in order to retrieve the pasid.  So why aren't we
> exporting a callback that given a vfio_group provides the iommu domain?

Make sense! Thanks for your guidance. :-)

So what we want to export in vfio.c is

struct iommu_domain *vfio_group_get_domain(struct vfio_group *group)

What the callers need to do are:

	unsigned int pasid;
	struct vfio_group *vfio_group;
	struct iommu_domain *iommu_domain;
	struct device *dev = mdev_dev(mdev);
	struct device *iommu_device = mdev_get_iommu_device(dev);

	if (!iommu_device ||
	    !iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
		return -EINVAL;

	vfio_group = vfio_group_get_external_user_from_dev(dev);
	if (IS_ERR_OR_NULL(vfio_group))
		return -EFAULT;

	iommu_domain = vfio_group_get_domain(vfio_group);
	if (IS_ERR_OR_NULL(iommu_domain)) {
		vfio_group_put_external_user(vfio_group);
		return -EFAULT;
	}

	pasid = iommu_aux_get_pasid(iommu_domain, iommu_device);
	if (pasid < 0) {
		vfio_group_put_external_user(vfio_group);
		return -EFAULT;
	}

	/* Program device context with pasid value. */
	...

	/* After use of this pasid */

	/* Clear the pasid value in device context */
	...

	vfio_group_put_external_user(vfio_group);

Do I understand your points correctly?

Best regards,
baolu



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
