Return-Path: <SRS0=m57D=Z3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D4BC43603
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 12:19:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9465A2245C
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 12:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9465A2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5F9BA2049E;
	Thu,  5 Dec 2019 12:19:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fe4J6jPjxXeQ; Thu,  5 Dec 2019 12:19:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 01073203AB;
	Thu,  5 Dec 2019 12:19:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8CB0C18DD;
	Thu,  5 Dec 2019 12:19:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC341C077D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 12:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C796887281
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 12:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tVjiScntOJxo for <iommu@lists.linux-foundation.org>;
 Thu,  5 Dec 2019 12:19:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9C97B87034
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 12:19:25 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Dec 2019 04:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,281,1571727600"; d="scan'208";a="209146309"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2019 04:19:16 -0800
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Dec 2019 04:19:16 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.90]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.46]) with mapi id 14.03.0439.000;
 Thu, 5 Dec 2019 20:19:14 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables)
 to host
Thread-Topic: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables)
 to host
Thread-Index: AQHVimn49qwPncOwpUK3oA3gYR4tBqd/6QGAgAdz7JCAAASEAIABX3gg//++iYCAEx7LIIALo1aAgAR0WIA=
Date: Thu, 5 Dec 2019 12:19:14 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A126B1A@SHSMSX104.ccr.corp.intel.com>
References: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
 <1571919983-3231-4-git-send-email-yi.l.liu@intel.com>
 <20191107162041.31e620a4@x1.home>
 <A2975661238FB949B60364EF0F2C25743A0F6894@SHSMSX104.ccr.corp.intel.com>
 <20191112102534.75968ccd@x1.home>
 <A2975661238FB949B60364EF0F2C25743A0F8A70@SHSMSX104.ccr.corp.intel.com>
 <20191113102913.GA40832@lophozonia>
 <A2975661238FB949B60364EF0F2C25743A10D40B@SHSMSX104.ccr.corp.intel.com>
 <20191202171149.12092335@x1.home>
In-Reply-To: <20191202171149.12092335@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWI5NGUwMTgtYjllYS00YzExLWJjZWUtYmNjMjNlYjc2MjcxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNEZReEI3QWlLc1lDRENXcVNjYk1DV2RzVzJkSXJLQkdkUkJ1NXQ3UHlwZnJPUyt4NzlpR2JVN1J6ZndDZ0NVayJ9
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Lu,
 Baolu" <baolu.lu@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Tuesday, December 3, 2019 8:12 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v2 3/3] vfio/type1: bind guest pasid (guest page tables) to host
> 
> On Mon, 25 Nov 2019 07:45:18 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > Hi Alex,
> >
> > Thanks for the review. Here I'd like to conclude the major opens in this
> > thread and see if we can get some agreements to prepare a new version.
> >
> > a) IOCTLs for BIND_GPASID and BIND_PROCESS, share a single IOCTL or two
> >    separate IOCTLs?
> >    Yi: It may be helpful to have separate IOCTLs. The bind data conveyed
> >    for BIND_GPASID and BIND_PROCESS are totally different, and the struct
> >    iommu_gpasid_bind_data has vendor specific data and may even have more
> >    versions in future. To better maintain it, I guess separate IOCTLs for
> >    the two bind types would be better. The structure for BIND_GPASID is
> >    as below:
> >
> >         struct vfio_iommu_type1_bind {
> >                 __u32                           argsz;
> >                 struct iommu_gpasid_bind_data   bind_data;
> >         };
> 
> 
> We've been rather successful at extending ioctls in vfio and I'm
> generally opposed to rampant ioctl proliferation.  If we added @flags
> to the above struct (as pretty much the standard for vfio ioctls), then
> we could use it to describe the type of binding to perform and
> therefore the type of data provided.  I think my major complaint here
> was that we were defining PROCESS but not implementing it.  We can
> design the ioctl to enable it, but not define it until it's implemented.

sure, so I'll pull back the @flags field. BTW. Regards to the payloads,
what would be preferred? @data[] or a wrapper structure like below?

	union {
		struct iommu_gpasid_bind_data   bind_gpasid;
	}bind_data;

> > b) how kernel-space learns the number of bytes to be copied (a.k.a. the
> >    usage of @version field and @format field of struct
> >    iommu_gpasid_bind_data)
> >    Yi: Jean has an excellent recap in prior reply on the plan of future
> >    extensions regards to @version field and @format field. Based on the
> >    plan, kernel space needs to parse the @version field and @format field
> >    to get the length of the current BIND_GPASID request. Also kernel needs
> >    to maintain the new and old structure versions. Follow specific
> >    deprecation policy in future.
> 
> Yes, it seems reasonable, so from the struct above (plus @flags) we
> could determine we have struct iommu_gpasid_bind_data as the payload
> and read that using @version and @format as outlined.

sure, thanks.

> > c) how can vIOMMU emulator know that the vfio interface supports to config
> >    dual stage translation for vIOMMU?
> >    Yi: may do it via VFIO_IOMMU_GET_INFO.
> 
> Yes please.

got it.

> > d) how can vIOMMU emulator know what @version and @format should be set
> >    in struct iommu_gpasid_bind_data?
> >    Yi: currently, we have two ways. First one, may do it via
> >    VFIO_IOMMU_GET_INFO. This is a natural idea as here @version and @format
> >    are used in vfio apis. It makes sense to let vfio to provide related info
> >    to vIOMMU emulator after checking with vendor specific iommu driver. Also,
> >    there is idea to do it via sysfs (/sys/class/iommu/dmar#) as we have plan
> >    to do IOMMU capability sync between vIOMMU and pIOMMU via sysfs. I have
> >    two concern on this option. Current iommu sysfs only provides vendor
> >    specific hardware infos. I'm not sure if it is good to expose infos
> >    defined in IOMMU generic layer via iommu sysfs. If this concern is not
> >    a big thing, I'm fine with both options.
> 
> This seems like the same issue we had with IOMMU reserved regions, I'd
> prefer that a user can figure out how to interact with the vfio
> interface through the vfio interface.  Forcing the user to poke around
> in sysfs requires the user to have read permissions to sysfs in places
> they otherwise wouldn't need.  Thanks,

thanks, let me prepare a new version.

Regards,
Yi Liu

> Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
