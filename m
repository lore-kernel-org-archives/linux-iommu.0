Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A59847B
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480791; cv=fail; b=vFwfTFomrWgdGXTRjKDIEUY6Qt8FbY1KkpgN+vXuqJXMpuxE1iUvN+CEpI6TDRzUJBf6XtLWC1OM3SNMZWX+EyTMp2dJZwrfKrqdSIyEs64vLoEH+FXjhX/SrHQEsJ6n0CM1BR90BwIIGO6u++KmVmOCGhW8V92+CU9BUg1zPjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480791; c=relaxed/simple;
	bh=JpndQYCXLIFF5rqpBsJ1yLlHoWpWstQI1Uocim9I7/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ci11FyrkhZIS+ghq/PzFavuhc8VYjXeyCetC1egFHamZu++9oBGkR7ccHE2VGAfYSXJggUU/JQdmSGCHpRL3iCnkdAUhiWUJaiMKm6i5st2N1RNGTofHZ17H62FoUWxUo9I8Yxu1VkzReF5V87bsTxj6vI8+An9siMnJ6TzZhMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciGhpJXY; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciGhpJXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717480789; x=1749016789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JpndQYCXLIFF5rqpBsJ1yLlHoWpWstQI1Uocim9I7/M=;
  b=ciGhpJXYw49QOfyvGh1YEgEsxn+Kee6vECtVEnZ4cNFw6zT3RGxJBS/+
   NMTPftuEZWl1136CubQh60RUd/g9w1tqDBfE8wSXb2vAaUDRomuiIcN5X
   fOc+n5Gz5IFeG0hv7o5+8XjjB6RTv8Ae/NXFHx0ycJuy3vhPHDGsc/Cg6
   OByv8612NFX+m0ozVlQwygcc42eTNETwLIg8BVeJUEC2IgVb6Kzz4r/q7
   tdqVjJr+Qdx4HcRX1gWpnFdop1ad9t9MLDDPTJRUyO/HEmtHBAt6L/YrU
   Fg3jErUChts5fCs0DIlpxgGW/9fFPe5r+xoU92GOfd+Q/0N/JsXvHnFv2
   A==;
X-CSE-ConnectionGUID: MiIK+mrnTZObPxIYT9ferw==
X-CSE-MsgGUID: 62SkRbhFRTiICG91uuK3Lg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="31504813"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="31504813"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 22:59:49 -0700
X-CSE-ConnectionGUID: Wj8tjUPVSLqFlD7P/pduxQ==
X-CSE-MsgGUID: aI9tXP9mRSa7YHC52KNqBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37183526"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 22:59:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 22:59:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 22:59:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 22:59:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ru49V6a4Q2i7xzL7DivbFFeHsfjvmMRrpC/QL6IV1bTwWaARg1I5umGQ4qoDKA21Q58XxmzVS3pyGNHqdsOnsGp5vUqL2HoA1bd1EZwT9YGKnE0I9zoM7SC3agvyeMHMINNDY+GLeMMpoAgAZZzeZnvsA0jc09ql4bHGJQJigrJbmdmh1jtAMVKQA5JlvMhOYFkr8FM5ZPNXiPydbeyzBqh3ChHabxRe1mMBF8guP6Q2udQTOzNBzCgeq9e943Gr3CZOaPFixOGTmN2IEB0YyV4ZQJiNT1/ci/FYuAh95g38SpzkjF0dz1YvvgwbkSj13GEKT5w3fxSIfvhAi5uRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpndQYCXLIFF5rqpBsJ1yLlHoWpWstQI1Uocim9I7/M=;
 b=V/iU6rI9ThdUkoa5KrfpfX8AlrKvM9MGICkRLZae3so0sZ7vymbOz0fiIlxaJRoJcnGuJYyRk7P1MTk5fv8Sw7CZk2zrUF/G+YKnNEzNtkRd5r2ogMf64LitQ0hXjonYGQjaPitqRkx20gaa3My/Qi5r1xNy08zXGAL4H/Xw7JsBAnn2uqeZRtXxkqXsnITxs4aFaHnSvpPJBtNHCztuin5qPl85Sm25dtXGn/SrTiQzJd0qzE1LW8I1IuAP5LZ2vEJKo0b3gZpULkuH5t2GcXGkorZTXL/TmKO64TWIhMOY3AYoR+TY4A9X92vpIIQlNMkVj0DPcZKXtAx4X2mZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Tue, 4 Jun
 2024 05:59:44 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf%5]) with mapi id 15.20.7611.025; Tue, 4 Jun 2024
 05:59:44 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
 invalidation commands
Thread-Topic: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
 invalidation commands
Thread-Index: AQHap/JyA+quh6RCVk2aSVRG2G8N3LGeUfAAgBdsvICAASqXAIAARQCg
Date: Tue, 4 Jun 2024 05:59:44 +0000
Message-ID: <MW5PR11MB58814B632958A5776B6C31FF89F82@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240517003728.251115-1-tina.zhang@intel.com>
 <20240517003728.251115-2-tina.zhang@intel.com>
 <2b390228-190c-4508-b98f-1811c54c9e5c@linux.intel.com>
 <MW5PR11MB588165376224FEA74A0426D989FF2@MW5PR11MB5881.namprd11.prod.outlook.com>
 <7440cd36-41e0-4705-a597-f2ce3f841a70@linux.intel.com>
In-Reply-To: <7440cd36-41e0-4705-a597-f2ce3f841a70@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SA0PR11MB7159:EE_
x-ms-office365-filtering-correlation-id: 1d454176-16fc-4e6a-4edc-08dc845b8825
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MzFweGlvaStsbUNKV3lneUlCYmRRZk1NWmJTZTd3bllHMTIvRzVSb3ZuRGNH?=
 =?utf-8?B?Zk1KM3RNQkZab3FGaG5qVDF0YnIxMjdnSXJSRzNHZ2Y4MWJLbTBaUjdEKzU4?=
 =?utf-8?B?bm10em1oS2RuMFA2SkZ6Z0w0blVYbHlIK0lrU2xWL2Q1bDR0Ly82S045ZURC?=
 =?utf-8?B?UGNPYWlkczJ4WlNHV2NuL3VURnZmdklMVHRDUDBCUldLQXJwSlRMa0s2UnNo?=
 =?utf-8?B?TGlNaCs1a2pOb2F0UjdxOTVEMDdtdTZwOEtLT2FjRnNObHNMRVd0WWl3ancx?=
 =?utf-8?B?QURUcTk2bDF4ZVptcWNuZnlNa05NVW1nVkdNcHRYdUV1dG9FcmhKZVpxQldx?=
 =?utf-8?B?NEo5QlpOSGc3eXI1ZUZiRTROOHEvQiszWTBtTjZFaWcrZHZGWDE0anRiS0lP?=
 =?utf-8?B?Rjl5SGJLeWxjSlpEZXdSY2VmOHg2cHR1SE85T1YxSEdSSkp2QVI1S1huWWw1?=
 =?utf-8?B?bTNiK29CaHpod2NkaU9iMFFqWS9LTW84VWFSaGlGaFY5eVVUWm9DdEFBekx3?=
 =?utf-8?B?L0VLUmgyRXNyc29YSkQwQStLVnkyd1ZqOEtKNUZGT0w0YUozNlVoNGdXZmRx?=
 =?utf-8?B?Q0t3QUNUWVVQdXVGZXlEbWlrRnhLcUwvdmlWYy9HM25aTlFqeUNuMkVPR2pM?=
 =?utf-8?B?UkIxc0hrQnJ5UmJwVmY5SGxHaHp0NEhNMzhSMzRLS212bE9YSkxDdFEvTzJZ?=
 =?utf-8?B?YXhjRm1NUDFwcHM2TmttTDVVM0JFRWd4d0J5Tm1rMDFIQTBNWTFsa2FTSlNM?=
 =?utf-8?B?YXNDeGV6ZkF5NUdEOEY3eVR4NFBia25OT1JiUUV2cWtpeEhPYWFORW1JaUk5?=
 =?utf-8?B?TmJoL3hFQXhPQjdnWW9OdVMySGJoR1pjZEc2bDVOVDBpN2RvZ1ZpMGZRYlk3?=
 =?utf-8?B?Skw4V0pIbG5IVDRqMzBKeUp2ZTNYNkNNcVlnQnR4WnU0dGZpWTdQaC8xUFRY?=
 =?utf-8?B?clh0RFErNGIxN2phVnJDQm53elQyRzNqWjcrUXdXa2c0UUVpQk8wRHRFLytV?=
 =?utf-8?B?dlVYbGlpRWtKOFkwVUx0eFVQTUNRWEYzTkY1dlAvRjVueUVBWjNQZUtiY00v?=
 =?utf-8?B?dXcvZ3JuQTE2Q0ZoSFJrQmxrbVRQK1A3VngwVEdnZ1RIU0Z4L1R5Z3lZaGZ4?=
 =?utf-8?B?MUVGWm1ucUZnUGZ6b0UvQWRGa3Z4V0pJdFVjVFNTQXVBemRqT2dvOGRFREI5?=
 =?utf-8?B?ZStYNVpHTWNRd0lPL0VKZHZVM2tKaVhmajI1UnFkd0dLZE5LS1B1ZDI2dVJH?=
 =?utf-8?B?aGdBM1Q4NEpnamViR2hjUGUrS1VqcHI5bHkyenkvQ2VUd0tKdUZ6S0h6MmFY?=
 =?utf-8?B?a016aDRZb29jeDJvNHFiSnNhTTV4dWFaeXcwZW9rTjVFeVFKWDdtaXRMTFBz?=
 =?utf-8?B?b1ZkN2xlZDdObUVpd1hmSUh3aFEyVGJCOUV5d3RtMmc1b3lWV2ZwUDdOTUtp?=
 =?utf-8?B?QnZ1MGVTMEdLaFIraHFFQXdQRFpwYkNFUUV4YStnUldJL3oybHZ3eUkrVUhu?=
 =?utf-8?B?ZFFLbUhCcllOM2xQNFcxTzdjSVRUeFphQjFnY1hPVHE1TWxpTndGQ2dOZ28v?=
 =?utf-8?B?Y1hVZ1pXTkhDVHZTcy9FVlNaanVJUDVCL3pXTjdWOHlVWFBpQmlhVFVjWWt5?=
 =?utf-8?B?ei81eFNtUS8za2VjWVlFQmRLV0pJUnIvS3RBcTNUZStkd0w5cXM1SllZMjY4?=
 =?utf-8?B?eTh3aW5EbGVXdE80WVpyU1RKaEErbFFadkJYa3NIdkw2bkppcFpJc3FiR0NI?=
 =?utf-8?B?S3JPMXJnZndPcDBIcGZ0dUxOVWtENytsL0hCQytTSnB4dTh6aU1neWZCZlNY?=
 =?utf-8?B?SnBVS1hVKzJpVCtGMTJLQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFQvSjQ2b2o5T015SzFrckIrMkFET2pEWUtIbCs2cXo5ZlJFakRKekJ0Ynhu?=
 =?utf-8?B?eHh2bGovRlpleXdWLzdCbzFKRXpDQWJNellyUmRYYVFSZ1RNTDZwRDVNbmVs?=
 =?utf-8?B?elB4SUM3UWxPZkk3QUFmSzlPNG0xNnBxSXN3QzVPamZ6Nk1FREhQbWFKVVJ5?=
 =?utf-8?B?eWFyY29NSW9NWHdwVTNSZzh1MXc4SGY5MXA2UkRCdkE4QytXak9idU9NMWNL?=
 =?utf-8?B?eGFKNjU0NlJod1Q2QnRZY053d2diT2dHb1VXZlNSeXEram1MR0NTTE1XcXNv?=
 =?utf-8?B?aysyTmF6TVY3NlJBdEY3Y0RPMFd0OSt5eWZOeWszYzA0TlI4UElpd0ZtZXhR?=
 =?utf-8?B?a3I5aEJNUzFRQWVTYUdLODJKdkh0czkvS1dkd0FEYnVsYXhoQzQyS0RVSzN0?=
 =?utf-8?B?ZlFQRm1UakZlZjFDMXdwcktaYzJSK0JEWUw3STJNZy9OYTJ6Myt2K2plODNM?=
 =?utf-8?B?b3FjMGFwT3lGdi9nRlhtYUZEZlc2OWdPeWl0TmlJYytmNlUvWEJFTndldVVP?=
 =?utf-8?B?Rmp6czVzcDRyVjVsV2NxREJPejIxcDV3NHdZNUpxK1BEeTB6Z2QweHBud2FK?=
 =?utf-8?B?Y2RuZWM3V0gzajA5anQ5TkJYQkNQeGdXeUowb2pjSjcvemNhcGlBQ0JCSURO?=
 =?utf-8?B?eXFyVGZYSnRrT0lsR25GN3l3K3drT1JsOEg2Yk9Ra3pUQTVmRm9icWltZm14?=
 =?utf-8?B?UjB2NFRyRWxPaGNRbE5jMHh5dnowMERONzZDeHk0a3U0K2U1OVVpTTJUVjZB?=
 =?utf-8?B?TFFpK01EV2RhMVNxaFROOExGUG1JRWp3TmY4SzZzelFsR2hmQTdWMjFYY0JH?=
 =?utf-8?B?am84NzA5NDlHNVBFNnk1eTdtdnk4bElvOTVIRHlFb1ZkdTRJK1I0OXZiQzNO?=
 =?utf-8?B?TXEwNTBhZ1RYdDVDUDBKK3RMTThWV29pRXk2bHFqT2oya1lHNjdDRHlnNEEx?=
 =?utf-8?B?ZlpNZXJMeHBndStEa21zRnNLd1ZGVUk1dnJqNVR1eHRNUzV0SFlZMU9YT2tr?=
 =?utf-8?B?NVJGZzVrRW1BQXd2TUVXWlBET0pNRzc4K2k0YkFrOW5zUTlVZ0x1ODRhR2xG?=
 =?utf-8?B?YW13MFc2OGx2ZU1uUXgxUlVHTWtJKzBrSnFmM3IwRm4yRHVWZVdmaUQ3SWIz?=
 =?utf-8?B?Z0pvYzFNQnlKQ09FUWZ6WFlHY0lRdzVmTmR6aXBDOTA0eWFmTUl6dXNrYnJE?=
 =?utf-8?B?K1hmN0k2TG9OeWt6Y1o1YUdvaHJMRHlpZEY4ZzQ4QXRnQms3TTh4bzFrYzNj?=
 =?utf-8?B?a2dLQlBpWnZXcnlFbWVkOXYva0h2QUVoc2FmY1BUcnluZVMzSUtwdHZ5S2Yv?=
 =?utf-8?B?WXZRa1BPelMwc2U4QWdhTS9FNWRUbnkwSEplQlFNdUIweWkyVm5ndncwVkJO?=
 =?utf-8?B?WUZnak1DTnZudTJpMDhmMGhmRW9LSW9YS2JrYXMwUDdoekJJcDRFbXpjalJp?=
 =?utf-8?B?cm1FYy9neVFRcEpHTGphN0xBc2tyNUdVRWgvTzU2cGhrTDErZmdMSUUwVUdL?=
 =?utf-8?B?dFpDZkc1bWgwckZGWG9hVWpUTm03bGlBS1Vwa3kycG4wZENySCt6UDZPL05s?=
 =?utf-8?B?QVRTNW40TFR3bHJhbkFSNkJNV01WTEU0TmNhWWNkWStSZVlRWVFwQlR5NGpJ?=
 =?utf-8?B?cEdaYUJRdE04V01yclk2bVM5NzNOdnNRb2VoeGRGd25vWFZHcm1oMDczcEFm?=
 =?utf-8?B?dEd6OWNrSSsrMGtuZUJodVQweDdabnpVdWlZR3B3UTlJVm1qNTJtOUJ0ZDNs?=
 =?utf-8?B?Wnpyd2pmSjBZL1UwbmcydWFlN1FsNGUzWmpBekNySFdMRVZlb3Y0YzNUVWth?=
 =?utf-8?B?dTdPdVJ5MUc4YjZRWGNWQm0xQmVvN212d3Yxd1hMa2grUGRvUitBa2I1Um9X?=
 =?utf-8?B?Y2FodzY0UW9ETHZYNmJiUUtWbEE4cDZjcTZwWnpBT2NEamo4RzdnSDJjSVpY?=
 =?utf-8?B?TlZUZjNuMFZwQkVxZk1ySjloU0I0OHFZSFdOaUg1eUR1YVRxRnUveForRWl3?=
 =?utf-8?B?bGlXN0MxYThyQnJKdUdiaGlFVWRiLytCTlp1QUhnbFY4c282RVAwSWM1ZVVq?=
 =?utf-8?B?SWFwR2ZyQk5oSDdhdmxZSDRNU2E1VzFRMzhRVjZBRlhkSnhjMGxkYmM1UUVQ?=
 =?utf-8?Q?Bpdod/PHHx03b0UuNgPEs2h1U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d454176-16fc-4e6a-4edc-08dc845b8825
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 05:59:44.0772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCfv6Pprc1XObxDY4QobV31zWGw6LOsv+5pwKtQEUPh1QZ5uu2druh3oJiMT8/Aw4bHFtrGRQUtYInk40nSJ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVuZSA0LCAy
MDI0IDk6MTUgQU0NCj4gVG86IFpoYW5nLCBUaW5hIDx0aW5hLnpoYW5nQGludGVsLmNvbT47IFRp
YW4sIEtldmluIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gQ2M6IGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbTsgaW9tbXVAbGlzdHMubGludXguZGV2OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gaW9tbXUvdnQtZDogU3VwcG9ydCBi
YXRjaGluZyBJT1RMQi9kZXYtSU9UTEINCj4gaW52YWxpZGF0aW9uIGNvbW1hbmRzDQo+IA0KPiBP
biA2LzMvMjQgMzozNyBQTSwgWmhhbmcsIFRpbmEgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEJhb2x1IEx1PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNv
bT4NCj4gPj4gU2VudDogU3VuZGF5LCBNYXkgMTksIDIwMjQgNTo0MyBQTQ0KPiA+PiBUbzogWmhh
bmcsIFRpbmE8dGluYS56aGFuZ0BpbnRlbC5jb20+OyBUaWFuLA0KPiA+PiBLZXZpbjxrZXZpbi50
aWFuQGludGVsLmNvbT4NCj4gPj4gQ2M6YmFvbHUubHVAbGludXguaW50ZWwuY29tO2lvbW11QGxp
c3RzLmxpbnV4LmRldjsgbGludXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4g
U3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGlvbW11L3Z0LWQ6IFN1cHBvcnQgYmF0Y2hpbmcgSU9U
TEIvZGV2LUlPVExCDQo+ID4+IGludmFsaWRhdGlvbiBjb21tYW5kcw0KPiA+Pg0KPiA+PiBPbiA1
LzE3LzI0IDg6MzcgQU0sIFRpbmEgWmhhbmcgd3JvdGU6DQo+ID4+PiBJbnRyb2R1Y2UgYSBuZXcg
cGFyYW1ldGVyIGJhdGNoX2Rlc2MgdG8gdGhlIFFJIGJhc2VkIElPVExCL2Rldi1JT1RMQg0KPiA+
Pj4gaW52YWxpZGF0aW9uIG9wZXJhdGlvbnMgdG8gc3VwcG9ydCBiYXRjaGluZyBpbnZhbGlkYXRp
b24gZGVzY3JpcHRvcnMuDQo+ID4+PiBUaGlzIGJhdGNoX2Rlc2MgaXMgYSBwb2ludGVyIHRvIHRo
ZSBkZXNjcmlwdG9yIGVudHJ5IGluIGEgYmF0Y2ggY21kcw0KPiA+Pj4gYnVmZmVyLiBJZiB0aGUg
YmF0Y2hfZGVzYyBpcyBOVUxMLCBpdCBpbmRpY2F0ZXMgdGhhdCBiYXRjaA0KPiA+Pj4gc3VibWlz
c2lvbiBpcyBub3QgYmVpbmcgdXNlZCwgYW5kIGRlc2NyaXB0b3JzIHdpbGwgYmUgc3VibWl0dGVk
IGluZGl2aWR1YWxseS4NCj4gPj4+DQo+ID4+PiBBbHNvIGZpeCBhbiBpc3N1ZSByZXBvcnRlZCBi
eSBjaGVja3BhdGNoIGFib3V0ICJ1bnNpZ25lZCBtYXNrIjoNCj4gPj4+ICAgICAgICAgICAiUHJl
ZmVyICd1bnNpZ25lZCBpbnQnIHRvIGJhcmUgdXNlIG9mICd1bnNpZ25lZCciDQo+ID4+Pg0KPiA+
Pj4gU2lnbmVkLW9mZi1ieTogVGluYSBaaGFuZzx0aW5hLnpoYW5nQGludGVsLmNvbT4NCj4gPj4+
IC0tLQ0KPiA+Pj4gICAgZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jIHwgMzMgKysrKysrKysr
KystLS0tLS0tDQo+ID4+PiAgICBkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYyAgfCA2NyArKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+PiAgICBkcml2ZXJzL2lvbW11
L2ludGVsL2lvbW11LmMgfCAyNyArKysrKysrKystLS0tLS0NCj4gPj4+ICAgIGRyaXZlcnMvaW9t
bXUvaW50ZWwvaW9tbXUuaCB8IDIxICsrKysrKysrLS0tLQ0KPiA+Pj4gICAgZHJpdmVycy9pb21t
dS9pbnRlbC9wYXNpZC5jIHwgMjAgKysrKysrLS0tLS0NCj4gPj4+ICAgIDUgZmlsZXMgY2hhbmdl
ZCwgMTAwIGluc2VydGlvbnMoKyksIDY4IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMNCj4gPj4+IGIvZHJpdmVycy9pb21t
dS9pbnRlbC9jYWNoZS5jIGluZGV4IGU4NDE4Y2RkODMzMS4uZGNmNWUwZTZhZjE3DQo+ID4+PiAx
MDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYw0KPiA+Pj4gKysr
IGIvZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jDQo+ID4+PiBAQCAtMjc4LDcgKzI3OCw3IEBA
IHZvaWQgY2FjaGVfdGFnX2ZsdXNoX3JhbmdlKHN0cnVjdCBkbWFyX2RvbWFpbg0KPiA+PiAqZG9t
YWluLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiA+Pj4gICAgCQljYXNlIENBQ0hFX1RBR19ORVNU
SU5HX0lPVExCOg0KPiA+Pj4gICAgCQkJaWYgKGRvbWFpbi0+dXNlX2ZpcnN0X2xldmVsKSB7DQo+
ID4+PiAgICAJCQkJcWlfZmx1c2hfcGlvdGxiKGlvbW11LCB0YWctPmRvbWFpbl9pZCwNCj4gPj4+
IC0JCQkJCQl0YWctPnBhc2lkLCBhZGRyLCBwYWdlcywgaWgpOw0KPiA+Pj4gKwkJCQkJCXRhZy0+
cGFzaWQsIGFkZHIsIHBhZ2VzLCBpaCwNCj4gPj4gTlVMTCk7DQo+ID4+PiAgICAJCQl9IGVsc2Ug
ew0KPiA+PiBJJ2QgbGlrZSB0byBoYXZlIGFsbCBiYXRjaGVkIGRlc2NyaXB0b3JzIGNvZGUgaW5z
aWRlIHRoaXMgZmlsZSB0bw0KPiA+PiBtYWtlIGl0IGVhc2llciBmb3IgbWFpbnRlbmFuY2UuIFBl
cmhhcHMgd2UgY2FuIGFkZCB0aGUgYmVsb3cNCj4gPj4gaW5mcmFzdHJ1Y3R1cmUgaW4gdGhlIGRt
YXJfZG9tYWluIHN0cnVjdHVyZSB0b2dldGhlciB3aXRoIHRoZSBjYWNoZSB0YWcuDQo+ID4gRG9l
cyBpdCBzdWdnZXN0IHdlIG5lZWQgdG8gYWRkIGEgYmF0Y2ggdmVyc2lvbiBvZg0KPiBxaV9mbHVz
aF9pb3RsYi9xaV9mbHVzaF9kZXZfaW90bGIvcWlfZmx1c2hfcGlvdGxiL3FpX2ZsdXNoX2Rldl9p
b3RsYl9wYXNpZCgpIGluDQo+IHRoZSBjYWNoZS5jIGZpbGU/IEl0IGRvZXNuJ3Qgc291bmQgbGlr
ZSBhbiBlYXN5IHRvIG1haW50YWluIHRob3NlIGZ1bmN0aW9ucywgZG9lcw0KPiBpdD8NCj4gDQo+
IFllcy4gSSBkb24ndCB0aGluayBpdCdzIHRoYXQgZGlmZmljdWx0IGFzIHRoZSBoZWxwZXJzIGp1
c3QgY29tcG9zZSBhIHFpIGRlc2NyaXB0b3IgYW5kDQo+IGluc2VydCBpdCBpbiBhIGxvY2FsIHF1
ZXVlLiBUaGlzIGxvY2FsIHF1ZXVlIHdpbGwgYmUgZmx1c2hlZCBhZnRlciBmaW5pc2hpbmcgaXRl
cmF0aW5nDQo+IGFsbCBjYWNoZSB0YWdzLCBvciB0aGVyZSdzIG5vIHJvb20gZm9yIG1vcmUgZGVz
Y3JpcHRvcnMsIG9yIHN3aXRjaGVzIHRvIGEgZGlmZmVyZW50DQo+IGlvbW11LiBIYXZlIEkgbWlz
c2VkIGFueXRoaW5nPw0KDQpJbiBjdXJyZW50IFZULWQgZHJpdmVyLCBvbmx5IHFpX2ZsdXNoX3h4
eCgpIGZ1bmN0aW9ucyBoYXZlIHRoZSBrbm93bGVkZ2UgYWJvdXQgaG93IHRvIG1ha2UgSU9UTEIg
aW52YWxpZGF0aW9uIGRlc2NyaXB0b3JzLiBJbiBxaV9mbHVzaF94eHgoKSBmdW5jdGlvbnMsIFZU
LWQgaW52YWxpZGF0aW9uIGRlc2NyaXB0b3JzIGFyZSBwb3B1bGF0ZWQgYW5kIHN1Ym1pdHRlZCB0
byBoYXJkd2FyZSBpbW1lZGlhdGVseS4NCg0KVG8gc3VwcG9ydCBiYXRjaGluZyBjb21tYW5kLCBJ
IHRoaW5rIHdlIGNhbiBoYXZlIHR3byBjaG9pY2VzOg0KMS4gRXh0ZW5kIHFpX2ZsdXNoX3h4eCgp
IGZ1bmN0aW9ucyB0byBzdXBwb3J0IGJhdGNoaW5nIGRlc2NyaXB0b3JzLiAoSnVzdCBsaWtlIHRo
ZSBpbXBsZW1lbnRhdGlvbiBpbiB0aGlzIHZlcnNpb24pDQpJbiB0aGlzIHdheSwgdGhlIGtub3ds
ZWRnZSBvZiBwb3B1bGF0aW5nIGFuIElPVExCIGludmFsaWRhdGlvbiBkZXNjcmlwdG9yIGluIHFp
X2ZsdXNoX3h4eCgpIGlzIHJldXNlZC4gQWRkaXRpb25hbCBjb2RlIGNoYW5nZSBpcyBmb3IgYmF0
Y2hpbmcgdGhlIGRlc2NyaXB0b3IgY29tbWFuZCBpbnRvIGEgYnVmZmVyLg0KDQoyLiBJbnRyb2R1
Y2UgYSBuZXcgc2V0IG9mIGludGVyZmFjZXMgdG8gcG9wdWxhdGUgSU9UTEIgZGVzY3JpcHRvcnMg
YW5kIGJhdGNoIHRoZW0gaW50byBhIGJhdGNoIGJ1ZmZlci4NClRoZSBuZXcgc2V0IG9mIGludGVy
ZmFjZXMgaXMgaW1wbGVtZW50ZWQgaW4gdGhlIGNhY2hlLmMgZmlsZSBhbmQgd2UgbmVlZCB0byBj
b3B5IHRoZSBrbm93bGVkZ2UgYWJvdXQgaG93IHRvIHBvcHVsYXRlIElPVExCIGRlc2NyaXB0b3Jz
IGZyb20gcWlfZmx1c2hfeHh4KCkgaW50ZXJmYWNlcyBpbnRvIHRoZSBuZXcgaW50ZXJmYWNlcy4g
SSBoZXNpdGF0ZWQgdG8gY2hvb3NlIHRoaXMgb3B0aW9uIGJlY2F1c2UgaXQgd291bGQgZHVwbGlj
YXRlIGNvZGUuIE1heWJlIHdlIGNhbiBnZW5lcmFsaXplIHRoZSBrbm93bGVkZ2Ugb2YgcG9wdWxh
dGluZyBJT1RMQiBkZXNjcmlwdG9ycyBpbnRvIGxvd2VyIGxldmVsIGludGVyZmFjZXMgYW5kIG1h
a2UgdGhlIGN1cnJlbnQgcWlfZmx1c2hfeHh4KCkgYW5kIHRoZSBuZXcgc2V0IG9mIGludGVyZmFj
ZXMgY2FsbCB0aGVtLg0KDQpXaGljaCBvcHRpb24gZG8geW91IHRoaW5rIGlzIGJldHRlcj8NCg0K
UmVnYXJkcywNCi1UaW5hDQoNCg==
