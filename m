Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A3170A26
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737353366; cv=fail; b=O+0QGFcwNKCdf2OJlmBRYnc5gf42fnAbjj8KCNQzLboooTn6+rofXtxVA8v5ZuTpqtGp1qO3BwW4tkEa/OdK8bMlsWCsx58xQ5/u4ovMsy6/eZbznFTOxVylYeuTN4PMZ4NK0QW6mPk1fCu+y71wkO1JmIGtqTYsPoB3I0P+DVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737353366; c=relaxed/simple;
	bh=pSGpq6yXV1fk5YjWVP1182KMvpMVhKo8hGul42I4q+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K0Eigw/Wvd0dH4T5Rc2/YTWchFlRMCkrh1Hxjx3Tzm3sIufEjzxRwyw/2mrInLTyYLXyWnrMhKVbuf6cl2TjvAJhDkwWKlHAcV0iQHumnsIIwDQx1SF409o7VeuYbo7Ty7L4KIJQL4vqqAWuxRRVexU2ERSzVXqjAkYFORfYX8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P47l2qvC; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P47l2qvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737353365; x=1768889365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pSGpq6yXV1fk5YjWVP1182KMvpMVhKo8hGul42I4q+A=;
  b=P47l2qvCgCXKQVWbcPz2jKwrohcTdLkRUVOeoEF9OkYvxpaVSZPkbv8V
   5EUmylaWwgC8DiUNJw0hY1eBdtmv5sE6fe/umSowFx0Kc1zP+QugZe125
   BYWi50NzYIh2q8/Y4nSE/5vCihtpqOFYyxDPKRG9zHYxWfXbElPgcQLIy
   JwpOMQd1ZSL3smuN9UDdOweEnXVCBMRYYvdF1ayjyv6RjTLAXqep3/n6l
   6ncWnvx4qyzJbtR7mYD9jIJRa+a30JOGQSZw/tD1k5hB5fJzGzMiHCKQC
   uAVXjB8VgpLkCJP6O9qbnSnLeSo7gqDmfD4ZjxjTrQ/4pjml8AFbS6izx
   w==;
X-CSE-ConnectionGUID: sgnjMiPySDuGA1UHmGeHLg==
X-CSE-MsgGUID: wTV57d7yQKWteMOb7I0OLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="36931426"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="36931426"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 22:09:18 -0800
X-CSE-ConnectionGUID: O9JQqt0rRiegqP2tMXsSXg==
X-CSE-MsgGUID: LyxsxPIwTL+VbrkCiPKlPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111002908"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2025 22:09:17 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 19 Jan 2025 22:09:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 19 Jan 2025 22:09:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 19 Jan 2025 22:09:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=it4Rp4kbcCONYMKziISnf49WiJHr+EC86mGL0G7Tz+w/63dSHwuiom2gFvIph6t/wc2Q72m19yPDTSuGbh3T13rJb/3zJEYatvfUAbZgbMjFXTVvAINGVYt6HRWSF1gavkXGdpv9f1H0bNG2SRckalYa1b1crJE3vBXpOLBgIMhXU1cBmF/eLlc7UMTYlclwcbluCBJLTvJaCnLlPU1yENaVX7QlC19noaCvZXdZtVNhPPPKdEYcyfL/9v948dEfZFd64K0TZ2OyBlKFOxLJZ3RY6eDTEpoOLvUrxk5zoaHj3k9Ge5flAuTHnLAz3KybiGJ2YWpZjl7NzDNRq89/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSGpq6yXV1fk5YjWVP1182KMvpMVhKo8hGul42I4q+A=;
 b=RwuKZEmT4q5wBWStyw9GSOabhYw27tMqOf0q+cgmUa9HcRjZtLZjh/CSDfAvwHw35BvAJBpiLwDid4dulgQ3yDDQL/6aIgu3sw48fnCzPfcu0pOr8t1lipi4u+NRbuLEsSBbzcob4bH4BtijahhMcC0TTDyRvUx5vWZ0s98QUU3K65+KDamAncs7KxETHCzhJUe7TPR66yJdSghXCbfPEWufCjSNs3FaFC/nj+y2dQSyGH77NJkGFxKl6+oYmdHigPZ0NwhPsj/w5JnFX5p44n2j02t7AO100CsPfMbwY8xE3EHqiXYGaITm3Ms5NuisPnTx75cRW7hjvmrGjHm87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8749.namprd11.prod.outlook.com (2603:10b6:610:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 06:08:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 06:08:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rc v4] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Thread-Topic: [PATCH rc v4] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Thread-Index: AQHbaRYveYJZ4GUvMEO/7u4k7dDKFLMfJ6nggAAHvQCAAADskA==
Date: Mon, 20 Jan 2025 06:08:43 +0000
Message-ID: <BN9PR11MB5276EFF7DF03C91D8F92DB2D8CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250117192901.79491-1-nicolinc@nvidia.com>
 <BN9PR11MB5276FEBFFEACE603E45517898CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z43mykycTXADF6KN@nvidia.com>
In-Reply-To: <Z43mykycTXADF6KN@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8749:EE_
x-ms-office365-filtering-correlation-id: 0309bef7-cff1-4e38-cddf-08dd3918e4e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WnZMTlJWMG1vNlNDekZLV01BYVpXN2N4YTBtejYrakZPSXBOS1FWM2NMUElS?=
 =?utf-8?B?dngxVFBMeEFqcHhFYlhBTFgrME0zeFlBeGJ1VmZPYjVRTWFBVDZSMVFxdFN4?=
 =?utf-8?B?eW94UXJSVFNhTWdTYVZ0cE00bjI5MTlxSnAzLzA0M1QvaUdsUnBoRGRNQnpp?=
 =?utf-8?B?MEU3TkdYa0NBYnEwZko5OFFtT00xdVFzU0FKaTNrMi9UcjJkSG9PMnpaQjgv?=
 =?utf-8?B?a1dsekxwdUtDQThWYnFVSTRibnFnL25UNWJ3Y0hwTW1JeWV1bWExSjh3bUpP?=
 =?utf-8?B?VjEySEJVWHBSUnNtQ2t0Y29hN1hIcUsvQmZOcEs1bEl1R3cxS09ZeWJ4cHg2?=
 =?utf-8?B?RG1BaVFOM245TUxQNWNVWmIvM3QySUptOU53MWVMWnRxRCtDTUNoM1dTdytk?=
 =?utf-8?B?QURWUkFSQmdUWGppSm5ZRmVtRElXbUd6U3ZGMjluQXZ3bmtib01iS2V1OFZ5?=
 =?utf-8?B?UkZ4bVI3VzhZOEpVamNMcXgxYTRpTkk5Vk9BTTNHczdZVUwvOXBNem5uOG5z?=
 =?utf-8?B?OXpnM3N1eW9PbWkvVENFQjZPWXFDQmFhZkF2V2lDZnowdGlMZTkrK245a0Fu?=
 =?utf-8?B?WHhIckxHeE1OVjBEdTNuVXFsRHNmdCt4ZkNLNC9QQkxuMGRmbmZUMjB1TkdX?=
 =?utf-8?B?ckhHcG9jYmRhRzRNNWtCTFN5TkpOSDM3dDR1eENtSlFhMG5CVHdjRFJlYW5k?=
 =?utf-8?B?dmJEMGN2azdBRVZ2ZEd4TFRRSWhZWFdWMWJCQTdET3VWb0NleTBOS3BZTEJ5?=
 =?utf-8?B?c2RQNHNRVXNYSkxxL0I3OTErZUQ0NEhhS29BODhiV0pGZU1KdS9XTzR0MlBV?=
 =?utf-8?B?ckdPQUxScFpDeUtvZkhuRVNYb003OUhocVg2NGxiMEtjWFhoUy9CWFp6RUxv?=
 =?utf-8?B?TjBBMTBhdTFabWZ5TzhRNzRWRnowVk9FTUtTVXh2M2E5eU1iOWJwMkZIam9E?=
 =?utf-8?B?dlF4Z1F6eXRzVnJUL3d2WXdpS3loblJMa0lITzZiTzNOL3dJZ3RudEFhSnMw?=
 =?utf-8?B?THM3aysybFlQOVNJWmV2bXpQQmFGSjJOYm9ORFliVTBlWlZ1dTdyUGxKdHRS?=
 =?utf-8?B?QVNwcFB0UHBoZ0JwVVlaK3hIeVhqWHNQV0kxQmJuYnF3a29WeENxTC9Pd2NP?=
 =?utf-8?B?cXJoR1htV2RjS3Y3YVhIbHdjbVN5RWZtd1pEN2tYYndNRmJMSExtbGNzMDI2?=
 =?utf-8?B?M3JHbi9BcENpcjRkOHFzUXFHWUtFWERXMHo1KzREMVkzK0F5S21rMEFWTU5s?=
 =?utf-8?B?aEk1UU03REFabTl3ODE2bjR1RzBKQXVvckxmdjgvaUQzQ3lydS9GRUc2S3Fr?=
 =?utf-8?B?NWppYi9uNkx5cE40ZjlLVjhhUXZ4TzdKZ2xORGVEQ2NqUDdwa0pYVUtMNis2?=
 =?utf-8?B?NkxSd1FNZm5nUUx0akdZNGM4dGVHL1gzQVF5TldkaXRWanlMTEZQRHp3Wktr?=
 =?utf-8?B?QVRTbVNwODh3M3F6azRoOU53eVlDMUo0a0MrVWhYajZWMnF6OC81NlY2bkR0?=
 =?utf-8?B?Z0pQZklPK0xEdGxuNkR3SStVYlBLbWhwZ3V2QTVTZ05aL2tBZHdBc2thN09r?=
 =?utf-8?B?ZUpJdjFkMkEwdURRZDFOMU12OHFHaWFBa0JnRXZTRzl2bGhmdFZsYkZZSzk0?=
 =?utf-8?B?NkdGY2JMMGJJMzQ3bS9wOTJObThxK0ZRVG9NTHpUZXBJQlJJa0hWc2N2M1cx?=
 =?utf-8?B?azVQbUR3S0E2NjVYSmJMNEtkbk8vN2dHZ1ZreVpvdndpczgwLzJPUjUrbndl?=
 =?utf-8?B?V3FBRlo0Yy9sSkxpZ2tmMVp4VDAwNTNZT1ZnYXFoUHpCVzB5N1FCbTAyMjY3?=
 =?utf-8?B?Ni9WVDA4MFlzelk4SmFBRGJEZGw4RDl6azJtek5aeXpJNlFDVU5lcHB1NFl5?=
 =?utf-8?B?KzdCVEM1eDBSbnZVTXFVN1c3ZkJ0dGFCc1FBMjBJR2VFNWZMdnVvYzU3NUFG?=
 =?utf-8?Q?dNIX0tbVTAk9/66UD/m14xQIel1A/spH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NldQZ0Fhc253WDBNWDRwK3dwNnBXWHRRdkZNT1pwS0J0TzdsVDhrQ3paaFg1?=
 =?utf-8?B?dWhPMEt2TTdpY3NxYWRPTUVUQmwxSWV4RGYya3ZpM2RsMVlHTm1KdHJRZnZh?=
 =?utf-8?B?T1NOSjBVeW15UU5JQmhMSW1kKzhGTys2RHRzRkNXR05EbVNxNzNOc0plUzIz?=
 =?utf-8?B?TkRzdHNOZzg3UDZnUWtjZklSYkRkUWpDT3ArNHZMMFhCRnRjS1ZYMnU0b1RY?=
 =?utf-8?B?Z1k4dm5jK2VKQWhRbmYxSHRVOXNoeXBSejRndGxqNEVvUkhPMmw0SVgwdzZD?=
 =?utf-8?B?emhraFlOb1NuSVQyczlXSE9PZ21ST3FNekc4cllCWTNOcEhVWUphZ0s3MVRi?=
 =?utf-8?B?SjRSb1VNdHJjaFE5UG5ZbWNuMEdycXgzMFpwRnRMNWJTWXJ6RUorN3ZKM0Za?=
 =?utf-8?B?Q2UvZ2FVT2FKbnpNUWpkU0piYmg2N1Mydm9oeVBZbi80MmlXSUR6bG9nZndk?=
 =?utf-8?B?cSt6bHB6OWNsRm43MXVsV3FPMVVZaUU1OVNIVkp4TVFiUnVtbDlHTWFFWGxk?=
 =?utf-8?B?ZlprRnIwMGNIcmgzNWFRYkVmMEJmaVA4VmcyaWtMakM1Y1R3OThkSmhlYUpE?=
 =?utf-8?B?VmpwK3hkTlp5b1NYYUVEOHdhYmhlQlJFL3hKQ0hiN3pjRXU4SmNVc2J6Zk44?=
 =?utf-8?B?QmZPS2QrcUZXemtLdWd3YW9BU2JLMHFvVUhYT3Z1dG83dUUxSzJrdVpIT3hJ?=
 =?utf-8?B?UnUwY0gzYVlGQmZudVhtcElWNW5PVG93cDRESlRtTHR5TlZuNFk4ckc4SlFx?=
 =?utf-8?B?TmMwUmFjN1hHVkMwYlphU1h0eVVzb3pYTko5VWhyYWtsb2xZSi9HYldYQ21W?=
 =?utf-8?B?ekY2Y3lhellDWDBqeEFub1psMmp4aHdXVE1QVkVoVHpJWEtNZ0hxQTlkRmx4?=
 =?utf-8?B?VkNXbEpxMC9RRERodkh2a29ScG1NVkVrZm5pUGlzS0FqNUpDaHAyZ05uaE5s?=
 =?utf-8?B?T3cvZHg4VTlTMjNqazNKbDJldXpPcnJoL1JTSXZ0UGZrZ3J1dGRMbktoTnhG?=
 =?utf-8?B?dW1wOGVzb1FXNXQ0WXRzUVNETE4yZHdXNzBQVTh2WkdvajNUV2VHSExDcXU0?=
 =?utf-8?B?WlRwckxmaXVQRnhUYXBkK3cwZEhtVHpja2FseVNrQWhTTzhBQkEzaEZLUnli?=
 =?utf-8?B?TEkzNDZkQ3FmMWZ5WnlFKzh1ZUNMU0paSWhnbUhVN0duWHZLbHMxb2dTY0dj?=
 =?utf-8?B?aEpEMEYvck9ReG94UjFWMmd0ZmdtVFdsUDVZT3ZaWDNZQnVtUGptS204UjZO?=
 =?utf-8?B?QVNBUTZnNlh3b29kN2RiQzJFanJpQm1GYWYrR2I0dGx1Y0NLNXNDVllWRmZm?=
 =?utf-8?B?Wnd2dVpGQ3FOYnkxRENwVmFpcmt0akRVY0RMbEhhWVRibDRvdEJ6eENjclk3?=
 =?utf-8?B?KzFhNlh4NEQwOUpJUnhjaTRIMFAwZTUrZkNEMTBNN1ZDTWt4SjJHK2FrcStP?=
 =?utf-8?B?cnZMTStwWmU2QjJhemRVYkp5SERmZGF0UjBMbE51dW5CMWxpNU83SlRoMkVJ?=
 =?utf-8?B?elBRTEpQcDNXM015QlhKeEZYRFRHSW0zSWRVZ0lOM0M5SGllSExRam9yUXJF?=
 =?utf-8?B?Q3N5VHJFZUNaV2JHTU5ReWVWOFl0WSt6Vy8xaVQ0VW40N0NsUCtYVko1L1Nl?=
 =?utf-8?B?MXU3SnIyK21YWTNzK2MvN2pKN3RVblk5cTZ5a08rc2tqc0N0ZXdZYnp0enYz?=
 =?utf-8?B?YkRWRlVVbVBOaFpzNExJT0Q5bU9LVkMyZjBlclY2azRvKzlpb1NPR2NVNTJG?=
 =?utf-8?B?ZEN2OTVHTng0d3lzM0swY0oyakRoMHlqczVIc05lL1Rnd1lHNVExNkl2a0d0?=
 =?utf-8?B?KzFvQUhaQ1oxMmNJcWdlelQvZnlnaUoyYUY0a0U4STAydWlLWWhXMnB1OHBy?=
 =?utf-8?B?dEovSndRaFAyelNsNXBQMWZPVm1kc1FobE51T0lrSXpoNGRJc3pSak9jTVh6?=
 =?utf-8?B?bHQvYlRTMjhJTzM3M3EvaEthVUp2T01aVmR5MVBKY3JJQUsxdENwMUhjRkZR?=
 =?utf-8?B?ZUFVK2J5NmFoWVRwb0EwUTZGMUQvWHRWZkJjQlRUQjY0OXUwWmdwTEdlcVN0?=
 =?utf-8?B?WWlOaGZMaEVyWmMwT0NxNCt2MEVLam9ueDlWMGFKbkQrTGpTNEpHVm5qa29S?=
 =?utf-8?Q?GXmmpQWBWbd1xB8m5xzbLN50g?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0309bef7-cff1-4e38-cddf-08dd3918e4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 06:08:43.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3dnKIpW9Bfe2pRhcvOpWy6u+RTnZoogqwdWjZxv2Mnm1zxybZPhwmMh0UfVfdpZSRHVfmkpVL2hb8I0SJ8tdoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8749
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgSmFudWFyeSAyMCwgMjAyNSAyOjAyIFBNDQo+IA0KPiBPbiBNb24sIEphbiAyMCwgMjAyNSBh
dCAwNTozNzoxM0FNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPiA+IEZyb206IE5pY29s
aW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBKYW51
YXJ5IDE4LCAyMDI1IDM6MjkgQU0NCj4gPiA+DQo+ID4gPg0KPiA+ID4gTGFzdGx5LCBtb3ZlIHRo
ZSBtdXRleCBjbG9zZXIgdG8gdGhlIHJlc3BvbnNlIGluIHRoZSBmYXVsdCBzdHJ1Y3R1cmUsDQo+
ID4gPiBhbmQgdXBkYXRlIGl0cyBrZG9jIGFjY29yZGluZ2x5Lg0KPiA+DQo+ID4gVGhlbiB0aGlz
IGNvbW1lbnQgaXMgc3RhbGUuDQo+IA0KPiBJdHMgcG9zaXRpb24gImluIHRoZSBmYXVsdCBzdHJ1
Y3R1cmUiIGlzIG1vdmVkIHRob3VnaC4uIDopDQo+IA0KPiA+ID4NCj4gPiA+IC0JLyogVGhlIGxp
c3RzIG9mIG91dHN0YW5kaW5nIGZhdWx0cyBwcm90ZWN0ZWQgYnkgYmVsb3cgbXV0ZXguICovDQo+
ID4gPiAtCXN0cnVjdCBtdXRleCBtdXRleDsNCj4gPiA+ICsJc3BpbmxvY2tfdCBsb2NrOyAvKiBw
cm90ZWN0cyB0aGUgZGVsaXZlciBsaXN0ICovDQo+ID4gPiAgCXN0cnVjdCBsaXN0X2hlYWQgZGVs
aXZlcjsNCj4gPiA+ICsJc3RydWN0IG11dGV4IG11dGV4OyAvKiBzZXJpYWxpemVzIHJlc3BvbnNl
IGZsb3dzICovDQo+ID4gPiAgCXN0cnVjdCB4YXJyYXkgcmVzcG9uc2U7DQo+ID4gPg0KPiA+DQo+
ID4gQW5kIHRoZSBjb21tZW50IGZvciB0aGUgbXV0ZXggc2hvdWxkIGJlIHJlc3RvcmVkLg0KPiAN
Cj4gV2h5PyBJIGZvbGxvd2VkIEJhb2x1J3Mgc3VnZ2VzdGlvbiB0byB1cGRhdGUgdGhhdC4uIFRo
ZSByZXNwb25zZQ0KPiBmbG93cyBhcmUgaW4gZm9wc19yZWFkL2ZvcHNfd3JpdGUvYXV0b19yZXNw
b25zZSwgc28gSSB0aGluayB0aGUNCj4gbmV3IGNvbW1lbnQgcmVtYWlucyBjb3JyZWN0Pw0KPiAN
Cg0KWW91IGFyZSByaWdodC4gTm93IHRoZSBwYXRjaCBrZWVwcyB0aGUgb3JpZ2luYWwgc2NvcGUg
Zm9yIHRoaXMNCm11dGV4IHdoaWNoIG1hZGUgbWUgY29uc2lkZXIgdGhlIGxvY2sgZm9yIGJvdGgg
ZGVsaXZlciBhbmQNCnJlc3BvbnNlIGFnYWluLiBCdXQgdGhlIGFjdHVhbCByZWFzb24gaXMgc3Rp
bGwgZm9yIHJlc3BvbnNlLCBzbw0KcGxlYXNlIGZvcmdldCB0aGlzIGNvbW1lbnQuIPCfmIoNCg==
