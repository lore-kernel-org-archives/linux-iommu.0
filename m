Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD738FA3
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 05:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002778; cv=fail; b=Zq06EwxrsncaYYQ3ANBdW9Xzcq6npE5FJUzE/t1wM4XZ15+nNdMwIchgCBwYEVh+bV8ewsAAb32KQeqLlZIQAXEzJY5v6L9borN5O3DoZ8/OLmsdhNkeq+M6kfBMbFxqcf5PKM/s+Cou2dVYzSu1HPAWa5bDHF/vV799G+lTD5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002778; c=relaxed/simple;
	bh=A4Lo9fh6PQ+L6soEus4CsyYQGUNJlKFoVJ4Xjl7zTNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WZ22BtdpSnWc/DKDpO0zbUkUlfjEtStUD0ugH5J+v062+JXfAz3jN0XtfWQwKo2jYPfL6WqjC8aBqx295/8VrukvH4xScy2S9wz+Iz4f/s2ChUiMTZ6jTVjCvGkLCGW8TILSH1G3zs0+UIn1nU02DUwnm4q2T+RFAu6bqoa/4Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9OEEbDe; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9OEEbDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744002777; x=1775538777;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A4Lo9fh6PQ+L6soEus4CsyYQGUNJlKFoVJ4Xjl7zTNk=;
  b=k9OEEbDesUCiQBXmlKNvtWD7ty1inOk9+dkNFUfICU/ykHT/BuxP77jD
   BlCgi0bHggmOzWdf+0wRoQi4C6KyyqysJrPeu29LcrMkCXhQO//1gGzYj
   wQi4O5R26VOnPThdHdn6ZcbTxamEpe0mRRgx/w+ws1YQXbHgtRb/IMFWk
   tahTaPykeOPoiNebXl0DTX53YdXVDsPI0eN5es9WBRSV+tlwwVIXEdgHw
   J3YtwOddFEuXVAGoJwRf1FOdrmP6Ep3wCN2yj890NgRJagvSa6iUVAmRC
   0Wr4fK7nvSrkXhftDlAt/DlG9UwY+Qp8CxoScKsThX/1urb27ZX716cUT
   A==;
X-CSE-ConnectionGUID: Ob+H8h8tT0iklnTRnXT2hA==
X-CSE-MsgGUID: J8lNcVOHTYW0rBWc25wJEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="56738748"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="56738748"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 22:12:56 -0700
X-CSE-ConnectionGUID: hTiNxGzJQYyc2UTS7n8uXw==
X-CSE-MsgGUID: hvPtYfh7Tw+HCdr0Y+lPTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="127820842"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Apr 2025 22:12:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 6 Apr 2025 22:12:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 6 Apr 2025 22:12:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 6 Apr 2025 22:12:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fx9Qs+6nKO+Pk5vVouEbh2R9AAWwPW/x3XUk7BM7yPLAANF3GcW7Or6+QuxJsx5wxCOcYkzxLrrs5otZu9WlKfBCOD2qzK5FPPH8S9AeHx8sH2FDuq+PTp7/Z+7gPn+gKgMyLSkh9MLYU4Yq4LjsBlB8exykNC5/0LsuWk5qST46I7Nr1F/4QgRb42Fmv4F+/QNdVT/JU5nml2y99cVrE7PzZPMrgydsLEi+TLpRQX8zUyMKE31XRLtxHnw5gElfRIPaDfBZzTLTU0RTAsRIPW64Wl1ZwlZtFPkS4eVDF0MezfR0fAxYuJnlIXB++gAVp9nPhXgZVdZeEL3OZA/LIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wY8BMJ3KWfymaq+Gl8N63cWudvxzyNfH58PnswBJt0=;
 b=jVEKQrZ7ynuX65t4T6aMYh2PrQKqg7JmZ5qNtzr1NyqLRCiMcpGGsO1BWioXSVyo1U/cs/X5cfMUVf/Ylrig2qcJCGTNG9STA3gl+G5kBaxrXvzcBsFJkUywa28dSLV96fvHSUFknpFzHU8lZokHAbWW+P+fEbGEqhJYXNyyvdcOJvz/9XIsT9q2KjFi+hiYy+31lxECaI6TdiTRTYCJrvrMyJ/cfknY1l9FcriYFPQNjalGVAx18+4vGyXxhNH7BQavXlc5wKNjLLvWFfJHVlbyopHV/2oxZ8GBTy8hO2Z3iAnqGTHU+Hu9LFnxJzImkixhzMM8+nipASoUcgTdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PR11MB8716.namprd11.prod.outlook.com (2603:10b6:0:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 05:12:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 05:12:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Steve Sistare
	<steven.sistare@oracle.com>
Subject: RE: [PATCH] iommufd: Fix offset handling in folio subroutines
Thread-Topic: [PATCH] iommufd: Fix offset handling in folio subroutines
Thread-Index: AQHbo3DOsg92Qm7uW0m7DGotFoaA6bOXrvkw
Date: Mon, 7 Apr 2025 05:12:52 +0000
Message-ID: <BN9PR11MB5276D77DBCCBE909083B6C738CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250402014408.2760300-1-aik@amd.com>
In-Reply-To: <20250402014408.2760300-1-aik@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PR11MB8716:EE_
x-ms-office365-filtering-correlation-id: 075b1e0e-f3b3-4b87-03fb-08dd7592d93e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mB3G7FAYzbaHOHKeCbZ8L4anYwmwZM2jgtx1tVuoCcHyc89cD4fa26tVt2PR?=
 =?us-ascii?Q?bpe5riQY5wdBJ80lxTQWaPb/WPbDtAzXiijFadfIPUlGOmi61tFn8TA2TLWe?=
 =?us-ascii?Q?rSOcD66IWV+d90D6L+NiEImmxoi+tzXvWN0tDvFPwhLK7cToJNqXmyCdHDlm?=
 =?us-ascii?Q?Dm9SbD4cK7nQge+mIK+8EEoPt9P9UO6Z8uI/VpWUGZctQxo5s9vB31L09OdA?=
 =?us-ascii?Q?4rqUoKeTgmI+VPw5ZAjNIoW9SWR6dBX8bNgk2jEZ2sozGmJ+ZfWk8FFv0jus?=
 =?us-ascii?Q?2TlZFQngLakmelZBYIA1NarVWF1wMmbDoKHb58AK6v65fDdDgFK+H+6yMQl5?=
 =?us-ascii?Q?bbQogpFfZcj6TKHmP02/NJKtGaN7kdYXvdJu7RmHyWlXCqMGlGh5iHe1pTMx?=
 =?us-ascii?Q?62Uv7wTNgdM286MmgQ+Fl+1GDkxkO9LROxUGxgxIqkoqbGEg1nsbj0WdCjp6?=
 =?us-ascii?Q?jz6MoS7DVVm5tLAmlLfnQENU1Zcbep0ekEeQYN+o54tkISnyHClsYVjg1iSS?=
 =?us-ascii?Q?24dhUbeZ7uheS9dGuFekiRIylfCx3T30yesMyPsz/aNCwPksNKaEohX8PyQe?=
 =?us-ascii?Q?jKalyAQDB0SU0M7z5ooKTNiAy+rlFBpivix5d6Wpz/Rq2ZTx6IoSRM3iDMgd?=
 =?us-ascii?Q?e/F8kZZtavUwTznPx/jY+IeTZk3ObAqO0mH9PFHisRJWXiDQZfUTOfdmVdVN?=
 =?us-ascii?Q?e5h64o0CBdtYamtbXi1iOxpv96D/LHk8j89QvD7uCy6we8VulFCUFPTmuN5r?=
 =?us-ascii?Q?q+SWUaQKRryw4aabi44IjyUlUd9saboR71yWNDxima/+U4r/GJBFzkLRKkb3?=
 =?us-ascii?Q?VCPbYOSRRDgNK25OUA6tRH6yLK4fjR5ILtCZZI9jxsBn5lRzUDrsRnF0lC9I?=
 =?us-ascii?Q?xmgIF0VcyGGm2bhgWr4zs5P4QykrHENxp+dh0n6ebdJLUvxquBW0Gmy1J/Bf?=
 =?us-ascii?Q?B+AP2eclusnayYWI0nE6rMoAlBB6FK5aufa7Yj4GsN9smysPJ9sbdDsFMctF?=
 =?us-ascii?Q?LdjhXFc4u093FfmLNtdidQKvf9E0yp8XzhemDLn+6YGeaJ1EhXaOLLoaN9D0?=
 =?us-ascii?Q?o/teb2Zg4TMWi6tUP+6KsH8kyH2CcpypPFFjL8rNsjU65HGv0w0XJdTgBWet?=
 =?us-ascii?Q?/AuLWZ5D5j9n8G32tkwVVXzkLUyZCqkeeUI/z/zVX4SQcvkHQY2uK04Qps2k?=
 =?us-ascii?Q?88F3cUg45WALx+NoN+RznZUKpz8s4y6UkGNZ2GJHOl2Pew7uOgzw72GILfZK?=
 =?us-ascii?Q?pwrMRHl9lwbEM4eXYWwjz0DBVVx2kilZZ3keiRrJKMgnYWBg6TWs/EKhVFS7?=
 =?us-ascii?Q?kMr6VF887+BNIL22GCMb9XmVllee+cNCwxb0C98bG6KLhjM1AtkskeVLxxVH?=
 =?us-ascii?Q?EKv6c7MmqnGlDfl/DO3UnZRkCvQnKgLGz0h0fmhBORtliTGjbKObkV0ESQEH?=
 =?us-ascii?Q?ImXQIEVqMDdDmflM0/FBnz5KQ8V1uETu?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AZ9NrieaMvTii1p1lJi/KoCPXBHqFYuINsMqj84yEgBDa5nBYoVwAlkIXxV0?=
 =?us-ascii?Q?/AyEQVioD/+Ef6WdR2GMyeSa4ExvrXfyMkCxqpBpf1Xqq07SlA9qk7w6btSf?=
 =?us-ascii?Q?8ENDonwBpH34LivQ19RWZnNDsehSR/Dsv50Zdgy/6CkgV90mWcsVbANd872n?=
 =?us-ascii?Q?ybp1LLBWLTsYEwBJv1Ea7lisdyXlAbKUUNgHHSRO8GOEyfZ3x425nwCwcejj?=
 =?us-ascii?Q?PmBbcjCPYnJNV1dIn9cYYEI4V0hhjC9DBHv3e1ZNAM+15+pYQesJ8cp6UiYy?=
 =?us-ascii?Q?lEz5YjVDp8YpkY9JwEbn6nSS5OPkF7JibezAHQQQjln/QUDlL2uwX9aZ6m/r?=
 =?us-ascii?Q?Sk6zOqmg4zUFnxn8RwKLDnWTWvUlB6vnAi7/8VzwxOf6odttlAxR+a70I1xW?=
 =?us-ascii?Q?OI6Y9nQXGNdWLbyQz6hGG3x/KPkcdwRNh1YhZTSugJFwDRQ2r+d2rikdRZzx?=
 =?us-ascii?Q?sxPX27anuWTukQb2b9UmRR7ee87tdOqLInvM8d6P+JJw8axtih1SqmZTfsLI?=
 =?us-ascii?Q?BIklM1clH/k173ParP4tO0RZ1ipWrGtGdQl8RNKVW80+o7/NKCCYjdsdsdeN?=
 =?us-ascii?Q?h2vJLiYwUhzxddLHq4jNMURe3giIcw/wXkHoJsfjuvniwWdh6qH99i4Az1yU?=
 =?us-ascii?Q?N7Qj8cD26mdDEJUQtzCUl1Xli1n98MLu83tS+6amiMIUxc5XRsl5L4ITrJqZ?=
 =?us-ascii?Q?6HMcbDiiGc4BJXibFZdln61HV89nLtaqq8erTSxuukZK9i3MjY1+2jvoL3kG?=
 =?us-ascii?Q?pH+5d758hZBc6t5AECTRWEe3LneY8X4SU0BscajhFfEDwfSy3SmHKGg7HLsh?=
 =?us-ascii?Q?+DRefckNi52WjJuSH+8KHEnFN4XaQ2TBety3HVNrREvc35+MzfAbXAq/4VFy?=
 =?us-ascii?Q?I72fhk4I8+/mfuMw280ejiej9+FW5+mwC32NFuwyowMQBjxlXF8Sx7w16/IF?=
 =?us-ascii?Q?m/jD92mUSBqQeo3bOQI5mECT4am9DxQWalXWC7iIl2e75YEZ88aJ7NWagNHd?=
 =?us-ascii?Q?+cUrqWGW8jNdk/r7Zz81HHalVMqVtS/uvYT7HD8HFxvxuGeCBu8iTYpsk3Kk?=
 =?us-ascii?Q?84RRZ953/dcFJkATaqpHT3ReHFs7s43yCXxoKzZv75hBDBesJArF9DbuFSjR?=
 =?us-ascii?Q?B3JZqQW5YLwoZG0O+FDXo7CNhWOecjccFonmvbonBGvNAkUbPsx1QOzIxJY2?=
 =?us-ascii?Q?6/JuFok+IpQ0peawhOHYiAoE6B6KDoTwL1QjaPGUQVMqqurkO9pcfw5TeLdZ?=
 =?us-ascii?Q?/2Fu0ot8SYAxEHaTL1XHNoNK2WcAS0s1Vg+BUMJ18ps26vN4hBKABqDl/8FP?=
 =?us-ascii?Q?Ti7bPOghLKlFFuSucworDX2DK60oYW8q0CwWt14wzdV5SpkLZGSp9KLXkN8Q?=
 =?us-ascii?Q?0rXttHzWOTozj/Dj8Y7OEaC+zotVzakb85r/Put+GSs3jQ2QRjxRiBcyJPeM?=
 =?us-ascii?Q?441rTGflFyTrqtsFlgxJTCcc8oz6VfKIxxaLFNqTT6dyUhsp7JxL4L1QEuB9?=
 =?us-ascii?Q?if7YXXEb/Lo2T68m/x52GUZnIFYDTKEvU0++hbCNn6P88otIL2YBXdnIJN7b?=
 =?us-ascii?Q?QZvgSfINZCpG5VdmfIchv/ELE7neidKVF1Pd1kbi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 075b1e0e-f3b3-4b87-03fb-08dd7592d93e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 05:12:52.6369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhzZjAjGtyG7bk5C+txMFqKwHZaHMlpTRQ4A7wE3QYiWM0ez0XXlkwgXH07+zL71UO3o2tw3FWetvAiEwu+HpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8716
X-OriginatorOrg: intel.com

> From: Alexey Kardashevskiy <aik@amd.com>
> Sent: Wednesday, April 2, 2025 9:44 AM
>=20
> The @offset from memfd_pin_folios() is pgoff_t and is bytes, not
> a number of pages as batch_from_folios() treats it.
>=20
> Convert byte offset to pfn offset and use that.
>=20
> Fixes: ed9178fbfd4e ("iommufd: Folio subroutines")
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>=20
> Found this when tried mapping a bunch of folios (>64) with an offset and
> the first folio was used for all the mappings in the batch.
>=20
> ---
>  drivers/iommu/iommufd/pages.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/iommufd/pages.c
> b/drivers/iommu/iommufd/pages.c
> index 3427749bc5ce..6075d11691a6 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -646,8 +646,9 @@ static int batch_from_folios(struct pfn_batch *batch,
> struct folio ***folios_p,
>=20
>  	while (npages) {
>  		struct folio *folio =3D *folios;
> -		unsigned long nr =3D folio_nr_pages(folio) - offset;
> -		unsigned long pfn =3D page_to_pfn(folio_page(folio, offset));
> +		unsigned long offset_nr =3D offset >> PAGE_SHIFT;
> +		unsigned long nr =3D folio_nr_pages(folio) - offset_nr;
> +		unsigned long pfn =3D page_to_pfn(folio_page(folio, offset_nr));

pin_memfd_pages():
	nfolios =3D memfd_pin_folios(user->file, start, end, user->ufolios,
				      nfolios, &offset);
	offset >>=3D PAGE_SHIFT;
	user->ufolios_next =3D user->ufolios;
	user->ufolios_offset =3D offset;

pfn_reader_fill_span():
	if (!user->file)
		batch_from_pages(&pfns->batch, user->upages + start_index,
				    npages);
	else
		rc =3D batch_from_folios(&pfns->batch, &user->ufolios_next,
					&user->ufolios_offset, npages);=20

So the offset is already about a page number as batch_from_folios() expects=
.

>=20
>  		nr =3D min(nr, npages);
>  		npages -=3D nr;
> --
> 2.47.1

