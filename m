Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5059EC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 05:30:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950896139D
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 05:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 950896139D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C9B8415BF;
	Wed, 29 Sep 2021 05:30:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h4iv79zC1ONb; Wed, 29 Sep 2021 05:30:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1F505415A5;
	Wed, 29 Sep 2021 05:30:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAE88C0011;
	Wed, 29 Sep 2021 05:30:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 182B3C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 05:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F20354013F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 05:30:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gn0MQeLByQj5 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 05:30:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1B9140018
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 05:30:37 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="285878873"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="285878873"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 22:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="707052560"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2021 22:30:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 22:30:30 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 22:30:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 22:30:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 22:30:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXhxiX0JXIdePv5VEilIIH5G2R6eCG+ODAz5Lml6iiItv00S436YHMKsrB8KVrIwZYCt6E3b+AXZJeYgjMc6XZqP+fG3a8R33xKOmIJRa76dWWE4GZ5/imzLsqIfau5RZp9LwOIG2p6rFcH7QEgp0KqaMaFIHDs1H7HUhsSGvPZwkikD4ZSCe/wZRMr/eh8aYMA4LzM8Ap8uYDXiJ+AqAPWut3gGeHgexE1pHcBiDX03s0n9BLpcYq5fT+3UtZNWaYUhDoLY0rzMUxcwU9Y994CX7MKEzjS1VMw6g1Csu2pcctqKpDFWS9BoyqNroHKE9oiAdee/louFRrHh34lBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=VsehtWsMnuPX74s0S1g33Ua1HGuIYFc8o5cFWPs2kfo=;
 b=W5E5XvFSrMXmSlSYGYGBgC/K/V9RxU3Fls/49/UqF5LTHSoI0HQQm8nS26sdxFp8HLioNCmj+TSJiFPye9vmNzP+cxOfgtzOLT+5wV68pHJikWQOoQ3x72e+TYua7t7R4A8ghU9vkxNnA1qaD9rwPKLaS/6NVk1VnI414Re4oJKuxFc8CV9t4ekGvlxI67wQKFPBNdhf7efPLnOxzUOgAUzbDKnIqOV//T1nKcvRKG3LaD8dpG0D5gBWhHjYQYrmcEz+R8pyJjPQNHZYmgfo9UvDkPmJh6UWq4OAuyOBLjx1MArtb0ta/7SSIrMkhtOvzv9psA9KQE/FjcXdwRD7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsehtWsMnuPX74s0S1g33Ua1HGuIYFc8o5cFWPs2kfo=;
 b=H/O9ecjJD6c0YBrIuFJhqk1SldvAlve7bkEOit8v0HVQXRLPnRlfB/z7Kt1c1XjVVJoBbHSwP1FHXbpiDj9LKIcPULylrGgBQwh0JyQiLM/T1pgCvfUhyAfPx/w8PbGYzDytqeDAh8koZi5vymQBkbqFFk5U8M0f9kSPXkt+udA=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5420.namprd11.prod.outlook.com (2603:10b6:408:101::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 29 Sep
 2021 05:30:26 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 05:30:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: RE: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Topic: [RFC 03/20] vfio: Add vfio_[un]register_device()
Thread-Index: AQHXrSFwNP3/pIcrZ0iM9X/cSoy0lKu6XWSAgAArGtA=
Date: Wed, 29 Sep 2021 05:30:26 +0000
Message-ID: <BN9PR11MB543356CD7AD9F45793D1ED118CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-4-yi.l.liu@intel.com> <YVPS43bNjvzdxdiM@yekko>
In-Reply-To: <YVPS43bNjvzdxdiM@yekko>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9b0f8a3-8c9f-4b98-cd02-08d9830a3e12
x-ms-traffictypediagnostic: BN9PR11MB5420:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR11MB5420FD557DA9F6CC5B06685B8CA99@BN9PR11MB5420.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r9yKN87D+uoSLUN8ZdtpvNu6LOi7xElt6KzsqBB/QF6n8qkgTeMFomMwRu8do6jwVkhinH4/E6W6hYXkY22gZK+JpSd8jlbIUR8GZf7jhR7zbxOCRkQBxzIaaEw9bYnYLhAgjLFq0pUzaMOGK+TwvdxcJN68cVCumQwPcERipQOVXs5ydPcLRwx05J7B05UVlzwqALQxPhTymDvcVbzy/sFsDiArJKMnd2I+cmq0QcFB/Ivgza6mzhb/Ct8IsiCFPTOTGx40BnvBYxjAsM3HmUMizghVlVwWjWoGzMhR4byCUS/ojhJFJKtYb2FVX9lvxSYVuwnPDCRbYW1nES4XMsaeqwcBTtpDBjoUOc9q9HGmOK71B/kVNe6+83AeBW3nmZiN9YfFgzYXRYLnS1GySbm46uoe2jhVrwaqWZ+rCFXx5WDQKIaPDBlyOe1zp58nyt60h+r5bAZ1YAKJp8vt97cB9c1rfMwAQoOzm0tJloZQow+3ngl5ZA96DXI2N+JB6KlUMjj6Kft1jmFqSJe/jvrhodFiIkPIUTP65+pczC932DyLT3aGTW6nfsRudy8KJCZK70NrT5xOs1LmuHLJ2Q5sGYYgjXA6TCjeVWoEun0PUtpoEgNmgf1D/UrqLUvUCPxlU6PRCd3luohSjCutuex7BYeAn2jYQegLTeWO+rkn8m5PtloaDSyPDMZqVO4uSiE+O1w9ch5JmUJBJObogg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(316002)(5660300002)(9686003)(2906002)(7416002)(55016002)(7696005)(6506007)(6636002)(122000001)(38100700002)(8676002)(4326008)(64756008)(66556008)(66476007)(26005)(110136005)(66446008)(54906003)(186003)(8936002)(33656002)(76116006)(66946007)(38070700005)(508600001)(86362001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmYycE5TcTZVd2U2WSthaDBWVS92YTdTckZwQjFBS2JuNUJ4VUs2Q1RCeFk4?=
 =?utf-8?B?blF2cG1pMy8yVDdQNUR1VGFWdldabkkwZDJKOEsxangwc3dNTlArV2x5WmNO?=
 =?utf-8?B?eEtqLzJ6eDNwWlIraU1oMlB6YmxCTVpjUDdZeCsvazJHSkdnc3c0V1ZqRHJs?=
 =?utf-8?B?dzhIT05iM3hlbmJvTmpqT21PRnU2OW02UWY2RVM3dmUvRVRhaUlwQW5heXFV?=
 =?utf-8?B?TmMzM1Z1SVNON3BpRXZXYWdSNDhOSFVSclZJV3k2WFp4UHpSNitPL1Yycmdh?=
 =?utf-8?B?Y0dHaWVnY0dtVzIrQk5wUDVLNVpOM1V3Kzh6L2VtL2JhVkgzWTMySW11UXcw?=
 =?utf-8?B?TExnUm1YVWtWZHdqb3FKSGQ5ZWJpWUN1KzNFZVBXRmtxT2gyK2tVVzNlaVlP?=
 =?utf-8?B?U0c3aEMzd1FQODB4QmQwK3FycGdvUktzTkNkQXFYeHU2R0FmQ2JmTzk1ZFND?=
 =?utf-8?B?SStCRVBLYk9DTTV1VWdpWHZOK0lYd0FSTTc2d2dWaGgrZy9leldpc2hlQ3RE?=
 =?utf-8?B?UGhiTllZQ3Z6cHFFMzNRdHEwdkhhUWxPRWJvTkRkamZzNE5wSXBXcWRFQkJ1?=
 =?utf-8?B?MUxiaE5UeUMzZXBIZGwyMUZqV0dnZzA2a21mUWt1YTIxZVpTRVVNTWp4dGh6?=
 =?utf-8?B?TkFzRVNZWkFIVkRLUmJNYmxaVGRhdUlOaTdsWEdnZDFVMkdQNUwzQzVhMitv?=
 =?utf-8?B?MEhzNVh1N0srdWlLNW9oSUdLSm9oNFlGVWZCcWMzRnZKb0xDTHc0VXlWKy9G?=
 =?utf-8?B?NDRNR1JEdGljbHU1RStpSEVza2U3bjBkNHNoR1BjeFgzdlIvMyt4YnRmcXBj?=
 =?utf-8?B?eEROVU5sUXBnMHdHdTdCdGdGR1pYQk5BeTlWZkdaWWVlSngyUVdUelkyemty?=
 =?utf-8?B?T2RSakpOK1NHZ3VlN2tReDlRQy9jaWxEMDlYcnFKdFNxcUFJdEFqM3lrWHR3?=
 =?utf-8?B?bGk4UjNxSGphSmdNcDBqSkFBbEhZY0VxK3F5WXN1KytZMm1VL2N6V2lZZHdB?=
 =?utf-8?B?SnNVWjFGa013SUJDS2RhSGlBWm5IWEZBTnlqRDZQUnI2L3JsWURUeHg2d29P?=
 =?utf-8?B?ZEZlVEIrMlBGVy9ONFNtVzRmSXJSdTZxUy95MTBDV2k3ekZTcWNHTERWUkhx?=
 =?utf-8?B?R2pmcUxZWEVwMmk2MjFJVXdEOHFEc29XTXh0WGhONE56ckd4TWZ0MFMwNEpx?=
 =?utf-8?B?azBtbXFGaWcvQW52L3AveUxIRHUxa1R1cU9TbkNRZjBHRUdqVHNHK2FETWla?=
 =?utf-8?B?aVB3NjZTdkROZWZadUY4dytJVGxDeVR0aUdRTkF0cm1PalVhU0l0b05FK3lr?=
 =?utf-8?B?cFBPOHp1dlhIa2NPMHZMZnBVdWREQnBjU1AxOHRRNkt5V0lwMjVjdU9qdkxy?=
 =?utf-8?B?bTV6dzRxK1lETndtTFRjc3A2bUhHL3RUcGxJWWM1NG45dFhsemk2MkZBUWtS?=
 =?utf-8?B?Nkp0aXY5bDdQMTFJL09OUFZ0S0FVaWFaQTZTdUUxQVB2RFpIYWMwdmxYbHVD?=
 =?utf-8?B?eGJyL29WdE95R1ZuQWVYeUVuUXVKQ1N4VnhvYkZDNU5CdDBZMlpQK2V6SlhP?=
 =?utf-8?B?Z0UxUHBXa1NzaUR5amRPK3BaWkxnQnNUdWJrVTVabndqS2FMLzVINGo5eklj?=
 =?utf-8?B?TmlRUDNhVm4zMnVIck5DR0ttNENCYTJVRG40dTdtL3VXZ0ZwN2g5Zm9PTzUr?=
 =?utf-8?B?M044UjNFMFJKYldDdHlMQU40SGZYNFB5Nk54bU5xRjhMRkprRHhIZHJ3Tno0?=
 =?utf-8?Q?5Vnnb34dtEb3lBPJxg+UoZfKq8Yz8CUz7pLZ4QL?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b0f8a3-8c9f-4b98-cd02-08d9830a3e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 05:30:26.1368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6vR8BDPPnb0PJtD2s4iTYEwvU8ffYIAsff3n/JH9e2q6fmIk8aVQBLUVxnNDOGpgme0wEg9QlIWlJhijeOazw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5420
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
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

> From: David Gibson <david@gibson.dropbear.id.au>
> Sent: Wednesday, September 29, 2021 10:44 AM
> 
> > One alternative option is to arrange device nodes in sub-directories based
> > on the device type. But doing so also adds one trouble to userspace. The
> > current vfio uAPI is designed to have the user query device type via
> > VFIO_DEVICE_GET_INFO after opening the device. With this option the user
> > instead needs to figure out the device type before opening the device, to
> > identify the sub-directory.
> 
> Wouldn't this be up to the operator / configuration, rather than the
> actual software though?  I would assume that typically the VFIO
> program would be pointed at a specific vfio device node file to use,
> e.g.
> 	my-vfio-prog -d /dev/vfio/pci/0000:0a:03.1
> 
> Or more generally, if you're expecting userspace to know a name in a
> uniqu pattern, they can equally well know a "type/name" pair.
> 

You are correct. Currently:

-device, vfio-pci,host=DDDD:BB:DD.F
-device, vfio-pci,sysfdev=/sys/bus/pci/devices/ DDDD:BB:DD.F
-device, vfio-platform,sysdev=/sys/bus/platform/devices/PNP0103:00

above is definitely type/name information to find the related node. 

Actually even for Jason's proposal we still need such information to
identify the sysfs path.

Then I feel type-based sub-directory does work. Adding another link
to sysfs sounds unnecessary now. But I'm not sure whether we still
want to create /dev/vfio/devices/vfio0 thing and related udev rule
thing that you pointed out in another mail.

Jason?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
