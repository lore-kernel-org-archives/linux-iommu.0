Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36F209F43
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360803; cv=fail; b=slIa+y4EEUQEGvuP/76dxEBelv/uuJUumVrjBudUuD80yrx+pCYJjv6TF6kLt1ZSIrBvWBiCLrUPMQGLyJ6v9Ujwvz9oQaVdmVf1KCjIo6cUsaIp/bipSyRgWDgj9NI9sphk1tj7ZVEmuBinTuq3FvFeB+aqfMBwuQk0I+4Fh2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360803; c=relaxed/simple;
	bh=yxBDE5fdpP9rw0xs3zrQBzuOBcvsSsiAfSNXApbvTuo=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=snubo180K4GWJoylUoDLzsCZ3jirgFTAGrydWOJBcN4AMqhJwCvf+XuTq/qnvzxn86+Pcts3cWQ3/dnTu2I0nMOrtVpHTkA70Mgk8g22fz1S/2EMMtc17XY9jgcmXzu/iPvn19fvn2BAGiDomjEUPld4UTCT6eDp8GdS1WZz4pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cFW2K+ir; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cFW2K+ir"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fngt2EyZomff707Z4vUEpIeVlSz9KBDoHgblnOevWytsA/nFhd2WH/I3sDi922jdaPEpeJbNcrXLbPb5xlR4F6xy5JMISla9B3yE1PUXEJCQZFr5AOQkj6icSn1shY7O8N30vusl8fwCpH5vNNBhKVPJ3K7F6RJFoj47aJ1xQLViftmCDF6NRwseVUkSjVEh2LELG9xkm9r2Tla3A+Cgy8elICfQUVXLrna4nPFUOPLbLu6IG97sUQDpg8oHnWL4Y5XP4vqFecUdVDiYoky7cicM3A5YhaN5I/1a2qQMvfpYyD6giWeG+RIxNEuEZLuDJBeFM57PDHu7iDL3ymfYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgEDL6VdcaHL/R6JbgowJSlvhPJgkoSBEequLN4Cj44=;
 b=kR7S8KEjfBNqDFT1bH0bRt4OOMXx2FOAGodG0MWJI/0D579TQBOhZhvnbwzrg00v90QT2rwxWVipQ5goppug4TlluIZurexf5Cc6q7VHAD9u7v6DxQju4/49BDEaY8DfnIfLsm1xVuHpa44N5erg3Mw1nM2GoB/yhboFmfH8OZ4Wft+xPtnAsDOfvi1jVxSGa143zbhlC6hnB+NHNbx1XjHzSKZiR6E0EzpzJEW7bVXFRnYwPvVTWzsb23TnkMxuBkLmkIUP2iCGPJBH92VgqIpLs0JpZoLBjA0NoyAtQB12qaikmY8lt3CBvNg5TrTVk1H43yofj/robx+G8QpMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgEDL6VdcaHL/R6JbgowJSlvhPJgkoSBEequLN4Cj44=;
 b=cFW2K+ira7OsEareRN+VnwZ6qaw7l4rcw9k1je93UHieA5ZiYtsXqCHpa4pQ7F27FF2PC4HG4BHuAddAOX9pNesSitsolP/f3S0G99wbTM3cg2+22XDsZPI3WjiJMepiI/JWE2DM+zB69+4cTskWXSGDXcri1aQFFyw/ZRgKprlp2lp1KY7DPis4ntGoN60A8RfeBHvt52CvGYQQ9CFZYA43avaiTisLboEcKMyT03b2uQFbxkWj2FHPIUctd/pNw+u4RMAw9qnGLio7wmfsmH5KHYxCKcBgOQFoE9oO6LugkBGIE0ULwl+0gsFWbX4kTmmHy1mrDeVayU9CH1yScQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 17:33:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 17:33:19 +0000
Date: Thu, 16 Apr 2026 14:33:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Subject: [GIT PULL] Please pull IOMMUFD subsystem changes
Message-ID: <20260416173317.GA1886788@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k/zJzsvoMjd8qYN/"
Content-Disposition: inline
X-ClientProxiedBy: YT4PR01CA0387.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 683a2bb7-8f7d-4f5b-b770-08de9bde3fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	y/Fokues7K6eK2lvKihrs3vBNT8vTj6vgBRHzhYRm46q7ov/C6ZDV5linAKYFO7p5xehb1/puWvCaRdSgalOZdXEdG6tl7WDX2IelFDAHJNs5dtBIFY90zSHGisx3X8bwoyp1CeXLH7MBu4vV+dEiPEaVCPFCzPhvnnzf41nT/BFfsFfr2GlMetkt4WpBLBxxMiiYjcgC3r9py84TVHhkW/yi1K9zW5Z/eVeEnXVCXdeJLew4t0+2eIMe7KjBA6YOzD7F04c8IeL0YWqXX4OOrTPXaRHSdKaYkAkDAv38+oQzTF9lr8mczihrC7gd8PjyQ7q9UkKD9GVtImrTh6JYC4akr/CABr662fQvZDMtRZvpE757x1WdzBj02TNSnPOqeTZHLOZWedOyKimpxd9KEGwz8OP9cAeJaZaUq0Y22AaR6jnF+mKKUHLH2x+4rbhVp62dFYb7Vw+1MVvypnZ1cfbv0mm+vE0mrQMRNaI71PFO6IGEPlxSVciUfBfjIcpw4T30e0KYJnvF5gqCNHKCL9llrV0j3UO9zTeNDgJu+RYdVB7hqpUJ/JpaMqIrkZT2HS6yMJmzUE89Xbkg5qI3uw03OFgMmmNtrE4uJzCWakdX0dC8IP6NPjHqL9oyHrm081TwU5OMQaJrJwYArJMMS7rInsGJX5WPnQhGrN5pnoM5r+giO4IzR+iKQPc5742ajVfSL/FwHxm2GyHf6AbRGSxchvGEvINEiVbUDasw/w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vsMx6JBioXgmXSi23XLQKRRBa3DRNPzZWdBME1BCFx0W2hfbPLfnpZcYqWFr?=
 =?us-ascii?Q?+TDLhh8SPt4mh6P8cV01BrdPW3ACPzGfp14SWeOsWkF2JIMh6LZzY+9thn7f?=
 =?us-ascii?Q?kepMchPGaPo+aEICiVXck74Hl0PGzLApPMAFcROhsMHw36++ypa4ubBfvfhS?=
 =?us-ascii?Q?dcQy6TITI/xoLMnEvB0Sah74YMoJIpdT/rNpdIQC0H5hDAVqSq/nrPtxa6fC?=
 =?us-ascii?Q?hZ4AjHRkVnKYOTz4yJDE/RR7xqy5qj/Y3CMgPWVqIpImB6m+QZ//RIX3+KHm?=
 =?us-ascii?Q?DpTYzTGMi5ioDU+Y3RKWnjX0lYIWNcYvJVAVIB4LUOb3aWnoI5pjYOLaX+Ik?=
 =?us-ascii?Q?XsjVLWjtA446EtJAMPqjE4Btu5D1i9aOuI3CNg5jQCt7/jRo8RqWc7bKxf9u?=
 =?us-ascii?Q?USQvkA2S/aWhsQdIVUmcE5cS9E07NpPUVegqvfIOecdEetRO47nHZw0f8SJJ?=
 =?us-ascii?Q?rbw69t2zMipQPhj45hyK66nI0WcfoEC09RtZZyaDjBssm53Qzz7X8NSxtdkt?=
 =?us-ascii?Q?E7SrUBS24vze7tsJzj6DsJbCh8YFlWkCxmWR62kaUOFkqLwHZuDDr3WF/GWY?=
 =?us-ascii?Q?XqURo7c/qUI5T312s+9+KjPM5VGTIDpLA+KZja0VO3OrKZ+1uyqR3OwgrBrU?=
 =?us-ascii?Q?kc7MtW9LWJZGEMidmCx5C3n2KUX9gGwLYSNdBbTchrp0yKPndThBQi+7GolU?=
 =?us-ascii?Q?9Rhu6uSxxTx7tWzdyzh1ZVc+V4eLrOFrZX9AUJaqmvhDR4hTCWbOdKRYPaG8?=
 =?us-ascii?Q?k32Ll9GB/n0dn5RF6vk0gEW+CdVNbMIWLzkLPc29JmZRu00LIZaA4svVb/Q6?=
 =?us-ascii?Q?uIffrKoMc/SsfXGM87u2qYLxbWSOe4C0wdXKtin2GVtu64EjPNSKabx+oCwx?=
 =?us-ascii?Q?R/vkWRHzbDezORXPovR8HNAVNg8+FuOYdvwaIoEJHX8nFKQ+sgS6S4/gayeD?=
 =?us-ascii?Q?9b6nnbenivXwLM4ElkkENAiPJ8qTTjCSvOymeUneXJO+dErWYPyX8ot2OYlX?=
 =?us-ascii?Q?zJZAvH21Uh0msnYYpoWbBuqYIlTzLpPsZ05ORLYsUpo5rDS61K89rbICfFn2?=
 =?us-ascii?Q?/Hhl+73FKh9dFhnCzc29G/OkFkgklv98JvqyivI3FQ+pQpB2xKySK0wPdtXD?=
 =?us-ascii?Q?L4+g3DHeCLEECMA3Qvh5u3qvaQkGxmBdRAyaGnfsW2/Ukb4TaSVeYvL8WFi5?=
 =?us-ascii?Q?tdCOVVQbf2O2DX5X6sTkWdSYV3wG9eigix5WHaEp9CqbS4/zmBimN8bOkPZM?=
 =?us-ascii?Q?iZPsKl/FB1hDBrASzt8S4SWkeHT5VwQ5oYwJef9pYkqkGt7JroG3RfNAlBDK?=
 =?us-ascii?Q?sisFKXGWgDCz/53v9W/foF/Tbb7IHn5zJZk38CTNPu+7abcX8ZMn/pPeCN65?=
 =?us-ascii?Q?MOpA2wCmM/zhJEHt4c/dAe9tKZkoC3fDq9RzdQXX9TIsXOGQv1IGd1k/Uc8l?=
 =?us-ascii?Q?obwccLIdfMK3Hbvzory7xYGVXV8TQowSuEs9gpZy45WGbjL/KhuVtSzPKr1C?=
 =?us-ascii?Q?BIJMJO3SvZr/WVt1ViZqbC1PqFqw32ysycxxlt3TlL29/o5uRHShU9sVEYgl?=
 =?us-ascii?Q?Sr6BJp8jtX8btZNf4psHClFoaP2uqzZ0e5B35UE2ZqLPIgPq3qGYCVCXUy3g?=
 =?us-ascii?Q?fMrdI65OrnhA2mNF08O71ouXpsBn75xM22YUb07/GbnzzSUuug8/TFWr4Blb?=
 =?us-ascii?Q?/QWf6ByGP28/eP2lcvD0iQwQukt4ELs8FAyUc7LcSoHFsuN+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683a2bb7-8f7d-4f5b-b770-08de9bde3fc0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 17:33:18.9594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3u/i0ALIvclZf5iOob+k6Q9ZnfqHEKiTIhBNowu4JxyFupFkC4JEmuHg1rOkC06f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796

--k/zJzsvoMjd8qYN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A small number of little fixes this cycle.

Thanks,
Jason

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

for you to fetch changes up to 8602018b1f17fbdaa5e5d79f4c8603ad20640c12:

  iommufd: Fix a race with concurrent allocation and unmap (2026-04-11 09:57:02 -0300)

----------------------------------------------------------------
iommufd v7.1 merge window pull request

Several fixes:

- Add missing static const

- Correct type 1 emulation for VFIO_CHECK_EXTENSION when no-iommu is
  turned on

- Fix selftest memory leak and syzkaller splat

- Fix missed -EFAULT in fault reporting write() fops

- Fix a race where map/unmap with the internal IOVA allocator can unmap
  things it should not

----------------------------------------------------------------
Christophe JAILLET (1):
      iommufd: Constify struct dma_buf_attach_ops

Jacob Pan (1):
      iommufd: vfio compatibility extension check for noiommu mode

Kexin Sun (1):
      iommufd: update outdated comment for renamed iommufd_hw_pagetable_alloc()

Pranjal Shrivastava (1):
      iommufd/selftest: Remove MOCK_IOMMUPT_AMDV1 format

Sina Hassani (1):
      iommufd: Fix a race with concurrent allocation and unmap

Thorsten Blum (1):
      iommufd/selftest: Fix page leaks in mock_viommu_{init,destroy}

Zhenzhong Duan (1):
      iommufd: Fix return value of iommufd_fault_fops_write()

 drivers/iommu/iommufd/device.c       |  2 +-
 drivers/iommu/iommufd/eventq.c       |  5 +++--
 drivers/iommu/iommufd/io_pagetable.c | 10 ++++++++++
 drivers/iommu/iommufd/iommufd_test.h |  1 -
 drivers/iommu/iommufd/pages.c        |  2 +-
 drivers/iommu/iommufd/selftest.c     | 35 ++---------------------------------
 drivers/iommu/iommufd/vfio_compat.c  |  2 +-
 7 files changed, 18 insertions(+), 39 deletions(-)

--k/zJzsvoMjd8qYN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaeEdWgAKCRCFwuHvBreF
YT2yAQCwqYXT6Sstg/A+XTxPwNRc8ZIBfpA/niN33JIccIaUCAEAhEvBO/qg/da0
EOD7huioNuMdosXO7vFVyYVw0VbuXQ8=
=6/s5
-----END PGP SIGNATURE-----

--k/zJzsvoMjd8qYN/--
