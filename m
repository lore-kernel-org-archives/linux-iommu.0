Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460931C3E
	for <iommu@lists.linux.dev>; Mon, 12 Aug 2024 00:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723422002; cv=fail; b=uLcFeemenMo6S5O6xpTWjHow6KTrP/8ZNdBAqSsR6S8iADDa6cmg4kPcunaidAQacCItF72ekEfiEH4HuPzmTHOEMhos+lUfpq+foKmRxRnq+D2vaQ+w9qFwkU6qCWjGKF4Fipe62BDxRJMAtLQ8VsFSG5laUBm6BjZxO2mwKJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723422002; c=relaxed/simple;
	bh=gxybC++Ln8fooaPBvzZskWAj6tq/EdlfU2ZkbuDm9d0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmCsZskDUoW5zSLCM6Kv5uQYYhZ03NZkHx/UmDHoN2X6sfo44Kj0YpKyiAP7PSQdwz29zgoMkJl0taMZVC0yI0n+tCKpGMUzJuktOf2o9XTbCqZx5oEU9Vfs2k5TPXaTsOKl44s6mDm/9yqRmgcxZ9Ur3mkJySxbAf56N8i/Zos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uhv9/gi1; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uhv9/gi1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723422001; x=1754958001;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gxybC++Ln8fooaPBvzZskWAj6tq/EdlfU2ZkbuDm9d0=;
  b=Uhv9/gi1KFF241iSw4pZUtxrZV3Z3grRdNxE/a3fchAjHcd0Ads7mwFG
   GqxJ2LvD2PcF2mVLRT7b2uMgu5zmm09AdVqkX1ijsI83eId0dgW/Ps204
   L2rYEZDuzDltiRLEdbqRprB+0OgXirEoWbPLnyQsRxTXKbtPIUIy0+Spt
   TAbH0Z6RwyYU2yNnk+mHD0qoz09S36sSsrSxh3G5jkbj7Jw9mpkUl58J0
   sW9lm8vjLYEsMb9WErH8Q0JXrUz3mDzkaVfzGtSaG+7mk/oj7TSaZG90s
   9iLD+bJoWz9404ydpdPoNlwo1/DS0RslV5fue+od8sgCdLioAzNrcXCo3
   w==;
X-CSE-ConnectionGUID: kJzFRjA7QriSU6uwpKl1sQ==
X-CSE-MsgGUID: 1SeqFd3rRmqZrcuIMKSPKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21684857"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21684857"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 17:20:00 -0700
X-CSE-ConnectionGUID: UNYTjVZTT1emIhzlQ8GKuQ==
X-CSE-MsgGUID: xigx13kITRuIyzmfOnysaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="62497637"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Aug 2024 17:20:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 11 Aug 2024 17:19:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 11 Aug 2024 17:19:59 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 Aug 2024 17:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WA8tzDnMSOZMaG5QjNqBWQJtAlxu1TpcLDcQDATprnZe19VKuU0tSYKlgAaMBpuzTU1M9osk6lLoGJBrcOdiYbkRmVr4fV2iAwUQn9QSniZ2RWMKpUfvWZzgIM/CjlXMwKnJ0rrWsW0EYQho8q7hQxOkm1cI08q9GZCVpuGxXEYiA9h+DmKSFBWoIuuR1vdkjC5mpzK2MnU9l73dG3gWvC2T1gN4tp2j+xewnSajcVMSCZ13F2pJySfW2rqGnAuduAZ1Yp7KS/RjXdLRISwZyz1h0OahUkZOOv+ZYQ31YPEpUf84CJlQtM7HUBU35IgOiYipb6gFhmxV2EOo4hR7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxybC++Ln8fooaPBvzZskWAj6tq/EdlfU2ZkbuDm9d0=;
 b=bT4PVVZ8XAJKuCDV/27S4nZiOgr39036eeEsfNr7n67OsHsEfcFVwRQ433iUqSJ8h9fyjVrQsE9IhrfQmJwJ4e8uOBDZ8kZt9ZIDGbJBYX7w7vUEZUs/u7tIfr2YIIjkPr2zvWefZmOCXtGe+KduIYhzUcLv7jrc26bJjEYnhmgUnfmy5qc82kKHZiOBGjtUMeMmnkv2byfj9BnRgMtib/UB1MCJpBCLhRzpiNjA8zzzPfWNoGGKZ2ogFRPw/FiU7nowxRyLeMTIiRhRaWXZeW/K+Cn91o2+Kv8qytqiu3tQTlmCrDY0YlA6OcX2UyU2wWb9fzN/225fqptzAh+0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB8151.namprd11.prod.outlook.com (2603:10b6:208:44d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 12 Aug
 2024 00:19:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.031; Mon, 12 Aug 2024
 00:19:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 6/7] iommu/vt-d: Add support for static identity domain
Thread-Topic: [PATCH v4 6/7] iommu/vt-d: Add support for static identity
 domain
Thread-Index: AQHa6iErS+XrOqfZj06v0mD/V22fg7Iel+IAgAGK6wCAAqMhQA==
Date: Mon, 12 Aug 2024 00:19:56 +0000
Message-ID: <BN9PR11MB527670BF3C50556D249598738C852@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
 <20240809055431.36513-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BCEC41AA08D80CE985F18CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8f5ee898-162a-49f6-9044-7e3ef6dafe1e@linux.intel.com>
In-Reply-To: <8f5ee898-162a-49f6-9044-7e3ef6dafe1e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB8151:EE_
x-ms-office365-filtering-correlation-id: d7f5b500-06f8-4d36-d0cb-08dcba647edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bnNrdTh0c3RzZ0VrbHZ3cFdQZjVHYmxWZEE0bXYzTTRXMUg0VW9hQ0JsMHpN?=
 =?utf-8?B?TGd4eUZTdWk0T3laaUYzdENRQVdBWlRRSGcwV3ZnUDRnNXBxVEFKNVlVMGly?=
 =?utf-8?B?a3NYNmhtOStGaDdMQ3kwMFlpOFFCbWZiM0tyRXNuYzM4eW5vU2l1UjJ6UjJI?=
 =?utf-8?B?T1dMNEh1WFZWUDJ3WVBtMlFNWm1Da0FUM0JpN0NQUkdpTWkrNTIzaE5nSXlB?=
 =?utf-8?B?V2h3SitzRklwcThPZVljdTFFUFdQU2t0eW9vckZLa2h5L2MySkR1R3YyZnc4?=
 =?utf-8?B?Zi92V3FSSkJnZDl4M2NudXBiSTdlV2pLNnp0RWEwSXhVUjIyb2dFTHFIYWV6?=
 =?utf-8?B?NWZKOFBFelhwNnhzL3BINVNXNkJqR3FKb1hqSEdOdElLS1JMZmxrcy9QLytV?=
 =?utf-8?B?akQ3ZFpRQVM5L042eGpuQUZWK0hNV3dSQ3FwUkY1czg3c3QxNzQxYjNVZndp?=
 =?utf-8?B?RldZQlBkaWE3dGllbFhjMnhTUTFvUnB6S2lOMzUvelNhQnhYYnNMSjJQQ2tE?=
 =?utf-8?B?SVBUMld4YXFhMldqRDJPVmFuQTVUZUZUZXJ2VmRPY3lxS2NReVZJMFIyRk9z?=
 =?utf-8?B?c25hK2oyTWh4T1V2bk1TcEFDSDZqdHNzak5QQTJJQ1I0SzBsTFBNZC9MWjZC?=
 =?utf-8?B?cDVIZjNhaGk4dWdtSEFCeUtzK3ovZnB0Wk9IdTZzMWtXdDMwVERrVjNrQnlF?=
 =?utf-8?B?Qkw5Vm9uNW16aVh6QjcwaGQyUVZBZ3pQdkFBejhkZ09DVWNId3JvNHlHVUhV?=
 =?utf-8?B?ajltYmFheUl6Nldqb1lSZldLTjBoOWpJTzZOOE9RRGJTMFI3WlNKNnhyTy9V?=
 =?utf-8?B?NmZmZ04vN3grRFZxRndYUjZwN2JXS3ZzYWlFS1dCcTNSK3VMcVZRblZvYkt0?=
 =?utf-8?B?Wm5TWFN3WEhKT0kwVVJIZGZSeTJFRi9wRGozUGZoQTNvSVhHbmFBMzVvaHFa?=
 =?utf-8?B?WUkwSjE0aGpkRjNGWnNRNHpzK3lIc0JzMnZ1RThnZWxJZ2V6c0pPSjBQQ2JR?=
 =?utf-8?B?bldJbHpDMVg1REJoWmRrS1hIYkNNaXZ1TE5NNGU1cGVTU2hvUVdySkVOdnFY?=
 =?utf-8?B?UnRsZHJpK3JwSjV6aFFVdzdZWDhGK3BpOGVjTWNneDNSaFdUN2J6UzJ5SGYw?=
 =?utf-8?B?eWNCYy9xTnF0d3cxY0lhaGZUa1VPUi9ybnRJQkcxMnh3VFhOUGlzaWtVOXBW?=
 =?utf-8?B?SDVlU2QxTDdjNk54NllHS0lUUUs3amFabzZQeVVCWnNDamFUS2pjTjNvVFdH?=
 =?utf-8?B?OXI2SE5aWmtCaDNyZHBUOEdCbUQwbVZLZGsyaEkrdGtBOVdzOXVGK1pxemli?=
 =?utf-8?B?N2RXSmkyd05TVlp3Y3F2QW9WNG9ERStjajdWU25VSWdGMjV1dlZyWGhwZnlN?=
 =?utf-8?B?RDh4Vno0Rk5xbHFvZ2NqUDZhYnprMFNOZkFVWVZOZURuZnRYVzNZVDU0bnBS?=
 =?utf-8?B?dXRHUkZnaCtjdFVZR2dOUmxXT3NaOXVEN3QyUHF3UE5maWFWSm9JT3htL1NQ?=
 =?utf-8?B?cUVDNEMzZ2tpb3RMYXZxeU1XYWFWaXJlWitZWkdKSGVRSWZHalVjQTUzU3V6?=
 =?utf-8?B?bjhJNEZnY0syU01pL3pZM3Y3aHUvdWZtOXFuNU5rT1p5Z21KeTQvaElNS2xB?=
 =?utf-8?B?ejVqSkh1amNFN29CcjlCUFNBUGlCWU1jOE5xQWpkNkduUzhhbFlZeGw3NXI4?=
 =?utf-8?B?NXV6eXREaUZrOCtRcG5NaUh5RFk5RWFsQktYdWkyQnd6RTUyVElsTitxT2Nv?=
 =?utf-8?B?TCtBaGgwbW9vam1BOXJHbERJZGJFQXVRRUZwRXdlMnR0clp5VXBYa0JVUFpQ?=
 =?utf-8?B?S3ZObm9odnRoODZncDNkVE1YZUdxKzErbjZ2OU52ZEI1eU0xakhhdFRnTU00?=
 =?utf-8?B?c1FQeFpsakRmUWJzcDNFcnNDaCtnb0JIZ0tqbDU4Y2s3Unc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTVXcEdpdDFyWEt2ZDNBRFdaMHpneCszQ3o3bVJqVWdxUnJ4a0EvWnN4L2ti?=
 =?utf-8?B?RUFSV0pnNGN5cUMyekZUWXZaS3F5L0N6Q01wZWtmL0kwWElxOU9PaGgvblpI?=
 =?utf-8?B?VnJoV0plNmlvdmFkVU5qWW8vMlpaN2t2OXg1dGNjUFRBUnl0V1A2WHBCQUhW?=
 =?utf-8?B?MWdMajVxWldkZXBRdXVDcWw4K1FmcE52dWlMa0R0NTR2Q2FsMXI1c2l5cEgy?=
 =?utf-8?B?aUlwMkkzZUhMRXRUWFpNa3dWWDlnQmp1WWFLV0kwc0FWVDU2MjBuNTQ1T1p6?=
 =?utf-8?B?UXN3VWJlOGtFU2NsSmFybXJYdEYwUlBZczhQZzlnYlVxcDZJU296NUcyQkxU?=
 =?utf-8?B?VkQ0MmFjeFZmS1lkYi9jMXZqUUd2c2IxMW1CRjhpZDdtdjNIQS9DeE1adGxq?=
 =?utf-8?B?RC82WEdoM1NvTDZFckQ2ZUR2cVhlWDhnb01KbTc3UUdMNVFJRkVkQlpka2NF?=
 =?utf-8?B?akVNZEIrR0V6NnR4WXdLdENiUUVzMy9ENnlYd2E3TmdPTDBlelZucUF0NSsr?=
 =?utf-8?B?bzJpRktjRGdqeTNJd2t0ZzQ1eUhsamZjSlNhL2Q4SFZrWmJHVXU1RWFNV1BJ?=
 =?utf-8?B?L0FxT1NHRXI3MFlldjh2RGpVK0lHT2g0QWpTTVArWWFpY0tmSGV0VUJsbGZw?=
 =?utf-8?B?Qm1NcXdyVUdYdzFQM0JRMGx5OG01djc1QVB0TUdqMzFKN3d5UUo2QzkvZkVo?=
 =?utf-8?B?ekV5WjRVeGNBaVpJZ3hIbkYyYXlhcU5kLzNoTGM4bTUvMnRYK2tHOGp2OThk?=
 =?utf-8?B?dWp3NEZPVG8zbUJCbW1LUTVOaHg5NW54N2JGZEV5bEpzYTFGekZmWU94S204?=
 =?utf-8?B?cUYxeStFWmI0eTNDdWVreVo2ZzN5VWFwaWRYWm5rNUFJUFZlSm9OcFJKZ3Q1?=
 =?utf-8?B?bFNFNzFsZ3Q0WDVCVHVnOENyby9nbS9ZaytVbS9NYVlZWS9kWWIwc0VlZXhC?=
 =?utf-8?B?Ky9LSUtRYmVIWUVkZmJwZ3Y0c1JQQTF0V2k3UDc4Zm1kQkR3TUEreG5mSnJx?=
 =?utf-8?B?UzV4Y0UvelllUG9NQmhvcnJjMjdlcENhKy9wNDFUeENhYkZQT3U4YkpUam1Q?=
 =?utf-8?B?Wk1Ic0hwV25yQ1lmbXdGbmcyNksyYm5uMXpMay84SGtoQ3UwWDcrZjBxKzFm?=
 =?utf-8?B?MG9OeGdEaTh1SmpEeUtJeDRnNVJrS3ZDSTV1d1BZNlBQSGxNUXV6NU5tV1Zo?=
 =?utf-8?B?RTFMSVBYczBaUmJpdSt6L2V5eTdudVNXMEJqTlg4ZGtiWXJCekFhZ01SUmFO?=
 =?utf-8?B?TmU5azdMK08wbU9TakNpaHNoSFVpb1BaS3UyU05EN3dHZXQ4aVdvYkdFcjZI?=
 =?utf-8?B?YWpGMFgvcUtGcUtzc0M0a2k5cUg1bUttN28xYlZCTTR0SWs3NU1vTzdvT25O?=
 =?utf-8?B?Q3dKaG1VYkRtMzlRdnZha3lVMGt4RXR5YVMxeWlYYzBTK2cwTzBKb0c1eFFh?=
 =?utf-8?B?eUZLbUdBNHhUQk1pTEVBaHBRRDVhVUJERlNJRDJaaVJ0cXdmcFdMZytVRW5p?=
 =?utf-8?B?b2wvc3Z3QjRMTUdHVlJJU3JHM1NXeGFnL1N5N0VkajIvZ1JRYWZWU1JsS01a?=
 =?utf-8?B?eTgvVWNvM2M5SEdLQkdwZ1dhR1o3Yzl3dnZ2VjFld1RRbUFzY3NVZk1aTDlT?=
 =?utf-8?B?TEIvWWJuSk1hVVRCSVcxRmxBanZlZWUyeXNHemhPRFcxcjhudVlNR3JZc0Nr?=
 =?utf-8?B?ZTNaN3dQR29ha3JMc1hrNnRSMEEzb2lzTlVCaVdpREcyN0xPKzVSaDlNUjhj?=
 =?utf-8?B?aDErRnVsYU1pY0R1dFI2NkxwbDVoR0syN0JWelRER1NCaGtrQjNqclZ6YjQ4?=
 =?utf-8?B?SXZWSnNtSmtlV2RVTWhUTGF3a0tmbVlRMHFPSEFPQnJTR0h4amVCYmdaKzVz?=
 =?utf-8?B?TXQ0WjZrK3VmRlFuOTREajhack05T3M5alVUdXVsRTdEUm1ScC9INzJBN3Bz?=
 =?utf-8?B?MjZaMkVtd1FZZFVOY3NWMjlsVUVEYzBHOTZENmt0ajFWQUViUGV1UGNvRjRW?=
 =?utf-8?B?aUhOM2g4TFdmc0lvSDEzYU52RmI5cnk2a3VEakdVNVQ5S1hPb2NoZU9RcHVT?=
 =?utf-8?B?WTJyVzRzaXRXb0NwOVhtWkx1SzdsUDlYR3IvazdVNTEvc0QzMFJSeFRvMlpa?=
 =?utf-8?Q?pH0JxgYarMVV6zT/IiGmo5OAP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f5b500-06f8-4d36-d0cb-08dcba647edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 00:19:56.7837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzX1VBh6p6TMYn9ZHtghbSPVEjwhdJfp+trVf8QiBMs1v3l9k+qun4M9q0O2qxYAZ8G13WMaoQAXWpfLwZNtSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8151
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTYXR1
cmRheSwgQXVndXN0IDEwLCAyMDI0IDQ6MDIgUE0NCj4gDQo+IE9uIDIwMjQvOC85IDE2OjI5LCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBBdWd1c3QgOSwgMjAyNCAxOjU1IFBNDQo+ID4+
DQo+ID4+ICtzdGF0aWMgaW50IGNvbnRleHRfc2V0dXBfcGFzc190aHJvdWdoKHN0cnVjdCBkZXZp
Y2UgKmRldiwgdTggYnVzLCB1OA0KPiBkZXZmbikNCj4gPj4gK3sNCj4gPj4gKwlzdHJ1Y3QgZGV2
aWNlX2RvbWFpbl9pbmZvICppbmZvID0gZGV2X2lvbW11X3ByaXZfZ2V0KGRldik7DQo+ID4+ICsJ
c3RydWN0IGludGVsX2lvbW11ICppb21tdSA9IGluZm8tPmlvbW11Ow0KPiA+PiArCXN0cnVjdCBj
b250ZXh0X2VudHJ5ICpjb250ZXh0Ow0KPiA+PiArDQo+ID4+ICsJc3Bpbl9sb2NrKCZpb21tdS0+
bG9jayk7DQo+ID4+ICsJY29udGV4dCA9IGlvbW11X2NvbnRleHRfYWRkcihpb21tdSwgYnVzLCBk
ZXZmbiwgMSk7DQo+ID4+ICsJaWYgKCFjb250ZXh0KSB7DQo+ID4+ICsJCXNwaW5fdW5sb2NrKCZp
b21tdS0+bG9jayk7DQo+ID4+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+PiArCX0NCj4gPj4gKw0K
PiA+PiArCWlmIChjb250ZXh0X3ByZXNlbnQoY29udGV4dCkgJiYgIWNvbnRleHRfY29waWVkKGlv
bW11LCBidXMsIGRldmZuKSkNCj4gPj4gew0KPiA+PiArCQlzcGluX3VubG9jaygmaW9tbXUtPmxv
Y2spOw0KPiA+PiArCQlyZXR1cm4gMDsNCj4gPj4gKwl9DQo+ID4NCj4gPiBJcyBpdCBhIHZhbGlk
IGNhc2UgdG8gc2V0dXAgcGFzc3Rocm91Z2ggb24gYSBwcmVzZW50IGVudHJ5Pw0KPiANCj4gSXQn
cyB2YWxpZCBidXQgdW5uZWNlc3NhcnkuDQo+IA0KPiBTaW5jZSB0aGUgY29udGV4dCBpcyBwcmVz
ZW50LCBpdCBpbmRpY2F0ZXMgdGhhdCB0aGUgY29uZmlndXJhdGlvbiBoYXMNCj4gYWxyZWFkeSBi
ZWVuIHNldHVwIGJ5IGEgUENJIGFsaWFzZWQgZGV2aWNlLiBUaGUgaW9tbXUgZ3JvdXAgbWFuZGF0
ZXMNCj4gdGhhdCBhbGwgUENJIGFsaWFzZWQgZGV2aWNlcyBtdXN0IGJlIGF0dGFjaGVkIHRvIHRo
ZSBzYW1lIGlvbW11IGRvbWFpbi4NCj4gQ29uc2VxdWVudGx5LCB0aGVyZSdzIG5vIG5lZWQgZm9y
IGFkZGl0aW9uYWwgY29uZmlndXJhdGlvbi4NCj4gDQo+IFdoaWxlIGl0J3MgZmVhc2libGUgdG8g
cmVtb3ZlIHRoaXMgbGluZSBvZiBjb2RlIGR1ZSB0byB0aGUgY2hlY2sgaW4gdGhlDQo+IHBjaV9m
b3JfZWFjaF9kbWFfYWxpYXMoKSBjYWxsYmFjazoNCj4gDQo+IHN0YXRpYyBpbnQgY29udGV4dF9z
ZXR1cF9wYXNzX3Rocm91Z2hfY2Ioc3RydWN0IHBjaV9kZXYgKnBkZXYsIHUxNg0KPiBhbGlhcywg
dm9pZCAqZGF0YSkNCj4gew0KPiAgICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBkYXRhOw0K
PiANCj4gICAgICAgICAgaWYgKGRldiAhPSAmcGRldi0+ZGV2KQ0KPiAgICAgICAgICAgICAgICAg
IHJldHVybiAwOw0KPiANCj4gICAgICAgICAgcmV0dXJuIGNvbnRleHRfc2V0dXBfcGFzc190aHJv
dWdoKGRldiwgUENJX0JVU19OVU0oYWxpYXMpLA0KPiBhbGlhcyAmIDB4ZmYpOw0KPiB9DQo+IA0K
PiBCdXQgaXQncyBpbiB0aGUgb3JpZ2luYWwgY29kZSwgSSd2ZSByZXRhaW5lZCBpdCB0byBwcmV2
ZW50IGFueSBwb3RlbnRpYWwNCj4gcmVncmVzc2lvbi4NCj4gDQoNCkkgZmFpbGVkIHRvIGZpbmQg
dGhlIG9yaWdpbmFsIGNvZGUgd2hpY2ggaXMgd2h5IEkgYXNrZWQgYWJvdmUgcXVlc3Rpb24uDQoN
CkJ1dCBub3cgSSBnb3QgdGhhdCB5b3Ugd2VyZSB0YWxraW5nIGFib3V0IHRoZSBjaGVjayBpbg0K
ZG9tYWluX2NvbnRleHRfbWFwcGluZ19vbmUoKSB3aGljaCBhcHBsaWVkIHRvIHRoZSBzaSBkb21h
aW4gYmVmb3JlLg0KDQpTbywNCg0KUmV2aWV3ZWQtYnk6IEtldmluIFRpYW4gPGtldmluLnRpYW5A
aW50ZWwuY29tPg0K
