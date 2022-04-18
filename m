Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C014BC433FE
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 06:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58B3F61208;
	Mon, 18 Apr 2022 06:34:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9CM9GogzN_zK; Mon, 18 Apr 2022 06:34:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 17FFD61205;
	Mon, 18 Apr 2022 06:34:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A9A3C002F;
	Mon, 18 Apr 2022 06:34:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90F40C002C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 06:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6854B61205
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 06:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ovsRMbLLQxJ9 for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 06:34:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C042360A93
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 06:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650263664; x=1681799664;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VYyOyydQC6iPGsv2R19Jfrm0YeFfIgmNBy8S393+lw4=;
 b=f1xCN74Oe5YOMtCy3t10LKMyhwi0H4PfIJZ902Fa9NExp2ZvbXE8GF8m
 bUoMXPBJyZWE/0D6NBT04gblXMbHfYPTDb9O1GB9IxYL8K9a8T5JyiyeS
 JOlBl70/pKLNS0uNKVWsd2+rG8LnjXeztC7I3+Fw1Ba8+y2Wxr/iFTAhC
 FRUFf5+rvmfdVWmBkdgo4/hv+7qT9SErby6mm2hUNgK9f8n/E0URb0nWZ
 YpZ02gFzt64QsEtZCCa9hj9VNEkjaknXmZppysntDCzAvWHMSnTuSOUvc
 ajiNMBowV/ZtM6D/u6SGxt5ohrnp/KjzBRJ9dwZ016XAX34a6sE0l4lVG Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="326363696"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; d="scan'208";a="326363696"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2022 23:34:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; d="scan'208";a="561243832"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga007.fm.intel.com with ESMTP; 17 Apr 2022 23:34:22 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Apr 2022 23:34:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Apr 2022 23:34:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Apr 2022 23:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APFHDQXHIYhzS17JF0USjZl6KBSbLk4KLcNZc0LvzinFduJbPGOYaPof10XBLbWndOG5C8B4G5bJo+uOFSFL9Hajieo1vNr1wl/iDrdyl87Fr1jgLFdncK17TVJwbys8GUd2c3/uw/sZOGuoBHviX9Ce0ZLuuihgMbbLciXpHT2fSVV67yFHZtMg1IykI6OosSUhj5PCO+pl1ZlSjuwFP2wF2MdxqBtb5PXX9lh+TOeUhOIOuPO8ua8ZSk6Hcikzgjs1dtHLSL5oiBJDjaRTsrk+4eq+NDk9dmC7U2WTnAYJTxCDF3mQ2G2P+X2az7KcRSifCIY6ok8A/9qs4bZYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6wEBjUjx9A/mKlPTsCmg3kpIW8ugLl8HEdYfhbBbJI=;
 b=dpOvuHyB/rG3JB+xs0JWhCk0PANgsOYYtfEfjRJSSjQ3w+lSFJpOuSo+9D37ceKn5Dw+ncxTChnVnaaBwGWNki1Qm5Jbafo4uA8e4yX3u4EfELGuAE/TBnFimojMKlSVmj56FwytwWBUYiRiqE3+x3hIPh1NB4Q2ht6gFDbZucs5n6FqA0EqPj6BVU/OW1o/I5TPsWsSgRSoafpJDIWuF5NjZ2DH636BjxyJAewZbLq2dzLEHB9Y9wNumv9QGY7VhBpzzk+pgP6SqYyXKRYHNyDKOCKals1WEUzEAHaGM73rvfK73yUsP+kpWVdJzLHUO1ujhnNaq/ULPZKp2eOo8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5453.namprd11.prod.outlook.com (2603:10b6:5:398::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 06:34:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 06:34:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "zhangfei.gao@foxmail.com"
 <zhangfei.gao@foxmail.com>
Subject: RE: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Thread-Topic: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Thread-Index: AQHYHHcYr3pxcExTDEW1Xvk+kLHIpKyUa1mAgFa0xYCAAALQgIAAAs6AgAAEYQCAAAInAIAAAneAgAEPWYCAAG8QgIAAH9EAgALJMoCAAY2TAIAABm+AgAAKLwCAABErgIAAmRsAgAO/hhA=
Date: Mon, 18 Apr 2022 06:34:19 +0000
Message-ID: <BN9PR11MB52765490BFC5F08CD4F7A9208CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
 <20220415140002.7c12b0d2@jacob-builder>
In-Reply-To: <20220415140002.7c12b0d2@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90076819-0d10-4e77-4345-08da210577de
x-ms-traffictypediagnostic: DM4PR11MB5453:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM4PR11MB5453E780E84F2D646D0ADF798CF39@DM4PR11MB5453.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DjiRW5Md8j3SZaZJktwO67F6q+taBiwsHvczH6hTIc3jqRJwn81PrigzQLQ1LMBAHzDcPrzK6q5ZVGmYH+oaRYYd0DAqQHkopKPfx8t7mASQg9NNiRxZhySh+3JpCmT0zHjGKYS/e093J/QLHF8tQh8LwoDk9RxluMpljQN1DeQ453q4E6ZrRLNPYrOawiKjysX903i4jh3MNnHzhfB6WTy4XQarG8x33jwTi1AYBADexd7yIfRXaROA8tOIR0P/v5kYa4lgzag68i7epOJ7NtQzAF6m4uzM33EmqeSU/NkdBz8/lrLRZbeUti110Z4XFSShqOosxcP3ie9pcW4xUR0I3rvUZ1R5S07Hr6YWpKcCRKHszOQLVEzVSEn6LuLPavXD//A+8UFz2c9keEUw73U8gFL/LBHgtGOw1PVeascOO6S1apwSX2nUDV9i8bHAzzE6+f8Fw9qIXiEOGR6n3mt8LenWcMn5OIoiTEwA+oJGdY94dLyp9i04bbo+grzNllqFClKWAQXzFsT8tJCKY9rPIVWMNOTLyNVlpbQSH8FePihT5Zos1rfY+DZP/r7m33au5rJeoHYayM847b0cf8DphrjiV0jX2d6vejxqytaCptKnwSpvTYUpX3d7Mh+WSj3P+1W9dESDYs5cO7StH4O5t5VuBfLBNrYMpMS1XwbUajPFJ0pHE5n2sPhwyVioVVikxeWhEn570V6KVAzIxVdF8kDBILcaIa1I2bstPgkdV95vsz03spM8HvL+/LTtJz66IGqHErnJOG5UBgT1rA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(5660300002)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(55016003)(82960400001)(6506007)(7416002)(52536014)(508600001)(316002)(71200400001)(2906002)(110136005)(54906003)(26005)(186003)(8936002)(122000001)(4326008)(8676002)(33656002)(7696005)(86362001)(38070700005)(38100700002)(83380400001)(9686003)(577694001)(48020200002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tQAX163dfm8RjEzby9aTDAGYP+quDAU0tby7+1ctj7KxuUIk3fHuL6DS+5oN?=
 =?us-ascii?Q?y5o02rVQ2hW8CAhzUOzBjp2/Jcm/E2nosNJCKYCVmeAWcVzh3HlQBJpwtG1T?=
 =?us-ascii?Q?tHAT1Aj/pcOrPQ/V2NMZ3VRHh2nDMip8lS/vBWf41F+Kz4AGQbP1u2LnJmYb?=
 =?us-ascii?Q?TlVPosaGvCStUfdfacIoTUoc+lIgq/0OTJW5V2bU/742q+cGmCa6pQy0jTXG?=
 =?us-ascii?Q?oBh8BpkY55R22LMng/PY7ARKXNVPoOmpqT8rNQpGSWGvDyi04ZEDWIRzPx0t?=
 =?us-ascii?Q?dA6Es+/S+iyk4o/j7t84ELwizyXfwCx0Euol+BRIsYyDGuyYldqrjp7sxZan?=
 =?us-ascii?Q?gafkyr8DYXFwrjYKaAG0wzORVHhWXkBErGvZiDCtAph6ml0VyVyI1qGZ3btW?=
 =?us-ascii?Q?HBxxO5gKkFr3ShzKwBaaOfjRRaHNXRLrzZc4lKjYZvaGbwbvBfCq1t+MmEjZ?=
 =?us-ascii?Q?tSRyUNMpKlYpJy6FuqspB1HtmeLUZh2jJKu8YGmv7+kZtdsGzSl1qdfMIIWm?=
 =?us-ascii?Q?isx+pARiTNTbwu7qqvPXYp1EMQabUzn/oXbGXNAn6ED60UWypoNMSdjSCXwN?=
 =?us-ascii?Q?3oYchc0nXkT8XXGdkeqAomBfi2nxZCDlu4XCaQnkYXvWCVEv4RnD/xQ/9EGa?=
 =?us-ascii?Q?bTJDACUF4ngUuKBmnhqOfkn5UwU4dPzKITUzhLSytesQW9IGbY4y02KqiyPy?=
 =?us-ascii?Q?kMkLJRkpVnxL08o3iu9KDRCxTT/xghe+SuVRMl1fTcdIO6XOIx7dBxAqxdZ+?=
 =?us-ascii?Q?s443iu4Rz5bZ9ob2Mkh9ossl90WV5eCyV5Ly43HHwSSyfEVtmzxAbOjPkfr1?=
 =?us-ascii?Q?NlotHYI4jAp9DB3vWwwzyQGHBI9tnkiKRlNtyAoNpsXo38OjNDghwNzG0L/G?=
 =?us-ascii?Q?AOd7CkBtc+VvvxxbYuH/Ek3L2xC2OqR1E7j4/kdFabXr9SwpD2vUcMm8OliN?=
 =?us-ascii?Q?icwFVgHTOgrql5Z/2JZyZYq+49nGCmmhHJkQDxox4jzKf4mO+MUaxdtFSxDz?=
 =?us-ascii?Q?c4ewYfcRkJ+lSNPYfVCzFY95qfoxE13fQvs6yN0V2y1F1MM5HRvLiO7bKybG?=
 =?us-ascii?Q?QXFM+hhDPXyEMDbF1W1CFx/g5YcURBHDh/WAHVaz87d8FJ7QSy50p8joOZTO?=
 =?us-ascii?Q?0Waii9AX//renJqVlu8udSKBIAc78WS7yfdld3VgED1w+tSdI3qlwWuU6YC/?=
 =?us-ascii?Q?fSjNeZIWEHwAQ9QJU42AEcLQRx1yE8tjcipNHrB9j7etXzwReX2/vVT1VpYD?=
 =?us-ascii?Q?+D4y4l711/ES0jnsMkLn61Joo8J7ikQKYCsbz4LilGzNG0AzkpU6k6btOXtr?=
 =?us-ascii?Q?Mq6QJg6o0+17zKyICPPZmyY7Bbls0AAJvaZaqIG76lSt9zzL07iEmacpcHrf?=
 =?us-ascii?Q?YG56k2olASKtR/BulKAP/FmisRz3f2gkZbmehRb1x2atU67npwPgcNV5Em3W?=
 =?us-ascii?Q?+XEzZdu1u0pc4fjVFAhxIAStyxrpH61r3gDYM4I0UdUoHcewHRDhP6swX7pM?=
 =?us-ascii?Q?3ho42XSQ/eWrSgNc29it9g2jCYuwKPtxlnMuUCRaW55+YtGn2BK0vRzeyC1K?=
 =?us-ascii?Q?XpUQo78n8pqpnM63uZh2j2y+nGY2aktE4hevBc6Cr1UyKACJaOKAHITobW2Z?=
 =?us-ascii?Q?mQSzI3QDshA622zLxIOWF0NV6gcLJzW/fUUfyn2XxzjNGP7XHcBXB+Cp3kx5?=
 =?us-ascii?Q?tpfmfpU6t7P53Z/pK55fjiuwyUhdjUW5xAI4UPKJOgTKjwRmeUOIEhOogDOj?=
 =?us-ascii?Q?XrrEte9e/g=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90076819-0d10-4e77-4345-08da210577de
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 06:34:19.3755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHvqN2sNg9VT2D05GePT8hgMngxGQJyQI4iWN4GFXzTdU+CrIDA2So6UTu4N0DEbHaR8RPY8HlF/SZ1ZPWG7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5453
X-OriginatorOrg: intel.com
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Shankar,
 Ravi V" <ravi.v.shankar@intel.com>, jean-philippe <jean-philippe@linaro.org>,
 Peter
 Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Hansen, 
 Dave" <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Lutomirski,
 Andy" <luto@kernel.org>, "Poimboe, Josh" <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, April 16, 2022 5:00 AM
> 
> Hi zhangfei.gao@foxmail.com,
> 
> On Fri, 15 Apr 2022 19:52:03 +0800, "zhangfei.gao@foxmail.com"
> <zhangfei.gao@foxmail.com> wrote:
> 
> > >>> A PASID might be still used even though it is freed on mm exit.
> > >>>
> > >>> process A:
> > >>> 	sva_bind();
> > >>> 	ioasid_alloc() = N; // Get PASID N for the mm
> > >>> 	fork(): // spawn process B
> > >>> 	exit();
> > >>> 	ioasid_free(N);
> > >>>
> > >>> process B:
> > >>> 	device uses PASID N -> failure
> > >>> 	sva_unbind();
> > >>>
> > >>> Dave Hansen suggests to take a refcount on the mm whenever binding
> the
> > >>> PASID to a device and drop the refcount on unbinding. The mm won't
> be
> > >>> dropped if the PASID is still bound to it.
> > >>>
> > >>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
> > >>> allocation and free it on mm exit")
> > >>>
> Is process A's mm intended to be used by process B? Or you really should
> use PASID N on process B's mm? If the latter, it may work for a while until
> B changes mapping.
> 
> It seems you are just extending the life of a defunct mm?
> 

IMHO the intention is not to allow B to access A's mm.

The problem is that PASID N is released on exit() of A and then
reallocated to B before iommu driver gets the chance to quiesce
the device and clear the PASID entry. According to the discussion
the quiesce operation must be done when driver calls unbind()
instead of in mm exit. In this case a failure is reported when
B tries to call bind() on PASID N due to an already-present entry.

Dave's patch extending the life of A's mm until unbind() is called.
With it B either gets a different PASID before A's unbind() is 
completed or same PASID N pointing to B's mm after A's unbind().

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
