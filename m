Return-Path: <SRS0=8AL1=AI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2935FC433DF
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 06:53:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDDE20857
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 06:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="SZQ6JrK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDDE20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9FA48204B6;
	Sat, 27 Jun 2020 06:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sW9Z0NszBDLc; Sat, 27 Jun 2020 06:53:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 939AD2047F;
	Sat, 27 Jun 2020 06:53:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BAFBC0863;
	Sat, 27 Jun 2020 06:53:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAAB1C016F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 06:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 97E1F8819F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 06:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PWqkoYC9vRDm for <iommu@lists.linux-foundation.org>;
 Sat, 27 Jun 2020 06:53:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9F0F08815B
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 06:53:15 +0000 (UTC)
IronPort-SDR: njlO2yS0AqecHNV8SRKHto1yA+SGmAjBY4TML4WZLgWqpXKqdtccgFlR4SpofI1MgjpXywWEYK
 O4/yx2cLCCBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="207127748"
X-IronPort-AV: E=Sophos;i="5.75,286,1589266800"; d="scan'208";a="207127748"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 23:53:14 -0700
IronPort-SDR: ehbmQWrLNoUZAZ2RyGXHd9r3xtxzZFjdKbl5L8fVDL7AIEKGyXsoGmjuJO29AcMBqgDuPTFEEm
 uGeI11DPw/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,286,1589266800"; d="scan'208";a="305227051"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga007.jf.intel.com with ESMTP; 26 Jun 2020 23:53:14 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jun 2020 23:53:14 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jun 2020 23:53:13 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.52) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 26 Jun 2020 23:53:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca5pY2qRh5El5XwBNiBpjDNRMwoit485gh802JAsbWOCTNLFU99i19DHIEGuG0S2sigevkx4HvdO75Iw7pphPwWOxVmekiEzdHnXiHALTrBo6BSpfo60pcl+OzTExz4+Rb27cFadbsTWlyGdLGNjvtCeWVlTlEuFFjMjqMizN8ge55tuIFDNX8DANtd4FOg1PZ9OeDaRj8/rwnB0+Caqrta3pTptGa07+uVvSOKry2CdY2GlD6jpz2xM0l6kRJrmqwjjKN6rSEpELFmh5dcj31DaXIsLLU4zL6Rnlmkg4z/J3BuDBzhFQGbwhJpKmGtq8RSM2pcmJx6REyFKZ8dNXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQe6G48jub3RKJSmPao6LVqDDvfPbd/M/bTk+yxpqG4=;
 b=OFKTqaTMJZFt7OXiSs2AKcoAAeIQnMVBiZdD+3ofWgGw5O8SgboqQFOmVpDTfVb2bCtABDxY6xAZfmck7aXj9Ov0wsZOKT509qCenpMD7YwrDJ3bOzFIg/sULJHCLZGQD6JE6bZFlaipd8NHcvGMGz0f434AMIVzlHbihvp3RYp9sFWpYL65K5iifVMv6wTT24ZbESqYuZLy3JXHBh/HRdutXMimc61cIzCKGXEnxQQJGDKyI4MmY0+IN7HOvCZJW5vFY+hsMEZrNlnad7RMmyBPbvIvO9br98hWzRjSVec2Ub2I4dg+fVPUCKuThYWt0d6Zw1vzrFYvia/ijcqFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQe6G48jub3RKJSmPao6LVqDDvfPbd/M/bTk+yxpqG4=;
 b=SZQ6JrK7RFoCBfWhozfJk+fLEfO6ZnYqKIwdgZiYfMEDtaKam8U8LKMKO+g3jJV1a4k9BvhDFriQdHvK8wz+lIAPiOCy81bSpvVyH/mE0xeqRyODRyEdWCir3uHWn345gSmvXWIXsovrYuT8WnFQjTAiLcEB0iJTJmzzupa8szE=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4473.namprd11.prod.outlook.com (2603:10b6:5:1de::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.23; Sat, 27 Jun 2020 06:53:12 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c%6]) with mapi id 15.20.3131.025; Sat, 27 Jun 2020
 06:53:11 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>
Subject: RE: [PATCH v3 02/14] iommu: Report domain nesting info
Thread-Topic: [PATCH v3 02/14] iommu: Report domain nesting info
Thread-Index: AQHWSgRQVmc9Qp+Xi0mQEumzIJrE0qjqiBcAgACK1oCAAO2ggA==
Date: Sat, 27 Jun 2020 06:53:11 +0000
Message-ID: <DM5PR11MB1435D877048ACCC1B8EAAFDBC3900@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-3-git-send-email-yi.l.liu@intel.com>
 <20200626074738.GA2107508@myrica>
 <069bcf66-4db3-b4f1-2e09-a79d255d0850@arm.com>
In-Reply-To: <069bcf66-4db3-b4f1-2e09-a79d255d0850@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ef028e0-0044-4945-bd65-08d81a66c230
x-ms-traffictypediagnostic: DM6PR11MB4473:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB447371CAB644A0EC9786266EC3900@DM6PR11MB4473.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0447DB1C71
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3T750JN9cAZkHbMZQxejyGapC/BANZjPyv17h3SpA7ibXfKuXa7NjRJZx6CgVU5Kg7wbS0nFjiEDC7/5Un3hK2Glht/0FoVAxb5bEKgPOe8o+o5xBAuuHCeMblVgnU77HFR0+nYpKK4t7CoC/GZAzueOD2ZpQCWFNYplAa5KoRkaT2/VGoCweZIL+sjrAgyGcIK9cgmeR4ZpH31ktvpNdIIsV/g5UOAEzNkX6CeR7L5t51BkrC0upxIDQAz1tF6FKRkVFscCHYqbteHy82PivsWl1a/J9PitAAx83Z37IMTPsRQWGQ6fe5eBDo1+xip9qTwsa6kMhBPoVwo2lb8K+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(2906002)(54906003)(478600001)(52536014)(110136005)(7416002)(55016002)(5660300002)(76116006)(66556008)(64756008)(86362001)(66476007)(8676002)(66946007)(66446008)(4326008)(71200400001)(26005)(186003)(83380400001)(7696005)(316002)(8936002)(6506007)(33656002)(9686003)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: rm2KuZjlXlj0JG4FnBXR7ZS2+HRWowbJynQw2R+MritwLaog8eLKCK8sVbJ+50et5crX5LOqfpyQrUwI+tLyeF+Tsud2Yi+rwtLiL6NNErFXcnroiCafF33Li3H4l1Zewa/2GaCS21+qzWZqByRPcbk85aRD7JvWlFl6QXKBzB+/KrgX0POBA3vAUeSTGyju21339idt1K1KocVTwdN8vqIJ95KOVexvA4lI88XGurjKn9EGFT8Yi2GK1usG6txCd0psXo9mHypRll/WkCxsW/SFS4QGF718aqpt8raH/WZ9Gvw7EoKQSYLaZ7YcZAsxYNJObWWjzOU8RVLaHAsL7vtJiVXxfeLdzG40RpBaPZk8ruEAufXPg7lVOfpDdN7E8NJBAD9iY3cWaSdkGHHdo2g94V6Yf3h7oWju+thDWNnd3k0sovalHJNdZXlIO04MftFsPEe9LLJeytRDyDwWCpxxwpQEXNAti+iqIjwIHBxcdMx+ilee2SKdc+oR+qxN
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef028e0-0044-4945-bd65-08d81a66c230
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2020 06:53:11.8646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+v0gOmyKcUGz1yssdWJVa0h5nD1EjetOHQGapn0ZEk+r4uXG7ry9FMG3/a1uMsTDhKO5fAHougeUGjdYwQ/Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4473
X-OriginatorOrg: intel.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
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

Hi Robin,

> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Saturday, June 27, 2020 12:05 AM
> 
> On 2020-06-26 08:47, Jean-Philippe Brucker wrote:
> > On Wed, Jun 24, 2020 at 01:55:15AM -0700, Liu Yi L wrote:
> >> IOMMUs that support nesting translation needs report the capability
> >> info to userspace, e.g. the format of first level/stage paging structures.
> >>
> >> This patch reports nesting info by DOMAIN_ATTR_NESTING. Caller can
> >> get nesting info after setting DOMAIN_ATTR_NESTING.
> >>
> >> v2 -> v3:
> >> *) remvoe cap/ecap_mask in iommu_nesting_info.
> >> *) reuse DOMAIN_ATTR_NESTING to get nesting info.
> >> *) return an empty iommu_nesting_info for SMMU drivers per Jean'
> >>     suggestion.
> >>
> >> Cc: Kevin Tian <kevin.tian@intel.com>
> >> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Cc: Alex Williamson <alex.williamson@redhat.com>
> >> Cc: Eric Auger <eric.auger@redhat.com>
> >> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >> Cc: Joerg Roedel <joro@8bytes.org>
> >> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> >> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> ---
> >>   drivers/iommu/arm-smmu-v3.c | 29 ++++++++++++++++++++--
> >>   drivers/iommu/arm-smmu.c    | 29 ++++++++++++++++++++--
> >
> > Looks reasonable to me. Please move the SMMU changes to a separate
> > patch and Cc the SMMU maintainers:
> 
> Cheers Jean, I'll admit I've been skipping over a lot of these patches lately :)
> 
> A couple of comments below...
> 
> >
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> >
> > Thanks,
> > Jean
> >
> >>   include/uapi/linux/iommu.h  | 59
> +++++++++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 113 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm-smmu-v3.c
> >> b/drivers/iommu/arm-smmu-v3.c index f578677..0c45d4d 100644
> >> --- a/drivers/iommu/arm-smmu-v3.c
> >> +++ b/drivers/iommu/arm-smmu-v3.c
> >> @@ -3019,6 +3019,32 @@ static struct iommu_group
> *arm_smmu_device_group(struct device *dev)
> >>   	return group;
> >>   }
> >>
> >> +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> *smmu_domain,
> >> +					void *data)
> >> +{
> >> +	struct iommu_nesting_info *info = (struct iommu_nesting_info *) data;
> >> +	u32 size;
> >> +
> >> +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> >> +		return -ENODEV;
> >> +
> >> +	size = sizeof(struct iommu_nesting_info);
> >> +
> >> +	/*
> >> +	 * if provided buffer size is not equal to the size, should
> >> +	 * return 0 and also the expected buffer size to caller.
> >> +	 */
> >> +	if (info->size != size) {
> >> +		info->size = size;
> >> +		return 0;
> >> +	}
> >> +
> >> +	/* report an empty iommu_nesting_info for now */
> >> +	memset(info, 0x0, size);
> >> +	info->size = size;
> >> +	return 0;
> >> +}
> >> +
> >>   static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >>   				    enum iommu_attr attr, void *data)
> >>   {
> >> @@ -3028,8 +3054,7 @@ static int arm_smmu_domain_get_attr(struct
> iommu_domain *domain,
> >>   	case IOMMU_DOMAIN_UNMANAGED:
> >>   		switch (attr) {
> >>   		case DOMAIN_ATTR_NESTING:
> >> -			*(int *)data = (smmu_domain->stage ==
> ARM_SMMU_DOMAIN_NESTED);
> >> -			return 0;
> >> +			return arm_smmu_domain_nesting_info(smmu_domain,
> data);
> >>   		default:
> >>   			return -ENODEV;
> >>   		}
> >> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >> index 243bc4c..908607d 100644
> >> --- a/drivers/iommu/arm-smmu.c
> >> +++ b/drivers/iommu/arm-smmu.c
> >> @@ -1506,6 +1506,32 @@ static struct iommu_group
> *arm_smmu_device_group(struct device *dev)
> >>   	return group;
> >>   }
> >>
> >> +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> *smmu_domain,
> >> +					void *data)
> >> +{
> >> +	struct iommu_nesting_info *info = (struct iommu_nesting_info *) data;
> >> +	u32 size;
> >> +
> >> +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> >> +		return -ENODEV;
> >> +
> >> +	size = sizeof(struct iommu_nesting_info);
> >> +
> >> +	/*
> >> +	 * if provided buffer size is not equal to the size, should
> >> +	 * return 0 and also the expected buffer size to caller.
> >> +	 */
> >> +	if (info->size != size) {
> >> +		info->size = size;
> >> +		return 0;
> >> +	}
> >> +
> >> +	/* report an empty iommu_nesting_info for now */
> >> +	memset(info, 0x0, size);
> >> +	info->size = size;
> >> +	return 0;
> >> +}
> >> +
> >>   static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >>   				    enum iommu_attr attr, void *data)
> >>   {
> >> @@ -1515,8 +1541,7 @@ static int arm_smmu_domain_get_attr(struct
> iommu_domain *domain,
> >>   	case IOMMU_DOMAIN_UNMANAGED:
> >>   		switch (attr) {
> >>   		case DOMAIN_ATTR_NESTING:
> >> -			*(int *)data = (smmu_domain->stage ==
> ARM_SMMU_DOMAIN_NESTED);
> >> -			return 0;
> >> +			return arm_smmu_domain_nesting_info(smmu_domain,
> data);
> >>   		default:
> >>   			return -ENODEV;
> >>   		}
> >> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> >> index 1afc661..898c99a 100644
> >> --- a/include/uapi/linux/iommu.h
> >> +++ b/include/uapi/linux/iommu.h
> >> @@ -332,4 +332,63 @@ struct iommu_gpasid_bind_data {
> >>   	} vendor;
> >>   };
> >>
> >> +/*
> >> + * struct iommu_nesting_info - Information for nesting-capable IOMMU.
> >> + *				user space should check it before using
> >> + *				nesting capability.
> >> + *
> >> + * @size:	size of the whole structure
> >> + * @format:	PASID table entry format, the same definition with
> >> + *		@format of struct iommu_gpasid_bind_data.
> >> + * @features:	supported nesting features.
> >> + * @flags:	currently reserved for future extension.
> >> + * @data:	vendor specific cap info.
> >> + *
> >> + * +---------------+----------------------------------------------------+
> >> + * | feature       |  Notes                                             |
> >> + *
> >>
> ++===============+============================================
> =======
> >> +=+
> >> + * | SYSWIDE_PASID |  Kernel manages PASID in system wide, PASIDs used  |
> >> + * |               |  in the system should be allocated by host kernel  |
> >> + * +---------------+----------------------------------------------------+
> >> + * | BIND_PGTBL    |  bind page tables to host PASID, the PASID could   |
> >> + * |               |  either be a host PASID passed in bind request or  |
> >> + * |               |  default PASIDs (e.g. default PASID of aux-domain) |
> >> + * +---------------+----------------------------------------------------+
> >> + * | CACHE_INVLD   |  mandatory feature for nesting capable IOMMU       |
> >> + *
> >> ++---------------+---------------------------------------------------
> >> +-+
> >> + *
> >> + */
> >> +struct iommu_nesting_info {
> >> +	__u32	size;
> >> +	__u32	format;
> >> +	__u32	features;
> >> +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> >> +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> >> +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> >> +	__u32	flags;
> >> +	__u8	data[];
> >> +};
> >> +
> >> +/*
> >> + * struct iommu_nesting_info_vtd - Intel VT-d specific nesting info
> >> + *
> >> + *
> >> + * @flags:	VT-d specific flags. Currently reserved for future
> >> + *		extension.
> >> + * @addr_width:	The output addr width of first level/stage translation
> >> + * @pasid_bits:	Maximum supported PASID bits, 0 represents no PASID
> >> + *		support.
> >> + * @cap_reg:	Describe basic capabilities as defined in VT-d capability
> >> + *		register.
> >> + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> >> + *		extended capability register.
> >> + */
> >> +struct iommu_nesting_info_vtd {
> >> +	__u32	flags;
> >> +	__u16	addr_width;
> 
> I think this might be worth promoting to a generic feature - Arm has the same
> notion of intermediate address size, and I'd imagine that pretty much any other
> two-stage translation system would as well (either explicitly or implicitly).
> It also
> comes close to something the DPDK folks raised where they wanted parity with a
> feature that currently scrapes AGAW out of some VT-d-specific place, so
> abstracting it to completely generic code, in a way that could eventually be
> generalised to reporting info for non-nested domains too, would be really nice.

got you. I can do that.

> What would also be cool is if the user was able to pass in a structure with
> preferred values for the address size and other capabilities when they request
> nesting in the first place. Right now we'll always set up the maximum possible
> sized page table for any domain, but if we knew ahead of time how many bits the
> user actually cared about then we could potentially be more efficient (e.g. use
> fewer levels of pagetable or a different translation granule).

agreed, and I guess only the configurable caps (like the addr_width, domain
could have different addr_width per user request). I think it may be an
optimization afterward. Here, we report all the nesting related caps to user,
thus user could either do pre-check or expose correct capability to guest per
hardware support. This is necesary as nesting requires guest to maintain page
tables per hw supporting.

Regards,
Yi Liu

> Robin.
> 
> >> +	__u16	pasid_bits;
> >> +	__u64	cap_reg;
> >> +	__u64	ecap_reg;
> >> +};
> >> +
> >>   #endif /* _UAPI_IOMMU_H */
> >> --
> >> 2.7.4
> >>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
