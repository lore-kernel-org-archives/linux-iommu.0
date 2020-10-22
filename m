Return-Path: <SRS0=at/m=D5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A3DC388F2
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 03:55:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAABA22267
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 03:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="i4twV6Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAABA22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 18B7A86D2B;
	Thu, 22 Oct 2020 03:55:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kVCwKhYMCLAI; Thu, 22 Oct 2020 03:55:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 92A5886868;
	Thu, 22 Oct 2020 03:54:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83405C1DA1;
	Thu, 22 Oct 2020 03:54:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B0A9C1ADB
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 03:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 08E59876A3
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 03:54:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z96lKAOjVo+g for <iommu@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 03:54:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 15B6A87658
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 03:54:51 +0000 (UTC)
IronPort-SDR: HaaR9FLknwinuUFBYssD2b2rn7gNRgQhcrBVvWojBXTjr1OUtIEPIsQNp4/8SzTahFN0U0R2NA
 +4e4XUWBbk8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="154420826"
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; d="scan'208";a="154420826"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2020 20:54:50 -0700
IronPort-SDR: yRgtAYRM0uMPohTpJ8W9nCuZ4+jfrqzN6NXH4WD99GX3XbZV0u7FCDASkhNkLN+V4umdVsdN7b
 gAdDBoq1/Htw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,403,1596524400"; d="scan'208";a="348751513"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga008.jf.intel.com with ESMTP; 21 Oct 2020 20:54:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Oct 2020 20:54:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Oct 2020 20:54:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 21 Oct 2020 20:54:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 21 Oct 2020 20:54:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKuDjSF5/IIx2js2bm/zkUDsQ4te0nuG60n0IFSnrTWHagVW0rQlg+2hzx6VSfwq0k+tsXrcID8GnkdDks6RgQOlbv8m/eRyiWp+qk41VQ4nzoGcFLM1CIx/EQgeofyE0WFNi4iuauqyFTHFeMb3XRcapQs+bw6IraKa1TJb0/f49MbC+8ZBzljdnoHxA1/Pv8LceJK7+9PzNhvXiALP4gGqfdEpFP0BMB9ciqNiF3uB/gZDL33EeWJgU63pzuY6VIkEa8ph2X2A1kLx7TK5hAMi6LVt8lO6Q9SjKwU3UfPdRfcCqaFHuvXtEk0RQePV/ipkvU54dLgMx/f/+j2/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mG75nnluJTfGmbDWWAZCqxWK+V/xKGBrMm5XqCwMLo=;
 b=Fk2FRS6whq+th7cn0AWLxDdMktdX6faur7VRW029ZTVbxa/ZnPL+/2OmmTki/G57xg3Lg55nuYUAjzyXYWb5yKra+guNfmj/Sx0IM0KNAzLGE86HIGYoan6oxcRj1Fr15c5EoKXB8fu0+r90T1VD7tMsTU5hVMZhcjbvNroYUtKZUJ29TT/+pd7/nc01DeY6RY5kvRUb5QtmbTHk6fd3uhOaDF8y5WitJxyKWV01gRmEfGPjxH6Zdw7ywdshxTGDEk2UwQtIAVOHWdHtEPJdj32MqjnYVb1g8+I9pkudhA1kmJhgjMvsc6xdz8ihLMAPHCGUs9FykmyM5JuDqEV8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mG75nnluJTfGmbDWWAZCqxWK+V/xKGBrMm5XqCwMLo=;
 b=i4twV6Ie2CHNsgf10pmdXOOny+vD1kIi38GljJ3LgT9MFbel9BTBNY5Q6MIsMC84BTmiYI4S42iRf2JvEqPe3Uiftrh4gIAUrv9/KdGkrXwlQ+FCrLvEa1IGVPG9r8rhJMmHazak6Rb4w4SCqGB0nj+tfYt/8eTnZBKlgeF5xGk=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB2603.namprd11.prod.outlook.com (2603:10b6:5:c6::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Thu, 22 Oct 2020 03:54:43 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::a1ec:ba6b:5057:be2f]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::a1ec:ba6b:5057:be2f%11]) with mapi id 15.20.3477.028; Thu, 22 Oct
 2020 03:54:43 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Thread-Topic: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Thread-Index: AdagceQQLvqwjRCrQOaq1hZ7MgDUUABZWmqgAH60bgAAh22vsAAM9nEAACSNTfAADO5TgAAE94UAAAFdlAAABd+HAAAAJWeAAABySwAAAC+JgAAAdbiAACAsxIAADLACAAATAO4AAAHSuIA=
Date: Thu, 22 Oct 2020 03:54:42 +0000
Message-ID: <DM5PR11MB14351121729909028D6EB365C31D0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <DM5PR11MB14354A8A126E686A5F20FEC2C31F0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20201020140217.GI6219@nvidia.com> <20201020162430.GA85321@otc-nc-03>
 <20201020170336.GK6219@nvidia.com> <20201020195146.GA86371@otc-nc-03>
 <20201020195557.GO6219@nvidia.com> <20201020200844.GC86371@otc-nc-03>
 <20201020201403.GP6219@nvidia.com> <20201020202713.GF86371@otc-nc-03>
 <20201021114829.GR6219@nvidia.com> <20201021175146.GA92867@otc-nc-03>
 <816799a0-49e4-a384-8990-eae9e67d4425@redhat.com>
In-Reply-To: <816799a0-49e4-a384-8990-eae9e67d4425@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b19164fb-1646-40ce-71f5-08d8763e357a
x-ms-traffictypediagnostic: DM6PR11MB2603:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2603E518B09B7DCC838DBEB0C31D0@DM6PR11MB2603.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOmUmm5D81WR8aFKHtVgWFLoC+EYYtVjZ+OZT3IxIRowQdnbWNhUlQ8hJ5MZjVdiZvVKjlyF/ORPoxYEBE170ABlL+5K42BmtjAovOpDym2+ht7X/HZUAJFQP7FKXLWelrM70uocdgtxRdLIeNJmhcffshbWOS7pGPQJ6GR3UJDnYKNxfsGSyAVrpbIMGnnGSjOHpF5TiXJialwbQwbBjLneErTcaALduyGqwlgvszKQyRjytPoiiMpMj8aCsEj0pKlyV24s5jg24fU5GF8piYHcVinAUkEoPOVfWt6wV4bw3cLsWWPmmUqZMhfv8BlL2OEVMe+siwCJQpDn5DM8QA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(8936002)(5660300002)(316002)(9686003)(7416002)(66446008)(64756008)(6506007)(76116006)(66946007)(66476007)(4326008)(66556008)(478600001)(26005)(54906003)(71200400001)(110136005)(33656002)(52536014)(186003)(2906002)(86362001)(8676002)(7696005)(55016002)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: zlVGmOTVPltqNpoNykq0eUE5ZKVMAtp5MagB8xUzb1fX8FuY1ue0fsHndHDisoMVez/ptN42mTYQdz6E0U8jHACuNMR4BQTrFpMRstKbHzug3ToWEtJxOxsBB1l+LrXWRqnXVu0c2LTfq1gUvwvCtO0OirR2obWUqitiJ8tepxq7zHaI3AtWU9GXnxqraIa+pj326YPc0EZbHhXnUOtUFHKH5yA3fVkf3S9Hd8B0NWvJ3cS4gwqy6K5fN4nM0Wuen5DIv6xk1r4JYD7y1uNmi8Ac0FfBewaWTOYhTaqIe46AkidvoJIfiyoS8yWb3BCD7LjzznnijjI+qVz7wtpVUIGvpdRQNeqg9be20rYqRg+cvvexv+CPEVp1nH62mAGNEyxSPn31NVRrwi7cOZjplZkdIUGH8lqIKBZrvJ5Mi+JmAVx4t7CbJP1vZB7PbZd0/8zqzfZOb0aG84zuHVktcw00N227Z+4tVZRNh92JgQhaJvLit43aUQoCLBBgd3ggBqD/FwpDI51nDArstWqHoNxym9p1Xa7OP8/pDLfqTiF2/TOjYVx23vUp2ZxBnCdyQVpqqys0BRKbz6ImzK+6CdsqaFMnlSGntxV1pbjiFRErmcDMJup+cUDG6fwFUW8REs7GICrs3SpaqoQaz0iOUw==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19164fb-1646-40ce-71f5-08d8763e357a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 03:54:42.8173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgQmaN+5DSBAeHYIVreAh6rsjgFneIOuRdRgZ8GucjXg85y3IBjOybWNY+wKTDzDJBk0xy6wE20Q5OH0kIYQ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2603
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian, Jun
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

Hi Jason,

> From: Jason Wang <jasowang@redhat.com>
> Sent: Thursday, October 22, 2020 10:56 AM
> 
[...]
> If you(Intel) don't have plan to do vDPA, you should not prevent other vendors
> from implementing PASID capable hardware through non-VFIO subsystem/uAPI
> on top of your SIOV architecture. Isn't it?

yes, that's true.

> So if Intel has the willing to collaborate on the POC, I'd happy to help. E.g it's not
> hard to have a PASID capable virtio device through qemu, and we can start from
> there.

actually, I'm already doing a poc to move the PASID allocation/free interface
out of VFIO. So that other users could use it as well. I think this is also
what you replied previously. :-) I'll send out when it's ready and seek for
your help on mature it. does it sound good to you?

Regards,
Yi Liu

> 
> Thanks
> 
> 
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
