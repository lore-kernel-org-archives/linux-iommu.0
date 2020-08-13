Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38118C433E1
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 09:39:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C492078D
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 09:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bQPjAsK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C492078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BDF3D881C4;
	Thu, 13 Aug 2020 09:39:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Ba-Cb6m+nsd; Thu, 13 Aug 2020 09:39:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06E73881E0;
	Thu, 13 Aug 2020 09:39:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F24B1C013C;
	Thu, 13 Aug 2020 09:39:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2F18C004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 09:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CACD8883E2
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 09:39:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id unJh9xixZ0a2 for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 09:39:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EA6A8883F1
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 09:38:59 +0000 (UTC)
IronPort-SDR: isVSg7gr+AnVNJ/gVED6Z0Eh4zDNzkQVdWC0U5DE1b96jbGal3UNlrg0Wj5RH5vLetn8Z1+kM9
 4V0Xsu5lskcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="172231426"
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; d="scan'208";a="172231426"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 02:38:59 -0700
IronPort-SDR: Dk6wZPpNEWssrKy3GKhUftVWwmOhrQFnAEptQCmc2YlkB7cm0KF90i2Iy6zj3+0fOtPeUZvKBL
 YdumVhhwlRUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; d="scan'208";a="495334614"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com)
 ([10.18.84.213])
 by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2020 02:38:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Aug 2020 02:38:58 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 13 Aug 2020 02:38:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 13 Aug 2020 02:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLYHM8rk7pp3SVXgANRWTiqwjyWxFulPUbs+hdTPT2D3f2FXxNKx2UDvERXEVs/YCA38fDrDdd3KvA4x9slDSGXTI7q8su929n/qAOShHKFy7EZlA7sPJthJLgbsDkKU3Flw9AGX7ovCqvXoPXbToUr3IIvTZ6xI4rNQe0YySvdmazMzMXY0oVyznABWCsqhrxMnku2cJwgG8ddxuMk/h8JbFAB2LMEtks4oDlFnBtc3MUj8fVd/PjuTvkIjWAN6dF/jX8YO/N5mff97YHwtZ8AeSSoJjKkTPr6oPvnWN/U1OlYjGPdYzMCqu6OUOEJuXDqD8eakKv0fCbgFFhx/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9CTG4BQBaG38Ux45c2YNFu08/xOfOHaukk+3h9Ipno=;
 b=jouPd8fmOizPMsCbU4edNiqAYP2lFPtgj/6bbLVEm+7oKBLHHjlNbkYSR7HgT+4bRpGT/t40GTFXMj+xUel9HqtSh70UhSaNF2TKoa70rTOdR1qr3x2t69njWZXXRoxSx0SC8MugJDXgQ7oRJYPz1Efm2I7Y5X7pZSWffwUSA6E5RmHrt9Q+0c3YwySAnjNbEnk8ChqBWZq0JunayOGmD0p3Ty3pgkotgjMdNvSqPIMkUHC1IqFpeRsM7K9HDnfIp8qM9iYdG+VcIJV3O+PJXFK4l/FyevnawEdOlpowA3IFTFBl6HuNc1iNwek2Gmts2Ksp4RTb/xoMCw6cyFkm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9CTG4BQBaG38Ux45c2YNFu08/xOfOHaukk+3h9Ipno=;
 b=bQPjAsK769LCjn/fNzSzQXrJo9Y2OoeFxiZpZi71snrGBUB7C2oznyvtPtrI4j8lsHz3THwniDeF+AvcyQB29T1/kyeMQa8ubqD/qEGJAmLJqYwP0wQgecSeh/mJsHXA+hQvJ6+ppjVYgh+HYP5wHv9/SGfUjU1NRiwJXas6J5M=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4201.namprd11.prod.outlook.com (2603:10b6:5:200::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 09:38:47 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3261.026; Thu, 13 Aug
 2020 09:38:47 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v7 6/7] iommu/uapi: Handle data and argsz filled by users
Thread-Topic: [PATCH v7 6/7] iommu/uapi: Handle data and argsz filled by users
Thread-Index: AQHWcVHR6nRtyLJ8mkqF35ykXhEOrak1w2qQgAAC0ICAAAHbYA==
Date: Thu, 13 Aug 2020 09:38:47 +0000
Message-ID: <DM5PR11MB1435DFD22AB25E7471D66E58C3430@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1596068467-49322-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <ee61f1d1-f581-e35f-c50a-80e10b1dd06c@redhat.com>
 <DM5PR11MB14358D98D56B22307F712D47C3430@DM5PR11MB1435.namprd11.prod.outlook.com>
 <55dc3e4c-2717-2c96-d676-708b94e8cf1f@redhat.com>
In-Reply-To: <55dc3e4c-2717-2c96-d676-708b94e8cf1f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ada50da-0cfd-43d0-d266-08d83f6cad9a
x-ms-traffictypediagnostic: DM6PR11MB4201:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB420189E4E05F917E00905F62C3430@DM6PR11MB4201.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mtH5dLjsP6yNqKZOBa0Tu5OELRw+tc/zyNyBiuyrg7KLqHaE0tV4bXtMbet4tOx1mFU1g5RVym9Yj62KYuGuB8HYw/grPzbpSRvR5jptk1u0MYeoxvXNztSksohnDmmD+/QiMY3/+loL/yYcTnqyNE07ph8+ZpLvwlSvFd739rNxsYH7zYwHtyQn5YnnTEmscOaJE7sE5/lOmLSSn31Aj7e07y5lVTNdWhAFBoLxMCeMkzMnJpt3P6dsNv9xsFweJZCwlG0G9ESxUfa75crPiZa2tqItzN8woPn+BQrJ2ytes7760ETZbi1L9pUqE8em/o4Rc6qvXLiXV9onJVmRjqQ7axs9A57B6br7SwcwidcTkcovhp3JLC5fyIjfA7TCSNSdhs3pMxHl0/ipdMWA3cbAmsm/F/z2xI+Uv0ArfLE7cjiohZe8VQKzUUEd7alLVv8g7osayunbkED/JuZYT20sro3oEKy5aRFlW9wxoWTo2qQjbvgnQkQvKXavCGzG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(7416002)(54906003)(55016002)(9686003)(86362001)(2906002)(83380400001)(30864003)(966005)(52536014)(76116006)(33656002)(71200400001)(110136005)(66556008)(66446008)(64756008)(66476007)(478600001)(66946007)(8936002)(5660300002)(186003)(8676002)(26005)(6506007)(53546011)(4326008)(316002)(7696005)(26730200005)(19860200003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: RPaMU1xPUlYfTcQpAtig3A1mvPvqaYmHkJ610zPKIc8yPtpWCZ9+TLME7pITyYgv0aDLY5WOO6VAKMF0atCrheYqW2sIXz3rtCvAC/xi5ta+GDIoN4xUqLIjGkfmazNDEByasjXQk13mWREs3ytV/lkwXm+ALQUi0xA/DqxHFEojOveq+gwRtgnRd5QbKop3gjjlJcHtwQFAmAZ9QhM4k9Q+3a/adz6Q65Im+EHl7JIDyBBntRCfb9/4pUjDM3Kp+N+d3YaxxqheYuxIk8sJ7mKS9tecGn0I2+NYWNISGYeX3yKgHRBbFXAE6Ji09yiXlPQdUqPxNj9C/XTPBZ64hNPhdIMb2/NG9YGLa68FcWnlGAMcLdG+Rgzo3QePwDZAkBW45iqarRJ3a28HUieqO28GP7UCR1kvjFyiZt4kjB0G9w5brp5v2epwUnfTBM6HDM5qvZA2zR8U3867+ZtW2rd7aVxr0KrbBnOOGtDHcwlJkTPqd4Hxgw4HvblqFr0kUwNRpXWqo7gf71iWksJ653/TE9PNqKd8vzqZNFPLiY+0GLBk+d/u4GYJy6kkjlExE6gu9mlLtKOJE5tuG/zOH2m1zaZEAc1FcBX+xJEW64ueoKEDWmrptkUiSJQnTTWJ+rk/TLXFjIL1Qwhe2ia3AA==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ada50da-0cfd-43d0-d266-08d83f6cad9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 09:38:47.1829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E03tQQW/iWVRiqnn1nIxeOG09ptHt+EQR2r3lConNln37hrzmsgZLSBNULpO2Ku2KH8Q8k9pToDyb7cRqO+4zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4201
X-OriginatorOrg: intel.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>, Jean-Philippe
 Brucker <jean-philippe@linaro.com>
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

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Thursday, August 13, 2020 5:31 PM
> 
> Hi Yi,
> 
> On 8/13/20 11:25 AM, Liu, Yi L wrote:
> > Hi Eric,
> >
> >
> >> From: Auger Eric <eric.auger@redhat.com>
> >> Sent: Thursday, August 13, 2020 5:12 PM
> >>
> >> Hi Jacob,
> >>
> >> On 7/30/20 2:21 AM, Jacob Pan wrote:
> >>> IOMMU user APIs are responsible for processing user data. This patch
> >>> changes the interface such that user pointers can be passed into
> >>> IOMMU code directly. Separate kernel APIs without user pointers are
> >>> introduced for in-kernel users of the UAPI functionality.
> >> This is just done for a single function, ie. iommu_sva_unbind_gpasid.
> >>
> >> If I am not wrong there is no user of this latter after applying the
> >> whole series? If correct you may remove it at this stage?
> >
> > the user of this function is in vfio. And it is the same with
> > iommu_uapi_sva_bind/unbind_gpasid() and iommu_uapi_cache_invalidate().
> >
> > https://lore.kernel.org/kvm/1595917664-33276-11-git-send-email-yi.l.li
> > u@intel.com/
> > https://lore.kernel.org/kvm/1595917664-33276-12-git-send-email-yi.l.li
> > u@intel.com/
> Yep I know ;-) But this series mostly deals with iommu uapi rework.
> That's not a big deal though.

I see. btw. it's great if you can take a look on vfio v6 to see if your comments
are well addressed. :-)

Regards,
Yi Liu

> Thanks
> 
> Eric
> >
> > Regards,
> > Yi Liu
> >
> >>>
> >>> IOMMU UAPI data has a user filled argsz field which indicates the
> >>> data length of the structure. User data is not trusted, argsz must
> >>> be validated based on the current kernel data size, mandatory data
> >>> size, and feature flags.
> >>>
> >>> User data may also be extended, resulting in possible argsz increase.
> >>> Backward compatibility is ensured based on size and flags (or the
> >>> functional equivalent fields) checking.
> >>>
> >>> This patch adds sanity checks in the IOMMU layer. In addition to
> >>> argsz, reserved/unused fields in padding, flags, and version are also checked.
> >>> Details are documented in Documentation/userspace-api/iommu.rst
> >>>
> >>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> ---
> >>>  drivers/iommu/iommu.c | 201
> >> ++++++++++++++++++++++++++++++++++++++++++++++++--
> >>>  include/linux/iommu.h |  28 ++++---
> >>>  2 files changed, 212 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
> >>> 3a913ce94a3d..1ee55c4b3a3a 100644
> >>> --- a/drivers/iommu/iommu.c
> >>> +++ b/drivers/iommu/iommu.c
> >>> @@ -1950,33 +1950,218 @@ int iommu_attach_device(struct iommu_domain
> >> *domain, struct device *dev)
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(iommu_attach_device);
> >>>
> >>> +/*
> >>> + * Check flags and other user provided data for valid combinations.
> >>> +We also
> >>> + * make sure no reserved fields or unused flags are set. This is to
> >>> +ensure
> >>> + * not breaking userspace in the future when these fields or flags are used.
> >>> + */
> >>> +static int iommu_check_cache_invl_data(struct
> >>> +iommu_cache_invalidate_info
> >> *info)
> >>> +{
> >>> +	u32 mask;
> >>> +	int i;
> >>> +
> >>> +	if (info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> >>> +		return -EINVAL;
> >>> +
> >>> +	mask = (1 << IOMMU_CACHE_INV_TYPE_NR) - 1;
> >>> +	if (info->cache & ~mask)
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (info->granularity >= IOMMU_INV_GRANU_NR)
> >>> +		return -EINVAL;
> >>> +
> >>> +	switch (info->granularity) {
> >>> +	case IOMMU_INV_GRANU_ADDR:
> >>> +		if (info->cache & IOMMU_CACHE_INV_TYPE_PASID)
> >>> +			return -EINVAL;
> >>> +
> >>> +		mask = IOMMU_INV_ADDR_FLAGS_PASID |
> >>> +			IOMMU_INV_ADDR_FLAGS_ARCHID |
> >>> +			IOMMU_INV_ADDR_FLAGS_LEAF;
> >>> +
> >>> +		if (info->granu.addr_info.flags & ~mask)
> >>> +			return -EINVAL;
> >>> +		break;
> >>> +	case IOMMU_INV_GRANU_PASID:
> >>> +		mask = IOMMU_INV_PASID_FLAGS_PASID |
> >>> +			IOMMU_INV_PASID_FLAGS_ARCHID;
> >>> +		if (info->granu.pasid_info.flags & ~mask)
> >>> +			return -EINVAL;
> >>> +
> >>> +		break;
> >>> +	case IOMMU_INV_GRANU_DOMAIN:
> >>> +		if (info->cache & IOMMU_CACHE_INV_TYPE_DEV_IOTLB)
> >>> +			return -EINVAL;
> >>> +		break;
> >>> +	default:
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	/* Check reserved padding fields */
> >>> +	for (i = 0; i < sizeof(info->padding); i++) {
> >>> +		if (info->padding[i])
> >>> +			return -EINVAL;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct
> >>> device
> >> *dev,
> >>> -				struct iommu_cache_invalidate_info *inv_info)
> >>> +				void __user *uinfo)
> >>>  {
> >>> +	struct iommu_cache_invalidate_info inv_info = { 0 };
> >>> +	u32 minsz;
> >>> +	int ret = 0;
> >>> +
> >>>  	if (unlikely(!domain->ops->cache_invalidate))
> >>>  		return -ENODEV;
> >>>  > -	return domain->ops->cache_invalidate(domain, dev, inv_info);
> >>> +	/*
> >>> +	 * No new spaces can be added before the variable sized union, the
> >>> +	 * minimum size is the offset to the union.
> >>> +	 */
> >>> +	minsz = offsetof(struct iommu_cache_invalidate_info, granu);
> >>> +
> >>> +	/* Copy minsz from user to get flags and argsz */
> >>> +	if (copy_from_user(&inv_info, uinfo, minsz))
> >>> +		return -EFAULT;
> >>> +
> >>> +	/* Fields before variable size union is mandatory */
> >>> +	if (inv_info.argsz < minsz)
> >>> +		return -EINVAL;
> >>> +
> >>> +	/* PASID and address granu require additional info beyond minsz */
> >>> +	if (inv_info.argsz == minsz &&
> >>> +	    ((inv_info.granularity == IOMMU_INV_GRANU_PASID) ||
> >>> +		    (inv_info.granularity == IOMMU_INV_GRANU_ADDR)))
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (inv_info.granularity == IOMMU_INV_GRANU_PASID &&
> >>> +	    inv_info.argsz < offsetofend(struct
> >>> +iommu_cache_invalidate_info,
> >> granu.pasid_info))
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (inv_info.granularity == IOMMU_INV_GRANU_ADDR &&
> >>> +	    inv_info.argsz < offsetofend(struct
> >>> +iommu_cache_invalidate_info,
> >> granu.addr_info))
> >>> +		return -EINVAL;
> >>> +
> >>> +	/*
> >>> +	 * User might be using a newer UAPI header which has a larger data
> >>> +	 * size, we shall support the existing flags within the current
> >>> +	 * size. Copy the remaining user data _after_ minsz but not more
> >>> +	 * than the current kernel supported size.
> >>> +	 */
> >>> +	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
> >>> +			   min_t(u32, inv_info.argsz, sizeof(inv_info)) - minsz))
> >>> +		return -EFAULT;
> >>> +
> >>> +	/* Now the argsz is validated, check the content */
> >>> +	ret = iommu_check_cache_invl_data(&inv_info);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	return domain->ops->cache_invalidate(domain, dev, &inv_info);
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
> >>>
> >>> -int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> >>> -			       struct device *dev, struct iommu_gpasid_bind_data
> >> *data)
> >>> +static int iommu_check_bind_data(struct iommu_gpasid_bind_data
> >>> +*data) {
> >>> +	u32 mask;
> >>> +	int i;
> >>> +
> >>> +	if (data->version != IOMMU_GPASID_BIND_VERSION_1)
> >>> +		return -EINVAL;
> >>> +
> >>> +	/* Check the range of supported formats */
> >>> +	if (data->format >= IOMMU_PASID_FORMAT_LAST)
> >>> +		return -EINVAL;
> >>> +
> >>> +	/* Check all flags */
> >>> +	mask = IOMMU_SVA_GPASID_VAL;
> >>> +	if (data->flags & ~mask)
> >>> +		return -EINVAL;
> >>> +
> >>> +	/* Check reserved padding fields */
> >>> +	for (i = 0; i < sizeof(data->padding); i++) {
> >>> +		if (data->padding[i])
> >>> +			return -EINVAL;
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int iommu_sva_prepare_bind_data(void __user *udata,
> >>> +				       struct iommu_gpasid_bind_data *data)
> >>>  {
> >>> +	u32 minsz;
> >>> +
> >>> +	/*
> >>> +	 * No new spaces can be added before the variable sized union, the
> >>> +	 * minimum size is the offset to the union.
> >>> +	 */
> >>> +	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
> >>> +
> >>> +	/* Copy minsz from user to get flags and argsz */
> >>> +	if (copy_from_user(data, udata, minsz))
> >>> +		return -EFAULT;
> >>> +
> >>> +	/* Fields before variable size union is mandatory */
> >>> +	if (data->argsz < minsz)
> >>> +		return -EINVAL;
> >>> +	/*
> >>> +	 * User might be using a newer UAPI header, we shall let IOMMU vendor
> >>> +	 * driver decide on what size it needs. Since the guest PASID bind data
> >>> +	 * can be vendor specific, larger argsz could be the result of extension
> >>> +	 * for one vendor but it should not affect another vendor.
> >>> +	 * Copy the remaining user data _after_ minsz
> >>> +	 */
> >>> +	if (copy_from_user((void *)data + minsz, udata + minsz,
> >>> +			   min_t(u32, data->argsz, sizeof(*data)) - minsz))
> >>> +		return -EFAULT;
> >>> +
> >>> +	return iommu_check_bind_data(data); }
> >>> +
> >>> +int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain, struct
> >>> +device
> >> *dev,
> >>> +			       void __user *udata)
> >>> +{
> >>> +	struct iommu_gpasid_bind_data data = { 0 };
> >>> +	int ret;
> >>> +
> >>>  	if (unlikely(!domain->ops->sva_bind_gpasid))
> >>>  		return -ENODEV;
> >>>
> >>> -	return domain->ops->sva_bind_gpasid(domain, dev, data);
> >>> +	ret = iommu_sva_prepare_bind_data(udata, &data);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	return domain->ops->sva_bind_gpasid(domain, dev, &data);
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
> >>>
> >>> -int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> >>> struct device
> >> *dev,
> >>> -				 ioasid_t pasid)
> >>> +int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device
> *dev,
> >>> +			    struct iommu_gpasid_bind_data *data)
> >>>  {
> >>>  	if (unlikely(!domain->ops->sva_unbind_gpasid))
> >>>  		return -ENODEV;
> >>>
> >>> -	return domain->ops->sva_unbind_gpasid(dev, pasid);
> >>> +	return domain->ops->sva_unbind_gpasid(dev, data->hpasid); }
> >>> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> >>> +
> >>> +int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> >>> +struct device
> >> *dev,
> >>> +				 void __user *udata)
> >>> +{
> >>> +	struct iommu_gpasid_bind_data data = { 0 };
> >>> +	int ret;
> >>> +
> >>> +	if (unlikely(!domain->ops->sva_bind_gpasid))
> >>> +		return -ENODEV;
> >>> +
> >>> +	ret = iommu_sva_prepare_bind_data(udata, &data);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	return iommu_sva_unbind_gpasid(domain, dev, &data);
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
> >>>
> >>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> >>> 2dcc1a33f6dc..4a02c9e09048 100644
> >>> --- a/include/linux/iommu.h
> >>> +++ b/include/linux/iommu.h
> >>> @@ -432,11 +432,14 @@ extern void iommu_detach_device(struct
> >> iommu_domain *domain,
> >>>  				struct device *dev);
> >>>  extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> >>>  				       struct device *dev,
> >>> -				       struct iommu_cache_invalidate_info *inv_info);
> >>> +				       void __user *uinfo);
> >>> +
> >>>  extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> >>> -				      struct device *dev, struct
> >> iommu_gpasid_bind_data *data);
> >>> +				      struct device *dev, void __user *udata);
> >>>  extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> >>> -					struct device *dev, ioasid_t pasid);
> >>> +					struct device *dev, void __user *udata);
> extern int
> >>> +iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> >>> +				   struct device *dev, struct
> >> iommu_gpasid_bind_data *data);
> >>>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device
> >>> *dev);  extern struct iommu_domain *iommu_get_dma_domain(struct
> >>> device *dev);  extern int iommu_map(struct iommu_domain *domain,
> >>> unsigned long iova, @@ -1054,22 +1057,29 @@ static inline int
> >>> iommu_sva_get_pasid(struct
> >> iommu_sva *handle)
> >>>  	return IOMMU_PASID_INVALID;
> >>>  }
> >>>
> >>> -static inline int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> >>> -					      struct device *dev,
> >>> -					      struct iommu_cache_invalidate_info
> >> *inv_info)
> >>> +static inline int
> >>> +iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> >>> +			    struct device *dev,
> >>> +			    struct iommu_cache_invalidate_info *inv_info)
> >>>  {
> >>>  	return -ENODEV;
> >>>  }
> >>>
> >>>  static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> >>> -					     struct device *dev,
> >>> -					     struct iommu_gpasid_bind_data *data)
> >>> +					     struct device *dev, void __user *udata)
> >>>  {
> >>>  	return -ENODEV;
> >>>  }
> >>>
> >>>  static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> >>> -					       struct device *dev, int pasid)
> >>> +					       struct device *dev, void __user *udata)
> {
> >>> +	return -ENODEV;
> >>> +}
> >>> +
> >>> +static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> >>> +					  struct device *dev,
> >>> +					  struct iommu_gpasid_bind_data *data)
> >>>  {
> >>>  	return -ENODEV;
> >>>  }
> >>>
> >> Otherwise looks good to me
> >> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> Thanks
> >>
> >> Eric
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
