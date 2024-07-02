Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D91487CC
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902391; cv=fail; b=VQ1/HQdbaQCa3iMAy646ltP8EZx61Sjb99jfyd7R+j/KAOVbaqlxdAeG6HWfVYOi7dparVG90jkPzWIxneWkEmtry/U2qnp6yYodEKiKFEpDGZZfSKGIvAVwDYj+mI9R7LZf9vO8G0Npr+qQYUspFGLzbkT3aIIEokgyM6yJFpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902391; c=relaxed/simple;
	bh=63gCIrgNzIAwVdwVWxFiKvv9UvazUDEmJReF70ti8Rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LO+O5JohYPayqVt4UF0At0XIJL7DjxmUCzB8xkfpkSR3SYtvxOymbPjtSPmLVA5as8M+VqzbsWRdzQLyhlQNzmboF7YUKTmqxJvbuly9DBiuIM54YaoZkxc4cIQJNJShQo4P2xOJ/VFKQTWIffysVkZ64aDrE69125uDER19c70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bi4zkKpI; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bi4zkKpI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719902390; x=1751438390;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=63gCIrgNzIAwVdwVWxFiKvv9UvazUDEmJReF70ti8Rw=;
  b=Bi4zkKpIAjdXYn1gkEKEMnWAD1DZj0V7CZZX/w2Upm7R43YfgxdcS5KS
   /w8nUuiFlB1jmSEYm/3q+ME10fOGCg4QmjwY1OqAK3vWcUlf7sgspegLo
   8EYymWxnyROySDY76uwKTVNJxlcd0kFFLWpghjr5C6h869UGJWo2AHXfj
   l7zMhSQJ+bPK+tWtDakro7I6YnAIq48J+yaSEGz9oHW7ntuwxHidGRGq2
   dQhrbLHWLDeRE46v2a7VbMFPJXCpjNUwUwqDQFXoGZbwJrYnJuJaQpKEC
   v1XszaRG/cqyaedP6oKNd3MblBgKRhdneN3x9MsKgHBr5tBzfSbl6nviS
   Q==;
X-CSE-ConnectionGUID: jhx+LqWhR7Gsgb1l7oINBg==
X-CSE-MsgGUID: VJ5fOdcLROa3k4Y/BehBfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28450720"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28450720"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:39:49 -0700
X-CSE-ConnectionGUID: i5FYSDuITRqM7IYPYRhBSA==
X-CSE-MsgGUID: 5nZROmXNSfyMC3FOqrYmhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45752500"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 23:39:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 23:39:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 23:39:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 23:39:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 23:39:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtpLMIW0YOCNy7VRizUxf6WuzIjbNO+xPEkuoJLXRicJ07xQE/gJL8Mxdx9s8UfY4R355JfyJyNtFxIxMI8zAMjJbrqUTsqpcc6t9XPITdBXoiul1wSkLBw2kRrC2PI5YoFqbAi8OoXScEnxkKKwOGZu2TFXp8f4lByC1YB5m2RtIKEuuD3rgxofZaPmXwnHpkmOLiPUr4noaVzcZOkwDv5ZwtKS9sYz56TZTrtihTz6+Fit7jCb0wSi2UcCkqcuYA8GNjMWeZcrOJ340pSC05sNyJ4BUeiOac1C9mz8enPe/5/kPnsnoIB0L3TR6RAVjyVZb2IbAV5nogO7c++8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63gCIrgNzIAwVdwVWxFiKvv9UvazUDEmJReF70ti8Rw=;
 b=KCv9e4cjsmJ6Q/ARI2aANrHYEPnjpcavf2jAXZqxfq+jfrDegCTqjgL0k83eHIdl8sfBsvQ1g98rDwV/0bhxcGl461ZLUEreaL/WsNXyzlKGU2RT2nt4B8iqUL81ST0dctmbdzNVmFE4LrfGPJyxg0h2BxlQppZie4GJFvAb/VB20RDledSN1FYOFkIUqS1qJzkOILIhsje5ga9PENqfFzgXv9IhUnqzx/xQAJ8phjIuU5r1fOwNkqN0KZux+1f5kflRLgeYVbG4Ql7bfmmlD0DHN8zPm1noCwx5pz+Qisc/prbljip+aAp8jKOs4VNdMM+s7qkGQtTqfmV3d9Wn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 06:39:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 06:39:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for context
 change
Thread-Topic: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for
 context change
Thread-Index: AQHay6mHOOHyxhjIZkya4OXhJi0laLHilLXQgAAXmACAAA+rgIAAI6EAgAAaO4CAAAOCkA==
Date: Tue, 2 Jul 2024 06:39:42 +0000
Message-ID: <BN9PR11MB52763B19F02E0481FB3B7EFD8CDC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
 <20240701112317.94022-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276502F9B5AB45EE9BF28628CDC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <14a7db3a-663a-4e3f-b29c-a733e98efc32@linux.intel.com>
 <5a8802e3-feda-49bf-b11b-2ba6c236305e@linux.intel.com>
 <1c9204d9-d9da-4785-b375-368b5ba9ec78@linux.intel.com>
 <d74b2f95-2105-4e25-8c86-b5d5204798f6@intel.com>
In-Reply-To: <d74b2f95-2105-4e25-8c86-b5d5204798f6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5170:EE_
x-ms-office365-filtering-correlation-id: 616d7294-32a7-43c5-16c2-08dc9a61c176
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXlZY05UL0xZVnJWOE0vKzd5WTZMTGR6SzNGWFpjN0NPdHdGUjdLSjZiSVJz?=
 =?utf-8?B?TEYxaGJBZ0MyZkU0Ym5XZ0Q5cjhRdlFlWjRGVVNURWgwamhrME5DdHJISUtD?=
 =?utf-8?B?a2tENGVmT3hIVXNYeVRPcnpoc2JyN3dvNmx5UGJWVjZyR1AzeU5FRkl1TG4x?=
 =?utf-8?B?aHI2NEMwckFKYUlkWlJEVHkzaG95L2pkb2RHY3FuTnVRNlhzeHM4a3EzVGJ1?=
 =?utf-8?B?OHJRbGEvTUFuZjBka1JBcUc2djEzUXFnMUQrSjZUYUNRcDBJckJQbnFQVzI5?=
 =?utf-8?B?TVlVejZtZWtWallPOUppekxzYUJmT004WUhqbHN4K2t1RHo4Qm50bklMa0M2?=
 =?utf-8?B?bHA5aWJzYXRQU0RQRjdWaTVjME9IRmV3NUhtZ1ZsaU15dktQU2RXbWU2TkZ5?=
 =?utf-8?B?SE5nS0x1RnBDK2dlM0Z0eXNyQm55U2dmK0xreW5kNTluYjM1RWFpVHVHY2pl?=
 =?utf-8?B?UTkyVFNZMDVmNE5ZSEVWL0h4M0d0b3J6NG1FNGJ2TEdkNFFCWUp2a1Nnei80?=
 =?utf-8?B?czFDdlVsaTR0U3B2QWk5VlhDSHk5Zmc3cVMrNy84anpieHJ4M21sd2FIbm0w?=
 =?utf-8?B?bmNCbVczcUR2Vk5Ma0NOSWFrNCs4T0c5OFJkMENXSWtDSmF1MkRLdWZvT1Y2?=
 =?utf-8?B?ZlVNbHlDaDl3bnZpZld0Q05DSVBWQ0k2bkhoVXhzTHBRSzJqTjAzcHp0UVZU?=
 =?utf-8?B?N3FnL3c2bGRlRzJkUG9jMVZjZHA5Qzc3azNQWVFvUUlvNHN5dWkvbHlYaEU3?=
 =?utf-8?B?S0RaUGE3TktLOEFUdmxEL29MQjFPcnpHVjBud3BHMHdiTmtLMWhLakQ3YUd0?=
 =?utf-8?B?WEFsbnprRHhURE1jMG5JVmk4YTRXaml3VkFGMVNiSDFrbk9OTmxrUEhEVkI3?=
 =?utf-8?B?Qld6UHZHVzJjUG5wdmpDc1ZNbGhCeS9NYzV3UnlSRWFENWdQdVdQeUhWS2lB?=
 =?utf-8?B?UjR5ckE2VE1pRUlSVDlONVdiWFZyWTZwTjh1V0JWR1BRbDBJOVpROS9xaXAv?=
 =?utf-8?B?RCtydjZmS2oyR2VyZGI0WFRIcTc3SEdJUkUrSnNjdlF6RjNBdCtkbkZ6eWRC?=
 =?utf-8?B?SUIwV2xOMUFtWnpWNU1LYm53S05KVjYzYk5MODlFSHdSd1RqT1RoQ3R2Y3ZP?=
 =?utf-8?B?TzZYOWszMWkzeWd5SDNLUC9xditxVVh2d3FHTEt0S1lYaGQrenZqb2t3V0xs?=
 =?utf-8?B?R0k3ZncrN2dJQ01QMnlrNHE1SDk2KzVyMjB4MlR2bGdpZFZHL1loSHJMaVl0?=
 =?utf-8?B?N3c1Q3owYk1WTHNueG9qTzRIZm9wUEhjd0E0eFFoOFNreHFENVk1TDJlOFhN?=
 =?utf-8?B?THNXdjJmOHJQd0FqOGR1UDVwL3RHREEvSmNaMlpHNW5qZHZWNUlna1J3RmhH?=
 =?utf-8?B?VzdVMHc2bk1TTlhkWjNUMHpKRzJ5OXZEYnpjYXBDU3hZWi9nU0lnZkpQOEVp?=
 =?utf-8?B?bmk1eHF3MWpsQ2NCc3B6ZVY3eDQwUmljVy9ySDhrN01qckNSdkZpUHhnSDJC?=
 =?utf-8?B?NlI2YW5RWUpWSjYvSWJZOWhkc2tnRWZEOVdHQ3FDd3ovSUJLbWh2QW1hRmk3?=
 =?utf-8?B?Y3VLc1NwS3pKM2Q5N1RWZnJPYW9mcFd1Z0hSdmR2T2I2TE9obXpEak80Q3FU?=
 =?utf-8?B?b3J5ZjE2UjU1cnlEeHZDTmlISzhXb0xBNjhQM2FYeGp3RHFwMVlXMEE1UzZP?=
 =?utf-8?B?OSsxQTlMUUNOR3NjSEJmampjdVNoaGNjZG9SUGdCWmJ5NE1qci9CbGJuNjN6?=
 =?utf-8?B?OVZ3dlFkSjh3WmNGVm1MOUtkbndyendCd3lYLzVWWHB1RTd5eWlEVTN2eHVq?=
 =?utf-8?B?NzFpOFRVaEJKSmFMdHE1STdVaFdBaUUyS1Irc2VOblNnWnhnQXE5cmZYeWFC?=
 =?utf-8?B?NGc4Y2orb29qTGVHSDNodDFNK05vZEVwZHV0UjdDU0FmMVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGx2T1MzV0YvNDhIMzQ1cndvTWFZK0xwZGhTa2o4dFVZVjE2Y09UTFl4amcw?=
 =?utf-8?B?M0JQcnJNdU94bWFLcDZnV3QxZ2lNOFZZYm1ZMTFtRHErU1NyS1VwS21TQVJo?=
 =?utf-8?B?OUNRRXFrbE9KSU1jMCtQVjNLUmFaMmd1TThlQ1ptQVQ1Z2JYSVNYYk1qNXM4?=
 =?utf-8?B?c3YxeFgwMTh6aTluSFF1aTJrbXdhOUhhdDZPaGhLcmhYVmpnZUw1dDJvK3ZT?=
 =?utf-8?B?RnM4dHFvUVJCYXUyRVdXN20zaFpHS1JYWXVySFJOWCtteFFQREVHUnlVRXpI?=
 =?utf-8?B?dnozOVJvYUdGVzVpc1ZnNEowTm1VNm1sMGxQRE4xSDB0Q3J4dm8xS213VXZB?=
 =?utf-8?B?cW5OSmRzbW54NERzZlFST1lNaU5BMWZuMS9qK2Yzd3JDbTRuN2l6ZW5NSUVT?=
 =?utf-8?B?c0xaZ0hoaVJrcjhDTzVZQjN2QkZWSzAvWG5pZklCZGQ5TFN1OEZvcjR3cFRK?=
 =?utf-8?B?KzNnN3MvWi93eVlTclFuakdGUnN4SnphaU5XbGxoaGJxNTRWak1aK0gvdnJG?=
 =?utf-8?B?b2pHUlRFTjRUYTBTNkV2MzUrSXNiWjBGenB0ZEhZSWx5VUJ2S2lwUW1NcURx?=
 =?utf-8?B?dDZYRTZXNHFRZnJ5ckpIYnE3NVZxV202ZWpQc3lVUXR5UjJTSU81VzhLU3hJ?=
 =?utf-8?B?L3BtWmVIWEN6VkdYK3g2clBHdTdFeDhzNEdCWTB6SmJtUmxtL3ZveWNwaTdn?=
 =?utf-8?B?ZEFSMDRibElBcFh4REttbzZobVYvWjZMMmhXN1pZLy9aQWxsdW81b3lTcExY?=
 =?utf-8?B?QUpoWUlDZEhVQ3Q5aWp1Ylp5RjRYNUpsSE9pMU05ZS84VG50S2lwbDRHOGZk?=
 =?utf-8?B?SktxV0ZDUXJtemw2WkorVXVwUDlHZHBOWlJlN2NvRDRpTWx0ZDlJUzIycm5U?=
 =?utf-8?B?cGxOY29nL2NMWHVsQTM0ZG9nV1NqbGYybGlydGdyeE9jbkhQb1ltdkU4QTEw?=
 =?utf-8?B?SnI3UXZtZWJFYTMzK21tZ2hQK05VNWwxMmhONnlDUHdaZnU1Yy9vTG91dFJk?=
 =?utf-8?B?QWdmUnhuY0ZKNW02R2Zmdmt0K2VLeVBRbENkQ1M1V1RtdnEwclVaME51YlRr?=
 =?utf-8?B?dEt5dWROZUszN00vSndTSU9VWXN4aEVhQ0VCZE5NVTBpSFpvUGhZbzlsSW8z?=
 =?utf-8?B?ajM1Z3ZWMy9ESk9kN280cFZxbTJLa1VjTUlhdks0YlVHRzA3cnMrK3owZDRu?=
 =?utf-8?B?V1plRG1hVkxqSjF6aUNCT284NjJYSEo0V0JCbFBZUU1wNFluT2NnV1l6elNt?=
 =?utf-8?B?Z0s5eFRxVm1TMW5zTEJFUUc2S2pwdEEzOERZRUo3NWRPcHZKUVM4TDd0SE8z?=
 =?utf-8?B?VGwrNFM1bzZZcVV6cDduRW5QQjdyRTNLNGNLQVNzS2F5ZEtGL2RNdXJnaEM3?=
 =?utf-8?B?cWE1b1Z3Snd4WExIZk5JOWF3QkprU3JGckMzRThoRDZtRWs4QlhUaHcyb1hU?=
 =?utf-8?B?RDdBY01xQjA2dkNlbHVBdVVWTCtwU3pSTzd1aWFhWWlpVUhzaWxCYzdZSktR?=
 =?utf-8?B?dXBld1pKYzhyZGltTThpN0dhTTUxWXlZYjhTUTdzZ3l6cVBZa082QUpuNTBt?=
 =?utf-8?B?ODRUdTFDK1hTNVJwREVtdy9GYVZGcnRhUVpnWWRJVnBKbkp2bzNPaWZJQkxB?=
 =?utf-8?B?WU91OFgvbENuZkNOSzFPQ1F5bjlhZWxUK3M4RE9BM3YzcXVGUU5odWRLZVdX?=
 =?utf-8?B?enJPTmNIYldIeFFwdWVkL1VpTWdBRDMraTljMTR2RndJb0xmWjVSTmRDaFhH?=
 =?utf-8?B?QVd4S1FSM0tYbmlzOGJlTmJZZUNycGdLWUFSRU1CUGVOSTE3YUNETjZzYmNP?=
 =?utf-8?B?V29nemJLdWNkQzVQNzJrRUVpajVnYWg1d29PbUdYYzYzYXZmVDM5TzI5a0VI?=
 =?utf-8?B?TXY4SFRhV2pQdjgxT2U4Rk83eTVvQ1FlcGVRZGJFVFR2Q2xJK1hNSVVWY0xI?=
 =?utf-8?B?RVFJYmwwUmtNZ3FRTkJzN1BHemxpZG1CMDN2czY5OVZIeGRqME9SU3JMVTdv?=
 =?utf-8?B?MU9wTDl6QVpYT3NDTDBtQTRWSklQeTY0dmNrNjRiRHFGbVFpNTRNdEp2dU5K?=
 =?utf-8?B?b0pOR3g5QXZ3Q3R2M3JjTVNLWER0ZmQ2a2QxWnEyaEl4bGg2V3lSTXdvcnZo?=
 =?utf-8?Q?leru4PokWno+vHnSkmX5ZhcER?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 616d7294-32a7-43c5-16c2-08dc9a61c176
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 06:39:42.7986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVr3RvicoBR4zwVzO1gjoqrj5mWOagc/l8qfCYCiKe4nQLcTdCRniuj+3oRATjsXwv4uR126s1FHvbz3Zqg9xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
SnVseSAyLCAyMDI0IDI6MjUgUE0NCj4gDQo+IE9uIDIwMjQvNy8yIDEyOjUxLCBCYW9sdSBMdSB3
cm90ZToNCj4gPiBPbiAyMDI0LzcvMiAxMDo0MywgQmFvbHUgTHUgd3JvdGU6DQo+ID4+IE9uIDcv
Mi8yNCA5OjQ3IEFNLCBCYW9sdSBMdSB3cm90ZToNCj4gPj4+IE9uIDcvMi8yNCA5OjExIEFNLCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4+Pj4gRnJvbTogTHUgQmFvbHU8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPg0KPiA+Pj4+PiBTZW50OiBNb25kYXksIEp1bHkgMSwgMjAyNCA3OjIzIFBNDQo+
ID4+Pj4+ICsNCj4gPj4+Pj4gK8KgwqDCoCAvKg0KPiA+Pj4+PiArwqDCoMKgwqAgKiBGb3Igc2Nh
bGFibGUgbW9kZToNCj4gPj4+Pj4gK8KgwqDCoMKgICogLSBEb21haW4tc2VsZWN0aXZlIFBBU0lE
LWNhY2hlIGludmFsaWRhdGlvbiB0byBhZmZlY3RlZCBkb21haW5zDQo+ID4+Pj4+ICvCoMKgwqDC
oCAqIC0gRG9tYWluLXNlbGVjdGl2ZSBJT1RMQiBpbnZhbGlkYXRpb24gdG8gYWZmZWN0ZWQgZG9t
YWlucw0KPiA+Pj4+PiArwqDCoMKgwqAgKiAtIEdsb2JhbCBEZXZpY2UtVExCIGludmFsaWRhdGlv
biB0byBhZmZlY3RlZCBmdW5jdGlvbnMNCj4gPj4+Pj4gK8KgwqDCoMKgICovDQo+ID4+Pj4+ICvC
oMKgwqAgaWYgKGZsdXNoX2RvbWFpbnMpIHsNCj4gPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+
ID4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogSWYgdGhlIElPTU1VIGlzIHJ1bm5pbmcgaW4gc2Nh
bGFibGUgbW9kZSBhbmQgdGhlcmUgbWlnaHQNCj4gPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBi
ZSBwb3RlbnRpYWwgUEFTSUQgdHJhbnNsYXRpb25zLCB0aGUgY2FsbGVyIHNob3VsZCBob2xkDQo+
ID4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogdGhlIGxvY2sgdG8gZW5zdXJlIHRoYXQgY29udGV4
dCBjaGFuZ2VzIGFuZCBjYWNoZSBmbHVzaGVzDQo+ID4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICog
YXJlIGF0b21pYy4NCj4gPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKi8NCj4gPj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIGFzc2VydF9zcGluX2xvY2tlZCgmaW9tbXUtPmxvY2spOw0KPiA+Pj4+PiArwqDC
oMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IGluZm8tPnBhc2lkX3RhYmxlLT5tYXhfcGFzaWQ7
IGkrKykgew0KPiA+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwdGUgPSBpbnRlbF9wYXNp
ZF9nZXRfZW50cnkoaW5mby0+ZGV2LCBpKTsNCj4gPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKCFwdGUgfHwgIXBhc2lkX3B0ZV9pc19wcmVzZW50KHB0ZSkpDQo+ID4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGlkID0gcGFzaWRfZ2V0X2RvbWFpbl9pZChwdGUpOw0K
PiA+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxaV9mbHVzaF9wYXNpZF9jYWNoZShpb21t
dSwgZGlkLA0KPiA+Pj4+PiBRSV9QQ19BTExfUEFTSURTLCAwKTsNCj4gPj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaW9tbXUtPmZsdXNoLmZsdXNoX2lvdGxiKGlvbW11LCBkaWQsIDAsIDAs
DQo+ID4+Pj4+IERNQV9UTEJfRFNJX0ZMVVNIKTsNCj4gPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0N
Cj4gPj4+Pj4gK8KgwqDCoCB9DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gK8KgwqDCoCBfX2NvbnRleHRf
Zmx1c2hfZGV2X2lvdGxiKGluZm8pOw0KPiA+Pj4+PiArfQ0KPiA+Pj4+IHRoaXMgb25seSBpbnZh
bGlkYXRlcyBkZXZ0bGIgdy9vIFBBU0lELiBXZSBtaXNzIGEgcGFzaWQgZGV2dGxiDQo+ID4+Pj4g
aW52YWxpZGF0aW9uDQo+ID4+Pj4gd2l0aCBnbG9iYWwgYml0IHNldC4NCj4gPj4+DQo+ID4+PiBJ
IGFtIG5vdCBzdXJlIGFib3V0IHRoaXMuIFRoZSBzcGVjIHNheXMgIkdsb2JhbCBEZXZpY2UtVExC
IGludmFsaWRhdGlvbg0KPiA+Pj4gdG8gYWZmZWN0ZWQgZnVuY3Rpb25zIiwgSSBhbSBub3Qgc3Vy
ZSB3aGV0aGVyIHRoaXMgaW1wbGllcyBhbnkgUEFTSUQtDQo+ID4+PiBiYXNlZC1EZXZpY2UtVExC
IGludmFsaWRhdGlvbi4NCj4gPj4NCj4gPj4gSSBqdXN0IHJldmlzaXRlZCB0aGUgc3BlYywgRGV2
aWNlLVRMQiBpbnZhbGlkYXRpb24gb25seSBjb3ZlcnMgY2FjaGVzDQo+ID4+IGZvciByZXF1ZXN0
cy13aXRob3V0LVBBU0lELiBJZiBwYXNpZCB0cmFuc2xhdGlvbiBpcyBhZmZlY3RlZCB3aGlsZQ0K
PiA+PiB1cGRhdGluZyB0aGUgY29udGV4dCBlbnRyeSwgd2Ugc2hvdWxkIGFsc28gdGFrZSBjYXJl
IG9mIHRoZSBjYWNoZXMgZm9yDQo+ID4+IHJlcXVlc3RzLXdpdGgtcGFzaWQuDQo+ID4+DQo+IA0K
PiBobW1tLiAiVGFibGUgMjUuIEd1aWRhbmNlIHRvIFNvZnR3YXJlIGZvciBJbnZhbGlkYXRpb25z
IiBvbmx5IG1lbnRpb25zDQo+IGdsb2JhbCBkZXZUTEIgaW52YWxpZGF0aW9uLiAxMC4zLjggUEFT
SUQgYW5kIEdsb2JhbCBJbnZhbGlkYXRlIG9mIFBDSWUgNi4yDQo+IHNwZWMgaGFzIGJlbG93IGRl
ZmluaXRpb24uDQo+IA0KPiBGb3IgSW52YWxpZGF0aW9uIFJlcXVlc3RzIHRoYXQgZG8gbm90IGhh
dmUgYSBQQVNJRCwgdGhlIEFUQyBzaGFsbDoNCj4g4oCiIEludmFsaWRhdGUgQVRDIGVudHJpZXMg
d2l0aGluIHRoZSBpbmRpY2F0ZSBtZW1vcnkgcmFuZ2UgdGhhdCB3ZXJlDQo+IHJlcXVlc3RlZCB3
aXRob3V0IGEgUEFTSUQgdmFsdWUuDQo+IOKAoiBJbnZhbGlkYXRlIEFUQyBlbnRyaWVzIGF0IGFs
bCBhZGRyZXNzZXMgdGhhdCB3ZXJlIHJlcXVlc3RlZCB3aXRoIGFueQ0KPiBQQVNJRCB2YWx1ZS4N
Cj4gDQo+IEFGQUlLLiBBIGRldlRMQiBpbnZhbGlkYXRlIGRlc2NyaXB0b3Igc3VibWl0dGVkIHRv
IFZULWQgc2hvdWxkIGJlIGNvbnZlcnRlZA0KPiB0byBiZSBhIFBDSWUgQVRDIGludmFsaWRhdGlv
biByZXF1ZXN0IHdpdGhvdXQgUEFTSUQgcHJlZml4LiBTbyBpdCBtYXkgYmUNCj4gc3ViamVjdGVk
IHRvIHRoZSBhYm92ZSBkZWZpbml0aW9uLiBJZiBzbywgbm8gbmVlZCB0byBoYXZlIGEgUEFTSUQt
YmFzZWQNCj4gZGV2VExCIGludmFsaWRhdGlvbiBkZXNjcmlwdG9yLg0KPiANCg0KWW91IGFyZSBj
b3JyZWN0LiBUaGUgd29yZGluZyBpbiBWVC1kIHNwZWMgaXMgYSBiaXQgY29uZnVzaW5nIG9uIHNh
eWluZw0KdGhhdCBkZXZ0bGIgaW52YWxpZGF0aW9uIGRlc2NyaXB0b3IgaXMgb25seSBmb3IgcmVx
dWVzdCB3L28gUEFTSUQuIPCfmIkNCg==
