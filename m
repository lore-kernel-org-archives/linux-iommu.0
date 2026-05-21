Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0E34EF05
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333436; cv=fail; b=bE/eEnWF5af1l3WcaofFtDXZVRW1GW/oUxiWseHXhwz6uC4rlFjHjzsWbimRSkjvkrLIvJOwr+IRZYMK8MRm5CWPCdT3rLVmOrcIbmkvBr2XTcd0SdNzBiogShUpMdWYd8W4GCwvNp8Zift3cQ4SWG4ICqUQ5SqwPMG1iRVttJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333436; c=relaxed/simple;
	bh=wijm6N4H145um5nNme6kJTv6Wz/gMgbPsYyLmlMq1fU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ii66ppHcNi4TJ9RAtxxEX6oXDd89f/G3Z60CHugFZ1qx94muvIZOONIfh3DxRGlz8DOstR2eVoYtWLU+S9lDpn/bsuk8eGfsLU5nLWSrp3TyO+ttI1pb4vzHs65e2apz7WO9trysFRQ6sqXu4+sEXvBbkHBHIuIz9yZ5uh8TkQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCdYLA8M; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCdYLA8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779333433; x=1810869433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wijm6N4H145um5nNme6kJTv6Wz/gMgbPsYyLmlMq1fU=;
  b=VCdYLA8MQSbtBeDGWW8APRpfgX+W8d+7HuPdqyFBneJJ42iLmOkUiwnQ
   58GplkiBZVuD5lpA+Fm1SoywPQ6S4sGvKsQwmj9qAb0HWGIdyBVDJhmMm
   kSjJ6j2xnFJfTaZbUTe9+6ByHOJ97yWr0B5adVRF6c9FhC/D5gDzAxVn4
   4ZSA8VfsWALNeO78LLewFNaOsY7ayyPgL7T6te3A92tEqKvLhEYjPFcQ/
   8txvduwefrTI5fYs3rOQpzo8e1YaMQEZHWGM4OJBw+tJIUem/00N/KFq3
   UlRnqhkrGA2rcXuBHRtf6QwnOkYc+J+WWXzAdmGvevl53KlqtIhLIE9cS
   w==;
X-CSE-ConnectionGUID: W9H5J7FbTpKlloZhw8YUUw==
X-CSE-MsgGUID: ZeSXmuH3SSGp0ShmU30XcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="91354808"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="91354808"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 20:17:13 -0700
X-CSE-ConnectionGUID: Aggl8FB2QoCEU+oPA1+d/g==
X-CSE-MsgGUID: YzvuRJY3Qq+3sOZ3NAKAuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="234050227"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 20:17:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 20:17:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 20:17:12 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 20:17:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPgP7hVNQ+unjbD2P0bTXDjqaIco6nh3mrrK5sBVAGEZz+7x2wMniv9lTloqx5DOE7tdYyXcd6lpKKpoFNjCPDA5SqbJzVhvrjuiSCk0418nRbPuaKPhkVQe5WdvrS4/PlZdv9IM2RBgc4TQbHyYTiBkN+DMHc4yppoCzRjdIuYMBQzh5vBMyQFY2ao+DZlgrR3tRPPNcXp4hXgW26N+wM3ptEt56XQcw18JohcLilhH1zi6m3/oqvkbFb91Rcx5UjHfX+SwePR+n5r1HHa+88Cc4JyTyZMmPyTQexYzdDDnSef6ZmZfRAuR0y3Y3TQAuGakucHYq5F5e9tVnA5O9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWui7Bi9f4toOylBtcDV0VN0cTLEXpzjO+BZq0qlxYs=;
 b=hYihIbsGy9S2RxOIxe4ggO2+vlNISO8t0WhFClw4JDH76BT3pQ+BKoA3sJOIuP1tC19/G1cd2r41N3eBiq/eSiLkg6l9mWzcq7Fi+cMZ92k8lpBiQeBlRxo9yqA7st9+BUUCXdjfNakYn28rqBWJodDPL1DUT1irxG1WE/ezOrZjJwdjMZDaQejMQJ7JEdmGNWTtMmw//7EbI8HI2V/W39I2ZgYHGq+xPOeTC05tS4Ot6SNfkwkoN6xw0K5gzWk8uMPMfO//XyzHX6ZXtYhd/ayYUPIEKCTQHGDDnwBqH3VGZAl7q40qayRcdvirx6utjAx+Kqs30TUYDQR2btEJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 03:17:03 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Thu, 21 May 2026
 03:17:03 +0000
Message-ID: <970647f6-0bdb-468b-b104-6bc5c6574855@intel.com>
Date: Thu, 21 May 2026 11:25:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] vfio: Enable cdev noiommu mode under iommufd
To: Jacob Pan <jacob.pan@linux.microsoft.com>
CC: Alex Williamson <alex@shazbot.org>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
	<kevin.tian@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
	<skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
	<will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-8-jacob.pan@linux.microsoft.com>
 <20260519214613.167e8d5b@shazbot.org>
 <95235a41-f9b3-4b5b-9a34-489a9ff7eac5@intel.com>
 <20260520111513.0000188d@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260520111513.0000188d@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0032.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::20) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|CY8PR11MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 138a42c4-8cb5-4b3c-023a-08deb6e76e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|42112799006|5023799004|3023799007|11063799006|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: KKqa8MvzYD1bQMb0K3SHMprud5g36DV6ID4jfG3lhXtWSWm7vUWx8rzuPqkvZK9CZA/LidYS5Z+7dLBp1iVAuBq+inWTO7mW64jEANdiwiBdNJ09UphSaD+bFvYs7+z9363Ko2r092eSktlo+9LavZW7u+d3iOhiyVTFNjSQScrXgbpAtW4vY2ZBuUwtTQ9Sn0p1NgjMlLcwK4r7DKanvMrBNv9lSU2AWdlOlXcq/5zf1xKBrLv4l4g1djpxICQPNdqGDDzIKt1KvKx2/Q17MDcoSc4w9zU5Pgw3JlYQ76SYNUOUa3Asb9FYWAKnvlLbpHTWQ7UW6XpkyAUC181yt3mT3KHmVhI8ySIgZkYOWxlORpclEcAGDSpJfXLUgfmtpBrJTSEkxvsrLFQ0W8R/Bzd1waNZFttvOPfAIZIbX9tw1Ax8tYwEu708XiPtExeQ59EBdCWy42wxQPY+JF4SplbIyWkFs19wd0b0ia3G/yNHISbwJS60I7tYYmiQ/2cqQzNEMW9tLzuCZUxUk0lm/Vuz1Bf5TE/BVP0E5AeQMMpGtRgKs40UnFDRhHG5kSbNVihPTjkLHDU7rGKQ1/78u3+FbRyE3H0TYz+goJOt/TXoJfUjaEwO0WQW7pE2UH1SEB32YIxJ4Fk8fkrJoEMP2QL1Xbxr+OdL6qUzPHkqk+ChBmqgUvvmzA3jWl+z79+8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(42112799006)(5023799004)(3023799007)(11063799006)(4143699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cElPTDJGR2xxQ0FiaEJDZElpZ3JjNUlEQjE1eGJGRTZFdmc1aXZtd2NWNEht?=
 =?utf-8?B?a0RRZ2JjVENQdklOcE94azFVR2JVWkxYY1hUWnpMczJTVGtlYWhLbnpSUTFw?=
 =?utf-8?B?dVFEaXRqYUlBemtnNmRTa3JxUzBtNnFrMDJ5blBLSDUzQjJNQ1pOazNCS0R6?=
 =?utf-8?B?SFUrbWY2MVlubjlobi93czdqbE12bVlkMUZjODVLaEg2ck9YcGNCK3BhMktu?=
 =?utf-8?B?dCs1WVhXTDU3bUtTSWpMeXYrWG8vc09sRVMrQVBrTFRWZkt5a29oM2ZLN1FW?=
 =?utf-8?B?MFhHaktDeWQrbGx2ZU1LTFpJR25Yd0JiK0RiMWlKYWxvV0VnL0c0VlhMQ3Er?=
 =?utf-8?B?SHh4UjNiQStON212Uis3NGNhVnJ2cDdsMXhmTDhnMG40RENpOXM2NXV2TUV2?=
 =?utf-8?B?dVprRUczTXVEN1NJU3JnNmVrRU5CTUQraFI1T2dyL3FyaFZQbDc5Y3d5Vkxl?=
 =?utf-8?B?MDVFZmFHUGpLK3FINDRXOUhrUTV5aXNIUFBUY3Z5VG9Xc1I4L0dXR1pXRUFU?=
 =?utf-8?B?UHJjSVpzRk0reTJLU3RxUkNuL1ZuQStLSGpqNHNaRUI3NXg1U0I5ZXNISW9k?=
 =?utf-8?B?QjR1R0t2OTJrN28xcFpYZEg1RzZ4Y3Zrb2lYL29kZlZuM3htRGtGRm9VbnVL?=
 =?utf-8?B?dFVrNjdQU3FmaytWd0JBTVpjbkZGbUNyUGxUZXZIbk04VnhoOEF4NmFpVXVw?=
 =?utf-8?B?dHZaYlN6bGNVSDlFRkJtMzhFbXpTOGJibGRDRTd0bzl2akUzdlZURC9DYWNL?=
 =?utf-8?B?VVVSbEJPTUV2UG5HL3lzdlBXS25yUXM4UmhsRHJwZGNSeUl5TEc4dy8wRVQr?=
 =?utf-8?B?UEVUekhFSnNiQ1RIcXZVWkRGNXJBckhKdnd3akJCeExSR0hRdXdlcDRxRHR5?=
 =?utf-8?B?dXRRL0hLTVA5SndzNy9QY21PcldMeEZRaTVTdDRVV3cvdmFNeE05b3dIbnc5?=
 =?utf-8?B?b2tzV0ljT0Z3ZzdXNGIvTFNhaVlWTk05NGFvU3piU1Z2RXh0NURwd3FFMi9K?=
 =?utf-8?B?aHlWdFg1dHFxZXQvY1JWNmdIaE9HeWNBb0tjR0o4Ti9jS0hhVStvUlRqZ3o5?=
 =?utf-8?B?ZXhGRFJnTytqYXF1a2FqWmZlVWtSQVZ1d3NPeEhueThxOGViTHZnMUE3Mmth?=
 =?utf-8?B?N05oOStPY2YxWGdOZG1CbU9HNUk5Y2YwelNUZ2U0aG82S2VVTHVRbU1WelF6?=
 =?utf-8?B?VzdvaWtKQU9tU2hYV2RGOElzaFlzaXhHQk1rMGRzd0ZKSGVaakFpdWFEZG51?=
 =?utf-8?B?ZmxXZGt3MjBkZjZKWE1rRWxnKzAyMkk2ZjBtbjNZTnBaNjUrYmNPMFFhV2to?=
 =?utf-8?B?dnJmd2Rtd2hKRTJ2ZndoTzNOa0FkZCtMUzdoSEw1QS85Sk9jUGRzMXNLMUhz?=
 =?utf-8?B?YUlyY3hCa1Rma0ZoRmVlU1VXdnU5OEtqTnRXQWZlQ2IwSHZjTFNmd3pYTjQy?=
 =?utf-8?B?cWpQeTQ1U2RjVUI4b2J5SllIcUU5ayt4TzBZeTZCMWp6Vngxa2oyTDhrblRI?=
 =?utf-8?B?c0hXT2hBdHRlSVVoMjFFRFZPYXV0UVRpZHpROE1RMVBXekN6TDdjZlh4RGcr?=
 =?utf-8?B?RFRnaDRSbzQveFFmZ29qK09SL09pdU1TUUdIT29zdVRPRkRtNGJyTG96NEtm?=
 =?utf-8?B?NHg5SW9zbEZHYWRqWVZQVDhQTzNYaFZiS05pcFhFeVhWZ0hVZGg4SFlHVS90?=
 =?utf-8?B?TURMd0lGbE1IRzg5dWFxRGc1RUFYY3ltQ2FzMDZKVGxWTlBwQTZVdFZxY2xF?=
 =?utf-8?B?UmxFb1ZwbjdUOWVUTmRwT1E0YjJ0OVBSR25RQVlIRkhKcnp2eElZQ0Rqazdo?=
 =?utf-8?B?NXlZYnRuVW9ZZDZOVVoyR2pqcWsreDFmY2Z0dEZQSE5aT0E3V0xpT2NTQWlX?=
 =?utf-8?B?cWNuVDlDcnpEbmtsOFFhYjI5ZkFJQXpRaWZ4NUVrbG5CVm5jRzlSTk4wTjVj?=
 =?utf-8?B?dkxqQnJ2RzFlSlR2V1MzRkxneTFvaTVDTzFRU1FaZ3JyeEhpU0FZbDNMenkr?=
 =?utf-8?B?MlVVbXMxOXdaRm1HZm5YRkRQdGpGV3Y4U3p2YkxkNitGMVJlWlVaOUphMTg5?=
 =?utf-8?B?cXhXU0NKdlk4SEhlcSthMTgvaU1lNjhxampJaURPenVoSXVqZVdLajM0Qk41?=
 =?utf-8?B?YTNkakd2cUJrQkFUbmRKZFcvc2h5Qko0NHdHd1ZjNHJXWXh0L0hQODZuYnVv?=
 =?utf-8?B?eDNEb0tQdUhxMzRmdm1VeUJzWEpnSFlvQUFrRmdMWWVGNmkwNWJzMHJVOEpN?=
 =?utf-8?B?MXEwNHZLZFd1SVhKT0lYY2l6L2FSUk5CMFBYNCtxRk1JOHNMbHJ4SHovVGJV?=
 =?utf-8?B?WklKdzc1RFFDREJFY3E1ZUJuTkl5TVVkOGhIc1cvZktuUkxKQzV6Zz09?=
X-Exchange-RoutingPolicyChecked: D1TXrSZt5mXMfQnMY31niX2RMGr5LA3whi/AcAZcbC/Y/wc091cfurLZx+IisvYiu2rTphVFgln9QyTJtKqih9TrpZoyyg5P3q1JDEnjVT0TOfJNXczatsPXoL/IclA/ZEdxvVgvto9RX5Nh4KsQjm0nJIKkvwqVtJ8dJKmvhYtohaAS2CKmv9O/6MyNPBG+BKjjkAhBoEmLqdigFZ5gvtjp891vzYQfro0ASQx6u5Hpih5Sin/6lSJfywBeGkelJnvZrZL8zG/j6lXx9+17ooq3NM0F2cqHxBNJoOY4cysAjiH4YE5FqoBA7Xcbr4LWtyJTs18Soxa0MHaHvWS4YQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 138a42c4-8cb5-4b3c-023a-08deb6e76e15
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:17:03.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhjYmZxnfH1qgcSSD6B3wHI78Z6kl4hoij3/KypFfCYYd2pj9O/Xqcvu9g6ld7dmau1Zn3JwUVrI6Ck6x8+pLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
X-OriginatorOrg: intel.com

On 5/21/26 02:15, Jacob Pan wrote:
> Hi Yi,
> 
> On Wed, 20 May 2026 15:20:26 +0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
>> On 5/20/26 11:46, Alex Williamson wrote:
>>> On Mon, 11 May 2026 11:41:12 -0700
>>> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
>>>    
>>>> Now that devices under noiommu mode can bind with IOMMUFD and
>>>> perform IOAS operations, lift restrictions on cdev from VFIO side.
>>>>
>>>> Remove the vfio_device_is_group_noiommu() early returns in
>>>> vfio_df_iommufd_bind() and vfio_df_iommufd_unbind() so that both
>>>> group and cdev noiommu devices go through the standard iommufd bind
>>>> path. This is safe because iommufd_device_bind() now handles
>>>> noiommu devices via its own iommufd_device_is_noiommu() check.
>>>>
>>>> Add CAP_SYS_RAWIO checks for cdev open and bind under noiommu to
>>>> maintain security parity with the group noiommu path.
>>>>
>>>> No IOMMU cdevs are explicitly named with noiommu prefix. e.g.
>>>>
>>>>       /dev/vfio/
>>>>       |-- devices
>>>>       |   `-- noiommu-vfio0
>>>>       `-- vfio
>>>>
>>>> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
>>>> ---
>>>> v5:
>>>>      - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
>>>>        and its dependencies
>>>>      - Add comment to explain vfio_noiommu conditional definition
>>>> (Alex)
>>>>      - Removed early return for group noiommu in bind/unbind
>>>>      - Use consistent wording referring to VFIO noiommu mode (Kevin)
>>>>      - Update unsafe_noiommu Kconfig help text (Kevin)
>>>>      - Change dev_warn to dev_info for noiommu enabling msg (Kevin)
>>>> v4:
>>>>      - Remove early return in iommufd_bind for noiommu (Alex)
>>>> v3:
>>>>      - Consolidate into fewer patches
>>>> v2:
>>>>      - removed unnecessary device->noiommu set in
>>>>        iommufd_vfio_compat_ioas_get_id()
>>>> ---
>>>>    drivers/vfio/Kconfig       |  3 +--
>>>>    drivers/vfio/device_cdev.c | 10 ++++++++++
>>>>    drivers/vfio/iommufd.c     |  7 -------
>>>>    drivers/vfio/vfio.h        | 22 ++++++++++++++--------
>>>>    drivers/vfio/vfio_main.c   | 25 ++++++++++++++++++++-----
>>>>    include/linux/vfio.h       |  1 +
>>>>    6 files changed, 46 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
>>>> index b1b1633412a9..b1a260b6054c 100644
>>>> --- a/drivers/vfio/Kconfig
>>>> +++ b/drivers/vfio/Kconfig
>>>> @@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
>>>>    	  The VFIO device cdev is another way for userspace to
>>>> get device access. Userspace gets device fd by opening device cdev
>>>> under /dev/vfio/devices/vfioX, and then bind the device fd with an
>>>> iommufd
>>>> -	  to set up secure DMA context for device access.  This
>>>> interface does
>>>> -	  not support noiommu.
>>>> +	  to set up secure DMA context for device access.
>>>>    
>>>>    	  If you don't know what to do here, say N.
>>>>    
>>>> diff --git a/drivers/vfio/device_cdev.c
>>>> b/drivers/vfio/device_cdev.c index 54abf312cf04..46a808244398
>>>> 100644 --- a/drivers/vfio/device_cdev.c
>>>> +++ b/drivers/vfio/device_cdev.c
>>>> @@ -27,6 +27,9 @@ int vfio_device_fops_cdev_open(struct inode
>>>> *inode, struct file *filep) struct vfio_device_file *df;
>>>>    	int ret;
>>>>    
>>>> +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
>>>> +		return -EPERM;
>>>> +
>>>>    	/* Paired with the put in vfio_device_fops_release() */
>>>>    	if (!vfio_device_try_get_registration(device))
>>>>    		return -ENODEV;
>>>> @@ -110,6 +113,13 @@ long vfio_df_ioctl_bind_iommufd(struct
>>>> vfio_device_file *df, if (df->group)
>>>>    		return -EINVAL;
>>>>    
>>>> +	/*
>>>> +	 * CAP_SYS_RAWIO is already checked at cdev open, recheck
>>>> here
>>>> +	 * in case the fd was passed to a less privileged process.
>>>> +	 */
>>>> +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
>>>> +		return -EPERM;
>>>> +
>>>>    	ret = vfio_device_block_group(device);
>>>>    	if (ret)
>>>>    		return ret;
>>>> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
>>>> index 39079ab27f92..bc80056c74d3 100644
>>>> --- a/drivers/vfio/iommufd.c
>>>> +++ b/drivers/vfio/iommufd.c
>>>> @@ -25,10 +25,6 @@ int vfio_df_iommufd_bind(struct
>>>> vfio_device_file *df)
>>>>    	lockdep_assert_held(&vdev->dev_set->lock);
>>>>    
>>>> -	/* Returns 0 to permit device opening under noiommu mode
>>>> */
>>>> -	if (vfio_device_is_group_noiommu(vdev))
>>>> -		return 0;
>>>> -
>>>>    	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
>>>>    }
>>>>    
>>>> @@ -58,9 +54,6 @@ void vfio_df_iommufd_unbind(struct
>>>> vfio_device_file *df)
>>>>    	lockdep_assert_held(&vdev->dev_set->lock);
>>>>    
>>>> -	if (vfio_device_is_group_noiommu(vdev))
>>>> -		return;
>>>> -
>>>>    	if (vdev->ops->unbind_iommufd)
>>>>    		vdev->ops->unbind_iommufd(vdev);
>>>>    }
>>>> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
>>>> index 602623cacfc0..ac79b1a2fce9 100644
>>>> --- a/drivers/vfio/vfio.h
>>>> +++ b/drivers/vfio/vfio.h
>>>> @@ -36,7 +36,7 @@ vfio_allocate_device_file(struct vfio_device
>>>> *device);
>>>>    extern const struct file_operations vfio_device_fops;
>>>>    
>>>> -#ifdef CONFIG_VFIO_GROUP_NOIOMMU
>>>> +#if IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) ||
>>>> IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)
>>>
>>> Have you considered what happens when these are y/n or n/y?
>>>
>>> I think in the former case we can create cdev devices for
>>> group-noiommu devices that are not labeled noiommu, skip the
>>> CAP_SYS_RAWIO test, but will fail to bind.  In the latter case, I
>>> think we fail to setup an iommufd_device and unbind will segfault.
>>>
>>> We really don't need to support independently setting GROUP vs CDEV
>>> NOIOMMU, the suggestion was to try to get NOIOMMU from depending on
>>> VFIO_GROUP.  We can do that other ways though and I think we can do
>>> it without the rename in patch 1 that will inevitably result in
>>> some lost config options for NOIOMMU on upgrade.
>>>
>>> The Kconfig may get messy, perhaps something like:
>>>
>>> config VFIO_NOIOMMU
>>> 	bool "VFIO No-IOMMU support"
>>> 	depends on VFIO_GROUP || VFIO_DEVICE_CDEV
>>> 	depends on !VFIO_GROUP || VFIO_CONTAINER ||
>>> IOMMUFD_VFIO_CONTAINER depends on !VFIO_DEVICE_CDEV ||
>>> !GENERIC_ATOMIC64 select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
>>>
>>> Sorry if the previous suggestion sent us astray, but the subtleties
>>> of independent support look tricky.  Thanks,
>>
>> this also looks better to me. Less kconfigs. :)
>>
> agreed, let me give it a try in v6.
> 
>> just one nit: current VFIO_NOIOMMU only depends on VFIO_GROUP, maybe a
>> separate patch to extend it depends on 'VFIO_GROUP && (VFIO_CONTAINER
>> || IOMMUFD_VFIO_CONTAINER)' first, then add the cdev path noiommu
>> dependency.
> 
> I had this below in patch 1/9. will do in a separate patch.
> Thanks,
> 
> Jacob
> 
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -60,9 +60,9 @@ config VFIO_IOMMU_SPAPR_TCE
>   	default VFIO
>   endif
>   
> -config VFIO_NOIOMMU
> -	bool "VFIO No-IOMMU support"
> -	depends on VFIO_GROUP
> +config VFIO_GROUP_NOIOMMU
> +	bool "VFIO group No-IOMMU support"
> +	depends on VFIO_GROUP && (VFIO_CONTAINER ||
> IOMMUFD_VFIO_CONTAINER) help


got it. not sure if it needs to have a fix tag or not. @Alex?
