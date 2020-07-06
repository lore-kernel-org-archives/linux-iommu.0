Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985E3C433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 12:48:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6400420715
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 12:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="PH/NZuYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6400420715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 41550888C7;
	Mon,  6 Jul 2020 12:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9klOnvHeMp8b; Mon,  6 Jul 2020 12:48:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6A0AE888A6;
	Mon,  6 Jul 2020 12:48:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AD89C0891;
	Mon,  6 Jul 2020 12:48:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 215F9C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 19BD3888C0
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:48:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6-gQe4mYJxtL for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 12:48:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D53FA888A6
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 12:48:03 +0000 (UTC)
IronPort-SDR: bH4+rxPinr6Y49Tu2PTm7j9i7T4qiJ3GbcjZYGJKbSEdhaX5FzrQHKpGyO1uT2GuvgrnoF5k/p
 oWwS8wXFa6FQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="212390977"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; d="scan'208";a="212390977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 05:47:58 -0700
IronPort-SDR: SiADBshIJ1U/v9lDc6V7Uuzar9kO05jKjiQYWssqcKf+QRswSOtCfNbPGltf7ivngvVbmNpaoW
 rD8IrWi473tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; d="scan'208";a="456711916"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga005.jf.intel.com with ESMTP; 06 Jul 2020 05:47:58 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 05:47:57 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Jul 2020 05:47:57 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 6 Jul 2020 05:47:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 6 Jul 2020 05:47:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu9X7CU/ZW75n4voCvt5a1danbn2r6Z1crb/AQezn/XXltrzDINFzsy+2QX17ZVVVGXVG2rPcnpIK7YFjKoMbgqGBc8AqYriBbkQbm1Ax/oq58TkH/SHyom7Nzji9o9hm+B3kj3hC5mR5YXMQ04xiGJAk2nv/udnqAh6emSDM3ztWFJeTLp1sqyrZFuKxdG+rpWfN8K3SvtcKdonQGBQH6CFn53zPKQOSHPaN4hVJ0W4f4Xm9Y6U/jEsijC7kXzMTzwc4pg5iyE4juG2TGJJ1nlsi45GqDB/76CYOJ2xEFhDorImwjCO5Kes9Zr3DkIUc/4Xq+cJAcyGchrRNdlVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP6rmP0bFLpktkYaR4+8WjiyZaqwH0MJcvL+sFLWIhQ=;
 b=ng+wWXdlVR41kIopKj5alEghOrZGA2QEUO65eFaU739GQLiDE7ao+42/DPsadaSO7AXw2MEPismauTJ4aajZgpdKvGOqusk5bSVVupptD3dN7vfSQW/0vSnY4UxUPDkRym+CA8fAP+KlM6j/LayH++MIgM+cN2CyOm2RuytQlFS0MjVJKhOsz7NWnGS37ghfpGHg2ZOLCX5u16Gar3Omla03SflhHyVCyWAbXyGYVxyY6drtyb2lHOQ4RpODuyuI2seNy4Kq5lkmyYMc+loAGJi5YHFG2zHF3kjCz+hIzEOwJxmC56EDw37dD7paaWP69WRIR5df1Lb836K/d7LcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP6rmP0bFLpktkYaR4+8WjiyZaqwH0MJcvL+sFLWIhQ=;
 b=PH/NZuYrRE61ttwZ/I7IysiJ6MLX6r56V7nhcTK8Z3fCOjoiZjeoC4gLjWKr2zH2L4eOq581UaGZYB/6iF/HSD2PBgPAgQQYOYXL04735+UYrtBeI66wBwkVpF6t/OLqTMEFt3u4ij0Jh4FFvOu6aen+LGNRpCdhC/fGAcX6Vh4=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (10.172.35.146) by
 DM6PR11MB4155.namprd11.prod.outlook.com (20.176.126.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23; Mon, 6 Jul 2020 12:46:53 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 12:46:53 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 03/15] iommu/smmu: Report empty domain nesting info
Thread-Topic: [PATCH v4 03/15] iommu/smmu: Report empty domain nesting info
Thread-Index: AQHWUfUaPoulLLqnPkWWSyUjWN1VMaj6XtmAgAAiPXA=
Date: Mon, 6 Jul 2020 12:46:53 +0000
Message-ID: <DM5PR11MB143543A04F5AF15EC7CBEC8BC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-4-git-send-email-yi.l.liu@intel.com>
 <d791bad4-57b9-8e97-acbb-76b13e4154f8@redhat.com>
In-Reply-To: <d791bad4-57b9-8e97-acbb-76b13e4154f8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e22a3f58-afbe-4bd5-3674-08d821aaa903
x-ms-traffictypediagnostic: DM6PR11MB4155:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4155CE19A5A984ECD679EF05C3690@DM6PR11MB4155.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+zlfz4WDye0BKWoE/F2tRMAIgoGB24OOKAmhyKlbGpx5COMsVC96etDCSgjHTr3nMg9PlcIodetTX58qZVqFNN8yFgsQB1/MztLnwfjeLLjlzjRjNr0ytJngT5kdngmG7tQ1VhBV3jHfaOl8Hz8yFbM/dULH5MzS09/eggBB7ol1kCC0ILDTMKvdPHA5Pr+1tzh9x87CA5n7IOMxRc5mshORQnFNmJwHijLD6+g4w1ItNw0ibhZEvyV+IEIYwqXKjnfjOeGgQ89YaP/cuM8Xo2VUh5vYQkexJRJmYTkDrlgA+Qs3K4FnKvaXgY0EspiOUrUuggLu24qzdOU/L5lKS/SPjAz1vv6wDgWo5WwSSGygJs8p7ry+SXwA8ohlTkQrMonOf1Xg8PgX8CnZFiBvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(83380400001)(71200400001)(7416002)(478600001)(110136005)(54906003)(316002)(966005)(33656002)(7696005)(8676002)(52536014)(64756008)(66556008)(66476007)(66446008)(66946007)(8936002)(6506007)(4326008)(186003)(86362001)(53546011)(76116006)(2906002)(9686003)(55016002)(26005)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 1Ra8GMbEHyJbPBtXtf7nWCRfeIG32bDC12QUYYiBMoA7Y2a9Qoj7HDV8nWMsHFO2wWaKx0db1XlSUcKEgRoz/+YMJdVQccufH1f7iccOmRSTMD63SyibA2ENviX+espLGqBVQuv+YfCTunPwGOJXXdTjqDNe4HEa+vyneqYSNmBc1qVZUob3fHiGVqVdtSS9LKzhiSN3LTvDV9CJ57/KKgJhoEa+kL8EoZ4WOaOCDIbi/O/ZpfiwKBnXHDJHE4llwG0YYX6AdCS/Rd6GsPh7cp67eEIn9DIEPWT7GAn617Je+V3IC1sxeFBJE45fYZIBBRZoTTiLQP9IqsnIhyW5yOy8cfGTFnfJLoo2zZEzZfZ51qo8H3WaTQYwTQhzHbvF9s3XL23HxNfOyXj4MKdefEdYIT7QRCtn9fM4+l2lC6cMldkCQxI1YtJ4KUcWMR9Q3fH0F9Sug5FK4JZFqmrhG2VDUipVBHLkvd5hGI2QwHt8x9/zAoZhOmWiJVkl/I1a
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22a3f58-afbe-4bd5-3674-08d821aaa903
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 12:46:53.5552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HITQbkkx4xjsFRGE/m09A1MLHmnBq2YRN7uxv2cRTOwkojhbUoBxGU3gclv1EFBA3m8YdRO1ZVhy4xQ4/+BuEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4155
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, "Wu, Hao" <hao.wu@intel.com>
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

Hi Eric,

> From: Auger Eric <eric.auger@redhat.com>
> 
> Hi Yi,
> 
> Please add a commit message: instead of returning a boolean for
> DOMAIN_ATTR_NESTING, arm_smmu_domain_get_attr() returns a
> iommu_nesting_info handle.

will do. thanks for the suggestion.

> 
> On 7/4/20 1:26 PM, Liu Yi L wrote:
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 29 +++++++++++++++++++++++++++--
> >  drivers/iommu/arm-smmu.c    | 29 +++++++++++++++++++++++++++--
> >  2 files changed, 54 insertions(+), 4 deletions(-)
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
> < size?

< size may work as well. but I'd like the caller provide exact buffer size. not sure
if it is demand in kernel. do you have any suggestion?

> > +		info->size = size;
> > +		return 0;
> > +	}
> > +
> > +	/* report an empty iommu_nesting_info for now */
> > +	memset(info, 0x0, size);
> > +	info->size = size;
> For info, the current SMMU NESTED mode is not enabling any nesting. It just forces
> the usage of the 2st stage instead of stage1 for single stage translation.

yep. The intention is as below:

" However it requires changing the get_attr(NESTING) implementations in both
SMMU drivers as a precursor of this series, to avoid breaking
VFIO_TYPE1_NESTING_IOMMU on Arm. Since we haven't yet defined the
nesting_info structs for SMMUv2 and v3, I suppose we could return an empty
struct iommu_nesting_info for now?"
https://lore.kernel.org/linux-iommu/20200617143909.GA886590@myrica/

do you think any other needs to be done for now?

Regards,
Yi Liu

> Thanks
> 
> Eric
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
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
