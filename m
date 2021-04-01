Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16938C433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 13:38:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887DB61242
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 13:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887DB61242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4043684A7E;
	Thu,  1 Apr 2021 13:38:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UcD9X3Pwe29x; Thu,  1 Apr 2021 13:38:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A70884A56;
	Thu,  1 Apr 2021 13:38:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00ECDC000B;
	Thu,  1 Apr 2021 13:38:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66D2FC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 13:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53ADD40425
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 13:38:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0MyLRzQ-C3ui for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 13:38:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E26E140414
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 13:38:53 +0000 (UTC)
IronPort-SDR: njR6/eOSzP4O+ffSud3MYdx6dq+ZnzKr/VlX6+TTRu03BB7awlUKJNZKT27Kbx9Kz2k0Kf4Ics
 h2Xpvl7wqgtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="172275039"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="172275039"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2021 06:38:51 -0700
IronPort-SDR: jEOy2zBWUTt1C8k/h0rKvwNUlC7hfNpsUjPVaKWSE6GFzvUkq2MCsOY04DjpYGg5z0OrJ98Nvi
 AS/8LFBIFT8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; d="scan'208";a="394523192"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga002.jf.intel.com with ESMTP; 01 Apr 2021 06:38:51 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 06:38:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 1 Apr 2021 06:38:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 1 Apr 2021 06:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNrf906VsD/keDOn08b5RgbWi21Fwwhj3pfBvoU+dhRuZHwZP+MvHeRV6GJAFQzY7jlRIhg0HNT2EpoZaC4Ya7NnZtuK5ROPotJbc+afGTQH74FJIVqcQk/qlo7PPWvAnkqEzz8I5p6NbK6Fc1prE9WP+gjFpSCUoXkUsWGtLzrQaAZRhjCmqCwRHICBYt66x7TMhjThbYgM7TmC1nTqlkwa+7GLR49cauUdRjELHUq72MXHqF8AKQ/1g4u4ZfhjzbL6abUvsoay+yZ39d6bUJGeV6568NFZzbzw/M/hNgC8jF/aRS1IuoHZyr2AcwyH9uk6i/caHLSRllBfA83/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4aCZLcmRmvwTsMYLoQIOWyZA3fv3wdRCpydHL9DfLI=;
 b=X0trWTmyNE/ptjZRETJOTVlarUnvQIFsHQIAfaD+0TK40gSaI+Gdo2ZgCbTIWUm3tDUzPm9gIKc+yrCjC+qxdmPKPwVBXXxNAy1YvXQn1uuBJWOxSbsaMFD/w1rF7GNQC0SbJTAaxi5wJVxBJzKSmFCvz7KItpHrYSuE5C1Ci1Wk1hIFv7WZNOLyGvDv5taxWMWvRuwklLwwT++1WZmuQfImPGdv4QlvOTFU4jW8DYIyEXWNBJjAtXnD6d7hPV+4KRR6sDwfdf9FcE1l5VdPgcjOcDLs8/1+dNqTWLTqE1KFoPrufPr2J5ryKg4vwEiHIPU0bCtCiAUYXrbkOZlJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4aCZLcmRmvwTsMYLoQIOWyZA3fv3wdRCpydHL9DfLI=;
 b=Y2s0s9ndwp8QV+8vcu6anQzNVejo5EoYUt0qEUKawmESsOtMexzwI0l0wkoRxqdfkNRQOcNSUd4zI20YHN0Pex/Sj/7I5NJVzH7O1hbtHMFtDMbnSboP5hlguESpYF4nSIzreyNyuyF7uiJqE2CCTafPJfX2XsJ5pWHY+t4RKuM=
Received: from BN6PR11MB4068.namprd11.prod.outlook.com (2603:10b6:405:7c::31)
 by BN6PR1101MB2145.namprd11.prod.outlook.com (2603:10b6:405:51::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 1 Apr
 2021 13:38:46 +0000
Received: from BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d]) by BN6PR11MB4068.namprd11.prod.outlook.com
 ([fe80::5404:7a7d:4c2a:1c1d%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 13:38:46 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZuc1/oaTFwUU0WheDxUmLBHiqqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAmFuAgADGxQCAAR7PEIAAZiYAgAECgOCAACyd0IAAWUMAgAASa2A=
Date: Thu, 1 Apr 2021 13:38:46 +0000
Message-ID: <BN6PR11MB4068171CD1D4B823515F7EFBC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
References: <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <BN6PR11MB40687428F0D0F3B5F13EA3E0C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <YGW27KFt9eQB9X2z@myrica>
In-Reply-To: <YGW27KFt9eQB9X2z@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9344cd4a-79c0-4314-6f49-08d8f51379c7
x-ms-traffictypediagnostic: BN6PR1101MB2145:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB2145CCB977871AB42A82F36AC37B9@BN6PR1101MB2145.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bsDfV7YJc2Gw/eNdla+en6LxKVylTIbDy+UFi6lRroFxSo1nH8ChtqVPkRo/8YYupphmNcIRdsNxMqSVSDUEn+OZKsHT5lx7peKlojvv/lEtoDQpm2slwppJ2+p3osdW2zw3dcydoqCYcQrvlsCzNTZHN8SpgiyT6jRKtOASoZg2FFt9A2Q+Y1fYEJ3WJTNrvFKOdnkjJ8DEUBsAk5qMY7PBa+Xw1p+tQUSsxNHDlUWiHDnsGr8YPHEtELGrqEpryzq2YKuLhekCH9jwIKQ1VG7Nqauwf5M0Z9T+dMYNGDuU8CXHR67Gd5Gti+rQdhqYLHnBLAaFZl4p81MH1e2ZqHjkwKsWIpjndS8tgmCCySjsl+3kT/PtdZo11JYU7sKNemZBKEYI8WdZTwbm6VAOub+W11LUpXL8Ry4AKprcyptERI5qAIAWFORSTMp415lwagY4o+EiBTlCapJgxhvTUCY01HvEExKOopQAycSnhIxFjyhLz7ZzOEGBfobNOvz/yJBNV0HguokYPx/lwGKWGZJiUcysgG7Z/uoAba8QMdzZKNC/Pd/Itz7kX1F155xZK2YalLTGxuAWMtGcaYHI+qwikvaOp7xndNpDxw3VD5whYgMMpqqD6p2QDonvxlGLFqwtIpDCZkA1w/Ztm8LqQ6bQocRCqyrPYMsS+TdiNpc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR11MB4068.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(136003)(366004)(396003)(39860400002)(7416002)(5660300002)(316002)(71200400001)(38100700001)(478600001)(9686003)(4326008)(55016002)(86362001)(52536014)(66556008)(8676002)(7696005)(8936002)(6506007)(6916009)(4744005)(76116006)(186003)(66946007)(33656002)(66446008)(64756008)(66476007)(26005)(2906002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fBqjycj9eIoB16H7khX1xdPpJTy/m+tqPtipBuSpQOL2LPRX3ZckwM8hJ/7f?=
 =?us-ascii?Q?nBZHRO/8aRsVyrgibCfA9zMqOHExNwRLvCR89FzGUo+6srBOBf+wZMMwbV70?=
 =?us-ascii?Q?KfRmRW2Z7FT+HeRKviSdgUuVxadQcFeBwPnV9mDj4Bxj+feo4YiGFZcatn5K?=
 =?us-ascii?Q?zLZwl1ojN3DdYpYNI/AKYv9WvVBPAjgrgyPP9IG2G/lG+EDmJzQJQMzuGjU6?=
 =?us-ascii?Q?otDCQxVmPJopdpUqWkk8voeaBAp82FgBDZ4tGj+YBPNRf4akibshKtlQnLi3?=
 =?us-ascii?Q?Zgp3Gqw1JaBr+moHcuQwkI9SEAbVjm+mD6lmzM0nHnDvW5Rpsx5U4GAxeNFh?=
 =?us-ascii?Q?5wIcqeH+AzseRPKGY6Ck2zSW6Phe+0MvELT+An++uRzBZ7QbWVdPVcYwNjNp?=
 =?us-ascii?Q?/6n/Nnk2aUCQDiI6F6bpnPHexGiBp71IzP9Z9b3ZPg6jCpRPL5WOLsMRu2KR?=
 =?us-ascii?Q?bKgioIzVFe79dD8dSFAyCBjkd6j6d/T2/U2AckKpz/K8u4Yydt1cRVKgFp59?=
 =?us-ascii?Q?MGa07CWBf5gIyw6y3bqJjkcaU1MwLsvNd1uDvGHRqVFBMV+u0CTJ+LFo/TI4?=
 =?us-ascii?Q?21gtzahecM16GWw6Ap1pCASpt/NGT32tp0Iof1fmjLSuVfY3I1tSvDYyYThE?=
 =?us-ascii?Q?p20fwTdShZRNGakah9IN8k/nxyVDw9dPXBrdplRzwPso1dP61NJKun8GHMOu?=
 =?us-ascii?Q?UXHYfY9VdcMY5Ew8orG/oPS/g3U5AkcO0zEHjXMSGMQUXmJWC7xZK3/CXD7o?=
 =?us-ascii?Q?HP7OZgMGCUFutjZ9ovRwBic5C73N/BEmGcKq0PBvTu8czRZ4HUyUVmyujLQw?=
 =?us-ascii?Q?4RGVISazRwFJ5Mqmlc8A+4yYtfdw3Byw7tOG0fAaVq/J5elQtWz0CI7fXoiR?=
 =?us-ascii?Q?Bfx5owNRklLAV6ye4XpCHSHkF4din40WMRhdWccxoNddWAiOmI+sm0fkGzIR?=
 =?us-ascii?Q?xur+O/qnfNKQ+bX532O8XjL5LTSHGB6TnBJwEo5nNTg2BQ39p5+cCbiqQyVH?=
 =?us-ascii?Q?t/o3/rgnivgrd6g9awzFG+Ym8DwIpZjzJvG5VxyQf3z2qsonRjpZx0vW7a88?=
 =?us-ascii?Q?OltU1WPhJjxBrznNRyrw97wIansHEt4MRAdZF2wF7B/L62bl/mDCAgeP9tX4?=
 =?us-ascii?Q?Mvvku0aL5Tkz9WE3uzpwrov20WZ5asn+/W1ZBZMepzF/4EVjRof8SzqdbiyG?=
 =?us-ascii?Q?twPq8XCIQGtbeMNoHpAVxfXwCO9R5qOkPm80I3pfpt0Si5OfMVLbKoWzxlvf?=
 =?us-ascii?Q?GIxoJyWS3qsoV4g1rK2IuO4K+67NhjqOK7DmQPMZ88G12Bk9efWnezt0u2XM?=
 =?us-ascii?Q?JqkptOf1hSuPIshmkVcs2q0U?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4068.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9344cd4a-79c0-4314-6f49-08d8f51379c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 13:38:46.7273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICUTsduh1uGBXjpEwmdecOdmPOCY4pFD330t+0/Q6khAZSVG3sQah2TglLTsp8740XUwx7MfrE/d3UuD2lbDTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2145
X-OriginatorOrg: intel.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Alex
 Williamson <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu, 
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Thursday, April 1, 2021 8:05 PM
[...]
> 
> Also wondering about:
> 
> * Querying IOMMU nesting capabilities before binding page tables (which
>   page table formats are supported?). We were planning to have a VFIO cap,
>   but I'm guessing we need to go back to the sysfs solution?

I think it can also be with /dev/ioasid.

> 
> * Invalidation, probably an ioasid_fd ioctl?

yeah, if we are doing bind/unbind_pagtable via ioasid_fd, then yes,
invalidation should go this way as well. This is why I worried it may
fail to meet the requirement from you and Eric.

> * Page faults, page response. From and to devices, and don't necessarily
>   have a PASID. But needed by vdpa as well, so that's also going through
>   /dev/ioasid?

page faults should still be per-device, but the fault event fd may be stored
in /dev/ioasid. page response would be in /dev/ioasid just like invalidation.

Regards,
Yi Liu

> 
> Thanks,
> Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
