Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013086.outbound.protection.outlook.com [52.103.43.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899AC2F28FF
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049275; cv=fail; b=OSsYnxGqql+w2NT57s9caP9hL+VsVmYbnoRJHDEZyyLRhvyfDx0L+RUV2NU5v7Go8t++6WB70OYm6Vojc0c812uYwRqR1jTXryeoQ/Nhcyytx5XIBUdXJPDbG6a9lqEMvygiaLVjaSRuRYkHEcXBZLQVwJXWNvnN7jVMiL3TCkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049275; c=relaxed/simple;
	bh=64IdCAsmmgIeTooVUM/2aYxa7VuJXoKJYPwwRU0ZTg8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oa/9pSTN0pfQ7Np/MdvJb42Pr8oIK/tTqnb97WnIHY04/MMmY3Ghc4pVyAxKCad2XOwte/gA7NIW4w3z/qpSDffdq1YdHFiE06ldhbWanWCxxxvEFqkZBiEtq+G/iam83fRt7Bj/WtzM72pzQa+UYRiP0oercfUajGHDPSOGnMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=C/5GnUQe; arc=fail smtp.client-ip=52.103.43.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="C/5GnUQe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSegokRz0KmM1sswxJ3lRGSQr6EZQk42VN2YXHzh3ISSLuBbqIAiKIDb/l4oPZnqbzKPKnLS7Is//I4tYuMz7BsYxA09xrUT2vjPVrQUEDSk0sg84rxQBY5usB4qnTx6RYca1J6b6Vw3YV1tEp9S4I0fnJ/vymPl30laL3B+d83yKDVxq2nkdD1BhJwLZZVM0aWQziju4jLQOu6U8D8Il6lb0mLF/8xf1L5MXzWvi8SBaYcLLLpc9zUd03gvPHJpnsVe9TS/vurhf1F3gboBTpgrkGIy0hRq0qsysKdo2yXSrzNW2m30l3ddgPZOeUQsWAZBCyh2QnaiRT3iYndBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8joq66Zs66ZobpDwvG/Hg6b8AFVZ1+UTeri9TJyY/Y4=;
 b=pnW/Db1MgXOPJvp+3l5gupRHpTsAqWn0fNNL0Pk2xQ+1aJS/77lhIgTFpzjLfugYoeYy+C2m+wsZludEIGTJmRbXWDCphVH234oHwhS0kWJR7nsE7HD9X5+I6tzePlWPq4WbpDgJlxvWQOEhkb0wGsfLttGsdjsoB9IbNS0pnUyOGgck8JnaO21O6duEfHWJ6jlLtXB81edqaPolBLZHstiSrWoflV5oOPRBpVkj3zw5E82NXIiX6ciTxsUKKibJOzstyH3w6AFc1rylYO0baVo9Ny1yf5gANg2nzgNRRa3pTR29MCeHkBwsolYNR0z5x9oM2JdRZ7qQur9jQSQlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8joq66Zs66ZobpDwvG/Hg6b8AFVZ1+UTeri9TJyY/Y4=;
 b=C/5GnUQeSXMKpiuMUqTedvCsv/IpkXRJJCH5AIe1AsHm88Qg2GNeaNwFtmPQyBb9gWfMfwIbf/fvSn63d8cBFXqs+zF5Ee18cwogUcaiiGQF2VCHxB2GUKTRBWpI2oEPAVyxfUyetG7jrZwXSvpgc1qV2kVIqysR3Rsk8PEqKypoQPKNV0G4/OUrC6DE0s8As4F5HOsfSI7MmW7FnZ1ZZhSBNS2DbeAQSwdO9gHTr/JOcUDbLcnc2U0WDdfbxlewMDQVlSUtQZy+ukFZgKePT5U2U/Jq3eNuRDgcH3cctNeoO5uKs3YAfur99pmEtH6xplLjCL0jLLqAjGFI7n7qfQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SG2PR01MB4170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1c9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 15:54:28 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 15:54:28 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: alex@shazbot.org,
	jgg@nvidia.com,
	thomas.lendacky@amd.com,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	joro@8bytes.org
Cc: aik@amd.com,
	kevin.tian@intel.com,
	wei.w.wang@hotmail.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH v3 0/2] iommu: Avoid setting C-bit for MMIO addresses
Date: Thu, 13 Nov 2025 23:54:05 +0800
Message-ID:
 <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:405::16)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20251113155407.1183804-1-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SG2PR01MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 533699c6-a438-453a-7f18-08de22ccecfe
X-MS-Exchange-SLBlob-MailProps:
	P1EfU6pZOd+hyYl8rT3WM065xpIwoBqOsIfc7xyDvFHE8GtJ6zkWDwyBmFCmL5b3jHgSxZLe3wikK+kU1/Ryqnbl4/fiBjJRA5QutGCCKZUBx517PLUW8fzv/kBF/X7VxRqqAFDuvNXn0qo2gNCeClfz2MsJKhGBS0lIh7AGszsapdykGpyNR7sik2poVmM7lxyYT4PjGfvU2PVjS3Y2RW/YjkLIj9F70m8WNScIMx4oU4dz+CNZSZ4kpakpIngKCXZrzHTorpCCRuFPBlhejyufEiTHPzQgh36ESEID0y9+uGzVeo0QVfsX+hMEn8siMfaySoECUwivD+vkLaeIp5XSQpK2twhr6t9IqbNTKaeSHQMncgAodd13BQYhJKCGsTbIUtHFARH7X5L/dYmKjYnrcfHpzmKQ2Oz8zJUr4ooJnKfXjP+sJnLpd7Lgk7kGlbf5tCKbTnLDsg6hf1hUCPvcX/9775fPXnJwin+RYdgupn8dohzrM5e2RvEgcTFenlED0lVUiWkoQZa0tJH8JHJNckph0SLTd5TPijcHuwI9x+MHGLQq2wWK7UJqsxMge6RqJ3SfM3bx0iFz14r/tVJSMWXX47sJEpfoZM9UPG1NLZo7ukbaBf35k3CQvsGVaqXbRHT/5nLIv22UeayiAj2HHtsWWNytrN0HgzYdc6Gd9RancLWmzt7xR8SNyVgFayeXZeNeDTT0Uturw7Y8nsKz9IolZLPgF8andQOl8DlXXwPaVDEsS4oyGbsX2f4HkfA6ZX7T9FGltRvhNXxuMD0pIpIEn6vv7mMYwVEP63JXNYC8NlIV9w==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|8060799015|10112599003|15080799012|51005399006|19110799012|461199028|1602099012|13041999003|40105399003|3412199025|4302099013|440099028|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4oZ8KFAfVxzG2olKqAC29ExRri139iAuQ1kOot4mQcHX0XFQSI6eXI5bN9HY?=
 =?us-ascii?Q?GSon18C3wMq/HDrXEnARI6axwsZoBKpSr4UazH7bv5Joa5Sq3GzhdbbmFSJN?=
 =?us-ascii?Q?ScfSUBgiHqMtwW4GQvrZjtJ/QnHCQjd5GwzAzFCXZze49dyXEctJDjUMt6pH?=
 =?us-ascii?Q?7WQ4mspGjzi5deH3TD7S9+aXdXPM+eP6kYVWSRvT1gepwfNu25ELq634qQnQ?=
 =?us-ascii?Q?DuV1VUI3a+2AZthiniXi/4mPa1NlY+AkTGTY5jB2vTtcELB1hWwjBDblZT5S?=
 =?us-ascii?Q?pNA5VzZJXCwJ+rWMx7RLXgaFnlOmKHbWTdCaBsswbyNGdTRIpHW7UseanLFq?=
 =?us-ascii?Q?akj6nGPlJh+pQm79Y56CG4VBoJ1IGTBoMKq7sGpSOF658bFlt9SIv7V1F8Ug?=
 =?us-ascii?Q?RDVg8Lhb7GEUEZdaD/ptrcoeVMe7X+M2Jlx0PhOlKuUn7kzDakj24CZdBHhR?=
 =?us-ascii?Q?1HyYeZQ96umgwZy6MdWJ2sGRMwMPf7yHWYfXrR3Xm20oxzZ173nxfdvrpzYy?=
 =?us-ascii?Q?wy+GCp3oBZpA8jo6OHAaAW03MxPvWSlJsljOxhRoal0W93KZS6T7+62kOf5o?=
 =?us-ascii?Q?SPU2gZTURBAssRaE+JD+GLA3KhrFL/E3N7xw2XOUTdu5W2hKJPYExpkTsRqO?=
 =?us-ascii?Q?th/S9BUwNIJe4hTt9w3ix19+V6uvioDBAhsdNy8yEFsiXQoWkf8HlSMILCjK?=
 =?us-ascii?Q?Lc87uPkCWm+57Y4fDt+Ccw22JK2rUuooZDf6JHJs0Hf0ZrIU8jRSjGZDVco5?=
 =?us-ascii?Q?BpseCFzFGUIOvBVvRPvc9uAv6IMHo0QdiDzGzpbJ4I2ZESAlJMUioqJ5qvEX?=
 =?us-ascii?Q?l4GlPc640vpsc142TBcUEpST2wPbbdgSjMWGtgHtooUjTZXuQEBULz1Q9Po3?=
 =?us-ascii?Q?2YtL8fbtEnElJPL+J4NEEdmyBK1LlTmXwum6oIRkZbn6hjInMQ0TT1yoR5JN?=
 =?us-ascii?Q?OzvbF5b8ew7UrgjCQivYXPZT5TR6R0omQr9BqNPJ5LTrTFJPp7hwVNh14ToE?=
 =?us-ascii?Q?H6migzA9q6sV+/9bmPQLZwkB/IP0hJxYlVzRqZDddLXUweLSl6AObM9oJ060?=
 =?us-ascii?Q?+lrOSoV8XPlqo5CximMXfZ4yR+ehzaSrSp5n8bG+NyN+td5/gVoNd+V1lTwM?=
 =?us-ascii?Q?NuR5wDjhGT25hXAu1RzIqZFSyWVOESvXLDPyNi5eJ2WIPGnQAXQvJbvDNw1y?=
 =?us-ascii?Q?zkuFR+rWRm9cJu++B7CoMs6NWPM8XSZ8bbj3lMctxcMC3igJpgAm8PUbjR7X?=
 =?us-ascii?Q?uPyUYDFwPr5sau13jC7vZW4yV9TpMXnmieVGzKlhofhrn5e12o6h346sTDh2?=
 =?us-ascii?Q?2qG7ZqIlY2bgel7RbOsbsjkwZ8izN3MD0xuYBBY0JllRS07uV7yo2jATN8L9?=
 =?us-ascii?Q?bFykmny+hNmH8uzH5v+SknaUfG6wzpCgg/gPb2TKaAPnIuaeHw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UVzLcsx2cuVMWhv41COTKENspw4WJuuFQ8xRVPFj3NNOWYYxVbeiNPX4C/+J?=
 =?us-ascii?Q?ACp2ByggT5ealnlTv+bs1+GTDVP+MIaan6K7I7ZKy5VRdMYKCxWjKS0sX6+u?=
 =?us-ascii?Q?3y2cXsn20P/yPCnBCh8kvA2AUDvbLX315gBZk7J/Y9A0BexWvqhnQipD5uvQ?=
 =?us-ascii?Q?dlTW+McuovWEo/Vr9yY3/PTGtQNvPjbZ70W+niIyUYm7+Q2XQmO/mEIz5K12?=
 =?us-ascii?Q?d5LBNyp/q8jM34i+mQQlFXWppP4mMDRrzZEot0+4V8zJr+BtclvZrBTR5x/4?=
 =?us-ascii?Q?m/yRD9SPvqW3bKSXKegavu0QmSMvqL+/syDMiTYwtJK7I4rvtevexhxjw9R2?=
 =?us-ascii?Q?aMr4wdEcpV7JCmEFwZ91iYOpLTJgQLwRaBylPo/eOiJJH6NOXN85IvsQfEyi?=
 =?us-ascii?Q?ag53hLCuhqrYlmKB/DfO81LmGZsYqVrtCdg4bqnoz8tEcKqDRlR+mvDxqd2t?=
 =?us-ascii?Q?m+HnF3qKqMaoCcYZM9ADII+Z82VDK+VIY6n8DZosFd8fUYtIqj9KXsDyb0s4?=
 =?us-ascii?Q?ojE3uW5ZewSUvCqSWUqPisWyD8dH9NvAh4HzUmgPPd6fMMnDLswT4Dj03Mux?=
 =?us-ascii?Q?B9V5sRoMl5ByHyVqexy/6Pe3grqWzI4YWQHi5lEYnhEGvPxxmPsR5h/iNPHi?=
 =?us-ascii?Q?XPxx/eVQehkN3nyvZ4H17WOutX8Ham/+TPHM96WNPqKmTcImlrLtFWC7F2xY?=
 =?us-ascii?Q?F1hYNCq23ISREL4I9kC1NujlY54nd12dAi61WeGoRDSe9Ku7zo2YXNXSp0yy?=
 =?us-ascii?Q?vZ9D0hoCX0ZTGkGmH01L3hfkshb7eE2FTWCEWeoD8jKyJMJM1PavDdx2kt6+?=
 =?us-ascii?Q?iOtZzUXg1dDL3Xq+Qhedbwdb99bwbJtCzYRzQaEnDqJ52toLeoN3KPaQm9v7?=
 =?us-ascii?Q?QYqU3ClxKIoEGO8oNloJhJxl3nwAhsYu6pGbMwg8w/FNXfzss+19TgLgd8rr?=
 =?us-ascii?Q?9rHkdrBl7WPWj6wn5oMbuLpWatXtevRSJvAQX07YzNI2jvIaBLoAGTL51PkK?=
 =?us-ascii?Q?WfeWu8hDK4elpecqNQmkNXTfxqXf+SYI0sjE7kWM+10WvnAqHBBcTpUX6D7m?=
 =?us-ascii?Q?0Mp5/JBT7WbPRlHP9oN8FH+nOiy1bLr3UjqiqeyB3jiY9XHPBrFNZmj94oAS?=
 =?us-ascii?Q?07jl1DZwDE/mVja+kCuiiQfXWjo9nXDCmhoyITVEh7HH9SXwfLsgkMJ00L7v?=
 =?us-ascii?Q?R3LQidHMy22MdRMuEPJf/TTQmVCpUP31POL8MUWbnUUgmiC2vV9y987TO24?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 533699c6-a438-453a-7f18-08de22ccecfe
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:54:28.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4170

AMD APM specifies that any pages corresponding to MMIO addresses must be
configured with the C-bit clear. The current iommu implementation sets
the C-bit on all PTEs in the IOMMU page tables. This is incorrect for PTEs
backed by MMIO, and can break PCIe peer-to-peer communication when IOVA is
used. Fix this by avoiding the C-bit for MMIO-backed mappings.

v2->v3 changes:
- re-implement the iommu part based on the iommu tree which has the
  iommupt patches merged.
  v2 link: https://lkml.org/lkml/2025/11/3/878

v1->v2 changes:
- 1 used page_is_ram() in the AMD IOMMU driver to detect non-RAM
  addresses, avoiding changes to upper-layer callers (vfio and iommufd).
  v2 instead lets upper layers explicitly indicate MMIO mappings via the
  IOMMU_MMIO prot flag. This avoids the potential overhead of
  page_is_ram(). (suggested by Jason Gunthorpe) 
  v1 link: https://lkml.org/lkml/2025/10/23/1211

Wei Wang (2):
  iommupt: Do not set C-bit on MMIO backed PTEs
  vfio/type1: Set IOMMU_MMIO in dma->prot for MMIO-backed addresses

 drivers/iommu/generic_pt/fmt/amdv1.h  |  3 ++-
 drivers/iommu/generic_pt/fmt/x86_64.h |  3 ++-
 drivers/vfio/vfio_iommu_type1.c       | 13 ++++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

base-commit: d22ff9a783a792263baca22f80a64cfc7ec319ea
-- 
2.51.1

