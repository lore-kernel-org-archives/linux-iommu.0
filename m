Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91419C433EF
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 09:46:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 198E881761;
	Mon, 24 Jan 2022 09:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GF-qK28jHcMg; Mon, 24 Jan 2022 09:46:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3AF1F81765;
	Mon, 24 Jan 2022 09:46:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1328BC0031;
	Mon, 24 Jan 2022 09:46:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F12F0C002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 09:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CAA6360BA4
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 09:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FeKpdj_7IaS3 for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 09:46:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2FD160A78
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643017591; x=1674553591;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=b6cIKd/hDJcdeImvXPQWgb7GrN3mw85n7h6Big/YYFA=;
 b=XxW6s9H/rGvKQruTrX83GCfrvmsUPcxPBrJBpuRcZXDJRmfs5mPuH/Ef
 7hNsniI/ajfAd3BaZItgOuMLREeu+6qVW4dLkN7cm96P8O/TTsu+1RrKE
 fMdaqoBj9qhITmFOT2qv1Y1qWbC0DkPTPwRyrlK+yMFq/6mNLpv7I3RJ7
 PjiMzdNOUqaGkt8TJH2PMcUPiWpa6VBi5DmETi0vHwLlGJdI3yeWlf1Ni
 3qpwWb97R0q9Vgw5cYWHucI2xvH1vgtgIvEWjy5grPr0bS1DplOVwSFJr
 UiO9mlZyd9F2I25rVZOIpMoV19bggQOxCNfc5bEbKvCpnZgTpExgPsCoF w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243604350"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="243604350"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2022 01:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="673572027"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2022 01:46:30 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 01:46:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 24 Jan 2022 01:46:30 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 24 Jan 2022 01:46:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUWSOMFZmgalPUsaEBxcPRA5ILvZvUMrnAfUVQK5mvEQR/suybKCckxnLCnVaFcW4fPo1tigAD/NkFk/ctUYTdxTm2hvtFILsma54Lqdk7ohTtsNzZfVaOk0pTO+tQ0bJTZMtKCrH+SyMLy7ROKZYeUytGEZ/1vBVHeIj7c+By7dn7Dj997NQt7Qb0ND+bZjwwtO5E8IXP//9Ir9j1LOnLBfpC2FH3URovkqvlvYHRrGu7IAiXYbJ5xUW2QbcU1HNUdRRnMUrmeF/7eAgCmyXP71S7L0P7GebSyj4fofYgeGv+Rm3xZRY6vUBeSci2KfGoCW3fKco3aS70zCoH3erw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6cIKd/hDJcdeImvXPQWgb7GrN3mw85n7h6Big/YYFA=;
 b=H9u6mq0kLsBrEKuvYa+Wa2j1r6YXgKYXVMGwW+fZ5C9B6c3iq8jfPPCb7hAH9osLbvaH+A7Es+KidbRTHJ9qUFBRnyqLpHqWciNHovpOWhoE7Y+VLRvCgkGYvcpNbbO5V9HMutxvFs+sMHTqev8xkQmODrYwwNBUFLjBkUeUPsSxmF3yw4SIBAjbC9uH6s4Tqx4L0Jwrp5119nKAHjeAhBx7Ru7j/7cvuAYelSKcUCMf4Gdns8ZACXtSw5LWMPoyJSnDfbsdRYnDYLqmZz1igmzghkEwBPAZJ4HoPbftZOl6NZRw6SMX/LH7BcTI1loJFnCIX0XdzbSpzHblpqYUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB2668.namprd11.prod.outlook.com (2603:10b6:5:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Mon, 24 Jan
 2022 09:46:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:46:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Ben Skeggs
 <bskeggs@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Will Deacon"
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH 0/7] iommu cleanup and refactoring
Thread-Topic: [PATCH 0/7] iommu cleanup and refactoring
Thread-Index: AQHYEPHAKjrfWJEn8EK96HWI6wkQH6xx4JAg
Date: Mon, 24 Jan 2022 09:46:26 +0000
Message-ID: <BN9PR11MB52767F46CC13601306001B9E8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 765d274f-4cc8-405b-345b-08d9df1e63a7
x-ms-traffictypediagnostic: DM6PR11MB2668:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB2668C44962B847F3AA3B721B8C5E9@DM6PR11MB2668.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c7FEST9/Dt5ASR1/ULp7PW/1jMW9YjBI1TE0ZWO7gP+juB+e2u0f4h/CGYxl65I7Xp0HQLRe0jCEsTlBKpK7mBteWEDLEAWHu+kw947vlhUqHXOUHg+GlWn4SN2xkKDo/jPQ38X6kp1+CLCZ1M421sx4As421vuw6/AosOGeraVwN3YJJ4vNd+bNRd6Ace75QFE7LeA5dqfsvtI4V0IwqHomq/JdBajdDIp2r4NzB6EMf8YgxMnMrfsFURlw81EJV6MXbULQLAbgqJZ8EvFLnxWCsxQzVWdJOPV+Dl4pnQTc3C/EH1glENoVkIrX/5ZjwHLyTPShNfpJW9Sp/BKcBCdnrndeWhxrufcaJp8Y7jcqSucjGz/axMdl6gl+/fouRvGwnLDxqYW7pxSB2+8xj89vAvNF3bLz+6FRpmwxu5333i8i23eypMoQjbBGHf6DUGyazRrr9pItLCfHypsDBixaWQJ4N4GBwbjXWJ8Qe977WtlE/Vb3rZe/H7u/Rs8sXFxIr2G9+KCglXCtSEz57RC5WFIMh9GbnQJseORsiPOU50DyMRIJ6fKcH1bG1ATeMu1Vq9+1IDsCwo8F0/kl4DPAO6aiy0lG41Q6MFu2E/gb7P9dUDiOOp4zkar6tyaDrDJN28VE7SNLYD5FNaKW7/DcR3W/2B4B3yfDtA2qZBBDPJZ9ZA65L4xQ6UxQtpyVWW27VpNS8kGrUWiIy/Vg0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66476007)(66556008)(9686003)(38100700002)(122000001)(64756008)(76116006)(54906003)(38070700005)(316002)(66446008)(55016003)(5660300002)(186003)(26005)(8676002)(33656002)(2906002)(86362001)(7416002)(6506007)(7696005)(110136005)(8936002)(508600001)(71200400001)(52536014)(66946007)(4326008)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Bo8oS9uHOFZr93OljV5Jb96K/M3NeOuECNYsievKHlR1e7hehrFdtHYBOJX?=
 =?us-ascii?Q?OgEQurL5Ingx/tbMh6y9Ajey75wNTe7ySMG1cdKYN6H1aOpLaVq1rarzuASr?=
 =?us-ascii?Q?zjUiXpI+2ETYFO0tAzFCEu2/QxS39BYFJS305ugsVSe8ak0pjMm0Gs+pQEzP?=
 =?us-ascii?Q?yAcNXOhWBNUe+N0Aymhcmr3ZJSKbwpZ8gYqU4EX57dRGgUnvwb5b78EqkbrY?=
 =?us-ascii?Q?e5NZgflEQBShgeEnAm+OcIFnXIynVcG+JI756BS/c4AvczGtqpDXImpqawwJ?=
 =?us-ascii?Q?NpMrcSxCMDw+Lqi7uQLI3UWZ755LDGfqgCu2WtlZUlzI/G5Q2tO+xOAGZMww?=
 =?us-ascii?Q?zGW0jtbvbwcjKAtFDT+OTItDXPkt5SIAqwZAspTTJ074pdQ14KHOX8oHzAUF?=
 =?us-ascii?Q?K9ZAl8eAV72XLqJ6nduRecHunscCpv/nQ2mCwkLTpgG4sBv+yB512V7gf7z8?=
 =?us-ascii?Q?nEDEtmqDPrYewEs0G4Rfqe8oAWeUD/+gykYMB8PAKsDzgPOZeQzsQQcDaCP0?=
 =?us-ascii?Q?umGbWP0AH8UFO3C33wp72H4EdaMFamHJGhwK05PN2TMKzP8RVcopqwqg5lcI?=
 =?us-ascii?Q?DXVn/ZPkTBNtd8oUXPWC4uHx1wvRIHvpId6YuF7Jb8PBdUdUQD86R7FG/s5p?=
 =?us-ascii?Q?pKWIC5h/em+axl3QxBurLeQFuFw9dsGgZJFDGVTY81CQtnUSlQp7plO3k54l?=
 =?us-ascii?Q?TFcxVJIIuQ6NJqzuqODbJRf2FmrsDRNa80H6tDH/k52g/qwvWweSLs8Y5hs2?=
 =?us-ascii?Q?dJlyQMReRa7KP3XqJaa2USj/Rf+PDERRUuyiaEJ0KGs6ZVGtKGcG/9HM+zuP?=
 =?us-ascii?Q?UXy7HdqMXtsteyIBoeH7CmncorJGELrkX4JPENdSygFhmPDu+399vkPrrLi9?=
 =?us-ascii?Q?pA9qTSWaDTo6cgLkJJfxPU33TMBkN2q/SE9mreW8k9Zxhb4uGfmgIaL9ulTu?=
 =?us-ascii?Q?+WAf9VTFSlEVGbkuJwhwLvWJzXzBMX4/idqlCFTuQj3+SSmEwEdXVjQ50mCu?=
 =?us-ascii?Q?qAzTdSC3avCpNdNfEqfvlQAUtbloI6n+pg5CLW6OQmsYW9WRoil17r+7v/Yf?=
 =?us-ascii?Q?Jvug7txnZR3y+QiJn182eIPfKiQME6tUpYukEEiKoQg5FOubjT56ol4PwurT?=
 =?us-ascii?Q?znOeDAP84PdJiXEssJQpewxPOS3pt2nv5wyUIUgb3gWaaM9pihLVTpTJhm3w?=
 =?us-ascii?Q?JBNOaPeg7Bv7r35DLr8/e2JI59MXKimsIsgZeGLkNtRJSzCLuj15GmK466e5?=
 =?us-ascii?Q?nyzcHyg3S30VqoLHN6AChomYlMTjtSVTEp0XafCDGO7fC+uWmRjEgiXRK00P?=
 =?us-ascii?Q?4v7Xf7O+UdM6FKpm+zWMqMEGhZN7RXfE4UkFfv1AFQEtXm+n97SeiTQixsQk?=
 =?us-ascii?Q?asfi6mF/ZjBX96jLtJhjtu08U0eR2u44rTFDLUmNTuZzNFFiRojWH5ogq/Ox?=
 =?us-ascii?Q?4REa4jtAuQjlnqem84ZETaodV9IHkAvJDGHrVkNZQcFDVFZgtJF1mx1JG+5c?=
 =?us-ascii?Q?N8DAxjMwwyy9aJo2/aCyFZ+IJDA+rkZrl1HkWfobw1/RUIUrqaKMCxUNrMYG?=
 =?us-ascii?Q?5UE2k/7y3md4smif3IUlAW6N5nI65XRbjhbQUJZ+CA5t2ZAQwowtZlU41g45?=
 =?us-ascii?Q?CJnlKyFqIrNYAHkE+SLYMAw=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765d274f-4cc8-405b-345b-08d9df1e63a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 09:46:26.2613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkYOeH3ROZtGHIJ5KuBNTHk8qViLLcJZzZPAG4NCjYaYZU/aSeP7J3BN38kC+SRD4FIY9B7a1aiBZ2ynm+xYFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2668
X-OriginatorOrg: intel.com
Cc: David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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
> Sent: Monday, January 24, 2022 3:11 PM
> 
> Hi,
> 
> The guest pasid and aux-domain related code are dead code in current
> iommu subtree. As we have reached a consensus that all these features
> should be based on the new iommufd framework (which is under active
> development), the first part of this series removes and cleanups all
> the dead code.
> 
> The second part of this series refactors the iommu_domain by moving all
> domain-specific ops from iommu_ops to a new domain_ops. This makes an
> iommu_domain self-contained and represent the abstraction of an I/O
> translation table in the IOMMU subsystem. With different type of
> iommu_domain providing different set of ops, it's easier to support more
> types of I/O translation tables.

You may want to give more background on this end goal. In general there
are four IOPT types in iommufd discussions:

1) The one currently tracked by iommu_domain, with a map/unmap semantics
2) The one managed by mm and shared to iommu via sva_bind/unbind ops
3) The one managed by userspace and bound to iommu via iommufd (require nesting)
4) The one managed by KVM (e.g. EPT) and shared to iommu via a TBD interface

Currently only 1) and 2) are supported. 2) is supported via sva specific 
structures, tracked outside of iommu_domain.

Following current direction 3) and 4) will end up to have separate tracking
structures too (some existing bits for 3 are removed by this series).

And this series is preparatory for extending the domain concept to be a 
general object for all IOPT types. And it is one important design direction
to be aligned in the iommu community.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
