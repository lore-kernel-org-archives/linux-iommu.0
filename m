Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BD3C38
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882701; cv=fail; b=JTB1Fh4fhm67et5v37x/k19A5jJJ7TaEhEFPhUhrrUutgPNCxh8mNeQ5if65KYBtcLWFk2ozzPwyd4VZGOYwX22I83uM0r2OEW5EKSERgW7FaI+Qe2v7bFes0wr4cRVhF635XOQS85h9tZbid2Q9KKc5Pgj16ACoJ5HPtBFxzH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882701; c=relaxed/simple;
	bh=04qc49nUH3Rzr0m4VGecS7w5hc0/rfOhbfvzr9nq2Rc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f554ad7GkU4kMs6QQtS925X/812cr4rz/6b2b2367wUGxzaJ/tBoO9t3IKnaHIo//zaQz4VDOnL/gOu9LFvUey56eEGAltlUdXf3UD3Y4i5txtSkpjEeY6Z2Fq3OkUPTNyUUKamedXQ5yUAE+tAsfck98I8/bonSkKgIQdo9RAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsLdmoLC; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsLdmoLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719882696; x=1751418696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=04qc49nUH3Rzr0m4VGecS7w5hc0/rfOhbfvzr9nq2Rc=;
  b=UsLdmoLCxchJ0YVV9iA3BtwoYk6f8omXbC+cHrk4lSR5jQM8h1A5j0Y9
   umncKvXoMzGczIEBw9VMPf4CnEhrAsfaO5srLR1j0d3C9z501XBi/L/Ao
   DL4notvgDdBJAbp/3rTTJTpGNMbupQsMRJekJJIsMq7hUTNKnUsUC/LvP
   FalbOM2u0KC25XfLzryDKNc7ML0G02smDOXyI6IjIhsubyPt7zS0BFK6n
   q8lp5zhjGR0NQThhE7oiDq8ysKL4ZAKyiFo6lZ15Svvi5SoEU01Era0uG
   /swv4/GBGNAQouQlZqSBP5ekA9CHWE6EGgRKyYnXGMNrms3SmItMRv2tv
   A==;
X-CSE-ConnectionGUID: dglvwEB1Q3KFX+69qbXUyQ==
X-CSE-MsgGUID: OrfneAwSRD66eEmRS1PbOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="12347870"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="12347870"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 18:11:35 -0700
X-CSE-ConnectionGUID: 1aS3JQ3kTCSGoHQ8+sqliw==
X-CSE-MsgGUID: WLx7t2cwRP2KJwFzu8gzGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="45511198"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 18:11:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 18:11:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 18:11:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 18:11:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS65euFPp/LB2R6/GC5SKJ/LXgmh7bfutmnHVQ53fNhvPqd8QmdaXMGsflpcC9jv2qWG/31Zn5wwEZKLjZ13/jLugqGQZcunlHsvIcC62d39q/PS+WynrqJio/n8XbExiHlSXvNbveRh9x2QI8VnbZtPFna3wITVleFGc9WVpfYwPgiM3zzT1/l9j5H2BwuUgNYUWmKvz5HzSn6idrc9iREawDbfnoBASyf7jBRnmAUZw9obi9wkjTAh2k9wdlzTagWYB9h8pVTbGX9NFjgx8IlmQx3CZuU6p7f4pbB54Vowf2VOVhxZ/XyaOml7eWkhHnHUfkfsSoLB+S/3GdB4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4JSkPuZ06juAT5My5WwCzh1qSlgVBTju6E+jKxWlSo=;
 b=NGp46mKYygjNazho/Wb1nX+lYzpKRNlo/36iZCA2bpDEutl1oOzBg4CMepChv1y/GorYhR/lesAz1wmDjZ3iscD0U4YjZ2lg19IxUlILCxXe3sXDQVy8OvJfRnY6/3eJeFJeWYYebQtxHD0SG/rC4VvgUJ8maZTQrDV6/DgKkhB9uxtWN1AysVHssnNkGyy7rWXNz6nWfn/2ffAN16u28qDRs1oh9OdkfsHDo7U0AHV5kziADnvV6rNCo7j6pMz++3QCbDCgre4NiDDJJVIEbR8g3gPRh4H0AjaP6A4fattXPxo1/IzNRIDyAhzw0U8ITJ2lXwtgmUglf+lPNBwh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 01:11:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 01:11:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for context
 change
Thread-Topic: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for
 context change
Thread-Index: AQHay6mHOOHyxhjIZkya4OXhJi0laLHilLXQ
Date: Tue, 2 Jul 2024 01:11:32 +0000
Message-ID: <BN9PR11MB5276502F9B5AB45EE9BF28628CDC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
 <20240701112317.94022-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240701112317.94022-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB6850:EE_
x-ms-office365-filtering-correlation-id: 30e3d247-faaa-4ab8-4c44-08dc9a33e93e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PjitET+AZd0inD0tZ3rHq35FktC3hZdKMGrCQqlynGqJaxxpiS1xSuFusfbV?=
 =?us-ascii?Q?bsoGgy4wFM1QKlqJuzcGLkK78uoQCz4B8dBJA1rqd0bLr5l1HsEp1/XiwQ5P?=
 =?us-ascii?Q?MCE/R1Q8yawb319ygPFQUNDEKoBuSkXWIQCctcpTxkEBIov9SkbXCPTAfzUw?=
 =?us-ascii?Q?00M1vDZDrB9TApKABt+0Y44f+M8oJMRHWKdr0W+76sZkYvLzcV00UC7bHpbv?=
 =?us-ascii?Q?xSpajDX6NRWmqZdPc4AMdylA9EOUP8Qa/VrKsXFawyN9RXMkL8asVv+MbHFj?=
 =?us-ascii?Q?e4utXX4VZbFwfYx8agrygDdUCg4R+C787WGyM0ITulbVdbAk3xagDrDBKOAz?=
 =?us-ascii?Q?d6LnvHHkXLx7fWFa3AOa/uSAa9b7NOYY9JInDf8eLnDjbwdw2iwsTi73K3hO?=
 =?us-ascii?Q?iEeX2oCAU/Q57bjcMdZDketjwvLCsKLf7kp1kVSdU0HUJhze1gNhojq9wTfq?=
 =?us-ascii?Q?3KNM2Kjj3Jv1oxejihCdnJLUlyBiDHBGfY/sKnZ3nM4EWHYCK/6+pzeif5Ui?=
 =?us-ascii?Q?i8TfVK3ek1BvRtbS0aI44qL0HdR6gs02edj50PkC5tcRRnEdHbD4zTxOIx/T?=
 =?us-ascii?Q?t8DdUYm1zpDQwox2nSo/EzTnLjUge6QMu10t7mc+HQd6Npm3aQRCoAi0NefD?=
 =?us-ascii?Q?/SnyeWtr51sbHwCVEkzRvx+1oXRyYp5JVP1d9gTBfhEUUf1nJ5LKEmXRpyGq?=
 =?us-ascii?Q?WUEJwcpj7WH6kLS6oBsAphBCDetQx0qI2yXyozopXlaMOTpZM9owCDFDBYUS?=
 =?us-ascii?Q?DGwQDyPbzjTQC+nZXv/+3qkoo1zQV6v/xGTOGqReiCwF1kIVNCPD0Dcw1IH6?=
 =?us-ascii?Q?CvHX+74CqHeK2NF2+4myCNEu0dmVyNCZaV7OP1u+wgilQWF9ceifjPVR1+CB?=
 =?us-ascii?Q?meCsDox5Kvp46FaFiEkIjPPGYN4dNmGNumIfA8HQJ7+GzRNlfIrltSXI2IHt?=
 =?us-ascii?Q?6t0vOnpVKtL05Cv/b+SVra02/+5/2VB2e8WVR8xdq1z3BhTAdw1V2kZhWIAO?=
 =?us-ascii?Q?eh9xcL8pZKJqZi3Hxg8xZkeLrN7l2TeTyj1zoJANnyo7QbQ78SUtyEMCIigh?=
 =?us-ascii?Q?boGRmAUr2cxrRbiTXjuxc3lZAasAZGgLkrxO2A9j3t+OKf8JpCrxjXBc9tIF?=
 =?us-ascii?Q?dMZjwuAhvDsJkB4CKcFh+NW/Ezd7sjyWvGqNN+7c+SHKtImG5LZf4Ppa7ULR?=
 =?us-ascii?Q?/o3KRHl6MCmdfURCND82QJHwYYvjN35H/AkJDaEduhVLYLFyyLKOVGV2Ie3Z?=
 =?us-ascii?Q?dmYSViDc6IiNSXJIRlZjxi9xXTVRJnItqZdBzllG7nacOD+e9y5c9R0tXTfH?=
 =?us-ascii?Q?+StNlRr58Xe1tAwfzomOsNBdKpzv8CepV8qXoDNrP47aLXNznVlQQrwfyx9p?=
 =?us-ascii?Q?Guv4TH6wZm+K4Pmzdl4Abmim5iOkbMy9/w1cT4sftnxh+E6cQA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I/b3Vfx3iari7+Zx7u37jAnlsA2RXlksdRmFGmCLhlia+K0RjNMKvvSVY/6F?=
 =?us-ascii?Q?6Tv7J1BBiTNnLVrLXNUimGlz40o67DDlYJIhbvsLn7+AUD6OaPTT+cST5Row?=
 =?us-ascii?Q?oH3FfOCzHzrALiO1t2gPXxJFZAX+gz0s7Nw/h8rGq4JsepSniv/75hpf473Y?=
 =?us-ascii?Q?GUsOoksyVCIPwIo5gHZxl1ntQQ3hg23s+2nUn8ZvEC8URSquWG2AJ6HiJN9p?=
 =?us-ascii?Q?co5pwnmqSVuthCMgwelOKneM9qYGRrVl150YSUXpbLo0r38pzNc1aKiw9KCw?=
 =?us-ascii?Q?REHUdRwSsXQnPLX2XrL22H/+HbRVVnqgJ52PrHwsz2N/Npm+x4CuMxokCpkO?=
 =?us-ascii?Q?abslbDx+k9wggJ0wv3wF5sJ88lhoHyeuzc1oCMe2aNeIzIcJ7xxaTUKAr/Tv?=
 =?us-ascii?Q?FqBu+z6mdOoK0Uhz8qAd0J/3TiulSATyFAzul8DBVBWSx4EHKMhKivbmLMLJ?=
 =?us-ascii?Q?euP18Y06wKT3UgydFEefn3zpMZ0of/xH1Q+sWPYSEU/uG/IPtShmRtNYZBbl?=
 =?us-ascii?Q?XzS5FavOehpGZl4zf4zSzrXvZ9t/8qVgc4nU7Ijc7toeBU9jGpzBoSJa710c?=
 =?us-ascii?Q?sapY77vzcXKK8NjIhs04TCwJ+Ev/dwCYe7j296I4PpCAiwdrycgHeyVPmhyM?=
 =?us-ascii?Q?5+iWZVZ2XdklmUEOt1/9a/bunhccjpJH0Dtaxyao5l2BPcodxzsU1VNMb3UF?=
 =?us-ascii?Q?d8h7W06CpCiFnYnShrC8qvaBdDo4Hc4w1eEBR5zTlcIsHT4eec1PjW5r8xss?=
 =?us-ascii?Q?+WjjtFQw/7nXfKWnneVUxU3TvmhLwUEfUw3SvZzxcMeaXkASpckbfZSfMa3F?=
 =?us-ascii?Q?NlX7cyi1xKkHh2l8sJuu3WjIgkBGcuaUbGRZsmXDhGzTLCCY6lwUv5gM1yVb?=
 =?us-ascii?Q?Ujl9M1rUKW7QwLS/u7/YZ07lM5z2WPonV0FlBu2kbFkUm/m5SjA6zL0zMFJT?=
 =?us-ascii?Q?HhF3oDZlodvkCJEvr5v/puazmiBrPSaaru6pgXTojyzD77cg17kMQuOmRoyf?=
 =?us-ascii?Q?XWMN+kub27bY61rdNYb2lUbsHZT50AHPliUD+frTECjva8z6igvneNoXXuyf?=
 =?us-ascii?Q?BPZKw7ELcYWrEVvs59cnLocSl9cVBtCaeLDXcLC8hlfdN56ReEP7eIizoWkP?=
 =?us-ascii?Q?WLz2z2hEGW/Pu8Wad+5Ujt7UICo/bC9lat3GmAlfUDeetNPqd92WgcnfSpT+?=
 =?us-ascii?Q?IJVWiZeqIGegCxxAn+lQDJVzf6ow88qlMJib1uCC8caLnHQzotf8LXkYUBxD?=
 =?us-ascii?Q?76i8uZjNBrdvEQgUgizGv/O62cVMaKgCrin/lGstnKo3wKQcK5QtdnaRaNSN?=
 =?us-ascii?Q?0bDMHvA4IZQAuy7iLmSMGXgct9fG8lkWUy7pVyB5L1xw8W1idYyvh6hhdUDF?=
 =?us-ascii?Q?ysnjlVYCmutkkafaWhLzpeFh/+6OdrstZDe4pIbhjLq2kVOZfiI4XlCCybpi?=
 =?us-ascii?Q?ksEWf8e+EKo/EsSxDvitcFoeLFTxxsXfZYOPirgs22zvwIZWg/G7lrHNtaGO?=
 =?us-ascii?Q?CEOR+ma3J7sURglu72I0T1UA3jOiwJ0wHy0lshtZPaHCWRtEWKtJJ6EnFYm8?=
 =?us-ascii?Q?m23eSSvPmYT+coSBtxSgthxoE3mdnoSipWAbahGP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e3d247-faaa-4ab8-4c44-08dc9a33e93e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 01:11:32.6589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuwI8PoeL85c23XihFMuBEmszRYy+r7uO8mDhluVCYDzsQRbZWNUbEvLQ8JuGpWAaxrZHGPdQ2JE4bo4JZ0saA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, July 1, 2024 7:23 PM
> +
> +	/*
> +	 * For scalable mode:
> +	 * - Domain-selective PASID-cache invalidation to affected domains
> +	 * - Domain-selective IOTLB invalidation to affected domains
> +	 * - Global Device-TLB invalidation to affected functions
> +	 */
> +	if (flush_domains) {
> +		/*
> +		 * If the IOMMU is running in scalable mode and there might
> +		 * be potential PASID translations, the caller should hold
> +		 * the lock to ensure that context changes and cache flushes
> +		 * are atomic.
> +		 */
> +		assert_spin_locked(&iommu->lock);
> +		for (i =3D 0; i < info->pasid_table->max_pasid; i++) {
> +			pte =3D intel_pasid_get_entry(info->dev, i);
> +			if (!pte || !pasid_pte_is_present(pte))
> +				continue;
> +
> +			did =3D pasid_get_domain_id(pte);
> +			qi_flush_pasid_cache(iommu, did,
> QI_PC_ALL_PASIDS, 0);
> +			iommu->flush.flush_iotlb(iommu, did, 0, 0,
> DMA_TLB_DSI_FLUSH);
> +		}
> +	}
> +
> +	__context_flush_dev_iotlb(info);
> +}

this only invalidates devtlb w/o PASID. We miss a pasid devtlb invalidation
with global bit set.

otherwise this looks good:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
