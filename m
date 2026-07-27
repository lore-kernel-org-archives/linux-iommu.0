Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A613EA97E
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145121; cv=fail; b=T3F2NrSr7yKYW8aCQiTsEVFhmmnHz03IWxe54NfrZJCT9mftjd6ZG3bDGnV2ZMAXtrwoHwR0WDB6k1hLiveneK369st6H86D629M9y2KK4jpiIsDZJSIGSvTP9QXrqCD8gctBoS1TSGDZ+izJHeuo/3wUPLqLtTixtx8FrXqgIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145121; c=relaxed/simple;
	bh=i1Nir7InfvA/at3GhI4EKzhHwxIxjBeywl/Rowj/Ogs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O5yo6zxKFpvvFDy/yf6bZDsl0X4/zbnGV5mTuNGb1w9XCwMOomr1fYSYSVginerx3XU6ekFwxBU0OJE04VoSZG507Uy5WhTgNjA40xdcE1GCmGaPWa6eRoEMV1vKVR1SXPAsGZ42DWbv43dPdIzLd4o5DOqk0K+OtsV1g65FwfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvFukNt3; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvFukNt3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785145119; x=1816681119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i1Nir7InfvA/at3GhI4EKzhHwxIxjBeywl/Rowj/Ogs=;
  b=GvFukNt32/IwJen2Y3Wa6W6Kc5CEfrRQjrOuJ2/tNIpYV/H6ubCjwxF+
   Ght2rYnrHEVlhVuGaSeUnM+FCVcNHo/7q93JqprfO4V85URl0//VjPWiX
   gMQtf7WCGjXIUokX1Sr7Hc4yUaOdYVohaPBHlWr1ZGDd686zWKsxd0g+m
   4wZZQxQfny8dczu9VbDFf97Tjzvn3tFQbyJJ97xTj+WjsKIMaZ30pTLhR
   fVGtywbf1sFDA7Ui+xBwPdyxd534vwlubGAzS7a51n/0c89/t5fYkNd29
   hmfpwXvNL8AZ+xpLzb/6MuyApt6+ILETP9YKO9wLSwjdEbWrs0/XSPMyB
   g==;
X-CSE-ConnectionGUID: tK0jjVHJSfOfvj4FohTtSw==
X-CSE-MsgGUID: qW7yfHa2Re+NiQKbVO4OLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="96297983"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="96297983"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:38:38 -0700
X-CSE-ConnectionGUID: 6GgoiFWrQJGTqJ+Coqhbtw==
X-CSE-MsgGUID: M7VA+m78QruE4ZY80J9F7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="260009916"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 02:38:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:38:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 02:38:37 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 02:38:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFSn/SjLh3RuXVQ41EEPzv9pmh1SQpVMLtLhpjSmkxRRRU/xj1sX2uzweSC6O7ytMDOm7U51C9Hh81BtAmrfizwXtzep12/eaWm7y3o9fRyBpfb70FFKQNNFBSKZBuGEOeXzK/Z9k2sTZ0LHhyyUe9Rx1tApsCR5i0HcLjqwh6TJsNA1VDzboAzWoDcdK2+5UMRyOUUahLuwkMKhsRErAwazKPUqJhOtFTHIikDg+OYAVKvlGj8t2qnCpvPDoGVMWMRAda+KanWNu2MpRtHhjBff+d3h9iTMsDs8OcQhw3WtPktdxJSicE8h4nMi++YQgWo1uXf5v42ZxnzcrYdCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NoieRZCG3B9N/OJ+/x5seo0lC7y21xFHzWVh+OIbrQ=;
 b=RlTPqBzazAsmqqsyMCWJZKdYcFY9YxSAayjW/UrxL4R/QKsSdBecsT7AjKXO4i4cKZaWGPCGVhbrnCMdhuU2nNG+1Fd+4TOAG+QUSbcJFWfGIGiwhq3CBo3n8eJmNpK9T2lePHVQpfB+Pc8n9VM+WNtNrc01zzTFRhxwOWamkDftkqfyuPEiWfuCoI10WqOFjnV3xSWKHOW7OwrhUC5mxK0O/T4/TsXROcOWrjf1YVxfhj+vodQn1LSb3cREeL1E6BhIDaA95T7HyC6mIwrBLSIO0H0vGqaNlXUi6IIOgE4VvYb+3MDwO653IpPj1n5tOWlAlWbQ+e9B8oChdESJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DM4PR11MB7328.namprd11.prod.outlook.com (2603:10b6:8:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 09:38:35 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 09:38:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"oliver.yang@linux.alibaba.com" <oliver.yang@linux.alibaba.com>,
	"zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: RE: [PATCH 1/4] iommu/sva: Set handle->dev before the SVA handle is
 visible
Thread-Topic: [PATCH 1/4] iommu/sva: Set handle->dev before the SVA handle is
 visible
Thread-Index: AQHdHNKBa7yd5pPsO0ijfb6evffGlraBHR/A
Date: Mon, 27 Jul 2026 09:38:35 +0000
Message-ID: <CO1PR11MB4835CBEA67280A7722E8DCA68CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1785050951.git.xueshuai@linux.alibaba.com>
 <c22e9af74d113b110348b995879baf2fd4734fe7.1785050951.git.xueshuai@linux.alibaba.com>
In-Reply-To: <c22e9af74d113b110348b995879baf2fd4734fe7.1785050951.git.xueshuai@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DM4PR11MB7328:EE_
x-ms-office365-filtering-correlation-id: b10a3e8d-2122-472c-ad09-08deebc2d4a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 1DCBJ718hDumz3/2ZqVLelm8uBKdp86jV66imOuY400dAKTEV1TgqAKvP3sSkWJ6ZdRrS/YYTd6xHavQQ8jEv4B6LkY14PwefrOEpFTfOQw7N+9rNSJlKJNggmekY9CujebaktLBQcGdAEU4XNQ1GjezFYF09WK+JA9d1NxDod18ONUz94Ye/EvAnr7aB4OK75UpfZdj/fL/6geBMvA9ncvfzSol/JC4xTt8Adx6kq7BnNOB7PMu6AG9DBro0c8wOGJBFulpkWDmxPKSe2Z1OPBZlWXYpGPlVHj8i9/D0x9xvM8P/Er/Z7Siref+qrIQPI1trByzTp6LyRs/fK/9eSbUcJy/05+cB2vcHvACq7x4WjuImndxczPJ9BsvIcnOl6l9Eia/KmgzuarfoEFL4i4HDv9j17nO1KzmmogFBIpWV5oAxQPZZDRNkutl2CbugPWTpnT5rPfPosdKkm1+HKJWGZfH07TCvr5j82fWFxANWehDS0p4OvsC0eR+brcBjWG0sjOX4W0JMtcQW1K3nfeHc582pHpSpg6BISAWEyhWakxoZLqY0fH4RZqsEcr3Apb6426CGpNty4ro1Ofnomgd5PpF2w8Hb9MP/Y/VtVVCJ35D18g6u+ofFw2IbBA2kJ8mv8qQJuTJCERf+6J9LihFUJMsUuzkZVw4VVrDWEGFJkgkAH4xGOlOhGAZ+e4r9p+DNqbL5NLErRvuMFdS0WP6g3BZgNhF8IHG+OEnxG0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JhJX1nUS0Re1Had5tbv6YnPiDrhTPt2rAbi7dgK96uNxF67zeQuzCCd41640?=
 =?us-ascii?Q?5BmpBu75iG5OXb5oc2Nh9wR82EROc41p2i4ycQhccyW7zZQUf08hoolKbrTx?=
 =?us-ascii?Q?J4rSs80sCTcmHHaRUjOrNtG5n3bAcxkj4LVKF5REMzlMBlM6w0LC9S229JIf?=
 =?us-ascii?Q?opcxgb6pgp4sSM2jxVC2s9kpTccWxyG/Z1v56Idh8crubwsMmMiJiirOld9o?=
 =?us-ascii?Q?6SdiL1gNiXkd2bpJQUvyze+6YdzLCwthTSrq/95zw86qM4Ho7kBOX668Eiy5?=
 =?us-ascii?Q?gvICh5aTuy92Mo+EnFn+ZjY9RhPfs4qCrYsBmqvLRJW0ghQskIsLC0j20+xJ?=
 =?us-ascii?Q?mRJ4lBdb6iPqyKanToc7SMcAHyf95xTCGrAi+OAeGxjwFDg405NZAUyZCjMy?=
 =?us-ascii?Q?CHDIxmc+MCB0jARwLqAq3g4WOEVKGhI3it/VJXKa9wrd45veZIXMtdR9RMdp?=
 =?us-ascii?Q?eohmG/HEVUWcFYBb2mtZ3tLxZe50XcX6CUBoeePnu5gQSQQJ0UGmm0+b5z3/?=
 =?us-ascii?Q?FJ9O/uv/rze+osb97/4N9R3RMS6RFvRI896zfJYuYoMMxgLUOpCMqiVrclOZ?=
 =?us-ascii?Q?qVEpxu2PZWqu8lnjF1m4I1HKFGQPATFJb5UPJ+WvPvhnFh6+H9CxxCa5MKy+?=
 =?us-ascii?Q?bUypRAIf/EExfQ3VKS1OSIfnG77gkxOBaZMeUgR65nFTHkjXrCqylYVLgG04?=
 =?us-ascii?Q?uofUK7G9+ji2Dyz0GXFHMGkOOmKiNyo1tO/qLrYF3x8K4qvPyEDy0S2y6Dx/?=
 =?us-ascii?Q?eLwzPTqmxrblVZJ9ajDW4KP/TWAmFuCsHLboXKgmKmnxY/BLecD9dJNJZ1yU?=
 =?us-ascii?Q?qWr2TrLPzXK8QAyz63VRph5JjKbvOlEhglaFjjrk+YjKhi+E5JBo+Pdlt9xt?=
 =?us-ascii?Q?BRybaqFpbSxtydn5Uc0W6Gj6zeAz2Gnh7cIE76CqN7u0HpCwBh9uIiw6ZZVu?=
 =?us-ascii?Q?DrqYiZaOVXr0qtS5hH4bFUfA4WTXIFqhSVmphNKw2sOV6+jmXQ6ki2iFBxa7?=
 =?us-ascii?Q?bmJDoechJ/JvKGCpWANGsbM7JO1LyGj9EMaTM3SABKkUaEGG51vOxTX2G2VW?=
 =?us-ascii?Q?qJD8yJbw+Kl6brhdr+gW8DK84brR7vHx+R/WTR7jMRHcFq3X+rd3kslM7o6L?=
 =?us-ascii?Q?Nln1wZ2gSq5Wujh5CeetdAkawOQzzykU8iJW89IFG16HywbY1OY7g/+TqEYO?=
 =?us-ascii?Q?8WM8e8/LqU76+lJtR5rUJN2tKG0glgIL0NWavoI825jF+wOwNyF0szbOCw9k?=
 =?us-ascii?Q?YoXkcIeSHxK3uDmS+bIfq1ZARjaGcu9BIo1yvKR62h81ZgyCp+cVSxuVl3+R?=
 =?us-ascii?Q?4wPXdG7i+/2mTNE63EYTeVj+XsnmVCGm1y/F8eehpCOb6ZUyR8DX3flEkL8Y?=
 =?us-ascii?Q?zBKbQA1u0CrbvxRQm1E80E4RWmEdACFx73anxCkOfLkU0P6bNtjVGEoSQ83I?=
 =?us-ascii?Q?67NSIGsgN4JwdT9nyK/3ZIYz1MLsLDaGugY/oZ3gGWxcGygmhNW/SLPgLvvz?=
 =?us-ascii?Q?PDcWT2bHADcJ4+pCH6K+GLqELz/eSx6YrrR54WMxchmO6OO28iKuMPjhViqG?=
 =?us-ascii?Q?Ob4jvJdpgdl+MNXo5eylYcMU9c0kSBUNnfVjjeqyFXe2zHkjfDTUh/cmCP2o?=
 =?us-ascii?Q?T6h576QiqTgnvMj3ZP3dNX2jboUG3c/ZNTaYKxGN8OXwHpFEZEpoyyyfutFD?=
 =?us-ascii?Q?96pL8FuryaQbC3arNtP8YrIEmN4XoYXg7KQSW6GH+ekdZgVFNWRtAQRSbFbv?=
 =?us-ascii?Q?ydxGTbVJlw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LebmYFU8GCiVowrmxox/2YuMrKDi+YfiVmV5AabI7Ku3vjRv9Tpsk4lrovAVg5MPlEf8xEmqDTfWixA76VYEQj1e6iBfOufw3WNkrMxCIVDOniDW7iyd/C6FQN896Ad2SwSCESI3FgL3TDE89eOGbk5jBQ7gDn0pajQY92aEJr5WzRTWKOHUmSnQVLYemAoXFtFOM8JSBtTFj+hamJ1ujf0t28tKOA3pLcLmJRZ32iMCfRXuzhQIv0ciAJHKS0tM4sN0PpbwkdGyjFuaM2m7S1jT9QuDN6C2WQBQ6p4t3T9XR0J35rfz7F2J3C0L3Fa4kV9dcnwnkE/+DcLgtbM0Xw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10a3e8d-2122-472c-ad09-08deebc2d4a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 09:38:35.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JThG8LfilbL2w1yA51+XeuIzB7sbeR6ZVxMSAVPjF3BNMlcEYqGyPiitfjVoLUHRUmv+8nopY/m48mrXsJkqIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7328
X-OriginatorOrg: intel.com

> From: Shuai Xue <xueshuai@linux.alibaba.com>
> Sent: Sunday, July 26, 2026 3:43 PM
>=20
> iommu_attach_device_pasid() installs the new SVA attach handle in the
> group PASID lookup before iommu_sva_bind_device() returns. A concurrent
> bind can therefore find and reuse the same handle after iommu_sva_lock is
> dropped.
>=20
> handle->dev was initialized after dropping iommu_sva_lock. This leaves a
> window where a racing bind can return a handle whose dev pointer is still
> NULL. A subsequent iommu_sva_unbind_device() can then dereference it via
> handle->dev->iommu_group.

ideally this will bail out early:

        mutex_lock(&iommu_sva_lock);
        if (!refcount_dec_and_test(&handle->users)) {
                mutex_unlock(&iommu_sva_lock);
                return;
        }

>=20
> Initialize handle->dev before releasing iommu_sva_lock so any visible SVA
> handle is fully initialized.
>=20
> Fixes: be51b1d6bbff ("iommu/sva: Refactoring
> iommu_sva_bind/unbind_device()")
> Cc: stable@vger.kernel.org
> Assisted-by: Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

but the fix is correct.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
