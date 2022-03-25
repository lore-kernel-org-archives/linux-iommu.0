Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB68C433F5
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 08:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D207440531;
	Fri, 25 Mar 2022 08:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bSGtseDqifMH; Fri, 25 Mar 2022 08:17:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0D1524026A;
	Fri, 25 Mar 2022 08:17:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D45FEC001D;
	Fri, 25 Mar 2022 08:17:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB1A8C0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 08:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3ABB61028
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 08:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SuBGm6XkKo53 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 08:17:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76E6E60BAD
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 08:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648196227; x=1679732227;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yMcddEG0m3Qlx4cOCIdxPkiaNKcIsXeTEHhdidBhOE8=;
 b=R2MA3xP3VEFsYfcEQc6g5vlUp1voqfY16rYCLsmHrjJfxPDOn4gwkRC2
 apEn6bFo3LcpuozgcRnjmXNdKEGG1V++d3wjD1Q6khX4eCwUY0CvJGcU/
 0ByK27P0tRf+q3ow7LuwffhfPClU49kNhPasv6n4b1zpLOfC8DFUAzoFW
 04Ux9J3GrSZfSByGfAOOJtPNaPpHDyUcg+muxKUM1+oob8hmskAglZzSH
 NYeQ5pdXgLoIaYD9YtPTZb0W+lHpL/1HBTVUusTnvrIV2r18DTNiStxvx
 VlqsDOmMYnFofueRYJZm+2aSvDcSXHRDKCB8BWZAiem+BsUC7b1wieoc5 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="257410971"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; d="scan'208";a="257410971"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2022 01:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; d="scan'208";a="718137777"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga005.jf.intel.com with ESMTP; 25 Mar 2022 01:17:06 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 01:17:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 25 Mar 2022 01:17:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Fri, 25 Mar 2022 01:17:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAU7fZZkcvJ/RRabCa448GyyRw6Q+FywKssmj8fQgFN59GAzOG7AomrkGnObL6ZfzGKqFB/e9NJv6KPIE8vHVLUqtXomKJPzK0VqoWU9/o32a0CvEhbT8bxG4LNvpBobOTu8wcA4bLuCG89tLacmGF3EyWHYoGZVk0K5EnvbQ5/OiqjiWVf4wHVlg5NU234DGV1cNby4wtxmzHu6H+utgvnD6bhEHmcaZ+3BHerCTN0ITtDga0hCxK7+Zff7gpUMI/kPl0pzjSlDGXBKczWs1BnJgN1820eGx7aH5fRs6uXokONPTC8kXY71fGfk9mNpupwljuMy4SCOiTgjMCoxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMcddEG0m3Qlx4cOCIdxPkiaNKcIsXeTEHhdidBhOE8=;
 b=N/z67Vv3FERLK59HuTEvgANWZG9lpTaI9+SdrJ+vkCGi/RU7fYhh9PEuZ41vAcjmaop6Pxwg1wkvScl+pMH0t/Ih3GMbZzV1+PB6htRAArR4vJRf4KVQpUwGibM2/5i41A59ipHKmt7CFQUSDlTg+QqmzsiSR2YEslDrC4p8N/BtbrOQ6uC/8OzuBHQ72t9MXyZQ3TzvLIj65zaJTJX+2awOgrgecxBVtFjJzI2cmB7R46VUac03Vkbg4mhEO2SG8GRr4Y5o2Ol6lld74nJ/I2I5FvA2xohgWejpva/BJbvXmW/zqs3cMRsHVZSsILNced0vJt5UNEwyvW/EL/mQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5538.namprd11.prod.outlook.com (2603:10b6:610:d5::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Fri, 25 Mar
 2022 08:17:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.018; Fri, 25 Mar 2022
 08:17:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: David Stevens <stevensd@chromium.org>, "Zhang, Tina" <tina.zhang@intel.com>
Subject: RE: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
Thread-Topic: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
Thread-Index: AQHYPbc7YJqxtY3XIkKe9qY2q/ald6zPnLVggAAX/wCAAAfXAIAAB+dg
Date: Fri, 25 Mar 2022 08:17:03 +0000
Message-ID: <BN9PR11MB52766D2B028F7EBD7D6696FE8C1A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220322063555.1422042-1-stevensd@google.com>
 <BN9PR11MB52761E41CAD28CFCB935688C8C1A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <MW5PR11MB58814148CD05C8284C3BCB23891A9@MW5PR11MB5881.namprd11.prod.outlook.com>
 <CAD=HUj5dPb9jsUyh5REm=dX0HJaqW807LxnAouQ9rspMHB7vuw@mail.gmail.com>
In-Reply-To: <CAD=HUj5dPb9jsUyh5REm=dX0HJaqW807LxnAouQ9rspMHB7vuw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d58b6f19-a029-4a49-1c6b-08da0e37d828
x-ms-traffictypediagnostic: CH0PR11MB5538:EE_
x-microsoft-antispam-prvs: <CH0PR11MB5538D0176E38144D99DB98DA8C1A9@CH0PR11MB5538.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlzpW6OHOfYCFbZQIl7tqeHRcSHKucOcWYgK945XyM2t8pFuT7NAP7Xrz2a0fLXDUteoMDNQzARsRYRABhBv6x/Wnbn4umQiaEnYIH2sXeAWPgzpU/IotrXn8Bc2mgsC5f2tMI2F3jpdlBm4J/q2pvMMtPZLaaNloD79LmJ7RPlVROWZWMsB5PogI5Hidk6PYQXQ05BI9ZhWxUGjCQ4B2iQQkAkOLmTAB5TYhVVV07ofi9k9Rtp1r52J72ShBd+HbtUQtVhhrXuMWvTTahAPG9nP3xRAmpthLBeTIqjfiCXHDieNZQySmSHaWBh3EhfJvluLF5nTFeopfe5X5v8Ir+Li8+kK09YicOujL3cLIpXvAo2TNVgi3JtKZNrTV+oCEz2WOUV88jMMRj92PzZsqp78iWndyFbGkO9fsCExVwd7jH3G0kw3NUKiiz5lQecD2Ybuk4t4sTmaxFPBwE2xMTEur74UF2NQlMAtbqYoOLMxFKIZdaNA/RC2lTQchnweU0L7kIClC3E2ftumDaJLP1dhUkNhXgOmEkMPpQNy+BFHjZS1Vc2QG6odLrLWIyLt76mkUDl8Kfql5Zus9pBs0tuNcXIZVvHHLzFPsmA68dVY5+za5khoi214Tf8oh7Iurt8rm2D9eakJp7LOWlAiXTrQdpuIYAsbSh5XUOYQYaaxO8UmUkB876orAuSvZn20RTZMWP+oW0cwu7cFDnj5Cw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(38070700005)(55016003)(9686003)(54906003)(82960400001)(122000001)(2906002)(5660300002)(38100700002)(52536014)(8936002)(186003)(508600001)(6636002)(86362001)(26005)(71200400001)(7696005)(53546011)(6506007)(110136005)(76116006)(4326008)(66946007)(83380400001)(66556008)(66446008)(66476007)(64756008)(316002)(8676002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VExUa0tMNk5IOXRKcEVNNVpmV2VWaWFGQmFnTjZXSElFZXBDbW96SkNvT3h6?=
 =?utf-8?B?a0QrT0lUR0lFYWdRajlFbXcvdUdxeHErc3VqR2hPTFRrNnlNdEwrS3FTay9K?=
 =?utf-8?B?Mm1zdWVXaTN3VjVzVGpQaURkZENjZFpmL3JGRVlxN2ZyODNNMzdSNHJVZUNz?=
 =?utf-8?B?UWJpVE81Zm1xSGRKWTY5MitjN3VNdUtZTkJVcStVWElCV21PaUg1Nm5lMWUw?=
 =?utf-8?B?Tko5bXo1RWpqTk1GR0U3OE55UlpNdUhSbnRiMXNNZ0g3NVpkc041dy8ySGVR?=
 =?utf-8?B?UkJPc0lOcUxiekZ4Y1BjVVlFbEJseXkwU3hNdGpWYzNvYjdrdWpYQXIxZjlM?=
 =?utf-8?B?a3NhVDhVYUNnSnNGRXRaQ1FweXRXWkVGVkJQNlZjYzMrZHIvN0w3QXZTWith?=
 =?utf-8?B?TXBnWHRHbDcvL0JuNVd1ZTRuSjBvVkVta2pwUFRIOG1ueWVLSlJHYjkvZVcz?=
 =?utf-8?B?eFprQnV6TEF6VFlvbUFZVFc3RlQwVUZrZXM5czY5KzNUeWxRVFFFS3h2V1F6?=
 =?utf-8?B?a2RXeGxoaTgwY1FHblpkQzN3bUJUYnNuMlBHbHpWeWY3c1RGWHdsOHV3VXRa?=
 =?utf-8?B?U1gveHJqYUkzUFJVRDNidmpoRHM3S0ZJRlBKUjd0bnVLVjVWNkZrMktKM1JC?=
 =?utf-8?B?a1BZamxIQjNRSW05ZXdzL0FvUlNxeXJ3Wk54UTIvTlcrajR3Qk9PNUMrcVdB?=
 =?utf-8?B?djlaU2JvUG5IU1ZkK1VheGJCQ1pSMWY4U1J3RXRQdXBaRS9XS2tIdjF2UzVQ?=
 =?utf-8?B?YmdHaUtlb0hWMzRRWnVVRzdLd2xlb2hIcnBYT2M2NlY4TVdmOXBjREVCUWdE?=
 =?utf-8?B?alVDUkh3T0hQNUkxc0pZalFMcXB5UDNmTkVFOUR3SndlenhyNkNUUVFSY25w?=
 =?utf-8?B?WUZUL3hoR1VQZU8zQUk5cmtJVjB3akhZQ1ByNWZFNFVhNEh2YjdEL3ZFRDBL?=
 =?utf-8?B?K2RSdHdBU2lMWjF2YWdncVVvbk15Mk1VamZaQmdCcTlBVFRUeW85Q0s4ZlpC?=
 =?utf-8?B?ZVZaOFRMTjBxM21TUDhTUVJLbVYwMnhYV0RvbWNudGhuM3BFQXdBd21ZTEdG?=
 =?utf-8?B?cHNmL1FzQ0NhanpEM1hFZ1BFK29GQ3VDdU80ZzJCWmNLK3hBVk1NVjhJUExF?=
 =?utf-8?B?YUNEWnhyUldJbHMwQ0h2QndFMWVHOXdnMk5YK2tobzhScVF1ZzB0TFBEZHZ5?=
 =?utf-8?B?YWczQnJnRUxlRmxKY01xcW8rSUcyT2lhZWhHUVViZmgrcmQ1bU9EYXVKNXZF?=
 =?utf-8?B?NGl5Qk5EUjJYeGQvZHllZExhemZFcG5NSWVNdllZTlNsUDhRd200Sm5FZVJ0?=
 =?utf-8?B?OGNoTERqNk96STBiY2pSZyt6SEZEU0NFblI5OFVFZ2s3NC93RHg5RUlVTjdn?=
 =?utf-8?B?cGxFeFpFalFkeVlIb1VqNVpQekVmUkV3a1BnTVpRUXBZVlYrSWlZWFFmNmRq?=
 =?utf-8?B?YWJNRGJ5cVpIVWxMT2Mwa3Q2dXY0WjV4OFVkQkVSVXBYWXRhYkwvNDVVSEpG?=
 =?utf-8?B?Rk5INCs2ZzYzY1NERDFYenh1dFV4ZWVzd01wam5CUnAyMkV2OWxTZ3FaOUs5?=
 =?utf-8?B?SEhoU0tQVy85cXFlU0lRWURIeldTV1ZMdGpCOGdOSXB5UUNmc2lMSHQra3NI?=
 =?utf-8?B?WDZlQzVZdkRNcmhLUWh2b1gxSyt6RjREWDc5c0hYL21xSy9SWStpSlZoaUNs?=
 =?utf-8?B?blJEMHpOeFArSWVzd1p2S3hIcW5yK3NjTzkwanJNcUtvQ1JuRlNBbnZwQjlt?=
 =?utf-8?B?YmRVNm5ZS3hrRlc0TjhVK3dVMStkdlVSdzhiak9hYzZ6MVJLOVllaTFrd0t5?=
 =?utf-8?B?UEw5RnJUNEhRTXhCVDRsNE1USHA5a2FrcEpSRkhMUTVrS0lXdVFoR3BvUVJQ?=
 =?utf-8?B?cDJ4MG1tNGVWRVRhdmpOTTV0dXNCejlITEFDaGJIL0JhZ2dCMXkrTTNHL090?=
 =?utf-8?B?RWhHNVFQWFpvbXpXS1Q2alU5VDMvQi9la2hjRGFYa3NCYk81Q0s0NEw4YTRH?=
 =?utf-8?B?TVgyZG00a0hRTjJFSlh2bGkrUXg5N0VJUTErNnIxVFJqL0JLdXJ3UFNPK0pS?=
 =?utf-8?B?MkROemFhY0RFRENRWkxuMit2ZVhvb0ZRNHRMWnhYb2hCV0ZhZm5DMUtuazV6?=
 =?utf-8?B?d1gyRnhPZ2hHSU1ZMEoyT0o2V0kwdGtZVWl0TFUwME1VMlBiZ1ZvcGJ3Nmdk?=
 =?utf-8?B?V1I2dGwraGhoVFdXYkNQWnBacmx6NER1aFpickpDRHVWeExsM0RCNURmU2Jh?=
 =?utf-8?B?SU8wbTEzUG5qYUJRVHVIVVRkS08rb2RpcTkzVkhnVXZySjdPUU9BTTI4QnNw?=
 =?utf-8?B?RHYyWFozeVg1RjVDNko0Qm1xdk9QaTFzdFo3TnZTQUZiR2V6Z3p6UT09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58b6f19-a029-4a49-1c6b-08da0e37d828
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 08:17:03.8532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WoQJQnQC5UKrOE8zE4vVCafb6gsMt+TUU8Txyd3yylEtdI5A/xmyC5kp2CcatrM8P0ly1ta2nsaqdBbPUaIQcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5538
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

> From: David Stevens <stevensd@chromium.org>
> Sent: Friday, March 25, 2022 3:43 PM
> On Fri, Mar 25, 2022 at 4:15 PM Zhang, Tina <tina.zhang@intel.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of
> > > Tian, Kevin
> > > Sent: Friday, March 25, 2022 2:14 PM
> > > To: David Stevens <stevensd@chromium.org>; Lu Baolu
> > > <baolu.lu@linux.intel.com>
> > > Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > > Subject: RE: [PATCH v2] iommu/vt-d: calculate mask for non-aligned
> flushes
> > >
> > > > From: David Stevens
> > > > Sent: Tuesday, March 22, 2022 2:36 PM
> > > >
> > > > From: David Stevens <stevensd@chromium.org>
> > > >
> > > > Calculate the appropriate mask for non-size-aligned page selective
> > > > invalidation. Since psi uses the mask value to mask out the lower
> > > > order bits of the target address, properly flushing the iotlb requires
> > > > using a mask value such that [pfn, pfn+pages) all lie within the
> > > > flushed size-aligned region.  This is not normally an issue because
> > > > iova.c always allocates iovas that are aligned to their size. However,
> > > > iovas which come from other sources (e.g. userspace via VFIO) may not
> > > > be aligned.
> > > >
> > > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > > > ---
> > > > v1 -> v2:
> > > >  - Calculate an appropriate mask for non-size-aligned iovas instead
> > > >    of falling back to domain selective flush.
> > > >
> > > >  drivers/iommu/intel/iommu.c | 27 ++++++++++++++++++++++++---
> > > >  1 file changed, 24 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/intel/iommu.c
> b/drivers/iommu/intel/iommu.c
> > > > index 5b196cfe9ed2..ab2273300346 100644
> > > > --- a/drivers/iommu/intel/iommu.c
> > > > +++ b/drivers/iommu/intel/iommu.c
> > > > @@ -1717,7 +1717,8 @@ static void iommu_flush_iotlb_psi(struct
> > > > intel_iommu *iommu,
> > > >                               unsigned long pfn, unsigned int pages,
> > > >                               int ih, int map)
> > > >  {
> > > > -   unsigned int mask = ilog2(__roundup_pow_of_two(pages));
> > > > +   unsigned int aligned_pages = __roundup_pow_of_two(pages);
> > > > +   unsigned int mask = ilog2(aligned_pages);
> > > >     uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
> > > >     u16 did = domain->iommu_did[iommu->seq_id];
> > > >
> > > > @@ -1729,10 +1730,30 @@ static void iommu_flush_iotlb_psi(struct
> > > > intel_iommu *iommu,
> > > >     if (domain_use_first_level(domain)) {
> > > >             domain_flush_piotlb(iommu, domain, addr, pages, ih);
> > > >     } else {
> > > > +           unsigned long bitmask = aligned_pages - 1;
> > > > +
> > > > +           /*
> > > > +            * PSI masks the low order bits of the base address. If the
> > > > +            * address isn't aligned to the mask, then compute a mask
> > > > value
> > > > +            * needed to ensure the target range is flushed.
> > > > +            */
> > > > +           if (unlikely(bitmask & pfn)) {
> > > > +                   unsigned long end_pfn = pfn + pages - 1, shared_bits;
> > > > +
> > > > +                   /*
> > > > +                    * Since end_pfn <= pfn + bitmask, the only way bits
> > > > +                    * higher than bitmask can differ in pfn and end_pfn
> > > > is
> > > > +                    * by carrying. This means after masking out bitmask,
> > > > +                    * high bits starting with the first set bit in
> > > > +                    * shared_bits are all equal in both pfn and end_pfn.
> > > > +                    */
> > > > +                   shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
> > > > +                   mask = shared_bits ? __ffs(shared_bits) :
> > > > BITS_PER_LONG;
> > > > +           }
> > >
> > > While it works I wonder whether below is simpler regarding to readability:
> > >
> > >       } else {
> > > +             /*
> > > +              * PSI masks the low order bits of the base address. If the
> > > +              * address isn't aligned to the mask and [pfn, pfn+pages)
> > > +              * don't all lie within the flushed size-aligned region,
> > > +              * simply increment the mask by one to cover the trailing
> > > pages.
> > > +              */
> > > +             if (unlikely((pfn & (aligned_pages - 1)) &&
> > > +                          (pfn + pages - 1 >= ALIGN(pfn, aligned_pages))))
> > > +                     mask++;
> >
> > According to the vt-d spec, increasing mask means more bits of the pfn
> would be masked out. So simply increasing the mask number might not be
> correct.
> > This second version does give more consideration on that.
> >
> 
> Right, this is what the more complicated code handles. For a concrete
> example, if pfn=0x17f and pages=2, just doing mask+1 would only flush
> [0x17c, 0x17f], which still misses 0x180. To ensure 0x180 is flushed,
> mask needs to be 8.
> 

Indeed! obviously I overlooked the trick here. Then here is:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
