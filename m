Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED8278172
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227028; cv=fail; b=BMga9o/jmOEWykXcTkgJois3GPAgJXCy0X5fddL93TaXnyzU27hL90SSfeX/KjZ/8sXgWqg74f1lplWyW3N0nXkoJz/W9oMPs3uSqf2wqJidS+V9BcIS2IxIz5w4K8mopm8TeTtGDqQnf2UUdSoeMFx2V0LdAL1saHz4ucWs4AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227028; c=relaxed/simple;
	bh=JsRf5K1KmwAQo4q+nLIkxEIU5nlh5PvOjfkqXZJzrKU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=He8g+FZjrfO55vlnh1FdOGedYlkdtOnqCddPHGXgcitQISYfZSHdUuKsQhvwS0skAntiZbzLoHEH+rH9dy8ni5l0UABxDsEBaZkhv1RBLtXmViGvH12Y06GgTsxOBhxfVNlrVs5OvwYRKS/okT355t2KbgXF5zs9oPkhLjoA83k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=afhoPB2m; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="afhoPB2m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAg8JAThhGDH/a40STsXxxJO8UZCSgqMbZhNhFO8MVQd1F8CTc49UHDzgYMwWYIXPcVlK8Xcl9A5jq6/Zb+CGnKQ8SCppZlfNcsm4p1t1XZa/WQRqusHqTORruTxuyjFltGnzFfYROXu0ABTanasxzEu1rNBPDSqzB7CKk0ajNiMPlJnmm3iwE84yJ10VUbE01x+tE9ZuyCRVIXB2nKBlCDY7qq3F+JJc92zV62m2SRiXdMpROGFZ88lGxcXtNKcOOpfGHYIZxph9LDOTtAYXcXkBV5ozmhtPAlsIZUjGeqr+8NUQYIIawGKbS6m9bdBezS4WlEQ80cd/tfNNa4xbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV+iNoJ4UAk3KJFdAChncAtsrCn22A1YZrwfIFZO7CY=;
 b=CmsLg4AiFTRbEKImYpEreV6Zna/Ibyxghuuqvw2AUK5eGfvp1iWhObS1dwIQTtY8f8aIwvjkc7XIMjVxQu5TUMXaw4CaUnohSKM2KvsQ+LpZU3zJxjMeSTRuekzHGnO7KrUM40Qiguivs+XF73MynLIoIiAGOy7dFk0ndxUgQojECDz1qYj6RLzalGcQdkllH9rCvDSTVKx9RXOQJonQctGl5y0WMCp+Ocsf/xNECE6wVPGjyU3z9djKEITRQ1xFr8gE3xJdXSyfF/4/i2U2BC7HMM0SQS4U+Q0F7DWPsO05K0y2fTQFecwCyNkk+DAnxfLhw0RfCbtBzU/SwOrEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV+iNoJ4UAk3KJFdAChncAtsrCn22A1YZrwfIFZO7CY=;
 b=afhoPB2mG0lrUQE8CxLpiBXnZ1+Z9zTgz1C1FkPFX8xhpVbDa/UWA3j2Ch4HEOZ0deJNBDbufA+R6kZ/5zk4+sxnnVY8GDaUMuTY7QZGjeyM+6OkcGz2E5lVnF4xB+4bqsZu4W59tNWQKsIt5BB2rxAyvPm62fcirxx6cL0dpKG2/hGTp/xqJFSZqZaRDxFV6rE19/ZA89bDxcnQ7RZ0VZOekVRpePCTVxrn+iP6cwK9GcPvxIWwg0UEz7T9Rkr3oS8wRuNxzfx/cOsO0BclpeAVGoHBUAmq4yNg6qycUqRFKtKLV/3qZTpsNxzOuaCjx6IOLIT12MaCATqiP0/uGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 12:50:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 12:50:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 May 2025 21:50:15 +0900
Message-Id: <D9VWA9ZQLY85.277DFA3YTH5R0@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Valentin Obst"
 <kernel@valentinobst.de>, "open list" <linux-kernel@vger.kernel.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Robin Murphy"
 <robin.murphy@arm.com>, <airlied@redhat.com>,
 <rust-for-linux@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, "Petr Tesarik" <petr@tesarici.cz>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Michael Kelley" <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 1/2] rust: add initial scatterlist bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, <dakr@kernel.org>, <lyude@redhat.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
 <D9VQQAY6G20X.RVU8H169KQL2@nvidia.com>
In-Reply-To: <D9VQQAY6G20X.RVU8H169KQL2@nvidia.com>
X-ClientProxiedBy: OS0PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:604:25::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b5a419-399d-4d5b-2e25-08dd92e5e18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW1qZHNiY2lMTGYxVTZnWm1hTlBUVHlzWW5XTm5HUUlhb1hEbDNYTU1GZ3M5?=
 =?utf-8?B?S2s2QjgzVFpHcGxNd3F0UGZqcVVaU0IzaktYUTNZYjVoenRXZW5Fd3RkNEhl?=
 =?utf-8?B?UVkzQmhFSngrOU9LaW9jb1RLSGxpQld0SXd4eU9PaC9DNVppbDdxbWJvWTNM?=
 =?utf-8?B?b3Y1OHBFZ0l2UHlqZ1hpYnVWZENIRUxBaDd6c05WTVJuSllCajVvKzZXV1ZJ?=
 =?utf-8?B?ZTlLekNOWGtaaDZzYnZaTk5xelFJdCsyTzdFaExvZkw4Kzk3c2RRQ3RyMnFT?=
 =?utf-8?B?Tk5kQXNjVXJ2M0NKc3JZMXB6bVpQRTV0RmhwWEpqUTZqY28yMUQ1M2NzYnpi?=
 =?utf-8?B?L1cvWXUvdlNJSG9qemRnNFdkdkhVODNSc1lCSGx4VDdoRThZSDVGOEhnWjdr?=
 =?utf-8?B?bXNqemw1OE1EdHhsQU93NW1zVmhEWG85aXZPOTR4TzhOZ0xCTERiZFpXSVlU?=
 =?utf-8?B?TE1RZkg0MHdCTVFvZFZJdGtXWk1zSjk5cDE3RTRUM1BlSkRnWkJHTFNVcno1?=
 =?utf-8?B?MWJlSlQxa0MzRDJ0U0FGeTdmb05Id2VSVTB2THhKQnRNWDJkdmg0a3I0RkVJ?=
 =?utf-8?B?blFqcFRpd1Evd2MveC9maHhpUUhCSm0vVnY0ZlNFWW1hdEFVL3F0aURXT0ov?=
 =?utf-8?B?RkZLc2JRNmtOZkhyV3YrUVNlV1g0YWljTlI2K0RCZEV4amZtWkNBWGN0eDUx?=
 =?utf-8?B?VkpCanM4aGIwS1Z3ZkxETU1pb2lKRmk3amI3MlZKVFRIZWRQK2JpMk9BbS9x?=
 =?utf-8?B?bkpJVktZQ040ZW1rNmhZeHNNWHMxTUY5b1diTkxzS0ZRc0ZsRmFtSW5WSnVM?=
 =?utf-8?B?T2t4V01XNzE2ekZjZEFxNDZkaHdyMUJLOGVIem5WajFzayt3NUs3aDMxOVlH?=
 =?utf-8?B?Si9oNFB6QnEwTGFBWWxBc2JVYlB1TVVmejE3ZkEySGtudnhMNklueDBNaWtH?=
 =?utf-8?B?Zk91c2FIajNmUGNTek0zMFBnOGlZUml0TkJpaFF0eUdYaHpITXU3cVNGRUc5?=
 =?utf-8?B?T0MzWVBDYjhUSnd5amZiaGZaTHhLQzlXYUZBNlk0anQ1TkpPLzU4UzVWMjNo?=
 =?utf-8?B?ME5zT29LaXBKYVRHWWI3VGNxNDhkajdHa2FDRndXNlVnUVVzU2prZUI0L2dm?=
 =?utf-8?B?Q08wT2g4RWU5SDJFQzRHWm5pOERLSzZUYWtMNFVQellCRHc1K3RzUlJFaGo1?=
 =?utf-8?B?dnc3Q0p3aXpWdkxmQXNoL0x5WUQyWTZ0TlVEek1NY0NiSWI5N0Nwa3Y1ZTA4?=
 =?utf-8?B?d281amFCd3RYaW5tc0g1b3IvUnZIT2hEU2w5TDR2a2hxWkFPTnlIR0NndWZn?=
 =?utf-8?B?TTlqSXM0RktDQVpPd29CTXBmTlBCbkwxTHgvejEvNENqeUtDZ1dIbHNSQWJq?=
 =?utf-8?B?aXpkWmx6K2x5VjdjcHVNd2s3Mm9LeU1nS1llYWxIQ0wrenBpakgrWHdmaVcz?=
 =?utf-8?B?N0ZDejBLNUhHQnFZVk1FTjMzR2JWbTBnUVNlOTkzU3hvZDd4elhKODlRKzB5?=
 =?utf-8?B?T0YzYW1UcE5URDFtVkx6SHRKdWpaS0RsRHYrYnBCektyOGpPVmN2UFRHNkZa?=
 =?utf-8?B?eGRENndtam1OUUJNRGlEZk9IRGNsejJxbDFpTE1UTThOekVSZjBRU2lJWEdK?=
 =?utf-8?B?c0hwK3B3WkYvZE9uUjlDazFiSDVwTEFrcHNPTVBEdXR6ZU9JUkNrZllvZ2Yv?=
 =?utf-8?B?MkRhS3ZSUXZiYUJzMGZNVXRmdmE0MlJHamQ1Wm1VVnYzOEVNYjdmSlhlL3Z4?=
 =?utf-8?B?aFRWZTBTUTh0eS9DcVVTRU5GYnM1L0MvYjlSZEo3MGtVc2NjUzRoMUpZSmp3?=
 =?utf-8?B?WVYrTFFmdjcxcS9JVUZJNjB4eHBvVDJQT2pJaUo4L0FaYmtSTjdoTHE4ZnNL?=
 =?utf-8?B?bnc0M1dhQmdKMmdiTWVXRG9SNStNVkFSNCtMMXpzb25tVUdEa0ZoZGlMeG5F?=
 =?utf-8?Q?8CA4NnK5oRk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzdrZXhkT3J4aFNpZWp2L0ROTGgvNzRRSmpaTG1CT1ZhZUM1NWhxc0ZqcFJE?=
 =?utf-8?B?bVBEYm5KaU1VUWxZTFBGSnVDK2J2TmhCcnVuVEswc1VORFAyWnZXbGw1ZlJJ?=
 =?utf-8?B?cDh5QUlsMkd0cW90MWpPbE4xbE9hMzVKTnZZT0RNdGZVVk05OTU3WVdjSHlq?=
 =?utf-8?B?amh0VjFtb2l5R0Jsa1RTb0VjaTBRS0F3T2t5OExpYWJsdTJ3SzNjMlRPRXJz?=
 =?utf-8?B?RzhHRGxNdzVLVk5NOUIrTGNFNHFBclo4TklwbUpYMzduL1c5TW9BQWxDSDly?=
 =?utf-8?B?SzYrWjVKamFjbm92VFhWZ2dSNG9oVjlwWmdRbWdoK0sweDZ0b1BiSi9qSThZ?=
 =?utf-8?B?UDM3RURaMXN6dDEyU0txbFZTV0RGd0JWNmZZK05mbWNaT2FJQ21zZThwOXJm?=
 =?utf-8?B?V3g5ZmI4K2trdFRSSUpLTSswUC80ZDRUN0h5TXNMdGxhWjF5V1Q0K1BFZXpF?=
 =?utf-8?B?OWNhSWFNdGJCbXlrdVc4NXF0NWFFa05OeVVHSU50TmM3emVoTzdCaDZXdG9s?=
 =?utf-8?B?enN0d2VCZFQxbmhid2xqdVFxVis0cEo1YjFWTnUvZ0dDR1NzR1pYL2YzRVJQ?=
 =?utf-8?B?di9nalU1VUQvRml4cHlSQVltaUtMZG94c0J6R09JNHdZczlCUW1YQXg1QWxG?=
 =?utf-8?B?V3ExQmFENHk0STlkV2s4blhXa1g2V29MemtRRDRyMTZqT0QvNnRiaFNUT0RT?=
 =?utf-8?B?dlN5WFNSbjFUWSsvN2QvNnZROE5VQzFhK2RSUnV6VWZDUi9BdnZ0UHRiS2cz?=
 =?utf-8?B?ZzZkOFBpMmx5TFNJandCcjN0dUNvYS9yL3VjMjZQNE8zSzh3eTFTWHlOc1ND?=
 =?utf-8?B?VUJiamF4S2wyeFM4N1craWdCYmZmRTUvSDFEOHpNejgrdzVvc1ZlRWJ5Nm5m?=
 =?utf-8?B?UXo2Ly9ISmkvd1VhdjA1a0VzRExSMFV5aWRZcHFLUmYzMzYwRUpwc1V6Umo0?=
 =?utf-8?B?UGFqbG4wckMvK1A3SFpSakp3WWY2NFRTQTYxQ3NjYTZVcW1Ka2tteTBxSUNl?=
 =?utf-8?B?c0pxRHoxVWdrZ1dDZUNBZXU4Vjgxc3pFZ2Z6TDE5K0x0ZDR6OVJqV0xudHdx?=
 =?utf-8?B?TENCeTlFUjFkRFhnSEVVR08vQnlDQ1BKSWkyOXlTKzRkMGYreWJ1bXpId0Rn?=
 =?utf-8?B?OXVocmpkeXQ1WEJoWE1obkpZUlN0akJPNHpndnNUKzdqSENOTFZuVGg2Q3Br?=
 =?utf-8?B?RXZBWHdjczJ3WmNuM2tFUkRseVR5M3M3WC92WFVDTWZLMW1ML2pvYVhRU1dH?=
 =?utf-8?B?WkxTL20vL3luNmZ6bzZHMWpJYVBFaStXbTRReFAxZlQxZnIyVndPSGJNeXhQ?=
 =?utf-8?B?ZU1wYVlKamhva3FzaWFIeEwrU0dzeEs4THJtRkRWQWdrQlB0dXNibW1zakFn?=
 =?utf-8?B?MTlSMDZYbUZsMmxmNEc4S3l1aUZORFREUWtLeXdIZkpjcG55Y1hVYWxBZHFp?=
 =?utf-8?B?MThidE9KdkVTUDFvcVZkUzF1NzJqTldMTkRFOTNIcFE2SmM4NjNJK0NNdTBP?=
 =?utf-8?B?YmVUOTh1RHhSQVhhSVhwZERNZHdLR3A1eEI1aWZyUzkyaEszQ003Q1NTZnNr?=
 =?utf-8?B?NDgzc2Q4RTk2aStvMjFUaGVndUJDeE9pUVEzNmwyM2FQeFBveTZDMG5yRE1m?=
 =?utf-8?B?TDY5d0d2Qlp5NVBFUGJPUzRaYzVjZDFhR0EvbUxCNWFtdk0zbDZjZ3duZlhR?=
 =?utf-8?B?Z3VWMlZMZDlWcFJUUkRPRHlkTGtCQVNCcGZSSnJOMTNyb2RtazB2L2hwSXFw?=
 =?utf-8?B?T1duWllQUldndHlLSEZDOEZ1WitCUENIRkFPKzJaY3BueXBHV0p0YmhKZldr?=
 =?utf-8?B?S01sbnFGK2hpYkUvRVlmbTFncE1iNWdScVVZcmVrS01VNjByUDA2OVRtc3Z3?=
 =?utf-8?B?bWFlL095SHlHY0VWcm52REw0bzBOUWtzME13d1h6L05ZTUZsSGJNckJGR3ZO?=
 =?utf-8?B?MDkzWU91bHJ1RXM4RGkrd0UzbjY3TnYraTdPMXZMWXZvamw1ekxneDNLTzdZ?=
 =?utf-8?B?T1owMUNQaFZKYnRqUWUvVUNVdU1pbnB5bzZEdFl0bmJWVjQ5TUhrMWFIM2ww?=
 =?utf-8?B?R0VOa2JFTm0vSVVNSTg3bmFVNkx1WjdvaWpGWGVFR3ZDN3RwS3NON1VFWlJM?=
 =?utf-8?B?TFZ5ZUdPUk1aZDlVQVhxcDA3RTN4QWdJZDMrMjhhS0ZPY3g0djhTRGJ0K0gw?=
 =?utf-8?Q?lXzcjSWN2yttOa0etwTPPEDdBgwRa4CEyNLGTMnVM/r0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b5a419-399d-4d5b-2e25-08dd92e5e18a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 12:50:19.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fn8YgjS9pdoaxmQFiuNEslns5WSrpD6bJRCczyH+rGgZ1xGcnuOdPp2l91wsDsWjTMLQ4bAHCh7SZOsvuYAhCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921

On Wed May 14, 2025 at 5:29 PM JST, Alexandre Courbot wrote:
>> +/// The base interface for a scatter-gather table of DMA address spans.
>> +///
>> +/// This structure represents the Rust abstraction for a C `struct sg_t=
able`. This implementation
>> +/// abstracts the usage of an already existing C `struct sg_table` with=
in Rust code that we get
>> +/// passed from the C side.
>> +///
>> +/// # Invariants
>> +///
>> +/// The `sg_table` pointer is valid for the lifetime of an SGTable inst=
ance.
>> +#[repr(transparent)]
>> +pub struct SGTable(Opaque<bindings::sg_table>);
>> +
>> +impl SGTable {
>> +    /// Convert a raw `struct sg_table *` to a `&'a SGTable`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that the `struct sg_table` pointed to by `p=
tr` is initialized and valid for
>> +    /// the lifetime of the returned reference.
>> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::sg_table) -> &'a Self =
{
>> +        // SAFETY: Guaranteed by the safety requirements of the functio=
n.
>> +        unsafe { &*ptr.cast() }
>> +    }
>> +
>> +    /// Obtain the raw `struct sg_table *`.
>> +    pub fn as_raw(&self) -> *mut bindings::sg_table {
>> +        self.0.get()
>> +    }
>> +
>> +    /// Returns a mutable iterator over the scather-gather table.
>> +    pub fn iter_mut(&mut self) -> SGTableIterMut<'_> {
>> +        SGTableIterMut {
>> +            // SAFETY: dereferenced pointer is valid due to the type in=
variants on `SGTable`.
>> +            pos: Some(unsafe { SGEntry::as_mut((*self.0.get()).sgl) }),
>> +        }
>> +    }
>> +
>> +    /// Returns an iterator over the scather-gather table.
>> +    pub fn iter(&self) -> SGTableIter<'_> {
>> +        SGTableIter {
>> +            // SAFETY: dereferenced pointer is valid due to the type in=
variants on `SGTable`.
>> +            pos: Some(unsafe { SGEntry::as_ref((*self.0.get()).sgl) }),
>> +        }
>> +    }
>
> I think Jason mentioned this already, but you should really have two
> iterators, one for the CPU side and one for the device side. The two
> lists are not even guaranteed to be the same size IIUC, so having both
> lists in the same iterator is a receipe for confusion and bugs.
>
> I have an (absolutely awful) implementation of that if you want to take
> a look:
>
> https://github.com/Gnurou/linux/blob/nova-gsp/drivers/gpu/nova-core/firmw=
are/radix3.rs#L200
>
> It's probably wrong in many places, and I just wrote it as a temporary
> alternative until this series lands, but please steal any idea that you
> think is reusable.
>
> There is also the fact that SG tables are not always necessarily mapped
> on the device side, so we would have to handle that as well, e.g.
> through a typestate or maybe by just returning a dedicated error in that
> case.

Gave this some more thought, and basically it appears this is a
two-parts problem:

1) Iterating over an already-existing sg_table (which might have been
   created by your `as_ref` function, although as Daniel suggested it
   needs a better name),
2) Building a sg_table.

The C API for both is a bit quirky, but 1) looks the most pressing to
address and should let us jump to 2) with a decent base.

Since an sg_table can exist in two states (mapped or unmapped), I think
it is a good candidate for the typestate pattern, i.e. `SgTable` can be
either `SgTable<Unmapped>` or `SgTable<Mapped>`, the state allowing us
to limit the availability of some methods. For instance, an iterator
over the DMA addresses only makes sense in the `Mapped` state.

A `SgTable<Unmapped>` can turn into a `SgTable<Mapped>` through its
`map(self, device: &Device)` method (and vice-versa via an `unmap`
method for `SgTable<Mapped>`. This has the benefit of not binding the
`SgTable` to a device until we need to map it. `SgTable<Unmapped>` could
also implement `Clone` for convenience, but not `SgTable<Mapped>`.

Then there are the iterators. All SgTables can iterate over the CPU
addresses, but only `SgTable<Mapped>` provides a DMA addresses iterator.
The items for each iterator would be their own type, containing only the
information needed (or references to the appropriate fields of the
`struct scatterlist`).

Mapped tables should be immutable, so a mutable iterator to CPU
addresses would only be provided in the `Unmapped` state - if we want
to allow mutability at all.

Because the tricky part of building or modifying a SG table is
preventing it from reaching an invalid state. I don't have a good idea
yet of how this should be done, and there are many different ways to
build a SG table - one or several builder types can be involved here,
that output the `SgTable` in their final stage. Probably people more
acquainted with the scatterlist API have ideas.
