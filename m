Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA09C433EF
	for <iommu@archiver.kernel.org>; Wed,  2 Mar 2022 04:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 601F5827D2;
	Wed,  2 Mar 2022 04:47:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wydT4DxechWR; Wed,  2 Mar 2022 04:47:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2D5D3827C6;
	Wed,  2 Mar 2022 04:47:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06686C0082;
	Wed,  2 Mar 2022 04:47:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A2B8C000B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 04:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A72960AEC
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 04:47:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mkURo-AO99Nc for <iommu@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 04:47:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2714260AC0
 for <iommu@lists.linux-foundation.org>; Wed,  2 Mar 2022 04:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646196451; x=1677732451;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Kk914rtFsib2tFU9ZKAOw4MrADzl7xYgLmSbRYdDp50=;
 b=DOqa676Mqv2Jl2qW+i2LPv+2PrWm41SZpc8CGKubcYPX7lSMYcLWloc3
 fFq1OFyJ2Jj8UQS11WCnusASmZBjQFdwsHDiSsmMuMRkPwtEj0Se8ppZr
 Dt2+BFNneZerEdT6L13RDXIXTmR/B4vBAM/qNKum30rGmiVhuRJAdYurx
 1AM6NUr/obAiLa7mR98DNAzxxlAwcKuW4HwKQwtqTEkWlJRPvM54NZsC5
 0sFbE3GoP+0g190tljVWUhiVFxkG1jFL5anOIuWKNaoZpqQPfZyFRvLhJ
 aG70MsgBnCS1p0fmmpcnKkIL0FSKf+yQCh/D+6aG3f/x/wFGX487YxmYi w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253042809"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; d="scan'208";a="253042809"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2022 20:47:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; d="scan'208";a="545377171"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga007.fm.intel.com with ESMTP; 01 Mar 2022 20:47:29 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 20:47:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 1 Mar 2022 20:47:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Mar 2022 20:47:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpEM5pr7ipLhujqnyyCN3OBV84wG5YlYxaFCMJPTrHezhO1bmTjsO2SidPctsFuyeySBegzlQ8KtlAYc5QOIWQxmZCF4jH7RoAvgbfNoLkPFuil+mR2A70bj18alc7MVxUuxWfqbcUau/J+HoEuZ5oqRwwodo+Y/eZ1GJkJITPtZQXB+zoSxXKVvrqB6wbsCRzaHEBAQHfbDAVqBWp/s1crkMMHfodeN/sZnmATdL54JKTOkOYWD3JPsN2FAr8vO9reeEFpr5o5Cu1PspBmXH2xRXQ0LRrk2ecuMJCsgOHtaQFOqIISS1ArDOXLYvYcgMqB8/eHHFuG1Pysv7s7eNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V58acWBGNlJFz8A4iuqjiWPzfJkpHAVceUnasYDdY88=;
 b=n63bTZ4OhYJVQQYmx3D0Mp49XQ7kNlFiWv/sxW2hU5BiBHgEIsKi1j3gcAqPl4dacsshTTNl379FnNLfttEv60w/cgP1ou+2hqgQcNMnyA6bA9EJwLca37fGbKTGQVPTEyuBKU8Y3z1BsLVnXeMagqriPP4koYjuLk//louo+yFmschoHQiIb97XolOrXfC4iE/TNLowQHASe43mmQ1TP4SQiv8bxtFGMxn0Zkl4B70ru3eaig2m0wh8HFYb5RBpR55tI9s92d4wEm3EyhcIiqQhhRCOWR/6a/K1JIx3C9cpANH+qSxe6FuBjCqaq0t3zmkb6HayZFPOdqc6bUjSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9)
 by CY4PR11MB1894.namprd11.prod.outlook.com (2603:10b6:903:11e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 04:47:25 +0000
Received: from PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::e435:95a9:4a0a:8e67]) by PH7PR11MB5819.namprd11.prod.outlook.com
 ([fe80::e435:95a9:4a0a:8e67%7]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 04:47:25 +0000
From: "Surendrakumar Upadhyay, TejaskumarX"
 <tejaskumarx.surendrakumar.upadhyay@intel.com>
To: "gfx-internal-devel@eclists.intel.com"
 <gfx-internal-devel@eclists.intel.com>
Subject: RE: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Thread-Topic: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Thread-Index: AQHYLfAIWxICH2E4xk6OOIR3tjPCg6yrhTag
Date: Wed, 2 Mar 2022 04:47:25 +0000
Message-ID: <PH7PR11MB58195E4BAEF76D12C592F290DF039@PH7PR11MB5819.namprd11.prod.outlook.com>
References: <20220302042941.191516-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
In-Reply-To: <20220302042941.191516-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
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
x-ms-office365-filtering-correlation-id: 7322073c-4811-465a-7ac7-08d9fc07bf5d
x-ms-traffictypediagnostic: CY4PR11MB1894:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1894909C9A00CAA629764793DF039@CY4PR11MB1894.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FMBCE8fpFiB2OcZ7aRoIBy0twYEqGPFtsSJx6UN3Z3EZAwWIK1JFGCqxQgLvdewhaUbkxqeAMTGD3Nix3D6kAjBKZ/vymn1pEa3VMfYjJ8+469QS2Yx2ymXLQ5b2NERw3pO7PoOso52fkZOdZ8Rd8bQl1DXCNOFjAYM7pvLyu8PQQ5hQa9pDfQVuCbQzRVvF+mazagYje803hZHEW3ttQg+/whr1TZaHePP+b6nQcoLSLbyxq9KrvmVr6EJBi14qJnN09vXyN+6s7+5g+Wi3lNiylIyJzVd/HyhqEPuOY1dT7dn8gLsCXNgTAld/CYsS8vMLOh+gocjSlvTknD/GH9dJs3MTnchiJql2+umDOAun+x3uK7y6qJBjy3npHmQndcDUuuO2IMV8nUB+74n6MLHv0knRQhR099SzeRtiRETq28bSPgkGztk9D1i3jNM8nuIO1Rtqx7ynH/lEqOJ5K48xZ0m2ZW8GXs3AM7vYgxykmxUIA2LpU1l5B+sG/8x/lO6+LvqJMVcj6PhYIrgglzBTJOvTV9yOd3svgPw/m1c0VXFuP3IsSCf2P4kG9JJanC5G5Ze7o8TzBzoIdNv+9xrcCV/YjqE2QlO9HoCpsbbPx/3lxEeCb8+Lwr/B5aoNlvy/zG/C7tAt1/WorJGswTnnjSj0SoQVGvVj1uwvL4A7ApmRFY/YdF4RLV9Qfcpub2aQtrcYG9iS7Dopu1EGXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5819.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(53546011)(186003)(52536014)(38070700005)(966005)(83380400001)(71200400001)(6506007)(26005)(33656002)(7696005)(9686003)(2906002)(316002)(82960400001)(86362001)(508600001)(122000001)(64756008)(8936002)(76116006)(66946007)(66556008)(66476007)(5660300002)(38100700002)(66446008)(8676002)(4326008)(54906003)(55016003)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6H2Qwv0s8OJDyyJUwCdkqtoDhHMsMBMtINWDVR///OVhmuiyqAr9jVgXJ8GX?=
 =?us-ascii?Q?7xmcilM2f6N5PgdmokuVOLTLCZt/wbdr2qtd4y4EFGP/ez11d0V95Qp6GuQ1?=
 =?us-ascii?Q?RCNAKJc4+mHGftLFBQ+xXEvUAqVcmpoti85O3oHxag4c8aWZZy6Zf34wETy5?=
 =?us-ascii?Q?eY1Zi3oj6cDUk0id0TzORds6IjDhSt5C+ROtLnEXsVmqRcDDmdWFE2hSIi0O?=
 =?us-ascii?Q?7+rqop8viUds6Awdw4UoNc8AlrzkUARNgSM++QCYUIWe0/scIPg19BzWxZAX?=
 =?us-ascii?Q?9m4l9PyIeEwyUoKbSmSxf6lIm8wLmkwnPXxIym2qeS2kG+J8XHBAXCTtzUiR?=
 =?us-ascii?Q?B7k8R+K92Yc2AswtRwZGwzBi5AMkBJsgAyDGpzI8hIJ2dP9bLN3is2QVGAiE?=
 =?us-ascii?Q?/PiE16xxxmF4cKDR2pV/m4ei61/4mgiNw5OPI1H/GbQqsa/25ytYNfQysqTB?=
 =?us-ascii?Q?uPzfa7RLrB6T5j5BqyADctbTlDphNJq9RqsigXriQ7YAHVhQTck7TWOjFZiO?=
 =?us-ascii?Q?1nGJcbM51ttPQB2NcJR0NyJQ69P6Cg7KgCwA95jPoiDpDgRY9dfUJEPEGc5R?=
 =?us-ascii?Q?X9Os3QVB/eQNhgH6o/tdawgK9osoFF5xmwflMRSC3u0j+jjoGUnVVLOMWHKq?=
 =?us-ascii?Q?PROBDuL2coSxxPtzRF4f/6mpceKmJcqtYLE4F6xjLSbGwQIfuaKVSIhPPQDW?=
 =?us-ascii?Q?9I2yRCXRJu2KNQqFnEr/SOI/YOgun43nEIbGKXYvKUnUI+tKVRTy7FEL9YKw?=
 =?us-ascii?Q?66L9I/yYfq/AWVu1pN8r+Yg+onoUK6+qTQsHeOKH7h/Wf1qlYh7VAS0HMvAj?=
 =?us-ascii?Q?4AxfB3GCBJnDvKDcxaPArDu9IfE9fQBO61jmfDlYW4ZWPUtJbI18CbWSZcFG?=
 =?us-ascii?Q?Zo4wG+5o5pmJxnGZohPp7MCOwZLlIYXf1YdGdennwPqaVSv/LmwjKrXzL17f?=
 =?us-ascii?Q?CiYpoqcajSCDYll03FxOZS+W2DCrpC+4m6Wytad0PYTm6bLx76lxhV0AAw32?=
 =?us-ascii?Q?6f0rL0M1piLeNPpzc0vzVZUDejw6y+no8WKfqrcK9SgTRfUtwnls/TR3FqYC?=
 =?us-ascii?Q?z+xwzoNbx+LWJ6a4tVYD+VhDaoG9lfv1LbJbe5uDOrrMujPIaMSRdlLf9P4a?=
 =?us-ascii?Q?7YTBT1Wx4moFj8DrEQe/8N+oKMm4ISdRH9L1CFh8LK/31Gg9mhVUYjBw2yYf?=
 =?us-ascii?Q?9vu50gFroWN9KFNMwmzCrDhSHx7Z/+8HmSCVWBahOyc5jvfAhRDCVJwK/4YH?=
 =?us-ascii?Q?s35fEneQw6Lf938cG3q3+wJnmElxrMxFPeRcXaWGDGV9ai8r+HJ7LySHPFfP?=
 =?us-ascii?Q?U27DzdHxUAVR1Nq/JEykJSJ77krUjEiEgKDawuvb544xa38tVlthE2AXTiUG?=
 =?us-ascii?Q?zgVEvnuDNaKFA2vF+yboiFFYkU1/tE5KH5uin8bzW+K9vZR0itaC//+s4PIC?=
 =?us-ascii?Q?vbo4FEAVSNR+9N7C0EU5S4lv7aoG4xQANA5GVKHi8ABLOlG8rFbAgVA8H06F?=
 =?us-ascii?Q?DXZISirwGwkOlCWacq15QaWZqdn5f9olfv1L2mC1nNW/haejSLLfaXo/tYcE?=
 =?us-ascii?Q?TYQZjeGDDWD7QrMHScLKNaZNyHBf65DZKyf7lMlOI6ifMKoYCNXDeMnXfi3h?=
 =?us-ascii?Q?lY8gnpXscy89dBvRIZ5PKMf7wSbaqyCPUAz3f1hdPRgzRKeCN/9JI2irV26W?=
 =?us-ascii?Q?ibfXoqwWjEKIYr1Y994yLTVG6VBZki24ZjHefM6mHmnAaifaSER4hjPniaBm?=
 =?us-ascii?Q?GFY+BH37feuAajOUxzDjV9nXE+/YNbzKDUFMWKR6sUvCUaZjNCZnn9ky0PhK?=
x-ms-exchange-antispam-messagedata-1: j/kbzKOmu/JYxw==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7322073c-4811-465a-7ac7-08d9fc07bf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 04:47:25.4243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6Z5W2c68nAcpMXRWzVFy/KkROQTnbjhiXN0NDlw22UVTY0arMXbBv+g7PcvSbcb0KbCs3QPGqTdyCz56ZuYEbjDWkoNilcXBTKec2UyX2cWcMrqsSg2JZ9Ey7k2X+IV7BkqR9sBcTMtcjWhWTp6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1894
X-OriginatorOrg: intel.com
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Talla, RavitejaX Goud" <ravitejax.goud.talla@intel.com>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>
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

Please ignore this patch, its sent by mistake to wrong mailing list.

Thanks,
Tejas

> -----Original Message-----
> From: Surendrakumar Upadhyay, TejaskumarX
> <tejaskumarx.surendrakumar.upadhyay@intel.com>
> Sent: 02 March 2022 10:00
> To: gfx-internal-devel@eclists.intel.com
> Cc: iommu@lists.linux-foundation.org; Surendrakumar Upadhyay,
> TejaskumarX <tejaskumarx.surendrakumar.upadhyay@intel.com>; Talla,
> RavitejaX Goud <ravitejax.goud.talla@intel.com>; Vivi, Rodrigo
> <rodrigo.vivi@intel.com>; Lu Baolu <baolu.lu@linux.intel.com>
> Subject: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
> 
> The VT-d spec requires (10.4.4 Global Command Register, TE
> field) that:
> 
> Hardware implementations supporting DMA draining must drain any in-flight
> DMA read/write requests queued within the Root-Complex before
> completing the translation enable command and reflecting the status of the
> command through the TES field in the Global Status register.
> 
> Unfortunately, some integrated graphic devices fail to do so after some kind
> of power state transition. As the result, the system might stuck in
> iommu_disable_translati on(), waiting for the completion of TE transition.
> 
> This adds RPLS to a quirk list for those devices and skips TE disabling if the
> qurik hits.
> 
> Link: https://gitlab.freedesktop.org/drm/intel/-/issues/4898
> Tested-by: Raviteja Goud Talla <ravitejax.goud.talla@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tejas Upadhyay
> <tejaskumarx.surendrakumar.upadhyay@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 639e4438827e..bd6dac90a948 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5741,7 +5741,7 @@ static void quirk_igfx_skip_te_disable(struct
> pci_dev *dev)
>  	ver = (dev->device >> 8) & 0xff;
>  	if (ver != 0x45 && ver != 0x46 && ver != 0x4c &&
>  	    ver != 0x4e && ver != 0x8a && ver != 0x98 &&
> -	    ver != 0x9a)
> +	    ver != 0x9a && ver != 0xa7)
>  		return;
> 
>  	if (risky_device(dev))
> --
> 2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
