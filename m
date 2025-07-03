Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6B2367DE
	for <iommu@lists.linux.dev>; Thu,  3 Jul 2025 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751526240; cv=fail; b=XCdECTYv5+IBJ7232tEI3xkrqhFjUXNZoHRFgbxa6hrcYXdo6Pw9kngAvJKD80ffCEB+y8IDYgT4mheWD9uSHZ9MKLUsW3LpWJ7Wp9KuC9PMjTkQ2z1oWcO2THSS7Y69twOxrEIEdiOXyBBK6/kjbSPXXEw3HZkbkqcEJCHk0Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751526240; c=relaxed/simple;
	bh=crsA64smjqOV6IjwfxeoLnizMdwmTOJ+xYLOEUPiAJM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=qoBPUCF3AQyEpA6Ly6DJvI1CHyvQUf6WfF1oC364AjjYDAIdf2BhgRFB2OKEjhKa6XMgxW6SSqMUblBwqzniHrl4LFajREQF8LSf6G8SqNQEeEpta6C6kthDOJygsu/GcTuYSyJOdQbCOdQrnQZa/tPW4bzXavWQISfNu0dvMnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ug1VtZAV; arc=fail smtp.client-ip=40.107.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ug1VtZAV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyKNJrDt/GnHGB6ONpqHjRPE01avXxwbHPVDc5XtnarHOaj/bCr8Iw+xfLAmhR8UzpiusW24rWUYBB9wB2CoGUe++w+57Kv+DVzJTBvioQ/XChdd5cm3c8qrVpWoetMMh+aHLdeNlbZUBW0suL3vmN31PV2G+nOePmjuEtqFScYu5TBZkaLFA2WU2sUnepRWd7JJemYd6TVfMPVPi8+MDIuW4HYDShBTDDW3e55OQ6E1YpcSy1lvdXvPu0/iAmnYsLoZpPHSMtKv93KoCVMUP+dqyK1DcN18sahdxTR+q1CNGiUmsDdzxWRr/tDPGMgEWEHF+WQCqqIBpnPh2DVbeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crsA64smjqOV6IjwfxeoLnizMdwmTOJ+xYLOEUPiAJM=;
 b=eu2yhch7LDFb93RA11VdDEzWtXbMRuRVmBYcVPmRoUXO3aT4+1WABgqk/+mN1tHX9S3oKbcBYlUsklmPgKP+wnDH2XtUCTBP9U4SAVZ0GjUX97YkKySvGZHqKCkmpEWUUameMT/h4j9tGN+Ph4e4NcCbboCrZYlxKAygfbw8w3lNx5tPSj/lQ0fLh5Sx2XIkItWtppz0o7EgNdN1toQ/5EiDdNuYDtlag7VbXIzstR7ocJH7nDr30lUeV6Lh9Y4RlvhB5x6Q4w7aHuBcShuY10kpwBNb4fXM5DQh958eyMeRdjA6tNa7lJwtoWoJIJMoX60pzmI/5MFiylqc33Idqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crsA64smjqOV6IjwfxeoLnizMdwmTOJ+xYLOEUPiAJM=;
 b=Ug1VtZAVWBxnJgTw7a8S5ut6bU5kZyyHubhW5x/HTkNFVwt44HH3NK6fG+t8veX8RxaXbHdFSj1tlKe1QoU/lQOf2ijSsc+5u7B4zhVtsRk+UoL0p7S7I+QQL3ThP+3XSt0xz0H/aCE4Z6sQmWfrd+SGWNk5GsU1rVrQ2ErLzP2NiS/jPn8xILV4hSSCEUFH/i8eIR6jI199IDz/wtIMCXY7vi8Wl7eP4VuyISdPF+cGbw7/RXERnkMfUsTe7pFl6AzeEfm2QZn+u68NYu/3l/1XnAYpeaZJzYMz7jZeL/sCtD50icwBJTTqpa8Ow+7+9F6kubi4SweGzsCWvQFKYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 07:03:56 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 07:03:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Jul 2025 16:03:51 +0900
Message-Id: <DB288AEQSBTC.63WK79TB77TW@nvidia.com>
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
Subject: Re: [PATCH v2 1/2] rust: add initial scatterlist bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250626203247.816273-1-abdiel.janulgue@gmail.com>
 <20250626203247.816273-2-abdiel.janulgue@gmail.com>
 <DAZQ9OGC1648.2WWABTO7A7UU6@nvidia.com>
 <DAZVUN9N4GBT.38B6BX4CN516F@nvidia.com>
 <DB17XMDHU5M7.2M2KN9A8TJQOB@nvidia.com>
In-Reply-To: <DB17XMDHU5M7.2M2KN9A8TJQOB@nvidia.com>
X-ClientProxiedBy: TYCP286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b15bff6-de64-4aee-e759-08ddb9ffc594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUFFTzRMcm1vZmRxcVZQUFNTQWdBUVA5RTVuU3ZzTDB0QVd6YUxucWllZmgv?=
 =?utf-8?B?TlI0QTNjOE5maVBQcmRjSG5ZdFZJZC80eG9RRDZObGlQM3dYK2FVKzk2RWhk?=
 =?utf-8?B?Wk5nelhDU1Q0K0t2dVJUcHpPdGVBOHkvaTdhaGlYSlNFUVBZa3NHeTB6ZUlK?=
 =?utf-8?B?bTZic0Y2TGkvakpKaUw1TnV2N1krVDRlNElrVE1jZTQzeDR4aWpmWU9md1Bl?=
 =?utf-8?B?NjZFVkMzYzNqSTFMQis5NVpxekdMSWlkK25Pa0lPaTlEZnYwSFVwZHpIVnNM?=
 =?utf-8?B?WHNSczIzeFBDbFg2T2JHeEltZjVtZ1pmMk9aQzBCSFNqaHVEUnNHb3ZQK3Ir?=
 =?utf-8?B?Z2JZV0xDVjM1RWJKbFZWK25xZENDMEI4Q1Z2NkYrTkZlQnJtRVoxWGtZSHRX?=
 =?utf-8?B?ZklWSXZ3K0ZMZ2VlaU9YSm9oQVpsVWJpRTNVdlNlcGVTR1NhRVJwdWx6ZWJV?=
 =?utf-8?B?akYrNGdiMVRMMDFNK1dpMmZXTGVMZGJCSFZ0VjAvMzhFTFhJWXlkVllyczgv?=
 =?utf-8?B?NG9wbHlObXdoZjhqRktYWjlFVkJQbkRzdElFNmZSanAzOVJIS0dSaWNIaEg5?=
 =?utf-8?B?cU1QWE0vS2hyeDJKZGhjdk5ySXEzSXZiNHJVeXlwYkFYMFI3WUY1eG9NZWIy?=
 =?utf-8?B?UTV2emVsRE84TnpFUGtXSXJoSEFRdTIycDl5WUhyNTVXU0lkaTQ1SHVXVWMz?=
 =?utf-8?B?NFVXUjdKZTNnUzYvQVRwQTl6WlA5elBibExQWk1DVE1KS293K3llaDNVRnBt?=
 =?utf-8?B?UEN5dGdyazVINGJMV0RyR3JjWHRDSTc5YXM3dlRHdjRIcVQ3bUJyRFRZUkRJ?=
 =?utf-8?B?L3FKd2toNWFXSFRscHdqVlBUK20ybzU5NndzN1p1WHNqY0pQWXFwSS8wZGN4?=
 =?utf-8?B?dDEyVjlVYStadFlQdkU0RzhXRnNiZDc1bEpsZGVCQjhWUjA5ZjhNNVlxNDFQ?=
 =?utf-8?B?aEZkdXdUbW1sUkc4aWhBQlhhZnUvTEFZVzJ6ZEhzNTl6ZnhRWSthV0hVZkRz?=
 =?utf-8?B?MlZqZlo3SW4zZmNvbmU2L21BWUk5TEVkMDhMcHZlZEp0SWxHL3AvSnR5MnJD?=
 =?utf-8?B?RUJ1a0x2TWNZT0d5VngzVlk2c2VUbkZ6TnE4aGxhWm4rMytkVE1pcmJzQjBJ?=
 =?utf-8?B?QmFKeGxDUjVybW1aWkludzhWN1ZzVjk4Yk5zZ1JVeWp1a1VoQm5HbEFMUGU3?=
 =?utf-8?B?bXlYbWw1NWVYcDZvUklMUlJlK3o1OHFqSGhmRlk1M0RVd04zYkNnaW9Jc0pF?=
 =?utf-8?B?SFJWU0ZLNFA5d2FTZjNRQis0K29XV0tRQ1RXR3FZazRQTFBiYWQ5WXVGQTFh?=
 =?utf-8?B?SElMVmF2S21ERmFzUmRObm1iREhMVnQyYjNQd3RkQjUyTDB0S2srK254NTZV?=
 =?utf-8?B?T2lJTkV3TGpoY25lQWdpUVUrRHJzeC82eThDeHRFUy94YUdEeDI0dzZ5M1JP?=
 =?utf-8?B?cmpxUFl1V2ppUG5RZHM1blhZaFR0MFovTGcvOG9YbVhNTmh3ZVpSckgyVlJp?=
 =?utf-8?B?bzRCWnlGZ1FMOVN5RW5mQUx2UEFLbDJ5bjM1b0h3NmRXQUJMNTVlNTRRb1Y5?=
 =?utf-8?B?TlRUNVFGRGZMdTVuV0J2WForRTZQMkc3ZUVhbDRqQ0IrdzhXL2tDNnMxQTJu?=
 =?utf-8?B?Mmh4T3dIVHpubjM2Y2RmRUNMVHV2T3duKzlPTS8yYVREYnZmSGZhUDJsNzhG?=
 =?utf-8?B?MnBDdkQ0ZlVwMmR2Q1NVeTZ2bE5MbGdXNjZ1YW5LQjlUWWxuSmUzTVdLWTMz?=
 =?utf-8?B?b0VNNzdWK3FNL2pTclpIMXJXS05KZUtrSXdTT3FQUjBrYm5kN1l6OWJlUUF2?=
 =?utf-8?B?TnV4dm1ycmtPcWZCVHBCT1R3L0orMlZxc1FZMXMzOUVSRVNZMG4yZU52cHBj?=
 =?utf-8?B?RmlHSDZ6MG1lck0rQ3U5RnlPcE5zMGoyc1Q2elppNjQ3M0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2dGeDY4ZEUwSVlXTWh2TXVMV0dObDVDcDFYT3RpUVU1SytuTmViOUpsYXZw?=
 =?utf-8?B?QzlHSzd6b1lZTVNVRlpMUXpZZVBUUTRhM2tlNC9IZVRVczdyNzJVWEM2M0FF?=
 =?utf-8?B?MDFveTE1YWl5VzA2WTUzZVVydGpqOFJHOFlGNkEyWkpLc0h6UGFKK29CYVBO?=
 =?utf-8?B?U0Y0Wkc4VUc4Zlp4Sjg2eXBHdWYrZXQzMzFMbkFFUjhVRllsaVN4cUtsM1NH?=
 =?utf-8?B?aGpCMjlWU1duZ2x0UmRLZFFVWnYrM1ZJTStEVzVZWEQ5MVpmQkNYZERpU2Qv?=
 =?utf-8?B?S25zQmlUMGF4ZkdZUForMzZucmNEOXpPTnV4MDlDaThaWGp0SEdRbmluT2lR?=
 =?utf-8?B?Y1BpY3EyWDRDRHQwdS95QWVYcHBXczF5SGpOWVZXL0l6R0pSNDBsOHVWWHl1?=
 =?utf-8?B?NFRPU2YyRCtGSmQ4KzhSQ3NYZHZUYXlCd1NoWS80b3UzUEUrcklKL1lia3Rh?=
 =?utf-8?B?RklHWUZDZUhkVnZ6aTdkN05weTBKaUFRaXZvdUk3RVl4SlFEeHVDeVh5MThW?=
 =?utf-8?B?ZnVUMDJtei9LQ2F5RDJ0OC92dXIzV1dORnFGM0VJRHVDYklGUHJPdUlUQm9U?=
 =?utf-8?B?Nysyb2Yva3JUWXUrako3Sm5CNUV1SU1mSTJ5Q09xUVVJTzFiSXB2SmtiRkF1?=
 =?utf-8?B?NXRKZmZUekQ2djJBWlRoc2pQeTFNenZXMzBHZDBVTmhyL1dHcmxtWmtiUXMx?=
 =?utf-8?B?TTZYS050ZFk5dTVYSGFaN1pDVEdzYXc0MjVwclcvUGxOamNVOEI1STFpK1Vv?=
 =?utf-8?B?aFNPYjNpTFBzeTdtOXYyNG16VlU4blJLWDEwdWtneFQvTmo3UEI2bTkySC9X?=
 =?utf-8?B?UDMzb0JJSXlLa2dnQXdEWFEyU2hGMFBaazBJVCs1TjBsUXhjem1qekJjbkVU?=
 =?utf-8?B?QzdmOFpXdjZldjE1WmtaaW90aEVKUjBwR2JISXZHTEU4RmNGcUNTSVBMWjlE?=
 =?utf-8?B?SjFrM243eUFtdERRenNoenU2VUZhZkdHMnlRKzdnQzd4UmtLUTJMb0ZTLzZQ?=
 =?utf-8?B?K3lyclloSDlldmx0VXY2NU5TSVQwczNQQ01yQW1Ybm96czZkaXpBS2dXT2tP?=
 =?utf-8?B?aVA0SDVmZXB1ckR3aHVweXlGSTlwTzV2MEJRYlU5S3hyV0I3dURack5wa21W?=
 =?utf-8?B?aDdETVN3SHZzYWU0VnRMSklxSUZUbGtZczAzUTljWnpNbTBuZW1yd3d0K2tF?=
 =?utf-8?B?YzlFdVNxa3E4dGMxdjlYYk1NNlRDZGRoNWNES2hxc09ZWDBzdndKUHRkRDlr?=
 =?utf-8?B?TGZIWlFTczBaQnhjUHFEL1JuWVBJTkhWbS9aa1JIejYydjB6THZqeGxGeG41?=
 =?utf-8?B?a3loUVowUFpkeGNIbU9yb3hWYXE4R3pJS3ZNQ3FtMUUvNGVVS0VrM3JablRN?=
 =?utf-8?B?SUdlSlk1UzUvM0lENENNK0tmRVdoemJmNXBQSjVTSnlycWJjRzlQemtyZVdq?=
 =?utf-8?B?dU9tS284WTZOYTBySFhPOGtseSs4VjlIMkpWV3R6N0NSUHR3L0RTSnhkSDRi?=
 =?utf-8?B?bUFVd3hoT1dyNDhYODNLVGtFTVhnK084WXRkZ0U3amVCNmxPUTF3eHJvN2ZU?=
 =?utf-8?B?czEyYkZXVXRTNmUxSU96WWFqN25CWHp3WG5QM0ZFTDlWa0ZKQitPWVZmZXh4?=
 =?utf-8?B?TUUvemtaa3ZjRVdOeUpsWjdvbHF4Mm05RDRuc25JREZXVkEyMDBybGRTQU1m?=
 =?utf-8?B?T3V2NEduOWdWVEVXNkxKcnJwQzhKR0VnVWJsTTMzVHpMeURZOXJnVHo4NUVP?=
 =?utf-8?B?bThBaEpkc1pYcm8rSERHN3A2UmFnbWV6WEhpN0h3eFVScmwzVFpIZ0VnWFhi?=
 =?utf-8?B?Y1hnSU95VENhZGFQekFkYnQ3bGxSUlE1RzhPMFhBREZxYVVrYXFUU3BpWWd6?=
 =?utf-8?B?dTZETExmNTRZZjZkQ01SK3NYQ1AwZnBiZ2RwZ2xkWGJsZEo4ZXVFbmVOUE1F?=
 =?utf-8?B?dlpCUDdWMzdZNXdYczhoOXNkcG9tcGNSWDlrdnppa2NqWVh2WU1mejJyODlz?=
 =?utf-8?B?MHlRZDdnYTRsemJuRGdBeWhFMjFqR09CTC80V2JOZFhHUXFkbm95a3Q1NVpV?=
 =?utf-8?B?N3pPT1lBVDBRVE5xekQ0bERLT2crYkFDamFERXZ6SWtlWHlaQ3BlL3c4bHhi?=
 =?utf-8?B?YlFscjkwUDZBYzA3MUhKMi9ucHZrSDRnZHJQdGZjMnVnbWQ5b1lwZ3RTVDdO?=
 =?utf-8?Q?yF+GWWnAemU1oOJYfB+tu3EGpB61DZsW1BlZ4gi49J+t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b15bff6-de64-4aee-e759-08ddb9ffc594
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 07:03:56.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiudfPHDE1x51R5A0/nFjaAZrsn7Q1tBSY940PXvWq38ODXuVsMBulldeCtyDySyz+XgmN8wRGB/kK2hCwSDOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922

On Wed Jul 2, 2025 at 11:37 AM JST, Alexandre Courbot wrote:
> Thoughts? If Abdiel is comfortable with this I can submit a v3 with this =
design
> for review (putting myself as co-developer), on which Abdiel could then k=
eep
> iterating, as I suspect this would be easier to understand than this long=
 email
> :).

Figured I could just as well share the code with you and save both of us
some time. ^_^;

The top commit of this branch contains the proposal discussed:

https://github.com/Gnurou/linux/tree/scatterlists

The sample code has been updated to add dummy examples for the 3
use-cases discussed (reference to an existing `sg_table`, refcounted
reference, and owned data).

There are still things missing, including the typestate on `SGEntry`, as
it wasn't necessary to demonstrate the basic idea.

Note also that if we decide to only support DMA-mapped SG-entries, we
can remove a bunch of code, including the one that maps a `SGTable` if
the backing type implements `BorrowMut`.

For your consideration. :) Please feel free to take and use anything you
find useful.
