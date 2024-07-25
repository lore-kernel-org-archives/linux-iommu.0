Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104AF3DBB7
	for <iommu@lists.linux.dev>; Thu, 25 Jul 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892906; cv=fail; b=CIUVbX/Vdc/WOnp7U/J/IJXkdpKJCf+0WGJAPvgv7dd9VkUGyQYDyABIix5ZWozAWvKGMrY4mybwd4VTVryBEt5WJuAaYk+tiEsiHVynDkWrxzvEDPggEChGWI4UPPTn32t8y/impZ5toaFOTRpY8kY4l0zPqsrVAprG8ErbSvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892906; c=relaxed/simple;
	bh=OX+NbreiJ2MZOyxVUhpAB/cfLBFVu04UfklTfyjkzQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=czl8t/uvHK+dvfotAHfVIeR4r2hQQoPAm6pSmFY1veRqBs0b0KntVkJ//P1NjZVxGZtrjzX5R54KeTOr4L8/vR/aekHdau2H/NET37sqS8V49tohIQDOqMKTje7rCnxNaeNhgB/YqPG7ipS1FKNrdCB6PQDFnBtO2B6RrMrIgV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBwblgn4; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBwblgn4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721892905; x=1753428905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OX+NbreiJ2MZOyxVUhpAB/cfLBFVu04UfklTfyjkzQs=;
  b=ZBwblgn48SddWkFSA/heXKqLU1+sIM4+CdKx2IfEHmYAqEC/W/SZ00re
   1FxioiSx1J4TUnhJ1klu/kSQjqXGpIhxBA/s8ysb8qbi2njIHdDlNXGAu
   vh4jeUULIy9oTJmQ0hLwePMlrs9oZKQSoGXrOLukCjCKTNYvkrxu0jib1
   53SiVLsW4pmvwOv8ebBdkHvwQWP/7BZsuSZiSUNkKZ1vnJ7xH/hPW1zJ0
   mHrS1sePI2qQfrCf0H0h3JDP60+xIkRnknzYyHpwxa1SFyVw1mVbSfVZi
   FriLbjUgBucCsAaXOKb+kkn8GxeML5oLRbcrUeGClnXpsbkXJCDDWnlle
   Q==;
X-CSE-ConnectionGUID: n8lNnCwMQCe0zgCOpG58oA==
X-CSE-MsgGUID: 3ZtszNrcTF6UaWbHfJ0wlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19222535"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="19222535"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 00:35:04 -0700
X-CSE-ConnectionGUID: dFhVevdMQTusH6bgybNe3Q==
X-CSE-MsgGUID: LMQLUpf3QMShTCqCvjSp8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="52773909"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 00:35:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 00:35:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 00:35:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 00:35:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 00:35:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGcOOXc92QrPpkL7apsgNn07FD2PEm+Cmxg9CpzQG5OgrZJHYDYh+Frvv4dyQox6MeGW0jRobfM+dP7AcSNWRqEYiVh05GzogLjYI6jwh3zbz5KWQqzrUMSpTgrX3bI5XR82muRJJGv2Xd34ms976cHwheYHtpOFSUlXJxMUOzFxAQIv7CicCe62h/lWDiXcxCs/7ebqwytZUFEI1gpKPkB3ZgjII8O/Vb5G/NtdJS0s82umRkBaNGV7njMBcgw6qKkXH4s08p1HuI3XYQfV/iDWO0Z6r84OIv8XDaRB5/w15X4tCfPUHXZQPbQwFDQOZ1ALyKJuk00mTUrM8D8j3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OX+NbreiJ2MZOyxVUhpAB/cfLBFVu04UfklTfyjkzQs=;
 b=vcDhoVduA69TqG+JaPazR1rq1We+551O450OMaaTptzzGB6f4yrH06iArxuJSHlhlJN4N6amJHjnqCsStVC0pkYtORRBdGJuCceWuuOEPoEU9kbm++XIRT34twA/e6T5zyikA+8PuQy0tYKU3B6IYgMKHfzU2QrMdRwF+eCA+xOobsRFB2SlWG0DHEUhsJjXF38fzOyglUnm6s6w6x9gA5qKX3irUTDVy9/3I/SJUkH+HMLGtZoK7JmrgiEE1CfQpCxp1NFVEOQ3JBBVCrzYFVckPpjv6bKlXh4fOHYnIgSMJywoZBxhlIHcpEYtKKSsTPuwZtuA05rfnproRhdMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7057.namprd11.prod.outlook.com (2603:10b6:930:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 25 Jul
 2024 07:35:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 07:35:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>
CC: Kunkun Jiang <jiangkunkun@huawei.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, Michael Shavit
	<mshavit@google.com>, Mostafa Saleh <smostafa@google.com>, "moderated
 list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "tangnianyao@huawei.com"
	<tangnianyao@huawei.com>
Subject: RE: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Thread-Topic: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Thread-Index: AQHa3WrLSmtjtahFz0iDm1P9QVDPxrIFm1CAgAARIYCAACxwAIABM47w
Date: Thu, 25 Jul 2024 07:35:00 +0000
Message-ID: <BN9PR11MB52762A8455449C6A432DA0BB8CAB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck> <20240724130320.GO14050@ziepe.ca>
In-Reply-To: <20240724130320.GO14050@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7057:EE_
x-ms-office365-filtering-correlation-id: ade66912-cea3-4296-18d8-08dcac7c4a7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFBBMTQzUDk3QVVDRDAwdkhRRmlYdzIxay9hWFRXbzhvSXZIYXRYS1RYRVJk?=
 =?utf-8?B?N0dyb05WK2hPZjBESXZCME1kQ2Fqb2RIYlJ0ZllIcWg1alllaGx4QmptVElp?=
 =?utf-8?B?SnA4L3o4ZzNBSjNGODNON0V5YzZ3VHVuTnpBVEJFSEwyOWFqaXUzNDRlbnNZ?=
 =?utf-8?B?T2drUzkxTW5MMCt3MzFNNDFob1NZQzI1SU53Y2JVc0pyRkd6OW5MR21tNGkr?=
 =?utf-8?B?OVdXdm5nNldmZXEwaVEzTW5aWmlUVEVoMEFjc1B2MmRaTXJDaUFkN0ZQcHd1?=
 =?utf-8?B?SVB4amU0S2tuT0ZaSEo0REFiYWJlcVhTbmovakhqRmh5cXRnaVQvOExUcmM2?=
 =?utf-8?B?Y3ZEM3FFdEoxcXBMa252cStweTlJKzBEdlVibXh2aHhCelRVZUQ4Y0ZSQ2V4?=
 =?utf-8?B?bUlhcWUwdTlnOWk3TEZNZzQxVjFZZDV2bnRRcmVQaXA1ZS9JTWNER2NmK0RO?=
 =?utf-8?B?R1JVakMzR3RPdDBQWDg0SWJxYkpqVWoyUEkvUit0L1ZiUGNGdm8zNW0wZ3JH?=
 =?utf-8?B?UzV6RnIwTkN6NXkrcHYwTlcvWG9acDlZRmRtQzdGeTBHVHZ3ckFwMzVQM2Yr?=
 =?utf-8?B?WG5iNjMzSVRWRE9ITlgvM01RNkd1MHh5L0pkU3hkTmxjZWh4cFQ1VlhNdmV6?=
 =?utf-8?B?R3VDOVMycTRGRmRpUHQrcE5sU1ZHMEQ3bC9QbmFTaURYZkNhMHFraTNURmpT?=
 =?utf-8?B?dmN2U3V3YzJiWUVseS9xWUFBSEV0M1FCMXR2bmR5TGpQcERjRXgyWUFORGk2?=
 =?utf-8?B?T2FUd1g4cDBhZ1pQUVBDTVlYRjNhSmwxM0o3UTdPNUJUVHhJWTBmQnE3ZTdl?=
 =?utf-8?B?end3UnlacUVrOFFGZVE3cDgySlZSMy9RVkVSNlJDM2FDLzJrNi95Y0s2b1RW?=
 =?utf-8?B?WFZHZVZMMnQ5UUhCZllrOW5MdUpVQXlnMFJaYWpnaGhJK3BydmZqSU5JOVYx?=
 =?utf-8?B?bkFoNGtSTzd0aGxmYTFqQnJqWGoxemhnMDN4Q2FJMjV0K2xIb0JtTUljVXdK?=
 =?utf-8?B?QVBzYnBTSWVjRmpRNzQreWl2UTJWak5DTDlNd3ZMNFVHKzc5cTV6MWpjQVo3?=
 =?utf-8?B?TzFwUS9OVVY3aG1LYjAxNU4vMEpnQkl0Z3gwK2N0Z29ydGxhWW93YS9uWVpR?=
 =?utf-8?B?RW11dFhMQVF6Zzc1MjVaSVkvTjI0TUdmdzdKdml6UWQxdGhrTkRwS0ZHVW5h?=
 =?utf-8?B?cTBFcUJEdVltWEN2SmV2a1EwRFl3bHJrWVI3Y1luOHVGNDh6N0VoK3FlNXBn?=
 =?utf-8?B?WlNwcVQ4N2lSa1pic3hzb3k3VUovZmFZVGR1VmF3TXVWcTdjTUVnaVd1R0Er?=
 =?utf-8?B?M2JVbVdZbmwvTTV3cERGNmVqM3kvK0lPSXYzOFRNMm1KTXdQOENxWlYvM25i?=
 =?utf-8?B?ZFRUaXVwSTN5aFdGcExXRlVYd1g2c09NV3BsaVhNR2hqcGFaMXBsTkFTL2Mx?=
 =?utf-8?B?V244emVlYnZSSUwxRUNvQ200cEg4SFBUN3B0VU5rRm9UZnZLY0V4V2NsaEk0?=
 =?utf-8?B?NmI5dHhLTFV4V3JYL2pwR1lHMjVqUWJSaE9KSXU4aWJNSGViZVUrZlV1Q2Jv?=
 =?utf-8?B?eWNyQ1hjb0hPVnM3U25pTE8xUVNKRyttTEluVGtuVDZVNUkzNzF2UlBjU0gv?=
 =?utf-8?B?SnVzRUJUMEFURGtFY0QwZmVtUDYvK05XSFdxRkZYRHlXWjZrMCs3bFFjVm5S?=
 =?utf-8?B?RVphaHNiWU40N2M2TXgzcHhTWkZrbnpHN2RJRVQycHN0L2I0QThnbU1QQ0Zo?=
 =?utf-8?B?YU1lbGhDYWZpNEx0MVRxRy9KTjU0NUVuWDJIRUM3Y0s3THpqaHJWWEtPNUhP?=
 =?utf-8?B?Wmwybit5cnJnZmo4VFFuNEdlTi9yVFY1UHQ2MjJrSDJyc1Z0bmR5Qi9IUEtO?=
 =?utf-8?B?STRnYlF1T09GQms5QWJkMnlCS1JIZTkzREppdkMzNFJINWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjdQK01obzlXcGZsREY3MHo4Mi9oZ2t3QTRVWWFCRXp4c2VnUTU0VWNlSW9D?=
 =?utf-8?B?cmlSZWxGL0NGaCtkU2JJQlIxYUtpNTVEeHhTVTdBb2ZpL3QxcDI4eXF0a2Jl?=
 =?utf-8?B?eHRpZEdjclNJczRxODhaWlVRV3liOVdjZTJYWnh6WURMYTVCVVl5Mjc1dWta?=
 =?utf-8?B?UnJJd2F4bFBXc1hoMzcwamx6MzM0dzFtSldjRFhuc1RBTnU1aFhRY1R5bGcw?=
 =?utf-8?B?aGlGUkoxZU8vNWwydVpBNmF5UlNSVjF0TmkxYWE0SlFodEFGcHViRXhlSFFh?=
 =?utf-8?B?UXRWYnhucitMWXlxWHZwT2pNTnAxZ0YyZFJEY2pBQkNFZUV5M3JVQVBZaEE4?=
 =?utf-8?B?Y210WllzQXNsVHBJdTQ5N2RsQXBNenR0OFdCTmFpWDQ5Mi90M3NWZXN3OUx3?=
 =?utf-8?B?akpjSWE4UW9lQkh2WEFoWFd5djREL2NUWGpKa0NjaytiR2ZUYjhPU1hsQXZI?=
 =?utf-8?B?eGJHWTNORDE3SG05elhwaXg1ckJXSER0MTNxUGRDNXBHRm1OMnFmb3VHUmdl?=
 =?utf-8?B?WVlLN3RYa0tOZjBNN3V0bjA4VFJCeFd2T3dSMTZ3SS9TT2VxNm43Nm52TGRo?=
 =?utf-8?B?UmJPWXN4V0NwUEt3Zjg4cDRZK25WOFFEbjV3N2NEZFZCOTh2WVJDUVhQV1Yy?=
 =?utf-8?B?V2lpZGUzRkpFSExlRERkdE9SWWNUWFpFTC9pVmdUK1hBUzFZUmlwbzRxem1z?=
 =?utf-8?B?SVZvSk5XWEVsZVpLdnErbW1zY3FEZWdCQytWM3NibEtZNjFaWVhsUHphUytV?=
 =?utf-8?B?RlFZUlNvNkxKR1RaNU54ZjdiZjJia2Q2TkVrVHFoaWNUR1VTL3M5Z1NXLzNn?=
 =?utf-8?B?THpDMXZ2dVVobDNKNnJOeVVkc25tQWZJVW5TK05DR1lvdlNlOUFvRHZpWmNW?=
 =?utf-8?B?RUJ0K2lla0lqUDBBOU1FWE1xelUxMTQvN3RyalBzS1I5dWN0ZWJwbm5yWkdK?=
 =?utf-8?B?M1o0WnhJTlp6Rko2dnBpUHd4c1Q3N010bm14N3hIYTFFUVJDbkF2ekxKa1Q1?=
 =?utf-8?B?bUJkclZDR3VZMEw0ZHdaWTVhYkNvR3dCVmlTMzhTb1pXekMwSld3L1BCZjR5?=
 =?utf-8?B?SXJZQklINTl0b2JIazA4SnE3OWFXcWw0Njh5YTVYSHRWMUVBaVR6V2dISHA1?=
 =?utf-8?B?TEVvd21HYW9NL2pYZndUUU1veXJCaXRjYVNzLzMvZmZjOE1ndWdOZkhBUENl?=
 =?utf-8?B?azFCb2NsUjZsU3dsQ015YkRrSmxvN0FGbW1wSFp0cUYwKzBtcG1WWGlVU1VN?=
 =?utf-8?B?M2U3d0RzWnlwejViKytvdjlBalRocGpVSEdhTEthQ2p1eUdsRFpZL2VlN2Ew?=
 =?utf-8?B?QzZkeVRpMzR3MEFDOVZLaU9jOVJzby8ySSt2OFpVMUplRFJFUkREZENDOVcx?=
 =?utf-8?B?VzhMQmtzRTdmV1UveWZaVVZaYTk0MmFaT2RxTGF4ZW1KR3JoSDJIOUVHaW04?=
 =?utf-8?B?ZjVSMmFLdWRuUHhFQzRKK1lmZDNrdnhpL1c1dHJIY2RKbndUQWE1UllkUGJ2?=
 =?utf-8?B?eCtaQm1ocDdjbGVUUzJWTlluZERBd09GSytlbGRkeXM5SnNZRmRCdlNtMmxx?=
 =?utf-8?B?Qmdpa2hQalBsTzdHVWhObFYvQStNc3FFOURobkp1VWZuY0k2QVd1WlNIOGVi?=
 =?utf-8?B?eWRQcDVmZ085WU1BNmFMV1RIZlV3M1k2QmdEcXZ2NjVwSUwzenl0M0xUZE9y?=
 =?utf-8?B?dDVqSjZzNFVYOFVwc0lCV0wrREd5SXZmdVZRM2I2MkpjaEFBSTcra3pQWlFJ?=
 =?utf-8?B?KzZMcC9ZN2ZqaEt4SythZHVFTy9zV2kxbUo1L0hzelJxVDdFRFhxOTVzYU1D?=
 =?utf-8?B?MUdpcWVPZHRTaXM2SDh1eDUwNGpSS1crMVZaTCtoaytpU3FoWDRDK1Z0UHVH?=
 =?utf-8?B?MkJsUU4xSlM2RktYQmY5SWVyajlJanFQK05kQ2NUMEw5Z05BalQ3NU1mdWgz?=
 =?utf-8?B?RVBPWHNzVWtETVI1cUsyT0hBaHNnNGw1SExoNU44bWZlelkrU0J5WkxHWHNL?=
 =?utf-8?B?c2NSZnlLdU8wSmdMYmVraXZrN3pteTlWeE10SEZpOGNsb2dYR3JXaTcyOGky?=
 =?utf-8?B?OXRwcjNOTU0wc1hGbnQ0b01ZWnppOXpaQTZmYnNJMllaYkIyS1ZWSkNNOEVq?=
 =?utf-8?Q?VMrKYOTFp6ZqdsnKu+j9pPxdT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ade66912-cea3-4296-18d8-08dcac7c4a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 07:35:00.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epQa060TlF5+dNcstJ/Y9SIk1BmozRRGMUnE6hg8wBScF2bUfQ48bgQqDRizQfnNQhouI/CHIzeBa6lLhRV/GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7057
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gU2VudDogV2VkbmVzZGF5
LCBKdWx5IDI0LCAyMDI0IDk6MDMgUE0NCj4gDQo+IE9uIFdlZCwgSnVsIDI0LCAyMDI0IGF0IDEx
OjI0OjE3QU0gKzAxMDAsIFdpbGwgRGVhY29uIHdyb3RlOg0KPiA+ID4gVGhpcyBldmVudCBoYW5k
bGluZyBwcm9jZXNzIGlzIGFzIGZvbGxvd3M6DQo+ID4gPiBhcm1fc21tdV9ldnRxX3RocmVhZA0K
PiA+ID4gwqDCoMKgIHJldCA9IGFybV9zbW11X2hhbmRsZV9ldnQNCj4gPiA+IMKgwqDCoCDCoMKg
wqAgaW9tbXVfcmVwb3J0X2RldmljZV9mYXVsdA0KPiA+ID4gwqDCoMKgIMKgwqDCoCDCoMKgwqAg
aW9wZl9wYXJhbSA9IGlvcGZfZ2V0X2Rldl9mYXVsdF9wYXJhbShkZXYpOw0KPiA+ID4gwqDCoMKg
IMKgwqDCoCDCoMKgwqAgLy8gaW9wZiBpcyBub3QgZW5hYmxlZC4NCj4gPiA+IC8vIE5vIFJFU1VN
RSB3aWxsIGJlIHNlbnQhDQo+ID4gPiDCoMKgwqAgwqDCoMKgIMKgwqDCoCBpZiAoV0FSTl9PTigh
aW9wZl9wYXJhbSkpDQo+ID4gPiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgcmV0dXJuOw0K
PiA+ID4gwqDCoMKgIGlmICghcmV0IHx8ICFfX3JhdGVsaW1pdCgmcnMpKQ0KPiA+ID4gwqDCoMKg
IMKgwqDCoCBjb250aW51ZTsNCj4gPiA+DQo+ID4gPiBJbiB0aGlzIHNjZW5hcmlvLCB0aGUgaW8g
cGFnZS1mYXVsdCBjYXBhYmlsaXR5IGlzIG5vdCBlbmFibGVkLg0KPiA+ID4gVGhlcmUgYXJlIHR3
byBwcm9ibGVtcyBoZXJlOg0KPiA+ID4gMS4gVGhlIGV2ZW50IGluZm9ybWF0aW9uIGlzIG5vdCBw
cmludGVkLg0KPiA+ID4gMi4gVGhlIGVudGlyZSBkZXZpY2UoUEYgbGV2ZWwpIGlzIHN0YWxsZWQs
bm90IGp1c3QgdGhlIGN1cnJlbnQNCj4gPiA+IFZGLiBUaGlzIGFmZmVjdHMgb3RoZXIgbm9ybWFs
IFZGcy4NCg0KT3V0IG9mIGN1cmlvc2l0eS4gRnJvbSB5b3VyIGNvZGUgZXhhbXBsZSB0aGUgZGlm
ZmVyZW5jZSBiZWZvcmUNCmFuZCBhZnRlciB0aGlzIGNoYW5nZSBpcyBvbiB0aGUgcHJpbnRzLiBX
aHkgd291bGQgaXQgbGVhZCB0byB0aGUNCnN0YWxsIHByb2JsZW0/DQoNCj4gPg0KPiA+IE9oLCBz
byB0aGF0IHN0YWxsIGlzIHByb2JhYmx5IGFsc28gZHVlIHRvIGI1NTRlMzk2ZTUxYyAoImlvbW11
OiBNYWtlDQo+ID4gaW9wZl9ncm91cF9yZXNwb25zZSgpIHJldHVybiB2b2lkIikuIEkgYWdyZWUg
dGhhdCB3ZSBuZWVkIGEgd2F5IHRvDQo+ID4gcHJvcGFnYXRlIGVycm9yIGhhbmRsaW5nIGJhY2sg
dG8gdGhlIGRyaXZlciBpbiB0aGUgY2FzZSB0aGF0DQo+ID4gJ2lvcGZfcGFyYW0nIGlzIE5VTEws
IG90aGVyd2lzZSB3ZSdyZSBtYWtpbmcgdGhlIHVuZXhwZWN0ZWQgZmF1bHQNCj4gPiBjb25zaWRl
cmFibHkgbW9yZSBwcm9ibGVtYXRpYyB0aGFuIGl0IG5lZWRzIHRvIGJlLg0KPiANCj4gVGhlIGV4
cGVjdGF0aW9uIHdhcyB0aGUgZHJpdmVyIHdvdWxkIG5vdCBjYWxsIHRoaXMgZnVuY3Rpb24gaWYg
aXQgaXMNCj4gbm90IGhhbmRsaW5nIGEgZmF1bHQgcGF0aCwgdGhhdCdzIHdoeSB0aGVyZSBpcyBh
IFdBUk5fT04uLg0KPiANCj4gSXQgc2VlbXMgdGhvc2UgZGV0YWlscyB3ZXJlIG1pc3NlZCBhbmQg
ZHJpdmVycyBhcmUgbm90IGVxdWlwcGVkIHRvIGRvDQo+IHNvLi4NCj4gDQo+IEJyb2FkbHkgaWYg
YSBmYXVsdCBpcyByZWNlaXZlZCBhbmQgdGhlcmUgaXMgbm8gZG9tYWluIGZhdWx0IGhhbmRsZXIg
dG8NCj4gcHJvY2VzcyBpdCB0aGVuIHdlIHNob3VsZCBzdGlsbCBnZW5lcmF0ZSBhbGwgdGhlIERN
QSBmYWlsdXJlIGxvZ2dpbmcNCj4gYXMgbm9ybWFsLg0KPiANCj4gU28gbWF5YmUgc29tZXRoaW5n
IGxpa2UgdGhpcyB0byBjYXB0dXJlIHRob3NlIGNvcm5lcnMgYXMgd2VsbDoNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2lvLXBnZmF1bHQuYyBiL2RyaXZlcnMvaW9tbXUvaW8tcGdm
YXVsdC5jDQo+IGluZGV4IDdjOTAxMTk5MmQzZjA0Li41MmZmZGI4MzI0ZGU1MCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pb21tdS9pby1wZ2ZhdWx0LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9p
by1wZ2ZhdWx0LmMNCj4gQEAgLTExMywxNCArMTEzLDU1IEBAIHN0YXRpYyBzdHJ1Y3QgaW9wZl9n
cm91cCAqaW9wZl9ncm91cF9hbGxvYyhzdHJ1Y3QNCj4gaW9tbXVfZmF1bHRfcGFyYW0gKmlvcGZf
cGFyYW0sDQo+ICAJcmV0dXJuIGdyb3VwOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyBzdHJ1Y3QgaW9t
bXVfYXR0YWNoX2hhbmRsZSAqZmluZF9mYXVsdF9oYW5kbGVyKHN0cnVjdCBkZXZpY2UgKmRldiwN
Cj4gKwkJCQkJCSAgICAgIHN0cnVjdCBpb3BmX2ZhdWx0ICpldnQpDQo+ICt7DQo+ICsJc3RydWN0
IGlvbW11X2ZhdWx0ICpmYXVsdCA9ICZldnQtPmZhdWx0Ow0KPiArCXN0cnVjdCBpb21tdV9hdHRh
Y2hfaGFuZGxlICphdHRhY2hfaGFuZGxlOw0KPiArDQo+ICsJaWYgKGZhdWx0LT5wcm0uZmxhZ3Mg
JiBJT01NVV9GQVVMVF9QQUdFX1JFUVVFU1RfUEFTSURfVkFMSUQpDQo+IHsNCj4gKwkJYXR0YWNo
X2hhbmRsZSA9IGlvbW11X2F0dGFjaF9oYW5kbGVfZ2V0KGRldi0NCj4gPmlvbW11X2dyb3VwLA0K
PiArCQkJCQkJCWZhdWx0LT5wcm0ucGFzaWQsIDApOw0KPiArCQlpZiAoSVNfRVJSKGF0dGFjaF9o
YW5kbGUpKSB7DQo+ICsJCQljb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMgPQ0KPiBkZXZfaW9t
bXVfb3BzKGRldik7DQo+ICsNCj4gKwkJCWlmICghb3BzLT51c2VyX3Bhc2lkX3RhYmxlKQ0KPiAr
CQkJCXJldHVybiBOVUxMOw0KPiArDQo+ICsJCQkvKg0KPiArCQkJICogVGhlIGlvbW11IGRyaXZl
ciBmb3IgdGhpcyBkZXZpY2Ugc3VwcG9ydHMgdXNlci0NCj4gKwkJCSAqIG1hbmFnZWQgUEFTSUQg
dGFibGUuIFRoZXJlZm9yZSBwYWdlIGZhdWx0cyBmb3INCj4gKwkJCSAqIGFueSBQQVNJRCBzaG91
bGQgZ28gdGhyb3VnaCB0aGUgTkVTVElORyBkb21haW4NCj4gKwkJCSAqIGF0dGFjaGVkIHRvIHRo
ZSBkZXZpY2UgUklELg0KPiArCQkJICovDQo+ICsJCQlhdHRhY2hfaGFuZGxlID0gaW9tbXVfYXR0
YWNoX2hhbmRsZV9nZXQoDQo+ICsJCQkJZGV2LT5pb21tdV9ncm91cCwgSU9NTVVfTk9fUEFTSUQs
DQo+ICsJCQkJSU9NTVVfRE9NQUlOX05FU1RFRCk7DQo+ICsJCQlpZiAoSVNfRVJSKGF0dGFjaF9o
YW5kbGUpKQ0KPiArCQkJCXJldHVybiBOVUxMOw0KPiArCQl9DQo+ICsJfSBlbHNlIHsNCj4gKwkJ
YXR0YWNoX2hhbmRsZSA9IGlvbW11X2F0dGFjaF9oYW5kbGVfZ2V0KGRldi0NCj4gPmlvbW11X2dy
b3VwLA0KPiArCQkJCQkJCUlPTU1VX05PX1BBU0lELA0KPiAwKTsNCj4gKwkJaWYgKElTX0VSUihh
dHRhY2hfaGFuZGxlKSkNCj4gKwkJCXJldHVybiBOVUxMOw0KPiArCX0NCj4gKw0KPiArCWlmICgh
YXR0YWNoX2hhbmRsZS0+ZG9tYWluLT5pb3BmX2hhbmRsZXIpDQo+ICsJCXJldHVybiBOVUxMOw0K
PiArCXJldHVybiBhdHRhY2hfaGFuZGxlOw0KPiArfQ0KPiArDQo+ICAvKioNCj4gICAqIGlvbW11
X3JlcG9ydF9kZXZpY2VfZmF1bHQoKSAtIFJlcG9ydCBmYXVsdCBldmVudCB0byBkZXZpY2UgZHJp
dmVyDQo+ICAgKiBAZGV2OiB0aGUgZGV2aWNlDQo+ICAgKiBAZXZ0OiBmYXVsdCBldmVudCBkYXRh
DQo+ICAgKg0KPiAgICogQ2FsbGVkIGJ5IElPTU1VIGRyaXZlcnMgd2hlbiBhIGZhdWx0IGlzIGRl
dGVjdGVkLCB0eXBpY2FsbHkgaW4gYSB0aHJlYWRlZA0KPiBJUlENCj4gLSAqIGhhbmRsZXIuIElm
IHRoaXMgZnVuY3Rpb24gZmFpbHMgdGhlbiBvcHMtPnBhZ2VfcmVzcG9uc2UoKSB3YXMgY2FsbGVk
IHRvDQo+IC0gKiBjb21wbGV0ZSBldnQgaWYgcmVxdWlyZWQuDQo+ICsgKiBoYW5kbGVyLiBJZiB0
aGlzIGZ1bmN0aW9uIGZhaWxzIHRoZW4gdGhlaXIgaXMgbm8gZmF1bHQgaGFuZGxlciBmb3IgdGhp
cyBldnQNCg0Kcy90aGVpci90aGVyZS8NCg0KPiArICogYW5kIHRoZSBmYXVsdCByZW1haW5zIG93
bmVkIGJ5IHRoZSBjYWxsZXIuIFRoZSBjYWxsZXIgc2hvdWxkIGxvZyB0aGUgRE1BDQo+ICsgKiBw
cm90ZWN0aW9uIGZhaWx1cmUgYW5kIHJlc29sdmUgdGhlIGZhdWx0LiBPdGhlcndpc2Ugb24gc3Vj
Y2VzcyB0aGUgZmF1bHQgaXMNCj4gKyAqIGFsd2F5cyBjb21wbGV0ZWQgZXZlbnR1YWxseS4NCg0K
QWJvdXQgInJlc29sdmUgdGhlIGZhdWx0IiwgSSBkaWRuJ3QgZmluZCBzdWNoIGxvZ2ljIGZyb20g
c21tdSBzaWRlIGluDQphcm1fc21tdV9ldnRxX3RocmVhZCgpLiBJdCBqdXN0IGxvZ3MgdGhlIGV2
ZW50LiBJcyBpdCBhc2tpbmcgZm9yIG5ldw0KY2hhbmdlIGluIHNtbXUgZHJpdmVyIG9yIHJlZmxl
Y3RpbmcgdGhlIGN1cnJlbnQgZmFjdCB3aGljaCBpZiBtaXNzaW5nDQpsZWFkcyB0byB0aGUgc2Fp
ZCBzdGFsbCBwcm9ibGVtPw0KDQo+ICAgKg0KPiAgICogVGhpcyBtb2R1bGUgZG9lc24ndCBoYW5k
bGUgUENJIFBBU0lEIFN0b3AgTWFya2VyOyBJT01NVSBkcml2ZXJzIG11c3QNCj4gZGlzY2FyZA0K
PiAgICogdGhlbSBiZWZvcmUgcmVwb3J0aW5nIGZhdWx0cy4gQSBQQVNJRCBTdG9wIE1hcmtlciAo
TFJXID0gMGIxMDApIGRvZXNuJ3QNCj4gQEAgLTE1MywxNiArMTk0LDI1IEBAIHN0YXRpYyBzdHJ1
Y3QgaW9wZl9ncm91cCAqaW9wZl9ncm91cF9hbGxvYyhzdHJ1Y3QNCj4gaW9tbXVfZmF1bHRfcGFy
YW0gKmlvcGZfcGFyYW0sDQo+ICAgKiBoYXJkd2FyZSBoYXMgYmVlbiBzZXQgdG8gYmxvY2sgdGhl
IHBhZ2UgZmF1bHRzKSBhbmQgdGhlIHBlbmRpbmcgcGFnZQ0KPiBmYXVsdHMNCj4gICAqIGhhdmUg
YmVlbiBmbHVzaGVkLg0KPiAgICovDQo+IC12b2lkIGlvbW11X3JlcG9ydF9kZXZpY2VfZmF1bHQo
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgaW9wZl9mYXVsdCAqZXZ0KQ0KPiAraW50IGlvbW11
X3JlcG9ydF9kZXZpY2VfZmF1bHQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgaW9wZl9mYXVs
dCAqZXZ0KQ0KPiAgew0KPiArCXN0cnVjdCBpb21tdV9hdHRhY2hfaGFuZGxlICphdHRhY2hfaGFu
ZGxlOw0KPiAgCXN0cnVjdCBpb21tdV9mYXVsdCAqZmF1bHQgPSAmZXZ0LT5mYXVsdDsNCj4gIAlz
dHJ1Y3QgaW9tbXVfZmF1bHRfcGFyYW0gKmlvcGZfcGFyYW07DQo+ICAJc3RydWN0IGlvcGZfZ3Jv
dXAgYWJvcnRfZ3JvdXAgPSB7fTsNCj4gIAlzdHJ1Y3QgaW9wZl9ncm91cCAqZ3JvdXA7DQo+IA0K
PiArCWF0dGFjaF9oYW5kbGUgPSBmaW5kX2ZhdWx0X2hhbmRsZXIoZGV2LCBldnQpOw0KPiArCWlm
ICghYXR0YWNoX2hhbmRsZSkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwkvKg0KPiAr
CSAqIFNvbWV0aGluZyBoYXMgZ29uZSB3cm9uZyBpZiBhIGZhdWx0IGNhcGFibGUgZG9tYWluIGlz
IGF0dGFjaGVkDQo+IGJ1dCBubw0KPiArCSAqIGlvcGZfcGFyYW0gaXMgc2V0dXAuDQo+ICsJICov
DQo+ICAJaW9wZl9wYXJhbSA9IGlvcGZfZ2V0X2Rldl9mYXVsdF9wYXJhbShkZXYpOw0KPiAgCWlm
IChXQVJOX09OKCFpb3BmX3BhcmFtKSkNCj4gLQkJcmV0dXJuOw0KPiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gDQo+ICAJaWYgKCEoZmF1bHQtPnBybS5mbGFncyAmIElPTU1VX0ZBVUxUX1BBR0VfUkVR
VUVTVF9MQVNUX1BBR0UpKQ0KPiB7DQo+ICAJCXJlcG9ydF9wYXJ0aWFsX2ZhdWx0KGlvcGZfcGFy
YW0sIGZhdWx0KTsNCj4gQEAgLTE4MSwzOSArMjMxLDcgQEAgdm9pZCBpb21tdV9yZXBvcnRfZGV2
aWNlX2ZhdWx0KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gc3RydWN0IGlvcGZfZmF1bHQgKmV2dCkN
Cj4gIAlncm91cCA9IGlvcGZfZ3JvdXBfYWxsb2MoaW9wZl9wYXJhbSwgZXZ0LCAmYWJvcnRfZ3Jv
dXApOw0KPiAgCWlmIChncm91cCA9PSAmYWJvcnRfZ3JvdXApDQo+ICAJCWdvdG8gZXJyX2Fib3J0
Ow0KPiAtDQo+IC0JaWYgKGZhdWx0LT5wcm0uZmxhZ3MgJiBJT01NVV9GQVVMVF9QQUdFX1JFUVVF
U1RfUEFTSURfVkFMSUQpDQo+IHsNCj4gLQkJZ3JvdXAtPmF0dGFjaF9oYW5kbGUgPSBpb21tdV9h
dHRhY2hfaGFuZGxlX2dldChkZXYtDQo+ID5pb21tdV9ncm91cCwNCj4gLQkJCQkJCQkgICAgICAg
ZmF1bHQtPnBybS5wYXNpZCwNCj4gLQkJCQkJCQkgICAgICAgMCk7DQo+IC0JCWlmIChJU19FUlIo
Z3JvdXAtPmF0dGFjaF9oYW5kbGUpKSB7DQo+IC0JCQljb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpv
cHMgPQ0KPiBkZXZfaW9tbXVfb3BzKGRldik7DQo+IC0NCj4gLQkJCWlmICghb3BzLT51c2VyX3Bh
c2lkX3RhYmxlKQ0KPiAtCQkJCWdvdG8gZXJyX2Fib3J0Ow0KPiAtDQo+IC0JCQkvKg0KPiAtCQkJ
ICogVGhlIGlvbW11IGRyaXZlciBmb3IgdGhpcyBkZXZpY2Ugc3VwcG9ydHMgdXNlci0NCj4gLQkJ
CSAqIG1hbmFnZWQgUEFTSUQgdGFibGUuIFRoZXJlZm9yZSBwYWdlIGZhdWx0cyBmb3INCj4gLQkJ
CSAqIGFueSBQQVNJRCBzaG91bGQgZ28gdGhyb3VnaCB0aGUgTkVTVElORyBkb21haW4NCj4gLQkJ
CSAqIGF0dGFjaGVkIHRvIHRoZSBkZXZpY2UgUklELg0KPiAtCQkJICovDQo+IC0JCQlncm91cC0+
YXR0YWNoX2hhbmRsZSA9DQo+IC0JCQkJaW9tbXVfYXR0YWNoX2hhbmRsZV9nZXQoZGV2LQ0KPiA+
aW9tbXVfZ3JvdXAsDQo+IC0JCQkJCQkJSU9NTVVfTk9fUEFTSUQsDQo+IC0NCj4gCUlPTU1VX0RP
TUFJTl9ORVNURUQpOw0KPiAtCQkJaWYgKElTX0VSUihncm91cC0+YXR0YWNoX2hhbmRsZSkpDQo+
IC0JCQkJZ290byBlcnJfYWJvcnQ7DQo+IC0JCX0NCj4gLQl9IGVsc2Ugew0KPiAtCQlncm91cC0+
YXR0YWNoX2hhbmRsZSA9DQo+IC0JCQlpb21tdV9hdHRhY2hfaGFuZGxlX2dldChkZXYtPmlvbW11
X2dyb3VwLA0KPiBJT01NVV9OT19QQVNJRCwgMCk7DQo+IC0JCWlmIChJU19FUlIoZ3JvdXAtPmF0
dGFjaF9oYW5kbGUpKQ0KPiAtCQkJZ290byBlcnJfYWJvcnQ7DQo+IC0JfQ0KPiAtDQo+IC0JaWYg
KCFncm91cC0+YXR0YWNoX2hhbmRsZS0+ZG9tYWluLT5pb3BmX2hhbmRsZXIpDQo+IC0JCWdvdG8g
ZXJyX2Fib3J0Ow0KPiArCWdyb3VwLT5hdHRhY2hfaGFuZGxlID0gYXR0YWNoX2hhbmRsZTsNCj4g
DQo+ICAJLyoNCj4gIAkgKiBPbiBzdWNjZXNzIGlvcGZfaGFuZGxlciBtdXN0IGNhbGwgaW9wZl9n
cm91cF9yZXNwb25zZSgpIGFuZA0KPiANCg0KTm93IGdpdmVuIGEgcmV0dXJuIHZhbHVlIGlzIHJl
cXVpcmVkIHdlIHNob3VsZCBhbHNvIHJldHVybiAnMCcNCmluIHRoZSBmb2xsb3dpbmcgcGF0aCB3
aXRoIGEgdmFsaWQgaW9wZl9oYW5kbGVyLg0KDQo=
