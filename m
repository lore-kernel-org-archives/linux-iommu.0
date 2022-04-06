Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3ABC433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 10:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F01ED417D8;
	Wed,  6 Apr 2022 10:45:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s4_tLtkUvJzK; Wed,  6 Apr 2022 10:45:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3522141702;
	Wed,  6 Apr 2022 10:45:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12634C002C;
	Wed,  6 Apr 2022 10:45:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9464DC0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 10:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89B3760EB1
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 10:44:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A3Q_-B0TvVY1 for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 10:44:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F07260C27
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 10:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649241898; x=1680777898;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aychiyOSAjDiKbfpHo74G/ZESe5MIQMSsUVbe2SMkb8=;
 b=VEdzVK3dSZI9A4eAF3QtP/0TcyVa8LcuFNco0pujl4VLeirb38NXF/oo
 css5v8RBO3EcsKGGW7ecRz5lE1v1GJ00G59CcdFXqRPLoAkwtoanfOseQ
 Tp9zcfrSgPxapaUmER/4sMs8E+u3cjIsRb+sChyqWEZRgYn6BuvZ2fUKQ
 /K1StReDXSRXp4YMVjp8y1dJ7bzgDE7zI3NB+cEk88cqNlcaXY2EVULJ9
 11eFQjVvawd1T1AtlR5wJBdVC6mVIXOc7qOi8/KytK5WPlS5t1gl9/2tW
 4utCVyFOOChHEnDoiUmG1IPeH9z6b8pgmy+IS5NldVnc8nhLyln7qYl2Y g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="261188939"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; d="scan'208";a="261188939"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 03:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; d="scan'208";a="524417281"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga006.jf.intel.com with ESMTP; 06 Apr 2022 03:44:56 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 03:44:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 03:44:56 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 03:44:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSpWDkWi9AcJ4MqFxlvn6qrnjSdDnR13mmqkTmnSm94xEkK4WWiMZVb5eIx3vqAn/qAmhqzQXUcPSKfFA7X4Kn90gQg2R5nsCQbfRcAITel3/e09d6cQIG5d3L14AWK5WQmtC59WvDT+VwbLJH5VCeEb343u2/jd0jgdZxkutTL6Q0R49K95VbC6T85whzo9yGZ1k5qcUJjOfGoBteuW6pUGzVYDBtCIiZ0SLyzglkNqixD7FcxaW4un1PD+15XRtuNyJsOVeGcpwHKzpO+tbdjvM4aJeciuqyi7ZGu7CaFggzZigEAs1hydXjHM1ZV2g8hLidaz+aDM70u1TbHPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aychiyOSAjDiKbfpHo74G/ZESe5MIQMSsUVbe2SMkb8=;
 b=ogVChLy6AYLxo3+uL1MXQ9ZvudMHuf+ZxzBkxJA3BK0Nm1CbL28++niZA1EWUzAJ3IZtS/vV7s3QpuRIiD1f2huL6Tls2BMtv96cEA2E+x569UBsFedv5Aj24s2fsKUdMaw/SU/a5qOU1vMQKSgm9Ockcl+uU8zrr7burZHGjjBZBhQhh7XKdx6wAycYSff8PLzNOzz7qPFXCOTyav1R8xZQdCrWmbFBm33mQOaSzwELzEaQLPdSk0IHwXkXwmK0Y+TKt73cIXSkBBbK5ij1B9dY3wWbpp1+WSINdt1UzhOvbHvDCQilkW8f7J9UDOfXp3eF/Ey99aIEn4vM2q2jQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5460.namprd11.prod.outlook.com (2603:10b6:610:d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 10:44:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 10:44:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Topic: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Index: AQHYQy+FyOvFomDYNUS+m4eyrODKe6zWBZTwgAA4VICAASjOcIAAbdAAgAAjg7CAAAbnAIAELxCggAaGagCAAAkkMA==
Date: Wed, 6 Apr 2022 10:44:54 +0000
Message-ID: <BN9PR11MB527646AB4F3FE8E9F97ECB8D8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <BN9PR11MB527691E38BAC4F89FB17BDB98C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330143008.GB2111031@nvidia.com>
 <BL1PR11MB52718E663EF48C45D97FEEF38CE39@BL1PR11MB5271.namprd11.prod.outlook.com>
 <821dc298-47fb-6d06-ba75-de5d62a97b7a@linux.intel.com>
In-Reply-To: <821dc298-47fb-6d06-ba75-de5d62a97b7a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96470ac2-43c1-45dc-a2f8-08da17ba7c37
x-ms-traffictypediagnostic: CH0PR11MB5460:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH0PR11MB54609D23AF8DE80131389C978CE79@CH0PR11MB5460.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OQgrhdb53WOG71omzltmNOlFs6ZF2He9VyUvlF5nWIe2HBd4l5lQjezK0urXJIvyR9n/uXP6bddo9fB1z1FhgC2uWMr3N6XgwhCczLFtGPaRXJEY7M7Lmc7kREIQQG7E/eSHWV8jSrAypCyq1+foDjEa23SlIt5s+hxUV0q8nPDYZSrquQ8b0xSsZPhCaASBSOHSt1HrcMFo7qXRlWCEUXtTKtqKen0GFHW7yY+fEzarUkt1TZQFRe6MzNi253c2TDyGg3HmB5v2mwhHA8CMR9rszpEq/7CghRN/3ouhKbBjaEB4rkabWIJGNOu5jvVwBXcaKg1OKmF4e/H7tQF4oDDPvWyuooqrKeaPVWWEACgKZYSln6TaG7hx16dBrQcgAlkkafzhqJK7nmfvxzgMtonCytlzDg5GIrd+veqORNGLcd6uto2QPm5VLQ7kCQl0TQMMgyH3HMFPNke+b9CpIru4sF6W5Z5/RFlBDRFVAJ5bL/WwWlDqaGQa/x8WvKa9Cn9nWsS9OGnPFydkxuOpipd7MdrlUCGOGbP8Xx9Qf9yKR5A3czKkLWTKj+BfkZKY6+fOUsHGyonWrLyK6/U32A2LV5s/Jg7AXLMYsR2ryjoR8G6vbzdXUAEGgrOuQjuUfcf4jtc//UTn27EkZ6d2bOVHkeWyxYKpqeqOwL2D6IdV2c4KgraohL17iMaIqSTPngPiZpNuBKV2+oH2/m728g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(66946007)(76116006)(4326008)(52536014)(33656002)(66476007)(66556008)(66446008)(64756008)(110136005)(316002)(54906003)(8676002)(71200400001)(38100700002)(122000001)(38070700005)(86362001)(82960400001)(186003)(508600001)(26005)(7696005)(9686003)(6506007)(53546011)(55016003)(8936002)(5660300002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3pSKy85VkVnL0pnU2NWN3ZsZnJQZVNQL0gvWlg2RW9RU0FIOUNhQ2xjMGFW?=
 =?utf-8?B?ZExMWjNrU3N1VnpSMTFFTTF6a1hGWWJwbUl4UGVtV2dlKzkyYTBqcG9MUmpv?=
 =?utf-8?B?ZThLODZQWmFTdkpYU2hIaWVNRmRsS3k0dURQczl5SzZRWjhzR1hHcS8rVGZt?=
 =?utf-8?B?Z1puODhkRnBESXZRdWtyWnpub1k4M2M3WmQzTDB4SjNzSGd2UjR0dkRDdmpQ?=
 =?utf-8?B?RlZUZkZDOStyd0JmSHo4NUJsSUdZUlFHV2hxNW5RRWY3SlMrQ0hMcnJEMXMw?=
 =?utf-8?B?cTdqbGEyL2JoNmhiRmRyQ3JqOVhMMWtVcjFGVmhJY2o2aVcvd2luL3MrWjNV?=
 =?utf-8?B?S3I3cGQ1d2kraWJBNWo1YjVPU0JnellOV2txcVZyaWlPVG5aalhGTTBPeDc1?=
 =?utf-8?B?cHVQelZGN2Z5YlZwY0F4a2VVaFdZaHNDMnNTQWdia1pGSmRRWExBak5kOEdY?=
 =?utf-8?B?SXRnd2NJMHVxUnFIUmtlY0ZOeFV5Tm9wdE5GL3pINzdjN1BtbWY0ZkErRnRa?=
 =?utf-8?B?QThKR0tUOVFqOE1XcnJGWDczNVYrdHY3WDJ0KzRqSFJDbmJVT0lWR3hnVXpl?=
 =?utf-8?B?TGd6NXlmc2EzRGlra21sdFlYTXZUazQzMnZ2aTlaUVc2NmQ0cFU0dkdUY0xX?=
 =?utf-8?B?NjZDMFRNb05tVjNNcmpBVXVTUGFvV2RjdnVyWGpNS0JKcXBoZGcxSFlCSXlZ?=
 =?utf-8?B?azFrU1hwemJ5RTR6RlIvMmRoeGpoMjBDdmx2NjZna2VQVUhJZWlsOC9EcXZa?=
 =?utf-8?B?M3BXK05iRVk5RkRWdEh6aWhnS29mcWpjbitEMUV0dVlLTWowZEhxbWZxckk4?=
 =?utf-8?B?Sk5Sd0haZGV5cFNPL2RrZmZUSnd1VHI3VHJaeEZnVk0xM2dRbXFiR1lxb2NQ?=
 =?utf-8?B?ZGVVcWJyby9kR0xJdktrYXMxT1c1aGhlZ0s0bXZhcmRRYnB3VmVreHhZbVlv?=
 =?utf-8?B?emxwOFNhM0ZuMGFkMTk0L2F3eGYyNWh5KzNud1BDdWZ4WUN5NFdjblNSbzIr?=
 =?utf-8?B?V2t0RFlyaWZteTQ1blA5MnJpemJWdWx1YkxvaWNEM29VbUpRWld4dFpBNjFl?=
 =?utf-8?B?QXhKM0FXU1N3bDNhZkZRWHdqRS9WVEtPbFZDdWZiVFhnOWs1N2Vnd044VkFo?=
 =?utf-8?B?Nm83VUNTTUFtVnNyNFhibzkxTnFJZ0hraVlVNEZPeE9kQ3h4RDlQMkNkRE9r?=
 =?utf-8?B?ZC9qYlg4bHh6anpRU3UxUVNVSTJQNHlEcjNPbUlaUzZZQ3ZWQmJFOUE3Z2Y2?=
 =?utf-8?B?QnhWOFl6TWwwUnZXUVRya28ybVVNVFFWUnFZTklZYkM1aThVVlRrVjJKeTkv?=
 =?utf-8?B?UTRsRUFTeXRHeDhEQnJLblJIRU95UlV0NmVKS1FQWC95NG5wMEl2azloS0Zp?=
 =?utf-8?B?OEhnQUZ2aFNvUCsydHF3VHRaQzhHTHY4UWdMMFBBUjBwVER5SHArc1VDbjFh?=
 =?utf-8?B?ZWVhVnNyd3dXaEw2Z3AxYmxEZ1hFQzBIWGlEL1ViRGFEL29Lb2tPU2k3dnVp?=
 =?utf-8?B?MG5NMTBPOXQxRnlQMENSUWVyNGpHLy9udjJOM2ZPT3lrVUxDclY0VUVQOFpk?=
 =?utf-8?B?Tys5N3BtYUpZQWZKcHhJK1lHdE1UR1NycFU2ZFBpc01qbWFUL0N6NFBCVy9W?=
 =?utf-8?B?V1ZBWjRsVWd0cEZJV3VwZFFQYkw3cTNlUG5XM2R0R1pXYi9PbzE1ZVlsYkV5?=
 =?utf-8?B?dFVtUm03ZE81ZjFWVHFJWUZ5a25ZNUhDZXBKbDBJRUNNakJodUkzUndDeFZG?=
 =?utf-8?B?VVF6Q3ZTZ1BHNjdES0J5L2p0Q2ZaY1NrTnFDSjNGZnk5VjNrNWNTbWIwcUlM?=
 =?utf-8?B?NlBTYS8waVBkN1pIWkcyVTNIY3c2UE5KVlMwMmdhTk84a0l4R2ZFSThTRnF1?=
 =?utf-8?B?Ukdlcjd5RUtwdDRPR1gxOTFaMWYwbGVjRnlpN0Rlc0FWVDd0TXNJMG0rckZy?=
 =?utf-8?B?WVY0cW5TSFhyTzVITnNVVzFzNGNCM3JZVGJubGZjcndiWDNNT0dBWE9Pbm9r?=
 =?utf-8?B?emZENVhrZk9MaTYvd0lxZTF3bm9kbTZBVmVNekpuYjE5MENqQ0lPOWswS1FK?=
 =?utf-8?B?OUE2am42K1RQeVNiWE1XSGZrcXJBNjlid2I5b2p6UVB2YmtqbFk5SDhKVDlG?=
 =?utf-8?B?NTBuenFzOWpIVG5oekcxV3RRVnpVUDY2ZlRDK2wvcC9XcXZ0cGViYmZvUHRy?=
 =?utf-8?B?Z0tqTnBlbzJhYTVlWjJVSlBGd1NETGxIUFNqN1Q2SEJnejdiTTNuMVJlTVUz?=
 =?utf-8?B?VnYxekN5RWlnUm1vVEJVdnl5MmRBTWxqYzltdUhUYUk4RnlTUkoxUGs3Ykwr?=
 =?utf-8?B?Qy9VUWJMQnFHMEFHeHlxR3Bibms0enUrWlNXWWR2Nk9rKzBpWVo0UT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96470ac2-43c1-45dc-a2f8-08da17ba7c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 10:44:54.0785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xyqxR5xkGQHMHahQNaWdTdZSJbj+Q5DugJAOCRuGGE4Ty2gWEh9Dkq02AhvoBWUh4dchgAn0J9eCsdmltSIfOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5460
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 6, 2022 6:02 PM
> 
> Hi Kevin,
> 
> On 2022/4/2 15:12, Tian, Kevin wrote:
> >>>> Add a flag to the group that positively indicates the group can never
> >>>> have more than one member, even after hot plug. eg because it is
> >>>> impossible due to ACS, or lack of bridges, and so on.
> >>> OK, I see your point. It essentially refers to a singleton group which
> >>> is immutable to hotplug.
> >> Yes, known at creation time, not retroactively enforced because
> >> someone used SVA
> >>
> > We may check following conditions to set the immutable flag when
> > a new group is created for a device in pci_device_group():
> >
> > 1) ACS is enabled in the upstream path of the device;
> > 2) the device is single function or ACS is enabled on a multi-function device;
> > 3) the device type is PCI_EXP_TYPE_ENDPOINT (thus no hotplug);
> > 4) no 'dma aliasing' on this device;
> >
> > The last one is a bit conservative as it also precludes a device which aliasing
> > dma due to quirks from being treated as a singleton group. But doing so
> > saves the effort on trying to separate different aliasing scenarios as defined
> > in pci_for_each_dma_alias(). Probably we can go this way as the first step.
> >
> > Once the flag is set on a group no other event can change it. If a new
> > identified device hits an existing singleton group in pci_device_group()
> > then it's a bug.
> 
> How about below implementation?
> 
> /* callback for pci_for_each_dma_alias() */
> static int has_pci_alias(struct pci_dev *pdev, u16 alias, void *opaque)
> {
> 	return -EEXIST;
> }
> 
> static bool pci_dev_is_immutably_isolated(struct pci_dev *pdev)
> {
> 	/* Skip bridges. */
> 	if (pci_is_bridge(pdev))
> 		return false;
> 
> 	/* Either connect to root bridge or the ACS-enabled bridge. */
> 	if (!pci_is_root_bus(pdev->bus) &&
> 	    !pci_acs_enabled(pdev->bus->self, REQ_ACS_FLAGS))
> 		return false;

it's not sufficient to just check the non-root bridge itself. This needs to
cover the entire path from the bridge to the root port, as pci_device_group()
does.

> 
> 	/* ACS is required for MFD. */
> 	if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> 		return false;

Above two checks be replaced by a simple check as below:

	if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
		return false;

> 
> 	/* Make sure no PCI alias. */
> 	if (pci_for_each_dma_alias(pdev, has_pci_alias, NULL))
> 		return false;
> 
> 	return true;
> }
> 
> I didn't get why do we need to check the PCI_EXP_TYPE_ENDPOINT device
> type. Can you please elaborate a bit more?
> 

I didn't know there is a pci_is_bridge() facility thus be conservative
to restrict it to only endpoint device. If checking pci_is_bridge() alone
excludes any hotplug possibility, then it's definitely better.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
