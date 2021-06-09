Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D111C48BCF
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 09:38:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364C961377
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 09:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364C961377
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3F4283C21;
	Wed,  9 Jun 2021 09:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YeYzHMPcrk9p; Wed,  9 Jun 2021 09:38:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D940983B1D;
	Wed,  9 Jun 2021 09:38:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB19EC000E;
	Wed,  9 Jun 2021 09:38:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C78DC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F8174033B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 99dRUwwSVM3x for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 09:38:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7542F400D4
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:38:41 +0000 (UTC)
IronPort-SDR: MMdkU3Rk+LQEio9Gneo3IZ/KXmfbjKqm9liD2I3Xq6DYGvf84ELe93GmVbZOZCql9mmkdi/w6B
 O8tSUQuc9t9A==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="205066638"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; d="scan'208";a="205066638"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 02:38:40 -0700
IronPort-SDR: o467rMdeKf21PQV/hnXCJfnq5t0z79A6eZE9Uy9xMPNUNfCb/68FbTDVVyuM9LlTWz9diBKMRu
 GaPraB4FkJKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; d="scan'208";a="449886365"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga008.fm.intel.com with ESMTP; 09 Jun 2021 02:38:39 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 9 Jun 2021 02:38:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 9 Jun 2021 02:38:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 9 Jun 2021 02:38:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 9 Jun 2021 02:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXqK6ujMqA8fXFpPoDGfvCU2OnjIxC/iCzAGE8LlYROZrbkbWy3wsvbix4xjAUhcXdlAxON22/ClWRPVfuHuS52pUexqMiMb4uav7XvShq/YvcLCGJ2luxyaj3g3SAqK715BwpjxilG1B0XUn5E6yYB9INkAc2GWCpCLPPMtFlHDvrUC61pz1JXrV+FqktPyGmbAGbs3z4qkcu0MWPtW3ijqzAORYG59/lIYSOYHP5I9RhmH3f9stMOA109aMYHmdQ/VHep7G1/S010eFYrCQSI0KeZYJ3fFYpcQvxVPG4Ihp7xJ2NESeOR420WYTRcpC1ag0E+vyK43p4ZbzleIAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbJHONPVub+osidIT4A8TP7Nf1Ar25wOcdGPIo3+4Io=;
 b=Mib25x5ZibW/ZMcYW1grm6AaNwKVSIrMMgo+prDC6XIQTgBiw5xhQy0b74hzMyuraTb7OJ+HxO04wW3l2kH0beOI1VNUyVt24bY7dUYWvt+243oLGzQJUV8DnuunNWY1BZu2M3N7LdlTubM+/Y8oyWV3n3sv1E/3aTKW7jZu9TCM23ipbRjdD9thvsmBHOPK5G3il7AEzKdREBl+g1sRCfmMCnYkawnfx3zfDZfYYFVeZKirO2QEtQMFbIVDxGRWbpVi1OWxPZRCp1wooQpnExH+cVGgvNsnMbja1xrke/yWhdQtZgBpjMXfqzibUaZazB1xdqz+gCOH+3d+evqlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbJHONPVub+osidIT4A8TP7Nf1Ar25wOcdGPIo3+4Io=;
 b=ea8mugZtdO3ouuwJDIcYtVGb94IwDkqERd23Iuh+m00DCiDRieu5sOB3yZxeB7PbghSlAfxtOf2dVdPiUV6hVbnTBgMqJ0zFyuG58McN+Oa/mo/uteAKN+sX5XucR/I3fumHvgAHG4AbnjQ6cgACAsQybSodYumf7NDxUXfYNyY=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2302.namprd11.prod.outlook.com (2603:10b6:301:5a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Wed, 9 Jun
 2021 09:37:39 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 09:37:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "Alex Williamson (alex.williamson@redhat.com)"
 <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 "Jason Wang" <jasowang@redhat.com>, "parav@mellanox.com"
 <parav@mellanox.com>, "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Shenming Lu <lushenming@huawei.com>
Subject: RE: Plan for /dev/ioasid RFC v2
Thread-Topic: Plan for /dev/ioasid RFC v2
Thread-Index: AddbO/WEUAFl3MPnRsG8exiH8bwEagBy43MAAAKwy+A=
Date: Wed, 9 Jun 2021 09:37:39 +0000
Message-ID: <MWHPR11MB1886FEFB5C8358EB65DBEA1A8C369@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <b1bb72b5-cb98-7739-8788-01e36ec415a8@redhat.com>
In-Reply-To: <b1bb72b5-cb98-7739-8788-01e36ec415a8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.80.65.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a926205a-c7f6-4c4b-04d0-08d92b2a3938
x-ms-traffictypediagnostic: MWHPR1101MB2302:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2302DD71C4E3E9B26AB31C2A8C369@MWHPR1101MB2302.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIOaCmKkEwBS7Ds72MWRWsBLHIaygrTEksQqiCbeGGkB/XdeSKl4YA2tiQYYDuCNGz2N3mth3OSDj1li0zlZk4TufS/hucofiRXFOCJr8OIRQjemveXo2ZI6WcvVCVLJaUquxPuJGnI2TT0zcJd8coATrQM6z4LTe5ZGJbFZhFzeJBIPLVk41gwSaYrOMoHSBlEJOb6omjRkK7eU4bgP9kfQVsKDswnzlGFi4fpbBD7BdQsD+YnOknFUBR7b3a4lQij2oMvd4KLO4EiHM7qWxWY8B8kiiiYsiFVCt7Xn+nOq6iICgo85EUmiyGT9WLEx6ID7fXYlmlVBFdYKpSoIS1hpXlDS7bgkXuXn/3qESnGx2c0khzH0z/Otwsb6czzx8E1JMy9aYGDpfdjyK00iZJc6iWJfIsdJ4IIBdxn6jOnx2yOXicpPXu9nZHPf534vcND31eMudOdcKGnjyMfo3X2JbRDG1f9KaHHs3nhHX2aKBTlaHuio5kyGpWLYagqEI7cOhi9R4uwEeojNWmdgxhj0OzISJWlN9Th/fOGB5gFv5JNckrCnsuW9buCJFMQujc554rqwfsmblfrrXRS1NYZAlJvMv+6VV0gISzFdZfLtfXwUJvpPW28g8NLi/0A54IiSmxbwE1XnD+Y4Ri32v8tvhTqOQ4Wmg0XnPok3PFo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(346002)(39860400002)(366004)(136003)(186003)(2906002)(4326008)(76116006)(64756008)(316002)(53546011)(54906003)(122000001)(26005)(8676002)(66476007)(66946007)(66556008)(66446008)(5660300002)(8936002)(86362001)(71200400001)(478600001)(921005)(7416002)(33656002)(38100700002)(110136005)(52536014)(83380400001)(6506007)(7696005)(55016002)(9686003)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXphQVZNZ0hDamtISEl0SFpiM1dhNG1aYmJqb0xONFlJOGhTdFNuVFNXTENw?=
 =?utf-8?B?TmtINGdXZndjN0Q1L2lNUmpYQW1JcDJDeTB0eFI0eE1yZThtTm1kajNJZWg4?=
 =?utf-8?B?dHlheG44NVhrSkhMVnJpeENZMlBjY05JTG5UNWtOd0VRcHdEcSs2ekdBMEVu?=
 =?utf-8?B?UlZINENJNm9yTXZHajRuNHBJUXBXUHJvM0tUTGNpa2lPd25HMkZHUmNuS204?=
 =?utf-8?B?Q2tuT0RrOUdXTEY3eXFhL09hU09TcUI5SDdsbHdTVFpQQ3pwVEdSMVhIRW9m?=
 =?utf-8?B?b0FZdi9HSG9rRE5qY1QrcWltU0JpbnZreHVhV1F2cy9OTHJhZGFUaFNnTzJu?=
 =?utf-8?B?ZkJVSXVGL3Z4RkFsVUgzNSszL3ZOaWdJWVNOVGVDMGJUTVRoVzdjNk51SzA5?=
 =?utf-8?B?Wkg2L3pRb1ZpOGM0RkRhQkx0RER1MXluZVNLRHc3c2JGVm9zMTVaQU5ZWmJB?=
 =?utf-8?B?WVNUczh5ZW5GN3g3VmI2a1BjYXZ4Q0hwckRYaEc2ZGM4N2ZKRXNjdUU1azdq?=
 =?utf-8?B?d21ra1UrcUlDNGRyMWJkMGRRSGg0aUt4a2tmMlF5V0M4aEk2TFBYaGJ2cVdu?=
 =?utf-8?B?YWJEWlRzbHZhQjNCcmprUEFpbGtpWUs0V0tJWTdqYU9xVStDcUhla0RIVVBy?=
 =?utf-8?B?MFZLT0pBREU4RVV6NTh1RmpORitnTEpkYWRtME12VW50VklPTTNkaEw2ZEhi?=
 =?utf-8?B?bExjZytNb3NZVndNVGtDZnhBQXhaRS8ySEtUc2pvM0RhMUhCL05mSDJWUXF1?=
 =?utf-8?B?NkJVYXVnWlBFWVBSVnRoVmJzM3laNGZEOXVpY05BOGFJQXdsZjk3YXp3RStC?=
 =?utf-8?B?RWNrYXVQMUYyNFNrNCtYUW0xVDc2NXU2V2pUeE9LeThBeGhIdzF1VUdpRmJR?=
 =?utf-8?B?b3NoeHI5bnd4Y2xpczZrSHlsRlZpaTkram4zR0VYTEhMR1FPeDl2MEVRSjhv?=
 =?utf-8?B?ZkdZVWo1V2p2NHhPRkF2SXRQZGRKcC8vSjJmUnZtcGd3c2Y0UGFiLzVJMUw4?=
 =?utf-8?B?NjFpSnpzOUhJcXhjbzRCNXFFM3V4QVNEK2p1ckNUZVNZTzVQb1pKcTlHVU5Y?=
 =?utf-8?B?TjJQQldyZVVrTDQxV1pEVjlwdGdWWVRHbGNvd29QSENuc091MVV3YnZwNXZw?=
 =?utf-8?B?N0I4elQyMGE3b21XcHRKbTZOaERIQUNDL1Q0WFpqc2laWXhsWEhyZjVHbHJ1?=
 =?utf-8?B?c3E4NUl6Mnl4bmxaOStjTVNsaU9sTGdKVlZXbDVSS1RoQTZGN2xleDIxRTVa?=
 =?utf-8?B?ZU00czA3N2RzQy93bU81d29BTDBYNzJ1b1RzTXBaYUhFMllEOTJNNnRQak1o?=
 =?utf-8?B?ZXUzV3ZERXlKYWxFSkJuN3F5cVZ2a2lwbS9NYTRIRkNlVW1xOWxWRXBielp4?=
 =?utf-8?B?MjYvWGFHaFFNRjRkV2NONFlGT09uMnY3eFhpRVpackdQZkxyblliYkp6RzVu?=
 =?utf-8?B?WWV6WjZqSkdIZjE3ek5vY2Zyam5kZkk0QTM5SGVtUVhCU2duOHplRXhKVXVy?=
 =?utf-8?B?citjREJtV3pvakV2VG0vVlBrbFNuNWR5TlZtRnRMaEFieUU0RUU3OWZVL29E?=
 =?utf-8?B?QnhmYUpEZFUzeHUyNW5qOTFuYVJVRHd1WStIVzFlSDNQeVgwL2FyZS96cW9Y?=
 =?utf-8?B?RG9jTG9qMytKcStIeDlGakEycVdHZXNXZzFyZHRjRnZrMXNUWTdycTZSZVFO?=
 =?utf-8?B?S1E2MS9udGNrVWM0Y0lKQWNSbnd0OXpOaEJ3SExqeGRKUFdmWFBFY3NaMWI0?=
 =?utf-8?Q?Q7IpWHhn0p8gXc3Xyo=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a926205a-c7f6-4c4b-04d0-08d92b2a3938
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 09:37:39.5520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krPYw9Qw5JHJLWRZnNdxE2BwuAl+5L80wh2KVzERenJVscAghbP3UMH+hwT2Tiq6FRP8D5V1jOlXvR8XfRVZvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2302
X-OriginatorOrg: intel.com
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Kirti
 Wankhede <kwankhede@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
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

> From: Eric Auger <eric.auger@redhat.com>
> Sent: Wednesday, June 9, 2021 4:15 PM
> 
> Hi Kevin,
> 
> On 6/7/21 4:58 AM, Tian, Kevin wrote:
> > Hi, all,
> >
> > We plan to work on v2 now, given many good comments already received
> > and substantial changes envisioned. This is a very complex topic with
> > many sub-threads being discussed. To ensure that I didn't miss valuable
> > suggestions (and also keep everyone on the same page), here I'd like to
> > provide a list of planned changes in my mind. Please let me know if
> > anything important is lost.  :)
> >
> > --
> >
> > (Remaining opens in v1)
> >
> > -   Protocol between kvm/vfio/ioasid for wbinvd/no-snoop. I'll see how
> >     much can be refined based on discussion progress when v2 is out;
> >
> > -   Device-centric (Jason) vs. group-centric (David) uAPI. David is not fully
> >     convinced yet. Based on discussion v2 will continue to have ioasid uAPI
> >     being device-centric (but it's fine for vfio to be group-centric). A new
> >     section will be added to elaborate this part;
> >
> > -   PASID virtualization (section 4) has not been thoroughly discussed yet.
> >     Jason gave some suggestion on how to categorize intended usages.
> >     I will rephrase this section and hope more discussions can be held for
> >     it in v2;
> >
> > (Adopted suggestions)
> >
> > -   (Jason) Rename /dev/ioasid to /dev/iommu (so does uAPI e.g. IOASID
> >     _XXX to IOMMU_XXX). One suggestion (Jason) was to also rename
> >     RID+PASID to SID+SSID. But given the familiarity of the former, I will
> >     still use RID+PASID in v2 to ease the discussoin;
> >
> > -   (Jason) v1 prevents one device from binding to multiple ioasid_fd's. This
> >     will be fixed in v2;
> >
> > -   (Jean/Jason) No need to track guest I/O page tables on ARM/AMD.
> When
> >     a pasid table is bound, it becomes a container for all guest I/O page
> tables;
> while I am totally in line with that change, I guess we need to revisit
> the invalidate ioctl
> to support PASID table invalidation.

Yes, this is planned when doing this change.

> >
> > -   (Jean/Jason) Accordingly a device label is required so iotlb invalidation
> >     and fault handling can both support per-device operation. Per Jean's
> >     suggestion, this label will come from userspace (when VFIO_BIND_
> >     IOASID_FD);
> 
> what is not totally clear to me is the correspondance between this label
> and the SID/SSID tuple.
> My understanding is it rather maps to the SID because you can attach
> several ioasids to the device.
> So it is not clear to me how you reconstruct the SSID info
> 

Yes, device handle maps to SID. The fault data reported to userspace
will include {device_label, ioasid, vendor_fault_data}. In your case
I believe SSID will be included in vendor_fault_data thus no reconstruct
required. For Intel the user could figure out vPASID according to device_
label and ioasid, i.e. no need to include PASID info in vendor_fault_data.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
