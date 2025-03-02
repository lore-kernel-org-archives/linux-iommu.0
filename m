Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4ED8821
	for <iommu@lists.linux.dev>; Sun,  2 Mar 2025 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740902773; cv=fail; b=SneP2yA8IPXWwQxIOwo0/E39ylfG7O+iQg2+8CoKzPH0vHITAchDNfLUCH7MCvnJa0rT8kIuOIjty/vCq+QhxFmHAC1KsPmZgGbOs6U7zNjqsT26DqB5/cBVyFcrroGqHwEL3LnSvPR/cTFvkGei3sKjqeJfC/wsMoK1QW+DyCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740902773; c=relaxed/simple;
	bh=CVFXyD2xgse+dy4sBHm8o1AxxqynQcbWhVLsInl2N4E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J/oMtzf30VgzwWjvYjcf2Dnqdn51yB2/zAotawjuTAAbOpp0PyNfwq7ed3V0bdZ7nGq9Z+iUIHOkdundhCIzwNOjeYJ2OiQ05edcg3ThVn0+aM0vBE6f5RFxVAEWpH6nYi3+qBkovviPq89nDWWRI5iHM7sq3NqqFsm5b7rY8Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bup32Foo; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bup32Foo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740902770; x=1772438770;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CVFXyD2xgse+dy4sBHm8o1AxxqynQcbWhVLsInl2N4E=;
  b=bup32Fooyu0TkgGYJCyrMzBIvXcHgrNsVqUcJx0L5azRMlHWEwXZji/0
   hRBhvionfP6p5NfdhhQeFGOU32cOp0EzlDDtKqI91guHLUSyxnCUb1b+R
   XYNfeLLnP9mSp5kLBzIh0hQEMgcN4kk5MLHekypl/XFzTy/1zqjxIlIgM
   97LMTmXF2tfXdHeOU+7ksMBWMftERFN6lPZS+7BpsQYDctuqKuemz6nOY
   zlfcsM1F5JAlVCMwrxjUnfXIJkXEhWYuTHCSNIChlPdeS8uq431vRx2c7
   5+TnjV/O3IKJAkECER1P9jPHfbH/df0nhqrkRzAxaOB5nSAupoyKLXJiu
   A==;
X-CSE-ConnectionGUID: gwhRLicjSFaKB64aNCkObg==
X-CSE-MsgGUID: fWpFtnPgSbCeer3XkUX5pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41488370"
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="41488370"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 00:06:09 -0800
X-CSE-ConnectionGUID: K6RvcSqOSRSWNo37u6an5Q==
X-CSE-MsgGUID: CROTUTkBSOClHAL1WmMBgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="117716874"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 00:06:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 2 Mar 2025 00:06:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 2 Mar 2025 00:06:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 2 Mar 2025 00:06:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/BQo+yTG3s4bYZ61WxALLtzHd/wmW3YKzaEmTE29W6mVMHu2amdUVDz145VjFT7xHh+EnlRhAP1atZLlXxi/mqRPPB+288tGaPewb5MGT7MfwGGwpVzP4oIJqtXey9eJS7qX37wuBnlxe+Rqn5QFEC2JudmWEti5BNM0SOOFkwdodguqWULRKAbIR9RyhDkhf7kbiXKADzbEMZNV/9ZdPlwrkLUVP4k9+u6YkJv8FKu0rBIB/f9ExlEHHxLRo8Nd7+sXJf4JK3itDkWbXMsq4WYT/iYySuMjIel8LpYGdHW3KpWfHdcNJlNg+T35UksEBiM1rcVE5wEyxKL8SNP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apEFYLfcfBK/M2j6GurzHBpgBySQXw6Mywy8QN9MkYw=;
 b=U7RZfDzYVmaH39cUO/+ayFoYBMOumRCB7MMGedQxNs5WQT+HyJbJ20zjzcx2ZmRKzV0TKyrqnTAfEuFVEwHcS9u6aXY/8N/mzM4olCxCOH/xehLG5PJ0ZGlQ8IHzzxb2kGgxdK/saI1PgD9rOFsuyH79ftBq1kRvABpfRlW25bq9OjyyHQZ+Xqg5BTMkvvvS1vu80Czc17fCKKa8prBfqbepC4XWQuhyNnI4yBtB/VfviEFTwcd94peIONrt6IW5BxjeV+g8FnB6QkR3C6AWvhi0VS8xqEc+POHekbrNELuU8/B4QppIYPly3hvGoT1foXIBSCfFLzqQZaTtY20HHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 08:05:24 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.028; Sun, 2 Mar 2025
 08:05:24 +0000
Message-ID: <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
Date: Sun, 2 Mar 2025 16:10:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Vasant Hegde <vasant.hegde@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <825ddadd-6770-46b5-936e-f17988534984@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN6PR11MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a4f7ab-3cc0-45d8-26ab-08dd5960fc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlMxMGVKeWF5OUVhZmM4ZmJha01mVnkvampnSVFGVmY1NWdjTDJkT1RWYTVB?=
 =?utf-8?B?S01rblpIL1dFUUpsZ2ZORU8zMUpONzJJMlpnMUk3YTMzV3Z3RkNDS0ExZG5V?=
 =?utf-8?B?VU9TUE1aK2dXdzhsRXhNZjZPbVpON29pZ3BSaU5hVU5TdTJNQTZLOTZYR0dY?=
 =?utf-8?B?ZWl5TXlySm5DZHczSUFta2lJYnYzOExzMmJJTGhBbnNWYloycG1XSHJoakI3?=
 =?utf-8?B?REhmY3gyZ2ZnOFNDSTNmdkxyWEFvZXMvcVlJOGs3NjRFdHhBcFIwK1k3RjUx?=
 =?utf-8?B?SWZ2d2lxOUMvSkQya1UyYlpjaVZEZjBMOE9sS3N2Y3NUbUh4Z2FrOFJORGM1?=
 =?utf-8?B?azdveVBQaUtiTFNLZ0RGalRUa1pUTG53ai8yTFV6cCswUzJwUGdPTlZpcEtD?=
 =?utf-8?B?UW1YN0JYWDYwL0FUa2ZrYnQyVlloemIxVkxpRThwdEVlTXNtY3NXRWxaNlcx?=
 =?utf-8?B?TXhxUHBubmhCdXlEYXpxQ0FRQ0M5WUdkSkZJMWowY2s3cTlaUjZjMXBscTl0?=
 =?utf-8?B?YWx0V2hiRXFHYVkwV0pISCtPQUZNb0FZbllBeFB4WFgzRGRhQ2hhbUJvaFZS?=
 =?utf-8?B?SU8yREFxSU1NSVFiMHFwNGlNMzZZVkkxOElhUUN2RWNTT1lWbUVrK1Byb0Ja?=
 =?utf-8?B?a0ExaTUyOU1od002UHduU2w2MEZHOURKSm5acE9uMFlXdWNQTUZDc1RLbW1i?=
 =?utf-8?B?MGZ1VHpTOWpTMUlSelgxQUpGeXFqQkZiakQ0a2E0ZTMyNWI5aWNqZEN3K1Z3?=
 =?utf-8?B?a25rbEpkUGVNZ1hPWGkzWVRRSmcwT0lqVmRKVU1Xc3E2UFQ3dmRkMlRIcnRt?=
 =?utf-8?B?bDdOK0tqVWVISjBSZUtXeFJSUnRNdXRBbnkxTFdmQ25BbDlPdlFDQUtka0o5?=
 =?utf-8?B?ZlFId0xTakpCTGpNU1I1YktmYmFwaGs2TzdJQ2FVaDlVUVdwOG9hd3I4bStY?=
 =?utf-8?B?MVhQYVVXcnRPaG9nQ0RzcmFhQ1VOdWF3VzZaVXFIa2RNL1JlYVlDcUV6WVR6?=
 =?utf-8?B?cXFPNzlVZ0dlclJjZnBPZ2ZudU5RaFRLcGFzdDBJZ1FEWko3VHRpZXRDNDRY?=
 =?utf-8?B?WnlWNVZ4NGMyM1pvUXdXZ0kxTnNRRDFPQmxOaFIvVUFBVWlJdG45V05uN3hw?=
 =?utf-8?B?MWMwSlhwZGtwaHQ0SUk3Mi8yY3BweUM4bG1RRDRLVkw4UktrSy9EYlFaWjZZ?=
 =?utf-8?B?Nk9CcUYvTnlpOUZsVUJ1U0dwbFZSeDA3RHFiZVNyUVNrUlNJVjhxM0t4UTg4?=
 =?utf-8?B?M1d4WWRCSE1KOWxvb0cxeTVPVmhRamJHQlE2QzJON2lkcnNIQk5QeEhObUtq?=
 =?utf-8?B?S0ozbWE0V3pvcEI5aXdSM2l2RENpdElSNk8zYkMzb3dQcEJaeTdaQXM5Tk1K?=
 =?utf-8?B?L1FyTXFVc2NvcC9qdXhPVnRSeFlhNlorVzkxc0hPeXBSOUFaL1BiMmtRcUlm?=
 =?utf-8?B?eit3SWJuanZXTHl1YS9DOGlsa3lDcFprMHFFaTFOTkxMaFZFNitSYmwwemR5?=
 =?utf-8?B?TXF0TVE2aHJYYlRKa0xlVGJFdEZxSHhDbituc1FNWnBVYlN4NE9VZ0QrWUlq?=
 =?utf-8?B?VlA1NjQ0c1FJZktiWXdsL2JQUGFlQU5iWGx5Z3c4NjdUVUxKY3UvUldiN3JU?=
 =?utf-8?B?c1J0Y2xmenNVU2cvMElOSVVJd2FVY0RZRjBPc1hHZDc0NStRbGROdGpPUVZD?=
 =?utf-8?B?Z3pEaWtUYjBnbXVXMjVsVFozaGc0ZlVRZWNUU21lcEhJcFBnQlRzelB2Nlhv?=
 =?utf-8?B?aTFuSVNtdHFEZllZNjU4T3l5aUhSYzEzdWU4NWI3cUliMlVlY2k5RjJyU214?=
 =?utf-8?B?bXowVEdiajFEQ0lxUnFvMEprZER0OFppc2E4Z1hMUVdscXk5NWhhM2w1NHB2?=
 =?utf-8?Q?EKQj05LhEErct?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXB5RndNK3NSK0pxOWd1MXlBUzhVUndoUzAvRmVXdWRnQzFyRWhCMkppRXU2?=
 =?utf-8?B?K3FxamthdmgxK0RFUjVQeFMzODlSWWxQZUk4N2dhOHA0a2ZKR1NMdyt0T25j?=
 =?utf-8?B?bk51QzliU1B2aUpnM0xNY29lVjg1SzkxY3JWWU5QQlYxcU84K2lJcUNZMnM5?=
 =?utf-8?B?RXllcENySnR5bE50bGkvOENPZGxmWHYvdmRZNVFmUEVCVFBJOGdQQXNxK3lP?=
 =?utf-8?B?RmU5d1plNWR5QUlVWDhML3BzQ1UySS9tRy9WQ1hTSVpCanNmK2lHSU03blhG?=
 =?utf-8?B?a0kwTktkeEdQbVppVDlZdklFTEJZaEFXTjdnY3ViMGRMMm96d01wOTJrK04z?=
 =?utf-8?B?aXV0bGdlU3RPZDdteVpsRDJhaytTMTlzS0VGcEpNcFY5WFBpVjhweWtzbWZl?=
 =?utf-8?B?VTc0L29SSm15MUFjOUw0dUNRL1FmZ3U4L2J0S2d4YU81djJYamJPSEZLSWJZ?=
 =?utf-8?B?UkNaQkwyUTZaN2s2NHZkZFBDdjlrQnVZcTIzMkVxR0F2dm0xNzRDeVlkTG1P?=
 =?utf-8?B?emgrSkpPZ21nUVhZdy9XMXZWOXlITGplQmNVOW5XS205Vzk4dHJzWWJLeklz?=
 =?utf-8?B?aG9YZDM2TnhpQUQ3L2pzeE5jbE1pa2l5bEJnUmlCSytJK01zWWxUWEYzQVBE?=
 =?utf-8?B?WmFuaUpuL3dzZFRuWXNlMXQ2Q201NitvZU81MFIzMkFlYnAyOW1LL3RYS0Rn?=
 =?utf-8?B?MS94aXk3VEtjTlM0TGwyVGtDSGFyejZiRGZnRTNobWRTaWliTVhSMW1kbmxa?=
 =?utf-8?B?Sk10N3RBNFJad09jVUFDLy9vSGJ5RDNXaFg4QWd5cGFBS1liRXJVanZUamk3?=
 =?utf-8?B?OEdBcS9iWGxTclVINlgwUllCWXdrWEFuUEpyZ2g5ckpxVFBCVExXSHc2QW9U?=
 =?utf-8?B?OHRxTVVKNkdhUzZXTUEyVnVsVlJZVVc1V0FWM2hMZy92cXBqZmlDK2ZwK0Mz?=
 =?utf-8?B?bzA2Z0w3NW5BTi80ckxIdmE4VDJNYW5RdXhKVFJ6ODIrMUpHREgvOG1mWGxD?=
 =?utf-8?B?S3BHMlN1L1JSb2MxYVR4RnlZeWlobGkvYUZUTG1DeXkwaHREUW05VmxHRHow?=
 =?utf-8?B?R2p5SkhHYlZvY2Iwa3JnRFprMWlCR1hoc1ljbnN1R01iOUlzU0M1c1I3alFS?=
 =?utf-8?B?VnJDUzc4VFprU0xZL0dCQ0UzSUdLQktjVEhlelBYS0ZnaHlEaklrTGw5TjZI?=
 =?utf-8?B?WkkvQWNvRWJOR0hmdkVyalBXbnVDS3V4U0oyNWxvTll0Zkdva004bUtBUkE0?=
 =?utf-8?B?S2JNTHFWeldxMVN5UHB0dGxSRVB5akZ2RXMzQ2FHZGtCSnIxSlFDdlVHaGJZ?=
 =?utf-8?B?SjJqWmJnbjA2c1VuTG1RNnA5ZnJWejc1Z0FCcXhQZDZ1eWRidldwT1kvS2ZP?=
 =?utf-8?B?Q3F5SkVRd0Zwbm50d1ZveEU2d3lsMXpMSDZUMXF1ZFh0VnBWdFlzemsyWmJX?=
 =?utf-8?B?c0Z3RGI0UE5LYzZBd2taTW9WQ0NjTndCaU1nSE1kb1Z5KzJXOCtKbHRFMUNK?=
 =?utf-8?B?cUYwb0s3L0R0RFUzUWhtbmJNUkJROEdwaWROWHRMdWoxQlJLV1lXbUticWhl?=
 =?utf-8?B?dHduZHgvVFV2T0M2MThWQ3JkbXJJTWpKaFBrTFl2WWtLTEhxZWR6c0ZKaFRW?=
 =?utf-8?B?R1BSNDR0ak5HR1FHNENDbGRYKzdhTUhVMjlsWEwxVjl1RTQ4Mm0wR0pCQ3dL?=
 =?utf-8?B?cjIvbDZiK2JPYys1c2hWcmRxMkNtQ1Z4VUlOc2NubXdOYU0yQWpoTk00Tkxp?=
 =?utf-8?B?azRjK2NOVDNESEZLWVVSYVJFUE1sVk9ObGZRN1FVT1NhVkhuVXl1VEd5cDNU?=
 =?utf-8?B?eS9sZlFVNU0rL2VrYmdDK0M5UkJadzc5NTNXWDBNQjU3QmpwdUtLZk9CR2VY?=
 =?utf-8?B?OUFLZzVoOXcrM3NjSXcySkpackdBL3Jyb0ZFd0haRW9jcXN0SjdGTmVlUSty?=
 =?utf-8?B?LzBwUnZ5S1hTTlFYRGJlMHhiMytSUDhaeVYrZ0k3QkhIeTQ1NDhlZ29FcGtp?=
 =?utf-8?B?QlFqU2J5R1NRQlFqUk1zRUNUc2hKeCtYVWo1ekI2dUt4U1dMblFyU21Rckhz?=
 =?utf-8?B?cmh0WkV2QUdOT0Y4WUxlNGh3clEraGI0TWlvOHVRNEJYaXM2KytNRExFYVNy?=
 =?utf-8?Q?7+MjhNg8BeYoAIprUFBwnTraT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a4f7ab-3cc0-45d8-26ab-08dd5960fc56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 08:05:24.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42K4+IbQO4GDEX/DjroORB9BYSYtChmv1qXMecVLykRDbqJnJNbQLos1OwNaBep4SLu210Xm5iknRVWsNyMb3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
X-OriginatorOrg: intel.com

On 2025/2/28 16:47, Vasant Hegde wrote:
> Hi Yi,
> 
> 
> On 2/28/2025 2:17 PM, Yi Liu wrote:
>> On 2025/2/28 16:30, Vasant Hegde wrote:
>>> Hi Yi,
>>>
>>>
>>> On 2/28/2025 1:13 PM, Yi Liu wrote:
>>>> On 2025/2/28 14:32, Tian, Kevin wrote:
>>>>>> From: Vasant Hegde <vasant.hegde@amd.com>
>>>>>> Sent: Thursday, February 27, 2025 11:28 PM
>>>>>>
>>>>>> Hi Kevin,
>>>>>>
>>>>>>
>>>>>> On 2/26/2025 12:35 PM, Tian, Kevin wrote:
>>>>>>>> From: Tian, Kevin
>>>>>>>> Sent: Wednesday, February 26, 2025 10:51 AM
>>>>>>>>
>>>>>>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>>>>>>> Sent: Wednesday, February 26, 2025 9:18 AM
>>>>>>>>>
>>>>>>>>> On Wed, Feb 26, 2025 at 01:12:38AM +0000, Tian, Kevin wrote:
>>>>>>>>>> If above understanding is true, my preference is to support a sats flag
>>>>>>>>>> in domain alloc (nested_parent only and PCI/CXL.io only, as the start).
>>>>>> For
>>>>>>>>>> AMD it turns on the sats bit in the DTE. for Intel/ARM the permission
>>>>>>>>>> structure is created and updated according to the map/unmap calls
>>>>>>>>>> on the parent S2.
>>>>>>>>>
>>>>>>>>> They are functionally different things, and have different
>>>>>>>>> requirements on the PCI topologies supported (eg CXL.cache vs no
>>>>>>>>> CXL.cache)
>>>>>>>>>
>>>>>>>>> I think they need to be different flags
>>>>>>>>>
>>>>>>>>
>>>>>>>> Not exactly. They are functionally different but serving the same purpose
>>>>>>>> to the user. From user p.o.v. it's sufficient to have a general flag for
>>>>>>>> sats
>>>>>>>> when allocating a domain. The underlying driver decides whether such
>>>>>>>> flag is supported based on the domain type and the associated device,
>>>>>>>> just like checks on other existing flags.
>>>>>>>>
>>>>>>>
>>>>>>> Chatted with Yi offline. Having untrusted user control a security
>>>>>>> feature doesn't make much sense. Probably what we really require
>>>>>>> is:
>>>>>>>
>>>>>>> - IOMMU core exposes a separate sats knob per probed device,
>>>>>>>      allowing the administrator to manage the sats policy which could
>>>>>>>      be no ats, unsecure ats and secure ats (might be further set per
>>>>>>>      domain type in case the hw doesn't support sats for all types or
>>>>>>>      the driver doesn't support all hw-supported types in one batch).
>>>>>>
>>>>>> When you say "sats knob", you mean sysfs interface?
>>>>>
>>>>> yes
>>>>
>>>> in case this is the direction. This might be a per iommu_group knob. do we
>>>
>>>
>>>> want a default value per some info that can be probed by kernel?
>>>
>>> I prefer kernel probe/setting default values so that we can enforce HW
>>> restrictions (like SNP, untrusted device etc) and then....
>>
>> I got untrusted device. How is SNP probed? Is there any bit for it?
> 
> Yes. There is a IOMMU feature bit. see iommu_snp_enable().

sure.

I'm also thinking about the impact of such a knob. How should we define
this knob. Should we allow it to disable/enable ATS? Especially in runtime.
e.g. if the device is identified to be ATS untrusted by the admin, while
the hw does not support SATS, it seems reasonable to disable ATS for
such device. This might change the driver behavior on ATS enabling. Intel
iommu driver enables ATS as long as it's available in the probe_device()
op. What about AMD and ARM?

On the other hand, we may just define the knob as sats required or not.
This is just a knob to let kernel know if the iommu driver needs to enable
sats or not. While leave the ATS enabling policy unchanged. This means
we need to probe the sats capability of iommu hw before creating the knob
in sysfs.

Any ideas?

-- 
Regards,
Yi Liu
