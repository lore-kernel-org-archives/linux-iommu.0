Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010003.outbound.protection.outlook.com [52.101.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C03D6CA4
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447306; cv=fail; b=P1COpkbr03ZGJj4dvtEdkLZx99M8K5KA1ERRKUu5F1SfP+D8aGql9Xo4cp6hlUCU+X4NF+cHUPNqKT6Bu4sF6Xsas9Yma/4gwLiyvfKp2XaxHt0JCIRpuM7Z4Y9rJxtnlMPO0o1x9CADRuqsbG+1kMXukFnD+RFWb1Dq3FduCSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447306; c=relaxed/simple;
	bh=Bk/RfBugf2MXQ7PA6VW30tLgUuAZPxT9SGQBR/3KKdk=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ha2zLt8ydtWuu5LZ0CBKEepgAC5jaV0ZoerllFRR+d8mhOe96bQ+ByfnGKbUZMbN7obBoEwTocChBnJ17+frBigRA8cKdKdQjbuYPubCGbTvGfm/a1Q+tO0tjiIQcX+eIS5bOvk8/UYTF0P+fTKmiamzL1ztjzWKb0X1BJPC3lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XBriR/Bk; arc=fail smtp.client-ip=52.101.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XBriR/Bk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3g3oWdudUAjxwZhw3RAcsgPFLlrUVOOcpoImkLN0OuRAsRcTulSRvYfpa8V3BUROT5gduOS6WogC7rHfldenL5mJ/24gUkVoOqo0lJX8fNuYGDm0OkfWLsYCuN37FJ9iIjL5aLYNjyxNyX2DdqOmki+vDk++zn/ZpYaJJye4J5NoPkKJsV2qp8YuI+IrNcBz0lsojSa0qKUHL3Xx2giKITgnxgt/wuF87DVMpdSLcUUufwKdwuD/54aCA70B68Pl1DtTamcX4gcqXMhFa3DHXcqFClK7VfOM+DzK1IJTDirtrLrqCQhmkEEg0GXia8ltl+n1W2M5G4Wdcm4oPwq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3XbHlh+wAG1DDh0FZWLyOpw6XdiUKST3DX5dtN5GPc=;
 b=ZQhjA2fHkOAw64FKcppHPaYCkfYxq3SfICwwj2bzZhNPqyj8EDlGFP8TaCFmuCTN2xSRfy+pby4sPq7R4YEYuoA/iC3jGNzbTpPXpuTA1QJniDcknrGl/Kw6kt+WDoZzKQ2fh1WSsjBmTY2ppsGO/88TmqBSgxuy5YeoRqPpJ4OWThMASFEp/kjdan8VCG4paXYmBP/CZw56GDQCuyY5it9HWoAkpxwg8DWKJcnWlb5vqJY9eQxdSF2LIeHvjgCcWZRdsLpc6zeJHt+Tfs0mWFQ1jsomhIpIkShsZ5ACLEhx+aZaeXE5cMeCTwKLQbyn9k9MnMLzgkvWBWh3trJbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3XbHlh+wAG1DDh0FZWLyOpw6XdiUKST3DX5dtN5GPc=;
 b=XBriR/BkyLDvi+DlPPuOOY8IBMVA59ChmS4tsw7ocEitdgUFMOKNj3d2v8ROw6iUYjd0d5hhmZ5oghBqUVDeDR/r3bIfVJ5hfKrbkhR32jTI8hpuH+/YK62u2o/qWKueY+P7xiM6ZiqrNom820Q25aow5ApEdmh1JbA8QdLbhQgim/icRXxdtsIX+VXUMbUheEJ8FjElxwT4tc8pj+jQqkmhJ6i6JaE7Ee0IFzwPS7RxShWn7Zy+5PFXh+jGkJFbZ7feMi6Giz+W0FfhNSsdP6qRDZjYoxDZ4VrVO0AG3HIYLT0ejmbH/nPU38Mw8lpcMjBQrKoMWt/qUq6nRCt+/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 21:35:01 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 21:35:01 +0000
Date: Thu, 30 Jul 2026 18:34:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
Subject: [GIT PULL] Please pull IOMMUFD subsystem changes
Message-ID: <amvDg1M6+Wu3HwSr@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZL6pA4d1cZEVZYEW"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR04CA0316.namprd04.prod.outlook.com
 (2603:10b6:303:82::21) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b77089-1b7e-4ea4-0609-08deee826909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YnEiKsJTdBcOI66uEOZeaeSSk8m3j6G5YhsnFi6u9jLBGefHZj16OQLii9Ect6jLw8oODxIKeF4PJ8EVoZRYuhnwFvNZex+8hizUftvnjt10H4DNWEf8dmdDHUp8MlJqpfyo56qIF4YBoCqJwCjReLInsIa72azTojYKNLPeEddNucDzOxsQZyFtXMn4XV4F1EWBvMxLWwQfe/bojV0Xg86UJaEyCd2YHwP0raknlJcs+kfoCdJAKpvi3tcrbGvuZax0IbVOkRyodnev4ca+meNt6Ho0kkSQn7FVjoCXYX+F7bF9Rsv5gA+v7g3r3ewdG0Kym+yTzznVpmCTJrBMz22FYDCwVkN5LxL1w5341GzMTlun4tcdqyozHo8PmxnncSAwd9ciJvr6Aw0FxOzJaUrfvnVtLKIorWY8NN9D07Ls9RmvVXxfaguod7AHgja6w5aXivscF6uaGkBxLeQ8VBa9UxxxRzpDw6mjlQi+W8Kmitd93uvAfc2nsBJ+c8D16aRMmVa40dkChzTlusr4s6Q6ZoJ6LmzBdB8DNdq6ufdn6w8tkQH8yNpXlMLBTxGBwgPfkd+sYS7rPnwfWfyNPG8Act2K2/BJe6PyEBwac+f/OuQIGnyHdncp/cmg3dN1BJubpZUSNDjl2F5UZzl22atRMDx/RSWV5GM3NQUhMDA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bGe6W84Rbu8bmW2jUUgLYvDO0MqplzXd3su+O2b/lgGHa12edZOsa2Nas6X1?=
 =?us-ascii?Q?bRJBlCNgvrWS9Art2UhweE9Gn73MlCg6fC6oe83idfCnXom89GDuXYqd8e3r?=
 =?us-ascii?Q?3Ca3mMv+xhQrX3c5P+N9pH2GsNycIAtT1KSETrmGFfWsQnkYjTg2c9mb9uUf?=
 =?us-ascii?Q?B7a1zn6ACSiWN9dC2Du8nsFn8qnqC5QdLh4RqSntKCQCd6Ad7Pfwv46TWEUe?=
 =?us-ascii?Q?4mMkXyj+hFj0icBXHr5LQjjBaozMECnQRVzCHFgdyyQUTWIQZ5jJVkjKopsl?=
 =?us-ascii?Q?s50qk9JOE37r1TWylUywGzhf2bEomVtIHCMwfbu7VtXQ3I3q/98YIP9uAz/h?=
 =?us-ascii?Q?pM+aKgqOrog9iYFjtvFf9klBDoC00AqD3FzNwxQjAYbzEZ6yyeStTfDPdWJx?=
 =?us-ascii?Q?/7RXNN8A4H7M033xAncjwjpoRVQbNMRGXTsX7ox2g9mQLPA+4qMse3du5VuQ?=
 =?us-ascii?Q?NBoQpQVStFmTVvt+FS+XVclw/xdtukJBlZdYiXOcqxDXbwVZtNKkzxatWK9j?=
 =?us-ascii?Q?IzTqywOedGuWy5OVYtjhEw/FZEqcZciyVOlS+hm0s/TCmQG8E1txI+18oMaw?=
 =?us-ascii?Q?qsT2m3+hDY9cREP0nA4K04eZk5Nw4tLCaBLj9uXoELzzcLmSE4buq5lq13QE?=
 =?us-ascii?Q?DTIR8bhWLrZFzjIAHkQFRsGJZbJdEuHcrlEqqSjvp0944ZPCPTTdelz0NApL?=
 =?us-ascii?Q?GIO/icD/taai5PAifi+fLpkYFm/19zC7/rve6SJbno4jNvBCLbBVzWHNpabb?=
 =?us-ascii?Q?wGh+aOoMMwRT17CTrxP2JNAZT7zgUKJ/MQqVO800i9CljKXUFUugOvNkrNMb?=
 =?us-ascii?Q?irryEShBNjqPLf7J0G//y1FyiJiHn1/Qb8Ke/tXkGQsr64rh7x1Feh7opo3N?=
 =?us-ascii?Q?ux/0OQUjLXtMn+2J+e5E84YarptiSH89yyjbgDv65JJmfi/dj1IZLFsHNgEr?=
 =?us-ascii?Q?JZcnoV36VZwcAkFV0DF79XnGrSriPCl38Zfbln4JM4A12LFq3bwaKrssAw77?=
 =?us-ascii?Q?SUgJR7VT+BTnpsYduqo1jjBOWwwupy4HzjWWEYjXmvEWCrLVyUKVBu/iwZnJ?=
 =?us-ascii?Q?aU1I0vWiFiAikd/SOH7XEeY2rutvYX67j0fh/QsNfU/OlVqjyXXDig8NwbIv?=
 =?us-ascii?Q?oOm03dhEN3XMFzc5r7bUnVhHWXs8c89kAuw5awyBCnl57uyBoEAs0JpgG4cc?=
 =?us-ascii?Q?lTp4xKHVmhRoI2d+QcPPW42RYxXL2aYE7xp5COkBHxL198g+RazWHTwWju4U?=
 =?us-ascii?Q?NCm6CMZGUO+NLGLU3kPe+M6bBJV6ppoSh0euIcQYfgDs4u0pxRfSIIJW4noS?=
 =?us-ascii?Q?2X53oMGCSw3bdySXLSgnKEpPuikRNzwKUsxrL3OwHYPXNdtvt80qfNhmSnxr?=
 =?us-ascii?Q?a5lNzwRZ0NZf9Rx03kJObnP+h2tIUX00QKH1vMt03dznm/1++P9+mecKGqbY?=
 =?us-ascii?Q?wA7X1JRfSaawT1Oe7mU7JkLOI3ungLSmNC/eUMw3oLwc9qwHIKdTdyAEYiGJ?=
 =?us-ascii?Q?ixwosAnHyZI6NnJATVVeclKXarlegyj/vfWB0AA8mKxgI9db8ubFpqloW2jY?=
 =?us-ascii?Q?vsOLKRHg87nDUMjMx8qBwelpY71rGUH+r/XR03QypZ7APICrvzrX5TJ4vn3m?=
 =?us-ascii?Q?TBOTM7MopKbvGsNSO6W4ZVp7SOJ8ZrM8/vh5jQRGMEJfdGL4+o3R4sdBeo/s?=
 =?us-ascii?Q?zmg8WqesGwSOsXvMy7yR9RrcvapZCCKBqAeNx7lwnntAm0xK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b77089-1b7e-4ea4-0609-08deee826909
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 21:35:01.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+wAz7+PmZyV3WZrWdPPLMdhpvopCPtOJxJC8C8jKl0B1E48S+xCOmApZVs2DlFI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

--ZL6pA4d1cZEVZYEW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Collection of bugs for iommufd. It seems there has been some
additional bug detections by a non-Google syzkaller, along with some
AI stuff.

Thanks,
Jason

The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git tags/for-linus-iommufd

for you to fetch changes up to 738e6f32e61d80b554e37015ecb7bc620b88001c:

  iommu/iommufd: Fix IOPF group ownership UAF (2026-07-26 13:16:21 -0300)

----------------------------------------------------------------
iommufd v7.2 first rc pull request

Several bug fixes found by tools and fuzzing:

- Incorrect domain passed during replace to ack faults

- Block the access API from using dmabuf

- Missing unlock on error unwind

- Race seeing a partially setup vdevice in the xarray

- Do not allow vdevices to have multiple stream ids in SMMUv3

- Possible UAF if racing faults with domain changes

----------------------------------------------------------------
Nicolin Chen (3):
      iommufd/viommu: Release the igroup lock on the vdevice_size error path
      iommufd/viommu: Publish a vDEVICE only after vdevice_init() succeeds
      iommu/arm-smmu-v3-iommufd: Require exactly one Stream ID for a vDEVICE

Peiyang He (3):
      iommufd: Fix wrong hwpt passed to iommufd_auto_response_faults on replace
      iommufd: Reject DMABUF pages from the access pin path
      iommu/iommufd: Fix IOPF group ownership UAF

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    | 15 ++++++++++++++
 drivers/iommu/io-pgfault.c                         | 24 +++++++++++++++++-----
 drivers/iommu/iommufd/device.c                     |  2 +-
 drivers/iommu/iommufd/eventq.c                     |  2 ++
 drivers/iommu/iommufd/pages.c                      |  3 +++
 drivers/iommu/iommufd/viommu.c                     | 22 ++++++++++++++------
 include/linux/iommu.h                              |  5 +++++
 7 files changed, 61 insertions(+), 12 deletions(-)

--ZL6pA4d1cZEVZYEW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCamvDggAKCRCFwuHvBreF
YcLOAQDBfYWcG+oMfPx8PVvXbzWnjm7lV14YmQoC4rXw9CGewwEAwqd225JZpMjv
5pgmppl+/HxGdc/PNgl1Nv0C14G4IA4=
=0aEp
-----END PGP SIGNATURE-----

--ZL6pA4d1cZEVZYEW--
