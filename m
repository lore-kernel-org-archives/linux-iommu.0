Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0631C8623
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953879; cv=fail; b=H6OQjUrtL7ecd1kSCA8Ie8QYBSZ5n1vKhINqDP4xHXhUPHOL0DP47pWHHD41DaKB7tvUsxFRIbf/WFD/um7upw7hSg+BGIPdQ1W2x45bSXJ1ApmH1wzC4XYTqNQLySqJ/3AAtSKTeu244GzHr37+45kNkmqvN2Ysxx6cYIk47GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953879; c=relaxed/simple;
	bh=arvQ/EMsUs+ZvncbAQODQeZiHIT9aEB0W3NLWbSrdm4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hCGVtZR6WjetueWMHP/nSWAJfKOJSr6Za3RrPVRj6hrYY8UHV5rcAusN4fRI3cNThV7oOYsX1sXd/ebJ1cx1KnvWt8ypDTZD9mh7kXL8hb87psIXnJ9iZzhJ7a3SOT9Wm8+6eZw2a3rN/zttT1i83keSVixvwC7gGXpXJGDJQvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InMiQKEr; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InMiQKEr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741953877; x=1773489877;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=arvQ/EMsUs+ZvncbAQODQeZiHIT9aEB0W3NLWbSrdm4=;
  b=InMiQKErS7U0UKZaCTMDF42eRnVXgWyQA3430Wa6/YTsXinBNF7w7aob
   lqLEXgb55JbS1mGZJaJTrDYK0FmcJE396l9DwObr9g1h14GcRKQ1CsmDL
   XJ+u6DNwGD9KiT2zY+FrML7+4gEu3BY7ytcTksftbbrLhSd741foOK1PI
   ufRwMxvIpcaWtR04ElPGMBuiMZNHg50CSyTwPOTzd/H6ejlBkhygQUoZw
   Q26fNeVIK2yX6FoOyw52k9beASZFLBKhpUS8wpzCU8ovzRTKLJNlFMrr+
   UjptqAIFKeutN4iyi2iSbxAei4rWMxo7Nu93gl/runAXMme7rjToBjgIW
   g==;
X-CSE-ConnectionGUID: Er+SsRhgS6K/fev2oVUihA==
X-CSE-MsgGUID: cfFVv9mLRdGnE8BmqrzDfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60500665"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60500665"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 05:04:36 -0700
X-CSE-ConnectionGUID: nknp9GOfS7KjdV1me96VJw==
X-CSE-MsgGUID: jPy6dJGfQny1TdS1w/G6Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121760920"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 05:04:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 05:04:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 05:04:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 05:04:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HL7DSYQAJoInP3isSfc5/8x5ZxsK9UEx7c6nsCEbnx4bqvxfU9hccx73bDD36Ai7gGyMENuzu10WRLopzCkRWFP6uk3NTwtoCM1dquRY+bgpYyOvBjXFcU19pdHVLayBVk802NOOovO2PgL8/7/HQewWuYK/0RGbfmYhVfzlrJgx8YmwObn86YL7N6DaUjVNZPUzVLSL4o2a1ezwpyZvevT2H8HD8SZzwbsFV2fRR6rlgzySIAnxQvsSwlTumonhE3Cg4FZOtZRrX9glc0/ZQIK+UdarmSJHOiW3VesBzt4lzAIP4lngFHSoHvJzQ2UYHHuDqnzczhw79o+hxvXRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbRQaRXydLIveRZZA2uUEOPLjkk9e4tRUlp6baUMWlE=;
 b=wCE466ThHE1U64HRKUm/97REhH2Hm96IrLcE/iCGnJJxsahula0iTKVRJFOr3KnX+GY+Jw6U3Fg6wWemdq2wm1/0L+t1qHxL4lfnOa4nDnyTg3KrNOf1XiyolbEdioSMNrcfSsLrAwdab9QNBfLwB8rRp+k0OPyDZUh0mEpMdz1s+BMs8mcYXqXRG/zTbcahjDy1dvsqnUFk4VSzUaFNHjDF/T+Admqojz7maYS9fD8nBm2Osq0QUceh7splzP6lOIGlhdzJggQzOCrqDUZa0CY8CLCvxgBYVsTW+DjuyEIX0lCaS8UoUkcrsHKYMbpxgLxqEJPCACJ74t8IjUp7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ2PR11MB7473.namprd11.prod.outlook.com (2603:10b6:a03:4d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 12:04:12 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 12:04:12 +0000
Message-ID: <791efd0e-4e43-446e-b637-1f9ed49d0c32@intel.com>
Date: Fri, 14 Mar 2025 20:09:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <20250303183801.GW5011@ziepe.ca>
 <391a2333-0373-4cd3-a858-349230bc7c90@amd.com>
 <20250304142402.GB5011@ziepe.ca>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250304142402.GB5011@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:802:18::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ2PR11MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b749ab-d2bd-415f-0f83-08dd62f0557b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWVjUTZlRnN0VjJnTEdqL0QxNXFzM0hUQjZBbU45S0ZHNjdIRGNXbzduNE4x?=
 =?utf-8?B?SXRnT1QwTkVLWlFzSWxwTzl6ODJPMEFRT1ViUmVIRDVWQUI4YVhHZTNZY1Fu?=
 =?utf-8?B?OUlmWFJNOW8xa2p0K2xRWHppT01FSUtVVWlPNHJvWTk4dlN4MENESk1rTjRm?=
 =?utf-8?B?Z1hsUEQ4RmlucTZuTUpZaC9ucGJPeWxUSTdSOUJydnJRT3ZDK1kyWGNhd2FR?=
 =?utf-8?B?TGR2d05ZcmNpRXpFZmN0eVpNbmlSWHBudC9YUjBaZU1GcFZKdEpuZW83ZDR5?=
 =?utf-8?B?MStYamN0WWdyY2tDSEo4TjNYN1A2ZXpvbGJUN29rbUQyVmlXV3ZJRDEyOXVy?=
 =?utf-8?B?U0FkUkQ0WGxERHZjSFpvMzUyWnJ2UHRrL1p3UHdjRXJWTkprWXh4QWZyQklX?=
 =?utf-8?B?Q21nN0dyMUtEQ3VwOG45aDdNU0xjNjYzN2d4aHEzNWNnaHRaNWEvQ1I4WWk3?=
 =?utf-8?B?WGFXUFZjc2dTSXNmaEw4K1hYdkpiZXRoQjh4b21Kbk5DZW1UQXpadVFvM3NJ?=
 =?utf-8?B?ZFJYbXJwNzVBZnpSalRHYkkwTFl4YlV1d3lxV0xjdzJ6Z2NadjQyZE5CbUxI?=
 =?utf-8?B?MDhER2JGR0FVWHpxSnh5SnN2dVpmOGtvYXp2VUpqcWJoL1pQVjh4eDI1MXJs?=
 =?utf-8?B?NDVyeWJzZGdjVEhkUjZCMjNiZmV3bEpXdjllaEJicXQxdGE3Wmg0NHRvQkVo?=
 =?utf-8?B?Y3ZiZXdRNmNwSk9vNEVWRHE3ajk1OWFlOGdqaTd2VkcycHVqenNWQWVFRDB2?=
 =?utf-8?B?bExUMllONG9mOER6NXoyNHJqWXFFRXpXMGZRT2N6RVBiZEdGMHVHcGJ3ZXA0?=
 =?utf-8?B?WFUxaFJaK0FzUmFFdFVkRk5Db0NjdlJqWkZjcnhHU2JuM3g5NndadzJVUCt5?=
 =?utf-8?B?VGVvZVdzZ3d5UFNxYzdhVjV5eGluWnR5cmpTdmpUbzRwYlA4MDU0cm5selB2?=
 =?utf-8?B?b2xkdzViL05lWTZmdjY5KzVaVTFOR1ZhZEtJOTFxN1NIY2tHVUEvWjF3WnY5?=
 =?utf-8?B?WmhTSHA2cU1BM2hjVGJxbkRXRVcrSkE2Yk5SeDN5SXVnNXhkWEN0Z1JxWEp3?=
 =?utf-8?B?ZWxLWjFycXJiY2dqRVhwYjFWWWhadll4amNabjEwd1FhWHozeEpndm5HbHNj?=
 =?utf-8?B?L09SL21Jd0J0U2xralBrUHpXQWtjc0h2bUlUcUNjaHBMeml5T0U2NjdjUS95?=
 =?utf-8?B?VThxa3lhVEJnWmdtMGlYMDRROGQrSFVmL3A4eWlmN25XTkpnNXB4UmpyQnpq?=
 =?utf-8?B?OUE1UDRWS0RRakVrV0ltZDBZd2N4Uk5IQWNPcFpUODBBeDg1ZlZxKzl0clZr?=
 =?utf-8?B?cnpLSW5aVlUwMmo3QW1DVkhoU2ZtNXRUS1B6TFJtU3FRWnY3RlRUdVczV3JD?=
 =?utf-8?B?V21tVmlXdnc5TDVpRUNHL2dqZkdNUUo3Rm9ISlR0dktwcHpUOVk5YnpBMGZu?=
 =?utf-8?B?Qk5pZ0hFOVJVMnh0Z244OXJBcUR5WXdPVnhDMlU4WUxYNFZFQ3oyczlxaWV4?=
 =?utf-8?B?NVhsOVYyMGFLT25UN0lEMXlGM0NpUEdXejF4ck53TGkzODZGcWV1cGpGRU1q?=
 =?utf-8?B?RlZjcTBWSlFselY5R3dwb0VDR1daRzR2ek1zTzI3QndqQ0d5bUt6bE9GV25X?=
 =?utf-8?B?ZEFrZEZNbElENU02WEZ0Y05YYW9aL3k5R3Z6SndQU1M5UFUrR1NJdUN1UWVY?=
 =?utf-8?B?YkFRendzcmtsanY3ajVwYkQ0djIxNUFYYmtpWWNuMktwa2ZiZzJrUnNuZEpR?=
 =?utf-8?B?TlhNeHV3VzMxZzc2UXhLRzJqcmdvcnJCZG9IT2tKNG0yVGQrNE9haXlLYWtm?=
 =?utf-8?B?eFJTMnN1NTlpTmYzd2VUQUF3cm0wdjFGcmJtRFNHOTQwc1NkV2JpWkxTb1By?=
 =?utf-8?Q?yUSMGAqx5zFck?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHlZa0p3cVdsTEg0N1pNSXFkSjBOak1KMEFTVG95aExhZ05RdnhMQTRqZ2pT?=
 =?utf-8?B?cXI3U0FkQlBOaFpId2Z5a2s0K0IzR3pjbHVtY0x6UFBNQ3ZuMVU2ZVN1NThW?=
 =?utf-8?B?RzNIeDBZT21FclBIUUpEVnFYS0tobkEyM1JxWXFrUnY2V1FBL0RldFlXWWVU?=
 =?utf-8?B?YlF2OXNWSjdpVmgvSUtDazNQRitrQ3lRVTJoLzhJbnJ5NU1uK2FaUzBWNFQ0?=
 =?utf-8?B?L0lFTnBvT2tlK1BrSUVPSnhBVlZrUFlOYmVzN05GWExJTE01S3VsK2h0Rk9k?=
 =?utf-8?B?Wi9aWVk3SlptdUE4OUhXMVBzZlZ6TGpFRzNZNU5aVmdoVXRsYmFvUVBra2tG?=
 =?utf-8?B?NkJmU1A1dHhEU0FqSU9qbzYydG4wL2R4Q1E1QUZaUzFndFdXTllic2pFV2Qr?=
 =?utf-8?B?RWpYeWVWQmVhdmN4RXJjc0l0TlVhNmVzSzFZeTFVNVRLSkxCRFMzYXVvUFEy?=
 =?utf-8?B?K1lyRThRT3k4dGgxMFlBOHNGOWJwTFJjN21aeEo0bE9WMkpSaDJadERENlM5?=
 =?utf-8?B?OFN4eDNwaGtUOTNrQmdZNEErVEFOdjFWUGd2ZTJaQVphaDFJcEtyREZEVVZT?=
 =?utf-8?B?VFpOdmJuN3BjMDd2d01TUDFwT2NVSXJPNXVsSFRtUEZJZVlNZmtibEd4WEpI?=
 =?utf-8?B?eHh5c3c4Y3FKYndEZURuM1A3QURwOFlaanNrdWp4M0FoRFpvYXNEQnI1K2Nm?=
 =?utf-8?B?Q21obVhUQm9oakdYWWpCUDVLRkJ5cHI5NGV4a3FPU0ROZ2NIenNxSGdHNDEy?=
 =?utf-8?B?NjB5RFpHbFNydEpyaXNtZ2VtcmRKWnVEWjg0RzhSWk1rYTNxVFBMajRuTkFp?=
 =?utf-8?B?TDFKY0RjZitpbUlUSnpoSytYNHJoKzN2eE1qdVV1MkV2aUFJckxVZ3lzS0dp?=
 =?utf-8?B?cUE3SzUwd29rN1dHMlJnSEx5QlpZMEg1U2tFNHJaK2l3QlRnYTc4OUNvcEdq?=
 =?utf-8?B?d1Jkd1FXQy95cHpxZ0JEL1prSStGRUlxREc4SktteUdZWFB5UFFEeGlWTFpC?=
 =?utf-8?B?TGlQWm44aDY4LzJoU0JCcmZhMUxMRmVDOFM2K3VibkRLZ1dGTHpLSUIxMGZI?=
 =?utf-8?B?SWRyUWswRWp1OGUzcTk0dnpnOEI3c1VTZ3hpdDR0VXVUdHNFdWswWUxhQWhB?=
 =?utf-8?B?SkhoVG5QdnJVeVZMWGtLNGlsY1Q3NzlqSGRpV0RSYkhBaUh0Y2g5Z2M1dThn?=
 =?utf-8?B?RCtPK01UdHVRN0dwUUhhT1pxd1dFVWpDaHRUdUFaR2ppZGJQczZIc2pmZ0pi?=
 =?utf-8?B?Uy9wRnhobzNUejZ2eEo4dm55SkNkM1lWU1hBR09jNXdrbkFMVm83RE16eGc3?=
 =?utf-8?B?UkZkNTUwRlNTYW8rR2RFZk1OT1pSdCtHZDhkUExQSHpRa3laSUhibXVZNmh4?=
 =?utf-8?B?TEUreHdsMTRBTlkwOVA5ajhxY01CYm5yVjlvVTNKTUVqNVU2ang5bjFyL2Nh?=
 =?utf-8?B?VzhVTkNHMXZHQVNwd1hZVCtBY05QZW5UcjRYV0Jvd2RFQStaV2VkenZhdGVw?=
 =?utf-8?B?d094VGVacmxwelB1TG8wT2x6d1J2RElNVVVPcG4wN1FDVVVwdGJvQmlpOWJ1?=
 =?utf-8?B?bkxpVWs3b1Z0bnQyb1hURVJBRURJV2k2V3pYRnhGU0hxTW91d3A2SXhqSGh1?=
 =?utf-8?B?TVRFdk5IeExWQ2VmWE1tUFVDRmxOUnY1VHdkTWhtY1FGY3lxWkVYaFZrd1Ay?=
 =?utf-8?B?MkZJb1FMOFJxbEsrMmthNjJwdkhCaGk2UUEyb29YQVpoMEpldGFlb0dYSXBr?=
 =?utf-8?B?NU55ajRJV1kveXhFbWZVbUEwQmFDRldWbmh4MG1SL2lJbzZJSjlKSDB3VUFy?=
 =?utf-8?B?blRldGMzd2tmTFdVNUgrSHY4bTRkbXQ3OEFNVi9vUnJUU1pNOFM2VzNRMFky?=
 =?utf-8?B?QWYxOXg4bFZtUEwwVmVzWEdSOXpPLytBUXhTVXlkNzBORmo0R0NOeFVmOGM1?=
 =?utf-8?B?MW16UjM2RDlWQzdhL3lqbjR4VW9ZSlRCUVArSzZ0NlVDVVdjSDhvYWZEZm8v?=
 =?utf-8?B?aEV1alZuemhDNldRNzAzOFovMHFnV0t5RnlTUUpRMm8zZGNtcU13VW5FcVpz?=
 =?utf-8?B?VE5YVUxPc0xLZGszYmVIRzhlN2hxK2s0NzNieEt2K1FzK2FQcnJGQTcwakJq?=
 =?utf-8?Q?ojCKkaNzfFYmrfGemlJz7dhDY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b749ab-d2bd-415f-0f83-08dd62f0557b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 12:04:12.5631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdoZfy7I73ZR2kBBq18zMugQaxv6jIQU7IvVlVPRIL6j1AZxe0+Q0b/JtYAybtQM2oZL1LBxewJl4gnU6sRzZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7473
X-OriginatorOrg: intel.com

On 2025/3/4 22:24, Jason Gunthorpe wrote:
> On Tue, Mar 04, 2025 at 03:45:54PM +0530, Vasant Hegde wrote:
>>>   never
>>>   always
>>>   paging-only
>>>   secure-always
>>>   secure-paging-only
>>
>> Why not just expose supported modes (No ATS, ATS, Secure ATS) per group and
>> allow admin to select within supported modes?  We may have to add more logic in
>> sysfs store/show code path. But user will know what is supported and what they
>> can pick.
> 
> A sysfs type thing is what I'm thinking
> 
> Just trying to understand what options we should be providing to
> userspace..
> 
> I am sensitive that we'd like to disble ATS for identity modes in many
> common cases and we get that implicitly today.
> 
>> Also sysfs knob needs new domain ops to communicate changes to indivisual
>> driver. Like in store path
>>    - validate the input
>>    - make sure driver is unbond so that its safe to modify the
>>    - New ops to communicate to indivisual driver
>> 	 something like ops->set_ats_mode(dev, mode)
> 
> Yeah this needs to be considered.. I wonder if a flags input to attach
> is the right way to go.

Do we expect this flag to setup the SATS in the underlying iommu driver?
If yes, I doubt if it is proper. My reason as below:

he reason is more for the #4 case you summarized in earlier mails of this
thread. Such HWs need to map the PA in the DPT/HPT table when a given PA is
mapped to IOVA. We may just hook the DPT/HPT map/unmap to the map/unmap of
a paging domain. Hence it's better to determine if the DPT/HPT is desired
per allocation. Otherwise it may requires upper layer to replay the
mapping. e.g. iommufd replay the mappings stored in IOAS->iopt

" 4) TA is an full physical address and the IOMMU validates the full
     physical using some kind of permission structure (ARM calls this
     Device Permission Table)
"

> 
> That would be convenient for how SMMUv3 is structued now as it can just
> switch modes hitlessly with its existing logic. I think all drivers
> should have a similar design.

I think this is more like we have done for the set_dev_pasid op. Now it
supports replacing domain. But as I replied in above, add a flag in the
attach op might not be a good idea.

-- 
Regards,
Yi Liu
