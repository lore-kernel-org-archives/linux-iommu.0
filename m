Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D57EC432BE
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 03:19:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D9760F9C
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 03:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5D9760F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 876FF828B3;
	Tue,  3 Aug 2021 03:19:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eZcpwNL8F5rr; Tue,  3 Aug 2021 03:19:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B811B8276B;
	Tue,  3 Aug 2021 03:19:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F865C0010;
	Tue,  3 Aug 2021 03:19:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E835C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 03:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09F72606E0
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 03:19:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id orWQNK6AkTcS for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 03:19:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31ED8606DE
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 03:19:39 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="213563226"
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; d="scan'208";a="213563226"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 20:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,290,1620716400"; d="scan'208";a="584495729"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2021 20:19:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 2 Aug 2021 20:19:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 2 Aug 2021 20:19:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 2 Aug 2021 20:19:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lruKSG8hZbsY/E6r9RvlbOnPu46Ru4Irv0fJMoCAcoVBLJ9tR+P4amcyVukseyaV7daIbTwQBLO6QWo4zX1/Qh0fqOjcDhC9+892EAQWVAwJvU7e9vU+sPh/U3MjFagFExbsztWww55xIf5v4Ba2/mud14JjAYA+bLMMMdFY8KhbIgOd32hjUcWHuUso6bEtbiX1Vwa+cTOSbKRz/ns/bKMhYu+HGSnumL6zJZUDxyh6q4ZHJk+r+BF9dNO97Fl30YT6HbyrWICZpU8KVk+i0JIp9EpZphvNc6I9U/oXg5BxRlLcKHQ5XYfbr/e2i+2/3Z8Mx374VWXZyXxAJBoiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFX1zf04jKACwMyW6m0F44IDbrFkXhviP77QjEUKawA=;
 b=VQxbSlj1phRPG2vy00354Y0xI0Q5+Ncu7/C9Jna/PQWUVQ4UYHrq/oloFbQNV0hXleOB56LERxgMrvkQuVaNgDHDvUUHCoHoBMuw5g/+7cvjcXk3MIB2WG4Trp/87Ew2U4q2KsmiaxadwYI/J5cE9lWfP6jmEcGTlXwL/rpLeCXrUUmxDuB0j5TS4fIZWgs32QQuwvn0CgNM/8QcbhQwwu0YfofR58+0zneYkCXMb5KFH/VZcZmuOUwS/F/TOA8CpJm3R7IJsVUnj8v39xa9AlQmmJ8+i5Cx6RCZ19LIE42ZLEwP9rRfMDeMoL8LuFbW8020hDsVYqFp180PbmTorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFX1zf04jKACwMyW6m0F44IDbrFkXhviP77QjEUKawA=;
 b=iB4GJK633V3RgMVB0DCfP5VoMmiyMcd+sa00rMOM7SzfiBUKT518cbEEd3grI5KMnezkWJNPtlRq8afDvJXM09KQ2Wsf09WWhLUAgIK/xWYtPxzazrrk48/Hq5HgofpYU37+FJXsTe2tiTUrThXDplbwJKMbFAAeiodw3PVn7dM=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR1101MB2084.namprd11.prod.outlook.com (2603:10b6:405:50::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 03:19:26 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134%8]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 03:19:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [RFC v2] /dev/iommu uAPI proposal
Thread-Topic: [RFC v2] /dev/iommu uAPI proposal
Thread-Index: Add0lrMH87IsTsl5Rp6WN1oQU6kGMQNQxoYAAGGEwqABKoT0AAAAch4Q
Date: Tue, 3 Aug 2021 03:19:26 +0000
Message-ID: <BN9PR11MB54338C2863EA94145710A1BA8CF09@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YP4/KJoYfbaf5U94@yekko>
 <BN9PR11MB54332594B1B4003AE4B9238C8CEA9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YQig7EIVMAuzSgH4@yekko>
In-Reply-To: <YQig7EIVMAuzSgH4@yekko>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c768095-b9f5-4e92-7b2a-08d9562d7f6d
x-ms-traffictypediagnostic: BN6PR1101MB2084:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB208498C97771C2C3D6468D178CF09@BN6PR1101MB2084.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yOtfDbDuP/iMRFOra+ABl9F2bcgbjE6iL0RdSTNMYgKgisB26Q9RQHBTBWEdrewwZHruDn25R1lcEIJvvefII3IcjLio+AWVyt7o2SF4E1oG2nll/E+oxbtqJtAOq2hTuFAkqUD9SQOgflbiA7r32dciubg0+lcOGBNjbilM5wf5npazI/ts5n62ld8fQ2tZdIX626HBfn6XLNVmeTkKYQia5CrAcLQ0Whi+iOemJOcE+41Qtg/hqSdAEIYs6HIsWkqwbvvNikGsAba/osx19L6+nBcpNBOPBVvflGQxVhL1PPfBTISU8tML3S4EIFoClsQTiqB+ec0jGydt73f30ZurOh3D+ayA4XdebOlfJbwKDRUg8SXyj14fCmz16s5EjZZ0cKnIK3nbNzvz40gveqArkFl9w2TMDeoWmw3DVj1aywfQj7jZKbNje1qtbXYf0lfqpFOyQHjfvLTFUbs+6Vy2p477baLwzEuvYcp8PWKUX1CVSPkhVwrSWtTqAK8W/Vii8Rw9v8jdvHjO59KuaDJ+n1baoHXJrtqiCkEW///wRYHhM6AeWLg8rSCRoZds9uXlYRWRN5Q1dUs3A4SCXKKpMAwidDZIsFU0V2Uw7kmOOhMKZjdq7wo8aIVV+ibwZYCQSFZ6womt7sICGnGt+2riYn45+UMAAsPKXFiaAqku0cjxxLVlNN0tgkTIZUSKJdVVqXTn6k082d/+/tmYnSbrsMS0lHakRp5Bqc89XxbdKzhzAbguepN087yCuxfrVdG+SJQzgJFH9MjYFXEoh9trGnHtYYtwol/kE1CHlOoQXWTWHfBgtKusbVrTK4b5tLz49bsVyUHvBOjBZhIWjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(7696005)(64756008)(66946007)(2906002)(30864003)(66476007)(316002)(8936002)(76116006)(52536014)(38070700005)(66446008)(86362001)(7416002)(66556008)(6506007)(45080400002)(8676002)(54906003)(33656002)(186003)(6916009)(55016002)(122000001)(9686003)(83380400001)(4326008)(5660300002)(38100700002)(508600001)(26005)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LF+ghBYxua97FeGRS4Pavywhv+KsDl25cKUzec/CO0+vT50fsa/UZ5Uojsal?=
 =?us-ascii?Q?aEkcudNY9RpTg0duPh7AJgRxyo1FaFXyCHuXW55wKpiUB+7HHucqW7OQZNXC?=
 =?us-ascii?Q?fLIwcLQ6npB00p1ijJaBydAF3loT7JpMkNL535VbLJG8Z1yW5TGq7z8OEmze?=
 =?us-ascii?Q?dkMgQD2g60hm/J2bWp42URMSrNd5/YL9IPSFbGJpiu2KVYNniIvlTxzeSVM1?=
 =?us-ascii?Q?6dCACIEQwbauWqmv2iC2deRuj25qhyDnOIXPMco/tBwdJ34oCOauvZlb33nK?=
 =?us-ascii?Q?0MDR555LFgR8/CF3WLWwli750rPGAiT5329wUwNCgdh+1pwTYZu3xdpOp65u?=
 =?us-ascii?Q?+ooeLjvaKvvs6rzhP0kZ8q9NfbJWehZ20JghkiuoebeW5FQtdq14npcUdh/a?=
 =?us-ascii?Q?kEb6Hk4eeFHYZzhfT733AB3Cwsv+RjsePfPIv+5xL6E8r+2SSWvyyULNMzKy?=
 =?us-ascii?Q?RyNwdUkL8mBHDxO12tQCD3FDttLgxA5deeNx0/kuMk43WJL+gs10IQJ2fvFO?=
 =?us-ascii?Q?FUKsGuP4u2anCeup4CiPlREiHv0JCM+ji8odmJjFwJF5t2BJ4KvgEHSYGY3h?=
 =?us-ascii?Q?Jz75gy0r/r6+becb+Mcc6eff72WdFk+D1bBhc0IcjV2kECG07TKegzobvTkv?=
 =?us-ascii?Q?Vwz4H6BU37wVa1u8HY85D/NkP7Thczm8TsSGwe35P+ZsN3hM/ZEj5NZQZayV?=
 =?us-ascii?Q?lqQXmF0u1Ip3qRsbCPgJ5M77ADjSeF3PNJM4CGylh09wh0EMKJVoOtWfsNEy?=
 =?us-ascii?Q?5UStQrIj7BDhE8Yrnb7gxBX8Fyql4Qv00YvLgAoJvDsrjX+reifsSX0VhR1s?=
 =?us-ascii?Q?gps86EPOVbj4GVzo6a7/utHKjds27WFXCIYMRlt1zLOR6RBDrLI9ANx42JPl?=
 =?us-ascii?Q?rHl891NN74+Rx3MpJMwADbc4vptkRZIEp25IN/4mfdxZ4AJyek+SNtREwAM1?=
 =?us-ascii?Q?B+pMeowv+0vA9yxRZFqCqmdM655wL/3i1aCDeyD+zji46EgSJDyHYeZkub9p?=
 =?us-ascii?Q?44Jhcmzvk/eFkeHcFD66IE7Z3scNaoZ0V8+JAy9TYa1ufTqwmdBbG56a7Oxf?=
 =?us-ascii?Q?EsAXZYm4UP1uX4HXq7Ss35PBpUsKt6BcVc3u2o2h/NMGgZpQhnBnxc9f4Psy?=
 =?us-ascii?Q?vZzyZuIyHMKhIwdOqORbzspoWuLv8xqw6BAjKEuTO74H+PlA5zQM4OKIDLW7?=
 =?us-ascii?Q?y8QQz01N0PY1Qp7Urruo6k91Bq3LhTrJaGuYEix/3uptC5KsExO9N2apRU2F?=
 =?us-ascii?Q?rBJ4F5IxAp4EBJ+scHqg+leHxSw+XRXz817ITMumWqqp7QXIOCOrxFrYtSUA?=
 =?us-ascii?Q?hVxKNxFZAEtcd7+1FX6Je4+I?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c768095-b9f5-4e92-7b2a-08d9562d7f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 03:19:26.0416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wwMTWokudPixOa1YS1xL7Jp0eitGvbAfe1JTTwMzJeEE/dsEmZiKwM8UKu3Jjt9SBWuyCkW8uY0BUFBUqPG5hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2084
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@nvidia.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, Robin Murphy <robin.murphy@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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
> Sent: Tuesday, August 3, 2021 9:51 AM
> 
> On Wed, Jul 28, 2021 at 04:04:24AM +0000, Tian, Kevin wrote:
> > Hi, David,
> >
> > > From: David Gibson <david@gibson.dropbear.id.au>
> > > Sent: Monday, July 26, 2021 12:51 PM
> > >
> > > On Fri, Jul 09, 2021 at 07:48:44AM +0000, Tian, Kevin wrote:
> > > > /dev/iommu provides an unified interface for managing I/O page tables
> for
> > > > devices assigned to userspace. Device passthrough frameworks (VFIO,
> > > vDPA,
> > > > etc.) are expected to use this interface instead of creating their own
> logic to
> > > > isolate untrusted device DMAs initiated by userspace.
> > > >
> > > > This proposal describes the uAPI of /dev/iommu and also sample
> > > sequences
> > > > with VFIO as example in typical usages. The driver-facing kernel API
> > > provided
> > > > by the iommu layer is still TBD, which can be discussed after consensus
> is
> > > > made on this uAPI.
> > > >
> > > > It's based on a lengthy discussion starting from here:
> > > > 	https://lore.kernel.org/linux-
> > > iommu/20210330132830.GO2356281@nvidia.com/
> > > >
> > > > v1 can be found here:
> > > > 	https://lore.kernel.org/linux-
> > >
> iommu/PH0PR12MB54811863B392C644E5365446DC3E9@PH0PR12MB5481.n
> > > amprd12.prod.outlook.com/T/
> > > >
> > > > This doc is also tracked on github, though it's not very useful for v1->v2
> > > > given dramatic refactoring:
> > > > 	https://github.com/luxis1999/dev_iommu_uapi
> > >
> > > Thanks for all your work on this, Kevin.  Apart from the actual
> > > semantic improvements, I'm finding v2 significantly easier to read and
> > > understand than v1.
> > >
> > > [snip]
> > > > 1.2. Attach Device to I/O address space
> > > > +++++++++++++++++++++++++++++++++++++++
> > > >
> > > > Device attach/bind is initiated through passthrough framework uAPI.
> > > >
> > > > Device attaching is allowed only after a device is successfully bound to
> > > > the IOMMU fd. User should provide a device cookie when binding the
> > > > device through VFIO uAPI. This cookie is used when the user queries
> > > > device capability/format, issues per-device iotlb invalidation and
> > > > receives per-device I/O page fault data via IOMMU fd.
> > > >
> > > > Successful binding puts the device into a security context which isolates
> > > > its DMA from the rest system. VFIO should not allow user to access the
> > > > device before binding is completed. Similarly, VFIO should prevent the
> > > > user from unbinding the device before user access is withdrawn.
> > > >
> > > > When a device is in an iommu group which contains multiple devices,
> > > > all devices within the group must enter/exit the security context
> > > > together. Please check {1.3} for more info about group isolation via
> > > > this device-centric design.
> > > >
> > > > Successful attaching activates an I/O address space in the IOMMU,
> > > > if the device is not purely software mediated. VFIO must provide device
> > > > specific routing information for where to install the I/O page table in
> > > > the IOMMU for this device. VFIO must also guarantee that the attached
> > > > device is configured to compose DMAs with the routing information
> that
> > > > is provided in the attaching call. When handling DMA requests, IOMMU
> > > > identifies the target I/O address space according to the routing
> > > > information carried in the request. Misconfiguration breaks DMA
> > > > isolation thus could lead to severe security vulnerability.
> > > >
> > > > Routing information is per-device and bus specific. For PCI, it is
> > > > Requester ID (RID) identifying the device plus optional Process Address
> > > > Space ID (PASID). For ARM, it is Stream ID (SID) plus optional Sub-
> Stream
> > > > ID (SSID). PASID or SSID is used when multiple I/O address spaces are
> > > > enabled on a single device. For simplicity and continuity reason the
> > > > following context uses RID+PASID though SID+SSID may sound a clearer
> > > > naming from device p.o.v. We can decide the actual naming when
> coding.
> > > >
> > > > Because one I/O address space can be attached by multiple devices,
> > > > per-device routing information (plus device cookie) is tracked under
> > > > each IOASID and is used respectively when activating the I/O address
> > > > space in the IOMMU for each attached device.
> > > >
> > > > The device in the /dev/iommu context always refers to a physical one
> > > > (pdev) which is identifiable via RID. Physically each pdev can support
> > > > one default I/O address space (routed via RID) and optionally multiple
> > > > non-default I/O address spaces (via RID+PASID).
> > > >
> > > > The device in VFIO context is a logic concept, being either a physical
> > > > device (pdev) or mediated device (mdev or subdev). Each vfio device
> > > > is represented by RID+cookie in IOMMU fd. User is allowed to create
> > > > one default I/O address space (routed by vRID from user p.o.v) per
> > > > each vfio_device. VFIO decides the routing information for this default
> > > > space based on device type:
> > > >
> > > > 1)  pdev, routed via RID;
> > > >
> > > > 2)  mdev/subdev with IOMMU-enforced DMA isolation, routed via
> > > >     the parent's RID plus the PASID marking this mdev;
> > > >
> > > > 3)  a purely sw-mediated device (sw mdev), no routing required i.e. no
> > > >     need to install the I/O page table in the IOMMU. sw mdev just uses
> > > >     the metadata to assist its internal DMA isolation logic on top of
> > > >     the parent's IOMMU page table;
> > > >
> > > > In addition, VFIO may allow user to create additional I/O address
> spaces
> > > > on a vfio_device based on the hardware capability. In such case the
> user
> > > > has its own view of the virtual routing information (vPASID) when
> marking
> > > > these non-default address spaces. How to virtualize vPASID is platform
> > > > specific and device specific. Some platforms allow the user to fully
> > > > manage the PASID space thus vPASIDs are directly used for routing and
> > > > even hidden from the kernel. Other platforms require the user to
> > > > explicitly register the vPASID information to the kernel when attaching
> > > > the vfio_device. In this case VFIO must figure out whether vPASID
> should
> > > > be directly used (pdev) or converted to a kernel-allocated pPASID (mdev)
> > > > for physical routing. Detail explanation about PASID virtualization can
> > > > be found in {1.4}.
> > > >
> > > > For mdev both default and non-default I/O address spaces are routed
> > > > via PASIDs. To better differentiate them we use "default PASID" (or
> > > > defPASID) when talking about the default I/O address space on mdev.
> > > When
> > > > vPASID or pPASID is referred in PASID virtualization it's all about the
> > > > non-default spaces. defPASID and pPASID are always hidden from
> > > userspace
> > > > and can only be indirectly referenced via IOASID.
> > >
> > > That said, I'm still finding the various ways a device can attach to
> > > an ioasid pretty confusing.  Here are some thoughts on some extra
> > > concepts that might make it easier to handle [note, I haven't thought
> > > this all the way through so far, so there might be fatal problems with
> > > this approach].
> >
> > Thanks for sharing your thoughts.
> >
> > >
> > >  * DMA address type
> > >
> > >     This represents the format of the actual "over the wire" DMA
> > >     address.  So far I only see 3 likely options for this 1) 32-bit,
> > >     2) 64-bit and 3) PASID, meaning the 84-bit PASID+address
> > >     combination.
> > >
> > >  * DMA identifier type
> > >
> > >     This represents the format of the "over the wire"
> > >     device-identifying information that the IOMMU receives.  So "RID",
> > >     "RID+PASID", "SID+SSID" would all be DMA identifier types.  We
> > >     could introduce some extra ones which might be necessary for
> > >     software mdevs.
> > >
> > > So, every single DMA transaction has both DMA address and DMA
> > > identifier information attached.  In some cases we get to choose how
> > > we split the availble information between identifier and address, more
> > > on that later.
> > >
> > >  * DMA endpoint
> > >
> > >     An endpoint would represent a DMA origin which is identifiable to
> > >     the IOMMU.  I'm using the new term, because while this would
> > >     sometimes correspond one to one with a device, there would be some
> > >     cases where it does not.
> > >
> > >     a) Multiple devices could be a single DMA endpoint - this would
> > >     be the case with non-ACS bridges or PCIe to PCI bridges where
> > >     devices behind the bridge can't be distinguished from each other.
> > >     Early versions might be able to treat all VFIO groups as single
> > >     endpoints, which might simplify transition
> > >
> > >     b) A single device could supply multiple DMA endpoints, this would
> > >     be the case with PASID capable devices where you want to map
> > >     different PASIDs to different IOASes.
> > >
> > >     **Caveat: feel free to come up with a better name than "endpoint"
> > >
> > >     **Caveat: I'm not immediately sure how to represent these to
> > >     userspace, and how we do that could have some important
> > >     implications for managing their lifetime
> > >
> > > Every endpoint would have a fixed, known DMA address type and DMA
> > > identifier type (though I'm not sure if we need/want to expose the DMA
> > > identifier type to userspace).  Every IOAS would also have a DMA
> > > address type fixed at IOAS creation.
> > >
> > > An endpoint can only be attached to one IOAS at a time.  It can only
> > > be attached to an IOAS whose DMA address type matches the endpoint.
> > >
> > > Most userspace managed IO page formats would imply a particular DMA
> > > address type, and also a particular DMA address type for their
> > > "parent" IOAS.  I'd expect kernel managed IO page tables to be able to
> > > be able to handle most combinations.
> > >
> > > /dev/iommu would work entirely (or nearly so) in terms of endpoint
> > > handles, not device handles.  Endpoints are what get bound to an IOAS,
> > > and endpoints are what get the user chosen endpoint cookie.
> > >
> > > Getting endpoint handles from devices is handled on the VFIO/device
> > > side.  The simplest transitional approach is probably for a VFIO pdev
> > > groups to expose just a single endpoint.  We can potentially make that
> > > more flexible as a later step, and other subsystems might have other
> > > needs.
> >
> > I wonder what is the real value of this endpoint concept. for SVA-capable
> > pdev case, the entire pdev is fully managed by the guest thus only the
> > guest driver knows DMA endpoints on this pdev. vfio-pci doesn't know
> > the presence of an endpoint until Qemu requests to do ioasid attaching
> > after identifying an IOAS via vIOMMU.
> 
> No.. that's not true.  vfio-pci knows it can generate a "RID"-type
> endpoint for the device, and I assume the device will have a SVA
> capability bit, which lets vfio know that the endpoint will generate
> PASID+addr addresses, rather than plain 64-bit addresses.
> 
> You can't construct RID+PASID endpoints with vfio's knowledge alone,
> but that's ok - that style would be for mdevs or other cases where you
> do have more information about the specific device.

if vfio-pci cannot construct endpoint alone in all cases, then I worried
we are just inventing unnecessary uAPI objects of which the role can 
be already fulfilled by device cookie+PASID in the proposed uAPI.

> 
> > If we want to build /dev/iommu
> > uAPI around endpoint, probably vfio has to provide an uAPI for user to
> > request creating an endpoint in the fly before doing the attaching call.
> > but what goodness does it bring with additional complexity, given what
> > we require is just the RID or RID+PASID routing info which can be already
> > dig out by vfio driver w/o knowing any endpoint concept...
> 
> It more clearly delineates who's responsible for what.  The driver
> (VFIO, mdev, vDPA, whatever) supplies endpoints.  Depending on the
> type of device it could be one endpoint per device, a choice of
> several different endpoints for a device, several simultaneous
> endpoints for the device, or one endpoint for several devices.  But
> whatever it is that's all on the device side.  Once you get an
> endpoint, it's always binding exactly one endpoint to exactly one IOAS
> so the point at which the device side meets the IOMMU side becomes
> much simpler.

Sticking to iommu semantics {device, pasid} are clear enough for 
the user to build the connection between IOAS and device. This 
also matches the vIOMMU part which just understands vRID and 
vPASID, without any concept of endpoint. anyway RID+PASID (or 
SID+SSID) is what is defined in the bus to tag an IOAS. Forcing 
vIOMMU to fake an endpoint (via vfio) per PASID before doing 
attach just adds unnecessary confusion.

> 
> If we find a new device type or bus with a new way of doing DMA
> addressing, it's just adding some address/id types; we don't need new
> ways of binding these devices to the IOMMU.

We just need define a better name to cover pasid, ssid, or other ids. 
regardless of the bus type, it's always the device cookie to identify 
the default I/O address space plus a what-ever id to tag other I/O 
address spaces targeted by the device.

> 
> > In concept I feel the purpose of DMA endpoint is equivalent to the routing
> > info in this proposal.
> 
> Maybe?  I'm afraid I never quite managed to understand the role of the
> routing info in your proposal.
> 

the IOMMU routes incoming DMA packets to a specific I/O page table,
according to RID or RID+PASID carried in the packet. RID or RID+PASID
is the routing information (represented by device cookie +PASID in
proposed uAPI) and what the iommu driver really cares when activating 
the I/O page table in the iommu. 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
