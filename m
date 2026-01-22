Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473037E31D
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 06:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769062527; cv=fail; b=huPw3+iELy72aDSWSMJQcW2ZAi4Rvm0Bw+tmIWXH/8k+J4OlaNQpUGDAsTvBn4/cHDErM/aK15unf/1xkqc3ca7QMpougsfEPR118CPNdckq4UurNmJ1Y56oZFxFhJT8Uc9U5AL2K4rid2JLHPrUcnxLBVRyt4a7Yuwv5hkJ4/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769062527; c=relaxed/simple;
	bh=1vNAuY3mylgUV98ulzLLiv2lR2SGcHFCc8dOMJRBrmA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g/YTA7dEu10zLGJGwI2BysxOQSJS41jSQqotZNjoCCdnrGEJYUHOy6Si7fvtjyH+eHU1ZfYfsmF0pr5Ck2jJ2SAqpgdQQo30WlUbo6OICj2QbcfsEwzK/uVuzdhVNcUBNFH/iAVmaT125gXRsBsY/3/gAPdiga+A9XR3QKVDHSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVEzSoAR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVEzSoAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769062526; x=1800598526;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1vNAuY3mylgUV98ulzLLiv2lR2SGcHFCc8dOMJRBrmA=;
  b=mVEzSoARkD2hpHO6Wje6x9uHu5GuZg+gtyiKN1q5odfd16rHCzq03g54
   pGNklexwEtS4QDvaCgVMosE66rWiJD5ZBZjkNB79I8Gb7Sz03Qb7MWuuP
   qTPaYrq8XAt7GW1UMPN8zxyn/zaoRKbiTCo8329BqOJfJrJvf5lmTXrOG
   l1sy4LP/demKJa1DlhA26leLcWPLY+B/5acLa/EoYfydGM5f9ZgdYqqF7
   iBLdzp0LjroGEt8UotemaRjMC1pmmE7SixWUCqX2cmVESDd7vD8pw6t67
   m9OiynKIsh7g0Vqx3BTKsHbsxMJZHqNKvU/7fru8tGe9P0tk1uduINCpd
   Q==;
X-CSE-ConnectionGUID: ZvTXvNq/Rt2iQQ6PtVAEeQ==
X-CSE-MsgGUID: /znv/aNbSTyc1tgUw+gzVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69496254"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="69496254"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 22:15:25 -0800
X-CSE-ConnectionGUID: Q9NYJ8fMTBWicIB4ASlgcg==
X-CSE-MsgGUID: VcbxMaN8TF6DScISnjFclQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="205901037"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 22:15:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 22:15:23 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 22:15:23 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 22:15:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PktJLYAIP6Aj42CBreO/gDJ4CDzbc64tfjudgkaMX/kVK7WS6jYrTe6dr6yJIMn0vtOj6KSj8IS2jJPH3XqFJct71JjjJQPdlE3FrWfesFFwqOQ8EEIVwTvQ83ZB1yF6iH46+M1XN3S3nnmtyli7EbRqYq1lUeKMtIBmBAoLIzCns436ThKKAtybtb6JbuuS58nvhnDkm+nWOi+seaVib6hktLykeLrnnzA2qhIG8tI0BIM6O2vAx6+Xzc0xbIcnDG3no0NPTl25F/hznwOXtbQ0cR3gjdcpTGf1pvVWmB70Nq9yeq37i526TqMyC9PQZ5CsJ04p55FhzBNORxld9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW2atA+o/f9mKTxSQSvscV864/5mAQ655MaeaYzAOuk=;
 b=C4vVF1pfYH/3YaXkORzXR0IcJfuz71xQ7mwE69EBoLuffbcDYM3NMsUZWD4a8QWaqFNl1iJv8ORBry9gLiH0UiMzaXQT++aMN33pOTCCsk2uJXjw5CyL0o/Q1HoszX+JZm3yQWZB78LJJrgb+rAq+KxytmPHjZ4vKV6WG7tzBepR7gigIWXn0XgBK/9MBCHWV+sCrguUABoZdP3rKaLNgttFAZVKHeLNL38JceOypbA+M8+UDQLJih6DWovOx9gPZsRDixYM57LTgiu7YFWz4c9ZOFHvI8CfvNkOsjQcOz4AudwP+PHbf7PDskVei2tEfCtz4dMp/YNSXFCFf1VflA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH8PR11MB7093.namprd11.prod.outlook.com (2603:10b6:510:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 06:15:17 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%7]) with mapi id 15.20.9456.015; Thu, 22 Jan 2026
 06:15:17 +0000
Date: Wed, 21 Jan 2026 22:15:14 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Francois Dugast <francois.dugast@intel.com>, <iommu@lists.linux.dev>,
	<intel-xe@lists.freedesktop.org>, Joerg Roedel <joerg.roedel@amd.com>,
	"Calvin Owens" <calvin@wbinvd.org>, David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Samiullah
 Khawaja <skhawaja@google.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Tina Zhang <tina.zhang@intel.com>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>
Subject: Re: Xe performance regression with recent IOMMU changes
Message-ID: <aXHAcibp/4pUB8f0@lstrano-desk.jf.intel.com>
References: <20260121130233.257428-1-francois.dugast@intel.com>
 <20260121131135.GF1134360@nvidia.com>
 <20260121180449.GA1490142@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121180449.GA1490142@nvidia.com>
X-ClientProxiedBy: MW4PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:303:8d::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH8PR11MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 6742bb9e-e497-47d2-c343-08de597d9cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0o2Q0Z0dWh3YWlad25MOUVMSHVBNUc4MnA5c0NZVWxzTmtoaytKNmV5ejlE?=
 =?utf-8?B?NitJVEtpS1ZqV3BBWUpoTDJTaFNHRzhEdFBiVkF1WW5yeHV1TmJXOW82Vnp2?=
 =?utf-8?B?cEwwMXhTN2dQOGIyZTBYZ3V5NGljK2xhRWpUQ0p2bEU2dWN0ZllWV09Lc2RF?=
 =?utf-8?B?V3RYTDhJL01VNzhScGc4ak53MGR1MWJ5OTRKSURVbmVMRm9FdmFyVFdMbUdj?=
 =?utf-8?B?VitqQmhUL0loVjhnSjRiYTJwQzlNTDR2QVVHbHJQY1MzNVhrcnVsVzlBY2ZK?=
 =?utf-8?B?QlVadDN1dWgyN0FFSVY2ckd2YlVXZGFnazVrbTZTK1VGUnNiWml1Um9KM0gw?=
 =?utf-8?B?dENZUzZVNisvRW5ZZEVzVWE1dXNOaHBzMVlCeW1nOFdJWUUvamxIVjI3VjJ3?=
 =?utf-8?B?WTh5dlZJZjJmWWVrRTB6ZW5FU0d1cEcza3ZMTVRWVEZ2dUtrZmR1OFJNU01p?=
 =?utf-8?B?Zmxzc3l5ZUY4RDl6VlliMzhaNjJxVGcrRlZFQnpQak1hcVNZYjdBRUdtMmlm?=
 =?utf-8?B?dnpDY0t5NVJleldDcEl2cFIrRkEvSE9zdWRKNnhHVkR0bUcrbmpldlc0c1NX?=
 =?utf-8?B?UWRCU01CK1dTMGwyOUszano2dC9CaWY4REt6SWZDQlM1QlpDVmE2R0hIMno1?=
 =?utf-8?B?TDZFVWVVaVk3Z2FoZ0lFYkZ3aFpOS1VVVFpzWDRRK3BUbzlkS25xa1N5alFG?=
 =?utf-8?B?SlVtS1BEWG5Qb1JqQkJISFlvc2V2T0l6clZWaEZScEY5VjlBTVBoMnFtbU5k?=
 =?utf-8?B?ZFd2RXIrWGVqQy9zVE1QejN4eGNGdHpGck40WDY1aHFETDd5V0lhZXR2VDN0?=
 =?utf-8?B?eGRWSDB1WGhmZGU5M1BsNThIdVo4bjRGcnVjTDJRanZuYWJMamFWSkVnTFp4?=
 =?utf-8?B?R09DNkxLNis1ODNHNmIrYlhrd2RyK2tubU5BbWp1ejBFeWhaSytNcENWcG5a?=
 =?utf-8?B?WWI0aDBHODc5dWRjYVJwaEhINUN2Rlh3cWN5dWNKZmpXZjZac1pEbzFvSml6?=
 =?utf-8?B?TlNCc3NJejlPcWxHMFE5QjIzbTZYQy9temVNUW9jdlhLcnRXaVVoMlphd08x?=
 =?utf-8?B?cGd3M0ZmeENiazkyYU1JVElzZStnSlhXeStINFlNaEdxR01YTWprb0ZHeXhN?=
 =?utf-8?B?bGwyY0hMc3Fqc3ZXYWxtbHhBeWJsT3E1bk1xUVVjMnBrVnFvdFRORjJxRUR5?=
 =?utf-8?B?R2FVTUJQN2hjUVNwNDgrd2llMUxuUXoxOXJFb2Q0bGwzT2todXpBaEpQcmlr?=
 =?utf-8?B?UkV5SFdvaUc3NXVXbncvYlZNQ3BNTVlZRkErTjB1ZWNZUkl3ZWdrSmEvaFl0?=
 =?utf-8?B?b0JpSXVIOEUyUm5ydGhGSVNPb3NNNkh6WC9ySmtkL2lYRXpFWVVpSVp3dGlS?=
 =?utf-8?B?eHcxVzZEZlF4elVBMTJvQjdUbVJqVmZQd0lMM01yekpRV2hWc0puL2dHam5U?=
 =?utf-8?B?TkQ4U01UTTQ0b1hMdXNmdmlFK016OTQvWWthZ243K3M5K0IxcE1sMFJCNE9F?=
 =?utf-8?B?ei84N0I4L3Z0WlMvU09hSDV5N08wWk94Z3ZIeWU2VWNjNk1YMDAwZXlXN3ZF?=
 =?utf-8?B?RGgvNExVK0hkSjRCWlNUMk9LaHNRcFM0T0EwUnN4amoxSFBaeFpMZyt1ZFR1?=
 =?utf-8?B?Z0IrL1BvNTZQTHpwcHNlUUVCMC8yS2daMU0xWFVWUkFqRzVOSk1Zb3J0eWNr?=
 =?utf-8?B?MEw4QklEU1JlR1BzRnQ1L0UzOGZSRnlrZDAxRlh4d3ZWLzBtOFZ4TVZIMkRD?=
 =?utf-8?B?WE9TQ0hucU16ZzNuUGhvWXBtTjIxLzdma3EyV2hpZnZFYm8wcDlhWW1SQlZo?=
 =?utf-8?B?bmhGR2UvUDBPblNpbzFVM1RENWFYbkJyRXFzQzdWeERFdnA5MWdIL1djdVdC?=
 =?utf-8?B?NjA1bWltM3FZMXhSbUxYU09mcmZkU0VCdEt2eGM5OWpLMEVkSVRIdS9nWDdC?=
 =?utf-8?B?U3dqYlFOalVhcTY3SlpRK1JZQjFuR3F5T2YvcW1HR0R6eGkreGt3aS9ya1Ay?=
 =?utf-8?B?c0xYcWkyM2JjS2llS2JJdU9STXlZb01YbnhhaWRpUGpINjFWQUs3T0NwbU9K?=
 =?utf-8?B?UnVVa0dVL3JGb00waE1hOStUV1pya3RqMFNBY1BDVExtM0JiejY0YXNlTndU?=
 =?utf-8?Q?8UE4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk1CTFZsQ0pVblBBQ05HZHh6d2pJZUZFam1MbmV4MkhSZ2wrNko0UFVYRlli?=
 =?utf-8?B?aEp6ajg4UDNnamtzdy9yUFBHWTh0VWFBUUp2emp3QWE3TlhXdEZDQlgzdGcy?=
 =?utf-8?B?QUNabHVMMEpqdUZvV3F4R3ZQWVFaSTE5TlRSTUpobWlmWmlqM1kyZFNIMXQv?=
 =?utf-8?B?Z3dkNHk5THFlOGNYR2h5T3hoZ2dTTDJQK0g2bkpsc1VhMWlxRmQ4Q0pqMmh5?=
 =?utf-8?B?c0VuQXNDdXVJZUo2SmlyNXJ0VEN4RVpxejdPc2RmUTBXTlE2cENKZ0RCT3Ni?=
 =?utf-8?B?aTBkZnpoMm13UllUWXR0SDVJaGpCV0JXa1VzRzhQMTdDN2ZPenorL2x5R0o5?=
 =?utf-8?B?K1NIZ05LQU9aREF4T1Znd0ljRFltWHRZR3htZVdXSDhRbHluNEkxYm0vbDRz?=
 =?utf-8?B?Y3JndTNXU3gzWUNrSnZmOS9scCtKcWk1Sk52LzFyS2hQRmEzZTBkL0xNWWhs?=
 =?utf-8?B?T1lSeVcyVHJPUU8rTU9pbWlYMHE4RmttaFNuUXNMNkJVNFR0bzlvZHJiS2Ni?=
 =?utf-8?B?TGJLRDVINVIxcVdWS3VCcXJBaEFHdklRMFI5YzdsVjNBNjFPMk9aTUgxUklQ?=
 =?utf-8?B?djhXSXRzcjhNZ0k2VFJISXFrQ0Ryb0dMN2ZGendkUE1BdUJkWDJ5ZHlzRWhi?=
 =?utf-8?B?bWgxZ2draUNyaU83SFVHZzNySzA2dTJpYnhrNGJqV2NXSkdiVFBvczNPWWQz?=
 =?utf-8?B?WDlCcWdVU3BDaEZTVDJrUmE2RTUwZDh2VTl3Y2RMS1FnbTZMQTZIMVJNWEpX?=
 =?utf-8?B?MnpMdHNCeDNMUUZGdUVXblc0aUlHUVZyRHhnamx6Wm11MWNnOTZkM1FyRmhP?=
 =?utf-8?B?NjJCSVphQk1ydUZPd1hVUFNYVTZZVTQzS1czWVh5b1BzRUZzU2NYdzdSYzJp?=
 =?utf-8?B?RW5QYlk3RTBUVWN0ZFRkdk9BblhFK1g5SE9xVUlxOENUWVlOSkJFa0VpN2JY?=
 =?utf-8?B?K3BHcVMvblFyeXFOUEwwb0ZiTmg5M2tqK3Njc21UUllIQVBOanZyUndXZmR1?=
 =?utf-8?B?VFQyczVjM2I1U3liSDhYSEl5aEZ0bTFVWFpaZkhSN2o5a0I3c2FLR1NoMWxm?=
 =?utf-8?B?ZHA0MXFEMS9VMXFXZS9kWFpCaTZKeDVnbUtYNDNXTFo2OUdEZTFoenBIY0R0?=
 =?utf-8?B?bUxZN3RVZXpjTEpUNWs5Y0ZRRUt2bEp2OE5haGp1aEQwZ1Z0TkExVEFHS2Iv?=
 =?utf-8?B?RXQ0U3ZDVTFiU1FWaHV4NndJZzlrMG9GUW80NlRhTXM1VXFjSkVIdmdDVnpQ?=
 =?utf-8?B?NUJVQkhoa2oyQnI1L3ZWU01SWVFjbklJVVMyU2E1U1VCWUZHQUlXTjJQRk01?=
 =?utf-8?B?N1JnbjlQa09XWmd1bW90dXQyQ2ZJZlQyQW9WZGJocURCa1BHMHE3dzdCcURS?=
 =?utf-8?B?UEs2UUtFTVBqSkZNeTZSYUVJdVMxZGx6TFY1TWo0THJNTFV6aWNEcVBWUTRl?=
 =?utf-8?B?aG54UStiV3ZQMnp5cVVSckhyNjJNbzVPTG84VmltVVRJMGkzZmphSU5Eb3B0?=
 =?utf-8?B?VTFoNVFqUEpPcDIyaXlteW9aVEQ0MkJaNkJQQzNSU1hWN2ZqSy9uYjRZOTJp?=
 =?utf-8?B?clhvUTVmOXlqQnNIRnRncHVkZ0xwaHFYc0JFQmxXMWxmd3VEUzdFZzFLdm1Z?=
 =?utf-8?B?cjJ2bTd6ZGx1TEU2c2M0dnkrVmNCRGJVM3VIbFFCMGJHRjRJOExpS21qYUk4?=
 =?utf-8?B?ZGM3d0NublZvV3M3cmR0ZGF5WjhKVE9GL285WWlacjRDeVQrT1ZqTUZEa2FM?=
 =?utf-8?B?d3lUbGdpQkFlcWp1NjVOczdnZUhwbXJyR2I4T1BOMUliRUhyNW9lQzVjM0RU?=
 =?utf-8?B?SnJSMUV6YTU4RURvQ1h5SWc2REFFMGx4TWJLSG1vN2VOSEhPejZ5TFJxemU1?=
 =?utf-8?B?TUp2dWliTmIwbEFGdnJFbEJUTi9YOGFkK0lCakR6NmpVa2w2NUNzcng1azFK?=
 =?utf-8?B?bjNhZVhZdHhUN1h1ZzJ5VzdJMTZhK21HdG51ZFA3T3h2MGZ2MldFcVg3ZEpi?=
 =?utf-8?B?dVRLUDc1Zzc4RmhWYzk3S2piRFV6Y3J2aVVXSGM5SndOVkdCRFhKL2lyeUFz?=
 =?utf-8?B?Q042K3ZURVpNSVpWV2JxeW5PRWxGQm5rdXpvMGk2WjZ2dHFmdC9FcHRTaDFP?=
 =?utf-8?B?MWh4bkxsb2dhSTB5RTgwbU1DdXZnSG40VFc3MGc2OTVBbzNCY3BEc1RaMVhi?=
 =?utf-8?B?YVpLSjJvSlN5L1pRWkZkVENvdXBTdWxzczdWOGtkb1ZOQldqOXJVQS91ZWZW?=
 =?utf-8?B?cmtFaUpIUGRDemRDREVweDk2SXljMEpHN2RQcWxaeGlkN2VHOFhvVlFRNTVk?=
 =?utf-8?B?V3pISFZGcmp0T2ZVS2o4bHlLZFQzT2xuT2tJUFhBQ1A1Vk12MjQyUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6742bb9e-e497-47d2-c343-08de597d9cd1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 06:15:17.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9FRw7i9VTYjU7Q+m6hFUwFub2kIr4wBW/Q9F/BKnWl235AaBkIYzkDzBLgxUXPnurxWUhP/L/Sa4j92Fn6eSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7093
X-OriginatorOrg: intel.com

On Wed, Jan 21, 2026 at 02:04:49PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 21, 2026 at 09:11:35AM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 21, 2026 at 02:02:16PM +0100, Francois Dugast wrote:
> > > I am reporting a slowdown in Xe caused by a couple of IOMMU changes. It
> > > can be observed during DMA mappings/unmappings required to issue copies
> > > between system memory and the device, when handling GPU faults. Not sure
> > > how other use cases or vendors are affected but below is the impact on
> > > execution times for BMG:
> > > 
> > > Before changes:
> > >   4KB
> > >     drm_pagemap_migrate_map_pages: 0.4 us
> > >     drm_pagemap_migrate_unmap_pages: 0.4 us
> > >   64KB
> > >     drm_pagemap_migrate_map_pages: 2.5 us
> > >     drm_pagemap_migrate_unmap_pages: 3.5 us
> > >   2MB
> > >     drm_pagemap_migrate_map_pages: 88 us
> > >     drm_pagemap_migrate_unmap_pages: 108 us
> > > 
> > > After changes:
> > >   4KB
> > >     drm_pagemap_migrate_map_pages: 0.7 us
> > >     drm_pagemap_migrate_unmap_pages: 0.7 us
> > >   64KB
> > >     drm_pagemap_migrate_map_pages: 3.5 us
> > >     drm_pagemap_migrate_unmap_pages: 10.5 us
> > >   2MB
> > >     drm_pagemap_migrate_map_pages: 102 us
> > >     drm_pagemap_migrate_unmap_pages: 330 us
> > 
> > I posted some more optimizations for these cases, it should reduce the
> > numbers.
> > 

We can try those — link? I believe I know the series, but just to make
sure we’re on the same page.

> > This is the opposite of the benchmark numbers I ran which showed
> > significant gains as the page count and sizes increased.
> > 
> > But something weird is going on to see a 3x increase in unmap, that
> > shouldn't be just algorithm overhead. That almost seems like
> > additional IOTLB invalidation overhead or something else going wrong.
> > 
> > Is this from a system with the VT-d cache flushing requirement? That
> > logic changed around too and could have this kind of big impact.
> 
> Oh looking at the code a bit you've got pretty much the slowest
> possible thing you can do here:

This was a fairly common pattern prior to Leon’s series, I believe. The
cross-references show this pattern appearing frequently in the kernel
[1]. I do agree with the point below that, with Leon’s changes applied,
this could be refactored into an IOVA alloc/link/unlink/free flow, which
would work better (also 2M device pages reduces the common 2M case to a
mute point).

But that’s not what we’re discussing here. We’re talking about a
regression introduced in the dma-mapping API for x86, which in my view
is unacceptable for a kernel release. So IMO we should revert those
changes [2].

[1] https://elixir.bootlin.com/linux/v6.18.6/A/ident/dma_unmap_page
[2]
e6fbd544619c50b4a4d96ccb4676cac03cb iommupt/vtd: Support mgaw's less than a 4 level walk for first stage
d856f9d27885c499d96ab7fe506083346ccf145d iommupt/vtd: Allow VT-d to have a larger table top than the vasz requires
6cbc09b7719ec7fd9f650f18b3828b7f60c17881 iommu/vt-d: Restore previous domain::aperture_end calculation
a97fbc3ee3e2a536fafaff04f21f45472db71769 syscore: Pass context data to callbacks
101a2854110fa8787226dae1202892071ff2c369 iommu/vt-d: Follow PT_FEAT_DMA_INCOHERENT into the PASID entry
d373449d8e97891434db0c64afca79d903c1194e iommu/vt-d: Use the generic iommu page table

> 
> 	for (i = 0; i < npages;) {
> 		if (!pagemap_addr[i].addr || dma_mapping_error(dev, pagemap_addr[i].addr))
> 			goto next;
> 
> 		dma_unmap_page(dev, pagemap_addr[i].addr, PAGE_SIZE << pagemap_addr[i].order, dir);
> 
> It is weird though:
> 
> 0.7 us * 512 = 358us so it is about the reported speed.
> 
> But the old one is 0.4 us * 512 = 204 us which is twice as
> slow as reported?? It got 2x faster the more times you loop it? Huh?
> 
> The real way to fix this up is to use the new DMA API so this can be
> collapsed into a single unmap. Then it will take < 1us for all those cases.
> 
> Look at the patches Leon made for the RDMA ODP stuff, it has a similar
> looking workflow.
> 

See above. I agree this is the right direction, but we can’t simply
regress kernels from existing performance.

> The optimizations I posted will help this noticably.
> 

I think we need to start with a revert and then discuss whether your
subsequent changes actually fix the problem.

Matt

> Jason
