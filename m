Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9597C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 08:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7DCAD402D0;
	Mon, 21 Mar 2022 08:09:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2-ujKXzdxAly; Mon, 21 Mar 2022 08:09:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1BFDD400E4;
	Mon, 21 Mar 2022 08:09:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E602AC001A;
	Mon, 21 Mar 2022 08:09:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE797C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 08:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9856581A46
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 08:09:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6wYXmWVdyiU6 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 08:09:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5326B818C0
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647850181; x=1679386181;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RfkbOuLoz0UItZsTySXOIz5BAmb3y0UhqAGouCU5gtk=;
 b=RqjKe1S4ehEa+CxRKhmRE4CukxU7kUr3GUX7r2g+S47AZt+H7tbMkLZJ
 lDSvyjXug1diU9ZeHWBX+IQliRd0qHpWKCdf313FXfXbZttP+MKjIbgyi
 DWnMfVs4PgBkatc+G6fJGat65PpqJJHINmJh/HOwwj4wItzewm4Hu6eD+
 wBqldgUYYF8tgjFa2CkUSop6/qrDEJ50Q2R18qLKmfrHQ3m2RDAI2R0uq
 dYlTgWY8enqKrYQ9QwXOL/BJq1jrVTM/w+Y1f8242OKV8eGFSXdS0NkQs
 TicrvAxL14403A+qm90uPghQnV8ktVlcDoLoPagIaxDHCxN0kqpEuxfNQ w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="320700979"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="320700979"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2022 01:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; d="scan'208";a="514857093"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga002.jf.intel.com with ESMTP; 21 Mar 2022 01:09:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 21 Mar 2022 01:09:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 01:09:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 21 Mar 2022 01:09:38 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 21 Mar 2022 01:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyzjwTyNBsGn65YsqwjUl0R7LM/vb1E90X6KVpvrYNp4kw8XLp9ry9Y0cROl2Jq999QK/eaIB4JHW0bEd4xVKKEBuDXbuwi1cD2oWIpZvn0pTRFe71WlAterroCTMRTM3pnwSTEsDCvLFmgLvmcxEm/1NaSKPK4sKqGx/qvgQ46dFrphEG0LHvqC6kic6pltjQ9zat/rEjGK3Ti23m317/p1CuGcwv2CPklSQqnk/dsLObmf36XXyiHrb98ooqCbf+L38opvF7Q9Co5g50E9AArmS3osX9VxIfNA6Ql17Ms+o7AEUaZe0wZg+MtBonSkL7q1raUv/1mbNYz3Waw4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfkbOuLoz0UItZsTySXOIz5BAmb3y0UhqAGouCU5gtk=;
 b=i/Y/Q14L/FNiYLZe/m0yZG7dIWzzHdxbjVPyIIEOC+6rkcf6AnorlV0uGm7EFJjtMFaYUcblsJRycemJGcLEKz1siFkQPzsSADhyX5CRKhzyZNXstXejuaBxZC7/R5g+y/8z36A08jj6VpYLsPxT/2PWjPPZZyObEHxFn8mmjARUCOA+may7fbH4MDr0fpRfA2h29whKSdYpCURaNFOJyhO7dNjdpxXA4bHroykDqRazC8lcDt17nmgezRDaggir3epe1B2aC606mI5txIF2BDtws6gI/g9aX3FylrO5sZXt+s7MjED/i/RyBLkwRwRa4Y/O5cv9kk4iPaxCzuMmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ0PR11MB5085.namprd11.prod.outlook.com (2603:10b6:a03:2db::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 08:09:37 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96%3]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 08:09:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.com>
Subject: RE: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Thread-Topic: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Thread-Index: AQHYPCXJ2tlsQR7+N0uG4LpIf9YVg6zJfVAQ
Date: Mon, 21 Mar 2022 08:09:36 +0000
Message-ID: <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
In-Reply-To: <20220320064030.2936936-11-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f6d6850-1aa1-48a9-ee2d-08da0b12241b
x-ms-traffictypediagnostic: SJ0PR11MB5085:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR11MB50858B43123FFA6DEDCE49528C169@SJ0PR11MB5085.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TFbA7iBAeEQFKBKQL0e48QBgUTIG4xmxYeEPGj0PwGZfqR8TZySYFAo6ssUzt7HX83jQk7GV10xkWbojFZ85OHSJPE0tMRIfQ9VOxwqpAnCpiF1HpJcfpL3HSr7aZwx0MJbHqgn8GUBYci+mY0dtpprLO7tmNEBPJvfBFZ9CFnPYMrNu0JL8vMnOFmHgxoJ0GtyDIXLCUAlPoBWuvzGDiTCO5Xj3cNrcl8On+7hVJwyg+z+bAbJgcpad6zlPuZT0OlDRQgLFKoUnQpI1/dVbPaFRrpg2FzjrXKAnip73Il/quGxdC4zrsOQgaKkpv4+WZPWRuB88eWt9+Fo3VyupVU+cYoF//IRmq3n++GqeKcSTaOMcQSV49BvkrZ3OVNyUDNac2T8I1bT+XfiY/VGgB8nrT+pYGJPXvZwzytB1efBg9qsGnW+7Dx6mtiKpExGrSpnzqNdoNqc+NG+1YXB6oQK8p+4Uag0J2lhzbLSojNp9vguAtnlfdArRrGSs44IyTHLDb5NkBMKS5bkFLV1r8PUDst4QQd9bKoe6cYFZSoRiZiQvyF7y1mCaRiYk8Cx0AETSfQtKt0a7ekMVNQnRk38Mei7UW04B40FGTWy64CxxcwXFNQTNEzab4s3NApSf0/EGwm8YNe7rDTKmcRq1zuF2gHiO8SXevVUel/AadbSPgsRG1LA9wVWSCuRdfO4mZ1uyC3XeyWUJoB/zfx4a3hduyR9+6HOSv+Vqe4weTnc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5271.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(26005)(9686003)(82960400001)(7696005)(6506007)(508600001)(55016003)(33656002)(186003)(54906003)(71200400001)(4744005)(7416002)(5660300002)(52536014)(8936002)(38070700005)(110136005)(4326008)(316002)(38100700002)(86362001)(8676002)(2906002)(66556008)(66476007)(76116006)(64756008)(66946007)(122000001)(66446008)(41533002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elp3ZzMveXR6ek1ybFhraHpUYTVKTm1NY0NqYm0vdHRZT1EvKzIzWkVZaVJ0?=
 =?utf-8?B?QUoxbHNpeUVNeGdjZExvN1B2L3V4MSt6blhza3RXOXRrcEs4NHpWN1M2YXo0?=
 =?utf-8?B?NFc2SWhGV3JsTUhHNlJwaGxOTTNNNjNsTkRBeEVGejRGaGtiem9DTmg3V2RS?=
 =?utf-8?B?TGFLSGhjSDRyZG1IR3F0ZVJzUzBqRUdXeWo5bllxalBNbkF3OW4ybUlJVFZa?=
 =?utf-8?B?ZXBReW5KcGJuSkVzUlRZVXE0OFZnSXdZdVJPMmtLSUduQ2dPYncyQmZWaE9o?=
 =?utf-8?B?SUpHeGE2RDUwY3ZLQlJNWWVyUmt3VWk0ZVV6aStQRDVzR1UxQ0x2eUhSVHpV?=
 =?utf-8?B?cWRoMmJrWStDNVZLeDNqTlJVSndnZSs5NnlqZTFXL09SWUFlYTZ5MVdQRmFN?=
 =?utf-8?B?NXJzb2YyZW83QjNhRnI3dkxqU2hCcHlDdytzWE1hUlBDUTV0bGZkVCtwaFNL?=
 =?utf-8?B?dm5SZlN0OVE4bmJVbUQwVjJtWUhIMHlxaW1ycitrRWlsVXIrUDcvZWFUUEU1?=
 =?utf-8?B?eVMrMmUyb0poYUs1b01PalUwamw2WnNHREgrNlMydXFLbFBHYlJEUDgzWC9T?=
 =?utf-8?B?V2VVZ01ZL1hpaXM4djFkdWNVQU5oWThMdlQxaUhYbVMxTjB2MUp4d0gxSDRC?=
 =?utf-8?B?SWdyU2FyL0V3cmhkczd0czAzZHRwVUhlVHBZVHc3Q2JQZ01HQjh6M2txNlF4?=
 =?utf-8?B?WWs5ZlZqSElVVUdZai9JOGwyMUlsSVBTUkNTNTllMU1ITzJXWUtmVUVZWFl6?=
 =?utf-8?B?aGtEL0Fia0g2K205Syt5eHNvKzlEeDhUSVk2aUNnMXNFODh2dW90a2ZiNkMw?=
 =?utf-8?B?alZnbEdKVFZyUUdLc0Y4TWlrckExVXpML2dBbkd4LzlCUlVDWUJWYy9nMkt2?=
 =?utf-8?B?MVlycE43WW02Z0Jobk5TUzhZTVJLU2c2LzJYUlpPU1A2VTR2Umt5R2tZMURk?=
 =?utf-8?B?U2VjOXFwU3A0ejFIbDlMcUFKM21RNS9vc2wzbG54cVJKZGdRQkNiajhjTWJ3?=
 =?utf-8?B?bm12eENlYmJ1Y0xGVTZEQ2M3UEF3OVFaKzY0elE0S1AxZC9uOEpKZFlINWUw?=
 =?utf-8?B?MEhyY3hhTkRrWCt5aFl4M3JqMzNpbC8vZmoyT0VBWG01TFhaTlUzak0ydXRE?=
 =?utf-8?B?eElWaWJjNHQvSkxqcUhlbGRvMlJ6U2FWUWp6UzdlTjZNWlRaaEpCdFJJeGJa?=
 =?utf-8?B?MVp2Tkt4NHMydFJmRWlsWmtGcXlnY0lENGhldmE3K2l1L0RoSnZIQmZ5ekw3?=
 =?utf-8?B?TVZ1cXVRUXlrTzZnVk0vaUFqVnV1RWg0aXhmSFkzendtN0NMTjc4bVZEMzl2?=
 =?utf-8?B?b1lqQXpxb2hsOElieTRkN2JaSVZiNE1mbW5QV1YvWkhZb3BrN0JYbXp1R0Q2?=
 =?utf-8?B?VXdjZUZpZGZ1cWx6NlZjay82OXE0Q2ZBN0QybnRldHdqNVpWeHBVdUVOSEdX?=
 =?utf-8?B?VWhhaWtYUGJTUXFSdGpBVXVnSjdROVBmQzJVM01EOFNCL2d2SHdPYmZRMzRr?=
 =?utf-8?B?WStzZnpTbkY5N1Z6MUtCbGdqSDh6NUltc09WKzRlcWc3UmUwc0JCK2E1WGZK?=
 =?utf-8?B?RHFHWUNwZGtoV0lwWHlZL283cHJteTVneFUvQndNUzJFREhVZTVIN2xUVlc1?=
 =?utf-8?B?T01HSE14N1BlUWNDVVU4RXVGT1ZvdjZjUXdONkNQS3FkZW9TS3NnRnR2VFNO?=
 =?utf-8?B?YldIL0JMeWZFaHYzN1NnbjZkVFRicU1EVTB2Q1FLVlQvR09HZWNLdWpiZm5Q?=
 =?utf-8?B?eWJmMkg5a0FXN3ZEZmZqRzdyWkxtMC9sQ1pqSWgrVDBUK1dxckJmRTJGSU1y?=
 =?utf-8?B?bFBGMG81WTQ1R01XdmFNLzNIOXpVTFNWZXE3MzJwQWdnbW5NSTQ3U2ZYWkI0?=
 =?utf-8?B?SFhWQnBSNGxFenh2YzdKeFQ4R25GeTRpeVVta2Nlei9ZdTFxSFdQUDVRamFZ?=
 =?utf-8?Q?eU1hohrUJXTVCLHxo5BRAFjn6NjyxJB5?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6d6850-1aa1-48a9-ee2d-08da0b12241b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 08:09:36.8692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwqPC//hFaiZv/07agYDG/IM24JH/SpW4k8Pm6fFTQEE6vbawABBIeD5wFMu5jzA+5v2EMXsoYAlkPJxmMjr+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5085
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIE1hcmNoIDIwLCAyMDIyIDI6NDAgUE0NCj4gDQo+IFRoZSBleGlzdGluZyBJT1BGIGhhbmRs
aW5nIGZyYW1ld29yayBvbmx5IGhhbmRsZXMgdGhlIEkvTyBwYWdlIGZhdWx0cyBmb3INCj4gU1ZB
LiBHaW52ZW4gdGhhdCB3ZSBhcmUgYWJsZSB0byBsaW5rIGlvbW11IGRvbWFpbiB3aXRoIGVhY2gg
SS9PIHBhZ2UgZmF1bHQsDQo+IHdlIGNhbiBub3cgbWFrZSB0aGUgSS9PIHBhZ2UgZmF1bHQgaGFu
ZGxpbmcgZnJhbWV3b3JrIG1vcmUgZ2VuZXJhbCBmb3INCj4gbW9yZSB0eXBlcyBvZiBwYWdlIGZh
dWx0cy4NCg0KIm1ha2UgLi4uIGdlbmVyaWMiIGluIHN1YmplY3QgbGluZSBpcyBraW5kIG9mIGNv
bmZ1c2luZy4gUmVhZGluZyB0aGlzIHBhdGNoIEkNCnRoaW5rIHlvdSByZWFsbHkgbWVhbnQgY2hh
bmdpbmcgZnJvbSBwZXItZGV2aWNlIGZhdWx0IGhhbmRsaW5nIHRvIHBlci1kb21haW4NCmZhdWx0
IGhhbmRsaW5nLiBUaGlzIGlzIG1vcmUgYWNjdXJhdGUgaW4gY29uY2VwdCBzaW5jZSB0aGUgZmF1
bHQgaXMgY2F1c2VkIGJ5DQp0aGUgZG9tYWluIHBhZ2UgdGFibGUuIPCfmIoNCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
