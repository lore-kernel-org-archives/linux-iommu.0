Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C91BC43461
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 01:19:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA4B20BED
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 01:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="vx8ADQzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA4B20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B293D8610F;
	Wed, 16 Sep 2020 01:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id igsn_PTmRRpj; Wed, 16 Sep 2020 01:19:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A3B285FC6;
	Wed, 16 Sep 2020 01:19:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02637C0864;
	Wed, 16 Sep 2020 01:19:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D407C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 01:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3BAC7872F2
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 01:19:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kRmu9jgjqJPf for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 01:19:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 657F2872D8
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 01:19:23 +0000 (UTC)
IronPort-SDR: 5XZTAOSQKlyAoHU5P74ca5pQzDLfnjDztNz152uFDGHfE+iPAgfsxRPkP0S4pUe0mCnj1USUxr
 L0bCQEVT+bwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="159431826"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="159431826"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 18:19:22 -0700
IronPort-SDR: heHnzCsD9+LzHzkAirANLFg1HB6h5+4MZ+sQocMz3edAEQBSz/qAMHmlWYguAs723dPxpttUmY
 z7hvTzwTK5Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="380001187"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga001.jf.intel.com with ESMTP; 15 Sep 2020 18:19:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Sep 2020 18:19:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 15 Sep 2020 18:19:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 15 Sep 2020 18:19:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maGrC7QMUn//EZ5yWqSyr7iLP24m165jwNB3dHJhm4gsReSqrmd0DSQCNAtkPXw4dx2AIGlPJC9g5L9259Fh74x7tRGR+c7Cdu6vvSwwbBFC0YuZhgqfy3L5ALMFYjsN9JW6FJCNnyF5iwaNJqHoV4pTS2LRCdM7E2TQoseqBuNqgywCgRpZK2T17S4y30wlfge7hW61orX/C8LxSzjDdv+lYIt0YKzH82YgOlr+6N1jzS67eSIA2H+KN4lQNaxu/qx5VvDFUlBiVFEjrwwPaPJjPrl8KqZgeoHY6b9fcMxQPHsiCgkFNgcrPz97xjZ1kKZfBax6f+VwPesl7W11og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rZioPmhFbNWTVYHQLgL/2FVK9RHcdAVb1Ezy2Ed43M=;
 b=J1u/1pu4AFtdLErGA4ZyKmbpWaNBCmAXRLXWS+qZh8fcEI670ta4yjCo3LHr9OQt1Lfk5dozdeZdnrSOcKYZPQqRQjwlj7q7WqeUxROHQHG+wdOPEJq2jguTUkI4BmybaB44FeSHaAY28x84lhDYSzRrMN3zbTx8mTaY012kmxIjHtUQoaPG36ZPRZaPVn6MtexC7QA5xmuoO2Fj7yhtlxzwkWGEZjb46XgDATnXJLfni63EqsWj9AlyoMprPwCWrpHSxB3AT9YMCWBVr/w7AGL3onBmx68iy0xuoh5wHAj6segiuKBEt4iFuZvCBRRHVixFCuiVpxRfu9MYRV1DoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rZioPmhFbNWTVYHQLgL/2FVK9RHcdAVb1Ezy2Ed43M=;
 b=vx8ADQzhvHGqBjafBlWswe1VxmEfDHzZFUhaWcTsDOb95Lq0x6BLy6GLmVpW3Cpv4ghgX6MJkRgR652nef0Goovc/0P7CX3p4Ah8mWzL5amsuW9QEg3pD02a8HCIr2ONeSywYhhp/MtiFbrFmzRLVKjYmdy3DSBwwlR1fbdhiOg=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1758.namprd11.prod.outlook.com (2603:10b6:300:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 01:19:19 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 01:19:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Thread-Topic: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Thread-Index: AQHWh19AhgenwZ1qREOwvjqrd6cs+KlnjewAgACZ9oCAAASWAIAAK1qAgAADGwCAAAb/gIAAC9mAgAALxACAAAp5gIAAO0sAgAELFgCAAK+vwA==
Date: Wed, 16 Sep 2020 01:19:18 +0000
Message-ID: <MWHPR11MB1645934DB27033011316059B8C210@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <411c81c0-f13c-37cc-6c26-cafb42b46b15@redhat.com>
 <20200914133113.GB1375106@myrica> <20200914134738.GX904879@nvidia.com>
 <20200914162247.GA63399@otc-nc-03> <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home> <20200914174121.GI904879@nvidia.com>
 <20200914122328.0a262a7b@x1.home> <20200914190057.GM904879@nvidia.com>
 <20200914163310.450c8d6e@x1.home> <20200915142906.GX904879@nvidia.com>
In-Reply-To: <20200915142906.GX904879@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc8e72f3-5b4b-42eb-42be-08d859de891a
x-ms-traffictypediagnostic: MWHPR11MB1758:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1758B08F0F1E19D2FFA3368A8C210@MWHPR11MB1758.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tfy3f8Jd67SeyAUIs4PigHoMCqWBKAPLtF/g7zXPRsBwwVOG6n0THUo7ZkJbreaEXa9LUcgjhVPVrwDTrG8R55IYt0KmY71EEiVVMpawmHxVip1RrMsVb4cQ96ivsdTEPinwSljP8vY/Bjiemz8uKp0mizp65mU3oY7Ba1Pa4rc9smMTTqzX+8AYwWJ17aLLttkpZiXIONNmdRKgyJ0l//uaDomRWrxYnLHPfFXKTYHVoFF8lvLs19o9mnGJzFhxgzXVM30tPEfo3s2QjR6rFsHA96oAh6Ltmx28PR/jFfgk0Ty5n4CrBVL17J1KHVUBWwLhwSNiKkvN4XalEgM47Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(6506007)(66446008)(64756008)(66556008)(54906003)(8936002)(7696005)(2906002)(316002)(33656002)(8676002)(110136005)(478600001)(86362001)(76116006)(5660300002)(66476007)(71200400001)(7416002)(66946007)(9686003)(55016002)(186003)(52536014)(4326008)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: b8UABfi+r2H/JMWePfpqLhaKpHzgDu5xCQZz15C9aX7TtK06WXC1UmVHL0AHozs4DbR2UnVpTwf/Q2RwOhFiEFyLowOivgLLdIwhi+v1oH/SDYnYPm4tglNdvam6I1+d6LWHmtUKkd9p/J9dGvbVxq3QnygCer0+aJqNu/FBih9vNPs+w8rYSrLExHW6cw6vTsHREo5RibWBvdK8GjP4ck7wSO82PaEHksPwpKytfYmBegbQOHvfNT3J9DIvpekhYWCcS+DhbytQlZMojxiBklgoS55ANWyFZjoc1lN6C21jkusZVEWZhQlwhBVqs3bXkO+hqihdbX2Zja1mw9QnkG738Z9YtDEoNsbFldy3jTitcnDT+4/Ep814Z4Y+efuudygsDVnhQummVp5hKbEyj1e0fjoATGqXeiusz3m8ISBU55t2CSmB+DCW5Gj5CkO2xiZ9wwb3iSzgGNScD29qUd5zYlJgNo1UOJmxnrGQaQMdjLoVNdjAlKH0Vf8PMAEe86VleA9AvKlMkIQT71C7vbVBnpS2pLbEfvAn83WZkGTWs1b1EnbkMHxSNJSLyqK/zakdrVDWhpeeZv2HywaQPEA8M9FU9jT1qb0kdq0ve2OqpGsHme3b/tWUR8/bHj/rmq0fzyoVQMTNReN0fmY6EA==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8e72f3-5b4b-42eb-42be-08d859de891a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 01:19:18.9257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5KsMa6zyTQltAgj6CtiH0YYDBJrzpBBbVESsqrISJmSFLMpcBw2qolyRlChtMX37RgusYIkIt3CEJqtn7ekiTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1758
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, September 15, 2020 10:29 PM
>
> > Do they need a device at all?  It's not clear to me why RID based
> > IOMMU management fits within vfio's scope, but PASID based does not.
> 
> In RID mode vfio-pci completely owns the PCI function, so it is more
> natural that VFIO, as the sole device owner, would own the DMA mapping
> machinery. Further, the RID IOMMU mode is rarely used outside of VFIO
> so there is not much reason to try and disaggregate the API.

It is also used by vDPA.

> 
> PASID on the other hand, is shared. vfio-mdev drivers will share the
> device with other kernel drivers. PASID and DMA will be concurrent
> with VFIO and other kernel drivers/etc.
> 

Looks you are equating PASID to host-side sharing, while ignoring 
another valid usage that a PASID-capable device is passed through
to the guest through vfio-pci and then PASID is used by the guest 
for guest-side sharing. In such case, it is an exclusive usage in host
side and then what is the problem for VFIO to manage PASID given
that vfio-pci completely owns the function?

Thanks
Kevin 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
