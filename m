Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F7423DE
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742518822; cv=fail; b=SzovunGXgxnTzSYRIjCrT5l3BscxbV4gm4xzOw5Ml0wO2dowEvg//G1vl1yY/QFJM5kfHjyCEU5EzeOMZbAnSKiSxvuMWojI8iuZnhNXCudpY/NpEavTlFWyNXhClit4aGREAoqLpzbG70U4PDtqN2b4llCuqMhxebQLjGMVaXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742518822; c=relaxed/simple;
	bh=/G2Cs3B4VN9ZL9BBMx2mLyUodSKJwOSbSJNrJLqOEQM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OPGlPAm6zZVnGGhvbGye5KgLLBG+azrIdiZlBoqqLyLQE9BoP/Jpu3HPEiuP5BlEeLYkVKj6h+yJpr1dxQ3vzGcQDtydL2H3gSVXiA/NvBOfe2bP4dteBWqRVvtP5wEEv+W25AFh0a2/bNsHNWJiYBz7enUWHiSNyxdTiIodHu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvtixJK7; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvtixJK7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742518821; x=1774054821;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/G2Cs3B4VN9ZL9BBMx2mLyUodSKJwOSbSJNrJLqOEQM=;
  b=bvtixJK7ViHjhLiFbxwtqXw6ayU+J8fPkGgIt2qtTED9h23yx33f6OSq
   7kZJ/3y3TIz1WjZ4m8YOGY8Jc23z7YJRiDCfNmwN5o3TaIo1GXjRtlSRT
   99Q2aWZ50ocAtRBxpkBbY5bmEEv6KDfEUkxc6Vos0AkkY2cmEqieKgqSD
   NxmaGjynUnj1Rg2wZUzesxLy0ox7EznVITvLWL4CLPGjZjh5zYiUw80zv
   vS7Z7B3K/4R/2rrjNvMKlKOIyxMJ5MTNIryADdwvtIPpgoi7nswgT2K+w
   VGIVTclxz9aJO+oROrWQc9kKwcp0KXAXBljvoreTfEtQ0k+h8a8wMfXi8
   g==;
X-CSE-ConnectionGUID: 8Iq80OmUQKGXMxerv0dcxw==
X-CSE-MsgGUID: TtfGUFgOQQ23iQGw7YKeIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66241726"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="66241726"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:00:21 -0700
X-CSE-ConnectionGUID: vzGQyfc9TUulz4ReGDqVyA==
X-CSE-MsgGUID: tw2dmdTVRmiXS9ZlJoxr6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123772807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 18:00:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 18:00:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 18:00:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 18:00:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MV1HHviHtvg8cUR7aZldrLDtNieMHEpDWm9K7S3pSjdMTRj3fWVImVU5b5rz8ObwdAdq2NUuGyK9VKqtsh7sKxm9EPc2y7kHYf/D7ZDwVqnQTZl25XZmD+V1Y0tk/6tsMakdJtT01HmlUl4XO3SzeQ3+K9RukpSdXaHlAj1HqXN09V2i9flRvOk+cC7pEqvul9w0ncsHWKhZ7iGn7Lq7IY7yAJZcRkc7dKRoeMKgbYNLuFPmH1EAGJMYVMOInZm3Rxulr36MdpG2UoYXKnPoMgUNBQyLRPhy1TaPW6E4Oln8SzYV1+gOSy557A2IGviu6YeiPreI7T2Bs+jXsjCs8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFmoi6HFr5LZa5H99eMqqXd6rBj8uhXEPejz41WAaPk=;
 b=FZJ6uYZu3ECrAMVmkugFbvcq87m8jwHp0X2a3APCAcu+/mumgyrMNA2ZT+Bte94UoatcjTG5o2RlPlK5qpZgK5FiGLjGK08Guv0jVy41s9kN890+0FuJbYNnS/M/dY/kJJR/9qInFagzVCV2Mhn58OrOfXOzi6hA+6jj9vqnicrqX+sVAlI4LHzJd/vZIVHWHEBGE1co/yhvX8h0XRtDkKHCnjDZupNsl0m8vU1Ndmte98NWmDHMP896zDKbESBuTzM7saoVOGXXHXdL8Ouaj2J4X/FcpqCU45xyuZUwvLX0wVmYQD0X0UaESN45vfzbj3f2OUiHdCytR0hvviiB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Fri, 21 Mar 2025 01:00:17 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 01:00:17 +0000
Message-ID: <78e022c4-c971-430b-8621-be6199b7f3ce@intel.com>
Date: Fri, 21 Mar 2025 09:05:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/18] iommufd: Support pasid attach/replace
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-12-yi.l.liu@intel.com> <Z9x9sy7s2u18wVrG@Asurada-Nvidia>
 <783d69d4-5858-4699-812c-b8495a36e9b5@intel.com>
 <Z9y0WzIo4Edu0D9H@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z9y0WzIo4Edu0D9H@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af3db32-a608-4a72-5296-08dd6813becc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTIvS1Vrd3dRVVp0NVNsMVBERHl1R01taHlFY2dSNU40Rks3MkI0UStqZS9H?=
 =?utf-8?B?elV6WnlibmdlL3lZSWxvODNDVUIyb3JDVUROMzYrTTJxRHlybVdvOTBudWNC?=
 =?utf-8?B?VDhZZzZKM1Q4VTJtNkIrSTBLRWxiQmpGaTdsSlRTNFBkYk9aSmlYQkZkdFNL?=
 =?utf-8?B?bDlEbW55eHJ1L3psbHJaSGtwbEtwby9oMytKc0djcC9yeXJMMDJNUHRFdW13?=
 =?utf-8?B?bTdhVE1IV0VBVm5ZQWVTeXEyK3MrT25HYTZBVXlNM2YzTVhobHJ1RlI4eHQx?=
 =?utf-8?B?QTRlRVhzL0p2R0VURUNrbTlYMVprQ1ZET0Uzd2k2MUc0R1hJTURNMVluMkJS?=
 =?utf-8?B?eEtZMmplTjM4VjIxU2x1cEFIYS9jM2w3T211Z2lsQXE1RXNrUytLZWY5M3gr?=
 =?utf-8?B?OU1MaFJISTdUNHVCdExGZmJKUU9uQmJZZGExZWYvYy91ZU5KYzZyV3NXR1NX?=
 =?utf-8?B?amoxZ3QrV0U3dytxakFuV01WbzhXZzVmYndKc0hLcWJuU01DY3dVRmVkVENT?=
 =?utf-8?B?RzcySUcwNjhIcGZjVTl4aDl4YWZyV3VzZkJvZVA2TmR5QUd5ZG13NnczMHhl?=
 =?utf-8?B?MFZhZkxuRndyeVU1QmZUMDRyMVJFbm1YWkNFSm9oRkdGVHF3Nng0R1NYbFdL?=
 =?utf-8?B?U0ZseU50WjFCZWNWVmtvT1c5OENsZVpTRk1Nam9lK0JaNVRRaC9ZbGJ5QjNT?=
 =?utf-8?B?am1GdUVsQ05QR3FsS3B3VnlYY3cxOVNRaDJFakEySEJtS1NZUi82clpTZUs5?=
 =?utf-8?B?SElBTnJhUnNxUjl2c0g4R1ZobldrNkxNTWlEYWlzL3hYMGRkc29VYVdsQlFM?=
 =?utf-8?B?U0J4YlRLRjR2U3ZZT2VCcTN2ek9rUVlodTFsZEtzKzVPOWZweTZsUUpValdV?=
 =?utf-8?B?RWcxZGZhUGZhZ3BtUGhnQ3UzeHIrd0YxckN4eG80bnF5Uk5EZDZkdldudmtD?=
 =?utf-8?B?amgrRkwvMFVzQkVmVnR4YzhNcmFycmFEblhDZ3dRV2lpZkdLdlhTYytRaEdk?=
 =?utf-8?B?NTJpNTUvNzVuSm8zQVRQN0dqTFgxZTlvQ3lPUDc0L09DU1pWWWZONU9kY1oz?=
 =?utf-8?B?Z2EwWkorU3pjTWorS0trTG02K2duVWowUWdYMUxRVXR1a0ZmSEM5KzcvNzln?=
 =?utf-8?B?anY3Zm1nWU42UlRFU3kvNzVkSktkOGtCTHV0SGpmaG9yMFE4OEhKWjREbTdh?=
 =?utf-8?B?N1U0bGY1cFFCcUZBZlMvMWsvSDB1T1lkbG15dkVGajFYb3JnOU9iUnFaU0dT?=
 =?utf-8?B?dndXc0Q2VGFVay95czdzYm4waUxEeTBGR0hYZm1mMnVHZWlYYVhVOFBPclNj?=
 =?utf-8?B?OXVZYmJPeUhJNG5acnBkeEgwb3RESFhxUmZLcnk3Sm9FUjhNZHQ5L0w0d2lE?=
 =?utf-8?B?TjhVcUpOaUhDRmZ3eHh3WUF6LzZhdkZob1U1K0NzVS9JOThLMDhsV2t2MWpE?=
 =?utf-8?B?MnhEbkpjVWswd2VjZFJhdG9lZGN0SVhBcHF0Y2dhNVdhallsaW1HOGJ5NDNm?=
 =?utf-8?B?QU4rcHJPMzljSUxKdmUwaVVUWFBYTGpDNGl6dnZJL0dkdmt4WkswWWZrR3Np?=
 =?utf-8?B?amhiSFh6d0dJd0JzdDRaT3ZwZldUWkl1ZEZGdlF6L01FTUlPQ0pMYTZ3U3B6?=
 =?utf-8?B?Zk9sYUxWMzdXcG9iRmQvdzQrL3NhZXJoWXIwKy8wUlg1YVVCK2VFZFVtTTkw?=
 =?utf-8?B?UnY3TzgyOFRuZ2IrUEdnMFZWRUZndjhhdEV3ZHR4YmMxYXZiclB0aUUzcXVK?=
 =?utf-8?B?cHFwYWs0d0NneDFsRTlSWU8rbzkvWkFETEx1blNUVk1PdjJSMWRCNkxNNkxx?=
 =?utf-8?B?RHlZaEJLZTdZQzFES29ZbzJ0Vkg2V0I5VHl2YW9TUEF2eS9qVzBrdjBDZnVI?=
 =?utf-8?Q?Kvj8VKzNxky3N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2VhajNrbjJMUDJCSHVqcE5qc2FUejNoa0puYW1xQ2laSElEeStRTEJhREpQ?=
 =?utf-8?B?VEsxZnd5ME9rdUdlY0UvWE9PV1JMOEp2M09PY0dLbmRNNTFvY0N0UVk5Z3Vv?=
 =?utf-8?B?bGhvUDhHbDhaMTRwYkI4YUxvL1BJRVNhU0ROdXcwa2Z3bndueFVlZU5wUHJT?=
 =?utf-8?B?Vi9uQitkVzlpclJYbTY1VWorOTNSOXdtRXJqRDhmeVlUUEZUTVVSS1Q1TUd4?=
 =?utf-8?B?bFBiMitEbGlaQ2dEU2lzUG45T1RtNEhndWwySGN3cmNzbzhiRUh4eGRiYVlC?=
 =?utf-8?B?S3FHSnErTTdnRzA5dG1jclcvazRGQ3JNdERjMUgwNUJsR1NKUThRSFFpTUZZ?=
 =?utf-8?B?ZUNobTZmT1RIRnM3RWFrampYTURlRHBCdDkwRUIvcW1NNXRaRnR3MGRDOHIx?=
 =?utf-8?B?eHYvaDdRdllkK2RaVFhEWDZyZHA0NkxBbGp5dEtYSjVaa2dLWXVOV0Z5TE5k?=
 =?utf-8?B?SjVZWTlrU1g0bWRLeEN1NTJIcXplQnByZHkyR0s0UVBpQjR4NWtpUG94bVNo?=
 =?utf-8?B?NncrbWVickI0UVc1N1J5aFV4Vm0vOEJNalpBS3AyeUVCTXFIc1d0MG5ickdl?=
 =?utf-8?B?SnNRYjg3blhVZ094ZDlXa2RoTXBsbzVxN1VLV09pNzdFZERYaFJxOGF0MlJy?=
 =?utf-8?B?a0pxbFdQR3hTM3hDWURlOW9QMGo1VGtYT1hQVDdZVGhUNE9ZUHZBc09tODNB?=
 =?utf-8?B?VDdGOVlxRVJWK2UveisvUisyN05iQ05QWHRvd2Jtc1JQUkVsSWo1c01VREE5?=
 =?utf-8?B?dUpUektjcHdzbFV4ZkdzeTBTbkoxQUNaVFd2VC9yUU9pc284Q1dSMkhxOUQ2?=
 =?utf-8?B?S1VMZ2FnSmVZaFpFdHJHM1E5TzY5endUTkJMQXpkZjN3ZkxQbHJ6a1MwbFA1?=
 =?utf-8?B?bHoyNkhuQjBnK3A0WDVmcERQTlBiZzBwdy83NklFUWdWOE13cHdNc3Z3eUNh?=
 =?utf-8?B?MThZK1hLY09OdFg1VktDSXJGT2VRSkcra1FTYzJhUk1lYjl1dXFwazVvNUFo?=
 =?utf-8?B?SXJlNEd0YzJqbUVwMzlxQnFOVVlGMDZuTnpmQjIzeGdUc2pGWndvVStNMDg1?=
 =?utf-8?B?dGszQ1lEMVR5SEk3b0NIQWpSWUVjZFBLZUVKeENJdkUvcmhFVklzbk9iSW1w?=
 =?utf-8?B?a01qL3ZGYXVrYUQrMmdDRnNIZWFCTTlrNjUzOU1VWEhrK0pNNTd5SmlvVGlx?=
 =?utf-8?B?NjIyK1VJb0pVbjlCNS9wVS93MVFCTDU0SStDZzVEUW4xdFBvM2xQR0I3MWND?=
 =?utf-8?B?ZERpam10cVJJai9VNmNhNml3enZuUkdYSHhlQ2F6bWZRVlNBSkkxWkxocFJo?=
 =?utf-8?B?UlpyVUlSM0RIdWl0K3h3R05ZUzMrbnExOHBJUkZ0U1FWVTNLajUvLytKd3JB?=
 =?utf-8?B?N2JWcHVvbk1NM0c4c082TE9LTFFMcWlNU0dCYm83TXR4N1BrbkRNdTVHWUpZ?=
 =?utf-8?B?c0RzdW1nUGtCejQzd2cvSXgySlZpRW40di9DVWhnSUxlMk1YV0tlOTVpZVlQ?=
 =?utf-8?B?ODVzaWF0ZDQ4UE1pZWNJVFpGQTlibVI0TVkwcm5DSWVNczNzeUJhQVJwVWhw?=
 =?utf-8?B?bkNabXJaSDZDK3pPRW5vd3RtSzViek16cE1rcGRIcmpCZC9mbUJJcDVxc01a?=
 =?utf-8?B?bzVxeDV6YU4xcTVoNXJmVTY5V1FFb1lYSnBGTUFpK0VKUTcvWDRaMXUzU0o1?=
 =?utf-8?B?TnM4N05uSlQrRFBLUFBCTm1aOS9QYlNOU0o3SVQrSlFQOGVtemZPcDVNNUFS?=
 =?utf-8?B?amNRVnM0c3ZuOW5Vd3E3NU1DSmlxRmNhV1A5NEFTajZhV1VwRjJ0NWJFZnNX?=
 =?utf-8?B?RGtFaDFUeCtZamlHczMxd2lkaXVCUXQ2VnJUNjZvcnJXMTVnbGluYi9ZTFNz?=
 =?utf-8?B?bnp0bTJKVHJyV21SRTJyaW9lbms0MEFJWWJLTFZvd0psK1gxT3FQeGUrenNX?=
 =?utf-8?B?RUhFVSs4N0pac2M1YUJaZzlZOGV5djFiRTJtcUtwUll3Q3pzNU9rK2x6TnFp?=
 =?utf-8?B?NDhWMThhZEhwK2gxYXhMM3JEWVVCK2FvSzhBYTZqUE15UnR6VGoyZ2dzRE1V?=
 =?utf-8?B?Ym1lUzkwVUpld0dHTzkxZjRCYVR6UjRpUGhYR1JhbmN0aVdLMm5QSXJZcHNu?=
 =?utf-8?Q?m5nPTzAUlMB1zdB7tZMyZGdUB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af3db32-a608-4a72-5296-08dd6813becc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 01:00:17.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXmkgQ4EZ4LBTRu+BAtCaTpVsOktB4RIkA0sggiSLk/teh0yVLJ9x47J/4lYb+UITcuLlPfUA/3GZwVZbM0XYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
X-OriginatorOrg: intel.com

On 2025/3/21 08:35, Nicolin Chen wrote:
> On Fri, Mar 21, 2025 at 08:31:23AM +0800, Yi Liu wrote:
>> On 2025/3/21 04:42, Nicolin Chen wrote:
>>> On Thu, Mar 20, 2025 at 06:47:37AM -0700, Yi Liu wrote:
>>>> @@ -579,10 +582,12 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
>>>>    {
>>>>    	struct iommufd_attach_handle *handle;
>>>> -	WARN_ON(pasid != IOMMU_NO_PASID);
>>>> +	if (pasid == IOMMU_NO_PASID)
>>>> +		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
>>>> +	else
>>>> +		iommu_detach_device_pasid(hwpt->domain, idev->dev, pasid);
>>>>    	handle = iommufd_device_get_attach_handle(idev, pasid);
>>>> -	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
>>>
>>> This changes the sequence of these calls?
>>>
>>> Is it correct to do iommufd_device_get_attach_handle() after
>>> iommu_detach_group_handle()?
>>>
>>
>> oops, yes it is. It should keep the order. will fix it.
> 
> Would you please also see if this could be covered by the selftest
> given that all designed tests didn't catch this?

I suppose it can be caught by the iommufd_fail_nth. But the fact is not.
I think the iommufd_auto_response_faults() should be able to catch it
since it parses the handle if there is pending PRIs. Maybe I just add
the below line between attach and replace/detach.

test_cmd_trigger_iopf(self->device_id, fault_fd);

-- 
Regards,
Yi Liu
