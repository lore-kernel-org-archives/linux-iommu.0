Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3E5C433E0
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 05:50:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FF022838
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 05:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FF022838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2FC5E867E3;
	Tue,  5 Jan 2021 05:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ab-Vl-yPFs6U; Tue,  5 Jan 2021 05:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 75CF3864F5;
	Tue,  5 Jan 2021 05:50:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67D73C088B;
	Tue,  5 Jan 2021 05:50:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2B99C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 05:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E6206867E3
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 05:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id maT17Ncv9B+G for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 05:50:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CBC46864F5
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 05:50:34 +0000 (UTC)
IronPort-SDR: CmDD0CGJJR3qhiwbZ5nuhGXdQsxRnZza4D0PNa6pGGuvIc4zYJNoq0ztKjR3MxrztfVWJaVkrX
 kgJUiN09tdng==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="164758465"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; d="scan'208";a="164758465"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2021 21:50:33 -0800
IronPort-SDR: /8bCxFx/XldcHSmU1EmN1Pu46B0dJq2JapnEgT08snDTWPp3BfRe7KOTFpyIUJU9s5toosEFhV
 k7DXRUoP9mcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; d="scan'208";a="361041813"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by orsmga002.jf.intel.com with ESMTP; 04 Jan 2021 21:50:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 21:50:33 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 21:50:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Jan 2021 21:50:32 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 4 Jan 2021 21:50:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntJuIk/GUA6FrNSZjVY4+uSrM1PrWobYGP9SZwSx9YqVnmai+B3X0MhUhpGdTqEh62DTkRMj8X7XvKoXhb0HauSttvwiHL9wuvjiqac1gGD/CdSttsTIZEJCs4Cg2Pr8FPfLp0AU5xNeXC/Odvc/ylDdeh7ATLvXW/DJT7efBGcyXgJpNqHf7YMqQpoG4WWjJ32VQc80YMC6cMK2bM1BEYQWNZEqfMiHU9dLaFJsYjK42OFzRyno0zN4uCP8zd0Wt6OLbEJvRPoLJ0aipLYOKe/UO1C41KV2F7OHHz21mUmiOieEIUDj6SJU79ZPfDNBcpmweT8fE1sAfGEU2+ITww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mouPT8yTrGRenUZkLP66MA7kWaIshXJwoDrDE2rrok=;
 b=frrqm7nCmJ4UhtGf1i5v99z1Cw31PHq1cDmvyQoaYgVOvtqwJmd0nPs2cMv9fprPYsbdwxrfo6j551mG1INDbNOoyqr8DpdiNOK+wyVENY4tKlIJeLHI08rD1kRFkLRe9UBSrGDENsdrckL2yXeTfxuk2xC2i+1TvSIYEKEHsweySOeGwYIKVYwUSAhxZSBURqGmbzwENU/pOGWnHKFbx/iCJ7iqXpA+X2iMEopIgaHuA1ZtqII2DiNvlGS3msmum1Sa96kv8d816fMV75I7cO4mf7Kh5Lc8CNerpO/ohUwN5Q7fIENARoohg8aWL/iMizt8fPYe3uDpxmtDFp3Rgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mouPT8yTrGRenUZkLP66MA7kWaIshXJwoDrDE2rrok=;
 b=mqvFW/W5Tk8hI+3JHc1T29NRkfaBXKwO0zyZDib9AJ/10/Oisd/Nqdd+JU0EVm6MfRioUY7LJq8sB/7n7N2b9oXKU9xFOQST6g/kd5GMJ+RRc3soQ55M2TvRjZuiHbJe7zG8GNZgnOe0NbntFp1AT/cZNC6Dwnm6RG8ddN1ThCw=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB2538.namprd11.prod.outlook.com (2603:10b6:5:be::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.21; Tue, 5 Jan 2021 05:50:22 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93%3]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 05:50:22 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v3 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Thread-Topic: [PATCH v3 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Thread-Index: AQHW3ZLDHAgDEwjOUE+qCmcDR/T80qoNwakAgArQO+A=
Date: Tue, 5 Jan 2021 05:50:22 +0000
Message-ID: <DM5PR11MB1435E814408F19A947263C07C3D10@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <20201229032513.486395-1-yi.l.liu@intel.com>
 <20201229032513.486395-4-yi.l.liu@intel.com>
 <c109eb64-2805-5e87-2283-b52c5704a31f@linux.intel.com>
In-Reply-To: <c109eb64-2805-5e87-2283-b52c5704a31f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19eb9c1e-3537-40fc-5d68-08d8b13dca80
x-ms-traffictypediagnostic: DM6PR11MB2538:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2538896C6130DD2DACF484D8C3D10@DM6PR11MB2538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 522FIpoumCKcuxMetgPKCCTyBF7pvZZrHYO/Rs0txuA1P0uXYGnf2I1bv7Uwj69c6HJGD7H1s3RKKrn5CYa2vGGv/P1A2GOCy3QnrlhilNj2oH8evyWcRmouRpx6saazSe4Qf7nAq3y5xFCkKCsDRYUaZN1CnlHKW+bZCiYOHE27XqPOW41ydXGS5W2GdL9giaymXprgYjiqIEi+FRTKNdHR7l/RAdLt7Yx7xa3gKTXYKx6jweAPbfPHJRwcsCoEkqNBxTo3/e/hz4gyC+XstEvezVFEz0KOx7OCOg14dZ6svYLw8QikKH26rvCrLuEiOoDLdptHivR2mTpG2ozU3rn/bqgdLlHqrwDusciNg4Ho5d1dVmCrZSqPob7r1POlIJqoZa7FdpblLHr/PAG/Xw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(110136005)(316002)(83380400001)(54906003)(33656002)(8676002)(478600001)(186003)(55016002)(71200400001)(76116006)(53546011)(6506007)(66946007)(26005)(7696005)(86362001)(4326008)(9686003)(66476007)(52536014)(2906002)(66446008)(8936002)(64756008)(5660300002)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VHdXcWphS1lLSFpZMmtBUVJPK28zanp4Q2piQmU4aFhyNW02UStoVldEbGJM?=
 =?utf-8?B?c1MzTmxKUVd1QVJtRVdydHJGOEJoMlJLdVgrclZ3SmJBeFR1R3VsNkp5YXps?=
 =?utf-8?B?OVVCM1dHKzdpWmQ3TDBPelUxWTZnYnR5VWhpMlYxeXBWTUVmL3crNGVUeVFy?=
 =?utf-8?B?RUxmMEorMTdZSys0THRTWlZtQjE2VnVQMDZ3YmVxTGNQZ2tXNkdXYlFZMHlO?=
 =?utf-8?B?VHJXK2hnRHVkcW1EVmE5Uk1qbzVxcHc0Z3ZnZHRrWDBrUjBSMkN1MGtsZ0t4?=
 =?utf-8?B?dlJjNkN6NFBVR2dlN2hGNDRqbi9zTnhWei92QzViTmpZYXBVR1MyYVVTdy8z?=
 =?utf-8?B?VXBHWWE1c0ZCVDU5d09ic2RwN0syRDlCR0hMU2RzVU9SS0VWMHFnd05SVXdY?=
 =?utf-8?B?QTAvYWs2ZURqRFhhYjVCWWllM09uQk5QdGp1OFJLRzM1bXdkanhMQ3YyTjNy?=
 =?utf-8?B?Tk1jQkNLajNBWDhaRGpvTndBZ2J5ekNkM3RYSTNubEdlMWZvcW15WnhueVFy?=
 =?utf-8?B?RFI1ZUlDNlZLTmpuS0ZtUUFiS29HbFhjbXl0NFZYY2t2dVA0d0tJMG5sZE9z?=
 =?utf-8?B?L1Y1N20rVFNtMTlJUERvL1pMb3BoNlhxUHkxeHZ1SmJMV2o4cFk5aXJJQ09Y?=
 =?utf-8?B?Mmt1NFBnWXkrV1pRY0kwMWlGTGNpeFJ1OWZYT2FQUUtsNGczS0xVd1c4MU1N?=
 =?utf-8?B?NWxqTkRpL1BoQ1I0MDdkWkJVdER6bFYrSGNha3pZYzZFeEtjcG1yYW5wanlo?=
 =?utf-8?B?SnJWNWZTcXV3UC9RT2Q5eFpodmVxOXl5ZDNlMXF3ZXg4dXpxWUV0U0YrVTBx?=
 =?utf-8?B?Z2pFcS9PL3A5YjdpYXJhU0JKZjJwbW9IUXhCNHFYOElqcjU4czdZMzNwcFBa?=
 =?utf-8?B?OHF5R3Vock5hY09lbjhXVHlHcU4rTVVUSHg1dVRaVEZlOFY0WFloMGNza09U?=
 =?utf-8?B?b0c1Nnh6SHdtcnFkV2w4YnRHZ1BFQVdOK3kyaGE2dStBcWlPM3FEUnJGNWNJ?=
 =?utf-8?B?bzZsOXVwd2NldXhxakVpV2JzZWU0a2diTkk2MEczdGxqRm9jN0NCSUt6WHZP?=
 =?utf-8?B?cG1scmlzZExSTmExRGpoaCtkUmQreG02dkxyV0ZkSWZQaUdBRXFxL09HSDdJ?=
 =?utf-8?B?UmYwbXlFZWZxNG1YQUZtL21RL2hrN2dyaHIrbUthT0xVNm0vNnhvMHQ5RlFE?=
 =?utf-8?B?dFNEdzNYbGJPQ2wvdVFITFJMNWtVZEdtdVFqN2tuZlhpbnhMUUFZeFFoWkNi?=
 =?utf-8?B?RUh1K2ZxemttZVo5Z1I1Ym4xejY2ZjQxenpUWm1TODBvVUtCc01HR1o5NG8v?=
 =?utf-8?Q?F/wZXPo+iOi8U=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19eb9c1e-3537-40fc-5d68-08d8b13dca80
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 05:50:22.0227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7Agvkc3ZD8aa1AfimB20/v6Rt/ZNu0FbTA02SNGsr3wSY7JR7XGDxv7gH4nw8Dq9rQI6UAkp6HToTYUUEHC+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2538
X-OriginatorOrg: intel.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>
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

Hi Baolu,

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, December 29, 2020 4:42 PM
> 
> Hi Yi,
> 
> On 2020/12/29 11:25, Liu Yi L wrote:
> > iommu_flush_dev_iotlb() is called to invalidate caches on device. It only
> > loops the devices which are full-attached to the domain. For sub-devices,
> > this is ineffective. This results in invalid caching entries left on the
> > device. Fix it by adding loop for subdevices as well. Also, the domain->
> > has_iotlb_device needs to be updated when attaching to subdevices.
> >
> > Fixes: 67b8e02b5e761 ("iommu/vt-d: Aux-domain specific domain
> attach/detach")
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++---------
> --
> >   1 file changed, 37 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index d7720a836268..d48a60b61ba6 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -719,6 +719,8 @@ static int domain_update_device_node(struct
> dmar_domain *domain)
> >   	return nid;
> >   }
> >
> > +static void domain_update_iotlb(struct dmar_domain *domain);
> > +
> >   /* Some capabilities may be different across iommus */
> >   static void domain_update_iommu_cap(struct dmar_domain *domain)
> >   {
> > @@ -744,6 +746,8 @@ static void domain_update_iommu_cap(struct
> dmar_domain *domain)
> >   		domain->domain.geometry.aperture_end =
> __DOMAIN_MAX_ADDR(domain->gaw - 1);
> >   	else
> >   		domain->domain.geometry.aperture_end =
> __DOMAIN_MAX_ADDR(domain->gaw);
> > +
> > +	domain_update_iotlb(domain);
> >   }
> >
> >   struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
> u8 bus,
> > @@ -1464,17 +1468,22 @@ static void domain_update_iotlb(struct
> dmar_domain *domain)
> >
> >   	assert_spin_locked(&device_domain_lock);
> >
> > -	list_for_each_entry(info, &domain->devices, link) {
> > -		struct pci_dev *pdev;
> > -
> > -		if (!info->dev || !dev_is_pci(info->dev))
> > -			continue;
> > -
> > -		pdev = to_pci_dev(info->dev);
> > -		if (pdev->ats_enabled) {
> > +	list_for_each_entry(info, &domain->devices, link)
> > +		if (info && info->ats_enabled) {
> >   			has_iotlb_device = true;
> >   			break;
> >   		}
> > +
> > +	if (!has_iotlb_device) {
> > +		struct subdev_domain_info *sinfo;
> > +
> > +		list_for_each_entry(sinfo, &domain->subdevices,
> link_domain) {
> > +			info = get_domain_info(sinfo->pdev);
> > +			if (info && info->ats_enabled) {
> > +				has_iotlb_device = true;
> > +				break;
> > +			}
> > +		}
> >   	}
> >
> >   	domain->has_iotlb_device = has_iotlb_device;
> > @@ -1555,25 +1564,37 @@ static void iommu_disable_dev_iotlb(struct
> device_domain_info *info)
> >   #endif
> >   }
> >
> > +static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
> > +				    u64 addr, unsigned int mask)
> > +{
> > +	u16 sid, qdep;
> > +
> > +	if (!info || !info->ats_enabled)
> > +		return;
> > +
> > +	sid = info->bus << 8 | info->devfn;
> > +	qdep = info->ats_qdep;
> > +	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> > +			   qdep, addr, mask);
> > +}
> > +
> >   static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
> >   				  u64 addr, unsigned mask)
> >   {
> > -	u16 sid, qdep;
> >   	unsigned long flags;
> >   	struct device_domain_info *info;
> > +	struct subdev_domain_info *sinfo;
> >
> >   	if (!domain->has_iotlb_device)
> >   		return;
> >
> >   	spin_lock_irqsave(&device_domain_lock, flags);
> > -	list_for_each_entry(info, &domain->devices, link) {
> > -		if (!info->ats_enabled)
> > -			continue;
> > +	list_for_each_entry(info, &domain->devices, link)
> > +		__iommu_flush_dev_iotlb(info, addr, mask);
> >
> > -		sid = info->bus << 8 | info->devfn;
> > -		qdep = info->ats_qdep;
> > -		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> > -				qdep, addr, mask);
> > +	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> > +		__iommu_flush_dev_iotlb(get_domain_info(sinfo->pdev),
> > +					addr, mask);
> >   	}
> 
> Nit:
> 	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> 		info = get_domain_info(sinfo->pdev);
> 		__iommu_flush_dev_iotlb(info, addr, mask);
> 	}

you are right. this should be better.

> Others look good to me.
>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Best regards,
> baolu

Regards,
Yi Liu

> >   	spin_unlock_irqrestore(&device_domain_lock, flags);
> >   }
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
