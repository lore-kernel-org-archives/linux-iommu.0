Return-Path: <SRS0=yhC+=F5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B59C433E0
	for <iommu@archiver.kernel.org>; Fri, 25 Dec 2020 08:24:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AC323129
	for <iommu@archiver.kernel.org>; Fri, 25 Dec 2020 08:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AC323129
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 346092011A;
	Fri, 25 Dec 2020 08:24:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JkLPoD6QbaO0; Fri, 25 Dec 2020 08:24:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2CAAC1FD16;
	Fri, 25 Dec 2020 08:24:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AA37C1825;
	Fri, 25 Dec 2020 08:24:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98C28C0893
 for <iommu@lists.linux-foundation.org>; Fri, 25 Dec 2020 08:24:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 81C44850E9
 for <iommu@lists.linux-foundation.org>; Fri, 25 Dec 2020 08:24:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LO1bAUVUKjhL for <iommu@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 08:24:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9C01E85092
 for <iommu@lists.linux-foundation.org>; Fri, 25 Dec 2020 08:24:04 +0000 (UTC)
IronPort-SDR: Iqni9LFajysdiUVncES5JWlkw0nwV1NCmMibYnwlQbWyhjM2rvYj4OY8XamBhurzVwwY2ibpTC
 c7A4clNz7M3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9845"; a="176358960"
X-IronPort-AV: E=Sophos;i="5.78,447,1599548400"; d="scan'208";a="176358960"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2020 00:23:56 -0800
IronPort-SDR: mDIR/pdjEQNHYUFGp30rCV4Tg0kJaQPdjaGtDE7D+LKKfI16COpx9d6YHoM7Y2XSOMU1noCdNr
 lFumnU2TauuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,447,1599548400"; d="scan'208";a="357696890"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga002.jf.intel.com with ESMTP; 25 Dec 2020 00:23:56 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 25 Dec 2020 00:23:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 25 Dec 2020 00:23:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 25 Dec 2020 00:23:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSU+pssSLlFqNF8eg3+pIJvtts1Yp/HlWoZReHGauGTzdMSTUZ1aXFWkjEbY9Q7pAUbmXFqptLEjbnpUMSjkC/SkakfXC28bn/EGQT0zIDYfcNdjFPalsLR5649CfqDCqXdQ35a10l3PxeKdpPVbZwHhyrPfefsTpWv9grvGZJ8CZAaYZDJm+6deSajEox2wjbJAyoaw2j/1WIN9ED4euSQ11W8oYno5Q9IF1MYftWndezy11E+2zJyg5pQU+xuSlIfqHWmPe/7EFIxaTKPwJBGTFCRdnvQzBOymC9fm8L9RBgyuYL/nn/dd1Mtziq9BX3Ks3UsqxOdU/ObVa3EH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4BdURSI3rBPJScRPQyji/V9CmIoKIk7GX0bZjdkf2s=;
 b=L+VRUPNxLH9rQE3Ngk2yQ8LcmD4nwwhqQIawVPdUjBTNTGr7YAaYGnWq18tr6nXCWWvG/qhlmLtwjE2nnfV7TurQUlm8zp5E0KLaHFam7AX0teQhKlqMdrqACliJX4DlAdkPz37l6rHCTSjHDpF+fTxB5JChZ2pxBm25SHSRWaUC3WUNbnzIWjEmAAKK9jMskQ4/nAHq9XncH32XAIhhzwSjS6V9xYbxe+TtPBSwvKoU+ybecpeUc+T+/TFPBL/xi8EcvOjWWnSJvLmf+13Iyce+5YPTI9topTt519W9X8tQZ3mSh7jtQc1mhvjQ1gELUiz9lNjKaRxoiiVAJyrpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4BdURSI3rBPJScRPQyji/V9CmIoKIk7GX0bZjdkf2s=;
 b=XKoUvXMH1f4dFWg4Rlq6W/Pq0fBk55ZXbrW1rTEq6XpX8FEolBlR2sOacMdRYz/1kJdqgQElioCFezM+M42UKee6dKPxEykkVjxW4Mw8EmT3s8TB2c8gXV4Fw8hDmYw1KQnTSN270dgTyz/VJLLOEq308EnrOVVj8TrPj69txQQ=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1692.namprd11.prod.outlook.com (2603:10b6:3:d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.27; Fri, 25 Dec 2020 08:23:52 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93%3]) with mapi id 15.20.3676.033; Fri, 25 Dec 2020
 08:23:51 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "will@kernel.org" <will@kernel.org>, "jacob.jun.pan@linux.intel.com"
 <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Thread-Topic: [PATCH v2 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Thread-Index: AQHW2PTKeeH7EpKUS0qYrKOxA9H4gqoEdZmAgAMG3UA=
Date: Fri, 25 Dec 2020 08:23:51 +0000
Message-ID: <DM5PR11MB1435370E436A7C6FA0F29614C3DC0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <20201223062720.29364-1-yi.l.liu@intel.com>
 <20201223062720.29364-4-yi.l.liu@intel.com>
 <176f7835-a5cf-e049-22b7-724636f74af0@linux.intel.com>
In-Reply-To: <176f7835-a5cf-e049-22b7-724636f74af0@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c0d6584-33e4-4d29-e906-08d8a8ae694a
x-ms-traffictypediagnostic: DM5PR11MB1692:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB16925303AB4EA2B7426025D5C3DC0@DM5PR11MB1692.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1kXYzbOOp423mAcs/9qDqFc5oGwrzzmqpWH2ji/IJGia3Px0U0mWXt7AuN/VP+b07Z2qB7w8YJRxjhL5Ix6vSYXBL6Gsbejg33Ezg4k6rwiRyQWy+ZQVakuuRYOaGPUnqDc3wJx9UUG8AFoaeofjDShBbgdgfsifluy2SadY1yfw0UzacnxJ/nqb3Pqj7K8d68ZwuhI+dgXGS6RL8tG51WJP3cCQ7lyJK6WBkWLAWrWoMczUtCOdjBii5A3c7REl0rDB7+YWC6FD3sMwwGeRIi04RqRFlclsB1tvtuP+KcLyXuccrvOIya3PxbjU7EBr2thfsu4dP5eZQal9y/a/56wK1pE1xD39A04jmcEQCr7xCc3pE5ORz5+Fhpb0uinMFjNLmZSj8VUiKGotDr3eSKdD+Dx3hjPfjAezTnDvzrfPuSqt8d9QYlcB0OGc+4+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(66446008)(64756008)(54906003)(86362001)(66476007)(7696005)(52536014)(66556008)(8676002)(186003)(6506007)(110136005)(55016002)(66946007)(53546011)(5660300002)(2906002)(8936002)(71200400001)(9686003)(316002)(33656002)(478600001)(83380400001)(76116006)(26005)(4326008)(309714004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZkVETGpnYjlwUUY1YWxnRy9WRzJ5S1ZsWjVDUjJ1eVdZQXFVV3l5ZDVMQWxL?=
 =?utf-8?B?TTlBeVgwTXVJR1pXS0tBYXVDZTVGZ3h1eUNCY3gxOU5yN0ZTYWszTUUzY1dy?=
 =?utf-8?B?V3pORGJWVzR5a3hvUENVZzFiVHpIL0ZJWU50ZThRRzhFd2kyaGV4V2oxdm5X?=
 =?utf-8?B?UDJ4NlhDOHJaRVZDU2FaOWwxb1NhUTMvQzdRRmFtNm5TeFZOTzN1cDFJWVRu?=
 =?utf-8?B?dlFETUhCeXpidHVzMmtRMmxXZWNJVS9kRTlMNU5uc2o4LzdiK2oyTGd3Nzly?=
 =?utf-8?B?VUpaU012cTcyRExsV05KOHZVSU5YaERYSWNLT0ZRdll3Q3NtaFI3UDkvV2Ix?=
 =?utf-8?B?QmRzS0wrbXk5UlF4NWt1Sm44QTIzd2pNTHZtZUc0R2k5TDlabVEzWTZna0hp?=
 =?utf-8?B?Ym8xd05zVmdEYjJwdmR4MitPVEJWVzZUbEQwNnVRYk50OTZaVlhYaVB0QnRp?=
 =?utf-8?B?U2NaMDd4UllFWVFZYWtQdWJyT0NBdHdyVWtxMWJZZUcrU2dJTVh1N1lGZStt?=
 =?utf-8?B?MWQ0U2dlQlNkLy9HTHU5ODdMdjZ0MGZFVFdoQlhuZEJEYTlTUEM4enhSaGtO?=
 =?utf-8?B?SitwYUhPdHVnVE8zN3ZKQzU3bWVMVDN5UWN2bFN2c0w1NUFDdFJoSVZ4UUtU?=
 =?utf-8?B?ZEFBN3B6OE5WRHQxUVF3WllaeUtKeXd0clRnODdOeDZrVE1tY2pkM0hqUGg3?=
 =?utf-8?B?cDdieW5BT2RDMHdLZ3k1bzBZUnVyRGt4UWM4YkdCMlVHM1UvT0RhZURlRzhr?=
 =?utf-8?B?ZnhRaG9OS2FZM1hFem5CVEtHK0JXYXBvaHRzR3lHZ0taZmwxbEJqU3d0V3N2?=
 =?utf-8?B?cnNkRE9XdGQ2dUlEb3I1eHR0UHVWUG5nTmlPK2FjVkNMck5Nak1YU2J0U3Yr?=
 =?utf-8?B?U3d5Yy84SHhwVThuVFluRjl1ejVVT0pUdUVTK1BmMHJCZjdSNFJTd1NUY3ZM?=
 =?utf-8?B?MTBPYWVUOU9VSHBlc2JORkZBRGZ6YllXQ09lQzlBdHJhanI3aDIwWDRQNE1B?=
 =?utf-8?B?MERlNVBPZHhHNGpGMllwdFZuQm4rV1FKdk1BL1BOb2EvRXVORk00eXM2WFlq?=
 =?utf-8?B?QlBGSDVnNUgwYUN4ZDdyTGxoOC9MU01hQXZrTGtwWDFxRnBJbkpSOUlqSmRm?=
 =?utf-8?B?S2tXdnlpc3Ixak9kdmpma1hYU25VQm9YMVJNeUh0NG1tVnZZajJxUFV3cjZV?=
 =?utf-8?B?TmtzL1gwckdPYUxNd3R4NU1MclJuejNmMXNUdS80UGE1RTUyZ3dmaGZGWlBJ?=
 =?utf-8?B?SExmZm5sdW00Vlc0ckdoM0pINDIyMnVGSmtzMFNFZW5OWE1WSXJPRmI5VEZC?=
 =?utf-8?Q?xChnGMGy2RNu0=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0d6584-33e4-4d29-e906-08d8a8ae694a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2020 08:23:51.3839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqmeJZhevu7Ev3udozEGkDKi4ODRcisyRlcmwPVgJnULJ7PkidoO26Zlmynz5DOGczpRCzhUKIi+EOTp05Yilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1692
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

Well received, all comments accepted. thanks.

Regards,
Yi Liu

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, December 23, 2020 6:10 PM
> 
> Hi Yi,
> 
> On 2020/12/23 14:27, Liu Yi L wrote:
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
> >   drivers/iommu/intel/iommu.c | 63 +++++++++++++++++++++++++++---------
> -
> >   1 file changed, 47 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index acfe0a5b955e..e97c5ac1d7fc 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -726,6 +726,8 @@ static int domain_update_device_node(struct
> dmar_domain *domain)
> >   	return nid;
> >   }
> >
> > +static void domain_update_iotlb(struct dmar_domain *domain);
> > +
> >   /* Some capabilities may be different across iommus */
> >   static void domain_update_iommu_cap(struct dmar_domain *domain)
> >   {
> > @@ -739,6 +741,8 @@ static void domain_update_iommu_cap(struct
> dmar_domain *domain)
> >   	 */
> >   	if (domain->nid == NUMA_NO_NODE)
> >   		domain->nid = domain_update_device_node(domain);
> > +
> > +	domain_update_iotlb(domain);
> >   }
> >
> >   struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
> u8 bus,
> > @@ -1459,6 +1463,18 @@ iommu_support_dev_iotlb (struct dmar_domain
> *domain, struct intel_iommu *iommu,
> >   	return NULL;
> >   }
> >
> > +static bool dev_iotlb_enabled(struct device_domain_info *info)
> > +{
> > +	struct pci_dev *pdev;
> > +
> > +	if (!info->dev || !dev_is_pci(info->dev))
> > +		return false;
> > +
> > +	pdev = to_pci_dev(info->dev);
> > +
> > +	return !!pdev->ats_enabled;
> > +}
> 
> I know this is just separated from below function. But isn't "(info &&
> info->ats_enabled)" is enough?
> 
> > +
> >   static void domain_update_iotlb(struct dmar_domain *domain)
> >   {
> >   	struct device_domain_info *info;
> > @@ -1466,17 +1482,20 @@ static void domain_update_iotlb(struct
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
> > +		if (dev_iotlb_enabled(info)) {
> >   			has_iotlb_device = true;
> >   			break;
> >   		}
> > +
> > +	if (!has_iotlb_device) {
> > +		struct subdev_domain_info *sinfo;
> > +
> > +		list_for_each_entry(sinfo, &domain->subdevices, link_domain)
> > +			if (dev_iotlb_enabled(get_domain_info(sinfo->pdev)))
> {
> 
> Please make the code easier for reading by:
> 
> 			info = get_domain_info(sinfo->pdev);
> 			if (dev_iotlb_enabled(info))
> 				....
> 
> Best regards,
> baolu
> 
> > +				has_iotlb_device = true;
> > +				break;
> > +			}
> >   	}
> >
> >   	domain->has_iotlb_device = has_iotlb_device;
> > @@ -1557,25 +1576,37 @@ static void iommu_disable_dev_iotlb(struct
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
> >   	spin_unlock_irqrestore(&device_domain_lock, flags);
> >   }
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
