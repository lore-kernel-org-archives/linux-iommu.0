Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD69C433DB
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 06:54:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D1222231F
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 06:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D1222231F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 011BF8702C;
	Mon, 18 Jan 2021 06:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZpDXZOYw8-8s; Mon, 18 Jan 2021 06:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2841887027;
	Mon, 18 Jan 2021 06:54:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEA78C088B;
	Mon, 18 Jan 2021 06:54:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADF88C013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 06:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A1AC485650
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 06:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hssNW5_EeXT0 for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 06:54:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B05B985631
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 06:54:34 +0000 (UTC)
IronPort-SDR: Kbu8JjLwm04Fd56Eurvygf2yIeG6Ecy7uQNEji4z78dzB+iS628bTIcMxRWZMyS6e9cW9FYJJw
 aM36WZqH1y1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="165855789"
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; d="scan'208";a="165855789"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2021 22:54:33 -0800
IronPort-SDR: zHGkh5AjAYAUd73KrhM6Qw12EDbyjk6WiIVADpBHxQmFj2VJg4r+ZNDJ2B+LUjqHqZgCz7OqoH
 3Dm6+QJv1xaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; d="scan'208";a="401951293"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga002.fm.intel.com with ESMTP; 17 Jan 2021 22:54:33 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 Jan 2021 22:54:32 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 Jan 2021 22:54:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 17 Jan 2021 22:54:32 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 17 Jan 2021 22:54:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/O7Zaomfk5Lt15I4VmUl/XIp2ETJ8u+s6ORWkGTEd+vpbkcwUbsz1+uXW1vCZud9wYQfypq8ngV0R3Pe5MNWXlGVxg4HNLaknshEaw0i0SARYKi73y6IKEuXpHCkDCruXtAB8wBAyhb1gkHXG+DuYLT0R7TL/0fn1uUxhnVL9U5ORePoe/FXDVn01KCY4A4IEdRo1NbT74AQIt6Ydo+ZUs+f7joDl/AYLDiRgNkv9id+854wgayjfuYfq6pSmHh2ePui07CGIQgF9yyhIMNvKO+tPHtbdKlNdilfEVesJzx17znbUb+Mt8D4yZdgAab2aM6KgFxcE4m1+ttxuTMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K3A4JUpJnGP+RDPIgCeC53azZNCLeFvpbJlWeD1pkA=;
 b=JA6Mi3rlkTWAw0j+ETqCyv8L/VEr8PLJFcwWt6VqrUjHrUT0nQQ9/SC4MsBnu8lIkcv/K04BDqRaIgCExrx6iRu0BBqzdOvDm223Lgv1veYY4PQ81Ilf/xIkyw1OOcWkQLsJkP1baVg9dManwNI4rQOnTyWzhTf6c/oQKuHMUWd0qMCpyZx/69dVbehLAKiTODOVtps5/+TfGebwX71mM0lh4lXgMPq/tyrNAVIO+V4mzpChHscP9vKpfB1ag1ja0J41PdaeuISZVWISHhsie2RY+BBSC88nPzmBPn+6Tl3rJdV8kARKxFSUJX7GDEVMzM+aQmGnjnqyPPkb7x147Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K3A4JUpJnGP+RDPIgCeC53azZNCLeFvpbJlWeD1pkA=;
 b=lhcxA2hSsTrqR0qBP6dQIsly3BgOW9xCTsHyjPBJSBJFlUkvHyq3jXDJG/h0D8Q8JU9VUc1Spdu0j5dJOhQaO2RUGrOGjtbjHkbCCcwJcKaVBXUyQLs17StPbwYCc4FW/b6+HHZfAIsgbrHUHbJPB96FYQ9khc5caTnrx6lM3ME=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR11MB1278.namprd11.prod.outlook.com (2603:10b6:300:1d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Mon, 18 Jan
 2021 06:54:28 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46%6]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 06:54:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>
Subject: RE: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Thread-Topic: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Thread-Index: AQHW5c9iGKyAtZrVV0Gy0IAW1dQ6Vqoja/GAgABPqoCAASY+gIAASexggAIw5ACAAk4qAIADP7Fg
Date: Mon, 18 Jan 2021 06:54:28 +0000
Message-ID: <MWHPR11MB188653AF6EFA0E55DE17815F8CA40@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
 <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
 <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YAB0SHyUZbxprkL3@larix.localdomain>
 <636814a9-7dea-06f6-03ec-6a98dd30b7e3@linux.intel.com>
In-Reply-To: <636814a9-7dea-06f6-03ec-6a98dd30b7e3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18a35dfb-c468-4356-13dc-08d8bb7de64e
x-ms-traffictypediagnostic: MWHPR11MB1278:
x-microsoft-antispam-prvs: <MWHPR11MB12784227342DF8C89D1114FE8CA40@MWHPR11MB1278.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGDdFLZ6q6L5Zv3bbEy/O0YU+9MINQn08Vj3E7fmm5dJ620x/9ZXz7KPIH76kb8ekm5kk1SWcDNBW6DGfYCQ5yOFDdMgD0QbfQc+8pbI6BmFU36wieq0ptH7uAOxa2ADtK0M6XMvyLf59MoI1K6yzUSS1hEZHOE8ftN+jqe4O0ZTowRNipfJawwtinLyIt3VQo+Hg3ljWuqVsM7OPKfCWtROyWSU4U226xWc0z6+hTwMLkOLQMoqNJEmzdAIn/lvTmfpEm7ZnVjq4eEi/G86o+t404UYdtvNlXHZaL6xI+/PoydakpHrCW6aSlRlAbMLogMCWYROm52LD5nlCSDxU8ATvGLXQo464wFjnqjB5EoUcrzOEx+G+OWD2KGdSo1lXHSi3bh14Gglxbpdmy4zlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(478600001)(76116006)(86362001)(66946007)(52536014)(8676002)(33656002)(7416002)(83380400001)(8936002)(71200400001)(110136005)(54906003)(53546011)(26005)(4326008)(2906002)(9686003)(6506007)(55016002)(7696005)(66476007)(66446008)(64756008)(66556008)(5660300002)(186003)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z0tQQ0s0RU5VYmNGSUZvdGxRRUcvSXptWWRIRjBXWE1YbGFWZHZraytoc2t1?=
 =?utf-8?B?dm5OUXBBNkRFTitHdFo5ZVpBczg5b0UxM1NhZXNxaHNFTTVySTY3dDhvaUFH?=
 =?utf-8?B?ZGhxQ0diSkJXZUFYRWdWQXFpc3lEa1h5alRpcVp3dTY2OGw4dkNmQXdOVnVH?=
 =?utf-8?B?b1JvNlBneUFTOVREdmhySnRXUHBycmtwK3VZT3FSNVVzd1dPM1JZOE9Pa2U1?=
 =?utf-8?B?bGRzd3ZyOEVlOUtOYkhFZXVJSlFmT09OOVV4dFVYN29yRWpiMmc0T0lyeVZv?=
 =?utf-8?B?YUVTNXRCSndyRHQxeXdIckRzd3lRUitVekYvaVNLVDBYQXJsaW40R1JWWTVS?=
 =?utf-8?B?OTNDcEZtVlZ2VFZLbEZ6ZWsxUGJVRHhwWUtpbDRiWW9BemdjLzFDd2piQWdK?=
 =?utf-8?B?U2ViY2R0Y3Q4WDVKTnVtNVVvUmJXSWg0R0xyclNYQUtkbldRMmJnRW4vMEtV?=
 =?utf-8?B?TnZyWEJrZC9rNjZNWng2aG5wSDlubXF2Zm84VU4xOHBYNnpRbS92T3BUc1Z4?=
 =?utf-8?B?YjltcnpKekZkcUtmUjVST05TemxoL24yK0VzeUExZFV3bUc2VDl6RW9JMkNI?=
 =?utf-8?B?M3gwMEw3KzRCNXh0N2hlNVRaQ1hCOUpwM2RBeXBveXU4OUVydlBSWnRpZXZp?=
 =?utf-8?B?U0YxWDA3M0hFSmRHTU91Q3ROWlZwNHZKZHlDcUc5cEhDT0dESEtIZWZlbnVi?=
 =?utf-8?B?T210eFBuL2xFNFF1ZlJldnk1UXVKZWRWMytpdzhzbERka01IeVZxS1NLc1V3?=
 =?utf-8?B?ZGFpL0NGd3AraU9sVjFDL0xqYnRYWjc4ZThBL2UxQUNxbkZqUEw1YlZVckx4?=
 =?utf-8?B?RlJPbXVodVU1Y1FoZnd3R2NJMTVLOXQ5NmNTcmFkYTA2dklIKzNqTndZWnZ6?=
 =?utf-8?B?WmxLaFJVNjhxWWVlTHVLSzgvYXlERGdnZVFsN2ptL0FuK1gvNnhEdk1iRzFZ?=
 =?utf-8?B?Q3dTT0RaZU5uZTdldUxmRVoxRS9qci9aYzJ1eFBhN0Jzb3BaakVPYUVsNGVN?=
 =?utf-8?B?WnNMcUZYTjlrc0VhN0twYkdveStGNkZsV015eGZueExyWG91ay8welhlM0xE?=
 =?utf-8?B?Zy9wZmFhMmZ2L3VrQmpxTDE5MEVRdkhRUFBoSFFTbmJjWEh1dmlqVUFoU0Rw?=
 =?utf-8?B?OVBRR1ZucWxNN3VlcXRTdUx4ellMU3lYQjdNN3UzZS91ZG5DcDAwL1grdTNO?=
 =?utf-8?B?eFFDRU1VM0xXOTM4dEN2emc4clpKN0VGWDdCN3VKUjhES1dmKzhMT0V3Tk0x?=
 =?utf-8?B?Y2RzUjFqNkd1QWFwOE5YWVAvSmpOczVIcXFsckx1L2VyVU5pY0wva1F2cmNp?=
 =?utf-8?Q?Q+VMQIWQH+AIc=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a35dfb-c468-4356-13dc-08d8bb7de64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 06:54:28.1553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rs/lgxqF0a+jt67qaLBQ1f1uVaWZZ1OGyZGlVXJYiQInO4sZn6Nak2B8lhhEGL3rAqwo85Z/ibUwdr8/3wSkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1278
X-OriginatorOrg: intel.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 David Woodhouse <dwmw2@infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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
> Sent: Saturday, January 16, 2021 11:54 AM
> 
> Hi Jean,
> 
> On 2021/1/15 0:41, Jean-Philippe Brucker wrote:
> > I guess detailing what's needed for nested IOPF can help the discussion,
> > although I haven't seen any concrete plan about implementing it, and it
> > still seems a couple of years away. There are two important steps with
> > nested IOPF:
> >
> > (1) Figuring out whether a fault comes from L1 or L2. A SMMU stall event
> >      comes with this information, but a PRI page request doesn't. The
> IOMMU
> >      driver has to first translate the IOVA to a GPA, injecting the fault
> >      into the guest if this translation fails by using the usual
> >      iommu_report_device_fault().

The IOMMU driver can walk the page tables to find out the level information.
If the walk terminates at the 1st level, inject to the guest. Otherwise fix the 
mm fault at 2nd level. It's not efficient compared to hardware-provided info,
but it's doable and actual overhead needs to be measured (optimization exists
e.g. having fault client to hint no 2nd level fault expected when registering fault
handler in pinned case).

> >
> > (2) Translating the faulting GPA to a HVA that can be fed to
> >      handle_mm_fault(). That requires help from KVM, so another interface -
> >      either KVM registering GPA->HVA translation tables or IOMMU driver
> >      querying each translation. Either way it should be reusable by device
> >      drivers that implement IOPF themselves.

Or just leave to the fault client (say VFIO here) to figure it out. VFIO has the
information about GPA->HPA and can then call handle_mm_fault to fix the
received fault. The IOMMU driver just exports an interface for the device drivers 
which implement IOPF themselves to report a fault which is then handled by
the IOMMU core by reusing the same faulting path.

> >
> > (1) could be enabled with iommu_dev_enable_feature(). (2) requires a
> more
> > complex interface. (2) alone might also be desirable - demand-paging for
> > level 2 only, no SVA for level 1.

Yes, this is what we want to point out. A general FEAT_IOPF implies more than
what this patch intended to address.

> >
> > Anyway, back to this patch. What I'm trying to convey is "can the IOMMU
> > receive incoming I/O page faults for this device and, when SVA is enabled,
> > feed them to the mm subsystem?  Enable that or return an error." I'm stuck
> > on the name. IOPF alone is too vague. Not IOPF_L1 as Kevin noted, since L1
> > is also used in virtualization. IOPF_BIND and IOPF_SVA could also mean (2)
> > above. IOMMU_DEV_FEAT_IOPF_FLAT?
> >
> > That leaves space for the nested extensions. (1) above could be
> > IOMMU_FEAT_IOPF_NESTED, and (2) requires some new interfacing with
> KVM (or
> > just an external fault handler) and could be used with either IOPF_FLAT or
> > IOPF_NESTED. We can figure out the details later. What do you think?
> 
> I agree that we can define IOPF_ for current usage and leave space for
> future extensions.
> 
> IOPF_FLAT represents IOPF on first-level translation, currently first
> level translation could be used in below cases.
> 
> 1) FL w/ internal Page Table: Kernel IOVA;
> 2) FL w/ external Page Table: VFIO passthrough;
> 3) FL w/ shared CPU page table: SVA
> 
> We don't need to support IOPF for case 1). Let's put it aside.
> 
> IOPF handling of 2) and 3) are different. Do we need to define different
> names to distinguish these two cases?
> 

Defining feature names according to various use cases does not sound a
clean way. In an ideal way we should have just a general FEAT_IOPF since
the hardware (at least VT-d) does support fault in either 1st-level, 2nd-
level or nested configurations. We are entering this trouble just because
there is difficulty for the software evolving to enable full hardware cap
in one batch. My last proposal was sort of keeping FEAT_IOPF as a general
capability for whether delivering fault through the IOMMU or the ad-hoc
device, and then having a separate interface for whether IOPF reporting
is available under a specific configuration. The former is about the path
between the IOMMU and the device, while the latter is about the interface
between the IOMMU driver and its faulting client.

The reporting capability can be checked when the fault client is registering 
its fault handler, and at this time the IOMMU driver knows how the related 
mapping is configured (1st, 2nd, or nested) and whether fault reporting is 
supported in such configuration. We may introduce IOPF_REPORT_FLAT and 
IOPF_REPORT_NESTED respectively. while IOPF_REPORT_FLAT detection is 
straightforward (2 and 3 can be differentiated internally based on configured 
level), IOPF_REPORT_NESTED needs additional info to indicate which level is 
concerned since the vendor driver may not support fault reporting in both 
levels or the fault client may be interested in only one level (e.g. with 2nd
level pinned).

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
