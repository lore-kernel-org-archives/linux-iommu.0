Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012048.outbound.protection.outlook.com [52.103.43.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279D2EC559
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483137; cv=fail; b=k8/63zDZuGXE+5hIBn25D/AjHfPb5CekeKmb/5ElypGEuNxYKLH3eah7o31KtPsIXysHhXw416ZOUL64YeZU2nyIw7kl4yam1ir0euA4XOWYlI0dcL5ja4SePiU0+YFMdF/VEnjL4thVNOwxTe0SRuddyqLBPrEy1vxtdBhNS3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483137; c=relaxed/simple;
	bh=9vw0I4VSeX5IuMVElZcemxH/9ehRVWkTANODqrMNb0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cw8tnpKb8sAvRU1PyycoIRZkvmAx+bhRq1NZpaj5cnePP9aE703uD3LVDbCnnzqMzzxoqMb1y1kXfiLkFvVWaB0bm889C6Ev9crkl94anDVD4hfpcrUvMojgXXoIgEOvDXC2reIN5Tic9UptaHRR05e2+WgdSld+Se+kppxP7f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Qj9yNEU8; arc=fail smtp.client-ip=52.103.43.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Qj9yNEU8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y39m9h6Z84qKOJL7nPId5g0o1thXavKFHg5Y91DTuN9N/8YvfA4Vg/rR68yOGT4emxGkC5YGs/ffPY5oGOBXj4BxMn+9gwwX3vEJyoYv1XeSzZnldbEtET1t2Kg11gxXmJjK+aFFLzU9NSqoLy+K0HZeTFngbCj+8KHHZ3cSTH7LhmFDApZnmZFlWv3fbcxqRdIj+8JIwdUglMgeNd18Y5x4FbtJVx/xpTx6N7WOkHmICwRiiu0Oh/VRCH5NAr8eon/QjkrJ7BsXJtRqDyTC9HRYedZFvpa3c0cHG1gsojq3EJ+3g43C4RX1rhxEB2IYZzjXQxm7gLgrECNw4wyEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWlvYyIkRio4AzIEoaMHgJ4MTDARtX3Sv4JuaBg+1OI=;
 b=boQM94R35+u26fnZWkc0xEb80aF7IYRAdnA2lMUBGXXAKl/GdFESZX4nQa83JI4yEHGo+2aRRkAaaNi0vTvYYjtKvFVvj5O/IEkNMk2b1qnjFeByKoUHfYMAFBvsRRbCfYM5HLK7duqzkOB33AckAzErpIKUZQqjUanZ4x0jYQ6YACbjpOYm1FdccZKDlDw/nUgsZgZxbOY3WMn3J5i0pPTRNVKexOrfe8LQHheNsRElfIcB8nDaFbc/yZODxJbyUPmHTgwUmSw2xqyeHvWxo6C+RdTkm/T6Rgf/63Qf1aY2eWo1JxF9Hgf6jLfWAx/FXtymKBvX96fNwPkXJb3LYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWlvYyIkRio4AzIEoaMHgJ4MTDARtX3Sv4JuaBg+1OI=;
 b=Qj9yNEU8LNwTju+QTnFTMD2mrdGMP2OE4KE+w8oatpcbBFStmRAFMicm5ju0LXc0RIluF+pcaKgeUPdrkpt3sDt+9yyIiUGIQu317KA40TaoDE4agcFSGaJSDL1QUpo+VU6SiK9T1T8/MNcfajmNr40TJdZK26Xbq0RokfYNfBkB1p/Qcsu9jjf3+x1V2GxbVA1ECyXXNOikCwZGIosem67tITqLzEwdW1p4pkRK1/XvmPRR3ZGkGF1TMmR3UzcGPTxpJ/gn2AoDbYG66qRt2av8LoAUBVPd9q2ul64mKMrrxfcS9fCjLvSy5FmzaeAO4ERrY05aFlF4P5UGLERx0Q==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by KL1PR01MB5671.apcprd01.prod.exchangelabs.com
 (2603:1096:820:cc::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Fri, 7 Nov
 2025 02:38:50 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 02:38:50 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Topic: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Index: AQHcTMpHV8D4LumdDUC0Htj3DzPtVrTmayuAgAAJP0A=
Date: Fri, 7 Nov 2025 02:38:50 +0000
Message-ID:
 <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References:
 <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107010349.GD1708009@nvidia.com>
In-Reply-To: <20251107010349.GD1708009@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR01MB4393:EE_|KL1PR01MB5671:EE_
x-ms-office365-filtering-correlation-id: 1ceab672-c262-4c9b-520c-08de1da6c8e8
x-ms-exchange-slblob-mailprops:
 laRBL560oLT/z5vudnqSE/O7qQNjjjS4UfGB80HupIfUDd8FuZRN1yA5oNQQ2rpkw2itofYGxjmfK8XdT+RTzSGhwErLbNqjvyBeuV4Sc/bpmEL0bbzcemV2hWNRO+ak9fYZ1bsFifvrBWHzD4zgmG982d4XJh/ZJwm9QYcrv7Hs/zSOJMNIuiPLrKhZHjMYLwPrl5AzRPIUZA94zbD33wtR7VpTIr6L291YPDs1BNaQrN6U6xKCC6IjQEJewfYzsB9lv0uUqaVK/ACNEDzeghu6hunK12EVwO6O61LWS2V21jL09BB+RhxeL+DY0PASy2sYKbtYtQCgZFW6C7drDkORepxcX1o/8PAOUcpXaCGa7sTqKuQ/Jr0sx0OViErVdlLUeixHZLx/MOWhVA0xhhkhNXfJmYsjzTi8Orh7Myf5KjpR/WQCMNs99jQIsqVMxLJmhpLLbFVVyK+vpbbzQ59bNK12BLgevoSpAjIgg8PBpjm6Te1iA9vkCJEk3lf+vDcJrgCrY666EntPU/Gk3hKliDULBCd0hXXdSlL3irZNJJZ16UI2jVO92nalEaLqhMadwQx7cFyNWFYG13Y3jXNWnL1oS+zSZhF14n1LZsA5V1LPABwqIQ5iDGcTnBRKSAqSJpQ/Y77WnL12K1TBJt1DuMAjFHe1wqNoQvWiQ99+Tov7h6J9mbZV0PjVRauyrXrTkSsoUuJKP8Can7fLz5BLhXfI35gIxDkTnYsSqnWNl+pfLUGSCcO8pbWX8gzT2KLu4nD294963bPOtxCWBGLNK5W3SOVr
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|10112599003|8062599012|8060799015|51005399006|19110799012|15080799012|41001999006|12121999013|13091999003|3412199025|440099028|13041999003|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yB5c9zLqvK6w98IHyWGf7SUgx58RJGl+pAf/nBdi3IKmyRt1viqLeFBpMcod?=
 =?us-ascii?Q?Eh/ORTIqCy+fb6DAVGr9Dx8kiWjQ7y2nJHZ8Iwn94kA5Hp+Z1h/kqZXNuoEp?=
 =?us-ascii?Q?zfvLw7usiszUT+3xKDv3lYj/eG7fD6vJnGK2zJpRubDRrl5rdSrVocxSfBtM?=
 =?us-ascii?Q?uiwY0kHD4GT8EZffUouqxgapR6eBgScgjEf9XVyJg+YPZ+p0i3N/8eNT3paK?=
 =?us-ascii?Q?qKgEaIXtCWRaIfXUQDAQz8mGRTBb+V8GJG0MgkHXnK0AZsbU4pw3bty+Vg5o?=
 =?us-ascii?Q?y/F0kVXUcHTonLV3sGIOnjk3roHyMKBcKpWKGvINfEfgbBiwJkgOm+UHtbqs?=
 =?us-ascii?Q?DMQUZL4TSCZXiq/BqAdUBFDAImd+cZF2QqCzq2UGbC1xBKKw6vHEsQJPlC+E?=
 =?us-ascii?Q?e1YWRc693gK4amX6LffsBP7seTeJ3RWCFw6l6d7t+zZoBoXgTC6zxRT6EHdg?=
 =?us-ascii?Q?EddEZB/vqHE1IJi9myuY2YJaTHGc4/SKrD0QQgK3Qn0GGf88jQ1mmVA/giTT?=
 =?us-ascii?Q?0/dASjRw1CLEryJfKocp8jSPlfLbMDGIpwWyNMZfrDsFfZ3fsAdMakkrmB0E?=
 =?us-ascii?Q?KF7rTzxVk9LmBalnYdBT4Urn03ED47jg3hkAkhAReUj47/Q9+GmPMZ/4Htyt?=
 =?us-ascii?Q?W2xh0P8HvLFRnKj3bLaZCI4gGbIQIEXyaiV5xPyDQmyWg7vaB3uZw98gyfL3?=
 =?us-ascii?Q?zwjOGB6qMaPlWlfwNA5xPquWU4ZcapcB0w8wSTdtOZNG2h6GoC7CmDbKMrgv?=
 =?us-ascii?Q?EWjRi0fKPlcU1T8IykEjf+CZKm6SxrVp1uQej/L1Yv6cTFEKnXOxiBA04mub?=
 =?us-ascii?Q?dqvgklRhOPyRPtQlGj44VJwF2v59LwIwsKGpxelmzqmD7O1J3toz9YihmzgI?=
 =?us-ascii?Q?NfWbCeEbFf8pKClS9KNKwipAiAqfdNIPSgfUySZreHOSLxBpQ/V1i8W7ifbT?=
 =?us-ascii?Q?Z4c4aqBCbxIhR4UgM5Im3schNugwDNA/K7LqKkiA+MigGPbKZdSf6sPxc4Vz?=
 =?us-ascii?Q?HisAcEk5sn/WOChSWpM+P8qUFqBWXf6xCD7j55Badtl4ivcGiGSfUcVrozN0?=
 =?us-ascii?Q?NzGmQfDOn8OXe1ORG5SHGTFB2Mghtp5FS7FnyiliF4XZU1pkBSTUd0uQOADH?=
 =?us-ascii?Q?kAySDkJVd+oOYkif0jovQMp1a+hPa716UoA9LmD+1+zxzyg5AnWIXoJZYGTk?=
 =?us-ascii?Q?AxvAxpAAIRpAdXzLwmETs7wjW9QnXIfabX6oTIy23pjiu0qlmFIN8w/tY2JI?=
 =?us-ascii?Q?SvA5L4vU4r5PWC6Ue2mQ5LHIwkQpsQylRZ9Qemx1gJpnUrIR1IP/wdJ+fSJ9?=
 =?us-ascii?Q?BwBH6+gSlNRCEMWrwCYStDxz8clyNnkv6uivlQrsMhSIxw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uUIInfxXz7L94JLeM8gkp4tZGhdq5AAoRIpgHyOjwu1iTmRDYGoRfrxxVEW9?=
 =?us-ascii?Q?EOxVmEgX6nDju/uRX05+WVR888GhvMWY+usvqJpk46CljoQBQ3nxUOFaeHsh?=
 =?us-ascii?Q?9fsPTuCBj6gtVr5cEEf3eW/BQ0mV+XPLybLui3MIeBx+xTiM+7ssu86tP6N1?=
 =?us-ascii?Q?qr3cRTm1E4leDjYGbsuTeoRm8qdvkSDDWqhYEDoCU1GmM6bthNzcghliclK3?=
 =?us-ascii?Q?Z90STUba3wQhwx1pERNMIAx2Fkn1TJQN+8eU7qlihhIHPWXuS3QlgHhMC3DS?=
 =?us-ascii?Q?bhg1xz4KV0dshtAZuk9k/oRn7yYqNx/OS0vsQSYGmQj8wVJf+VLORtasGe2a?=
 =?us-ascii?Q?84dt1wyo3fLPVVq73T5hhfdIGsilDFMWgCqJzWC6gZoQ9ncEtvSlmwnpfryj?=
 =?us-ascii?Q?NeYZlAxs2KWEF0kKBec9/JJTsI7ZLJmM8XXifVo2XH1JcYht+eCKVUGBGG5E?=
 =?us-ascii?Q?/Z5SZu9VrmBV53gtOI9nHxVEkAbe3K48QFDMH4F09wojU+FjyQM4/ziIvShz?=
 =?us-ascii?Q?xtCMwu4/nbi1+DQbi7RI3yY+eRVUoaqv8am1ui+J3kKMieehw2XNNVOVEIN7?=
 =?us-ascii?Q?5dNNbPotoEirXVSCYmetu9Q1hEksfN4x6xK5leu+JQ0dBP7VrczNLHGyGqsV?=
 =?us-ascii?Q?WAANURD+wUe8ayq3q6S5RyJ+eMAGzmBuTgLX2D6ChPO6ioWdS5t+lmuzxyOa?=
 =?us-ascii?Q?jiRq80qL/o46ORh/SMWys5RYb9nyWAX+gvU6hxehvuDBY8yi6sBy8vgsyjh3?=
 =?us-ascii?Q?GIiT6CV0V18PbJugf9Ra9QQJCCG4GnsgEF8e0BOr/rtMZ22oUbJmBX8sUwkg?=
 =?us-ascii?Q?ebuAdWZWCC0wQRuCuzAZXcVGZUGh3vzyA3QT12LdrPUeEV0mUmM7xYJyzcyj?=
 =?us-ascii?Q?Lrh1Se4GDFXj4eCwb1ewf9l6taV/pejdR1wvTA90Bpe7NI4/Ap/4kGPyYsxe?=
 =?us-ascii?Q?KpNB49hHD5zAACgT2inDrBMFoVmCJFaZNbq9w9lING3oHwkF0IautKOE5ge8?=
 =?us-ascii?Q?UvmyC6z5Eyx61csxw0oagXt0+NHZYKtw4v+nhssRX8a8bcLB2ck1W2r/DRee?=
 =?us-ascii?Q?tKSfQy5yztQXVThtkPgaakzaahgA3i6+TvElV4C01c7j4V+BBnyIp7Nr1s7C?=
 =?us-ascii?Q?tuwBDClv44ouQFGtQwJ2058IJUJEs+gKivyx0JXyplsxy85hB4f8jumF1dRD?=
 =?us-ascii?Q?qrBoXBdZhJ12rKJeH+yXjPk+AKeCdFGLjqs/R48FSExZlnGVe0nxBlQ7Vk0?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ceab672-c262-4c9b-520c-08de1da6c8e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 02:38:50.5201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5671

On Friday, November 7, 2025 9:04 AM, Jason Gunthorpe wrote:
> On Mon, Nov 03, 2025 at 10:00:34PM +0800, Wei Wang wrote:
> > Before requesting the IOMMU driver to map an IOVA to a physical
> > address, set the IOMMU_MMIO flag in dma->prot when the physical
> > address corresponds to MMIO. This allows the IOMMU driver to handle
> MMIO mappings specially.
> > For example, on AMD CPUs with SME enabled, the AMD IOMMU driver
> avoids
> > setting the C-bit if iommu_map() is called with IOMMU_MMIO set in prot.
> > This prevents issues with PCIe P2P communication, since current PCIe
> > switches and devices do not interpret the C-bit correctly.
> >
> > Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> This may be the best you can do with vfio type1, but just because the VMA=
 is
> special doesn't necessarily mean it is MMIO, nor does it mean it is decry=
pted
> memory.

I think here vfio type1 only needs to provide the info about "MMIO or not"
(the decision to encrypt MMIO or not rests with the vendor IOMMU driver).

Why might a region not be MMIO when vma->flags includes VM_IO | VM_PFNMAP?
(are you aware of any real examples in use?)

For reference, BAR MMIO regions are explicitly mapped with these flags in
vfio_pci_core_mmap() :
	 vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
             		            VM_DONTEXPAND | VM_DONTDUMP);"

The only exception I can think of is nested virtualization, where an emulat=
ed device (with
vMMIO emulated using system RAM) is passed through to a nested guest. But t=
his might
not be commonly used in practice (no performance gain as physical device pa=
ss through),
and the lack of encryption for such vMMIO should not be a concern, IMHO. It=
s security
model aligns essentially with that of the host (i.e., physical MMIO data is=
 not encrypted
on the host, and the same principle applies to emulated vMMIO in nested env=
ironments).
Also the same for physical devices (as opposed to virtual devices) passed t=
o a nested guest.

>=20
> I think to really make this work fully properly going forward people are =
going
> to have to use iommufd's dmabuf.

Yeah, I'll also patch for iommufd. We still need to account for the case th=
at many users are
still relying on legacy VFIO type1 (will also have some backport work of th=
is patch).
