Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5A8C433DF
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 03:53:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B11208FE
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 03:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="KmkgZokp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B11208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3EB6D87BA1;
	Fri,  3 Jul 2020 03:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NxWO0dcCpckD; Fri,  3 Jul 2020 03:53:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6AD5187BAA;
	Fri,  3 Jul 2020 03:53:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 549BEC0888;
	Fri,  3 Jul 2020 03:53:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34BC1C0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 03:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1979688C59
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 03:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TsZMA8kz2YgS for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 03:53:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A09E388C57
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 03:53:18 +0000 (UTC)
IronPort-SDR: pO0IEj3pRh2a4LTp8TbRb3GWaJwwbif4r82FI7KLIUt8ofEbjFemBPd0MvGW2Wcf0+M+lfP/29
 /UPCpzggD+TQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="135368204"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; d="scan'208";a="135368204"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 20:53:17 -0700
IronPort-SDR: wnk8vVRTIdNDnVHaSdZVjtJ/lsEHD21zgtDOUKrSG0x1FDJHPpdCnmq8i7boOr3d2dhW7tfQ8d
 ps+WKyefsbRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; d="scan'208";a="482234204"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by fmsmga005.fm.intel.com with ESMTP; 02 Jul 2020 20:53:17 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jul 2020 20:53:16 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX121.amr.corp.intel.com (10.22.225.226) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jul 2020 20:53:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 2 Jul 2020 20:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC/JISaJL3G51KDV5GCsYOpjau130YfASO5lJO0bDAQBIaMZFxXhheAdC+/+fNJB6cALZaMwsZYMzPcka2bl5kAJ/tNtpjlszYQjevdcbqR3tirifR6J9Uw3ORmMop9a+QP5Qsq2e8DJzy8IkAMMr4FKj7tkxqpWYSfFq+AsnFLAVW5u9c/PuKXguJm57FVho4T3zVD94wbG7p2CUQcW7nKTPfjih0LB1n2HRNCaWU3NBy3GUjRkLFHXr5tbwHwC5nMAGlQKUb9A3CzqZBu48S+Yg/CI+FYOCVhQIsyND1m0psxUFspg1A3S+es2OepivF44xrOA1GNhte5i6/cftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqDhzxooY0X6jtji1FR8chh3mj8SaZlGIU5mxuWeZUo=;
 b=BiYheyfuWI2j2FqLtvwuD7eIr0rhm6b7z80pMxkpvhltX0CDRrgDGcn1IwydZeu4HVIUA5rv48itd/ld6mRAVN0BymLyGlkhagRffvLdb/mxMJPkuEmVIa04OObEKM0jV1gw0KKR23jMQXQVNOcWhasZeKmc7lsYrxVkIqtlwvNf6+6+kYhwLBcqadLcTsMK3loSodwydoNywyQOhYxwMcJAN7u5+TW/l2elu3qtbQufMIdWVtBvTYQ2YrAxRjSYRbBXyLOhT/WPDpCjelA7k+dylc2Y0pxy2/S8HTOxFtpv4wr3X71NfYHAJy4sZt/lYar9g6rq85saBDwVm6Mjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqDhzxooY0X6jtji1FR8chh3mj8SaZlGIU5mxuWeZUo=;
 b=KmkgZokpmoqNBiVAkwoy5QlXR/hSjuKw9b+4gOTa7colpNC9ZV6y1L0wPpsori1JCW5+Q8vW77P1WWlKIX9QCLaRp7zLJPJODuBE/DmbMNEf5mr+5Q2BAvmNIZg7PTPXX1Yq5cX6any2K3FdrNb232x9AImwVAs4VaCPYHLagCI=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB2537.namprd11.prod.outlook.com (2603:10b6:5:cd::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23; Fri, 3 Jul 2020 03:53:14 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c%6]) with mapi id 15.20.3131.033; Fri, 3 Jul 2020
 03:53:14 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 02/14] iommu: Report domain nesting info
Thread-Topic: [PATCH v3 02/14] iommu: Report domain nesting info
Thread-Index: AQHWSgRQVmc9Qp+Xi0mQEumzIJrE0qj0n78AgAClxmA=
Date: Fri, 3 Jul 2020 03:53:14 +0000
Message-ID: <DM5PR11MB14353D6E0E4CE34BD839663BC36A0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-3-git-send-email-yi.l.liu@intel.com>
 <20200702115454.058bd198@x1.home>
In-Reply-To: <20200702115454.058bd198@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d152ba31-51d2-4546-015c-08d81f049cf8
x-ms-traffictypediagnostic: DM6PR11MB2537:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2537D298C5EEF680952C5374C36A0@DM6PR11MB2537.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3abHtGmnBgaVtqxvynip+nhzy1pb65YHdVn8N5g2QPB9GYXEIYqzXP2BrNyLY0HQd3mT+coM+HFl8JMtRzpBy99GMzdWlTHfHzQGBFbPEB3FDOiB4I35+FTHDGUWlYpmRwAm/Ppqt681CkZQKTlRFOBDYtCZu3gWlVldpcWm+6+TBeSY6Rr5VM+pg8OcreVwrfFjGh2Vsc52kJyacvFyeN8demMKwAudCmnmA9EQjSpKFnQy6BHXpvU6X0hUgUwpn6TxYezJZ1ap2r8fWzRYqR8+6+XXWThLAY52r4rN758P7cqRpAJl3dQTOPDCv7Z8TZ2I6Eeqi8rLjr/eYR5lFg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(71200400001)(6916009)(54906003)(9686003)(316002)(55016002)(83380400001)(52536014)(7416002)(26005)(33656002)(6506007)(478600001)(4326008)(8936002)(7696005)(186003)(2906002)(8676002)(5660300002)(86362001)(66556008)(64756008)(66446008)(76116006)(66476007)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: oHLQuncbA04bo7wQW/ET5fJ4wsDOWjWPu6MKGnCZ3NwzsnkwjBYrkB08YYr/G7Gv7zylokVbS6ld7XUH26KV4TzeekZf3H42C+p1mHgkA8gcTq2t7nOahiKf15g0l0QXUPBfsQoUudGgoBxXbwicgbJ6d813lLnETNxFnIbsj2DhGNJV6wwaNvchvUiJUbljBX7j4KsEFC8O97m2B8Rwt83amxABXME0FVm2MHt5nfESaUApLvEc5k5I1wSvO8UZiouA+VBDDpRSeSJV6tFHw74pdOVOzGn7Q+3DJKTzCY19diM+EUjDKZiVvUjq7Ck64cE+WqcGPgSodCsjWOwkKv7Z3yR1kUxBaHDCcGWzceZ1BLFI1K/PT7hmvXXGD77nvPsUtNOdJlrHv5ZI8pWQfo23tkJrwBRUkpAlvFBVZr8BoYvOsGH7Zpu5zhvUxZW84Y5YGcBUHxj2wahuwRxnMYNqd4V7hkof/EDw0LmJQpOQK+XdQd95mBQCra940JH4
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d152ba31-51d2-4546-015c-08d81f049cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 03:53:14.5145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+/sL+heOP52hMKzlkD0DCyrTbwSmEMWz7wforblpbfDx1Fsfl3fftatEPA7xJi+SvvU7NXxboPC78pHSOO6aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2537
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian,
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, July 3, 2020 1:55 AM
> 
> On Wed, 24 Jun 2020 01:55:15 -0700
> Liu Yi L <yi.l.liu@intel.com> wrote:
> 
> > IOMMUs that support nesting translation needs report the capability
> > info to userspace, e.g. the format of first level/stage paging structures.
> >
> > This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can get
> > nesting info after setting DOMAIN_ATTR_NESTING.
> >
> > v2 -> v3:
> > *) remvoe cap/ecap_mask in iommu_nesting_info.
> > *) reuse DOMAIN_ATTR_NESTING to get nesting info.
> > *) return an empty iommu_nesting_info for SMMU drivers per Jean'
> >    suggestion.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 29 ++++++++++++++++++++--
> >  drivers/iommu/arm-smmu.c    | 29 ++++++++++++++++++++--
> >  include/uapi/linux/iommu.h  | 59
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 113 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index f578677..0c45d4d 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -3019,6 +3019,32 @@ static struct iommu_group
> *arm_smmu_device_group(struct device *dev)
> >  	return group;
> >  }
> >
> > +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> *smmu_domain,
> > +					void *data)
> > +{
> > +	struct iommu_nesting_info *info = (struct iommu_nesting_info *) data;
> > +	u32 size;
> > +
> > +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> > +		return -ENODEV;
> > +
> > +	size = sizeof(struct iommu_nesting_info);
> > +
> > +	/*
> > +	 * if provided buffer size is not equal to the size, should
> > +	 * return 0 and also the expected buffer size to caller.
> > +	 */
> > +	if (info->size != size) {
> > +		info->size = size;
> > +		return 0;
> > +	}
> > +
> > +	/* report an empty iommu_nesting_info for now */
> > +	memset(info, 0x0, size);
> > +	info->size = size;
> > +	return 0;
> > +}
> > +
> >  static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >  				    enum iommu_attr attr, void *data)  { @@ -
> 3028,8 +3054,7 @@
> > static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >  	case IOMMU_DOMAIN_UNMANAGED:
> >  		switch (attr) {
> >  		case DOMAIN_ATTR_NESTING:
> > -			*(int *)data = (smmu_domain->stage ==
> ARM_SMMU_DOMAIN_NESTED);
> > -			return 0;
> > +			return arm_smmu_domain_nesting_info(smmu_domain,
> data);
> >  		default:
> >  			return -ENODEV;
> >  		}
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
> > 243bc4c..908607d 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1506,6 +1506,32 @@ static struct iommu_group
> *arm_smmu_device_group(struct device *dev)
> >  	return group;
> >  }
> >
> > +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> *smmu_domain,
> > +					void *data)
> > +{
> > +	struct iommu_nesting_info *info = (struct iommu_nesting_info *) data;
> > +	u32 size;
> > +
> > +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> > +		return -ENODEV;
> > +
> > +	size = sizeof(struct iommu_nesting_info);
> > +
> > +	/*
> > +	 * if provided buffer size is not equal to the size, should
> > +	 * return 0 and also the expected buffer size to caller.
> > +	 */
> > +	if (info->size != size) {
> > +		info->size = size;
> > +		return 0;
> > +	}
> > +
> > +	/* report an empty iommu_nesting_info for now */
> > +	memset(info, 0x0, size);
> > +	info->size = size;
> > +	return 0;
> > +}
> > +
> >  static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >  				    enum iommu_attr attr, void *data)  { @@ -
> 1515,8 +1541,7 @@
> > static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >  	case IOMMU_DOMAIN_UNMANAGED:
> >  		switch (attr) {
> >  		case DOMAIN_ATTR_NESTING:
> > -			*(int *)data = (smmu_domain->stage ==
> ARM_SMMU_DOMAIN_NESTED);
> > -			return 0;
> > +			return arm_smmu_domain_nesting_info(smmu_domain,
> data);
> >  		default:
> >  			return -ENODEV;
> >  		}
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 1afc661..898c99a 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -332,4 +332,63 @@ struct iommu_gpasid_bind_data {
> >  	} vendor;
> >  };
> >
> > +/*
> > + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
> > + *				user space should check it before using
> > + *				nesting capability.
> > + *
> > + * @size:	size of the whole structure
> > + * @format:	PASID table entry format, the same definition with
> > + *		@format of struct iommu_gpasid_bind_data.
> > + * @features:	supported nesting features.
> > + * @flags:	currently reserved for future extension.
> > + * @data:	vendor specific cap info.
> > + *
> > + * +---------------+----------------------------------------------------+
> > + * | feature       |  Notes                                             |
> > + *
> >
> ++===============+============================================
> ========
> > ++
> > + * | SYSWIDE_PASID |  Kernel manages PASID in system wide, PASIDs used  |
> > + * |               |  in the system should be allocated by host kernel  |
> > + * +---------------+----------------------------------------------------+
> > + * | BIND_PGTBL    |  bind page tables to host PASID, the PASID could   |
> > + * |               |  either be a host PASID passed in bind request or  |
> > + * |               |  default PASIDs (e.g. default PASID of aux-domain) |
> > + * +---------------+----------------------------------------------------+
> > + * | CACHE_INVLD   |  mandatory feature for nesting capable IOMMU       |
> > + *
> > ++---------------+----------------------------------------------------
> > ++
> 
> Agree with the previous comments on these descriptions and Kevin's suggestions.

I see. will follow the suggestions.

> > + *
> > + */
> > +struct iommu_nesting_info {
> > +	__u32	size;
> > +	__u32	format;
> > +	__u32	features;
> > +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> > +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> > +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> > +	__u32	flags;
> > +	__u8	data[];
> 
> How does the user determine which vendor structure is provided in data[]?

it can be deduced by the @format field. @format field follows the definition
in the iommu_gpasid_bind_data.

struct iommu_gpasid_bind_data {
        __u32 argsz;
#define IOMMU_GPASID_BIND_VERSION_1     1
        __u32 version;
#define IOMMU_PASID_FORMAT_INTEL_VTD    1
        __u32 format;
#define IOMMU_SVA_GPASID_VAL    (1 << 0) /* guest PASID valid */
        __u64 flags;
        __u64 gpgd;
        __u64 hpasid;
        __u64 gpasid;
        __u32 addr_width;
        __u8  padding[12];
        /* Vendor specific data */
        union {
                struct iommu_gpasid_bind_data_vtd vtd;
        } vendor;
};

Regards,
Yi Liu

> Thanks,
> 
> Alex
> 
> > +};
> > +
> > +/*
> > + * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info
> > + *
> > + *
> > + * @flags:	VT-d specific flags. Currently reserved for future
> > + *		extension.
> > + * @addr_width:	The output addr width of first level/stage translation
> > + * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
> > + *		support.
> > + * @cap_reg:	Describe basic capabilities as defined in VT-d capability
> > + *		register.
> > + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> > + *		extended capability register.
> > + */
> > +struct iommu_nesting_info_vtd {
> > +	__u32	flags;
> > +	__u16	addr_width;
> > +	__u16	pasid_bits;
> > +	__u64	cap_reg;
> > +	__u64	ecap_reg;
> > +};
> > +
> >  #endif /* _UAPI_IOMMU_H */

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
