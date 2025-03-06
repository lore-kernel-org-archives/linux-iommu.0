Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDE10E4
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741234211; cv=fail; b=bskxku9wGqXzIPX29zcsJ85DlHMpCMEXhtuRDVEbvhBKMVTd76q0r4KIfMh5hIDOBqPeCXmuCzA5CreWawJRZP674r6HscVdNIqosqNb2LAb3zLxpuquSnmqhQ5+wB3NLnTjDJQukpZsQqaryFgLffZ2uInWPMCab3NiQUtNyA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741234211; c=relaxed/simple;
	bh=mUS7yN7ouW9shJ9W3ProBrTkRGtJrbunXJcX9HI2fUs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOQOtgRYnfBufv+jSYxLcAW9ZpDKArbIsizWLuf8RS1oR6360kRWWA5x9jAAWmqjG+1yQtHJiDo5Qi6ypnIvRWAHT821oIzPTr676cFnVbuNkYgH58282HMJVzj0bB1FDCwkFb7x/f0m3rlM32lEM0L5goZcv2TSxXcpUo9YTxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3QLtvOo; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3QLtvOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741234210; x=1772770210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mUS7yN7ouW9shJ9W3ProBrTkRGtJrbunXJcX9HI2fUs=;
  b=f3QLtvOomVDXz97e+YCOTIN8iec3a7uskA9AOk5e000IFPV7Y1NrkDEl
   idfskk6veTN8aX79DU+Sn1hISKJNa3FCKOiyYFOhSibsb0G6wjkQScP+m
   hELhA1+T4LIIUtixkUZ/hM2kfV8DNmr3QJ+9/TYtlkWUrNV6UI7Lsw41y
   OR0VvI7ZKlRghLCqJHjaj58kypgMfrnGO1AYgiz0MIaqnjjvlxIMVX61b
   fpPSmeM9hAVdI/Nbo+HbtkBchsimpQh9XdvUs/5yY9BlWQEPwwJn+n09G
   bSnNTX8FuUh603ooOzMnODjxY9QJj5zkrWXCcUbH12OnYBnePwHq8Xzzs
   A==;
X-CSE-ConnectionGUID: sKe+kveuTwygaFIDrzdTgA==
X-CSE-MsgGUID: 4VwRjyzgQlyKBjojm4R+nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52874586"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="52874586"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 20:10:09 -0800
X-CSE-ConnectionGUID: QTPJ7k80S/+nbkvqO1RcKA==
X-CSE-MsgGUID: z+wUliCmRsiFaLsEvfBWyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124092578"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 20:10:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 20:10:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 20:10:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 20:10:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsDW5U9a+YR22OAYfjzc/V7JBeBcGeqyfoiug3sASv8GMmllJXnpGnMqCLX05hnhN1ZLWO6FPYNebD9hJ547QSnGB77h1gbSGOWw/SH9oSnBOJh2fXvjL16y62IATgAMYhHnkwiBgSO/O7eTUCA82rzuUJUHwbmwoCxqnBLtrBLtdkPC/xGhDpP1y69h0t0O8njv4e98yn8FX5WmS/lJsbdxIEHGOyKu8JivGkipXAQTXmzWy5Ipn3Szkl/jZcsj/gKto9sqbSx+MiqGmT+2NlwHAJq5phRy4tH9RewU/3h9513OZt7rPsBzBRLWNT2eN3Op5+4tdzpfhWoFozogNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUS7yN7ouW9shJ9W3ProBrTkRGtJrbunXJcX9HI2fUs=;
 b=RElwe+z/OFnghZ3pEjwLJKG8+0qgSOMRDfXTAoXj7c4gE/lPmMUDIjIvOxSr+3jeYXOQfjYythMYx+JfmVVfLY7SsYKHrObiGgL1ikGbgngqax/JNyz/zFdEzKz12Yy/qdhvC7mUB7Qi2n5fJZVN7UuaeRePidnVinq/G6Wtbvdxy2kA+4QBAiudjVlQmVo18xxBs3CMdZ4Q4n3PUWnfMGCQjJASKLIe9hpD9bj8+JN1vKtCbExlhuZ8AEjxWc2y4Hd9MqRQAoNm2gynWH5l97efvNzSXyCVaiYI6GBXSGE5exEAa/Hudxv2Xbe0DOrTp64dIXuBLdH1pKlK/hzMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4790.namprd11.prod.outlook.com (2603:10b6:510:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 04:10:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 04:10:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
Thread-Topic: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
Thread-Index: AQHbjc8TuaqI9dW2VEO8xtB9FKkZhbNkyaYAgACkT+CAAAakgIAACf0g
Date: Thu, 6 Mar 2025 04:10:00 +0000
Message-ID: <BN9PR11MB52760A7D6D2A5680A3DC240C8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250305130356.126424-1-yi.l.liu@intel.com>
 <20250305171838.GC133783@nvidia.com>
 <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d4da9e8a-e393-487d-ae4c-892fc139f2b3@intel.com>
In-Reply-To: <d4da9e8a-e393-487d-ae4c-892fc139f2b3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4790:EE_
x-ms-office365-filtering-correlation-id: 1b39cb7e-094b-495f-93cf-08dd5c64c3e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eVEwODRpeEJacHJqcUpMeHpYTkFhRjFQRVpPVnJKcDVFWU0yRzR1UDVsZGJn?=
 =?utf-8?B?Y0JkZ2RMaVorV3c2TUF1bDB1L3M1enprRkgyd2lCckhocWtPWmNHQkdLTm5V?=
 =?utf-8?B?Y2pRTDQyQ1Q5ZGZJekw2UlJlU3d2TTBLWlB1aWZjUXJFc1Z6aC9RaWdDNndZ?=
 =?utf-8?B?ZlFnSW1BSEY5NGFLRnJaNkcvWmdzd2puRksyOXpJN0h0aXNIREdQL1AvVE0z?=
 =?utf-8?B?eVNaUHRjL2l3c1BZcVZmdmpUaFkwV0ZvRThYQmw3c1ZpakhTSDBjWHRRYW1W?=
 =?utf-8?B?UjIvaEVLVkJyU2ptTG1PQlRSUklHYnFDSEFVMkVhM2FEUlo5RDFyMjBJSmJo?=
 =?utf-8?B?OXJhcHBmcDV0cWlTd0t1TWQ5VEtzRmtpd0gzZUJHMXN5Zjh3N1prajBPMnNV?=
 =?utf-8?B?MjZSOGdMRUJvNlRaS0FEaklNdkRTUzNybVRtRWViclZZSmV4cmRaSCtRSTBy?=
 =?utf-8?B?MlR4eHlZSGFaMVpjbFQ3Q3BmMzFwUmFxMitZTnR0b1REL2xOLzFPSW1mRUxX?=
 =?utf-8?B?dFV3alk4azUvVEpRQW5mSkRia3EzZFlZQnFjZ2xRU0JURms1MjdGN1g1TUNq?=
 =?utf-8?B?ajIrMmN6dDlYNWRRclkyV3N5TjdZRHdGb2RzNEFGOTVGKzVvbWw4Yk4wVUZZ?=
 =?utf-8?B?OHFWNGFBSldQbk5WajIvSmo2MU00dmJxaGdxbHZQTk94bENTTmdkQUVESDNu?=
 =?utf-8?B?ZkRJeHBCTm50ZHdXWE14VkR3OTZ6Z3BOdEptVmZjN21POHJzVzVvVEp2anhw?=
 =?utf-8?B?VUJEbE5wVG84dTZOSTRwSkNYR3pKUjVtaDNOcHRETjFMSG5YYmh3QmIvNk41?=
 =?utf-8?B?eFZxSkIzNmNqZTJ0REM4ZzF4Q2pJV0FEb0REMVNmR1lESzEwWkxueHROdG5l?=
 =?utf-8?B?b3ZSV2tTV09DTHkxVzhEbmg2aDZaclJVY3p2ZjhuMEhJaDc3b291ZzhoTGt3?=
 =?utf-8?B?SjhtbnNYankyM1ltaEJyK01udU9FTVpQdUR5SituZzVsQzRXU2tLbHdldVVa?=
 =?utf-8?B?NkUwTFA0dnZBUFhaN1Qzc3crWHphT0hXdks5QW9xQlFOckc3NGlscHozdHZx?=
 =?utf-8?B?TExvMElmRWJXR1NYMnJxVXU2RldHakVBaVVZaWNjWVhkZkt0YmQ2dUhQZlVU?=
 =?utf-8?B?VXhvZ05aZW1EYUNGRTc5MGtjN21jU3hVRkRYYUptNnZQc1Vyc3krN0E5dXlH?=
 =?utf-8?B?YjFBSXNTY2s3TW5XWldaMEltS0xLekJoeU1TaCtmbzhrdk9FTXNLTGgzSWhK?=
 =?utf-8?B?bHJUYkhEbWFZRGpOVUVwT0ZUVHdsa2l5VjNrTVE2amJqeFJnRVBwY3JodXQ3?=
 =?utf-8?B?dkdtL1JSTTRyVUU1dFgxK0s2ZnczbnhkTHBqZFVUc0VTcTZ3WkFnMmhqZGkx?=
 =?utf-8?B?Nm9qSjNEaHplZ2VjRmtkTTZieHZleDBuRmV6RDRpSE9JV2w5L01FM0FiZEJh?=
 =?utf-8?B?TUdBakZWTEt3R01tTFhtR3pjSFlNR0hBSDJyNE1zTTVtK1JmOThRYTlDZ0Ux?=
 =?utf-8?B?b2JIRXRWQUN5UjdPVWNCS2FiY2llRFBxQmJkUDRuZGhFckxXQlQ2YkRJZ2dN?=
 =?utf-8?B?NUJCZTlCUTFkK24rMU81bUhQRERReTFoVlZqZkpFNFNmL2JQMldwRFBPYkNW?=
 =?utf-8?B?RlZaMk91QittUkZzNmxEby9xMzQyNVFSbjZDTUxPZXpVRzd3UGJWYjBpbmFN?=
 =?utf-8?B?Vk8veTA2Mnl0VnVjdHdEeW9EQnZSS3RVOSswWEpUTWtKYnhYRnI1cE50SjFk?=
 =?utf-8?B?YnRxcDRBNDlheStxM2RLRXQxZHd6L0RUVFFHOGNMZ3o0TlBXVFQ3dDRrWTZ3?=
 =?utf-8?B?YUVNZjF1YlowUnlyZjBwcGhaamNZRDlTVUhpeUxHYW1ZSEtrOTZrbXM4a1Fm?=
 =?utf-8?B?K1hIazEwZGxpWVBNUGV0U1lHL25tSWczc1N3NWZGL1NuWkYvb2RuSmI5MDB0?=
 =?utf-8?Q?h6KC6gZwy2GgVbeL6g/Sre6+kjOgk0jP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjhodlIrbkNCTXRiUXZKdzBhcUMrSXkyWjZNOHB6SjkxaVo0RkVIbkVDajJK?=
 =?utf-8?B?cTU5ZE5JZFF1Yk5hdjFwdVU5Y1lOb211aExRMUorRy8yS2lMNG0rS25xOFZm?=
 =?utf-8?B?UGlXY0s1WmExL041NTFoNk53SnA0bzQ2bk85UFFpWk05bjNJbmpGWkF1Q3dF?=
 =?utf-8?B?ZGNqemNqWEo0dlpJNUd5UDBKL3lUZ3BBSEVxNENVampUODBsd3haL2IrL3Fu?=
 =?utf-8?B?Z3RQWHFtUDN0RDNJaFhoNk9NaEJqYU9MZ3JMYWhNUHBXSzNoZ0k3MWFtVVJw?=
 =?utf-8?B?cXhhUjNoY1ljSjhhVFl5UldwalpBZ2J6VmxzQXA5UUJoMDJkd2NwREVZdFBB?=
 =?utf-8?B?KzBRSTRFM1BtUGJseURoalNvNVN5Z1htRlFzR1ZmaDEyczk3OEp1WWZnT0ZD?=
 =?utf-8?B?ZWpORDhGcjJ0R0tDWUxZUEZoNmdrdzdyaHFIS3g1MVRnNkRuTW9hZVhsLzRs?=
 =?utf-8?B?SzY2emh1ZGI2T3djOEhwbzNqMmVzK0ZNZzJWa25xQlR0b05CK1dMVlBHWDlC?=
 =?utf-8?B?b1hQeWZzQ2RBWXNmM2x2YVVrRlZNOHhKWGQ1RGZtMlVhSkxvWmxYbEpGSW83?=
 =?utf-8?B?azZ5MC9HQnJkcmwyVTJDNGRTVFVNRVZLbDFpNlZQdEdNaGxiOXJvVVRoazli?=
 =?utf-8?B?Si9Tc0d5dTdDbmkwTFhBeTFDT1k3a0ZrM1VJdHJRbHZsNEJkTHpqeGdNeEhH?=
 =?utf-8?B?cGFoT3F0QkRZZ0tzS2NyeVMrREVYY2pJUVJpbENReW0yM2h0enRtTmRKSXR1?=
 =?utf-8?B?RlhxN3VXYTVzWUZWQmFrRTd6TXlNNU03blloQmVwQ2w3bmZ0SmptRGI0Q0dl?=
 =?utf-8?B?eGlPQURCUTZKVVdTUjhZeEtCZkVzeHgwdlVEYkVLd3l2Q2c5eWRXbGJQYWRv?=
 =?utf-8?B?Q1RSWkVhMUZ6SFNVdFo0WFdxa1crZFFVMERRaXZJcDJGWFNRSWlsOVJEa0Qv?=
 =?utf-8?B?eVZxakJNeGFmZlhtaCtMNWxxK01IbmZnMnM3VmYzb0tTeEV2OHo5SUNhMkY1?=
 =?utf-8?B?ckk1RmVmcDZPR2xRdDdZNVcyV09hcmZENGFxRUJoV2owYTM3NWJlS1gzNFZw?=
 =?utf-8?B?bU9xeVF5WHZpaDNvVEwwT3BQT3lZMHZmNjVoczVBNDJOSENRdnZBR0psU0tI?=
 =?utf-8?B?bVpyVFJsYVpUcFVaTTJUcHZzNGRhL0Z5bmtjR2JFMGlyczVCTEkxYmJ2RWZO?=
 =?utf-8?B?aDdVY0Nlcy81UTRnZGtTa3l4N1ZUaTd1SkU0VmFjNDVpNERaMUpNcEVRQjlt?=
 =?utf-8?B?RGdsQkVYTEU5cjEzNzNFeW4wYUwxckcrUVlCL1hiZk9hVUhkRE1WaEJyTmcx?=
 =?utf-8?B?ZkszVUJmcnoxV3RYYmxiV1dxSnpDSllHK09Jb0loQkNyWkZERFlEZUNTeE1h?=
 =?utf-8?B?ZFIxUzhkMVNSLzErRHZUNDgvdjhYN0ExWEgxSmwvUmtTNndRYXF1OWlINUsw?=
 =?utf-8?B?Z1pJOGk5TGRmRmpTQSt1TFlkUURVOGFyVnNoa0hhSGc2bklUejB3eHpzN2Mr?=
 =?utf-8?B?OEM4TFN0YmJ6OHJrVk03M1FFVjV5bFJuVWNsd29MYmFiRTBDR2JScVhTcHVs?=
 =?utf-8?B?QjVUZmxzZWtSbHI4T25qUm5JZkg5ZDZkR1V5Z2gwMWdwLzhoZG9wM2pxUmlC?=
 =?utf-8?B?Zkd5R3MxL2ZTTnFDNGcxekIwd3cvVnplbU03TjhwdXBUaFJ0L09EUnNwbVdw?=
 =?utf-8?B?MzBmNW9FcFV0ZnJKWmkzQ2ZNZVh2TDdrQjFic2lnaUp0V09ReFdHdmhqM3ZN?=
 =?utf-8?B?YnhObi9uNUU0T0NFbnBhYXcrcTJBQVJjWFFHZms0d3oxTmZjSUVOd0xMblg0?=
 =?utf-8?B?bllLQ0tOWDFIS3A0OWV6N0pGbEV1NXJkemdsLzNiYkF4OURLcWpwdzFlRHlo?=
 =?utf-8?B?Z1RzaERIY1ZKbExmWllHUXJacWR1RHdxZFA1enU3WVpJMWRkQUpGaWdDbUJE?=
 =?utf-8?B?REhmUUpQNGpvWUtQR0ZGSTExYVFRTUs1WmxwejZ0V0RjVm16cEwrZnpyTm91?=
 =?utf-8?B?VU1FRklQTWpDWEx6Vjg1bzhDU2RqeTBjeHozQ1M3UU54SGFMZVBUeEI3WDZu?=
 =?utf-8?B?aHVIYitYWmJSV1V5VWtYSXFQeVNVcDJNdDFxZ3AwclpwZFZFSVBucENYK0F3?=
 =?utf-8?Q?oUSvf/JJUkH9hiKrnuct2DmYH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b39cb7e-094b-495f-93cf-08dd5c64c3e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 04:10:00.9520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3yNFKLi5CGvWFwaZvJxxUFwVjv1o9+hzgFaHfENAClvIMTLyKordzF3GzK2CW+hDFB4y+Z27Bb8zcSNelGL2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4790
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IE1hcmNoIDYsIDIwMjUgMTE6MzAgQU0NCj4gDQo+IE9uIDIwMjUvMy82IDExOjEwLCBUaWFuLCBL
ZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4N
Cj4gPj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDYsIDIwMjUgMToxOSBBTQ0KPiA+Pg0KPiA+PiBJ
J20gY29uZnVzZWQgYWJvdXQgaG93IHRoYXQgY2FuIGV2ZW4gd29yayBpZiB0aGUgUklEIGlzIGVy
YXNlZCBpbiB0aGUNCj4gPj4gZmFicmljLCBob3cgZG8gd2UgZGVsaXZlciB0aGUgUFJJIHJlc3Bv
bnNlIHRvIHRoZSBjb3JyZWN0IGVudGl0eT8NCj4gPj4NCj4gDQo+IElmIHRoZSBSSUQgaXMgZGV0
YWNoZWQsIGtlcm5lbCBzaG91bGQgcmVzcG9uc2UgYW55IHBlbmRpbmcgUFJJcy4gSWYgdXNlcg0K
PiBzZW5kcyBhIHJlc3BvbnNlLCBpdCB3b24ndCBzdWl0IGFueSBwZW5kaW5nIFBSSSB0aGVuIGRy
b3BwZWQuDQo+IA0KDQpKYXNvbiB0YWxrZWQgYWJvdXQgdGhlIGNhc2Ugd2hlcmUgdGhlIGlvbW11
IGdyb3VwIGlzIGNyZWF0ZWQgZS5nDQpmb3IgYSBsZWdhY3kgUENJIGJyaWRnZSwgd2l0aCBhbGwg
ZGV2aWNlcyBiZWhpbmQgc2hhcmluZyBhIHNhbWUgUklELiANClRoZW4gdGhlcmUgaXMgbm8gd2F5
IHRvIGtub3cgd2hpY2ggZGV2aWNlIHNob3VsZCByZWNlaXZlIHRoZSByZXNwb25zZS4NCg==
