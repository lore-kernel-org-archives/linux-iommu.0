Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6289FC43334
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 07:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0A2C41846;
	Fri,  1 Jul 2022 07:56:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0A2C41846
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZyFxKAyp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H5SYyUKLoTpe; Fri,  1 Jul 2022 07:56:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1FBA941830;
	Fri,  1 Jul 2022 07:56:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1FBA941830
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E48CCC0071;
	Fri,  1 Jul 2022 07:56:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 423B9C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A9B84026F
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:56:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A9B84026F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZyFxKAyp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FCOhSidcXcOF for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 07:55:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E4984026E
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E4984026E
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656662158; x=1688198158;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gYaDAMFAAZBoc63m80Ex/urM48d4bXGrRrcD/+CatbI=;
 b=ZyFxKAyprZviOrhUaL7rV/XlRpn7cyXukY0Le/Qe9mLF9a405f5MP4i9
 HUwg5znZEwwPSfTIksbEj/ku5Ydd+Kv2l1LEC8BPTy7Ivd4ZQqU2mOVrI
 P34S3XU+vyxq7GjaozihkSkpU1sDWJVLs0ovGvGBfxrv4MlDOyt6C88S6
 DSYKcntqlvwunPmq6AjR7DB0/cSYBkuyWkFzClcQLf2JkEvFQ9A+ZkME7
 5mVYEU//O3Eiousjnz2W9J9jmX+aBeK5Ii6Jo2HrNgoAuBss1nsg6CsWs
 fYh50AWXYPeKe4zZdxY/jWneAYDfBOyLoFPCYWFIW2e9XtYBBqVIO180r Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="346570976"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="346570976"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 00:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="768416742"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga005.jf.intel.com with ESMTP; 01 Jul 2022 00:55:57 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 00:55:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 00:55:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 00:55:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eX8vbxTbQlHM3fwu9cDEaMfwZvlAEafNEE8GlD/guQpEDl951LWwUVRfChYsGO7x5ZUs1njCXyxqcwgIcma1emLZhiTZtwUIqR8QyMo7tUd7S2Cdn5Isgz2KdgZgt1NOtG8+dtmqcVSbktTHAZuqxfoDxtrHRoW9+1EJVxJpoqkD6gBtVtjNbtTqD0SMUw9xuCPdR+q5n3PqPcIM1hHHuPda+P/jTI3hTqgtb//Px+dHA2KeAu3soqbPBDSKD1+aIG30R6hd1HJ1Uduy4smUJ6UfBiUbmlzQCEn5kYRBeY2LCH3jc4fEuVUu4gtNjmu1JPuyl1JNGFWM94REU8wIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYaDAMFAAZBoc63m80Ex/urM48d4bXGrRrcD/+CatbI=;
 b=gTDxhqqnMrm9K+FX00iq0t7wNCpv7im8mhhJ3gtJp4Qjpf98lonRrwN/QmLssFBAtxFPMOqZLMlYhxglW4+iWds/dEr6KcXkVK9bzTWu8Q+K2cGWZVY5H1d6iUtVUzOpsBwFUchEvt2Lwja6WuPDGu+FK3+m7IoUg0dtMZ6HJQuos5ICfreM+7Ob9IBJzkels9jstj/+ewEBh7tBM1Td2+bAoIaD2ye5tAUrKMl1ZECk+zkJtT9dYZ3Ay4v09MkGNJLUPAr38jv0C+cCf1ar5OR9zYB9/yg1cqGYQrMiFEyBA9hP3W544zCr6xfFKFIu5SGUyZlzZFiF61F+5d6+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2943.namprd11.prod.outlook.com (2603:10b6:805:d3::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Fri, 1 Jul
 2022 07:55:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 07:55:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>
Subject: RE: [PATCH v3 01/11] iommu/vt-d: debugfs: Remove device_domain_lock
 usage
Thread-Topic: [PATCH v3 01/11] iommu/vt-d: debugfs: Remove device_domain_lock
 usage
Thread-Index: AQHYi40fBqsS9evxMUasUxl0YDEi361pKMkA
Date: Fri, 1 Jul 2022 07:55:54 +0000
Message-ID: <BN9PR11MB527606277CBAEA6FA9652F998CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <20220629074725.2331441-2-baolu.lu@linux.intel.com>
In-Reply-To: <20220629074725.2331441-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05f74bf4-0726-453e-c783-08da5b372003
x-ms-traffictypediagnostic: SN6PR11MB2943:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +UYR+StZKlkzanNQoftoGAfurM8uULkLSBATUsoQ3Hq3b43WSQtDQeTLwfytTwgAw7Cn+wJjCkcrhl3oFbD5kwp04lu9srhvuUWNpv1xvaouRPACuDYWqY9xgJ15SkxfY3Be3cGxIyO+h+vegZteSvRQaF0j6BqY9OcX8X+to7cXA6LIGUfZbD1JiV/jsaeV8GhpJdvFO/heEfRoVRdcH5BcKEyXvTI6O8Fx2UikROcDJk4/HLhd5elxr0970ZW2YjL9l2QEGrCTInKs7+YZThtrCaSLg/uS2ZXyKnCUWzL4R9EnXmaaNyVPXY731B60dTUf6ILTYmnXwhN42g5m3xtF/2Zv51kqmSj82s4PfL969ru4s51kkp4H8JJVF35Qnco1lGGsey8EATpb7KdPogJQw/5+CwA1hMAKB/saYPr4af2ixRdB92e9H6k8zxr3Y8XwwRPc6Ui7PoROxBqn5024WbUIAbumnGIOPOZ6npex0J8/RmwswCUOJGeuH4tp2HbB0ThwF/QnwR0X4fvslk2+Lb1mKizYbSR+XK/TFyXDIaFscdc4dOAa3epcQo/JrpAeUtL3YO2w3/AlmnR3ldxRnwlkHKTolEJyFA6jf89/EnMZ6DiwNmBIM1cdMozmerpPgt2bzyLXmflDt0BU/vGPPn0SC6UKM/SYJtXU+d4O/2zuHGYS9AIE9rN46gsKkrqWnbBe8vK7J6PepB6ogowtiPBkGGgAk4KPkR85GmErTSw6wM4DUS+oUlk2ptsJ4ecJNznKxnT8qWjAsxcF4eEPTkEJVTZDy32w6AArO0Dzc1+TeyFW0Jg2Uu/2Z4fD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(52536014)(4744005)(7696005)(2906002)(26005)(71200400001)(9686003)(82960400001)(38070700005)(54906003)(122000001)(6506007)(478600001)(33656002)(110136005)(316002)(8936002)(86362001)(83380400001)(38100700002)(66476007)(66446008)(66556008)(8676002)(76116006)(55016003)(66946007)(186003)(64756008)(5660300002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0PChermdZgMsYDLm6q6u7aS0tVi+1TUov2PryuwYnWeoZJX/3yXV9zB1nuVB?=
 =?us-ascii?Q?Ot8J9xgh9mm1ZqC+wckdDWigWkBJSBX+YIobKidNV8S4W5RZ3gfqTuwyZ/Lf?=
 =?us-ascii?Q?Yfo8tFbvFD5bYVCQ64aJzXGb81dI5UbrrbaTHvri/I4kyxBnEA2Mdk1bDvQ4?=
 =?us-ascii?Q?2OtJ1/6wSnjOUtU/K9dfypDz6T+ClAvU76z6OeflNxjTW/s+VjopqTj1LJbX?=
 =?us-ascii?Q?+yV0oChUnMPbm9tsX3ACjM38F27C7u6QVxt0YlDzLBpDw1Fs6nPyBPW0l0My?=
 =?us-ascii?Q?//nG+o+NZyAqEtCPst7P0RYvLdcdusNwyTQFS4Dx1PrNjEeRuZKDe7tKm5a4?=
 =?us-ascii?Q?BQomd5YTBTc1PkAmwF3jFT5rY3P4O17EcOiMtLP6sOMc/2IN9gSYgaOUb05O?=
 =?us-ascii?Q?sSl37sJVa+ffL4pM0aVM7/ZJd0u8Sxf4lOaArHH5Tls5862aQMp1I0XU3xtW?=
 =?us-ascii?Q?JjFDyvARZNRhH4oe0IXTMPj5GAMiUeb0OOrntOK5DPJEa/WKAfM0fx42++Za?=
 =?us-ascii?Q?SLGqjTIRRfDEimN16QBM//j4nNdG781R+32LGruDFuZr4UDBi7LhFihmp8hz?=
 =?us-ascii?Q?u35m0unQ2s1pIa+WR7d1VPoj5CHNz5tlxV/FYh69Pyg51bkNFaLbEZnB+5F9?=
 =?us-ascii?Q?y7p+wCuyeL4H6c18zHOABWKZV6WiysPOlxz/duId7jbfNL1zMep14CeTWv8C?=
 =?us-ascii?Q?OAYnx+aeaoJ9FTFrLPEtWqTlaxqkJ0gJ6VqssRljpagXdblRoChM3pNEvaEX?=
 =?us-ascii?Q?sN/nKtz6Bnktw8jITs10RtQXgfvIpaKWnOdGAPiHvYRtIN/udxdETZubPfNF?=
 =?us-ascii?Q?jcWaWnN85i1+NfCYnoxQRCOTkB+nywtOcMsE8lrwLvTsdZ9T/3j2ZT1Gr1q+?=
 =?us-ascii?Q?h5HFqAeXqGXRWnSpZLMapylrEbbEyLS9vzuHosrSTsEqID1CrXZjIWQbEhgE?=
 =?us-ascii?Q?qEQ619161EnHuAAjxcf1jb4RJhbVxEHuJ7Xfp39PvIZwVde1HNMtB59livAf?=
 =?us-ascii?Q?uHqU2JA3PNmPiq485pIo2HlZxBsiGxu9r149EOgE5gMyGLAoSK5hChBw8NfU?=
 =?us-ascii?Q?K1EHWQzB1RY1PSoFYhRud9ewsVb3n3ZLWoRorc49zHyQ2ebcAgY9o3UN8kXg?=
 =?us-ascii?Q?lmVPz95qoIXU5Ng3RiafreOzpZPnN+eBzkLFNYkMzJSFLTWkubGa1lbcHcSu?=
 =?us-ascii?Q?W02GEyRDYtRGKA/XmW5P5HlDlKtzBbSubpuze+WOvhbo6PrOPwU9Omcb6zWA?=
 =?us-ascii?Q?AcA075Y6qUcU6Mlk526SQEjTILZgo35PO27rRg2jXsrHUIXipC0RiYE++K5M?=
 =?us-ascii?Q?TK4Firp/a6mtNKiw2NoC5i1EVKSwZVWScwhLhAqOw2vxVN2gpHp1nBSmNWCE?=
 =?us-ascii?Q?sNKASj0c3ot11XORT1TZ5jNGbRtq41wjqMa+K5+HRTMpPETEHtzQ8FYyQAWi?=
 =?us-ascii?Q?j15kTuagXgpJomNmIsg+NYBaDmH6YVMrjxwTorWVs5Oxr7eWkAy16POGYQ/N?=
 =?us-ascii?Q?rXuWG2+g/fWVv+PkpeyKF8I6e38KUJBRHb2145Bfd91PdmEYi9S+ANAbAYJN?=
 =?us-ascii?Q?sk7nd5Gtbi2MdBHyBHhHOf5oWM+vMTtdwtGsTlI4?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f74bf4-0726-453e-c783-08da5b372003
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 07:55:54.4325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrwOrinEu5kupe03AgUgsoJNd9MM0xATf4HMO4ioOl/kObSC2JGuavJC3F7tiWxfD7nNSbTsuTVtc/t7yVGuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2943
X-OriginatorOrg: intel.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>
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
> Sent: Wednesday, June 29, 2022 3:47 PM
> 
> The domain_translation_struct debugfs node is used to dump the DMAR
> page
> tables for the PCI devices. It potentially races with setting domains to
> devices. The existing code uses the global spinlock device_domain_lock to
> avoid the races.
> 
> This removes the use of device_domain_lock outside of iommu.c by replacing
> it with the group mutex lock. Using the group mutex lock is cleaner and
> more compatible to following cleanups.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
