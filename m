Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E01A83E8
	for <iommu@lists.linux.dev>; Wed, 11 Dec 2024 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908967; cv=fail; b=UiXNJHtxm7KClmdQi6E0cHVGeZeLQdY4E8WEmOs5xqD7MqEuqREuFqiCMLdTdDCzOAhslALzsUCAo3ureO9JMlaRvjyAm3psIjQGQzK0GV3Uvx41wSntTM60v0m1BWGLZAWFaoUCsvv1zIrQ7/D3WbKCDMVDr2ormT/6Ns6RCJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908967; c=relaxed/simple;
	bh=b6OgdarZI6ksLp9Yg98Db2Ol8QLUovYBQIVaQnmBJ78=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zs+t62011+xLcblzrtkcPkdSh++LPfELcoNo9KEjl4abF84h13yeAA+OlRNlHg3azsReFdZ+bFKU6rOTV4zSzKqggV/EwzBXRY8+vd7cKtVUPlRKFxj1xLlzw5MAbMmPa4jUlBXHcqFH2Ew4HciQz8N53Ud6311Pw9lBRANCpWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIRcbaCt; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIRcbaCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733908966; x=1765444966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b6OgdarZI6ksLp9Yg98Db2Ol8QLUovYBQIVaQnmBJ78=;
  b=fIRcbaCtkdKjYAF+KU5ZeAuoDrWuSGMzrV+swCQi6oHqzjiWX9DDDDUf
   ALWxnUEXL97n3ZQMQz2zKXCYeOBNRu5/1LX2vQNh2WB41EvTS/mWyHRmM
   vd60Q5u70xJ62/Lxa0sg+u0Jn8mqOQ6192DTPK9WeCt77YzUFMZgI0U9R
   0jEQBekVPIJvPnZREz7nUNy/YSDUeVQsbxwtt+KJJBcgu7cTXqnt09a6W
   tgzyEJuTEJptBUgI/us9yOfxuz9HmT6I3yqyAn+vsuDL3LaHnkhe9H9dF
   SxlPBFWYayvAxfLKEUve+WLy0246CQJoyOQZRbkFrIz/bGDU8Y8+WUlk7
   w==;
X-CSE-ConnectionGUID: lBBzqo75TQCKATyu0n40Lw==
X-CSE-MsgGUID: AB6oGhM8S0Sj9LlOsRNDsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="21865373"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="21865373"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 01:22:45 -0800
X-CSE-ConnectionGUID: HxfoCVa9QjqujYZ9Q63viQ==
X-CSE-MsgGUID: +NSCjaZoRJy4ULqYlzOBRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99818432"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 01:22:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 01:22:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 01:22:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 01:22:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnYjO9atd0geILa7ocgqijuy3I0Rf4O3hBMWtj9GQSDeIEyn1hQudpEUh79xEGTXaHYd1IX7e+2gEWI14en2u26fr4nO4b1Q6Pwd38tIporJgm7N+phJevn6bywaOoX7orXhgJVW7UiNiI3+dNOg5DcPsGH9EIyOHPKmvkg1Llv6RaGfVKdkyt4sJhNrkNshfqeOeG7ILtiDVUY7RZhr99UTHf1VXcCLBGmEyHBqtnnBNq16WnKLkMKgS6WBsxkeTgGNVhvXH4go7wMH01qv3wgs2hrddiE9M0g/0K7BmOp2+2h3adjdknCNG0MotixzkEMW3EoZE3ZuEevYpl1sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvwjIQcUMHJwOaDhh9WB4aT2ZJmYjPUiUjrwrwP4p3o=;
 b=PqVofsWvvG0JrpLcudT1YVUI1Gmf7LarUiFn56msNbosj94n1m5FFQQGWZr118k1IN0XJVWcwoInzplphVAXh72EoG6tFwEP9jaQBR7MXo8oQYU20pKq1I03zlnMw4FcXbcAQDMfMqxNga2NvgblXThcc6KAICkKJRPoo4JdRVuVZZX4eWvFLrN7Ha/IubilLlPH0nZgp92gzh1jk3AoNYcgOG5Vu3CPcamzcRbSbGTZXkS8QCzc2cDjMCLZVfjShrUN+qzh77OsUBnZWvv0qQaf5xJQG1zVQ17Pqbo8DqPC+bjslboag4o0UqCwPJBaRBcDdZrzXaVGXY0lQU7xew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CYXPR11MB8753.namprd11.prod.outlook.com (2603:10b6:930:d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 09:22:01 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 09:22:01 +0000
Message-ID: <c031213d-a86c-4f7c-81f8-235116638291@intel.com>
Date: Wed, 11 Dec 2024 17:27:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: Fix qi_batch NULL pointer with nested
 parent domain
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20241210130322.17175-1-yi.l.liu@intel.com>
 <BN9PR11MB527673D307E992D5D69CDDD18C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527673D307E992D5D69CDDD18C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CYXPR11MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 54965bbc-325d-404e-e2e3-08dd19c5449b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dngzZVdjSy9kMFJyd1JzaktWaGRmdTYwWVpaMFR5N3VKVEVUdlVjNmg2TnB5?=
 =?utf-8?B?RzRYQjJqbmQ4MnJnUlR6NzlZRDBWV3doWWxobEFKVEpqNHJEanpkZDRoV2p6?=
 =?utf-8?B?VXhNTVJ6d0VsbDUyQ1praUp2dlNwTnNMZ05vMTlQZHl2MDR5d3FORFlTczlj?=
 =?utf-8?B?eW5EK1Z0QU14Zkl6dndRdW1iTXNHNGU1dHlZejd5M2ZSVi9XWk92SmJvNnJn?=
 =?utf-8?B?d21xZS9SekxDbEQ2UWZwUWwvSVhXSUJES2ZoMHhqeExiWG1wK1k4M3NTSUhq?=
 =?utf-8?B?bGFQdlM1NFIrTjIrQW9sRytZR0FycDBVK3gvUTN5cUlNVzZhRmpqWEJmY3Fx?=
 =?utf-8?B?YTVNZFRFbWhxL3dIMzMxQWgzbEZ5VWd3d1dhKzNBV1JlbHU0UFNLS01GN0RK?=
 =?utf-8?B?dzhJV3FvTk90M0wvY3dreE1WVitaVDFOazhSMi9uU2hCV1FzbE9QTHVBSGFR?=
 =?utf-8?B?aEdmL2hCU3N6UUc2VUlWNWdKV01wNkpYSGFGa0Y1RGFUZ2JReXhvU3c0NHBL?=
 =?utf-8?B?NjNBNFUvbW9HR1ZwV1lxK1dsbFc3Wm5XZDAxenZPdmxpUE4zUXpjS0NFZEkx?=
 =?utf-8?B?bkIvVXVCWCtsckJDeXRNTzlGam9nMmNQR3MwRngyUXltYzl1NEloS3loWEtv?=
 =?utf-8?B?aDdoWEx2UXpzZ3dUVG5FM3g0ZVRJWFE2L2lESkFSWWhIbHp1YnBGeThjMnJi?=
 =?utf-8?B?amMvR0E4anJCVjVvUnM2SVE5TzZmSFVHN0syQkcvemVieXlDQVc3blByS3Nl?=
 =?utf-8?B?OEx3VW42Yks3WXM2eXo0cW9jaGdPL084ajloZFUvQ1Yxd3NxL2NRL3Q4QWl5?=
 =?utf-8?B?NHNkSnJIRWlWZWJNcFFpRUQwVDVlQ1h0V0FTOS9PM0toNlpTOWdTZEJKUjJH?=
 =?utf-8?B?U3JqQmRuY3luTTgyY2h2bkJuRkVJTVhic3NkS1hxdVl1TmFWWDVnTGF4SDNC?=
 =?utf-8?B?Y0JXNVpYZ0NqTkw4bFE2TXZJN2wvbzlJbVFhYnIycE15SjMyejZ0Vk82TkEy?=
 =?utf-8?B?K0luZU56U0J3ZmFzbGQ2aDNhenh5aCtvU01IcEcxbU9LVC8zdVJmMTJvdng1?=
 =?utf-8?B?SmFZU29sWVlreDR6VHVUMVlJL2NrZFpETXRyZFZTRG0wR25oam1qRmdEQjU1?=
 =?utf-8?B?eWRmenRtZG9SWHNBTTA5QTQweHFoRXVFUjUydWEwN3dxdGJicXJlekRYNXpF?=
 =?utf-8?B?L2d0dnNDdjJwSUJNQWsxcnNFTmY4c1B4TUxybjdSWC9SMEZaaW9nTVF0Slky?=
 =?utf-8?B?VWRsWFMxdWEwOGltb3VpbmpmS3dlME5IUi9MNVBqakFka05iRVdsbzlnOUNB?=
 =?utf-8?B?c3FEVVFibCtsY1p3OHNSLytwMzdrTVp5NVZmT24wa1QvZkJVRTEwWHBQZ3hz?=
 =?utf-8?B?aElyL2VjZFFoMytNYWpCbys2UGw3SzFMdXkwSlBqZkVXd1B2eXFEdWV3SFFE?=
 =?utf-8?B?QVE5MExleE1LZTNLTFczemdQdm1XN1d4NGpUSDlOMHVURXNDWncvYlhMMlR3?=
 =?utf-8?B?d2Q2dkdJcWhRcTVaTGdZYmdEcFRySUFEdTdkcnpxZ2gxSEdINmUyTTZneVp0?=
 =?utf-8?B?NTBLTFRIMWd1VzZUS3hiSEpNTEFyTjhSN051cVdISG5GV1dxZ2ZlTlBXZG13?=
 =?utf-8?B?bnRuYWYyN1puT204Z0FCWkFwSU04N1QwUGlFTkhOZGdxM3A5ZUg0eXRSQ3lM?=
 =?utf-8?B?bGpKMzczcnRjU1F5YVBwSzJIWWJzWHYzVVg0cWVzV0ZhNmVzNmhxeUtBMGJI?=
 =?utf-8?B?WVhtdzV3NjUwTVdjb1Z0RktPbkxLNTZkUEZqUHk0L1pTNDNiYk9pNEUwRlQx?=
 =?utf-8?B?N2hoVzBVQWRaSE5VZHIzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVF3SFgwalhoZlg2UmxpVE42TVUva2Y5c05HZXQ4c3pkSkI1QksweVdqcGRk?=
 =?utf-8?B?TmhJcTE3UWkyQTlibGVnKzM4SnMxZ2dFbE14Ynh6RFYrSWc5SXNmV0xVbFNR?=
 =?utf-8?B?YWEwNkZGSkRBOU44Y283VVVycFNvbG42b01IZ3pPT1BRKy9Bd09XSXhOQUh1?=
 =?utf-8?B?dzZ6MzNQUUhDR2tGSnIyM1EvZCtRNWZZbXo4d21LWjJIekVydjlZbk9NbkZp?=
 =?utf-8?B?VXd6a0RqNk1NblBVemNwS0xNZjJRaHlkUzZsMTJBcU1RUlJSa2NmeUllNU5M?=
 =?utf-8?B?RHdIajVYNkpZWHF0VExHUFFLa0w2Q0pJUzhsUEo4WE9uSTRvcnZwa204SDht?=
 =?utf-8?B?bGd0TVNtbms3YWNNUzRqVk5YWEFjcGJyenQ2YjRYTFJXZVA2eTA3NW1aZzl6?=
 =?utf-8?B?d1JXcEswelVHUGlid2dweWU0UVZOYmc3Y0FTbXJHd0hVRWFGenBXeVlEcko2?=
 =?utf-8?B?b1pmcEhoV0t1OWJzRzYrRHhxZjEyQXNYcTlQSHJuem5FaXlid3dPZkZGbjAy?=
 =?utf-8?B?eWt6VTl2U1NrKy9yVkdoZU16MDZqRW4wVk0rRDM5aXNrV2Q5ZGhmY25WbjRW?=
 =?utf-8?B?bEF1WGhkdkFQa0YrazlZVXB2T1ZqY3B1TnRuWUVTUFhTNC96UksxRUdYL3dV?=
 =?utf-8?B?RXJsRTJpRk9QRTNjSzY3S0NpZ0FMSEVTN2ZrcTVMSktsTS9wM0ZJenNtZnNs?=
 =?utf-8?B?UUdXSzRoZkpFMkNuWFQ5QlorYUpxa2s0VU5GbzhCazRhc3Fybmp3NkdZZ0pX?=
 =?utf-8?B?Mk1IYXlvVStraUtBQ3ZjWG1LbW1GUkt2cVVSSnFaTmlJNTcxUHNmd2oyV1dV?=
 =?utf-8?B?VnBzanJKekVUUDRsTXVuS21ZYWl1YTJJQ0hzR29XUXVFVHgreXRRWm5nam02?=
 =?utf-8?B?NHl1UCsvbStCVk9FZ3Y4aDVTakRQN3U2aVVuak45WDRydXVHeGhNSkNpem5t?=
 =?utf-8?B?cnJTZWt5V1lQSERlOGwya29MdnZXazhaSFlVTDNOTDUrVVRDNkdJbUtRSVY0?=
 =?utf-8?B?NmEvRzl4R09WMk13cEQrQTI5TG9zNXFrYlZnVGQ3L3hvY1hzUUYzR2VwZjhr?=
 =?utf-8?B?by92NERaekgyWnlaNWQrZUU3WGVZNGU5TjVOaHJ3Skc0V2RTMHBQNWVHWHpo?=
 =?utf-8?B?M0M5OUhJbjBHN3k3RW5sQmlrUGpubVFLTERpcGJRN0kybURFcDJOTGE3anov?=
 =?utf-8?B?SmNudlRiNzhEZzB3QjFmR1k3OEhwWW8rN2NxckhiOEx0d0pxcS9zL3lrY0dO?=
 =?utf-8?B?ZFBhdE5pdFh2NnBoTmhhZWVHMVFzZUgzRDhBZ0ZUc3VucnZqWHFpdmpFdW9r?=
 =?utf-8?B?eWYxU0xVZytWZHBVelYxZzVaZUpCTXZWSEFxMmE4S01oZTJFUnpGZXVndlNO?=
 =?utf-8?B?OTFINnh1YWxvSlR6cllCdDVzdkxjMDNJZlJKYVI2eXpZSWlKdytpZGhEYVlH?=
 =?utf-8?B?dWVLUTdXSHAxbVVvWXFYYTZBVC9OdU9wdThnendoL1Y2UWJKazZJUk5CdG5U?=
 =?utf-8?B?dFBvemw2NmVkWjZ4bTB4UXdDSzhDa1ZlR3ZZejROQWV0QmZvb2NlN1RBTmZz?=
 =?utf-8?B?OGM3M3FrRzFzWWo1V2FXTkNRN29Dd1gxL2dhcTBxekpLb3FiQ21LbDFjS3Jo?=
 =?utf-8?B?RlFJdUhTenlRYWt1OWFGbEdra2J4U2FYT0kvR1lySDhVL1hWZExEUERHTitm?=
 =?utf-8?B?dDgreXJQMldRQ0RIUkE5R29LWGtMTWNWaDdXdjduQmtob1dIMmJRRTVqaXhZ?=
 =?utf-8?B?Qk9qMVhrSklqc2V2eHkwdGNRUndhZjU0a09nZTE4SU5IQ2NrSUg4TXBGektN?=
 =?utf-8?B?dVhKWCtBSDZ1WCtzaytKT3YvaHlDN3FKRFFjQ1FCVndtSlR4WUxydjJtZXNG?=
 =?utf-8?B?Wmd2TUxmMmhVVXl1aXZLL3BrM2NpUy9xVHNzS0pTRC9mVTQzbzljUlRFbDZp?=
 =?utf-8?B?R0pzUjIvcTVYU1h0MGh5SUJPWTI1RzBhbjgwUlhOTGtzOXV3amU4R1gwMGZY?=
 =?utf-8?B?ZUlRT1ZHQnFYVUNjZXJJTUpySStCZEErNGdLTXF5WnQ1eWozQjV0SEZuelBw?=
 =?utf-8?B?V1R6bDFpbDN5WUlnSnpFWkk4VXcyM3VMQnlzSURMTEpNK2M2cEFnQXVOZW90?=
 =?utf-8?Q?R4abl1rdATyEkx0C+RUvi2Ne0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54965bbc-325d-404e-e2e3-08dd19c5449b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:22:00.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzvCWGiTA7tVyhxbcdSNnXDqGeqIcFvm1F+wEGcYyi0wAil7pCwLHrm5573RB9eSPO6v1sP0sxaSfo0gqE9I9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8753
X-OriginatorOrg: intel.com

On 2024/12/11 16:35, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, December 10, 2024 9:03 PM
>>
>> The qi_batch is allocated when assigning cache tag for a domain. While
>> for nested parent domain, it is missed. Hence, when trying to map pages
>> to the nested parent, NULL dereference occurred. Also, there is potential
>> memleak since there is no lock around domain->qi_batch allocation.
> 
> Out of curiosity. In which case does the VMM try to change the parent
> domain mapping when nesting is enabled? I know this is allowed and this
> patch does the right fix, but just curious how it's triggered.

This happens when there is map on the domain. It can be easily produced
when userspace allocates a s2_hwpt but never attach it to device. When
there is page mapped to the IOAS, the mapping is then populated to the
hwpt and its domain.

In my test, I just allocate s2_hwpt with nested parent flag, and allocate
nested domain with it. Then I attach nested domain, and replay all the
GPA mappings to s2_hwpt. It hit this issue.

> 
>> +/* domain->qi_batch will be freed in iommu_free_domain() path. */
>> +static int domain_qi_batch_alloc(struct dmar_domain *domain)
>> +{
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	spin_lock_irqsave(&domain->cache_lock, flags);
>> +	if (domain->qi_batch)
>> +		goto out_unlock;
>> +
> 
> V1 discussion ends up with an agreement to use domain-lock, but
> not followed here. any reason?

Aha, there is a confusion between Baolu and I. So we had an offline chat.
We confirmed there is no locking issue using domain->cache_lock. And using
it is better then domain->lock since this is all about cache. I should
have mentioned it in the change log. :)


Regards,
Yi Liu
