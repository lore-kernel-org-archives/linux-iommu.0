Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6418DF69
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844736; cv=fail; b=oRGS2BWf+iCqqxdMgnAwRXQeOA+7FQHKoQn8kobC6Eix79IRkp14vyrxjF8LvS4mBIfLBKS5nb73OchrZ/OravW7nkEKsd+QBLGq3psH8PLhvRH0KHmjTap/8KLXq6BM7qjZFSLAKmGu6Ix12Xy0uhNVcb0AuYZaKcvkOMrG8xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844736; c=relaxed/simple;
	bh=lBSBGquB7CGT/GarTULTWDF1PLxOAIH0sj0lrw3I8XQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hp6ya8h8n2j1ax9FGltrBe0Z5tsLzsDiW6dt38O6Se12ObIuX2jtLLfYQoUDtjdDBWSPqi8tC9O4NhQU+0RR1in1zU6f15xo256gEuucPlM8W2JhX1FwLy/+pCpSRk7i6sLfZdG4/TpkX2GLiEAAU/JnUjvEF8hRF0J4HZMPyyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfWkcK00; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfWkcK00"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729844734; x=1761380734;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lBSBGquB7CGT/GarTULTWDF1PLxOAIH0sj0lrw3I8XQ=;
  b=IfWkcK00we5QNEBoVUlkBcqthF23pX+vSDauDqivh7iHLUHHtah8H67i
   wqFiWYc2iOtznB/MAdSwUG26nw1sHlvKKNE4WQ4eXCNDBK3lOOGBrTPgd
   lmA0WL5B5LUTlI7sVgiS7+dRu7XCFrqZZ4fxHGBjXlk4QZlbrSLe61viY
   CYEg4dXcjMjRv+gy0Y8HYjUKmdKaHCSXJYAGDFOpIQqPHsAsb4rm+MycQ
   qYS3GXRp40jkzQ8lSwCjZIK52D4zuUiAzzspmKXBQuc0Y/K7HE06Y3ghr
   PGGbkMRQN2YzHZGBoX/40ZdgFdXGcbiipBlfciVqal5Mf4yxfoTAv6fWW
   w==;
X-CSE-ConnectionGUID: pZ3J+zkGRsioROrj+VTnaw==
X-CSE-MsgGUID: SEE6GZReQCCJpIzSPIZzUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29623202"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29623202"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:25:25 -0700
X-CSE-ConnectionGUID: XV0FJCOBR6qBJYHWrrl4mA==
X-CSE-MsgGUID: 2euD8X9wRWWXILpfxFxUFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="111689253"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:25:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:25:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:25:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:25:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6GCrfU4xXUgQRNdkPhAOGvHZVJ4z+mjSA1GqztjmC/Zn84OKlbPyUB9qXP4I6sSj4bF/j+B7X+w3aWMUB/xLQa6ERaH+bom3i6NLSOjxZ7PaeJ0MFJzay6PD/tnq6es3zetw6Rt4rbRTcK2zpoGbtNyx2nFY/Uoize6KPUi0LnrH9/UaaRxcuB5Z3RYAU8gWFeC8w+BOOOh+Yb4ktbHjblNlv1i8H9QYuBpa/K+t39Z/yMI53CXRfLpJMFXHvpWda2dv7Tt11iRuT3z4aXM1aJiDiBBLc/fD4cfNMoAa26irR+egf6QKEl2ZPzfsZX8ONNFGmuVVQJ+Mj51pobUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBSBGquB7CGT/GarTULTWDF1PLxOAIH0sj0lrw3I8XQ=;
 b=hg+VNK6GMp/vbsyNesr6tL0y4gkXKOUoZ5gfpYsZ+QR2c2peqMoOZw9h9h+xENexEfW7Vi6DcsYJZefNkjOZmZMH6sE1ZKsU4PHvQK+IzTeiDdMwpu4NX3gvhPUpMmPIDMCafAFlQ/BmxByjziGockFzhxnvYkCcqb+XVYoPVuBmY4fEI9Qb8GopCogY6uqRduBoqLf76AgZr/tyuyxxV1S26IE5FJGivLv2Nag0QFe70dNsK4Xwm9r34Qycv6jnnK+0D6WcG/co/Q2vdPlv9FpAxoY2JDIPZYjGaiKZB5VQPl4F2exbESxRtO5xSZK0MF/wzCLhUlYXWvXmz4zBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:25:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:25:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 11/12] iommu: Put domain allocation in
 __iommu_group_alloc_blocking_domain()
Thread-Topic: [PATCH v4 11/12] iommu: Put domain allocation in
 __iommu_group_alloc_blocking_domain()
Thread-Index: AQHbJTi8IgN+a3cWDE22Ah9nXU1qo7KXJFSg
Date: Fri, 25 Oct 2024 08:25:22 +0000
Message-ID: <BN9PR11MB52767C6B87C70228F7EF32F18C4F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-12-vasant.hegde@amd.com>
In-Reply-To: <20241023104207.5894-12-vasant.hegde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4754:EE_
x-ms-office365-filtering-correlation-id: bbd4380a-c036-4d0e-6e2f-08dcf4ce91a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?l/NXp1V+gcHYynW9xP9UO0u8z/x7Hy+ZyuRALpcW3kK/dPFMXGZBKYAqq38T?=
 =?us-ascii?Q?MEECzILYRAJulGPduyBLiy13+O2pW0x9ZR+/PUoqmvvHarqUNKrMTU9U6H1G?=
 =?us-ascii?Q?+gM0IH10DS8qxgvGO2P7vXB2s2m/FG8FaUcouyDvoK9dyQqeIOKb+4SmkLdo?=
 =?us-ascii?Q?vYVr7r8rp8JXqIqyBvFdmPt89WwYcoeU3gfzrgRlZDubTiP1KeTRdcx43Wb2?=
 =?us-ascii?Q?N3/AXaI7r6jxMTTfUvY2CLuTdTcGB4jbChNSJ779opCtPSr1YL6sWZCHAAVK?=
 =?us-ascii?Q?B7yQFOA/Mdg0/1OZIVEhz7bmeKN+P1vcQaoOq9SW+KzlG8K197rGoF+YagqI?=
 =?us-ascii?Q?ycylf2FxypJk6txbB7WYBrYFHeBOF/MiSk4yZeGfyTtGVIMakxH3k6nxapkY?=
 =?us-ascii?Q?oubqC2zI0zcVrvDyrhFZq074X7MgNjMSWWvtcR9FdCdo8yK4rp/oDwRgMSQs?=
 =?us-ascii?Q?ucktpOWpAeIA4Bkzf6LF1KOX7A68vTxccwTSDGfA2PZT7pn4faCF+pbD/tJM?=
 =?us-ascii?Q?qH90xRj1clYTIQ+RMCmf5nFC0YuqUz8bTvapkMmg7xCeC+pWPeOt3nspUPCO?=
 =?us-ascii?Q?B2hILKpsFy5WSx39v555Fdx3K12vwPwxEi9pa1C9cBZ2u5cBq6x3t8h2bu9y?=
 =?us-ascii?Q?e4IbyF/uRRx3LFNVtkHOwFq+fUwx3rMsQkwhAcZy7ugP/Y6gyUJClm2a61pM?=
 =?us-ascii?Q?pzVF0bTXI8dbUbbNDd0vEsa/BSROQ2FEVyUz2l19a+YH0fZe77YmgnUl0+/A?=
 =?us-ascii?Q?MCXj/5Sc7D9VcqUHgdwFB5AWVMbN2t1Zf52fz2NsG7+/YnCFf1l2laUgu5We?=
 =?us-ascii?Q?bZg9K8ijve3FgU+MLJRApM7IHmTecJUbSF7enrZ2Nqjyia9/3OFVnq00T7DE?=
 =?us-ascii?Q?uoJWyvC2h5PIIJ/Cx4zzvE35rGmoYqki3BmmQH19hhO+Mpql/hZfCX+NvSdx?=
 =?us-ascii?Q?Q4bEkn/OayAe+3l6QVANUAHxWFOLAquJHrrv13KGZIRF5ZjTvAovec7iJoGv?=
 =?us-ascii?Q?zIqSp5IGz/esHMXBW1TNl6qQgA/6g0HtKfZUsVbf+G6sV0aZUysf7J4HY2f/?=
 =?us-ascii?Q?3YULmS9zPvBctk8WfCRQxjGZC4SWG26z+nOCXLUE5pPHZCKrUb/32D/x2dCa?=
 =?us-ascii?Q?AKU25w9XdMZ1OVLt0wejNHIGKFeJb6A+oxdVGtbVY3tX3+lhRe7AByfaCmvG?=
 =?us-ascii?Q?fOY3RdQ80EX77GzbDSq4JNjECH77Kcx4v062Au4MhUixOGj7B/JmhAAZES+i?=
 =?us-ascii?Q?j2vy3anQI5YcORyhalP43e4yD8N/8dmFyJ/xPwdztdbN4/oTnOqDd0L68j8R?=
 =?us-ascii?Q?bcLaDTukTy22qXaR+3jSZRzxm9WQVIyaIMhNRjjmFKamUR/Y7WSXG0NUNCGA?=
 =?us-ascii?Q?tICbxfM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hpff6oeYOtyldpqmYAyT9IFHESIMO6K5XFRCGLmyiBI6V9w90qHCEm0T1Rmk?=
 =?us-ascii?Q?1K5jHHwHBWwdqhgD0iU6JZHY3NJtvUXa/rEuYwG4JMXDmbsi3QnA9mcixHAP?=
 =?us-ascii?Q?Ed8vGwUgNOHAa68348cl1Dl3mNND/ggYXPPCglF8hVgWveUbFi3JqvtQf5pb?=
 =?us-ascii?Q?nnlCUy7kV0AukUv1BEskuvCNqpJQVPF4xd57gFuLqtCdRFU1AEYggBYATyq6?=
 =?us-ascii?Q?f9vW9kh49aAoCdMUA5B4pfYHktej0KjlP+t0xIfijpBB+QI6VZrR3WvkmFOm?=
 =?us-ascii?Q?f7OKeNXXKIWsfegEOOhBaxQJ2H2QgNxbeBeK/CAhCK6wu96aWFRUNGM6rdpx?=
 =?us-ascii?Q?ypevercwti73nwlNPUBUIwkwgiqNlVu2C4Uv4TlhMN8FdMgjIA5J430FgRtU?=
 =?us-ascii?Q?N3SdILAVP/3EHMECLKGjOZpedWdOH3zITQoabcH5qI2nvhseIdAaBAcLzikC?=
 =?us-ascii?Q?fxWOoJ4JThxI6d5ZDSLcnr+OA5YPm1JoanDXe0ebr6DzyAZn0fng+7w48+mu?=
 =?us-ascii?Q?A312XFsbu9gUIIBjVWDtncpqHOOq5h25ZrjKWJFGN7PRvZYGP2/XI+m6Twpn?=
 =?us-ascii?Q?+q7lI/Kc4TTiiRE0Z93OCpHD7C2I8SLhu5NVeN3E+NYTAuWFi+x1O79LMXqg?=
 =?us-ascii?Q?jeAZDTwu3OfPZaqfhVg7SvToJWa2y0irlE/8eDc2PiN+gBvS2r488SdpuotV?=
 =?us-ascii?Q?VNkKDxltBe/w9abnYqcjYiICCFbRcAvW2heqMaZ1YqkSs2lNtzHFV/cgexca?=
 =?us-ascii?Q?nHDf7xVjFCEE1X6Nzuo8wXx/hQBfrfEOUJR6LYIXd2EUeh473lAhc9S+bf/m?=
 =?us-ascii?Q?hySKJPiL99h3aBw7J6pSydQr6YSPDzGW+TH+9N3gbtSVOCtskBpLBTP2Bd1B?=
 =?us-ascii?Q?BVw1NGmMaP+y5/Sj6/sogujNOmcrq02GaWnMEQo+SfYdbBCZ9/De/ices/NN?=
 =?us-ascii?Q?XTq2hqM7sT8ksbqsWzfoa7MCrRvk6Lh2Owpt1aaFHBheNXoQbBgA97kmGmMg?=
 =?us-ascii?Q?onssg37t20yOQ7D07ReKlWLm3O8jcQ0KMHjlt8jeK3Rjk09VIiS+NACqLUKl?=
 =?us-ascii?Q?/fzf3moW5Xo5x8JRwYC4WRMNyl8c1v3Ye2GhS+uEvwlQtGvJOV3KFMS3zVTu?=
 =?us-ascii?Q?775OVNRzbPSyJPwV2FuQgzkL/XChADGw0XJ6bLJ21PCixeUkcb1HWGD0dDks?=
 =?us-ascii?Q?h8Ccwqppa/x4DzlxVZEjS4YWgHZcN4UfR/dOF9EBz+Og6dkJCMnVBRYwNg4r?=
 =?us-ascii?Q?GTMkrL8ek5Ao7XyKCYXwuhKDyOrqo68T34vAUTCrdHVnYXWfJKc7zDJuGtMY?=
 =?us-ascii?Q?K+BXxMzgmyHLKxONuIqmwZTCyYTp5M3IWrWlYYNxPa1Ctza2mBY3Fr/iqz7+?=
 =?us-ascii?Q?CjT2PJYDT7S5KBYV3pNMTb8N3chqKslqXFTYi2gFQZ45gz9qZ/FHcSj/fjWv?=
 =?us-ascii?Q?hMy7l1wg+0z4NGu39wLdCESqW8irU0VvyoGTSy/U6e37LuRvMmsaTaQdWQrH?=
 =?us-ascii?Q?YM+ww+n2ENhnYJ790WJCP0PQFvkX93nnZRysjJs6ykvgfvdZMGnbRt36IeXF?=
 =?us-ascii?Q?nE9gQY3eOFair2jPCyV2A/MdHjX4tGMXefbNdj0a?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd4380a-c036-4d0e-6e2f-08dcf4ce91a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:25:22.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4HfbSJtAySW/TNaWVxqJ4sV3FTlv9qCmiJiip9M591Htow8d/S6Zdc5bXoypc6hrqfzz6gcfTdXZZoIXUylqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com

> From: Vasant Hegde <vasant.hegde@amd.com>
> Sent: Wednesday, October 23, 2024 6:42 PM
>=20
> From: Jason Gunthorpe <jgg@nvidia.com>
>=20
> There is no longer a reason to call __iommu_domain_alloc() to allocate
> the blocking domain. All drivers that support a native blocking domain
> provide it via the ops, for other drivers we should call
> iommu_paging_domain_alloc().
>=20
> __iommu_group_alloc_blocking_domain() is the only place that allocates
> an BLOCKED domain, so move the ops->blocked_domain logic there.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
