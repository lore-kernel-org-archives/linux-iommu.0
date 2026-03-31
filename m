Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC750394496
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941565; cv=fail; b=jltS8i9ngXgVBtamFNWuBaEzfD6u8gEBxC5/2yHq8P1KbjyuepXiVdrzn/PSPKMAKCvIRWAb8mbECeokNaihXBrGluRVqaTEHUGEQqS6aRR9pTxxOVEPt5AUqpWgtiCBrB+x1QVTguk/t2F1Frldr8UFi7AmTzTerx3KZu9aQVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941565; c=relaxed/simple;
	bh=4vaydwBJ6NYYFLOVhvSPBSP9VIrI3+KZ0/eskOVdwac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rCBY9em68vB7uQvNSejPwsSTC70zTyDSZBdad7M9N+WfedEBAJm27kvK0c6hjGQoFRgCPt9uRWRL9ef09BhpBUijBqiriJpEjD8aXlsv6F3Rek58GtMRh8S2pRTWpHiKPm2RsKNEWpSr/yuHJNX7h0r307JBCrcAFCN5dZb+DHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJwDxC0i; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJwDxC0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774941564; x=1806477564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4vaydwBJ6NYYFLOVhvSPBSP9VIrI3+KZ0/eskOVdwac=;
  b=PJwDxC0i8bUPBtg5HFQJd4iHShzewOB13ehrn3jfGfHESrb9V8OipKHc
   kng9zC3R/apBGia7dVQGlLtrc4t3yJhsHWPDARD/VO6O8krT1SvfyR5P3
   I2XyTLniH+4TiYzW9x/iJ61niwM/VydeL6PhYcpcpJ4yPpMD1pdyzWu/G
   du0cYMirTV6Wb3/dN8blEoWrAPYWzErKU3b1Rie8atVQJvP47/TEZDudw
   DpvBm9yWdO64UZMMWji9M0Dr8QPRj9g73mTq8Htdd4OaqFG9AW0jOdZFj
   coRCBEHBpXDrfdAN6KDO5QAjxil54ohZtPWgM9rFkwaQi+0YQPD9ymOnN
   w==;
X-CSE-ConnectionGUID: nciE60OtSkqeJQHnBtdHig==
X-CSE-MsgGUID: eb/3xn24QbGJicj3oBCRxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="78538000"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="78538000"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:19:23 -0700
X-CSE-ConnectionGUID: soxZbXkgQ5OQlNE+V3QdTQ==
X-CSE-MsgGUID: 3cYaTiCpQ4aIh5PTZj2syw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="225454070"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:19:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:19:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 00:19:22 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:19:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZou8RiwxRacJ3+lb/VRHUWJaS8r58NBQsKj5UOV7kKRnYexakNtQYNDILvVhEb1gV+JuGbfuCFoABJI5ZVXDBoNLHskUzkhEkMWVxGQ5xcsncedYKDF6cEwxKR4CXBeTSP0+LFeXvuVKQ90mvzQjj/xgwEQdHmQ3NmLm04FL1H3ePBnmlEFPEo1NEpMGnlDXkA4f+zqczfQ43wpCHOrxK2EuePGhmqU4LElgPld3/BLbHmbyY92D0RmFmDrkf+wh4uS+BiiLDMMG2MO0M7IO96kcXmTO05TdkBRMcajpUub92sXTaAlAdtHAGnZ63O3M1S1J1C/hXGJxrIPMQxmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vaydwBJ6NYYFLOVhvSPBSP9VIrI3+KZ0/eskOVdwac=;
 b=euObwfRCSGlsrs1tHyJClWps/zloZGTdZMPVqv4wxl3G1h+4/uWJaVIhSB1aaSHT7dQv7GW64h8DHIBjPGSstk61yOqsYbM1P2mCUZMGooTecj876K1/UkPu/mCeca1A6EQPZ6ffTXgw5NqFHD6DPlL650HT4px/fht/NajDxVQodrA5DVYLvZuiqFX/nTyf/7kDc2eJTOx9M7eG5OclWQfs0/yZgwE74Wo7r9gXyERgJQkw9aXPfVL21rUhGKTFenACcg6I2Pg30rpt/8OTUOIbjBYWONA21eOLW/DFwEHdPMruhQ/ASyQaeGEvX+8S2h//YWDV9NBBlwfcC1+QwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 07:19:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 07:19:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH v2 2/4] iommupt/vtd: Rename device_set_dirty_tracking()
 and pass dmar_domain pointer
Thread-Topic: [PATCH v2 2/4] iommupt/vtd: Rename device_set_dirty_tracking()
 and pass dmar_domain pointer
Thread-Index: AQHcwC2VWjz8G4gT1kiYvjhplNJ5mLXIPPcw
Date: Tue, 31 Mar 2026 07:19:20 +0000
Message-ID: <BN9PR11MB52763FE1018223AC6CFB65E98C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260330101108.12594-1-zhenzhong.duan@intel.com>
 <20260330101108.12594-3-zhenzhong.duan@intel.com>
In-Reply-To: <20260330101108.12594-3-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB7984:EE_
x-ms-office365-filtering-correlation-id: eb4e0a85-7987-4614-c360-08de8ef5d3b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: JPywD8EIvY3Gv3B1Ao2uZ6IZT4UjhRanOT8T+qddR2u2Ob3TdSU6T47h4fwwoofpMGFarvjzYF8pzR9CDp85Z73sEodAg6r6qalIU/CoTS0LsDNk2UARXl/iW1jWa+HbLKFRlZkTY8tXFMa3DUau90lOsNOTjkohYhsuvauypU4qd1JkKlsReoP6RzsSzbWEg8ZEmdid9K7wsv+sA+ubyr6kvoDesEOpcbVe7fk++3qAJ7MJyNGUaaPzAYJ2OUILqT2Dcz0HTYUvncteOpDFheC+zfUp5MMCB3arbJ3Ic+WMOZrQFWzlMZj6ny+Yw9IW+fo+Ony1x+CMkM2QrXMb6c89dYHcmwDtC/jyCjdBAy/7yV9UJFMtO0z2L4RgTmHfw0HFX5t71J/FGHpTt5q4pW4C02yxmtlIPaQHlOYmaxy8uUm/9uoq33yKpue5oa6hmrHvwf500YzuxlaZra3Y4+WpCKvnVFXZEKmdNk20/1WaHn+Nu2K52Okm0fs1dGYvZBFIfRniYPXOt7iBpk13bPVBx/4a025Qyt4cN9u4fbB0hMqTrUcPzYfvr72cO7He02xLuDNfUh8nr+Nnu6Kq/+q9I8u3us9m7CIMdM19jr73b6JWv7MdObIne43SSArO44hgWy3LnkB4ktRDcElldZIqWd8oU08nGTVPzIStRAnf4BiCPpDm7aQuTscC1aRKlpRbCCKNP6/Wudh3fPSZDpI3YuUBbyxrGwwUvQvAFfJBSECGnD3Qvhvsq3gxvmpByYK6BRKQ5jFUjyZpacTMxcNEU4THhv4v4O+3EBtKt5M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2y8gUzM9E30bMaqX978UavLxxfWhLssYijiL0o845xerLEyAVszG67XR3sRp?=
 =?us-ascii?Q?XPtOkGgn1qmPeaGlz9LNjj4wPpn7dxPiQi1EalnyfwjyNqBWhYzK9V9hXlV1?=
 =?us-ascii?Q?GVV6V6++44GJIVrOjVzGmUVruJlB4jNTHvKBo1fhRHRd7pw5XvZmP3u7KUml?=
 =?us-ascii?Q?CavkHyd4ea4SX45NTHQhOQ3TlVpbJVk8YYT6VBQyFVQax/EMee/1QIOvAFb4?=
 =?us-ascii?Q?VcQwaO+v81qswJCTaw1j34Wtbi2GjTMy5T5Zo1z8V+UxHO8ZjpY7O4/Xgis4?=
 =?us-ascii?Q?rC25mz+BS4ya3CGWMOvjS3xNt68JzZ9FXFDXw4S9R0S7PKUk9vLWyS+hZMUn?=
 =?us-ascii?Q?lc3EeEEbGggc3VvPzsgx1flqo+B0A746xlCxf7o92oA1sNR5ZxhSwruKWLqI?=
 =?us-ascii?Q?Xbnyfw3YKkXVeljfQpXpvc6+FqXZcmSXBfLY+IO7BnE2lTRu7E+EktJrItBo?=
 =?us-ascii?Q?2lgiUN0+5kEuYSyMZrJJPDQGNyEuSOgvtQoYQr2KNzSRoOswLC6KWIkW8wRU?=
 =?us-ascii?Q?00GugmZQjeMz9/+xdGtBS+XKsK7MPDEYmIAe6/jTo3e6BUhvhIgH5eB0tlfs?=
 =?us-ascii?Q?ligCq2q0KPLhtkyao9NgLY/v4mFY4fLb3zFd93UH8qoX8DG5KiIy6VNBp3m4?=
 =?us-ascii?Q?TxamwnFnzvgrpRJc72aCrUf07lwg3CZ+p7c29K1Vgyo6OkCNS8nW1lmJ0tcC?=
 =?us-ascii?Q?mYrJ+Um+DSCyF5+5qLBjq98ZCus14skHyiGczUx7gMpV0hqLCPqLLD4fs59k?=
 =?us-ascii?Q?6kvae5K+O1EXm1uloweoGhRyUtYPZFLq1+1qVDUwAJd6TenCssLnArevOTDt?=
 =?us-ascii?Q?wk3IsJbB8tmhptD8tRA++McD5tlv5B2rfQyzF3GQhg9vIpoIzimazva31H6B?=
 =?us-ascii?Q?NvOh1H3ZRIn6HCYQxs+vcsqiKWoamOFY17Qn277PXW8GN2Tn71i6Ue3hYsav?=
 =?us-ascii?Q?gM/NIlI6HYvsI0+ky0/hv1HEyt9X2XfKoiwgnsITw8Dl4NDDdMUGABG7imn/?=
 =?us-ascii?Q?1FwT87+9uxA0j+lqV1ozA+H1NIQEEPdef693GBCz3dUVMkC3XWGvoXEysw9B?=
 =?us-ascii?Q?3f6FkjSExf2TsSznOrLN1z2ZkohSn9osQjonKEvjiZsJ5Y0TVxzP7Q++ZXqE?=
 =?us-ascii?Q?yzkd2zrsLh1cB29s8ej7w4omyO/C7WGS7V9/MTCyX0mCwTcnQqUMMtCYeeM/?=
 =?us-ascii?Q?m180FjPCyGYb3Fb0lzh/visjCxc7Qh8/skAafwYwS4LVHwbeMdK3POVkNwKw?=
 =?us-ascii?Q?7mBLuqOz2RkPE5HjMowdPVNExUXFRtlYxhDvERXtTuDBPMQWQCDkiDy0u99+?=
 =?us-ascii?Q?/x4uwvPZmSsbjGcVzmpzXxKyP1FbSBa1+rKpg+KN7cXXbLNiVK+yhB4uQM28?=
 =?us-ascii?Q?VeRpgYdMErx+X9iXROtdOQBulodI7SNuEuH5z7IU2FwUGyclybsF64YBoCvw?=
 =?us-ascii?Q?DGeL7i4guymlkFiALSSySn+LJiYkncprxb1QmNyVgtgmr/iYYIrApsTPTN+q?=
 =?us-ascii?Q?z87G3HMT4o8qUwykpluhdINhT9vNvtuC+mJxXWPg4Mx9cqpsEz0Jm22ieTBu?=
 =?us-ascii?Q?fyh8qFapbgr2tAA/+dOe/j/dRAq5yDTAfrTP4Ijickx69OYVLS88XuJsKRLU?=
 =?us-ascii?Q?OqjwxKpF6wLjm85L0vH3NTGwHVmbhbxV2XiH8eZjHgz39ZquQkfAsMXhHiH8?=
 =?us-ascii?Q?vwuZWXRw04wOLle/Aqvi8uaAVduFYwjs2F7k+BlNL30bV4s4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: t6UhYM3OFRh+EmlUjyUht1Hq+8rd+Af0jzqM2jmnQ6+5YQWEPyjlBIrNeD52U9vw3LSS6hj6ZW5jwVdZjmYeUazLtioLeiqR+fXt86BLckD8MU4ZrXxm6EXwLedflwHlm/NnExmXz5yby6mPBOIumC+LRTvImLSMrHQ+4CidfVgiH1MaFHoXf9KWe1btv0iPt7BfA0EDuaU3i0snWCxy8T/nzaD8h8Espfgr18HXl91wFgy8nCi1/m4bQPlFVDSnoNVBCxDP0E9XEWPpwo7h/BIaveDCbjPSfe7Srrk574Bj7G977jdWM2AInTRprS46hvMqaWU0FV5cmrqqbYMwWA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4e0a85-7987-4614-c360-08de8ef5d3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:19:20.2967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozQyhtMiBwMM2q9eaLVBCuptKJY1N57+vXy+ekkdC4+h/2RLTbsfdZRJRqriZSSsG+9T78sge0IkXJ/VImaBlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com

> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: Monday, March 30, 2026 6:11 PM
>=20
> device_set_dirty_tracking() sets dirty tracking on all devices attached t=
o
> a domain, also on all PASIDs attached to same domain in subsequent patch.
>=20
> So rename it as domain_set_dirty_tracking() and pass dmar_domain pointer
> to better align to what it does.
>=20
> No functional changes intended.
>=20
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
