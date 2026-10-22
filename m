Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792687918;
	b=PMQTPrymM+pEkkKCGtWvJeNELRZ7suJmGr8mmFk2zdqoAzlaSIxkmhirLQ5UsqMAiDwy
	 gK6o7W2bvGgHQmM69ZxcB2ygdShgsYoIsv75we6Djcvegl0LTyjfBa+oFx7IggDSjAoK2
	 3CNrwL7OcdGnSfZffBDfgaGtfLkC/vy+tH7bwuUSYoEuC+pbJCQjd8ugMUmLTi75efDjq
	 MZVduTYUaxSfQ9SoOilKQ2iCokSPth2IX3I5ynv4EO6wVkpkhHQldHJBbG1l/BELbcD/u
	 Sk4979k0FkrXlcyjP8CnkvKVsGeL6HLqqOFm9k6oDpeQ0fZd3YdUbCSJvYZ9i4aQtqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687918;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:Content-Type:Content-Disposition:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=b9VwIDlGRVXO4HoUkwoV5Blr0nvcxqT11g7GRHsFce0=;
	b=FY5J38Vj4RQJUoh+g5Mb5lghOu98l8EgVPT98Y62U0ihhyRizeniHNKrvwpSJDH2PJE2
	 mkBgir/LxqOTKhfLj8ySdGFt+YOCf6kvaQZ2fQT2MZ22CF6dW6Q5hhBEvCd1ski7+8Yqc
	 ctTSNDRK9B84qUe45LRDaTY9wZoxme+ZJQFf1TAnOEILKG77fn+RYa08nJEhbMOA29p8w
	 eprb0c7IvCWUN2xwYi1iMQcz+RGafxjh2kcd7y6sAPKTj3bgQglZV6VaBpMLwF2ntqbb1
	 N8ondGI1rPB/TrAKeD7cFQVV9cD8/FjasQq2A4qnny0PSt10B1ghYrXh7upqupGyAUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pnljgyt6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.55
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012055.outbound.protection.outlook.com [40.93.195.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE6606A31D
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 16:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59AE6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pnljgyt6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkdJJQVWYTGsVWPEJGEKzjl0whELJAMl2Diu/r5sYXqIT5ARMbwdBG4en1aapovwTpybppH7Y+lLrDuQLtIFJZBg5u1CDbpbFyp4tpELVZQ1h1c2zZb7J7KHcdmP9U8hEw3We7EAkWellV2ukM485cST3WI+hfvbiPxT0MNhQVjhYKEqTSFIbRF2+xZSTnaKYWOqI3mXarmsXv9mrTDIJROTFAuB43PTUIDZz98kU20p36UzcpxhXVh3zuzA7za4xQ6wE2405L7xm5imbSsVDHn6V+q2gnLrUlzdCHZgtdqmW2CrMEHvtZwb3FM0xENDl5wkMXmeOMr/4pWE4eYq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9VwIDlGRVXO4HoUkwoV5Blr0nvcxqT11g7GRHsFce0=;
 b=Dbj20+jJKbCM5QWIYz/8idQNIZ4T/EoBO4VPBXBGQGoyjOzAeEIOmqQRv055LZxHBDCdnQ8VQrid6/FSq6xqMD6X728fijiXNb5rxbL1qD0hPVfLdNKhHJWiTCdVvZm+7Ro+k+6wtLCZ4N6XzJt57mGM00W3zdxRgwBwk1F4v5pMIUrvbGqxC8iTBQE5y0bTN21m7HbkYqpJCIiJyDKjy9OsXS2/haPhNnqSyiyvCsbvls2JRUESL0VAG7Gp3TUhWPjZwblv4/dG8FFseku095tm6qqS4at9GDvJrrQqqllUYVEgBLe1bwZMsVVTXOkb4/mHqJeXK74O3IbNFJx1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9VwIDlGRVXO4HoUkwoV5Blr0nvcxqT11g7GRHsFce0=;
 b=pnljgyt6DsUKlHz6eAjLyu0WVpGo1KJSdzjBEKMzBCLrkHRGpmuaYmPQt3aOjTQHXMsSw6jSoGZxpaijE3eyZx6T+Cllke7PIvbAWraedREpB0x8eHU+m7z+UuhIUfB+CNw5OI1Fc6P51/uULB781N4fgCJbWNNsrWgQuekqu1lAt7X0uh4ZV+ly8y51Y5YtG32oWvOMo8tXcfOjoLkpXNL8u7Rm2g02enEPqumkTAoNVEimhNOCT2qvFWWD8mYANFUHovQVLbaBaf9PJKlcmIgVnVe8fPmrPtihIuoLE4W3JTeaD3A34YoxIMGgSsn1+wIvn3cQ7FdCdq/SBI35kQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 16:51:52 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 16:51:52 +0000
Date: Thu, 22 Oct 2026 13:51:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Subject: [GIT PULL] Please pull IOMMUFD subsystem changes
Message-ID: <20261022165151.GA3692244@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mFUbxSPnBhmcY4Wd"
Content-Disposition: inline
X-ClientProxiedBy: YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::28) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b07d16d-47c8-40e6-a162-08df305cc5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|10067099003|261021121427099003|3023799007|261021135927099003|261021123027099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	yjnziu8gi9QegbPBF+FhPUuTQt4ajjfNKY3gwlVxpM8kgxUKc50DvXN/s5MTz/qE1QhxhSBQo59s8qFDKvFbhxg5riJvwmP9vOFrJPAibzZpRAiMGyj0p/mJN+DASHLY+0/VKMmn1TZv7P/20Isp6eq+fLHRofXwxyxrGI57fij+JYSggJE6NZ4kxxkfTrHr1r5fmgeC+yxprhjZR0vcVZlOWQTyvOHqpBAxYMnsMsVq5iRzlIQjbYCnR34hQOVpWw6UziM7QoOSZmTFEcWpiDFoFsSGGzUt1WPS8GQFU0mY2nIbmcfN5kiEsaqDpGN4O4vNuQ0zrqFSIwaa9aV30Gq5f9LqQ6vDEHGGXPs5jK+PhqTFazVXpxlN+Cl7IIYGIuX2l3mMmgWPY02YHS6ui+dsm70+uk8/ZacWsQ6xDGGRRfHXD9+v5qe20fZG46AEiMaAT04bSrhrNttp9wZuKpls9lGenej8KDS11tDbqeQisL2fH5T8vb+fyIkQg1SAYKlNYAtGLdBS8aSFr/6IyLnT33kVdohkwxN1hnl95USO1RkJ3+gvY/QUBtflaMpCw3VJ+QyqK5Muh0iiGzwFkK+CBbC+xdZecabeirRYGeBWIzQEYkxq9xpI7Oqlc7wkq3wkZMCC0iqSlmnD2gNFz2U0La+4DtfYP+4uru2YmXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(10067099003)(261021121427099003)(3023799007)(261021135927099003)(261021123027099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lYCTdUsHLKkn5ev9XznH5+cXryAXbvhmhOBKCQL/jV1NXLcSSmnFMV6sMyC9?=
 =?us-ascii?Q?4dBq8EOfCo/REsFodu4kMAVF0kHenCZjI/+r5BmBWwxvchWZwdteIpjBJsH+?=
 =?us-ascii?Q?WlAKSYTk5lqBUvkUlJiu4iS3WVJhM+WoSjU4db+LglGJA7DDcKutzYbp4zrC?=
 =?us-ascii?Q?/EZHKcXJwKylAE5tS6thV8uxauVcbezb3Dg+EF+s6vdjWBiApVa+eunYz4fu?=
 =?us-ascii?Q?uWXLVRZK97BfNP5g7rklX1dMt/2aqYJS24FnWY+ekYK8hORihtEOTar2adLj?=
 =?us-ascii?Q?/TDe4BuKv/pxF5fx6evgaAst+jPRIKWouc/G8431pw/E22KzONcmnXA4hJEh?=
 =?us-ascii?Q?LSmOtBtRg0uBnOzQh6bs8FGepzFC0/IQSnz9sKLPV2AdtDW0e1qAs5amvNV/?=
 =?us-ascii?Q?u40zjCSpQ25NExDeKriBJafcgkqsxWJ30LYC7KHJFiZ6qDs2zgs68KR2Gw5+?=
 =?us-ascii?Q?bjfLHqxKVxt4CLEdhUu2PNLq7cYUrUNd5+yGlixRTgUmpjmtdnZHPkParXKr?=
 =?us-ascii?Q?2GQiWq8XWmjkce+gmr+rneVrhCL0hc/eogfetym2+KOJMqgdWvO+47jxIHsZ?=
 =?us-ascii?Q?8E9Ym+WhtrhmUNv2dfd1kplUQBYyApxF1OsblKBGRFOeqJSH+L55/Z3ZpzLH?=
 =?us-ascii?Q?I0BM0BaYpqC7ALHTUK/VP1hiiUGUM3LoqClFreYW5tBgxF5Qk7OKkFr3oUiy?=
 =?us-ascii?Q?ItlGC9N3OLxqJN+1RZHWqbgYBjfMw0ds2DKe7NKbEmHGXfuYI79KK0UcSacB?=
 =?us-ascii?Q?g3il/G3CRFs8pRj/46hRC1kciia5xJ2Gle3b3fCtmDD2aZxdK3kJOmufdzyQ?=
 =?us-ascii?Q?Lh/C7ZQ05rUuXEYYICcoHLM5aluR5VKa9XRQkCuR+Z4xzKbpmRvFb1qZsXV3?=
 =?us-ascii?Q?asKnHkmaVDkcQqshtgaqem5OIQz44stCWummeGLYobo0gNRVhkAij6J3F5gs?=
 =?us-ascii?Q?+nX1LG/LbL7z4T6Q4bhCWvtIoeykUpXP4GNN8GWyP9HtJLhhjiwk3X4BmoQZ?=
 =?us-ascii?Q?i8iEOeKzbcZ/RG3W+/XS844ATZ5zg/bLty8oobd/jybi6lr77aIFtchrrAj3?=
 =?us-ascii?Q?WbLLF/z84xgHMgaxFzMfNvm7xTtc0N6aftyljMiXgaQwQY1RN11fqkE183Qj?=
 =?us-ascii?Q?kqO7aGBCWRchOCl5Qjygw6zyOI1zUbuGLd0F8TOvwF9vprLfyxwgQ+oFqadx?=
 =?us-ascii?Q?ti98YRigLr0oKJP5SDSgEAMLcFxD6pKSBAseFOmFdP5bFFYBs5ZCQbnMBd3I?=
 =?us-ascii?Q?tGqAagEai1A3I+4IMOF8C3x4DssF3vKPGVC1PQJK80OiskV0kljF3BAq2lMk?=
 =?us-ascii?Q?o7Gms0cwRGDnNti8YNVyLyCaiHpDCMr9dTbFgfyc0ChVKQydKMQqSHQrnNTK?=
 =?us-ascii?Q?jUvVXtuP7kUiqNJjuikGKjKPAjboTRKyYeY95X6IQaBJ721NRDfJC5sEQT2t?=
 =?us-ascii?Q?TKvbSHvM429q6qidvT5t+FHooVIXt9d79F/s2LOMKW5YoBSSDqsIRGV0cF2G?=
 =?us-ascii?Q?5pgCzYlr+VRKpmAGUjWQOtNH1Q9EB+j9FPsCCNetq6Rtw7NpKt1FjXgHC45h?=
 =?us-ascii?Q?OOnq624K85ol6OtGGVy/FRQR8GpaC/dVGMVmwudHCkwAjOL3UffND4uCeTOo?=
 =?us-ascii?Q?VOejQ/0N+12JCMAuP0WszkXx1R+xF1IqxjISqneM9a6aJJ+LIrKUIMyKjtbJ?=
 =?us-ascii?Q?IkZfU/jpqot0LzCODlzQatKO59bFUCeSZ9ZRCs1zh1yaeTEE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b07d16d-47c8-40e6-a162-08df305cc5b3
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 16:51:52.2947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5+cAbQF8qS5GOq4lj7j+5K4BUU3PfhLuC4RLWX8Am1/MR88XBqk0owIaxgqFlXq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434

--mFUbxSPnBhmcY4Wd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Small set of iommufd updates this cycle, pretty much all bug fixes

Thanks,
Jason

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

for you to fetch changes up to 04bcf84613346b973a8cc0c59238b6b5bc902688:

  iommupt: Do not allow PTEs to be split when dirty logging (2026-10-15 13:56:22 -0300)

----------------------------------------------------------------
iommufd v7.4 merge window pull request

Several bug fixes, probably found by AI based on the emails:

- Several edge cases in the self test

- Reject malformed invalidation commands in case the VMM let them through

- Rework how the invalidation interface works to the drivers to be more
  robust and fix several Sashiko issues

- Correct several error unwind paths

- UAF during eventq file release

- Reject more malformed usage of the dirty tracking by the VMM

----------------------------------------------------------------
Andrea Parri (3):
      iommufd: Keep dmabuf PFNs MMIO when filling another domain
      iommufd: Reject a zero-length dirty bitmap request
      iommufd/iova_bitmap: Ensure that iova_bitmap_set() handles the full IOVA

Donggeun Yoo (1):
      iommufd: Keep reserved IOVA ranges when a replace within one IOAS fails

Eva Kurchatova (1):
      iommufd/selftest: Skip when the mock device is not there

Jason Gunthorpe (1):
      iommupt: Do not allow PTEs to be split when dirty logging

Karl Mehltretter (1):
      iommufd: Fix iommufd_hw_capabilities reference in kernel-doc

Nicolin Chen (5):
      iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation commands
      iommufd: Iterate the cache invalidation array in the core
      iommufd/selftest: Convert cache invalidation mocks to the core array loop
      iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core array loop
      iommu/vt-d: Convert nested cache invalidation to the core array loop

Nirmoy Das (1):
      iommufd: Fix event queue release use-after-free

Qinyun Tan (1):
      iommufd/selftest: Return dmabuf fd from IOMMU_TEST_OP_DMABUF_GET again

Samarth Narang (1):
      iommufd/iova_bitmap: Fail GET_DIRTY_BITMAP when a bitmap page cannot be pinned

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    | 197 ++++++++++++++++-----
 drivers/iommu/generic_pt/iommu_pt.h                |  30 +---
 drivers/iommu/intel/nested.c                       |  54 +++---
 drivers/iommu/iommufd/device.c                     |   8 +-
 drivers/iommu/iommufd/eventq.c                     |   4 +-
 drivers/iommu/iommufd/hw_pagetable.c               |  25 +--
 drivers/iommu/iommufd/io_pagetable.c               |   5 +-
 drivers/iommu/iommufd/iova_bitmap.c                |  26 ++-
 drivers/iommu/iommufd/pages.c                      |  13 +-
 drivers/iommu/iommufd/selftest.c                   | 153 ++++++++--------
 include/linux/iommu.h                              |   6 +-
 include/linux/iommufd.h                            |   2 +
 include/uapi/linux/iommufd.h                       |  12 +-
 tools/testing/selftests/iommu/iommufd.c            |  24 ++-
 tools/testing/selftests/iommu/iommufd_fail_nth.c   |  14 +-
 15 files changed, 375 insertions(+), 198 deletions(-)

--mFUbxSPnBhmcY4Wd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCato/JQAKCRCFwuHvBreF
YZxoAQCJwoZzNNx85eDR2Md5V80eDIgeHkmSXypkjVA8xlqmWgEAmX3fRO0rnhX5
b0/MrCg852RslQi5/jqgjr8LmddMlgI=
=zc6c
-----END PGP SIGNATURE-----

--mFUbxSPnBhmcY4Wd--
