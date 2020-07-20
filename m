Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B2C433E4
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 08:49:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF512176B
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 08:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="rzsbNZv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF512176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B24202107F;
	Mon, 20 Jul 2020 08:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PpikBEBnWCmV; Mon, 20 Jul 2020 08:49:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 86462204A1;
	Mon, 20 Jul 2020 08:49:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A722C0894;
	Mon, 20 Jul 2020 08:49:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79F86C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5E3CA87476
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:49:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LgfPkjaIM7XA for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 08:49:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A02A587079
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:49:44 +0000 (UTC)
IronPort-SDR: qK2Kh2FKcNoSGFWLNcNYibYp7C7XM49D23zuWvWojhR0bhklFZht91B0rAbO42M2kf2Y0b7s5B
 zGHQ6OjjUi+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="147829461"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="147829461"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 01:49:44 -0700
IronPort-SDR: QwyUGhNCYdX+MS2siVseSF0tGrX/6CimmdHwrNsGaAISalp1Oec31JSd/g+lc1llM0G4i5wSkK
 HHyAN6ZGn7Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="283447570"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga003.jf.intel.com with ESMTP; 20 Jul 2020 01:49:43 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 01:49:43 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 01:49:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 20 Jul 2020 01:49:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaXtC8L02dAPJVHLRDTeKJl4+6iHnp1vjMwpuNRGQWUwPUNMmnCT/ZbGp8xgT1VxnevaZOgejHVdeOoMpqRC59RI8wxO63Ef/D9FwQaZLLdCHYAZyj4AxuHbkqUhpA6y31KZwTiVK3jBqITECC6tJh8MAoKJOcq2xHL78n/F7Q82PhtlNxvc6xehqMIMFLpaq0C7Y7vrr3uqrwFfpDoNm+m+9qoBka+/6eeTf2YUmMxOPUfRCUs3Nn0bLXtty958GXP8UIQy/it1dZQA54q1/aV6PGLOJ9ZWllFm93/Dj7ZjOhyppAFhE1+L1tVoL+vES6AQA6KfYl0xhbU79T4pRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHT2dLXi2ZzhTQlZZY1lk6EKaBTXriZPYrCPG/baqVw=;
 b=d5Tr/zNju/7O3MzbgR2nNfX5fJmsZo4qJoEEUz02nbfh4bbHGq9IL9+CvpHRO7eyDKzhE/lO0mxywo5TBxOglJFLKBasT3XPnYbVTCHeCSF7Y0SQKju9SfkcPFVjsw1T+zJHmvu0/4fCL/eJx8Ul+FNsBW8fhQ3a60x15c0wX/+6MN4pfDyzoDCvz7JkI/470TTmQyGvlyPuLwXkiAsxrBOEB66hLmww55AtDXr7AnlpOmlUhiZHBhYyhZvMXDEFUJuWvLSjzkxh4MLyNc3kTZ7Kl6CclAsCbYw/EmJdCpm5NOGr2RkH6chqVAv1//WU+Vrf+d8PFnrnx3C5UQ0TAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHT2dLXi2ZzhTQlZZY1lk6EKaBTXriZPYrCPG/baqVw=;
 b=rzsbNZv6MnQeKTIZWkBYY2JjeSrkZW7MDj0fZ+li0OCmjcoZ+LjlYgELBpNBY4RBolG4V1tr3/Rt1xQtopXH8SckygjLcdcLknaZEIYT8hrusmsbgwz9kzSvx2Csrx9u7zLrspf05J5Xo17lT5T5BqKmYeBqFZ7weFkPOWp6JEE=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1996.namprd11.prod.outlook.com (2603:10b6:3:13::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.25; Mon, 20 Jul 2020 08:49:41 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 08:49:41 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 05/15] vfio: Add PASID allocation/free support
Thread-Topic: [PATCH v5 05/15] vfio: Add PASID allocation/free support
Thread-Index: AQHWWD2nUFc6pY9OvEK1LW9mFCFZBqkPFNcAgAEQv2CAAAi6AIAAAP+g
Date: Mon, 20 Jul 2020 08:49:41 +0000
Message-ID: <DM5PR11MB14353C2D9929384A45E8B285C37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-6-git-send-email-yi.l.liu@intel.com>
 <7ce733ec-e27a-0a80-f78c-eeeb41a4ecf0@redhat.com>
 <DM5PR11MB14351019ED0DEE3E27A98D70C37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <7d982308-f39c-ab5f-2318-a36600284402@redhat.com>
In-Reply-To: <7d982308-f39c-ab5f-2318-a36600284402@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 602bb015-400a-47ce-2307-08d82c89d7e2
x-ms-traffictypediagnostic: DM5PR11MB1996:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB199674F08CCE1A2EDA6794E1C37B0@DM5PR11MB1996.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jZQfR2xXigA8ytw/3V4+W9VnGpmrsiSlyRp95shXQ/oUVe4zKHVfuHeeHNihng2a9OqXHXjXL3wgEsuMSNdivN78BMslPk779HcKsnAx0J3Yhzp/+RbLj7sek+5KYIaVJAvFwtVmfugvfqmTg/uNYpcuSwlGm/mRIhUGGbVmMDBSPhxLdz/vECkMHTxb0NjPLakapnJud+GdUEuK8a1mExSMXiVXI7lBksq5BpWe47hgszw0AC1IFH83fUHYDZ5JWZhyEaEZCRA8c53zJRxU2B8qpnDYs3zxc5Iv2kcflqJLAc3k2SqEabGONzpt311jqggZ2qY/jMtq9M0Dh7INhruXhWKPbxXjLXE+rVWKYTPn4zzxKm1HMfGJuREJscHgy5OumuzFAykguGceqkBbYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(9686003)(186003)(26005)(316002)(7696005)(55016002)(83380400001)(33656002)(6506007)(4326008)(64756008)(8676002)(2906002)(52536014)(8936002)(110136005)(54906003)(71200400001)(5660300002)(966005)(86362001)(76116006)(66446008)(66946007)(7416002)(66476007)(478600001)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: LXNhQlcQyOJ9IaAO0Zfw8vqob7Qk0p9FPFqpMI5udkCXMJy+Au9MeY6v+XvxUfRNKCkDwmNXrZ7GtF6eOWKnlLhOLd460qzi/13P3eDCPWw9qEziXxYK76mSOIPdEKypZDkgooPLWeLo0Uddfnl9NDVhuvCumvpVzf3WcH6+TOlcEn9KuSrzsbd8S5Mhw/aiIvBU8zgYEUAjeCVmIj8mPuI1eb23Nvo4YijVkrYbiFWshjwrTjqfh0A9F36aaG0AWTumQ++Z2j+eR/2tQpT4fNHS9cSq82zL0kFB8BQGgK0ovzSAx4egHXSphOu8X4wC2OSF2q2wFRW+6zZoAQU5qVfiiXWPds/oV+c61oxi1AVXLm90pfWtIiRPfNtYwNHh/kvOYNLCgioBkmLdIuIbyVodM1xHPLdgSGm/NEpNyl8yVYGYtksLVtUJAk1dcvJ+TvgPY5zGl1/4veKJMVy45E4pqQSFeWcWpItMbxI74mVNGpX/F5lvhRii54YtRYur
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602bb015-400a-47ce-2307-08d82c89d7e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:49:41.5129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AxzM/Vl8Rvr/xo0PzBqfqrrU1OMnniRHPbY5MqwDjcgjfc7ubWxCD4bCGxn88i1yttwAh56Cpt1F/g3bm0tGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1996
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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
> Sent: Monday, July 20, 2020 4:26 PM
[...]
> >>> +int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max) {
> >>> +	ioasid_t pasid;
> >>> +	struct vfio_pasid *vid;
> >>> +
> >>> +	pasid = ioasid_alloc(vmm->ioasid_sid, min, max, NULL);
> >>> +	if (pasid == INVALID_IOASID)
> >>> +		return -ENOSPC;
> >>> +
> >>> +	vid = kzalloc(sizeof(*vid), GFP_KERNEL);
> >>> +	if (!vid) {
> >>> +		ioasid_free(pasid);
> >>> +		return -ENOMEM;
> >>> +	}
> >>> +
> >>> +	vid->pasid = pasid;
> >>> +
> >>> +	mutex_lock(&vmm->pasid_lock);
> >>> +	vfio_link_pasid(vmm, vid);
> >>> +	mutex_unlock(&vmm->pasid_lock);
> >>> +
> >>> +	return pasid;
> >>> +}
> >> I am not totally convinced by your previous reply on EXPORT_SYMBOL_GP()
> >> irrelevance in this patch. But well ;-)
> >
> > I recalled my memory, I think it's made per a comment from Chris.
> > I guess it may make sense to export symbols together with the exact
> > driver user of it in this patch as well :-) but maybe I misunderstood
> > him. if yes, I may add the symbol export back in this patch.
> >
> > https://lore.kernel.org/linux-iommu/20200331075331.GA26583@infradead.org/#t
> OK I don't know the best practice here. Anyway there is no caller at
> this stage either. I think you may describe in the commit message the
> vfio_iommu_type1 will be the eventual user of the exported functions in
> this module, what are the exact exported functions here. You may also
> explain the motivation behind creating a separate module.

got it. will add it.

Regards,
Yi Liu


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
