Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF9DC433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 17:11:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92EE864F2F
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 17:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92EE864F2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49D5A60694;
	Tue,  2 Mar 2021 17:11:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id df1x2XE1m1qA; Tue,  2 Mar 2021 17:11:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24A1860693;
	Tue,  2 Mar 2021 17:11:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFF9CC000B;
	Tue,  2 Mar 2021 17:11:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3DC5C0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 17:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7C9B60694
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 17:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YBgZq52bAuJS for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 17:11:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18EA060693
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 17:11:17 +0000 (UTC)
IronPort-SDR: LEn/o+z+SJ9QBm4+DNJgPxclN9oLEIqbKDWqpXqaEJVKhF+MoRfv4j4zuK0xlX6Bk8cwoDzjdN
 gs7VBflscAtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="166781773"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="166781773"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 09:11:16 -0800
IronPort-SDR: JIH2cPgHmEyDB8jcG5yboYFvOA0L9iZ92yElD4Sh1mVurz8gs9R9/rix56DWOPR21483d6q24Y
 Qo1GBYI0EoRg==
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="383628600"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 09:11:16 -0800
Date: Tue, 2 Mar 2021 09:13:19 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [Patch v8 04/10] vfio/type1: Support binding guest page tables
 to PASID
Message-ID: <20210302091319.1446a47b@jacob-builder>
In-Reply-To: <20210302125628.GI4247@nvidia.com>
References: <20210302203545.436623-1-yi.l.liu@intel.com>
 <20210302203545.436623-5-yi.l.liu@intel.com>
 <20210302125628.GI4247@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, vivek.gautam@arm.com, jasowang@redhat.com,
 stefanha@gmail.com, yi.y.sun@intel.com, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org, Lingshan.Zhu@intel.com, hao.wu@intel.com,
 jun.j.tian@intel.com
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

Hi Jason,

On Tue, 2 Mar 2021 08:56:28 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 03, 2021 at 04:35:39AM +0800, Liu Yi L wrote:
> >  
> > +static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)
> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	unsigned long arg = *(unsigned long *)dc->data;
> > +
> > +	return iommu_uapi_sva_bind_gpasid(dc->domain, dev,
> > +					  (void __user *)arg);  
> 
> This arg buisness is really tortured. The type should be set at the
> ioctl, not constantly passed down as unsigned long or worse void *.
> 
> And why is this passing a __user pointer deep into an iommu_* API??
> 
The idea was that IOMMU UAPI (not API) is independent of VFIO or other user
driver frameworks. The design is documented here:
Documentation/userspace-api/iommu.rst
IOMMU UAPI handles the type and sanitation of user provided data.

Could you be more specific about your concerns?

> > +/**
> > + * VFIO_IOMMU_NESTING_OP - _IOW(VFIO_TYPE, VFIO_BASE + 18,
> > + *				struct vfio_iommu_type1_nesting_op)
> > + *
> > + * This interface allows userspace to utilize the nesting IOMMU
> > + * capabilities as reported in VFIO_IOMMU_TYPE1_INFO_CAP_NESTING
> > + * cap through VFIO_IOMMU_GET_INFO. For platforms which require
> > + * system wide PASID, PASID will be allocated by VFIO_IOMMU_PASID
> > + * _REQUEST.
> > + *
> > + * @data[] types defined for each op:
> > + * +=================+===============================================+
> > + * | NESTING OP      |      @data[]                                  |
> > + * +=================+===============================================+
> > + * | BIND_PGTBL      |      struct iommu_gpasid_bind_data            |
> > + * +-----------------+-----------------------------------------------+
> > + * | UNBIND_PGTBL    |      struct iommu_gpasid_bind_data            |
> > + *
> > +-----------------+-----------------------------------------------+  
> 
> If the type is known why does the struct have a flex array?
> 
This will be extended to other types in the next patches.

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
