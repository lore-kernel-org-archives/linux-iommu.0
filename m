Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B990638C
	for <iommu@lists.linux.dev>; Mon, 27 May 2024 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716772880; cv=fail; b=XaAIB4ToZzX41wEW5n9Cm7SLFfPtrfqELZL5Vo3FZ2N7GL86ThGvlnwZFZFLFTsiYmksyrDbbJgWg+ztVZd4+uvDybPyPC3IKgPSde8UQYevOYlKU1/z9ccrhTaCEzAA6nAeS5oqjUt9LaDjDl/J7AaUiTiCswxioqqxXDPDkxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716772880; c=relaxed/simple;
	bh=DkYXRK/EvY4Z+MPNrRwKLKjxRbR1PDRqHMYyB11ygvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nqce3i7UQL2MbUgzrIxbKgsMfq796YL2zeFbySvql7pBEP4DCrIRckOD5Vygp3NkwBKg9pnnNnTJFQ8zXxdMaVJVs+/iz+qDgG7ehlLWkbUUxoPyqRy7idrTBlywSTclOYCtuml62Cr7a6A4QLYmp9eU48mj6vyB57s9bmXkya4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiHyVsPA; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiHyVsPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716772879; x=1748308879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DkYXRK/EvY4Z+MPNrRwKLKjxRbR1PDRqHMYyB11ygvM=;
  b=fiHyVsPAqgWVm3jw7xoZznDvy5BbyPhtBTDbPHAxpvhW3c+EdJC3TbAF
   vkvEnn/mi2NMuqzmGYaxpwkdPFVfqn5ykpK5H0XpSYGbrPbSNVFTKNK4O
   Ivg4wGDke5nlqdynXQrlw0IpqCDHzHfUg1IH8M0L6H63Mu9wn4E8szWHk
   Ad1addA8IiH4J4Zlw/ANd4sklTwVkeTchyJtF0M8MIqQI10hmWapHTQ1x
   2TxA8wKbhxhSlZotCGo/i29BAgPm1bk/+ZSqD4KH74pPaie7t8BCjeNAQ
   fQPsyMHOv3L/X2Qt7EgHyvKFdr70cpCLmBV8wKIr0GIn9veyAKZIOSPVA
   A==;
X-CSE-ConnectionGUID: O8VcaPbDSFm5Ri6w/opQAA==
X-CSE-MsgGUID: YGf5V8KkRaqPB18r1onGUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="24483831"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="24483831"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 18:21:18 -0700
X-CSE-ConnectionGUID: WDqCUEsoQOyouZ60m6Oqrg==
X-CSE-MsgGUID: P14uBdCvRo6gxHXIsEwDTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39026249"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 May 2024 18:21:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 18:21:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 18:21:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 18:21:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 18:21:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKqTNtmLa84JzkjUm8z1wkU3Irn9OV4esXotd7sMOSIqgXgaSqEr9tOAnHXxa1b1BGXgd4zBeUn0NKPXwzrH4mhud6qpg+2mJ1W+9iYPdTxORNCHZU7QeFFCBJzap72hW6GVq3TguQOwY6tkDBmpCG3QiSidU86tZCeodjliP+uZyiu8fV+A8g1JUGsM6uX/oMWEaVzrm30G/f7ADFbWjbwL5aCv6Dw0DPOM55f4b+R/0dCHoM/SrkdlEYKeXgHXoKsLVJq3DQE6RTe9DsjlFlK6nUG5hhQcyYT4EJa67N7lLAI1Ih2og4TBIViNCx/lSMaW3qkjSQhlAyGQQFjIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tMoLRfuGXiuIN5OOIucfPOmEmzRXpWpwNGMCbFPbnw=;
 b=AtvV/S+gan3L3o7PzDcf8poGuHVFDdGxgL5OXPfFuYaVY3MqTYoYGKJ448jk/5v47MnURc0MFuGk48TCxN6Ufcu5CRTSDbz8mUgb3AC4Tey3V2spakyu0bc7eghMWkHfC/MvN2KcOexHmq/hDXvzQOejS6EAVZWMEHE/CJLe/KzdR74OoySsNtSg5ff4qJ8dNrcgVd9eRBsT7ZlYn75Sh3UTKSFr8AB2vD7/Le+btJZFYaSVaE/AJZ5eI4mvlMoEtqJiqynT5ISJR1QousJSO5ciiko7MTlCglPfRzGbNwhsPnk4uT6uhLc++7PPZ3dpEUvwbS2yKiSPt4P7tx8ZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8346.namprd11.prod.outlook.com (2603:10b6:a03:536::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Mon, 27 May
 2024 01:21:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 01:21:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "will@kernel.org"
	<will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, jiangkunkun
	<jiangkunkun@huawei.com>, zhukeqian <zhukeqian1@huawei.com>, Linuxarm
	<linuxarm@huawei.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Thread-Topic: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Thread-Index: AQHamwS0g/Jv+pTXu0CIWVzE2nXv87Gi9y5wgAB0YgCAAAmsgIAAJsIAgAAEAICAAAsmgIAAoXEAgAIY6ACAACwEAIAD31aA
Date: Mon, 27 May 2024 01:21:14 +0000
Message-ID: <BN9PR11MB52761D4122B818A05B508BB28CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <13e93238f21b42539097d7e347be684e@huawei.com>
 <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
 <20240522165640.GD20229@nvidia.com>
 <cb2ab7ee-9e31-468d-85cb-71e70d7a7e0e@oracle.com>
 <20240522175053.GF20229@nvidia.com>
 <BN9PR11MB527660CCD250C176DF86F9EB8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2d949dfb-ea40-418b-81f2-f2711b796d4a@oracle.com>
 <20240524140754.GZ20229@nvidia.com>
In-Reply-To: <20240524140754.GZ20229@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8346:EE_
x-ms-office365-filtering-correlation-id: 2d294fd2-b603-4b21-3cf6-08dc7deb4cf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?t3WVBc91ja3ci8ltMhUhtsUIlHQqWZfSVghgDKtZgWpI2nFU7/OTzikNoUJi?=
 =?us-ascii?Q?taOlNWt6GLFgrRdGRQFj4CPj/NgX9DR/soIyynl8MR8IjVY01JsVLenzdGjQ?=
 =?us-ascii?Q?zXknVtCI/yyhMnw3WchHkHh5OT36x1pFuh3K9mRPK/2eESdIourMUT8dATw/?=
 =?us-ascii?Q?TyaXnXIjYRLvAa503QcNLMb+9ry2Zpo1p/9T5j0aAu8+9twdO+MszGo6uW1L?=
 =?us-ascii?Q?zNW1iE7ibb/OpuT+aU7nTwoPdalrCo+pO5zqGo3ei3qgzHvhymo934td498p?=
 =?us-ascii?Q?0wU9cq67pu2zHrI3YQIgc9tMB8Rc2hau9KaAEdJS2Gb1073geFFKZlxZ+4TG?=
 =?us-ascii?Q?AhMFCzqJ3olD0o/yt9wHBXJEWfWCEyImVolThw8yqF9EHgJFrmk66hqFkYt7?=
 =?us-ascii?Q?5EyLAXtJEY2ZC+GCzqxZGccjWXpqiiRdXFz04eSjvWsbXMcEVZUFTibm54rO?=
 =?us-ascii?Q?QImCIcp3GG0kwJb/g9yix6vkQpP66BQobdnXfb1jGYEnDAmtPO7TEwA2FnoD?=
 =?us-ascii?Q?sJbAjetalw/3Gixf3zJJZCxH+YbTV6s9U7YIwXvx4iwjhT7VFzjaYZZNcc9C?=
 =?us-ascii?Q?c4Kc00m/7a99fA1QKOAcwxLgqfgLNUJryTNRTHzfNTw6Q/Az+VKLOZ2n5Uq8?=
 =?us-ascii?Q?5lN9xjQ+QQQLs50QnfcVKVkKSiTp3HSL9Gcw/iKiQRuVP/1U07Rd4WMCfdW/?=
 =?us-ascii?Q?mLs0nddtioNSPXIUVNUSb4j4KwAgbE6JxIHmJDJbspwvTAaiwJ8k2xIyvCxN?=
 =?us-ascii?Q?QHe81WaYPKrb/ufGlc/ax4v1HtQ7pxQVWqo2HTtRtdsG3XefvTyZqxLs4IYD?=
 =?us-ascii?Q?GgTmlrkLVL66MkwDsySrIvfYSyOTUuikZSSo7s3J7Kzh4VgQVsQwXex1j2w4?=
 =?us-ascii?Q?k28KWCVB5dvi1dwgGUMPG1rVoZwCJR7rkT6BUOUrJsP9FDIqOsgKLnCuY4bg?=
 =?us-ascii?Q?SbfYuzzUJWESIt1k2qUNXb5AHVg0ORqBbRl87EH3MS6Pn9rpEpdRkgUbDybc?=
 =?us-ascii?Q?8KxPbQcphMycuW5yjdEhiN3G2y6HSO+5MQxGQ4ebn/fHPxb/UeU3u2QPmKHh?=
 =?us-ascii?Q?lACcgF3cynANC56oo9iwpb3ZJcNHpuCYgRfwBVObBYjm8qaUp9XYUebsu2Y5?=
 =?us-ascii?Q?N/D1+XtOSScc8LSzaAwJYBQMYeOeJ7j+GlJXb+5+tj1f39y/ZKNyIdpa8iSP?=
 =?us-ascii?Q?jiYvyrdzeBb/MetzU3JaYIHVpp6X1qRKki47dmEg8XpGAd+iyTI4NADTzaFX?=
 =?us-ascii?Q?AyT8/V3NlMVv7nB2ZkJqptmZvv6NRLszJkfDtY1W/W0AvkmvwltOrfCVEr0T?=
 =?us-ascii?Q?hejg6AKesshwuSn+alZANY3LN8BPjsOG/KhxYJbyzcEBqQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wkoxqR5IW4yUQP+bzUSqJSi0sKL+ES7Re4/AjBRcMyPes4GbRwxaU9TrQC/U?=
 =?us-ascii?Q?7/ofnJqusrng6mJ3XSWr4tQeYkyDD/shgYB1H4imHLOqgdMqPzR25xARQ5i7?=
 =?us-ascii?Q?j7vxKaNk9lx6kQx4CGlSrunQZY81qpaACVTevqrOZZZ5bsyQyKWyADaQtd6o?=
 =?us-ascii?Q?L+yY62uDb40DZWvXD+VkbHzFTussaeCnIxELwu2nA6IsGwyw6sll98Q84uF3?=
 =?us-ascii?Q?i9pnm3ElvdkHr7o6yEmLxMTlgMORlD/sEqASKobLHIASeFfro7geTH62Nlht?=
 =?us-ascii?Q?9cor15++MwTZuHUpO8ys8NrVqJJwKlKKzUAyW8JhqV6DGi003iAIIrbhEtwf?=
 =?us-ascii?Q?uk0xOMMKBvI2KmK75c0mmw7TQJkkYifpiJbpv/XHTs+nfO2JTnCtOI3lDpl3?=
 =?us-ascii?Q?FL8jpJrludBeKn+8z6E9MAcpz383FDp7J0IRrBZlI94HMoZ/qfGMrL7dHOus?=
 =?us-ascii?Q?kfnIHaPC1GtRLDUDiWf6CbXDQ9IGjeAnC4XK7ZEP8+v4YQzxgb474crWcUf4?=
 =?us-ascii?Q?v8+LtgrSGfdfWxFKdHf5VxNjdAV4bmY/AxGmjg1B5F1vNAhoj6gFbq1lq3M+?=
 =?us-ascii?Q?zUZOyaBt+WP018Q33B93TEBL32D+so0YaooxLOpdtbwfd/5DF4ulj5udv/Bk?=
 =?us-ascii?Q?OlglrUnHJRCR8/+Gfq3dYdFvyxtp/MylOEXygxuBQwX1LWYWjmH/Jrij9CoK?=
 =?us-ascii?Q?S2x9XvQdCxhm7sG5na1mLJtrwTyJ2sKNCogi9Pau/iFRSA9Pviu9M4I0oOrk?=
 =?us-ascii?Q?VUjQztBBCrKCDyWnwGSD6YFiZ5VsLMv2tjX2mTv2/pMRh0aJV17g6lZ7zhQv?=
 =?us-ascii?Q?HmZOTkJuqCk1IxaaSDTPYbAnpa7hBlaYPrwdRKEj54n8NGAgVWmTVYikGLGT?=
 =?us-ascii?Q?q974KdJK3hHbn/NtWnSkXY8JupIGcn2qnuqGkiQG4YmviwQssF5lSZh0xUyi?=
 =?us-ascii?Q?vyYu++4qcU7eESLWutzoVibw+gLE7fyxuATqR1NZLnUsZFlrW2kB/2+J3bt4?=
 =?us-ascii?Q?v8BSLVVEShZ33oOUNqyvdz04T8uXVsoWpPcIlVthgAwCh+YHf48lktZdWnFw?=
 =?us-ascii?Q?bKb/Ez93B6P0vD/SvypI3DaVGuzpI5CfWg/g/gnNYufHIuMhZuj5TXD9PmE+?=
 =?us-ascii?Q?BkgO0xgl4rrwiz9Hd+LLpUyx5f0ezB4icPfP8OF0AuLvTyyLurQIbhfigVX4?=
 =?us-ascii?Q?Oy8OsyBqA+pauuJwqoDa+HlNsQ+xasMUrxuCzfHrhyaUnR5MmqOgL1Ue7T47?=
 =?us-ascii?Q?6k/PYvQVnMK10VKWPw6/EChZRXEzNfUDE9wDKObaZFpwhdlNz6jKENDKKM1W?=
 =?us-ascii?Q?/a9Nm01cLSd5SEHkX+gkfm5M2UECI0qS54GCFGFRK8c9xVBZUebqkbyUqGSg?=
 =?us-ascii?Q?k/FIaqzEfO8xS7x9+gOGKTe0Vg6VJgHNL8IGZH+XfV/qWjf8FoF2T+6KF1w2?=
 =?us-ascii?Q?A8qFNeigeynUVpvubEBCmM3V1Jj+vbydD4jYWGELM5xiRLQa4AiwFofJpsRQ?=
 =?us-ascii?Q?lF/o7CP49+3gI5nRRJGmrQD5JVyYuH8Ckb0xXTXPUiBBZW1bcIgVxym6pSS9?=
 =?us-ascii?Q?byKk00P1fB05YE4nhD3HqxipAIxwl+nmXXtA+uud?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d294fd2-b603-4b21-3cf6-08dc7deb4cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 01:21:14.1380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6GO4wAgAJuueEmef9PqweuT+gZBaIGlQLIK8ZtiBx54LkOAhgjhf9W9ifgMzKUq59wLl52DzNsdyRMiqnEJqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8346
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, May 24, 2024 10:08 PM
>=20
> On Fri, May 24, 2024 at 12:30:22PM +0100, Joao Martins wrote:
> > On 23/05/2024 04:30, Tian, Kevin wrote:
> > >> From: Jason Gunthorpe <jgg@nvidia.com>
> > >> Sent: Thursday, May 23, 2024 1:51 AM
> > >>
> > >> diff --git a/drivers/iommu/iommufd/iommufd_private.h
> > >> b/drivers/iommu/iommufd/iommufd_private.h
> > >> index 991f864d1f9bc1..de3761e15cab54 100644
> > >> --- a/drivers/iommu/iommufd/iommufd_private.h
> > >> +++ b/drivers/iommu/iommufd/iommufd_private.h
> > >> @@ -52,6 +52,7 @@ struct io_pagetable {
> > >>  	/* IOVA that cannot be allocated, struct iopt_reserved */
> > >>  	struct rb_root_cached reserved_itree;
> > >>  	u8 disable_large_pages;
> > >> +	u8 dirty_tracking_enabled;
> > >>  	unsigned long iova_alignment;
> > >>  };
> > >>
> > >
> > > should it be a hwpt flag instead?
> > >
> >
> > Most of this deals with iopt locks and walking iopt areas to clear dirt=
y. So
> > this being a iopt attribute looks cleaner in implementation. But I thin=
k I see
> > your point suggestion considering it represents a iommu domain property=
.
>=20
> Yeah, the original idea of the hwpt/iopt split was to keep code that
> was principly iommu_domain related away from the code which was
> principally attachment and lifetime related. Since this value is
> covered by iopt locks it makes sense in this struct.
>=20
> Not sure the split will stand the test of time as we keep finding
> reasons to muddle the boundary :\
>=20

emmm there could be multiple domains under a iopt while the dirty
tracking toggling must be done per domain.

with a iopt flag like this only the 1st domain under the iopt will be
properly configured?
