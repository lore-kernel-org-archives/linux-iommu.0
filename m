Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A81E9B3A
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691804; cv=fail; b=H4UTLcd3fdwqYD7bq2ESUHn0Cl2zNS/szX6/h4Y5SkOONxDTWXvE0upt8l/tCBrclK6r+LHeNaLDEZ/g3aNw0A+DxZ7Bx6U+LU9h1d9LvHbRuPHUJ855tcglwcHjPPkEwLZSmIhXOoj8xFysq4B98oZWkp/Y6GiMe9ksx+/QjG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691804; c=relaxed/simple;
	bh=iRlGsMBfFBgU7qKo2cKZpx0nzQWfo1uQEizobH/RC9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EhJYc+TDa0TQimLmr/EQx1R+beLRUlNm9CK5FyfWnxJQCb3Mi36G+bwTgEViC5NAZrO0l/lfXasz6sZvKFw0fxl7C37xnYTZnsh7O6K8nSSVQ/CErXRprgPM/ahJtfPbkrSnhbNlailIgrO49WL5Qb2tDbIQxrFtjQfm5yT+mBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GY7dN1FP; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GY7dN1FP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779691800; x=1811227800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iRlGsMBfFBgU7qKo2cKZpx0nzQWfo1uQEizobH/RC9g=;
  b=GY7dN1FPek9jMnh3S0ci1RxSxw8z9huX0Mv4x7Sst3sv32mRNjE1Kpes
   dh/BB5tAUd1XYe+2mzmyfSB8ckawXewkiN/F4cBD5i/RlhsYaXhW+43k/
   5orWF3oYBWVv3U+xnaBj3LvQdFeX9uOYpHh1LODa/s+3XqzeX6Zztrug1
   rW4qXISPrG4ta1fuqNZ1QVyQLvWhepo6jVVyiz6wio8QE5DULsFIJSkUV
   vm1Xix1GNQKu78/4K1EVchkdMrViz4ZOqH0dlfm+s6H+qjsFKQluSTqLn
   tbpPJdfrKsA2zwi6UsKDYA/autBvwOM5XIcKAeStaLNeGuUPHc123UFxC
   A==;
X-CSE-ConnectionGUID: mefYBJvVTja0Ms5v87gMGQ==
X-CSE-MsgGUID: DaEtT7x1QbKh2QJbI+O04w==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="79541913"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="79541913"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:49:59 -0700
X-CSE-ConnectionGUID: m2DOBEC6RjeZzfFmU258cA==
X-CSE-MsgGUID: Q4/T3DCGS++Dn4dvZ84Zqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="265085904"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:49:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:49:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 24 May 2026 23:49:58 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:49:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wvo9QMhzLmnyd9sd+b5puSBpxBTl6ivTyElGs256XrBv4l+rKNRhAG33YOHZ/L5eJPkWjfBWEszrrw02ic0hG0Nj3c3DyzHnYzlPDYcM0dXu1vkQBdUHdhqaQIqtOTtSN7oIw7iaS5gPk5lPpcVCZRX4WJUxfDYPryNoFkjDSU+dqmdPUAWzART66ub/4sD4ukRbIU1mN6fIzvkzAu7OeQ/dCnKpPnvxSu2yTbQAnCpCCzIfdN0NGRZw51e/5KGFnGpPfUS8DhBeUvPLomkRZKe2e/JTJMMMSfK0lOBodpWDDva/6VwxeLkbQodKYFAYhkvBbq8CXlsEPQ68gh01yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRlGsMBfFBgU7qKo2cKZpx0nzQWfo1uQEizobH/RC9g=;
 b=knTCp4y3E/PvvHqnazCuXNH8NbkP+XwYdTHoT+7nrFC/r6NW1W0p4xiEQYm47Ji7y+IymgsHnsSBD/F16FV1EdIqTtaknDY+URcTjiojc8zEnnrCvWVHz1KgYCx3X8uW6SH8+VT5v3bTZk0MbfBeJzE/Vv61Q6qrR7b46omtXM0Id4oyYMZEnAdPGIHd2yRNJHGwAyMYrWAI9If8Mr/RfeXqhUuaLZ5d3U/8UYHEgX/lhHNgZxl56UN4E3ccKLWgJbLnrvKwahCdSqRATXHELsYqL4bucrmqzZ1Q2J44UxC2KNqVof4YaE1qKO7joQUIiDmdeqLHA8mumveYw/JILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.19; Mon, 25 May 2026 06:49:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:49:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH rc v2 1/4] iommufd: Fix data_len byte-count vs
 element-count mismatch
Thread-Topic: [PATCH rc v2 1/4] iommufd: Fix data_len byte-count vs
 element-count mismatch
Thread-Index: AQHc6YMiIkdm3M84L0CUUGE6Rix3z7YeUiRQ
Date: Mon, 25 May 2026 06:49:52 +0000
Message-ID: <BN9PR11MB52769AB9BA7572BE58000D2C8C0A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1779408671.git.nicolinc@nvidia.com>
 <f7665f839b9dce917d6bd394375a1cf56568d86b.1779408671.git.nicolinc@nvidia.com>
In-Reply-To: <f7665f839b9dce917d6bd394375a1cf56568d86b.1779408671.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PR11MB8670:EE_
x-ms-office365-filtering-correlation-id: c46cb1bc-d49a-405a-b361-08deba29d2c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info: gcFlmS67jLd1B3uvXBpnsn3shlZZv3449DINBsVJsDOW8/tXGno9wJsxd53tEs/srfuuDyW9WRErdCoN4LstbZyOvjSNZxHuQ0eGSlvt2qeoirzW7zEvjZe0KJ8gPzNtG+nGIle8A9f0VhShqr31pk3cS644wQl9n6TqAhXMDoJSn3NBFhuV8syIUW/wTQBhNXdXlpb7JJTjE63LZjvgzovnQKQp+kIwr4hF6GuYVv1F/4fj+auj6eZ2fdeO/1MKI7suuVfEE0+Hc3EfYOdFGW6K5rHM5OsEk5kJpgeQMlH0swBPWoY1YIS7oAIHypTbtfb0oTeZZo3DDQAFdwDu7C5kBLfkqhTvDm3taeuuX+pUnlj29dOBtVyKR8T+b8gGaBDYjMxGS0Lvxd51xOOmOySYMfyfSCTHf2eAlclFVjHlIooOTcLoSh9F/tlnXEmHnzI/l0DeV9WWfe2nLKy+Cg9B7DFMRQZGT5tD7RUYPDN089H+vCdTnQTES0BHr+0jp+zF23yJGPk0EuXN14WKgsC5gpCRGT/svCIw3WNw7RPl/AL67o/KjovT7noxXyeRqVZbLHP6eQivMCANavakuJzfe0f9Ia2IQF4JWB9ijY2FXX8LsMpHR379PxXE1fwYDNWmvbOo0oS0fSxdqtEpG8Vi1fwOioFaV/paXjsJoBuo26r6UiERk/tKjsON5vTyR9He7rluoYN886mkgRIdzTUIfwx3ptDeeeBFxWzp/654+MJYR/uyumuvIwVGR52q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SDhlWjBtBVVb81MivaALF8YxQvx2bleBZlwgPkVdI1yrtpTb0lQhWZdWbkkt?=
 =?us-ascii?Q?JkuG++w3fx3XcYa83pup+Lkd6geIx39alPqDUAZBXmAybKYjhgPRSzkSpsmS?=
 =?us-ascii?Q?gdXCBp//Fzl9NRuiPlaf/pTpxDKcj3+c9kppeEmvqGgSLXSfSgQeBPnHQTNA?=
 =?us-ascii?Q?l1oVhPqvCbF5SLGGB1YXtsmavs+AgbQgxCEnRoCVSxDSu6Efiad+7eAHGhPB?=
 =?us-ascii?Q?+VmHXdgjc9Ml0uYisR2XgTeGewYBD/i4SYd27yRuOh4yPA3GYL67/B2bdCuY?=
 =?us-ascii?Q?L1eq8nA/ESw1MFtJYM4aFxDglMl2qawmAjFdS6JqZ6VuLUFVPTxYuuX08oUp?=
 =?us-ascii?Q?yXoIiRzAMwL6/3vib3PVnxTnUwUpFbjnwwJZTQ97lOwlw5NKblHV0yMsgyRd?=
 =?us-ascii?Q?NUM/6q9BRgIbEBrKwlgWgPkz2o+pIaV5daFJIu6jqF2VFKpoViZa7JsysIxx?=
 =?us-ascii?Q?4ZQQMuf9ZHtjG7DmzQqQkWIJSmn5y6d5Cy38vxQRqcN3Ujs4wLHuo1s/+SBS?=
 =?us-ascii?Q?Wbl/mv0FnV5zh8K2gXgWU5nMzLrv2H0k5H0uVKEcX5iGTd0RjiylNqcPOuoW?=
 =?us-ascii?Q?K6FyQDBVWomW63NlZ80YP22W5NS7E3mtUdzi4Zjh7EnyoSd7DRnl93NNFH/y?=
 =?us-ascii?Q?NBpHji+YmisKYrj/5COZLQrk18fanp1u1V1ddyoW9Pm36dmcMNYy1JPbnHCj?=
 =?us-ascii?Q?hZvX2WiQ1N2edQ6MAvPHE1Ql8OlDeRjHCejK5FCEutvDHGPZrHV0KyRf3Yts?=
 =?us-ascii?Q?NNO273LAwUVGt0ckJGxyUWT0sR3S4/xPFJ4RBOzPTVYD3OuV9GL7j7s7spPh?=
 =?us-ascii?Q?0htMJqggTRShVLjYwkXu2f7PAfont62EKouMhvA9EEqdM3eaerXIBcyxrnjz?=
 =?us-ascii?Q?afrcLEyzZnhbPBKXpcWzgv4wM4zsWejFxf3HrrvUmHTSlidgUohP1SiYBNtZ?=
 =?us-ascii?Q?7TtbcJVfTFjDGPc/hh4GyTwqnHyXOeIbFHHtWWm0I/+xibl7cPVSXy/gC2X0?=
 =?us-ascii?Q?fK4zMqTanP7gaQiO7gzLAN3ql8h3sn8P0MN8y9Sgi7A3O8QIcLzL9L6yUEKI?=
 =?us-ascii?Q?DSOqsbf6Xv5WAH6NrFmFJdh+I/LSi7VsI6gghwz0+Cyy5KueH3+1bQqjRPZa?=
 =?us-ascii?Q?8/gyWJiC9lMF7nHuSQYaP9SSNsmuS9le84QsLpIgmkI+r3dAYt6+sYWJYZGC?=
 =?us-ascii?Q?6RP3cdDwfj9tFcUubEywiXRcpowak3Us529dsDPrdG/Cz3mDCveeqpdxqPv+?=
 =?us-ascii?Q?C6m8VcGgRd6aM81UdcimR/kvI/maak4m7jmLy08/AacTXemb6wnbJlperqXN?=
 =?us-ascii?Q?oRAEDypr5d8vWej6jQNIXvn7jvUxfvPMESoALbs1ZVtjAH4iFW/k21LlWM1G?=
 =?us-ascii?Q?ziQ+1H7pQJpMdHGHSCviZSfuyEhPpRR9wdpazVNIF7pBpgjS+hi6PPht1/dx?=
 =?us-ascii?Q?SiWTX40gipA+B8cGzrM4wZhOLXQAg7kd8ZB8t8MZk8mU7u9xKDfxxNMvGYcR?=
 =?us-ascii?Q?A+Way9CTcxHf5QvY1jyGTVs4DaApsGzGxvYmNg/HLv5prfuAaGZL8sWo7PYj?=
 =?us-ascii?Q?1cYJSABTLRGoPYkggrQ4Y1Rym9yxmFQAodQKjrlWGmAbC2CMlybPHcr0u+5Y?=
 =?us-ascii?Q?CbtRPcxjbihUU8iyRZfbNvCa+5kpJXxFQH6gUOmJK6+BlcE0yZsWJya2cuQP?=
 =?us-ascii?Q?QIytu2vkX/65zAUpdk5JOhBVjy+EqpK4GWkzL+TjYujlW9hkZFH19d4Nm1Ua?=
 =?us-ascii?Q?CObOcxED9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lsEPvs17yRmVua1deQB/mI8i/M/FklbCdML5Ftm159zTGSBOxpzR29yX63w9F7nAtZ3nvj2CspfdWzp9Eu8He/yR9DBR2bJThG8+yvVSGR+Jow67iUtngvmewjS9NnZqOuls+RprOikn9rzgdL4yAdQ2eEYxgL9SDQg2VOgfSTMDxmxYIwaS48M/s+LKldd9elJvEAO3FCRzGYTdXHZwj1bMc7g5eAnoIDmW5prXoYsqVxmuGfnenbKz/fW81HVVjm8UQy+s2yFmvRSGf79btAB9cGa89/MStrywKPzd9xRKnXCeEVenvZTK4qQsDGmSAZ8bZa8BRenrJqfWqyKF5g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46cb1bc-d49a-405a-b361-08deba29d2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 06:49:52.5769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pwdz7hCzZqMfWKqU5lpELdIrWUIm7fVe/e1yPXcSjBADyq2GAq7hrTXZLK7n4BvGbcRCOhwYA/UGGg1K35sJUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 22, 2026 8:37 AM
>=20
> kzalloc_flex() computes the allocation size. With event_data typed as u64=
,
> data_len is interpreted as a u64 element count. Yet, every caller and the
> read path treat data_len as a byte count. The current code over-allocates
> by sizeof(u64) and the __counted_by() annotation overstates the length by
> the same factor.
>=20
> Re-type event_data as u8. No functional change in user-visible behavior.
>=20
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and
> IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
