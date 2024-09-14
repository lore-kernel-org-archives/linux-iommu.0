Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550574C80
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726275182; cv=fail; b=b8wJe5a0/ApukWESHmn2XZJGZwginuYKmwCggg9OxLYjbCo5IOPHKjXtaZzElkgx/fmrPuUOVnwpT+esH6r59u7pn2ic2ZNMP3IjVYjf0Th6EKWGc94SMypI58jv60on9vsXch95OWp09PwjgonERJerzs8BD6hxJ1yOlMfb3Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726275182; c=relaxed/simple;
	bh=+vqiGGdgEVPoIV+MduBd3KdQ2ye98DGu0/vqeF/f2DM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GzvqidtobbP5FVo7D88ZWvlV17wnvCHY2uKqI2MZtAp0AInFKmy+8i08xO65t9HP/ehCA7XdMUVv1TnGBAr23UUhZyAhXGl+Pp55f6NFu8TSsEyw3h+pBHRSAkDoh8ItqEniUT4eagMI0LMoy07aPQkwuNiXB6dYRCYxoZJdal0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mw07Zhtm; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mw07Zhtm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726275182; x=1757811182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+vqiGGdgEVPoIV+MduBd3KdQ2ye98DGu0/vqeF/f2DM=;
  b=Mw07Zhtm9XmLsm2BKQ7Pzce0h2EBMnDdJNSIMeLduwx/peUxxRpIj/Ct
   /2WNALITB+WMitXuf2cmHJJDMV+4+MsU3YrtsSglz/JGDEzi6AKCH2Bvi
   aR/mwtZGEogTd9JaJgcv7FER/WcsRCoqbcsloMxowj6RWszbj3gdIFKdi
   ZRhDH/s3QrLfCReMiOkFPckxCozGC9DOfwqLnroIBuiZjvFDKQRRFbYQw
   8aOlvZjQURVcxj6Vf+8rS40xf1zcSxliEW2SR864IHdZxs75VYCxHr0so
   fHIa+7Guj6OyojAEnLaSnFGD+Khas/vsjiX3NQNPnhAQPaaVY5SVDGNHI
   A==;
X-CSE-ConnectionGUID: OHj827miRyegjvne7oB+dQ==
X-CSE-MsgGUID: mEW+U6j/T+eDefQfu5GGAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25286420"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25286420"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 17:53:01 -0700
X-CSE-ConnectionGUID: Vij8m65bSCadsF9KO5sTmg==
X-CSE-MsgGUID: 9JLpYWP1TAqEGZE6vOU8TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="67876554"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 17:53:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 17:53:00 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 17:52:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 17:52:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 17:52:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTp5WwrXj5R9prGF558GlYh+SPTFwSi13I0fh1o0loQJ7AIozoQ1p42j61tU8FTBqLnBuhZdCkCxmkCPHBn25UKd3hiaSXwwXUDekjhAbsC/YB0RjKD+DI+w7sPLQqT7HEcyTCiisljH2hc99t8wcucRGAYU89H4ns4pBSGTI55usHqF9H4AWXIOc93q23p9SI/E3v9iHWQienUY9qPJ8U60VFpKbL0bA0cJ2Q9gdlm3WO8Cxb2HNOIWR/Ks9o84usu3i8njW+j4HuaqSFho39sDVGdyIT2UxWoP9UqmlHrP8A0IMm2I2vnwEYua8E6Aenfcbb5k+uR8LBZejde9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vqiGGdgEVPoIV+MduBd3KdQ2ye98DGu0/vqeF/f2DM=;
 b=yMvqw8R/8i/xVYWv4chSz/9oygRdo2OIUFqdUIm3P1XgreSA6XZBGMF/YuP0riA2u9hSPTR9BX4JytH44DcT2r7aijjpD54pEd//iwypEwk9BY1RtdRdJYKMFZFODK1AMmgl0E71iXIBSW/vt1kAFF/Q19liYLOSIDCkxPxgp+iDsNCuQuoOsu5doEtE2TrhX5+iE+PgCFXwyl29dTJh82Ef6kZOticLU3OiwZwGaTx71YAfd3lz7lT3t23TAmcaA4w07dzpusnwhZS2DD7t6MaCUyyd+ZrxLVxgMfN/SktiWYVYP9328GqZnFmEQoBnfTVqZN8suvyuUNT/OJgIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM3PR11MB8683.namprd11.prod.outlook.com (2603:10b6:8:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Sat, 14 Sep
 2024 00:52:51 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%2]) with mapi id 15.20.7962.018; Sat, 14 Sep 2024
 00:52:51 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "j.granados@samsung.com" <j.granados@samsung.com>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen
	<its@irrelevant.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
Subject: RE: [PATCH v2 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
Thread-Topic: [PATCH v2 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
Thread-Index: AQHbBdJ0eGggWt18ykmKF+0GZ9jDebJWdR0w
Date: Sat, 14 Sep 2024 00:52:50 +0000
Message-ID: <BL1PR11MB527143B88CCA277624BDA8498C662@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-2-dea01c2343bc@samsung.com>
In-Reply-To: <20240913-jag-iopfv8-v2-2-dea01c2343bc@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DM3PR11MB8683:EE_
x-ms-office365-filtering-correlation-id: b6ddf7ed-8f5a-43ca-d99f-08dcd4578f3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dUFDTE1FME9oYUJuTGd2eTRxQUMxMERVUERXdmlGWm5tWmo0L21TUlgrZExK?=
 =?utf-8?B?MVV0MTZVNmpHOEZvTkJBMFFEQUROYWlna1FPakhSYXFQWVNTQWlodlFZWEd5?=
 =?utf-8?B?ejRrQlFGNUN1Yk9mQ05UQWJtM1B5bE9MbnZBRi96Y2M1c3gyM1lSckNvOW1P?=
 =?utf-8?B?VXRhbUs4cVJXY29YSEVrKzhlcjhMQXV6VmNad1lBWmhTODl2RFhHYS9vNEZE?=
 =?utf-8?B?VFI2bXhRVzk0WjRtMzZLUCtzMm9CV241UFlyZnVCZ1ZCaG9ISk51RC8rQTVr?=
 =?utf-8?B?NDdpa0IrbEFFUWhjNjFaRmlTSGhHVVJza1dTM3BxY0tCbytsSzFOeWtaanBY?=
 =?utf-8?B?UVkzSXJKT0FubjBhckJpRGc5TGtlR1ZYWVRYY040UGJSYlp3S0pGUjY3blJW?=
 =?utf-8?B?cExUdWJ3b2FLbThqbzgrZS9oUkcwaUY5dnlzMDdSZGl5OGtwcEIvNUNrZHRo?=
 =?utf-8?B?cUg4SGpZZS9uZWZnRXhhN0c5bHdlb2Z6SDhlSldpUnI1d0luVmZLT1dWSFQ1?=
 =?utf-8?B?OVA5WHBYMys3cWlBaHJiTXl3K2hHRkNDdTBwRTJ2dWJJRmE3c3U5ZkhPZlRt?=
 =?utf-8?B?STNXV1pFVkh6b3VZdjk2bUVURCt3RnlsWDJQUURrNmlBMGpDait2ekhPZU81?=
 =?utf-8?B?bnozVmFDRUhuUTBBeTdJVmtTekI4ZXMyTFRGdVljUXdHdG5TZ1ZjblIxVTJD?=
 =?utf-8?B?Yi9EOUI4cCtyaEpjM2pna3lmOURqWGJPc3dhRmZKR2RNRTJQS0tjaHZxVE5l?=
 =?utf-8?B?ekxTUEswd2Z5MVBtWVdhM3lKeUZrQWVLbDZkaGdBTVNnUzhYcXVmd2h4S1lh?=
 =?utf-8?B?ZlpOcFFVTjRCOGI2U1JabnFyTFdsQUd2VEM5djlkZUtWVUQ4WkJtakFxTGhC?=
 =?utf-8?B?SVNNbG9lZitDTEprN3IwYnRYTHAyeXJOSC9JTVhubmhKT05WeksxbnZYNzFv?=
 =?utf-8?B?ckVueTRnODZGRnc0YVFjR2NyREFUMms3cUQ2dTROeEpKSVRoM1VTQnF5VERC?=
 =?utf-8?B?UVlNcTVVYjBTZVhxQTZaSldWQndBYWUvR1ExaTJSWFNTR0Fac1d4dzdKUGxD?=
 =?utf-8?B?Q3Zab3NHd2Z4REZlSTdhcUUzMlYyZEdvdUJ5SUJrbFhtOEIvSW1VQkZ3bDJs?=
 =?utf-8?B?STAwaUVERU1DbG44d2JUN3FzOUJINzRCUmRyWUpGZ09lR2F4Y1lIY3pKZ3hs?=
 =?utf-8?B?Rkx5U3plTXo3TXRDaWEvOXN5SzUwUFpKSDE0Y0FOVkl4aEFBd1pPeE04YnJW?=
 =?utf-8?B?bHd2RzlsRmNFMUIrVjlFaFhueDIyaFhMbXozQWJCTTFrVFNrOUg2VXJNRmhv?=
 =?utf-8?B?cCtLTzNjT0R4cEkxcktMWkV1cEtSNEZGWUt6R3M5S3NUV3BKZFo4TTczWWdq?=
 =?utf-8?B?Vjc0RzZBZWF6bFJpRHcwSVFlNlMrNldQQ2p2Qm9BZllFQWtTSGUyenlvcngv?=
 =?utf-8?B?MFArVkRlbElqSlFpRzlMWUptZld6cnF1V0N5amY4RlVGV0tSc1lKcXpucGRl?=
 =?utf-8?B?N2xoZlFRdDRoM0t5QjJtT1c0Q1V3VDhoaVlGMEl3OXNYL200SDVSbnJFMHAx?=
 =?utf-8?B?cmhUcEVtUHhNV0g5aS9QTDI1RjVFR09zS3ZwU28weDl0WlRGekNRZTF5STd4?=
 =?utf-8?B?YURudysrYWtjd3VwVE00bmFDNk56d3dyNUdCdnE5NVNDTlVYUmRvL21GRks0?=
 =?utf-8?B?aWc1bUppcEJlRkdkWkJPdExHQW5qSGhxd0krdWNuaUZMTFYrMTNkVC9aOGZF?=
 =?utf-8?B?d2M2S0hrRjh6dnAzUmNGeVlSU0dLR1pmaldjM3RZZHptY203WTBMaUFLcURY?=
 =?utf-8?B?ZzZOazUvT0RkeTFicTYyYTVJYS94UUUxN2UyZU1Ma1JrQzh6bGMzM2hOemZE?=
 =?utf-8?B?RE1nRG1PcjZzUFJZQjdGMjRTSnNrREgzMDlNb2xkR1ByaFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjBpdXpsQnVYL215ZzI3QTFoV0lvcmF6ejhpVU5SbC9Bc3BlZkNqVVFmOHBB?=
 =?utf-8?B?cHZmcTlhMy93UHlwT3pQMzd5T0pISHNUZXlEOWo1ajlpUVNKa3VFVlFoT2Qw?=
 =?utf-8?B?blBsd3prZ3JyZnRZa0JZemdEdzE2eFdQK1V2ZW9BTFRmdHRmQXVHdjZwUnlq?=
 =?utf-8?B?MGdaVFJyaFY2aUppRC9mZmV1Tm5uWVpjeUY4ME14M1V6cWp1Q0Q3SmhMOWVT?=
 =?utf-8?B?SUZXelNHMVh6NStzcFFnbjg0SUxlUlZmUEl5WHloTUFTMjdJV0QrQ2t3RlZz?=
 =?utf-8?B?QmQrYVFIb1dvUW1taDdhZmRNM2Vicm1OTGVVaW9BczZuWUUyY0FjTXJJVndm?=
 =?utf-8?B?clRpQmcvZ2lkNDF2bk1VcEtGV1ZYTGpMRFFkTFdOWVJLNkg2RU1LN2JkRFUw?=
 =?utf-8?B?dFR5Z0lXUTdqY3pVdE53OTFBamE4M3N5OTNrZ3pVVlpYeHJtNW5FeXFSYlIv?=
 =?utf-8?B?WkpGV0s0OGJEQ3luNW1mcjd3bzBwMUUwSG9FZHNTbkV5QmZINjVvSVpTWkNY?=
 =?utf-8?B?My93eENGS3NEd1RJRTJ0QXhvVUJyQWN1NmkxS3N5QjhlMks4R2ZZU3hDVm9n?=
 =?utf-8?B?N3JnbXA4N0FTWmlHdnNFMnNOZ29KWWhEV0s0TWtPY1ZyWFRoTEl5UlNkaklw?=
 =?utf-8?B?NWNhaHlLTlVsSzh3WGdydWFpdkZWeVJvbkpqRDMySi8zdWJyd2RZY3hSek41?=
 =?utf-8?B?UDNuMS9FTi9wdGhtcEd6UzZacTg5akJtZ1lsME1rai9vcW9FN1FmNTR3WEg1?=
 =?utf-8?B?VmhoaG1JeExWZ2tGdW91Ry9hN3pKb0tsL1N2Z2JFMDVDdE93aVdZT0dLcGxJ?=
 =?utf-8?B?eTRHN0c1c3BkUXZiTnBFUDdzbXRjdjFzZTllQWdoeDA2Z2pqQVpZUElGbGE2?=
 =?utf-8?B?bThLWWFtNFM5d0V2TEVDYUQ3S3JSS01NMHBCaENvR3M0QllPMllIUzJpQVFo?=
 =?utf-8?B?Z242b3FkU2J5ZmRCOEM4eEd4N0FTRTFMY0pQTlE3dk9oSU95Z1Q4TmhOanFS?=
 =?utf-8?B?ck10bzBLcjdZODBveGsvM1QwSzJYMTArZFFZSkQyRE1EbEIzMGJQSTFlaHJ6?=
 =?utf-8?B?MEtyN2lRTHQyOVhIczJ4QlN2eDUzQ1lzOTFJcWNaVkprdUxvaU1GQ3hpcmdQ?=
 =?utf-8?B?d3BQWDd1dUVQM0VYZzJMRE5uMXJZL0l1THUzSWdSaTlvTGRhQ1V1V0FJaE5m?=
 =?utf-8?B?MEJKeE93MlgrQTRWK3ZFOTBPRVRETEE5V1VEYWRqYXM3RTY4RUtoNHpYeEdR?=
 =?utf-8?B?T3NOSWRLeHFMY2JEdm8ydm1pYjlnZ2JrL3QxOWFBcEx5NkluYWY1UW01NWNl?=
 =?utf-8?B?ZEI5eXpJbGJLU2dYYUNzKzByVHhvb0lXR0I2M0VkeEp4MnBXR3NqRzJZd3F1?=
 =?utf-8?B?OE4yWmcxR01HdjhJS0ZZZ2M0VkF2Q09wWGpoczZkQXJlc3AzTFMwclkvSEtP?=
 =?utf-8?B?K2x4bWx2WmUrRXlkUU10ejFOOVM3R3N5M3o5SU0xckR6VGpmRng0bld1cGdN?=
 =?utf-8?B?YzhpVHNkL1czREszRjFOeXRWVVptTE4vRFVuTzM4YjJnTjVyK0FnQklrWkRo?=
 =?utf-8?B?TGxvc0V0UDU2b2sra0tFSHh1eUdQT2xDbklFbjhRMWg4ZGg3MEQvdXJxMGNT?=
 =?utf-8?B?TGowTFJjT3ZxQmsxK1hnamZ6TWErTXQ1bkZvVGo2dFpnQjUwSmFybnordml0?=
 =?utf-8?B?ZzZqaExWZ0lVdDRnYUE5ZVkzSDNqUzNVVlA1SGt4eW8rZEdRQlJ3eC9LZUdT?=
 =?utf-8?B?Nk9vbzlDUG5jRGg3bmR6QW9GSklUUm5nZFcxTGZBSUs4S0FIcForcExwd3kv?=
 =?utf-8?B?TlQxMHgwV1djYUF1S0dLREVhMUZUYlB1ODBxOUVhQ2NJWEYzeHIxS3UrcFJF?=
 =?utf-8?B?RW84eFBLVFRYby9vVXIrMkY2Wkd2RVZ3aXBKM3VaWUF2TzR0YVUrSjJSNzNs?=
 =?utf-8?B?OFg2Vmg5S2VXalhIM1ZvRmhkVlF3ZXgrc3J5aXhWTHEwVjRFczRWTDVhNjhN?=
 =?utf-8?B?dVFVZzBKTW0yVVdxam5SQ09UeEticnlMeXJuRy9ZWVlTUkErQnRBdFhIU3VJ?=
 =?utf-8?B?ZVExNCs4SDMvcHhuN29WR0UrTFlJNHI2MFppZGZSaU5LL0JJekgvS2F6YTlC?=
 =?utf-8?Q?UKXClUSFo1JF389iNDz+c3yqB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ddf7ed-8f5a-43ca-d99f-08dcd4578f3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 00:52:50.9898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTdIdvBYQA9ZahcNm8VNPB6q7jlRO/rnPyRIKkWug153CdRS60iLwxNa3PVWRE7WPEsfo/K7fCPGs1cs16i37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8683
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb2VsIEdyYW5hZG9zIHZpYSBCNCBSZWxheQ0KPiA8ZGV2bnVsbCtqLmdyYW5hZG9z
LnNhbXN1bmcuY29tQGtlcm5lbC5vcmc+DQo+IA0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVu
c2VuQHNhbXN1bmcuY29tPg0KPiANCj4gUEFTSUQgaXMgbm90IHN0cmljdGx5IG5lZWRlZCB3aGVu
IGhhbmRsaW5nIGEgUFJRIGV2ZW50OyByZW1vdmUgdGhlIGNoZWNrDQo+IGZvciB0aGUgcGFzaWQg
cHJlc2VudCBiaXQgaW4gdGhlIHJlcXVlc3QuIFRoaXMgY2hhbmdlIHdhcyBub3QgaW5jbHVkZWQN
Cj4gaW4gdGhlIGNyZWF0aW9uIG9mIHBycS5jIHRvIGVtcGhhc2l6ZSB0aGUgY2hhbmdlIGluIGNh
cGFiaWxpdHkgY2hlY2tzDQo+IHdoZW4gaGFuZGluZyBQUlEgZXZlbnRzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogS2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1zdW5nLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogSm9lbCBHcmFuYWRvcyA8ai5ncmFuYWRvc0BzYW1zdW5nLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0K
