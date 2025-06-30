Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD884A23
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 05:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262877; cv=fail; b=qE1Lo0eIs1+sqyQiC9N7hQrYYOL7pkesj5cGAjs+bA/TqZu9dwm8MdqQZpGG+FB50Eg5r9kgRc8a7cNa1JH/ysDg0OeFz/fR3RemIBG5UJZHEFfjUVsMmehxYv0eF8OtQzofIh1ftrNs44sZ7CHticLmuCo5AyxCu72jt5ldA0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262877; c=relaxed/simple;
	bh=pIlDQEmHVpe9NbYnhyxKkj13RdIWrA5bSuOA9SVrUQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uNTy3dW6qQJOgyjESIpZoJEoMctTqn+3o0vF+17Fl7w0CKLyZCx+hqqqXLcN5+rg3CNonpWXVNZtON5ADeqbI6ZzXz27h0SP1WtuwiHHsU19MyGInI3cA9MeIc7FupKjPP2KVWSTWtmVT9IGrq+9TDJocNp6PVzuu0DlB0PiFqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=We1fpioc; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="We1fpioc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751262875; x=1782798875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pIlDQEmHVpe9NbYnhyxKkj13RdIWrA5bSuOA9SVrUQ8=;
  b=We1fpiocq32NfvPSm0bv+eviNexB1Q1Wt+zohw9bZuv4dBbWWoCNjWEb
   oDjWwYb+bqPqwU4555A4wtbs90ixbeSuMF4kbJETJRaQMzOi/wRV6Dot6
   1sWnXlIqtbDXieKWdKNfSnzBLo3bsrU4Acho3vqelbBTCSHqegtGLRR3y
   UM143uf/IjRWvk8v0lGxeBeDgbbrht7Nzukt1mFyIvrypBPZXi9Nm2a+v
   8QcDDfjLoUtup4NI9l3w7LRTosgqxoI7BCx8Ee4KBhWXZtgv6A3oIQ+NB
   nmzcsNjU5Vi1+bGagRvJIuQ4Wo/iY2Oj5TXUmgkxjKvc6BVBszodq/Onw
   g==;
X-CSE-ConnectionGUID: 9f5yUc1xTeWtLseNSSE6vA==
X-CSE-MsgGUID: x7SCmqHiTVW6ffl4hhUrNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="52593433"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="52593433"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 22:52:30 -0700
X-CSE-ConnectionGUID: yGJdLM0iRCWpoqscjlnSlA==
X-CSE-MsgGUID: sPI+HZoVShiiOog2dx6pFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="152747079"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 22:52:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 22:52:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 29 Jun 2025 22:52:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Jun 2025 22:52:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBqAetIg+O+eftc0M37VyizWJ58JF5kONeb1TPVZvbUV6jSauRC/2Z9nx9oSezRUgopKybwhMyiaHr9ppLoHyqyLv9vCZNhtMZXtaLCsYbAVxE4lXa63KSevmYDTzfgqD2v7T3F3D/RTr29/PF+tVv+yFlnVMmT0zRtz/l4oj7h2LGRnBAmRlX+dzHhhv8/1amh+mRt9zRFPVpkLVh+DD/QcB2mncZ3A9i088CYZHfDhaS5ERvsc/BVXGQr4aCKQH4YV5kRUU6kc7dqT64sYvVpWiNaTW7lFgu7Jt1WFGWfviAhXrblg4/GypV/FfN5C6dXPO0e1OQr9uJd2IJPlpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPyQXoPKqNZMvOZe7pjQqMP6FzRcoY9OuTGSxKSvr4c=;
 b=Izn9KAqw+wMBikE58B8GgkuMMO2U9/hDfPxUUGCweytuuF79wFObuWl5BD9Qt02IC+wass/IYwfw/S5j0tSkABPn0aR63d85NFmZskS6Lg/pHUi92KcmaceTFfOsMah2sUZx33LFV2Qa89sLLHgynHkHB9GbeIMm0DxWjqlx6Mp7jyrDOlhXinudezwwE19ZPrernZjIEgBcPYfojdtwJZYWD1X+airpqHjqjz7Bx8W+7Ef6TpZoisIH8XW48BHkOUUU5KHQMSMOq9MpGXzQGiVpflNbPgBVaGjTWoTwoAafCeLIqMAJo5b94Em3vux8TMS8nh1ShO73RqEeB4ZeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ2PR11MB8585.namprd11.prod.outlook.com (2603:10b6:a03:56b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Mon, 30 Jun
 2025 05:52:26 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%7]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 05:52:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v3 1/5] iommufd: Add iommufd_object_tombstone_user()
 helper
Thread-Topic: [PATCH v3 1/5] iommufd: Add iommufd_object_tombstone_user()
 helper
Thread-Index: AQHb5xYCtHs96qDSmE6Vr3JwXh7ZorQbNauA
Date: Mon, 30 Jun 2025 05:52:26 +0000
Message-ID: <BL1PR11MB5271410ADB704F459C77BC248C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
 <20250627033809.1730752-2-yilun.xu@linux.intel.com>
In-Reply-To: <20250627033809.1730752-2-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SJ2PR11MB8585:EE_
x-ms-office365-filtering-correlation-id: e265b5b6-cbba-4d3b-b45c-08ddb79a4ae8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?x24neYZf25px0FN3aihorpgP1+zGN2lALih/3WLANluhQPNdeImk98D293d+?=
 =?us-ascii?Q?0RwA81jR2eBku5DBylZlkdzSNPB3ocZHrgj0tm3rA+7RIcBcSABpBMlExeB+?=
 =?us-ascii?Q?KVXaDdRliEgticoOghqBP16qyXE+HrckiU/6zxzVNRpskecqMTuT/+qSOeqk?=
 =?us-ascii?Q?k653lJw7FUtqabazS6QnBiFVxn+yNhPWfQQA67zIjQdO4PDNPs/Wqo//jcKM?=
 =?us-ascii?Q?8d6L2KX5WvpbnYrjZoXwW/2yCPezgjwh7cB8bH+ZjMAY9qoLu5g62UqPgOlR?=
 =?us-ascii?Q?Y/daSFNNASOTa7fzWyDHtF1bbuFHpT0/dPppfem3UmhQHcHTUkCsdidvdpl5?=
 =?us-ascii?Q?qq8dXEioII0kdhAiaLn4GOzBvks2pKU5M4/JvvLRPDykMDVGrNUJOzUGM8bK?=
 =?us-ascii?Q?UMn5EYouPA3miOVshuCcaxVKdqSlQ2dc+RKdc68ocO6e6qkZLY18fEtvQsda?=
 =?us-ascii?Q?d1nKSR0lWG7xbqmLMf52JqxKoQscBmDH5K3YUA7RFppxT4MHrVeH4EYJB/Bx?=
 =?us-ascii?Q?PRK+PdvmUq7BMmag/kcezFfBIblSP6SifYFUgFuTN5QWjbz2JLdLVUWabmAT?=
 =?us-ascii?Q?zPzIIwZj12hd77QOw7IcVAtjp3t5rK6rQM/o5RQnRNrkdVa351BMZMkTKP5e?=
 =?us-ascii?Q?xQtbAncVIcPkowr9Sg1K9ugFkKho0dHa/KD228weGjUWXEsRumlAAUDDpmqT?=
 =?us-ascii?Q?Sj+0+EBgZc+t7VYttdDDEoVIdSfFVK+XQ+M5fGod4vu3kdcX0eSVhOa9TwAx?=
 =?us-ascii?Q?U5UtQa1+VUw4FPurgKVndIh5/qy+QVnhKYuvnzHNI/6CyweFtk4jf8eH2YOK?=
 =?us-ascii?Q?08xS0/4u2c7KWipI2NjM4qfi9kbfSywmr4bCetfaM2LqAGKt7QgsSh1KC6x1?=
 =?us-ascii?Q?ZbpXjnA+/rmvMEUOJxL5rcLkZ6oOFfkUlANwrcIUQHOJVRRpO73AebvJTR0T?=
 =?us-ascii?Q?9RqAlxqE5TZcN8U1LK6/JH4zOaRag21Y+r5BkzaxFC1t0dIhUr1YQSrmqJkC?=
 =?us-ascii?Q?SR72g/0JUlCUcphDp96A4lATRG940Q1oecG2ykSTysML77XcMbj5WuJwiatz?=
 =?us-ascii?Q?bLPAl8BSkjQyIA7WxWW+c843C//jJxqamVJvT2LRhdZFNyHuN+OXoaddGLPT?=
 =?us-ascii?Q?NfLvzdlRgK+cEZL2tpsZPPGCtmjNtN5AyxspafUcr1bfqSlHxe7+vm5KqsbK?=
 =?us-ascii?Q?8IlE3ZECRpHPqRfgiQ+Y/9F+ybhb00qZgA02aMBm5XdYWqb8cD4BOdekF+aA?=
 =?us-ascii?Q?O54OMdDa6usDGCOatIpV/bMMke4WKP/y2z3wAU/PwmiqP/1xwwjGhgP/1Mbp?=
 =?us-ascii?Q?gIBbKlZdoC6DGTd+ubHMDvM2PbGKGblUIhkijA50SSh8O/rTaX2HfZitsTcs?=
 =?us-ascii?Q?i9jFMGoEGgA4jdP8psR+9zhw9HDjCOLrIQI6TvCCrFsHnU7wU75FYqRsSsDW?=
 =?us-ascii?Q?Z/W/MVTDW3yxmR4TECmtYI7AsiHZ3+gH1p/ICY4NVvzL9+9p1ThBxVfPyt9V?=
 =?us-ascii?Q?XyknQ2kNURBpb90=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fCAp0kzzJ9x4e3Z9S7idfM9qUE4avNJH7KxHcVEaKKeuHBL2tu/kIJcEkQPL?=
 =?us-ascii?Q?0Joc6xhlHc1zgSeaJhGZHpK5dEpJkw0jZGxaZJ5f5YICYWmupdFLRSBhGVqu?=
 =?us-ascii?Q?ekJflHBMe7mRIwWPGGVjGu2L1+pQu6BuLmsE5J6nON6WNCj2GSmN+oZWArBY?=
 =?us-ascii?Q?Pga1rRppiquhFaOeyQj2rodBlOdSPcruTDq2yVNUBJTU103xeT9r+LGch/vV?=
 =?us-ascii?Q?Z1Ee5EVnsMjmmYark1FW3zHNwKbSWOwuq8+xYhJmFdDomt1ir8d+lLzTRZ0I?=
 =?us-ascii?Q?YIzl+c86I/22CwYEXpKCbtsdvDA2WFgsusoeT0QayMpOaxgN3oRI8Jza5L7V?=
 =?us-ascii?Q?7yC1uAL1UDABk+GUS3nC3p5+aIlFAfEv2qb+fJm9jQCK7f4hv5ClgYOdOcdj?=
 =?us-ascii?Q?krYLO23jypOHLxtn4HHgkxIkPxiHysTwG5T3g0ALikqsfAa7KIP9FSn2H0Df?=
 =?us-ascii?Q?VJL2wCo/iPICuZFiWpszai+7nOFCIxr76hmzR81Pf57DKi7D0GxMLMiKL0le?=
 =?us-ascii?Q?8v+PWBE6avdrqxtl7GfATQvK8pPWXfG2ChI49ZQqv0ocebgvk2EeY6RIEIKr?=
 =?us-ascii?Q?FauAifKSx4bODjg0b9AFarZAiTw6U3WR1mnaSOte2+LSOwm0ZcErjYPST2lx?=
 =?us-ascii?Q?XkDBgg9E7gS8/gobVrjTsHvmthYG7tVH+exCxOK18WP99tranfYtnxSIeW4D?=
 =?us-ascii?Q?PfJonGyMqhqGmWVLoo6gmpKwYS2SGuvTvuEb0EeLlw3+cz9qM8UlwZoTUmaY?=
 =?us-ascii?Q?JPE4B8OGvM+tt4pFT+USedR5YsdcxPBVM0ZB6Spr5Nu0jq5ptphnfeYgJye8?=
 =?us-ascii?Q?FxMiKgFURCregJViVOg0jkKwzM9XUdvoFLANI/QAEca1iv+cOakTFBm8b5iO?=
 =?us-ascii?Q?iiYJJfBRQ4/oLJEx+lDYuNSyBB4TYwoeDJk+sntwbsJiRpIyxVShIVnIrZbS?=
 =?us-ascii?Q?EIFMf8XkvTeEUUz3SbGxHCAJPVqVw/gHYrY8hu7s6ZlV6Qv6GBnwnxR1anuM?=
 =?us-ascii?Q?TMD71ZJrW9DoeAuAgKoU3b0A/zMa5EynVxAzSuTQy/Dzd3rRHxXNEl/eUdJ4?=
 =?us-ascii?Q?NcfFNqiW1fOza3qKJ/oeyw8f6P54hx6FTaPTZ6wxnCNqZVSkyO9RsSve9C4s?=
 =?us-ascii?Q?eK5Pp5Tmpo9e6iiwcjjvFiaB+D1IG33pVn4ABujgf5JJ8OEj9fagdkJusMjs?=
 =?us-ascii?Q?iF8XCVTiP2Ss6jmg3iSBcL2TDJ6fvMUsknt4qevlaNJcISyFrT/z3lFa6Cf6?=
 =?us-ascii?Q?Dhx85pSYLOyR06j3rOdGf7DhvGs1teba7Q3IQLij+VXIq9ALGZlXfwdmri5a?=
 =?us-ascii?Q?K3CjZkTa9RisljP09qN7uhsfDn5bsGDV1UE9Bdx72BsEIhMDkjznJAyodNAx?=
 =?us-ascii?Q?U8dBbGgOkIkkoKALSguNPEC2/mp9bVphUFlNIfoQ9ku/t5e0UKf7isOvVYkq?=
 =?us-ascii?Q?LpzfYBsXDeHMhdEre+0w3xJE2D/MW+d6XR4SxifSJqo6pJVAhSb0FZPpSN+y?=
 =?us-ascii?Q?A2SPj2B2fEu/w1FVC67ajZvnkROzVm2Uq0XvzS80NJJXqqWZP6xCdB2qaLyb?=
 =?us-ascii?Q?+1qO1dSf3/XeNYPfL9rkwg4MXxgn9g30FhxQFhLa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e265b5b6-cbba-4d3b-b45c-08ddb79a4ae8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 05:52:26.5544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1r/kTSNtIbnR/MEwG/mC6rFMwfqFBUtroTI31p8FNZHame1p381tewS6y3HAfzGiYR+0rvW8Y2gbYr156UdXMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8585
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Friday, June 27, 2025 11:38 AM
>
> @@ -239,6 +239,7 @@ static int iommufd_fops_release(struct inode *inode,
> struct file *filp)
>  	struct iommufd_sw_msi_map *next;
>  	struct iommufd_sw_msi_map *cur;
>  	struct iommufd_object *obj;
> +	bool empty;

move into for(;;) loop

>=20
>  	/*
>  	 * The objects in the xarray form a graph of "users" counts, and we
> have
> @@ -249,23 +250,35 @@ static int iommufd_fops_release(struct inode
> *inode, struct file *filp)
>  	 * until the entire list is destroyed. If this can't progress then ther=
e
>  	 * is some bug related to object refcounting.
>  	 */
> -	while (!xa_empty(&ictx->objects)) {
> +	for (;;) {
>  		unsigned int destroyed =3D 0;
>  		unsigned long index;
>=20
> +		empty =3D true;
>  		xa_for_each(&ictx->objects, index, obj) {
> +			empty =3D false;
>  			if (!refcount_dec_if_one(&obj->users))
>  				continue;
> +
>  			destroyed++;
>  			xa_erase(&ictx->objects, index);
>  			iommufd_object_ops[obj->type].destroy(obj);
>  			kfree(obj);
>  		}
> +
> +		if (empty)
> +			break;
> +
>  		/* Bug related to users refcount */
>  		if (WARN_ON(!destroyed))
>  			break;
>  	}
> -	WARN_ON(!xa_empty(&ictx->groups));

I didn't get the rationale of this change. tombstone only means the
object ID reserved, but all the destroy work for the object has been
done, e.g. after all idevice objects are destroyed there should be no
valid igroup entries in ictx->groups (and there is no tombstone
state for igroup).

Is it a wrong change by misreading ictx->groups as ictx->objects?

> +
> +	/*
> +	 * There may be some tombstones left over from
> +	 * iommufd_object_tombstone_user()
> +	 */
> +	xa_destroy(&ictx->groups);
>=20

And here should be ictx->objects?
