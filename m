Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392D3E1D16
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287491; cv=fail; b=rfXdvkM18Q/tScDBVkppj8YVILaBYIMAIHK/mr6SFlLJ81Q74qVyXiiwBruJdVQkl0dgMKRR8s0QPkA+SZyImHArXdRZue5aGqS5YtS4R+AUABvtUffSkoUco8a/vGOsDzUMjT/lFAgSEc7fKjldmPEpYh8BkKrHZsvevGncMKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287491; c=relaxed/simple;
	bh=pTLrRVVUVZpsHUOJIs2MvyOeyeW9qY2dDZdptoFXPAQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NTlai5gdLogt7UBFyCHrg3Hmc93119wnqn+rYbKIDxAGfhLDbjcfVglnhkbE7HfC4xT9NhNXFmGpxnT/6djWMzo1gOf4ynH/PuuZxV2kLfgxYTUXFVyBpnqQIdXdALF3OG8LQDysjikFvuA2MEQhvslkwBRcZs8UBLsJszNE4DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeaDmVDW; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeaDmVDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779287490; x=1810823490;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pTLrRVVUVZpsHUOJIs2MvyOeyeW9qY2dDZdptoFXPAQ=;
  b=IeaDmVDWeQoFo0BuyHy7FVeLJb17hZTlDG+GkLWory/mxn6+zhyXPJbg
   YnQLFcH3Zh2XGsEdmK2bsTD/gH6rJ0s708L1ZtPJUTRel+Lv08rhVV09j
   o7+mNSKRAFk/vWxXa0xnjtOr9ybmFwJfiEVru7vmr7KdXKz5uj6VavpBI
   LYcyx+UIbagcmf16dJHYp/Yfr3TejH4cw8JskTTnx1Spi420jkQmMeBEW
   zJIgTlc3kF3mrrsEaZ8yNyE2vX0htl8xjJdfd8v9LLohQfLKPYmCePUDs
   RHHKGBxrqUe8kdUlgLyPyekRbmY9lyFzpG03LdvdwwGCKRhfD7/Al3Dz4
   g==;
X-CSE-ConnectionGUID: tK5Fd1FYQ+SqbX1MiCZvnA==
X-CSE-MsgGUID: enFGbNiOSTe2LUjrgey42Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80169460"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80169460"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 07:31:29 -0700
X-CSE-ConnectionGUID: vUeH2f/dQmyD4xPo3yBtcg==
X-CSE-MsgGUID: t0LyHNWTSKSf8mfoc7v4BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="237594558"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 07:31:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 07:31:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 07:31:28 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 07:31:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2i4bipRrjxbbo4X7JX26OGh7P/r4YxQt8f6agbSXv7ozw305QrhzqirirnVFAQqk+i/fU4/21r6Bqp9Oa3bdSteBpG6zJ8RnfxXwu8honTt/RXuvFcFHVxFgi4QwBqMibGO2EzsPldYVpnIbIvKqMHM3jQACRdQK+JT126CXyV7pZRSe6WLSkIPbR0iEKN+GDvUeJLS4k3DLNacvrSYpb7SEiRag/1GVjWCQ9D1na9fmVrIylyqsQADZXEk5Ugo+oQX/+4/c+l8n1f3XnT4xi5ZX1KrIabUhmdFhXjj79GLFUKmYNNOqo7q6aYRr//Z9TU4ej7M3Ss91ymzz+CpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PT/jP1xBGbE8E+9T/KY6HIcSwJo6i/LGx/1zYCLMALM=;
 b=PkyQlWy3mLNPfnsOozMT8wrJ/ChNS3MP87GAyZJBA7do0dWbBcACQzSSSnv1oKDIWW70V5cGrMUpA+oPNJkD2nHYNXdAVhvePd8H/axMacTJlGoMSbwK0OZXtpioO4viAjPDOIv1EY6Of1YcmH+6yYgtWXf/W82eNVjKf7TfWpNHvRVW+abVHvkTA/uB3j2AmLwKpOn5LOS6PD6R+5SzD0ch2rYkO+IKWurBi4BAWMuyKWml/o3Y1orwHIVzbGeUfJKBkXXi3KYn/QVELV/OXntY9S+LqD5ngnyFHvOadk0ddBJ3CAx3veXb2WJ3bnlwT7KRfG76k/Aa8RY6wq3Hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by LVUPR11MB9592.namprd11.prod.outlook.com (2603:10b6:408:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 20 May
 2026 14:31:25 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 14:31:25 +0000
Message-ID: <41efa1ed-55e4-49b4-a978-6d9c7c95f304@intel.com>
Date: Wed, 20 May 2026 22:39:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	<skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
	<will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-6-jacob.pan@linux.microsoft.com>
 <a0e88436-3bcd-4808-8aa8-86b3ec0c197a@intel.com>
 <20260520142225.GU3602937@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260520142225.GU3602937@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::18) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|LVUPR11MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c520f1a-fcf0-406d-e208-08deb67c78b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|42112799006|366016|376014|7416014|1800799024|11063799006|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: UH7zCACY1yE2m1dttxv/nTBlrdf9iJuNCP4Fyj+rHuQZ9m2DyoGVzY6f9u+zhyaJHyJtxP8ti4tdc1od0Jf4qrdlGYis4m8kcmX5CJUNF72Hd7XqxLudv/MGjFtkirAXjS78xaAtWUbZPHydj2fckPxsxkK8tyka6U+f9P6/ZT54v21dquxxI0sTt6WoSFH4AaPLZYT6p6NYa36PyGrVflo2B2CT/XB/A/+28kHfuyuCTsXgrEkqHtlINQzO4jK/1wH6rcItORE/NFgpDTA00QiHFIrr21NmGqCg9QPuEwyfqQhKL2/jwXqvX3aLyiTO3GCZsp+rbKPoi0lihSkwcLate3dunph0CMSDhXw8QIeRTXy+ToKy1hYF5GaFf4maB95+gqJI6ukEgo/1PbUnXLDQaSQKRPTry8TD1LWIE0bNMVypUIK60nmbsKkqre5w/JrJounqtiGv4Fj9NNiWcbGJS649uTCNYd+Em9nx/wiuE0A01tQELi6mJSonUozvtPdhA1ZAg2C/BL463iEPX0VMYMjB2pxmiArhhBdXVniAen9xQ4En/e4AqHDQ6wl3mWIFHrk2n9zAza0KKql1pp6cZuBsFExrqJRB77gZgRYtSvG83sR9EwZPVuM8/mKVWO2lhj3taGYUhbF3HSCukgZY6L4gHWqEUSW1d7UJNR0Ar+30dMNkwVeqo1Z8vSHH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(366016)(376014)(7416014)(1800799024)(11063799006)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWlxQk94MGhkQkwvV2Yra3FhYXczc25MUkRuemo1cXo0OXFtOHhwT09DZW56?=
 =?utf-8?B?UmNYSXdpNllRclVpM2VKdjFpaDBVR1V3Q1E5cThDWkw1QTJXMFRrQmxrZHpB?=
 =?utf-8?B?NmdUdlFuU2pYbklQbC91OHJYdWhVVXVqTW1OVEcyRmoxdnpRN3hmV21OamJU?=
 =?utf-8?B?YTdOTlk4ekJMUEswTTJ5SVpLS1g0QWVEcXRHb0V6S3FOK05ST1RJeGpLMnFz?=
 =?utf-8?B?bFFFblVEK3FJRWZMUEVqMFp5RVQxa1VCM2Z6QmlOUzI3dS90ZmhVbFBEUjV2?=
 =?utf-8?B?ZnV4NVRJVTRUTDZ4RHhJbmtjVW5aZWNpSlJIZXYyWEJKc1ZRUzNjQUZzUG51?=
 =?utf-8?B?TTY1NGVCZ0RpVlB2MjRNQUkzM01UVDUvS3NyalA1eFFzL1lOcnFkZUV1WE54?=
 =?utf-8?B?b2lLaTZQaHRZOTEyRHYrUE13T210dEZ1dWxHcWFoa0xEam5vQVYvMG9uSDli?=
 =?utf-8?B?cTh3VXFDeDJKcmJGT2hHeUJ1VXpEUXJpd3MxZC9rVUw1enJaYWgvWi9DbEg3?=
 =?utf-8?B?OEVsdGRZWWRIN2dTNGtZcmtJR0Ntc2VwOE5LQU9UaXhkV1VsbmYreGh1ZzIw?=
 =?utf-8?B?elB6YTBQcmI3RlpmUmxxRXh5eTZkMkhIbUxGeW52NlVMUGVUeXVITVM3SVZC?=
 =?utf-8?B?bHRyVzJsV0pyNHoxZmlSeWJxWkxTanNvNEx2TjZwbFpQZTNrRE9OSWNtYXlH?=
 =?utf-8?B?NXpMZUJ5d3l6QndWZHNQTlYwWkFzZS9ZWjg1YjNGbTlFbnFFS3ZBVWVvVlNV?=
 =?utf-8?B?NGVndnJyYy9qNTc1cHhTeVR6SHp4Tk11K0VtVHFqUE54QU4zNXBUN2R5RW5Z?=
 =?utf-8?B?bW9jYWJLN1NReTUyTTNkNTJ6NHU3RnpQd21GcTJZTld5b0tFazZXQXRYV2RW?=
 =?utf-8?B?N3doZ2F2ZGhWSEFPSjJoN1ozVVJEZk1NM3VqcHNDVUZvOUowbjIxLzlkZ1BX?=
 =?utf-8?B?RlV1YkJmM3JZWkx5d1RXZXVneXdNellPOTNQOU5oQjlqdWRZYXBWNlNFSWNF?=
 =?utf-8?B?TDNsZFJQZUNPVTZKTGRqMlpyTEJJanZtWXRzMmhSZ2pBWVNrK0NQbHZDR1Jl?=
 =?utf-8?B?MGpOMUcrR2dDd2FJVkUwZ29SMGUybk9UZWRENjkyb3owQVo5b21OSTVjZ3pW?=
 =?utf-8?B?cDBvK0M0OFFFVndYN3k4dmRjMm9Wb21ZOVBVOU9IcDdIbFJoOS9MS09YVzFN?=
 =?utf-8?B?dVZqZjViZDdXSGZScUhXZ3htellsZkRueUZ2VjRDL1BmSmxmUmQ3b1phRzRD?=
 =?utf-8?B?bUJZR2RjdFprd2oramNtTWxVekN5bWgxU0VudHU3eFM5MUw2SGZPVWtGdWsv?=
 =?utf-8?B?R3dTaDFIcXliLzNrYklPV3dPTm05SXFXU3NKWGdKM3JUU0VuSXRWUzhmdWp5?=
 =?utf-8?B?RmxrYUxqYzVPL0MrVkxqcXJWZUcrbzdZN005YmJNdUdXSXRYSTBmSERqYUYy?=
 =?utf-8?B?QTdvYVd0VUhVWUtJUUVIVk04a1VUTG9BTTBiT2hINDAvQy93Z3lHWXFiWlJZ?=
 =?utf-8?B?SllsUWdkeUoyRDZKWnN1VWt1NEdNZTBQVnU3cExDbFE1K0hpMTZ2ZXlQUzRn?=
 =?utf-8?B?UDYwbUYxZTB0K2lVN1FDc2ZWdlo0dDhwd21FdGhaK0xDTWFTaGRUSEw0SXFi?=
 =?utf-8?B?MEw5Zkwvbm5OU2p3a2FEbDFua3dKZEhEYmRGcGVDNjJieGtoWTRpbVI1eDBk?=
 =?utf-8?B?L0FJb2tXclpNalF3T2MwT3NkOW1qTG4wWldlL2V3ZlBtMXp4ZFVXV1RUK0dP?=
 =?utf-8?B?V015N2F0UzJQOFFtcWhOQURDSzhzR1ZmcW5hLzN5TU82K2xMdU04UmZ0U1pZ?=
 =?utf-8?B?WjFTYjhQeEVyWUoyUXFMN0hoQnl5VHUxdTQxOTdoemlZVENNWC9XK0lzM1g3?=
 =?utf-8?B?eFdRdU02VkFEaS9YTDVFS0pNZ1VTeHRaZDlOdWhtRFFsNEdweG5GbWN0Rk9P?=
 =?utf-8?B?dXB3NTFHQjUxU25UN1Y0OExucmYyNVRncms1SnFzUXN3enZFamdEcnBIT3l1?=
 =?utf-8?B?NWNRcW1OME80a3dyY2xsUFkrNW9wdVRKQjVzTE04djhJcnVPYXlKUU1IVGNP?=
 =?utf-8?B?em9udnZNM3hkTXk5VWNMWDArQmYrRFZXellZTVV4b3JocFZaYUtFaDNQd21P?=
 =?utf-8?B?bkFMN0pFY2ZNUi9Ed3Y1eXF5Q1dkS1NCUENRY21GMTBxOWZDaUlZa3dHYVk4?=
 =?utf-8?B?aW1XdElqbzhqdW1sT29WY1lUYjMvMjB5YXc4SUFWMmd5ckVIWnhDek9vYTM3?=
 =?utf-8?B?UnBUNXBQRUF1R3ZxQzZnbVIzOGRRK3g1VTU1dlBnMTZVck5RRGZhM25GYnIy?=
 =?utf-8?B?VFZRR3VpZVR6SUJJMGFtb3hWOEszbitjeE8vb1VwdzFiSTRWR01HUT09?=
X-Exchange-RoutingPolicyChecked: J3Hku5mw+zKj3bVuiyW0bjXMokugdOKH28dgWPMvp9uUvizo/cxKJTPQGhUHcK2vA663U3PlXhm+6ob+lJXhItBj46wtI8NI4N8G10Ds/xKUh9DhmLLfsDYU7zVuyw3AVCf+/W2TlCMaUxvwCT3hpJD3Ejtj79DpJu7mcuXK8Pf/3TAyKDWwqHZYTpzB4F4p39fu6f0o1hG5rUx2CCBRgOgdbrLswgiWAbeIc9TtrlYCIBK/3DVD5EqlrR3Adz0BJrZEIp2COArFQ1UAeJreoh6+1TagkXbYrZmzTj3s2Exb/hqaqoPMIQhRLcR7fqjh5PnnuEGOZdDbxQTucXKAfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c520f1a-fcf0-406d-e208-08deb67c78b9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:31:25.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnbs4YrSW7w0KR98/jVuqtQSVG1TQGvMt3scrLMvmVTb7bIz0+GiYwisrUmP5PPvqAO6bCwOLNqyV+5kemTgdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9592
X-OriginatorOrg: intel.com

On 5/20/26 22:22, Jason Gunthorpe wrote:
> On Wed, May 20, 2026 at 03:20:15PM +0800, Yi Liu wrote:
> 
>> can this work for normal vfio usage as well? e.g. vfio usages that open
>> devices that have iommu procetction.
> 
> No, it must be blocked we cannot leak physical addresses to userspace.
> 
>> My concern is kernel does not prevent normal vfio usage from invoking
>> this ioctl. If it works for normal vfio usage as well, may just remove
>> the noiommu term from thie name. If not, may be
> 
> This is a bug

got it. After a second look, I got where it gets failed.

+	if (!area->storage_domain ||
+	    area->storage_domain->owner != &iommufd_noiommu_ops) {
+		rc = -EOPNOTSUPP;
+		goto unlock_exit;
+	}

Regards,
Yi Liu
