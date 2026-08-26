Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9C3955F4
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768364; cv=fail; b=hwBGbsSoClu6Ki5FUSjjjs140hY2mZ/5V7lQszdikfC2eLyuXHuB8QDlxOpbG2kqVIjD/IwAyl2OpEmplazJbkPUFFvEjtPgEASq4aD4WCJ09oicPrYyQyBz+fPWaY9W4N68dRdgKhi5JO9Wd/0Q+vvKXjuHpBB9IrGlG2B4l9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768364; c=relaxed/simple;
	bh=6IwFBG2rXn7AR1lGq/oiBT5HWYmxp/WIE+5PoVs+INc=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Gz/Q7YyaPHFECNaDzSbyStm1eOoTm6mKNhngtpfnaDe+dE6ml8T/tE/gadGdz8z51+Aq96RvtGe7ucu6o2hyr0I87VEWDi22mB86BJ2ddNmMPR/c7xnN89vnH+zjrxsXjIxkqYxbVSJwXfEZp47c+GaHVYh9STbAlFnnWtr8+7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WF7pxVRk; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WF7pxVRk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjudGqdrv72vFMNxEH1xtqy/xwNXUvOQ4g2H+29myNUFAzTrfTTx4yf6hvjpGDpHeDQpctoOg9qoT0HhdYgKzm/l5+BKJM+WEYKLKveWt3XDHm3Uph/K/E1hi5wGpCmoWiaVdcK2xu5PWC8HCOukmFcpFvCP94GC/6BKEkxIzMIupz28oR5sSy594D/D4Mq/bntn+K41vT4/J1nP2j4Xm8Rcg0yuyEYbM1QWaPxfn57thrH3bb2ntWS/nag1dTtdT1cE/dJmoVNa33/pjE0rAmAsWZrACX30rG0XWcMs5aa1xk+0WaO6TcC87CREl2ldHOBIzDsQcMe9hl7j7M/09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSJK7e31lPxbgSRKKKsrkS4NHvMC+icNFjexTeZNSys=;
 b=eBOAtckMExT+vz87tKJnkiRbTXZ2prxfHPj39CjYpcyJSVx4JZhMt5shdt8rroUBSVnOrXrDBWcGuPVfb0cRzQNebY+sXMlSj3mFDgErgAqlaBaT0FSJ6Nx7+3JMy9yljhHSSFYNRN4ZswhlWxn3W6LP77S5VdJdXEqUYVrLc37KTlZ9WAjJjuw3guzxcMkg8TjdRB99IJT4roefcB54qIpv8M5D8QSZnkoTww6IwhN5K7wCa5RwM+iEFKxdT/j42ooqBkZEHTm29+hyI2SV3WPySwBfgPiCQ6aAlhRE35/cATE0xPyiE5sJMj3Wxg/jvaGUSORvPMgdWWAsqmwCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSJK7e31lPxbgSRKKKsrkS4NHvMC+icNFjexTeZNSys=;
 b=WF7pxVRkJIR7JIuWA5d5tRPo3m957oY5B/rPzfuzthB3Wc6AfNe08m/ygLp5tVZOFKDnuXC4LkDCMHFyqA/yo+J3iQUC4UnIlorq4CWVmiT5Z96jubcoJOT/BoVQRwkK44WaOBPXvXiiOU728BDteJkwi5ChRQhGKtOp4HzHqwwQUjtnGMOGPxSn6l+vQW56xYtETzUty9ErRjEkLXkuSJxAELJkzmumqO21r5AW+CFbMS0wq1jpvVwfOXrnnqx7S9jpiZxpxi07TnurneIDVfG4cgSECjwlh/7BmILeidVcBt5zXkQt7+OgGYIpgI07GVi0GM0PZISK2VEIL4xHoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7437.namprd12.prod.outlook.com (2603:10b6:303:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 18:18:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 18:18:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/5] iommu_pt: Fix test_pgsize_boundary() failure on
 narrow-OA formats
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel Drake <dan@reactivated.net>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, 
 james.quinlan@broadcom.com, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20260825-bcm2712-iommu-submit-v3-1-7f143e7289b6@reactivated.net>
References: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>
 <20260825-bcm2712-iommu-submit-v3-1-7f143e7289b6@reactivated.net>
Date: Wed, 26 Aug 2026 15:18:41 -0300
Message-Id: <178776832178.3356902.10335417913508692093.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: CH2PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:610:56::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: efdb525d-c124-40b7-4722-08df039e76dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|11063799006|3023799007|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qsXuTaRQKFuywC/RMguZ1XZTyubs+o7VAoiS2lkbHSpLQocZ1wEZLJWISkepFks2LGGJ77KJlgTCdrDfJYjkgXMlK40t/mqefnUzPeQYxd4+IhqsY5bxgum4lU1WncM6r+h9Gq6lW1RdO2rTtv9ILFLxOi0/RjrhYoAds0xxNwTR7+ZAeLCGWjSUy/SBDZaTWMwDh4rmOTm7pOchHdkkGePYNCC6vx6+4k4UQcqKCvpfFseTDbM1YkLlZGfq0BKOkxoXtJRJRUeoiR53Gba/RLEXTettY0TUlC6+/47lpdTQ1vbnteT40rMeQ/AeY1kLxjx5NXOVFxz2JmIeRBUAF6PKAcnvOf5u+/YBeLoNxzYxZcOQgTbeuL+u3/PZipL7KRDYOxuiTEAcFttCJBHNkN97qxUNfPQ/bRSoRT+Xx+Pg80JQI+Uxr57HrsSjVsvXI9Zhe4aoJWKRV7Wf6p6xYgNUGfFFyc4oyX5ycP7Pr5u/uVx4/4ZDS+ksgofEtZKM78H0NFT4qpLe/IIhN40fcY/za4O1+0oVAK07EdF7uVQEP1asvXPyaARmHlIFJB9Iney1CzjODKFQrPPp6pTog864X6NAs3X6o55/Cvx1bTyTykp0HkZs56IKyIiCCoYOE9LcYzHYEgMbpgR7DXanzhTtJYLg99Gw2wQkFiRZ4nw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(11063799006)(3023799007)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2xnNlozc2FuVXFoWVdSTUtaVmE5MExpd0g4SzhxdGV4UnJNMG80Q0Rrd2RW?=
 =?utf-8?B?MDEwWlF0Z1lKSUQ2TEprZlRYVmNmczVCclZ3cmtFZjV1QUE0UElXZnA5c1R1?=
 =?utf-8?B?bFBNcmt3NHhVWGdob1BrMWJ6VHh0ejdSdHd2RTZMaFFmMmNpa1RhZVNtRGI0?=
 =?utf-8?B?c0xsRDg3ckpRWk9Jb2RjcTF6U3BDOXF0Rlc3MjRKNXZPWG5tVlRhNjRSYXJM?=
 =?utf-8?B?blA0MWtlR1poTlpOaFh4RWVxa2JvSDFKV0JxeFQ3dHFiV00rQWpvUThaTUdz?=
 =?utf-8?B?eGRTZk1nOElTamdJT1hMSy8ybjhVTnhBbmZGclhONy9rOVhpbEtyd0RyZkFF?=
 =?utf-8?B?YTVsSnhZZGVXUHhDM1dMNzZPTnBOSXZwUy9BUjFCeWhlVFBOM2pUZ1Bva3JT?=
 =?utf-8?B?ZlYvYWI4SjNsMnlqUks1WGZNNGNBT0tqa01qTTRtaDRCM1VFU2w5TFg1TzhR?=
 =?utf-8?B?d1hUcU1YOUFWWHg3S3pkNUl1SkVGUU8xUGRYSlFUdVFQbHZPZzVKdHFBSklN?=
 =?utf-8?B?b2xSZncrS2d3N0d3cU95UVljTnpyM3VyUk1BYTZlMWNzc0FqV1RsY3pYNDU3?=
 =?utf-8?B?YzdiMkJXT2RLeS85SmN3dDJKM0gvZHNDQmFzMktJelBDUHVPZmZhbmNxTnhQ?=
 =?utf-8?B?Q0Z0OWpqMWQ5VXpBZ2FnRGVaeWlpMStsTFkyLzRzd1g5bTYyRWV5K29vck9w?=
 =?utf-8?B?Q2hpUDdUVk00WTJpdmdGeHZWYTE3Vm5XSHJWV3VkMmRvNERQM0hyQ29wd2ps?=
 =?utf-8?B?SEg4MENXWnRrTWtmTkQ1WmxrMzJoelVRRU9rR2l5WFJNQjhhbE9vS0p2cEh0?=
 =?utf-8?B?WUc3WUo0Vk9NallHbTcxczZ5MHpZQTZ4YzYyd0lTMndrZGI4SHBJY0tWK0NH?=
 =?utf-8?B?OTZVSkNRaEQxcUl6MDRvSHdlS1BWc21Na21QL082S2c5MEFGTDdTb09NN1Jp?=
 =?utf-8?B?TlcxMGg3bkFvdG8yV3JmeFphZllQandZVDh4NWpmU2E4cURISU9nVFFUdGRJ?=
 =?utf-8?B?aWZFZ1FnVEJ0RVZ3VjM5MytmeWRNSytPYWthYTRWQ1dyVGNhbkl6eDN6YUFw?=
 =?utf-8?B?SmpydkFEOU84anNocHYrcjFnQm5nSWtnbjdaK3Z0U1RBYTRwcVNVMjZpUit5?=
 =?utf-8?B?SnlUcS95TG9kaDRkNjc0THJpdHZNMFoyb1pTdkRPR2J3Y3cvRitweks2aEhq?=
 =?utf-8?B?L3NDWVdLNGdPdVZpcGRCSEhzbXlFNFYvMExQUG85NzhqMFpMOW1qR3NQZ1dk?=
 =?utf-8?B?L05SdEJTV29CcWFyV3JQM09MWHBiazJham0rTGNaMjZITHBVTVZ2NmF2TlBL?=
 =?utf-8?B?dUFGbmxWaTFjOHpPYUdnbm5VSTlxMElOYmdEbGVYUDJMWG11K2JLVk1DcnJj?=
 =?utf-8?B?dTFIdE1WNThjWVhHRzJ1dHhTWG5FL3RncU9SeHpKODNmbWZBWG4zRm41dTR1?=
 =?utf-8?B?TUNUdC80UUNXYWdaWEFUNG82LzM2R2hmbVZ1cHdNdVBnQlh6Ulp6Kzc5N0g5?=
 =?utf-8?B?TXJFNUpseWdhZXRiUGdWOHVVa01BcVVEVVh5ZFluaU44WlpzSXpsZjUrRzlS?=
 =?utf-8?B?WWpEMjhNcXlJLzUyTUpVTVdkWlhWaTVPbVA1eXIyNHdqZEN3WnFpNVFncnRO?=
 =?utf-8?B?R0k5cVlRa3JqQThwd2haR3RJSm12eGVCWjcrRmp1RjR6VU1VbEQzMVVRYk03?=
 =?utf-8?B?MFQ4Vm84SGJlVUZ3aTRXSTZOZi9ZR2RHSVdkNXYvU3p1M2pCWUozRTR1Rk4z?=
 =?utf-8?B?RVpGRTNVSHJ1WHpUelRjT1dsS2hmbGxGL1RFNjdFMXhONTRHVjNFa2VCYnM0?=
 =?utf-8?B?S0REVDZJb2RIODdFWlAyak5DWXlCZi9rUUNodUx2UXFiaUtXMkwweVpMZlg0?=
 =?utf-8?B?M280K2ovbDZra3RQNGVEZHlxcHlEVFdaK3dhQ2ZCbGdXQ3dvS1dJQTlPcHpJ?=
 =?utf-8?B?ZGNPdmYzQXJXbVJPUXVrbVh0bVBueDB1UlpRUUNGQkdkdGtuUEh4K0JsRnJo?=
 =?utf-8?B?OU8yaDR4NncvbllYNDA4bUdQV3pFanNsbGxtNFpYZEhVNm56d3NCdGRSck5Z?=
 =?utf-8?B?ZEtZeE16M1RKWlpEOVpWSzdpSmd1Lzdma0duLzZlREEvZFp0Y1ZzbkFqVXUz?=
 =?utf-8?B?aDZ2aWRqMUFhYjNWTzVLYjZVSkMya3ViOUxXRUN2RHJWVkkxM2ZqRW1FMUFJ?=
 =?utf-8?B?RHl1RnkvMmdmQ2hVcFhFcFpIWmNHVExkZTU5Vk51TDVad08vMTJ0dEJ2MzVE?=
 =?utf-8?B?Vk4zYjZXYmxic0dTdy9sV1FRK29SRWVoWG1KMDZVVi9xMExMa3lXWVFSZWU1?=
 =?utf-8?Q?7dMlfa/X9aS2eQENec?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdb525d-c124-40b7-4722-08df039e76dc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 18:18:44.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/ymVvVr07S+EuBIg6En9eUJiBwUwerNZ31yDw0NjkuFBjlZzKGOa6j7lrFfLmXc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7437

On Tue, 25 Aug 2026 21:56:04 +0100, Daniel Drake <dan@reactivated.net> wrote:
> test_pgsize_boundary() tests boundary mapping with a hardcoded physical
> address that requires 38 bits of physical address space. However, the
> upcoming page table format for the Broadcom BCM2712 IOMMU only supports
> 37 bits of output address space.
> 
> This causes a test failure as iommu_map() rejects the large address
> with -ERANGE.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
