Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1775C433DB
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 09:21:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C15322E01
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 09:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C15322E01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D9B6E86587;
	Tue, 12 Jan 2021 09:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRACcLTDw3XW; Tue, 12 Jan 2021 09:21:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EAA3A85B1C;
	Tue, 12 Jan 2021 09:21:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC61CC088B;
	Tue, 12 Jan 2021 09:21:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05361C013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 09:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E48AD86854
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 09:21:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-+0kD+hzzDO for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 09:21:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9B5E186845
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 09:21:24 +0000 (UTC)
IronPort-SDR: P3NXEW+5zwKakx6b+eCJHA9XrhyC8pnfq483KniG3D/1Axl1VlgdVcOq8MLrBnRo5I3SubgV9N
 EZDdT+FeOgiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="165690083"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; d="scan'208";a="165690083"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2021 01:21:23 -0800
IronPort-SDR: +Rit3b93EXzXJdByVGk1Jl22GTRpNmRJ4yzaVtc07MjEWt6tS43SYxDj47itrMpLe7+HGvEnAG
 7gZSvjaQCZrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; d="scan'208";a="404410012"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2021 01:21:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Jan 2021 01:21:23 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Jan 2021 01:21:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Jan 2021 01:21:22 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 12 Jan 2021 01:21:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISXGdshAJGLrYWNvlRylLZQB/RvQVp/BuRhapNHXOHWlRqhhuR6c3gp9/3/Un2scXVR6LrIGKf8kpLS1DyKoSKtr5d13ZG1ixa/55rMOkqLDkEUNpBI+U2NIy1LIt7VRaQOO5y8M2sxrLBJ5dPOtbyO7cPBOTVTYPHe+X8cBlRT2k3aB0PZH7WDtDENu2V1F1oZCdrBcUtBmxl540hL9oT7YSKpXCblrYv+aaA5n9DmYeOrGAglFOpqlFcvfmPLAaWOFdJOs+0IKRNt2CXbUvHgBaQOPWNO9a6qeRkfYwZkmQfIVsDCD9+IKZR9KZhlNr8QS+JICpZBzgbAqUiDVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loo0jx7kG+6oKarLzpBG5Jy9/pwfnS+FPzMxV82P2ck=;
 b=jkF0ffg2Y46lA4+Mbc8KvCl8AvBo1YBReUytMeTOLmNfIcgLe0ZO/0kUFu1Jl7+nSaKSVAvAZFKgKHgIa8GsG4eioRU39l4aTRf8tFsi4l1BKatJDu6/keMInFGJNxkWudQs/q7Gxjp+aa35AAJbKJF/6YBFgPkW3P00CPq1VvfwZ2llT96TH2BoF2pniHroNiuujOx1EbHmzaLk1q/qkV6VkSJhUAIXrmYQjgm3ni6fQ5iUev1R4Sz6Ghsb7Mv0u2jPQEG8uGLb+Y5VLBu7w9q23Uqtx/68bqSDFz0I2MGrlLIwsCVEbNPbAOBcmHV1/7oJsArDGtFfEmtzP/fGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loo0jx7kG+6oKarLzpBG5Jy9/pwfnS+FPzMxV82P2ck=;
 b=TH6Jo3CWr0EUHzWBXcD70F/Jg+OAajQLJgu70LsPmlbTscxMd7JQ7YBDKDj+EDDByX2AVc8VrnU0beRDsaihUDSO7uNNsOnpnWZxmO5GCN3epe4wfO5pcUUqnnfzAHAROsWHX6/2MD3zt+vgkxXv3RI1UapwScAzj1BpCIeLahA=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1481.namprd11.prod.outlook.com (2603:10b6:4:9::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Tue, 12 Jan 2021 09:21:20 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93%3]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 09:21:20 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: RE: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
Thread-Topic: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
Thread-Index: AQHWh19ACfcP7ssg8UC1cgpZfCvfJKokT6+AgAAjF2A=
Date: Tue, 12 Jan 2021 09:21:20 +0000
Message-ID: <DM5PR11MB14356D5688CA7DC346AA32DBC3AA0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-3-git-send-email-yi.l.liu@intel.com>
 <CAFp+6iFob_fy1cTgcEv0FOXBo70AEf3Z1UvXgPep62XXnLG9Gw@mail.gmail.com>
In-Reply-To: <CAFp+6iFob_fy1cTgcEv0FOXBo70AEf3Z1UvXgPep62XXnLG9Gw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97f826a2-bebe-4d9f-95e9-08d8b6db6c71
x-ms-traffictypediagnostic: DM5PR11MB1481:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB148181A7AEC761CE0C81689FC3AA0@DM5PR11MB1481.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/RkMfarZrAcr2OcJ8JQ/9n0SUp1Gf+vq3zCrCneQLBaQE3pzyeH7S78YSSrDqn9HZWsmNxRJ5aiXlVwLe0znkXSxUnt8ikNnhaNkpTLMcO09l6ZJzdzMLg/iLRBl9SY2/8FEOn+9amEc/+eq2WNaabCjCO2stlWHFookqMYaYOCMMU+YdByGXmpddlPydQBa4a612hoD1MME4q3twwwO3o1jYjlU4sUY4e9DuWA0LKHovEXu0crVrGFTvofZEjkLbJT14Tb3a8bnIUOMslhV6DMFDAU6GBg8VKqxigta8Mzu1ILw9y5lb56U6pTGwUkGMAE1lC0f2g9zzk4hwPks2hgHzp+5ET/NKSFpOEsjfhLM55qsFjzxzirxHo5rGNpT1hsvU1JD3xKNGyU48BDBw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(6506007)(83380400001)(54906003)(478600001)(53546011)(66556008)(6916009)(186003)(2906002)(316002)(8936002)(66446008)(52536014)(5660300002)(66946007)(64756008)(4326008)(86362001)(71200400001)(9686003)(55016002)(7416002)(76116006)(33656002)(8676002)(66476007)(7696005)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: vXbAz80yH1C/kRqqKJ2VaKfHXNyX8rayQGTG7XYkGW8ouYo+TZvsCZMHY4Rbvc3YFmGciONVmtm7ZE0vbVd09dTm0Rm2aJa4+gNmUsTKGzdFXKz0poLHZmzf3Ag6jM9S943TtQ1J/BkeX/AxAqhSS65OyXL8SUW0Mr0BM0Z/1b2Lh89HzmVl720paKEgkVASVM/f3wswK0orjSfUFYNFzojTpmgjY5oA1oNGwfpZegbL+9CRdXUoroX2cslKsnb2bRr+Y7maSN02Mw3OBMeOLbPFPd2wIBhVCAXgoJ2VFIpoglf+TK6IxkLQJ2zWXcCC81k3KsgiAiooimn6y+Bm5tv+mNXaaQ36xjgpiH6jbBQf1o7YNMyi9Vb7hCYFoxpvE5mi9PnIfoy0IXi7PbimAmwdBiFGu0zl9Usm491Tjwn7zVXUJjRKnHz9sEA2KiC7N6cVI9kbz1KnvAETzc5/wpKS/iS6DXQ0VJx980H2SgD0QrbmJXzjvKXNg8jojqfis8Lw7axRpLLA+mwKAKqihq0abtOBjPOFl5Ydp1u7Ywhf2G031kHj//mSIPVkyZeQ5lkjKo3UbktNVuyvEJ9LTSuJKHtd1yoIQf8ctqfdgwJGF6BV1MroSu6B5YuHeSItyeTL+nQNIYDdcrw2IJNwk/uDzF+xG6XILaFxfk5l/Ov9mFSgQME9lWOJCjexYb8u8FRmUU4mfdJEOOHve98pMLsPWPSqxq9aK6O24j6RTP3qPnG0tKcIZjrKMf6j4cOk
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f826a2-bebe-4d9f-95e9-08d8b6db6c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 09:21:20.4262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbup7jxgioVkAHPqr/hP8FJxyxTGsplJ/M2T/H5+RHrUvVpC1b+27KoWHWHb6ZyUbF+qFAx4jR14UIRM18iZjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1481
X-OriginatorOrg: intel.com
Cc: "Sun, Yi Y" <yi.y.sun@intel.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Tian, Kevin" <kevin.tian@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Will Deacon <will@kernel.org>,
 "list@263.net:IOMMU DRIVERS
 <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
 " <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wu,
 Hao" <hao.wu@intel.com>, Robin Murphy <robin.murphy@arm.com>, "Tian, Jun
 J" <jun.j.tian@intel.com>
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

Hi Vivek,

> From: Vivek Gautam <vivek.gautam@arm.com>
> Sent: Tuesday, January 12, 2021 2:50 PM
> 
> Hi Yi,
> 
> 
> On Thu, Sep 10, 2020 at 4:13 PM Liu Yi L <yi.l.liu@intel.com> wrote:
> >
> > This patch is added as instead of returning a boolean for
> DOMAIN_ATTR_NESTING,
> > iommu_domain_get_attr() should return an iommu_nesting_info handle.
> For
> > now, return an empty nesting info struct for now as true nesting is not
> > yet supported by the SMMUs.
> >
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > ---
> > v5 -> v6:
> > *) add review-by from Eric Auger.
> >
> > v4 -> v5:
> > *) address comments from Eric Auger.
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29
> +++++++++++++++++++++++++++--
> >  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 29
> +++++++++++++++++++++++++++--
> >  2 files changed, 54 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 7196207..016e2e5 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3019,6 +3019,32 @@ static struct iommu_group
> *arm_smmu_device_group(struct device *dev)
> >         return group;
> >  }
> >
> > +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> *smmu_domain,
> > +                                       void *data)
> > +{
> > +       struct iommu_nesting_info *info = (struct iommu_nesting_info
> *)data;
> > +       unsigned int size;
> > +
> > +       if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> > +               return -ENODEV;
> > +
> > +       size = sizeof(struct iommu_nesting_info);
> > +
> > +       /*
> > +        * if provided buffer size is smaller than expected, should
> > +        * return 0 and also the expected buffer size to caller.
> > +        */
> > +       if (info->argsz < size) {
> > +               info->argsz = size;
> > +               return 0;
> > +       }
> > +
> > +       /* report an empty iommu_nesting_info for now */
> > +       memset(info, 0x0, size);
> > +       info->argsz = size;
> > +       return 0;
> > +}
> > +
> >  static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >                                     enum iommu_attr attr, void *data)
> >  {
> > @@ -3028,8 +3054,7 @@ static int arm_smmu_domain_get_attr(struct
> iommu_domain *domain,
> >         case IOMMU_DOMAIN_UNMANAGED:
> >                 switch (attr) {
> >                 case DOMAIN_ATTR_NESTING:
> > -                       *(int *)data = (smmu_domain->stage ==
> ARM_SMMU_DOMAIN_NESTED);
> > -                       return 0;
> > +                       return arm_smmu_domain_nesting_info(smmu_domain,
> data);
> 
> Thanks for the patch.
> This would unnecessarily overflow 'data' for any caller that's expecting only
> an int data. Dump from one such issue that I was seeing when testing
> this change along with local kvmtool changes is pasted below [1].
> 
> I could get around with the issue by adding another (iommu_attr) -
> DOMAIN_ATTR_NESTING_INFO that returns (iommu_nesting_info).

nice to hear from you. At first, we planned to have a separate iommu_attr
for getting nesting_info. However, we considered there is no existing user
which gets DOMAIN_ATTR_NESTING, so we decided to reuse it for iommu nesting
info. Could you share me the code base you are using? If the error you
encountered is due to this change, so there should be a place which gets
DOMAIN_ATTR_NESTING.

Regards,
Yi Liu

> Thanks & regards
> Vivek
> 
> [1]--------------
> [  811.756516] vfio-pci 0000:08:00.1: vfio_ecap_init: hiding ecap
> 0x1b@0x108
> [  811.756516] Kernel panic - not syncing: stack-protector: Kernel
> stack is corrupted in: vfio_pci_open+0x644/0x648
> [  811.756516] CPU: 0 PID: 175 Comm: lkvm-cleanup-ne Not tainted
> 5.10.0-rc5-00096-gf015061e14cf #43
> [  811.756516] Call trace:
> [  811.756516]  dump_backtrace+0x0/0x1b0
> [  811.756516]  show_stack+0x18/0x68
> [  811.756516]  dump_stack+0xd8/0x134
> [  811.756516]  panic+0x174/0x33c
> [  811.756516]  __stack_chk_fail+0x3c/0x40
> [  811.756516]  vfio_pci_open+0x644/0x648
> [  811.756516]  vfio_group_fops_unl_ioctl+0x4bc/0x648
> [  811.756516]  0x0
> [  811.756516] SMP: stopping secondary CPUs
> [  811.756597] Kernel Offset: disabled
> [  811.756597] CPU features: 0x0040006,6a00aa38
> [  811.756602] Memory Limit: none
> [  811.768497] ---[ end Kernel panic - not syncing: stack-protector:
> Kernel stack is corrupted in: vfio_pci_open+0x644/0x648 ]
> -------------
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
