Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16810290DA4
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789726; cv=fail; b=gzNQWm5ReHONq424Xz5bQ4atyMMFlP6sEMVC/dGBZrGEgYqfnjDtBAfJwAOqYYuQCZhYO4DvhUuOI2PMGmN/ACASIww0vOk4+fR/Z1h8O/DZLninB6l+tRbWuXPWaHj8+VQPZCNyaSFgZUP5GPbPgWBWxwa+dzVoFDtgf+rnbco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789726; c=relaxed/simple;
	bh=AKzmzmoP/6btqteIrCkTlnMEoOezjNlcy7GMM1xodAw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mSGRUvo766milyUUsCL8xqj3JBcCUeO3RrFM1sLq4Oo71pLZqVVfksxA1OUdQUaOOWTfeUz9pzFRKlIo5xVE2KASW/V7Y2K5GpZOj70aLChKSh9WlxrkA+TCH9fyqjCRtRe7BrqtOO6Adx9YdBrG/Eet7fYMdev8lYH4OOOl7ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKoDZf8U; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKoDZf8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746789724; x=1778325724;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AKzmzmoP/6btqteIrCkTlnMEoOezjNlcy7GMM1xodAw=;
  b=CKoDZf8UrWkBc78zBOAhGng4CAXPc2WrxCMeX8NtglB9boBviQAJsRNF
   +5qRHgyZJqanbRE8NzqS3cb2XygTXVYLBqV2/v9nKjEACjdvH3CfN5d88
   dR0vDC/1mG0+S9pysvqZg15ZAT96GvYAkyCNuCl6GUkU3d88RmKbXg7xK
   SJbeGbHBFcikT7luN6rwzwPUJS1wuhhqf/w5DSU33I4YkBjEzcb68riNy
   ecQKzZCqdkTz321Bp+xY1IMGFo/mNtsi9GRcwplXzNJ8zW4LI/SRg86qz
   DgoeD7Lc8TbQCxUYLU9thyTkHiZqta5/FmDT2wn0A30sRcE+h+tDQuFH4
   g==;
X-CSE-ConnectionGUID: FIJwIFoIR2uwbsGLan62XQ==
X-CSE-MsgGUID: oIdpy7p1RGm73YwOl7ghZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48622061"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48622061"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:22:01 -0700
X-CSE-ConnectionGUID: fOSqMWS5SGeoNmHrisglzQ==
X-CSE-MsgGUID: EGNHe+R3Qr+sg6PKtr/0Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="159887144"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:22:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 04:22:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 04:22:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 04:21:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzoWrbD6ZostqXe2uVnNux+Qx7k5Kem/JGFU78lHu6/G/kmpHJQMg2funVMhWjyGqM/CBecVawmlur31DvhP3ua0Vm+zW5MOZo9bJCNOJ4JvIDYu/Uoq5khBno4+tOdv0hyOFoYmTVTDqPlSz+DmFH4yr1PJH4kGA65y52hibAB0IvNMtT93NKWhjz3tpd1S5d5kzUZOyH44VQarSSsnhTvAMfeywODUwWFeWZZrVTR47F9FpTvVgSzLWXj33gGZOog3hacmM9PIuGQPw/Sf9FWfLQOR8UZZzP+rUr2BwoQxa72N2qPEgccec31gg0yNUbhu4X4pG9qLNAdZp+Ly9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKzmzmoP/6btqteIrCkTlnMEoOezjNlcy7GMM1xodAw=;
 b=tqff57cCueALlT/2UrCKr8V9+fUZVQTLRnTECn2GvbBye0waYgbzNKZmzTcuZcO4f0kszKcFWMTF4N+EHCZal1V4kSm0ZcKtICJBe4q5oCWu7ZN6/JhH/hf/pjbxFaDEfEU6FfXcPlkjsNsq7+Q7KV1OqZtTxjK3/hItV5r+7qVul0nup2GNwTVKgAblS48RY4AMXY+CoKUOUqRXw5vzpTKJWbsHlTPDda41c1997l5Px3om7ZAQmyzD+lrMna5pvvdH6EEAT6r3DNs+P4sNmTPPaNj5mrOwhVX1UcSpUz3fJE0a7vq4YWXb2BPg5UCK3/oajaE/4A7Qwal8jXhC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 PH7PR11MB5982.namprd11.prod.outlook.com (2603:10b6:510:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 11:21:57 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%7]) with mapi id 15.20.8678.025; Fri, 9 May 2025
 11:21:57 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, "jroedel@suse.de" <jroedel@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v1 2/3] iommu/vt-d: Change dmar_ats_supported() to return
 boolean
Thread-Topic: [PATCH v1 2/3] iommu/vt-d: Change dmar_ats_supported() to return
 boolean
Thread-Index: AQHbwKlYQsKYb81eIEW153XEhg844LPKB9CAgAASRmA=
Date: Fri, 9 May 2025 11:21:57 +0000
Message-ID: <DS0PR11MB63739B7AA12D735DBDC3ABC9DC8AA@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20250509140021.4029303-1-wei.w.wang@intel.com>
 <20250509140021.4029303-3-wei.w.wang@intel.com>
 <b36f7eeb-c6ed-4f80-969f-a33a619b954b@intel.com>
In-Reply-To: <b36f7eeb-c6ed-4f80-969f-a33a619b954b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|PH7PR11MB5982:EE_
x-ms-office365-filtering-correlation-id: c5c6dbdc-b080-48c5-019a-08dd8eebb58d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?amVteURZQmlkNmtjd1FnR1BKemlRRjRZanI5bXVyaTFBdm1zU29PVDAwd0Y4?=
 =?utf-8?B?Q2toaXNycUM2MG5rN1NYMWpHaVVGOUZPUFhxbGNHMURSemFoQWJSR1g4azJu?=
 =?utf-8?B?NFRBU2xkUWs3YUpsSS9hZ3RzNU82MWxBbHpxd2VucXhqVi9iemZXbkJPTEYr?=
 =?utf-8?B?aXpNVUhVUWF2TmxibGRnZHhTekZJNDBJelhCUmVIYmxKUkRzVm01dHAyaGwz?=
 =?utf-8?B?NW03cHhiV2h6Rys0TE9iQXVlTHdiYmVUbnh6YmtVMUQwcDhxUGJWRWxMeXVI?=
 =?utf-8?B?dWo2Vjhjby9uZGhwYWNidDBtaEZwM3plU1JWMnVlZnlDTG0wakJJMSs4Y0FX?=
 =?utf-8?B?eVFKVU1sUVk1UVZzNTlZYWxrQWF1cFZVc1RsaWlkTzhram5id3ZxSHhJVFdx?=
 =?utf-8?B?S1dVKys0VW9YRkJEY1NzWlpHclg5ZjRxQm96OXlIZ0tSRjJ2cU50cUFhdlFh?=
 =?utf-8?B?T0x5enNOTlVXUTZhMHhXTExIdkI3UHNHN1R6WGF0M3BTSjgyUitEdExzMzJH?=
 =?utf-8?B?bHowS1Y0ZzN1WTBmdXVKYnlOeU1WWVBOUWlxWHVTd0R2RzUxeUNXdkx2NUVp?=
 =?utf-8?B?YnZuQ3grclNYR2QzR29FOFpiQ01vR2ZCYitlQ3ZsTXV0Z1N2N09VcjVsR29H?=
 =?utf-8?B?ODZBY0dHWGFhUmY1NExNbGpIY0xZT2QrTHdFWGZ5YmNZVUNYay9FOUxYc0Ir?=
 =?utf-8?B?d0FsMkhPLzRnMGFxbllXQUVmQno1R1R0ZXR1TWZXK21KZEVCVzM5dzdGMnR5?=
 =?utf-8?B?UFhOTlhmYnVjcmkrQzI1WTVJSEgxajZIaXJ6RjhtUTIyY3g1b2FDRnNObzc2?=
 =?utf-8?B?YXpZRndka2ZxSCtkU01qdDg5c0FlNTRtVnJaUGI1SVMzcmNTVXc2bUdiV0Zt?=
 =?utf-8?B?cVpOWmprL0lUZmFzZnNMVkZQMjB2bnMrMUNQNWM1c0NnbFlha2xLaFg3YWJr?=
 =?utf-8?B?cEhPa0xrbmkrMlFmSkZuU1c4NHVXSG1iZGh3YWVvbUUzdjBHbkR0Sm5Xazd4?=
 =?utf-8?B?anc3L0k5TEh1UnF6MjdudU5VdFZZR0FKMWFBNzFDeitNZ1k1UWFsM2JoUlBZ?=
 =?utf-8?B?REpmY1BjV0QvSHNmWmszRFZEYWp1dTlqYlFFdUhqcU9Va1lvV040VFJwU0x4?=
 =?utf-8?B?OXprSlkxS1VtdXEwRWptYmlGb3QxQlhJUXNScFA4RlBnU1Q3dWUwVy9mWEts?=
 =?utf-8?B?MXdqWUJCNzZoV2ZKOFQwdkRsVWNCOU10Y1pBVzFoeUhpQVVhOUJYb0lXN1hF?=
 =?utf-8?B?dGk1dGY1Q0JmaFFOcUVOZ1lKMUZtNVU5Uy9JQ1hVc3dkRGZZdGxPSnorek5s?=
 =?utf-8?B?d0dzYW9sMFNlOEREQW16NWJoRUZaT3hFK083TGI5UVRyTGJWZGlCb1pIWGww?=
 =?utf-8?B?aXl2SVVKT29TU3h1SDRDODdTREQ0RVRJOE5wellVTEk0dUxKSzhGWm9kdXlH?=
 =?utf-8?B?VjNFcUxYSzQ3Z3VKNWlMMGp5dlhuNDViRTRCdUh6UHNCMmhDTzVSRlFkcktv?=
 =?utf-8?B?Y2QwNC9RWC9VSE0xNVJNMHZxYmVhWERQREcxOEVrQjJyQ3N6bnQwZGhWR1RP?=
 =?utf-8?B?NUgwRHBEYWJFVXBIb0d6RTdKeWMrTXVjK21UdHcyL3c0bWVjbmV3b0hHTWF6?=
 =?utf-8?B?TEh0bENKRTRkK3R0RUZTY1JlWTFGWU5MU3ZiY1d6SERWTEZ0SlhtaWFJUkkx?=
 =?utf-8?B?ZStuMFByTU1jSmtvVUZNbjFrRGpjKzAzSG1IUHhxSm1HQkdkRGVkK2E3SnBQ?=
 =?utf-8?B?UW9kTzN3blJLZEx2UlpQZ2o1bHAyV3pkMC9XWXRDNUdVNmlIbXNMTGtJNHh0?=
 =?utf-8?B?QlpIUXFSQnliR0VQbHlySmNya1VLREFKaGhSL2xla1ZIbkh0WE0xbHNXd3h2?=
 =?utf-8?B?YWdXT1lIK2ZsYjVWZ0pWVDhaRmpocFhpSDhvTmxPT21wNzBQblNhZ3hVcXBZ?=
 =?utf-8?B?TE92bGpVU1JFMTFkL21ocWpsY1hvOTVNaGFxUmZYS3BvVFBmNnhkUHJ5MXVm?=
 =?utf-8?Q?PFRDAcy7JDB1NgzCquGDF+EpGYjFaA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGEwTnU5R3RJODBYS2Z1akJjeXdBRU5NbVZvVksra0l0K1E1Z1dDbWtMMEtn?=
 =?utf-8?B?S25lTWRXNmZaRVdhTGVSRUVFY1N2U1ZyQ0NKTXRmOWEwMXF0SGpjeVp1Ui91?=
 =?utf-8?B?bG96MnNuK2U5alh4WEVPcEczbUxLWGc5MlVibDdBY1paZG1kaWdjVGRuSGVX?=
 =?utf-8?B?MWNNbTIzNU5tR21lRXlEOHZqdDBpdHovL29qeklmM3lkanJrd3FpNHB6OGVt?=
 =?utf-8?B?N3BJdDhObHYrQm91OEJRb2RqNFZOdDV2WFdTbFlPaWkycjl4Zm5zRzN2UFUw?=
 =?utf-8?B?YVdSbUU5eW5LVUJPRGY3RUV1RDZqMlp0SHN3OVNTSVZUWkJYTi9udERmVUhB?=
 =?utf-8?B?dFdnRHo4L3NKMlYrV2pnQ3MzcG54ME9yemFMVDlMOHhVZ0s1d0h1S3FLNjRR?=
 =?utf-8?B?djlpazh2MEFlQU9vUWdBT3V1UDdOWUJxSnJpOGEyNkJWQmE1U3htMVMwQk1V?=
 =?utf-8?B?cURtd1dUaDJuZ2RCM2cvblhzYlZrcGRxVjhSdEVXbE5aRldpM1N4S3NkLytr?=
 =?utf-8?B?Y2hvR1pLYUV2YUs2WjJiaDRBZzR3a1Q2SzFKTmt2NENRTlZSZTQ2SjBRSWM0?=
 =?utf-8?B?M08wZEthdjNNVkR5ZVhZYjZXSDcxdFJZdmE1d2dKQlVKVlFBaVlaVEY5ZHdO?=
 =?utf-8?B?cW1ObnlQZVg0Z3EyV3AxdFlDWEk4NldGdUhCZUtaUW5aWUVwWHRtR3Z5TC9n?=
 =?utf-8?B?ZVVhUjJORTF5VXVMYmpwZGo1RmNPVmJaY0hQMm5yWEpBNmtMK21NVFVvRTRC?=
 =?utf-8?B?Qks5ZGdnaXA4ejhMUlUxVGZGemFQOXc5cUdmQnRwRDZSSlFpYlQybTNvcTYw?=
 =?utf-8?B?cERFcm1xTkZEdGQxL1ZVdDBJQ1Ztd0d4ZlIxUGJtZktyWE40Q2FDWUNIQVZH?=
 =?utf-8?B?cU0zM1pLYmR0MUo0ZDJ5ZWd3MEorWG1ncHNxRkRUQ0pQZ3plNnlDWThzSWcv?=
 =?utf-8?B?eWtkL1g2NmhIUnpaaVpVL1ZoaFRiVjZkV1dHVTdOUlRJeTBWcVNLSW1vZVpK?=
 =?utf-8?B?T3VMRmQ1cVFEdFFHZjRrMGUvOE5LNXVNRzhTMGlLVDBtTjhORGJXeU94UDBE?=
 =?utf-8?B?QlZzMDlaRzY1VkRoZGwvbGJtUFdmL1pac3I3Q1Aya0txdW5tSFhac1NabU1D?=
 =?utf-8?B?L0pQVmUwSlBmdlgzR3FEbTZzL0oxZ01pckhjWnBiRHBNZVgyL0llc3VaUG9W?=
 =?utf-8?B?WUZSRmdzbEk1RjBRbGJETDRjVjh5RXFyYUJlaEUyVUo4Rm5rNG5JbVBuZU9a?=
 =?utf-8?B?R0VqREF3ZDJyMFZ5SVpxUW5Od2lmZ1FoRVlDU1ZpQlRwK0tubDRRanN0Nkdw?=
 =?utf-8?B?RGtubEIrZmpiaWM5Nnd3Nk9tV1dQK1BrUkVRUFpVTGUxajBnM3F2RXRoZ2M0?=
 =?utf-8?B?Mko1OHo3dGUrQ0VubGZvdVpDU2s5SS9kOGdaODZDMmdWUHRpK3hPSkpyY3RE?=
 =?utf-8?B?bHZsbkNobTl0ZWd1Um9oM3pobHNuOVFZdDJoaHp5Vjl5ZS9nd0QycHRrN1lF?=
 =?utf-8?B?T0dhU2VMcGl1ZktETzM0NWgxNkxUcFFhR1NuRG9nUjFGZWNSRWVIYWJ0ZVov?=
 =?utf-8?B?N1BwRExjY3grS3N0WmN2aVJOY3RtLyt4TlNiUVo1b0RMdFBCM3Q1MzcybGRO?=
 =?utf-8?B?VVhHd09waTU2NTcycjhFTWU3VlErR0NxQXRHc0ViVjdMM094TmQybDh2ZGFi?=
 =?utf-8?B?aDFGS001dVJkNGVvTk9lMkRmWlh1elFDZDJGbmtPcTJQazY3WVdYVFBmUHBs?=
 =?utf-8?B?aVk4YlR0enQvd09wSzErenQ5UDdvZ0dKbmsrRnUrM2RIbW0yZWMvY3RGaFlN?=
 =?utf-8?B?NndpMnhUUEdKcVdBMzY0OHRKYUZqZFl0Mjk3ZE1INXg4aE9qWDBuWjFaYXNw?=
 =?utf-8?B?RkJsdmNtNEF2ZWxwdzFOajRKWVN6enVraDRvbkw0MGVBT1M5bFU1cWVNeWc4?=
 =?utf-8?B?eUM1azFqQkZTWFI2WEp1NE1Pa2FOMlVNb1FFQVp3alRCUHVXK3pkV3RnTGdR?=
 =?utf-8?B?MDkzL2RBc21ZUXdOQkNZbUViU1pObXQwUU1yV3g2RXNJT2E0M2doSHIrUEZL?=
 =?utf-8?B?NGJvNC9HVWgzTXhlOGF2Mjg0WGZXU3N3bTcvMlhYUjRaTEo2UkJ4WGhrK1dn?=
 =?utf-8?Q?zoSbfE8r/TOnt2+y9IgZhrcFi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c6dbdc-b080-48c5-019a-08dd8eebb58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 11:21:57.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqBYsJga7ZodmfW5sXVvl6BDihnQdhFcojIi5R5Et10wSGMs8PutsuGEzMifqzisSws0lajKLZboL9qsNuhs5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5982
X-OriginatorOrg: intel.com

T24gRnJpZGF5LCBNYXkgOSwgMjAyNSA1OjI3IFBNLCBMaXUsIFlpIEwgd3JvdGU6DQovNS85IDIy
OjAwLCBXZWkgV2FuZyB3cm90ZToNCj4gPiBBY2NvcmRpbmcgdG8gIkZ1bmN0aW9uIHJldHVybiB2
YWx1ZXMgYW5kIG5hbWVzIiBpbiBjb2Rpbmctc3R5bGUucnN0LA0KPiA+IHRoZQ0KPiA+IGRtYXJf
YXRzX3N1cHBvcnRlZCgpIGZ1bmN0aW9uIHNob3VsZCByZXR1cm4gYSBib29sZWFuIGluc3RlYWQg
b2YgYW4NCj4gPiBpbnRlZ2VyLiBBbHNvLCByZW5hbWUgInJldCIgdG8gInN1cHBvcnRlZCIgdG8g
YmUgbW9yZSBzdHJhaWdodGZvcndhcmQuDQo+ID4NCj4gDQo+IHNlZW1zIGp1c3QgYSByZWNvbW1l
bmRhdGlvbiBzaW5jZSB0aGlzIGlzIGp1c3QgaW50ZXJuYWwgaGVscGVyLiBUaGUgZnVuY3Rpb24N
Cj4gd2FzIGluZGVlZCBub3Qgd2VsbCB3cml0dGVuIGFueWhvdy4gOikgbm90IHN1cmUgaWYgQmFv
bHUgd2FudHMgdGFrZSBpdCBvciBub3QuDQo+IFRha2luZyBpdCBtYXkgbWFrZSBoaXN0b3J5IHRy
YWNraW5nIGhhcmRlci4gUGF0Y2ggaXRzZWxmIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBSZXZp
ZXdlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQoNCkl0IHNlZW1zIG1hbmRhdG9y
eSB0byBtZSBmcm9tIGNvZGluZy1zdHlsZS5yc3Q6DQoiDQpNaXhpbmcgdXAgdGhlc2UgdHdvIHNv
cnRzIG9mIHJlcHJlc2VudGF0aW9ucyBpcyBhIGZlcnRpbGUgc291cmNlIG9mDQpkaWZmaWN1bHQt
dG8tZmluZCBidWdzLiAgSWYgdGhlIEMgbGFuZ3VhZ2UgaW5jbHVkZWQgYSBzdHJvbmcgZGlzdGlu
Y3Rpb24NCmJldHdlZW4gaW50ZWdlcnMgYW5kIGJvb2xlYW5zIHRoZW4gdGhlIGNvbXBpbGVyIHdv
dWxkIGZpbmQgdGhlc2UgbWlzdGFrZXMNCmZvciB1cy4uLiBidXQgaXQgZG9lc24ndC4gIFRvIGhl
bHAgcHJldmVudCBzdWNoIGJ1Z3MsIGFsd2F5cyBmb2xsb3cgdGhpcw0KY29udmVudGlvbjo6DQoN
CiAgICAgICAgSWYgdGhlIG5hbWUgb2YgYSBmdW5jdGlvbiBpcyBhbiBhY3Rpb24gb3IgYW4gaW1w
ZXJhdGl2ZSBjb21tYW5kLA0KICAgICAgICB0aGUgZnVuY3Rpb24gc2hvdWxkIHJldHVybiBhbiBl
cnJvci1jb2RlIGludGVnZXIuICBJZiB0aGUgbmFtZQ0KICAgICAgICBpcyBhIHByZWRpY2F0ZSwg
dGhlIGZ1bmN0aW9uIHNob3VsZCByZXR1cm4gYSAic3VjY2VlZGVkIiBib29sZWFuLg0KIg0KDQpB
bm90aGVyIHJlYXNvbiBmb3IgbWFraW5nIHRoaXMgY2hhbmdlIGlzIHRoYXQgd2hlbiB3ZSB0cnkg
dG8gYWRkIG1vcmUgY2hlY2tzDQppbnNpZGUgdGhpcyBmdW5jdGlvbiAoZS5nLiwgaW50ZWdyYXRl
ZF9kZXZpY2VfYXRzX3N1cHBvcnRlZCgpIGluIHBhdGNoIDMpLCB0aGUgYWRkZWQNCm5ldyBmdW5j
dGlvbiBuZWVkcyB0byBjb250aW51ZSBmb2xsb3dpbmcgdGhlIGluY29ycmVjdCBzdHlsZS4gU28s
IEkgdGhvdWdodCwgd2h5DQpub3QgY2hhbmdlIGl0IGZyb20gdGhlIGZvdW5kYXRpb24g8J+Yig0K
DQo=
