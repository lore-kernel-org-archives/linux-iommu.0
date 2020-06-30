Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02749C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 01:20:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B452720760
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 01:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="nEKC2yFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B452720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5C4232107D;
	Tue, 30 Jun 2020 01:20:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z4shF7JAMTri; Tue, 30 Jun 2020 01:20:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7B08D203D4;
	Tue, 30 Jun 2020 01:20:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C436C07FF;
	Tue, 30 Jun 2020 01:20:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D07C6C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 01:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B82CB87C30
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 01:20:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wGKqbnLb1tNZ for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 01:20:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DC48684344
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 01:20:39 +0000 (UTC)
IronPort-SDR: hnVqQW31toRe29cZqjxf7IryVtHoRfV9JJuwNzipslZRCcuyQEXQunIHeSdGkdmZv103JvL/Qp
 WE/SEPMHUDxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="145188013"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="145188013"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 18:20:38 -0700
IronPort-SDR: bAvEHcVoWCZ+gPa9J9+OmWkJ06iU4p0KY+bOJYOMd2v10MdJNQHLL3l27X+RS+bLE5Gk09VArH
 nKYgJcV45Www==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; d="scan'208";a="266344077"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2020 18:20:38 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 18:20:38 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 18:20:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 29 Jun 2020 18:20:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tnuy0rYsR51CZU8RcsJv2lGzTtP+fWlo2C0pMU3q9F+3wEu/ei8pSqYg7ZlaTasyzAYAKqUOCNnO4Px7LOLJl5d5AfJZcg1xWP2GwMgPvG0NOC35hyc9x8BoOJFMuG4DHeytGTMLobSRnWHgl2Mj1Uv6NfBeIe955Uu3pC4UahsnPA30xQfx+40gX6bGSrzryqJIdgNGglErDNmIeO4qTb7D6HfvZBgwg6Aq9yxMfYm7G4el1M3emp4mMYNQB3e5/NhFrzEn645LsBoo+fLJI5gJpS/+gTfJuB14gN/Wg3KENZpVuO+oT1HhjHtWZi8pAOhwdwnbTIllQ7BSkSwXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKcUVtx+vigrzVJFVGj62AujjFgFteYFKp1iEfn5EFs=;
 b=bqyqwKgcxX09MGf6TfjlAtnKD/MJ/sKTiEfLXOPlLuh4zlyoIExu83XEvdLA8Pkpw42hD1qFwhsRkxNrhG1Aaq+sScJlt6lW0XxUkcNgWqGHJuf5yLFSQ2PvfjpS+mEYMGYSOA3fhMb7C4zB05nbu2iz3BemUzv600H+ZqJ53aY4eQs9gZQfO6r5Go3FMctGKVCDNuKZsQGLO7VsxXXbpa3y7KuO4kf2quZiqJ7Fw8NVQreYU9GqWDsFNhf4gXvfCxlhuX+JoEIxYbzhWqdjZlbg64pKNW3uIUosoDK3iLymfe4hQH5XPDg5orsA2OC0IvsB6++yr9z5+XBVjXVnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKcUVtx+vigrzVJFVGj62AujjFgFteYFKp1iEfn5EFs=;
 b=nEKC2yFALOJUMcIiSZjtfZve0x55ttoz7h5GOF4oDhYwfQXEJvs49mgldmWjk3fD0urSHIcqFrisizXTK5zAjHOAEOTNcdnicFWm2+tqrU1G+1MJpeSQv3oq7XVo3t4TN9nRexoo4FoTNmbbhIHYkqY8P+w5OAykmEe4ihu4LBk=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MW3PR11MB4569.namprd11.prod.outlook.com (2603:10b6:303:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 30 Jun
 2020 01:20:35 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 01:20:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH v3 02/14] iommu: Report domain nesting info
Thread-Topic: [PATCH v3 02/14] iommu: Report domain nesting info
Thread-Index: AQHWSgRQYPLf19tsF0i4Fom/j2zC7qjqiBcAgACK1oCAAPhIgIAEWX1g
Date: Tue, 30 Jun 2020 01:20:34 +0000
Message-ID: <MWHPR11MB16456F2C16A88BB6F84076C78C6F0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-3-git-send-email-yi.l.liu@intel.com>
 <20200626074738.GA2107508@myrica>
 <069bcf66-4db3-b4f1-2e09-a79d255d0850@arm.com>
 <DM5PR11MB1435D877048ACCC1B8EAAFDBC3900@DM5PR11MB1435.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB1435D877048ACCC1B8EAAFDBC3900@DM5PR11MB1435.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a89c1ad-a04d-4f38-7b4f-08d81c93ca21
x-ms-traffictypediagnostic: MW3PR11MB4569:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4569F3A7E7FFA56A98C436A38C6F0@MW3PR11MB4569.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bR/HWOzcXWPeLY6NlonHUDSb9QXDx1sOYshajqcCwtANwyfmHEIw+/MK5nGAI61Et9awj9yq+FtTDdCZKGjDa7BqYHF+VecPfQbXeYkwcB6hkx+7rtiGAaiiM5ECP+nroGztdrYDQM6uHQdLA2d3EkqVdTW2o76+wnvLuznlkw1vDjfQK2iud7+l8pHGiWqmz0dbGxlWMu3btJkE6dp8v2xFLd+HT5wUDYB5VltZZGJFvYvs6S2Sz2jtlvaZg0eWs3P1aO2PyNIoW5Ix2dMqidqUcNJGP6Oa9QN1iW6QB1ykd4qOHnTrd1xESbb8P+lhR17iJh/vC8qrRy5ea7BFpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(64756008)(66446008)(83380400001)(26005)(186003)(33656002)(66946007)(52536014)(66556008)(55016002)(53546011)(71200400001)(4326008)(6506007)(7696005)(66476007)(8936002)(7416002)(9686003)(8676002)(54906003)(110136005)(316002)(86362001)(5660300002)(478600001)(76116006)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Il0CTgSiZGl00lwxkZtVnGjrwUEe/HsMHuDSuVwIq6zAv0Mliq61QkN+2JAvY/ArTqDk800Nv7EkfqYqo4Y/AIBRqcmjYbXcb4FGqf2ejVoKoxCNQIaYY82pCDb7EMjz7LOOipNMZsdKk7g5UdDwPvv+oVeFxnnN9H4ZM9B8zazbUvEDelfWpzfEXA72Oak2/1H7H1HOrM71ksbgVhzAgZ+GTWqrCnM8EZzntqK2yxylkh2P5e3B8SUbKPyCe7sCdBS66zv4tGfMZ7A6yzrCDJxAFFY4VdClJXE+agXoJ12G5eHadC9uzS2C6npMpWopx9ssKURYNmfcPJNqYOMnKKf1Dbrq+X7/gCs9YykY06+fVUqDm73JGwq5966lVLEjmkLsfiqHo9Xxozs/PtF0ZzJQXLampx73p4OB1L7FVk6yZGqsklwbITvk0RkxpaOWutMP8OG9HdhBug82JKnyWIqAduIrkfPNLVFLTjMImbqq3DTKZiXybs595w5FDkz8
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a89c1ad-a04d-4f38-7b4f-08d81c93ca21
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 01:20:34.8607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Js3oK4LvMKwE5o0emA/Ycyjb/up+NyUG1G4xe1yK8qwD/H2B05KHd2H02NMYprMEjEoBq8j2YjukwrXB7h6HdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4569
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>, Will Deacon <will@kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Saturday, June 27, 2020 2:53 PM
> 
> Hi Robin,
> 
> > From: Robin Murphy <robin.murphy@arm.com>
> > Sent: Saturday, June 27, 2020 12:05 AM
> >
> > On 2020-06-26 08:47, Jean-Philippe Brucker wrote:
> > > On Wed, Jun 24, 2020 at 01:55:15AM -0700, Liu Yi L wrote:
> > >> IOMMUs that support nesting translation needs report the capability
> > >> info to userspace, e.g. the format of first level/stage paging structures.
> > >>
> > >> This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can
> > >> get nesting info after setting DOMAIN_ATTR_NESTING.
> > >>
> > >> v2 -> v3:
> > >> *) remvoe cap/ecap_mask in iommu_nesting_info.
> > >> *) reuse DOMAIN_ATTR_NESTING to get nesting info.
> > >> *) return an empty iommu_nesting_info for SMMU drivers per Jean'
> > >>     suggestion.
> > >>
> > >> Cc: Kevin Tian <kevin.tian@intel.com>
> > >> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > >> Cc: Alex Williamson <alex.williamson@redhat.com>
> > >> Cc: Eric Auger <eric.auger@redhat.com>
> > >> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > >> Cc: Joerg Roedel <joro@8bytes.org>
> > >> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > >> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > >> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > >> ---
> > >>   drivers/iommu/arm-smmu-v3.c | 29 ++++++++++++++++++++--
> > >>   drivers/iommu/arm-smmu.c    | 29 ++++++++++++++++++++--
> > >
> > > Looks reasonable to me. Please move the SMMU changes to a separate
> > > patch and Cc the SMMU maintainers:
> >
> > Cheers Jean, I'll admit I've been skipping over a lot of these patches lately :)
> >
> > A couple of comments below...
> >
> > >
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > >
> > > Thanks,
> > > Jean
> > >
> > >>   include/uapi/linux/iommu.h  | 59
> > +++++++++++++++++++++++++++++++++++++++++++++
> > >>   3 files changed, 113 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/iommu/arm-smmu-v3.c
> > >> b/drivers/iommu/arm-smmu-v3.c index f578677..0c45d4d 100644
> > >> --- a/drivers/iommu/arm-smmu-v3.c
> > >> +++ b/drivers/iommu/arm-smmu-v3.c
> > >> @@ -3019,6 +3019,32 @@ static struct iommu_group
> > *arm_smmu_device_group(struct device *dev)
> > >>   	return group;
> > >>   }
> > >>
> > >> +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> > *smmu_domain,
> > >> +					void *data)
> > >> +{
> > >> +	struct iommu_nesting_info *info = (struct iommu_nesting_info *)
> data;
> > >> +	u32 size;
> > >> +
> > >> +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> > >> +		return -ENODEV;
> > >> +
> > >> +	size = sizeof(struct iommu_nesting_info);
> > >> +
> > >> +	/*
> > >> +	 * if provided buffer size is not equal to the size, should
> > >> +	 * return 0 and also the expected buffer size to caller.
> > >> +	 */
> > >> +	if (info->size != size) {
> > >> +		info->size = size;
> > >> +		return 0;
> > >> +	}
> > >> +
> > >> +	/* report an empty iommu_nesting_info for now */
> > >> +	memset(info, 0x0, size);
> > >> +	info->size = size;
> > >> +	return 0;
> > >> +}
> > >> +
> > >>   static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> > >>   				    enum iommu_attr attr, void *data)
> > >>   {
> > >> @@ -3028,8 +3054,7 @@ static int arm_smmu_domain_get_attr(struct
> > iommu_domain *domain,
> > >>   	case IOMMU_DOMAIN_UNMANAGED:
> > >>   		switch (attr) {
> > >>   		case DOMAIN_ATTR_NESTING:
> > >> -			*(int *)data = (smmu_domain->stage ==
> > ARM_SMMU_DOMAIN_NESTED);
> > >> -			return 0;
> > >> +			return
> arm_smmu_domain_nesting_info(smmu_domain,
> > data);
> > >>   		default:
> > >>   			return -ENODEV;
> > >>   		}
> > >> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > >> index 243bc4c..908607d 100644
> > >> --- a/drivers/iommu/arm-smmu.c
> > >> +++ b/drivers/iommu/arm-smmu.c
> > >> @@ -1506,6 +1506,32 @@ static struct iommu_group
> > *arm_smmu_device_group(struct device *dev)
> > >>   	return group;
> > >>   }
> > >>
> > >> +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> > *smmu_domain,
> > >> +					void *data)
> > >> +{
> > >> +	struct iommu_nesting_info *info = (struct iommu_nesting_info *)
> data;
> > >> +	u32 size;
> > >> +
> > >> +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> > >> +		return -ENODEV;
> > >> +
> > >> +	size = sizeof(struct iommu_nesting_info);
> > >> +
> > >> +	/*
> > >> +	 * if provided buffer size is not equal to the size, should
> > >> +	 * return 0 and also the expected buffer size to caller.
> > >> +	 */
> > >> +	if (info->size != size) {
> > >> +		info->size = size;
> > >> +		return 0;
> > >> +	}
> > >> +
> > >> +	/* report an empty iommu_nesting_info for now */
> > >> +	memset(info, 0x0, size);
> > >> +	info->size = size;
> > >> +	return 0;
> > >> +}
> > >> +
> > >>   static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> > >>   				    enum iommu_attr attr, void *data)
> > >>   {
> > >> @@ -1515,8 +1541,7 @@ static int arm_smmu_domain_get_attr(struct
> > iommu_domain *domain,
> > >>   	case IOMMU_DOMAIN_UNMANAGED:
> > >>   		switch (attr) {
> > >>   		case DOMAIN_ATTR_NESTING:
> > >> -			*(int *)data = (smmu_domain->stage ==
> > ARM_SMMU_DOMAIN_NESTED);
> > >> -			return 0;
> > >> +			return
> arm_smmu_domain_nesting_info(smmu_domain,
> > data);
> > >>   		default:
> > >>   			return -ENODEV;
> > >>   		}
> > >> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > >> index 1afc661..898c99a 100644
> > >> --- a/include/uapi/linux/iommu.h
> > >> +++ b/include/uapi/linux/iommu.h
> > >> @@ -332,4 +332,63 @@ struct iommu_gpasid_bind_data {
> > >>   	} vendor;
> > >>   };
> > >>
> > >> +/*
> > >> + * struct iommu_nesting_info - Information for nesting-capable
> IOMMU.
> > >> + *				user space should check it before using
> > >> + *				nesting capability.
> > >> + *
> > >> + * @size:	size of the whole structure
> > >> + * @format:	PASID table entry format, the same definition with
> > >> + *		@format of struct iommu_gpasid_bind_data.
> > >> + * @features:	supported nesting features.
> > >> + * @flags:	currently reserved for future extension.
> > >> + * @data:	vendor specific cap info.
> > >> + *
> > >> + * +---------------+----------------------------------------------------+
> > >> + * | feature       |  Notes                                             |
> > >> + *
> > >>
> > ++===============+============================================
> > =======
> > >> +=+
> > >> + * | SYSWIDE_PASID |  Kernel manages PASID in system wide, PASIDs
> used  |
> > >> + * |               |  in the system should be allocated by host kernel  |
> > >> + * +---------------+----------------------------------------------------+
> > >> + * | BIND_PGTBL    |  bind page tables to host PASID, the PASID could   |
> > >> + * |               |  either be a host PASID passed in bind request or  |
> > >> + * |               |  default PASIDs (e.g. default PASID of aux-domain) |
> > >> + * +---------------+----------------------------------------------------+
> > >> + * | CACHE_INVLD   |  mandatory feature for nesting capable IOMMU
> |
> > >> + *
> > >> ++---------------+---------------------------------------------------
> > >> +-+
> > >> + *
> > >> + */
> > >> +struct iommu_nesting_info {
> > >> +	__u32	size;
> > >> +	__u32	format;
> > >> +	__u32	features;
> > >> +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> > >> +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> > >> +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> > >> +	__u32	flags;
> > >> +	__u8	data[];
> > >> +};
> > >> +
> > >> +/*
> > >> + * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info
> > >> + *
> > >> + *
> > >> + * @flags:	VT-d specific flags. Currently reserved for future
> > >> + *		extension.
> > >> + * @addr_width:	The output addr width of first level/stage translation
> > >> + * @pasid_bits:	Maximum supported PASID bits, 0 represents no
> PASID
> > >> + *		support.
> > >> + * @cap_reg:	Describe basic capabilities as defined in VT-d
> capability
> > >> + *		register.
> > >> + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> > >> + *		extended capability register.
> > >> + */
> > >> +struct iommu_nesting_info_vtd {
> > >> +	__u32	flags;
> > >> +	__u16	addr_width;
> >
> > I think this might be worth promoting to a generic feature - Arm has the
> same
> > notion of intermediate address size, and I'd imagine that pretty much any
> other
> > two-stage translation system would as well (either explicitly or implicitly).
> > It also
> > comes close to something the DPDK folks raised where they wanted parity
> with a
> > feature that currently scrapes AGAW out of some VT-d-specific place, so
> > abstracting it to completely generic code, in a way that could eventually be
> > generalised to reporting info for non-nested domains too, would be really
> nice.
> 
> got you. I can do that.
> 
> > What would also be cool is if the user was able to pass in a structure with
> > preferred values for the address size and other capabilities when they
> request
> > nesting in the first place. Right now we'll always set up the maximum
> possible
> > sized page table for any domain, but if we knew ahead of time how many
> bits the
> > user actually cared about then we could potentially be more efficient (e.g.
> use
> > fewer levels of pagetable or a different translation granule).
> 
> agreed, and I guess only the configurable caps (like the addr_width, domain
> could have different addr_width per user request). I think it may be an
> optimization afterward. Here, we report all the nesting related caps to user,
> thus user could either do pre-check or expose correct capability to guest per
> hardware support. This is necesary as nesting requires guest to maintain
> page
> tables per hw supporting.
> 

yes, this likely requires a new uAPI thus it could come as an incremental patch
later. We may reuse the same structure as defined here for communicating
preferred values.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
