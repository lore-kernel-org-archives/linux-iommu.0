Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E37D1F8ADA
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116912; cv=fail; b=SfucTKCM6SLP95LDunRTJHsNUrt0e5Tu6MtXOu0m6WPpbTDyDlb9HKBVIQRReZG8sOnACdbv9TVIcmUie7bJSdBlvcSug6ajzU4YtP6eORxZUG5aL/CQ+jDM1iGfg2hrN/3ITK4FgRjGc55WqTxmxgzbQF4FqyULbkzCSGmKqEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116912; c=relaxed/simple;
	bh=51dJUw5bGsdnCqh22nLMIQ6AgljvG2+1jhaVPTO2ir4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uMxrGvfhigw4Pz2C4wPYpA3YirUTvKrZcgsbxFhalW924odMiklWLzkBM49fUsbQZbSS+X9YaHC9XQ2s3sVZid5t8rlMuXn3qtZWUln8qwWsLBWYV9rs6XXM1FfERuME6Xa2pjDpgk++crNHbolXU2ipiqALddISoClsS1mAsaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WB06spVe; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WB06spVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737116911; x=1768652911;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=51dJUw5bGsdnCqh22nLMIQ6AgljvG2+1jhaVPTO2ir4=;
  b=WB06spVezc1wcS9Qxnv7xr6Zp7M4loEwv4VYwkQsvkaVp3Wr5Sgl2/uK
   pVDi4HTudNAwP9qhRnxmaBuKcQl8X/uACqSDxHkZhiS9YTajrsowoVCLB
   MSP/FCK/a0iDjKEO2Fap+FLTeVXqZyv6tU5vdQJPHL3IuVea9j8oM+Nir
   ygSgLaERCKmfx5OTrYbk8oXTlvoqePT5N5Z6STAeLVqZBXsrPdfcnJdSD
   nyukYEyFxG5RG9j0uaYsN4yxB7iW3rRmnAMoX55ZP9gBm5wu6TZlqeIbR
   jFNgX8tt6ZQAU5U/QiabtvporJ7EchboAURUnETmSldKOu9lXeZErWhob
   g==;
X-CSE-ConnectionGUID: 9bcdoy+IQ7W07RAgnUI7fA==
X-CSE-MsgGUID: aWQz+FSATDC/i6oHbW0WGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="55095636"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="55095636"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 04:28:30 -0800
X-CSE-ConnectionGUID: NLvA+Vh+SVKpHaW5JolHUw==
X-CSE-MsgGUID: 895RwoNtTMS0bmQk5bUyQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105636586"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 04:28:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 04:28:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 04:28:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 04:28:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6uItFbRdiDIwsKMCVoObxEwGXLrwHl/mBpdorw2VGDuVEAu4zPZsh26+ov7GDDtgWc5QBvWuVvEhMQDn28CN7Irq9pW3wHRaEBV+ESQMJAEzJfSbjrY8oTiD0OBf/BDKGPQ1pvY46MQ+nfhVxr9uVFUrs4SqOzr4V6go5mw7g+AR2amlF7uP/ASPzSmx9TSNnGFyCrktj3APulwO6d4Zl84FbN5ZliMzBbVo1WDipf+OCLiSPFhdZ+zIhpJqce/1FdUfU3v5GvSPbWzHIRaWuaRiORiL/xGlldUt6Py6ixSDu34THNnN8bCuStC9hW3ffhv2Jfm6SgGmwPDOHMAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u29XZu1l9ljcfnTwakBzTd/yDXwEbbX6JFZCLC+mGeI=;
 b=TcdWfeLcKOZFjBbtVcdJPARoSd2ewhwpIeaYepvJYrARM7SoAks4evBUIPg2zsE7YseJklT1uld4VT3gtzanEtTUu4xIH58PzSMnmlH9BM1QjFSe8oMTN1traVa3QrbZ6LX3DZfFbPP4in9YticNAtmswr9UrReY9lkv+APqpDLEW0o1/ksk5xl6XbuzYecvRZBqsfng24UGOIvFh6DHPtP9TXKNQeMmQeKdNMdZVnmI44GsyiJnNKA3ycUkTkJdjgfa4pqDKT2/etGJphr6xnPRZ0K7IAGkZ/wCEhp4s9Q77demNPJ1ywkW4K7n6WFlgQW+vE5u7QYgXx+SwwphPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 12:28:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 12:28:27 +0000
Message-ID: <3f101c0c-5212-462c-a916-83e9da8793c8@intel.com>
Date: Fri, 17 Jan 2025 20:33:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/14] iommufd: Always pass iommu_attach_handle to
 iommu core
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-5-yi.l.liu@intel.com>
 <BN9PR11MB5276F2830324D346D180D3068C132@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276F2830324D346D180D3068C132@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV3PR11MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a6abd8-2ec2-4dae-9236-08dd36f27186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dERSUHU3dnZvRlBLM3l6eTVVeXp4YXV5elVwN3kyaXplQUFFK2oyKzUvNkhE?=
 =?utf-8?B?azJwS0pNb3huR2h6WU44Q1JJWjkxaFFQc2lIUUJDOVl6Q2oySnVnU2lZd1Fr?=
 =?utf-8?B?WjhxQVhjTWRpTC8wRGdnWlNkTU1ZNkQ0aXNSTXZGKzRRUXgvVFJ5ZzZORU1J?=
 =?utf-8?B?QkR2TjFjTTNPTzdtRS9qYldxQ0Vsem04aE5jSWEydnc0SjRJMXZRVTRuSUxX?=
 =?utf-8?B?bDhGd1M2OXp6aVNKRDVkNW1PN0duOFVWRXpsdEZRSVkyMklrR0E5U2Erempu?=
 =?utf-8?B?Y1JNL25lM2ZFMFZmd0x3MW9PeDNiQ1puTW1wL2Y1N0duWDEzRElvNWVrcFNt?=
 =?utf-8?B?Q0c4dDFjcyt4Mlc4Y1ZuWm9kQ04yNzRBdFdRV21yY1BQSlVMR2J0UW04S2dV?=
 =?utf-8?B?TGhkQXdCS2JKNzFxWFZzWmR5dVp6alpCNVlPYWxYakpQMlNORTJ4NGlGM2Ux?=
 =?utf-8?B?ZytYTHNjSStoOUpSRUJCSSt3cUF6M081OWFVTU5oQlVZNUZ1bzJlTjFnZmI2?=
 =?utf-8?B?RXhKc2tNMjAxMXA3YW1XOHZxVVl3L2l4MUw5MlRlMDFFQ1FnUVpaSVFlSDhQ?=
 =?utf-8?B?OUJPZkJjbXYvb3BudEpVdWZRNkIzSEZ1TllWdUo3Y2xaeW1UUlBuS2R6bW01?=
 =?utf-8?B?UDlZUkR1V1h0NFdhQ0h3R1I3d0pwSmsvbDFxMm1PaXIzY0MwaFRLNmJUM2V0?=
 =?utf-8?B?bFpQZ3BQS3Q5cG1DL29ieFFpK2xjT2VGT1RzbTdPdWNYKzljR3FiOGlxR1lj?=
 =?utf-8?B?VUZlak42VWZJZi9qUE1sMEFwcnZwaENFdU9qV1E1MFRzZFMwVkMyYzZURmhm?=
 =?utf-8?B?Rlc2MTVub3Z5WUk1WlhXSjRnVk1xdVVZT1FyeDhUdEVCdnpnY1BEN3o1REFJ?=
 =?utf-8?B?QU9CSlRFN0JnZDZOaWk3TGNTalcxdnphcm9JTnQ5djIvYnNFQXVZT2NOWnNr?=
 =?utf-8?B?ZlZYdnIwcEdsdk1LYy9PamhTZzNtUlBlanlMdW54bDNvQnFLRlpkUVdRNUsx?=
 =?utf-8?B?N2dyT2RiNW05QStJVFVSclVaSHVuZ3VLMjBqcXZnUTMvK21KMUpGWE9KYWNq?=
 =?utf-8?B?UnZRU09vRmVzNDJ2UUMvWVBLVWRua25ib2VrWG44dUo0LzFXMHdqaEYvR2tE?=
 =?utf-8?B?UGpEZlN4a3J6REpFRFBCNnErUk96TVpLQVk4VGo2WXR5OXhOd1dPQ3VRS0pT?=
 =?utf-8?B?N1BJd3RmNEFYM0pWc1dTbk5VWmlONXJpMU9VandLWCtZMTZBYVFOVURPL0pB?=
 =?utf-8?B?UkRaSEYxTGJqMnkxeEJ0NjQ3aTZRdnFXdGdrdU4wSmxZQmMzczlQb0dzV2Ja?=
 =?utf-8?B?RG1EejlLSHZUV2ZwSnF4UW82K3FxdElaYUhJT2x0SWtHU3JhbWl3U1dxN2JD?=
 =?utf-8?B?WW5vNHd2Z2lKaG4xclNUTFhrQlFWangvK3lFcVA4dnJNU1AxeUxlNXR0UFpJ?=
 =?utf-8?B?RVFCbG1EamVoSk1NNW80bGxYU3Z1bnp6NEhYU0FrRWM5YldwdVhTWGNrNXBB?=
 =?utf-8?B?R2w3VGU1WUxqcnBiMlhadkx4UUk3eVROYVAxMUZTaEpIYTl5UEdtdmxzN1R2?=
 =?utf-8?B?U09Xdnp2RnB5dUttWG1VZmxKd2RLdi9nMnN0NVpEUzUzOXhqaElMaHUzeU5Z?=
 =?utf-8?B?cDBnZDIzUnRQYlpHSjdxVVNsZlZYaFprNEtJdUhqa1NmUzFlcytIbnNYVjRP?=
 =?utf-8?B?YW5TcTRGbjVBV2dFS25zR2R1WHlBQ0hlVWQ3L1V2RzdoeEFiNnpTVmVtZnJn?=
 =?utf-8?B?bHJldVVFamQxNTJKVFgvckpDQ0t4a040NUFlYjQwT2JXRDFjNWF5YnRwc1NU?=
 =?utf-8?B?cm9PM3pGMkpJUFhxQ25XdHdWdmRzSTJLaHFPWXdodXZJa3ZJOUttMWxndnpU?=
 =?utf-8?Q?Si83186kZvdlA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk04aUV6Z0FHY2dOUVdkYzNCUFM1cmJjcTJBTU9wWjZiNWNTZWFtcFFhdy9z?=
 =?utf-8?B?SFhjNWlhbjZnS0RubnpETVgzd0FLUFdwWGpMd2dtR3pqY24zRHI0VXV6S3gv?=
 =?utf-8?B?MTFib1E3aW5NRVlPYi9HZzFieUlJTzJCL2VuV1AwOGd6YXpwb2lkSmY3Sm9x?=
 =?utf-8?B?UG94am9VTmhkd2NvV1RUdjRqMFB4dDdoZTRRck5qY29ESjU4SEQ3Z2JOQ1J0?=
 =?utf-8?B?MmtYaDBReGJ5WVEzZ09zU3pzMnp6MzQzRHFHZUN5ZWhjZmpnTmVWTzd3V0xo?=
 =?utf-8?B?MWEzUFMrS0FGWkNwWEl1WFJITEJmREtDSjJPTllNb0grVEJZVWhtUXlTQnQ2?=
 =?utf-8?B?eUMvNExhUUtocDRHYUhxMFVROWdyUjhUdUZNNGtXMVhSaFJ0bGxsU1NuTVAr?=
 =?utf-8?B?N2JubS9SdFlMdWYxMys2NDhtaFBMc2ZPYnFBK1pZSmRZbStCdWtzdElQeUwv?=
 =?utf-8?B?QVZVMTgzUUdzMXlrMEw3dTZTb0JNSUh1U1h5QTgxWkI5ZWQrQzNhTWtZNTZZ?=
 =?utf-8?B?VHhmaXc5RE5Wa0U4M3A1dUhWQlUvcUxhaXhEOXkydDRZUG9lc0t5TUNCd0JY?=
 =?utf-8?B?QVVlWVZmd1RyMzJZSmFDK1hucDM0K2NDVlVsbXhRdjV2U1pqd0ZBTDMvdTRF?=
 =?utf-8?B?anRkdDV4dXQvOEpaeGh4Yk9QNUR6MnJkTXh3NXk1MzVFU1ZLNG1LQWYwWG40?=
 =?utf-8?B?bXhNWGFOWDQ1L3lyUmZPa3ZUV2JodXJoazJVem1QR0h2M0JYNVNhaDNEUlJS?=
 =?utf-8?B?eWdxL2VsRVlXbHA5cG5rM3hSOXFnWGdSK0NjY0Y3Vk5FZHM4Z2hQVyswYVI0?=
 =?utf-8?B?cVpPaUpiZzY1dTR5NXNieVFVSWpVd3RjbXdqcVNhRXo1NytreHlIVmlWSTRT?=
 =?utf-8?B?S1FTbjBNNEMxUXBvcWdoTFJPTHRKdURKMFQ5VFJDYmFpUnJQZXkwdEVXZmlj?=
 =?utf-8?B?NnlKbGdCRW5haGxZVkZYVDJiRXU3ZU5Yc1BmZElIekNWaHRycUdyN0FyU0p2?=
 =?utf-8?B?a3NCQkwrdDNidTI2N1cwcUd3RStuVHFUZVRXaEVuMEFDVGE0TU5wTGl3Uytr?=
 =?utf-8?B?QWxaR3JGajZyV1JydjRUREt1VWNVenExRmhjYllOV3RzdUJRNnI1TllQa0Ir?=
 =?utf-8?B?TDhTQ2tqaWZDU3BMbnFIVUZyNTVLVVU2Y1poUFRQRzlveFNmb3B4MDNRU2RM?=
 =?utf-8?B?QmU3ODBkK2xxZWFmWlpMTWdqYllSZWtnRlRhOGdFMlJBcDFwbTBmeHRGdlpy?=
 =?utf-8?B?aG1qR1VqS0Z4c3NvTzlKM2JwcHVBdVlHaVJlWG5ENXdyZ3NlQlF2R1c2K2c5?=
 =?utf-8?B?Z3RGMCtJWjQ5L2lBSnJ4amY0ekFGT09LSlIwWktxaVJJTWZ1VmZPc1VpU3Nr?=
 =?utf-8?B?anltK2l2ZTNObVJVT3RjUzFNeGtTZUhqRm5QNHZqcGlWdFpmUEdsR0xjekJF?=
 =?utf-8?B?d1Zta255WGwxWnNmeGs1aFZ4aWoydW45eFFMU1hmOVEwbWJwOXZacE1WNkRK?=
 =?utf-8?B?NDFaR0k2clhMMlFGdTl6TTBEYkdSSVJ2cFZuU0hJaEVyZmZJZ2hIeFo3TXI1?=
 =?utf-8?B?TlRHRTVCRE1ON1huUzJ1OXJlUUsybkU4bWZQYUFwU1A5d3ptdm0vK0RteVZs?=
 =?utf-8?B?L2o4OXByUkJJTjlHaGY1QjBJYkVyRWtzSDJVTkJhZ2s1YzJLaEtCWlNYSnFo?=
 =?utf-8?B?ejAzbkdKZVh4T0JLNnYvcU5JN0dpWVJUMjVQTEVJa1hmem9IZjJSa21iY0cv?=
 =?utf-8?B?V1o0UE01ZEJVazk4SmtERCs3UnlNcHE2ZzJIUy9SRnBpbjlhK1RkaGliZmwv?=
 =?utf-8?B?WjhZRWloMy9kQ0dEQ1JCVWdMeFRHQzA0R1lxSElnQlJuSEtkd3gzaDVNVDJa?=
 =?utf-8?B?OWY2M3QyOVRVSEJVdHR2R0M0OW8rajJCeUJPM2FGbDdUOThESUlwdzYxbVBM?=
 =?utf-8?B?bmpsM0lTa0VWZjQ1cmtrcUlZUlFlbEtFZDliT0czd1lvVG1wS2xGeUZDMVNH?=
 =?utf-8?B?TmFlblV1U0pMbXpDNTJFT0pNRHYxSUFpbmMvUUV5cVJ4bXp5UlN0bzgyc296?=
 =?utf-8?B?T3FxK2FDMGZEdFBBcUhicnM3Ykp6YWNzTGdwZnJmaVRrQUtGeit6Z2wxRzBo?=
 =?utf-8?Q?2M8ZDODgsOyGDjlMXNgBTld7b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a6abd8-2ec2-4dae-9236-08dd36f27186
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 12:28:27.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt52NF4mJdMACdgtgtSbgtyxnBtGTjAhd2Fx1JLEGjODX8WZYpXdTVnra9iYalQWARW3isvd6S26auXbu4ybBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8601
X-OriginatorOrg: intel.com

On 2025/1/9 15:44, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, December 19, 2024 9:28 PM
>>
>>   static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
>>   					      struct iommufd_hw_pagetable
>> *hwpt,
>>   					      struct iommufd_hw_pagetable
>> *old)
>>   {
>> +	struct iommufd_attach_handle *curr;
>> +	int ret;
>> +
>>   	if (old->fault || hwpt->fault)
>>   		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
>>
>> -	return iommu_group_replace_domain(idev->igroup->group, hwpt-
>>> domain);
>> +	curr = iommufd_device_get_attach_handle(idev);
>> +
>> +	ret = iommufd_dev_replace_handle(idev, hwpt, old);
>> +	if (ret)
>> +		return ret;
>> +
>> +	kfree(curr);
>> +	return 0;
>>   }
>>
> 
> It's not balanced to have handle freed in different locations (one in
> Fault domain specific handler and the other here).
> 
> It sounds clearer to remove the fault domain specific helper and have
> everything together in this function when you move it to a C file.

sure. I'm also coordinating with Nic about this since he also needs to
make the handle code to be generic in both fault and non-fault path.

-- 
Regards,
Yi Liu
