Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE5FC433ED
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 22:53:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3318961934
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 22:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3318961934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9E9060DC1;
	Tue, 11 May 2021 22:53:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sYv-T71Z30D0; Tue, 11 May 2021 22:53:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A0E860DBD;
	Tue, 11 May 2021 22:53:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DDCEC000E;
	Tue, 11 May 2021 22:53:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41E6FC0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 22:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 303D060DBD
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 22:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z6l6iz0mK7lb for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 22:53:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3D9760DBB
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 22:53:23 +0000 (UTC)
IronPort-SDR: Ct39x3jhlNTP37v3PSpv1ANybuvHc8e8v520WRDQLGxJ07MKBq38o9ruZOxnuGRy7RviBUq//4
 DL9WvLelF6Iw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="179162958"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; d="scan'208";a="179162958"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2021 15:53:23 -0700
IronPort-SDR: 11WON0ZgvuVzPxLKOKiuT/WEp0/YUeaEIqfntSS6dW/sGVbrNF6XYCYfmSlwKLS4CVwwu5dyQQ
 Np3PgigpdBqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; d="scan'208";a="622038803"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga006.fm.intel.com with ESMTP; 11 May 2021 15:53:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 15:53:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 11 May 2021 15:53:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 11 May 2021 15:53:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 11 May 2021 15:52:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr/FickeQdtWDnaDwIRiaiUEujL9JYp/5RXhvLmlBr01IPOFAcyujk2UZkFiP1YyTT9gYqDMlk5mSOetBuX2C/nzrlCb0CQ1wn+mErlYN0nzwk22cyFRRu1ixUbZVFzELI1ba5oMimCsr3td/BbA6SeU9XhCW2GUnj6NVBlrGo7zcoSnzWPJwUwhP9A4VM8OAbxXr+5cBN7gTVapHi0JPUShTRjDWV4uQnx9X85EESahC/HWudkK0q3bcXIgCZmdHLoW05PdcEvO98lM/mjrkYUjraNevgmBdQNwVgvxzG9HDQXDe3Ez+Bcx8VtSQfChtfohGSO4OZm0mImveCKpvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5EsvjsfIQbWWuDFdBFoSgnv6gWbpK7qNjbKUQkw76s=;
 b=eeFZay6EF/9LAt7YaQdQGsGIgWpd/ajHPCs4ABX/A/ZMHJvrTYsp86V8UrVhbU0uAAfmQZGpVzmLwGW1NTYXkWFg0FR3dal3b9y1m8ElijP84XCI+P8AtwYMsNA7kYwrHz0+MBXAf+FMEDmaSsgCndmYexEssmXuydkkZ0bh8+XPNTDhxJ5wz2SuHwjBbCHbHuUKiI0jbb5heHyQbDHgF+oxoaNUIcJkYt8mMzy1TvMOmm1MHMFQv9H77pKe/jClH1Gtn9AGz9MakqeKcd9LsxrUBZ0+YhpDxH+t/6/b6sVIlBbkFtsI1StJj+8iKSr0E7BHINUo7NvkVWmu0C5BGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5EsvjsfIQbWWuDFdBFoSgnv6gWbpK7qNjbKUQkw76s=;
 b=Am++vbml5Sp7ALd8x+ddAt5HFS9zz/TNIQ+D5DdH0G/loCD5WsYn0wmLgyX7zXUr1aIqB4t5UFVYuLnvaNC9HNy+YOToA4pk9fi3VB59E8piC74odgRYfD1VRRLZQ8iy6w6OP62FrsscvU524FLEJfj3ObvQGnI6T0OSrkqgrp8=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 22:52:21 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 22:52:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Liu Yi L <yi.l.liu@linux.intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkIAAYWwAgALs9qCAAdeZgIACip7wgAo7TwCAACbZAIAARiUAgAARxQCAAS/XgIAACnOAgAAiwQCAAL24AIAAVNoAgABEgACAAo33AIADeaeAgAESCjCAAI1+AIAAnm3w
Date: Tue, 11 May 2021 22:52:21 +0000
Message-ID: <MWHPR11MB18869F7AE1652A843AA826418C539@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210504180050.GB1370958@nvidia.com>
 <20210504151154.02908c63@jacob-builder>	<20210504231530.GE1370958@nvidia.com>
 <20210505102259.044cafdf@jacob-builder>	<20210505180023.GJ1370958@nvidia.com>
 <20210505130446.3ee2fccd@jacob-builder>	<YJOZhPGheTSlHtQc@myrica>
 <20210506122730.GQ1370958@nvidia.com>	<20210506163240.GA9058@otc-nc-03>
 <MWHPR11MB188698FBEE62AF1313E0F7AC8C569@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210510123729.GA1002214@nvidia.com>
 <MWHPR11MB1886E22D03B14EE0D5725CE08C539@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210511212444.15b47c05@yiliu-dev>
In-Reply-To: <20210511212444.15b47c05@yiliu-dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.80.65.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90b6b134-8b8f-45cf-9828-08d914cf6f9b
x-ms-traffictypediagnostic: CO1PR11MB5155:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5155145EFEBB7E94E7EB0A618C539@CO1PR11MB5155.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rqwu8Nfj7wqg8Wt960zMPz2CBme+NlzkYMGs87ZIIwY2e5lEYLKjm06NE7OSxfTSdKUkNkfPKfAIG9znhhj/OUR8akjsNeSa7fTXyW8SqAxcAupC6VveLc6ETw7jGVCmVF35yeZ/+1Wfl56bqEEu578nabMGcDj82BrkujGbtTrMIfbXDomQQhuXhIWVDLjOPUIBFslSd/STFCXX/ihaPOP5Hq32EMt73Gz17NaSJ3ADEDnmxMNvc4WvvWuft2IxiQSRMMBWWWvC4Q+wrFsStDKNcgNz6lvkVWuCLpbJJm58pj/47FZzQzn1JOoAcJFXLUMuErjr4VJdFhk7pcsach4oMAZwKCgBmJA2balL7AfRd2VQjXL5MIh7xL9xIsxd+PD2ljFymkOuPVfeHX4Oc3vDXhFUNHLCYqnqBDT4CIJ8OhWCBSliSHlym7PKorRSE4BTv9sKoRxqHiaKOvi3tjStbTjN5+nDOSRT3hPlr82iFQn+awk/t/O41rlZcfyN/TfsLgAgZRCVWaB1tBP+h/+OZs49+oLZK8jnz/AIIlj/7PLxa+eNmCfNPqYSiNDhXLrEZNCFugsepnOKtKQQsSfjrkzPK5jpM7pdjcdUpO4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(396003)(136003)(39860400002)(346002)(366004)(55016002)(66476007)(66556008)(4326008)(64756008)(66446008)(8676002)(66946007)(86362001)(26005)(52536014)(54906003)(316002)(9686003)(478600001)(5660300002)(33656002)(2906002)(6916009)(71200400001)(76116006)(186003)(83380400001)(8936002)(7696005)(7416002)(6506007)(122000001)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XHNPt3tOxvTFwUjMi2PY8kM9RSVkF1vHqxEnibzHfTUcbONmFdR1NLepiylX?=
 =?us-ascii?Q?zeB1y4QJjUHwfh+yAmQKp0095ppAaewxQRXA7gFHC70iDO1rU1J1YHIkBZUM?=
 =?us-ascii?Q?UKnWvwC9srL4BxJLx6uoZOIE6VZoqEgPtY5ssXYbqaV53lTiL7g3pH1DrUS0?=
 =?us-ascii?Q?hud+b4B2/3kGs7VmaLDowOHqLx7LBuw9dtL/8/Yy9aqaM87x5+xmI9Gto+6r?=
 =?us-ascii?Q?3rX+0tJ2NYRJ2wNgJoNfsT7aU+GbpGLn1Fi2mMsxHqYdHXTozccBf4eCc7rB?=
 =?us-ascii?Q?kMHH5k+8Ot6bOwheJ9e9GHfL/gYd3wvltBHPb/3xLzfV1hEXj/iEKpzRQQvR?=
 =?us-ascii?Q?uW10fAOKviBZgAyORXb1ErXWL0rD8SB5y2fxil8McyK50YTyc9JnEvsIJ3uC?=
 =?us-ascii?Q?DBECU6WPsQgl85NS79Q5LuNgQBfBv3B9BLDeK7OWpSsr/tOccs5G2MzrAFcg?=
 =?us-ascii?Q?GCtmiKAVxS2aI11VkLD4Or+VGcM7Lj5bIeYZpHLSBNj/Vy8oTGumhUbYvgam?=
 =?us-ascii?Q?M34txX0rCgMo/ZKiVLdJ/S1FBnSAAP2tqdGp4rBnUZpXwCGAEHL5spxDSrzw?=
 =?us-ascii?Q?xDGpb2WeJKKFkXeMZOgv8UZgaeCT6SDWrOiYAiQ/RWi2a3ijMTIkIvAhjU6W?=
 =?us-ascii?Q?caHIO+9pjWD9b4YPdBvvuQx0uuNWq0hIofa0SLDbCpuOUMKkVNLOirqet1CX?=
 =?us-ascii?Q?qjmSxUZRSDz278FFIanvBdSjC7lkbjCbh6iIFt6sdmPjXsBmAhyBPX71Bkqk?=
 =?us-ascii?Q?ROkxGBgFz8iTLfDcwkpMhhikPCcBaC6FpP9djToUrEmMbusMcbez56leq10G?=
 =?us-ascii?Q?o2j0MkabVOJQTn2GdiZBQqgM9FipUUSMlNhtvrvQ2sTg9r4ubVy/13acCUUk?=
 =?us-ascii?Q?aYcoMiVHVxIJNcmtpzIiJZC4I7yfbd7YKFvudQiUxsfGMuncS51q4Zfq3zhz?=
 =?us-ascii?Q?NuuU+BQhvJigtovZQAZrJ+7pBPzZH+zNJvck1LrxAkrtPie5kPyFpLA8Oyx7?=
 =?us-ascii?Q?DLtPynkA/0cTUqH3gv0wRTTq0+Fd6nxuCd8sYwH7gWZKjVksazBwii6O6QeQ?=
 =?us-ascii?Q?7wgAl2xycB8N5Jols6qbDdBzowCJd9DQqyGq0t6V56QmwCcPvyaAvZSsXebr?=
 =?us-ascii?Q?u4BGMyPd2Bv5MYhssJ+nE/nSLphuioN9tpsde+tgGV+5djcG0WEGDlwvDr+0?=
 =?us-ascii?Q?WGKAKoGfQ1iTrnPVvh5rrHAs7ojJitngZnN4AkdG0Va2o6KhoMfS7ud7nHs/?=
 =?us-ascii?Q?VUuEjRID3M221dIRSQ6h5wOnN4HcvrO/BbXAWIMd9Z1y/wQApIQHGhZHN8gT?=
 =?us-ascii?Q?5Kc=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b6b134-8b8f-45cf-9828-08d914cf6f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 22:52:21.1280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULO2ge1ypPYkRjBzPA7ubW40LhevW7i/86im6iwkD/pDxFg074j5nK0/TLEgfRN5T13/0a2uXFQ/+ZD4wKg21w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Alex
 Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Liu Yi L <yi.l.liu@linux.intel.com>
> Sent: Tuesday, May 11, 2021 9:25 PM
> 
> On Tue, 11 May 2021 09:10:03 +0000, Tian, Kevin wrote:
> 
> > > From: Jason Gunthorpe
> > > Sent: Monday, May 10, 2021 8:37 PM
> > >
> > [...]
> > > > gPASID!=hPASID has a problem when assigning a physical device which
> > > > supports both shared work queue (ENQCMD with PASID in MSR)
> > > > and dedicated work queue (PASID in device register) to a guest
> > > > process which is associated to a gPASID. Say the host kernel has setup
> > > > the hPASID entry with nested translation though /dev/ioasid. For
> > > > shared work queue the CPU is configured to translate gPASID in MSR
> > > > into **hPASID** before the payload goes out to the wire. However
> > > > for dedicated work queue the device MMIO register is directly mapped
> > > > to and programmed by the guest, thus containing a **gPASID** value
> > > > implying DMA requests through this interface will hit IOMMU faults
> > > > due to invalid gPASID entry. Having gPASID==hPASID is a simple
> > > > workaround here. mdev doesn't have this problem because the
> > > > PASID register is in emulated control-path thus can be translated
> > > > to hPASID manually by mdev driver.
> > >
> > > This all must be explicit too.
> > >
> > > If a PASID is allocated and it is going to be used with ENQCMD then
> > > everything needs to know it is actually quite different than a PASID
> > > that was allocated to be used with a normal SRIOV device, for
> > > instance.
> > >
> > > The former case can accept that the guest PASID is virtualized, while
> > > the lattter can not.
> > >
> > > This is also why PASID per RID has to be an option. When I assign a
> > > full SRIOV function to the guest then that entire RID space needs to
> > > also be assigned to the guest. Upon migration I need to take all the
> > > physical PASIDs and rebuild them in another hypervisor exactly as is.
> > >
> > > If you force all RIDs into a global PASID pool then normal SRIOV
> > > migration w/PASID becomes impossible. ie ENQCMD breaks everything
> else
> > > that should work.
> > >
> > > This is why you need to sort all this out and why it feels like some
> > > of the specs here have been mis-designed.
> > >
> > > I'm not sure carving out ranges is really workable for migration.
> > >
> > > I think the real answer is to carve out entire RIDs as being in the
> > > global pool or not. Then the ENQCMD HW can be bundled together and
> > > everything else can live in the natural PASID per RID world.
> > >
> >
> > OK. Here is the revised scheme by making it explicitly.
> >
> > There are three scenarios to be considered:
> >
> > 1) SR-IOV (AMD/ARM):
> > 	- "PASID per RID" with guest-allocated PASIDs;
> > 	- PASID table managed by guest (in GPA space);
> > 	- the entire PASID space delegated to guest;
> > 	- no need to explicitly register guest-allocated PASIDs to host;
> > 	- uAPI for attaching PASID table:
> >
> >     // set to "PASID per RID"
> >     ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_LOCAL);
> >
> >     // When Qemu captures a new PASID table through vIOMMU;
> >     pasidtbl_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
> >     ioctl(device_fd, VFIO_ATTACH_IOASID, pasidtbl_ioasid);
> >
> >     // Set the PASID table to the RID associated with pasidtbl_ioasid;
> >     ioctl(ioasid_fd, IOASID_SET_PASID_TABLE, pasidtbl_ioasid, gpa_addr);
> >
> > 2) SR-IOV, no ENQCMD (Intel):
> > 	- "PASID per RID" with guest-allocated PASIDs;
> > 	- PASID table managed by host (in HPA space);
> > 	- the entire PASID space delegated to guest too;
> > 	- host must be explicitly notified for guest-allocated PASIDs;
> > 	- uAPI for binding user-allocated PASIDs:
> >
> >     // set to "PASID per RID"
> >     ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_LOCAL);
> >
> >     // When Qemu captures a new PASID allocated through vIOMMU;
> 
> Is this achieved by VCMD or by capturing guest's PASID cache invalidation?

The latter one

> 
> >     pgtbl_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
> >     ioctl(device_fd, VFIO_ATTACH_IOASID, pgtbl_ioasid);
> >
> >     // Tell the kernel to associate pasid to pgtbl_ioasid in internal structure;
> >     // &pasid being a pointer due to a requirement in scenario-3
> >     ioctl(ioasid_fd, IOASID_SET_HWID, pgtbl_ioasid, &pasid);
> >
> >     // Set guest page table to the RID+pasid associated to pgtbl_ioasid
> >     ioctl(ioasid_fd, IOASID_BIND_PGTABLE, pgtbl_ioasid, gpa_addr);
> >
> > 3) SRIOV, ENQCMD (Intel):
> > 	- "PASID global" with host-allocated PASIDs;
> > 	- PASID table managed by host (in HPA space);
> > 	- all RIDs bound to this ioasid_fd use the global pool;
> > 	- however, exposing global PASID into guest breaks migration;
> > 	- hybrid scheme: split local PASID range and global PASID range;
> > 	- force guest to use only local PASID range (through vIOMMU);
> > 	- for ENQCMD, configure CPU to translate local->global;
> > 	- for non-ENQCMD, setup both local/global pasid entries;
> > 	- uAPI for range split and CPU pasid mapping:
> >
> >     // set to "PASID global"
> >     ioctl(ioasid_fd, IOASID_SET_HWID_MODE, IOASID_HWID_GLOBAL);
> >
> >     // split local/global range, applying to all RIDs in this fd
> >     // Example: local [0, 1024), global [1024, max)
> >     // local PASID range is managed by guest and migrated as VM state
> >     // global PASIDs are re-allocated and mapped to local PASIDs post
> migration
> >     ioctl(ioasid_fd, IOASID_HWID_SET_GLOBAL_MIN, 1024);
> >
> >     // When Qemu captures a new local_pasid allocated through vIOMMU;
> >     pgtbl_ioasid = ioctl(ioasid_fd, IOASID_ALLOC);
> >     ioctl(device_fd, VFIO_ATTACH_IOASID, pgtbl_ioasid);
> >
> >     // Tell the kernel to associate local_pasid to pgtbl_ioasid in internal
> structure;
> >     // Due to HWID_GLOBAL, the kernel also allocates a global_pasid from
> the
> >     // global pool. From now on, every hwid related operations must be
> applied
> >     // to both PASIDs for this page table;
> >     // global_pasid is returned to userspace in the same field as local_pasid;
> >     ioctl(ioasid_fd, IOASID_SET_HWID, pgtbl_ioasid, &local_pasid);
> >
> >     // Qemu then registers local_pasid/global_pasid pair to KVM for setting
> up
> >     // CPU PASID translation table;
> >     ioctl(kvm_fd, KVM_SET_PASID_MAPPING, local_pasid, global_pasid);
> >
> >     // Set guest page table to the RID+{local_pasid, global_pasid} associated
> >     // to pgtbl_ioasid;
> >     ioctl(ioasid_fd, IOASID_BIND_PGTABLE, pgtbl_ioasid, gpa_addr);
> >
> > -----
> > Notes:
> >
> > I tried to keep common commands in generic format for all scenarios, while
> > introducing new commands for usage-specific requirement. Everything is
> > made explicit now.
> >
> > The userspace has sufficient information to choose its desired scheme
> based
> > on vIOMMU types and platform information (e.g. whether ENQCMD is
> exposed
> > in virtual CPUID, whether assigned devices support DMWr, etc.).
> >
> > Above example assumes one RID per bound page table, because vIOMMU
> > identifies new guest page tables per-RID. If there are other usages requiring
> > multiple RIDs per page table, SET_HWID/BIND_PGTABLE could accept
> > another device_handle parameter to specify which RID is targeted for this
> > operation.
> >
> > When considering SIOV/mdev there is no change to above uAPI sequence.
> > It's n/a for 1) as SIOV requires PASID table in HPA space, nor does it
> > cause any change to 3) regarding to the split range scheme. The only
> >  conceptual change is in 2), where although it's still "PASID per RID" the
> > PASIDs must be managed by host because the parent driver also allocates
> > PASIDs from per-RID space to mark mdev (RID+PASID). But this difference
> > doesn't change the uAPI flow - just treat user-provisioned PASID as 'virtual'
> > and then allocate a 'real' PASID at IOASID_SET_HWID. Later always use the
> > real one when programming PASID entry (IOASID_BIND_PGTABLE) or
> device
> > PASID register (converted in the mediation path).
> >
> > If all above can work reasonably, we even don't need the special VCMD
> > interface in VT-d for guest to allocate PASIDs from host. Just always let
> > the guest to manage its PASIDs (with restriction of available local PASIDs),
> > being a global allocator or per-RID allocator. the vIOMMU side just stick
> > to the per-RID emulation according to the spec.
> 
> yeah, if this scheme for scenario 3) is good. We may limit the range of
> local PASIDs by limiting the PASID bit width of vIOMMU. QEMU can get the
> local PASID allocated by guest IOMMU when guest does PASID cache
> invalidation.
> 
> --
> Regards,
> Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
