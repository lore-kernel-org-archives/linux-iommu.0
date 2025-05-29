Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3B220F30
	for <iommu@lists.linux.dev>; Thu, 29 May 2025 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748499070; cv=fail; b=PHImfJ0I61fvNsJDxAz8o/h7G6PVmF8fbo7myulsdL52Tdy36sty8F1arC+hunUaw9VIURcT1i0RIaAzrzHN96tV3wnzqycl8zD3uZYiNzPPOCOdAkj2DzmZ6vsH7Jcq7lJIvtx0my0/rmaZFQC9mHUSaODoQIyDiHYfu2Bw0DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748499070; c=relaxed/simple;
	bh=rEnr5JAR25d7HMGFCWate03gfKt+/AcCwACzchLGirc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i4v5imLUPYlbSwNlXrSe8dIvl/jcGtE5Lt+ea6EuyMPfU1d5ArjZdgEOnVTAtwsTy2hH8nsmQCMciCZxkeQC1i6KFOqOJWh6XoVH3dCD9CXPU4LRYeCEuudgngqckS+amySbxjjCjUreuxxUMjkdwvczdqVtSXg/ZcmRaOblGNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4arJ2rh; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4arJ2rh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748499067; x=1780035067;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=rEnr5JAR25d7HMGFCWate03gfKt+/AcCwACzchLGirc=;
  b=h4arJ2rh6OE8n56Bj/zNGdjinaWxVw8vXKY2W85XWcQGVb9KvLiNYhdK
   vMmQN+q+bklCPMjfigavg+b8zhs6iLR+nwKleQYlm4J/LNrG/WXaRrb7d
   GtjIYJjj5TZszo5lRfsc4KrYQ+SmLr/TSN1i5/3ejhwDMyyQMIyCy7bUj
   TTeJtUKzfqhcTV9ay5+SQpjhAIcOsBtlnvTBXwq+g+h1IkfiPFAdyOM51
   61wdrcOjOzeDlHohAs5b5kN++0ID1mZq1wHPbl4o0+/wZrOarzIOEIRvB
   v7Dmcn5IWNVaWxd7tLpRvv7p8m1itcje7bZL2xagCxDgheqmlXfUJ8doZ
   w==;
X-CSE-ConnectionGUID: 5riwpMM2SWu2V6zrzBh58g==
X-CSE-MsgGUID: 97JC8AsHSFOvO9HjFH9ZvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="75937426"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="75937426"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 23:11:06 -0700
X-CSE-ConnectionGUID: O1KuNGoRSpyATAKahf0kBA==
X-CSE-MsgGUID: i7B28WtmTHei+wlTD+R4AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="148607877"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 23:11:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 23:11:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 23:11:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.88) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 23:11:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faPrmSvnludSlGJYips39AH6TrbVXPJ2FxmgI0v6pqURnw9l12+KAj3mht3MrELMR5J8vbpEMJ2vFQ98oS2M/KPBCxZnWgRsnSJAkviI2/5Y4Z31jiLQZwLT45GFoBiRKroK13sePmVn6kEJ41XbjX1tZt00FP1qmrZ6DBN+NxVweePHqzzmQRt7hEmN25sHC1tOwXderp54r+7LS8tWiX+mF+XRaJ2n7Yt7Cw0aHgQjRLcKXRAADwbFZFoqvpMuj1VbXljXYQ1aZUD6vValZui9QfqeDovOA36fKi0xWQUd1xOKXPqb18RuvCcgqqjMwU3EsqJyYHAYZCDNwJyVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEnr5JAR25d7HMGFCWate03gfKt+/AcCwACzchLGirc=;
 b=N1ilU4wDj0s+CK4Qn/QP7Qlj7utKMlc4Ig8MbM+5o3COu3K6V/Oh9VAdQxenzQETwx9D8Q2QTQDx6882p4twIewCq2wDoAVYst9bFZCZHYgk2lhjNqgs0mfYLhzTXFSlZhZjCYt5kUKHYd+ATvmOGalXVD3l35leU97F0qcHZMs28krkKet8vTAJm5Gc8vtajfslqzbyWCjffHRnUu3D6+V1yqGCuiVFF6dxg9IoLZqP0UcWMV8dUs3VX6Hdrxz2q88xoHl0eDP70NVy3vuaA2r41e9eLhqAXDoGWLRoINDZUl1fCi8Oh+zuNvKYZX0CPLdZUnxH98kX5WODqExc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 06:11:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 06:11:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "Wang, Wei W"
	<wei.w.wang@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "jroedel@suse.de"
	<jroedel@suse.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v1] iommu/vt-d: Remove the redundant logic in
 first_level_by_default()
Thread-Topic: [PATCH v1] iommu/vt-d: Remove the redundant logic in
 first_level_by_default()
Thread-Index: AQHby3jxlypDGlKlcUOjnKODrsdL8LPpI4qAgAAFqSA=
Date: Thu, 29 May 2025 06:11:00 +0000
Message-ID: <BN9PR11MB5276CFBD4CF795CCB3ADCD1B8C66A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250523081056.223082-1-wei.w.wang@intel.com>
 <01e5d0a9-715a-48d4-a2a4-2a0b5d99149b@linux.intel.com>
In-Reply-To: <01e5d0a9-715a-48d4-a2a4-2a0b5d99149b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6267:EE_
x-ms-office365-filtering-correlation-id: 7564c33f-6c23-4b9c-c48c-08dd9e77959a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?czRCa2YvRHRNbkhuL1RNWGpZLzNZbHNkWVFuTDlCSUlxNkE5UnhRNlZRbXRq?=
 =?utf-8?B?VEYxRWxCM0cwN0JDQ0JEUk4zR0RIV2t1QkVhSTZ1MjJCOHFFZkJjUDFob25S?=
 =?utf-8?B?RVhzVVMwaGlKNkRMVEg3VUpBdS9xelJ5aDBlaVFrcW1UQkxYOTNaS1hrNXlC?=
 =?utf-8?B?VmhKaXMwRnoyb0ZXempDQUFnQnp5T3pyUFNRc0Q4cC9VSUhQZDQyd3Zld3VD?=
 =?utf-8?B?NzNXVDF3bUI5UzM1RTB6S2pXMFFQRHQwUEgyK0hORU0yRFN5b1hwZzF4aWJa?=
 =?utf-8?B?NUsyNzlKNk1tZ2hFZWxTbldIZ21YU1JqZExIYWJhbm1rOXY2MWJ3Y3U4TU9O?=
 =?utf-8?B?VnlNRXJUdGNCNXFIRlBEL1dJcEJSNk8rbHJoeWczSTNrUm01SHluWWlsMlEz?=
 =?utf-8?B?OHhZNTUrSHRjMjlpRGEzb2pLVEF4aFp0VHZwRFNXOFRtRlRTMnVuNDdjVjRk?=
 =?utf-8?B?aDIzcXprMGdMaGh0T3luV1FQNVl1TXpOVWxYNzN4SE85cHFhVGlVaUVWRkc0?=
 =?utf-8?B?elJXRDNERUtXWmV1M0hibURiUENHd2RnSWc2aEhWRGQxUVdGVWhzMlp1angw?=
 =?utf-8?B?UWI1UXJEdnFqRER1dnVJL2tKRHpKbUJpM3ZtQWNNNnlpR01lbW8yRFZsNkhm?=
 =?utf-8?B?SkhvQ3g2QlMya1NJdjNSTVNiQ1VtSGdweE9UeXdwek02TFAyTGErWTFMOXg0?=
 =?utf-8?B?VmxTejQyd084NG5YSlBHaU1jVUNJZHV3R0NMcjVOL3hrRnRHZlgyemRyU0JO?=
 =?utf-8?B?cGlUTHl3b1R6NHNHQllzNit2UkRBNE5SY2VQVmg4aWVydDlLRXJyTVpOcXNL?=
 =?utf-8?B?ZW4wTnRwY3V5eDg0OHRTOFp1SUFubDlnTUhaUGo4OWZZNXVjSi92SWJ3ZFE5?=
 =?utf-8?B?eXpSM1hRZTZlOVozajlMYjg4NlBKeVJDNU9TMW1CbERFTFZteWIzVll2aVl2?=
 =?utf-8?B?YmJITEZlZHFsSlQ3Q1gwNS9ndllyRXdoY29WaWhxRC96ZTMzYzlMYWlzOVV3?=
 =?utf-8?B?VTNzdmZMT2szODJCMDFHTjVqR3djeUlOK1RIRGU2OGNVQno4NG9BM1ZxckQv?=
 =?utf-8?B?dG8rVml2ZDNLK1RSdWIzTmo0NGZMUUtFS1Fva3VyeTZIczZSejZzc1pRakJ1?=
 =?utf-8?B?aUhqOFZUYTJIVWpMNkpIZ05ZN1lTTVc5ZmdaNktBU2dSYzVXOXIzWkEyRXVu?=
 =?utf-8?B?QUphSFVqQW5qSXd2QXZiVXNlL1MxWWZFRkJWRUp3bG1aNzNrY0FDWkdzSUxi?=
 =?utf-8?B?VDdweWhZZGRxRnh4OGNyR2dmM25jZ25RbHlreU1hNisvSWlJdkVSZEtNWUs0?=
 =?utf-8?B?bVJaUnNrcHlTaHRHdko5OWZKZWlvLy9GMHVIaUdyQ0x3UmpLYzBJbnNvVEtl?=
 =?utf-8?B?RjAyTjF2OU55UmVpNFA3czRSRHBvQ044V2pZeTFDc25XQ2dvZ3ZhZHV4VEs0?=
 =?utf-8?B?NmtaSW9VRUt5UXdLUjZ2UGhsN0pKVGtELzVWOG5YSkQrNWI0TnJPZ09hMytQ?=
 =?utf-8?B?MW44RkdUT25VdVFiK0dyaFY4TTR4RzRob2lDdCsvTWFPSFhxQ0M5SHRvTDF0?=
 =?utf-8?B?V0JqYkt6VTdNRXdzUm9PUnRESTNVb0hhY3Rtakk3NEpnNXhnc3BsYkRsWHpT?=
 =?utf-8?B?eFAzWlZZQjB1b0ZHRFJSWmxFdnRTOUdaQzA5enMxdFBpd2tqNUMzRG1paU9X?=
 =?utf-8?B?eGlxNDZZV1U3aWYvT2FwSXNCbDF0Nlg1MCtLUjZXOHNhcXJadTc5Zk9KaW9m?=
 =?utf-8?B?R2pMOE5ScjhOYUhPSUduMGxsYUxCNFFRMjl4MG92dFc1aHIvVVFIOVVYT29G?=
 =?utf-8?B?MkNrbjY2WlJHNXlxQjd4bzB2ZlNIOTEzNFl5cVRDa29uczI3L0ljVkNwckZQ?=
 =?utf-8?B?VzFOTHRFS21GTFlkNGpFSit3MUpOQjhzMG5zNmp0UnpwMzdseFk1amJCWDIw?=
 =?utf-8?B?OW1HSExXc1pZY3dFekJGVitaT0N4eEFjK0d2RjUxTS9NMVNlTndjekxwblVH?=
 =?utf-8?Q?mjWftyPg5eZp6WqB6cxPuToBXGtFDs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE84eTc5aTFaRmxveWdEMEtDTDVkSFVSVHdHa2NNVlh5TDREYm1saDcyT0V1?=
 =?utf-8?B?SU1CWFVpb2hLU1ZMMDlEN0RaZnY0b2FKTDhlNDRVczNxL0M0QXAzdUI4Rm5v?=
 =?utf-8?B?b0xKSlVNN002UGUzOEROMjBydkxzMlZZWEVXTUlqU21HQ3hRYVNGdFlJSTF0?=
 =?utf-8?B?N0tzWVl4ZXdrcjhNalFIUit5N1lHU0ZxeHU1MDRhN1I1Qittc3pJNlBEYk1o?=
 =?utf-8?B?K3lXb0lDb1Y1WWNwR1NZRXBjNWNmRTJ1bWRNVlZ4NjVVZDFyaURPQ0dsS0c3?=
 =?utf-8?B?N2g1dXI5YkRWcUtQVUk0cWlsbGlVbVlOa1B6SmVsNVBXTC9lWkszdDAwcllx?=
 =?utf-8?B?T0tRWnJpNkVZaUNTYlZ6ajMrbWtsWE5qU1ZHSzhDdE9XVjk2cjhPV2Vic0JC?=
 =?utf-8?B?WjdkbkF0UXU1eHVuUXVDSkwyby9IM25CN1BnUUtxZUsySlJuNTRnVlNOWG1W?=
 =?utf-8?B?WXRmNUtCL3p0TFVodFpsL1FtM3R3RVhraFg0SWZKSGVkVFkzZGRNMm1SR2tv?=
 =?utf-8?B?ZG1rZzZqU3J1WmhSdTJhS0VDVDJrY3IzcHdTdUtGZGFwSE5heVZyWjlFQVA5?=
 =?utf-8?B?bXVweTlVZHNsSVlrN1BqbHZkbXRyVUtBVXFUUDlNeHFtRUd2RjlNVTZFNkQ4?=
 =?utf-8?B?KzZXMkJEUVMweTZEdEdadjF1N1ErK05sdGlrUEFIMTFxakI0eEpKMWZkcVlX?=
 =?utf-8?B?djFmU3A3d0RoY0lEdTF1aVFrMXZkeTBmN3Nld3hxK1dyS05Jc0FPVTJ3ajc4?=
 =?utf-8?B?ekYyVXNxanIrbGhsQ1NjT1BJVGx0ZUIzUW1CeXRTU2pkMFdxaHIrTVpDaEt0?=
 =?utf-8?B?VlNRc3hqb08vckZoYlNXUENRMlNSUzhBM285WWlDNW9iY21uTFhzZzlEUTZU?=
 =?utf-8?B?dGg1MGUrV2I4L2tnOGZXWjlSNG5MMnRhUTBxQlJHWUgxZWxhYzdKUG9MMGpV?=
 =?utf-8?B?WjVjSEZESmg5SVNLdWF6cXlLclFGcE9ydmppc2JNNDVMRThqVzRQc3ViNTB4?=
 =?utf-8?B?MERQOHNHVHFYcjdibXk3dEtDSlk3aXZRNnU2QXIyVkV1YjBZeUVteWEwOTc2?=
 =?utf-8?B?bkJManB5VGJ3dUVrWDJvVlEzcm81dFc5TEFDNk83QVlZZUxBZ1VLNUdYeEZ0?=
 =?utf-8?B?TEZ4QnltY1h3ODI3RmZvQ1pQZXlIZ3I5K1JtTUFDdEtPc3JqeWp0Y3A1bkc3?=
 =?utf-8?B?RVY5NUtkbU1nWGFLZGU0QlFRL01RQ1JYRkNZZWFzeUdEWVlXRXJrSXBxVnp3?=
 =?utf-8?B?N1g0cTc2eDFISUtvUEJ6WGZkUTIxTkZUTXhGUEZ2UnBkU0NyYURjWVFTMUVm?=
 =?utf-8?B?TFFSOVlmcXJEUEt4Y1l3bzFxTy9talpDMVJFRFI4TjJzallJdzlSeHdyUE9D?=
 =?utf-8?B?VW9pYTMrejlZNTlTT1oyZzJ6VGN3S01jYUFaT2VDa3craVdlK3h4Z1RiWDZU?=
 =?utf-8?B?NmVzR3lncjdka0VlVnBWOHAvT3Y2VHk5ZjB1aUZ3MVZvVGVscnVuRUJHckp5?=
 =?utf-8?B?aTkvMzZiclNHU09RdExtM1RjTWhTaG0rS25QNTgrSjJ1OHZXWmUwdjhVU3FM?=
 =?utf-8?B?WmJZOVFZZmVIMEtwMmYyeUk3UC9sRjY0aXYvS2xsQmprazRuaWsrVm9HZnR5?=
 =?utf-8?B?emlwbWE4T1dpUE1xTnAydjBOUC8wcGFFQ3UyV2gxamZVOTVFaGlMbm42MG93?=
 =?utf-8?B?ZE9sNGhqMUl3TTJCUFZydFlBN2NmQTVKYUYvUi9oT3VYZ293QTErSDAxbXlr?=
 =?utf-8?B?bFdKc2ZaS3lJNDltelJpeUdYRGdqMXpSVGV4Q1VlKzg3aE5uQnIxSDA2YmRm?=
 =?utf-8?B?Z1JpTnU5K3hEaW1nR3ZQVDF2Vm9kWHJUelR5N1hTb1BwenJ4bk5zVjBZcGFj?=
 =?utf-8?B?dmFzNS9sbTRnOW1la2VYS3h4MzU3Y0FzQVBKREQySzBKTWxSdmphNEVtUHFw?=
 =?utf-8?B?VnhLcG85QUpRUUI0VGlibXU0VUtUVkJwU0QrMm9hVHFNS2xCeVNyd0JHWkt2?=
 =?utf-8?B?ellUNFpPODYvdUtlQmx0YWRjR2xreDBtdW51alArSjNBdDExSnowdWVvWUQz?=
 =?utf-8?B?KzNHREhOZGlZZEwvUVVUYS9wQkxCSXZ6MVZsYmNibGM1Z2JNODVwL0F2WC92?=
 =?utf-8?Q?nauSxylvS4ayvT+bBhBtwRHQW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7564c33f-6c23-4b9c-c48c-08dd9e77959a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 06:11:00.4544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ZHn1Nst4+Iib2f1qTjcTIOCIK/CT9pU578KqmByXWBbhSxT9thf86ATIRMguC2G1pq7Xz2M1ENH7Ao5SBECAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com

PiBGcm9tOiBFdGhhbiBaaGFvIDxoYWlmZW5nLnpoYW9AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBUaHVyc2RheSwgTWF5IDI5LCAyMDI1IDE6NDggUE0NCj4gDQo+IOWcqCAyMDI1LzUvMjMgMTY6
MTAsIFdlaSBXYW5nIOWGmemBkzoNCj4gPiBUaGlzIG9yaWdpbmFsIGltcGxlbWVudGF0aW9uIGlu
Y2x1ZGVkIHJlZHVuZGFudCBsb2dpYyB0byBkZXRlcm1pbmUNCj4gd2hldGhlcg0KPiA+IGZpcnN0
LXN0YWdlIHRyYW5zbGF0aW9uIHNob3VsZCBiZSB1c2VkIGJ5IGRlZmF1bHQuIFNpbXBsaWZ5IGl0
IGFuZA0KPiA+IHByZXNlcnZlIHRoZSBvcmlnaW5hbCBiZWhhdmlvcjoNCj4gPiAtIFJldHVybnMg
ZmFsc2UgaW4gbGVnYWN5IG1vZGUgKG5vIHNjYWxhYmxlIG1vZGUgc3VwcG9ydCkuDQo+ID4gLSBE
ZWZhdWx0cyB0byBmaXJzdC1sZXZlbCB0cmFuc2xhdGlvbiB3aGVuIGJvdGggRkxUUyBhbmQgU0xU
UyBhcmUNCj4gPiAgICBzdXBwb3J0ZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgV2Fu
ZyA8d2VpLncud2FuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2lu
dGVsL2lvbW11LmMgfCAxMCArLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4gaW5k
ZXggY2IwYjk5M2JlYmI0Li4yMjhkYTQ3YWI3Y2QgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9p
b21tdS9pbnRlbC9pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5j
DQo+ID4gQEAgLTEzNjYsMTUgKzEzNjYsNyBAQCBzdGF0aWMgdm9pZCBmcmVlX2RtYXJfaW9tbXUo
c3RydWN0DQo+IGludGVsX2lvbW11ICppb21tdSkNCj4gPiAgICAqLw0KPiA+ICAgc3RhdGljIGJv
b2wgZmlyc3RfbGV2ZWxfYnlfZGVmYXVsdChzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11KQ0KPiA+
ICAgew0KPiA+IC0JLyogT25seSBTTCBpcyBhdmFpbGFibGUgaW4gbGVnYWN5IG1vZGUgKi8NCj4g
PiAtCWlmICghc21fc3VwcG9ydGVkKGlvbW11KSkNCj4gPiAtCQlyZXR1cm4gZmFsc2U7DQo+ID4g
LQ0KPiA+IC0JLyogT25seSBsZXZlbCAoZWl0aGVyIEZMIG9yIFNMKSBpcyBhdmFpbGFibGUsIGp1
c3QgdXNlIGl0ICovDQo+ID4gLQlpZiAoZWNhcF9mbHRzKGlvbW11LT5lY2FwKSBeIGVjYXBfc2x0
cyhpb21tdS0+ZWNhcCkpDQo+ID4gLQkJcmV0dXJuIGVjYXBfZmx0cyhpb21tdS0+ZWNhcCk7DQo+
ID4gLQ0KPiA+IC0JcmV0dXJuIHRydWU7DQo+IA0KPiBUaGUgZnVuY3Rpb24gd29ya3MgbGlrZSBh
IGRpZ2l0YWwgY2lyY3VydCBoYXMgMyBzaW5nbGUgYml0IGlucHV0c8KgIHNtLA0KPiBmbHRzLCBz
bHRzIGFuZCBvbmUgYml0IG91dHB1dCByZXQuDQo+IA0KPiBzbyB0aGUgdHJ1ZSB2YWx1ZSB0YWJs
ZSBvZiB0aGUgb3JpZ25hbCBmdW5jdGlvbiBsb29rcyBsaWtlDQo+IA0KPiAgwqDCoCBzbcKgwqAg
Zmx0c8KgwqAgc2x0c8KgwqDCoCByZXQNCj4gYcKgwqAgMMKgwqDCoMKgIHjCoMKgwqDCoCB4wqDC
oMKgwqDCoCBmYWxzZQ0KPiBiwqDCoCAxwqDCoMKgwqAgMcKgwqDCoMKgIDDCoMKgwqDCoMKgIHRy
dWUNCj4gY8KgwqAgMcKgwqDCoMKgIDDCoMKgwqDCoCAxwqDCoMKgwqDCoCBmYWxzZQ0KPiBkwqDC
oCAxwqDCoMKgwqAgMcKgwqDCoMKgIDHCoMKgwqDCoMKgIHRydWUNCj4gZcKgwqAgMcKgwqDCoMKg
IDDCoMKgwqDCoCAwwqDCoMKgwqDCoCB0cnVlDQoNCidlJyBpcyBhY3R1YWxseSB3cm9uZy4gV2Ug
c2hvdWxkIG5vdCByZXR1cm4gdHJ1ZSB3aGVuIHRoZSAxc3QgbGV2ZWwNCmNhcCBkb2Vzbid0IGV4
aXN0Lg0KDQo+IA0KPiA+ICsJcmV0dXJuIHNtX3N1cHBvcnRlZChpb21tdSkgJiYgZWNhcF9mbHRz
KGlvbW11LT5lY2FwKTsNCj4gDQo+IEFuZCB0aGUgdHJ1ZSB2YWx1ZSB0YWJsZSBvZiB0aGlzIG5l
dyBvbmUgbG9va3MgbGlrZQ0KPiANCj4gIMKgwqAgc23CoCBmbHRzIHNsdHPCoMKgwqAgcmV0DQo+
IA0KPiBmwqDCoCAxwqDCoMKgwqAgMcKgwqDCoMKgIHjCoMKgwqDCoMKgIHRydWUNCj4gZ8KgwqAg
McKgwqDCoMKgIDDCoMKgwqDCoCB4wqDCoMKgwqDCoCBmYWxzZQ0KPiANCj4gaMKgwqAgMMKgwqDC
oMKgIDHCoMKgwqDCoCB4wqDCoMKgwqDCoCBmYWxzZQ0KPiBpwqDCoMKgIDDCoMKgwqDCoCAwwqDC
oMKgwqAgeMKgwqDCoMKgwqAgZmFsc2UNCg0Kc28gdGhpcyB0YWJsZSBpcyBjb3JyZWN0Lg0K
