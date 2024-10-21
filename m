Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1D1E0DCD
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497308; cv=fail; b=Wsq5ogsDfY9pcWeZ5LBIILySwKvd+0aMgdw5NUtTvdQo8Sl++paJdjQfNZXRDOixTxvY6zMubBXg+1DCMUkIhxAZz8PJ5I7j+d/BGKw71jYn39mRWHMt/sUrr718ye9l0GcCdFm1ucquMKDlHGHMNpKaAKqjIL3GPrS07z4uUn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497308; c=relaxed/simple;
	bh=oCAAvP4TB3TpNn9QzqnC4VYOe3HHXstTmzyTFU2hmPI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CEY4S5K8T8h55no4vLYzADzmIgnDfkwUEMmNNltAWydBNWBnB9q137duZqlgXWeE8xHkHsw8Md//qtspE9FAPjttmr8YxQuaBo7DFb6v5lAlp502stpXigcQqWuknuesMSbS365Ru0N66BH1aZbAu45ps/2yvbMfHw7Hrd7uk6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/uDjobT; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/uDjobT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729497307; x=1761033307;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oCAAvP4TB3TpNn9QzqnC4VYOe3HHXstTmzyTFU2hmPI=;
  b=E/uDjobT9+jlKCX4XlA5rdk+ShO6GfrzW8web1ubX/2siUqEQkrA1PSp
   vwgjQWXBV56JOpwBuKTRzCWtTQIRpSP5dZ86pLMksUMuhG8aIixVid0xG
   J1Qs/PlKkgq+S09LgiZ20FAabl27H12karMMzWi8hbyIIQynXKmTpXZr5
   kJHRhiUJKigiWzWzPO4wrL8RUVg1xNzi+5dofxag3XaMSsV83r2IK2I2R
   4IdbsemMIIG2DuHrKIboQaZKHylkeLmuC0g4YoyUx7aHjHUowf6rQLKvC
   66rLraRTp5/UZfre4N8mHRNvTs4KVIhAq8sv1dg5TPzo+DFyxuAemBHcK
   Q==;
X-CSE-ConnectionGUID: B+7MshBITq6seHKFOlIkkA==
X-CSE-MsgGUID: 4ArJ7fZWR2ygyT0p2ZhBwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28916451"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28916451"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 00:55:06 -0700
X-CSE-ConnectionGUID: /rgb2Xp3RaWSWMcAAV5Saw==
X-CSE-MsgGUID: 6/vHIN1tT7qsPfferxzgdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79603746"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 00:55:06 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 00:55:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 00:55:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 00:55:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=issDKfnYHmsRYlNK5mAbXCDZNfx0dgqTIfkU/1jzZXXRphlyX+dxr+IXSjdOfWrP1+z+wPv2p4ZlLQqtt5FSbucezDxejCDcp6Jbcr7A35+wUXkFZPUa/H7GNMV+5eMH2araah2Ky/nQHHpj+nhw3wYM+dkOuw1k11vJjUA3t5EBRro0cSug/D3QwhaSt4dqYIlLdXMgDQeGJTRKWrl1YSTgmA1XnR6sX88IGd+HHaimvTAs+HN3qBN6YPg/bKY20obhyLERWQd48tFNy0Gj/asx9uFBakGdg3Hwd1Mv5+KGXZQSNNbXdh2ewLnZmD63lCTCXkBkS6QJU1KfShUrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3rfC9tsUUU8ooiy5jGA5adsMGM51H2pnxOnItazyZw=;
 b=j+zG+6gfCJOKtAp32thfR2PvVvBE5YT9dnJm7/aqBaaOgwWywtDIpbnIDBGkA0l/7jj5WujWTfrJz53tZE/v20Ws/hi1EVXjCeRzHapqAMoK3dIgJscj53Y7MJ5oI/NNrRkWNaewOY8FYH7jsfRwepIQVv0grSO4uOLtqHOt8dSX1LffXaoi/6irZH7gst4OHsPPyTHe8HMQ8hthDaom7dC/Fyrs0Lst6HVl9vkRUvJRupRqd/yjypF6ChIfoW7TqdFB8CeXxCyYoCPDKoQx2gy5B9HuIX8YNQuAJreT/FfYe0wKZotHrj77uevB6SVTPdgmI9z5cE6abvZ9YJRJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB7069.namprd11.prod.outlook.com (2603:10b6:510:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 07:55:03 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 07:55:03 +0000
Message-ID: <95ddde93-9cac-4067-a3ca-1ef02c2dcd09@intel.com>
Date: Mon, 21 Oct 2024 15:59:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] iommu: Add new flag to explictly request PASID
 capable domain
To: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <jacob.pan@linux.microsoft.com>, Jason Gunthorpe
	<jgg@nvidia.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-4-vasant.hegde@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241017140137.6028-4-vasant.hegde@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a14c1b-9e67-49a0-514b-08dcf1a5ab53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU5uQUxzWGRLS2lUcE1GYWJZSEYyNzUzWDJ1am42Qm5yWXQzY0ozeFQrYmZa?=
 =?utf-8?B?V2U2azZiTzlJR0JDRDQ2enJLd0U4QlNpVzRjOHlpYTlOSVlUalZoVEFZTXV2?=
 =?utf-8?B?eWcrMW9lRFoyMTI3a2ZpbDdTVWR6R01uTTBaNkdQWDBDZnpmcTloUVhkV1Jm?=
 =?utf-8?B?Rmo4TXprZFc1emp6Qm5OUEh3UHdpNVRXUWVhbVpoSGdtcXFKNkoxSUVKME5X?=
 =?utf-8?B?bTN2U0NRWWx4NFptS09EMFF6NVJGOE1CQ1hKVGs0SGhkQzRWKy9QSHgwY2hK?=
 =?utf-8?B?NnZzb3hkTmZGcXNidXBCQWFzS2NKQ2VqenZYSENhWVorQkVveTlOa3l1MVNi?=
 =?utf-8?B?ekNQdGZGd0VBaW4wdWJGK1pDTUljRWpod2llMHBsZUk0RGFtNW1CUGlhazhP?=
 =?utf-8?B?TExQTTMzemhhakpwTzNFVllicDQ1ZnhZelVydTlzcmRiaXBlYU52L2h2aG1p?=
 =?utf-8?B?c0dFZG5vemJ3eGFSUDFuMU52VHpWTUUzcHdWclFCdmFKMG01b1p1WmJaNzRl?=
 =?utf-8?B?L1JDVk1hOTJMU0NZL2JQejJFdkxOaWIxQ3l1d0JoVFYzZ2RYeW9MSzVkRC95?=
 =?utf-8?B?VWJLRzUvUmdRSEhybEM4b1lvMHpGc1VOTVkzUkM3R0NWTUJvb3dES2NOZWVV?=
 =?utf-8?B?VmdNd0t1b0dQanRmQmFQbmxjL0VZcS81c0I5NHZaa1ZWWCtyYldUbFpKN3dW?=
 =?utf-8?B?a0I5cCtST2cvZ01CVU9DT3VtSXJ2TEZoSzVQWTA0aXlNbHlHVTBsNlJrd08z?=
 =?utf-8?B?ZmtFWll0NlBFTnUzUE9VTWZyODNRSHRUZ0JyS3cvRU5makFpcUpPYWV1YXJv?=
 =?utf-8?B?ZFZlem1ZbFc4cUhQNFEzeEdjVXdUeGYyOVNUOHY5UGFVYkJCRDJwaEFVUTJn?=
 =?utf-8?B?eE11WGcySjA3dUNsLzNRbWFaRldLeGVZeS9oM2FwQkpmNlZya1dqYkVsT0Rq?=
 =?utf-8?B?c1JFempORlNsMGVqM0hhS0RFV3I5bTBoUEhTZXRVNmROeWt6MzF6VnZRNmV0?=
 =?utf-8?B?aThoMXJyeUZsRm5MN1JZTUNUNlpvQmwyQ0RTMy9PaTlHL3YxZWM4dVVEbHIr?=
 =?utf-8?B?M3hxTWozei9PdGdXSVFPS3ZxV25pVXFYc0JVdDZIc0ZxbzJJM2tMalNPMllI?=
 =?utf-8?B?V1pQUHhMTnpQMUxiMGZoM2tnbDd1QnZwNitJR1hYOXpSRFlkMkp3dEJuL1dD?=
 =?utf-8?B?SGpJeFBSbVNROURsamV2dVZWVUp4UDVJVWhXSVdOMTJEWVRDUDVFN2lSODhk?=
 =?utf-8?B?UkxpUWlBaW5tV2FaNW5qTExxT25RTnVlc0Fpa1ErR01CaFRGR291Qy9NRm5J?=
 =?utf-8?B?YmtZN0lxSjQ5L0dIQy9haG5EcEpvQ2E5THlzZmVmaExRR25rQlZ3RVAwOTBV?=
 =?utf-8?B?eHcvczE1U2hjLzM3cWVMeXhtSWdDWDdpSEZTSTdOcU1WM3pPeXBHUGtLTW5J?=
 =?utf-8?B?UDVSeHF3UTlHUTZBR2p6YXZDQSs4M2sxSU5MNm5hb3o3U1dLTlVNRHZ1bElQ?=
 =?utf-8?B?L1pvTXUwek9FR3FEWlNJQk9CVkdzdVNIUXI1VVQ1UkU3ZCttRmR2VGhnbmtH?=
 =?utf-8?B?bm1rajJvS0FaL240aTNkc2NELzBueHhLeEhsWFhZMS9kdHc2Ylg2bkRhT21R?=
 =?utf-8?B?eFhvNzUvSW4vR3FWUSszSHAwY0VaTmRKSW1iT3Y5M0JoTjBzUVFxcUJCS25r?=
 =?utf-8?B?MGFLSS9lWGhPZ1ZWd3ErNWJINUZHRXYzWUc3NFg1Z3BoQ3FpSlZzYnRSUUwr?=
 =?utf-8?Q?Obitz/WOKHGzf4A+nWNG7pbrVt6hVAawpoti679?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkJPTk54OG85RlVacjdrODlLS3VRRVduRm9PNGRDT1RYN200d0N2ZnNtb1hx?=
 =?utf-8?B?WFkxT29tUE9aTTlLem1FV3kvbWpmQld4cHZJMVdmcmR5WVYranl4Uk5PRTFK?=
 =?utf-8?B?a0tnYnljU0NSODVkcS8vOExlZGhVZHYwR3RlTFZCcWFHKzREUDlwYjRpa0t3?=
 =?utf-8?B?amV5Q25jS1F6R1NFbFk4b25IM1NGaDdDUG9PcERITHR1YkNRTTVyU2lPVHZL?=
 =?utf-8?B?V1BtMkhPQzJwYnlVK0xiR3dDRWhUREJ5WEJ6dXhiY3VwbFlRc0MyNmdTc1hr?=
 =?utf-8?B?Y2lCYnpTNEwvOGpYYUxQcjNuaHV3bzhZU00xTkhpN1lRa3g0MG4xaTE1WS9S?=
 =?utf-8?B?KzlUVXpFeU5NczNTd1EzU2hiK2w0aSsrL3g2NjNpQmEwUmd4SktaVkhhZ0My?=
 =?utf-8?B?R3JYcjRVRXZFbkpPUFRobXo0NTRFZ013S2IrSGtmcEl6OEUzSHB1TnoyMWRV?=
 =?utf-8?B?SWZiejJ0RjRVN2hyRkw4RENIbWEraDJWN0FXRUlKeGUvUmowVXppVmkvUHNn?=
 =?utf-8?B?b0M5NU5IRmc0Qm8yaVg5QmhwdGRJY3BNZlZxQ3VuSlR6Y0MrT1cwMjJUaUZy?=
 =?utf-8?B?VDN1QVR2T0w3OVVBWFY0VWZtM2VLUVpoWHRqK1BWUFRFeDRYSFB5NGNnQTly?=
 =?utf-8?B?YndoK3BBTjVpV2V0UG9WSEM1d2JZWjVBdEJkb0l2Wk5yN1lJQWxNb1J4YzVS?=
 =?utf-8?B?Yzk5ZnhrOXNxUGlFODB1am1acFB4UjVrVXRTS2VvQmVuSHdwdDVjY1MrUHl0?=
 =?utf-8?B?OUJKb2JnSGJNVWJGSXJXbEEyOVpITEhBYllKNmlHSkI3RkUzZjB0TEZrS1Jq?=
 =?utf-8?B?Y2hhRUhHV3JHRHN4ZmlYWFBuRWpVSWlmZVFKUkhBNEUrSG9IKzlZdmJUQThN?=
 =?utf-8?B?M3k3ZUVLaXhZMytIN3VpSGFmbC9vcWg0bjJOQm0zS25QWjJvb2Eyc2VjdVNG?=
 =?utf-8?B?bGY1SnlDcVlwek1YcFcrS28xT0NDeVYwTnVVS1ZxMzgrZ1daczRFRmxSWlhG?=
 =?utf-8?B?WXdXT1NFV2dUbkhMd293cFlhaXNtWTM4S2FxYk1nRldhZFhIc0w1dUo2Q1dq?=
 =?utf-8?B?UzZIak5ZRGRYU3g5anFLWmFJODJrMG1VUzlmZktwc3ExY2czQjlNR3BpeWlS?=
 =?utf-8?B?TVFkbnQyR2ZJa0VMQWx2WW80ZU41cWNrZUsxM3VLT00zTjYrdjF5enMwV3Fl?=
 =?utf-8?B?cjRVcmlQUUplUE5uTHllTTVtei90bnhRN2x3VzNOdkZ2Szltc2dJcTRGT2lH?=
 =?utf-8?B?Y0FBTUtiMnd2V1NQRW5jK2ZjdGZvaWtlZGtnRXN2UlJpSHA3YUFVd3BNRUti?=
 =?utf-8?B?MXIxOG14QTRqRktmZ05XZmdBWWRkSkVmdDdUcEtNVFlOcStkaXljOVUwVllp?=
 =?utf-8?B?VWR4aWRZM0tnMWQrbzhMSktSODBXUGFqbFVkZDEwU1FyQVFhenlMTkFQVGpX?=
 =?utf-8?B?a2NieVFWUlZtdTUwVGFiNDZpZDFJRzdoaUNYQUpoaEZjYWt2TEt6K2JXYmt6?=
 =?utf-8?B?UTVZclNnM1VlNXZ6OWwxRVA4V1JVRmhyZ1NhYzBxUTV1S3BnNXlLOGtpOWhu?=
 =?utf-8?B?YkNobFZWbndkcHhrVXB2Q0dKNU9TZW9QMVRScFcwRlhVQXkxaW9ZRVYrOWY1?=
 =?utf-8?B?TEZCMEJBejV2bVUxRStjUXZTc0V5dm9nWDNHcDV5TFVDWExDSUQ1RTZ0U0ZH?=
 =?utf-8?B?Q0QrNUk3OCszMnlvOTB3bi9aMTBaOG9VT2ZuOGJlajI0UmF4YjBzVEZacHlx?=
 =?utf-8?B?cC83OWxpZUNtNGM4cUlTNjVsSkhmTzFpbGU5SEs1TVFhM21IaDdJUFphL2VS?=
 =?utf-8?B?UUZBZ0J4VVV5Y3JoZjlQWXRJZFQrS0doemNCZzBsaUxKWGlZU0dZdHRMT3B1?=
 =?utf-8?B?SC9LdXNOeWtzZjdSeXRxYThveEk0Q2JHd20zWjIrUmpsYkwzWnBaNlNvSXBz?=
 =?utf-8?B?REN6eWlyZXMwZko3ajZDZFFYTk9JWENWdHlmdGxLUklDOXNKMXE0TlVKbEQ5?=
 =?utf-8?B?bFgyT3FZM3RvZ2l2YmJPajQzVGRKSEVUWjVONWpHNEQvTjhmWVJ5bnBkYTRX?=
 =?utf-8?B?VTBXN1dNRklUWEdWdU9vaS91WllDSVpVK0xPSExuZGtCeEkrbjBIQXMyOWdM?=
 =?utf-8?Q?29ZuoP/myO9TxH9IRiyQLyOCJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a14c1b-9e67-49a0-514b-08dcf1a5ab53
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 07:55:02.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +n+dKHvloveHZBSvF+AKPxlIi4+bLWHuAuu7j6PTJCz5dxxKuhXSE5b1tOHZVOlbbX1BOdBTB+jIJUOSxZLi6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7069
X-OriginatorOrg: intel.com

On 2024/10/17 22:01, Vasant Hegde wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
> If both IOMMU and device supports PASID it will allocate domain.
> Otherwise return error.
> 
> Also modify __iommu_group_alloc_default_domain() to call
> iommu_paging_domain_alloc_flags() with appropriate flag when allocating
> paging domain.
> 
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> [Added __iommu_paging_domain_alloc_flags() and description - Vasant]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/iommu/iommu.c        | 45 +++++++++++++++++++++++++++---------
>   include/uapi/linux/iommufd.h |  6 +++++
>   2 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e13d64ffd14f..107016b3ba3d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -32,6 +32,7 @@
>   #include <trace/events/iommu.h>
>   #include <linux/sched/mm.h>
>   #include <linux/msi.h>
> +#include <uapi/linux/iommufd.h>
>   
>   #include "dma-iommu.h"
>   #include "iommu-priv.h"
> @@ -99,6 +100,9 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   				 struct device *dev);
>   static int __iommu_attach_group(struct iommu_domain *domain,
>   				struct iommu_group *group);
> +static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
> +						       unsigned int type,
> +						       unsigned int flags);

nit:

+static struct iommu_domain *
+__iommu_paging_domain_alloc_flags(struct device *dev, unsigned int type,
+				   unsigned int flags);

>   
>   enum {
>   	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
> @@ -1589,8 +1593,19 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
>   static struct iommu_domain *
>   __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>   {
> +	struct device *dev = iommu_group_first_dev(group);
> +
>   	if (group->default_domain && group->default_domain->type == req_type)
>   		return group->default_domain;
> +
> +	/*
> +	 * When allocating the DMA API domain assume that the driver is going to
> +	 * use PASID and make sure the RID's domain is PASID compatible.
> +	 */
> +	if (req_type & __IOMMU_DOMAIN_PAGING)
> +		return __iommu_paging_domain_alloc_flags(dev, req_type,
> +				dev->iommu->max_pasids ? IOMMU_HWPT_ALLOC_PASID : 0);
> +
>   	return __iommu_group_domain_alloc(group, req_type);
>   }
>   
> @@ -2026,16 +2041,9 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>   
> -/**
> - * iommu_paging_domain_alloc_flags() - Allocate a paging domain
> - * @dev: device for which the domain is allocated
> - * @flags: Bitmap of iommufd_hwpt_alloc_flags
> - *
> - * Allocate a paging domain which will be managed by a kernel driver. Return
> - * allocated domain if successful, or a ERR pointer for failure.
> - */
> -struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> -						     unsigned int flags)
> +static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
> +						       unsigned int type,
> +						       unsigned int flags)
>   {
>   	const struct iommu_ops *ops;
>   	struct iommu_domain *domain;
> @@ -2059,9 +2067,24 @@ struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
>   	if (!domain)
>   		return ERR_PTR(-ENOMEM);
>   
> -	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
> +	iommu_domain_init(domain, type, ops);
>   	return domain;
>   }
> +
> +/**
> + * iommu_paging_domain_alloc_flags() - Allocate a paging domain
> + * @dev: device for which the domain is allocated
> + * @flags: Bitmap of iommufd_hwpt_alloc_flags
> + *
> + * Allocate a paging domain which will be managed by a kernel driver. Return
> + * allocated domain if successful, or a ERR pointer for failure.
> + */
> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> +						     unsigned int flags)
> +{
> +	return __iommu_paging_domain_alloc_flags(dev,
> +					 IOMMU_DOMAIN_UNMANAGED, flags);
> +}
>   EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
>   
>   void iommu_domain_free(struct iommu_domain *domain)
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 72010f71c5e4..d1b07f4d9d32 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>    *                                   enforced on device attachment
>    * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>    *                             valid.
> + * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
> + *                          domain can be attached to any PASID on the device.
> + *                          Any domain attached to the non-PASID part of the
> + *                          device must also be flaged, otherwise attaching a
> + *                          PASID will blocked.
>    */
>   enum iommufd_hwpt_alloc_flags {
>   	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
>   	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
>   	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
> +	IOMMU_HWPT_ALLOC_PASID = 1 << 3,
>   };
>   
>   /**

-- 
Regards,
Yi Liu
