Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832FA945
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 05:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768455861; cv=fail; b=DOE6DIOLMNtz1Rid/rVz49k8bXOJQF83gtwWlcoxQFPQmITWEwB7uB8S6PAr8EN1JgXzwuNtoMVYjX14EwmiAXuhsbVJOpml37sp6hOKjLXPDnyhl0XUUL9DnT7pEE9M9D69ApFSch2sh9tF5whIvdJVJnBCNNF0w2c6iCp42sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768455861; c=relaxed/simple;
	bh=/C5aNCJoWZM70coFtjRkmQXpvNrKcy0WdhpANromDQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d83lKE+ZgmekltlX7yAMwAFBGTDGHK7Msle9UDQsmnBEeHKcP1IwHDHrJ+j+xA7Jj+AeJtxjrZKm1hDZlwsBbyhTHzs1eqo2ZZq6gSCX7WiyO3F06e+qvK7Ckb8pc1y0ir2UVp2IkKHmfHr7JwHhxaU/9KZiGJMSQt8dGkUK4+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THd3RdQP; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THd3RdQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768455860; x=1799991860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/C5aNCJoWZM70coFtjRkmQXpvNrKcy0WdhpANromDQk=;
  b=THd3RdQPtM4JcVQRun0C+IMf5VZDEeNz3gMbVoYQYdN5V8/wyUsLUuOg
   /RoUiZ+KsAkQTwFJ0xSmHJRK5TFyoRqiLOjHV/LfHEatM6JVdELW45Thy
   Q0JUqdlhNpfaTo/eKdgRf9n5sD7Q3/OFgqu6mZmce0ETAggQDIlJJpxcC
   QMP8MgqvaEBnVux7AM/SpESjulia1ioLyeIrpMTQPXAy9K8npY4UDYrR5
   FtoBF2XdLCrxTsmNnRU9z1pNCk9Vg0d25YJcSRDbq7d4F3N9y6wXGjNG2
   3PkSjh9IzPcdgDN6EZxFqFHM7VP1bF8NMP9Ik3/Gm9+sDYCbq0oYtsjlC
   Q==;
X-CSE-ConnectionGUID: PaL4kr4HQxaLYaDdn3bV/Q==
X-CSE-MsgGUID: ZC4/H/UATMipbv9/wg/Vfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="73611764"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="73611764"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 21:44:19 -0800
X-CSE-ConnectionGUID: vInUeHYnRS6IZ8vjtgoctA==
X-CSE-MsgGUID: 20xT+fK1QxCaaWMcLXj9lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="242425592"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 21:44:19 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 21:44:18 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 21:44:17 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 21:44:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKquculKnU09NFc8EZGPNZw/dUCmlaR4m/DVCI3sjAor2XXuFROYHlIkoWVcywgq5a+bwFRsQ45ukZ5MGUvCJDFf+v7AHrpu8tWFrr+mCBo6rC0gQwsbEC9XqtY9kWQNKbn7p7czVTnQ6d+fUloySi9NOiRXiAKtsfeXvbKvry4zo7syvrj+dkFMg5uCOC7hy9P3LiouxwSZNwpaXKLL3MdUqahJFEFrhg/z6DqVBKPEdAMXB+5+k0mIAQJOcZsnIpimwixdoO69WeAYRXygy10owu74tjKrhdtjUa2inyFXrdmAu/mpCKJnrfbuwaP57XOLpXwc0GKcu52/XLzDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C5aNCJoWZM70coFtjRkmQXpvNrKcy0WdhpANromDQk=;
 b=RyvgLCh6vSzYZbXtBHVKiKWqnWbL+YvNSeica+gGwlkK7KQtXG3LxSm9sM4Aty0tRz2ymwMZwyjTrpvElAy2rEkOdSY92k5hL8JRMm25GHqKfCTKinrnkfOmJWYdmMh0cTldybkKBpHcHkU3lHnyAfR4kgMc8I+QpkFPGSK+VsFAKG9e+05dQ8jzw4nnXWljTtC6sOj43xDDv1yj5PVMBn6gIPUm5ATkR1nJZT1K23cvScEDMwDV6YhwgARQv56bH/0wWsKj2Wxt0mRzUSOC/pxDEyEYVdR2/7b7nlR4cSoIvACX+2N7ReZhweWC0rpj5b5ejv2iUlHXRITPzhbRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8372.namprd11.prod.outlook.com (2603:10b6:a03:539::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 05:44:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 05:44:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Samiullah Khawaja
	<skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Dmytro Maluka
	<dmaluka@chromium.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Thread-Topic: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Thread-Index: AQHchDk8uR0lu8XrwEKOIcSK4FCQmrVQfN4AgACsmgCAAA5hEIAAb+iAgAERgCA=
Date: Thu, 15 Jan 2026 05:44:08 +0000
Message-ID: <BN9PR11MB5276C98AADBE65795DAC5CB28C8CA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
 <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
 <ef58cd8a-504d-457b-b731-f7dfdba0e43c@linux.intel.com>
 <BN9PR11MB52760881132AD4513E32373C8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260114131715.GA961588@nvidia.com>
In-Reply-To: <20260114131715.GA961588@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8372:EE_
x-ms-office365-filtering-correlation-id: 527cc92b-20be-4b9b-46b7-08de53f91a82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VUtIWlNtTWlhbFBadXd3TVhFd3dsWG1peXpIalkwNldxOWJKWEhTVDZDMk1S?=
 =?utf-8?B?OEdoTUdBY05zUVhnSmJjNHFzcHBLb2JPUG4vQTRLVzhzZUVXVVdOR29zTDRR?=
 =?utf-8?B?WEJoL1JCc0xsT25ranRnUGpQbDEwTjBQTkgycFZmMkdCamJVMmNHOUhBMXVu?=
 =?utf-8?B?dGVucGdoQko1RndSWURTdHBNcDMrZjgvbXBSTnBVdGZ4aysrSUNoOUVxZU9j?=
 =?utf-8?B?Z2twK2M1REl4d3dydnZKREFjS0p4aUo2Snd0TDdONUZvK015VnEycktMQmNO?=
 =?utf-8?B?SXdRWkdVcHNUK1NsQjdVTS96T2hMTFc1SHgvNlhCWURveVg1VEhKWnp2Mmtq?=
 =?utf-8?B?SnA1MzJrNVh6d3pKVjhoc01ReHBrdmFoa1N2cS9sYkl6bmZ2MnZWMTR1SDla?=
 =?utf-8?B?V3N0K1dGWE9Lb3c4ell4MXYrT0NXUDZjeStGM09DWjlnTEVWMHlCTVViYzRB?=
 =?utf-8?B?TXZNUlNaUHNHSHhzaGxuZ3pwYnlEVDVSMWxtN2tQUUhqakxSZm15Q3VkRyt0?=
 =?utf-8?B?TUJUUm93UVhxRWxLbVdqemVQMkkzd0lYNDJwOW5iVHBNQ1prTlF3bGNiNm92?=
 =?utf-8?B?ME9aL1k1M2VXbENxQUVnQ01SRkM5UW1MeXNSemdJQ0RnN1dvbzJmWXNwaVFR?=
 =?utf-8?B?K2wxWEQrclZKYVJ0cUxQVWNuVk1YN3ZheGgwK1pIMExQVjllQ05NUkJ4L3lT?=
 =?utf-8?B?WFVuRGFPNzA3UUhZRlphUHhZRjhNN1d2THFTUVJuV1RvRzVKRDlHNnZuWlAz?=
 =?utf-8?B?cDU3MVFEa2dzZkREejlrL3BCUFNHTllkSzhtcVhRamlMajJoL1RaU1JWWWZp?=
 =?utf-8?B?TTlvQzRVaThpaUdMUloyakRPMjNzckROUFVrVmJsRjNab0xXU1Fkei9pWnhS?=
 =?utf-8?B?L3Nxb3EranBSQlVkWWx6cFRWYStoZmUvMGM5c0RTWTh3WjZNN0pVbUFxQXhu?=
 =?utf-8?B?TThlam91Q25Sbmhjd2Q3SkZFQTFab0hVemlHTGZneEpzeTErV0lmbFNuTzJ0?=
 =?utf-8?B?dEVyREpiUlJqdWw2QmE1QjJYTjRKaVhSMnR4YTJNa2pNY2pJRlQ5azl0SGty?=
 =?utf-8?B?Q3lCQlFRMjc5U0tFNHNUVVdIeDF0ZFh3L2JJYU10THRlamNhYUp1aDJUNjJ4?=
 =?utf-8?B?WWlLT3JGeUN5OENrUUNKOWc5OC9DRi91b29PaTRUN1dXRFBNZkJhaHhNWTg0?=
 =?utf-8?B?TXYxL0tWcnNXRUpIZkZCYlFDRStpdktxZFZKRlpxVEttOEhUaTlwUzkxR2l3?=
 =?utf-8?B?U3RUMFJkZXF4Ui96TWxpZkNtK3ErM1lrd0ovL2o2Sm1LWnE0QnBDY2l0SitL?=
 =?utf-8?B?TkI2QzRxT1ZJQU5TZ3NCZHd0ZDJ6ZHBKZUg4eEIreEFUc3J1N0JvKzJMMHJQ?=
 =?utf-8?B?ZFlmOGpuVGUwRllGVFhVd293Q2JrdDFpN2NBRFA4dU1kM1NjeFdTR2JlTHBo?=
 =?utf-8?B?T1k3ZGtXcFhjdzU1RERzTC90V2UxbE9FTkZram1OVnlFanVHajl6Rlo4dXJJ?=
 =?utf-8?B?bEg4YkdBQjJVOE0ybys2clMxSkFtWDlqRlg5cHJlNkJvY1pyUzE5WU52NGRx?=
 =?utf-8?B?UjlQRHFVNURteHl5OTJsTUJOeFhBcm9FTXAyci85Sml1WVpRTDU0ZkxZYVVr?=
 =?utf-8?B?Z3Q4KzJaVmxWZnZnMnNoejM4enRwbDhWQ0FpZENzV3pLdElDcHMwcjBRNVAy?=
 =?utf-8?B?USsvWUVCcXNJVGtCSVh5MjZSZ1FQUHFsRy9ZT1F3OVJVRkhSemo4ZmpHc0tI?=
 =?utf-8?B?dWhnOTIwM2d1QUxrYTlibWFzbkQ2VFJ2YTNaa1VIQlc5MWl6YVFpcHNiNzRz?=
 =?utf-8?B?OEs4TjRQN1FjbHlSQnVXa2hZVGhUaFRLUGdtWG8xUWZYYzdvNUgzUjZEcVBk?=
 =?utf-8?B?b2pjSWlXZXU2bzhFTnhtL1hpa1M2Y3FRVGpRM1B1Q00xRTJGNUtWc0lGckgz?=
 =?utf-8?B?dzB1Qm9Oa3lSTWlITzRKajY4Z0N2YkJGL1FLTVRDQ2RJcTg3aXVnVE5pMzRB?=
 =?utf-8?B?YXlYcHNYeTgyRzBOaE5ZeEY0ZDdHK0RZRHZ5TGxtZjZZRzUvbHBDUVpSQ0lZ?=
 =?utf-8?B?Y2F1eW5COEZNMzVJVlovS2R1c2J0WXcreTd2RCtZSmlwbVFzdUNPZjVTL3Qv?=
 =?utf-8?B?ZDEza2tBNmdVNnZmR01rc2l5aVBvcWR1bHBkZEJIQmM4VHJoRlVIOWMvMmQ2?=
 =?utf-8?Q?Ee/viWHSHBmNvOMRZaGMpPA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UElRK0o2K2FVN0txdkxPMVp1STFpcnd3Y3JRYU4wL3BDL0twVEVaUTBQOWxB?=
 =?utf-8?B?VGNsWVkzYXJlM1RRS2haZElVQ3ZDYk1ublNGUGFYcmRqNVIrWGhDOW5LZVlK?=
 =?utf-8?B?a3RTMHBVOFBPaGtzcThrQTBaclBndTcxcVR5NmhIWm0rRndwanpTb0NRUy9w?=
 =?utf-8?B?ZU5QbnFVOXlWVHZEbUN5ZXk3STlmQXdwOXpiNkI5RUdhWDFZemFUM2tHbmNs?=
 =?utf-8?B?dnFsV3o0dnoyamJIYVpVakx4MER0bnZZdGVrbW4xQ3dDU242RGNQUzVVajdM?=
 =?utf-8?B?M1o2UktIWm4vMDFQWTlyMjJGSmx4UjU2Yll4SjcrYTBpeW5GaDNOSHRnMDA2?=
 =?utf-8?B?azJJZzJZNGcySWlZQUlJaHpZYThpYXJrUlUwTTk1QXlnNklTUnVFSWtNVDBT?=
 =?utf-8?B?bW9Vd0puemgvMFZlS01RVDdsNU05VVMyVlNqanQrcEx5alZETTlha09oWEwy?=
 =?utf-8?B?ZUlkVXoyeTZCcUxuZkxXNGdFQ2JiQXljRUg0MmoyTmpOa2p5T2huWjZCK1Q2?=
 =?utf-8?B?bDlKektDT05mWTY5Z21ERDhnUCs1QmV0WjNQYk9wTXRtMFpxSkt5bVB0YWxt?=
 =?utf-8?B?eldHdnJyV3JlWklwaG4xWmFOVnhmTjdYYUJXOCtBN1p2MkYrc1Z6TTlRblFO?=
 =?utf-8?B?eFVQTXBsNUhZQkhlVWRUUmNoZmFyR1cxS1VFMzlBTnRnaEFqQ1Y1V2xnenBV?=
 =?utf-8?B?SFJLdDBiRUs3c0VpZDdRQVh3cS9lR2p2OWYzYzhjYnErUFFjOTZNa1VkcmJT?=
 =?utf-8?B?SlhNSEpqRVlHVitkNjNCSWsxb2lkSnhISFExNk0rUG9YVUFOTWpCSXBoL0Fr?=
 =?utf-8?B?YllIK0JXYnNjK0NQeVBjZThnV09oaTk5dUFGWjJRRGpDQWVjUnppL1MzRnYz?=
 =?utf-8?B?QURBVHlDQW5MSlVjZVo2OGhBTmxYWi9kcXJ0bE5KSCtUb1pyL09aY0g1ejZL?=
 =?utf-8?B?WDd5V2hHMFQyZjd5NSsxdEtaZmFybFprUDBMS0tXVFp0ZEhYSENpZGtaY1BG?=
 =?utf-8?B?TkRPcEFHOFhxN0lrRkRsU2ZBemVuZ0VXN1Z1T0xWaDNJd2JZN0tZa1hWaDVU?=
 =?utf-8?B?MXVUVzF6NUMrMUJUdGFIeTVmN2JyVEFxblJFVnFocFNtL0JvYUN0S0pjb2ZR?=
 =?utf-8?B?SkRHLzBEQWdZYVozRGVVOHJjOHZRNnkwQWlLUXVKMS8yREFDU1hSY1dxcXhN?=
 =?utf-8?B?ckpocHZhemVxVzJXQVZtY2RNMStVZDdSeFgxZVhpSlZnNUdFblRhVXBCdktF?=
 =?utf-8?B?Mi9QSlhNMmUralBhY2NtVCtyWCtwTytGbDFSR2d2eU1KZ0tYb2VaYjh1bWhz?=
 =?utf-8?B?a2RFcnczYnl4dmk1UC9LMzFLK1RjcWRSdXp6SU5scWFvZi9ON1BOam9Wb2h0?=
 =?utf-8?B?a2t1UTRoQlJrRUdyMU51K0k1R005MG43YlIyZ094WDdpdlA1R3VqaVFWWnI2?=
 =?utf-8?B?REg2UnVVZVQrQllsVlF6eXBDRXRFRGxUbldBWWc2N1RCbzVVWC9uUTRXeWR3?=
 =?utf-8?B?WnZQNlZVK0hXdVRONGJQeVZwQzFPNTB5b1ZTVlBJN1ViRkQrdTNzZXFkUW1J?=
 =?utf-8?B?c051Nm4weXdsL0pYSTJTZ1pnZFdXdGYrMGVPTkhOQ1ZYZGx2QXN5ajZjZXRP?=
 =?utf-8?B?TkJBbkxDWDM2OUdyblVTRXU5R1ViQnFPczZwWVJWTllCSkFQUzU4bk51aHJF?=
 =?utf-8?B?RjVwbnJtQmxTby9ZWWl3WTkyUDZKT2NNQ1dPRGN1dks0MThjZzZFNE9nbTlF?=
 =?utf-8?B?bTlQUjBzOGh3djdoYjJ4aWRHV3dxNDMzdHIrSC9INXBtb01oVkIxbjZYWisw?=
 =?utf-8?B?blhidG91MWlIY09Jd2VmUWVaa3phT0VZZzZ5dFRORENGaVV2bTMyUWFIUmVB?=
 =?utf-8?B?ZTlrNEtpM0tkaEorcGZ1Qis0ZGRJMWJ1Ujk4UzdMRnVISFhVb1BScFpPQ0pV?=
 =?utf-8?B?ek5pais1bTZiUXA4cFNaU01IUGswWTlCbVBoMHZETkZYbjZjYWlPbFVjQk5F?=
 =?utf-8?B?QzAwTWUrNmZrRDA3S1h0NHlxT0FTb0x6ellPbnRxSlM4WjQyMXNYY1U2RE1i?=
 =?utf-8?B?b1BJdUtHbFVhWG8wRGpVcHh2QXBvaGhjTThGVXJMUzNIQklQcFpmRGZMRXVJ?=
 =?utf-8?B?SmFyLzE2RXJKcnovRUNKSjRRcXhxZE1BMm1ya3FFTFNGSFN0VTAzMTNjUnE0?=
 =?utf-8?B?MTFQd2lBRXY5dmVyTlU0SjJZTlBRSjdKNloyQUYyTUhyRFB3ankxUnJZYzBI?=
 =?utf-8?B?QlhTeVBVVHFraTJxVjIzVVk2ZFBlWWI2MlpyUjhGWmpSQXI0OCt3UlB2ZkFW?=
 =?utf-8?B?bk5tTEtydHp5MWROZC94OWwwV3hHM0s5dGZkK1ZkOWp0ZTNMMS9kUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 527cc92b-20be-4b9b-46b7-08de53f91a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 05:44:08.9718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcSyEbTBBgeRMXEhmo/q6SrrBGOoY8yWgG204qKFw42nP+rOMKWAPy6g3xKUtMo3FhlPbgujMQRDsffIDm/Pvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8372
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEphbnVhcnkgMTQsIDIwMjYgOToxNyBQTQ0KPiANCj4gT24gV2VkLCBKYW4gMTQsIDIwMjYg
YXQgMDc6MjY6MTBBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gYmVmb3JlIGNhY2hl
IGlzIGZsdXNoZWQsIGl0IG1heSBjb250YWluOg0KPiA+DQo+ID4gIC0gZW50cmllcyB0YWdnZWQg
d2l0aCBvbGQgRElELCB3aXRoIGNvbnRlbnQgbG9hZGVkIGZyb20gb2xkIHRhYmxlDQo+ID4gIC0g
ZW50cmllcyB0YWdnZWQgd2l0aCBvbGQgRElELCB3aXRoIGNvbnRlbnQgbG9hZGVkIGZyb20gbmV3
IHRhYmxlDQo+ID4gIC0gZW50cmllcyB0YWdnZWQgd2l0aCBuZXcgRElELCB3aXRoIGNvbnRlbnQg
bG9hZGVkIGZyb20gbmV3IHRhYmxlDQo+ID4NCj4gPiBDb21wYXJlZCB0byAybmQtc3RhZ2UgdGhl
IG9ubHkgcHJvYmxlbWF0aWMgb25lIGlzIG9sZCBESUQgKyBuZXcgdGFibGUuDQo+ID4NCj4gPiBB
Y2NvcmRpbmcgdG8gNi4yLjEgKFRhZ2dpbmcgb2YgQ2FjaGVkIFRyYW5zbGF0aW9ucyksIHRoZSBy
b290IGFkZHJlc3MNCj4gPiBvZiBwYWdlIHRhYmxlIGlzIG5vdCB1c2VkIGluIHRhZ2dpbmcgYW5k
IERJRC1iYXNlZCBpbnZhbGlkYXRpb24gd2lsbA0KPiA+IGZsdXNoIGFsbCBlbnRyaWVzIHJlbGF0
ZWQgdG8gb2xkIERJRCAobm8gbWF0dGVyIGl0J3MgZnJvbSBvbGQgb3IgbmV3IHRhYmxlKS4NCj4g
Pg0KPiA+IFRoZW4gaXQgc2hvdWxkIGp1c3Qgd29yayENCj4gDQo+IFVubGVzcyB0aGUgb3JpZ2lu
YWwgZG9tYWluIGlzIGF0dGFjaGVkIHRvIGFub3RoZXIgZGV2aWNlLCB0aGVuIHlvdSd2ZQ0KPiBj
b3JydXB0ZWQgdGhlIERJRCBhbmQgY29ycnVwdGVkIElPVExCIGZvciB0aGUgc2Vjb25kIGlubm9j
ZW50IGRldmljZQ0KPiB0aGF0IGlzbid0IGNoYW5naW5nIHRyYW5zbGF0aW9uLg0KDQphaCwgeWVz
LCB0aGF0J3MgdGhlIGtleSBwb2ludCENCg0KPiANCj4gPiBwLnMuIEphc29uIHNhaWQgdGhhdCBh
dG9taWMgc2l6ZSBpcyAxMjhiaXQgb24gQU1EIGFuZCA2NGJpdCBvbiBBUk0uDQo+ID4gdGhleSBi
b3RoIGhhdmUgRElEIGNvbmNlcHQgYW5kIHR3byBwYWdlIHRhYmxlIHBvaW50ZXJzLiBTbyBJIGFz
c3VtZQ0KPiA+IGl0J3MgdGhlIHNhbWUgY2FzZSBvbiB0aGlzIGZyb250Pw0KPiANCj4gSG1tLCB5
ZWFoLCBBUk0gaGFzIGl0IHdvcnNlIHlvdSBjYW4ndCBjaGFuZ2UgYW55IEFTSUQvVk1JRA0KPiBj
b25jdXJyZW50bHkgd2l0aCB0aGUgdGFibGUgcG9pbnRlci4NCj4gDQo+IFlvdSBjb3VsZCBtYWtl
IGEgc2FmZSBhbGdvcml0aG0gYnkgYWxsb2NhdGluZyBhIHRlbXBvcmFyeSBJRCwgbW92aW5nDQo+
IHRoZSBjdXJyZW50IGVudHJ5IHRvIHRoZSB0ZW1wb3JhcnkgSUQsIG1vdmluZyB0byB0aGUgbmV3
IHBvaW50ZXIsDQo+IG1vdmluZyB0byB0aGUgZmluYWwgSUQsIHRoZW4gZmx1c2hpbmcgdGhlIHRl
bXBvYXJ5IElELg0KDQpyaWdodCwgdGhhdCBlbnN1cmVzIHRoZSBjb3JydXB0ZWQgc3RhdGUgaXMg
b25seSBhc3NvY2lhdGVkIHdpdGggdGhlDQp0ZW1wb3JhcnkgSUQuDQoNCj4gDQo+IEl0IGF2b2lk
cyB0aGUgY3Jvc3MgZGV2aWNlIGlzc3VlIGFuZCB5b3VyIGxvZ2ljIGFib3ZlIHdvdWxkIGhvbGQu
DQo+IA0KPiBPciBtYXliZSB0aGUgY2FzZSBTYW1pdWxsYWggaXMgaW50ZXJlc3RlZCBpbiBzaG91
bGQgaGF2ZSB0aGUgbmV3DQo+IGRvbWFpbiBhZG9wdCB0aGUgb3JpZ2luYWwgSUQuLg0KPiANCg0K
dGhhdCBhbHNvIHdvcmtzLiB0aGUgS0hPIHJlc3VtZSBwcm9jZXNzIGNvdWxkIGhhdmUgYSBzcGVj
aWFsIERJRA0KYWxsb2NhdGlvbiBzY2hlbWUgdG8gcmV1c2UgdGhlIG9yaWdpbmFsIG9uZS4NCg0K
b3IgaW4gU2FtaXVsbGFoJ3MgY2FzZSB0aGUgb2xkL25ldyBkb21haW5zIGFsd2F5cyBjb250YWlu
cyB0aGUNCnNhbWUgbWFwcGluZ3MsIHNvIG5vIGNvcnJ1cHRpb24gd291bGQgZXZlciBvY2N1ciwg
YnV0IHRoYXQnZCBiZQ0KYSB2ZXJ5IEtITyBzcGVjaWZpYyBhc3N1bXB0aW9uLiDwn5iKDQo=
