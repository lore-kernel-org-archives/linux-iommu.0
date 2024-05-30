Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57BFBEA
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028930; cv=fail; b=pQi/HLV2FP5xyaafOdBaLRZX8ka9BSBEbMgF9WNrSzWsR8jytMG3N2/AofGVF130EkqD9zbU9U4uPh95f7JL5g4MZlxTc5N1AzH2CjyaB0bWr4MY0Dm1meNJIXPOlR9567tH25F37g0SIvs5W/2i2P5s8lpbjB/VyDA3fpnUiVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028930; c=relaxed/simple;
	bh=XsBB4dWIF19Ag68URnKImliiVQS3VgYupOpW9MqaVT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dM1ahngcS/ahIGDtJ+fxEjQa/Fn1pRzhWsE2PmPVLv6TwWoQWPRKFAI2yN8xaJbQzfRB7EMLirMy8YLd7ovvkcL2cxbJXfC2xdvpjLUcU12NPgF9xl2/Ql4uozXesGwR9822aTSsoN/FAaKp4bZz1nsnsW7yDe4/bGEYR6E/p8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dv0J+xRM; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dv0J+xRM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717028928; x=1748564928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XsBB4dWIF19Ag68URnKImliiVQS3VgYupOpW9MqaVT4=;
  b=Dv0J+xRMlAo0Cry9+Qw8GH2WJW/4ZH6gxx5TziXkPjTUpBKhglFE9I8+
   DdBkMo2ncHeL05Fw/TLoUHgwVmifUk2SKosvpRZV7Uqi82H4+qVv9llm3
   VAftQ1i7m1g8p/LBrXe5jtISI2fsETh4VikjHVnjytOwOZqdvwbyjhTBH
   vz+Y2G7UUOS8C6fmQtmDdsRI/zzaWCzw6c38Atcm2aNjmGAPH8nXhwQo/
   sLaKhCvlpG9qkLIlxIlrW2fhq4dc1kPW11Ej8yuOkHT7TQkoR/R/bcS7W
   eNeZQvcSuEsEdQbIHWhWou/l5SEqlWJmIbAedInZ2WgosqcdBSvedMfJN
   g==;
X-CSE-ConnectionGUID: 3+zs9QdaStqVoegI7A0mIQ==
X-CSE-MsgGUID: tQPR7FCWSgOdBxU88i1I/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13349575"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13349575"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 17:28:46 -0700
X-CSE-ConnectionGUID: ASRBQAb6RlC8LzE87KHsqA==
X-CSE-MsgGUID: rnj6GzUsQaOBhunkPdYxeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66478934"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 17:28:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 17:28:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 17:28:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 17:28:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:28:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYdPZnwxmzYXc+IOrtC22TerXo51Gtzh1JlYHBxEojA/5Zxr9YButMMZK6nggpPL5761NKz/hssbCJjDMaZ1Ux/o0orYJ94Zoaf4avThYGgO+CNPKbfzsuR9/2KYDZmeiCA3ArPUpgW/N0eOcHLpgV/l8W8Lz8HDYD0Eth1tvbTHS5QQN62zAZojaD7mc/zFlIkiCiqP3SMgaOwQCbjNNRsvD4RaQh+LWnNLyOmNfvCl1vGtwieP+PfpnFGHadJ6g3hkAnvL1m4jsf04cv5k0IzAuY/v4VFcSDVKxlGpYdtksSmQlZ6Jb3j0D/CHjAamWiExsfqppSB4fD1lwqFFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsBB4dWIF19Ag68URnKImliiVQS3VgYupOpW9MqaVT4=;
 b=Tt6UyDDsajsfdOLzgwVj8BRNDQQIcUQ2nC9c26JdFEHbbJC222bC4Ndmh5u8Ormb6VK02jZiucr151K/XvMPuI0OtvlOlMepBoXHpjxBJmtIzecJGtqJtHHWqTYGfh0Ta42j7V4b/dsl7FIK7v0RnrovghOIJJWKcJeQCxaaNvT7BFS1vxBSRevw93JyxaYKeipdY5rAp8UVHIUbxYKo3lekUQKCBSfYeY9Q5gAX6+1pf+G32GubAS6ZP/MYZPiVAOrRFvFoHTTxLpmtpywSKXXUDNiAy5kel371DCYhddvXLOhPkIo+U96vmvTLHzcZoYU81dksVgudNEGkb8jgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7316.namprd11.prod.outlook.com (2603:10b6:930:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.26; Thu, 30 May
 2024 00:28:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 00:28:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Topic: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Index: AQHajVVl26WkVBqVE0qDV+tml8yTY7Gkmr6AgAGEQoCAABbGEIAAaX4AgAPpupCAAtXxAIAAbUsAgAAHhACAAV8OUA==
Date: Thu, 30 May 2024 00:28:43 +0000
Message-ID: <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
 <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlafEktUu5znDsNt@Asurada-Nvidia>
In-Reply-To: <ZlafEktUu5znDsNt@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7316:EE_
x-ms-office365-filtering-correlation-id: 45a9cf0c-b9c1-4183-2278-08dc803f7613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OVpZOGdpUVhiWkYxZk9XeTJrQi8rUEY5UWxjQnZiRTMxUXZRajNHU014KzhD?=
 =?utf-8?B?ZGczUWl4d01ZUUVuWGtlWkp3b0MyREQxeHFwRWZkb1ZjMTRvdTJnL1lDWFc5?=
 =?utf-8?B?SWRFUGdTWFVPZ3hrREVhMWV0c1VkMHRvOFR1Uy9RVWh3aTNpWFJzQlVHUXZh?=
 =?utf-8?B?V05zYjFGSmZVbU9aUGxqdk9kN1IybDV2M3RjNUcrTzFuaEhNN1BDSVBHMFI5?=
 =?utf-8?B?akFtYSttZVlwa0ZHaC9ESkQzaUJkdCtWSVAxMjdkRU02YXpPMGFOZXBkMWYr?=
 =?utf-8?B?cVhIWGhkT08yM2dWekdtZDV3WDRucmRxTlM0WXdxZHF3bVIwWm1iaTFwSVZ2?=
 =?utf-8?B?TWVVaWk0T2Q3eEY0Zm5Wd0pRK1pjajJsSzdIU0FvRHJLcEMvbTlkdmNzcWxo?=
 =?utf-8?B?Zm8wZzVNb0xPYWZGbGNkOXVONERYdWdncVU4QjhyVUs5UzBFSUZ2VmJkMTF0?=
 =?utf-8?B?QjBiM0pTSm4xRmtIbHE4N2MxMTNkc1JOQVdsT3pFRTEwYldYa2dBTXZWV3Bp?=
 =?utf-8?B?a1c2QmRQRW1UN2hXYS9PSFB0eXdtVDNaRE9nZDl5RFhLZ1lBUTBiaWRrN3Fo?=
 =?utf-8?B?cDZWK0RydE8rR0tabnJ1eHhiT01BWGVVYkMyMzV3MnBObVlRcDRRNXV6Y3ZK?=
 =?utf-8?B?QnY0SG9Ib3packk2Si9CMnpLSVQ2RGlVVzBKckRGSWhycUVqV2dwWE1JcW53?=
 =?utf-8?B?SEh2Nmw5Tm9EVEViVDRTNUdoaFNBb29DZTJxVkJhWVJYaENWc01GNENSSGFQ?=
 =?utf-8?B?aWxXRFpJRGRmUDFXQ2RRUks2LzdwbVZnbFQ4YnFKT1Z6R3NyT3IwT2d0NVMz?=
 =?utf-8?B?Sk51aXNsZlpRSkJiQTcyQ2VYOEZXWUhBaHI1QUpyZis1cE1mRTVMRVBNTlBo?=
 =?utf-8?B?aU9lYnZEdmN2SGs2U2NHckhGdU5aUE54U3pVSGlhNm8xS1lhTWJoVFYxOC9w?=
 =?utf-8?B?UUdRdk5ERjE4cGovV2h3ZStyWnA5Ni80V1EwalM2QldibXdZREwvT2QrUWlm?=
 =?utf-8?B?V09PUlRid3BZUDJRRlFLUFF3ektHTHAwSERvbWM0VmZoK0l2anM1b3hpc2pj?=
 =?utf-8?B?U2Q5d3dHRGxrVFRHUDVwbDU1MUVBeURNUzUraTFYajVTeU1VMW5QdkQ3VDdS?=
 =?utf-8?B?S20zbmx4UGMrNlEzS0N3SnpBSFBRNEw5ZVB1STk3YnU0MlVsSmdLMkkwN2VK?=
 =?utf-8?B?TjdXcjJiajgzUVhEZ3JsWUlOaXJ3ZzJVUURucTk1dTV1VXdqNzM4MUFBcDl4?=
 =?utf-8?B?aXB0N2lFM0pqVTdidHV2TDBEbWJjcFROMFBtZkFMWTRPSm9Xck5QT1ZEaEoz?=
 =?utf-8?B?OW0zd213WXJHa3RpUFo4UHlBN2dwQ2J3MHdZWmZjZ1N0eWg1NVF1RDkrZ0Q4?=
 =?utf-8?B?VUlGK053NXpUK0JxLytuNnBEaDFYN0tRVkc1WkNPRDBIWXlKU0J3NGwvU1Z6?=
 =?utf-8?B?SzhjRlZXY3N5TzU0R2lDRmtVbEtuTnBHcnVlRENPUG8vY2FDMWgrR0dTMTE2?=
 =?utf-8?B?SGFBcUNBcTdJajlBVGVUSG1nUGw4ZnA0ZE1jSFlRYk9vMzNKdDdCKzcrR2pG?=
 =?utf-8?B?bXlPQUp5ZDVDaXRPYzlHdGJRSUUvSUFUdDRZYzhKR3Z6NHgxUHpySTdTYmIx?=
 =?utf-8?B?R2NBei9aZExMTlJjbUxkTFhOUVJhY2NuWTRlRXZHcVQxeW1lVUM4bDRRVjZO?=
 =?utf-8?B?VmlpOGp0TG5oK1VCZ3NSWEhzblBjaXBjdG5QRHBvYkRCMnVlR2wwdGJHOTlT?=
 =?utf-8?Q?3WES8XJbTYHYxccKNXsIZgYtLypKettFtohPV6N?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tlk2VWZCZVVsa3o2a2RaTW83SUVLRm9FZmErZU9VNmFWZDVuRHhOUG5pSzBn?=
 =?utf-8?B?Nk1Bc0V6Yk9NTFo0Q2tHWnp6RTZsOXordnNKbGhUMzNYMndlM3MrRW13U1o4?=
 =?utf-8?B?a1g2ZmF6UHc4dGU3d01TZnBBcUhLNlR3WGpXbllEMEg4YmxXYTcxa01kTTcz?=
 =?utf-8?B?eWRoVHA3T0FMbmVkT2pDYjQ5QWFIc3dMckVEeksvdWsyaGNuTHhRZXAwSUJC?=
 =?utf-8?B?SWpSTlZHa0lmZ3ppa1BndWxIbUFrUVVPTHJqcHNBMUN0dnBQT0cwa1pseWFG?=
 =?utf-8?B?bU80TjQvYUlWTnN4RXVWMVp3TVkxTGR0TjdJODRDa3d0REFvdUFRcGRnbm50?=
 =?utf-8?B?Nkx6RlBwU09iR3JFdmUxVWJCai92dDhVTUhVUjdiNWxwMzFEdnMzdW1zNzNy?=
 =?utf-8?B?aVlLekNNU0xYOHUrR1NXd1czTlcyZXpFMTlTRnQyZ3BuLzVyckhpdXE2U0Z5?=
 =?utf-8?B?WmI5U0NlZzlJalN6WWYrNDBzdzM1OG1OZFM4bXk0SCtVVWhqNnZhcU8rVTRz?=
 =?utf-8?B?NDFJRDAvNGErU01FU1dyc0JqdnpheHZsVi9KSVRYc3Z6cnY1MkpBS1ZXVURG?=
 =?utf-8?B?ckdwdmpBMlRCTlJDeEdBTjlpUUxaM29ZVEszcm0zb20xNnUrd0lZKzZMWXMw?=
 =?utf-8?B?cVVzakRMc2g1TGZEOC9DbE1LZGh0eVl0ZEhLNWRLSU9CVXJmZjBrYnkzM1pY?=
 =?utf-8?B?RU1LUWcyYWpHT2JJNFNCcjJPcUc2cmdmOGRlRlBLWmd4TlZYK2tKMjU0M0ND?=
 =?utf-8?B?ZzVWc0ZVa2ZXOVhQZGhMeDJycGlLejdpd1o5ZEh3SmVYazFmc2M0RWVPeHZG?=
 =?utf-8?B?WksxbDRTZ0VCRkE5LzdTM25vQ05DcHlQUlI3UDdPbTVFYktNcm1BVlU0NXFB?=
 =?utf-8?B?elpXdEdaMVBhV2xMOTliL0dBbXFCNFZMb3RyeFdnUndOM2pEcDZ5bU1LaUdC?=
 =?utf-8?B?YVdMM2ljamFZNnB6WmMwVmRyK0VocnpIZTR3TW9oNWxadVNKdXU4RFNPS3dq?=
 =?utf-8?B?dHNYRWUxSW9HN1d6ZmoxMHMralVuU2trQnE4cTNGN2trcmxWb2VjOXdyQk0w?=
 =?utf-8?B?aml0NnEvb3FtOFRWdVVHeG5sSnBSZHlXbHZ6UUdzdUJCQVFweGF3ZytyWWNP?=
 =?utf-8?B?M2lwWWFKSDd6MjFOdUFmVmRBL1NpS1VUU20yNEpyWTVQZlVGWnVQZmhBK3FX?=
 =?utf-8?B?TFg4Q0hPUnlHMU1ZQ2w4RjUzdUVSM0k0NHhLRHRpWjNVcnlGYTh4dnZybjhR?=
 =?utf-8?B?Sng5b2lPSUxXRndqdFA4NXJBdTdsbEVMRThiSE9nakpTbDJuYmR0RzRYVjJW?=
 =?utf-8?B?R1JJenRlSmxUOEtTN0h1eXBtR01pSEpFSTU4MGI4cU1pQzlqdDBzRGZ2a3Zx?=
 =?utf-8?B?RWtTYnlENSs5bEZwUzhsaGo5ZTZkSG5Ba0krUjFmZGlqdEdVQitSdW85QlhQ?=
 =?utf-8?B?RTNadTluSFlHRFc1Q2h4YXJ3cHQwT25TS0VXMUFzSE5hNXhlUVkwVENjeU41?=
 =?utf-8?B?dGhueDZNTHFsMk82QzFhaGt6bHdnVnBlUkJxL05Ic2hpRGtBU0dKc0lyWTlO?=
 =?utf-8?B?YngxMURQREw3YXVkamxKdmR4azJrNC9oRjJiazVvckRVcU1aeFNyUjU1NUpu?=
 =?utf-8?B?d0xDVjZBclpIaUpjM0RXMnZZcHE4eXNDUlIrSmR0SWpWakdkeHkwa3pRdE1n?=
 =?utf-8?B?VHVTY2hML2t3NW9WSkpwOC9LWHlUbkRHZWdXRS9ROFpNeWpNNTkrV1FWUzVh?=
 =?utf-8?B?UkpXbjNKSkJ2bVFCbXN2NXBsWVJGdCtuNmNTMDRpRG92eHp6QkhtVlRvcHFS?=
 =?utf-8?B?VjVRZWZ3aWlaeHBSRkF1cjJoa2tya0hrUVlHR0F4dmhKb01QTzJRSE9nRGJp?=
 =?utf-8?B?WlNUOHFtYUZZbzVaVE9UeDVTL3huaXJhYTJIelkwZzNCKzNhNTdROGhyY0hI?=
 =?utf-8?B?b0RmaWhKQ2NOM1FXdWhZWlhtM2M3UEJJM28wbkFHaXYvM3g2cis2ZmNFOUZY?=
 =?utf-8?B?Qy9mL1BNd0JEODBEWE90djhNSi9DRTZ6bkZBQUo3bTBKc0dQVjJreVVaZWNT?=
 =?utf-8?B?MHJKOWRZUzNpT2xkTXl4ci9MelBDWW9OWFpuTGlJQkROQjRkMEVsSGF1WURt?=
 =?utf-8?Q?NXfGeNjSA7jHvk6CP8bb8pc4y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a9cf0c-b9c1-4183-2278-08dc803f7613
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 00:28:43.1810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iNLcZOVYCf1kPBoBv8iEUB46psprSzNIfxofGOkVL88zRAwKDvIgsKgax3hkRP8jxVLOnH4+c/Q0or+VfdO8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7316
X-OriginatorOrg: intel.com

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgTWF5IDI5LCAyMDI0IDExOjIxIEFNDQo+IA0KPiBPbiBXZWQsIE1heSAyOSwgMjAyNCBh
dCAwMjo1ODoxMUFNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPiA+IEZyb206IE5pY29s
aW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgTWF5
IDI5LCAyMDI0IDQ6MjMgQU0NCj4gDQo+ID4gPiBXaGF0IEkgbWVhbiBpcyBmb3IgcmVndWxhciB2
U01NVS4gV2l0aG91dCBWQ01EUSwgYSByZWd1bGFyIHZTTU1VDQo+ID4gPiBvbiBhIG11bHRpLXBT
TU1VIHNldHVwIHdpbGwgbG9vayBsaWtlIChlLmcuIHRocmVlIGRldmljZXMgYmVoaW5kDQo+ID4g
PiBkaWZmZXJlbnQgU01NVXMpOg0KPiA+ID4gfDwtLS0tLS0gVk1NIC0tLS0tLS0+fDwtLS0tLS0g
a2VybmVsIC0tLS0tLT58DQo+ID4gPiAgICAgICAgfC0tIHZpb21tdTAgLS18LS0gcFNNTVUwIC0t
fA0KPiA+ID4gdlNNTVUtLXwtLSB2aW9tbXUxIC0tfC0tIHBTTU1VMSAtLXwtLXMyX2h3cHQNCj4g
PiA+ICAgICAgICB8LS0gdmlvbW11MiAtLXwtLSBwU01NVTIgLS18DQo+ID4gPg0KPiA+ID4gQW5k
IGRldmljZSB3b3VsZCBhdHRhY2ggdG86DQo+ID4gPiB8PC0tLS0gZ3Vlc3QgLS0tLT58PC0tLSBW
TU0gLS0tPnw8LSBrZXJuZWwgLT58DQo+ID4gPiAgICAgICAgfC0tIGRldjAgLS18LS0gdmlvbW11
MCAtLXwtLSBwU01NVTAgLS18DQo+ID4gPiB2U01NVS0tfC0tIGRldjEgLS18LS0gdmlvbW11MSAt
LXwtLSBwU01NVTEgLS18DQo+ID4gPiAgICAgICAgfC0tIGRldjIgLS18LS0gdmlvbW11MiAtLXwt
LSBwU01NVTIgLS18DQo+ID4gPg0KPiA+ID4gV2hlbiB0cmFwcGluZyBhIGRldmljZSBjYWNoZSBp
bnZhbGlkYXRpb246IGl0IGlzIHN0cmFpZ2h0Zm9yd2FyZA0KPiA+ID4gYnkgZGVjaXBoZXJpbmcg
dGhlIHZpcnR1YWwgZGV2aWNlIElEIHRvIHBpY2sgdGhlIHZpb21tdSB0aGF0IHRoZQ0KPiA+ID4g
ZGV2aWNlIGlzIGF0dGFjaGVkIHRvLg0KPiA+DQo+ID4gSSB1bmRlcnN0YW5kIGhvdyBhYm92ZSB3
b3Jrcy4NCj4gPg0KPiA+IE15IHF1ZXN0aW9uIGlzIHdoeSB0aGF0IG9wdGlvbiBpcyBjaG9zZW4g
aW5zdGVhZCBvZiBnb2luZyB3aXRoIDE6MQ0KPiA+IG1hcHBpbmcgYmV0d2VlbiB2U01NVSBhbmQg
dmlvbW11IGkuZS4gbGV0dGluZyB0aGUga2VybmVsIHRvDQo+ID4gZmlndXJlIG91dCB3aGljaCBw
U01NVSBzaG91bGQgYmUgc2VudCBhbiBpbnZhbGlkYXRpb24gY21kIHRvLCBhcw0KPiA+IGhvdyBW
VC1kIGlzIHZpcnR1YWxpemVkLg0KPiA+DQo+ID4gSSB3YW50IHRvIGtub3cgd2hldGhlciBkb2lu
ZyBzbyBpcyBzaW1wbHkgdG8gYmUgY29tcGF0aWJsZSB3aXRoDQo+ID4gd2hhdCBWQ01EUSByZXF1
aXJlcywgb3IgZHVlIHRvIGFub3RoZXIgdW50b2xkIHJlYXNvbi4NCj4gDQo+IEJlY2F1c2Ugd2Ug
dXNlIHZpb21tdSBhcyBhIFZNSUQgaG9sZGVyIGZvciBTTU1VLiBTbyBhIHBTTU1VIG11c3QNCj4g
aGF2ZSBpdHMgb3duIHZpb21tdSB0byBzdG9yZSBpdHMgVk1JRCBmb3IgYSBzaGFyZWQgczJfaHdw
dDoNCj4gICAgICAgICB8LS0gdmlvbW11MCAoVk1JRHgpIC0tfC0tIHBTTU1VMCAtLXwNCj4gIHZT
TU1VLS18LS0gdmlvbW11MSAoVk1JRHkpIC0tfC0tIHBTTU1VMSAtLXwtLXMyX2h3cHQNCj4gICAg
ICAgICB8LS0gdmlvbW11MiAoVk1JRHopIC0tfC0tIHBTTU1VMiAtLXwNCj4gDQoNCnRoZXJlIGFy
ZSBvdGhlciBvcHRpb25zLCBlLmcuIHlvdSBjYW4gaGF2ZSBvbmUgdmlvbW11IGhvbGRpbmcgbXVs
dGlwbGUNClZNSURzIGVhY2ggYXNzb2NpYXRpbmcgdG8gYSBwU01NVS4NCg0Kc28gaXQncyByZWFs
bHkgYW4gaW1wbGVtZW50YXRpb24gY2hvaWNlIHRoYXQgeW91IHdhbnQgYSBzYW1lIHZpb21tdQ0K
dG9wb2xvZ3kgc2NoZW1lIHcvIG9yIHcvbyBWQ01EUS4NCg0Kd2UgYWxsIGtub3cgdGhlcmUgYXJl
IHNvbWUgY29uc3RyYWludHMgb2YgY29weWluZyB0aGUgcGh5c2ljYWwgdG9wb2xvZ3ksDQplLmcu
IGhvdHBsdWdnaW5nIGEgZGV2aWNlIG9yIG1pZ3JhdGlvbi4gZm9yIFZDTURRIGl0J3MgY2xlYXJs
eSBhbg0KYWNjZXB0YWJsZSB0cmFkZW9mZiBmb3IgcGVyZm9ybWFuY2UuIHcvbyBWQ01EUSBJJ20g
bm90IHN1cmUgd2hldGhlcg0KeW91IHdhbnQgdG8ga2VlcCBtb3JlIGZsZXhpYmlsaXR5IGZvciB0
aGUgdXNlci4g8J+Yig0K
