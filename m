Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB101990C3
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730178550; cv=fail; b=LKP/5SWqimIqnxUiam2b50HHeJ1FoEk9rqs48yjmNZ/dnvbUiRI877rd8rLkM10uNbkqnNUWlu7XZfO32fA8BQLvftU5IopYSV6dotzcU47MCPxMltyF3ODF6oSOVWf8E1s9Ytdzihz7+p2IG4v1G8Q1ywhFS44p/gKn/02IRDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730178550; c=relaxed/simple;
	bh=fF6uLpox9UgljFDDB3nHWL4b+Ik1rHqSME/dfhRx7RQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GXQRtbTKwVhmLheLSNIXu0UZwuWOWhWWi7+gavytHc4esAUPwh1vVhn44i4pO29afm/BP0qiRxgKtGRaXjDYmNvAYv9e0Fx+RE7djoIEr5V6cyBy15wdQA8LHHAuz0xBkhi7EzBkw7qKDjlzSnpdydXWUCHyNO57oA2nNlhCt6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVVv58Ea; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVVv58Ea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730178548; x=1761714548;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fF6uLpox9UgljFDDB3nHWL4b+Ik1rHqSME/dfhRx7RQ=;
  b=KVVv58Ea+1rYYU/8j///i7pdKj69T7o2ZlJcCnD8WGiazKhm5iehgQow
   WgT91SA5AhQv8PlrbChI6iyJMtM3Y/JW48Fr/n1tIYfECdf6dxpK3eNjG
   8CQwlOdR12Rk8dsraXAGTGpdpZaH05M7KCDJ7hMyesnJ4X1tlaw40CUq0
   AUZAZthFRxlDSs2biyR9qBZzco2+3UkbhHV75dBTyh1uEfdFqKHsSnbA+
   YqrhvMKbgu26BgU5NO70VJwDTPdZZIyjfIZwpeTaSwlneV6PGp3MgxIy9
   HBrT2QmH3qDbf+L0dwVuNear9yy+SK3cMHD3+NAVPMNut/7dYMO/iMwds
   g==;
X-CSE-ConnectionGUID: 06opY9gyQOy52hrYDfXbrA==
X-CSE-MsgGUID: 7utH1H+ATxyZ7KgIafJsVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33498071"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33498071"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 22:09:07 -0700
X-CSE-ConnectionGUID: KgeAaW13Q6+z8It7yawXHw==
X-CSE-MsgGUID: ATVlxhjnQeWXzf28IqD9LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86612631"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 22:09:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 22:09:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 22:09:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 22:09:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7AjfS02Tgmfvzmh9Ix4P+bA20L4TNB1+cNoPIapOdHpIrIt+jObbUkAWZg8jJPSR+rzUVBLlF0DzN6UPPjpl7QRs1aDPwxYvaqEYFQ2wLMGfo5aWK/AoFfIzGNF65K/8fmeoUfxCwzG65Z6XIyHHrZrFAcqF1z7naZW0loul0Y6cPzopnFSARQJ6feExoYEB1pIqPWn/zM1PiA68KqNev6r0bpmNxYP+PCllZigytfPfk/7NwjRehSjJuxo/G/7K5yOD7wV/MNGwx+oluGb4V53gH4UxPawcxFLFLkJmRnP+MRGS/JK1/wsA22fsfLCZH/t+TJjBxU2XI0W8EZ31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNDY3Avukn6EO5oNCxEBxxz3EJ9qM/agLhu0AqHdFl8=;
 b=ZAoao8M6PT8sVUhkIP+CdcB0X40TMK17PGHa7pt4WGZc81XV1b3y9TjRyy54P15kwpScuxHqBlryHpzMwUJXHtrcjJCHn/6WhIbW/ngyOyldUW7HusmK2T1FdQ6bT9IJ5S6PLADKc2wvQycuHbRZYVydkIgF/nYy1OSFzBLvmGfs5OSC67Xi0IcgYSIYeeGuFobcZQM2ebLgkpt9US0Z+TubUwNFzPjcXuQIrk+UOOQNl5i8Vy+qYUMG9uFR67Yf1VjNyafa3xscig8AZqQ2dvCIrTtNl7IL+CKtg+2RFRfO9OdZ4CYkHKbxjdcqKQFIuGAtNrlNFCvLMWA4ya0kVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 05:09:04 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 05:09:04 +0000
Message-ID: <91d59b7d-58b0-4da2-af59-18a980273bb4@intel.com>
Date: Tue, 29 Oct 2024 13:13:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
To: Baolu Lu <baolu.lu@linux.intel.com>, Joel Granados
	<joel.granados@kernel.org>
CC: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Klaus Jensen
	<its@irrelevant.dk>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	Klaus Jensen <k.jensen@samsung.com>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
 <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
 <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
 <ujexsgcpvcjux2ugfes6mzjxl53j3icarfbu25imhzliqskyv6@l7f42nv4fhmy>
 <bbd95589-f4c9-4dcf-939b-c3c407eeed21@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <bbd95589-f4c9-4dcf-939b-c3c407eeed21@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7e9efb-b70b-4719-f784-08dcf7d7cebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTlLTEVzUnhpTlNtamNHTm9USW1hUGRVZlR6L2JXR1FDVitabmZnVVhGTjVu?=
 =?utf-8?B?SnVMdVhUa2k2L25KVzA1L0ZXcC9ic1l0OER4cFJaNEFWN2FGRWxvWTlNQTBx?=
 =?utf-8?B?SDEybFZoNWxGSzJKR2IzZW9rSGlVUzVqcFpldnptZzZRVjQ4VlQ1MFd3ZzNn?=
 =?utf-8?B?VFk5WmF5TE0rMkpBVXE2NkR2amFFMEMzYnNCVEJCNjhQQ1hPb1htZzV1clJa?=
 =?utf-8?B?ZHRIREFRcjBoNnk3YmJ3MHN6TXphN2E5RDZ2SmtESzFQb3dpWHBTVUNKUEM4?=
 =?utf-8?B?a09DcUhYWklhQ3daYTNDSDFyRm1KSVpSMm0rUUcvekt0NFNkMGhmdmQ4SkRW?=
 =?utf-8?B?L2JyNG9CRG9pVmU0OXhNYzU0N2doQ3lXRzJUZEpocmV4OVd5Y1EvQ1BMbTd4?=
 =?utf-8?B?ZnJBTDhiMGdINnlISW0xdEpYcmRzUXh6c1loK0EzUUgyaElQVGl6bExOL2E3?=
 =?utf-8?B?UzFBb01aekdWQzhteFk1QWQ1YS9QbnZIU0l5TUVyK0FmZWdrK0JJR0tkVjRr?=
 =?utf-8?B?cm9uRG1VdFVoVkRxMWhRNDMrL0lhVGhkdGlRcXFSa0U4ckxlZlZhSm5zVUNS?=
 =?utf-8?B?bDg1YXYweWYwVmIxWlRIVS9GUXRFVVdMV3lHTXg5WjlZK00xajBzTGpSc3J3?=
 =?utf-8?B?Q29KV0RoREtmcXJLWXZFdWN5MjVMT2o0Qm1OTEJQWkRvUjFkamdDN201dFov?=
 =?utf-8?B?WmFtWFl5Qlk3MHFRb1NTai8yMHpKVk9MTFl5aDFpcDFtakd4T25pTmQ1dXpG?=
 =?utf-8?B?ODRWU3Nuc0lVY1UwdTMyOGxJNG12YUQ3RXJ1a2NWR0tJdjRhZjc4UDdNMG81?=
 =?utf-8?B?QXJLMlQ5UmJJSTljZUNxU2FkcW5wcjVmeVpJc20wT0ZVOFRSbklYM0tUbzU0?=
 =?utf-8?B?Tklmb01MRERPU3dUTkFNN2pRVkx3eGdNQTFZVXIrbFNoUGJQSjMzK1NTSitt?=
 =?utf-8?B?K2lTQm03Uk8vOFp4NXFBTzBqWVh1VklEWi8xdVZCQ3ROTG5kcThuZVJmSUFK?=
 =?utf-8?B?d3BuUEtGUzZmZnE2NVJOL1p4TUhRY2lNaWNtc295TG1ZaTR6Y2ZuenVZQWVu?=
 =?utf-8?B?Mk1GRkhiTTRWMGp4Ym9FYTgyU3BOTzhWa25kMWFhWVRjS1JjQW4vdVBiUDM1?=
 =?utf-8?B?bGdUTVA0Yk40WEFQU0xMVEZUcGszeDZtUFgvUkQ0RDliMlArRmpwNkVzRTFO?=
 =?utf-8?B?WDdieFVTYzhMdFNzdm11cWt5VE42VXM2SzBHWmFBZzhyUUdCM1hpSThPY1Jk?=
 =?utf-8?B?UHdlck5NVUxhd3lZYnRuNXBOUzR0WEZvR0tBYkhUeVI3TGc4VmQwc0VwbUdv?=
 =?utf-8?B?TkdzZkxhUFgrVGhMMHM3NjhjeXFQMTV0YTAvaiszc3E4RlF3emdyVUFVYWww?=
 =?utf-8?B?eGNCSXAzeVlYOG9MWGsvbXg3WHJMOXd5c0NvTENIVEZzUXVNT1F3TmpPazZm?=
 =?utf-8?B?a0ZSOFUwbmRPNU9EMzcwNzF6TmtSUUdRMk0vbmVFMXNmcUk3Q1V6ckIyTmtN?=
 =?utf-8?B?Z0c4L0pQUWtCNGs0Nlh2U3ZEeGs3K3QvNTNtQmhHZWMvNnA1ZFZ6eXo2Q3gz?=
 =?utf-8?B?WWo4aXFOd0Jyd09NNkliOGI4M2djTjB1ajRSb09ZWWFLRnJyT1BDWjBtNi9x?=
 =?utf-8?B?elp4aURFR3JUcjFZWjFIRWFsTFZZeStQWFI0STlSL2RxWE13ME5tMWtaMGFE?=
 =?utf-8?B?cmRZTm5idjd1TnVPTlc0cldPVUllZWNlY2NiMTQ2UzZQc094NklFTWF5Vmw0?=
 =?utf-8?Q?F8euZsgA1sra+sgRQSWhDfHlTpdaOaj7wgTwBG0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHRZL081dEpZUlJBeXkvdVNuL3VHZGVhdUE0cmxPbjlYN1NsNUR4TFNPMWVv?=
 =?utf-8?B?R3NmUE9zSWFPdTNNVGxmNkxnRk5CVzBPTlY1UDA3bVk3a0N1WTBxUy9yc1VW?=
 =?utf-8?B?LzBEeUlTS1c4RFh0RW9UUWZoKys3UnFqUXVVUDN4QW9rNTRpM1lGaUI4LzFh?=
 =?utf-8?B?RWwzM2pkVE1MY05UbVJNTFRPYjFodkh1SDdKVWhsMWhrem1KTVlYa0FxSzNH?=
 =?utf-8?B?ZEg0RnNScFpPNWtUYlRKTFlDYUwzNGVqSW5IbnQvOXo1dFFCVVozNzcycFhl?=
 =?utf-8?B?QlpJT205MTA5cXNpWktDNVRibHVleWtnQzhJQkQyRUtoNEtNcUd6eVJVd05s?=
 =?utf-8?B?SWpkRGRQNXNUYnVQZVpCTjJMdTM5cS94MmVkMkhsRndOSDRSMG5BSERCRURq?=
 =?utf-8?B?UjRBQzQzNlFFWHBUdmVNa3YwNWZKMTVkekR1Nk51eElYaXBpRzBJZWROY0RN?=
 =?utf-8?B?NjVSWWdEckpnVVQrSVNRcGl1TkU2ckZFa3dCZm5Bd2REcVpkMENRUHl3Z1B0?=
 =?utf-8?B?bFpKcWwxc2tHVjJpMHEwclozNWVlbHNiMTVjdWowY3BWT3lxWVFEUDFPSHNU?=
 =?utf-8?B?SU5uR1V5dXJYZ3lPTjFUVGJsSy9qY2Vnemp1RC9JMFFUKzQ0T05ZRlZydElw?=
 =?utf-8?B?VUkwalNIR0JZL3dBaldLbjUyaUJubkdBMlFYb2xEc2Q1ZzNjc1ZTUEY1dUIy?=
 =?utf-8?B?S2dsUnJ6ZUNVYjNTcHl1VlBrd1R2eE9JWm5Sd1RnR0xZTTdjR3ZpWVdXVGtI?=
 =?utf-8?B?eWR0NXlkWm5hZkwzSDkwS3NpcENJRWU5cmNrV3ZrWFNhYXE2ZUVESVZHd0NG?=
 =?utf-8?B?YkE4ZHliYUc4RHdST1dOVzJFeWdQOXI1NW9heFVZeW1LMk8rZEh6cENZaGRK?=
 =?utf-8?B?TkUwQ2E3UTBqZEFKL3kvZExmak9BUkJrTTJZVGZjdE5aQ3ZPZjh3M2V4aDJF?=
 =?utf-8?B?ZnQ2TVVja3F6QjVCeUM0SXVpMWY1WUVnSTNiL0JzTVlVRlNJcW91dktOQmFN?=
 =?utf-8?B?UmtFSXlkdlp3U0RQSHc3OHRhM0xYN2Q3clFjYjNSUjJOWE1FTURWbHY0QW9i?=
 =?utf-8?B?cWpqalhwNkJ1c2Y1dTEwN2ZXR3FlaFpUZ3JJZXNabVYwM01yNzBkUkZqaUlo?=
 =?utf-8?B?VTZzWGNvbDc3WmVCY0FrY1EwUys3L3F6MitFemZzcmhFeUEwV0NZOG9VRk1S?=
 =?utf-8?B?RjhLVTJ6ZkZ0MGZKUWZOZU5Vc21WYXJOSVlFRlhiNWo2SU5BVGNVcGdWWGZl?=
 =?utf-8?B?b3VBZXplK0JvUGo0eEFxaWcwblVKUDdhL2dFZStUbG9RQ0xJR0pGeEcycG9t?=
 =?utf-8?B?S3lWd081MlpOT3NCTkowTUU2VHo5TEFTMzlnbDJnMlJBajRqSHY2aWg1T1Yy?=
 =?utf-8?B?K2ZyVm85MEhMTWxHbVZ0YlhFQVZHbWtJb2wwaWdDeWFnVkNXMXRyTjFKVFo0?=
 =?utf-8?B?eTA0ZUpBejhoUE0xVXRaK0xNK0poM1JoV2YvUm5yUUJDc2xEaFl5ajdaM3cr?=
 =?utf-8?B?alo0WVpvWmRlZFFuMTQxZGxNUWlOTm9FazNZb0NEcEtnNTd4Yjg3QkxtQlJS?=
 =?utf-8?B?S2tONmtlMEUwMWFyaHNYbHlpbk9JZlRyc05ZSlo0MDd3V0VkVG5kakVIUU9G?=
 =?utf-8?B?RERwNERlNXNaaFdkQ05xR1pOaStTb2VVcUR4cnUvZkE3SUFQbk1HN0UyeWI0?=
 =?utf-8?B?MWIvL2R3Wm9TVVU3NnJVbVVmMm1OMUU2K0E4ZkdocURjWEV2OGFXelMrS0NW?=
 =?utf-8?B?RXpWNzBZeHZabERDQ2owV2JOZGhYMGRwNG0vZk1UUUJrQ1FRY0dGcVlhOUNl?=
 =?utf-8?B?UTNXMHVueGNTZWU5RkY1MFRteldGYVhBdlB0R2FTeW5zUVVSWCtnZWpCaVZD?=
 =?utf-8?B?d1lVRWNFc1JBcmN1U1MvZGpIRlBvVDFYaXIvdDhaYlo5cmF2WUhKU1VXNm9u?=
 =?utf-8?B?TDVKSEpyWWFCck0yblpZSlhjanVrVHZmSVVTT01kR1cvSVp2RUE2amUxZFFP?=
 =?utf-8?B?VTliT0JaNllNU3JNZDBxdjMxNG55TThLakJwK2RoUjdZaGtaZzFaVy9wQUlz?=
 =?utf-8?B?eXZEazdlcVIwRXI5dDVLd3gwZDh4d2xpdmUxdGVMMnlCOUVBYkNFZ0VpQmxz?=
 =?utf-8?Q?3Moq+f7INNXoZO/WC3qr6aY7+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7e9efb-b70b-4719-f784-08dcf7d7cebf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 05:09:04.1421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7ApQmpwcIznhiuMct4h+Ours5mhuQggKBHL70aMF/jP0uN+goFcTXPMbt/FJGGd/Oy9hqDtpfJdmemtQxW3rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-OriginatorOrg: intel.com

On 2024/10/29 11:12, Baolu Lu wrote:
> On 2024/10/28 18:24, Joel Granados wrote:
>> On Mon, Oct 28, 2024 at 03:50:46PM +0800, Yi Liu wrote:
>>> On 2024/10/16 05:08, Joel Granados wrote:
>>>> From: Klaus Jensen<k.jensen@samsung.com>
>>>>
>>>> PASID is not strictly needed when handling a PRQ event; remove the check
>>>> for the pasid present bit in the request. This change was not included
>>>> in the creation of prq.c to emphasize the change in capability checks
>>>> when handing PRQ events.
>>>>
>>>> Signed-off-by: Klaus Jensen<k.jensen@samsung.com>
>>>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>>>> Signed-off-by: Joel Granados<joel.granados@kernel.org>
>>> looks like the PRQ draining is missed for the PRI usage. When a pasid
>>> entry is destroyed, it might need to add helper similar to the
>>> intel_drain_pasid_prq() to drain PRQ for the non-pasid usage.
>> These types of user space PRIs (non-pasid, non-svm) are created by
>> making use of iommufd_hwpt_replace_device. Which adds an entry to the
>> pasid_array indexed on IOMMU_NO_PASID (0U) via the following path:
>>
>> iommufd_hwpt_replace_device
>>    -> iommufd_fault_domain_repalce_dev
>>      -> __fault_domain_replace_dev
>>        -> iommu_replace_group_handle
>             -> __iommu_group_set_domain
>               -> intel_iommu_attach_device
>                  -> device_block_translation
>                    -> intel_pasid_tear_down_entry(IOMMU_NO_PASID)
> 
> Here a domain is removed from the pasid entry, hence we need to flush
> all page requests that are pending in the IOMMU page request queue or
> the PCI fabric.
> 
>>          -> xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
>>
>> It is my understanding that this will provide the needed relation
>> between the device and the prq in such a way that when  remove_dev_pasid
>> is called, intel_iommu_drain_pasid_prq will be called with the
>> appropriate pasid value set to IOMMU_NO_PASID. Please correct me if I'm
>> mistaken.
> 
> Removing a domain from a RID and a PASID are different paths.
> Previously, this IOMMU driver only supported page requests on PASID
> (non-IOMMU_NO_PASID). It is acceptable that it does not flush the PRQ in
> the domain-removing RID path.
> 
> With the changes made in this series, the driver now supports page
> requests for RID. It should also flush the PRQ when removing a domain
> from a PASID entry for IOMMU_NO_PASID.
> 
>>
>> Does this answer your question? Do you have a specific path that you are
>> looking at where a specific non-pasid drain is needed?
> 
> Perhaps we can simply add below change.
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index e860bc9439a2..a24a42649621 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4283,7 +4283,6 @@ static void intel_iommu_remove_dev_pasid(struct 
> device *dev, ioasid_t pasid,
>          intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>          kfree(dev_pasid);
>          intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> -       intel_drain_pasid_prq(dev, pasid);
>   }
> 
>   static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 2e5fa0a23299..8639f3eb4264 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu 
> *iommu, struct device *dev,
>                  iommu->flush.flush_iotlb(iommu, did, 0, 0, 
> DMA_TLB_DSI_FLUSH);
> 
>          devtlb_invalidation_with_pasid(iommu, dev, pasid);
> +       intel_drain_pasid_prq(dev, pasid);
>   }
> 
>   /*
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 078d1e32a24e..ff88f31053d1 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -304,9 +304,6 @@ void intel_drain_pasid_prq(struct device *dev, u32 pasid)
>          int qdep;
> 
>          info = dev_iommu_priv_get(dev);
> -       if (WARN_ON(!info || !dev_is_pci(dev)))
> -               return;
> -
>          if (!info->pri_enabled)
>                  return;
> 
> Generally, intel_drain_pasid_prq() should be called if
> 
> - a translation is removed from a pasid entry; and
> - PRI on this device is enabled.

If the @pasid==IOMMU_NO_PASID, PRQ drain should use the iotlb invalidation
and dev-tlb invalidation descriptors. So extra code change is needed in
intel_drain_pasid_prq(). Or perhaps it's better to have a separate helper
for draining prq for non-pasid case.

-- 
Regards,
Yi Liu
