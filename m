Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4119BA41
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194606; cv=fail; b=ao930TJ585kHuzuGn8Hsz+CODYSg18UHDVlxFSYqcSRcBuGkUEYevA/Aaqx4WahxJprPoQ6bDOcTWpFDV9r/a0VWQqpvgB12RQuk9R6uexkkVKrv8zz2waXasFs+XV5Tg5T+wzPx3PEX4d/j6K0YubQV8a8/lHyNaWi4IYzo/DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194606; c=relaxed/simple;
	bh=SP7OOtkOpkxd6Zi3bBzlBHx/n5qYc64FMR9nT0eNzMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VOksmXv9ZpcUTKyQoHU4VwEbmQ+uqtDjUEbFLF0399TGp/EhFN8ye9R/7HVJhhuAXOaAUY0XFrNMridTCwzbmW5hEDA7mpScYe1KOWquXoADJNwm+MgHlvHFLxAisiqvTNjviubqt/037hf8Y2oWyDUUGa78UkAeBniLwk08DBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TD+8FVTO; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TD+8FVTO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723194605; x=1754730605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SP7OOtkOpkxd6Zi3bBzlBHx/n5qYc64FMR9nT0eNzMQ=;
  b=TD+8FVTO9cM27/349DzL8sT+BRGENNSQ57V7B3tq1YbuBPrUg8wJcHCL
   ips3d351gz8p4PWsqnZwuc9ZU4OIxJQBf/+6qEBC08yVThGVRXhEmHkFD
   p9SGz4jQNj76CrfO7Le28HSnMd5N176p1thgqBTN/yrA64rgOgtapNZwl
   tlylkazKwXyqLwhmULFXbJYOxkvpnMlmVTWV2Tgv6LCkdjtFC761jug7N
   QcM7dr2laTJVgANORWTA+FkWkEk4irMHLxLUMSAMThWgMqOI4shJh+8Bs
   +I0qR/IkDWdj9LTq+Viw9B5v2CSooanFP7GyXtMza0Bxn5K7CYl71SVzh
   g==;
X-CSE-ConnectionGUID: K9hS3yvFSH6E7S0zHBK0YQ==
X-CSE-MsgGUID: MTb8eBM3SUW50janx4tSzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21333221"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21333221"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:10:05 -0700
X-CSE-ConnectionGUID: LZrDr1TMQlCK1r8lPW3igQ==
X-CSE-MsgGUID: H5gAbyz3QjuB/V0TmIcKrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="80749790"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 02:10:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 02:10:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 02:10:03 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 02:10:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeis/j8TsIoF7K06Yk909AIbL57b/bM6iTszQ/WZReuCDct99qX+mbW/y8uYgSNWAVRowWnRAlWEpLMbdhtRnF8BYikVmBhzQiSyfCsY1RHZeKl53C2M9z5LmkGWM5l6Lu8fcM20o6T4OnT9Aujldc6pNrDV83W8VNkkDYqe1/y30dj0DmpiwJCW0JuyusJaLqnq2ECxgWJQwocCairlYm/l1OomfPRPNIdncBR7I0HItVq3SeL8XpWWKMROltg/n+0y+sPlU9pQWekpGTz2A5Boi/MqY4lKpQxmTRofO3bD3Zc7shkSjINemPn96gyUgH5Dcciycq5InFkkpWvyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP7OOtkOpkxd6Zi3bBzlBHx/n5qYc64FMR9nT0eNzMQ=;
 b=Wwx23XKauGSzXMNvaeBuyGmkYjQGb4T1nR0/Q4KfRafLAL1z0Y+mZyCQmQl13xkx3rf+UzlDiGHwuCU2FMvcFVLrBeQQ8lt3fq5sdXE00XV1fvJpkOyJ9vpLjFoQ8XCgLWqqjyvzRHsxgSKh/10UWeFjI0HGnkLTRBntm8s5VO3N/UsXNzINcIKn1Rsei50Aj4lkyyv2FA0WlHUXONOYol4e1a9QOSjyzOhtNP5NV6f3wCYd5djYkT6hVGhqPJpRXt/ktOnxnjbTxv9q1eOHN5j//CV+uScfpLbepIFqConh1njpws9hF1zPkgyw4sL+h/p+iDypMhXp7HZgNRXkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SA1PR11MB8596.namprd11.prod.outlook.com (2603:10b6:806:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Fri, 9 Aug
 2024 09:10:01 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:10:01 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] vt-d/iommu: Refactor quirk_extra_dev_tlb_flush()
Thread-Topic: [PATCH v2 4/5] vt-d/iommu: Refactor quirk_extra_dev_tlb_flush()
Thread-Index: AQHa6gfK36QKuUmly0uKTC0aNAh5F7Iel1QAgAAJo+A=
Date: Fri, 9 Aug 2024 09:10:00 +0000
Message-ID: <MW5PR11MB588170EA147F7CEC6F94090189BA2@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240809025431.14605-1-tina.zhang@intel.com>
 <20240809025431.14605-5-tina.zhang@intel.com>
 <4d1f761b-993d-4c13-a296-111bc3b39141@linux.intel.com>
In-Reply-To: <4d1f761b-993d-4c13-a296-111bc3b39141@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SA1PR11MB8596:EE_
x-ms-office365-filtering-correlation-id: 23a7b176-94a6-4094-16ad-08dcb8530c69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y0RwYi9VbUxoMUdJUkFzQ3BGazJzVjFYN1pYNDVORTJ0a0hBTFNteldFT1lj?=
 =?utf-8?B?VE1ycU13Sk1aUTRYL24vdUZqRTh6NXZ4bWZRaGN5V2F1aUZmbmFrbksxYlY4?=
 =?utf-8?B?ZFBadE5jclBubTkyNExBR1NQVUhIanpCOVk5OUg0YmlyWm5tZ3FFeVFnQXFC?=
 =?utf-8?B?cWpvUDdpaWJ4U0t3VW45Wkc5UDBHUnRsUUlsenpXUzhVbmpWanZyUlNqK3Na?=
 =?utf-8?B?YXkwTnBtR20xbWhic1lLMXloSUxXUlJwUlYwbE5YaHpibWZxTnBuTGV4bjVT?=
 =?utf-8?B?d3FPK3ZlUXZCSy9zUkpxZ24yTnh1SUgrRFhaMzMzN0hqb3p5SXU5Wm5LZzNS?=
 =?utf-8?B?bjVZdTNDUFZJOXV1MUZ6L1JiYlZndUIwRDRaK0FSZUpUT2xibGJTUE5mOWdS?=
 =?utf-8?B?aC81L050ZUVDZkgzZFhBRlpqMkh0WDRYNnZsejU1eEU0V3hMV0F1ZkFHNXJ2?=
 =?utf-8?B?QUNlQ2xRbG9XZHozSWREcGdkbmNXRGlUeHQ1N3U0OUkycVZZdklGZ2JNOU9h?=
 =?utf-8?B?NEVMUmt5S1JvV3NtK01JTEgwV3lUYXJBb1FQa3E4MGRZaGwweU1LSVpKemR4?=
 =?utf-8?B?eGJRQ3pWWUNHQjhEL29MNXY1bkREdWRZcDFJZjhZQTdBZVd3amZwSDhTWjFB?=
 =?utf-8?B?VXFmUHpJS2FjWS9BMEM4MmRJZmNrUnNKVlJWbjZYSnp6b244a0o0SlppbC9W?=
 =?utf-8?B?V1ByK2RydnhQdm5KYmlQb1hObm1TOHEvQzJwZ1I4bXNnOERhT3NQR0hXOW9h?=
 =?utf-8?B?M3o2cFdENU9FYy9FbGRBaHZHMHUrSXhCQkxBaWUrclVBUHNoVlNwR21yVGg0?=
 =?utf-8?B?Zm1zRlJJL1liOVUybHovTkJhSlhjNW5Zbk9SWnZoVXJtY2xNbTU5SWxZWUwr?=
 =?utf-8?B?ZFB0UGcyTmZ3ZGNFcVpoRkFKTno2NzVCTEVzOTVYLzFxVFFHcUZCMm5VNTRY?=
 =?utf-8?B?dkk0MmxMc1ZKRk16RERzQjFIL0FpQXJTZS9iR2pXeGpMaTgyRlR4b2s1WnJG?=
 =?utf-8?B?WVNlaGp6YWhlNUh2KzYrNW1VM1diNjhSNDVaNDAxTE1DNStFbHh1aHZBQ2lE?=
 =?utf-8?B?VEVnaUNRU3QxR09ITnpXeXJOUTRKMms4YVN6cTBiT0d6L1g3RFprQWNoZWI2?=
 =?utf-8?B?aWpCZUdWeWJRV3lnS3JsbkwybmthdkFHYUZCeml1c0xOc09NcVZuYVN2V3Bq?=
 =?utf-8?B?QTV6aWoxa3gzcWt2MXU0d29NV1NGMm9QNUdIR0VUeS9GL2xlNm01YlV2TXhn?=
 =?utf-8?B?am1GN2hLNnloaHlZdURLRTZHZDRsbkRQR1lVZFQwc0MzS2VBOTdwMW5wR1hl?=
 =?utf-8?B?TXRyaUdadnRZTUw5K1U3RUNFOWlZSzNabXByaSsxenFuZ25qOGhHb0NEZzdU?=
 =?utf-8?B?OXJmUGk5cmpha0tHZTZlN1lXUlZXaUFHNlVCdE5hdEd6Y1BEcWRTNG1iNW51?=
 =?utf-8?B?eU5nYUlNMDRnbVdYbWhzNWlTR0tiaDhwNmp3YTlvOHdudFdrdUFzVkR1cGRw?=
 =?utf-8?B?VFNrRG9UUE5vL1Y2dG1hWjExL3RtMkpUQ1F0ckQrOU1WeFJaRzAxQnNMcyt3?=
 =?utf-8?B?dncrQ1I2YjBtc0VnMXJDemJWWjBNakFnbVpxSmRyVXZwSXVmKzA5aUoxMTRK?=
 =?utf-8?B?RkNPWTFYMFBvZkk4QVBLc3l5R1dGbGw3U3ZjaUMzendPSVdRNVJadXAxL0RZ?=
 =?utf-8?B?ZGQ2emx0ekdBQTArZjVzalFxOFU2V1gvei93b3FnQ0FOWHg2d0F1STVuVS9H?=
 =?utf-8?B?Yy9JRHZYanZ6czJybWRCVG5mMWEyZkhsSEMrMTRPYXZNa2k2VlJsNWc5WVdi?=
 =?utf-8?B?RHQwNjVFVEJLelYxNEFGbkRvdkFUUXh0SDJ5MitHWFhTNWZTWVZZR053RVVR?=
 =?utf-8?B?dkRKdnRTOVVuWERLYW81QVY0SVduLzRMUnN2eC93NUxKcmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWU0MExOeHVjYTdNMWlPcS9qNXRvQXBOL0pscHgveUFiRkJCRWYvbGJBSXp4?=
 =?utf-8?B?TW9RQUVHSi80cWdLOXNpSU5aN2VZSVdWU1gwZVhaUUYrd1JTQVdKNThZVUwz?=
 =?utf-8?B?TXZaS2t0VUI0RWhFUWU2bGJWbU1OcUlMVlNPWDl3blFXME5WWUJ3VnJ5RnRF?=
 =?utf-8?B?RmxuQUZGOW53Wml1eU12QXYrQVFaeDVBRDhxd0pZclFORURxMFljWjEvRE5D?=
 =?utf-8?B?N0ZwZWV6RVNLS2I1cTJOWUpXbmhUN04ySGM4Vzd1STBSdklZV2FaOHdScEFW?=
 =?utf-8?B?NURib0JuRi92Tjd1WXVaSDI5ZUFYUlBMT2lrOEhubHN4YmlXblVLVVIyZlY4?=
 =?utf-8?B?alhZZlc2VjRpa0RDc3dRd0Z3ajdXYWNzK0V4a2c0TlA5akQ1NnhzWXFKeGg2?=
 =?utf-8?B?VUlvcldQRVdGZ0JtUnd6Y2lHUEROczJ0YjF6Y3I3ajNmZysrc0UybVprVmMv?=
 =?utf-8?B?WVgxb0VGcG9uR1RmdjRabUxRWFNHNDZyVEw1M0dBS0JnVmxEWUJ2K0JEU3p5?=
 =?utf-8?B?N3BWenNVK0tUd1JmU3dsU3MvNzdCZmgxa3FxZFMyTHdvbnBDa2tyUDJidTA2?=
 =?utf-8?B?SHhSRmkxTEhFaDZEMHB3elgyM0cvbXlDdWdiQmdJYzdlNlNPR1ZBZzhvVDhX?=
 =?utf-8?B?VU1vM1hlbklmOUhnYnVHQWk3cUE5a1BsZUxKQ1ZDcjRNSkZkMkovd3cvNjBN?=
 =?utf-8?B?dGNTblZPem85VDRSSEt0RjlOVGxNUFpENm1pd0lEYVJ5amg4QkhkSGo2NWNq?=
 =?utf-8?B?T2ZyWmdibU1TZUtnazdJRktyOTF1UHlCNE96cVdHYUQ2OTR4dFQwRWVERG1P?=
 =?utf-8?B?clpjcmFzdk1TbmRCZVJKbmVxK1dpOEUreWh4M3lJT1U3WWlYSWFHNDU0MU16?=
 =?utf-8?B?UC9IVUZIV21uM1REejlhVUtmNmRUazdodEZzUGpiQWQrKzRGbzZINzhXVDBF?=
 =?utf-8?B?amg5U2xrclJMYnovQmhneEdTcWdHUkFsQW5CM0hFUGQrYWh2ZlhndkNncFlu?=
 =?utf-8?B?OHBKWmdXeVZpZUJQYlluZ0M1SHQ1RnJ4NFB0MldQNzZmbWkyVWlYcUJZSXRo?=
 =?utf-8?B?M2pKN1NaREVJcXdjVTJwOXJtbERZR3BULzBYRm56UUtOVW1VcFpqcWRFdFUr?=
 =?utf-8?B?RWFScHVWdHBadzVkMm1HMXdMZFl5dEdONm5tUk84Tjc1QVVxQkdhNUFEeUZY?=
 =?utf-8?B?ZFVreHlLMGpaTXpPSnlVS2lycGlMUVJvQUF2QnVJaHp1MGhlNWRVVW9YbW9l?=
 =?utf-8?B?ajVBYjZ1clYrWVhNS0lEbVNmZUI3aGVsUHdKOS84NHlFUDlMS2g3RVluanRH?=
 =?utf-8?B?V0pXclBwck5TTldPU0lLZWMzRUh4c3pwMU4wQ2hXL1JKZWJIYitVVGhRT2U0?=
 =?utf-8?B?V1Erd3V4c1U4eHJ0OHhxWGdrK1BEdEw4ZjRqdWxYR3RSTEVWbXpSNDBFNUJB?=
 =?utf-8?B?S3NRNVo4aTQrYU1OQkNGMFhhMEk3U1FLMmVMM09OYjljcHlFcm9odi9vbFQx?=
 =?utf-8?B?dTBmcWdteC9YWk9jdFRPUksvMU5wVkxaU092ek1sOG9kaXAzWTFHajRRUnB2?=
 =?utf-8?B?WC9BcHlEdGRHOXFSc0Z4Mm1YNDVJaFQ1eDkxZ2lwckhIbHY2U0lCQkl0OEZw?=
 =?utf-8?B?NkxPa2V3NHY0Z091NkVDdUdiM045VktQTzI1a00wYjlPa2xiWXNsdlBQdURP?=
 =?utf-8?B?b3grWXA3QXdRN2lCRERFM0JXYmgrMW0wM3FuQ252M1A3cXp6akdhQUgwL1ZR?=
 =?utf-8?B?WjlVUExrejlXMkh0cE8xSUVDZWJKaGF5SVRZaENHd2hqbE5JL1pOYjJUMXdl?=
 =?utf-8?B?SXNadnBOaXpaMUF4ZHdOZCtJVDF5Zm01VDluREpXazB3bHJMaDZDbkovd1Bm?=
 =?utf-8?B?UTg1YmdyenJmSU5Wa1haK2MyVThGTmdOSWNSNStBaTJBeHNwenQ0ZE52ZU51?=
 =?utf-8?B?ZG55NDhNbm9LbkxGenptWG4xWXBpekppV291bllocjJ5alJ3WlhtQTBJWith?=
 =?utf-8?B?OWllVHZwZmduL0hVWWhTNklVU1ZoM3hPZG1UN1BLMVRnYVozK1JFR29LZTZ0?=
 =?utf-8?B?bVdyNmtJMVJ6VTFsWmpySGJmRzRLZGRzTm5uM05Ud29GQ2hZakRjeDZzWmJD?=
 =?utf-8?Q?PZyTD1h6HO+Oo5VYM2VNzjH0E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a7b176-94a6-4094-16ad-08dcb8530c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 09:10:00.9681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ZwrAgbz5pw2L+ScRwjMcCPGCZ/Ji9Ucusa10QuA7enUv1YKcZS0z25vk6zn43ClqVTT8Z0RSu0DgPgOQzbZAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8596
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgOSwg
MjAyNCA0OjI2IFBNDQo+IFRvOiBaaGFuZywgVGluYSA8dGluYS56aGFuZ0BpbnRlbC5jb20+OyBU
aWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+IENjOiBiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb207IGlvbW11QGxpc3RzLmxpbnV4LmRldjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA0LzVdIHZ0LWQvaW9tbXU6IFJlZmFj
dG9yIHF1aXJrX2V4dHJhX2Rldl90bGJfZmx1c2goKQ0KPiANCj4gT24gMjAyNC84LzkgMTA6NTQs
IFRpbmEgWmhhbmcgd3JvdGU6DQo+ID4gRXh0cmFjdCB0aGUgY29yZSBsb2dpYyBmcm9tIHF1aXJr
X2V4dHJhX2Rldl90bGJfZmx1c2goKSBpbnRvIGEgbmV3DQo+ID4gaGVscGVyIF9fcXVpcmtfZXh0
cmFfZGV2X3RsYl9mbHVzaCgpLiBUaGlzIGhlbHBlciBpcyBmb3IgYWNjb21tb2RhdGluZw0KPiA+
IGZvciBib3RoIGluZGl2aWR1YWwgYW5kIGJhdGNoZWQgVExCIGludmFsaWRhdGlvbiBjb21tYW5k
cywgdGhlcmVieQ0KPiA+IHN0cmVhbWxpbmluZyB0aGUgcHJvY2VzcyBmb3IgaGFuZGxpbmcgZGV2
aWNlLXNwZWNpZmljIFRMQiBmbHVzaCBxdWlya3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBU
aW5hIFpoYW5nPHRpbmEuemhhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9p
b21tdS9pbnRlbC9pb21tdS5jIHwgNTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LQ0KPiAtLS0NCj4gPiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuaCB8ICA0ICsrKw0KPiA+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJz
L2lvbW11L2ludGVsL2lvbW11LmMNCj4gPiBpbmRleCA5ZmY4YjgzYzE5YTMuLjE2MGQ1NjkwMTVi
NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPiArKysg
Yi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPiBAQCAtNDg3NSw2ICs0ODc1LDQxIEBA
IHN0YXRpYyB2b2lkIF9faW5pdCBjaGVja190eWxlcnNidXJnX2lzb2NoKHZvaWQpDQo+ID4gICAJ
ICAgICAgIHZ0aXNvY2hjdHJsKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW5saW5lIHZv
aWQgX19xdWlya19leHRyYV9kZXZfdGxiX2ZsdXNoKHN0cnVjdCBkZXZpY2VfZG9tYWluX2luZm8N
Cj4gKmluZm8sDQo+ID4gKwkJCQkJICAgICAgIHVuc2lnbmVkIGxvbmcgYWRkcmVzcywgdW5zaWdu
ZWQNCj4gbG9uZyBtYXNrLA0KPiA+ICsJCQkJCSAgICAgICB1MzIgcGFzaWQsIHUxNiBxZGVwLA0K
PiA+ICsJCQkJCSAgICAgICBzdHJ1Y3QgcWlfYmF0Y2ggKmJhdGNoKQ0KPiA+ICt7DQo+ID4gKwl1
MTYgc2lkOw0KPiA+ICsNCj4gPiArCWlmIChsaWtlbHkoIWluZm8tPmR0bGJfZXh0cmFfaW52YWwp
KQ0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+ID4gKwlzaWQgPSBQQ0lfREVWSUQoaW5mby0+YnVz
LCBpbmZvLT5kZXZmbik7DQo+ID4gKwlpZiAoYmF0Y2ggPT0gTlVMTCkgew0KPiA+ICsJCWlmIChw
YXNpZCA9PSBJT01NVV9OT19QQVNJRCkNCj4gPiArCQkJcWlfZmx1c2hfZGV2X2lvdGxiKGluZm8t
PmlvbW11LCBzaWQsIGluZm8tPnBmc2lkLA0KPiA+ICsJCQkJCSAgIHFkZXAsIGFkZHJlc3MsIG1h
c2spOw0KPiA+ICsJCWVsc2UNCj4gPiArCQkJcWlfZmx1c2hfZGV2X2lvdGxiX3Bhc2lkKGluZm8t
PmlvbW11LCBzaWQsDQo+ID4gKwkJCQkJCSBpbmZvLT5wZnNpZCwgcGFzaWQsDQo+ID4gKwkJCQkJ
CSBxZGVwLCBhZGRyZXNzLCBtYXNrKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJaWYgKHBhc2lk
ID09IElPTU1VX05PX1BBU0lEKQ0KPiA+ICsJCQlxaV9iYXRjaF9hZGRfZGV2X2lvdGxiX2Rlc2Mo
aW5mby0+aW9tbXUsIHNpZCwNCj4gPiArCQkJCQkJICAgIGluZm8tPnBmc2lkLCBxZGVwLA0KPiA+
ICsJCQkJCQkgICAgYWRkcmVzcywgbWFzaywgYmF0Y2gpOw0KPiA+ICsJCWVsc2UNCj4gPiArCQkJ
cWlfYmF0Y2hfYWRkX2Rldl9pb3RsYl9wYXNpZF9kZXNjKGluZm8tPmlvbW11LA0KPiA+ICsJCQkJ
CQkJICBzaWQsDQo+ID4gKwkJCQkJCQkgIGluZm8tPnBmc2lkLA0KPiA+ICsJCQkJCQkJICBwYXNp
ZCwgcWRlcCwNCj4gPiArCQkJCQkJCSAgYWRkcmVzcywNCj4gPiArCQkJCQkJCSAgbWFzaywNCj4g
PiArCQkJCQkJCSAgYmF0Y2gpOw0KPiA+ICsJfQ0KPiA+ICt9DQo+IA0KPiBIb3cgYWJvdXQgbW92
aW5nIHRoaXMgaGVscGVyIGludG8gY2FjaGUuYz8gVGhhdCdzIGl0cyBvbmx5IG9yIG1ham9yIGNv
bnN1bWVyLA0KPiByaWdodD8NClRoZSBxdWlya19leHRyYV9kZXZfdGxiX2ZsdXNoKCkgY2FuIGFs
c28gZ2V0IGludm9rZWQgYnkgcGFzaWQuYw0KDQo+IA0KPiBCeSB0aGUgd2F5LCBpbiB3aGljaCBj
YXNlIGNvdWxkICdiYXRjaCcgYmUgYSBOVUxMPw0KSW4gdGhpcyBwYXRjaCwgSSBtb3ZlIHRoZSBj
b3JlIGxvZ2ljIGluIHF1aXJrX2V4dHJhX2Rldl90bGJfZmx1c2goKSBpbnRvIHRoaXMgbmV3IGZ1
bmN0aW9uIF9fcXVpcmtfZXh0cmFfZGV2X3RsYl9mbHVzaCgpIGFuZCBtYWtlIHRoZSBpbnZva2Vy
cywgd2hvIGRvbuKAmXQgZXhwZWN0IGJhdGNoIHByb2Nlc3NpbmcsIGludm9rZSBfX3F1aXJrX2V4
dHJhX2Rldl90bGJfZmx1c2goKSB3aXRoICdiYXRjaCcgYmUgTlVMTCwgc2VlOg0KDQovKg0KICAq
IEhlcmUgd2UgZGVhbCB3aXRoIGEgZGV2aWNlIFRMQiBkZWZlY3Qgd2hlcmUgZGV2aWNlIG1heSBp
bmFkdmVydGVudGx5IGlzc3VlIEFUUw0KICAqIGludmFsaWRhdGlvbiBjb21wbGV0aW9uIGJlZm9y
ZSBwb3N0ZWQgd3JpdGVzIGluaXRpYXRlZCB3aXRoIHRyYW5zbGF0ZWQgYWRkcmVzcw0KQEAgLTQ5
MDUsMTkgKzQ5NDAsMTUgQEAgdm9pZCBxdWlya19leHRyYV9kZXZfdGxiX2ZsdXNoKHN0cnVjdCBk
ZXZpY2VfZG9tYWluX2luZm8gKmluZm8sDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dW5zaWduZWQgbG9uZyBhZGRyZXNzLCB1bnNpZ25lZCBsb25nIG1hc2ssDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdTMyIHBhc2lkLCB1MTYgcWRlcCkNCiB7DQotICAgICAgIHUxNiBz
aWQ7DQorICAgICAgIF9fcXVpcmtfZXh0cmFfZGV2X3RsYl9mbHVzaChpbmZvLCBhZGRyZXNzLCBt
YXNrLCBwYXNpZCwgcWRlcCwgTlVMTCk7DQorfQ0KDQpSZWdhcmRzLA0KLVRpbmENCj4gDQo+IFRo
YW5rcywNCj4gYmFvbHUNCg==
