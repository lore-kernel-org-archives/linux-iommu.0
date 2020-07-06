Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C18C433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:26:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C48206F5
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ONUCHVK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C48206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B584388276;
	Mon,  6 Jul 2020 13:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9nbfyQK-+ikf; Mon,  6 Jul 2020 13:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B31A288437;
	Mon,  6 Jul 2020 13:26:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 847CAC08A9;
	Mon,  6 Jul 2020 13:26:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B249C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:26:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2918886D15
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:26:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ysSZlHdKcSXH for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 13:26:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DB01B86CA7
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:26:19 +0000 (UTC)
IronPort-SDR: ehb54q9k76GjOmk4qAy4leaw7Y+eLCK2j8MRd/p74rD8zS9OGNCt5pFCx91PdoBcsPB4c0qxkj
 Nei4PpB/Qyyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="127486037"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; d="scan'208";a="127486037"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 06:26:17 -0700
IronPort-SDR: PlfddyEk1bL/1wHCJhz1LRBKWsyYCwQ7l52m67FgQYY0/Rj3i2N4KfhCTFrgsV+EWlRihxxeEp
 24FJmg7fOuLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; d="scan'208";a="267920016"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
 by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2020 06:26:18 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 06:26:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jul 2020 06:26:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU6KDqY+87PkfKNkMHAQm4DlfEGQ/AQGaMOt6K+rQd9eJRZMFNzNomq4DAtFdCLoTT4SnHzhtwlnguBOILKJHOx6uZzEfEonqOGB7+mpYGfyj8hmFh+KtzCOEv7/Ft0FEYUh+a8hd/nCyylqkhQ2HGucvUaTgIBJ+Oshahf22VwfiVuChTMTrnCBnmIJTh/m4BmmHWIWLyf4QFW1NZNskjydhW+4QFO50o+Kj6//ZivVHqGZr9Wu+kpfgYFqfpbK1v4+26py2IlpK/7RAC+ulj0Hd7JABMwwsh+BkXzeazgrTHnuH19JSuCucwfPFJ5/I1X0TLve0eKz7t4uJVLo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiOZxDh1JoZOfE0etzh0xWvjUMdIxADic7Q0TwX/UOw=;
 b=L7XbLMRr75N6drj54Tjy8gtCwLOMSYVs7DxGwMoUNWB6q80jgzAVhrNQh+WmciFaIHclz3rDHQTMnrS/cG1yRzpHGaGiPn3R3IuK5qrvNwuAKO9YqLyIzxYDmuwE4rY6kqDOFl3EsFmaKh6J91Eexph3mCFwX7Ur3/RV7lEFySk6GUEroFAyZX9FZT5DvQjey3craDI0GshPONC6cMtOpsSGv08/w7fhdYUi07Tuw0Y5MsAW/WuEJxX/LOYdfDIsQpWvceFJ9t2Lke7S3gEFbV0vI4nzBZ7n/6JUDhnvRwlDNcIKtugTS1S2vbm+CFCfVU4jz2slLQrf+2Rcj5YUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiOZxDh1JoZOfE0etzh0xWvjUMdIxADic7Q0TwX/UOw=;
 b=ONUCHVK2ydL9CnM7LmE0bukz4V2vKQYMqetwucJp+wepJaM+5+SK6EDqs4rAJOOzg7oa2BztrSjum5OWM7D6T2zfqEL7QGrzXkS5eSma+8j5GSRXjQC9V4EtRbYS6uLy4NawlFkSxazyWvGKkdFlN091oNVeLoFYZ/UwgPqhe04=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3595.namprd11.prod.outlook.com (2603:10b6:5:142::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23; Mon, 6 Jul 2020 13:26:15 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 13:26:15 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v4 03/15] iommu/smmu: Report empty domain nesting info
Thread-Topic: [PATCH v4 03/15] iommu/smmu: Report empty domain nesting info
Thread-Index: AQHWUfUaPoulLLqnPkWWSyUjWN1VMaj6XtmAgAAiPXCAAAvZAIAAAMyg
Date: Mon, 6 Jul 2020 13:26:15 +0000
Message-ID: <DM5PR11MB143534C547D61ABAE5CCEDBFC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
 <1593861989-35920-4-git-send-email-yi.l.liu@intel.com>
 <d791bad4-57b9-8e97-acbb-76b13e4154f8@redhat.com>
 <DM5PR11MB143543A04F5AF15EC7CBEC8BC3690@DM5PR11MB1435.namprd11.prod.outlook.com>
 <4d1a11b4-dcf3-b3a1-8802-3dd3ae97b3a4@redhat.com>
In-Reply-To: <4d1a11b4-dcf3-b3a1-8802-3dd3ae97b3a4@redhat.com>
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
x-ms-office365-filtering-correlation-id: ae76ee19-0f86-49d6-6c38-08d821b028ea
x-ms-traffictypediagnostic: DM6PR11MB3595:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB35952A0212EA2A28981B944CC3690@DM6PR11MB3595.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lm3BKdRefNldk/Yo56RvZQrp3e8zXWvyQ0cv5WF6IRnSm7eF2eZorNjU3ClriCMjRGF+OLs9Ri9bDOaIj393DTQFwP+dE1ZdY4/mJBA6ythx/iJo82S+L5ItHIF/vIfXwoA5WZHwXBiuYWYM8u9Qc3+qRa34SFdkIWr5GKXwqC0FzYx1gv3wiZj7GJQ5wFrD5nnBqRhEQ0OE4HADQMDN7fWaJLe1qcInjm2tVdAQ2WXG5gL/PhljRLDsJdrPhT3V9w/uTUg03ayXKN7HzR2nndww2ekqdGg24AoK3m4BsCJXIgswuHSwBf2goQGUbr9hmO+XR4SnMhZN7D3QH+5dgd0Me9XOsWNL3n+Xi9D0wpyJbj52QggKVXmgxUw6J45sYiNl9YIsxELcO6+fmFH3Ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(54906003)(316002)(110136005)(8936002)(8676002)(66446008)(4326008)(66946007)(66556008)(53546011)(9686003)(2906002)(55016002)(66476007)(64756008)(6506007)(186003)(76116006)(7696005)(26005)(71200400001)(86362001)(52536014)(5660300002)(966005)(7416002)(478600001)(33656002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: yjTuqapc8t76NZhlGFddGInBCqwfpturJlNcGBeNMGD97QmAbBQx47E/jrdUPZ0u9K7UH93mj2D2xTb25UL/5p43NVvbIWkINhP5G3sXx3jZL+X3Fga2ma0kdY/eALpXp0NvZUfhbP81esuoyl5YRluhtvNmI1gkzHg4lGzY25TqIG0zuv/9tPL4WCiFJXoH/a1hJpv+MsMOKfGrZiGqSEw/bW0WdoiJ6BYiu2DIgs/9JhHn7DKtiusrityFnyk3/sMhUzvN4E21lGGWq+FlCP2dQJRhhL7Kjui8OJsuyWHvC1C0rEs7/jwNBIbFKCOVoSMteTnRHVP0gH66RroRzgNw20lzrRzeARKjh9+y2TjYG5eSHNZdmKBrjuDspwQ8i7W1AN30cP636fvLAb0f7AnW1xO8cPjs2KeDP+ENK+Dc3cNfdO/+CQ44IE2X61b4JKD2j4w0EucRynG3CLlJ/fUddAA4aOtIDQJOkEzdLm3SL0dB0jKw2Au9c6HVJFx2
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae76ee19-0f86-49d6-6c38-08d821b028ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 13:26:15.5868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDO0/P7j/YI0lNflq0WHm0wdjOujg3+ayRp6j2I6ASy3BZmqbdXC3mII1xA5fRtfLo8L1+wHnkU65j4KCyTpRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3595
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
> Sent: Monday, July 6, 2020 9:22 PM
> 
> Hi Yi,
> 
> On 7/6/20 2:46 PM, Liu, Yi L wrote:
> > Hi Eric,
> >
> >> From: Auger Eric <eric.auger@redhat.com>
> >>
> >> Hi Yi,
> >>
> >> Please add a commit message: instead of returning a boolean for
> >> DOMAIN_ATTR_NESTING, arm_smmu_domain_get_attr() returns a
> >> iommu_nesting_info handle.
> >
> > will do. thanks for the suggestion.
> >
> >>
> >> On 7/4/20 1:26 PM, Liu Yi L wrote:
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>> Cc: Eric Auger <eric.auger@redhat.com>
> >>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> ---
> >>>  drivers/iommu/arm-smmu-v3.c | 29 +++++++++++++++++++++++++++--
> >>>  drivers/iommu/arm-smmu.c    | 29 +++++++++++++++++++++++++++--
> >>>  2 files changed, 54 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/arm-smmu-v3.c
> >>> b/drivers/iommu/arm-smmu-v3.c index f578677..0c45d4d 100644
> >>> --- a/drivers/iommu/arm-smmu-v3.c
> >>> +++ b/drivers/iommu/arm-smmu-v3.c
> >>> @@ -3019,6 +3019,32 @@ static struct iommu_group
> >> *arm_smmu_device_group(struct device *dev)
> >>>  	return group;
> >>>  }
> >>>
> >>> +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> >> *smmu_domain,
> >>> +					void *data)
> >>> +{
> >>> +	struct iommu_nesting_info *info = (struct iommu_nesting_info *) data;
> >>> +	u32 size;
> >>> +
> >>> +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> >>> +		return -ENODEV;
> >>> +
> >>> +	size = sizeof(struct iommu_nesting_info);
> >>> +
> >>> +	/*
> >>> +	 * if provided buffer size is not equal to the size, should
> >>> +	 * return 0 and also the expected buffer size to caller.
> >>> +	 */
> >>> +	if (info->size != size) {
> >> < size?
> >
> > < size may work as well. but I'd like the caller provide exact buffer
> > size. not sure if it is demand in kernel. do you have any suggestion?
> 
> I just suggested that by analogy with the VFIO argsz

I see. will change it.

> 
> >
> >>> +		info->size = size;
> >>> +		return 0;
> >>> +	}
> >>> +
> >>> +	/* report an empty iommu_nesting_info for now */
> >>> +	memset(info, 0x0, size);
> >>> +	info->size = size;
> >> For info, the current SMMU NESTED mode is not enabling any nesting.
> >> It just forces the usage of the 2st stage instead of stage1 for single stage
> translation.
> >
> > yep. The intention is as below:
> >
> > " However it requires changing the get_attr(NESTING) implementations
> > in both SMMU drivers as a precursor of this series, to avoid breaking
> > VFIO_TYPE1_NESTING_IOMMU on Arm. Since we haven't yet defined the
> > nesting_info structs for SMMUv2 and v3, I suppose we could return an
> > empty struct iommu_nesting_info for now?"
> > https://lore.kernel.org/linux-iommu/20200617143909.GA886590@myrica/
> >
> > do you think any other needs to be done for now?
> 
> I understand this is a prerequisite. It was more as an information.
> Returning a void struct is a bit weird but at the moment I don't have anything better.

got you. do you think it is necessary to add your statement as a comment here?

Regards,
Yi Liu

> Thanks
> 
> Eric
> >
> > Regards,
> > Yi Liu
> >
> >> Thanks
> >>
> >> Eric
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >>>  				    enum iommu_attr attr, void *data)  { @@ -
> >> 3028,8 +3054,7 @@
> >>> static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >>>  	case IOMMU_DOMAIN_UNMANAGED:
> >>>  		switch (attr) {
> >>>  		case DOMAIN_ATTR_NESTING:
> >>> -			*(int *)data = (smmu_domain->stage ==
> >> ARM_SMMU_DOMAIN_NESTED);
> >>> -			return 0;
> >>> +			return arm_smmu_domain_nesting_info(smmu_domain,
> >> data);
> >>>  		default:
> >>>  			return -ENODEV;
> >>>  		}
> >>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >>> index 243bc4c..908607d 100644
> >>> --- a/drivers/iommu/arm-smmu.c
> >>> +++ b/drivers/iommu/arm-smmu.c
> >>> @@ -1506,6 +1506,32 @@ static struct iommu_group
> >> *arm_smmu_device_group(struct device *dev)
> >>>  	return group;
> >>>  }
> >>>
> >>> +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> >> *smmu_domain,
> >>> +					void *data)
> >>> +{
> >>> +	struct iommu_nesting_info *info = (struct iommu_nesting_info *) data;
> >>> +	u32 size;
> >>> +
> >>> +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> >>> +		return -ENODEV;
> >>> +
> >>> +	size = sizeof(struct iommu_nesting_info);
> >>> +
> >>> +	/*
> >>> +	 * if provided buffer size is not equal to the size, should
> >>> +	 * return 0 and also the expected buffer size to caller.
> >>> +	 */
> >>> +	if (info->size != size) {
> >>> +		info->size = size;
> >>> +		return 0;
> >>> +	}
> >>> +
> >>> +	/* report an empty iommu_nesting_info for now */
> >>> +	memset(info, 0x0, size);
> >>> +	info->size = size;
> >>> +	return 0;
> >>> +}
> >>> +
> >>>  static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >>>  				    enum iommu_attr attr, void *data)  { @@ -
> >> 1515,8 +1541,7 @@
> >>> static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >>>  	case IOMMU_DOMAIN_UNMANAGED:
> >>>  		switch (attr) {
> >>>  		case DOMAIN_ATTR_NESTING:
> >>> -			*(int *)data = (smmu_domain->stage ==
> >> ARM_SMMU_DOMAIN_NESTED);
> >>> -			return 0;
> >>> +			return arm_smmu_domain_nesting_info(smmu_domain,
> >> data);
> >>>  		default:
> >>>  			return -ENODEV;
> >>>  		}
> >>>
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
