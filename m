Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D6D17BA7
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726282397; cv=fail; b=P2Gvm4OudZHm2rNgrDqBWm4mwyQWC5gIVw5TvrQFqnhzGbytprV+PT2bPqvO077K0vTT2aJc+10O7SqlzELM6F6VBVjc5qa0IAVEf2ZN3JQvKsmfYEHwPixJ6eTn4RntEb6UNTXdPbvrdBSKaJOBNRkQgs4R5FCEaPQmXDf/Wks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726282397; c=relaxed/simple;
	bh=7Ax+cUDqyTzU4li8acm490KfrIpZHXWckz6Lpm9k2Ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qT2ZbIayvcttdvOV2+QvpusY2YVrMct0HVQbiXN6k0+lSVh2bOMFKVeeSXb7DyTWZzu4WSUnFQesmZZOZk57f7NqhsuJEUzp39TOykQyvhIIDSP+wyHQKiqvZzKdwYl+Q1GfDKjkKY+HsZSWahfz9jqSZAWkYOeo70agQ4Sv3fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCYjRoI/; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCYjRoI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726282396; x=1757818396;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Ax+cUDqyTzU4li8acm490KfrIpZHXWckz6Lpm9k2Ug=;
  b=iCYjRoI/JTnTObbXS+cVoPjioU7UXqt2828mJzFnyhZiWfO32wQ7n9me
   n2m5I/2+LCxk3XBxBRvf+cw33k7xyExHx9RQRHNEhVijB4fbBWjVPA0AE
   bnqxvG2pyF+XlmCnZGBrqb3IUviNyfzRiT5tzj6zzAAQaHsCjmTjPWKeO
   XWFPoDXq+YVzIrcNthXP8goBRtOo0OHa4tGdAqiCRdiwKyW/GBrRxCVs6
   uzQE0a8IP9U+tGr2K33dt5LJRUKYCcu2rzs8PCxsx4ele1aFtKrq3oHXJ
   12ykAEvKgpOFREk+642+usx2a3mvfI7YxKUlWQuWdkRLGi31FeuczINZJ
   A==;
X-CSE-ConnectionGUID: M1F0O4kQTXqSrGZoYZHI6w==
X-CSE-MsgGUID: e2ir4ve9Qe2lOwsQew1ebA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25351488"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25351488"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 19:53:15 -0700
X-CSE-ConnectionGUID: IU9H08HuTSqYGkB5DAEcNQ==
X-CSE-MsgGUID: aqYrooptTxWw6WvLc/xhqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="69058387"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 19:53:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 19:53:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 19:53:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 19:53:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 19:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zd0Bw4MEzhKiP4y4bkIVSpCojd5vpMbf4jQKcNPRa7mVZFqP3uQs3UQDdpsDpiwU8WZzsaFZ5E5V3Cu7R8qzcJAnUJldivldzw9swIsbLW11sGQdRPzCBSva/i6a8kGprPiYxhV76WMLeODBeujPI765/Cn85WR++KouN4st1Vc/s7S0HXzCNZCIByle86mUoOmMHN43VF1DXy4JftepQ3D7ydrSGLQIoBeFBZIPrNsEBN0uVjkc55QZJ5tzLNRk6AJbHKH4lvdbZncv2YgzBPPRBOjl9Ca5IzQcnaj6Fas5rdVddkxWxNC0sBN5jGRfQ/Br2cbMW6i+i9Ejp/UEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ax+cUDqyTzU4li8acm490KfrIpZHXWckz6Lpm9k2Ug=;
 b=JO6+kIM7ELUlZajyx7mkAl2PB7OUETvFTR50T2b0fp5vbGCbtLLiTHMSzc0f3wPzAWoA3kfZa2GKWCJlDqhYAdIG70/9roUY7hZ9v3ntTS6KIRoBWERfFqSnBRMAwFpMsVuhRCnhXa7nVRamde14j1BeF5reeiKdvGryj9dc0hHbMw9BWkIFY/WZeA4Uwt4qToe7pdXK/6Gt7x3nS90ywHHZJENQpYZnXex5mojDdnxT7Wn/ttCCfHoLbE7loUxshlITqROFt6/UEDvDg6+yGglqIBhHTucvkcpDmHzLqGsHwufYZoadujwjs+JtN4g8mRTH7Lo9Npbs5iS+4FCmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB8303.namprd11.prod.outlook.com (2603:10b6:208:487::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Sat, 14 Sep
 2024 02:53:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 02:53:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "j.granados@samsung.com"
	<j.granados@samsung.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen
	<its@irrelevant.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Thread-Topic: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Thread-Index: AQHbBdJ7/7CTtQp+20SlGBvfhvfxtbJWdAEQgAAIWoCAABlWQA==
Date: Sat, 14 Sep 2024 02:53:05 +0000
Message-ID: <BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
 <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
In-Reply-To: <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB8303:EE_
x-ms-office365-filtering-correlation-id: ffea4706-e009-4f16-e441-08dcd4685b3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OEE5RjZoZ2VuTnUxT1NEM2xkZkw4T2lXYjkxaXg5eGFuQi82ekVTdjBTMHYy?=
 =?utf-8?B?YVZYNU9Ncmd6L28xa0lFRmE5SUNhbDduV20xNzBoNVVnZEF6TVVKTXZ2VmhX?=
 =?utf-8?B?cjM2M2JYb1V5cFcyYmVSVmdrWEVyRnduZUNrRGF6U3hwdG1VbGtoS0JTY1Bw?=
 =?utf-8?B?UjArTWZLOWFNSDIra0NyWDdnY08xeEZ3bnk4Wlk3U0NGeEJSbzdEVlJseUhk?=
 =?utf-8?B?V20xYVV0TG9TdlRHYUd1aVQ4L2FtUVI1T1RqTFJoeFlaM1RFUG9FME9vdGlR?=
 =?utf-8?B?ZW9uRHF4UUhiV1gvYVF2UXlYVVN6VmJFLzdJWExGRVJ0Ny9DK0Zob3d4a3J4?=
 =?utf-8?B?SW9zVWwxRVJqWXFBeU1BMU9scndiRmN3YS90dEpNb3gwaUR6Q2JYK1g4TlM1?=
 =?utf-8?B?V3pKbnBIc2ovb1dzUXVBUWhEZ3Rma0NGbkxkQ01XZWRIS3ZCbHRvNzZxNjkr?=
 =?utf-8?B?L3NCUTA5M0N5dzVDNmpZQWlzWHJWYUJmRXVlZmR6VEEvYjRFd2tNY2xaOTJS?=
 =?utf-8?B?Q2VCUWlaaE5rbnBQQStuVnJqQllKd2FTZnNUSXB6UkVyQjYwZnQ0Ny9FUUNG?=
 =?utf-8?B?VjY2OFo4YlRIQk84OVpwUUNKZjRQcm1FUlJxdGtsbGlvdHkrd1hUZmFUbkRl?=
 =?utf-8?B?bEN1ZHd3K2R2YWxnVnlUWTJPRlVsVUFUOWNNLzFsK3FFR0pEcjhoOXQ4SUtC?=
 =?utf-8?B?WXpXMTlxUVZrcDFNT0ZjdWRZVG9LcGlrUFExRU1SZVhZeGovc1F2SnZWcmdZ?=
 =?utf-8?B?c0ptOFdkVHdxbjVEejhiUGxVQ2JkanNrcXZRVmNyQlN3bnNaNTZ0VWZKRDRh?=
 =?utf-8?B?UzZ1ZmJqbVRQZVhUWUU4ZlVXSnZzSTNieHpYRkJETTNHSGltYXM0ZWs5SEtz?=
 =?utf-8?B?d1dmWm1OYmNyMHdqSGltNng0SlhzUFZuQWZ5MmVrVGFQYWRVN2xoZUJ1d1pG?=
 =?utf-8?B?clFrVzZFelVCczI0M3B6bkJoZ25QUkdOTEZqMnBuTWhGL3BVek1nNFlFanhv?=
 =?utf-8?B?YzFLNmoyQ3NoK0Q5VlUrSE1HWUNJWGVPbTVzOERjV1JIT1IybzVXVTUzVFdW?=
 =?utf-8?B?ekdFSk80UHgvTnNjamUxajJtdGdLTGM0TE9NTk5qVnFicHU2S3kvdER3YVZs?=
 =?utf-8?B?Yk12R1hrUUNibVFUbE4zN2JtWTRIMjE3bHVVOGdrUTcvVURJTDFNVW5WbnA2?=
 =?utf-8?B?U3FvNTVKMnZOaFd1MUZ3ekJTdDZpS1VoL2ZHNGlYeFM4MmRiNmJ2UjR0SGFy?=
 =?utf-8?B?UlRUYjM5eTltNmVCbDVVaHF4Z2M3MXJGLzNMYVRGRG4zSVJSWnFtbnd2NkJI?=
 =?utf-8?B?ZnVFMDdQbGpVbkJ0akpXUzdlMzkweUppY3F1QWNkZFo2VDRoUXA4REtUT0Qy?=
 =?utf-8?B?MThud0RzZWhTbnBzUUFFazNuc1ZQU1E5TGtLZUJIVmdGZVozRGhJMG12UmVW?=
 =?utf-8?B?a3Y3cGJwS2NkMHBBL01aelJiK29iVmRQTnowUS9FZm41VzQwYmhkV2FTT2Vh?=
 =?utf-8?B?dUZHb2N2QzZWSHlRWW5TMEs5MXRMR3NrM2lFUjRUZTRmR1Z0QktXZDZZUEhT?=
 =?utf-8?B?WFJPaDhlMnBzRXpLVjhmNGtpdGx0bUF5SHJyNmFrNmNibGNUMDkyOElydzY0?=
 =?utf-8?B?a25GNWRzMERycGoycjlFK1ZRUFd4SHhOK0Z3dGZORllnRU1BVGJyZ3ZsTWJE?=
 =?utf-8?B?WjIrSTdCdU4rN3hFejM3RXZXR1QwNDdrUDQwc1JGQ1kxb05CVGhUa0V5OE1F?=
 =?utf-8?B?VmVObE9IZW5FcFQzYkFEUjM3NUltb1JIUzRqVmZ3Nlp1ZHJhQUxIWjVpNk5n?=
 =?utf-8?B?c2kwRmtLS3ZxdVBlUHNDWU44MTVqRm9zRlFEd0I5c1g4YTlGTTJtSms4b1h2?=
 =?utf-8?B?dEVRQ040ak5kbHN5NndibTdHYkplbWhTbiszWXVCZWcySGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0o2bmt3a1Q3R2o2ZVVZVWNqWWpLOG8rV3VldUJXR0FsNEpQVjVBYlBGNVZE?=
 =?utf-8?B?cjlDc1pUVnBlcllHWEpFSTV5T1FqdCtWUjBjMlh1b1dzQkVOSk55Y0NhaktM?=
 =?utf-8?B?eVVMY0w1SEFlb1ArRXM2M2NjZS9ocHJ1Wk4vWGdVQS9IR2czeGkzMjJhS1NZ?=
 =?utf-8?B?bGNpT1BrTnR6aWE2ZUhqb093em5Sa0tick5VSUE1eXh6TWVZQ1lraGJ4dkJy?=
 =?utf-8?B?WDJlekNtd0J1MVZpSGhFZXlEam9UeHIwYitXVVBmd1NKM21Ec3llK0hHS2k5?=
 =?utf-8?B?RWJ0a2tBL2V1dWFCUkIzWjdPOTRzTTJzZm5qTFd4c1pjdFV0WklJWmZaUWdI?=
 =?utf-8?B?T2dFTXc4ZWVBb25URDZqMllOdG5sR2Y2c1pldmVNY0RKNTNsRXp2UTZpZDV2?=
 =?utf-8?B?NmQzUzcrK2M2Sm1rdEhPOUMzZ1JRNGo0MWY1K2JFdWpIOUpVTklQWHg2d05Q?=
 =?utf-8?B?aE03d25TZlRDSnEzRDJ2M2JWM0dWZ2tMM3N3dUxQK0JHUEt1cjJJV2dVSlN3?=
 =?utf-8?B?eHdFWXk5NTNraG5scks5VnN0Skk2S09lS1dyWFg4WFpCdlNpdmphclVJa21z?=
 =?utf-8?B?QU1wbExTL2FhTUlFdHZyUnVpM3RsRURVWWNrQUphRGlTYmliSjcwL1FJTHpO?=
 =?utf-8?B?MjkvbVBwTS9JeEVpTTdsZmo0Y3ZrRWpBUVQzOVA4QjhXWENYMWFiQkZpNmFB?=
 =?utf-8?B?cTV2bkptVzBNZlBYNjIzKzlqcmpBZEh2UXdRWU1xZWl5dEU5QzZUdlRBaitp?=
 =?utf-8?B?WGgxcGpSZkh0R3BVR3MrODdvcURwMFNtUmtoZ2lndmx1eG1Zb01aamp5dTVT?=
 =?utf-8?B?YlBzUDRFSzJJUDlxaWI1cjJ2c0JZbmdYQ1dPS09YMDNkMW5lWXF4aUFqa2lZ?=
 =?utf-8?B?bmZCYlBWRTBMQ1FyaU5lWnAvdGNSaUZ6RlFQTjJrcnFiamZtK0tDeVkzQyti?=
 =?utf-8?B?TzdkdDFHNjRUSWwvbDRoSXU5b0JPbys5SXBGS3hzR3V4Y0hWR1MvUkxYdG5W?=
 =?utf-8?B?WWQzU3BNRWNQNEVUQjIrU3ZxbGR4NDQ4Tml5RkcxMWE1QVp6ME44SjlDTW1i?=
 =?utf-8?B?cHdYVE1QblMwM2Y0eGp0UndNeHhNUjVzOVVZNXhTWjFZK1J6MHJXOTFYZXFW?=
 =?utf-8?B?T1VGUUxrNER6MmIrcURyaWtHNk1ZV1Q1anl5dnVMazM2MEhYNjFRNlRXakds?=
 =?utf-8?B?SExRWCthcDZoWkpVcjF2UjBqRFY3TUVMRlFGam1va1FEWG5SMmNhOWFuMWxi?=
 =?utf-8?B?d3E5NjBTd0htYkYxMmYrTENIRkdxQWN2RVRFekVLUXlvbFAyVlJXekkva3hQ?=
 =?utf-8?B?eDhxcHo3aE0xK0swcURJbG13U3laOXhLWDFGYlBDT2hjR3BLVVJWMkhubFp3?=
 =?utf-8?B?SzF1STAvUVQ2TkZxcGhTZFRKUkh1enlKc251Y1kzK3A1UDZIZ1hZY0JCTFRy?=
 =?utf-8?B?djRhYTlmM3RyanptUHg4UDluK2xnTGUxcCtBUVNyR3d4UHBzcXpzZVdHLzZX?=
 =?utf-8?B?MXd5SnRHRkoxSFhMOVVQdU81UnNUQWs0SjZuVldiZ0tVcGhhSmZDTDZ2bC9w?=
 =?utf-8?B?blZnSWJwQmhJWGUxMXM2UnFPcmVlbUlJVU41RnhzZTExMFlJVEdzV3hnZ05B?=
 =?utf-8?B?VkFQdmFhbFVraDIzcjZKcWxXZTRrVGZLUGhySDhJRkRPOXBiQTFNcW9MMGt3?=
 =?utf-8?B?ZnVUYS9aN243ZC9hc0hQTEVqNU1YU09Ja1VSWkhKTzJqbmgxL0VDcFJQek5P?=
 =?utf-8?B?eHVGWDRVQjNLQkh4RTZwakZub2cyWmJYQWpuQ2E5Q0U1RkZlUTMwbWFGTUZu?=
 =?utf-8?B?bFpzcjNuQy8rZ1U1Q3FXb2gzeVJMbkpuQzMxSlJLWTNtL2NDaWgzRUpwOExW?=
 =?utf-8?B?bXVxdUhCVlhzR2lyS2xYbEdlU2VJQmpSRGNWS0NUYXF6ckx0d2pyNFY4Q2NR?=
 =?utf-8?B?OUhEcjRSUGV3cnpmVzFFMmJscEYveERUVVZkOENHM2plOVVrb0xKdUxUcmxG?=
 =?utf-8?B?YmR3ZXA1UjBMaTVKcHVWc3F1dGY2RFNxN0VrVFFadGJabFN6MVlYQkxnbXBq?=
 =?utf-8?B?OURoazhJRFYrVEdjendUZzI1TjJKTVdwbVhaRzFDVHFwcExVNmdLMURvS1dl?=
 =?utf-8?Q?vjdWpOHcy8AmRHTgTLAbLUTCF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffea4706-e009-4f16-e441-08dcd4685b3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 02:53:05.1645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixpBWbMmdy7xOTv3KchBUnJHSNVNNXLPDH+lLjZDVqn4vhxFM/t4OA1DmKZXS7NSnteRINauoeN5ETlZ+g+ZDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8303
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgU2VwdGVtYmVyIDE0LCAyMDI0IDk6MTggQU0NCj4gDQo+IE9uIDkvMTQvMjQgODo1MiBB
TSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEpvZWwgR3JhbmFkb3MgdmlhIEI0IFJl
bGF5DQo+ID4+IDxkZXZudWxsK2ouZ3JhbmFkb3Muc2Ftc3VuZy5jb21Aa2VybmVsLm9yZz4NCj4g
Pj4NCj4gPj4gRnJvbTogSm9lbCBHcmFuYWRvczxqLmdyYW5hZG9zQHNhbXN1bmcuY29tPg0KPiA+
Pg0KPiA+PiBJTyBwYWdlIGZhdWx0cyBhcmUgbm8gbG9uZ2VyIGRlcGVuZGVudCBvbiBDT05GSUdf
SU5URUxfSU9NTVVfU1ZNLg0KPiA+PiBNb3ZlDQo+ID4+IGFsbCBQYWdlIFJlcXVlc3QgUXVldWUg
KFBSUSkgZnVuY3Rpb25zIHRoYXQgaGFuZGxlIHBycSBldmVudHMgdG8gYSBuZXcNCj4gPj4gZmls
ZSBpbiBkcml2ZXJzL2lvbW11L2ludGVsL3BycS5jLiBUaGUgcGFnZV9yZXFfZGVzIHN0cnVjdCBp
cyBub3cNCj4gPj4gZGVjbGFyZWQgaW4gZHJpdmVycy9pb21tdS9pbnRlbC9wcnEuYy4NCj4gPj4N
Cj4gPj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzIGFyZSBpbnRlbmRlZC4gVGhpcyBpcyBhIHByZXBh
cmF0aW9uIHBhdGNoIHRvDQo+ID4+IGVuYWJsZSB0aGUgdXNlIG9mIElPIHBhZ2UgZmF1bHRzIG91
dHNpZGUgdGhlIFNWTS9QQVNJRCB1c2UgY2FzZXMuDQo+ID4gRG8gd2Ugd2FudCB0byBndWFyZCBp
dCB1bmRlciBhIG5ldyBjb25maWcgb3B0aW9uIGUuZy4NCj4gPiBDT05GSUdfSU5URUxfSU9NTVVf
SU9QRj8gaXQncyB1bm5lY2Vzc2FyeSB0byBhbGxvY2F0ZSByZXNvdXJjZXMNCj4gPiBmb3IgdGhl
IG1ham9yaXR5IHVzYWdlcyB3aGljaCBkb24ndCByZXF1aXJlIElPUEYuDQo+ID4NCj4gPiBCYW9s
dT8NCj4gDQo+IFRoZSBPUyBidWlsZGVyIGRvZXNuJ3Qga25vdyBpZiBMaW51eCB3aWxsIHJ1biBv
biBhIHBsYXRmb3JtIHdpdGggUFJJLQ0KPiBjYXBhYmxlIGRldmljZXMuIFRoZXknbGwgcHJvYmFi
bHkgYWx3YXlzIGVuYWJsZSB0aGlzIG9wdGlvbiBpZiB3ZQ0KPiBwcm92aWRlIGl0Lg0KDQpobW0g
dGhlbiB3aHkgZG8gd2UgbmVlZCBhIFNWTSBvcHRpb24/IEluIHJlYWxpdHkgSSBoYXZlbid0IHNl
ZW4NCmEgcGxhdGZvcm0gd2hpY2ggc3VwcG9ydHMgSU9QRiBidXQgbm8gcGFzaWQvU1ZNLiBzbyB0
aGUgcmVhc29uDQpmb3Igd2hldGhlciB0byBoYXZlIGFuIG9wdGlvbiBzaG91bGQgYmUgc2FtZSBi
ZXR3ZWVuIElPUEYvU1ZNLg0KDQpJTUhPIHRoZSBwb2ludCBvZiBvcHRpb25zIGlzIHRvIGFsbG93
IHJlZHVjaW5nIGZvb3RwcmludCBvZiB0aGUga2VybmVsDQppbWFnZSBhbmQgbWFueSBvcHRpb25z
IGFyZSBwcm9iYWJseSBhbHdheXMgZW5hYmxlZCBpbiBkaXN0cmlidXRpb25zLi4uDQoNCj4gDQo+
IFRoaXMgb3B0aW9uIGNvdWxkIGJlIHVzZWZ1bCBmb3IgZW1iZWRkZWQgc3lzdGVtcywgYnV0IEkn
bSBub3Qgc3VyZSBpZg0KPiBhbnkgZW1iZWRkZWQgc3lzdGVtcyBoYXZlIFZULWQgaGFyZHdhcmUs
IHdoaWNoIGlzIG1haW5seSBmb3IgaGlnaC1lbmQNCj4gUENzIG9yIGNsb3VkIHNlcnZlcnMuDQo+
IA0KPiBTbywgbWF5YmUgd2UgY291bGQgbGVhdmUgaXQgYXMgaXMgZm9yIG5vdyBhbmQgYWRkIGl0
IGxhdGVyIGlmIHdlIHNlZSBhDQo+IHJlYWwgdXNlIGNhc2UuDQo+IA0K
