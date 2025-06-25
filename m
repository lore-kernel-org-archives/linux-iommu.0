Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8111922ED
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817506; cv=fail; b=b6tf+OxZsagtX011F7jKZKD++13fUnsCRSChtJ7w1kANQM3jTrSLrRe+P14FpX62vGsIW1iVIWAcX4Q3snd76Gr95N43QBPC+D2ferOfve7HB0a7oGX0kQWfqF67Me/IoamUbpEKvKVuo3M/svhPr3pPUYhJG2h/4PdZyAUEsQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817506; c=relaxed/simple;
	bh=voGq7VYUE6MPFwNJjmD6fJkCB3zzJ5aX6rEZ7a9o2Ak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YMus53uI5an9f/BAWHQJqQYh8sDjWfNe0AuqpePQNait+Iz5084qIzYuJcdVr30Mo+YQydhIpyLjVzDR7B0+S85UToTlhuWNd4QBjAm4IrKUnRsMSHQDd45EQUFXKe++3DGBRTBFqid2oEFUnFJRZ4E53SrQEjPv+bm1ujSef6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djGd4VBN; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djGd4VBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750817505; x=1782353505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=voGq7VYUE6MPFwNJjmD6fJkCB3zzJ5aX6rEZ7a9o2Ak=;
  b=djGd4VBNZS+1AoC1YZ+oJdcVkxby4t2qAgDc/bmAOToX1uGN9HEa3jZ4
   eT83Te/t4HnByAFZ7XBCMpKRqJcMakMO/anx2d4eQrMrO+pzueTo3/j0C
   WlN8wQwK+sTnn/aVz0p/UF220A5qmrHedZB4UGEP7/K2C/Af0d95edub6
   GETIurTr62jOnCveWlSwMfS374d3zD8/q9+s7dbeCzFJU4ua3pVQaVibc
   EBKs4IIR9FsMFU7RDdB0pdHvZGPbI2YmjBpt0JD2Bz19rgjcC/Lf93W8A
   c5tbvqYaOrYq+o/Z5T3pPK8oJIXdPabVl8MEV6boLsPh6TW7u20cd5xfG
   w==;
X-CSE-ConnectionGUID: H2JTgMfbSpilE4RkHiMhcg==
X-CSE-MsgGUID: yZA0/8A3RCOYeGTvQIPyyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="40694883"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="40694883"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 19:11:45 -0700
X-CSE-ConnectionGUID: QHmjwFtPTy+cqT+G+TGOwA==
X-CSE-MsgGUID: 0TGxwwfJQ4aLpEE03R2Gtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="152572533"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 19:11:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 19:11:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 19:11:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 19:11:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZL8YqeMWYPRQwtwXqlCBRyhAlC9caIYz7TtLOxTkMj0GlyPTRd7+ZmlhC+dmMBK17w2i+SGmO0owJZACrs68OHg/YK3wM1Y6UsEHwwwWzwgz4GcNEfeT8wbrrbXmwS8LB14+HEo6MlR29/G1MUbyghVBNBsvkiF4Aq0lgWWgVO0Zt9z0/EMaXIHXBGF3maJOD/vAyyUvovrDQbz8aRC3Kg3F8Vrelb72jEmxN+a3JP7VtpkJRrUQ3OL+aT8XhCoVV3zYKAB4hbhCCRK2vqTx+8SB6byOWhuGZ1ah+P+GP3QHVMDq/56Cie6itTPkX6ptDe53ny8yh6HPzsyvdS6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voGq7VYUE6MPFwNJjmD6fJkCB3zzJ5aX6rEZ7a9o2Ak=;
 b=U6sGWmOIgOCBORCDgEvkNm0sci5KaAraCvxkpU5cQQoGzeEKrfk6WlCC4X2E2t8gYeKQnMhBL38fDYvk6GND/RdgTrbN8vEmsj+R22+GQAeVO6Bkavz+1UkXO2FmWMU1yemyKcFdODdcrlHJXua3DE/8Vz4b48qz5LbzDoUgk+i/XcyMLUYK0kBVm1JubRclSs9//wCJHCgjkBiv825ZcpxjK0lpsYeGInehr2t9qZz9kQ0cK7vOJlfKR2tiy78vJLCuqUd+0As++pK+9cFUpUk/RuaNhdjYXy27BOILtQEliLy9QnnAocx4HhR6ZVZGYUG4dkOdEvubk/hwRTamxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Wed, 25 Jun
 2025 02:11:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 02:11:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>
Subject: RE: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Thread-Topic: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Thread-Index: AQHb5CVFBE31qd5pKk69rn63g+oyeLQSZ0cAgACWaFCAAB0rgIAAApsQ
Date: Wed, 25 Jun 2025 02:11:40 +0000
Message-ID: <BN9PR11MB5276A6F54C0391F72F3CFD7D8C7BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <20250624145346.GC150753@nvidia.com>
 <BN9PR11MB52762BD911A3CE2F1A062B158C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250625013629.GD167785@nvidia.com>
In-Reply-To: <20250625013629.GD167785@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6825:EE_
x-ms-office365-filtering-correlation-id: e0fc914c-8d9d-470d-4d61-08ddb38d9fce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2hLandjZUpaSnArN1M5YTgrUVVWWW5WbFhjSFdLeUREVmtUbHJ3NVNudmtB?=
 =?utf-8?B?cUFjakVpSzdHMUtuRjd5aDNjRU5IQmRqMi8yOENPTFlrWEtLaVpFbXMzanY2?=
 =?utf-8?B?YTNmYTJiRjhaWHNpTncrb2N2eHZIQjNxRzhXemdsYkc1UnowMXNWKzdtOFVV?=
 =?utf-8?B?NW1hYTJRV1NUalN6aU96ekFJWXU2eVlJQWtmQ1F3U3FZRkRMMVlwaTdCSGFv?=
 =?utf-8?B?Ylg1R1ZIS0tXT1Z6VTU2WmFDeW1ONFM3UnZCenVrNjlZcWhDa1lwdUFtY2NI?=
 =?utf-8?B?Yk04ZTh3WTRnWnRpSVZHanRITnR2UnM0eEdVeEhkb3Q5c2RzVWhWUkxsRVZz?=
 =?utf-8?B?UTA5QU42OUtBQ2w3SU1rclBPMG91RmtoaVRWbHZ4a0UvQjRmL25xeUNFa2Zh?=
 =?utf-8?B?YWdacWhadkpCdFZKczdGZEU1SGxieVlRRjZmcTB2Wm93V05Zbi9PNGZXVU9W?=
 =?utf-8?B?ZW9LSE4ydm1waDVQQjJNQkRZMU0yZEZaR3ZsZTQxanRVb3loSXFKL2NuR3VT?=
 =?utf-8?B?OVdTL0FvYm1oMTNXZUNtNEJhNkdNdUEwMkN0MU55eTVuTnJHMjVhb3FxcnRw?=
 =?utf-8?B?cU9Pai9vVFhYYXNVK25zbE5NTnRoeDVZRWRVeUd3NE5ycWZuS3lML2d6SS8w?=
 =?utf-8?B?RlR4bndMdm0wcHU1amo3VDk4QkgwS3BTbDhhZXRiMmZGUDVjNDFHQnp3eHd0?=
 =?utf-8?B?OXo1QVlZUFVWa2tISTVvcFM5anNsY3NaOTVEcTVweHp6V01LcEtxVVVhNzJt?=
 =?utf-8?B?MmE1amR3aHhIaHpOYUhLbG41R2FiTVZVWTBJbUdqSUR2WGF1ZnkwOVJnT3J6?=
 =?utf-8?B?OUFYaHY3UXBvdmtzR2M4ZVdkb0tNRWx1ZlAvdTlsbitLdlJJR3QycytkM3pm?=
 =?utf-8?B?MCtralJyK0Z2eU9STTVEdE5LUlpkNDlmaVBDeURqTG9jQkdLOTVtNmE4dHl0?=
 =?utf-8?B?S3hzWlJ4SXFNRzB2YUcvbktkRlJRdFNOVVZPN2FxbTNlNkYvNzZENXJnSTFQ?=
 =?utf-8?B?SXViU3JpTjQyK205YTUzZEZibTJDamlhcFpLVHF6OUI0SHA1TE9XQXdlZEgz?=
 =?utf-8?B?Smt4WUJid3BMd3p1cnh1ZDBPUlV3UEtMcXlYTm5WOTVkc0I3L1pJZmF3UVRW?=
 =?utf-8?B?Ylc3dTI2NGJ5TEdOaGlqKzZNZ0pXUzV4bHRLRWNLdG9adWlsQ0M0VGh1dnB5?=
 =?utf-8?B?ak16Tk51SWtjUkkvVFl3WU9uWDVXMzFEc25ic01CWFoydmFWUkEvd1Zmc1k3?=
 =?utf-8?B?ZUIvN3RWaXdZY2lsZzJSZGxFMW9ac1RNMm1CMHdiL3NvZUZQRFJPVVhFMFJw?=
 =?utf-8?B?dmtNaFdqTUN2VFFWck93SldyZEFBSlpGUG96L1NtMzd2b3FCQnEwL0VZTnpv?=
 =?utf-8?B?c3lXdFV5djQ4SkZWQ2lET3lvSmJwUjF5NXdtaE5LZW8wWFc1bUFvencxMDFG?=
 =?utf-8?B?UU9kS2U5WFZ2VWQ4QWFmeEtEUnExcXd2cEpubG1USjc1YTFxVFZUaHpNcHV6?=
 =?utf-8?B?M1doMFdiSUlHcjE2MDlnSEN1QWRzeHZKUUF5WUxQSmhtZjFlM1hxZ0hvcnRq?=
 =?utf-8?B?b3k3RlFNK2ZwSUpOcW5VWHJGSUhFUDNGbloxUTNLazI4RWZ3NFBqUVRhMDZz?=
 =?utf-8?B?OTZ3YUdtVXJuNndHL1JmcWtYQkx3OVIvT3crUUhXSTFqSjFWbSs0ZFdMM1FT?=
 =?utf-8?B?Wm1ISEl4Wmt0OHprRTAxNk53TEtIMHB0eEd3UmNrVnE0L0Mvci9VYXA1ck9C?=
 =?utf-8?B?T3V2SGdSSFhKYkFwclJtUnFVbWFJQTFNUVRxdndrRW5UeWgzSnlPZDB2d0tJ?=
 =?utf-8?B?bGhkVW5HdWsxVHNSQ0pEK1JwUHE0aXpoNk1PcHFnNURzYU5xUE9GZWMzME40?=
 =?utf-8?B?Sk9XUkh3KzhzZnZ4RWtxU1JNZ0NXSCtRbS9PR04zRDk5ZFg2ZjZXTm9Icm10?=
 =?utf-8?B?Zzk1TFRnY2dZc3VQcldiZzZZSnkySE1FS3poSGtVcGpvRUtzaGNLeVlsK3pa?=
 =?utf-8?Q?7MHaQPaX8p7uHW390NO20cVoaJMReo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmpLcEtUZ21vYklOdjViUzlxY3JqY21pVGNEak5pSkhqbDBsNHY4eVBSYUgy?=
 =?utf-8?B?NVF6amlWdnk1T3JlMVNGS2dmbzdXc2g4OFladGNxa1pqL1FCMVlPbGFPZEw1?=
 =?utf-8?B?K3NwcU9zOElhTklBRk1aRmM4eUp2dWUyR202K3VWbTZkVjVhN09mMHpLV1RD?=
 =?utf-8?B?VzFPRHlHNlpEanZtNktWR2o0Vjk4c0NSbi9KdEdobE9XdXArcUpyTzVEYmZO?=
 =?utf-8?B?V2FOZGloYzRCYWYvbnFNYWlNSWp2aGFXNG4zY1JFV0RMK2pocS9GcW5ZdTRn?=
 =?utf-8?B?NGJxY1AzUVBwSmNFc3VHNW93TVdtN2NvWWs2TWJwRksrMHNMUHhkN1RYNmJm?=
 =?utf-8?B?NmlqWE9vaWU5R25GbndaK3ZLeGtPbVhDcEl5c1NoSkJXVlhnaEIwVFIvZ1Jj?=
 =?utf-8?B?RUd4ek9kS29RRUZzS21IZmtwNERTVGJRS21XalJDMng0bUxoUmR6alVFbmpm?=
 =?utf-8?B?OHNKTmhBZmtCTGxsSWNsZzdSd0lad3JaTGdhVzZxM3JWSU83NWtnR0o0dUdn?=
 =?utf-8?B?SkxNckNVRW05Ujh6SE11ZVZQUFpwckdQUitmSkhHdHlXYVNEbXpNbzlKQ29D?=
 =?utf-8?B?bmh5cW42aCt5TzMyYTVEY3lWT3pmRkR1dEsxYitsVE1BcnVMRTkwb3VQUllV?=
 =?utf-8?B?UG5MRWVCNWUzUmhpVHhJeUU1S2ZEZGFxOHhPYWEwVmg2OWVUaVFVdlJZOHdi?=
 =?utf-8?B?M2wyWm9wR2ZGTC95bGlJRS9DakFjdUhqMGQyOWxKYzlpSU5BdEMrRFJuYnVo?=
 =?utf-8?B?NkxONGZhUHNXMFRiRnN4UGVOM3RkSTBPNndvOUpUT0RURzlGalZxTy9kWGc5?=
 =?utf-8?B?VWVjMENIM1Vlc213b1YxUkpRT3NHczcxUEJVb0dKZzVBdi9JdmJGdWUyZXdy?=
 =?utf-8?B?WWVrcmYrZXpOS2xzQy9KSUJCUEZpa0tzMExXeFNZVHU1QVY4U2xKazF6U050?=
 =?utf-8?B?YmlsTTFMTGh3UkFCTWo0WldGUFFncWU1eWZrQUhCaFdteXlWZ3FFL3BOaGlP?=
 =?utf-8?B?cStpZ1ZOYVcyTjBGeGF2ancyWmJRcDJZNTRqUUR2UUZ5emVEY3JvVW9abXF4?=
 =?utf-8?B?Sk9zUmNYa1Baa3pCeW9zck0vR0libGkrK0VVSlRRNUJKWHZvV3F6Mlp5aS9w?=
 =?utf-8?B?b1F2blFjdmFOVU9kaUZHOTBtY0Y3ZEc5SE5MdFJRR1NMdEFxenR3K1B6NW5P?=
 =?utf-8?B?QkFSeFJ1enJFc0I1elRLZzFUTHFDR0ZVR3J4eWxqTnVWUG9uWEFneWttZEtz?=
 =?utf-8?B?ZG10RFpIYndJZTE1ekx0Qk8ybTAzT0V6Q0MxdXBTTlRlbXBlM0FXdjc5bURR?=
 =?utf-8?B?N1IzdUhmb0d6NllwM2N1TEdMVmpnZ24xbU41ZE9LR3VwWGQyK2pieVk1UzZY?=
 =?utf-8?B?ckJQY0RCNWxwM2lxMENmcEl6R3V1OHhnKzUyNHJQOWhsTm85VUoyV1dJcHFR?=
 =?utf-8?B?MWNlUEgwNjVqaW96TWJHaldHUEpiQUdtY2VCdG9TcitpbSt2alRHZ016Zi9P?=
 =?utf-8?B?aUI2N1Y3RGtLYjlQQWhNSmVnWmJQQTd6LzB1bjBTZkxWTnI1TEJzS2gyZFhP?=
 =?utf-8?B?VmtpRzBVdmt3SG04eGpKdzFrYzYzaDl4YU5FSjZkUzljeGlIOWRRcE1hMDRE?=
 =?utf-8?B?TElxZ2tOd1dyYUQyc0doT1F0dlQvVWlScC9qRG0zRVhpMHc2NngvWG5iSVpJ?=
 =?utf-8?B?VVh1NjdCaGF1cUNUUlhON0E3YVFJQmtTamxmRUowQTdmRkNMM1o0WnhSWHdF?=
 =?utf-8?B?bVFTMkljOTFBRVpseEI2WFlka2p6WFdpd00zUHVZLzJ2VTlnL0Z2b0hueHpH?=
 =?utf-8?B?OXdCOHdxTW9vRklraUs4YlJzOGUxZzRLaHprVmJUQTV6N0o2ZU1KUDZPalpT?=
 =?utf-8?B?YThKWVRhYmZXWmlFNWQ5SkoxWm9uQm1BeW9QME9DL2lFcmJ5MWlqVWh2M2N1?=
 =?utf-8?B?d0daQUVpSVEvQlNIL3hTdUVsSVovc2p3UmdibXlUM2dvM0dPMWdRY0VCNVpK?=
 =?utf-8?B?cXcxNUZYUTIzTVNtZTdxWFM2WTdKYnZRSFAwa3hHUHBtSEpBdStXQzFiejRN?=
 =?utf-8?B?YXdmek1sR1F0citCRm9nQkloaWZ6eE1JN1ZRN2xmdTVvVjlJUEZ1VGtLdnhp?=
 =?utf-8?Q?BYv6Y25FUcPQMl1awYC4Ib3uy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fc914c-8d9d-470d-4d61-08ddb38d9fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 02:11:40.9318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2CAxFBoXM3y0aSrinCw4lXQ0J/QNI4ZVz8tHlrlAh6YAh5kUMRVZ3WFPXvtezeIfWmPw8whrRH6zo/jVDUUrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bmUgMjUsIDIwMjUgOTozNiBBTQ0KPiANCj4gT24gVHVlLCBKdW4gMjQsIDIwMjUgYXQg
MTE6NTc6MzFQTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBKYXNvbiBH
dW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgSnVuZSAyNCwg
MjAyNSAxMDo1NCBQTQ0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgSnVuIDIzLCAyMDI1IGF0IDA1OjQ5
OjQ1UE0gKzA4MDAsIFh1IFlpbHVuIHdyb3RlOg0KPiA+ID4gPiArc3RhdGljIHZvaWQgaW9tbXVm
ZF9kZXZpY2VfcmVtb3ZlX3ZkZXYoc3RydWN0IGlvbW11ZmRfZGV2aWNlDQo+ICppZGV2KQ0KPiA+
ID4gPiArew0KPiA+ID4gPiArCWJvb2wgdmRldl9yZW1vdmluZyA9IGZhbHNlOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICsJbXV0ZXhfbG9jaygmaWRldi0+aWdyb3VwLT5sb2NrKTsNCj4gPiA+ID4gKwlp
ZiAoaWRldi0+dmRldikgew0KPiA+ID4gPiArCQlzdHJ1Y3QgaW9tbXVmZF92ZGV2aWNlICp2ZGV2
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJCXZkZXYgPSBpb21tdWZkX2dldF92ZGV2aWNlKGlkZXYt
PmljdHgsIGlkZXYtPnZkZXYtPm9iai5pZCk7DQo+ID4gPiA+ICsJCWlmIChJU19FUlIodmRldikp
IHsNCj4gPiA+DQo+ID4gPiBUaGlzIGluY3JzIG9iai51c2VycyB3aGljaCB3aWxsIGNhdXNlIGEg
Y29uY3VycmVudA0KPiA+ID4gaW9tbXVmZF9vYmplY3RfcmVtb3ZlKCkgdG8gZmFpbCB3aXRoIC1F
QlVTWSwgd2hpY2ggd2UgYXJlIHRyeWluZyB0bw0KPiA+ID4gYXZvaWQuDQo+ID4NCj4gPiBjb25j
dXJyZW50IHJlbW92ZSBtZWFucyBhIHVzZXItaW5pdGlhdGVkIElPTU1VX0RFU1RST1ksIGZvciB3
aGljaA0KPiA+IGZhaWxpbmcgd2l0aCAtRUJVU1kgaXMgZXhwZWN0ZWQgYXMgaXQgZG9lc24ndCB3
YWl0IGZvciBzaG9ydHRlcm0/DQo+IA0KPiBZZXMgYSB1c2VyIElPTU1VX0RFU1RST1kgb2YgdGhl
IHZkZXZpY2Ugc2hvdWxkIG5vdCBoYXZlIGEgdHJhbnNpZW50DQo+IEVCVVNZIGZhaWx1cmUuIEF2
b2lkaW5nIHRoYXQgaXMgdGhlIHB1cnBvc2Ugb2YgdGhlIHNob3J0ZXJtX3VzZXJzDQo+IG1lY2hh
bmlzbS4NCg0KaG1tIG15IHVuZGVyc3RhbmRpbmcgaXMgdGhlIG9wcG9zaXRlLg0KDQpjdXJyZW50
bHkgaW9tbXVmZF9kZXN0cm95KCkgZG9lc24ndCBzZXQgUkVNT1ZFX1dBSVRfU0hPUlRURVJNOg0K
DQpzdGF0aWMgaW50IGlvbW11ZmRfZGVzdHJveShzdHJ1Y3QgaW9tbXVmZF91Y21kICp1Y21kKQ0K
ew0KCXN0cnVjdCBpb21tdV9kZXN0cm95ICpjbWQgPSB1Y21kLT5jbWQ7DQoNCglyZXR1cm4gaW9t
bXVmZF9vYmplY3RfcmVtb3ZlKHVjbWQtPmljdHgsIE5VTEwsIGNtZC0+aWQsIDApOw0KfQ0KDQpz
byBpdCdzIG5hdHVyYWwgZm9yIElPTU1VX0RFU1RST1kgdG8gaGl0IHRyYW5zaWVudCBFQlVTWSB3
aGVuIGEgcGFyYWxsZWwNCmlvY3RsIGlzIGJlaW5nIGV4ZWN1dGVkIG9uIHRoZSBkZXN0cm95ZWQg
b2JqZWN0Og0KDQoJaWYgKCFyZWZjb3VudF9kZWNfaWZfb25lKCZvYmotPnVzZXJzKSkgew0KCQly
ZXQgPSAtRUJVU1k7DQoJCWdvdG8gZXJyX3hhOw0KCX0NCg0KaWRldmljZSB1bmJpbmQgaXMganVz
dCBhIHNpbWlsYXIgKGJ1dCBpbmRpcmVjdCkgdHJhbnNpZW50IHJhY2UgdG8gDQpJT01NVV9ERVNU
Uk9ZLg0KDQp3YWl0aW5nIHNob3J0ZXJtX3VzZXJzIGlzIG1vcmUgZm9yIGtlcm5lbCBkZXN0cm95
Lg0KDQo+IA0KPiA+ID4gQWxzbyB5b3UgY2FuIGhpdCBhIHJhY2Ugd2hlcmUgdGhlIHRvbWJzdG9u
ZSBoYXMgTlVMTCdkIHRoZSBlbnRyeSBidXQNCj4gPiA+IHRoZSByYWNpbmcgZGVzdHJveSB3aWxs
IHRoZW4gbG9hZCB0aGUgTlVMTCB3aXRoIHhhc19sb2FkKCkgYW5kIGhpdCB0aGlzOg0KPiA+ID4N
Cj4gPiA+IAkJaWYgKFdBUk5fT04ob2JqICE9IHRvX2Rlc3Ryb3kpKSB7DQo+ID4NCj4gPiBJT01N
VV9ERVNUUk9ZIGRvZXNuJ3QgcHJvdmlkZSB0b19kZXN0cm95Lg0KPiANCj4gUmlnaHQsIGJ1dCBJ
T01NVV9ERVNUUk9ZIHRocmVhZCBjb3VsZCBoYXZlIGFscmVhZHkgZ29uZSBwYXN0IHRoZQ0KPiB4
YV9zdG9yZShOVUxMKSBhbmQgdGhlbiB0aGUga2VybmVsIGRlc3Ryb3kgdGhyZWFkIGNvdWxkIHJl
YWNoIHRoZQ0KPiBhYm92ZSBXQVJOIGFzIGl0IGRvZXMgdXNlIHRvX2Rlc3Ryb3kuDQo+IA0KDQpJ
ZiBJT01NVV9ERVNUUk9ZIGhhdmUgYWxyZWFkeSBnb25lIHBhc3QgeGFfc3RvcmUoTlVMTCksIHRo
ZXJlIGFyZQ0KdHdvIHNjZW5hcmlvczoNCg0KMSkgdmRldmljZSBoYXMgYmVlbiBjb21wbGV0ZWx5
IGRlc3Ryb3llZCB3aXRoIGlkZXYtPnZkZXY9TlVMTC4NCg0KSW4gc3VjaCBjYXNlIGlvbW11ZmRf
ZGV2aWNlX3JlbW92ZV92ZGV2KCkgaXMgbm9wLg0KDQoyKSB2ZGV2aWNlIGRlc3Ryb3kgaGFzIG5v
dCBiZWVuIGNvbXBsZXRlZCB3aXRoIGlkZXYtPnZkZXYgc3RpbGwgdmFsaWQNCg0KSW4gc3VjaCBj
YXNlIGlvbW11ZmRfZ2V0X3ZkZXZpY2UoKSBmYWlscyB3aXRoIHZkZXZfcmVtb3Zpbmcgc2V0Lg0K
DQpUaGVuIGlvbW11ZmRfZGV2aWNlX3JlbW92ZV92ZGV2KCkgd2lsbCB3YWl0IG9uIGlkZXYtPnZk
ZXYgdG8NCmJlIE5VTEwgaW5zdGVhZCBvZiBjYWxsaW5nIGlvbW11ZmRfb2JqZWN0X3RvbWJzdG9u
ZV91c2VyKCkuDQoNCnNvIHRoZSBzYWlkIHJhY2Ugd29uJ3QgaGFwcGVuLiDwn5iKDQo=
