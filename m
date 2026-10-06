Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E61370D79
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288934; cv=fail; b=XVIUdxpjhLe6gLKR+fo6VAYaEr8CfQQyNGGaRvuFGiCrP1XS9bDOfWGlaFMNq/kigMTMKPcnXOe8Jwp52MuArCLGj0JZNLhWA4YUz79rUqgPnVS/Bt9HtEH7LzWPI5frP0Zt8Y6Y9KuBL9q8tWeonndHT86DjsIVb1f+JmbHO40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288934; c=relaxed/simple;
	bh=31uOTvM2KjCaCCqC6Lmx3LgjhlvyUZc2K+VHmB9kuG4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=P1bJobl+vuU8IHt0ce2cSQIjwGaxpwJd/7RIQHUMx2z16/hTFRdSntqWZVCDvr1dzHQdx+c3YHBh3szpuBLBdgd5+psMMecZ41prwOliu2bVcer+Y7gpuDyle6spI2jN0lX1dtk5ugFhZmhQXwymJcjg2t/k6tbJqXd04exeqhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=D6DWMWMd; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="D6DWMWMd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F87k6AIJCEYsRwWqyET+gZcaHnHVQDSNvYJlDpk6DfaZbpnLUQwSqcv8TVO47wsJUnbDbUENYBbJB63KHKJSjfTk8VycwXsZudbCJ9+jjTIRfwzwL4VofYN0i2FoAlUxdV1a4LXZHmwax4we14EjYGn9QvuFxTHLnaMh2+Ou3xSmeti7WTgWiOIdhtFO9o12NFPkgjlu6miI0aRngF47oEstjsgksNU/9+82dlnAHw0xG2kMefejCOPzCWf2gy2iYTxAnYYFe0zn3UnsaE9nss7mBsvm6jxL7RFlq80HsVJoXe//BBT79UdExWWNFxgWsnVkMgMheMETBvEIRsYrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eK+wlQJbqjTvzPyYVmfbshZ5uU8o39NppGal6lXmNb0=;
 b=QZhZ2Cx5Qu7cvYstsIDI7FPDZhub53zdA3HwWrT3AloT1Rlp8QE/D0euHwi9UuUF769F0QG+CiIUXx6XAjpb5i8C3pngPMFRfC51zFbYASjMc8fL7syiPXzQRHFtZN04f8cjUWSqEZVLYy/84EotQ93G/BRS1y0pkkQWvCc84/UY8LjC+tznL4pHjVpMTnExwG5z0xnbgddu9pdDaB2+9XpSjW4pkAd3w14jb5hej/u4+nM2CW/8p9UxeOgTPvCLN569cDLaagxHsa/qYr9Uz52cO021pHpG/0wz9fYgY2+DZKZ2MdeMVyIms0yRQN1xvki2eCYl4f2+j+rUeI/HjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK+wlQJbqjTvzPyYVmfbshZ5uU8o39NppGal6lXmNb0=;
 b=D6DWMWMdnAB62s4scok4l6dYhYKd0kidwWWOTJ2rit46u8cTa3ZpLrfQXHr/yFtgaeYD/ysYYbmnzNXfMQs7cBkyPu8/3ctHH73VQfm5UQ5mwOpVwJVWWzFab7khXKlgO3EqgtA8cuRnkmkSUDRBaUFkQccZEnE3UuscdBFT1wRlyao0PQ6MZi+3aMgY/eRSWZ72GvrmrxFSuANT1BFvAV+WsWauxib5zT7yloyoVfFEQmLhArvtCjORYahneXmVRg31Zi3F8dE1DphdLqiVkYRD4C5loKPclY/Eq77PLeWy8dMWC3bZ9v0mtPEZ/rN1epB+bGgXQFNcyRhmnpl5cQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by FRZPR04MB12432.eurprd04.prod.outlook.com (2603:10a6:d10:1ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:15:29 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 12:15:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 06 Oct 2026 20:19:12 +0800
Subject: [PATCH RFC v5 6/6] iommu/arm-smmu-v3: Wire up shared-SID STE
 ordering and feature gating
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-smmu-shared-sid-v5-6-169a59c671d3@nxp.com>
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
X-ClientProxiedBy: MA5P287CA0032.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|FRZPR04MB12432:EE_
X-MS-Office365-Filtering-Correlation-Id: afadd3b9-63ba-4150-ec71-08df23a3829b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|19092799006|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	wfnadZOD7lMKqzhpQ/NX+ATIKwSC0DzIUeErdzo9yzlM3IZKvKael9c70mLpvaLYm1Gm1UC3RvfjURfFt5JbdB1uXA/yPD/Cj4j17ixgvuzuX6EgSk8G2xeEKcQQRW8bB/6HXoq6I81qGzuyWGTw6mhO48cFhOV3TffZxIHYDIKZIX4HN5ZFOvdKtV2H6UM1rxfnROLDKB/Up2ZWw5bHb/JbQsuDZVv9v+VNrwRp3IE8LHYpWweIZYx3F9H6gYjGVHvs521Bks1TK1kU0vEF0YqKrl+uHS10tg6/chvDuGEiLFDNFHgetAo0VLLCz20iHv1aZdvUcjxM/8HSSJF4dEOeaHqJoPd9jzN9Pet9xIAGzjXkxjVn4kuTqtcCPN//MX1MY7K7QBodyz9jkflwroWIOQAmjsyGwrAqMkCDhmRASdrXFctv6oP9iUoJXxyX8CjAkUbfrSHe6+Cjg5bsbKOg6Hr2AdRnJ5ZYOtOsAMOOGC8WRadSvHos4eYgr1nAyLX5YyYo8Lseoq1axwzdWOGPCK2AEDd6TMs/QMCpupa+4RPOw71V7sskw/my1g/Fli5uvQMxGiqpB6B4ITTFg+ZLJC43Y9SmKNJSjagH2TQzjIq6YUXRUi/Py3L3DXcyRloqPxeihmrhsnCHMUsGr6JEKt6kONNMoh0UVMaUdrxV/aJdx/YycOlFfDnRcuGCKw1RflqyQ0RF/eizEAFvSQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(19092799006)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0hLZHE0VHo3RHpDSkJodjJLVVVtajVCRHR2dnAwWjlFbVdEUmFjbzdrK0dt?=
 =?utf-8?B?STI1bklCY3pZclIzSXI2V3h1Wm14d1QzS1hHVFZQMklWUGdQdnVoRkplWmYv?=
 =?utf-8?B?bmlhSFo2TUV5VVgxaE5pa01IcWdpUlhVZVBwRnJwc3ltT0k5TGlJTXZkdUhO?=
 =?utf-8?B?V1hONnhqcWVSL3NRcXJrZU9uOGZmT3RsRUpiRXRiSFY2K09uaHBvclhqMjk4?=
 =?utf-8?B?b2ZieU96M2lSOW5VajlnaUhrNTloUTZHVkNsRzl3RzV0OC9GakdSM3M5U0pv?=
 =?utf-8?B?dnQ0VWJTN3VqUDZUWHBBTWpCRzJCTUs1aTg1ZHErWFg4aTRyYmp4dndieUJE?=
 =?utf-8?B?OGFNRzRkTG9MVW5CN0VqT1VBandTN2xsTzhoZUpqQkc3YmdXdTV5WTlKTTNV?=
 =?utf-8?B?MXhIUWNmaTlqVVl1RWl0TU93b1R5UnFkSDJUWTRxTkhwUEVBQzlOK3F3aXdp?=
 =?utf-8?B?UXZpa3VYMGIzNStpby9nLy9aTjZISzNuNExCalFFTmd5SHVZeTdaMCtrR01s?=
 =?utf-8?B?ejFyRE9kYlJmVHRwcGZBcGR1N2IyVXBIaXpBL2tLaUFuTHdjdTVnOXBVVFZt?=
 =?utf-8?B?VVhBSUF6V0huSjF1TTZURU42WWJKek9IRTZldTBjUUlBL244eGdRTXN6QUhv?=
 =?utf-8?B?TUgwVHVvZnhpRnoyMldCTWN2R0ZrNlAvdVNjaEoxQ3ByeWV4eEJlRVd5S1Y2?=
 =?utf-8?B?VXA0dFNEVWtkWGZqRVVaUmk2VWp5QWxzN1hlbVAvTE41NTVJWmh2aEpFdEVl?=
 =?utf-8?B?T2lTM3BUL1hkM3ZocHVzMC8ydldXUGcveFNnbnljMXRqOXNicWFUdzVhSCtY?=
 =?utf-8?B?OHlJbWdXY0J0eitvM0hGUFpDQlllU3kyNjZTL0JtNk5nWldrL0oxMnhCYnY2?=
 =?utf-8?B?UDB1cnc4YmQ3MU0wdXcvSS9LblZNNXpQTkxQOUpiaGNGdHpFdjE0cU1xR0hM?=
 =?utf-8?B?bGQzeE84R0ZJUkVibFVNRnBDeUkxOXJhT3ZrZlZ3SitQV3RlSmZyUU44V3V1?=
 =?utf-8?B?WmtVeldtSWFUY1dZMlRIWDFLM05GT0JGeStnaEpGb1pSTzliamI5clRLcXFN?=
 =?utf-8?B?c1RFbW9kTUd2dlRyaG1HTU5LYmcraGQ3OUF5clBJbjVFaDlFVU5zQjV1MUdC?=
 =?utf-8?B?QjZQS1pWV3RFRkF6dmV5MnZvNkpYTXhNUW1Za2x5VWRFOGtPU0VUdjhkeFRp?=
 =?utf-8?B?ZmRFM2N0cXR0MWxvWmFwTnJlSEUwRHFSZXc0NEo0bzF0UEowQ2JpYkZIRlpt?=
 =?utf-8?B?TDFkMGFTMHlSUWhxTGFFNUdheHJTMU83cWVXNnloclpqUlpQODhBM1JqWUp1?=
 =?utf-8?B?bGxFWHpqaWpmcUtkZzFkQXJBaUhaR1hMUWZ5ak5ZV1R0cThhbFFIeFp2Ulhw?=
 =?utf-8?B?b056QkpKRHJsbFM2RHhOdWswdmE3L2ZiOXIwMS9WUTUxN2pKRUNSYVJXdnpZ?=
 =?utf-8?B?TDhsQzVzQXRPSlh1ME1Fa0plbW5uS25YL2UzbUtnOEhiVUZZR2lreUxvYldp?=
 =?utf-8?B?aDlIYVZWR1pPUUdWSnZMVmNkZDIrZllNamhrOWp3aHNLdUJqVUpHWHNRZHlj?=
 =?utf-8?B?WCtTaHU4TFVxblhrTHJ3WXRtUHZvZ0N1b1Z4UXFvN3NTWDkyV0c3bUxuZVdT?=
 =?utf-8?B?WWg5b1BmN1B5UXlhZFZQSXhOc294NnFoN2tWODNOc3EreU41QlFJVC9kbEpu?=
 =?utf-8?B?dUxjekd6bFBjQTVBb0tiTGZLbzkwdllEc3A0azZZTC9BS25JRlpYekdsZUNX?=
 =?utf-8?B?Tk5Hem9XZnlIV1dLTVN3ZXJXQVBPRzRhb0o5aUI5cGRMMFF5bFNXVmc5UG1n?=
 =?utf-8?B?dnphZW9OK01NM0tuYnQ3dnlEbTdyakl0bDNseDkzeUwyNHg5R1Bvd3lMNEdr?=
 =?utf-8?B?dGE5b1l3WVdNYTJudVFLdXhqVkdUdnRpUkVNT1dSZUI1MlNKd3lWbUVsczgw?=
 =?utf-8?B?UlB4ZDhyTFU5bEkzYnRPdXBYY2VGNk5ubm83TUwvYWtzMUNSdUllZmVKR3Bw?=
 =?utf-8?B?QXIzREc3QmtSVVZnVzRscjdjWWdJYlEvQWliS09IWk5CMXhCdmRGcjliQzBi?=
 =?utf-8?B?ei9pa0JxeVg0QkJ2aGlRUWtGOXllUTRvbWVZMnpDVktYWHZ6S1YxdmFIR1Zx?=
 =?utf-8?B?RDRSQTVCdy92VW9jZzlZOTJHZW5mNVdBcTFVRFgyMUVsSmMza1NaUklOVXFm?=
 =?utf-8?B?T0lnZ0pXRGRDYm5mNzIxWnp1OGh4Ujc5bDl3VmZ5NnBjNFJ5SFh5RGpKOHc2?=
 =?utf-8?B?Mml5dTYycnduUktDeFRqdWo4TmdGMy96WGNweWRxRkJkckxkbnVaRm5POXRZ?=
 =?utf-8?B?UzZpZlNPTExnOVlsczZaVmRkZXdkeC9GK0ticTVPN3ZXNlczbnBTYmNJYkNw?=
 =?utf-8?Q?f8L3fqLiOx8V6JoQGWV+Hs9OGyTzfWs7wEeC9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afadd3b9-63ba-4150-ec71-08df23a3829b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:15:28.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eV8p8bX7XcKOn9ZOXzY5SbMKX0E3K1jxhqlVVs5CD5i22tYL5rdtDIUYbLBrVSmL7aF93s4ECqKsHYXTUmW6MwHW/dQxmLxkhktVZO0CKhcwz3+tv2XQxepAxTIVo6HS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR04MB12432

From: Peng Fan <peng.fan@nxp.com>

For shared SIDs, only the first master to attach writes the STE
(tracked by ste_installed under streams_mutex); subsequent masters
skip the write.  On teardown, skip the ABORT STE write while other
masters still share the SID.

Fault events on shared SIDs cannot be attributed to a specific
master, so arm_smmu_find_master() returns NULL when the stream's
shared_masters list is non-empty.

Disable SVA, IOPF/stall, and vSMMU nesting for shared-SID masters
since all three require unambiguous SID-to-device mapping.  Clear
stall_enabled at probe time so the STE is not programmed with the
stall bit, which would cause unrecoverable bus lockups since
CMD_RESUME cannot be issued without a unique SID-to-device mapping.

Assisted-by: LLM
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  3 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 47 ++++++++++++++++++++--
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 0934a6bbd3e08..9f13154f832c1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -309,7 +309,7 @@ static int arm_vsmmu_vdevice_init(struct iommufd_vdevice *vdev)
 	 * arm_vsmmu_vsid_to_sid() maps a vSID to master->streams[0] alone, so
 	 * more streams would leave the rest stale and none reads out of bounds.
 	 */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || !list_empty(&master->shared_masters_elm))
 		return -EOPNOTSUPP;
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 0a429c64fbf3e..54a0a65669ac2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -271,6 +271,9 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
 		return -EOPNOTSUPP;
 
+	if (!list_empty(&master->shared_masters_elm))
+		return -EOPNOTSUPP;
+
 	/* Prevent arm_smmu_mm_release from being called while we are attaching */
 	if (!mmget_not_zero(domain->mm))
 		return -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c4cfe609ae93d..bf09c02538381 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2977,11 +2977,36 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	}
 }
 
+static bool arm_smmu_is_shared_sid(struct arm_smmu_master *master)
+{
+	return !list_empty(&master->shared_masters_elm);
+}
+
+static bool arm_smmu_skip_shared_ste(struct arm_smmu_device *smmu,
+				     u32 sid, bool is_abort)
+{
+	struct arm_smmu_stream *stream;
+
+	lockdep_assert_held(&smmu->streams_mutex);
+
+	stream = arm_smmu_find_stream(smmu, sid);
+	if (!stream || list_empty(&stream->shared_masters))
+		return false;
+
+	if (is_abort)
+		return true;
+	if (stream->ste_installed)
+		return true;
+	stream->ste_installed = true;
+	return false;
+}
+
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target)
 {
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
+	bool is_abort;
 
 	master->cd_table.in_ste =
 		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
@@ -2990,10 +3015,12 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		FIELD_GET(STRTAB_STE_1_EATS, le64_to_cpu(target->data[1])) ==
 		STRTAB_STE_1_EATS_TRANS;
 
+	is_abort = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(target->data[0])) ==
+		   STRTAB_STE_0_CFG_ABORT;
+
 	for (i = 0; i < master->num_streams; ++i) {
 		u32 sid = master->streams[i]->id;
-		struct arm_smmu_ste *step =
-			arm_smmu_get_step_for_sid(smmu, sid);
+		struct arm_smmu_ste *step;
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
@@ -3002,6 +3029,16 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 		if (j < i)
 			continue;
 
+		if (arm_smmu_is_shared_sid(master)) {
+			mutex_lock(&smmu->streams_mutex);
+			if (arm_smmu_skip_shared_ste(smmu, sid, is_abort)) {
+				mutex_unlock(&smmu->streams_mutex);
+				continue;
+			}
+			mutex_unlock(&smmu->streams_mutex);
+		}
+
+		step = arm_smmu_get_step_for_sid(smmu, sid);
 		arm_smmu_write_ste(master, sid, step, target);
 	}
 }
@@ -3149,8 +3186,7 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
 	if (!master->stall_enabled)
 		return 0;
 
-	/* We're not keeping track of SIDs in fault events */
-	if (master->num_streams != 1)
+	if (master->num_streams != 1 || arm_smmu_is_shared_sid(master))
 		return -EOPNOTSUPP;
 
 	if (master->iopf_refcount) {
@@ -4331,6 +4367,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
+	if (arm_smmu_is_shared_sid(master))
+		master->stall_enabled = false;
+
 	ret = arm_smmu_master_prepare_ats(master);
 	if (ret)
 		goto err_disable_pasid;

-- 
2.34.1

