Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACFF2BD587
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768456803; cv=fail; b=a1w9pvg4ijHu8X247dIZfb/nEyPaR7C5T7nF5mouA+nM7zX72ISs4wM+rdl0uuKzbxUbWUmoNY18xpTgVE0x0xkLE0Sy+XNxpA6plzHZweoqikyYnDv8qa3HtDB3HuzWUZDD8UsEp0JHDakKognTggV76IrE/w5qbxKjg7q6Y6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768456803; c=relaxed/simple;
	bh=lUyLdum7WdpeiMzK4RDMJvgkUZuCW/G+XTelG9tPxaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AwVH+XpQTCwTkMU7pbg0bBGQlbK/jBWaCuvUkyfL5VBNOR5reQmTTCpkBziie/mgyHAWAs9BZ2WSrHleRBjCnO48/lD+YdJgS8DKTIjVQdXJw/p2ZJn7zAIO3HT0MzTUlEmc7oHhQDyOJU30JEZntiv+hMC7rLMWDIGjjHXaUNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HktHVSxJ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HktHVSxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768456802; x=1799992802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lUyLdum7WdpeiMzK4RDMJvgkUZuCW/G+XTelG9tPxaQ=;
  b=HktHVSxJMsZbIjUr0m+iiFG28mSskiRe5i5lyE6wGIaDbZFmOERzyk9P
   3yzzUbtVEXB2iVpjGAuNm/ZMUyhtyjFAiAq68MEsUaTm5enn5jfz2jvRS
   CZtj3knjZR77oQbKlZV5Jti05+7NoftW5wwn/vgb/CarV3m9T6HR3VQDx
   fsncjHJyUannWIwG799rU3e6VHsrXVXueNBg9w9WVertrBizg+CTuKl1B
   Izsgp0yl+JjitVIwsssB29AoDRa/s+loi2RWldXUUKPrxyvoG3eya/PWK
   hujMITgEk/LSom7diagv6VGf+9P1XQYDvQD3J2xYNc/+7v6E2o1Gd44nO
   A==;
X-CSE-ConnectionGUID: +RkUMguVSz6TbZ/GR7mFZg==
X-CSE-MsgGUID: bXBSoeclQ1Grb+0TRhYh9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68769677"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="68769677"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 22:00:01 -0800
X-CSE-ConnectionGUID: 2xqAEmR1SwKTnGhg8ZsChg==
X-CSE-MsgGUID: Up5IQcVhREmZhja/V2OTuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204754836"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 22:00:01 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 22:00:00 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 22:00:00 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 22:00:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyIeFN3THjkHNjXWEz/MStVlibp7pNsHHEIq7oYc84lcDnmnKGsfpsnfuZmOC6u/UYp/o9ZHVfsZd1jECEbtqMQLWMIVlbCpAkkHM7ST0I2lI2v5hlJrdw6EdE7l7HkLtiMgcHdJYEx7C+ybvYyzX+Nbq+z9DRpJz8cLbHlrxQKbDhprpRceEtmLBfzg+3uvN8AwLhCngySpTIquRHIX9pN9Ouf7s9ap1SOk1yms4UvkKOzfBuTwFLgQn6wA4eQokRyIyc5DjNyDVFklAnRHyWL8AU9CYFnHt2y4VJYo+3coUuw0jwj+xnqF5VftcLM30HM4dTwBuuj28I/kfptdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUyLdum7WdpeiMzK4RDMJvgkUZuCW/G+XTelG9tPxaQ=;
 b=xMcdw/IuJ+fA5n3KSqU3qaqf+pbjJk1gGprR5kncgw9Mrp3zBSjR93kcHnauAfyCb1Jzwm4smE+iCd54WOhIj3fdfJujseaxTXO0vJ+utzNVp3KIvd84NuNSW6duJH3aDMw7q0tAXwKU/1AvacR2XDCYarWGc31jUoluimr5aGsf9eR1pgXd3rgbyEQmvK02H8TPYQ5gYzo9WsJoPuPuWjR6OYtr1L7Bqvqaxin5+2dLR0aDOWWbuIRM/bSG6Do66Nw4mYfUsIt9pxApYgkuCIixAgx5E8tbsu9pcWaAAPP5AjkGTKDgDcyAh/KC+9NJ9yvD8VbzCUivRhPFeAq7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7482.namprd11.prod.outlook.com (2603:10b6:8:14a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 05:59:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 05:59:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
	<skhawaja@google.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
Thread-Topic: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
Thread-Index: AQHchDk4W/6+cv58J0mVdTDrdjg0/7VRR2wwgAFNtACAACpDYA==
Date: Thu, 15 Jan 2026 05:59:56 +0000
Message-ID: <BN9PR11MB52768CB67C102CFCF562E8248C8CA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276EFACF8AA21215568550F8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <db26b1e3-bd7a-44ee-b458-6cb0fedf6662@linux.intel.com>
In-Reply-To: <db26b1e3-bd7a-44ee-b458-6cb0fedf6662@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7482:EE_
x-ms-office365-filtering-correlation-id: 9824df2a-50ed-450d-c220-08de53fb4f4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aUNYak01RFpIM3I2MFB6TFVmUzJoRXFoeC9vLzJFOFFvck9tUmVxZE5leUhW?=
 =?utf-8?B?RmlVdkVPQUJxeksrdC92V0tjektmcGplTEpBU2hsWGIwVkhacm5uTnhiZ3Mr?=
 =?utf-8?B?d0daWTZLWGo4T29sTks4Yk9aYW9rek9vQ3l5OUhXTW1hZXRwd29NMXRuRkhY?=
 =?utf-8?B?KzdDVUlReDZSblRDWEd1Tk5sek1GWDFtNmFWQ28wV0Z5ZjhBSmpYcXl5Q1dQ?=
 =?utf-8?B?Tml1MnpxUmJPTVBqeFNjODJXQnM1Tm9tRy9YNnRTSERucGFIYVJYRHVRc1R5?=
 =?utf-8?B?S1ludUhKTVkvZm5qOXR1azJ2VVJWK1N2YzgvSnRQMkN2NmNMN0hGZjZwcnp4?=
 =?utf-8?B?bzF0QjJIN0RLSXVNRGwvSlAzZUo2WkNvckh6dUVuRnBScWVvQ0JodVJzdU41?=
 =?utf-8?B?RlZvWFdZSmkrVTRKVjh1RGJHWjVCcVhyVDZWUStjZG5IU2c2VkcwSi9JZ0dk?=
 =?utf-8?B?K255QXVFUUJYTHl2d29jK0FSRWMrSDQrSXRjTXRMVHBlV0s1b3M4eTJ2SUVW?=
 =?utf-8?B?anZzOFhSMlM1aFRkZEVjS0tWK3diRG4vMm5RTHlrZSsxMDZVN0kxWVY3dks2?=
 =?utf-8?B?OE5Xa3hqNXZwWGQxYkpTQy80eVZGTHFSdXI0TXJTYTgxVTZmc1FyNUlmL2sz?=
 =?utf-8?B?ajhqbTN0RFF4UVdKUkR4YXBPeDBaODVpaHRYRWtKUFA2SGR5TEkyVlhFZjFw?=
 =?utf-8?B?aFRpQ2pFYWU5Q0twSjN3OWo3bk5WaFNaeXdDRnhDS25jN1pjR1JrMHFuUFU3?=
 =?utf-8?B?K0ttQ3oyeHA3aE8zQjJPOEZ4S3FhV0pzQitkZDFSditYNndTSmZmcHloL1VB?=
 =?utf-8?B?d2x5bFppVC9wTnNNVjlWTHB4ZGVFOG9lRHJyejJaWFZSM1kvZnZUTXhHYjN6?=
 =?utf-8?B?S0dzZkNjSDBoN3o4QThNNlUzOEQxUVdmN2xEUXZudmF4RGd3Nnl3UVhvYnUw?=
 =?utf-8?B?cTZ5QmZkNGQ1NUFWUnNWOU9ZcGlEVkNTdzhXcnorRDB4YjZ1a20xby9URXor?=
 =?utf-8?B?bW1rbUNWNjYyWkMvTkRwM1RYVWs5L20zbVRSTnIzUzJ4SnVLMUJjWlRWVDMw?=
 =?utf-8?B?cFFJMTUwK0V3aEpheXZWOUhxVkx4dFZ1bUM1ZlFOZjVWMnR5blRsZnltZlE5?=
 =?utf-8?B?MXc1ajBOaSs0N1NOYTlPenUxZjFLZTQ1RnBBMURWNklmTjN3by8ySW5QVVF1?=
 =?utf-8?B?TlpJNnV3VEFyLzNHaGJ2Lzdhd29JV2xma2VhZDJSMFFTNUhlRDRiYnA4UUJu?=
 =?utf-8?B?YjROVWUxeVpyNlNGMWxKaUw5WFdVdmRhRytvYzM4OFBHUlBLZFlzbWloYmpt?=
 =?utf-8?B?Qk5aTmJEcDJ0TFdrYTFLL2U1T3BMQUlzdlpmNCswbW9aU2pSdFBkV0FxMm9V?=
 =?utf-8?B?eW12OWpIT1pSWnRrNDZzWDcxaVdPRjE1Ri9GNGZpUmxidWR2cU9MYWZpR3dj?=
 =?utf-8?B?d2pHY0kxRThuMW5sSE5XR2V6RUlzOStEMnBRNGdVbmZKZExlQXNXemE3bW5K?=
 =?utf-8?B?NWdpcytnVUZ4Rk9BMUhqT3ZGSERJeEx4NzRsMkk3VWVjOFFtM0JSa3B2MUpE?=
 =?utf-8?B?VmlhcVo3bUFIbld3WHpVbFIrMVZ3a0UvTENYcXAxeUE3VG1jLzBIWG16dkk0?=
 =?utf-8?B?VWRUM0xEU0d4U0hhWkJ5dEFIeWJ2REVhT0FOT1FFdkdyZGZTZk9tVXhabFhJ?=
 =?utf-8?B?NHo2MmpUSXpCMllNcTN1ODIzZnBPZEYyWlNUaVViY01NVm1JZXdqcHNMVWZa?=
 =?utf-8?B?TEV5WjRoRmZQTTd4cjhjMnhmdWU4YTl1NnpIeDVSdG15V0lHUW5meDdqZDgv?=
 =?utf-8?B?eVlhSkpJY1llVmVZRWNQcHhBOVZWT3dIR2NhZlBqVDZZcEpwTGNLdGw1M0dO?=
 =?utf-8?B?QXVpYmt5OVdhamFaeElTSTVSTDhJdUdiWURacXNmRjlhanJ2OWhYMlZEbGt3?=
 =?utf-8?B?VE1wb3JsaDVGMFhLcmh0Nnc4RUE2MnJ5UUNRdU5oWEZDZTBZUHZjSTM0T3p5?=
 =?utf-8?B?ZjU4WWVrUFdKOWZQaEY0eXJnNlhKVTU5THRNenN4K1Q4K1JPMm12MExEbmZp?=
 =?utf-8?B?T0xnOTZZWnFoNXJJMldiZGd5VnFidktzeUxWNFdKYnlZTVVXZkNPb3RmUzhL?=
 =?utf-8?B?RW5UR3Q3SFJqMTIrSUQ5Y1RQNVRWQmJUNVZTaFpQcUVLazVJUTlQcXQxa2FB?=
 =?utf-8?Q?ckg4goY2FQtw7gOcssEe+YU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVNTSUM0amFwYWFOYnl0TTlwQmJUcWQyVnovUjd5T2VOZEVNRlZ6TVRXR1FR?=
 =?utf-8?B?Um1zbmwvM0pkVFFPNStPM1Fkbjd4Ym9nT0F0OVJ6RmFpSDlSTWcwVW1NcmMz?=
 =?utf-8?B?L2dvaU5DUFh1T1FtV1ROc3c2eW5SQTdHWjRNRnhIUVZPU280T090RCtCOG8z?=
 =?utf-8?B?akNUTXJBQkFac1hteWcwekpNS2h3QmhneDc4Q3BpRzBUNW5HaU9MZTAxNmZv?=
 =?utf-8?B?U3JSUU1adUZnekNYWWVMcDQydnIwclgyMmk2YmVMa0FOZGpVU0JudFZKbmJP?=
 =?utf-8?B?SktNRGJvVkxCR05Lb3dJcmswMlIvRHcrYlAwWXFoa3Zmb2RHbVpHWFpaaFZ4?=
 =?utf-8?B?d01iNFZMUC9GN3BncFdJZGsxV2RCa01ZV1krYS90OWM3K3dFUUc0YkE5TzJ1?=
 =?utf-8?B?ZldWUFJ2WG9Cc1phcmk1OFFDSTNiNWxWWWdxUzhlZ0JnWVAyOXdRaVdiOUJB?=
 =?utf-8?B?NmUyUi9PcWxrL2N0dlBXNW9pNHE0dk10eXN6TkorVkFQSC9KbXF5THdwL04r?=
 =?utf-8?B?Nit4TUV3QmVpNms4dlJQeTNQN2hKSHJvVVh2cFFKWWZuRis4T0tqaTRuZzlJ?=
 =?utf-8?B?Rlo1by95OGRyZE42dVZwZWROK2pTSDE2aG5sWVJkN2FuWmlDSXB0SnJ4a0lL?=
 =?utf-8?B?SlhjdGUwQ3gyejQwVkY1TkZ2TEVGWjNSZTY4VFpWUUZCQ2JZNFRkZGR2VGsr?=
 =?utf-8?B?dmRCckJidkVCNzNIYjU2S2c0d1RPbzJBbWx6dU1IRzZXSUp3cVlLKzdmSUpY?=
 =?utf-8?B?a01kdlhLR284MGNuREJ3eHhOdkIwNjRRR0NjdDkrekwyS0xWaGQ3aGZJSHI3?=
 =?utf-8?B?YjMrREQrckZRVkMzN1d5bmp5S21UaWhhTlpyT0lBN2JZZ25CdkpIakhFMWlN?=
 =?utf-8?B?MGZXT1BQNjdBWHJkVnR1cDQ3SVhtRElxcU5jWGFyMkYzOENOT211blZzRHdQ?=
 =?utf-8?B?c21iblBRY3Q3aTJ3a3pPemdhZE1tdndXMWYvN0JKdTEwRHpVNm5JYUtXVm5s?=
 =?utf-8?B?YmtFcy9Zd0loVEM2K1V2NnAwdldoSHNvanhxMFlMckVWRUlhVGlUOUVBYnJn?=
 =?utf-8?B?MldIZktLRTVYOVVKTHBiQmdZWFEzVlk1bWJ6RVRRTitrd0wwZ252VmlEWTRD?=
 =?utf-8?B?WmhOMHBRWW5FU0RuK3NkZ2IxWk0rQUw5WGNqTk5NV0pMSm9JWnlvM2s3dVZu?=
 =?utf-8?B?K0pJdTFISWpRTmxXbWt2eE5jajdIWGJXVmREcUFIYno3eGZpR0hDVXV6OC80?=
 =?utf-8?B?MFFMVjV1Y3VZVm85RGMzenVwUytUT1hmMVpTalMxcW1TMU5hcHE1eTk1elFC?=
 =?utf-8?B?NStJZmJvN3cyOHJGc3pxTk5uWDZyUzVPK3J4M2t1MytsMHFJTk92RWs1UE1H?=
 =?utf-8?B?T0t3MnRHMUpMSE82a09hbTI2T3FYc3k2VmVCbW5qa3F0bGllQ2hLbjlIcXFZ?=
 =?utf-8?B?ZHJBME9YRFZnNzJ0UFZnYTBJMXBZcmU5YlpKcW5kcW5BQWtmd1lOKzl4Y0NV?=
 =?utf-8?B?MTFyMVgxVjVPVHk1bSsrYURYRE5iQmFGakMxWEN1NmpvblVUVy9pNGVjYVVu?=
 =?utf-8?B?a0E3bVgweThPaVhqb2VyWXZUZnJCdmtCTEJoL0JPbi9veWxYT3lqUHh5cjF5?=
 =?utf-8?B?VDdTZWxFNmdJZ25mbllhWklQK3VqYUxnZVNHeDN4bk5odTZjMkRPNU94WHJT?=
 =?utf-8?B?b25GaE5KY0FHRkxHTzFIS2ZEbXJHcEtGUWVQTXNwZC9lczVMZis4ZGhFY0dE?=
 =?utf-8?B?eS95ejQvZ3l0bGxtWWx3K1JhRnRoMWJDYVJZTWVYZlpHY2xLcDB5TFZ0czVR?=
 =?utf-8?B?a3BGaWhFZE9CTGtrZE1WdUVZSUZtdnJrRmlpRXcvR0lzRDZvNjl0ZmJIOERV?=
 =?utf-8?B?N2QzaGUwejlUVXlGczN5N0dDR1FDcXc0U2cyRjBkQ3JNS1U2RWZJaEZpMWRy?=
 =?utf-8?B?ZFVBbW1WSFQ2ZzNMUzJzNk5iZFdZa2tFZlFBMVNTeTl5cHBWalpHbVgrRllI?=
 =?utf-8?B?UEo1Y2hwS2EvbFI3TVZpc3RWbW9XQVpFUkF0bHlHSDMvZ1FaMDB3WVJTS29q?=
 =?utf-8?B?S1dGZlI3TWErcHRVRVBENXl3Z2ZBRFJ5NVhabE0rcTdpMEJXeWp5Qlk1dGxz?=
 =?utf-8?B?RlVMenFUQzhscDd5R1pvY3lOVEQ0SElMaHcwN3c3SnBHZ3FIQ3BnbTByY2dH?=
 =?utf-8?B?Yko1QlA1SDNvdG9xYlRzeFhGdCtWNFdMeWdNdnVuL1IvbzRQSlRYSWFwVGda?=
 =?utf-8?B?MnBsaGFhbUUxc3ZhUjZqR3d4L05EbTY0Q1pBTlg1RVpERDV0aW5oanFhdTQr?=
 =?utf-8?B?Z1hOYkhhOWtkNU53SFZrWkk3bGlVSW1lVEtOc1MzNEtneTcyRUpaUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9824df2a-50ed-450d-c220-08de53fb4f4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 05:59:56.5079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sv7lcSC0P+gtw6XoSZO7K3veayb77WTCkLTFAE9qXJV9dnm9/bNlEq2MirzGDoqI1QEwtGfHdjWRM4N+pdnUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7482
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSmFudWFyeSAxNSwgMjAyNiAxMToyNyBBTQ0KPiANCj4gT24gMS8xNC8yNiAxNTo1NCwg
VGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4NCj4gPiBUaGVuIHRoaXMgbWF5IGJlIHNwbGl0IGludG8g
dGhyZWUgcGF0Y2hlczoNCj4gPg0KPiA+IC0gY2hhbmdlIGNvbnRleHRfY2xlYXJfZW50cnkoKSB0
byBiZSBhdG9taWMsIHRvIGZpeCB0aGUgdGVhcmRvd24gcGF0aA0KPiA+IC0gYWRkIHByZXNlbnQg
Yml0IGNoZWNrIGluIG90aGVyIGZ1bmN0aW9ucyBpbiB0aGlzIHBhdGNoLCB0byBzY3J1dGluaXpl
IHRoZQ0KPiA+ICAgIGF0dGFjaCBwYXRoDQo+ID4gLSBjaGFuZ2UgdGhvc2UgZnVuY3Rpb25zIHRv
IGJlIGF0b21pYywgYXMgYSBjbGVhbiB1cA0KPiANCj4gUGVyaGFwcyB0aGlzIGFsc28gcGF2ZXMg
dGhlIHdheSBmb3IgZW5hYmxpbmcgaGl0bGVzcyByZXBsYWNlIGluIHRoZQ0KPiBhdHRhY2hfZGV2
IHBhdGg/DQo+IA0KDQpJIGRpZG4ndCBnZXQgaXQuIGF0dGFjaC9yZXBsYWNlIGFyZSBkaWZmZXJl
bnQgcGF0aHMgYW5kIGlvbW11IGNvcmUgd2lsbA0KcmVqZWN0IGFuIGF0dGFjaCByZXF1ZXN0IGZv
ciBhIGRldmljZSB3aGljaCBpcyBhbHJlYWR5IGF0dGFjaGVkLi4uDQo=
