Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760363CC7F3
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540664; cv=fail; b=FaEaawhTCj+mC/3ji/xvJxsUFgwNmHPRCfaB6YusQYHyccdwTmtr7y1QBcPw2Iqhc3Hz1bT3TVBmMFF8otOhmoAazZP1VuBrDGcdGknW87OGcq0zvMawH9cdToj6xCAajZSvHd4Ut6M6Y8khMS5EqWAkZPwBTwgJ1B+iar1xqNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540664; c=relaxed/simple;
	bh=Y5x1tfa0zOWDP8rq217nK/tJnaAuEVohNmt1ybUfUFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GZus19j0NfN+WR477HxHlHoLTIBi4Y+OYwPX5ghppATa7cJe/jv4XMukDd3Bc/nhMY421z/IpBgldRpXSlfUTySBD+cb1CnIak5DPf6LE2uLVw5wEpVMchwqkj1ileJJXhb6l5xaxPqgR8y2fy0/RhEdHNx0WyakLW/me9L7GY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjIigzbD; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjIigzbD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784540663; x=1816076663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y5x1tfa0zOWDP8rq217nK/tJnaAuEVohNmt1ybUfUFQ=;
  b=FjIigzbDgGWUjySAwKss+1cKxHK+HJhpKK5I5Od6xTuEEcmvtkMJ1zjO
   Gos7wVtjnDwyOq9yxRyeZLzbZDZHV08triTNyEk6J6lqkbLJ42WdhSGmA
   4lL3Tjg52oRj27kGeHGdjs71SacTHXOD+qU1L3DueBGY5UNN9pZE8IQIi
   TF8Hkgm3OcCLClhJ+k6S+fMC7DBW+izXfk+nCvjrEynScVvodYGyRTHwG
   CaYC4VkiN5i0u1wPiK9c3cgAuEElRKfSQGeheV0iWeLbasgxVXWNFgn5h
   W5I0/bol1lkVGG8A++uDAXmbl9Vq7hV3OpiJBtcR/KQlezEst7Q6YAalk
   w==;
X-CSE-ConnectionGUID: v/KU5JE0RcKQ9vKD17CTPQ==
X-CSE-MsgGUID: UIGI7QWMTVS6Psyl4inw+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="96630064"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="96630064"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 02:44:22 -0700
X-CSE-ConnectionGUID: gvvU3rfbTG+Egar2TFIX0w==
X-CSE-MsgGUID: FZdOtQ+xTX26BaRFhCB9Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="280692836"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 02:44:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 02:44:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 02:44:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 02:44:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=is469MhoedlVvQJyMXVSWn8/wZotX17gVIGxTCT4vSp1nbO/TRXphmfnGUYZJF1HbBJVP6KMfjP4C3gpmFu3w+uEIqobIH5rdTiDoA93FxrPIFk9UYZ8ruN6Yy5/PtD0OaztbmxfOsq+QOIbnSwYMz9mCpvidl6+Gj/FjMJxS1+X/k+RVY2qKQhD84qTvMw2wllwhEa95PlTYSJ+s2lOQx6wr18+mivZGdsngWUyH9tS/Pqft2vDotqV2yE4EV6aQRhOkc3cQ9aBgvZFa2cx8Zux5DnBE4l1v/YDGry+4rUPu1YiuVQ1g14c3wgnOFPxjvsdp//wG0S662o3TjAa/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5x1tfa0zOWDP8rq217nK/tJnaAuEVohNmt1ybUfUFQ=;
 b=elK6FHth7w4TBntQGKBCQvyeg6CEQC9MqX4FhEAo5JVbzEO3YTu+sD9IcRCwRyqnqxSytX2fDvUyXqI0IYa+/IEEd8U+0wdGsdX/diZBb9OdCb/ptjuL/ZHNlA8+ShHzhLRomvOtTybLoLmfqLwm+mHli5ObFN5zaixiPtRIA8GAVxxgoZGKytCHZAhbq0hsLdYhcq0ql0Lbpo5JVtNJk1EqeJ6iKqowM0TIlyLd3y8giVv2sA/O+M5OVO6IxFsCxfByMDveXHKtgHSg1a3g31j4T8gifCQghBwlUXLnDg5jvSNHyT1wFAym6V/fMRvXdrK8q7E1zyOAJeEZoX2Iow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA1PR11MB6919.namprd11.prod.outlook.com (2603:10b6:806:2bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 09:44:19 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 09:44:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH v3 2/2] iommu: Make iopf_group_response() free groups
Thread-Topic: [PATCH v3 2/2] iommu: Make iopf_group_response() free groups
Thread-Index: AQHdGCUnnWQ8Gm24yE2B6SWu8N2vibZ2KFKA
Date: Mon, 20 Jul 2026 09:44:18 +0000
Message-ID: <CO1PR11MB48352093A5F63B77D4250E8F8CC32@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
 <20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>
 <80BDADA0C8AB6928+20260720085017.3998878-3-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <80BDADA0C8AB6928+20260720085017.3998878-3-peiyang_he@smail.nju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA1PR11MB6919:EE_
x-ms-office365-filtering-correlation-id: b5ab3df3-efd8-4e3a-6935-08dee6437857
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: VDXE2YPyzHRI06xITAYjoNBpp2xuMkU8L5BZNPEW6s+VOZ7YEAq0Q2ShnuQGNpLXSqNLsro5jV2xfveFbzYws4cFWFK3V2uCNqjXOyPY7BDcxZlQl09ZIb2JYSMlKWrkp+pBXSwc8MYUnYeg66zwljOm76og2JWWXMdDM9d8brseRhMJWGPRP3rLZHbGKaK4It37/qHV7BaiCsHADISxoDO88QEABVM3qNlPlPbOap5S1ToXX8rRFH3lhGvveaic9l6vP/TndbZRdLLEYUPq2n/jJsYF5l1RwJLHlDvklnX2GHjyaUG7B7oz43P63mnaQB7dwu5Re/ssb08t/jjQte3eikt+tw5yT6bV6Ism71OkIYAsH2MIL8mvLwRbfadd4d1Wa4Y0cG+Up+kEzF2xXXAdFNhVPt40Y/GZuDUYaAFDsaSTiJCrJP49J2++o7U71pFsFxSOe354h/3gsb1X+gMTRxhasM7oFXocW1peuMFelfdC35UE7ltMMFBPLDVwf81qGMCqNzoG+xm49FPMToZZ93vvO0vSOYhGICGfqAP5IBLboGH35hS6R/l6E/oZEIN0cjE/9WyE2tcwVP+3rmf35wpRjhMLQyszT4AFU9LEyRJCjFNpb3frPqJ+4fnF+UEDYwq54lP3yRuZ3gNgi3vPuvSm+ZCNLvET/DMvmksJKfBu6G0feRnisBnePEUrXBNI6yF8Z7ZjF2JAHPuZP2+LQebDBOis2tWqVJzCB/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OMD/j+RNORcrJ+ZZWn/KmmYPmtlzGZxdwy9EUdqpsqM20B6AeU4q2WkCTAm7?=
 =?us-ascii?Q?AIAL5Vlznpif8RbQkXEdYt2LI0Av2ZTrwS7+gPTLAJggXrOd38eMCV02FsiP?=
 =?us-ascii?Q?3IZuOIa7mQW4E/NVyOKSAHdJFoD7istI6IrKr0xyJa9JCQPMEX/evRudFhv/?=
 =?us-ascii?Q?s/b6e/vV9JUcU1dFC4n/G9WxrKatWrTfD27tSljn76ydsCOeuPGAom156WDv?=
 =?us-ascii?Q?+wnm/V9sQtJyXfUtiG2O4smNOPTUWw+P5LzllsIxg4yW1SKmK2+nfWxkqO52?=
 =?us-ascii?Q?MfMyE1O+He6kZlIYX9FW+4cCiOFc4C+efTo/MoeP+3tyzj46xRmZ7MZRuEfP?=
 =?us-ascii?Q?y6VU1pmZDGCFpMKOgIr4BKRiQssczSRfDbgP+5Xc2LnP+5j3svzXdg8IFKxw?=
 =?us-ascii?Q?H39oWEr/xASc1IB9VclwDhj7Dixt3U3NEctEMQeEziF5EHXA7mJcsCMjeWap?=
 =?us-ascii?Q?oWY9ZVHSDw2MQlAfiSGIeGYBFy78nWUNeiKxBUNdxdjsteaARszaixrX6WJM?=
 =?us-ascii?Q?cMN0kC6ZfVGk5gJOxoLmQVUCJZf3wnnIWB81mFd6OVDhM5TUCLJxXm/J1k0/?=
 =?us-ascii?Q?8g/ufoDTHqZspApbIhK2L5tyubomItaIAyyNdWzzVgLY5q1qziYZ6sDN7Lxy?=
 =?us-ascii?Q?+aL5cxjDNnXv+Flm6+ziVmLIkSQhMWSrWtKX8umH2F5iELYYH1aISH2blZLQ?=
 =?us-ascii?Q?Kc3Avb9wcratYsDjTx3W97/HqM5w2yyTp8M1pCYE/IC8fhzf4fYmBD4wkuve?=
 =?us-ascii?Q?2TsaUlGYqS1ugo2Mr2ZICTnUkCX4lAcfCcHAw9RLV5gwAgDFFk7ImJVYGScu?=
 =?us-ascii?Q?gcpE4k5uTxP3jW3CAGLp8yT20uCrxtR5z3lIbWnzqS/T2P/6JlptxwVmYLmG?=
 =?us-ascii?Q?jlU+McxJkMQBw8MwbSLhRZQqfLIg3b/tYRB0L8l/wu/ts42DjTMyEDTQbZg4?=
 =?us-ascii?Q?lMtTf+tHNPpsqaI2DMmBUt68Fjnq7VSJGbNGW6iGtmch/PUpCsPWevod1DBR?=
 =?us-ascii?Q?yboYfV1hnnyUD3ei2m3a1TT53rujJDFDadFHqEZHfxGO7VpMG39Gi4OsmuWs?=
 =?us-ascii?Q?4rZf7F7kqrlSczKAmatN4ZUEcTHsdOPY4wDMrC59C9D0G/iJzPTWGLDUwKX4?=
 =?us-ascii?Q?eQiD3Bv5uFCcHTudHVxZj5rEvSasEXyFHcv5rEdBPFRCcr9TrB3N5g51ITfR?=
 =?us-ascii?Q?l1gSK4dBYmJN9O1/3LfFRenr+kf38+lxrrAqfPdKgxhFkewgF4hsJmw4FZdx?=
 =?us-ascii?Q?AzDULBcvRnRJ834j+sP70RG5tIBVIRqLEToUAolSmWxeA5CnGPsXonDi7NXO?=
 =?us-ascii?Q?Ly/sYXP2KvfOlqg059QlxtXi3TlaKZVTxG31CmJH4IpRFVhwnRUHLZTY8iDo?=
 =?us-ascii?Q?sweYh+sxIWArHyjvkh7loIBe0+9cdQG5ilNuzHQZmHslQ68sCwdDVW1PmKfR?=
 =?us-ascii?Q?OySISEiOKVamLpfCsSnJavlUEb3LJoYYQBoNq543xS5p6lV/MXSRUPTKJ4MX?=
 =?us-ascii?Q?+cglrZtiJiu4NmlZvcVbySmA59QxsEB5B2kIZUzTNcPqWqJFoZt/6dnx7kfQ?=
 =?us-ascii?Q?TRcdOiduTOYSxXPE7NzlJ9JTm7pjo1CuaXkMd8XUIFlWibFr07zhtSIXmxer?=
 =?us-ascii?Q?PwBZREg3Ooms2crBLl+Xrv17KzAq8gevwAO8Us4Q3JoRq3T1d0ZqNWd4KKSu?=
 =?us-ascii?Q?yCgvnEA1hylxFkrxdkgDMgh7nSTZczBaV9CYulqKZhpFy/dS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IT4CsexDtCz9O3ja+8YUFX4mQy8m6SALiPqBiPV9PaAnOQnZdaXoggmhzGZd8CeXFg5SvFZ4Q943H7vRyldHrhdA0Nx4Y1CKfGZtkLJ2hU7QV3Ti3a6yHGFTTovKWu8M9vqBjrSUtsh3ufvzyLuLIrkQADU/7RfU7ztcb0/1tXhGYHcBvyiCkWXWf4Q4dx0V9Iz7EDFieGOzl9EMJIQXSEuZmqFZCfH61zQueEKFWJ34cvsaFRFLOTHYOPywhb+3znzb015+hUjT2sYvdpESwhXXZTQPHBQiph1dKQVlmk5D/VzVVv2oDn8TZCy+fvclBWDNUQ2CsgqG+O411orRCw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ab3df3-efd8-4e3a-6935-08dee6437857
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:44:18.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niUV/PmadTnr33jfmuYGrzE+ikOy+jjkCcC8qxpBaa/0cxcL66A478VlOol3CldO54kg/+eoLWEF8MD8ZrXisg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6919
X-OriginatorOrg: intel.com

> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Sent: Monday, July 20, 2026 4:50 PM
>=20
> Every normal iopf_group_response() caller frees the group immediately
> after sending the response. Make iopf_group_response() do both operations=
,
> so callers no longer have to free the group separately.
>=20
> Split the response operation into a helper that requires fault_param->loc=
k,
> a helper that acquires the lock without freeing, and the exported helper
> that sends the response and frees the group.
>=20
> iommu_report_device_fault() retains its special stack-allocated abort_gro=
up
> handling. It uses the non-freeing helper, then keeps the existing choice
> between __iopf_free_group() and iopf_free_group().
> iopf_queue_remove_device() already holds the fault-parameter lock, so it
> uses the locked helper before freeing each pending group.
>=20
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
