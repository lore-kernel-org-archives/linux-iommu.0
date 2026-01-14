Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04C35FF57
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375581; cv=fail; b=bBDS0mSY4tZEarrFEc5aiFAfXZ4OVdrL7RkSZwLrc3SvSu5VyRPDXS9kcGkwVNr+wR4LiUiMnnkP900EFuLNb1J8su5fIyYhUf5Hkc8b+H7QRZZmeAxvv6XmhxRCbH+EHo7iEIx7oJPwnS/xVT6KQYdA8RC575gWf2uaVEaAqmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375581; c=relaxed/simple;
	bh=y7n2Ssy7YYG1Y7EuFHwfHytdlp+ZvX/kZahGZfJD02s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxPvIaT/ToBUmJv+yZsj+VujsrfVlfEpaIo0C4sb/zB2qv4AMAXgPhpoTpfR6fEQd+eYrtnncr0XYsWIDIpHo25AzA/i2qoH4QZtql5Dx2VnrwK/H/+ZS4l1b70JXnZZ1xiGrK0b5SZistChFX5XBaZy6wtfQUB7lfJgurDOn3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ul13t6Sl; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ul13t6Sl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768375578; x=1799911578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y7n2Ssy7YYG1Y7EuFHwfHytdlp+ZvX/kZahGZfJD02s=;
  b=Ul13t6SlW/ZICoSTaYSNGrrnXS/DiwywdHEit3Lq2qm1EWqyYO4xOFW5
   V3x8dSK10xTXlgUBP/68PVvneFDkVqVXDwiGS1kpBlAPyVXmizRY35XqQ
   cQyJ+6ePzgLxmUEjcTf+mA6UdDYv/zO5htQz4W0R+COClVQCyzYe4hkr5
   eLESbQyLcPqgFYoV5+3MVYPzaG95hdGCt+WyXoWnQrNQGEaobby2yig2j
   6Fcz4hxNWQFTJMSVY24pEshvLMVA/XFEDZAFZApL+vr/L1t3arpnzLrjT
   0ZbIvHEie6UzcdxSBqvVNoxLSY28zs4xaCzIiuw/6PpQdIfwaZpFVQ3lk
   g==;
X-CSE-ConnectionGUID: uR/uI/KKTo2Uaoyv8G4Zxw==
X-CSE-MsgGUID: ZshOvQ8BRT+9UflZKNNg+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="68876400"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="68876400"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 23:26:14 -0800
X-CSE-ConnectionGUID: aOgvZBOQTu2zjQhYH/UbCw==
X-CSE-MsgGUID: V7j0xdGfQuaDa+GRgUnJ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="242138858"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 23:26:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 23:26:12 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 23:26:12 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 23:26:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZu3fSPLayCLteusSVCTUldJjmrMi2iSWL30Bks62rZjv25ooxaFy6LClvl7jyOz9yqtQQYFCUtoj8SkjCrQl9djpgmS+bGy7MPDCCh7StmFBw5Ypktl/eaPprkApm5uotcnC7kyKLBcw15DP0aglmNVrpAb8F8SRrP5+BIXq3bIGoOdDg2vmgLYMrf1opYUYwYR1bUEkWE1twtUmvOBrHLHlYmOiSxWvCtBAjWqrvyMfYs/6UIrbV1LLGkE4j2NUmNwL9CU1Kmsi7e9rc5IT5cJN0V6tIQc+p0XrEnTQYZIfWC5LL1T4qrjEiyz+6pBu6lxNlvvH/NBVvUgvx7l9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7n2Ssy7YYG1Y7EuFHwfHytdlp+ZvX/kZahGZfJD02s=;
 b=tI5/Mmok384qv+WX8rmLdgpod7He0lpulM73U4nb3Aig1GmOfrwlI68lzQwPnkWc6sOVsatIn3iO3ZMxwXXLrPsuK2Son4f4bijdvHTWh82F6Blxj15tP216H+iuRvRf9axl1KBlLxoaRS9iM29GijVJBB7EfVXos1zLdZzeFGSF/yQX7fmAnhpJ9M47w0L9zz68trDwAdIGNGE7NnJ0Ek2ypuGne7P4R/CdlcH3F/WLQP2kJQv0P0dcG175kDtiAc1udIrJDNn/xvQEaEy229OYE0xtkobBGoyZaynskCYY4RGIetjhjQ3Ul55OxpltWLM9ixPacdJwFw++31SBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA3PR11MB9226.namprd11.prod.outlook.com (2603:10b6:208:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 07:26:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 07:26:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Samiullah Khawaja
	<skhawaja@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, "Dmytro
 Maluka" <dmaluka@chromium.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Thread-Topic: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Thread-Index: AQHchDk8uR0lu8XrwEKOIcSK4FCQmrVQfN4AgACsmgCAAA5hEA==
Date: Wed, 14 Jan 2026 07:26:10 +0000
Message-ID: <BN9PR11MB52760881132AD4513E32373C8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
 <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
 <ef58cd8a-504d-457b-b731-f7dfdba0e43c@linux.intel.com>
In-Reply-To: <ef58cd8a-504d-457b-b731-f7dfdba0e43c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA3PR11MB9226:EE_
x-ms-office365-filtering-correlation-id: d022b22a-7f75-47b4-de51-08de533e30e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NlR5a1JBOXFTUU5aMFU3UzkrbXdQRWNWWmVORWx1RVBnanhMTTZXazNGd0No?=
 =?utf-8?B?YVNlZEtXcW5RSDg3WlJ6d2pXb2VaeHpVeXR1dUdRS0FqbG9CdmczVjAvWjV2?=
 =?utf-8?B?V0V3MVhpZEpMY2NBTGNCMFVsQko4QkF0Nmk5bVdIU1gzUlNKcmdJZ0JhT0gy?=
 =?utf-8?B?UkZzdlArdDZ5a0VqK2ZXRmhQN0d1L0tGdWM4aWpSTnBvRWpHTXphUUk0NXUr?=
 =?utf-8?B?VnF1MzdjTDcvTVVlcmtDU3ZWdjQ4QkY1bjJ0UjAzbjE4T1N6K0hJZW5WQkxN?=
 =?utf-8?B?Z0FEYkUxa3FTQkZVMkpRRXBTaTVMbXozcm5jdC9QeXNpOHp5MFphVUlVd3Rx?=
 =?utf-8?B?L2hPM1ZXYndrVmJzenZBeVRxTEtMbU1yYmRyZnd3MU5EenBPb2paV0dFVk9P?=
 =?utf-8?B?Rkh3YjVCdUFQUVkyblpDcXAzZ1V2VzVOY1lRUStQVDRtazY0R2MzUDBGUnBB?=
 =?utf-8?B?cVNwK25CWk0rWEgzQm9xYTd2NDVRT3NLdVFNN0swSWpEK05tQ084bi9vWVF3?=
 =?utf-8?B?T29ISlBXQzhlVmxsb0ZnQUVLSjlxZVJsWjRQR1JsRkcyNjliazJzckRsdHlM?=
 =?utf-8?B?WmRzZDVIMWFITGxHTEkzWS9UbUNJMW5GSm9odHU5RGh0d28xWHdaQ1BNUXNk?=
 =?utf-8?B?Y3Z5WjkxWUtsZ3AyS1FGZVpiQ0EwRG5oNXB5WUkzNGpLRk1rT1ZWbGlDSlZU?=
 =?utf-8?B?NS84a3RQenhqemV5Z0MwaTBYejR6MzlRalBwL1VHMkxaWUdtNEREVElaSVpO?=
 =?utf-8?B?TUp2YnZsQjBhS3FxQlZpVURjODVKWmVhUlcrQ2syZXA1U1ZncUpQanAvZi9z?=
 =?utf-8?B?ZHdPMWIrUEJDUUh4QWlTM3NxeUx3YVVVUVVKczNtY0dhVE14SlU0eXVnZFda?=
 =?utf-8?B?WE1rVnFIN3NTSTkyeXgvc0dhS3JCTE1qL0NTRnk2UFZpak5PN0l5RFhUSjNX?=
 =?utf-8?B?UDN3WDBsNU0ybEpsMGhUWVh5SnpSem5JMXRxa09pM1RzWksxRERQazhHZlJi?=
 =?utf-8?B?emNMbjBoMUV1ZFNzRlJBYTRkNlA2cWhtNUFsd1R3TXFJazRlV0RjZlk2YSty?=
 =?utf-8?B?MXFrdDE2T1o0d3hDOUoyYjFVckNiQ216dExGZWtORVJBem9TS1ZkR0kvb21j?=
 =?utf-8?B?WkszN1Q1RVJNcTcraWY0NDhObU45MW4xTDVVZXdyOTJydGxPMGYwZ1p4V1dl?=
 =?utf-8?B?REVTMFBYaE9KSEVQTWRFaUNzbDdlWlkzaFh6RFA5THprRHFBdXN0NXp5ajUx?=
 =?utf-8?B?Mm81WjhQZWpMTG1CdTNzUmU2c05vRm5pcXJuWFFHWXN6R2FpTys1ck4vMy9K?=
 =?utf-8?B?UmpWdmZkUXhxUzBlVDUycU1ka2JSR0ZiRE5iK1pmZFZOZ1h4TENwTW9BOWRa?=
 =?utf-8?B?MmR0aWJUMCtUbkpwSmtXNVpzZDVYNzdmampJUEtRKy9TalF4amZzRmlOa0da?=
 =?utf-8?B?VFdaN25xTWE2bnNTSVU1NS9nMkZhZ3ZiQ0RWeDBYeTVRdm1EL0RTNURqa0ln?=
 =?utf-8?B?ZzlnN3ZVQVZuRldYTlRqUzlJRHBmazNsbWpWUUtGVFpjTm9yZklCUXdqM3JV?=
 =?utf-8?B?cXVTSkpndW5vN1lubkxPTzNDNis5TVRYaUJuS0Iva1E2OE9zS0pFYUxISEhE?=
 =?utf-8?B?TUNLL0tZcFRWbE05Q2w1ekJkQVdDdHQvaDJWNzBXbUNKQ3c2WXY1VHErc3lC?=
 =?utf-8?B?RndSZHh3NEJLVkN4bXA5UWZQekpZUytsRktoUnpGY2hRZituMG1aa0FuNlBG?=
 =?utf-8?B?UlFVR1haSWpHbllnYkl4RmIyV0VaYUErSy9Vd0NvcTA5RFAvZ0V4Um93aXU3?=
 =?utf-8?B?QmprbnNiaXFHR3RFUnlXeW1hYWJUVis2UjNmZDRGRzRheUVkUy80OXh3MGVm?=
 =?utf-8?B?NEV4UWdWM3VsV3BTS2NOUlphRUx0MGJVaDBJTldPekJseUVLTVpPVWdxaFVz?=
 =?utf-8?B?eGYyajVKVEx3Zm9DUnhJQ3d2SkxBUWNla3JiNWpGYWVaMG9RR0R4eXdzUVdk?=
 =?utf-8?B?a0tQcmx3VWlUdjFZN0lyUWdmQ0MyeDd0eWY0bUpwaEh5L3lQLytYck42NzZU?=
 =?utf-8?Q?TTlChL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjVCNEZzVjE4QjVVZVJZZ0pLazl2WGtjR05UdDFzQnRKYWpHalNEV0ZBVWM3?=
 =?utf-8?B?M3g3anFQeE9ORXpkb0svZElLaTRwL2lIa04yYThZMXl2RkZaN1d3RkI0a3pM?=
 =?utf-8?B?bCtueHBXWHZQMCsxTHFwWDhRNVBzQ2h4VWxNRkZkSkU5Wjk5eUFySUU0VGpr?=
 =?utf-8?B?Q3FlVi83UkI4RlF6SnIwbW5hSXl3cUVvSGNNcXJ0YTR6Rms3di9GYkNoWVd5?=
 =?utf-8?B?bzFVT043NmxhODFURFltalpLY1htekE4WkZKQ3FGcnVCSjZMenlXanA4WWpz?=
 =?utf-8?B?N2hqemZYNktEbHV2ZTlsb1E0NHlodXY5ejRlQ3I5VkZTaWMvYkx3VEhrODF6?=
 =?utf-8?B?WDNaS0M5dmdDN1FoYTAzSU41TTA3YklNNHorN3pRSTVhajh1WXlYQkN2Ly91?=
 =?utf-8?B?Rk9CMU13Y0dqOFBwWFg1MGhpS25weDUvaHVnKzIvMFBqcnZ0NDZDbjFZNWgw?=
 =?utf-8?B?UGp5ZForZnVSUVBzRGFFbU5sMCtQUzEwSmxkRDRORG83Rm5UZUI4K2Y5WEJF?=
 =?utf-8?B?cDBxcEdMOUt4amJtM1NHNWpuNEE3SGRJOGdJM0o2ZnZFNS9NeHB3d2lJczh3?=
 =?utf-8?B?Z0tPQnZ1bTJrWDB0MDBISVRzcVN1YzlPd2wzaFFsYmlvb1NPcGpCc2JyRXc1?=
 =?utf-8?B?VkVrRXpzTWJZN1pxTkxSUVgyRDYxc1plNkpZZlJacTFxTEwwVkxQRFlvREh4?=
 =?utf-8?B?ZHgySkhkL29sQ0RSVkF6OWdjU0gxbGFHOVZyemtIY2xNT3pTZ3E2TU5hWHhX?=
 =?utf-8?B?UUwwWlRodERvWXBiRXR4RkVCaXozWFlGaUJmeDUyRkFqY0g0OHR1eWllL2pZ?=
 =?utf-8?B?SHhoMTZLRlMxb0d3WGZGRGx0RnFjRnVUL3NoTktjQjVCaVRaNFBCTElCeFJq?=
 =?utf-8?B?UC9PUnhsWTJhd2tra1doMVR6elY5WkxXZ3l4NjNUT0FjQmRLS09hNlMrMGhI?=
 =?utf-8?B?QnlObFFkS1dqZmFQdW42aGVmbi9OdWwxT1FTZzhkVm96QXZaMW9WbHVjc2Js?=
 =?utf-8?B?UkhsVUplTUlCVEJCYVExNzA1b0NSZmd4ZThFOE5manpsaDVvc3h1bE51ZGln?=
 =?utf-8?B?WERTK0NpZGVha0ZpbG5SSWxaK2RkOVJyKzRqbVJGVC9KR29EcFhhdE5BZ25h?=
 =?utf-8?B?aWlZaWU2eGk0ckswdEt5UUhVZVo3ZGZ1VVVPb2liMVQxcXlpVnd1dmd6T1lu?=
 =?utf-8?B?V3JwQWFDQVdnQU10T1lqQzRrWVpEcUlhZ2FwTVkrYm9aTWNoRUY3TXo3cVZq?=
 =?utf-8?B?VktnZWl5UmN3MmxhOHExY3oxa2Y0L1N5N2s5dzZZaEV0N0FVUkxQd3Bicyt6?=
 =?utf-8?B?dVUyalRsQ1Y5ZVB5b3NEWUtZRDVwelk0QkhVcExMVnJpTXZVaVprOEljd3lz?=
 =?utf-8?B?b255N05ycjJ3blZHZTNZT0R4YkJCeWZKeVRFb2svMC9xOStrUENXQk1qWUlL?=
 =?utf-8?B?MWVDRUdXM2cxMkNTc3pXaHFQczZ5SmV3eTdqb1VIaHpIZXZUczVFUlRQKzRU?=
 =?utf-8?B?em94aVNJRU5vVDZSM1pnK3llT2FjS0dWeFpCc001RzdaWjJrUEpDMnV4bjA1?=
 =?utf-8?B?N29keEYxRzVTZ2IxVnA3VEQ4V2ZyV1JrNXU1eGxEUkxzRTFZQmJ5bG5RVVZ5?=
 =?utf-8?B?Wm94RDB3dThGMWRtTmlrM3lEbndVUUE4WUxzTkl1bkxnTWVtT3ptWVpXaGQ3?=
 =?utf-8?B?c2hqdUV1ZUFRYWxGNUlFZ05KUmlxKzBieUZqclp0RENCdFgxVFNQT01pS0FF?=
 =?utf-8?B?RjB0aXVGVUJGN3d0ZHhpOWlUNCtxZk1jU3RwZlRIeUVYbUZxL0NoKy9qdGI5?=
 =?utf-8?B?ZklmNmZPN0MzVkp3RDlETURvT3UyRGFTeEtBV1dFSkZQTHk3aHdKYzVqNFVO?=
 =?utf-8?B?ZzBCZExTZ25mUW1aWmxpbUQxQWtVUk9KRnJVZFVPNjN4djhTTUh5U1ZoMXg0?=
 =?utf-8?B?Tm0vV2txVzhkby9YY3J6OE9GaGVwYzJZdWZ5TnlERTdCWjZVTGRsZmJGeGIr?=
 =?utf-8?B?cTRKVUNNS09IQi9namRYaHF1OFdtWXprRmQzVEozZUo3WHJ3aDE2MUgvZGZh?=
 =?utf-8?B?a3F2NDEzK2pjVkpsa2wwUEZCZm9iVkt0RVhLdzMwVzhvKzIwWXNnOVpXMzQ1?=
 =?utf-8?B?aXdHeDgvZUt5aThlOWtVUDE1TkIwMHJwYXZyS3M5WE1kNkZWTUhJRnluTWQ3?=
 =?utf-8?B?RGowemZBZWZ0NGRiVjhTVHFGVFdpMjJVOG56UXEvbWdkNE9mcW8xVFRiOEhr?=
 =?utf-8?B?Vy96K2V5cnRBNjdaOWg5dnJaSGRzVGo4eEMrUHZtZFA3TXhSaHZ0UnU3Mnpj?=
 =?utf-8?B?djBRRnVXSjgxZXpKS3BPVWpEOTBaZWI1MTNzek52dFpCMHRiUVRBZz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d022b22a-7f75-47b4-de51-08de533e30e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 07:26:10.6085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcvR2SK6mObFt3iuwk9NiO/LiUdhhqJhImbPJioFGzuGtAmcCqK6Jiq/4rvx/+gxB8hGhWLKm2ny+lSpDKAhoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9226
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEphbnVhcnkgMTQsIDIwMjYgMTo0NSBQTQ0KPiANCj4gT24gMS8xNC8yNiAwMzoyNywg
U2FtaXVsbGFoIEtoYXdhamEgd3JvdGU6DQo+ID4gT24gTW9uLCBKYW4gMTIsIDIwMjYgYXQgNzow
M+KAr1BNIEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4+
IFRoZSBJbnRlbCBWVC1kIFBBU0lEIHRhYmxlIGVudHJ5IGlzIDUxMiBiaXRzICg2NCBieXRlcyku
IEJlY2F1c2UgdGhlDQo+ID4+IGhhcmR3YXJlIG1heSBmZXRjaCB0aGlzIGVudHJ5IGluIG11bHRp
cGxlIDEyOC1iaXQgY2h1bmtzLCB1cGRhdGluZyB0aGUNCj4gPj4gZW50aXJlIGVudHJ5IHdoaWxl
IGl0IGlzIGFjdGl2ZSAoUD0xKSByaXNrcyBhICJ0b3JuIiByZWFkIHdoZXJlIHRoZQ0KPiA+PiBo
YXJkd2FyZSBvYnNlcnZlcyBhbiBpbmNvbnNpc3RlbnQgc3RhdGUuDQo+ID4+DQo+ID4+IEhvd2V2
ZXIsIGNlcnRhaW4gdXBkYXRlcyAoZS5nLiwgY2hhbmdpbmcgcGFnZSB0YWJsZSBwb2ludGVycyB3
aGlsZQ0KPiA+PiBrZWVwaW5nIHRoZSB0cmFuc2xhdGlvbiB0eXBlIGFuZCBkb21haW4gSUQgdGhl
IHNhbWUpIGNhbiBiZSBwZXJmb3JtZWQNCj4gPj4gaGl0bGVzc2x5LiBUaGlzIGlzIHBvc3NpYmxl
IGlmIHRoZSB1cGRhdGUgaXMgbGltaXRlZCB0byBhIHNpbmdsZQ0KPiA+PiAxMjgtYml0IGNodW5r
IHdoaWxlIHRoZSBvdGhlciBjaHVua3MgcmVtYWlucyBzdGFibGUuDQo+ID4+DQo+ID4+IEludHJv
ZHVjZSBhIGhpdGxlc3MgcmVwbGFjZW1lbnQgbWVjaGFuaXNtIGZvciBQQVNJRCBlbnRyaWVzOg0K
PiA+Pg0KPiA+PiAtIFVwZGF0ZSAnc3RydWN0IHBhc2lkX2VudHJ5JyB3aXRoIGEgdW5pb24gdG8g
c3VwcG9ydCAxMjgtYml0DQo+ID4+ICAgIGFjY2VzcyB2aWEgdGhlIG5ld2x5IGFkZGVkIHZhbDEy
OFs0XSBhcnJheS4NCj4gPj4gLSBBZGQgcGFzaWRfc3VwcG9ydF9oaXRsZXNzX3JlcGxhY2UoKSB0
byBkZXRlcm1pbmUgaWYgYSB0cmFuc2l0aW9uDQo+ID4+ICAgIGJldHdlZW4gYW4gb2xkIGFuZCBu
ZXcgZW50cnkgaXMgc2FmZSB0byBwZXJmb3JtIGF0b21pY2FsbHkuDQo+ID4+ICAgIC0gRm9yIEZp
cnN0LWxldmVsL05lc3RlZCB0cmFuc2xhdGlvbnM6IFRoZSBmaXJzdCAxMjggYml0cyAoY2h1bmsg
MCkNCj4gPj4gICAgICBtdXN0IHJlbWFpbiBpZGVudGljYWw7IGNodW5rIDEgaXMgdXBkYXRlZCBh
dG9taWNhbGx5Lg0KPiA+IExvb2tpbmcgYXQgdGhlIHNwZWNzLCB0aGUgRElEIGlzIHBhcnQgb2Yg
dGhlIGZpcnN0IDEyOCBiaXRzIChjaHVuayAwKSwNCj4gPiBzbyBJIGd1ZXNzIGZvciB0aGUgZmly
c3QgbGV2ZWwgdGhlIGhpdGxlc3MgcmVwbGFjZW1lbnQgd291bGQgbm90IGJlDQo+ID4gc3VwcG9y
dGVkIHNpbmNlIGVhY2ggZG9tYWluIHdpbGwgaGF2ZSBhIGRpZmZlcmVudCBESUQ/DQo+IA0KPiBJ
dCdzIG5vdCBuZWNlc3NhcmlseSB0cnVlIHRoYXQgZWFjaCBkb21haW4gd2lsbCBoYXZlIGEgZGlm
ZmVyZW50IERJRC4gT24NCj4gSW50ZWwgSU9NTVUsIGFsbCBTVkEgZG9tYWlucyBjYW4gc2hhcmUg
YSBzaW5nbGUgRElELiBTaW1pbGFybHksIG11bHRpcGxlDQo+IG5lc3RlZCBkb21haW5zIHNpdHRp
bmcgb24gdG9wIG9mIHRoZSBzYW1lIHNlY29uZC1zdGFnZSBwYWdlIHRhYmxlIGNhbg0KPiBhbHNv
IHNoYXJlIGEgRElELg0KPiANCg0KSSBndWVzcyBTYW1pdWxsYWggdGFsa2VkIGFib3V0IERNQSBk
b21haW4gd2l0aCBmaXJzdCBzdGFnZSwgd2hlcmUgZWFjaA0KRE1BIGRvbWFpbiBoYXMgYSBESUQu
IFRoZSBzcGVjIHNheXMgdGhhdCBESUQgYW5kIHBndGFibGUgcG9pbnRlciBtdXN0DQpiZSB1cGRh
dGVkIGluIG9uZSBhdG9taWMgb3BlcmF0aW9uLiBJdCBhcHBsaWVzIHRvIHNlY29uZC1zdGFnZSBi
dXQgbm90DQpmaXJzdC1zdGFnZSB3aGljaCBzaXRzIGluIGEgZGlmZmVyZW50IGNodW5rIGZyb20g
d2hlcmUgRElEIHNpdHMuDQoNCkJ1dCB0aGlua2luZyBtb3JlIEknbSBub3Qgc3VyZSB3aGV0aGVy
IHRoYXQgZ3VpZGFuY2UgaXMgdG9vIHN0cmljdC4NCg0KVGhlIGtleSByZXF1aXJlbWVudCBpcyBi
ZWxvdzoNCg0KICBXaGVuIG1vZGlmeWluZyBmaWVsZHMgaW4gcHJlc2VudCAoUD0xKSBlbnRyaWVz
LCBzb2Z0d2FyZSBtdXN0IGVuc3VyZQ0KICB0aGF0IGF0IGFueSBwb2ludCBvZiB0aW1lIGR1cmlu
ZyB0aGUgbW9kaWZpY2F0aW9uIChwZXJmb3JtZWQgdGhyb3VnaCANCiAgc2luZ2xlIG9yIG11bHRp
cGxlIHdyaXRlIG9wZXJhdGlvbnMpLCB0aGUgYmVmb3JlIGFuZCBhZnRlciBzdGF0ZSBvZiB0aGUN
CiAgZW50cnkgYmVpbmcgbW9kaWZpZWQgaXMgaW5kaXZpZHVhbGx5IHNlbGYtY29uc2lzdGVudC4g
DQoNCmkuZS4gdGhlcmUgc2hvdWxkIGJlIG5vIGlvbW11IGVycm9yIHRyaWdnZXJlZCB3aGVuIHRo
ZSBodyByZWFkcyBhDQpwYXJ0aWFsbHktbW9kaWZpZWQgZW50cnkgaW4gdGhhdCB0cmFuc2l0aW9u
IHBlcmlvZCAtIGVpdGhlciB0cmFuc2xhdGluZyB2aWENCnRoZSBvbGQgdGFibGUgb3IgdmlhIHRo
ZSBuZXcgdGFibGUuDQoNClRoZW4gdGhlIG9uZSBpbml0aWF0aW5nIHJlcGxhY2Ugd2lsbCBlbnN1
cmUgdGhhdCBpbi1mbHkgRE1BcyB3aWxsIG9ubHkNCnRhcmdldCB0aGUgYWRkcmVzc2VzIHdpdGgg
c2FtZSBtYXBwaW5nIGluIGJvdGggb2xkL25ldyB0YWJsZXMuDQpPdGhlcndpc2UgaXRzIG93biBw
cm9ibGVtLg0KDQpOb3cgbGV0J3Mgc2F5IGEgZmxvdyBpbiB0aGUgaW9tbXUgZHJpdmVyOg0KICAN
CiAxKSB1cGRhdGVzIHRoZSBmaXJzdCBzdGFnZSBwYWdlIHBvaW50ZXIgKGluIHRoZSAybmQgMTI4
Yml0KQ0KIDIpIHVwZGF0ZXMgdGhlIERJRCAoaW4gdGhlIDFzdCAxMjhiaXQpDQogMykgZmx1c2gg
aW9tbXUgY2FjaGUNCg0KYmVmb3JlIGNhY2hlIGlzIGZsdXNoZWQsIGl0IG1heSBjb250YWluOg0K
DQogLSBlbnRyaWVzIHRhZ2dlZCB3aXRoIG9sZCBESUQsIHdpdGggY29udGVudCBsb2FkZWQgZnJv
bSBvbGQgdGFibGUNCiAtIGVudHJpZXMgdGFnZ2VkIHdpdGggb2xkIERJRCwgd2l0aCBjb250ZW50
IGxvYWRlZCBmcm9tIG5ldyB0YWJsZQ0KIC0gZW50cmllcyB0YWdnZWQgd2l0aCBuZXcgRElELCB3
aXRoIGNvbnRlbnQgbG9hZGVkIGZyb20gbmV3IHRhYmxlDQoNCkNvbXBhcmVkIHRvIDJuZC1zdGFn
ZSB0aGUgb25seSBwcm9ibGVtYXRpYyBvbmUgaXMgb2xkIERJRCArIG5ldyB0YWJsZS4NCg0KQWNj
b3JkaW5nIHRvIDYuMi4xIChUYWdnaW5nIG9mIENhY2hlZCBUcmFuc2xhdGlvbnMpLCB0aGUgcm9v
dCBhZGRyZXNzDQpvZiBwYWdlIHRhYmxlIGlzIG5vdCB1c2VkIGluIHRhZ2dpbmcgYW5kIERJRC1i
YXNlZCBpbnZhbGlkYXRpb24gd2lsbA0KZmx1c2ggYWxsIGVudHJpZXMgcmVsYXRlZCB0byBvbGQg
RElEIChubyBtYXR0ZXIgaXQncyBmcm9tIG9sZCBvciBuZXcgdGFibGUpLg0KDQpUaGVuIGl0IHNo
b3VsZCBqdXN0IHdvcmshDQoNCnAucy4gSmFzb24gc2FpZCB0aGF0IGF0b21pYyBzaXplIGlzIDEy
OGJpdCBvbiBBTUQgYW5kIDY0Yml0IG9uIEFSTS4NCnRoZXkgYm90aCBoYXZlIERJRCBjb25jZXB0
IGFuZCB0d28gcGFnZSB0YWJsZSBwb2ludGVycy4gU28gSSBhc3N1bWUNCml0J3MgdGhlIHNhbWUg
Y2FzZSBvbiB0aGlzIGZyb250Pw0K
