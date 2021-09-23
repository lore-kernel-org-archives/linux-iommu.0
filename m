Return-Path: <SRS0=900o=ON=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA298C4332F
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 13:41:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA7D61216
	for <iommu@archiver.kernel.org>; Thu, 23 Sep 2021 13:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EA7D61216
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27F7A60774;
	Thu, 23 Sep 2021 13:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dDW9DghihDIM; Thu, 23 Sep 2021 13:41:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E95A26075B;
	Thu, 23 Sep 2021 13:41:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC9C9C0011;
	Thu, 23 Sep 2021 13:41:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AB8AC000D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F06E8421D7
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yz-MLuiLqNdq for <iommu@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 13:41:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CF3A4161E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Sep 2021 13:41:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220643642"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="220643642"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 06:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; d="scan'208";a="558370081"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga002.fm.intel.com with ESMTP; 23 Sep 2021 06:41:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 06:41:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 06:41:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 23 Sep 2021 06:41:13 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 23 Sep 2021 06:41:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il0RbjEeCSx5XNY4Xu1uSb4pZZ++ZQLgQGJ/UY8PqX4NcmgSCrikoRzVrPQPMn37v9c7nv3KOVEiTVqNBL5nWPna8s+OkBJ4BoONO6QVjaQ+rW3FgdgFDgWfutQHGut7Tf2dBtiKVghxXlUfI0w/PiFzatD9zsrM/b8gYbo8SMb0PfBl5/PJTJ9J3YNH3tXjHzgTnKRnhjcZrQ2OUYg6JV+SRsp7stRoW6PMBQRLUY+2ODn3yR1eoSnwNDi8KZV6/DdeASa6WizzQ5rFptS63fH+Ef2JG/NE2GLdfwNghEy8g03apo2Xb0rfXTlztb2vhHUFbcKsqZE2+3CPDUHfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=BsFe9e/a7Q61rXc9NlfQkz2EvJX1UoxrimSY9XMF6es=;
 b=Z4lEHSJNz8uuZwpdYJVoyK8u69ZnF/Rd1NI27P91Lfw5xuDBEL+0Io1M99f3ttPAUn96GLsX6KwlsrtBoZ7Jv02JwNPjtkiEpARHf0rNph0YCDbTvWPB8IFosZVcvEjVta9SweUk1Av6dGPDWjx+fVSXxOQpa+H/UgEC+PJRAg+iFzL5oCBdAgWTMSialHQM9XeAULi2x1+JBZLznCEUZ6AeEwTQSG1J1Co/Zb5jfzfStNcq6N3m9fFoTH2T1U1J567BEQIKQEeEtUG8IWR1wVJS/SuNYuZ7Pi6/FqBqdrebEgK1FmH16sPzxCuJu1yKkSZEF2tYyu2iCjwXWy9u5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsFe9e/a7Q61rXc9NlfQkz2EvJX1UoxrimSY9XMF6es=;
 b=RYgSSLronNqHh6TLeo+LoEIfpX3BxwVP/ah7GzMCqZE1HcvZA/xo1Si9H8drjysoThIyRGygeccQUCCkDzU4nqjCXtmw44YNFFS0Mh/b/kFrs3q67FWlPQBN+o0P62XcUW7Tn8Ygt4mw6oArJwVNlH5W5XE6ZB96JqCCQTYuEjQ=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN0PR11MB5758.namprd11.prod.outlook.com (2603:10b6:408:166::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 13:41:04 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 13:41:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Topic: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Thread-Index: AQHXrSGPLoYXtOF3o0iA7Cse+/LM66uuxm8AgACjoWCAALKBgIABNQdAgAA7IoCAAAByIIAABmEAgAAAUDCAAAgmgIAAAWowgAAGs4CAAAEXUA==
Date: Thu, 23 Sep 2021 13:41:04 +0000
Message-ID: <BN9PR11MB54338820E6457DCB3B0ED0C48CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210921174438.GW327412@nvidia.com>
 <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com>
 <BN9PR11MB5433A47FFA0A8C51643AA33C8CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923120653.GK964074@nvidia.com>
 <BN9PR11MB543309C4D55D628278B95E008CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923123118.GN964074@nvidia.com>
 <BN9PR11MB5433F297E3FA20DDC05020E18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923130135.GO964074@nvidia.com>
 <BN9PR11MB5433B300CF82CB09326A00978CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923133037.GP964074@nvidia.com>
In-Reply-To: <20210923133037.GP964074@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71832ab9-6d9c-417d-da72-08d97e97ca47
x-ms-traffictypediagnostic: BN0PR11MB5758:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN0PR11MB5758A98AA9A3C0B2214FB8318CA39@BN0PR11MB5758.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GrFWCgvXztw+3741qVs6LnQPgyV9eI9UIxMyuyFddcHVjwoRXOD905F2JI1IB9SBpmK/aIgi0pEFSBhaDdEIDNHe4l+Y7vkFiEI/WZles3yKPEdMENhKa/TNTkTh4yrgtUDLlEAu35xrrBriVK1pzm9ZAJ0C/btxu18m3Xq9xS/H2pUw1UkacSlJIqhrp7QyR1tu3P1xJJYMSeMgZKjtOOQUlqldQAg0gtcoys5Ea7arJQmPUjtnoDApoYDlK1lSLvpkezvDQXelDEX8VThETw6neq2BxyqOYVzuN9zA++RXowrycVMhwyNlEMGaq0BFt0kyqiEsTSk8s1FXcEkn08mM9szu4seKdvB08DWzB1eMDhAyMKlUPrTtsiALt1n0WFWI8go11QAFSs2Xbaae5Md/5Mhb2h6i0apbr2u9mLT/ZWq95YAQ5gKq85iXKfYrxN7fnNXFcYigI301F0QCSTZdnGWa422THAOf1FNchFaSh1H5TLS5E6qdINHBh6sBS2dcrPiOVgd5j1dd0CwwDG+6JNpwYbpYyzh9kww2ZfYmWCNQoOFYGzL37JAat7NuRhwj0pKIrSlglzJKWD8uOEGtLU2vvyrAHsO6irbsOA4nm4OtMB2gD9feojQGytJE61FnbphgMCUljE93Zwbnjh0dEhzBolZ7si0pPdBej/sycF6EzsP39BfClL4VB79vy2xGrxRXahNw03QOMghQAvfjSXsK0vZiXQSiKOVyI5Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(2906002)(316002)(5660300002)(76116006)(66476007)(66446008)(508600001)(66946007)(54906003)(66556008)(64756008)(33656002)(8676002)(7416002)(38070700005)(6506007)(38100700002)(6916009)(52536014)(186003)(9686003)(8936002)(55016002)(7696005)(4326008)(86362001)(122000001)(71200400001)(84603001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUdGczJDZ3lHOTlVbW5NZkQwRFh0Q3ZqWmd5QStQZkxvL2c1Nmk4QUxORDJm?=
 =?utf-8?B?bENRWjhrbGxvaklvRmNlV0dZa2c4QjdISTMvRjlHZ0huWUxhVnlCTE9UMm95?=
 =?utf-8?B?SER1WGYrVmlpZ2srMVUwS3lMdFh2Q3FodlkvdnVGV2lESFhCenk2bXorTVRu?=
 =?utf-8?B?ZytvN09zU2ljTGhjelNSVTlza2o0L3R4eXNmWXZhQjB5MncybG5URDUyTVo5?=
 =?utf-8?B?QjZiQ2pMajFIamFiS2g1TmFhQTd3a3hubmZBd3M2TWloaUlMUnZvWVJPSjVj?=
 =?utf-8?B?TmlTYUNzaUdIOHk2ZSszQldGYjVHVXFPVVZzQXBVNS9vU2lkRjd6a2tTeTNn?=
 =?utf-8?B?WkJpblYwU0xuUG5QT0JmWC92YUhKYVZySWdVQStuWG1JN0o5eW9Yc3g5a1Rn?=
 =?utf-8?B?Rkh2SGxVbkptQkoybjd5ck9GVFNxZEtCQVB2eGIxcWFZZVV1MndjSnFUcS91?=
 =?utf-8?B?TCt4NHJHTUZ2a1lJb2l5NEt0ZWdiL1RpTHhpZEU4Wk81ZVdUN1hIMWFYWWVU?=
 =?utf-8?B?eTdyNkErd2RNUzlFNHFRcVFGTDhkQVByYTQ2emx6NmlBTFJaQWplejhzQ2pY?=
 =?utf-8?B?dWRONzZqQkZGc3lvQnBZckxZb2pFc0xRano1aUowTUhTN1hZRnZRcFkvcWlU?=
 =?utf-8?B?ZmlaL2ZFdkZQTFBpazlRY2ZRYXd2dUY2Qm8rWHh1UHlCZzRBNTFpekRoRXEw?=
 =?utf-8?B?QWtPNmYzUU16RFpTNlZPek85V3VaZExoUlV2Tmh4cmlUeEM2aU5malBWaDJl?=
 =?utf-8?B?aGw0VXdhRU83dlJ2N20rRzd4TkE3NmZVOFVtLzJBand5WFdUaTR1eXJQeUhq?=
 =?utf-8?B?cEFNQWpydVgrR3BuMW1IN3pnbDl6RzM5cHVneDdibDQzM3JCWHA2UXB5cXdV?=
 =?utf-8?B?STNiV0ZmeFNTeDVLWHF2bG5MTlJZUDVsc3dHdGFTOG9jb2Q0Yit6bTVSUTd6?=
 =?utf-8?B?NWNDK3dhQUo4TUdRaFpjTDlNNzBNOFpab2t2dFg4VjQrbEVlN2xVNlA0cmJ6?=
 =?utf-8?B?Q0cvYnlCRVBHOFJsa1hMZUVpNkpScXJuTnRjRHl1a29qeElpWDVXaGlqWUN2?=
 =?utf-8?B?bVhIeDNvUmQxSm5ra1JzMkRYRjduWlpTNWlEb2NRekxaR1pBRUxETFBQbUpK?=
 =?utf-8?B?cnNJL25McVBPZ3VGc0Yxc0xudjBsbCsxRXBWTzB1SWdXZ0xKRXhVUWNucUxJ?=
 =?utf-8?B?RmtKQnNtb0xhSTB1UmlBOFVtTi9vNWtlai96aUc2ekJXN3orRlFuQ2FGcjhV?=
 =?utf-8?B?Vk5ncnBZcVdHcDRERXJMRC9yQnFrRWJtbkNvTThTN2kxN3FTZ2UzM01GODlj?=
 =?utf-8?B?ZEZLNjFEbzVRVmpPZWVkMDJPbXlncXpuU0l4aHJhSERzMjh3aEVBNGpsZk1Z?=
 =?utf-8?B?K0t3WmJodGVQeEMxSGZGblJKNUpEWlU4NGVNNzZ2NzJVd0JkZUtqVTZzYTRK?=
 =?utf-8?B?TlBnakRnUEhQcUNoQjBuaUhQNlJNallGS0U5T2h5MGFEK1NwTUVtRWhmcmo1?=
 =?utf-8?B?Q1dpeFVrNytTQjd6bmhYTGlVWWhFNVNDcGdpVEhSNkZRcFNZK0JhYy9adzZT?=
 =?utf-8?B?bHBFVzljdVVrTXBucGN0YktjQUptK2R1bTM5R0VrT1c1M2R0MXNxQXo5SUhM?=
 =?utf-8?B?OW5vTFNGdGNpTzZVdGg0R3hBbWpMT2pveVhGLzJxNGFzSjVacVdiK1FtZGI3?=
 =?utf-8?B?bGhWYkJ1V1N3WUtoUzVDNWZOWXdtaWk4STJGc0V2c2NkdS8vOUd0ZzgvU3Ba?=
 =?utf-8?Q?wYQbJ8xNuNTH5OVwHCg7I9R35zqqVGOp1ghFsmu?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71832ab9-6d9c-417d-da72-08d97e97ca47
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 13:41:04.6502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pt6qx2fqRD2LOHkpZQrfspVnCISpHIgIDkEshav2djq8zOPw5STSbyHtISxlqU5tl7KOVIpkTCWxGZfcN2tnZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5758
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgU2VwdGVtYmVyIDIzLCAyMDIxIDk6MzEgUE0NCj4gDQo+IE9uIFRodSwgU2VwIDIzLCAyMDIx
IGF0IDAxOjIwOjU1UE0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiANCj4gPiA+ID4gdGhp
cyBpcyBub3QgYSBmbG93IGZvciBtZGV2LiBJdCdzIGFsc28gcmVxdWlyZWQgZm9yIHBkZXYgb24g
SW50ZWwgcGxhdGZvcm0sDQo+ID4gPiA+IGJlY2F1c2UgdGhlIHBhc2lkIHRhYmxlIGlzIGluIEhQ
QSBzcGFjZSB0aHVzIG11c3QgYmUgbWFuYWdlZCBieSBob3N0DQo+ID4gPiA+IGtlcm5lbC4gRXZl
biBubyB0cmFuc2xhdGlvbiB3ZSBzdGlsbCBuZWVkIHRoZSB1c2VyIHRvIHByb3ZpZGUgdGhlIHBh
c2lkDQo+IGluZm8uDQo+ID4gPg0KPiA+ID4gVGhlcmUgc2hvdWxkIGJlIG5vIG1hbmRhdG9yeSB2
UEFTSUQgc3R1ZmYgaW4gbW9zdCBvZiB0aGVzZSBmbG93cywgdGhhdA0KPiA+ID4gaXMganVzdCBh
IHNwZWNpYWwgdGhpbmcgRU5RQ01EIHZpcnR1YWxpemF0aW9uIG5lZWRzLiBJZiB1c2Vyc3BhY2UN
Cj4gPiA+IGlzbid0IGRvaW5nIEVOUUNNRCB2aXJ0dWFsaXphdGlvbiBpdCBzaG91bGRuJ3QgbmVl
ZCB0byB0b3VjaCB0aGlzDQo+ID4gPiBzdHVmZi4NCj4gPg0KPiA+IE5vLiBmb3Igb25lLCB3ZSBh
bHNvIHN1cHBvcnQgU1ZBIHcvbyB1c2luZyBFTlFDTUQuIEZvciB0d28sIHRoZSBrZXkNCj4gPiBp
cyB0aGF0IHRoZSBQQVNJRCB0YWJsZSBjYW5ub3QgYmUgZGVsZWdhdGVkIHRvIHRoZSB1c2Vyc3Bh
Y2UgbGlrZSBBUk0NCj4gPiBvciBBTUQuIFRoaXMgaW1wbGllcyB0aGF0IGZvciBhbnkgcGFzaWQg
dGhhdCB0aGUgdXNlcnNwYWNlIHdhbnRzIHRvDQo+ID4gZW5hYmxlLCBpdCBtdXN0IGJlIGNvbmZp
Z3VyZWQgdmlhIHRoZSBrZXJuZWwuDQo+IA0KPiBZZXMsIGNvbmZpZ3VyZWQgdGhyb3VnaCB0aGUg
a2VybmVsLCBidXQgdGhlIHNpbXBsaWZpZWQgZmxvdyBzaG91bGQNCj4gaGF2ZSB0aGUga2VybmVs
IGhhbmRsZSBldmVyeXRoaW5nIGFuZCBqdXN0IGVtaXQgYSBQQVNJRCBmb3IgdXNlcnNwYWNlDQo+
IHRvIHVzZS4NCj4gDQo+IA0KPiA+IGp1c3QgZm9yIGEgc2hvcnQgc3VtbWFyeSBvZiBQQVNJRCBt
b2RlbCBmcm9tIHByZXZpb3VzIGRlc2lnbiBSRkM6DQo+ID4NCj4gPiBmb3IgYXJtL2FtZDoNCj4g
PiAJLSBwYXNpZCBzcGFjZSBkZWxlZ2F0ZWQgdG8gdXNlcnNwYWNlDQo+ID4gCS0gcGFzaWQgdGFi
bGUgZGVsZWdhdGVkIHRvIHVzZXJzcGFjZQ0KPiA+IAktIGp1c3Qgb25lIGNhbGwgdG8gYmluZCBw
YXNpZF90YWJsZSgpIHRoZW4gcGFzaWRzIGFyZSBmdWxseSBtYW5hZ2VkIGJ5DQo+IHVzZXINCj4g
Pg0KPiA+IGZvciBpbnRlbDoNCj4gPiAJLSBwYXNpZCB0YWJsZSBpcyBhbHdheXMgbWFuYWdlZCBi
eSBrZXJuZWwNCj4gPiAJLSBmb3IgcGRldiwNCj4gPiAJCS0gcGFzaWQgc3BhY2UgaXMgZGVsZWdh
dGVkIHRvIHVzZXJzcGFjZQ0KPiA+IAkJLSBhdHRhY2hfaW9hc2lkKGRldiwgaW9hc2lkLCBwYXNp
ZCkgc28gdGhlIGtlcm5lbCBjYW4gc2V0dXAgdGhlDQo+IHBhc2lkIGVudHJ5DQo+ID4gCS0gZm9y
IG1kZXYsDQo+ID4gCQktIHBhc2lkIHNwYWNlIGlzIG1hbmFnZWQgYnkgdXNlcnNwYWNlDQo+ID4g
CQktIGF0dGFjaF9pb2FzaWQoZGV2LCBpb2FzaWQsIHZwYXNpZCkuIHZmaW8gY29udmVydHMgdnBh
c2lkIHRvDQo+IHBwYXNpZC4gaW9tbXVmZCBzZXR1cHMgdGhlIHBwYXNpZCBlbnRyeQ0KPiA+IAkJ
LSBhZGRpdGlvbmFsIGEgY29udHJhY3QgdG8ga3ZtIGZvciBzZXR1cCBDUFUgcGFzaWQgdHJhbnNs
YXRpb24NCj4gaWYgZW5xY21kIGlzIHVzZWQNCj4gPiAJLSB0byB1bmlmeSBwZGV2L21kZXYsIGp1
c3QgYWx3YXlzIGNhbGwgaXQgdnBhc2lkIGluIGF0dGFjaF9pb2FzaWQoKS4gbGV0DQo+IHVuZGVy
bHlpbmcgZHJpdmVyIHRvIGZpZ3VyZSBvdXQgd2hldGhlciB2cGFzaWQgc2hvdWxkIGJlIHRyYW5z
bGF0ZWQuDQo+IA0KPiBBbGwgY2FzZXMgc2hvdWxkIHN1cHBvcnQgYSBrZXJuZWwgb3duZWQgaW9h
cyBhc3NvY2lhdGVkIHdpdGggYQ0KPiBQQVNJRC4gVGhpcyBpcyB0aGUgdW5pdmVyc2FsIGJhc2lj
IEFQSSB0aGF0IGFsbCBQQVNJRCBzdXBwb3J0aW5nDQo+IElPTU1VcyBuZWVkIHRvIGltcGxlbWVu
dC4NCj4gDQo+IEkgc2hvdWxkIG5vdCBuZWVkIHRvIHdyaXRlIGdlbmVyaWMgdXNlcnMgc3BhY2Ug
dGhhdCBoYXMgdG8ga25vdyBob3cgdG8NCj4gc2V0dXAgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIG5l
c3RlZCB1c2Vyc3BhY2UgcGFnZSB0YWJsZXMganVzdCB0byB1c2UNCj4gUEFTSUQhDQoNCmFoLCBn
b3QgeW91ISBJIGhhdmUgdG8gYWRtaXQgdGhhdCBteSBwcmV2aW91cyB0aG91Z2h0cyBhcmUgYWxs
IGZyb20NClZNIHAuby52LCB3aXRoIHRydWUgdXNlcnNwYWNlIGFwcGxpY2F0aW9uIGlnbm9yZWQu
Li4NCg0KPiANCj4gQWxsIG9mIHRoZSBhYm92ZSBpcyBxZW11IGFjY2VsZXJhdGVkIHZJT01NVSBz
dHVmZi4gSXQgaXMgYSBnb29kIGlkZWENCj4gdG8ga2VlcCB0aGUgdHdvIGFyZWFzIHNlcGVyYXRl
IGFzIGl0IGdyZWF0bHkgaW5mb3JtcyB3aGF0IGlzIGdlbmVyYWwNCj4gY29kZSBhbmQgd2hhdCBp
cyBIVyBzcGVjaWZpYyBjb2RlLg0KPiANCg0KQWdyZWUuIHdpbGwgdGhpbmsgbW9yZSBhbG9uZyB0
aGlzIGRpcmVjdGlvbi4gcG9zc2libHkgdGhpcyBkaXNjdXNzaW9uIA0KZGV2aWF0ZWQgYSBsb3Qg
ZnJvbSB3aGF0IHRoaXMgc2tlbGV0b24gc2VyaWVzIHByb3ZpZGUuIFdlIHN0aWxsIGhhdmUgDQpw
bGVudHkgb2YgdGltZSB0byBmaWd1cmUgaXQgb3V0IHdoZW4gc3RhcnRpbmcgdGhlIHBhc2lkIHN1
cHBvcnQuIEZvciBub3cNCmF0IGxlYXN0IHRoZSBtaW5pbWFsIG91dHB1dCBpcyB0aGF0IFBBU0lE
IG1pZ2h0IGJlIGEgZ29vZCBjYW5kaWRhdGUgdG8gDQpiZSB1c2VkIGluIGlvbW11ZmQuIPCfmIoN
Cg0KVGhhbmtzDQpLZXZpbg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
