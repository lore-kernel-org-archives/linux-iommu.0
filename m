Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013080.outbound.protection.outlook.com [52.103.74.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64DB4DD6FE
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003248; cv=fail; b=Xv5EnIwQHIBn809trqgInazN2KGUl+sOZZq1nA0yWVz9ijO9CDEgWytcZqALqfRf7oryI8g/5xgobuEJpQX2wsyUaaVg6+BQEqd+bDJ3PBHSTKPmf1i51GT3pQkLGQleRMMHvojNv9bkvjtlsKr1Vn71XEoN8Cy0yMWXlfWA7fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003248; c=relaxed/simple;
	bh=mG4HknS7i/flidh/19EKw9DfmiiIX0NRkqgf3OvCDN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uiu/4D11WpxYVa4sJrSFGHrwJIwnsqvzs5Xc/ghWDONX5WVDA03w490xYxzIxXZsByDRnbZE4948B0oFC8o2QCF1j06mD7mY1gX04T6L7lf7rP3pEyimw4ZpifJyTohkmo5JGYTHZ8pWt1vZr3FchOpdpdjzadBZpwzp8rj/KyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=GOA0Z1Gt; arc=fail smtp.client-ip=52.103.74.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="GOA0Z1Gt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9VdksLjeB+OihlJmjMI1B+G5YZ4gnk8367RzZM2WdGCKQhDZJe4gXRB9PxFVNpvp/522So90kryrqbLzwIkwft4dquxni5WILAxkO0CLtI9q9yDA0Ft+CMuIztQYFDrubMpUJHO7jV928bWeYhuMTCCY5xmh5y1lg4vdKcwoJaJ+SA94QjJl1bZaf+2ccMi/SzAErhHlfar8jcxO5YGAhSbUQKtclVN5wRf5u9fs65/+TY0ClMb+oHZaXbxcavcELDVCZ1h+Bj4Pn7GOp3lLByi2ouO7dC0yvDSFV43rNBpkd593o+b0/IVXGwdtpTikR4m0CLXQtzYz7pMIxfU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lx+Qm3/qUHpOa0D0yUDGaWA6aINc6fCBvX4tWAgp04=;
 b=pb8PfVurQv0Dqfe6izFC4e6946l/YdlMhjjcE9lqj1tM6mW0uFSFP1asyIhM/CKV9ZnTST7BtbyiUpZSBVIm6NdaMFHHzN+TEyB3MFxaatDgjp0l1aV0I03rcpFctHnMypTrcIieMCPaiAvA/jUG8aD3DHAdF3EBTikNdDTEsX2e+EPrZsSOzo4I+YzeOY/kzTEcBbwPoDkCpSMw6bIvn/kKHd18q7hsQ/3vo2cXuK4qIoFb0LCyAPDqDrtRpEBgb+hFynqbtMbsCUInybdHo2klD6E2DZStkAMtXZbN66L3vAW6Lha60/qnzx5L8D5xqNQnEMGEYB48PspXlBqu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lx+Qm3/qUHpOa0D0yUDGaWA6aINc6fCBvX4tWAgp04=;
 b=GOA0Z1Gtu/D+m+/QEz5KmsgYyzSnW8Tw+kF2cMAhpO7kOlIlb4K/7aPh42JBVEvRbimbsmwWTm0C3l+bwOhNhKCd3jbTPo5afDDW0aNB7WCycasiSu92PfrKFoPcvBzv2YdDT+UQp8mB3lS65/opYiLNhq8GjIAjVyDvMSHvwOjnyZ23jJloQ/kzX6K/2KbQfdG05kGN88/WA+NqMQZwIvigG02wP/3+hnuLoDWAHH9kgvO4C8+uA7J2IqKUiEB1LKEeeLjASv0UT6RdsCvaizmaguVGMp0pQfrfKNA4BTXirS+4M/7CZlY+08i8fDUt1QhmPE4H6GrBxfvVT94R4Q==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY0PR0101MB4786.apcprd01.prod.exchangelabs.com
 (2603:1096:400:27b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 14:40:41 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 14:40:41 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: joro@8bytes.org,
	vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	thomas.lendacky@amd.com,
	aik@amd.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wei Wang <wei.w.wang@hotmail.com>
Subject: [PATCH v2 2/3] iommu/amd: Fix false positive in SB IOAPIC IVRS validation
Date: Thu,  2 Jul 2026 22:40:19 +0800
Message-ID:
 <SI2PR01MB43933E6F02757CAD5BC03A44DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393F989AF7FBFC94C304E61DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F989AF7FBFC94C304E61DCF52@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0066.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::19) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260702144020.1296835-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY0PR0101MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: 77be48ff-700a-4a84-2151-08ded847e3bc
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ71q/lZ+PYm7dIVku0MuFLgpGk75/PL25t7lXxgzLXcDtEOM/1TCYjjmSNKkZo9qpz4GfxtCEvJ0uLjHeLbmFlW/V35M58OFLFTIhZvszEjFdlHvZmBDwxgcq4TTKDJnnFFgAtuRbXeGoftVW9BW3HGjY+LB8dOHVDnxvnrizyDOlAXwpkKxW4SfFDcbjsIjQRTfyLO39ewsorFYmfHlVXxpPo9PBNGMOMMDh8QhaSq2jwZT8mzfr8XxzQkFVPaQs2M3INxQEZ+I2nG1wxhFTHzcCyJErZwKwjbrJcryPiG69K6GVe61MXUR9ahrJZgpFN/mqkRcmB5NTyFiQZnIIs2JBHqz6dvSy8yYCVfi/+mCTveGApevybg0bEdBRO0KVPSRTsGUIHkPaR2KmUvDGvrw4QPFx4apai0+08NGbqQITl1hgWMAbPYk5W3B2lE3MP/GkPpPwpYJfnZT3n8dRR76EpCwjW1U6PYmlWH1pGShJE+c9aJ9iyMOBmfdzHcFlzg2nD8OjasmDuWZ0rfaFh8j1iPi8lJZ42JiGExTSnZvEyTQ664Dob12N7b8UqPbC14KmwCdWSrCMBsKWRdBDL18TGG/8W91LlSVwU07OVqYK3xw/XjTnprDjo6sxsBSL0kTfaTX4XAJJ1z44+ED4wS423iHrBy4n7Fs8psEzVBb5+iXtNC8wmJkg3fY9ipD+sWJfFhF1v6zw/tkDeDFGRb1z18BRNjtB6oW+6F4muAxQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|55001999006|45011099003|15080799012|25010399006|41001999006|7042599007|37011999003|23021999003|5072599009|51005399006|19110799012|8060799015|12121999013|12091999003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?psHTwYsB375g9KFAnano3BcqOV6hnF+uz+kTHvpPuTIN3k8hUf1sjVBqFYnj?=
 =?us-ascii?Q?xgX3iq6IjS0AN5DnO5JVTvKe/jg0IX6Otz+dmgrZcDBZvsRIkyz6qbvMuGUu?=
 =?us-ascii?Q?JcZgYM9zd0aFMjPi3I6ZMSGaVB7sY2Y9CeAhDJ2mBpQxOKookeyOwVbklxkg?=
 =?us-ascii?Q?5U2vaxdVmRLYIyhLGxGh1QxXMHw2ipQ5xOEXzAlTFgm8F3hIfcpIwTERcOPS?=
 =?us-ascii?Q?+CqzlMHmjdSPkkxzfIp+i7VTfK33fDDprednc0gjOSDWjWWZtT9/gymwr9fg?=
 =?us-ascii?Q?xFp/ECv11tE9/iQJcjqedQphfWrkNBiUsSokDFEXnMzetOvngKxvVq/TBNkw?=
 =?us-ascii?Q?XvSO1E34JE9hXXc8oki2PZHBHBojKWXJT2OyrIZQsWMkML7d5slP1JnbwExR?=
 =?us-ascii?Q?ScHpIBcEyNPFikXdvieqxHQ+IL+dgNe4nk7gwZeIjL608N3vyPXQZ6HKNrkY?=
 =?us-ascii?Q?P3Z/TEknKQUK/OA0eVuHM0CxkQ4eF5DAT9A8ip52Yy2iGyuRy+fCy6rXiVbI?=
 =?us-ascii?Q?w/i4JNZ5UMd/f2t/Z6+/xrjH60g2J4qZGCJUonxosknHEWiNt+cs8/arU2Rq?=
 =?us-ascii?Q?fzYgFU3xzrC/0ZyDwvS2oxj9XeVHAUkEL9k+Qtw8RXjljHgGTbwFsyNBwAz6?=
 =?us-ascii?Q?wZjElXezJWv0oszpc+n6yZ0nHywapt51VvStef6zTeF0CV0fHaLUJ1rPtBc4?=
 =?us-ascii?Q?/yAmYPQeOpazvGYEWBzsS8aSBrXGmi+pWCAgp4idEcJ4zgudttLB9IFwJ83a?=
 =?us-ascii?Q?xswUZHlRfTWhEu0ISSYUPgPR29WxgGMdI4DK+zEbZyWcEhsZNmlRAxWuyeuW?=
 =?us-ascii?Q?YADTtJt473v8M5e/jYlUV+PCdYaj2jRuWagcmOhShZ/tv983XpzQGPb4GDyH?=
 =?us-ascii?Q?8uz3S9oTMho7flUxKlSpYITHL/dIhaI7Csgnz2NGoN/bUvT9Wheul/Iyvd6S?=
 =?us-ascii?Q?dEuUDxRPRosgVLrZG5TXPSzbPB1w0JV3MpTEGLJWlfZ1clzmxC2x+q91dhjO?=
 =?us-ascii?Q?Med5Nl7tzS9Tuhu6YTXF9s5ssf+FLl1TkW0A7gut0tGdI931jTEjCky5A70W?=
 =?us-ascii?Q?rUio7JQYQwc7qjHzmi9Bm+wvJlGcINaLlc3ISg1kvhO7mEe4zYwcS1YPTZyN?=
 =?us-ascii?Q?DZZjoydfdiO17Nif8e+mmOYHJPxIdE3B8A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FdA+brik9NBv4cIK+4htIC7SHeETR2oIjvUFLExpS9AUv9N0PqAGj5RD80So?=
 =?us-ascii?Q?Xc8A44nTl30d/I/oMBMHgNeaZINEJH9othwLeQ7FLxqAHRA9yvhNCY6t7gdV?=
 =?us-ascii?Q?llZ+IQQkA6kaHxHWpGVR5llXra4BXilQ7kw5lm52OzvBoaUeJNDHlf4qeCt5?=
 =?us-ascii?Q?MvSwVnfTxD39oGV44GVCV7xQ843fSHMMLrhIB3JPtlIdKaA6jdEsd4/7LGZA?=
 =?us-ascii?Q?2eRI6XP/TQYCi+m/0J7U/TYTEy4oho+kK/25azE5IZhAKeORZqzt0DNqL94p?=
 =?us-ascii?Q?BzubBq+RxVciOlzOQmxKTEJAa7T6BSMjx10pnfbrbrwL8nisiKSwNTln/5Bq?=
 =?us-ascii?Q?NeKVc6k8M/ZErqM/VnvXaPy5r4JdKuTtdY65WWQaMW4iVRnHggz0fSzYACAW?=
 =?us-ascii?Q?LME28T7NA3kfPyhRDIoAEeH2vDArxfmUuhsnMLw264na9KR33Hht7fTV47Qf?=
 =?us-ascii?Q?YuPdpU4KgnnTOhVVUXfWlpfRvnFTNevW3AcyC3Ni8hBdu3JZLVq3fCrrt629?=
 =?us-ascii?Q?ZUirR6DnPCZ+AVcRq+OMp8t/Nkmpyan9L/AS2VInSvgsF1yqEHP9ZNNv/x7F?=
 =?us-ascii?Q?GuQAWILIoDopQCxivUI2+gQCesDrWqMsmi+hbQoNYBKasNfY3ncQ9AtZCdzD?=
 =?us-ascii?Q?ad+2Xn18g1QxsfeAcukaBysRNuQxx2szUIdZ3bZZWIlI4+Pv3aYsznGm9zRe?=
 =?us-ascii?Q?h3mx2jaAMg07ju+QiRs69mkNqySHYHxHjho4nkBPTiMYguMu8ElxrLg+UbR4?=
 =?us-ascii?Q?4n/jxEtfLCIF0Nq85aKcyIwyseZMRK8PCq627BQxLZYFefAyhoLQWsH6QYTH?=
 =?us-ascii?Q?k6fLix0H55p6Il+cIsnwTV1dGjtrfy5J4sF0redRD2tUPB398ld8RXswTUSK?=
 =?us-ascii?Q?ngp2LmZM+wiL4QwHfRmTHNFQoG6hP/stCUaPxfmMvX4eJFKTAt5FFq3Cnhdx?=
 =?us-ascii?Q?/OfMMkkQlw9cE3FvlwsEmElhMalCaO3ni0qkgmsbw9wHwBFRSv864mmt7qfq?=
 =?us-ascii?Q?wDMbH5GOf2zGrJyCJFPhlDaOe9ZKFELg9L0zg3XeC1Cr75dBkIIU15mFFb+1?=
 =?us-ascii?Q?ApsN/lE/lnxRQ2CPbB4faloVbVnehXvGIQ2RY+o0mRQuxrikup8L6z7qEZwa?=
 =?us-ascii?Q?Px6MZOYypixlo6hoTWjKGF8eLtCwoZi9I23AwuuZHfjW5k/rRsVz8to0WpOW?=
 =?us-ascii?Q?zrT3c8/rniPyxDo2DaxJyRyfGAGhEVdbWU/1JmZDVQlbEug1K7vBbPDD49/T?=
 =?us-ascii?Q?lZH9CiyoeiTRtCUUtDMs2R9nq7PPG5d+DbhZ0mbx4X3MaJE58QaAUdt9G17G?=
 =?us-ascii?Q?Ge85ecYmEAjQqyq3mOo3Bt/b1LPv3V8O5pjyDVCB4u4sY8xFx8hRuqMdi1P0?=
 =?us-ascii?Q?AVfQU5NEO2YinLgD1Lxn+CQl+R/g?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 77be48ff-700a-4a84-2151-08ded847e3bc
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:40:41.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4786

The check_ioapic_information() function is designed to prevent boot hangs
by ensuring the Southbridge (SB) IOAPIC is properly mapped in the IVRS
table before enabling Interrupt Remapping.

Currently, this check passes if *any* enumerated IOAPIC matches the
expected SB IOAPIC device ID. If a buggy BIOS incorrectly assigns the
SB IOAPIC's device ID to a secondary IOAPIC in the IVRS, while scrambling
the true SB IOAPIC's mapping, the check hits a false positive and
succeeds.

This erroneously enables Interrupt Remapping. Consequently, the IOMMU
blocks unmapped interrupts from the actual SB IOAPIC, dropping the system
timer and leading to a silent kernel boot hang.

Tighten the validation to verify the device ID specifically against the SB
IOAPIC by matching their APIC IDs first. This prevents the validation
check from being bypassed via device ID aliasing.

Fixes: c2ff5cf5294b ("iommu/amd: Work around wrong IOAPIC device-id in IVRS table")
Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Tested-by: Yongwei Xu <xuyongwei@open-hieco.net>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f983b1961847..9e07f7c4196f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3091,11 +3091,25 @@ static void __init free_iommu_resources(void)
 /* SB IOAPIC for Hygon family 18h model 4h is on the device 0xb */
 #define IOAPIC_SB_DEVID_FAM18H_M4H	((0x00 << 8) | PCI_DEVFN(0xb, 0))
 
+/*
+ * The Southbridge IOAPIC is assigned a GSI Base of 0 (handling interrupts
+ * 0 through 23).
+ */
+static int __init get_sb_ioapic_id(void)
+{
+	int idx = mp_find_ioapic(0);
+
+	if (idx < 0)
+		return -ENODEV;
+
+	return mpc_ioapic_id(idx);
+}
+
 static bool __init check_ioapic_information(void)
 {
 	const char *fw_bug = FW_BUG;
 	bool ret, has_sb_ioapic;
-	int idx;
+	int idx, sb_apicid;
 
 	has_sb_ioapic = false;
 	ret           = true;
@@ -3108,6 +3122,16 @@ static bool __init check_ioapic_information(void)
 	if (cmdline_maps)
 		fw_bug = "";
 
+	sb_apicid = get_sb_ioapic_id();
+	if (sb_apicid < 0) {
+		/*
+		 * Lack of SB IOAPIC registration is not a firmware bug,
+		 * e.g. kernel booted with noapic or noacpi.
+		 */
+		fw_bug = "";
+		goto out;
+	}
+
 	for (idx = 0; idx < nr_ioapics; idx++) {
 		int devid, id = mpc_ioapic_id(idx);
 
@@ -3116,16 +3140,16 @@ static bool __init check_ioapic_information(void)
 			pr_err("%s: IOAPIC[%d] not in IVRS table\n",
 				fw_bug, id);
 			ret = false;
-		} else if (devid == IOAPIC_SB_DEVID ||
+		} else if (id == sb_apicid && (devid == IOAPIC_SB_DEVID ||
 			   (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
 			    boot_cpu_data.x86 == 0x18 &&
 			    boot_cpu_data.x86_model >= 0x4 &&
 			    boot_cpu_data.x86_model <= 0xf &&
-			    devid == IOAPIC_SB_DEVID_FAM18H_M4H)) {
+			    devid == IOAPIC_SB_DEVID_FAM18H_M4H))) {
 			has_sb_ioapic = true;
 		}
 	}
-
+out:
 	if (!has_sb_ioapic) {
 		/*
 		 * We expect the SB IOAPIC to be listed in the IVRS
-- 
2.51.0

