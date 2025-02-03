Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DF1B6CFB
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610176; cv=fail; b=dYbxBLXnNC8meFKJWlC+hlQoLbtqldIwDlKTw1zJSWgZ+WZZJWIuwDLoG0xtchMeYRxo+uHpRBygKb0buTStEqV+VO+is9eVHaowyRwzRnXLRZaodR6d+oW3Bnc18NCWu1vR9goXl1CK6bONmYAu5slhwE7ymvSzJNOnefWSPVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610176; c=relaxed/simple;
	bh=Dtx/3/NNkEgVqf70BzGWiAq3zt9N9ZItph3Q4CzZpNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B4LfESPojJXvIIuH5QPqj6pvNYVEsz3xYcOr3LbuatE0y394JMo1/1r28HG1pefHzOlsbENNKDwCxSS7B6Uv72y5y4RGqGDDqPk/KgUN91Lx1qA9HdM9974IlebWjzNbY/RlY1ktxXK57WyefND+cNjPgFg3taIsZzbuZxShBDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AG2cVsL8; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AG2cVsL8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFqLj3SfFHGLY5CzfZcVHvJyh7Gjy1msizOyeX/TKqmMhWFDe8MmTcYYJwq4MRum3tgBsy+1zA3raj9WDMLxlnByq7WMt/gHd/l074Iqwy92hbDvfCk9uNAkh12fH0xmush5Qsu4/ZNaffRE2hzpdL8M/4KXJXaV2zD8n0kxvN1WFNSlNQZLx7SP3Uq/O+0PzxYQ4z8Ml0mmbFmzl9LLkdzDADlH1FZMTOqq9sJDPvoyxQri3Cker8N4mUwGMO3rgQRSK/jtCcjS6AiOOI4vIsykC5STVULvGSwnBsnzH3LvpjN2XPdTYoi69oUcR8M17TGlBcFGAyshFRPfFS2izg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7Exy2iQivdzfsqBXFokKrwhatWXEY61EJCBbekda74=;
 b=Ob+q1Wr+dyjbEfJaJ36/bX9Y/GAA9OnhpvYwEH6Wh8jn9npiBj+VphKwaWH1JyuInBAU+BHZzYYDmSwJFu9mQBC2uTaJnsXkPrVyAhw9L4WS2fUd2ngUqLK0LY71UtPYM8cEHvJKubHoYbA1DhyvjkkKqFUDLqqxA3QbWXaQIp9LDqItqzdGzTQLLuBj2/xZQoRfho5M2ELfos7j0cw26eUJjxhQAdYKITGXVJ8mcLx6dho4lzRGlyQ5fLXIbBNAmzJv+R9an1eHAaoJ8xb+l0TNl+qNO29mOpUp8uk8+iPbAoNuVd1DTYxFh5Wu0e23Hmi7l34btI5ZmXV9oMSkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7Exy2iQivdzfsqBXFokKrwhatWXEY61EJCBbekda74=;
 b=AG2cVsL8Nue9lCGFdHgjV3N7UUx9dFE658vozvjldNz4fSt9d16iV4BLab3axA3WwAgdwzBWhtLLEy47z77a2m3y2SsbZfhsZsoPT6uA2EdnJ2H8A7hZlefQtL1vrf7eVG6XxlDh5XyPXe0waM7sggMfoZuv4P6Q87ggYNghgZFQgLtQYT96UlZU1zjhVYL1LBv8dziMI/ljZo1K3l1OGIXbCQwD562LKxuBbNUK1bCJntZnpsSWnTjyxa4sPgKqxDC3GPRAjgkiWXbZufh4nYedjNk+2XcGbOzIxM+Y28unOQlkr6aYSmhhkPES2tNzVB+SqWqSQUi3AoHgmJ2Vyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 19:16:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 19:16:11 +0000
Date: Mon, 3 Feb 2025 15:16:08 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Hector Martin <marcan@marcan.st>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <20250203191608.GX5556@nvidia.com>
References: <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com>
 <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
X-ClientProxiedBy: BN9PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:408:f5::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYYPR12MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a76e4c1-71f2-415f-e9d3-08dd44873829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ccBYZxeoUUlVEKYuFmzD7vIwHlCoVyhiqLlW0YFbK9bVZkmoGObEbG6Bk5GY?=
 =?us-ascii?Q?IGzm40Fi1OfTGZt5i2sewt6KFo0efgqXrcAjEsjeI40pglrUQPHCT0oxd+np?=
 =?us-ascii?Q?MqrQnYX3ZvllBZMbdFWF5HVHbluJN7gdDW4109xCDaOaAYw29MpynH473wEC?=
 =?us-ascii?Q?uMFIzleyTNdRt8Q3zQvvraV8rxsagUbHRPXWHHJhFp4LfCSPTgnMkYCWpVJt?=
 =?us-ascii?Q?mhMuD6++quRYKLOM1pqTz95FujrNJ929pFMhMWW3RHaKdZ8/fOxZXAWNS1Lk?=
 =?us-ascii?Q?vn+iwicuT3XuIJBYxqz0bpq33V9+yydUIOs/UU4m8if71O+hg4AClZKiwT20?=
 =?us-ascii?Q?zHALXWDpwLRnRU+1vAuViGD9n8OsVUDKjJVEkCLiDcpQ6HZxI8Mq0aOQG2M5?=
 =?us-ascii?Q?fV2oOZBdo6DhygDbyIJGUrgHvppK9Pctp9gDwvWAmdav2FsNxbROopXGZB1E?=
 =?us-ascii?Q?s8iPQeeWADIS2ntLe7LIVVCfIMc0/PtSVmm8oPz5xgZOslX2tsyhXEbUAE0e?=
 =?us-ascii?Q?OjY4FNyMQOs9tPZovTZqs+FRv6EWSJqpL82W0gOR6EQ2+gLxs+9Xrqxisr3B?=
 =?us-ascii?Q?M0y/LPfQj9O1ib4zEtfev//XqQs6fh9YuMFJU46h+/mhpN7PnoSFB6KBpPxi?=
 =?us-ascii?Q?3G3gtwODG1g0MkWLkfWbX6eNoCbV71lIJoXygG9m6+iVTntaHHUOzish/t5e?=
 =?us-ascii?Q?TYBVXWQ/p0nHJGU+rmrGt/2nmBG7kbKi8e/TKJZUvQW6vBxutGMRCb2LsgDx?=
 =?us-ascii?Q?GBSfMBVterYGrJyYojegarUdSvg2l9Ra3fqpOH9YXGwmcmcIy/SHNi5nbXT9?=
 =?us-ascii?Q?vuOSeuf4ZvK/BTyrbpx9EHLrwhdWUc+CXcOBO1qnBquv9UEjPm0kF6pTobkT?=
 =?us-ascii?Q?KHCzcutl60QNDgLp2qUMyAZD2pOdtN1I3qngWhLA4gQAejYiZK+uHtQBNBdl?=
 =?us-ascii?Q?rfMEoNHCdlpOwUhx12zcQsJe5iXNfOWWXoLgt86Nu4uUD0VnO2eoSRVcYJoY?=
 =?us-ascii?Q?kmuaezShrCqencqhNVQ+lWnh2MHnoaNHB/JNlRFPdbbXzxBFSvAxtik0VE5D?=
 =?us-ascii?Q?ULzHdEUGY5NmES8S+hUW6xX7+J2kMyuUoFYsWqSSVgzLQT9FOoRGWVo7xatZ?=
 =?us-ascii?Q?IEUWs0Vk+elJbvCn+AC/aRQ+xr3/AjXz7OO1AhqsR2aBVZtcN6yrwJM71XbE?=
 =?us-ascii?Q?AJe5lNn/qLpRaE5X68x/qxNoRwJiN+Nlu/KAXZsAQUmx71Dhgq7T2DZSGoep?=
 =?us-ascii?Q?ZbLU0Hw7Em4YiYw1dlHczp1d89owp700BFIoqOwUx3f2e8G+IWT+1dxJ44+z?=
 =?us-ascii?Q?cWGi6Hrrby5VasZlqYpPcSuIIQUhE9DEz9B39c6Sg8puI+P61xtye0CZbWue?=
 =?us-ascii?Q?Ix+OGSnhwrxsTgUB23/gt1PNQNeG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xwwLA5IcKYnIztIGgN3A/axLyiPPOl4Hhz5ff+pKWV4saw1/WbzK6erW+Yl6?=
 =?us-ascii?Q?CPquBDlpUHw0Uq9M/crlji0kiNL9f8mTQYEHrF373sGlSMMC03pGnKs65aC/?=
 =?us-ascii?Q?7s56wlOiiJHOvBA4cogNjC8Lfb0xe2BDzc/5FngthxKpFL+gfT566FzK57B/?=
 =?us-ascii?Q?s9Hd6avWXDSWxooVMHeA9fB+Et1B+ps5IbdE+U8eLFkQy0VVcNSp3fUcZy/o?=
 =?us-ascii?Q?DykMXlsq2luBB/AVc0V34mnm0DJ41qzr2mFRWhWHqH5Fic+KRp/+9ispe95A?=
 =?us-ascii?Q?CtYKMBmFL7rECvsJx7J0uwQi9DAj8l+JHKVORmLOLUOFdktlFtfdF0oVN4kf?=
 =?us-ascii?Q?d4zNO81zFATaomk5ef+r8xjDl2yO+GKuAwh2AIVnF0fz45QU9gczQxr6VEqz?=
 =?us-ascii?Q?/7GI2blNjsxtRLYlKqoiV03yubkPGmxS4BzMaUt/EZq5mOt/NDguUzqbBVxe?=
 =?us-ascii?Q?Q4niGKHYrVXdXHjLzePHVTsam0fu6VvKAxbqE2lUIADzf8IVRvCm93sQ9SWW?=
 =?us-ascii?Q?K1oeyGpKlCI4tjqJDCO/vlXnqSKzgTMbzOIi7W0wGQZD8ZQZ/G4/yqBwpoz0?=
 =?us-ascii?Q?slzZ86BeTOAhSwKyv6G/wvRlxJ7mII4M9S7qL53eCMwEcVjaeTwZNyXNSWBs?=
 =?us-ascii?Q?lzsKpI3nygPex2l6TbLKhz4nLdn5KVthJ8S8dGjtxz9RR5ENcoSjz2wQPNsH?=
 =?us-ascii?Q?jBYXUwvgaIqVjgQx26sxwE1lgHx2kK74cgFAzsydBlEwaiUdZ7ROPCg5K8aQ?=
 =?us-ascii?Q?w9NUKDGa+J3s8fUK1sRQNAXkIWQlaLdGNcF091wy84GLJMVrova9F+lDT+YH?=
 =?us-ascii?Q?1T9KoDY+mTfDx8whelsLT0NPRFYMlxncHIhjdhzYxfLVsx28/BImXZfsGxXM?=
 =?us-ascii?Q?augdSD2sBzDweuv3fa2mSs6g87dIaz+HY9zPEIYPH528JfHEwP7eqsQIBfD5?=
 =?us-ascii?Q?DGT92myIdorYpeKVdmOVpO0ORVu7AuY3yrbXaOm+kx2goncGJIl376/ygzwG?=
 =?us-ascii?Q?1gcvlVUPREDeF+R4Ye+dyqdMw4ypNmxupbbC3oRzAIps8a2dcTJH+cgY6BhJ?=
 =?us-ascii?Q?D2pWcPFJERH5NvlAJMeITL8AWXiRLpJ8tCPupAaqiV1i3q/Z/vAgQ+klSPhg?=
 =?us-ascii?Q?s5ateee5RIPqzvNWfrikfaUrEAB+msuaGaLAVmLFJXv3i7y0Fp7fIljP9tO0?=
 =?us-ascii?Q?HF3AYzrNEDlZ9IgZ+je41ODL+IfiXPeVIxhHtOx4hHist6LjCjdGb6ISPqDW?=
 =?us-ascii?Q?7IW1XaZBZOR9xJE8fWJalL5foW2q2tCvpVrr5FJKPxmYaCWTwYH/nRBpH/N8?=
 =?us-ascii?Q?9pP0hCCU2glldtKT4soXCwCFoX1UJri5fdG4akE7TSeLGmCAL9xdqXkgOaXP?=
 =?us-ascii?Q?IHbzZ1+oPIq93ZQVuKtY1+17vbJ3xLWi59zj0be8ijYlVruWfdIzDc7Kc5nK?=
 =?us-ascii?Q?KhNHTEZfg/snYrNEqNCAbhlM6bzb+ncNDVUfgflVbVWuIci3SWcMrLQFG+Kr?=
 =?us-ascii?Q?DCCiTgq+n7s/U3smogbGScH0Shh6yQVd5YYaAVcyl8pp0J5Mr65SHwCX1uDC?=
 =?us-ascii?Q?TDzKFNRYCTEbEHbhahQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a76e4c1-71f2-415f-e9d3-08dd44873829
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 19:16:11.1427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmIgXY8sqdSJZGzrFmi9wNCj2aIixoJ2Kxfqb4vlG8iRRGGh3O2SMbgKcr79QZHP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655

On Tue, Feb 04, 2025 at 03:46:14AM +0900, Hector Martin wrote:
> 
> My 2c: If Linus doesn't pipe up with an authoritative answer to this
> thread, Miguel and the other Rust folks should just merge this
> series

Please don't hijack this side thread.

This is about Linus's policy for merging C code that breaks Rust
builds. You should put this comment on the branch with Christoph's
NAK.

Thanks,
Jason
