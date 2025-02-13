Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6B35951
	for <iommu@lists.linux.dev>; Thu, 13 Feb 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450916; cv=fail; b=lRQ4EOj4dgXk3yM0g7m5ozZ2fhL/SAGV2E/P1Il3ht1nE1b+qCGA1w5NQYj0RBDcwC/FD4vmM95TVjwgpkxWdee4xMKdaJHHCO3BhudfcYKfmWhqJtDUHVL5PWZjLH8K0NLC8EhCB9KK8uFdZ19R5xjLmV3LymSQIMVR+KXPiNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450916; c=relaxed/simple;
	bh=cPkPpICs0azcMPtpIrp9VywvwV98WEfRHq7CFQHar40=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IXV+OjvgHPFi+haLD3sGK542ySvO4HrQbBhCLNvhe/hO5TotKdR0C6P0J49GlXH2qTM1tWVTMUHY+VL+ZojIU6kqmSj4bdrqF0VviCbr4UlUSxQdiou/W5zoCBZXwUu56pludO9bCpZwrd6TM63h8xHQjTeTtF5XBUqhQQi3VTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBski0FB; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBski0FB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739450915; x=1770986915;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cPkPpICs0azcMPtpIrp9VywvwV98WEfRHq7CFQHar40=;
  b=EBski0FBL0SHAXHOtXHwhH2cPzHv2fTI+kygp4AguFYUvA4z4PYy/+7l
   TYvffOmQfcsdcvyhFw6fDYDDnaiqMe4ILca1/8TBMsMCTpqZLuVvdYJpS
   Q2s7EGeTzRXc8GhlWgTu4foj6W8Vy1rBUCfuooI0G9vSVmKN7mHjbx13F
   seQ79THva33ULcyH0ofUV/cxVjmBOKkiJJ+PV0sQ1srxQrmp6creiVKIo
   fi7/PgTevAcjlRnm5ljkNC3BMs31vkj+jd9cXqdnO3Fpv/DmpX5MLU8yt
   RShVJxp6QctYK2bXWnb3V+zBjKI4OSnCbqrLRMMeEh4EfrEcZtzyrINMc
   A==;
X-CSE-ConnectionGUID: V+Xm8pN8TpieJv/Btc9Zbw==
X-CSE-MsgGUID: 6eSeFJfjT8Ge2XPewQg3+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40181884"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40181884"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:48:34 -0800
X-CSE-ConnectionGUID: QNa34SMoRjeuCciAT07qfQ==
X-CSE-MsgGUID: f5Enu3p8RcqWSJJLNXcePg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113797884"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 04:48:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 04:48:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 04:48:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 04:48:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFzbUU49BMl8fThSTHDvDNxoemigZ3EWIAOx/ftifFl2kBT18UYaVN0/gz0XiKuBQeV5/B6apjiE0Tr7C7zhDs0Mw/szpP20jD+KUMeM/CclMFX6f22PNL41nJ2tPm5aty3HEKrAePv6bDFGkPG1XAHBIAJq05uyobihaWhq5IULbmuPydnnRZUSv55JsgcUzjtTDvqtgy5yqg75ROCO8xflmVJ/UpBFMs/xjFbgN1IVISxOMmexr0mpqJ+8BumqXMiX/vUTlxAGMi12bICa/oLrK8pCowf52TVx9W9js8lokiBH2WLrmPZOrE/2G1i7dMs72LtFg7dVFSrNNx0UcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBUKwAOd7kGj86tfwfVWJFJ/fBBdru1KbreTV+7VL4o=;
 b=tuY0ilcnFoBXdk/nJtPRk/x0NLnkuQj0YBjoYro4iPu+uu29GwWzXOMd7w9WN/8/DXXUREqOweVFVTTP4nKb8b3pirNBbiZ9VgPhSDVHC2OhAKAKrSiyEZwJNMZokHrxrhEazYL2jkGYu+f/90n+lHtaaC3sFLPrsn5q8BwXFH0vrLfTGhNqj5bWp1MDo8wufJxfFGISm187YqsFe1zy/PC5J6Je7FGeC76ChHQs0v55d0wgUOmVhIYegFigszrn92/v+D+Xd9oWvutr1aeZDsYVg5m0mIm+dSJ4+Yl0kgQXwaSq70w4ehNDHlVZSAp16XQ1NHiYR3ficWTFDpYcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6977.namprd11.prod.outlook.com (2603:10b6:510:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 12:48:28 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 12:48:28 +0000
Message-ID: <3fa78ebe-2d68-45c9-904c-2a20d2575681@intel.com>
Date: Thu, 13 Feb 2025 20:53:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	<joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
 <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
 <95ab1ac7-f0a8-4b9d-b88e-72ce0d72ca98@arm.com>
 <deb77d13-5722-49fe-a5a7-8ba6bc370763@intel.com>
 <145b2f93-58b3-4484-b6b5-9216d4d21e1d@arm.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <145b2f93-58b3-4484-b6b5-9216d4d21e1d@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af03a40-82f4-47ee-a01f-08dd4c2cb64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmdYWWV0VHpzdWdVb05NL01uUEY0OEk2WFBRRk5hck1QdFZsVmhUUk1FLy8r?=
 =?utf-8?B?M3o5bGVSakhFRUpEQmtvUXNGTldtTVpScjI4Ny9uSVdVQTlTOWFFcjVSQkR3?=
 =?utf-8?B?TW13T1RDbTFXKzBjNDB1MnZscXJlODNLL2w3dTY4MjJxSllOV1ZDUmU1M00w?=
 =?utf-8?B?YlZRRUFOeVF3WmJDc3dMa2ZPVCtlQ2tYaGR6blRLNFU1bFlGT3cwRkk1TldG?=
 =?utf-8?B?cVJ0VWhBYXp5cmZvaGpkckVKWEpxaElLVHpHMCtmRk9qUGdaRnNGU3g4dnlW?=
 =?utf-8?B?K3p3aXlWeTIzaVRCTFVheHBoZTdialB3VmkzZG02Z0NMOEtCY3F6YWw0T0lm?=
 =?utf-8?B?THBrTXJYRXJhdDJWaFF1ZHlhVnVjOFk5ZU5zSU13cG9zbkE2S0FmaU91Y05k?=
 =?utf-8?B?TmRYRXZjWmxMU3o1S1pQczJ6aEk5eW9ycUVHU1p1TzJzSXJQUktOUkh6ZnVM?=
 =?utf-8?B?elpDbmpJNkhHcHBlTHN1bnBxWE1aVy9NdVNxR1M2QmMzTVZmZDVWM1FtWU5Q?=
 =?utf-8?B?dWIzYUVOdDltemNvYjN2VzBiTS8xK0JJNDlUVFVxUTZNTVNlVjNqeis4dkxi?=
 =?utf-8?B?c0NtWFBFM1pDdnpNYTVUN2RqcTBBQ2lGeVJER0twLy9zbHE0MFVsa2hyZkti?=
 =?utf-8?B?S3FJVm80M0pOUUJkY3o5emg2NEM4a2NJcXR1VVVTbzBiN05CMFdRL0JHM0dZ?=
 =?utf-8?B?anJXY1lZT2FwSzZ4cUtaallDcngzNmxySGRPa0Q4OGduVjk3NjBjQmhKUytY?=
 =?utf-8?B?U1NWREQxZDVKSUtMbzhHTndEUFluY3ErRWNYdGJZT2QxUHRST2kvVzc0dk1V?=
 =?utf-8?B?UjFkQnRsa3BPZzVwTjdFeDVHbnl3SW9JZ1doVXBONFBOMWtIdUpXcE1aYnlH?=
 =?utf-8?B?U1RjekFRVm9JZlA4WTZtdVNTN0dZeXQyZDAzajdmajNtVXhhTEgyL3B3d0xt?=
 =?utf-8?B?REVDMHkzOUhBR2ZyR2JpNExVYmI0UUxsc1RtVXBJODB1Zm9KT1VMWDBCQnFP?=
 =?utf-8?B?NW5TUFVaTWVOMXkzWm5NL2pzcmFQTitJcVlMVHFQY3pEK3dLNDdDY3FqNXg0?=
 =?utf-8?B?Nmx2MktmbjJ0bEdrWmFWZjRnMG9GUFVnNGs0RkY4K3JaLytkckpFcit5UVBi?=
 =?utf-8?B?UGVLM29mZjNPRkZEMm94ck9qR0NoTTdmN0JxYmpaWldya3hLdno5aGJ2b2RL?=
 =?utf-8?B?ZGp2SVNRQnNKOVQyZ1RSMGtmMm1zdnlyWHRGbUFHczU1djZrWWI5QmxLS0ky?=
 =?utf-8?B?R0JoQlY2UDRnd1EvRkZGcUh6aGNnL0d3KzhQemd6ZWcvTll3NTNkVWJHSlN6?=
 =?utf-8?B?NC9teWdKQWFSclk1cDIyck8xQWNYZSt6TFIyYTVWK1JIK0hkamxoTzA4K1NW?=
 =?utf-8?B?cWo4TWtEaDR5aDVnN2ovRWVKckZtU3A1a2tBM0JwM3lKcFhHWVpFNys1M3Yw?=
 =?utf-8?B?MkF6eTBwTkQ4b3pwa0pSUTIwRWk5Rll2aFJ6S0hTWVB0ZWZJQ1pxVmpyRTB2?=
 =?utf-8?B?LzRPdVNnSERqMWxZOUtzeGt6aUZkNEc2Q1pMWVd3anVaUUp6MS9SZkkxYnJv?=
 =?utf-8?B?L0xzWHp4WEQxWnEySmZNZk5ERnhPZHkwSlFham1jR21BckVtcTdhdzJvY0xx?=
 =?utf-8?B?WkoyTThjQTZMM0Zqa1NQVkFROWpsUVZXd3o2SzQ4SXRQcHBVbEYzVGVmYkJR?=
 =?utf-8?B?Uk9rRk9iNml1MHRHdzRTRjhHUzczNFdhaS9BbWhwVHZkUG1CRytHR2NpZ1p0?=
 =?utf-8?B?UHNWMUgweFBkZlRCOXNmeitNVnZweGFIKzJXaDBzK1JIUGFDQ0N2dHRaUmUr?=
 =?utf-8?B?cHlxR21KYU8rQ3YyUjJrQTJxejIyZERESWdkMStlUklyREZzYWtLNVF1MHNx?=
 =?utf-8?Q?4a17tuOLonQIM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm40bkVZTHZMcjRhT2NlOXRHVjRQbFRNVDloTnhkNWFUS3d6OUgzZmVQbW5Y?=
 =?utf-8?B?cUJScyt6OHBMOHVOL3ZRSmgwR3lTM29DcnMwTE9WREs3WVhrMDUrOFNJYnNZ?=
 =?utf-8?B?YmFzRkJqVjQrQ0xtN2hlTENNTzdkTEVDQlkwdG1jbFJVV3hVSDc5QTJWdTZ6?=
 =?utf-8?B?d2VvRzl0THpYMzc5TXJ2UmlpS3Qzbnhkd0FFYmp0SkJidUlJNDNlMnpwNkRv?=
 =?utf-8?B?ZVRDenBpR3ZBQzA5N0luL0tYTGpiYXpNczVrYklmQ1JqVW1lRHNaMjh6ZnFy?=
 =?utf-8?B?NzJqaGxNMm5TQ0g1UndwQmVpTSthOFRpMlhXS1FiRUxWVnpOeDFVNC9qVDZG?=
 =?utf-8?B?eEhBZk9meDREYTd0eXFSM1BsQUIxT0F2NUZIM0R4N2FDc245eGtHVXVrQ3Qv?=
 =?utf-8?B?bXdUS1JXQmV0ditZeGd3ODNIT1EzN1VFaUFSK0o5SHdlcmdNVHNNUGtDd2xt?=
 =?utf-8?B?akpCRy9XNDZzV1l4dGFiZngxMUJnQlc3SWJHM2o4RkpkSnlaaVFJV2orVlZP?=
 =?utf-8?B?L0FaaGZ1YmZmNmhxV0MyUW5qaXU3NmEwV0dtSC81TURzWGRUY3lLM2xrR3Yr?=
 =?utf-8?B?b3UvOFVZZkhMbEd1ZDFraTVxTTYyZzMyRjRiSjQyKzNrSW9MU0hXNDFNV1pX?=
 =?utf-8?B?QythOXNwKzFRRTJTSDc0dkVMNTZQUUI4RVRzRTVJQ2psSHZuSU9aYlVHcC9O?=
 =?utf-8?B?NHhiNDhWTVFrVm9nNHZvZlVBbXJwUlNHSGJWME0yNHBjZ09PN2V6VERHeDZU?=
 =?utf-8?B?YXRNM1p1MXF0UkZTM2M0T2pGR3c1M0dtVmZacUxQSmNKNHZmdElkM1RTUkR4?=
 =?utf-8?B?YTI2RUdlTXc5K0RkMWhXTTAxWTluWlplWFc4Q0QrY3J2aVhvOVNvMkZ5L21T?=
 =?utf-8?B?cmNpcERidU1CZUxuSitOQ0JBbUxRM0QyclM2Nk9hV2NDYVZJNWdHejFzam5T?=
 =?utf-8?B?RFdnNFo4QkdpVm9TdVlSNzYzd1ZPNHlNeTRVbThKc3lubmg4VW8zRWwzb0E2?=
 =?utf-8?B?NXpBVlI3d0FzMWRaTy9DUTFQNmVVTXRENzBlTGtoWVBOc2VWV21QYVg4MStQ?=
 =?utf-8?B?ejlIQk9ySnQvaXhzZFY5dnMvMHAxd0o5ZUJFb2I2blZRZmJHZ28rYUczMkMr?=
 =?utf-8?B?UWlxRHdIL3lOalpuajIwM0FMelJINkZTT0ZZcnFZaFdPMmhFcXZ0MG8rcGZ4?=
 =?utf-8?B?TWxoT01kbWhmT2RSRTZNSm13U0k0U1Q2aFA3bkVqK3BBOGdCNWlScmRSZEdt?=
 =?utf-8?B?ZVJTcnlrQ0ZnZHlkbnhLc01lSnNRQjhwbURLaWZHRGVVSkxNdWJpU3BIZU56?=
 =?utf-8?B?c0pIbmpZTzZLNnJtVzNGc0lrazcvMTRrYkNxYThFRElGSS9SU1k2Nkt2dzNq?=
 =?utf-8?B?aGtxTkduWVhhR0dnNjRTMTNqMllMN1hvK3JKNlBBYy9jZEZQM20rcEx1Qjhp?=
 =?utf-8?B?ekJpYWphYjd0UFV4Z0NZaTU0RFkxZ1JkMXI2a004VzA1SkhqSmNDYk9nUE9m?=
 =?utf-8?B?ZjhSWHZDdThnYzQyMUNKZ29uRmhRcjZmdTlPS21MUit5YjArT1lNMmFBZDVl?=
 =?utf-8?B?TkxSUHIvdEFtL2d1V3hZV3pvcytDb3NVdWlYcTNyMnpYUTMzUWRZakZWNTRK?=
 =?utf-8?B?RTA2bW5rSVdzeDhldmE2OUt0WXFSS0F3c0VEMW5DUStEY3ZvY1l5QkRwMGY1?=
 =?utf-8?B?VGZlTHF5SW9QQ1ZKUTV5eW9mbnFnL3F3MVd3ZmxwSFhaeDVscHk2QkY1d2tL?=
 =?utf-8?B?YVdGcE9wVnFHOHMyRlJQVlI2VDI0NE1KdDZUUTVOZUo4YVlHekxHN1lENDM3?=
 =?utf-8?B?WDBuMmY0dmNvMFNYSS90SG5mc1FsNCtTaDFMcmVOUldXYmFZNEZGNUFJZm5z?=
 =?utf-8?B?TWszeWVXbkZFK2NPaGdRSmlKRkYwM2ZMTWpFWnMvQVZTM0hNT3lZeHMrdjhG?=
 =?utf-8?B?YytZUE9NdU1maTVPYm9RNkFXd1ZiSUtYSTNzbEk1ZzhTc2k5NkNCWjM3bWxJ?=
 =?utf-8?B?cFlsQjVBTFppSHIrb0libzYxUkNQdkVsUnFMU09laXdWSkZoOEJMVER2MCtk?=
 =?utf-8?B?T00vKzNNYXhhRFV3c1F2eldseGhUMXByRUwramQ4dGsyK24vNUEwdVVRaTIr?=
 =?utf-8?Q?P0uBhHtN/8NC6TnwWr55H9W9Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af03a40-82f4-47ee-a01f-08dd4c2cb64d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:48:28.0697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1084RZXWlnw7+OkNTegDi76S4SX5Uk0AHdkfVPh0MUjS2rqW5BPfLqDJ1X7TPByThK2UbS5Rfr0WZ4aQ++XNug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6977
X-OriginatorOrg: intel.com

On 2025/2/13 18:24, Robin Murphy wrote:
> On 2025-02-13 10:10 am, Yi Liu wrote:
>> On 2025/2/12 21:00, Robin Murphy wrote:
>>> On 2025-02-12 7:47 am, Yi Liu wrote:
>>>> On 2024/12/25 15:13, Baolu Lu wrote:
>>>>> On 2024/12/25 12:30, Yi Liu wrote:
>>>>>> On 2024/12/25 09:02, Baolu Lu wrote:
>>>>>>> On 12/24/24 19:35, Yi Liu wrote:
>>>>>>>>> Another related consideration is the support for page faults in 
>>>>>>>>> nested
>>>>>>>>> domains once PASID is available in user space. Would it be 
>>>>>>>>> reasonable to
>>>>>>>>> support page faults for nested domains?
>>>>>>>>
>>>>>>>> yeah, it's good to discuss it.
>>>>>>>>
>>>>>>>>> If so, perhaps it's time to open intel_iommu_domain_alloc_nested() to
>>>>>>>>> support IOMMU_HWPT_FAULT_ID_VALID when PRI is enabled on the device?
>>>>>>>>
>>>>>>>> IMHO, the PRQ support for nested domains requires some more 
>>>>>>>> facility. PRQ
>>>>>>>> can happen at either stage-1 or stage-2, iommu driver may need to tell
>>>>>>>> it and forward to the correct domain (nested domain or parent 
>>>>>>>> domain). Or
>>>>>>>> the stage-2 is always pinned just as the VFIO/iommufd does. Hence, 
>>>>>>>> any PRQ
>>>>>>>> happens under nested translation should be due to stage-1.
>>>>>>>
>>>>>>> The parent domain is currently always pinned and does not yet support
>>>>>>> page faults. Therefore, when a page fault occurs within a nested 
>>>>>>> domain,
>>>>>>> it apparently should be routed to user space...
>>>>>>>
>>>>>>> If we decide to support page faults on the stage-2 domain in the 
>>>>>>> future,
>>>>>>> we will need to figure out the correct destination of each page fault
>>>>>>> and route it accordingly, either to the parent domain or the user space
>>>>>>> nested domain. Hardware assistance would be beneficial, otherwise the
>>>>>>> software may need to traverse the parent domain, which is not
>>>>>>> performance friendly.
>>>>>>
>>>>>> this is my question. Is it still true the parent domain is always pinned
>>>>>> after the below series? If yes, then it's fine to enable IOPF for nested
>>>>>> domain.
>>>>>>
>>>>>> https://lore.kernel.org/linux-iommu/20241015-jag-iopfv8-v4-0- 
>>>>>> b696ca89ba29@kernel.org/
>>>>>
>>>>> Then, perhaps we could enforce this in iommufd for a short-term purpose?
>>>>>
>>>>> When allocating a hwpt in iommufd, we should enforce that the flags
>>>>> IOMMU_HWPT_ALLOC_NEST_PARENT and IOMMU_HWPT_FAULT_ID_VALID cannot be set
>>>>> at the same time.
>>>>
>>>> Let's consult with other vendors. We need this enforcement because we lack
>>>> a straightforward method to distinguish between PRIs in stage-1 and 
>>>> stage-2
>>>> under nested translation. If other vendors share this requirement, it 
>>>> would
>>>> be appropriate to implement this enforcement in IOMMUFD. Otherwise, we may
>>>> check it in intel iommu driver.
>>>>
>>>> @arm and amd folks. :)
>>>
>>> Yup, SMMUv3 is more or less in the same boat - we *could* reasonably 
>>> manage unpinned S2 for non-PCI devices using the stall model where the 
>>> F_TRANSLATION or F_PERMISSION event tells us all we need, but for ATS 
>>> it's the same thing where by the time the fault has taken a round-trip 
>>> through an ATS response and a PRI request, we've lost the details of 
>>> exactly how it faulted (or if the PRI request was sent eagerly without a 
>>> prior translation request, then we simply have no idea at all). Thus the 
>>> prospective mechanism would be to inject a virtual PRI, wait until we 
>>> see the guest issue a matching CMD_PRI_RESP, then sniff the IPA/GPA for 
>>> the given input address out of the guest pagetables to see if there's 
>>> anything to do at S2 as well/instead. Yuck.
>>
>> Thanks for the response, Robin. It seems we're in the same situation. :(
>> Out of curiosity, will the vPRI response provide the IPA/GPA to the
>> hypervisor? If not, the hypervisor will need to derive it from the GVA on
>> its own, possibly requiring software to traverse the guest page table.
> 
> No, the PRI response command only contains a Page Request Group Index, so 
> the hypervisor would then have to look up all the outstanding requests with 
> that index to retrieve their input addresses and then translate them. The 
> SMMU architecture does technically accommodate a hardware-assisted 
> translation feature (ATOS), but it's optional and rarely implemented - 
> certainly Arm's implementations don't - so in reality that is indeed a 
> going to mean software walks as well.

got it. thanks for the explanation.:)

-- 
Regards,
Yi Liu
