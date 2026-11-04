Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.105
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809390;
	b=neSbr3OdvM91ijEJLmP8J30+RFsDhmF1DVPvRjUsBMEcZEtpiPtw+LbowYq5y6N74e/o
	 SuwWQIHn6ohKKJ9NNJcAHFBBy2q2YJRmNFGKHhIkuEP+gBuAqMUd2wflkBXILsgHtz9IM
	 3VAPrmlVTwMRuuM6WyrGvJh5jk2xbJ9CfDqaqE2jMb4F7LfpaQJ/KRL3g/lWLxDooVW9w
	 +h5lhzzw9Xb8Y+MEkZiuY7P7dCetLfxcIayDwg5/V8EmEZ2aaIO5l5L+SqYMDGrJ4XZNS
	 95ltXxaL5EukZN96/45kREEaH+VaUhSqxRcTOqw02z9ilWvEr9Z9giTJF4nRzq9H3pg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809390;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=39Mbjok2rPlXhRzIwTXY/VJmILyDqdEJizs/HLwXXVA=;
	b=2D/AFfCwVzuf35EjL5YFAVyJ2aMhULiiMdLllzIo0w9egQtCpULs7LF2bdiRrtAFLUtm
	 IMgvVcnS/M+F8Fjd7sBf2R0Ky8Uagf6A0Yv21Hi9ELYO49ij8phOMtd+WIVodrm7sBMTF
	 8qHsCWwIF7NTnb3Xgv8hrWcoXzh2dITXUHMV8Jnp5uXhjj+H3g7kQGtlT5NVNNdZpl0Xf
	 PUJVYtdp+BS6BETVeJNNDOnE0eSqv/xXL9Boj+aVUwB9+28qiJmbEtFo+852SGydQbwsO
	 cOxSNVVLZLwOd31UObAoVhAV+KJWr0KjEGAUQNL84lrq+asY/RqJkm3VzLujO1nQMIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=hMh5Or26;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.105
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021105.outbound.protection.outlook.com [40.107.74.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30876606A332
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 16:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30876606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=hMh5Or26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLDqNo2gkSojktohdKeBTajGthffF8ojbay3Ka3a9wL2qZLfA3c5MgmyFd7+I22wL+AjbogggwxY3M7r6DUyEn8uhu1g7Se7kS7eIY081MnZjeGB9kG77qvJvBEafmxfH+DfeUz+bgKeVjwqzKV5lacrZsXmFQCIqS7Bc7pTAeGql349WxTdFrhAok7TFcHso/bD2odTI1jcNx92QU5Af/Ni8oxW8NvFhUR3bnkuLK0hIwDCPta/bB+extgwX1ZKlVs2yIZ5skRobUn6WJSAfpxP7H/7ZjYjKIJWfJA/1nsFU1zUUWAyEfqVM0i+DllMj3sH9sjlqJQ82Hn/OaD7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39Mbjok2rPlXhRzIwTXY/VJmILyDqdEJizs/HLwXXVA=;
 b=Wx+TwobqOCnK8rRk7dD2iY4oSom1T8QbLeIMlWtdfMbCYZQHMsGnMw3BBzASrUTKnscdJlmgASr1hi+TykMmUgVrD6Y6mSVQtdGD+hzOfc06Kj6cmFyTPebRneO/bUarXaNF9FQhlHT/6zySrxKzsMP1oyJq1P+C8DVB7i5bv4Gd8iDS5okPGJ3YBddBiyyEhMewKxljlty7mxFVRMQwhE595zuD+bPr5ldyI0ZPQ3xWVQTcAVYQwbZ5gn4U3GYIiK64FsUsX6rRrqDxiQVKX4GjcjNI5ZYQnqQeHwwjBdutdoWIdco+okResAFhXFFjfiJrfx1CoLPrRdLy9niH7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39Mbjok2rPlXhRzIwTXY/VJmILyDqdEJizs/HLwXXVA=;
 b=hMh5Or26J+kK4W2WtVAlO1x2U+hG0kJ7qXNKODk0OSw80AuwwpcxuXhGGQjwktiUK7af8zJQ2yIUN5cp80AkM+Laln27HNKYJGFCKrcdL2iDV/V5C/SjWzrkwVRt1O7L0vTHv7LIJRg80utGa1iVSiMj4uSnT082lezfXABJQ5k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSZP286MB1462.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 16:22:59 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 16:22:59 +0000
From: Koichiro Den <den@valinux.co.jp>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Magnus Damm <damm+renesas@opensource.se>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Marek Vasut <marek.vasut@mailbox.org>,
	iommu@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iommu/ipmmu-vmsa: Move device initialization to probe_device()
Date: Thu,  5 Nov 2026 01:22:50 +0900
Message-ID: <20261104162251.1749998-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104162251.1749998-1-den@valinux.co.jp>
References: <20261104162251.1749998-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0243.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSZP286MB1462:EE_
X-MS-Office365-Filtering-Correlation-Id: 97574062-c48b-40bc-7cb9-08df3a8fe45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|10070799003|366016|1800799024|261009223027099003|261021121427099003|56012099006|261021123027099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pVF7//Sig5EMHfBZOdqwN3sDD/4u3TXvEDi0om/I5yxjmgwCEKfPfE0kbPnvkgkIhKztUUVPW2i2SXNksXNFVBSfpDHUVJKoe5ju2HhCGSoQAu8wwYGnzvAmGKJQLN6bf2LkaqOFwTOixt0xPeO2NQ31AT7rcu3Ftiv/dnr5QiSj0ucWTnIpiqWeEY6ngofE2reNwxxplgQFcft2yQJitXmUVSxSPdSBCjlBatjuKEqAWK06orfApqSSUJ5N/OAmpb0EcEHUul63ccwFt3Nn1h3rVsXo1YOtfUybAIMpDNGUjTrFxSd3Gb1nB3ufMuBw/Mnx3Y1ZzHZQ01VOcK7XTnppZtHKH+yze5D1aX/nWxwx2tCs7/AX5d1kr9cjKIGGAoZRkpw5E/FEu/jZWXxT7YCQIs+iDWlSOmVBrtxnipXD9vInG9nT4SZcbYKyRG6Iz3CxGGvuUvq1w4W3XLZXvINBj9iDSLRD+OSjOCQCFYtAIPrDqnt/Y3CvwWPJgOMo/L0zgOZTz7ee03lbxm00h+2llPowSx28V29O1HlkWnKWaq3JaAXj5Pmu4SHyWLMoIIuv+tjPNYsAl10HTFeffyaW4K5/+f2Ua9kccCEaj1r/RgOnx7rX87fAzlcJZIB4YD15G4jDzEdPk8kmztxAcwR8IQRfOIFAdzG/1Lq2YYQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(366016)(1800799024)(261009223027099003)(261021121427099003)(56012099006)(261021123027099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6OaEFs7zjLuLUxqlsAlk3SObjAoQ1xjY1G/yVUnJ1JyVWRY7YwnK9ZWPAWm5?=
 =?us-ascii?Q?aIHJeRM6roR07BLLPo6E8UBy9tpDcieHRMbsnkOiiBDZF8hKjX2nfU0BmjeV?=
 =?us-ascii?Q?6wRcR972rq1yWOBFmsRJObenTxckE2etaIOy6Kk6BEZj22uPETMyzHmP/j6X?=
 =?us-ascii?Q?XGXPE3TTseXRvoIR8ez6BPzPCapgj2+TW1N96o8cm+6gvfrzfIRw568NC5gg?=
 =?us-ascii?Q?2UR/qLmz5biMQhxEqHP7E38HaZNSxP0QpK42oC9vK9oDOTbtuzqzqELrPvW/?=
 =?us-ascii?Q?hTAUp0rYw5/FsYlQ+J7YTLzNvpBpx+mkXHmZRnTecgQDhP9yKzK32J/OEHIg?=
 =?us-ascii?Q?qvEGiEH06j1e/sL2M7u/AHUW6h3Sou5WEqowExuw4zJNMH6yZe1NEFBMSGU4?=
 =?us-ascii?Q?HDVb9sNZs6I+ImBXiZsX28+dBd+kxJxM+F94LOb8/SU840MVNpPqflrBEcTF?=
 =?us-ascii?Q?4ZzYJIzHmI3wOdVP3Iyb5fnLhUL8gnFmiENbjI2KsdkxEi3/NeiM5MpgLEwb?=
 =?us-ascii?Q?8Ha+aEdwgDRqApUPgAlpIGSMWbgNfBpbhO/ckn+AhfogAMnRcZ5DNDANdz7w?=
 =?us-ascii?Q?V4uLx+cDu522IGQYQNcPs4jk9E22aqkt8zuoHJJcPqwM3MSqrzdp1CYIHLku?=
 =?us-ascii?Q?YVPJ/Lk/cEA3WNaXqHhsndEaBp0QTpFESKklG7cpGFDqi6/d0POkojCSRZfc?=
 =?us-ascii?Q?FZQRoue6q3txx2JfXjfo86hpQa73xH0k1mK9bjBs5xXGVrIDY7GfXzmoHvI7?=
 =?us-ascii?Q?fQ2uF1v3KVMOd/QkQf44fLNymLltLKYjZ4b7TTFiv/9+R/wjBIqjL/N9PLNv?=
 =?us-ascii?Q?07rJCW4QcH+pTzc5/Ebk5ggSS5T5Y2QZ2Z3gy1D6WoUzvdoq/ywrU5Q8NLEb?=
 =?us-ascii?Q?L+Ibt5y9ohUcoFzKGO7/5aHygwaQy2dyu1d4Slfok+rFYn9AH+PqaWeL9/fC?=
 =?us-ascii?Q?x6edk68yLKVsNozMch+3jPLo9yGbChjJv/3eAa0ozWsXX++Wy6vFoGoSq+rd?=
 =?us-ascii?Q?ciynNrYQrYt/fgdWT/Lznqfej6Ky9wjroWiZmIO3A4zPggHKVngwlmOWEr+Q?=
 =?us-ascii?Q?evFqp7qPLt4OMYmRYRfJuk7Vvil+YvTjuKO8rA2JgMpK+1d+IODwZpdSMCE0?=
 =?us-ascii?Q?5cqC5Mg4cQ5gFQjMS7aV2LwbxC8Nlir0rv3ykkA6CQf9DNv3kFILAKzVQC0p?=
 =?us-ascii?Q?nJMPpur/wJMa7xOQhaLUMM0njK+ZoJlKnujB6gIMrgtxFzJybKEjsz7Pmi8M?=
 =?us-ascii?Q?ecVWSkpWDWE3wy2PTm6VrWgHh+4l4FemCLPVTagzwzbxNICltVj5t2hzu2nw?=
 =?us-ascii?Q?3c5aXR0Fadra84FiNJweq/NF9w16AXXnhf1csRr0u3TYPj6H9bGuxHVjccWM?=
 =?us-ascii?Q?d/L4h9QPzdVwwO6i9f8wcLjbTC+yk7YPnuvN1igT82pLxuXuIz1eiaBpF+9e?=
 =?us-ascii?Q?spjlBmeHEAmswJMJpmrTPHUWeUNMQYgPNAaUJqH08yQxXVZ5u6JHv0KuL91l?=
 =?us-ascii?Q?3xJ4UAD1qlRjb55FpvmWGNYxXGXzzirqX8KfkTeA2+XZedTGu5BR/rbZjX8D?=
 =?us-ascii?Q?KkJVTdg9X9Vb+oHzAt//OM5386I8GpgLszAZ2jKI8UBeLYd12q3o56sIP7fQ?=
 =?us-ascii?Q?w/4bzXvKVFENZyDv2Z/W6d89+6VVG04iq/azTuylr2bdc/omjXOuUrzKVzIX?=
 =?us-ascii?Q?KjVr4Rk4zqcr5CHhNn3fqi1fCvrGuxA23TdGAE9Q7RmxWsEubh3aigYH8zyB?=
 =?us-ascii?Q?nNJbQ9vjgLLtUx5rL7JeNzmX30W5eE+CYnKO338KKwLefHHj1iEz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 97574062-c48b-40bc-7cb9-08df3a8fe45a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:22:59.6363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4mAZrezNxqe5V7rSywUSaMsG2FYsW4iD68RDCl9Ekv0D/Ad5nQ1WgQo6+XWW18vyPTtx0TK5DRkoj0LuLCeWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1462

Move the IPMMU instance lookup and private-data setup to
ipmmu_probe_device(), using fwspec->iommu_fwnode. This prepares for
per-device attachment state managed by ipmmu_probe_device() and
ipmmu_release_device().

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/iommu/ipmmu-vmsa.c | 47 +++++++++++++-------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 99586c68ef35..cea9348ac10d 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -709,22 +709,6 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 	return domain->iop->iova_to_phys(domain->iop, iova);
 }
 
-static int ipmmu_init_platform_device(struct device *dev,
-				      const struct of_phandle_args *args)
-{
-	struct platform_device *ipmmu_pdev;
-
-	ipmmu_pdev = of_find_device_by_node(args->np);
-	if (!ipmmu_pdev)
-		return -ENODEV;
-
-	dev_iommu_priv_set(dev, platform_get_drvdata(ipmmu_pdev));
-
-	put_device(&ipmmu_pdev->dev);
-
-	return 0;
-}
-
 static const struct soc_device_attribute soc_needs_opt_in[] = {
 	{ .family = "R-Car Gen3", },
 	{ .family = "R-Car Gen4", },
@@ -778,20 +762,10 @@ static bool ipmmu_device_is_allowed(struct device *dev)
 static int ipmmu_of_xlate(struct device *dev,
 			  const struct of_phandle_args *spec)
 {
-	int ret;
-
 	if (!ipmmu_device_is_allowed(dev))
 		return -ENODEV;
 
-	ret = iommu_fwspec_add_ids(dev, spec->args, 1);
-	if (ret)
-		return ret;
-
-	/* Initialize once - xlate() will call multiple times */
-	if (to_ipmmu(dev))
-		return 0;
-
-	return ipmmu_init_platform_device(dev, spec);
+	return iommu_fwspec_add_ids(dev, spec->args, 1);
 }
 
 static int ipmmu_init_arm_mapping(struct device *dev)
@@ -839,14 +813,25 @@ static int ipmmu_init_arm_mapping(struct device *dev)
 
 static struct iommu_device *ipmmu_probe_device(struct device *dev)
 {
-	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct platform_device *ipmmu_pdev;
+	struct ipmmu_vmsa_device *mmu;
+
+	if (!fwspec)
+		return ERR_PTR(-ENODEV);
+
+	ipmmu_pdev = of_find_device_by_node(to_of_node(fwspec->iommu_fwnode));
+	if (!ipmmu_pdev)
+		return ERR_PTR(-ENODEV);
+
+	mmu = platform_get_drvdata(ipmmu_pdev);
+	put_device(&ipmmu_pdev->dev);
 
-	/*
-	 * Only let through devices that have been verified in xlate()
-	 */
 	if (!mmu)
 		return ERR_PTR(-ENODEV);
 
+	dev_iommu_priv_set(dev, mmu);
+
 	return &mmu->iommu;
 }
 
-- 
2.54.0

