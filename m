Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762327482
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 05:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660168; cv=fail; b=ARb1voJ4EBilq4TiOJSlONKRTfAcBw+ZhXRGmH2IPIBCDOroZB9MZJf82AYG9PI809+tEyBmKFj1TcmgfYXm36g898LzbmrTiQiWd8gxohs0cICqlqpIQKK8coXM+H/fvWrkHDLXNYg2P47FT9T+J9p797kJgOsQVcTU2Znr5uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660168; c=relaxed/simple;
	bh=n/kfkQnC4OEBNyGrxuAUC+0xpWP36aUFZuK1XX851R8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=InQ7AZ+3N1flLb2OCmDEtlGlMmrnX8+RLWIT3OHNfUQHQuZtoB68L9fni/M54NYp8pMNREFsOsvAa+lCnNBjV2Hg+yqZwy+PjIRTh7HeyZtZERRVh7KXrR66rHpqv/zW6UHn2LSALFoPskrgc2vWPTi96LT8+Dd2GEcB0NeAowU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3eqiRfs; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3eqiRfs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729660165; x=1761196165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n/kfkQnC4OEBNyGrxuAUC+0xpWP36aUFZuK1XX851R8=;
  b=T3eqiRfs+lKGAXUGMG8ciiRZyadNAJRtxkJa9CbxMwsQ2Kcp0l01x0gn
   zLHHCSfczqJz+jqrJFK/D2zuvKmqkp2Htz5cRDkGBuz2b9qhL1HpgtCiG
   6OmpLdsBJ3GZkGzszo3QKm3qCjELzumwbC9KXgpGN8DkYWfddkUtjI/jA
   XVswWAyWnvSp2QfsZJW1V3coVZM5HBWTZrJ4LwXarBgjYiqdyaCZuuVfR
   25gltVJPUCR2u3uv3GUo7zvAexVj7oj+6r78ZGxeeJcw3823lVu55BQUQ
   3Ev+m50Zn+tOyUSOMA0bx5Yh4K01x5MWBbU4Bt0A9B9KZYdsb3U97mhiw
   w==;
X-CSE-ConnectionGUID: GYD0rPOrQLG2aaaxqyubdA==
X-CSE-MsgGUID: ASoO+yPKQgSovb/8dzfejA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="39806361"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="39806361"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 22:09:24 -0700
X-CSE-ConnectionGUID: yFbuMRE6S8Gm2RWLFUobiA==
X-CSE-MsgGUID: 27+FZR2STE2+uARRodd04w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80020355"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 22:09:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 22:09:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 22:09:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 22:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y426BLwTT2TApvzpi1jOVPdok6FI12VczLkZJLb+8eetluyDQY7xtzpvJkarVrvQaln4PeBOZBkJJfuXvJOkhGT14gZSfsKHtulhFkRMubjx1YvlCcuOMZYnlI4NQdE/T1EuQsZAY2F9R2gRAgN7SFVYMlNLG+LhKTJ6z3e4kiI3NPFn1+LEtKaba+D+zr5OFAz5UsMywu4wG/kwCKcWlPVeqxCPUGbtuPjy/i37P1YgLWagH+mjvcsuVlvXFeNugZKYW8RY0DQZ3+aSRm2IRG2lMccKSRAs5bRpwzyOwN7O/qHzB2oibl/g+cNdMYDiAbCleCBahapQSzMPUwanYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/kfkQnC4OEBNyGrxuAUC+0xpWP36aUFZuK1XX851R8=;
 b=oiiN1mC/V+t+QCo1W38FqMW0xB7Dr1mZUlptZNHv/pX0zayU4Ite1rWu2HJ6ctn3tGf4s1L3m8EzU2hSxPUQ/w67kbzpCWVKZGJMM9XSRl3GDwnx0OpFFg0c4yLB28UCjCyFZ8CuZAc5oMuPLqbUcMwzbHBlmNM10y3ohYjwCozFR2yedprebBFomBHky6gct6GP48juRe/5XdBQa5vWJ9Zk+2d0Y1sSsBQRjpukyfYgYC4zww8Jtkg0WErwl9sijaELUqUHtbc9H/3hwkPKElOOOvMdL3wfDmTrSFD/IQGKEW/HgV8EqnEE6sFIuJ43T4/hJyq2JdigKZaQmoOzbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 05:09:21 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 05:09:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>
Subject: RE: [PATCH 1/2] iommu/vt-d: Fix checks in dmar_fault_dump_ptes()
Thread-Topic: [PATCH 1/2] iommu/vt-d: Fix checks in dmar_fault_dump_ptes()
Thread-Index: AQHbJGhAjO2HOj30VESpiNTxtDQGPLKTqhmAgAASYdA=
Date: Wed, 23 Oct 2024 05:09:20 +0000
Message-ID: <SJ0PR11MB6744E47FF944D4C576B6B973924D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241022095017.479081-1-zhenzhong.duan@intel.com>
 <20241022095017.479081-2-zhenzhong.duan@intel.com>
 <b524d09e-62ea-41ca-904c-e9c94aef2b76@linux.intel.com>
In-Reply-To: <b524d09e-62ea-41ca-904c-e9c94aef2b76@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV3PR11MB8674:EE_
x-ms-office365-filtering-correlation-id: 1eabf70e-692e-498e-0c1d-08dcf320da7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHVCOUZhS20yMDliZTBWV3lpWUpKVnl2S0FMcVVodUFDZER5OTBYL3FlTXZO?=
 =?utf-8?B?cjVUNXlDUEN4K2ptWjZMZ2U1eEwzU2JuYW1KK0JkOE5uTmNwYXZyL1d1MVVr?=
 =?utf-8?B?SVloVXJYSXVhVWE4ZWU0eFJFa2VBTVVtWGRvRXJLZTdLUEhjT1NlMkh3Zk0z?=
 =?utf-8?B?eC9URCtrWUtSTEY4VWUxQ1dpOXd2OUtubG5tbUU0eXg1ZHkyUExoUVVZM0RG?=
 =?utf-8?B?dWFLVnFZMUExdUhFNGp1QTJyWjBiMXVuMjhDOXphL3lyQmRMR3VEd1ZYNEs5?=
 =?utf-8?B?bTRvalBhU0g1T0VkanJJdWtXUnBkV2J6cktDQmg4RmlzTytLUGd2Zlcrd1dy?=
 =?utf-8?B?eEwvS2tnVGc2U215TC96MytBMWt1NjBzcjRTTTNHOXlSdkZpREx4L2RGcmRr?=
 =?utf-8?B?VkV3cGwrbWk1c1l3RDN2eGw4cmpxTDN5QU1qWnNSeUYweUZIb3BveFRqU2dC?=
 =?utf-8?B?Vm1Fc3RjREpWNHljbEhUKzRlR2htVDBnOVRVWkFHMy9NMXlLbzFsaGxkNTRo?=
 =?utf-8?B?bzFyRjJXYng3Ykl2QXRyRTVkMnF5ZWU2dnN0cWgwMklPT24wTlpsSmgrazM4?=
 =?utf-8?B?UWp6QmRzUWRDQ2ovajczVXBVNWNGeE9FTENZOHFkTXlEdG1ndWI3My94UU14?=
 =?utf-8?B?TkNTcXdVQ2RhT1lWK3RCd1orTUI0Z040cklNVVgxdHVXQzJTck05OUxHZHlD?=
 =?utf-8?B?c2VLeG9rSUIzWWROUk0wK004VDl5TVhlalBobWI3L1Z5bzVITlJkWk9SVGdB?=
 =?utf-8?B?RkRmbHFNRXVCRTZ2UFlDSzQzWDVvd2cvTjgrUFZob0tDRmY0anRnWVFVVGVB?=
 =?utf-8?B?L3Q2cDdjWit2VWNDNis3cmJNa1ZFbVZEU1cxWERueTkxTllWRDNvM3BobFVU?=
 =?utf-8?B?bkNWcTZwODhmTm9sNTZMa3hLcWs1UVZlTG8xZjVCb3JBS2RRbjRjTTVWcjBI?=
 =?utf-8?B?WUZpS3FXYWZNbnFROVR5T2s3RVBBK1ZPaHZDcU9xV0szZ240TGdCNEFQVFhU?=
 =?utf-8?B?STdITmtPc3VtbkM2MlRIMnpyL1Y1L3NtWUVvbDZaNkZWYktmdnoxQUk0N3R4?=
 =?utf-8?B?c1VMY0VCb056Vm5qWEgyUUk5TjVzS2tyOVZ2dHVJYWF6bU41ZUg4NkhrbVA2?=
 =?utf-8?B?QkhJMi9Wb05OTlBjRGZWTXhXZldGaUtvd2NRc0NtanFqRUZoMjdMTmY2YkVy?=
 =?utf-8?B?enRoY2JoQWtxWVBaQk1Fa3hid3hmVU1EbFF2YkNsMmlBR09wemJmWW83by91?=
 =?utf-8?B?QTNoamF2S3I2elY0RFZSaDJGMmlwRHVHQy9lSjRPL2luNU9EenIzRlFsbDVn?=
 =?utf-8?B?ZmZ1SktCN0FmbTcwcEtncGcrbnR4b2paYkowTDZRYzhsbHFscHFONWo3Mmlz?=
 =?utf-8?B?OEd4QU9aT1hmNTQ5UU5vVjljTS9TcUhMSHkyWVNwZVJmVmV0ZXdlVTJjQkVp?=
 =?utf-8?B?TWNLREkzdVFuQjNEYVViVVVmdGtZdUcxTnJ3R0JVaTRHR2pIU25hbzljdUFu?=
 =?utf-8?B?TEhmeVFhbGRVc2dsNUZrV1RFODZESk1obGM2QzFvYUp3RkJSaTZhT0ZpcHJ5?=
 =?utf-8?B?dVhCWjBGK29INDJRaCtWTnpsWUt2S1YzSXNtZUhKcXBXcWswZUg4a3g4d0hW?=
 =?utf-8?B?VmtVWHJYOStyUGhEYnBOT3VNYjNpTjk5Y0VDSFpHRUhuVmRpZ3ArSW9kQ2hM?=
 =?utf-8?B?RXJwOWFXa0dpdGVLcDRhMHUyTU8yOGVGR1pqK0wyclA1RkgxL2NLRGllaTU3?=
 =?utf-8?B?bXRKZE5pTnhFbVMrdmtZcG16b1lZR2NLeEZjTEYyWE5nNzJPWFlTaGlhd21s?=
 =?utf-8?Q?wCWDAF7hCZidCvic3ukghIoiIn0G+exXzVnNk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1R0bVB3M0U3TW8zckNUOCs1blZEejBHMTFtdGpTSTJZcFYvMjRCdnowTGNn?=
 =?utf-8?B?NUxFY3hGTzV1b1E4S2hpZHlzVHhTYXk5aDdjb21yWG15UzZkT3hXcjNOQWJk?=
 =?utf-8?B?UUVpdGh5K3JKa0dYblYxcU9PaFpXV2ZvSWNHWjEvT0ovQytKTTlVczBQMVFm?=
 =?utf-8?B?QW80UzFtOExpei96ckVBQ3RXYnVSSnZEY2V1OXViK2VyQmc3bndvUmE3MnlW?=
 =?utf-8?B?bktwbkVIN3dEQjBOc2xDekRCN1RjUGFHUGxGS2JGUTRVVXRWNTdHWEtlVm1R?=
 =?utf-8?B?K3NYSVBiaVF5YUhGeHlUVlFSUlB5dDdKUDFaYVBTaWNpNEc4aFJKMzJYZ1Zj?=
 =?utf-8?B?M1VhTG1kWmNpRjRabzgzKzl3dS9Dd0VhV29jTDJnM2V4c0xlMVRacHNtNGpP?=
 =?utf-8?B?cFJEbUNVTC9PRksyLzdUS1JmYVZkSzB6bzFhVU9LNVFwL3lDekRock5acFRr?=
 =?utf-8?B?VGRBb2dzWTIxajZFWGg0Nk9JTWl6ZFdkdjZqRW42NjZnYlU4Vmk0UHBhQ3pn?=
 =?utf-8?B?WXBlOGRtUVJUWDRSM2NwclhhVEJjVGVOQXhWNGI2VjYva2FtQ1FzT0NZaGxY?=
 =?utf-8?B?Rmh1d0d5WHlBK2IxL1poYStmM2c2ZGtwekNtdFNjMGRMcW9jQ3V5cjNrcldW?=
 =?utf-8?B?V0NVeWNBakJxcFZhUXJVU084RXJYVmlGYm9iaktoak5zeFlIT1BIK2pMcGV5?=
 =?utf-8?B?cDVDeVhPeERqeGZxcTJIZU5MOGRrTUVCM0lWYk9nRGVSc2UzS2JLQmtZblUw?=
 =?utf-8?B?T1hJWEg2d0xlbnhrMG5qeTBGeTlOempqMWlkN0ZiaENRZzBOU3VycktHZnVw?=
 =?utf-8?B?Sm1Yakd5UVNQRTZjUnc4bjZTSGs5V0lHbGJjK1RMRUdna1g4R0x0Q2RpMUpo?=
 =?utf-8?B?MVljV3dlUTBZNlFLV1lhTG1qV0NTbk0yU2FubWhnUXNEejMyaXhQZE9acFdz?=
 =?utf-8?B?Q0RVTDJoZFdvNlEydDJOejJzTHBiMHo4L1NlNzgvZVppZVNVeU9jdjJna3Fq?=
 =?utf-8?B?cDFFUi9hdWdsVXRWd2oyTjlrMHBQOGZRN24rK0tYL0lrL3RuSFNON1hybzIx?=
 =?utf-8?B?dU42dUEreE5lZC9uS0xVYkg0YUZScHV5MEVocmVyOXdzNVV1ano5SGV6aHRl?=
 =?utf-8?B?ZGpveEFDTDI1QlV6TlVNdWFHdW9MRElLUDNnbXhlWTRUeW9yb2djYU5jRzVj?=
 =?utf-8?B?SFYwOEFINzFoOEJoaS8vOUFnb1gwQmNkc0VrOG9lMUIzakVVR0JkRUZRV1V6?=
 =?utf-8?B?MzdpSE0wYUduVm9FbVJzbU9pUzdsNjRDV2dwTkxhTEpaZFBKUEhrRjVMTjFs?=
 =?utf-8?B?L2twdHRqS1ZyYW4zZUJjNnZFZDFrcmlwall2ZEZ1OGtjVFBLa3kzSWlER1RE?=
 =?utf-8?B?dkdNSlg0Vm5RQ01iZmIwVGxkcVBwOHBzK2xDWU9QeExBQm8rWTJYSW5lOWZO?=
 =?utf-8?B?bDJBRS9CbXNNT0RtSE14SDY0bnZ2eGpIUURCckF6TDNtN2JQeE9JNHZCYVQ0?=
 =?utf-8?B?VzlRaHA1MThsOGQ4UUFVaGgwekN6NWRzUEJvWUdQYjlqbG9UcmhxREQrTmhU?=
 =?utf-8?B?ZlQxaW5kbXAzMVIzVWt4MEx6T3E3ZFQzQXhwdy90VTZQQzVQZ2VXQnhJRVNF?=
 =?utf-8?B?L2dxOHN1bmFLdjVXLzIvRmRnNjYzdUtDaGd6cVZZejZkQXlTZkR3ZDVlYkdF?=
 =?utf-8?B?cjlIYkhoKzNjZ1Q1L244SUlTbFlKQ1ZTTTlaS0txMEFPUTN3YzYwcUwxWVVi?=
 =?utf-8?B?TGUrcDd6Rm4zcXBuR1NuYS8wL0NJUldDV0dBdDlhbW1ZSHJxSjE0THFUTVkr?=
 =?utf-8?B?S3VmUWd5YWZIQjc1cTVQZzB5bWt4c2dtY2NTSG1BMzFPNi91N0RsR0Z4alRY?=
 =?utf-8?B?WEN1S2pNOGFPUWkyejUzUjNrMWFXcnV2MDJpYmsxWDJOd2swU2xDN0VsQlNG?=
 =?utf-8?B?TE4wSzlMbVdjWlBuMUhJMWp2NUU0bnpBUmd2UG0xZjYxNTljenpseEN0dWp6?=
 =?utf-8?B?QzZ3TDBFeDNKVW45Smh5bE44UllHOFRvS25xaWdTczZWTzk2T0JBaWs3OU9W?=
 =?utf-8?B?T0Zod2xJWXVnRTdPaGM3NFAvejJKYmxNMHloemt3UTErcW1Rc1NhNWZHUytJ?=
 =?utf-8?Q?ZwMQVA5Vw6CoBWI2avHHbaFMG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eabf70e-692e-498e-0c1d-08dcf320da7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 05:09:20.9769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbrbMZWFCJNweKgB2Vko4c7WtTr+WsjG8lPsc0bUTyQIV7EM11o7urmBJsLlIP/6j5RE0NBzEuV85wzIrn/0xNP1LHqPH/M5upDu1ar1XEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJhb2x1IEx1IDxiYW9sdS5s
dUBsaW51eC5pbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGlvbW11L3Z0LWQ6
IEZpeCBjaGVja3MgaW4gZG1hcl9mYXVsdF9kdW1wX3B0ZXMoKQ0KPg0KPk9uIDIwMjQvMTAvMjIg
MTc6NTAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSW4gZG1hcl9mYXVsdF9kdW1wX3B0ZXMo
KSwgcmV0dXJuIHZhbHVlIG9mIHBoeXNfdG9fdmlydCgpIGlzIHVzZWQgZm9yDQo+PiBjaGVja2lu
ZyBpZiBhbiBlbnRyeSBpcyBwcmVzZW50LiBJdCdzIG5ldmVyIE5VTEwgb24geDg2IHBsYXRmb3Jt
IGF0IGxlYXN0Lg0KPj4gVGhpcyBtYWtlcyBzb21lIHplcm8gZW50cmllcyBhcmUgZHVtcGVkIGxp
a2UgYmVsb3c6DQo+Pg0KPj4gWyAgNDQyLjI0MDM1N10gRE1BUjogcGFzaWQgZGlyIGVudHJ5OiAw
eDAwMDAwMDAxMmM4M2UwMDENCj4+IFsgIDQ0Mi4yNDY2NjFdIERNQVI6IHBhc2lkIHRhYmxlIGVu
dHJ5WzBdOiAweDAwMDAwMDAwMDAwMDAwMDANCj4+IFsgIDQ0Mi4yNTM0MjldIERNQVI6IHBhc2lk
IHRhYmxlIGVudHJ5WzFdOiAweDAwMDAwMDAwMDAwMDAwMDANCj4+IFsgIDQ0Mi4yNjAyMDNdIERN
QVI6IHBhc2lkIHRhYmxlIGVudHJ5WzJdOiAweDAwMDAwMDAwMDAwMDAwMDANCj4+IFsgIDQ0Mi4y
NjY5NjldIERNQVI6IHBhc2lkIHRhYmxlIGVudHJ5WzNdOiAweDAwMDAwMDAwMDAwMDAwMDANCj4+
IFsgIDQ0Mi4yNzM3MzNdIERNQVI6IHBhc2lkIHRhYmxlIGVudHJ5WzRdOiAweDAwMDAwMDAwMDAw
MDAwMDANCj4+IFsgIDQ0Mi4yODA0NzldIERNQVI6IHBhc2lkIHRhYmxlIGVudHJ5WzVdOiAweDAw
MDAwMDAwMDAwMDAwMDANCj4+IFsgIDQ0Mi4yODcyMzRdIERNQVI6IHBhc2lkIHRhYmxlIGVudHJ5
WzZdOiAweDAwMDAwMDAwMDAwMDAwMDANCj4+IFsgIDQ0Mi4yOTM5ODldIERNQVI6IHBhc2lkIHRh
YmxlIGVudHJ5WzddOiAweDAwMDAwMDAwMDAwMDAwMDANCj4+IFsgIDQ0Mi4zMDA3NDJdIERNQVI6
IFBURSBub3QgcHJlc2VudCBhdCBsZXZlbCAyDQo+Pg0KPj4gRml4IGl0IGJ5IGNoZWNraW5nIHBy
ZXNlbnQgYml0IGluIGFsbCBlbnRyaWVzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9u
ZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+DQo+SXQgc2VlbXMgdGhhdCB3ZSBz
dGlsbCBuZWVkIGEgRml4ZXMgdGFnIGhlcmUuDQoNCk9LLCB3aWxsIGFkZC4NCg0KPg0KPj4gLS0t
DQo+PiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDMxICsrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEx
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4+IGluZGV4IGE1NjRlZWFmMjM3
NS4uODI4OGIwZWU3YTYxIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5jDQo+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4+IEBAIC03MzMsMTIg
KzczMywxNyBAQCB2b2lkIGRtYXJfZmF1bHRfZHVtcF9wdGVzKHN0cnVjdCBpbnRlbF9pb21tdQ0K
Pippb21tdSwgdTE2IHNvdXJjZV9pZCwNCj4+ICAgCXU4IGRldmZuID0gc291cmNlX2lkICYgMHhm
ZjsNCj4+ICAgCXU4IGJ1cyA9IHNvdXJjZV9pZCA+PiA4Ow0KPj4gICAJc3RydWN0IGRtYV9wdGUg
KnBndGFibGU7DQo+PiArCXU2NCBlbnRyeTsNCj4+DQo+PiAgIAlwcl9pbmZvKCJEdW1wICVzIHRh
YmxlIGVudHJpZXMgZm9yIElPVkEgMHglbGx4XG4iLCBpb21tdS0+bmFtZSwgYWRkcik7DQo+Pg0K
Pj4gICAJLyogcm9vdCBlbnRyeSBkdW1wICovDQo+PiAgIAlydF9lbnRyeSA9ICZpb21tdS0+cm9v
dF9lbnRyeVtidXNdOw0KPj4gLQlpZiAoIXJ0X2VudHJ5KSB7DQo+PiArCWVudHJ5ID0gcnRfZW50
cnktPmxvOw0KPj4gKwlpZiAoc21fc3VwcG9ydGVkKGlvbW11KSAmJiBkZXZmbiA+PSAweDgwKQ0K
Pj4gKwkJZW50cnkgPSBydF9lbnRyeS0+aGk7DQo+PiArDQo+PiArCWlmICghKGVudHJ5ICYgMSkp
IHsNCj4+ICAgCQlwcl9pbmZvKCJyb290IHRhYmxlIGVudHJ5IGlzIG5vdCBwcmVzZW50XG4iKTsN
Cj4+ICAgCQlyZXR1cm47DQo+PiAgIAl9DQo+PiBAQCAtNzY2LDI4ICs3NzEsMzIgQEAgdm9pZCBk
bWFyX2ZhdWx0X2R1bXBfcHRlcyhzdHJ1Y3QgaW50ZWxfaW9tbXUNCj4qaW9tbXUsIHUxNiBzb3Vy
Y2VfaWQsDQo+PiAgIAkJZ290byBwZ3RhYmxlX3dhbGs7DQo+PiAgIAl9DQo+Pg0KPj4gKwkvKiBG
b3IgcmVxdWVzdC13aXRob3V0LXBhc2lkLCBnZXQgdGhlIHBhc2lkIGZyb20gY29udGV4dCBlbnRy
eSAqLw0KPj4gKwlpZiAocGFzaWQgPT0gSU9NTVVfUEFTSURfSU5WQUxJRCkNCj4+ICsJCXBhc2lk
ID0gSU9NTVVfTk9fUEFTSUQ7DQo+PiArDQo+PiAgIAkvKiBnZXQgdGhlIHBvaW50ZXIgdG8gcGFz
aWQgZGlyZWN0b3J5IGVudHJ5ICovDQo+PiAgIAlkaXIgPSBwaHlzX3RvX3ZpcnQoY3R4X2VudHJ5
LT5sbyAmIFZURF9QQUdFX01BU0spOw0KPg0KPklzIGFib3ZlIGNvZGUgY29ycmVjdCBpbiB0aGUg
c2NhbGFibGUgbW9kZT8NCg0KSSBkaWRuJ3QgZmluZCBpc3N1ZSwgY291bGQgeW91IHNob3cgc29t
ZSBsaWdodD8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPj4gLQlpZiAoIWRpcikgew0KPj4g
KwlkaXJfaW5kZXggPSBwYXNpZCA+PiBQQVNJRF9QREVfU0hJRlQ7DQo+PiArCXBkZSA9ICZkaXJb
ZGlyX2luZGV4XTsNCj4+ICsNCj4+ICsJaWYgKCFwYXNpZF9wZGVfaXNfcHJlc2VudChwZGUpKSB7
DQo+PiAgIAkJcHJfaW5mbygicGFzaWQgZGlyZWN0b3J5IGVudHJ5IGlzIG5vdCBwcmVzZW50XG4i
KTsNCj4+ICAgCQlyZXR1cm47DQo+PiAgIAl9DQo+PiAtCS8qIEZvciByZXF1ZXN0LXdpdGhvdXQt
cGFzaWQsIGdldCB0aGUgcGFzaWQgZnJvbSBjb250ZXh0IGVudHJ5ICovDQo+PiAtCWlmIChpbnRl
bF9pb21tdV9zbSAmJiBwYXNpZCA9PSBJT01NVV9QQVNJRF9JTlZBTElEKQ0KPj4gLQkJcGFzaWQg
PSBJT01NVV9OT19QQVNJRDsNCj4+DQo+PiAtCWRpcl9pbmRleCA9IHBhc2lkID4+IFBBU0lEX1BE
RV9TSElGVDsNCj4+IC0JcGRlID0gJmRpcltkaXJfaW5kZXhdOw0KPj4gICAJcHJfaW5mbygicGFz
aWQgZGlyIGVudHJ5OiAweCUwMTZsbHhcbiIsIHBkZS0+dmFsKTsNCj4+DQo+PiAgIAkvKiBnZXQg
dGhlIHBvaW50ZXIgdG8gdGhlIHBhc2lkIHRhYmxlIGVudHJ5ICovDQo+PiAtCWVudHJpZXMgPSBn
ZXRfcGFzaWRfdGFibGVfZnJvbV9wZGUocGRlKTsNCj4+IC0JaWYgKCFlbnRyaWVzKSB7DQo+PiAr
CWVudHJpZXMgPSBwaHlzX3RvX3ZpcnQoUkVBRF9PTkNFKHBkZS0+dmFsKSAmIFBERV9QRk5fTUFT
Syk7DQo+PiArCWluZGV4ID0gcGFzaWQgJiBQQVNJRF9QVEVfTUFTSzsNCj4+ICsJcHRlID0gJmVu
dHJpZXNbaW5kZXhdOw0KPj4gKw0KPj4gKwlpZiAoIXBhc2lkX3B0ZV9pc19wcmVzZW50KHB0ZSkp
IHsNCj4+ICAgCQlwcl9pbmZvKCJwYXNpZCB0YWJsZSBlbnRyeSBpcyBub3QgcHJlc2VudFxuIik7
DQo+PiAgIAkJcmV0dXJuOw0KPj4gICAJfQ0KPj4gLQlpbmRleCA9IHBhc2lkICYgUEFTSURfUFRF
X01BU0s7DQo+PiAtCXB0ZSA9ICZlbnRyaWVzW2luZGV4XTsNCj4+ICsNCj4+ICAgCWZvciAoaSA9
IDA7IGkgPCBBUlJBWV9TSVpFKHB0ZS0+dmFsKTsgaSsrKQ0KPj4gICAJCXByX2luZm8oInBhc2lk
IHRhYmxlIGVudHJ5WyVkXTogMHglMDE2bGx4XG4iLCBpLCBwdGUtPnZhbFtpXSk7DQo+Pg0KPg0K
PlRoYW5rcywNCj5iYW9sdQ0K
