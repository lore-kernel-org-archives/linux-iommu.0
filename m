Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C0157472
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053191; cv=fail; b=nucgvtARifacFonbRIkFE0JhXJ5FDRyy5TPokgYm1BR5ayZCVfUw3xsYcDVxSp/pTVJj9znrVn4yYmDoDHcY1UWJBN5mOBy0gd+VxBCWc6fpzLEJFflVsxagM9FZsTxlqNBq/Ae5x83cAunjiFPJwlHyeKvhPymXB/bY1W31Drc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053191; c=relaxed/simple;
	bh=h228RZFrl0hzteulM4ZmYtrGDmTtM8YImB/5ojWrSwk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XYrzuTN80ing8YSQaK1UOVeLdznGr4//uYJ842E9Y0wkYn/11Pt01Ps3uwzB0NQ+M604I1iag5iaQxzBGyNpvwMd7TRDV/TGbs0n/qqJHlAZXxWhOAPFixdcd2Ftmb1qT0xmd2PI1O5TFFTlKWZA1R6aNLi8JHInRPU4swImgxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kj0Dz60X; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kj0Dz60X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724053190; x=1755589190;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h228RZFrl0hzteulM4ZmYtrGDmTtM8YImB/5ojWrSwk=;
  b=Kj0Dz60XeOvVJyjVdRbbjjPXIGOInM76qGfrbHhVPCIvtQmhOcQ4AGHq
   EEB9BHp7lBgYD2Kuw1uvaxxksH2KBOLHcOnZr5HJ049BsOITIwXopCY8G
   B0fBadN9reyMNA+jvkpnL39sAyZTmy/xSxsZCQYochphDcG69cOatrODS
   YY24gX956O3zu+7xcPUAvb/Jggzv1HFDt+jwWWPpoZ2gK4p+1hyLmmV3Q
   j2m0qHsNqSMOYx6XsKv5jlxtv/+eMWN4xBJz5XNzgqTCveWjSk/wRZxz0
   JnIhaT/ewNarFsbWQcQIrPWppMM3UEDlqME0aSF8KyIy/9RyPNWGfv875
   Q==;
X-CSE-ConnectionGUID: let5XZYjTxOMmHpgMkD0lQ==
X-CSE-MsgGUID: to+2Zt0WRLyM+fnBlB98TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="21906236"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="21906236"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:39:44 -0700
X-CSE-ConnectionGUID: EF2i1uz+QBiIHP8Npq12VA==
X-CSE-MsgGUID: +ok6LMBqQb6kGkc71Mn1Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60854893"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 00:39:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 00:39:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 00:39:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 00:39:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 00:39:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foqx82AVMn2ZkOGV0prIMImt+u4Y626JAch4+1i3ScfwC+coa1a/CjyM+GM2/ZTyk6y8dwpHVXAxTF8TUxr/VdEmXo8CPRKLyaMcGFaU9AEi04VwTM5lSr176L3uBGGpBVLkqw/j3cpcOs/42WX0I8FDge5Q/s8+CvW9EWZUuYgM1sKWjKuvqCVcdnU2l3ViPG6IVFJG5eietjDaKQFzef9F9fKQ2iOhD0F7HR7FX4BnNMmyFXlrFtylayl/0GvYJAu32KEi90UnSvvTQLJ98YkBVEPym2mDPwxMb00TjPcDa/Wul7PRq+fSJnLAbCWC8wUWnvNVkyf0mSbAw8NfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKMdcy19fprn/8Vawg0KPrIp+aMs0PjQ0W9hqpXmIF8=;
 b=GkgSyMtjvXdIABEmLDAHFCXzDoVkxBroVuIhSNEZq0lbdedU6BDKCEFqXWo2bRJ3nT9RivFAeRTrei346FCWhjKdG5OuQxIIoEdgljC83YdVYUkA+x7wnN6KEryGMh6tNi777c9c9QeE0+ZKBZnNopMhP4OqJqbFPwrQEPpaFKVmbUXns2JvXeZDBhf7kDrUUQMs5MfuJ3I7D313yiuYCjAmsJuOn/95uXvbqn404GG4pFr3x3WrDn9klX/I33RI9hsp4ACWsLICbmqkNNirKx5bK6ZtHU37kWXxvpR6UlBkzyWCgQG2a5eAJcGyciIMOHVQSJ7gv6zSmznmSxhNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 07:39:38 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 07:39:38 +0000
Message-ID: <225363a0-fbb7-4201-8a27-9cc01b8c78c7@intel.com>
Date: Mon, 19 Aug 2024 15:43:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move PCI PASID enablement to probe
 path
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240819051805.116936-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240819051805.116936-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 33797b80-6bbe-46b9-e429-08dcc0221451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VG4wVCtXR0pTSVpIUW9GL0pJS2xmQXFHLytmVlh4UDdCaWRxdFllTE9vUmcx?=
 =?utf-8?B?dCtOY0phRkhBbnllVVlCWDZlb0xHcjVJYkJ3VmVGRWRCTURvdXZFZEhDMmY5?=
 =?utf-8?B?VXAxM0lIdUR4TzdJN1M5K05tejM1QVlERWhCbHliUitIZzRjaklRcHhreUtS?=
 =?utf-8?B?M0RPdkZ1WG5WbVdnNEl4d0gxdVN1T29uY2Z3WVZ2UzNOKzVQd2t3N1lGVC9x?=
 =?utf-8?B?b3k2M3dYSENjYzQwKzdLR0N1R3NnTldrQlQyTHBQdVVkSGZNOG4wcFBlcVZJ?=
 =?utf-8?B?eGwrdjVoMHpnNTNON1hycjZhY0VEUThyNTZ4K011KzA5WjlJcjFvZSsxMElS?=
 =?utf-8?B?a0JSek5Nb25KR2tzV2NhVHU5SlpINjNpU2V3UXJUOU1vM253NnR0RXlwTHFk?=
 =?utf-8?B?aGN2dzJJRFFIYU41TFBhZGNkdVZ2ZzVLTkw5UjFGTEJYMGtPR0pQc0tMVys5?=
 =?utf-8?B?cWFQeUkxeUhtN05LQWlsblU2NGR6WUdoVFFSN3ByYWdFQ2Y5MksxZFh5Z28y?=
 =?utf-8?B?NnAvRmZFa3NzY0NpQW1OZG5EVW0xN1hSbWg4TWM0NUUwclAxcmdIQWJnQzBZ?=
 =?utf-8?B?VlpGUDBEMS9NNmFheGxZMUk1Z3dyTk4xOUsycUFIVHFrVWlzVlQyWE9CcWFO?=
 =?utf-8?B?RTV2dkNrOGRxUGtiMm5xcEtTdVZCcDNWN3FWTCtrallmM1NoRUxZTXhJdEFz?=
 =?utf-8?B?aXUrSHZ4em5qNUg1WGYyeGRzOS95dms2cURpSlQ2QnF4K01nU3VqZk5uV1U5?=
 =?utf-8?B?dGs1dUVqb3pCZUxDMUJVN3g3L284RURpYzgxNzZNK3Jjbm13ekdzcWdzenFT?=
 =?utf-8?B?NnhNbC9GMUFKYXhsa01tREZ0L2Y2RG02SmhCN3U0VHpLUGxNclhmWThRdmo0?=
 =?utf-8?B?SlNOcE96cUs4M3dneFdSN3NWSTRLNzZHa0dmWUl1S1dkbEg4K2IvS0QrSWdL?=
 =?utf-8?B?VExOdFhHOG5mNU5vNkF6NWVtY1d4YUVpS0d4RjFGaFl0M2tkMVE1ZHZsdG83?=
 =?utf-8?B?STUzYS9sQlNqR21HSEhnclg0aXl3S1R3eFRTUFBHQVNidkpPWUlQRXZ5N2pT?=
 =?utf-8?B?M045QW5pbDhtaXVpQXZwSEh3ZnhyYUh4eDJvV1BHYWE2RVZVUDI0WE5GWmt4?=
 =?utf-8?B?WXk0dkgwRGpiblVKRXFaV2RkV3QvTEJ6bXRkQXpLOC82c0hOVzVYR3lFaC8x?=
 =?utf-8?B?eUZKTWd3Q20vZDFYdndzbU5vSFo1VUcyOVNFWU1PWHZzaXg5UjFUQTFjQ1BH?=
 =?utf-8?B?NXJYQllZUUJoUHBZM2J3VUdSQ052OUw4OWZXVWJ4WmJEMzVVbFVES0VuZks1?=
 =?utf-8?B?cXlWY0I4T3l2MDZZSEtiaklWVDFYRG12K0dZNEFyY3B4bkVOd1kwaTcwdjNI?=
 =?utf-8?B?M3RuN3B6Q3FVL3I4elp1OHk2bGhPc1BJNWtPOXd4dmM3TEJEK2wzMW1QRzBl?=
 =?utf-8?B?aXFJWUdEdFdrSEdVUnQ2V2liT08zOXZRQmx1Y3NCMml2WEVKeXdFSUwyWWpY?=
 =?utf-8?B?eWRyV2x3cWFIeHN1MnNwWTNDVzJtMVBkT2x2V2tDUXhabWdOWlpTTzdzR1cw?=
 =?utf-8?B?SGpNVmFML1pxQmE0VkJ4cG5VVkFLM3FHYWFhQ0VrTkVXdFNseDdKbGpZWjF6?=
 =?utf-8?B?S21xN2E3NnJ1OURsRlBvOU1mbXZRdHJlVVRRYkM4VENIY1luMEJaNVBoSWNt?=
 =?utf-8?B?b2N1Qys2VHBiZld3SWxkQXE5WFJPUWxBQ2twbk9VMmdhN3JMcmNWUU1wV0pi?=
 =?utf-8?B?OTRpVXEvbVdhSGtySVMwNjNWZXdDd1lsZWFxbFh3emEyc3NCWitkY3VDZWE4?=
 =?utf-8?B?MFpzRUlMQVpwV2JrKzRZZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ZkcHpwdnN0UXJmTmNOZTZmZVQyNlVXMnlmRjE1U0xIM1VocG1ZS2Q5QjRI?=
 =?utf-8?B?RzIwVTVpRXlsclRFYURVUnZQZDFYUWdZNmNMOTc3R200Tnk4MzBJMFlJazlr?=
 =?utf-8?B?SzZYNE9zR25tcUdVREZGL3JYQTRsdjhFZC9raUEwMmUrUlQxd1BGYTBYOEZy?=
 =?utf-8?B?cTdNMzBxZVMrNk1SNENQbWlQRlRoQndFSG8vUkREVm1UeEZNcWkySHJXRGhl?=
 =?utf-8?B?OUgvb1Z1WE5naGVaV1NZaHlQVS9raS9ieVFXTTBtLy83S2FHTlJ0eE1nOW1L?=
 =?utf-8?B?a2tjVE5JeHNxdmVITSthMHNXV1hONFJ2ZVdJa1YreEJudGNQT1gyaDlPdEtC?=
 =?utf-8?B?dXlYRXRuekV4TVZ5OWUzMEphblhFdk9nN2dRUGNNemF0R1gzenB0K3BKRVJE?=
 =?utf-8?B?WXdnc3NqMVpEYWhVMEg3VkwrZytmL3E0YnpHM2RJMk1FMFRYQVQ5ZVhkWlcw?=
 =?utf-8?B?OHl3K1dRR2l5MURjZGtsNG9mejZsM0hGRGI1VndqM0hoY1JVdk9LVWlWOWJB?=
 =?utf-8?B?RVFob25qR2MwaWtrRXhGaFVBdHlxaUMrVnJXZUtWbVdrUjZxdlRTcmdoaCtT?=
 =?utf-8?B?aFptd3NQUVVLQlVKYlBWN0s5UFkvTEYraXk4cS83OFlhVmhaTGZFbVhvYlg3?=
 =?utf-8?B?NUgrU292eTVUUXBhQkVMckR4NWhhTERkTW9Jb3E2MW0ySW1nb2ZGWk1rZjFC?=
 =?utf-8?B?ZlJ5ZitkZS81cis4OThLeHUzT29VSGE0VThTd0FZOFZxVmdIeE9tOWVTOFJl?=
 =?utf-8?B?aG1wVkZzZkNzalNzSWhGM2trczhzZ1V2T25BdkNqL3NkVE5XeWRGcGNjT0Uy?=
 =?utf-8?B?NXllZWlrUFJNcjlrekQ3TVdSTVZYNXQ4UGlsR3QzQ3B1dS93SUVYdm1DcUlR?=
 =?utf-8?B?c2NQNy9Qc1psK20vUi9JTTdDRGswWksrYTI1bzZCT1Y1b1U2eGVvVmMxblVa?=
 =?utf-8?B?eXM0YVU1L3BudTIvTElhWHIvaFZVSGR5b2RMSzZETVVrNU8zWkNMckwxOGw1?=
 =?utf-8?B?bW9WRHhabnJRWnI1azhoL3ZhWVE5bFFuODhjT2xCWGIwQktiYjZtNkNDK2V1?=
 =?utf-8?B?WUhFTktzZWVWd2JQYVVpVjhQNyswdmJuUEE1dnQxOG5SQ1hRMlVsYUY2c21Q?=
 =?utf-8?B?eFFqMzU3MExUKzBaNTRmQ1A5dUtsKzdubjBEbTgwREkxSmNFaGhPODV6WWdW?=
 =?utf-8?B?LzBJc283MmxNRGhuZnJHRmRCeXc4ODQwbmgySzVSdGw5L0JhY1BCMHMxUXVa?=
 =?utf-8?B?V0Q5SEk2Yy84T28wZDlBNGxId1hXR2VNUXF6K0JPNTN3eGkyUmVIaVhzdTE5?=
 =?utf-8?B?dGo0bU4wMGs3RUFhZXFNOGhjM0w0enl0azdKZ3pXMis3cStvamFrYnoxQkVG?=
 =?utf-8?B?eHlKamhzaFhKb2RudFpJQjRaNzZ4a1ZaY2JxMXg2eHRhUmszR0FiZUN3Sjk1?=
 =?utf-8?B?RDdYc0xtSktWQkhPY0wyR0plRDFJTWtPcVI3cFUzRmNNaWp3WStmTmVVWklm?=
 =?utf-8?B?R25nUjdNa1YycXB1TURTL3JvdXh3SStzM1N4YnJEY0VJVjRMbjFhMEN4YU05?=
 =?utf-8?B?dXpEV3VlUWlhdzVzNHZhcFBDSGlPdit0SEQxMWs1bUVQSXY5b2tTSS9BQUdF?=
 =?utf-8?B?d0drdDNac1d1cnIzVk1MUjJyMFhlaHk1MUc1SVNjVDVSVnl2dE5NcmRaTk04?=
 =?utf-8?B?bXcvQWVBd29kb1VYNkZPbG0vb1h4aWtNQkVOZ2xiSy9nNU5mUmpib2RIWUUw?=
 =?utf-8?B?bjZCZTRpckNVTUMxRE1obW1YQXM1ZVJ3VlV5ZmZQMzJwb3YxQWIxT04zZmVC?=
 =?utf-8?B?L1dBN3NQRHMwS284Sk5RNXhraUZuNEpNd2ZVbzVMak1jMlRWVmlHZ2xBVHpY?=
 =?utf-8?B?S29BVTdZT0dLb2ZmUjdSQ2Fud2ZqSGFIelVtaStEVE9PLzdNSzlVRk1UTmk4?=
 =?utf-8?B?bHVvUHBxdWI2QTFCd1N5Y01PbXNBZXJmdEVHaGYyR3FUNFl0bDRVamN1T21s?=
 =?utf-8?B?S1M5ZDYxUXVSTVFaejFFbk9FbjU4VlNpdDY2c014M29KbnNXdDZzTVdHUWNt?=
 =?utf-8?B?MWFOYmpxdFFBdlJKQlFCOXE2am5ESUYxOXZlM25xOW52bFl6UVUrZk1vL2Ft?=
 =?utf-8?Q?8GmhGWJ29xDhnbQJKPjPTrRlE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33797b80-6bbe-46b9-e429-08dcc0221451
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 07:39:38.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYXhwxaL6pKBjxoZyaLg5DPO+5T6hYNGBhXhKGNZTPjHIxKN3tYoBGDmK2+7lr8ZpOtbVDZhL7aF8zOZszUH8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com

On 2024/8/19 13:18, Lu Baolu wrote:
> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
> attached to the device and disabled when the device transitions to block
> translation mode. This approach is inappropriate as PCI PASID is a device
> feature independent of the type of the attached domain.
> 
> Enable PCI PASID during the IOMMU device probe and disables it during the
> release path.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Applied this patch to 6.11-rc4 and assigned a PASID-capable device to VM. I
can see the PASID cap is enabled before and after VM is boot. In the
before, this cap would be disabled when it is attached to blocking domain.
Hence,

Tested-by: Yi Liu <yi.l.liu@intel.com>

> ---
>   drivers/iommu/intel/iommu.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> Change log:
> v2:
>   - Move pasid enablement the last step in intel_iommu_probe_device().
>   - Clear pasid enabled flags after pci_disable_pasid().
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9ff8b83c19a3..43ad1f551581 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1322,15 +1322,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
>   		return;
>   
>   	pdev = to_pci_dev(info->dev);
> -
> -	/* The PCIe spec, in its wisdom, declares that the behaviour of
> -	   the device if you enable PASID support after ATS support is
> -	   undefined. So always enable PASID support on devices which
> -	   have it, even if we can't yet know if we're ever going to
> -	   use it. */
> -	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
> -		info->pasid_enabled = 1;
> -
>   	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>   	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>   		info->ats_enabled = 1;
> @@ -1352,11 +1343,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
>   		info->ats_enabled = 0;
>   		domain_update_iotlb(info->domain);
>   	}
> -
> -	if (info->pasid_enabled) {
> -		pci_disable_pasid(pdev);
> -		info->pasid_enabled = 0;
> -	}
>   }
>   
>   static void intel_flush_iotlb_all(struct iommu_domain *domain)
> @@ -4112,6 +4098,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   
>   	intel_iommu_debugfs_create_dev(info);
>   
> +	/*
> +	 * The PCIe spec, in its wisdom, declares that the behaviour of the
> +	 * device is undefined if you enable PASID support after ATS support.
> +	 * So always enable PASID support on devices which have it, even if
> +	 * we can't yet know if we're ever going to use it.
> +	 */
> +	if (info->pasid_supported &&
> +	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
> +		info->pasid_enabled = 1;
> +
>   	return &iommu->iommu;
>   free_table:
>   	intel_pasid_free_table(dev);
> @@ -4128,6 +4124,11 @@ static void intel_iommu_release_device(struct device *dev)
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct intel_iommu *iommu = info->iommu;
>   
> +	if (info->pasid_enabled) {
> +		pci_disable_pasid(to_pci_dev(dev));
> +		info->pasid_enabled = 0;
> +	}
> +
>   	mutex_lock(&iommu->iopf_lock);
>   	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
>   		device_rbtree_remove(info);

-- 
Regards,
Yi Liu
