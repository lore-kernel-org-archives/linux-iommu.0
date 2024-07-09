Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959613C699
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508344; cv=fail; b=bs6EWMgQKiUfUtx1/68Br0YAqAPJzUNAKSEBq1BCv1K8uAurfcpCrXbQlCBCabAZrZrdo1qRndRMgz+MMR5DDBHc3ePitesLTSA11EQZRcbhgkkjjdFHHOJeLX5jm67HyyevkDxS8zLJhF0uqPegZemoAdLNbdMUuKEsnXO8aeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508344; c=relaxed/simple;
	bh=t7fC++hF14bB/kPQTmudEqjWPRN1azvnmZ5vauS1JBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H1tQiBAEHQBhq202THKOqBMuuhEMQwrNFfPWMqTpoUdnKvmOAAGGzgzrulDEXMJDeyG+3+KOW44w9R4OmYQl4D7H15JjaUKQBa/T1wgh0+x2TaNEVMxtE19kTiuSFoqXHrtVPHOuwsXS/XbwV/xDPQv5dtz/FJl60G5BzHvb7bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHCAj9Ew; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHCAj9Ew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720508342; x=1752044342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t7fC++hF14bB/kPQTmudEqjWPRN1azvnmZ5vauS1JBE=;
  b=AHCAj9EwpQ2M0Z4SyM/SWBzRo5m+H3DxAAlYZctfv+T8oBk2lPJ9DdCa
   qokvmkDWRhWcIR/MKliV4WcoYFX4odQppSgC5Gx3F/wTQVs5rCB642Kk1
   IdsPM+KVInO6/l7/3scmIx51m9BuQ0GPoFWJqYMg2jOp5cIEgtZMmpG9Q
   9n3i5GALfxvQqeObvFh+f4nsJtf8RXmMv0qr7IxkDhvSSPAS1nTWBDUJt
   7tog9ZTNf+u+j9BBgFyEPuC/n/d08jkFC6NGOzDPTJ2qA6hKGKc0p+FTU
   SogavZmAJmzbCXg7jl/Xy2demIIUTBKj7vlt+w42VXxIMASQf/VtC/i7P
   g==;
X-CSE-ConnectionGUID: IyLgWTrtSiOrF73lZ/aYWQ==
X-CSE-MsgGUID: mtsAOK8WTzOMMBzQ+w96mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28346187"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="28346187"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 23:59:02 -0700
X-CSE-ConnectionGUID: 9byYS8y/SJi/gYJ+XWYVYQ==
X-CSE-MsgGUID: VtbNWz6MQDuA1PoU+4mghw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="47730561"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 23:58:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:58:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 23:58:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 23:58:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWsQBoKoOXc1S6YgUJk5PY4AGwXfEfSKGwgt20ROFlua9C+90qXWqq5YUpMOU1D9f4U6BH+h0/BaTiussdXT125mBzyJ0iZknrkRCVQl2veGchCq6NHbKwhXaT5xwgHIRf+ajsGg2i+KxnMpM+GSytHB/a7PJTqN+oWu4fkBAsNxcFrzheHbO2qS3zwU77sVGqrSiLa7pf4noO4B+NxCp/ZRRezgN1XEeBKiaKFQpvF5MynSiFiQvkHC873TURyWoWMaEyXEUt5yID/exeNaqa0YK7vBvrRmuQNaR79yhd6JhCZDyoNEefHBe9qZNoo4b/b5fHI2AJR4R9H6lnfGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7fC++hF14bB/kPQTmudEqjWPRN1azvnmZ5vauS1JBE=;
 b=GUT5ar0ehcWcRMFqTSSJgJBTbk3nAaQjhtdxxw/wTNFJEpFIdymkQoUT9vx4YlespcaqgdR1xAKpQGVzgNYmrE/s9q7EInA6Uosc0WlU+Lvj9Up94si6nNDMmdTSeAGrVm3nN29F8LjqY13otm892dFmyNqwQZU/CWlj7iRq4r2XNd6AXV82sVFUv/ShCalyavHhjXDRIGo7cAYYxh2Ap/Gy/OZyrjs0CVFn5HMnwtW4iK7x0U5rZv9u/N13ejaIjZ7Yrt5WEWlnrZ5F+XDH50UH/muOyU7ndfEauxe1rurmJ1INL9Ic+fY7or+T/wN/9Hx1/k19sPQiVcC7TxQn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 06:58:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 06:58:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Louis Maliyam
	<louispm@google.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix aligned pages in
 calculate_psi_aligned_address()
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix aligned pages in
 calculate_psi_aligned_address()
Thread-Index: AQHa0TDPCiU670xksUKJutXGN3QTxbHttBOAgABEMfA=
Date: Tue, 9 Jul 2024 06:58:50 +0000
Message-ID: <BN9PR11MB527613512AB7E8D3B4B8FEBD8CDB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240708121417.18705-1-baolu.lu@linux.intel.com>
 <66e0f183-83ca-428d-af53-0fac69af7d42@linux.intel.com>
In-Reply-To: <66e0f183-83ca-428d-af53-0fac69af7d42@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4872:EE_
x-ms-office365-filtering-correlation-id: 7efa288d-7f1e-4cac-19f4-08dc9fe4964d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UkEyNUJTOXpyMWw1L3RkYjdqTFVscmQ0NzhjSUo1VEwwZWVWUm5PZ3htUk1q?=
 =?utf-8?B?Tmp1ZTBFQjl5Mk5zcDlYODl4YzRDN0N0ZG9GVDlFRWNIbjlDcHZkTnp3MlFy?=
 =?utf-8?B?c0lkc0MyS1VMQzRSME4xZjhJZ0ZMcWEwSC9IN2N3K2F2cFFhTlVLMC9pQkFi?=
 =?utf-8?B?QzliYVJZVVpiN0lYTWFPbVVpZGpNc3NoYXBRYlhzTUlGZTNnR2NHSENyTVNQ?=
 =?utf-8?B?akhxMU5qM3ppZXFYMUtaZ21HZEI2SEk5RDhNTm1UNjJyZE5QeTNucnNDYlJl?=
 =?utf-8?B?MjhMRS80cmxMc3RYZGpoN09VdzdLTkg0bmMveGoxZWhkVVF5OHBNeWtUSFFB?=
 =?utf-8?B?RnRremRDTDMvRFZGN2FKb0owL3dRQXZvSWdBZVJCbzdudnhGU1JZbEVMQWY3?=
 =?utf-8?B?Y0tGZ1JrSVErUzNqcC9NSjNPWHp5K0piZ1R1andVczFLUE90T09QN0UxeGhV?=
 =?utf-8?B?TTVaSUwra1JrdzdhU1k4aFZmZXpuZ1JMenFSYUIvMDRsQ3ZoRW0vRENJa3BZ?=
 =?utf-8?B?U2NReE9Cc2xSUUJzVEV4WWFKa2F3Z2FhaUd4Uk12WFRENDZ0WlRpeFQ2ZTU5?=
 =?utf-8?B?SlMwMkpKcUhFTDRYSEdSWVF0bXFTdHFzN2doai9sZUxWM0dxd0pKUDVocE9O?=
 =?utf-8?B?bHlTMStSamJaRTdlbVA2RmtEZ2tpTW9hUERPcXVhWXBsQXVKRm5YSUs2VkFj?=
 =?utf-8?B?R21nNzJtVkdncVBvaDh5eEdOeWM1OHorekZ2aTgvT1ozRkpiUXowamg4VjBH?=
 =?utf-8?B?OXVZdkFyS2ZDU3JjYVZKcHYzQW1za1dSNGpjM0Z0Vm4rNmJEUnh2d3pzL3FF?=
 =?utf-8?B?VGdiRitZSVV3bU0wUGNybU45VTNZK2prWWFJelJzQUlUSnI2bVUzOXA0SjBr?=
 =?utf-8?B?RmllT2R0M3pMMG9KdnI5aVJrUG1pMVpJclA2Sk5VZ1BhbHVWUGJhSlNDSDJ5?=
 =?utf-8?B?bDJOY3ZsbGdER29RaFZGM25mdHFKRnczTWVDT1AxTC84TlNNZHMya0xiTU40?=
 =?utf-8?B?bnFSRkNBN1RLQ2VRa09UL0xxbWdDck9zanN1eGtUNlNFMkZjSGJ0M3E5OVhB?=
 =?utf-8?B?TGcrR1VlNHU1d0xMZmhjbytuSWg4UXlSalVLb2VucnZSckdsWHl4RnpRTWJJ?=
 =?utf-8?B?Z0wycEN4dTErYjNDWGFuM3NKL0JNLzFHVEVPODlzb1Mrd2FvbVhtQ2ZQZjZk?=
 =?utf-8?B?VGlmZ3N3Y3VncmJndkZjYWVwM0k3WHpqNnNDQ21LbDZTN01tWlp1d0h1N2J2?=
 =?utf-8?B?eEdxVkdJSTJCQUlHKzVpOE5UdmZSc2wrMmVMYTdzS1lhWVZqTHRjZVNsQUVX?=
 =?utf-8?B?UGdXbnUyeTU1STE4SS9CSlJ1MExTQmN4ZTUrbGZVclBPNStUcWUzZmJGaXRa?=
 =?utf-8?B?d1JXS2Z1TWoxY2dwTmZYMDZTUXhMVUhKV3czWmZIUW9YWWJTcFdKMWpjYkps?=
 =?utf-8?B?dmxWaTFLSUJvZ0V3M0lkZ0JvbWlHMi9Kb293Z09JbWhVNUxHc1VnY3NoNDVC?=
 =?utf-8?B?dWpTVUI5bWY4c0VrNUwxaGZWc3E3Y0pmQTVUTnF0SnFpL1lZYTlRMTlMQVRy?=
 =?utf-8?B?L1ZjK3ZSMWZ3Q1R3U2ZjK2Q2bDk4K1A5L2VlaGs0eEQwRVhzRjBIcGVBeEJu?=
 =?utf-8?B?NWd3U1lRY1A1YytYcFdBOXBnczNtRUhSN3hkM2JkdHBORTRLS1BkM3N4bElx?=
 =?utf-8?B?WU85M04zc2Z3RjljSHRNZWtoTjFQMVlyQ2JTaDBOd1gvcTYzRm1BRlV5aC9B?=
 =?utf-8?B?ZlM1TU44cTI0ZHpERk1lNGg4dWNNOTlUM25sN21RNnlpQkk2SzZmN2pRa2Ro?=
 =?utf-8?B?dUNCa1ZQRmdvUk5VRHpWM0dXWUZwQmVwK0x3RzFDdHJtcjF2ckpOV1czSnU0?=
 =?utf-8?B?OWVFc2U0MGpiMVBMREZrYlNMNWF6Vml2V3JUR0M1QTJpOEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekpwdDU2a1l6OGk5eDdJYVovSnJvbUk0d1oxeDFLM1NiNTNmYlVnNk03c3Js?=
 =?utf-8?B?SktBckY1K3NCSWdzVGR4dHI5VGRFY0hNOVY0ZXJPK3l3OXZOU3ZhNDBsbW5O?=
 =?utf-8?B?azJydmdZSUVybThibWluZ0FDZGRPY1hNRkVwaEV2WlZTblZJMDFGcUJPVEVH?=
 =?utf-8?B?M2FFaTVWK3FuS2h4T0Q0QnN2STVyMUlJVFN4ekY5RUcva1FJczNNbUNvUGUy?=
 =?utf-8?B?NkJUdzg1NmQyQXpoZUk3Q2loajVpRFBDVGphVUlYQVpmYXpRL25oaitaT3Az?=
 =?utf-8?B?MFhOeWZkcXFkOEc2RW1vaXZENVZkaEpwb3UvblNiSVZyLzZaSjVvT3BnNmhF?=
 =?utf-8?B?eUxZRE8wMm4xTXErd1ZhMWVKK0t0aXQ5aEtjUmpwTHN2bU9BTkJuRjZyOW1H?=
 =?utf-8?B?RWVteThVZFBFSDFncWpQdmVzZTBmbTdacmQ0QU1tenp2M2Y0OVVKSDFuYXp2?=
 =?utf-8?B?VnVBWkl0MWY0MHVXVmZvWVlacm1qUWRKRUV0MXBLdzc4di9LWWFFSGp2N0pq?=
 =?utf-8?B?NDdhYU1tMitTSklOcHNiVGFnZ2VhSmtnUlJ2SFpadTMwOHN4ckVXdFhSU1Q0?=
 =?utf-8?B?YW9Mc2szcVhWNDBKM3NkZ1ZOcDdSZzBnRHEyVGFmdGZYZkJZc2VGMm00bG1l?=
 =?utf-8?B?SDdKc2hKbXpibFhHckQyM1RpRFNXbjFUaUJMd3BvOWFuVWlFdTJuVUlMSTBK?=
 =?utf-8?B?N3lxa3djNHcwK3d0eWczbGxXeEdxUVpDN29lNm9sV0JudzlQMEJjM1hDZjV2?=
 =?utf-8?B?SXJ4R0NtK3ViY1ZsNjRVNzN0cmdjTFZMQXRDcXpzRHhGc1E0WFhndGI3QWdC?=
 =?utf-8?B?cUxTbmNSMzJXM3VYL09RdnlOWE9waTl2T0wxVlB6V0N2T1MvdXZXeCtCakJj?=
 =?utf-8?B?Uk12MndkWUp6Q3JKYjhhblJqWUxnaWdDdjByU05TUlM0RithbTlZQnRoYmJZ?=
 =?utf-8?B?b210aytpMG1MbVlod3FJM3BKMUJ6YUlRY0loMm1DejJqQllOaDdmbzRRZ056?=
 =?utf-8?B?WndNSFlxdVZ1S1VnZ0o1TXFSK0paM2xrNjg3SmNqSGlacFU0Uk1KbGxhbmxT?=
 =?utf-8?B?aGV0djhnNVJzbytGd2RCT1RzMnhSZ3BwSGJ3Ukoxclc3V3JyaWcrZnY3MVRx?=
 =?utf-8?B?ZmZ5SmIrRlBjT1RKRDJqa2hlWmIydjJubDVOVEJJc2N2TXlXdnhFS2phNmdY?=
 =?utf-8?B?NXd4d09XRy9QbFV2SitzUExqcFZ1K0NoTGRaTHQxUnFuWTJLYmRNVUR1a2VD?=
 =?utf-8?B?WFA2V3dSQnVDTHp4SFVQeFcveGhHdkdwQXQvZnZtUENIQkoyUnhyY2tYVGcv?=
 =?utf-8?B?OHY3QUh5Zk9oMDk0TndzNytwSzVncnJyU1NEVmhFTkdnL0kwQXdPTlkxNmh1?=
 =?utf-8?B?RzhydkxHL2NGZnpUTS8wZFFCWldOVnJ0OFBGVnZYVDBEVWR3SjJYSnlnSlc3?=
 =?utf-8?B?bm0vYXd6MXF0YnNrUEhRVFBBNC9ldUN6akt2eFhzOGs2NStxS2c1bUJ5ZjhQ?=
 =?utf-8?B?RUtrRnprT1RoTG5UNWJSNWFJRzI5OFczUkttcFVxcW1hUS81MDJHQy9zZ3Fk?=
 =?utf-8?B?N3RYYWY1VmM2YzRWNG0rYzdlZ3c1QnRGVUlDUG1oRlE4RG0rRGhCalg0OW5p?=
 =?utf-8?B?d2lFUVU5RzJxYm56VEt5QytpdFNWYVdxaGw2cm5VUGwyalRIZEN1c1V2c3Bk?=
 =?utf-8?B?ZHhKWUx5cC9qbzE2ZmFkRWhSZkRIZXpiMHVvU21meWZJd042cGs0OUdzWmNH?=
 =?utf-8?B?V2RuU3R4b3hUZVJOR2ltY2d2d2JYSzVBS2NtWnBWWTMvS1Yrekd4WTJoYWJV?=
 =?utf-8?B?R2NCSXh2aVBmWGZ1dndwakJhaVViVmlGRExGVy9sOWJCNmxlNE5sc2l5M2ZY?=
 =?utf-8?B?NFdRTGl6Y0dSdEdram9VUkFIU1RYdEE4c1luZDBkMnhiL3dEU2VRZXlXV2VS?=
 =?utf-8?B?TStYY2FqQjNNNGE4MnNMMitNUnJmTnE3OXJnMnNyN1lKelkrUklYRVRqWmR1?=
 =?utf-8?B?RDErdGdpaU12ZFc5eXB4U1psQ3FBdHVIOHcweEUrYWlKT1NEdEJMZ3VCWUdD?=
 =?utf-8?B?aUl6WDhKUm5oSGJNazkwa01Ec1hHZExqWVFVQ2RzSW9ZaVF3bVRjMHNVcFcx?=
 =?utf-8?Q?g2d9+AS/HINSm5JvAuzLD/UcK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7efa288d-7f1e-4cac-19f4-08dc9fe4964d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:58:50.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjsU2n+b0lWZQMFtdHFqoaAVXMlfxzo8v0MZpyX4KwcXAoyvVINj8A4voa287FqHV31LlQKRIBfV14KmYpypvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4872
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdWx5IDksIDIwMjQgMTA6NTQgQU0NCj4gDQo+IE9uIDcvOC8yNCA4OjE0IFBNLCBMdSBC
YW9sdSB3cm90ZToNCj4gPiBUaGUgaGVscGVyIGNhbGN1bGF0ZV9wc2lfYWxpZ25lZF9hZGRyZXNz
KCkgaXMgdXNlZCB0byBjb252ZXJ0IGFuIGFyYml0cmFyeQ0KPiA+IHJhbmdlIGludG8gYSBzaXpl
LWFsaWduZWQgb25lLg0KPiA+DQo+ID4gVGhlIGFsaWduZWRfcGFnZXMgdmFyaWFibGUgaXMgY2Fs
Y3VsYXRlZCBmcm9tIGlucHV0IHN0YXJ0IGFuZCBlbmQsIGJ1dCBpcw0KPiA+IG5vdCBhZGp1c3Rl
ZCB3aGVuIHRoZSBzdGFydCBwZm4gaXMgbm90IGFsaWduZWQgYW5kIHRoZSBtYXNrIGlzIGFkanVz
dGVkLA0KPiA+IHdoaWNoIHJlc3VsdHMgaW4gYW4gaW5jb3JyZWN0IG51bWJlciBvZiBwYWdlcyBy
ZXR1cm5lZC4NCj4gPg0KPiA+IFRoZSBudW1iZXIgb2YgcGFnZXMgaXMgdXNlZCBieSBxaV9mbHVz
aF9waW90bGIoKSB0byBmbHVzaCBjYWNoZXMgZm9yIHRoZQ0KPiA+IGZpcnN0LXN0YWdlIHRyYW5z
bGF0aW9uLiBXaXRoIHRoZSB3cm9uZyBudW1iZXIgb2YgcGFnZXMsIHRoZSBjYWNoZSBpcyBub3QN
Cj4gPiBzeW5jaHJvbml6ZWQsIGxlYWRpbmcgdG8gaW5jb25zaXN0ZW5jaWVzIGluIHNvbWUgY2Fz
ZXMuDQo+ID4NCj4gPiBGaXhlczogYzRkMjdmZmFhOGViICgiaW9tbXUvdnQtZDogQWRkIGNhY2hl
IHRhZyBpbnZhbGlkYXRpb24gaGVscGVycyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHU8
YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9p
bnRlbC9jYWNoZS5jIHwgMSArDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMgYi9kcml2
ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMNCj4gPiBpbmRleCBlODQxOGNkZDgzMzEuLjExMzgzNDc0
MjEwNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMNCj4gPiBAQCAtMjQ2LDYgKzI0Niw3IEBA
IHN0YXRpYyB1bnNpZ25lZCBsb25nDQo+IGNhbGN1bGF0ZV9wc2lfYWxpZ25lZF9hZGRyZXNzKHVu
c2lnbmVkIGxvbmcgc3RhcnQsDQo+ID4gICAJCSAqLw0KPiA+ICAgCQlzaGFyZWRfYml0cyA9IH4o
cGZuIF4gZW5kX3BmbikgJiB+Yml0bWFzazsNCj4gPiAgIAkJbWFzayA9IHNoYXJlZF9iaXRzID8g
X19mZnMoc2hhcmVkX2JpdHMpIDogQklUU19QRVJfTE9ORzsNCj4gPiArCQlhbGlnbmVkX3BhZ2Vz
ID0gMVVMIDw8IG1hc2s7DQo+IA0KPiBIbW0sIGl0IGFwcGVhcnMgdGhhdCBpZiBtYXNrIGlzIGVx
dWFsIHRvIEJJVFNfUEVSX0xPTkcgKHdoaWNoIGlzDQo+IHR5cGljYWxseSA2NCksIHRoZSBsZWZ0
IHNoaWZ0IG9wZXJhdGlvbiB3aWxsIG92ZXJmbG93Lg0KPiANCj4gU28gcGVyaGFwcyB3ZSBuZWVk
IGFub3RoZXIgbGluZSBvZiBjaGFuZ2U6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9pbnRlbC9jYWNoZS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jDQo+IGluZGV4IDEx
MzgzNDc0MjEwNy4uNDRlOTI2MzhjMGNkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lu
dGVsL2NhY2hlLmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9jYWNoZS5jDQo+IEBAIC0y
NDUsNyArMjQ1LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcNCj4gY2FsY3VsYXRlX3BzaV9hbGln
bmVkX2FkZHJlc3ModW5zaWduZWQgbG9uZyBzdGFydCwNCj4gICAgICAgICAgICAgICAgICAgKiBz
aGFyZWRfYml0cyBhcmUgYWxsIGVxdWFsIGluIGJvdGggcGZuIGFuZCBlbmRfcGZuLg0KPiAgICAg
ICAgICAgICAgICAgICAqLw0KPiAgICAgICAgICAgICAgICAgIHNoYXJlZF9iaXRzID0gfihwZm4g
XiBlbmRfcGZuKSAmIH5iaXRtYXNrOw0KPiAtICAgICAgICAgICAgICAgbWFzayA9IHNoYXJlZF9i
aXRzID8gX19mZnMoc2hhcmVkX2JpdHMpIDogQklUU19QRVJfTE9ORzsNCj4gKyAgICAgICAgICAg
ICAgIG1hc2sgPSBzaGFyZWRfYml0cyA/IF9fZmZzKHNoYXJlZF9iaXRzKSA6DQo+IE1BWF9BR0FX
X1BGTl9XSURUSDsNCj4gICAgICAgICAgICAgICAgICBhbGlnbmVkX3BhZ2VzID0gMVVMIDw8IG1h
c2s7DQo+ICAgICAgICAgIH0NCj4gDQo+IEkgd2lsbCBtYWtlIGFib3ZlIGFub3RoZXIgZml4IGFz
IGl0IGFscmVhZHkgY2F1c2VzIG92ZXJmbG93IGluIGFub3RoZXINCj4gcGF0aC4NCj4gDQo+IEtl
dmluLCBzb3VuZCBnb29kIHRvIHlvdT8NCj4gDQoNCnllcy4gZm9yIGJvdGg6DQoNClJldmlld2Vk
LWJ5OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCg==
