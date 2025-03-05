Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE413792B
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741142289; cv=fail; b=V6jpj3vqU35AylhooJlvMC137I1fYVmFwQQpWZVpIaDfs0pZxScOhAq9b0K35hpnhfmFwDl9gQa7GGJ4BpNjmfIIVlyGEDMLnUS7qHvQXMIyFvNbxPx8MHLxspQZlive45eOkWuej9iftfPhYGPe3F9LIThDSWeJ8KwPcj7ays8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741142289; c=relaxed/simple;
	bh=0O6qMj3h2n+l4poDTAu+xBRN73mQqGq9JDYrWtyHaL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pvWaFCrN4R72lbPMaX1TUkKg4LyVSZB14O5dSE7m7kT1XOjHqwVbSap8tHnQngVDT7+583FWjUrei44s7hYNe8x9zGou2aV0pT0F4dqYX9Im50DL10Hx1TR6NRV3IcHDJo8eQnyy+OigrvAHcInuadTqajqU9QAA7PPqv5VtchM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSASLzRx; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSASLzRx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741142287; x=1772678287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0O6qMj3h2n+l4poDTAu+xBRN73mQqGq9JDYrWtyHaL4=;
  b=nSASLzRx2UBUXYFgkzJL4t/j4JPlNZ1TCcCRJTf8rr6YDTYJywivfsTA
   96wEdGIUTC+e+f/tYR4BOZ9fmX/StdfspwLBmEQ++shQkHD/8ANcaNg7B
   l0c6ujNmUXLKyJKJxb91qaCWLgloon6dKYJQ+jJoFxZwK9dsYMj+y/KnV
   AFvdhPU2mby1vmIJN7vTsekEscAyRq/fg4RXXarg5hpXBVmlrJPjSU0CB
   +8QIr8cQCsuk8rzSswyCgYt6ll+IKTKiYXewkd/4XBcV3WLbaY6eUQg58
   KEhCxShwRORC7UV35UeIsSnykZefb4okOc3QraUU9HSwWPVccdIffj7yf
   g==;
X-CSE-ConnectionGUID: rQ3j3FXiTjqqBaMSammGbg==
X-CSE-MsgGUID: pKyHptfFQqejPciPFUMH2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53487912"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="53487912"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 18:38:06 -0800
X-CSE-ConnectionGUID: GftNBg56TmCxnetdRE2SSQ==
X-CSE-MsgGUID: ny/fZcFCQfGShSf4UU8p/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="141801672"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 18:38:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 18:38:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 18:38:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 18:38:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKrm11AstMw1TFiJWRlE7P/w+yiODdKRqXCC6yZE9p2uLOt+jtIwDowlc07O4ObNytflRbOlGwsrmrJCIKKeaqZ1CxRc/3Y98gMNEtz9wwlGcINbcSZdat743ykRY6Uxf0bWqHIgyae3I+GP2K50MgM0ViNcVWdCJP+9gHJj/eGxu92lWKFKp146nGyyqBdNEkWXG0ttKl40uxzf3DOeev6lHvIwETqV3YWFMBvEseCJh2YDJHO9TFEqJVsTfP/dE5AANqvHA43nPSoKcqT7HviypovipBD3CNH/OtyEsxWqTMeXCadBg3XO9mnlgkDBxCa8m1slhpJisQQAflvSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O6qMj3h2n+l4poDTAu+xBRN73mQqGq9JDYrWtyHaL4=;
 b=tkC8MosXr2KTMw6I7XbWnueJKZwUqhc597gimvK9gN5Ln2XpoidHUnhEdQxB7XNMHCfv7Ooj8e7Jm2DXkjiA1iKh4RowSofKcWTALEqDq9qTr6fsZjrsEPCnkhbza78fM97UP11F23co5L92anSmAZt89eM83eP2RNkbgXkJYHXEQfbZsIpOOxVOKDCwJBmtODw7Xs50Ai9neOB8h+uyUBs3Guif9AU7Nlye3mzFprItXPHcwwsD3NrrIl1XFBmg1uFwE2cHfsP27lQpglHQrXSA20IyyqgLWhVDw0lkNZ3xX0ksHLkh+q9rhyUDqFGUMm9AxX50TGH3w1KYiNUTFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 02:38:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 02:38:02 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible
 domain
Thread-Topic: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible
 domain
Thread-Index: AQHbiENELkm4am5+RUqgCVJ/UkvmpbNipqgwgAA/mICAAPgOYA==
Date: Wed, 5 Mar 2025 02:38:01 +0000
Message-ID: <BN9PR11MB527619BA7FBF947201ED68F28CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-10-yi.l.liu@intel.com>
 <BN9PR11MB52766783E53A987FA872ED918CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a05fe92b-b36f-4240-a20a-07d186cdc4d1@intel.com>
In-Reply-To: <a05fe92b-b36f-4240-a20a-07d186cdc4d1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7410:EE_
x-ms-office365-filtering-correlation-id: 235f838b-7389-46f4-4b9f-08dd5b8ebfeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mk5wTWg2OWVTbzdIL2RZR0lVYmRFaUJaZnBkU05VV09hQUhXYlEvMkdhempu?=
 =?utf-8?B?cGhjakxiMjJDKzNVeXRuaHBhdFBxUng5Um1WT1d4MmE5V3BOR1N4dHhKb0RN?=
 =?utf-8?B?c244Kys5ais3RjVkUTJabFJRZzl0TUJ2L0tWQ0g2c2Q3SUZCU2xhM1ZvV2xa?=
 =?utf-8?B?UDdSSFpYQytCSUVwOXpJTnBINzU1eDEvZ0pzRklxeEtXS1VmS3AyVU9IZTBB?=
 =?utf-8?B?bi9mWE9SM0RTZ2FnVTF2Nk1TZUQ1RkVBZVlkemNsMHpRL20vZnRWd3hGRU50?=
 =?utf-8?B?Rk45eGc3MUh3UTBnMUZESEt5Tlo2M0tyOXduTGRVakZEbEZaYzVKT09PYnJ3?=
 =?utf-8?B?Nlo2dUJCZ1llVDVpc3FUaGY4MXp0UHlXU20wb2NsdEpGR1psZDB5S0ZaU3g3?=
 =?utf-8?B?UkZEN1FvU215U2pUMVc5YktIdlp5cHg4V0x0NHpEYktxS2xvcjAzQ1BZdit6?=
 =?utf-8?B?MmJYMmxLdVNZUmRIQm5TZ1hHWExIREExdEZocWR0WDFSaXZBM3BiSWIyOFF0?=
 =?utf-8?B?c3lNZ0phUEZKdU9GU0Jnb1hScU5STjk5RkQ4U3BGU3B3Y1hCYWpKNE16TWo0?=
 =?utf-8?B?cXo5Z2k0TVJqQWZ0bzdvZlUwMTBMbmFpd1dRRmZvVmpwWXpUVjhjY1VwSllh?=
 =?utf-8?B?TVMrdm9hM2FyMVJkQWhzNXBOalBmbFB2QncxekQxLzlhczNHaSswRlNNOGUv?=
 =?utf-8?B?SllwSjd1MG1KUXBDTlZkRDJqL3QvUjV6ZlUybWptZVM0eTB1YnNKdTRiVytK?=
 =?utf-8?B?UlFQbHpVZkVBV0ZzVENNaWZwNTBJbE5mMGVKemp0Y3cyTFFEbmppdlh4UUpN?=
 =?utf-8?B?cnhqS1dxYU9JdklCb3g5QXFSNTlqcHF2RHl6R3ZWeGVSSkdpM3J5RGloaVl3?=
 =?utf-8?B?MTdDYVJ4VC9YTWp2UEdSVUtNeUNycFpnUFR4Yk05b3hLd3FsUmR0Zk1qMUdP?=
 =?utf-8?B?T3U2RW9wcDM4azZHVUQzM0VpNTJDWFI4bFJ5TU9odW10RjNURy9zUXlRQWZ4?=
 =?utf-8?B?NG1RbjYyM1FpM3R0U0V2TG8zL2k3NUlQczFWdnpSMCthUWt5RTJlczFSZWdH?=
 =?utf-8?B?cGc1M0pBRU9ZU2NIeU5HNTA0bWxjQ2REYkNZWUJ0RkxJRHpHUEZkM0Zoa3p6?=
 =?utf-8?B?WHkxVzFFcFByeXVSdkJkT2NIVXI1NXdKWDJSZlpkbFJHVVEwMnhYNHFUaWdk?=
 =?utf-8?B?L0RESzNtMDNkRmlxbWFzU2doVUp4a3k0dnJ3aHdzUnprM0MzaWdjb2J1b1Zt?=
 =?utf-8?B?aWJ2b3hxVFpDemRJT2poYU9tNEswazY0MW5NWkU4YUQyOHdNbkQ2bDlwMUZB?=
 =?utf-8?B?S1dVb2JMWGxPR1ZUemlyeThnaDZadWVGWnNxZ0FXd1ZvSDIrSmZLdTlUR21N?=
 =?utf-8?B?ZFRKMlQwMGZnTVppTkx5NCszMDNEWVM4SFZ1RzVTQmZkNGZNbTJxa2k0QU0r?=
 =?utf-8?B?cWJrUDFSQ0FBenhmdnVtaGFYc0IyNGVzL2tSdFhWV1lWcEFjNGdEem5hVFRC?=
 =?utf-8?B?UVFXcElJZkNXVWtMeWFhM2J2SVdsWWgrbSt5WUN5YWJNRjRiZ1FFZUNXWnlF?=
 =?utf-8?B?UXRhVFV2SU5DdVFKK0hQVDV1RTFHLzAwMFhaQm4zU3FEZlYwMWZMaGg2bkFF?=
 =?utf-8?B?cDZxcFV1SWtvQjd6M3JqMUVWNDlYenN3S1pvQ2JIT01yOExFK1ExQ2xMSWxP?=
 =?utf-8?B?ZnU0NEp1V3U3Qi9ra2xMeGRPSUsyOW1hckNCbjJpaW54YmpwR0ZQM1ZmdFNH?=
 =?utf-8?B?WXNoUFR3bzFwNkVTUno1dDl1cGxZeVpWVmd2N2FZQTFoenNKMFFMbnJUemx2?=
 =?utf-8?B?NFh2Ui9ESUJDOXpFeGcvcFdONjZPN3pIdUFwZXFXRm9IcFdJSmpUb0huUExL?=
 =?utf-8?B?OExMTjcrc2duMlVONTU5eU9sOG5LVHRqTmhXNmphajBMb2pBR0l2UTFpZ0lG?=
 =?utf-8?Q?ELyKQBTLjlHC1O7qa8gn+3xIh+zNT6NX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0FRSUI3Z0tCMHJDcklKTWt5bXhtT0pDSkN1UDZNdGVVNVdEOFlmRDhySmlH?=
 =?utf-8?B?R2NBc2sxZnRsR0JnWHZ0TmMydnRVSnp4UVE2UkVOUkNZR2x1RlFIeG1aVGJP?=
 =?utf-8?B?VGFaVzBrZFRyanhhSGxGSWF4a21qRXY4T2twaUp4b1l1MnIrM05mSE1XSlhM?=
 =?utf-8?B?RjVNSjRFUkVjOVE1ZmxrUzNsNW5vZ0Z2eHIxM0I0VnIwY0ZRb3B6L1NLTWFC?=
 =?utf-8?B?a05MVnFiSVp4R0FjeVk5Z0VaMjI4NmZ4aUVpNE54UzduOHNpQkFyR2NBSmN0?=
 =?utf-8?B?NVVJZFFrUTM4TTZjcGZnMVpudzAvK2NWcWpIbm15dkQvdkw3UFpmanBNS3A1?=
 =?utf-8?B?amFDRnMwQm9CcDlnT0JwektGb1FVa1VsdER4Z0l6MC9lL09COXJQb3c0aDhh?=
 =?utf-8?B?V2VJNEY2Y3NuN3krNTdiZkxpSFVxYVRnQXg5NlQ2M1FJbDNTcTdMN2EzWmRH?=
 =?utf-8?B?VkJ0M3NxMWRSTHE0RGs5aGFsekU4RDRHdGliZm1kTW9odGhQTmdDOXFTS0Rx?=
 =?utf-8?B?Q1UzNVRXeGlHdkdGSkRCQ0poaWsrSVJmUytLWWVqNnBDVFhid3NCbHBUWXNo?=
 =?utf-8?B?d3JaNUsyd2YwWUVZUzNJVW1VSGs5U3lzSkliTGx3WFA5N1UvN24vVkk2NlFY?=
 =?utf-8?B?RnZqWi9jd09xVmVUbytzUmRxY3JJYmZLTU1WWWo3N0ZZWG15NzdQdSt2QThX?=
 =?utf-8?B?Nk9lSDNoUm9naWs4cDBQNkIwd2pjYUY2MmphTlhqVlJXcWlEdTNzTDhXaUFW?=
 =?utf-8?B?QXNZTlFXRFRYcUlYTS9vZ0xxQ09seVMrbzhUNDlYWU1WTm4rcE9NVjBadjhT?=
 =?utf-8?B?ZlVvRlA4V2s2aUErd2QrYjIrd3gzcS92N0RpNkhlRktDcTRRU0oySTFIaytG?=
 =?utf-8?B?MXFxTklHSGFSUFd6V2FueGFBTEhOdUwyR1c1K1doYlE4d2hBekwrZkhFaHFZ?=
 =?utf-8?B?YytZVVN6TjJ1RHNjMkZyUCtaV0hLdmRlUnU5SHBEUWtDNlRYSVJhNGp2ZmJ3?=
 =?utf-8?B?OG9RcXhPZ0Z5R09SM3doM2xsRGVLUFBQUjdtL0xoOTNNci9xUG16NVdrMzZJ?=
 =?utf-8?B?Wjh1VXRiS0Q1YmxNU2NJQUpvK3JQV1NGNXowM1pBMEJ5MWlSMzFEaUNBSzJ6?=
 =?utf-8?B?UUliUmViQytwcjBUTmlyWE0rTUdjRjF6YlgyOWhpNVhSSmc3Zmd6Qmt4dHFE?=
 =?utf-8?B?ZzdDenhJSDN2dXo4VTlmcWk5dDJjUXZtQlhRUGZ4a1lDclFBSHdJdlJjc0NQ?=
 =?utf-8?B?aDlsK1EyWllWQzhJeHZvSVlTU0taMnkwZmxoOEpOQXdYTS9HM3JEdlJhOVB3?=
 =?utf-8?B?S2w2SkZJVGw1Z2tGMVFkaHEvUnVHTFY2ak1reXAxOUFGeGlxeHJtYlpwSm5w?=
 =?utf-8?B?WGYwUTVrazNwdk85S29qVVAyZis2Z0xhSzUzelRxNU81Z0hDN3IwaXR2MEZv?=
 =?utf-8?B?U3FBSEFNbWQrNjdFTS9MM0hoSHE2c0dkb3g5Y01IQVN2aUkyYVVVUEFhUVhw?=
 =?utf-8?B?U0gvS2lBc1c2cU5keGpIN2JIanJRSFVXQWhMS2M5NEI5bllFOXFaRlFseERn?=
 =?utf-8?B?K3U4NVAzY2ZHbDRvd3BmNFYvcVJTNFdHNTZUQytpZFQ3Y0pqWVo2cERRMnc4?=
 =?utf-8?B?UE9iNDJxK0dyWUQvQ2JobDV1Qk4zSC82SGhOdDUwUFhNZFNrV0h2RUY1UjFa?=
 =?utf-8?B?Qkc5V2YvSWJ0NUpGM1NaZ29xUjJrM0xNc0FQSDEvV2MyOTV2RURTazZSRjVq?=
 =?utf-8?B?UC9ZTjhhZUQyQWNadStUOXh6M2drbnczekdxNS9RN2tGbFRUVzY2aHZhUEwy?=
 =?utf-8?B?V1Q0MmUzK245UGRCblRJeTJCSkR4TUI1bzJBOHg0N21obzV0NURHR3JmYTkz?=
 =?utf-8?B?cmFjU3hoSXVzenFiUWxGdEtVdzVGSVBOV05kelI0TXpJb2VLNmhXeEVYYzE3?=
 =?utf-8?B?cjJnWnJEeDVsZXNLRDlEY0hGS0xGcjFud2RDWXIzUXB5Sjd4Z2dFWG90ZWJ1?=
 =?utf-8?B?YWl0Tys1cUVOREMzQjZLcGNhVDZ6TXIzS0trNFBDZTVMVWUydUY3alBZVXpu?=
 =?utf-8?B?VXZmSXdnSjZaamk4enIrS1JPek1vUXE4L1ZDMDB5T0hhdWNVVVhaWjVKaHEz?=
 =?utf-8?Q?DiszxdbXD/5HUY0fYolcUcybR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 235f838b-7389-46f4-4b9f-08dd5b8ebfeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 02:38:01.9484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/XfVVDHrrwJzyQQQrkARoorOuwAqhuOsIB+qN3tFzZGrH4qKhzDAhyI6Q5dRPd+W2WFZJh1p3l/8M1IXT14SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7410
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
TWFyY2ggNCwgMjAyNSA3OjQ5IFBNDQo+IA0KPiBob3cgYWJvdXQgbWFraW5nIHRoaXMgcGFydCBh
cyB0aGUgYmVsb3c/IFdlIG1heSBhc3N1bWUgdGhhdCBhIHBhc2lkDQo+IGNhcGFibGUgZGV2aWNl
IGhhdmUgaGlnaCBjaGFuY2UgdG8gaGF2ZSBwYXNpZCB1c2FnZSwgaGVuY2UgdXNlIGNvbXBhdGli
bGUNCj4gZG9tYWluIGZvciByaWQgcGF0aCBpbiBhZHZhbmNlLiBJZiB1c2VyIGRvZXMgbm90IHdh
bnQgaXQsIHVzZXIgY291bGQNCj4gYWxsb2NhdGUgYW4gaW4tY29tcGF0aWJsZSBkb21haW4gYW5k
IHJlcGxhY2UgaXQuIG1pZ2h0IGRvYyBpdCBpbiB1YXBpLg0KPiANCj4gCWZsYWdzID0gMDsNCj4g
CWlmIChwYXNpZCAhPSBJT01NVV9OT19QQVNJRCB8fCBpZGV2LT5kZXYtPmlvbW11LT5tYXhfcGFz
aWRzKQ0KPiAJCWZsYWdzIHw9IElPTU1VX0hXUFRfQUxMT0NfUEFTSUQ7DQo+IAlod3B0X3BhZ2lu
ZyA9IGlvbW11ZmRfaHdwdF9wYWdpbmdfYWxsb2MoaWRldi0+aWN0eCwgaW9hcywgaWRldiwNCj4g
CQkJCQkJZmxhZ3MsIGltbWVkaWF0ZV9hdHRhY2gsDQo+IE5VTEwpOw0KPiANCg0KeWVzIHRoYXQg
c291bmRzIGJldHRlci4NCg==
