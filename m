Return-Path: <SRS0=4al/=PD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A432C433EF
	for <iommu@archiver.kernel.org>; Fri, 15 Oct 2021 11:29:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B23B6101E
	for <iommu@archiver.kernel.org>; Fri, 15 Oct 2021 11:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B23B6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7E7C60688;
	Fri, 15 Oct 2021 11:29:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O9M54iMdbK7R; Fri, 15 Oct 2021 11:29:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE1CE606D0;
	Fri, 15 Oct 2021 11:29:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74C4DC0011;
	Fri, 15 Oct 2021 11:29:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F9ECC000D
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 11:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 404E981C38
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 11:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-RBzrmheQvH for <iommu@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 11:29:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7BCE6819B8
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 11:29:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="251342786"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; d="scan'208";a="251342786"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 04:29:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; d="scan'208";a="461540208"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga002.jf.intel.com with ESMTP; 15 Oct 2021 04:29:42 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 15 Oct 2021 04:29:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 15 Oct 2021 04:29:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 15 Oct 2021 04:29:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6x82sm4RAU9ho//fUOU2AA0QfwxJTLshaokFmdrriRPrBFnG10nsWyPbnu/mReqrBnhR5e/qOXjeseoscIP92a2qsH/YB6qaYyyqG5nEsOkfe1XmOFFocFy5TCBe4qKqBWJF3TqHHoxmI8JiHKiCNUdsizgIKfxMSfL56IzL1MVj0dcO4LFUeZ2EOtaTZavHCQQzPsxjNufIJJZe4AUR/a+NFfHNrNGr/UENiVkQORbOBjbAhjDdaO0lz70o3ySs1m0sldfQeGM8/3dn8LpZbUvFP2FNMkQqWieu/iuPpa9sk/uCBk6LtQe39a4yd4VIhpvIlS2ImRghgyFAZvdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEwEEonB2JcsD8tOKtiU7DPFByWYOFEiwmbtoJMBZVU=;
 b=TRSDXk54npOBFjnO7GmuLwBKJ41rPA1a0xIgHsn/y2/QlfCUIXv30uYcQWJzyCimhDO5NJgsdg/Cabee39T9hm5L3829IKMXx4oNPQ8gljiH0ZQE33xfVbaZJobQP9MZdY+kTirSxeq9JqdvMBfRxqpHcjK5SWChpYA3IxoY14xO7lkRI2eADbCcjMSiztk62ZU/DewcBhv+VQyvd2ow+P07Xs98fdDdTK4I14bauQ6OGR8Vzho/i/1wJEyH/5DJA1HS7rQn/Q+6JhpO+S7Ax6NCkyxrBBzgzAaBSwyuntRp6Hz54887HhJSC8+Pd8IQsCI2FQ1eeWr/N4g0kh6p4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEwEEonB2JcsD8tOKtiU7DPFByWYOFEiwmbtoJMBZVU=;
 b=odzStZP208dvs11+96uW92zA7X9RJXtfqMN3H4I7k42dmboa3LoqZT5/a3n3B/J8hwsAR1V8sd2VzlDUnbQyXK9E7kSizV9KAQUOAG0ZNe9ftKnQvE1Xh2zTA/HLskQ8dItzi0MZqYVQLmoBtMa/ZBnADfhGHaHgOCPov3QH6Og=
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by PH0PR11MB5642.namprd11.prod.outlook.com (2603:10b6:510:e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 11:29:38 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::5009:9c8c:4cb4:e119]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::5009:9c8c:4cb4:e119%6]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 11:29:38 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 01/20] iommu/iommufd: Add /dev/iommu core
Thread-Topic: [RFC 01/20] iommu/iommufd: Add /dev/iommu core
Thread-Index: AQHXrSFn+yRWuHvsGk21Z769W7oSJKuupBEAgCVKaUCAACPrgIAAAxPQ
Date: Fri, 15 Oct 2021 11:29:38 +0000
Message-ID: <PH0PR11MB5658E36269B5A490EADE417FC3B99@PH0PR11MB5658.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-2-yi.l.liu@intel.com>
 <20210921154138.GM327412@nvidia.com>
 <PH0PR11MB56583356619B3ECC23AB1BA8C3B99@PH0PR11MB5658.namprd11.prod.outlook.com>
 <20211015111807.GD2744544@nvidia.com>
In-Reply-To: <20211015111807.GD2744544@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d91e6b4c-0e43-4b15-2536-08d98fcf12b0
x-ms-traffictypediagnostic: PH0PR11MB5642:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB56420C06145689A29AAE483AC3B99@PH0PR11MB5642.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9AKjAMJzK8NB9s/sl6TmuRlUqdaIqvK4TyzfflXZi85BOSJMRbBme/waLuXIfiACiVPn2cVzZ6CDdgICZL4WguoEzNN8XTtFXaaIKFgHkUfvFcOznrSfxL9n/IsAbX1AGIsnOj0xmF152XLySkiTMNvy3DON2mdAsGnYvmsF6gGd/5qCGNNPTas0/Fpnt6A+nY9LSAJjSZtWobPtPw0TYlU9Exop5tz6aOWNMSnlHeqTJYN60pZGclVZGhm0CBnjJ4OWt2f14xtGxG5heoTFjYZMiQEA2N4e7OEzR1bVKy4vhy65tEC6noJP4dz//XaDBvL21bvQOvGYaJGjQ3xxVT6xK5a+/dwbPtwUPa86UdUs7r/fiYljNA6f9B9Y1Q2xs6YLOqe3RPpuJkfTap7YqfhKvtv3PO53nAYlXC4Ezat6Z9+AjWwMPRu6Oq24C+L3sANwk/aaYjcVv78veb0jC7XJz+4Xbt14QIs5/H6Hp5iyTQNYVjf/Ky0b8gMmVhL5XUGy9QgbZO6XnbSEhLzuw8umMJcUckEtaHh+qofxQ4wteEUGZ3jFB6UkMFIlGWiu3GQ4UyavunesISFls86E/F2ASdgJcGgxFs41qT7h6YDLL24zBoTrecsza+TpPEwRTR6Vb8FFOe38+XH3EkhT2ETFhIyu7kfPc+f60cB6fon2lVe2jxGcg7OxLoP6b9Do/HR0sxm8aWyUvnrDC1TMXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5658.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(76116006)(54906003)(4744005)(316002)(86362001)(508600001)(33656002)(26005)(5660300002)(6506007)(52536014)(66446008)(8676002)(7696005)(8936002)(6916009)(66476007)(66556008)(66946007)(186003)(64756008)(38070700005)(9686003)(71200400001)(83380400001)(4326008)(7416002)(2906002)(82960400001)(38100700002)(122000001)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o+uTd+0i4653DHuQw9yMUmuIcCLSZO9bdFbiJlwDi6uO6RrQZEy7PYPrT7WA?=
 =?us-ascii?Q?fYMjc5umBRxCjW7OcagL8FDSOBROvgR8Mur1MRWeI7TmGKN6oT/iYKMWyZgG?=
 =?us-ascii?Q?VoBbymLTW0jQrqU9c/W7+T3U3wxcNz16Tgps+dtCN6i511evOheHdEIWSVPt?=
 =?us-ascii?Q?HXLqjVxPltRpASPUppUadifdQ67HHJDZxXTfL47k5QpdPe4pH9LkHqhzhOAu?=
 =?us-ascii?Q?BQn61fDpj7HG+ZYhvUK0Q3pq7wHZMf9MnBRrXqnm18XIL8tZngBbBMUk3VTr?=
 =?us-ascii?Q?Sxr0hMhpmprFn9BU1aclvvRRZ/LKYzg6hw52uqaA1tICgv+5ucZnekyAQAnX?=
 =?us-ascii?Q?Cj1GSuAWuIJBEyjCdT4Q8eNI+oUjLgQC8MZXFyqrqwlj/WGSevlSYqZ8KGxp?=
 =?us-ascii?Q?Te72/nksrYdBj50TZDVqrnItRULh4jaOG/e56/1dEWIgXuc+MKtsvhBwvIMZ?=
 =?us-ascii?Q?BJ6jZKtQsQBH8tKU5e0n0WgsnTLWoO+EoJEBuo3LUsbmhggA0wsVHubigpSx?=
 =?us-ascii?Q?CAu8wIKyr71DVrZPBPWHlGNVdINtgxYM41RgGOOIxxwKC4jWjiX/RaJ52g9i?=
 =?us-ascii?Q?DQRCpBGXQD96aZ4yR1lUMvYYl/ZAvlSu2qbmLUa2jKqt2mW6VmqqEY1v4snT?=
 =?us-ascii?Q?fHSIP/lIOSRw08mVxQhgzJqFVx6Ha7mDWnejAHLKpt+8RwEGvUW3TeCq09xM?=
 =?us-ascii?Q?nfy3MKzkWuEEA8OHP1Ubwehb06HZrlZpalqv72ZKVYuMVykikvO0hpVf8I0D?=
 =?us-ascii?Q?pQnKPCCFhKynONuCEyvatQBlgp/w7hBzEaMlSJeb1WcVxRdc7W5TTHF6Msks?=
 =?us-ascii?Q?viHIrpWLz8p7Yp/1W8aXL6THUqC+2xFQOWNzS/vPQEiN0L//tyrtxtGTPLNy?=
 =?us-ascii?Q?HcT4C3xID2yKk/RyELYE3XC4kNuVwZVoon6gZwRzhVzTeLHHkuJa9wouECxW?=
 =?us-ascii?Q?IXfcKp31N7jSoR/L/kDG5XGF6oi2PbN5czewT9bFmn97QJqRFkJWBBezD6AF?=
 =?us-ascii?Q?K5MBwCePbJxzjs9qybYlo/Ccg2epEtjrb2EBpqy/Q3V2Olb3Nn2N16M6Nesl?=
 =?us-ascii?Q?KDfZ7Im0/LB5tuyGhnBkAd4CD/3ZDUYcKgCMFuaiVCPUGsHe8wMvlgtAN3ay?=
 =?us-ascii?Q?cR/hdWsTFYTAPtcZGYJxoz+voqxhAUiYplOvZ0RGc2CXKDEH6BtL/fRq0L3n?=
 =?us-ascii?Q?bshOGPzIsyowJrEswq/vL67JOyauTvrZmUDMYzhrM12FAVLThlwrVJWi29s6?=
 =?us-ascii?Q?V9iZtpEoyLN0IrLJLz6q9++CT8nxfnWz9dtVaIn51KRA+g+1lcqu9xIUY2mB?=
 =?us-ascii?Q?vhlfW+OPTxl30ThhMBaz/lHO?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91e6b4c-0e43-4b15-2536-08d98fcf12b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 11:29:38.1682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wwuHHIx6PMaX53WmuspXMdJdhQypcsg2MbRerc0ACuYm+QpIzItT5asdZgZR394W8KqPscKjqj9ajuQD/uGqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5642
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
> Sent: Friday, October 15, 2021 7:18 PM
> 
> On Fri, Oct 15, 2021 at 09:18:06AM +0000, Liu, Yi L wrote:
> 
> > >   Acquire from the xarray is
> > >    rcu_lock()
> > >    ioas = xa_load()
> > >    if (ioas)
> > >       if (down_read_trylock(&ioas->destroying_lock))
> >
> > all good suggestions, will refine accordingly. Here destroying_lock is a
> > rw_semaphore. right? Since down_read_trylock() accepts a rwsem.
> 
> Yes, you probably need a sleeping lock

got it. thanks,

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
