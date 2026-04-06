Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012060.outbound.protection.outlook.com [52.103.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E2C33064A
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490035; cv=fail; b=ACFImp39w1kQV6ybpinj5ZZctJyFljZ6DNTvMLELs6vmCk8U5BDg1cX9sqvwdjzUXCpJncjs2TgmN5a8FjPhw0Cofvn5oIXD1BvqEh0S7kTMMzE7vpggAsfXpRoXvy/vLG/K8psU/DLVEYJLhYE50EWxRtANsGeSyt9QGi+pI0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490035; c=relaxed/simple;
	bh=n9gVmIZUPC/n9DEL0xE7m4keyuAB1ciefjCgHjiXUwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTkgceuIx4hytfEHtNt7KlM7V05+vyFbforXp+eZ1daDbfpY7p5xTfQoxB+pJ55LXGa0mQ4a0VwC/9TFUYfou8Pa6JBfbtCM7jKKwfQNanFYGFQG0hbolJ5Xcv1aM1zqCVLF38n5MRjSIr5zvLNrHdn45EPf+Mm0WeHQPEUQv+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=S92226hw; arc=fail smtp.client-ip=52.103.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="S92226hw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4Ne6hLGpvL+p4lJ8jCGJwY1h+Db0ykQuhceWcrqRa3JmfOZe7CFq9n5dCnyDkM5MoCXXEWjpA3ZfG6DXsrc8XVRL9mHLABj7zgocyW0tp+Br0tKGvAaZYjanFlDTxDEK2bdDTZ51D6NqN9Yg7f5jQdsIWgoPc8zwcD9ummDgjD1VFiuoNqdh4P48ANNOAjMZf3EnCZZSo71Q/7XLkGs4eRYNJ+SmocRuN93LxtKrRzqmwF/W3X22SL/w9kzyc4JtVRauNPM3wV12G2mt5f0f/4bgBSQ5nqRbe4dUxH46IzKVmkPtaRPTqhel5Lz2g9wOus/sl8s4uY/kI9nNPHl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZl4wTLDlb2chlAv5N9P9Y+bb5U5/zFH+YtwwhtpBjU=;
 b=Fu0kCIbj6xm8qCHoydl0a0hGL5ULd2ZiHIymzvwHTZ6ShMNNo6aAoTLr+o631SlqAReg3Y0iru3IXaOb/JAsMUbo3AIhgxZoG25j5jlVmCaLYlGURocP1axVrGbCxFVXuGC09c2HCcrWRCozEArrrydR14hu2ZQlx+LjXxsDdXff/GN++R3KvfDNf+5Y/jKVwHjbojhRGbtsBMJl8bjXW7zZ8rZUyuWya0rHO2xghUjhIRZ69tc6WKczX7BTXZatFgL/ApACL4rHubSqSl0I8l33/XHxme6W1u77VJQWSBf5Hf2bJBth4hAPaLB6X8JztxT0JVM7J+53mCaUANqL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZl4wTLDlb2chlAv5N9P9Y+bb5U5/zFH+YtwwhtpBjU=;
 b=S92226hw8ZgEeyCNZ3yLdnxovXyOSDuNN9ldhodVi7KzbqM60Kz8xO+VHNqyNzw0XzhYxoXsAC2j67yvxnOH5YRO+EMzcvokPeDQsSZrWcdZlwS0l11XwMfDBBxsJhz6hMfvUMrqgGgeOoxpcFU0VzdGPQaj3tBH9m5pkf3z5EoJNXOS9hDeaXmpDBc2w0HYGZpCooexm4wwgwWqv0wsTOPaWYPO6Y6DdiLaQPSL/BUE81cdZtu6bYEN/lGtpO9JE1j2YXIxccxz4a5GLtrZXVxharUud1cagsxPwAIv3GzIaQvF710LaG6v4U6icSRbmr/NzUY0P+Ii0nOpmTg6xQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5150.apcprd01.prod.exchangelabs.com
 (2603:1096:101:e7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.38; Mon, 6 Apr
 2026 15:40:29 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9769.015; Mon, 6 Apr 2026
 15:40:29 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	thomas.lendacky@amd.com,
	vasant.hegde@amd.com,
	aik@amd.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v1 3/3] iommu/amd: Dynamically verify Southbridge IOAPIC via PCI config space
Date: Mon,  6 Apr 2026 23:40:09 +0800
Message-ID:
 <SI2PR01MB4393703E1D856C2B8C5C6A42DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:405:2::23) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260406154009.580106-4-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: c33d3c9d-68d9-463d-b4f5-08de93f2d4a0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|8060799015|23021999003|41001999006|21061999006|461199028|5072599009|15080799012|51005399006|19110799012|7042599007|37011999003|440099028|3412199025|12091999003|26121999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CkY2m093cjX5UyRpfmg5elY9glnU2w+xOoHqAtUVZTG5BhdAoKe1magLCbjX?=
 =?us-ascii?Q?lSCrNM65zm3xmMu5d6sk8BaKYj3c3oES8a8HFkZOND991CllCI8GhAdNwlIF?=
 =?us-ascii?Q?tBN2KQknEMHAJeuxAxh0iiAgMDYBMQl4jNTGcOJkNxmSGOtpUWjWEfCsJ5af?=
 =?us-ascii?Q?P6tpiw7Phjp/I0vfHH1V21o961vG6rneIFjRgDc4ggErwz4H6o22Lr/1ziO7?=
 =?us-ascii?Q?+qapste0vM6LYoJSG5xMjhHBWq6xLXdv0xuXGvUetaGPuODIuojWAylb1zun?=
 =?us-ascii?Q?7FseGZ+eDfQHVONNZ8NI9vDEWoLB7qTMCJzL/VPsXhKA+ilnXPRFTbU3ybKb?=
 =?us-ascii?Q?qFxYsSQ7D8a81Iu4D3gQqM68dFr+/izhw0nRHpkv6aHFuILt4C90SvVD6Zxb?=
 =?us-ascii?Q?CXGdBUF3EHlU0pJ8IjgwLrPklmlSU0+wCmlOmX4jpCdoNQs5eyyB/QlDE6nC?=
 =?us-ascii?Q?5eQ9gIDT2U95MWvW5wX8ODew+stwFbUJYwDc9Q3fNvwAKm40Aw9bH+zZmRcJ?=
 =?us-ascii?Q?yvNm0S/iZk0kNmS3hUV5+FJpvOeV+w9Yd9ihNiBg7H7AC2EegTjfI/ijmEnD?=
 =?us-ascii?Q?pgh9Rq4Kfr+pq5DmdrLDmvMUp8GVp1GD0Ay7hLpLxELm0RevMIQrPVcNebbC?=
 =?us-ascii?Q?vhfNzmBKR0pFrC2f4AgvUTHO8oK3KU4MtOKEX8QDA33gwjOq3QLXdcPkMx/m?=
 =?us-ascii?Q?X/pyRmmtoRxovKnFUXmw56gwF+jffUxEZpx4X0o/yZOqGAuYx8nB09Inq+XN?=
 =?us-ascii?Q?idGPJo+iCqKtIQt/QA0pCufLvM7jlH7UDb+ahLqVSS0ycuryKcB8Wpgo0r1J?=
 =?us-ascii?Q?ewH51U6uVBia17Ci6xuN/pYC0J2SiyUgsZiJlkZiGSobRH+//x7oz5qvoPCD?=
 =?us-ascii?Q?tNOOf64sEgD4W1lw3auRe3ilWlVCIS+k0cJ4q4TVMA5CKTECCobIROhj3/uw?=
 =?us-ascii?Q?QDQS/V7aahIU1aredA6tCtKB3cXNSD50MUSs6ZdEpBH0K57POA4nDaiIrjio?=
 =?us-ascii?Q?dp1uhCrJ8Mi73KdnOIaJwRLDeigaNF7fNVcSxyLfizC+gxf+eI+IN0AeWIIG?=
 =?us-ascii?Q?xLn+Ht7+KZBbZOFpwwP+o9Bkdcbb+zDfTCairdDzGL9Orq1UWtCQ/0JNEbzq?=
 =?us-ascii?Q?ZQ5gvB8+VZMyU79zTdTV1NDSLlGWuP+S1A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DF33nZUL7MANs25enzJiz3ErmQ1aunH9UmdfBK28crHTYwF5cCo64y7C+UTg?=
 =?us-ascii?Q?U6Lv8KYPlJ2y7LsLwYEK8tJuumU0f27PDdTp6HujRdl/+AGWkQqQiU4nuyQF?=
 =?us-ascii?Q?t+lZOypO2mztjLV1hwFHSo8SYrhd67VV0CTdmWswkusM1HWJDLDmsIg2H6Np?=
 =?us-ascii?Q?IkwU4692BDkM3EQZtPpnSkUyU8DwY3WSrqlslJ5YbmcWEvWcwyN3F2YTFhHl?=
 =?us-ascii?Q?L+BC+pMVcVRaqe/jBcurFpWjB5DIKNsAUewaZQfBsuobKxs1f8/Qb6EtZMiY?=
 =?us-ascii?Q?8ZTsvw7QKxvA2UErD9Nx0FgFfNMtsR63741fjNM7FdKCLfT56HQfuSekApnA?=
 =?us-ascii?Q?l6i4pF94K2w21SmhloiRvy0FBbNxNEg27BqXwKuqiHZNNMbgm4FOF4kdtxsH?=
 =?us-ascii?Q?r+jUKrApZKqJYjGFLjbYYnHBEjpi4CRVm/+tnBMY3QSU2skxXm2cuxDdFAH+?=
 =?us-ascii?Q?Jej3zv4gDMREmSSDcyDFiWfjNDm03zt2LHz7a/83HC5qDgeDxPD6tyvDjcLC?=
 =?us-ascii?Q?UIwGywyrU+OMA89FiBxI0CPGpsnZqlZQvPqlM2GTubGFvfYnSq+t4bbbYEv5?=
 =?us-ascii?Q?zheNt88wV6kFTT5vwlXzhMkEWkl03eQDoAC+Kolph17MTxrL20n/p5PibPLg?=
 =?us-ascii?Q?jfageQHxJbme7m/ydMP442+ASYMSO2608uVGRH8v8CGZRU674U1z8geIhsmH?=
 =?us-ascii?Q?+OVlmkmvYV4R9mi2ix4Pjjeg1PeYZZw2KoijmSKStsz4BwaI3HutvWqFlR/1?=
 =?us-ascii?Q?Z80cbxK/b1ikiIYKm4XyMYlVzvTtWHASwh4f3ujYcQIvcufIEfNJUqBwCjFS?=
 =?us-ascii?Q?XR48XPpR6VSZhdEO4nJCU2hrt4hScF9pSVHJ6D158bHnxePGZ79rX+VxcTPr?=
 =?us-ascii?Q?OCYu2PUlNgdJoCcIzoQ0EeVX9TcUKp5ClWjbmdpXlW4Yd7h1pnSIWz13k7xO?=
 =?us-ascii?Q?5HHZns1Gu9uJg3pp6vSuHPRuukLXyKXvJpFuwmpGOH7K32/huRgalG93N7dA?=
 =?us-ascii?Q?I2/MR3eTtiMhgp7e/qphLyh4I55PY0P2nkJ7OVezEB9JohRBJUUt0Xnl4XHp?=
 =?us-ascii?Q?Z/hfRCmYp681Epq512Y4j6wTXpGJAP4guNIaH/DZ90Plojkx1vD/hle41kq7?=
 =?us-ascii?Q?R1UsVP2HVx9Xp+/yz/mJo/6e6wm9n271GORbVgdO2W4kVRTh5WJacsJbBQgx?=
 =?us-ascii?Q?MAGxDwVrMYfFluNNJtnfS3zWbCXK0BBGU7620FjbuGlHDR4Skls6MX//FHrh?=
 =?us-ascii?Q?6S+Nk1oo2u7wPm2qsA5Ocs92zBDNzppbdEZjrXdID+yGHHLOJvTxkort5Pa8?=
 =?us-ascii?Q?+uFEDvoMXApdG5Rl0XqDCdFayrOYV2qEubV7SS5jHMyfl/jWFcUYJT9Xa0J5?=
 =?us-ascii?Q?+hImyFFuH3bDofyulI3f/MHr2/a0?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c33d3c9d-68d9-463d-b4f5-08de93f2d4a0
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 15:40:29.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5150

check_ioapic_information() verifies whether the BIOS has provided a valid
device ID for the Southbridge (SB) IOAPIC in the IVRS table. Currently,
if the SB IOAPIC entry in the IVRS table does not match a historically
hardcoded device ID (00:14.0), interrupt remapping is forcibly disabled.

This hardcoded expectation does not scale to newer architectures. For
example, recent Hygon Gen 4 servers use 00:0b.0 for the SB IOAPIC,
causing the validation to fail and interrupt remapping to be permanently
disabled on these systems.

Because the SB IOAPIC is embedded within the FCH (Fusion Controller Hub)
and shares its device ID, we can inspect the PCI class code of the given
device ID to confirm it is an actual FCH device, which is typically
exposed as an SMBus controller function. The PCI class code at a given BDF
is a stable, specification-defined property. Using it to identify an FCH
function avoids maintaining per-vendor/per-generation hardcoded device IDs
that must be updated for new platforms, while producing the same safe
fallback (IR disabled) if the check ever fails.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/iommu/amd/init.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8981117417d6..a4930a946e68 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3096,8 +3096,21 @@ static void __init free_iommu_resources(void)
 	free_pci_segments();
 }
 
-/* SB IOAPIC is always on this device in AMD systems */
-#define IOAPIC_SB_DEVID		((0x00 << 8) | PCI_DEVFN(0x14, 0))
+static bool __init check_sb_ioapic(int devid)
+{
+	u8 bus = PCI_BUS_NUM(devid);
+	u8 devfn = devid & 0xff;
+	u16 val;
+
+	val = read_pci_config_16(bus, PCI_SLOT(devfn), PCI_FUNC(devfn),
+				 PCI_CLASS_DEVICE);
+
+	/*
+	 * The SB IOAPIC is integrated into the FCH (Southbridge), which is
+	 * typically exposed as an SMBus function in PCI config space.
+	 */
+	return val == PCI_CLASS_SERIAL_SMBUS;
+}
 
 /*
  * The Southbridge IOAPIC is assigned a GSI Base of 0 (handling interrupts
@@ -3148,7 +3161,7 @@ static bool __init check_ioapic_information(void)
 			pr_err("%s: IOAPIC[%d] not in IVRS table\n",
 				fw_bug, id);
 			ret = false;
-		} else if (id == sb_apicid && devid == IOAPIC_SB_DEVID) {
+		} else if (id == sb_apicid && check_sb_ioapic(devid)) {
 			has_sb_ioapic = true;
 		}
 	}
-- 
2.51.0

