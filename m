Received: from SVZP279CU002.outbound.protection.outlook.com (mail-norwaywestazon11020130.outbound.protection.outlook.com [52.101.180.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442933DD52E
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.180.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962626; cv=fail; b=ULuXW2C2gklfLf5Jrtwp0KpHKmgAZyLbQ+nlLcsqy9U5GolKYWKUFTXnTcKJ8qi/h9BVkS4kIv4tNF0OBUDOEJBY4LfyaTlWjADJmuCUpkSLb0BnP8gGpmzZPubTsusegD2PQ0vGs9PnDPrZTDlpxdmxxVpxM3cu7vCCQb336ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962626; c=relaxed/simple;
	bh=l84oho25Yuvb8ExlfAlKAzzGvq7QRIzJkKe9pG/wVbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m4BBrQTvPnweAuRYpRQmB0yT6v49NH+uQxevdJCJDjEDEbfALZugo98FyMRm2hrSk+Pui26ECSuz0q6xOFD2dpo22bhsDx691VD4iB1/hzMNai/g02aeW7Us2q7QKaNE/ycL2Y54YaHwzDCa0NAjV9WqKYZSWWEqNe0AHLhl1NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=iHGqWeIq; arc=fail smtp.client-ip=52.101.180.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="iHGqWeIq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNme58gCN8kHhE1TEcopQ6kiAVjL/6TrskUYNjcsTM5zv89UmLvv5K3Hcha96Jhy8CcxnF/0F68c30FGfofvEjiUQsssY77N8PzdeaT+W/KXZDZJ1Yu7uUnpt0CsPNIZVy+zRlp5Oqqa1cFcuiLoevNWoxggPSlqYdWlRSH4qJLOSZZQtXP+/KdzClrDCtXGlQe4a0/savqqO+Nc45IKXJOh2DILEh1OMwJFmKsiDMwZE6O/K2Ilxx1xKk9Qh0cdDxQmpCUJY/0XnakSabiY/gM6LHe7tPcmgqLKOwLFHf86Sh0Adq+JJVt/s8Pd0dvxCsklbaSf8zTflMgbOHYjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWtW9Nip4j48bB5Y5D6KyCjLpuacPwrRqrlU/8FBqPk=;
 b=xGem+0YHjxn6aPHIvgoGULUe/EndWHY2HCjXh9qUpNqfBpJAQ0XdQ9XfTV+QJvW4wT8Tp9FvOkoXJ1CvStdGz2LhaFM63ylnQ67QzsTDr7yVLLJwr1VxNx+KmKtMUjhKVxwx++yhX9IZkwux8k8kpd5/+db2AzSUfv/It6wZ/NMpJv8yEdcF10LnqTIfWjxg1i+Gz3lyisJ97xr7c3hr4lk+nB3Xu1F/kMxm44I8TQbHIhz3ewJCMGf33jlVB+g1RPczIt3wFCTFXxxW20iXXZ+NnetSHXclRQLC54cckv8AQ7c762EKFOgJV7+At0sd9VLfWNkLxllTc1E43fxacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWtW9Nip4j48bB5Y5D6KyCjLpuacPwrRqrlU/8FBqPk=;
 b=iHGqWeIqG1fhU6loyBMVGELcPCcX0dKA7W+SKnilOVfgC69t2GsIvhbHnyN591CMMjAdfH6rpxHalk6WMdIV2mDTil51wJRSa6RKz2esXyo1hgfDjXkNWCgka+tX4CCIfcmU0LYf1XoXHnl9mX5kIFXh3OPgTywvlWf8FIKSaZn/NJaSbJPd5uJqVY1fEW6E6Z1ZmWrhnPz/Fd1Z0uh5LanlvATuP5BcmYjHaE7PeC+lYoNnu4Swhv2jdVxbtjNFQytoRTrjSYqLRUHIxQGK/WAxq52F4OxZUr20blIkgEWmgwQIUaUjwsuyJvsUBlY6z13c3QZE00mIxQacSsAd9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 SV0P279MB0026.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.28; Tue, 31 Mar 2026 13:10:20 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9745.028; Tue, 31 Mar 2026
 13:10:20 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com
Cc: dhsrivas@amd.com,
	iommu@lists.linux.dev,
	jonas@dolphinics.com,
	joro@8bytes.org,
	larsk@dolphinics.com,
	linux-kernel@vger.kernel.org,
	magnus@dolphinics.com,
	suravee.suthikulpanit@amd.com,
	torel@simula.no
Subject: Re: [PATCH v3 1/3] iommu/amd: Use raw spinlock for interrupt remapping tables
Date: Tue, 31 Mar 2026 15:10:05 +0200
Message-ID: <20260331131007.57657-1-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <152a5b57-4956-4f49-85f8-d32ef5f44beb@amd.com>
References: <152a5b57-4956-4f49-85f8-d32ef5f44beb@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0040.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:32::9) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|SV0P279MB0026:EE_
X-MS-Office365-Filtering-Correlation-Id: a35755cc-1d95-4b3d-98f6-08de8f26dc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	c4sP3NfKVvbUwc+yhU42Fgn0uvcvegBaYEaXrCgVssL75dYuhpF//PrLgoAxeF/bcv8FMK6qE3k6v94mrZz8avYYcYOyeaYzSP6ACDAWTxDPu1A1BozbrSogFhtcKO7HSoPfo3sdGJShJPuuARq9OAF5gOZdSR+rzSWzvdcTXbxWMBGsO760bmcukp0FDs9HBin+9JRdFXRAsaLD/4H2A3nYyWF8WKwbbS9te6TKE6M1YbtpvEHRhEs88OM8xfA8/CkytP55qeyDCWOzzvOKrR/Glb8arEtlOvkZ5HSuJ7vaMN3oYJ9NL+oIVOJK6C9Qpz2xm0gZfBdvZO5ep2kKL9wlrdaKlDBvzGgBf7YGxyCyHJym3EbkDW1K0+C5pxtox9fsCcgowUeSSQY0JDYhmClraSx3TaaQk0YYWg3tUZjEQmIlHvOWlePyHo/Hn+13ERIyFcxA1R6RpV8lQvryBpRENoPxKgKwervzJ61HAiyk1F0/Yp6XRubkwdGBs72nsYmVN4/dblCnnfq1mSLox+jOQugaCIsiYArB/1233IqSwzfHLpOaHL0vMZjqGd0QLuf9WHsvlx4Xcp47wC6SRe5BmYSm/mL+qpxWprUZ9Cp7MH2pyHUfVRAGfNfrnyxPmDfMhVFdXmWJb+ibLBBTJcNT89g2Ga+A1Pws6lF3MYb7wE6VVPIDM04oEWiCM1Zd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EzRMg3zFD8Ha8di406xo4bMqKtkufDBrUhDYapsX9VEkbObQx5PyEnhGLykV?=
 =?us-ascii?Q?9xCve7L4lFaSns8QP/4Xkgqa1wuFnNXJCTKM/2mhfrrEwOlbtdhWisEYYFSi?=
 =?us-ascii?Q?hXbQiHiv2LcxGrvxVt3CbamfkJm0j+J7Gkbf0dsBRAu61C68kTM3Z0vTpfwl?=
 =?us-ascii?Q?1eTcmxzCFtR1hMDBlOsYdKidOzgubJV4+ag6oMS0huMo3qQvKX649s9TCwhD?=
 =?us-ascii?Q?PYybkwqyKCPMaKXBY7DDW7aN7Yk64oVxwiMzZd6NjkQUqNjZiD0boH4LwGYq?=
 =?us-ascii?Q?CsfSCdRDaBam9fttmopKaa4w+NStx90So3Qe1Xf1ex2LxRllKkYFes5rjlHc?=
 =?us-ascii?Q?H25WBdveBChTkQkTW41mGvsQa8+C5Rg5KOju4epnEd4WH1tW/NZ8c4hlI2pM?=
 =?us-ascii?Q?E4kh2OJUBO9nNon4MBgq439QFKMt6GbE99RHbo9A8gWPkWn8D8oYbKH94E01?=
 =?us-ascii?Q?cLpMyaJG6vz/zi8YC/Z4vpd/VPfDe/CMpiH1Jrl/vAQDbcxHVDqxnXE+F1o3?=
 =?us-ascii?Q?BXZAJNw/Ar3H+Ptazz97arukp9C2hokSlKDBk9JJd2GiXouseodmFl9FcyGu?=
 =?us-ascii?Q?0nu+GuUGRnz12MJ5wTuwYjxXxocgiRCaqaba6uhTv2uxLZGGIXtl0E24YZSY?=
 =?us-ascii?Q?4AKcu15mPvpt9m86ks0lXSH7/sdyuy5840baYd4OQViLqiNrvOhJMZvmwmbd?=
 =?us-ascii?Q?EYVrQQHpFJ3v8dLu9QGtXkIezLG1JbbZa1zIjsMukJsmqtiZ3Mt16+YUVoAh?=
 =?us-ascii?Q?Nxq+dLfDtCljnYiI8i/UrMPbmr0lPTn0qKxND/CC0u6iuKXqPsBJ2Y5DaQ0x?=
 =?us-ascii?Q?lX+uLLUtMs5rBE9o6ID/5h6qsEQ168kJHDgVcemimzXba2CcPlRXX9YrV5Wx?=
 =?us-ascii?Q?aOMSPx56fcK5oiTAd2uGs4rQrY8xNe3EXL7fUKW2s+GYlX2GUogleF9gWLcO?=
 =?us-ascii?Q?eZAUsKE2+5rsDkBNdxa2R0O6cna2yB1laAYY+vMIGeCS4WXcG47xIfbgZX8m?=
 =?us-ascii?Q?LL4ihNPHeinePNiVProZGake/vFnNXpRAbLxACJYjyQ67RzNNtsnMYQIPlCl?=
 =?us-ascii?Q?n/i2S90qOGTCfstM72DGN+3pJD22pXcqlchLJLN5BM3uAP48vMlwt5T19vsD?=
 =?us-ascii?Q?pAgxZghOq9OIp1aRJCO+7hJifMme/g8VyUMtMVa5X7XB6jR+ITrTNYUXP+X5?=
 =?us-ascii?Q?HRqiJcCqIOpO5bUCdqtB6IqJT0nJySMuA/WQLiuz1jUhYUSHvYXbAVVWzMa9?=
 =?us-ascii?Q?GAzyy0KHwdZynUBCGKsrJtyJE+6ovd9gpot5fkovOMuE22vi3+8nn3FxwHEy?=
 =?us-ascii?Q?u3DOw4jCpP+tgE9Ckaokg+jg2ipoVl0dXKqzrA/mfG3OmMFXs6GoTfsEICWY?=
 =?us-ascii?Q?LfaEJYLTww4wBV0RlS2j2H/fMMWCO1Y10hztW4kjzaWSwYvy1ifDwdwK0tln?=
 =?us-ascii?Q?bKTUooPwQq039Q74cywHhM3ZqwsKGV6Pdby7sa3HH3L2Xn2av/VfpedHLkaZ?=
 =?us-ascii?Q?7nh4ZEnq1rWPs3pjV8bJm10Z55osnoWamVVBpxU8SJxdLOUlMDppynPH8PFq?=
 =?us-ascii?Q?ZQ57XyulPLdNW6WycVgHC6wiyyvcxX1NeFTi5nDdH1rM2uB1PUTLYKXAezfx?=
 =?us-ascii?Q?EHQiCsWdmb1QJvcJF3bRLORCmNsjrBT7ayIX11XKHZB0le5ZNSlkF+dI2/We?=
 =?us-ascii?Q?4oebdD6R1ogboDZorF1ls8iX7626YieuM/mAH3oIl1SKAL21iEqKi9jhxEYR?=
 =?us-ascii?Q?dO3CncXwzw=3D=3D?=
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35755cc-1d95-4b3d-98f6-08de8f26dc37
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:10:20.0445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymhM3HDe978Du7bZVjDAqL5QWvWPX5dJ0tJEiN4uwKcxedZGeZdYPGzn9jc3o0CoyFJvZuwO7FYxhQ4FeNF8Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SV0P279MB0026

Hi again Vasant.

Not sure if I understand correctly, but I'll try to answer based on how I
read it.

On Mon, Mar 30, 2026 at 08:53:48PM +0530, Vasant Hegde wrote:
> I spent sometime going through entire flow. I think we can re-arrange code so
> that we can avoid this lock change.
>
> #1 ) alloc_irq_table()
>     Remove iommu_flush_dte() from set_remap_table_entry /
> set_remap_table_entry_alias
>     Once table is updated, at the end of this function we can have a logic to
> flush/completion wait.

The reason we change iommu_table_lock is not just because of the nested raw
spinlocking (holding iommu_table_lock under iommu_lock): it's also because of
the locking context from __setup_irq. Again, see this:
https://lore.kernel.org/linux-iommu/26cfa307-6c33-41f9-a7a0-fbf202b38a00@amd.com/

> #2) iommu_flush_irt_and_complete()
>   This needs to be reworked to match device_flush_dte()
>
> Makes sense? Did I miss anything?

Same here. We cannot rework based on the logic in device_flush_dte using
pci_for_each_dma_alias, so we rely solely on alias_table. But we notice that
device_flush_dte is called without holding iommu_table_lock, so if we can do
the same, then changing the lock type won't be necessary.

Please let me know if there is a misunderstanding somewhere along the way.

Thanks,
Magnus

Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
