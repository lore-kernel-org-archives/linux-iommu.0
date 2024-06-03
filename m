Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E147A57
	for <iommu@lists.linux.dev>; Mon,  3 Jun 2024 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400279; cv=fail; b=EHMXLdH8D+fJH3QJ9Qzzy5NQwbzISDydHy8EJ6J9N6bdMnLCtzMotULA66dp3Jvw2luiziPeUYKHcLEUi7Qym0lAdwa6k+UmiCzDN5qk330HWqsKKIOIXiJtBqLrIGvrhXC2oJfkgFrhNnlFLJcXSIYlbZBLdpfLG42EFSOnCBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400279; c=relaxed/simple;
	bh=tpwKk+bzUUPQMECjDym0nn/oz6odeKxw+Bm9YondGNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dztKcYLFNNkhF5TY3wiJyikCTqPPmPEInXva1D202KeAP9IE+2cJCbw36DEXMu6+Pe70uc7deemKTD19OIZvL5x1w3minQOK5BVRi4fFlED3FXSg0advM9oWEM1KNKtxYTwKkR6Ndmd0Qa+6RKsU9SXxz6XTymGTegbqN3HkAfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwTEprX+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwTEprX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717400277; x=1748936277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tpwKk+bzUUPQMECjDym0nn/oz6odeKxw+Bm9YondGNk=;
  b=iwTEprX+zDwrvH3PGr5c4VYRYC52ogvFJmavV68QZ8VjIdDSO71OrVog
   hTpQzymY3/7hjnT1QNGk8R2uTMIPKjY+F/POgpUSLixhYapxV7HW77Lav
   +sef6d7nzZqq1IwEx3XfMWVuJ/MhZ00K5a8r2AUv0hNmm6A2tnbQbXapd
   c3ZlXDfrHQ9+WZL1QFk1SrNOeFUs94xSKnzcmmslT5kKYy27qJFgKxrB2
   3aFhSfateG6e0GyWoRdxXRCuQHaZfcXDqxACZf4XLp6NRDz0nZRUJff4t
   WeCqXP3MSzkkrVnLf6WF5hhoJ3swTNEfWX233U7fcTdGdBHEVzRBckQ+A
   w==;
X-CSE-ConnectionGUID: 8h9OwlwESPSQ+/TMJqrdxg==
X-CSE-MsgGUID: kQO7RCvORJW3rYDbJzYEpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14002012"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="14002012"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:37:57 -0700
X-CSE-ConnectionGUID: 8KdTolNMTh6Ze3Q12PQQOg==
X-CSE-MsgGUID: y7x54LzfQ9SQaNoEVjeDdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="37393548"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 00:37:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 00:37:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 00:37:56 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 00:37:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE5aJX9T7Ziku4f3kiuDxw0ykWTyHn48sXCVnF/W9aY0gdTVKWpqQOelsT4bSAqgcuDMcpljdPk2bCGUuROPz+aSToVTJFX8r/s5GwFRaZdkO+yn3gRs2ArpvENyLz2S0b9GszcSi8jaYGxQFkEyxV70lLXjVvxZy54QaWC3m7V7SR0lfX3SRKl9C9sUOj4DG8zth4UtRIs5V47k5CrI1BIHn0GTV9/FJPuxJ2EA8cCqgme712HSySKKjh7JCqfnjn83Q48y6mMh1v7790kbHgoGtTJS4GdaDqH27fq9bNVS75t+aY6goaLQzxxznl2IwIsSH2s1Bh25MAxqSSpvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpwKk+bzUUPQMECjDym0nn/oz6odeKxw+Bm9YondGNk=;
 b=XyRD3q9JhsTnXestnfO/815krihrFz4LEAD/94hCY4v9LCzwfi78MYNC8dK5Ay0v/eOuvAEC5tzEytXTBRwJNaP+g2KgP+IKQf3D83wUbws2jEESlF9IZWx+o2mskWgNpEoSQC6MggPbfI0n5vF/8d6N46Tvl+gAHl1V+o+MbYh3qV/Sthl/uRJcCO8pbECAykUHkHg8l7J5j67xBeQq8xCsVzu12aQcjfsuhgUkxnedOZSN0Lyuv/0Ux9WUFTbtjeMDhHoEboq394DmEe8L72x7ix0twH3oel/ycslqCOHwxMqt47GwluBjwDbnxv0PypPZuV+UF2wURpeTdPL9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by IA0PR11MB7379.namprd11.prod.outlook.com (2603:10b6:208:431::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 3 Jun
 2024 07:37:40 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf%5]) with mapi id 15.20.7611.025; Mon, 3 Jun 2024
 07:37:39 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
 invalidation commands
Thread-Topic: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
 invalidation commands
Thread-Index: AQHap/JyA+quh6RCVk2aSVRG2G8N3LGeUfAAgBdsvIA=
Date: Mon, 3 Jun 2024 07:37:39 +0000
Message-ID: <MW5PR11MB588165376224FEA74A0426D989FF2@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240517003728.251115-1-tina.zhang@intel.com>
 <20240517003728.251115-2-tina.zhang@intel.com>
 <2b390228-190c-4508-b98f-1811c54c9e5c@linux.intel.com>
In-Reply-To: <2b390228-190c-4508-b98f-1811c54c9e5c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|IA0PR11MB7379:EE_
x-ms-office365-filtering-correlation-id: 26d7b0e5-432e-4ac5-ff51-08dc83a00bfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?L2ZpZjFBYWFTK3hLYVVEOEVlcEJyTlQrNWdLVlIrYTg2QUFLcCtua0VwT010?=
 =?utf-8?B?Njd0Y1JodDc4WHFraVlZbEdKd0lTMy9KQmY1cmJoczRGYVp2TkVMd1UzdE1Q?=
 =?utf-8?B?S0p6dkNQcGRLeUdHMVByTzR2SVlBYjdzcm1vVGxoZFE4UGlxTGZWY05lczEr?=
 =?utf-8?B?L2tiM2pMYkhxQnRLV0JnOERON1E4TjlWMTMvV0c0L29uYzN2QjZ1L0sxUk9p?=
 =?utf-8?B?SFYzbEN4OUFWZTdiekdxL1VuUytJRVk5ZnRlclIwVlJQUTN5cjFLbXUyM3F4?=
 =?utf-8?B?Qjd5cXdXWlZxaVRaQkV2R25PODlNMGtKS3FFRUlzWHBYVy9ON2JnSU1WcWVk?=
 =?utf-8?B?S1V2UWV3MjFTdE1tb0dzTXpMdCtpV0NJbHBhSGtlUllKb05BajlZR3hPS0hZ?=
 =?utf-8?B?ZkNIaisvcXpKbWtmWTZEYjk2RGhTd0t5dzNTWURTUlpSWXFNS3V2VkFiWVBa?=
 =?utf-8?B?dUFrNWlFRElxVjZOamxkN054YUpIRUwrY2pOTUNhL3BWV25jazBLVXQxUDdY?=
 =?utf-8?B?SkNQUll2WjYyTDRLM1N5YTRhOUUvb0gvKzZsY0tSSFc5SEt3OUJSUWp4emVa?=
 =?utf-8?B?a1FxQUVMTHlkZVNienVvWXhIQmVob1NwM1IzUzlxTmlkVkVLNDBpaFprQmUr?=
 =?utf-8?B?cVNFRFc4TlMrZEhNWDN5V1dUVzkwcmdwMXEyZUpKYWFOV05xZmsyY2s0VnIr?=
 =?utf-8?B?MHJWdnIrL0pyVkFwM040RzFVZjZHcWNrY0UxUUx3VW42bjV6ZkJZQzJ1ZzlV?=
 =?utf-8?B?dGszR3BGY2hQR2xycGJrM2EvSllWTnhMZWZGRGRHZ2FRVnFmckhSZFJNdmFx?=
 =?utf-8?B?TmZHVDZGZFh3UFFhTFVUNU5XcmJxSTZZZXRsYU5ZWHpMM2tQaE9VLzJ4elhy?=
 =?utf-8?B?T3JzQlhzcDZOVlZGSmEvK215UWZCbzVtQXJTa3ZYamlTMmR1VHBadk93eERa?=
 =?utf-8?B?MGlSOWRaSFQ2NnVzWjBqMk5QYmY1ZEV6S1dmWEEwUjdwbFViM0xPOGN6dll6?=
 =?utf-8?B?YUtyNU5zRGswQ1FJcDFMMlFJb3VhUU1xa2RhckpIUXZJNmtJakVPcTUrakpC?=
 =?utf-8?B?ZTNJMmpkOFNBbk5xZTZraGF4R3lTbWIzZEhQYjFEaDRBTk8xNVpKMEdaODht?=
 =?utf-8?B?WkUwTXpweWpPNlVvak9YVTZRNUFwOXBKUHRVSzIxWTJpb3ViYzZidFp1WWNP?=
 =?utf-8?B?WVVVckFPdXpJOWdsbE9hckxzbkhxTkpRWEtBck9NNU9lODlOUytZcWhlRVFz?=
 =?utf-8?B?TngxWkJKclQyOHQ5c0lvRVJLemphdXJsKyt5YTkxWmNEL29OaS9vWmVvbEZn?=
 =?utf-8?B?K1lYNXZpL0VUakx4cXJScDdCbmZXWElwZTBLVWVHUkM1Zlh1NlFqRjRzekdI?=
 =?utf-8?B?UjlOaWVsZEQ2RU5ZR0taOEVpd2FsS1VhYy9jMVdWQWh5UVZtUzUreUQ5eEdF?=
 =?utf-8?B?WlMvbnY1TmEraG5NSG9aNnovZ3hZZVNwVTdESnpIQnk2N1MzNmU5S1h4MUxX?=
 =?utf-8?B?ZWdKRmVrazhOUDNWUGJaSnJRcS9oWUV2NzNtVkswOGYwcWVOOGdaN01EN2Jz?=
 =?utf-8?B?WXRyQXpxMi8vMERZcGxqMloyQ3cyVGg4bExoU0FRSXdJRlVaRHd6WHhSY3ZL?=
 =?utf-8?B?WEs1MU9mNHBCd0VNSngyWGR4b3lZS3VhL3B6NWZmazEyazE3eUhudGVSVDZT?=
 =?utf-8?B?REF2UDkzZWdPVWRlVnd2dlYwWWlzdzkrS0JvMjZwT2dPcys2N1A0WXhtK0tC?=
 =?utf-8?B?OFFjR3lPLytseXplVFBiZ2Ntc1RleUQ2YmtCNUJLNkdwMzlibnZSZ0dHTnlT?=
 =?utf-8?B?ZjJ1THMxZUE5Y3o4WE1GZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWhrMVJVMU5KNEExc3RHMUYzL0NWSjBuS09OSnZ3ZG5zRnZTMjM5NDZPYldj?=
 =?utf-8?B?d1BZemZLTWVxZ1hrRHFsUURFV3JkQittb0FsK3Mzb1FsN3dVZHRjYTh3MlFZ?=
 =?utf-8?B?dnFwU1BPU2xoRHpOYzhOeERyeld1T1BIVjJsUldCdWc5V1NqdjN5bUFwMVFZ?=
 =?utf-8?B?d2pnYU14S0NJUXlwYXlvcFdLakRJdERncnVqeEZjNi9OT3ZLNDdoMGg1Rjh0?=
 =?utf-8?B?VWJEQS9kSWZjNFEwS0JxODg0VzBXbDZmRzIzK2pLdWtzY2d6WnkrM1RhTFpV?=
 =?utf-8?B?S2k5TE9SRkFheFcxMTlodks2ZElmWGs0cGJSbEpCRnBtODB0bGVCV1hkY2g0?=
 =?utf-8?B?bnh0L2IwR1gwNE92RjU4eTVXVThVWllnbDNBT0VpL1dIcUoyQzZTNERkRHMy?=
 =?utf-8?B?Tk5nQmRVN3BjRmI0UFd4Y3ZuN2lYTkpMelcwTGJpYmRrTCtKT01qQVFKTW0r?=
 =?utf-8?B?MXhZemREcGtnblgzVGNUcjdVS09rWEdNVVZaakRKNy9JcTdNOHVWTlY1VC9u?=
 =?utf-8?B?dVQzR3J4ZDVqeHNyTmdDMDlXaGhxcEZzRlcxZGhsRS9zTWhOMGlNQkJ0dE16?=
 =?utf-8?B?UVp0ZTB1L3JtNjBlYlZkeFFOaCt4MXd3bXNTZEVPUmFnZDdkNzdCaFBvMTlo?=
 =?utf-8?B?SFh3ZXlyeVFBZjJEaVJlR010dmtZVmJ6OEYraFdOTXB1dVA2L1p3T1JlQzdp?=
 =?utf-8?B?aG9VSTFOdXY1c2ZqVmlMVHFCR095SHpqQWM0STdDSGoraVZjbExwRG85di9G?=
 =?utf-8?B?bVV3UkVyOWRTcTR1TXlzMmFkZXNndmlpOEZycTkvOHF2VitQQ3VjNGd2dkpC?=
 =?utf-8?B?L21qSzlUMnU0SjJoZnIwS2Zuck1yRHE1RDE3TW5oUzZLSFZ5eGNoRE9CS1NU?=
 =?utf-8?B?SWZjTWViR204REZFRGJYM1ZURW5Tb0xFMmEwOXQxaExqcVpXeGNyNXJCYWpU?=
 =?utf-8?B?eVJaTkhxVmt3a0MzbFp2WXIzUWsydUdoNkNOck1EaXl4bmJ3YUtSMHhqWEtP?=
 =?utf-8?B?c1AwYWdwS1hSY3BZTnlEMWhUTC8wUnRvdGxRQ2ZSbkpjZi9JQ0lpeFpDUHE5?=
 =?utf-8?B?NDg5U09CdkFkWUx3RUZPZUoyMWJ2RXVwWU5WNTB1QzNMTVd1NjVFdW1yMlVD?=
 =?utf-8?B?U1Y3WWdtVml1UFgwMTdqcVczV2QvR2VNeUFvSDRWZXpiWjBNTXM4MWU0L2or?=
 =?utf-8?B?ejQ5V0ZCS2lwbUl2OXhnYzhub2s1Q21WeHNyMTU1ZitDbXRJREFpMlBLcmpB?=
 =?utf-8?B?QkhkWjJDOXVINkdkYUFtRjQxaGsrUDB2eHp0UWYrU0VZZ2ZCcXpId0dnSU9t?=
 =?utf-8?B?ZU1YZ0hpbERaM05kNHZVdFBFWjVsNXVDYkN3STRQc1dzVVJRUEpCbnhIbmRR?=
 =?utf-8?B?bXZpbUdlQmNFbzRMb1RrUFdObjRidi9ZSXNOdks1ZTUrcHRYUUR6Wi93aUJn?=
 =?utf-8?B?K1ovY0phVTREZEtrVjhKREJQQktxNTVLUlIxY2wrUHVFZU5aeXhLUFVBS3Qv?=
 =?utf-8?B?dEZlNkc0djBBZ0RpTmRuZXluVWRCWHEwaG54UFpJRWxqOEpZTWtCUXJrdXg4?=
 =?utf-8?B?MWRRcXU2aGNYblprMkdBNnhQWmJzWXRad0VkaUN1MUNDU1RHb1kzN3BHUE1I?=
 =?utf-8?B?K3hZVStBbjBvR2lNM3N4eGh3cC9COHArOVR1Q0NxQlB3azk4OC9iTUNwaGE0?=
 =?utf-8?B?alczTGV6S2xuTzY1eVdMR3MxY3RLeUh5eXJWeFVweWdOZ2dsend3T3p4V1I1?=
 =?utf-8?B?UkhZTUIrRTJnSVBna0YwdFhWNXZCSnJmaXFKV0dwMVRLWHM5Mm1hYXlDZGxV?=
 =?utf-8?B?cFRHMENuSmdaYmZzOGhhc0pNTmxxWHpqSmdYZVBhQnZhbTlOM1RDaVhIREFn?=
 =?utf-8?B?cGU1c2N1eURMNkFHcWxsZ05rdEt4MERkVzdvWEhrMUhxRmJaK3ROUDJ5MXNy?=
 =?utf-8?B?MXRQNERaSlZhblZMUWFDbm5TRnZRQ0NLZzBPMmVrakpPcGpaaWpaZG9ucWFC?=
 =?utf-8?B?SGZ6bGVwWVlpdWZUeWpPUGk3SllTV2didHVwMTVmRE5xaXQrSG5kMGlNOWtl?=
 =?utf-8?B?MkFJOTNudVZhWW8vaU5tMjJqYUwrTnBhbzBqcnd4OTY0bzFDc1VuWFd6Z200?=
 =?utf-8?Q?9xfCkLgOzre7ShkSkSF2wsIlr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d7b0e5-432e-4ac5-ff51-08dc83a00bfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 07:37:39.8574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fl15qgMWZjLPqIQOTtTF717uIuCIEtByimZ3HTtzUZKfz2cCjaPnPWhJYnrC+6PAtRaBElGLh6FniNQQ+huwDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7379
X-OriginatorOrg: intel.com

SGkgQmFvbHUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUg
THUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogU3VuZGF5LCBNYXkgMTksIDIw
MjQgNTo0MyBQTQ0KPiBUbzogWmhhbmcsIFRpbmEgPHRpbmEuemhhbmdAaW50ZWwuY29tPjsgVGlh
biwgS2V2aW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0KPiBDYzogYmFvbHUubHVAbGludXguaW50
ZWwuY29tOyBpb21tdUBsaXN0cy5saW51eC5kZXY7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBpb21tdS92dC1kOiBTdXBwb3J0IGJh
dGNoaW5nIElPVExCL2Rldi1JT1RMQg0KPiBpbnZhbGlkYXRpb24gY29tbWFuZHMNCj4gDQo+IE9u
IDUvMTcvMjQgODozNyBBTSwgVGluYSBaaGFuZyB3cm90ZToNCj4gPiBJbnRyb2R1Y2UgYSBuZXcg
cGFyYW1ldGVyIGJhdGNoX2Rlc2MgdG8gdGhlIFFJIGJhc2VkIElPVExCL2Rldi1JT1RMQg0KPiA+
IGludmFsaWRhdGlvbiBvcGVyYXRpb25zIHRvIHN1cHBvcnQgYmF0Y2hpbmcgaW52YWxpZGF0aW9u
IGRlc2NyaXB0b3JzLg0KPiA+IFRoaXMgYmF0Y2hfZGVzYyBpcyBhIHBvaW50ZXIgdG8gdGhlIGRl
c2NyaXB0b3IgZW50cnkgaW4gYSBiYXRjaCBjbWRzDQo+ID4gYnVmZmVyLiBJZiB0aGUgYmF0Y2hf
ZGVzYyBpcyBOVUxMLCBpdCBpbmRpY2F0ZXMgdGhhdCBiYXRjaCBzdWJtaXNzaW9uDQo+ID4gaXMg
bm90IGJlaW5nIHVzZWQsIGFuZCBkZXNjcmlwdG9ycyB3aWxsIGJlIHN1Ym1pdHRlZCBpbmRpdmlk
dWFsbHkuDQo+ID4NCj4gPiBBbHNvIGZpeCBhbiBpc3N1ZSByZXBvcnRlZCBieSBjaGVja3BhdGNo
IGFib3V0ICJ1bnNpZ25lZCBtYXNrIjoNCj4gPiAgICAgICAgICAiUHJlZmVyICd1bnNpZ25lZCBp
bnQnIHRvIGJhcmUgdXNlIG9mICd1bnNpZ25lZCciDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBU
aW5hIFpoYW5nPHRpbmEuemhhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9p
b21tdS9pbnRlbC9jYWNoZS5jIHwgMzMgKysrKysrKysrKystLS0tLS0tDQo+ID4gICBkcml2ZXJz
L2lvbW11L2ludGVsL2RtYXIuYyAgfCA2NyArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCAyNyArKysrKysrKyst
LS0tLS0NCj4gPiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuaCB8IDIxICsrKysrKysrLS0t
LQ0KPiA+ICAgZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jIHwgMjAgKysrKysrLS0tLS0NCj4g
PiAgIDUgZmlsZXMgY2hhbmdlZCwgMTAwIGluc2VydGlvbnMoKyksIDY4IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvY2FjaGUuYw0KPiA+IGluZGV4IGU4NDE4Y2RkODMzMS4uZGNmNWUwZTZh
ZjE3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYw0KPiA+IEBAIC0yNzgsNyArMjc4LDcgQEAg
dm9pZCBjYWNoZV90YWdfZmx1c2hfcmFuZ2Uoc3RydWN0IGRtYXJfZG9tYWluDQo+ICpkb21haW4s
IHVuc2lnbmVkIGxvbmcgc3RhcnQsDQo+ID4gICAJCWNhc2UgQ0FDSEVfVEFHX05FU1RJTkdfSU9U
TEI6DQo+ID4gICAJCQlpZiAoZG9tYWluLT51c2VfZmlyc3RfbGV2ZWwpIHsNCj4gPiAgIAkJCQlx
aV9mbHVzaF9waW90bGIoaW9tbXUsIHRhZy0+ZG9tYWluX2lkLA0KPiA+IC0JCQkJCQl0YWctPnBh
c2lkLCBhZGRyLCBwYWdlcywgaWgpOw0KPiA+ICsJCQkJCQl0YWctPnBhc2lkLCBhZGRyLCBwYWdl
cywgaWgsDQo+IE5VTEwpOw0KPiA+ICAgCQkJfSBlbHNlIHsNCj4gDQo+IEknZCBsaWtlIHRvIGhh
dmUgYWxsIGJhdGNoZWQgZGVzY3JpcHRvcnMgY29kZSBpbnNpZGUgdGhpcyBmaWxlIHRvIG1ha2Ug
aXQgZWFzaWVyIGZvcg0KPiBtYWludGVuYW5jZS4gUGVyaGFwcyB3ZSBjYW4gYWRkIHRoZSBiZWxv
dyBpbmZyYXN0cnVjdHVyZSBpbiB0aGUNCj4gZG1hcl9kb21haW4gc3RydWN0dXJlIHRvZ2V0aGVy
IHdpdGggdGhlIGNhY2hlIHRhZy4NCg0KRG9lcyBpdCBzdWdnZXN0IHdlIG5lZWQgdG8gYWRkIGEg
YmF0Y2ggdmVyc2lvbiBvZiBxaV9mbHVzaF9pb3RsYi9xaV9mbHVzaF9kZXZfaW90bGIvcWlfZmx1
c2hfcGlvdGxiL3FpX2ZsdXNoX2Rldl9pb3RsYl9wYXNpZCgpIGluIHRoZSBjYWNoZS5jIGZpbGU/
IEl0IGRvZXNuJ3Qgc291bmQgbGlrZSBhbiBlYXN5IHRvIG1haW50YWluIHRob3NlIGZ1bmN0aW9u
cywgZG9lcyBpdD8NCg0KSW4gdGhpcyBwYXRjaCwgd2UgcmV1c2UgdGhlIGN1cnJlbnQgcWlfZmx1
c2hfeHh4KCkgZm9yIGJvdGggYmF0Y2hpbmcgYW5kIG5vbi1iYXRjaGluZyBwcm9jZXNzaW5nLCBz
byB0aGF0IHdlIGRvbid0IG5lZWQgdG8gZHVwbGljYXRlIHRoZSBsb2dpYyBvZiBxaV9mbHVzaF94
eHgoKSBpbiB0d28gcGxhY2VzIHdpdGggb25lIGZvciBiYXRjaGluZyBwcm9jZXNzaW5nIGFuZCB0
aGUgb3RoZXIgb25lIGZvciBub24tYmF0Y2hpbmcgcHJvY2Vzc2luZy4gV2hhdCBkbyB5b3UgdGhp
bms/DQoNClJlZ2FyZHMsDQotVGluYQ0KDQo=
