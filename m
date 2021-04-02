Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DD6C433B4
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 12:47:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1956113D
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 12:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1956113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20B264064D;
	Fri,  2 Apr 2021 12:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rTNObAq3huuG; Fri,  2 Apr 2021 12:47:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id C22B240001;
	Fri,  2 Apr 2021 12:47:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94325C000B;
	Fri,  2 Apr 2021 12:47:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F364C000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 12:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E43F684CA7
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 12:47:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id viu3-wpma55I for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 12:47:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E70B84C86
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 12:47:00 +0000 (UTC)
IronPort-SDR: KYVvycR8T4kSV9xqeCdpwT2rgnQ4Iny9kPSp0rSFqLmEJlq04heyDA4Muk31FS3/Zj5FxaZG7K
 LGp+ix57rCVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="253796442"
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; d="scan'208";a="253796442"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2021 05:46:59 -0700
IronPort-SDR: e7/M+yaC/pkVlN/RO/bdrMJHLEmB8GQ5fSdxk07+I1QtzrallsimVG3V/QkD++grgo/1f13HLu
 vhtB7HWk/gOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; d="scan'208";a="528594375"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga004.jf.intel.com with ESMTP; 02 Apr 2021 05:46:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 05:46:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 05:46:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 2 Apr 2021 05:46:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 2 Apr 2021 05:46:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmhaD1YscydZlCvwQzr4yqwWaVTBCnaIDnLCu4AS+GmyFqLKWP3gDfCV35eMaN3X4UG+kTyi/mJiNwso8UtcJW5c3usVlQI0vjR2rNXNmjZ/ySzXxAQ+9R0GPnIdRtjCyqqYRwNzBgheMit14FTAj7k8bo9zgLsgg0ZO1iNUgpdb+KoGc8zWRohlOX6aYdkVCFKbc8T1TSAm0W+ZrjTzl5OXMWP4IrfGXikWiVohXuHW7ZjAc6h1ZPbb/pvL86j9XFE6ZThuC2OpRErnjhtLozMCDSIGFa9taXpCjZHHCMSUTzoTFv979e1q6dLtOnZZ5aOnix77uR1poCOquq+Lqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm7NTg3K0kFXE8D3AyfvDPNcSWG4w49e2zUafSmcjVM=;
 b=eCGOGSa6YYhN21GadSN6VBAwv8qNrSz+tTSSZTxFPnLrXOxP9j3lCK8uHZSkxYT1ZtADgRz3xWIPUuqXMkDLu8bqmJajB6uMQPNODe3rbrfAOag0+QDgh0lPdL0HutNKfGaRI7WtFlyzuiW7OGDMOU6rkdInuCMUulPTgYMqRhKLn/LgIE7VjPmnHNSj9O4z/5GdUebGIaze3rNNGqpJwPqCR8ScX6mjp6PfZic36RH+juRGEnposTMiagOvhQ3s0+rAD7/ipHOjFFXxH/+TTWZwaAsFC5tfyMvNz9+an+yRsz0zLp4yhfxoM+5ZRj/DTaJB6930aoidf4kHtIw9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm7NTg3K0kFXE8D3AyfvDPNcSWG4w49e2zUafSmcjVM=;
 b=TGedR3cAugb/H7EiEWHu0lVhu+TBlyWHaAjxXXPiyOxKmoIz+z/7REdPsSj7AOz7yPyKQFkCqCFIFCMjltNIUc0yzkT1zzoeWs12j7KJw23cWn/nd5HCGtdnJNf/z0G3hsvVctyoY70wbA/Sx35H+/8bGEL66iB4fsHPfnjhfYQ=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN6PR1101MB2291.namprd11.prod.outlook.com (2603:10b6:405:53::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 12:46:56 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3977.033; Fri, 2 Apr 2021
 12:46:56 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAmFuAgADGxQCAAR7PEIAAZiYAgAECgOCAACyd0IAAVlOAgAAaQIA=
Date: Fri, 2 Apr 2021 12:46:55 +0000
Message-ID: <BN6PR11MB4068B9036B42149B67B91596C37A9@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401115429.GY1463678@nvidia.com>
In-Reply-To: <20210401115429.GY1463678@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fd8c775-90e3-400c-8504-08d8f5d5660e
x-ms-traffictypediagnostic: BN6PR1101MB2291:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB2291AE9ACB1CD6E13F41A065C37A9@BN6PR1101MB2291.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VHuLtGSHAXT83VnuWAXXjWDclChdBZjltP16MljkSGpXA5k8pLOOclujKvmI5PTdH03TVJDDv9NX2UxNqluEzFfOZMx2+8tsFHjjk64/9w7m8C3cJFrmIxrCCyK1CwRISvC5o7TMgqiuUz60aAbghnW3CwxggdH2c2yO6WEC8iVlpN3yT/27zNE8s8+oeMUIUnY4PizwzV9NLAD+0kEovWa4JJGoRwwBjz+9qnEuGeKltXzH2Z86Qqw6RZ6togAnLRstXWUwJq02NER8xyKy5jdhIj02UEuoG+yvYNx/RBZV9ZF8TzLmxV2vtdy9/riKCwPjj835zTabYJ58W1Pyegk9AENL4bO+s7hU9Ff9FRCheJjhD8hOWGYkM/VwcXjgQj9i1aOZLA7d9HH/OAwO+gVz7UAyyilAAjOq4KFkiGSCBj7Np2zUH1DZUhc4zl2U/QHbPYQUD9EFBja66OMyUI/LRt573M1xlp88q+UwfQmUJQO/ukdbCejutyXj31/dkb3ZyZ5MasCEywN0+B4Q4r7hEw6qp9yrbO+PpD4r/d3JUJk0HsOaQDRNjGo3LW4Igd9XP/BhsTP4xUbVF6nmXQ+hXZgNTC22cWeURA/fxGoXm8zvL+UjVLsPb0Z51NHGJ6OtAtFhtbBADUN2wsNEiRGEu9sQN7xz345t+V9O5n1ntyks33XNbpmd1Feuc5kS2q6GGgcOHU68Kl1vODWhLC9pU6gdbKMCtptZWfK75LR+NOaQ99kjwv6LDUMFCaB4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR11MB4068.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(346002)(136003)(376002)(39860400002)(66946007)(38100700001)(26005)(966005)(478600001)(5660300002)(66556008)(64756008)(66476007)(66446008)(186003)(4326008)(76116006)(8936002)(7416002)(2906002)(316002)(6916009)(8676002)(71200400001)(84040400003)(9686003)(7696005)(54906003)(55016002)(86362001)(83380400001)(52536014)(33656002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HCWQoH2mwURWF3/vJPFjwdB+C87OY8WOZdGckimFOQ+RG90yLSHKI3mM/DWJ?=
 =?us-ascii?Q?hlbtVhd++8jNvP2hlJKr77WqCLfPDvMChAS6XcfTK6ovJKZq+KNYnr5LDMAs?=
 =?us-ascii?Q?G66Rct9Xjec0upmiTRLgT1y+4cLK2fqwwVjyr7ydumi4LNncd3PUVF1pykWn?=
 =?us-ascii?Q?hBlYnPk9EsDDbKv50UhlFTS3sAVMHPX873J3WJP8/wqfmVp1TRn9Ap+16ziI?=
 =?us-ascii?Q?nYR8xaHdEmTeQZnEmPXdoV75CvkL/0wfqquHt3HqhTrb6+mU/DaWTOHz3/or?=
 =?us-ascii?Q?QzFL3TdJ/AbKXwl2iYfpwzMwWQqrkX71WtkIX1y4OHKinetv/KgmtDcno61O?=
 =?us-ascii?Q?+TTlrrZUTMFlVUv4w7NDkMI5xNLaRiHnqI6zQ5O44zSJfJdGdoofouok6PEY?=
 =?us-ascii?Q?LDalyPXE4z4C/rhD3++82Nl+jjjmswDGrICtBhOszrrLsku+tD84QrGTNTId?=
 =?us-ascii?Q?idhLEo7jKog/oHL/iFLCTHoAgzkdZqSU921xGbZYDuzArvmTfo8XccEVNXqA?=
 =?us-ascii?Q?4JydLh688lEZUYNPpjmVP1TCosgBLF3qRlY+1XMqnnJ55HoUmY9AsmjlXRmV?=
 =?us-ascii?Q?AHBssKMLCSccG/LiN30x+y9+zL/JyXNmKDtp+N6d00ufYuDVmnUszlHAj8nT?=
 =?us-ascii?Q?4LUpm19mU1po9VxtEW6T5YYYD7ouAua4pW63EO1XV/8amBCTyPxZ7ViMNhns?=
 =?us-ascii?Q?9HeI/2wD09QCAEXNf4ld3tRAhiuPnUVFtZ/Lbho8dZRTx8Kz/R/LVQdCjZKy?=
 =?us-ascii?Q?G/f4CYwSlgs/lGsxjQKOfUHxtect3QpRXkT+2o72tfmPWb9TQ+fv5fhdI76v?=
 =?us-ascii?Q?z79eKUczTMIdvnqF0K/QqlgWpD1iZzeCyy99E08mu3H98iXT0M3xuhkfYMSb?=
 =?us-ascii?Q?SU3U333K/A9jCOyodZ4dSjDPG6mbMYE3Zs8zUfNRpq4bPjdaR2qSVE/2EeRC?=
 =?us-ascii?Q?96e6XF8bRIXDQkCzjo/uVHEf6pP5ONjwtTonYOk58G5j258jXFDHE7cGE6j6?=
 =?us-ascii?Q?M5ae5AFpFXQ9ASHu7f6KK9YX3hEIoE7tIJmYXLIx4XvmDhmCMTDN1zpk3O/X?=
 =?us-ascii?Q?wqDis4w5m4Y1kbW1sA1/vdxKPBFGlfUUGSZLIA88N88O9thLbgLhqUqDXIA6?=
 =?us-ascii?Q?YQB/aPjq4mSCdOevzSXrS49ILHwiQGjykg/kXMkJ3f3e3gi80n4SwGmnJOHs?=
 =?us-ascii?Q?c0begdV9n07ojrslFv8j4/RnfgTO0O4yBhJ4VMyF6WCoie3kOrokk1NuP6Bc?=
 =?us-ascii?Q?CJ/ecKpAIkIuM1lIDp9e6EluZNm7yWvmMtA+f2QazLTpUNL69ME4A8f+I8FQ?=
 =?us-ascii?Q?KDNUqMuDkwYpoQoewE9LoWsa?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd8c775-90e3-400c-8504-08d8f5d5660e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 12:46:55.9763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oW+m2QN4IuIqxAOt0hSUaU3VoQ1n+c/fE2VRRwcGa9+xorQ7DE+rlFDXVTPqieyIgw4aSy4Atd1jeq1dY4NDDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2291
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, Jean-Philippe
 Brucker <jean-philippe@linaro.com>, LKML <linux-kernel@vger.kernel.org>, "Jiang,
 Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 1, 2021 7:54 PM
> 
> On Thu, Apr 01, 2021 at 07:04:01AM +0000, Liu, Yi L wrote:
> 
> > After reading your reply in https://lore.kernel.org/linux-
> iommu/20210331123801.GD1463678@nvidia.com/#t
> > So you mean /dev/ioasid FD is per-VM instead of per-ioasid, so above
> skeleton
> > doesn't suit your idea.
> 
> You can do it one PASID per FD or multiple PASID's per FD. Most likely
> we will have high numbers of PASID's in a qemu process so I assume
> that number of FDs will start to be a contraining factor, thus
> multiplexing is reasonable.
> 
> It doesn't really change anything about the basic flow.
> 
> digging deeply into it either seems like a reasonable choice.
> 
> > +-----------------------------+-----------------------------------------------+
> > |      userspace              |               kernel space                    |
> > +-----------------------------+-----------------------------------------------+
> > | ioasid_fd =                 | /dev/ioasid does below:                       |
> > | open("/dev/ioasid", O_RDWR);|   struct ioasid_fd_ctx {                      |
> > |                             |       struct list_head ioasid_list;           |
> > |                             |       ...                                     |
> > |                             |   } ifd_ctx; // ifd_ctx is per ioasid_fd      |
> 
> Sure, possibly an xarray not a list
> 
> > +-----------------------------+-----------------------------------------------+
> > | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> > |       ALLOC, &ioasid);      |   struct ioasid_data {                        |
> > |                             |       ioasid_t ioasid;                        |
> > |                             |       struct list_head device_list;           |
> > |                             |       struct list_head next;                  |
> > |                             |       ...                                     |
> > |                             |   } id_data; // id_data is per ioasid         |
> > |                             |                                               |
> > |                             |   list_add(&id_data.next,                     |
> > |                             |            &ifd_ctx.ioasid_list);
> > |
> 
> Yes, this should have a kref in it too
> 
> > +-----------------------------+-----------------------------------------------+
> > | ioctl(device_fd,            | VFIO does below:                              |
> > |       DEVICE_ALLOW_IOASID,  | 1) get ioasid_fd, check if ioasid_fd is valid |
> > |       ioasid_fd,            | 2) check if ioasid is allocated from ioasid_fd|
> > |       ioasid);              | 3) register device/domain info to /dev/ioasid |
> > |                             |    tracked in id_data.device_list             |
> > |                             | 4) record the ioasid in VFIO's per-device     |
> > |                             |    ioasid list for future security check      |
> 
> You would provide a function that does steps 1&2 look at eventfd for
> instance.
> 
> I'm not sure we need to register the device with the ioasid. device
> should incr the kref on the ioasid_data at this point.
> 
> > +-----------------------------+-----------------------------------------------+
> > | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> > |       BIND_PGTBL,           | 1) find ioasid's id_data                      |
> > |       pgtbl_data,           | 2) loop the id_data.device_list and tell iommu|
> > |       ioasid);              |    give ioasid access to the devices
> > |
> 
> This seems backwards, DEVICE_ALLOW_IOASID should tell the iommu to
> give the ioasid to the device.
> 
> Here the ioctl should be about assigning a memory map from the the
> current
> mm_struct to the pasid
> 
> > +-----------------------------+-----------------------------------------------+
> > | ioctl(ioasid_fd,            | /dev/ioasid does below:                       |
> > |       UNBIND_PGTBL,         | 1) find ioasid's id_data                      |
> > |       ioasid);              | 2) loop the id_data.device_list and tell iommu|
> > |                             |    clear ioasid access to the devices         |
> 
> Also seems backwards. The ioctl here should be 'destroy ioasid' which
> wipes out the page table, halts DMA access and parks the PASID until
> all users are done.
> 
> > +-----------------------------+-----------------------------------------------+
> > | ioctl(device_fd,            | VFIO does below:                              |
> > |      DEVICE_DISALLOW_IOASID,| 1) check if ioasid is associated in VFIO's    |
> > |       ioasid_fd,            |    device ioasid list.                        |
> > |       ioasid);              | 2) unregister device/domain info from         |
> > |                             |    /dev/ioasid, clear in id_data.device_list  |
> 
> This should disconnect the iommu and kref_put the ioasid_data

thanks for the comments, updated the skeleton a little bit, accepted your Xarray
and kref suggestion.

+-----------------------------+------------------------------------------------+
|      userspace              |               kernel space                     |
+-----------------------------+------------------------------------------------+
| ioasid_fd =                 | /dev/ioasid does below:                        |
| open("/dev/ioasid", O_RDWR);|   struct ioasid_fd_ctx {                       |
|                             |        struct xarray xa;                       |
|                             |       ...                                      |
|                             |   } ifd_ctx; // ifd_ctx is per ioasid_fd       |
+-----------------------------+------------------------------------------------+
| ioctl(ioasid_fd,            | /dev/ioasid does below:                        |
|       ALLOC, &ioasid);      |   struct ioasid_data {                         |
|                             |       ioasid_t ioasid;                         |
|                             |       refcount_t refs;                         |
|                             |       ...                                      |
|                             |   } id_data; // id_data is per ioasid          |
|                             |                                                |
|                             |   refcount_set(&id_data->refs, 1);             |
+-----------------------------+------------------------------------------------+
| ioctl(device_fd,            | VFIO does below:                               |
|       DEVICE_ALLOW_IOASID,  | 1) get ioasid_fd, check if ioasid_fd is valid  |
|       ioasid_fd,            | 2) check if ioasid is allocated from ioasid_fd |
|       ioasid);              | 3) inr refcount on the ioasid                  |
|                             | 4) tell iommu to give the ioasid to the device |
|                             |    by an iommu API. iommu driver needs to      |
|                             |    store the ioasid/device info in a per       |
|                             |    ioasid allow device list                    |
|                             | 5) record the ioasid in VFIO's per-device      |
|                             |    ioasid list for future security check       |
+-----------------------------+------------------------------------------------+
| ioctl(ioasid_fd,            | /dev/ioasid does below:                        |
|       BIND_PGTBL,           | 1) find ioasid's id_data                       |
|       pgtbl_data,           | 2) call into iommu driver with ioasid, pgtbl   |
|       ioasid);              |    data, iommu driver setup the PASID entry[1] |
|                             |    with the ioasid and the pgtbl_data          |
+-----------------------------+------------------------------------------------+
| ioctl(ioasid_fd,            | /dev/ioasid does below:                        |
|       CAHCE_INVLD,          | 1) find ioasid's id_data                       |
|       inv_data,             | 2) call into iommu driver with ioasid, inv     |
|       ioasid);              |    data, iommu driver invalidates cache        |
+-----------------------------+------------------------------------------------+
| ioctl(ioasid_fd,            | /dev/ioasid does below:                        |
|       UNBIND_PGTBL,         | 1) find ioasid's id_data                       |
|       ioasid);              | 2) call into iommu driver with ioasid, iommu   |
|                             |    driver destroy the PASID entry to block DMA |
|                             |    with this ioasid from device                |
+-----------------------------+------------------------------------------------+
| ioctl(device_fd,            | VFIO does below:                               |
|      DEVICE_DISALLOW_IOASID,| 1) check if ioasid is associated in VFIO's     |
|       ioasid_fd,            |    device ioasid list                          |
|       ioasid);              | 2) tell iommu driver to clear the device from  |
|                             |    its per-ioasid device allow list            |
|                             | 3) put refcount on the ioasid                  |
+-----------------------------+------------------------------------------------+
| ioctl(ioasid_fd,            | /dev/ioasid does below:                        |
|       FREE, ioasid);        |  list_del(&id_data.next);                      |
+-----------------------------+------------------------------------------------+

[1] PASID entry is an entry in a per-device PASID table, this is where the
    page table pointer is stored. e.g. guest cr3 page table pointer. Setup
    PASID entry in a device's PASID table means the access is finally grant
    in IOMMU side.

I kept FREE as it seems to be more symmetric since there is an ALLOC
exposed to userspace. But yeah, I'm open with removing it all the same
if it's really unnecessary per your opinion.

Need your help again on an open.
The major purpose of this series is to support vSVA for guest based on
nested translation. And there is another usage case which is also based
on nested translation but don't have an ioasid. And still, it needs the
bind/unbind_pgtbl, cache_invalidation uAPI. It is gIOVA support. In this
usage, page table is a guest IOVA page table, VMM needs to bind this page
table to host and enabled nested translation, also needs to do cache
invalidation when guest IOVA page table has changes. It's very similar
with the page table bind of vSVA. Only difference is there is no ioasid
in the gIOVA case. Instead, gIOVA case requires device information. But
with regards to the uAPI reusing, need to fit gIOVA to /dev/ioasid model.
As of now, I think it may require user space passes a device FD to the
BIND/UNBIND_PGTBL and CAHCE_INVLD ioctl, then iommu driver can bind the
gIOVA page table to a correct device. Not sure if it looks good. Do you
have any suggestion on it?

[...]
> Include a sequence showing how the kvm FD is used to program the
> vPASID to pPASID table that ENQCMD uses.
>
> Show how dynamic authorization works based on requests from the
> guest's vIOMMU

I'd like to see if the updated skeleton suits your idea first, then
draw a more complete flow to show this.

Regards,
Yi Liu

> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
