Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CD6C47083
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 06:37:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381B961412
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 06:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381B961412
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F362D406A6;
	Fri,  4 Jun 2021 06:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N1Y-rRnlnO8K; Fri,  4 Jun 2021 06:37:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95CC840691;
	Fri,  4 Jun 2021 06:37:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D687C000D;
	Fri,  4 Jun 2021 06:37:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC044C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 06:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE7794271E
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 06:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F-jlB4hwcTIU for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 06:37:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 266B1406B7
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 06:37:42 +0000 (UTC)
IronPort-SDR: seEeFENfiX9aGMs6io3SzAjBueILbw3ja7g18iTqgZ+dAkqM/gFVKIzUknmgG0MkJaOiAemF1X
 xGuWvU+GOAFQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="225547175"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; d="scan'208";a="225547175"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 23:37:36 -0700
IronPort-SDR: K4K7ffd8ru6cXSAck/Qq+3xBfZwhSpQP+7Q9j6nZBTEBvzBoVEPZUpvjpzIWVPfN3c1EzRpDmr
 YiiAf9zgOsDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; d="scan'208";a="412267853"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga007.fm.intel.com with ESMTP; 03 Jun 2021 23:37:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 3 Jun 2021 23:37:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 3 Jun 2021 23:37:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 3 Jun 2021 23:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPFRYOk4dWwil5CI9eZq73XVZoZmlYXHOtND72V6krjhbdSGsNhzh2Hp9sPTNcOx14ClSi/7Nll7DaZd3i/4kUVYEX20UyhKzSaqJWdi3iiQyqPkUNn+1csUS+3Gszfkfnk3YsdXMwIbzYno7HQrq6XGnSCA7GVApIz1BLMJrRFCP7CbZcD/YfgPKzqXPq1dM4okdmusWA/14wXF/wQ43B+pY4SHVJf/6L/BC9nQZzQwfNb/E5swgYuqN4dEV3EKcePjhYByvvddMgBS5bJ2xhgF0r2eUMwJ5IO98soULkTqXUGGwXQgxpZd5ZXlZ526ej+tAVoMv19Euzduf8+kPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LUnFiLYRjI2l98AohK80DGsyE8QwDshQKuw2EDOnAQ=;
 b=i5ilk0XEdfOjROyq2S8+ULVXz6OlORis5rtHJ/2IizjIs8e1kySTd/9xImV6G/zjuNpwM+AKmCnIWq0Mv4HLnlAzq4e36ZtV6g1dqunRLdFJUwySLMldQ8pMyQiluQud+cezRHrxgYSMSpkf3v4W/vQtygU3MmBo7MtxwRj/waVz6hSCfEMeA1DLJLyEd3bYaV2wi3lIZbCZ1ghDTF/sSbq//SNHf6H4651CsblDihQROMNwGxpe+cjAvK9NpPelwgnO1/uSBrn3rEwFbCC/PT8BsU+eUbDHE+OTUH6DG7f7Qyv5QiCboM5SBeFmuBoSLBv3eMQtj9YnLJ23y2PoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LUnFiLYRjI2l98AohK80DGsyE8QwDshQKuw2EDOnAQ=;
 b=Xgf3gMDgPK5pnbsUfw8j9Ye+qYxzcEGHcbPvtIqr74nmD0XV1Y/E7Jm18SRzik+pmG2jTnEWyldBJgA/EEddS9IFElK0AErTfml7M1cSH0yk6dfqMou4ahyLeNQD4QZULfGMCWgjvmb1Hzp3hYkVQ7r9C/EJ085ufbhJsomuKGI=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 06:37:26 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4195.023; Fri, 4 Jun 2021
 06:37:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC] /dev/ioasid uAPI proposal
Thread-Topic: [RFC] /dev/ioasid uAPI proposal
Thread-Index: AddSzQ970oLnVHLeQca/ysPD8zMJZwBTUTCAAQiuDaAADwOFgAAkifcg
Date: Fri, 4 Jun 2021 06:37:26 +0000
Message-ID: <MWHPR11MB1886B04D5A3D212B5623EB978C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <MWHPR11MB188621A9D1181A414D5491198C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603130519.GY1002214@nvidia.com>
In-Reply-To: <20210603130519.GY1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 103b58db-29c8-4687-31e5-08d9272337f8
x-ms-traffictypediagnostic: MW3PR11MB4588:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4588EC98E99F006687639F748C3B9@MW3PR11MB4588.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjIZcZ/yj1EDobFKpcMY83Fiv8N6MCF5yG7dnvuu5xdYixFWrPy1VwqkTL3uFB9AqcS0loRSJuSYMD1ppSma+0jN/Hi12fgNQ/Kkooj4/BCja3c09Aony/XKbvBYK0OCkdopRhUih/KAbvtJjsUPQDFBpG+RoJsvHwIDZeDuf3yl0S3NzbZ69CjEuYNcLmYMzEDewH0L78UaLQcbZBZyjuKqLolWBQqCTKZ/hnbb2dUxRdNsZoa9rconu5c+hCRRObtIR19Vy2rTd65f/mvPj2wFOv6JsocYEM3CkV022+oNafRw++2QqMSu2DjYD3XXrXgosdpUrS9RAJZgmuNcRHj46oMT4hBDSuKQuspF+kuubFTvBSLP7ySPtDd1UW75l9C34IOvozm7dcQQCXIj0I5SwuKA9UZxMvsHnT9IGN3rTO1Z8RBXH5Iyri1YQBTp6TMQZiMpHMSjZmrhQ+kGA+StVs3Oqa6nEIPeW38KJI1peSpUjcIFAIg4LvHBAU+cnrSAhYvWkpgHmtLC64zom9Vbq06P1S/V2TDCy4U2OubQwavbl9B58Vb3bYm+izeZzMwZmXmeHrP2JX2oX0NxEHHhJo7mfQdTF2LV1lbFYP0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(2906002)(478600001)(8676002)(6506007)(8936002)(26005)(186003)(76116006)(66946007)(66446008)(6916009)(55016002)(71200400001)(64756008)(9686003)(4326008)(5660300002)(66476007)(7416002)(52536014)(7696005)(66556008)(86362001)(54906003)(316002)(83380400001)(33656002)(38100700002)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?F5G3CL5shEPIj0plnU/4BJULjyoJEWDMo6IKLsWvN+BKxv3jnoU4hLs3Dp2m?=
 =?us-ascii?Q?aUR+XUopWYohh3+R49MQ1MyMxklCRu91FLPcbwGqBcz8gEQrqY8R1qPlDJiE?=
 =?us-ascii?Q?CtWujEB1wC9UbIsTGuzj9kyKWxM5J14b9yndXTUiTS9GJNKqPlseCwpwcee6?=
 =?us-ascii?Q?BILxGKurPOyxQ48I8ZJRDzcRsdIYqR6Chh46q8+t1NCh2A/WnWa6znI2D56v?=
 =?us-ascii?Q?+HlWZxyMKC3ubdOrQZ1WQaBNZJoFoFsECthN4s7bdUp5dcMFz3BuoHbCZzuD?=
 =?us-ascii?Q?ISEN4jcnkSul1/E8JsypX/U6NR/DdZ6oKRY4gjE40kqaGIWM7hdP0DkzeFwp?=
 =?us-ascii?Q?ctOReaRevw+3UCUGZRylLZ/ut7U3KtPD415JjRky056pXHJu/gqmpA0Pua0i?=
 =?us-ascii?Q?a1TrJWW08C1ZqtcnqfQu0vLxcvPOb2wZJXClGoPP2SVFhkJU43K57Z0OT2Wt?=
 =?us-ascii?Q?KH0MukyAuXmaoFet1HY+P5T4lKYR/nSar9TnQ6AsDTta4bFZbU9py/P1achO?=
 =?us-ascii?Q?zW9sBAkIMK3690LbiRhiWsutPjWut+0uOsyLgiiKjCDYzeV0jIYGFW+2pmtk?=
 =?us-ascii?Q?m40S9CXx+Py5gmholzaDyFlAua3PXub0fBB7HZlGu7P2LfrvGW3g2wJDDPr9?=
 =?us-ascii?Q?38nQtm/5HWWVN7Vz7hSHJMsA0JMKdEW3WpuryvgQiU64o7avFAZLLpiXYQIb?=
 =?us-ascii?Q?XmrsY+W1vkLvkNwoPW7FgvtYj9MvsKMrBj1ALSSd3uU1lIfbCKXXhjmas6tH?=
 =?us-ascii?Q?M/UQMi/yh7i9rCa9B7VAeFhWRnKzcoWD4V3EKMWMSJPWOQ/CF2Bm3SuzSa+a?=
 =?us-ascii?Q?OFDhzlCuN6QfPBu5GDQ9y87axL/hNQmVIJtuldcmav/5gfnP3QUwaYTfe/IT?=
 =?us-ascii?Q?MVVaWjW8Wyrh0dyhcu3hF7wiOOFIcW5RbrzpruZtlrBW3qjTKc7yxIkfVADv?=
 =?us-ascii?Q?le8g+wcDw/LqRsSNinOSbWykIwACD+6JlUBKJhzds7FnMwEVghIV+cAcB4kH?=
 =?us-ascii?Q?QNzmI0UK3MyyvY7qnltiPiK66mjBq5nvoFmPQyJTOzKwFf1YZLOnikSqY4mt?=
 =?us-ascii?Q?P4GKx01/mBtpqgg6JK0R+gLg8tckb5YAH5d92y5Q9DRZtXDxyZFZUCz2rUeP?=
 =?us-ascii?Q?ALKaFHqAlMKQloRd8AE51v8bRN2DzBLn5c6bFo0ZS/SUccdBkhECA3nrVet5?=
 =?us-ascii?Q?AhKG+lOCd2OWIPjqg4HF+404S+w9wjf1+UBV+YFqWeZicrAQaKbu7vcY/XfU?=
 =?us-ascii?Q?qOLSn6B7aNrdJ7lKHUVU6ZwCwjuc1ccM+ttlSQKSxGEO91i9MyNh1jAnXPrl?=
 =?us-ascii?Q?huQJT0iAEnyDgEhWA65WWTY+?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103b58db-29c8-4687-31e5-08d9272337f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 06:37:26.4617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XM68XrJ11yzrowLnJ/KwzocbWAf/eDbfx8eygonzjmrzQ6pvd8mS/0ZTDfL7b79YS9s5Q/aO2cVSeksn/3dCbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, David
 Gibson <david@gibson.dropbear.id.au>
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

> From: Jason Gunthorpe
> Sent: Thursday, June 3, 2021 9:05 PM
> 
> > >
> > > 3) Device accepts any PASIDs from the guest. No
> > >    vPASID/pPASID translation is possible. (classic vfio_pci)
> > > 4) Device accepts any PASID from the guest and has an
> > >    internal vPASID/pPASID translation (enhanced vfio_pci)
> >
> > what is enhanced vfio_pci? In my writing this is for mdev
> > which doesn't support ENQCMD
> 
> This is a vfio_pci that mediates some element of the device interface
> to communicate the vPASID/pPASID table to the device, using Max's
> series for vfio_pci drivers to inject itself into VFIO.
> 
> For instance a device might send a message through the PF that the VF
> has a certain vPASID/pPASID translation table. This would be useful
> for devices that cannot use ENQCMD but still want to support migration
> and thus need vPASID.

I still don't quite get. If it's a PCI device why is PASID translation required?
Just delegate the per-RID PASID space to user as type-3 then migrating the 
vPASID space is just straightforward. 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
