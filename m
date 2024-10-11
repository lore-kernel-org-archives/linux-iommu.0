Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E362581
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728623197; cv=fail; b=i3nMdS8Bc1GhCf7BG+wtTXv/qccsjNHgMb46gJ/f3Gc3kADxNPmpRwxbCHEf0PUWm26TWMe67cLWeGGAW/6qv87n+MZev76diTHeWToFMhtUgdUmlExch4QhIIQM3/KQ9nksosuqwSRLNAH49ltyQ44KBtf7bzITgZ3zYBg3Nyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728623197; c=relaxed/simple;
	bh=sBpU2GOHw5Ru9EAUs8HAto33vqf/S4Yz5j0+bp3uYH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XfP4eLRAoiH9AtH7/R4qjKgYQWR0mCiH9fCjrtctHkumKYqD64fylVaNu23IMwt0mgNVkaoo1Phk+0RNyYzW1TGDiMGL6zKH5gjcbnPnFgclcANm0XWBFsy5lJjyhzb4BI5BiPPRZMefeMrOdYGwBm1yTEBdaIlq3pfxL3PM+vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cAo7QyQv; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAo7QyQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728623195; x=1760159195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sBpU2GOHw5Ru9EAUs8HAto33vqf/S4Yz5j0+bp3uYH8=;
  b=cAo7QyQvg/utnaVBFw9jNTj5k+DDoMA6rLaSw2iOBgOM26OdnQ1Jx7H5
   zk0/3OoKMcqHmECKTQyIzGRxtK4qI1q1bmTyWMZUOKxE9/HZ/cYmGHZXG
   BnT6b38nHuD0LD5Tnw5KjQQrA6/t6Phubpz38f1ndQiXjv3sVPJ0pJRS6
   6+jPpDEx+R6ZbuwTV8A+RgqsrsyjRWMvIz0OltCbdQAe+bbkQwcniweR4
   Vq5R5PbvbGR7no3gOcjLrhNTj4BGoKe4QvmNNFvAG3DOJYvJJpUiF/0/p
   e/nH8TbH/DWOh1Kbtq6/kl6QxfCfPaE5FWUQOfgCjagg8IdQp8TulpcAP
   Q==;
X-CSE-ConnectionGUID: I6YIbn/bShWkDRCjNxf1SA==
X-CSE-MsgGUID: z/vjMLnkSG6i2ALqREikcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="39142270"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="39142270"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:06:35 -0700
X-CSE-ConnectionGUID: OSsB3j+LRxC3DyRuKjbgCA==
X-CSE-MsgGUID: rChlFu38T3CIVWeVI1hQTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="80810743"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 22:06:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 22:06:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 22:06:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 22:06:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 22:06:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+iLRlm09B97cDj0Wo5vGUTi+xh3w03iAzuQST0/XEyUpRMArLvpdFlcDAtWT6w/XbHydPcIe4GGFj3d7FYfii+DAEJ7Wo1X4mTkMNvyoNiuFm4q39fI5/54Lv1uUaAB2W0/1fH21KL28iGiEMz0O5mf65CxX5PGBzX4zmZxAtJp18pdjFWJ5bDQrqGBzV+acxprMMqnOlILmX80EP8/usrc/+4FcXYwgOHuUbWGeIwJnVz7649BqWIr9cdzPnVGBpU/9nhGYOqJcecWRJbhldmSWz6v+XbNADyKjnapG0Dc1f4WylNplzZo7nSSs0eVLPUkVaByYdItHJPZ2X2Mjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBpU2GOHw5Ru9EAUs8HAto33vqf/S4Yz5j0+bp3uYH8=;
 b=cAsfe/3c0gJ2800SxNlFi3rwf0Tefq3G34bYOSCsLW2ayJFL3BlQSbDOR1Xk+KdkT4jNOTKRFwUXZeV7zmcEXVuPSVYldNXzrbdm9AYqmfERG5sq7VbmXweHoNLnTbMy9mvdqM+G9rTutMw3vYSkG4KkfHXzGIVDjWzxv79UkVrSnuD0QLapKaGfWddH5XXnE7cEZ3uTmpIAY1dRP9JD6YYTcWzPECqjX6Rm/tcZgA7i/pG6+IKV/RRWfQdWpY5gAEI5ivd5BZLj6rsrH8sTyB5B6buewzNQSU/T47N2cWcTyEQ9M47BSii8KmAPfhNdLkLId1U6SaR49NzZA/H8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL4PR11MB8822.namprd11.prod.outlook.com (2603:10b6:208:5aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 05:06:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8026.020; Fri, 11 Oct 2024
 05:06:29 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v2 0/8] iommu: Domain allocation enhancements
Thread-Topic: [PATCH v2 0/8] iommu: Domain allocation enhancements
Thread-Index: AQHbBDQqs9HEBqpHkUq9bG42EKBwfrJzD/0AgArSsgCAAHcIAIAAJ9MAgAKrhMA=
Date: Fri, 11 Oct 2024 05:06:29 +0000
Message-ID: <BN9PR11MB52765C7FB8A106FCC7E944E98C792@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
 <71d20ff3-0a85-4670-8559-70ca5e6543c0@linux.intel.com>
 <9d0101b4-af13-4bf6-94a5-43a79f4d9989@amd.com>
 <20241009121548.GE762027@ziepe.ca>
In-Reply-To: <20241009121548.GE762027@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL4PR11MB8822:EE_
x-ms-office365-filtering-correlation-id: 87d9a726-352a-435d-b2a0-08dce9b2778e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iT9AKpizWJ8M9IOe6b2aeYoJYpPd98nhrxGvQacpKnwCWK/za0waP6p8lkBl?=
 =?us-ascii?Q?1Y4x3yotwn1SdNQ//w8bo3867+ndDp8j4nfoG6clTKqgjq4eIs9iED5KYQ7m?=
 =?us-ascii?Q?YwpY6tzbM26jTbrS+JTpNrbYkYSD71zyukN/WfRzntHiDXppSW4zbCXT/xpM?=
 =?us-ascii?Q?DNrW89fR8wKZgDMQ2b2VUgpR/4iSEcRCdDcVDj1ZMufwVUMz6rH6P4kd7zuP?=
 =?us-ascii?Q?xqXaVmNQmLZBkOSv9GJDjwvWJqg0wKhm6ufcHfu6QroIiGhBysb0dgZTzn5c?=
 =?us-ascii?Q?pOzuHwK8QKd/5+w5Ru5QYdY2McNZ/7lmcWQXRSo8Gu2wpQiTXoAqFPjvvOhL?=
 =?us-ascii?Q?Hof2AXtcuzHocC9UmibhWwAQUozXF/H9mp73FCi1JooLBFeAcTT/8tskYdNG?=
 =?us-ascii?Q?p9RZu12LDkpxxVk0p7AQFZ3WAsvQPiH9Fcib972MLWYN/3Ryb8rCpeBkAb42?=
 =?us-ascii?Q?r+DuGOwEHikYHzdEAEmK6Go1HBR/henDsPLxFSqPKoG44eWI44wTs5O8s8pP?=
 =?us-ascii?Q?ASyWh9iE+TVnzPTYsL53LPUO+D68hCqjOlG2UnWwNXnSaXVvl7k/xv8l3b0K?=
 =?us-ascii?Q?6bDNhjEZ1ZTAieTr1GtEDQb4+V2GuTPLnVrDM5kzJZjg9Z1JjkHeomrCiRv1?=
 =?us-ascii?Q?H5uRONkBDA7g+s1hXQ6q4+mGyob8WYYOsXXBX/EdacYmP7MKsTitaju+Epfp?=
 =?us-ascii?Q?zwvGUwA+q0tQ7r+5faJ3C4mHhv+CQvF17UmlUybrR6/kPm8r6nPujvwj5I32?=
 =?us-ascii?Q?CnNpNde5XLcpK1Lld7YwuEzGeqmrhcUNkkpwQl2pbqcgqamJP5D9u8OKzvS1?=
 =?us-ascii?Q?JXEe+Qfw4jtQPCd4BWM3nQx/I3Od6xYHI6dRIWitWQlCuyqrcR2z2Bb6O6+I?=
 =?us-ascii?Q?VnGYer8FD+f53IRckKZNGv70Gf1r5+rgm0c+uknub7WzHadKAJOU+izbHWip?=
 =?us-ascii?Q?k0ND8+oJqGhtj/Il00H4/l4GC1JAOqnaGPJ/vQdcLWNH6I/8nlPwiGm1SFFj?=
 =?us-ascii?Q?1oMeKoZYzDZ8qvnfmW9fcCI8vgBM7U/B3fHBIGhKCLwrUss1DEgR8SDZN/P/?=
 =?us-ascii?Q?P+wPASDf+zIv9jML3KsxlsYA53QkashgYGldq3SoStoY+1k84CvGv4A8ctrP?=
 =?us-ascii?Q?vUW9oKLLmKlWh1A41liBOCZeQk8q9CemAjRRc5JLYWR5ZmT+AHeSKQuxAitj?=
 =?us-ascii?Q?z7axRHkkqSj37KmyvFXCoQlpdAzJq62UpVZjyJTwCHJzu4dXI4YF32jK4cku?=
 =?us-ascii?Q?YKqgPuTqVNQAcwluDW0XvRebyFxsH5zItuDTd4FkeP1zvezmITFdXC3q/iyz?=
 =?us-ascii?Q?nQRZ6aCd8kZhcs0aHN0lf4kD1Ia+Q+6F5Pz86W5puWzq1w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ReD8AIX6AeT0R0ZIq5vPhkvbNSJ6h+Ig0ih+9xMF7t6KXhf8CRBSLjt9/PwU?=
 =?us-ascii?Q?3hddNKDNkjgQBm5hiXwil5LEHxFmnYhjqmHoaIL0u1A7VFWxaAEkFp5R2d5P?=
 =?us-ascii?Q?Ol0KK6tt1MhgfoJwLp/100bjVQDfQQB9nHtO2H2LglYQ42UKZm4Fv/9ieBdl?=
 =?us-ascii?Q?InbyHmwJoHpI+dJEjSK7vi4AZ0u/03qKwH4XlbPjnS2pAgYH5/mrpKEyrpU5?=
 =?us-ascii?Q?q4Agea3ZqKfli1HU1uwVpfYqIw+tLH0t8ai6J7E37YqtG/A462hzP4U/MA28?=
 =?us-ascii?Q?Tla1d/KXVlyJbI7VnmMJnNb2biXa3zNrDE0z9CyvBTnPWp70TrmHwyXTuT/Z?=
 =?us-ascii?Q?0oG/lEu+IFa8qkgcfsGVmb7JysFB/I9I2efnK4dvjsnjEnp3Lfsza04nwMKm?=
 =?us-ascii?Q?U+TtPRWx/4ilv1f+UxK/uKWpnjgW/IzGV4gxZ4O3UKmSrYsV3umvoM1UzPVL?=
 =?us-ascii?Q?MKIebKm3wVQCYBf9Lpo36AuzdgOuhgAdPQgmuIa8YZZIzRf5jdrJuNHqERi0?=
 =?us-ascii?Q?TlvF4tvzPQ6/dXX2En7IlF2B5FaE/GE+MnaJ3Bh6BwvHuolnMIYRLAjXfF50?=
 =?us-ascii?Q?WS+9JsxYfqO4U1RJypT3eNdHWwrbCNkrtwnZ2QgpDenyLG/D72B7I/CpEFe6?=
 =?us-ascii?Q?xzkWIJyoXqCxPLhxqGwWC/gFn7ApT/hgsa45iin+LDjlQV4f39Kd7UDdGM3+?=
 =?us-ascii?Q?+xmVmGgTwGZnuMsbbqZPilmpRJNZm8lhw3WP2rOEicsvnDKTJRoZUmdP+fbK?=
 =?us-ascii?Q?U/dxH8fwCPnfqrHK6QCbuDDnc8teInqNwyXkeSKCoWYWc/XtEN2+vu2hPkrY?=
 =?us-ascii?Q?7BJNXCVRi8w9xH5/dh/viuSyu0Ep08CuD520sRF8PD0PhJn51zIgE4q2Acgx?=
 =?us-ascii?Q?Cc1e5OCxzwSNUVMhYNj47svGX39v8oYujtd0PCv8T4BlZ7YgI5vHXOCAhOzS?=
 =?us-ascii?Q?I/LeHfkDN4RROr3AduVUasyCbsU1XqhrL+LdCZT8RmMoXPeA03bwMkqzW/za?=
 =?us-ascii?Q?uRHYmGuMxI+2JG9yjOP/RMkDBeCLeRxBW3/dh3NPGRDAbK7bTrHtgDz2ZmtC?=
 =?us-ascii?Q?v8JHh5EtVsuP4x+Z4oHeVqxYpMjOOWF/mUxEZev1i5RksKI8huea5iX8bCit?=
 =?us-ascii?Q?NwNKe9S14I51qCDX0UDW+5No9ykrUsPkZLCUSTSfExT5AdF4RcHrmU6SKIW9?=
 =?us-ascii?Q?a03O2c7BUcsc2JxbJhNNLYeId35nZt+03axvI+VoitvMmT3ubpXcpzLES329?=
 =?us-ascii?Q?exQpKmclBpV/cn1DmMSgL90lxHoDBSdtfDMUWexQeScfTzQVldJom2k0obEB?=
 =?us-ascii?Q?sYgAmzmGoWA0Zr9vr8Mu5KC15PDvNTooKPuwtVVI8ov03uSp4KlIWIOp2iYD?=
 =?us-ascii?Q?5LGE7UnBstvN5OAYbWPtPRhA7MCfLTpDe5zY8o3eZ48uzse6npRBVoFcO/ff?=
 =?us-ascii?Q?7URdEXVYggT2lyeALG078uEx0GddOJyiHGIF3BH67VFHwCWBvamxYNOR5ohH?=
 =?us-ascii?Q?A9jr1qlvhGd6ak453kG9yShrHnjGNMT5mhhqXpXmybVB72OJBluavk/n1GiM?=
 =?us-ascii?Q?dHKwWU++CyOgc6QWbo5fDUpSQdlsId2QunaZ5XbX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d9a726-352a-435d-b2a0-08dce9b2778e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 05:06:29.8822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pE1c8U4CGKHhw3kVuthfZjq4tRfGZ4fXt4xUYTrlQ8C9EJGsoUcrSv0REsXfca5ekTOhOKUFAzYGVcPnTRyg9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8822
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, October 9, 2024 8:16 PM
>=20
> On Wed, Oct 09, 2024 at 03:23:16PM +0530, Vasant Hegde wrote:
>=20
> > > This change might cause a functional regression when it comes to nest=
ed
> > > translation. In nested translation mode, the user page table (e.g.,
> > > created and managed by a guest VM for guest kernel DMA) must be in
> the
> > > first-stage page table format. Then, it can be nested on a second-sta=
ge
> > > page table managed by the host kernel.
> > >
> > > Currently, the kernel automatically selects the page table formats. F=
or
> > > example, the Intel IOMMU driver always uses the first-stage page tabl=
e
> > > for guest kernel DMA. After this change, this assumption no longer ho=
lds
> > > true. This means the kernel might use a second-stage page table for
> > > guest kernel DMA, breaking nested translation.
> >
> > Hmmm. I assumed after discussion in v1 series you are fine. Looks like =
I
> misread it?
>=20
> It is a bug in the implementation in the intel driver.
>=20
> intel_iommu_domain_alloc_user() should always allocate a page table
> that works, if you are in a guest context it must allocate a first
> level/guest page table otherwise nested VFIO will be broken.

I don't think it's a bug. If nested is broken then VMM can fall back
to the shadowing approach. If the VMM only supports nested
then the only way to guarantee it is to not advertise 2nd-level
capability on the vIOMMU.

The VT-d spec never says that guest software must use 1st-level.

>=20
> For this reason Intel driver should always allocate the guest
> compatible page table unless IOMMU_HWPT_ALLOC_NEST_PARENT is
> specified.
>=20

But I'm fine with this *policy* change.
