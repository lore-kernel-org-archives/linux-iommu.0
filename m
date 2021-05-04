Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20480C43461
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 16:20:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A478A613BC
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 16:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A478A613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F9EA608AD;
	Tue,  4 May 2021 16:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8yB3VnD-P0GP; Tue,  4 May 2021 16:20:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DA57605A1;
	Tue,  4 May 2021 16:20:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11E0CC000E;
	Tue,  4 May 2021 16:20:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE003C0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 16:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5A3840617
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 16:20:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sVp_ME53tJ8q for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 16:20:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FBBA4061C
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 16:20:08 +0000 (UTC)
IronPort-SDR: plJxDQ05dSQUyRfsHB5oPDXETtvFz9UzGrMElCuQjieFZ2zeUrUJCKR9s9WWxPLKlklhL3W5qc
 JJ8nuH/YJhPQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="198106465"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="198106465"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2021 09:20:07 -0700
IronPort-SDR: FE31X0f0O1HmtVya2wHzkb2m+mH92c3O29UDYShex4/bS8cRaxxOvxXCVAHn64M0HmX4ZXzTcL
 vnP6nVihO/fg==
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="468576361"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2021 09:20:06 -0700
Date: Tue, 4 May 2021 09:22:55 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210504092255.76c387f8@jacob-builder>
In-Reply-To: <20210428204606.GX1370958@nvidia.com>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210428204606.GX1370958@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu, 
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Wed, 28 Apr 2021 17:46:06 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> > > I think the name IOASID is fine for the uAPI, the kernel version can
> > > be called ioasid_id or something.  
> > 
> > ioasid is already an id and then ioasid_id just adds confusion. Another
> > point is that ioasid is currently used to represent both PCI PASID and
> > ARM substream ID in the kernel. It implies that if we want to separate
> > ioasid and pasid in the uAPI the 'pasid' also needs to be replaced with
> > another general term usable for substream ID. Are we making the
> > terms too confusing here?  
> 
> This is why I also am not so sure about exposing the PASID in the API
> because it is ultimately a HW specific item.
> 
> As I said to David, one avenue is to have some generic uAPI that is
> very general and keep all this deeply detailed stuff, that really only
> matters for qemu, as part of a more HW specific vIOMMU driver
> interface.
I think it is not just for QEMU. I am assuming you meant PASID is
needed for guest driver to program assigned but not mediated devices.

User space drivers may also need to get the real HW PASID to program it on
to the HW. So this uAPI need to provide some lookup functionality. Perhaps
the kernel generic version can be called ioasid_hw_id?

So we have the following per my understanding:
- IOASID: a userspace logical number which identifies a page table, this can
be a first level (GVA-GPA), or a second level (GPA->HPA) page table.
- PASID: strictly defined in PCIe term
- Substream ID: strictly defined in ARM SMMUv3 spec.
- IOASID_HW_ID: a generic ID backed by PASID, Substream ID, or any other
		 HW IDs used to tag DMA

Is that right?

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
