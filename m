Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C01C433F5
	for <iommu@archiver.kernel.org>; Wed, 30 Mar 2022 14:18:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 899864051D;
	Wed, 30 Mar 2022 14:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I6B4jVnQvMqM; Wed, 30 Mar 2022 14:18:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 61896404F6;
	Wed, 30 Mar 2022 14:18:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 359F1C002C;
	Wed, 30 Mar 2022 14:18:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92BDAC0012
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 14:18:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FFC9611EE
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 14:18:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04faCyKJnv0y for <iommu@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 14:18:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B1A0611E5
 for <iommu@lists.linux-foundation.org>; Wed, 30 Mar 2022 14:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648649932; x=1680185932;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3dG3ruhfTxuCg6tsSftFqJsbwEuvatX41R6BYMQm9+c=;
 b=RtnW8VAUedtV7ywfs4z9h7khBlHVugfkgweLFj2MNsm5FCeQ+nReYnKV
 Pc0doDv0OnW3gOQYlwmC4ZtZ2nYBd2+aMU3R8VLwrCa13RlfPo7TtLO4S
 9EEsPh312UWuRtTX090fZDmil2+CJiVxV7MYoa++ZLd3uvCgYEOmbcfmp
 WtwwNajQHl4JujwLZBoUEsHgd17cFfJOwjDMRcGvdSejYe4YgFPgEcwvL
 QGJybnHUCkTzbWabWWNCxTnBmpaEUq7YTSagR8nd6LTnhCy6/wxUkGlIr
 /INNDknKAOzDndGvxg5OdyxuS+AaEXIp+HCqQwy4xu3G9JI7k4sjqrXx4 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="240149299"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; d="scan'208";a="240149299"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2022 07:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; d="scan'208";a="695114497"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2022 07:18:50 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 07:18:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 07:18:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 30 Mar 2022 07:18:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7Su9VhELiwtpx/9tB6W8Kk9k+EeknWeMeIoYbUlQ1xnK6r9HcANpxwiVybYYLsRvw+bdRApUXdM+lrZVWmta1OBxBlHhxop+d50bzzH8V0fyD/c9M2/N9OA6Cn1Wlg3V0K2rf+i2RI3SGBbpT+ApEF1xEFom8i4u28cOelNPgDrB1aKRuwjf601aCDAXVAoswI+Tnlr841MW03TVLrGXu6GJu5QORvm41W6l5ul5gVL6YXbAX34yOW2o6I4vyc861OC6cltZvLTM4XX5s8aEvKTXO67XheQqV+TDmViByk8Qox7RZ6xXHJLKQWqpEjJ4OPecXJLP1mvzYm/8UTpww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dG3ruhfTxuCg6tsSftFqJsbwEuvatX41R6BYMQm9+c=;
 b=YifwBAYuggHdrHvU0t7tLGf3g8T7T2xtrBlzTu81Om0xbHOoGhLhMjix63qsKM7hBmsutTclyvjQRVZtByImStVasUzKmrf4y6+B4e1IEd9J30mrQXkJGBzFMCZqpzVAzrgNYpXtsA0BaWMet7A+Hj4wJcfD+xxGlHaFsC3TSm3whIQAB1xvWx9e0hofhFamR7wIP9ochM+QIEaO8RTzz1XiNJLYzSyH2OL/wYZIdbgUL/TKQ0Jc/UM1gvSc1AZVvrLo9/xGOAeYkQZDCtlKaRp6EmX12jQrkjU1nHmj2IwYKKDbRfphk0zHnFUh/Yhv7ujAbkcufNGMh9bqxCrskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:231::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 30 Mar
 2022 14:18:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 14:18:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Topic: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Index: AQHYQy+FyOvFomDYNUS+m4eyrODKe6zWBZTwgAA4VICAASjOcIAAbdAAgAAjg7CAAAOWoA==
Date: Wed, 30 Mar 2022 14:18:47 +0000
Message-ID: <BN9PR11MB52766A3E3BC82EEF437258198C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5ac878b-52f1-4aa8-db51-08da12583482
x-ms-traffictypediagnostic: SA1PR11MB5778:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA1PR11MB5778D649EA46AA87AD7E44E38C1F9@SA1PR11MB5778.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gnAPQS7t8BffAUnVab/skLQB06lhjzPTcSALQ3eZBdv/FUbrTmN+nSwIcwidp+K0IUKsrzU59oS0n0SyhpV8LbLM5D5X/k2WIyQtPUuBgjNVusqIM4FpDYCr1fepYujktmxbTh+f9ALgGmetnrcZkWhNS1qsaSCfKasOglEa7acU2YgSxfr5/INwgoW3P3vb7I8Cmyxta/kGDGmcZvxbpbF8SE1k7DUF0AQTW9BuHHE2wJUwUhs4wkHXZ/8Fc6+1kX/IplPqxh0DD68s5E8qUgDJWKCIf9vnH0ks9/3dKdmLVrfoAv4Wk3jVf0xNvihVK/z/ikp9F2RbbhO2k0EHrhTpJ8S4JSBrWuJ3EcI/3DBnywbW+bgq7AFlHMFE5RjKZwMzQyzwv4zFgMjTTOfovHTttZkDbALuZqlA5umYpYDhCGDNmSuWLHyfxXyp/+oBufU06BvZnGAA1gsPkNdgY4TD52YWcEctGMjDBczgFaxyO9JORBC9hVvurQT2lqV9b49Q63xbQXdDXFpEAfkEjlzDcIufGzdfDYEePEpK0t6htKIaTnppP0d+RZfiNb4gbFI1hFl/hJZ4jkNEjgos39w+hnU3mGG2w9MypaQ/X89ZmIz/kIqIyBO0GOxoV2BM6ogK6W9Tj1D0YaGvZb5j0aW5nV36pLePsCwnBWIqPCZznTk2/foCMk4DKBQJzjFW3t/jNiiUCZQlqUOHb7LLZQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(38070700005)(33656002)(122000001)(26005)(66946007)(186003)(66556008)(66476007)(66446008)(55016003)(64756008)(8676002)(4326008)(2906002)(5660300002)(86362001)(76116006)(83380400001)(52536014)(71200400001)(38100700002)(508600001)(9686003)(7696005)(6506007)(8936002)(54906003)(6916009)(82960400001)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ghM4VdpyMEDXXudOX4T5ELiEHyAVTTeSRC3SpFoOGxeweSQ+zmiKboPfSO5C?=
 =?us-ascii?Q?sB96kXK9afDWjMLzpq3laMICTbrYokL39QGpUk+VTsFa5n2AqGEKZt1oBz7G?=
 =?us-ascii?Q?977ZqvJ/TLiKZzYu5tu8sYYSifzEAwalt7gic/Wg1e3odmHgmJ313hb6hDm7?=
 =?us-ascii?Q?hN6dyFLc4jAMCIB9VrSzSWqcM3eNNoHMtsG6jFXlPiCh+9S1hqkI5UpnnlFQ?=
 =?us-ascii?Q?rTmZerikE2ZPf5SI0061VGV0XM4fRqcoVXf3XM7GkBsLjuWZvO1TH/X7wOvT?=
 =?us-ascii?Q?UmP5ix9sWEPkxxg/VSzmSw1tWyfsBxIVRJmKDJysQrNz7Yw1VE/s03pLyc+r?=
 =?us-ascii?Q?6ngtSCwa/oh3z64V0CRq9ttZz2DF/3+aPQZvw7OoNXbCsmaR/xfkld1ehgv/?=
 =?us-ascii?Q?/O84AEI9wInRz6RK3ssQCHubnzaLGfHtSca97Udqvq8xmumWVqRdbcp6kiKR?=
 =?us-ascii?Q?SAcxRcxZhxktBsqu/2FGhdn470UA81TMBMBSD0p7MefNMEO/5HGq9P+xuLJJ?=
 =?us-ascii?Q?6/DYkad9zC1v/g/n+XcjXufzvT8GClmg58JOIvbXTjWxVn+LxATav31llAa5?=
 =?us-ascii?Q?hcMSmxxJLfiRuiBRFzIiuKc5UWgsuOwkH6l7OHUR55orukxCTEEB/bHoGGox?=
 =?us-ascii?Q?KS32LgEsrDxQQYlx4Exv1esevq46+UFOKHQNlGKEhz3ZfWX7SAxx3budRNFq?=
 =?us-ascii?Q?VfKcqIehn22C1g0mavg6TWaOT85g/AqTWQ4t/wbDjjB8ZmdcWC/UDT8/dWI4?=
 =?us-ascii?Q?Nv+ZRCJtG7HZAj42T6PRBpzdgmPjuvBkkUTECZKc/jS+MAANbg/wqW2QkFDh?=
 =?us-ascii?Q?2lTdcxdkKYiKzCOPlTi7WqGocTgNKvvHdafhWY5lxROsD8uIQ/VTGaQHhLnq?=
 =?us-ascii?Q?A+Et6f5hTXGip0WJzkug5aabkPABTrei6HshNSOI0jQFWikE3mUh9u+HEeCh?=
 =?us-ascii?Q?CoBeoGd1NS+B59y3FrF0YgRMOb+DR5n0CiMYAY1l2Ol6H17QxBOZtf41ZRcn?=
 =?us-ascii?Q?hURmUcMtQiBug46WMOY9wXLh1WTLJeAWRRlbDdUEazNXCoPo33a65c835Gei?=
 =?us-ascii?Q?WVKYvs07AqJZ5uE+YhmCH0Tn1gviT3g4ujFmdq6SUv4hDz9ndzw4sPhJ1qo/?=
 =?us-ascii?Q?n9xWTYgoUFomHpXfq3TPHgO1S5XsDwlQx1OMVukr6CrDO5q2/FuiU3PLEcNv?=
 =?us-ascii?Q?qod2+jwgp9VXWHwFLmJ5XMHIp1gNWG2PW+qZL+zyE3C4GODxEwncd87RnnA4?=
 =?us-ascii?Q?LnALkZJgJ9eqSfebM2biKxZERep7R0NGP1HB2m/CXxhZW5KulW/MnFL0Y4K8?=
 =?us-ascii?Q?x51WUZbBqY5G1qcRLJHJfGLu2/aC1WqxLqaKT+vYTzy7VujD+48ePLrN/Q46?=
 =?us-ascii?Q?DgJdi3F51Putswoy+LDb+urBnVEdPUjGaqQHKa9q5ELR9SRqn+8dBJK2T+g8?=
 =?us-ascii?Q?aDaynYfq5RYwpGi3TMlPjkP2goPdSowI6S68/kVTyqLdtfmQAqY0WdDtdlwU?=
 =?us-ascii?Q?Q4RN3e2tQeFf8OYJPfMMlWF4Rcb0EHQo4nzOk4hlKaep4oQfQs5v+RE4a6Am?=
 =?us-ascii?Q?MC9PYH84vOgMUiE3zdJ0jQHVH5EZAqnXr/iJXTYUkqE8qscTn6jXswJP/sZZ?=
 =?us-ascii?Q?de7IhhfiuL2wUPs9a0gKJmU6UVZChAf2k+hGQZcydqMDhvpPnpq07ndrQgk7?=
 =?us-ascii?Q?EGhDDAwwAMxCK0uMOz5IkNOmXqyn3vL6TuWF5LIY8FW1jcga+7t2GzxYwhFX?=
 =?us-ascii?Q?TmKzWxfmtg=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ac878b-52f1-4aa8-db51-08da12583482
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 14:18:47.2353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vffY+waatIq/g6UhYn8LLvYaCKAaTrJUGkMe6A5kZSbJ28XjiFbwBPVfbfH/CT/qrvvHVxvY+rlfhFzBnMrYSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-OriginatorOrg: intel.com
Cc: "Alex
 Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
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

+Alex

> From: Tian, Kevin
> Sent: Wednesday, March 30, 2022 10:13 PM
> 
> > From: Jason Gunthorpe
> > Sent: Wednesday, March 30, 2022 7:58 PM
> >
> > On Wed, Mar 30, 2022 at 06:50:11AM +0000, Tian, Kevin wrote:
> >
> > > One thing that I'm not very sure is about DMA alias. Even when physically
> > > there is only a single device within the group the aliasing could lead
> > > to multiple RIDs in the group making it non-singleton. But probably we
> > > don't need support SVA on such device until a real demand comes?
> >
> > How can we have multiple RIDs in the same group and have only one
> > device in the group?
> 
> Alex may help throw some insight here. Per what I read from the code
> looks like certain device can generate traffic with multiple RIDs.
> 
> >
> > > > ie if we have a singleton group that doesn't have ACS and someone
> > > > hotplugs in another device on a bridge, then our SVA is completely
> > > > broken and we get data corruption.
> > >
> > > Can we capture that in iommu_probe_device() when identifying
> > > the group which the probed device will be added to has already been
> > > locked down for SVA? i.e. make iommu_group_singleton_lockdown()
> > > in this patch to lock down the fact of singleton group instead of
> > > the fact of singleton driver...
> >
> > No, that is backwards
> >
> > > > Testing the group size is inherently the wrong test to make.
> > >
> > > What is your suggestion then?
> >
> > Add a flag to the group that positively indicates the group can never
> > have more than one member, even after hot plug. eg because it is
> > impossible due to ACS, or lack of bridges, and so on.
> >
> 
> OK, I see your point. It essentially refers to a singleton group which
> is immutable to hotplug.
> 
> Thanks
> Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
