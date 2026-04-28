Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFCF2836A6
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361871; cv=fail; b=id32Ufirc18t5ROfb3LeGCQ3g4IsUPzJ52JL7td4K8ltwmDUJvMYDws2vgY6SP3kWWDP24NV1v1sRxm+ZQyYzoih74r1Ixdd1D+cU9h+M/LRdB2GeA6+2vnXzHi1LcXItJEmdWL9X8FADysE3LjLwk8AIw0pWupGfrorffJqTVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361871; c=relaxed/simple;
	bh=Pan0yI9RTQyrLjPWCtexedz0FehxmpoxXn7hBKMAu34=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a5fuWDUrMF2XsfI4M7RtwTzcop5aU4YCaQiqD8p+bogi3mi4LiPkoF8q3trIkdqWp+6KjDje1kYEYOMENHhtU/cY44AWly5YD7kEuY4TLNpUdoYIwHjZDcwZBkGUw977dWAZnR5vDPLa2LqnDdKnOWPVFnA9r00bR2xehRYxH6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csLzD5Gp; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csLzD5Gp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777361868; x=1808897868;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pan0yI9RTQyrLjPWCtexedz0FehxmpoxXn7hBKMAu34=;
  b=csLzD5GpJf7sanip8Sv9TajVgfKZ5Ntgb6iB5mIef0Y4vEvnqeGKmBNf
   M1BghZWwcf6SBdUMo9lrwuVFDb+4WRSR5lAw5DB9gnfmAFHAY4kEKmqVi
   kvcoSWAdeyoJKSPNVj0zb0HUX0cpOJwLgmjxnZpfPXOCvxpJ5gBAWS3q8
   azE8JuMLUMFvdrtCwonvQJG3YZ2Wg1mIJmfPCV3WdCzKoQD+erdQbO3yp
   RxPdziBGNAIsRSwc0K/Gv0e5TkfapS+NAtru0zpopBM75M5aEoin89PJj
   gHosAxks6B7jolMBQ4v3IoYd0d5XGxAbWInTu2m/qgXrcPKXfmrAJap6U
   g==;
X-CSE-ConnectionGUID: wpLhPotHT4GSsyqMCk94Hg==
X-CSE-MsgGUID: slrM6De7TAWONtTGDBFcAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77966414"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77966414"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:37:48 -0700
X-CSE-ConnectionGUID: bLgBv79lTKWXUfvyN0Ud2Q==
X-CSE-MsgGUID: OoXj9aLDR8avOHz/LfMy9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238860838"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:37:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 00:37:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 00:37:46 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 00:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhG1zycEF5h3WPBfI4AJ401yBYU/c91nGMvG8YUaEdrc6W4V24/2ZzahOn9SA9Ke5kTj/OpMQw/OpVzu8HgY5RIDslZn5xzChObau6hELmkhfHKZFB1bdtq2mP9t+x3MPaYMMhIc9/FBHoOGOcJG5BNMp+/TR30paX/Pv+OF6E5yJWbyR6yHJdRKTFeyM5GG7Qa4uDza+20r5GkWHLntfvRxDNgbxqGx9tEOACv8NwFw/1MUo2TBVQYJKTVGtYx68jAnsxpP6UJmmJqXPHqNmlXONzMjklkB1kuCY6rW7BZMDRrZ2QnRK1lbnyvFHmjWdkOdW7PzwGpebQQhv3BjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFrDNdcBIVwIdpe/wZAQTZQZKAG9hVAHvzoZB1nScd8=;
 b=Y6Qa9P6qgcHTJJbPh6pniPEMo7S/xGnjCJcNeWRVUo3HFsYhdaoJaUNGr0R9t9m+d4aizrqhPGUjoPSULm7PPhEU+qfuK7sUn7jjHnJJGpIGvNGSE5ta/o054TQFG8UOkELEUblPuNUzu8QTUNloUcjpevjdOtuRtmtdNimZuo+B2eKDxXGjDZPpSVF6yVDUM4JinxIgL5IW8tZzU0BxS3qjI+qnn3kBNyBumppGnzGHBTSzXbWq4Ar6Q/vnvXCxauO1/pOvnxPenxO6P43FSbSO6jDxtIFbDJ9zpzl2HKHumIoiR171kXJ2L7HlZO/yVHL2eYIGSIeQuyiqAsSj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ0PR11MB6696.namprd11.prod.outlook.com (2603:10b6:a03:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 07:37:41 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 07:37:41 +0000
Message-ID: <4f0aae4c-2348-4109-bdb9-348613f8ef94@intel.com>
Date: Tue, 28 Apr 2026 15:45:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 02/10] iommufd: Move igroup allocation to a function
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: <skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
	<will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-3-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260414211412.2729-3-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0010.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::19) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ0PR11MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c546f0-e875-48fe-d3cc-08dea4f90783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|42112799006|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: I7ZOMIeU1GC60+7GxqB8WE1WB5n4jN3ctEBtqKIxTqDFb+Gh/OCc8nKpwy1YiyR0aUsKsGDt6n7UTewXi5wURjBGM8ozC9hc//4t9r7A7m1lxBAQOxiYWgDzNYu/qSDAQUdHOI30M9VXVBxcziFpOWx7DkzIYiu2PzurWLT/3W4JuClrkj6jRdpESeGRHUEPSSnM5fZXEZQkfg5UqMCmjtC8gnOs21GjBMNDJPkQfUmfJnsmaXROfQhqwAKNguU1aP5n+nDPxNxzFNj9/kLNgkU3wVnHrjrk7JAho0AWHF6dWcpmktiiUWfNWfX6C3erfUa5VMlI/N2ObbqKJ96SVma97ikp4XItcE5PnJ2GYnzwfjN99gS6HWwXfdddOgLLbR3mHeLV856pIGhvygTS671UtLY/B4ZUtpGtB5cx1pbk/XuJg7rU5wcKhgT4uMGKjRD3RJddEKtmToPEGwF6H8fEZpLUcpwXfxn0AUt3jieSi/6+gjxbK0uQAaDaCbXHOjwMZMR3UqDLdlimOqMt92mpxRY8RmQDAAjNtdF3VcBBJG+h+kbMfpsIcFG3nbw+njb6Zg75jhbGvPZLy3Q+Tp1KEEi9U+4FCQMX7GMdQioFxEn+jggE+aDFckbcp0XOEfRv+aV/jo1/iygxnx8nv/k/DRZisIhvubAuwZCTjAs4V1Pst2Rj62YBG4voEk5zfPLcWjJYlRaVM8+/73ReVzXLvruSgGAqVhgnGKBmRTVCMv/U84qCc9Ev/JES22GXzyLfoZ2foUzcIgDPFDePIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(42112799006)(18002099003)(56012099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlZNXNwNW44RGhnSlhCMThPRU5RdEx3QVFXVUk4K285aStTZTVWRDZnSkFB?=
 =?utf-8?B?aUZ1clF6R081NWdWLzFUSmN5ZkR5ajBzZERGY0VrbHhQcERVU1BFQ0tpZkV3?=
 =?utf-8?B?V3lXbTc5eVR2cnd2dlpFM2YwWUxMV0trcGM3SUpwSTJ0Z1Nyek9Da2kvZDc2?=
 =?utf-8?B?NVVjeDUyd1ZxdW1oVDFTNEpUZklHWXkrQStvSG83UDdkVzFxNGcxSElUK2F1?=
 =?utf-8?B?T1krNU92U2Q2UWRmNGtYaG1nbXhiWTF4OHhVVGNqWTF4aU8wcGk5eXNibzFN?=
 =?utf-8?B?bkE3bzh3cXFDdXlxd3JnT2oyNEllSXgyMzk5STJPdGwxWkV3YWVsM1VpY0hz?=
 =?utf-8?B?VGtHU3hGbi9mWlRiSkxmYnZRT0UxdUFlYi9UYm5xdXY3TjlIeXE2Z2lBL2Vh?=
 =?utf-8?B?UVdJbTVyaTRVRWdPRmhQaTBYQkJlazBqa0puNUwrTmNzU3gvQWlXSDNPYjFk?=
 =?utf-8?B?RGxlSWc0TDhPNjduK2xON2RHMkJzb0dFTE1UdXFxenpHdFlmQnd0Zi9meTln?=
 =?utf-8?B?RUVrWFRrK1NyRE5PMzdQbXFVbG9SaWtBRExiUkxqNG1SU1NlT3RIck5GMm5o?=
 =?utf-8?B?dDlhNWlVODN5NFV0aFNBa2lQdUxGemlxSUFpUTFxdzJQdG5Qc1NwOFFUcmpX?=
 =?utf-8?B?WDFDaVg3eUZ0RVhiWEp6Qk9uaENpWStKbVBVcFlvMGJqTVU3bmFpQ21wejRG?=
 =?utf-8?B?L0ttdjhRMHVCZFVqcDFZYUxJQzF0NmNJOEhqcE5VZkVFZlA2cjVCRVR2NERm?=
 =?utf-8?B?NTZyaXdNaVRzZWVGcGIwcUZKZ282OExZUUJUS2xsT3kwYXRoeGpsNXBxOWpU?=
 =?utf-8?B?NHYrRkxwVi8zUXE0SHFoN291MUErNk9KT1ZodmZCd0hDaTV3NmZSSEtPN1FI?=
 =?utf-8?B?WHFydmpwaG4yZlNKS25xMWZDU05TakNTMS9KMngxRkszQWFPa0tUYWlobDRt?=
 =?utf-8?B?MTgwZDNmQitmc0dkVkhZdkZFWGxNc2xZcTRCVFZBREhkNkVDZEpTbm9PVG5a?=
 =?utf-8?B?MHhzUkFDSk52bm5tZzgydzdtc2EwRTVlMm5wRlpKcjZmWi8zMlJJQVU4WURJ?=
 =?utf-8?B?cmxKK2VUOUs1RXFqWnZiaW9VNWtJeVl5OHYyNUpEZFlnRTNqOHFsRTVRcWJa?=
 =?utf-8?B?bjM5T2hnWml6dmhRQlNSK1BPN0ZNQjJkdnVyYmw0czhXS1VtQ0xNWXp2dHox?=
 =?utf-8?B?Myt3RWJtQVFHZk80Z1JFUjh0N3gxdXlLK0VLd1NhTjR5Vy9JOVI1VEZhM1Bs?=
 =?utf-8?B?TEIxZC9KTG9OZmxUdVBXVm0xakloUitNaG9rZEFlS3NnV2FNZXhmQnVtYzY2?=
 =?utf-8?B?Z3k4Z2VUMUNYY0l0ZjF5TzBXL3NuRitxOVZsNWpZb1hvQVJMd2VITkJOWE5q?=
 =?utf-8?B?MlZBSk9JdC9vK3JJQU5jZGs1OVViOG1GazhDaDc5eHVqZjNsUEZZYTBDSlo0?=
 =?utf-8?B?aEc0OUVRVitobUVHcEFCRTlLMGNwSWR2K2xEK2F2bWgzZGJMckI3ejhOUk1O?=
 =?utf-8?B?djhMRjBuY0RpMjc3aGx1YnV0TzRwRnNDYW11c3N4TWRPR0RQcXJIK1ZERDFZ?=
 =?utf-8?B?bVRVWkNvd1FXL2J0RmJyYlBNayttbnJSaGpLQUtmRXMwY1gwYlBITGVFclRU?=
 =?utf-8?B?dDNMSHZ5em1ieVo0SFpoSnBNM0RFYlZRMGlMZlBzTDkydVlNcVF5QitVOUxz?=
 =?utf-8?B?cC9PZGRXK1hHcUVnb0UxekRzYThRNXFBTHBDVjY0czgyaHhadkhiVXlieGhQ?=
 =?utf-8?B?ZlBvSlFUeGFJYkIzOGoyaXRZOFZqbXRPbmd3MTNkSGFYNit1RUw4REUyeU9u?=
 =?utf-8?B?cjhUbTJka0xBRkF0VXVGaDdIb0YwZ2pPa0wzZk9oN1RNNlFZU2VnY3JFQ2lk?=
 =?utf-8?B?eVRQRzJBeFdjWElWQVAveUJnWXNnNm5BbXhPaGZXSkU3b3YyWVZUSWN5a0do?=
 =?utf-8?B?d1Z6cWhPMUpqN3ZvMWgzUGZBbXJJWHRXaktzNEZsSzNSd054TW03b1AzclpY?=
 =?utf-8?B?ZmZwWFg2WkFkMzNhajZTQVBQaFN5U0U3cGYwSHBTL2c5Wm4zSzRYdWJyb2o1?=
 =?utf-8?B?THVUaDhQdXYvS0VBUVpoMXJjMkl5cnpQcldPbGNlM1hoNEtXVlk1OGR3Snhh?=
 =?utf-8?B?SnZXNmtzdTVsYjhvM1NEQjNzZXNIdXdQWm9VK25lbmJQbEVWanVXbUtDR3Vx?=
 =?utf-8?B?VmtHRHBaYXVyRmJQZVlWR1ZnTThjMEJzNTAvU2tGQVpjbjAzQkpwRWE5MWxI?=
 =?utf-8?B?ZzArSHFtSWVidmFMWGgyL2UrRTFra1N0NG1CTVFzL3FCcTlBaHdZSHRhOS9I?=
 =?utf-8?B?WlFhQXNvRkh4Z1dMMmYzSDZ2NnI3Tm9zYnd3S2RvcGZzU1U0OVJGUT09?=
X-Exchange-RoutingPolicyChecked: GwinkaD8xq9DUBpkEm3/03jQlwZ2NyNg0Ft+7ONQnIlQ8H6oaQ+7pfSLBiB6qZuwUwHOPikJuWHxyCxVeN6W/zV+t2OBPZAq5ZUPQUFRFd8IqkZGssiIpQCCJARNMEDv4mbWyDqlJwX2thTBWBElGXglMzuKSpw8zqtnPxP+L2OHrvE/VczK/h+SByf13GxYvfEGgeGidv6dCV9mrs3g1ftmieXMXh18F2ZxZUAnGdoTgAgvFFjUsRHly/UjgNx5FtqsBOgqQDsCw701UBdFBTZiicID/O37vjwlI326EJT7ZmW+3m0l/IQYMH+Ngh3KYnolUqb3x273sajiAnnX5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c546f0-e875-48fe-d3cc-08dea4f90783
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:37:41.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nq6tdzELido6piTUJrRcBFaYMv9Mr+10wCcX9JPwhqgfSpX8SLPdezly+wV1i+204z8RoGvoUC3Hmss4KbcY9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
X-OriginatorOrg: intel.com

On 4/15/26 05:14, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> So it can be reused in the next patch which allows binding to noiommu
> device.
> 
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> 
> ---
> v3:
>     - Moved null group check out to the next patch (Mostafa)
> ---
>   drivers/iommu/iommufd/device.c | 43 +++++++++++++++++++++-------------
>   1 file changed, 27 insertions(+), 16 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 344d620cdecc..2f30ea069f66 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -56,6 +56,30 @@ static bool iommufd_group_try_get(struct iommufd_group *igroup,
>   	return kref_get_unless_zero(&igroup->ref);
>   }
>   
> +static struct iommufd_group *iommufd_alloc_group(struct iommufd_ctx *ictx,
> +						 struct iommu_group *group)
> +{
> +	struct iommufd_group *new_igroup;
> +
> +	new_igroup = kzalloc(sizeof(*new_igroup), GFP_KERNEL);
> +	if (!new_igroup)
> +		return ERR_PTR(-ENOMEM);
> +
> +	kref_init(&new_igroup->ref);
> +	mutex_init(&new_igroup->lock);
> +	xa_init(&new_igroup->pasid_attach);
> +	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
> +	/* group reference moves into new_igroup */
> +	new_igroup->group = group;
> +
> +	/*
> +	 * The ictx is not additionally refcounted here becase all objects using
> +	 * an igroup must put it before their destroy completes.
> +	 */
> +	new_igroup->ictx = ictx;
> +	return new_igroup;
> +}
> +
>   /*
>    * iommufd needs to store some more data for each iommu_group, we keep a
>    * parallel xarray indexed by iommu_group id to hold this instead of putting it
> @@ -87,25 +111,12 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
>   	}
>   	xa_unlock(&ictx->groups);
>   
> -	new_igroup = kzalloc_obj(*new_igroup);
> -	if (!new_igroup) {
> +	new_igroup = iommufd_alloc_group(ictx, group);
> +	if (IS_ERR(new_igroup)) {
>   		iommu_group_put(group);
> -		return ERR_PTR(-ENOMEM);
> +		return new_igroup;
>   	}
>   
> -	kref_init(&new_igroup->ref);
> -	mutex_init(&new_igroup->lock);
> -	xa_init(&new_igroup->pasid_attach);
> -	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
> -	/* group reference moves into new_igroup */
> -	new_igroup->group = group;
> -
> -	/*
> -	 * The ictx is not additionally refcounted here becase all objects using
> -	 * an igroup must put it before their destroy completes.
> -	 */
> -	new_igroup->ictx = ictx;
> -
>   	/*
>   	 * We dropped the lock so igroup is invalid. NULL is a safe and likely
>   	 * value to assume for the xa_cmpxchg algorithm.

