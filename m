Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BA51CAA7B
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070734; cv=fail; b=SYxjxBzpPwnz2DO4UX9Ic3ah580OhaNpXUhNpHp90eq+BX47SBs5Z/fSVmt8qhMeG+kmHGKf02i67Ev3WZhn5sZmzg7CWyMN0P8M4S0gaWeHjgx0ru76LvpVaNRFpWjRO9aCabfhYJVhB5D/rEBCNRMGPAztJZ0S9m8VUiGUrs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070734; c=relaxed/simple;
	bh=edD9PS9w4EhC2sOYIE+s48r6IanvIL7YVkhw7xGio0A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ux3TRZz1GdrSAg3lw9kSeaK/5Z4D3m+UiuFTC0qnGhxOF/7IJlIOWTdT/jp0oL01usrvL1/c5NxbJJmB1yJ/CZA/ayX94G9wTN1+dYCB+imvjXnVC+nsL1msq/HwxDa3LbJ7gjYiPF8AKa0/x6pWcGTwDhzDdQb/fZzwQXE//mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZJUz0w8; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZJUz0w8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741070732; x=1772606732;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=edD9PS9w4EhC2sOYIE+s48r6IanvIL7YVkhw7xGio0A=;
  b=bZJUz0w80sT1Aqp05y9k5Tbgd6c2HizMw4CIawwzzFSDaE4MfkOjOsVG
   GbZ5aIy8QPXxLWkknf9Uqp2YeJP+8ENFfShSDTW3g+oCfXQL00NInZusD
   glR3BVWeFvL8nhNhmEUvJqORobzK7BRDYgf22rsFkT/DNjHL4pmDJ+yOs
   puDRnWkILUdAkJNFuSGMeY4KQIm/gWqcEW85E3BmxReoM9Ma2nc1sGrcS
   06fKBU4YOionc+6GIjHLKri0bTeNA9vb3NtgyMm2V4kiKSJd1radsvCJK
   CqsBq+xkUrwrzLFRt9m3WuzZSVvtdDz1wYttLU50eENv6FOHNV4IS6KVR
   Q==;
X-CSE-ConnectionGUID: gmIjMoloQOO+jRQj06I90g==
X-CSE-MsgGUID: gV/mCKIxTre3JsGaMffEMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53378352"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53378352"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 22:45:31 -0800
X-CSE-ConnectionGUID: VsvQGCp5QPaYC+XjLGD+yA==
X-CSE-MsgGUID: zpDpZeF5RfeX3JYCCyeJOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123299626"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 22:45:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 22:45:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 22:45:30 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 22:45:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MT5f6FWh/6Nmvwoi6wcMoErU+hA6ucCMQB05dPPl7hmVyRR+3EilJ0P84SCrGDCGPAWWD+OiLBmJQfGn7qK0mDg4JdICcBAN8UHUMfqsTuguGqLH4zU68sol87Hv6hM/8gRwhbewVGN0DuNRmsI7CSe1fwLCkrEQdFbYGK07oa8KEGuvQ1F3Mm6k2vWEt7qS4RdJBEXfGSeMdtcQfduCqQWMZgW+cpbb7ZME4oVIA3L0mrl2n6XGJgkhWsfThMafQOjnK531VzqdpIKBIGZ7OYnvkqfkYMBuvd2rttuI3a9g51XyR7HBC3wlWDO/3qQiGQMKxxyChzL8YuVt9jLWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xCjixvITWRieMJoHLsvtN3S99EUSOkYcxJmUsZJZ4w=;
 b=q5ROhVsKYyxk/fzZgAxoHolCV5xiWwWH0aMakjG53QnfUmIfebDd6AHm/eJVNM6MV7/HHfGJkp16cuzXQBmGoCkTifW14TouI96dlLqwWQEVcdLK1X8jtHcGCnMCrFEY7SzqRPI1BGD3UV+KwKIY3HeNVPUjJD1o/YPhJtlZcL4So8v7buojQZd6wKXP7rRCAJsfil00C3jq4/06VYk9T0f+4jOGTycqSpNJFfn8dp/qGYOa12ZfFFxaBYnp53M23Pogk/eV2pVeUWl7gysot+Jg9pFY1LR3CD1wRn6RVNpMJkr6+v4PfSOo0E05unzSe9QNsWmzQRBDsRBxJChSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV3PR11MB8675.namprd11.prod.outlook.com (2603:10b6:408:219::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Tue, 4 Mar
 2025 06:44:54 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.028; Tue, 4 Mar 2025
 06:44:54 +0000
Message-ID: <2c9ef073-fee5-43c6-8932-a8cae677970e@intel.com>
Date: Tue, 4 Mar 2025 14:50:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Vasant Hegde <vasant.hegde@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
References: <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250303183801.GW5011@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV3PR11MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 375c95fb-2929-4070-837e-08dd5ae81266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU0xMHRWTitnRlByWnk0NnVybms2S3RMc28rSlRnWW80Qy9RRmhoNnl2UW1N?=
 =?utf-8?B?ZDVwTmhYaTVKNVcvMXl0YmVabDZISm9vbERlQlVrbEJGVENCZXJuMmw0c0hR?=
 =?utf-8?B?TUdHSWpRaDIyUVd2SnNTTlpOWk44cmJBR2ZkNDBsM3ZYRHd0TmdPM3ZxSGRh?=
 =?utf-8?B?dHJDZzJsbDhmK1FoMFc1MUwra2FyNG1paXNxYlN1ckFFZCsvUFNNOWtkWmgx?=
 =?utf-8?B?dzVYVEh2bW9oWXFoQjJXM1lBYjNLeTRGdlV6TlZBckJrVGk5ZndFK0l1VmJM?=
 =?utf-8?B?eXY2eEtLR25sRnhTU04zaENNZytqL1d1U0p3ZCs4ZHpOeVJnRGVQZXRkNU1o?=
 =?utf-8?B?dnZJeGFKa2lLQmVlbW1MRGs1Nnc1Tmt5UmNhWWphMDdXdlM0M2xPY1VpY3ls?=
 =?utf-8?B?SXZQdUxDdXhYY2plRmRvVlBtbU5WTDlqR0c3SnNXUUt0b29uL3dWaXJjVE4r?=
 =?utf-8?B?SlB0UUc1OFB6Nlg4bk5IL052emtXWGswWmhtZ1g1b2pIQ3dMYkoxYnlockg1?=
 =?utf-8?B?Z29QaURPdmMxaFNKd08vR2IzYXZvaFhEaSt3WEF2SUszQ0hWeFBPL253a0oz?=
 =?utf-8?B?N2NwRE92U0xYNzdrUjR1SnB6UmUwOVpTWHlqYVlOOVhRNUM2L0MvbExHbnlq?=
 =?utf-8?B?VThNMkl5alJBNGlia1BZdGtNSURYcUdwcEVrUUNWS0I2ZHoyQW9aZ0h5ZmhD?=
 =?utf-8?B?NXVFNVYrVUh0eGFNOFpja3dseVhFSXFpMk81N2VEbElkUjluTEhrMzVxWTAr?=
 =?utf-8?B?MUlySWpmdnliZ0E2ck1RMUxaNGF2VCt3c04yM3BRWjYxTThTR2MrWThDZWhS?=
 =?utf-8?B?ZjVsZjZCcldaYWVaNEg3VUptS0RZaUtNbFlUL2k3aFhyNUNLVFhKcm16eDRu?=
 =?utf-8?B?RU9WOFcxRUtVeTZhQXVyUU5KYmcrVlhmNFJkL1dCWmlUbjY5UndpZU1tUDN6?=
 =?utf-8?B?bGdoV1hjRm0vaGdUUzBpNEVmMHFndmRZZGNpc3NDdjFJL3EvZGNONUR5SHQ5?=
 =?utf-8?B?NG1QRGdnUmJzTEtmR0lhSHNsNmF1bElUN25Ib01XN1ZDZU9IWXZqbUtWZzhQ?=
 =?utf-8?B?bWNSZjJSQTJVY1UwTXBPWGtEbG5qdXpXekFEUk5zMm9HdlQzS1dXSktad3c1?=
 =?utf-8?B?d0lHUnhXWEdoVU5oQnBvZlFXamRqWEdqSUFBL2NyNURpNHo0WDhHanorblIy?=
 =?utf-8?B?Vk5vQ2J4YlJldWZ3VUNhMjdXNnV3S1cza2E4dFBmWWtQaEIxakViZ0tSVmhm?=
 =?utf-8?B?dUlzTjRqZVlpTkUxK3J0MkVIbmtjUmtNVjIxNzlsRGQ1dkFkckVYR205OHdB?=
 =?utf-8?B?akJVR0NIQTZqcGlXRWJQbW5DRG1sbTRCd3IzYm9Ga2RqVU9Fcm5WdDFDcEt3?=
 =?utf-8?B?eGVIbGdkTkUzbUFoaE9oQzdPUDdSbEpTOTluRWZVL1BjdnM1cWlGdWpMR0M2?=
 =?utf-8?B?bTdEYmNFdEUyTEMzQnJoUXlHdGUxdDVyUGpWNkxDVUhpTkpCVHhLUXZ4ejZG?=
 =?utf-8?B?emFvdERYcDJySFlhVWdOazBqNHYvQ1krbWFHNkN3ZHFGakFoSWFTSjd5RmxN?=
 =?utf-8?B?UThraXVIbkQ2V1NPaHRpQXB0R25UK1VaQjVrb0RWV2E2dXpYL1h6Zm5uU1RE?=
 =?utf-8?B?eUxWTURIRlFUdlRSUHVweE9JbWc0Rm9XM0w0RGVrNEs1dWR1TWFmczZWOHB0?=
 =?utf-8?B?OG1WbW05Z3ZUSzNvWlZBRGdGME90UUlCYXI0ckJzM05td3BOVjdJeEsyN1RH?=
 =?utf-8?B?UWV0MldHWmRMYjhWRnhXa05CNDJ2Y2FWeVYwdkVYbVlRanBka3lpc3pnKzhn?=
 =?utf-8?B?TFZMSkc5Nkp0b2xFK0I3MWxFVDVYWmE4YmFjK0YxWGZZcjlKZS9BSytQK3E1?=
 =?utf-8?Q?VTeNZ/7GEsidu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGNsWmtpekxYUTVOcGd0b0hoUUwvNE4xWXM2SlRZMGIwdHJTb1NDSElVVU1o?=
 =?utf-8?B?Mk45Nit3TVJSeVRoWGVETVE4Z1BBd0ZZTWFpVEM3aVZiVjJhTDRYNGJKV3VI?=
 =?utf-8?B?OW96Q1RNSjhzcVhQdHdtL0hsaktlSWRQT1A1ZWtlWVpBN0gyNVdDVHByWFFC?=
 =?utf-8?B?SFpwNnlERkRnT3NpVEZKSmxuajJvY3FDTjdnVHZ2QnB0SkVINCtNSERTQ0Rz?=
 =?utf-8?B?WDhNbDNVZ2F1S3d1Uk02ZnQzZlRpYzlWY1h4dHU1RTZOMU9MVTFtTmtwTWlI?=
 =?utf-8?B?N3oyZzFQVjc5TnFFRENlc1ViMVNONlUwdjJvaHRZUWptRGNGWGZxTlIzeXRt?=
 =?utf-8?B?OFRqVkNBRnRIT3VaRXZ1ZHc3WnFUOE5sbnlZNlhkb0RONHFEWG8xemNtVUhu?=
 =?utf-8?B?UlV1SXdrMGp6MUVkVnNkenM3VFhhajVyQ09xZmVhc0xJVlJvQURDZit4NGZj?=
 =?utf-8?B?UVNuajlmRmRUam10bGNVeUhKN2dIa0xjWlcrOUFSUnVqMG5INFk0TFg0Vi9T?=
 =?utf-8?B?QjJCMjZTbUdna0dZbkViMG5vVTI0RkdlM1Q4bEVrdm11MmtBOUVSQ05lMUtw?=
 =?utf-8?B?TTNQNkFZZXl5TGROY3hrZnBwSTA2dktJS2NaTXdVcXBnYW45ckJMeWhsT2lu?=
 =?utf-8?B?MGo5MGI5SHkxZzM4YjloQjdFZ3YxNVpLT2pFZnpGN0pSQ2MwbzlzRjdFbnFK?=
 =?utf-8?B?YTkzb1dsdGVBMnRzbmM1Yk8yMWR5M01xYXB0ZzZMUlNYSzVrVGdiS3NQcW1J?=
 =?utf-8?B?QURXZEFyL2VEaWlJUi9rakQwOU9CM2xFb0lGQkZrTkZMRjFiSDZ4WS9ZRVo4?=
 =?utf-8?B?cVd3TWRMVFU4SFduVXdwc0J4N0FLdVB3TllsSHRTdXFDekZ6MkVzZ3dsc2Nq?=
 =?utf-8?B?NGpNTGR6eTlIbVliN0pvdUMrQU1qRHJKRUJUM1RSWVRKYUhOVU9UeGRLMTBm?=
 =?utf-8?B?d1M3eDAvNjl0N1p2VlBFbkxIU2d4dldkS2dSRjY3RmdTUlNrVGs3QlVOd1pE?=
 =?utf-8?B?OVZRQk5NZjB3eEw0ZFc0SlU5a2lSd0h5ZmdiN1RmQW5FZENxU3NPYTEwNklC?=
 =?utf-8?B?Z3BUZFdyVEpxNGlyeVdnQ2RiWFNTQnhWQ1RkUkFob0Jycmh5K0o1TC9qV05F?=
 =?utf-8?B?M2JGYXdBSk1JR08wdHIrT0FDa0oyVDZ3N0lCMlhLQVpmYVZjN1hpRTZ1YzhM?=
 =?utf-8?B?WHFaNC9nWXBXOHlJd2V5Zmo1WmdBbXRVd05Oa3RWbERYTlYzZitIWTlEM3Bh?=
 =?utf-8?B?SG45MlZjV2lSRlNpcEp1LzBrdVZlZndXcU1KWWF3a1AwWHgwSTlOeGJqSzBV?=
 =?utf-8?B?VnNYV2dtZU9hRThSYjRtQldodG1ZVjIzYmpNMG8ybVYvc3ZjRktYcjQ4YnJC?=
 =?utf-8?B?MnFoKzhsMVltYTlTVWpPczAxbkVrSnN4TnRrL0QwdkFGbU5lcWZxUVhSZWZP?=
 =?utf-8?B?ZDBvSy9rVWhaRzBCV1F5SkFTNnVpQjd3Yyt5TVFQSGdKRkdjdzVScmFtZ1pS?=
 =?utf-8?B?K0dZb3ltbndEUVZzMHlYZjFTWXk1YnJTcU9xbmpzSTkxakUxT0xuNHNyUXEy?=
 =?utf-8?B?WDk4dFg3MmhEWGFaNUZUMmF4L2NJL0NOUjM4S0NPa3VTc01nNTc0ZFRJUkI1?=
 =?utf-8?B?RTY4ZDVJbHMvRjZXY01IL0hWY2tBVmpEcE1CVjR3NlZ4R01yWmY0bGpFKzBZ?=
 =?utf-8?B?cUUwWnNWVjRTc2UzNlB6dk9OZVFwcm9Tb2VrQ2FRT1FicmtWUjR4VTgyYWhO?=
 =?utf-8?B?ell0RVY3YkR3blRqOEVQQ2lwVGJ2bS8vYlVnTEZJUC8zOTE1cGRhaUU2Tkp3?=
 =?utf-8?B?ZUh0T1AwRjM1VTE0REtSS2d3OUh3Y1Q5YVNiOUo2R3VxdEdSZHRlY2FubEU3?=
 =?utf-8?B?YTBRaHpLQUJRVnVSdVZaQ1dKZXljc3VvUU5Tdk9lUng1ajlTZi9jK3paNkI2?=
 =?utf-8?B?Yzhod1pvV3UramNwT1JxYjFVMUY5SVFUS3J6aEs2bWRseml1bjlWaTdKN003?=
 =?utf-8?B?MER1eExaWVBQN0NpNDE0RysrdUg4c3VqYks3NUNSemV1enJGY0lXdUdzWnRZ?=
 =?utf-8?B?KzZFLzFoYVFCZ2UyQzdBZUErMTVKa0VDYjN6V1NuY1JSUm9VdXovSHRqZUpC?=
 =?utf-8?Q?1pNfzPayrqU6q6iDvDXtNQ073?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 375c95fb-2929-4070-837e-08dd5ae81266
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 06:44:54.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEvJtF6TAq/QiQTtf5tuFpqb77UueJMlY65IZX4DZVpSJwQS8uR20gQG+pDVmJGPiE2N/zyRgqcO6HwC7A3mkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8675
X-OriginatorOrg: intel.com

On 2025/3/4 02:38, Jason Gunthorpe wrote:
> On Sun, Mar 02, 2025 at 04:10:46PM +0800, Yi Liu wrote:
>> I'm also thinking about the impact of such a knob. How should we define
>> this knob. Should we allow it to disable/enable ATS? Especially in runtime.
>> e.g. if the device is identified to be ATS untrusted by the admin, while
>> the hw does not support SATS, it seems reasonable to disable ATS for
>> such device. This might change the driver behavior on ATS enabling. Intel
>> iommu driver enables ATS as long as it's available in the probe_device()
>> op. What about AMD and ARM?

sorry, a revise. Existing intel iommu driver enables ATS in the time of
domain attach. While Baolu has the below series [1] to move it to
probe_device().

[1] 
https://lore.kernel.org/linux-iommu/20250224051627.2956304-5-baolu.lu@linux.intel.com/

> ARM enables ATS when a PAGING translation is set on the RID or any
> PASID is used. Otherwise it is off, eg for RID = IDENTITY
> 
> This seems like a reasonable thing to do to me..

will it affect Baolu's above refactoring [1]? :(

>> On the other hand, we may just define the knob as sats required or not.
>> This is just a knob to let kernel know if the iommu driver needs to enable
>> sats or not. While leave the ATS enabling policy unchanged. This means
>> we need to probe the sats capability of iommu hw before creating the knob
>> in sysfs.
> 
> If we add some ATS control knob then maybe it should be able to
> disable/enable normal ATS as well?
> 
>   never
>   always
>   paging-only

this can be considered policy to the existing ATS. curious, why paging
domain is special here?

>   secure-always
>   secure-paging-only

and this is the policy of secure ATS.

A general question. Can admin op the knob if the device has been attached
to any domain?

-- 
Regards,
Yi Liu
