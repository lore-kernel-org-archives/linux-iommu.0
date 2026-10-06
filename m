Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706983E7625
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288908; cv=fail; b=V1MDPGcw595nmeA2yDUPPqRLNw7xRmBD6yn84sdRz+K1CBykZ8+kg7EWUNOYXCWIvbn9pXHgyyXs4EiqTtHVWk48i5bqoDHFLvp6BfveO0Wm5oCj7zJB2tzWVdh5OeQEHoyRb5wZub9pqSGeYYVyndbJUP1su3PV5FLXks4lm7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288908; c=relaxed/simple;
	bh=pXmVObVxcH/PsjBm4DW0cDYyqvFbDaf919CD9Qw1Stc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JZNCaCM1DneGfA86y+IdJnifp8TA/SCb3fsQJGcAsH+Nw3GCfEtJti8fCWBnzDtnnN8H6wyj+EkqBiviXd2cpH6H5gQSVFlGOjudNvqvBhNwNd+sGgGH1AqFb9QWEno3PTwmpsDL8nAQoVLdjRA1CIEaauWcZv4Mc2Gcjx+HfUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xWBjAy8y; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xWBjAy8y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lw6sZVggyz7HGPGgvXJeI8J7A13PQnl5t6uDkHFv8EvAOFGR4nFUMjkNGs+GOCCy1J7NxZWPS+jZmTRw2dQrpyRSM37DsMEL2DuITuRUZuCF8Ji5CJB8xvCrmRxXgfmQrGPijVT7g5ITkfgGlkUim/jh7fwP3nhBPDT0OoCtU/kFgeQy+UYy1KapfXJZVZyaRcABNQNC4+wiqLD1KOiMA2aYBuz3NGnJOYbbdj0yjHZZS6j/XBcSkTRuo/BNAebX4OBOMDV9tMsO9kTd7jd10KGTIK2Hvm/SdJHMUyUzIE0J2H0fkfMeEOSIv5YYtD1z9aHjieLKDuOAGRMQxUSTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysdwkQ0j+BnJKH6UxPWa6QYyVhOLeX78lk/hV/eRN3o=;
 b=SmMDjqYCsESU1ittQsb2v2aPEbVm5zKR0i2y6brS9EfmitYj+RTYty2Kmz1Wjn12DThbbr/2UTrR9yN8oFxLrrK4nhCMz7yiD/mbaMiADBToz5RFzzlsV4ohh+0rLVPc6qdjkEK5mybXvN8BtiF+lf9X5uZPqTCv1qEuX0byiFThEwkOhdehnNGPRSJguxymBZD8CYmdkZG1zBumd9l012HLM2uJwhxdLdjyockFXVIUKKmu0Qav2SZDveXrwkujwk7vjTdcBIHOBHwqlz/Gfq2TLCUEtENYfAnjeOExy/8Ak5Nt/EZK5dj6f62vUg7vnp8Qb3pUfRS4y3a+qIWfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysdwkQ0j+BnJKH6UxPWa6QYyVhOLeX78lk/hV/eRN3o=;
 b=xWBjAy8ywnNppqr9Z698ozJMtveilLmpoSwva8r7IMoRnjVXRUidkOHxuFikNpZgdc258+584Mo2QdlYDLl0PfisHsS9Ke/27kr3oWC0V5sHgBVdqfrMMThOymEGBeIvXFhMej8ivc1aDSMzx1E9JAGPEK31kALTTD41qF/uyTIw6T3lH9d/mxd6St7gw8hxw4G9iIwvNzoDtSbATcErJFIBVQrrv8TIlxKfH3z3s1DRWO+ipkONVSJBvA+6QdCmUo3dwGajaRgydygYhA69uDOp/MnZH2a91pRmcfrbHC6wPL30AzZmrOd7ul/OHSj4ZBP0ghnvO2pUPihKE4hlWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by FRZPR04MB12432.eurprd04.prod.outlook.com (2603:10a6:d10:1ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:15:02 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 12:15:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 06 Oct 2026 20:19:08 +0800
Subject: [PATCH RFC v5 2/6] iommu/arm-smmu-v3: Allocate streams
 individually
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-smmu-shared-sid-v5-2-169a59c671d3@nxp.com>
References: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
In-Reply-To: <20261006-smmu-shared-sid-v5-0-169a59c671d3@nxp.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Jean-Philippe Brucker <jpb@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Thierry Reding <thierry.reding@kernel.org>, 
 Krishna Reddy <vdumpa@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.16-dev-7bc12
X-ClientProxiedBy: MA5P287CA0208.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|FRZPR04MB12432:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d03e404-3788-407d-4987-08df23a3730c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|19092799006|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	NQ9a921c/OMFaxB8fjU2umBI/0rpUsMUpEZelNan7RMewslcOq9nlTdsi711eQaxKKOxxZe2dasrmrlHYLg88Vo48gGL8AjYbSLcnCW69XlQ6T/sISOtJNtlHLwHl6R1bHIAVMl3J+ggU79eN8RYDDuqYQq+XkDHUb8UtF49loxRTFd0fN+TAR3xDG8yhG3hn7hkvC/DewyTvQgkMB1emw3UZijhN2StyCmiDs01fPYHgJ3Ze9JeSXwnCfZ650TxitmeXl5k0D4v0Y7mYgxdxdDwLoOxyYSlEWF4B/uru9CMSEhqIbO9fxoqVPYo+TfL9bvYOD3zhoWoRkbsV9L+UCBUGOd5BLmRWQ1w5QIbnv5nwNv1B3vQniLR8ihfucUx7JYHlQ4n8IwQ+QPPBZOSz76gCJVLTCdECh1oiwsMJjPR28lAVnRNTZ2j6TiSsByD+/8JvA64df/x0km0CKah3Rl8EA0ZIWswTz+aBn8uvc2a/YSCBOM6dwhLWbmg1weiJpxzf9dH0nFq2/ALPm0A2a6mTJz706xFAHu+nlKkktj9OSFmj6V7wZ1d4FFuWI36Z900R6J0Nrbc1FurQBBvt5toG9MwjbjkasHGXLvU1Qq/gezboGPqk5WUqLo2VrUZHIEaAaGuycDxKMmVV2nrLcUkS7G+m0JheyD8eB7UVIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(19092799006)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUFWZmdmTmhtSU5OSEcrTEVzNHAxR3JDdTltTzJhNk5KdVprT3FqeGFxUG1o?=
 =?utf-8?B?djMzMWdxZkRUMHFwTUErVUVxOWdJWkNmcTJxNytGYWltc1hJaGNiS1JBV1cv?=
 =?utf-8?B?bmU4MENaM09KQjU3RmJydE5WNmk0Z1lIZ0hSWUZSVlJ6TnQvbkgvYloyMjBs?=
 =?utf-8?B?MHZnc091c1ZlYXNuQW1qdFQ3WFRIOWxscURUQzdqUlFkRWNZNFhlOXR3bnU0?=
 =?utf-8?B?Wi9nRU01RGVxTTZNMDVEa1FRL3VwS1dORCtSK0U0TXJXWGVuVzRFOWpTVWJX?=
 =?utf-8?B?YVNmVVFtNGp1SXNmSzhTZjlVYnM3aVU3akpsb09MM2M5Skp2ck1vd0E3djg5?=
 =?utf-8?B?aCtkQU93R1JZOUxFUHMzTi9iQndjbmlCZ0sxSGM1NUwrYjZlNU9ZNnJLNFh6?=
 =?utf-8?B?eVRYMXBmNE9TSDBDTXAvMlpJd3pINDZyVmpUUXltRmZHa0RrcHF4b0piMW5h?=
 =?utf-8?B?V1U1RnIzV3Y3Tnc1THErNWx3VlY0eGZ3RCsrdXpYMmd4bjg2VXBmRXdnV3FZ?=
 =?utf-8?B?aTlpM3BRQ2tiMittRjl6eGhkaWtMd05sTktYVXBTZGlCekp6L3NFR2NHWTNQ?=
 =?utf-8?B?QWtVYzAyZ2I2Q290ZGlsb1NNMEFaQ0JZQ2FCQVVwckhVTnA2OFZJeldyL29M?=
 =?utf-8?B?MmIrdVdtZFNuQXFDdDFIbDBDWmZvdlJLR3MzYTlDS0NkeWhRR1pIM1RXTDQv?=
 =?utf-8?B?bG95STlRL0JUaC8rUzlvSUw0bHZtZTBEOGJnSEdFejR6UkxtUGVoanlqYmpS?=
 =?utf-8?B?UnRwTk1UTWc1MzdDTjdyMzhCaXlqaTlDWHg0SVFleWJLTm9oWkJFWHJ3OUdq?=
 =?utf-8?B?WmZ1ZE1XWERDUGFTMUt1YWhIald4NTJheEUwbVhIVEVZc0dqdzZ4OXN4MGx2?=
 =?utf-8?B?K0hwOTI4OEV0YXc1Yk9qVEpUWWJwZ1RheFFPM0cyNGF6OHVIYjZRYlZ6S2Ix?=
 =?utf-8?B?YmhNNWVzdWpwRWE5QzkzbEZBS0gzTmRucjMvNlpLVWNFNDNJQzVIV0dGdEdz?=
 =?utf-8?B?OTAra0VzNXIyUnh2MXp4SkMxQ2l2RzZmbUNRL3RSU2tXVkVHd1RnUms2QUZC?=
 =?utf-8?B?dy9xYTJFdXBVTytKZ05XK0V2NzV0UzZsTVpyQjBtWlJZTDBFNWNzeTVsTnA4?=
 =?utf-8?B?d2dXTFIyTGNtb2lsVDRhWFVSSkdveG5RMy9wRk1XTFU5d1R6cFNtRG1tT1Zo?=
 =?utf-8?B?YlJDMHZnV3M1aVlwSFp4OStxOHF5TmVoRlJOeU9NcmgwTDhpbXMwTW44cCtT?=
 =?utf-8?B?M1Jxa1NXbzVsY3FNaUo3WUxIZ3dNeVRWSklYcjZ5K2ZTUStrY3d2aFRXWDBR?=
 =?utf-8?B?TkNnVU43bm9mb3o1YnlnbUhBQmE1RkY5T2wzUDFYNXhvbm5aYkw1TXFZeXZV?=
 =?utf-8?B?cGpqRmF2UDVKeUZCRm5JbUIvQ0VCNlQ1N0pjQS9HdUIvbm9oMG9Ic0k1OEps?=
 =?utf-8?B?dmRaVE1EU25sUngzOUR1amdqRHRwYmowZzZLKzdLVDFrK1h4anlqSEZIS3l6?=
 =?utf-8?B?QW5WYnFzMTU2NjdmQTQ5QTA0c1ZmU2FqMmxqc0pOc1J6UkNQQnlTeVk1a3Y0?=
 =?utf-8?B?UVkreTRPd3ZOMjN3RUloekZGV1N3eWFiQm5GYi9Vb2dDTUZETDlnWkwwZVg0?=
 =?utf-8?B?Rm5BMHNkdy81QzVGNHBaMitaNnk4algramptVCtKQlpYMkMvM1lQbko0VFg3?=
 =?utf-8?B?M2ozL0hzeDcrTzJIWjJZS2JUcGF1SC9KTndYcDluQXYrcUR3anREdE95YXZ2?=
 =?utf-8?B?cXJpTmJMMm9vbGJVQlRHb0U3THZwOTRNT0I1Rjcvcks1cjZIYUNaZ1NOWFpq?=
 =?utf-8?B?aVVXYkp2YjVQUWRRRDlaMG9halloa1B2ZGxOZjNxNzY3Z2xKOXYzRVdpS2Nw?=
 =?utf-8?B?amVjaHdzMktHYm02cW02RXdFMTAxT2tJOVhuck44WGxtVUx0Y0lPWm5PUXRH?=
 =?utf-8?B?OTRWUm13dGpwYlpKRVcvdGpuNmhUaVYwczNsdndCUitEM2RRc2ZLL2JxU2pS?=
 =?utf-8?B?Z0o4ZFRvU2RFSjE4YVpwem1BTjF3OHAyZHlTLzN3YlN3WmdIazJDOEZLampF?=
 =?utf-8?B?bEVmZFc2aU91UEREcnR5cy8yTHhSKzlXN2FLd3Jkd0dRN04xV0xTZFpRTHFI?=
 =?utf-8?B?Yll5MU0wOGU2OXVzVXU3bTFyc1pJU2cveEs2SlpUejFtTTBvV1RIS1hIQ1RF?=
 =?utf-8?B?OGh3MExvWitQWTlCL05vcjBHczAxOVd4Q3pib1dRdlhRaVVBKy9PcndoZE9j?=
 =?utf-8?B?MlFVanlCSHVxRVEwNmVjV0FwS09PeVBsNmJZeTZwbTBqYTBhWG93S2FJdFdP?=
 =?utf-8?B?SUpVTVhOU2l6UmJmVit0Nncxcmora09Jck8zQzl4SXB0bkxlYjFrclNib1d4?=
 =?utf-8?Q?KUy108BMLtTZ4hcnuladnnSRbYlEio1Sg/hD/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d03e404-3788-407d-4987-08df23a3730c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:15:02.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWCQUIxlmf86ESFMm+qbiap1sVCPT8K/rfQWV0b58uTip6je47dUsuIi1F1Y76Q2HY4YF0sYTYQW1aCyF9W4h80EXv/QoV6KrWPJLUMxQgXgattjqBujOsFWA/YmAvn/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR04MB12432

From: Peng Fan <peng.fan@nxp.com>

Change master->streams from an embedded array of struct arm_smmu_stream
to an array of pointers, with each stream individually allocated.

Prepare for shared-SID support where multiple masters will point to the
same stream object. With embedded structs, sharing requires duplicating
stream state and manually keeping fields like ste_installed in sync.
With individually allocated streams, a sharing master can simply point to
the existing stream.

The sort comparator is updated to dereference the pointer indirection.

No functional change.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/arG6hmng3NddGEHm@nvidia.com/
Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 52 ++++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  2 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |  2 +-
 4 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ab1078a97d801..0934a6bbd3e08 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -294,7 +294,7 @@ static int arm_vsmmu_vsid_to_sid(struct arm_vsmmu *vsmmu, u32 vsid, u32 *sid)
 
 	/* At this moment, iommufd only supports PCI device that has one SID */
 	if (sid)
-		*sid = master->streams[0].id;
+		*sid = master->streams[0]->id;
 unlock:
 	xa_unlock(&vsmmu->core.vdevs);
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dba6c2942af8f..9d34eac196a65 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -972,7 +972,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	}
 
 	arm_smmu_cmdq_issue_cmd(master->smmu,
-				arm_smmu_make_cmd_resume(master->streams[0].id,
+				arm_smmu_make_cmd_resume(master->streams[0]->id,
 							 resp->grpid,
 							 resume_resp));
 	/*
@@ -1504,7 +1504,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	for (i = 0; i < master->num_streams; i++)
 		arm_smmu_cmdq_batch_add_cmd(
 			smmu, &cmds,
-			arm_smmu_make_cmd_cfgi_cd(master->streams[i].id, ssid,
+			arm_smmu_make_cmd_cfgi_cd(master->streams[i]->id, ssid,
 						  leaf));
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
@@ -2431,7 +2431,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	for (i = 0; i < master->num_streams; i++)
 		arm_smmu_cmdq_batch_add_cmd(
 			master->smmu, &cmds,
-			arm_smmu_make_cmd_atc_inv_all(master->streams[i].id,
+			arm_smmu_make_cmd_atc_inv_all(master->streams[i]->id,
 						      ssid));
 
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
@@ -2978,13 +2978,13 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		STRTAB_STE_1_EATS_TRANS;
 
 	for (i = 0; i < master->num_streams; ++i) {
-		u32 sid = master->streams[i].id;
+		u32 sid = master->streams[i]->id;
 		struct arm_smmu_ste *step =
 			arm_smmu_get_step_for_sid(smmu, sid);
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
-			if (master->streams[j].id == sid)
+			if (master->streams[j]->id == sid)
 				break;
 		if (j < i)
 			continue;
@@ -3276,7 +3276,7 @@ arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
 		 */
 		if (!arm_smmu_master_build_inv(
 			    master, nesting ? INV_TYPE_ATS_FULL : INV_TYPE_ATS,
-			    master->streams[i].id, ssid, 0))
+			    master->streams[i]->id, ssid, 0))
 			return NULL;
 	}
 
@@ -4078,10 +4078,10 @@ static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
 
 static int arm_smmu_stream_id_cmp(const void *_l, const void *_r)
 {
-	const typeof_member(struct arm_smmu_stream, id) *l = _l;
-	const typeof_member(struct arm_smmu_stream, id) *r = _r;
+	const struct arm_smmu_stream * const *l = _l;
+	const struct arm_smmu_stream * const *r = _r;
 
-	return cmp_int(*l, *r);
+	return cmp_int((*l)->id, (*r)->id);
 }
 
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
@@ -4111,10 +4111,16 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	}
 
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct arm_smmu_stream *new_stream;
 
+		new_stream = kzalloc_obj(*new_stream, GFP_KERNEL);
+		if (!new_stream) {
+			ret = -ENOMEM;
+			goto out_free_streams;
+		}
 		new_stream->id = fwspec->ids[i];
 		new_stream->master = master;
+		master->streams[i] = new_stream;
 	}
 
 	/* Put the ids into order for sorted to_merge/to_unref arrays */
@@ -4127,11 +4133,11 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	 * which sort_nonatomic() invalidates by relocating the entries.
 	 */
 	for (i = 0; i < fwspec->num_ids; i++)
-		RB_CLEAR_NODE(&master->streams[i].node);
+		RB_CLEAR_NODE(&master->streams[i]->node);
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
-		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct arm_smmu_stream *new_stream = master->streams[i];
 		struct rb_node *existing;
 		u32 sid = new_stream->id;
 
@@ -4161,14 +4167,21 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	if (ret) {
 		for (i--; i >= 0; i--)
-			if (!RB_EMPTY_NODE(&master->streams[i].node))
-				rb_erase(&master->streams[i].node,
+			if (!RB_EMPTY_NODE(&master->streams[i]->node))
+				rb_erase(&master->streams[i]->node,
 					 &smmu->streams);
-		kfree(master->streams);
-		kfree(master->build_invs);
+		mutex_unlock(&smmu->streams_mutex);
+		goto out_free_streams;
 	}
 	mutex_unlock(&smmu->streams_mutex);
 
+	return 0;
+
+out_free_streams:
+	for (i = 0; i < master->num_streams; i++)
+		kfree(master->streams[i]);
+	kfree(master->streams);
+	kfree(master->build_invs);
 	return ret;
 }
 
@@ -4183,10 +4196,13 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++)
-		if (!RB_EMPTY_NODE(&master->streams[i].node))
-			rb_erase(&master->streams[i].node, &smmu->streams);
+		if (!RB_EMPTY_NODE(&master->streams[i]->node))
+			rb_erase(&master->streams[i]->node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
+	for (i = 0; i < master->num_streams; i++)
+		kfree(master->streams[i]);
+
 	kfree(master->streams);
 	kfree(master->build_invs);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd2fee2f560e6..ba430078cbce9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1000,7 +1000,7 @@ struct arm_smmu_event {
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
-	struct arm_smmu_stream		*streams;
+	struct arm_smmu_stream		**streams;
 	/*
 	 * Scratch memory for a to_merge or to_unref array to build a per-domain
 	 * invalidation array. It'll be pre-allocated with enough enries for all
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 6644075c1431e..bc62a3d5a63f9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1257,7 +1257,7 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
 	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
-	struct arm_smmu_stream *stream = &master->streams[0];
+	struct arm_smmu_stream *stream = master->streams[0];
 	u64 virt_sid = vdev->virt_id;
 	int sidx;
 

-- 
2.34.1

