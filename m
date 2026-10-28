Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201303;
	b=UyiHoydqjs4wpabpOuYpY1OPwYH8i+2BTxOuasoygLYWLHe4FC3Wi/xJWjXXEWxWv3vL
	 w4etlINwDMBscrN0WfIhMqXJktmcOtfGIuGgyuxfFTCta5ou2DjwW+l/rV1KD6vVgUGFM
	 xshqF4Dr2IBgMqHg0BsQG1QLInVsn/cED0zwphBQzYqxknHgwg/ugC4f16CSaYNkg2YI7
	 8M8sp4K7qat8xOGJW9dOlqx+1tEOLN8xvLRjrPya6unZdaT6mBeSsGiXGSfXqDXTSuWWI
	 0XV1YUy23oLu1zD0Q/q8Ab7XcN6GDOKBU+F818Dmue4YfussNCT9ryMiGJVfLzWhepw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201303;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=r9Ox8/TgEaKXje5gT+ccePUFmBOGhq7/DzObDFtwP6Q=;
	b=YUp6HXBVj/8Ml1hykFygKKUl7yj9t58l9Pa2ZZ9vmn03Nk6RDPUqiMKqhhyjDYyaUsLb
	 bgTEQm6gVKdPmMulsOwUqFeX+cXeCVdanNH0N5K3hYjjNAvFiVTsTzvV5eF0I3BKrBTiu
	 QojIIHT/vsZ/SGsug3byiC6qSnKAtzjX9wSH5p0n4PMmghguWsifJua8MzQ4Dddhyv7Y1
	 OhW0uz1YJREVuQNxttwfgOoEChJvdDaNgMIcYnjoP3Eoyb6p/MNvLfifMjKVA26r2V6JW
	 sFLSzjWZv0OJG0yPlmCL6Rj5KH7JICjaO1O5Hd9UQg8o1tZZ2fkKVbGv5NTwPPuYeuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aoXxkKLx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.45
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80689606A338
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 15:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80689606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aoXxkKLx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhocXtSvwYp/fBcKv/yyrTrYHxTjYYVMU48MwzoSia59hYQd+5lBVj+Wjalip0yvvtbbEIDBEl//nTyL8eCJ5cQEWObIaz1pbgLuK4BCFQZp/WBE1Rcuspi4gJOzZTe2FC/oX7HVk9SNtsxPezHDlJzL3pxZ2n4erkIYwvXDZp9IOiTY6H3xp8O7+PgdeF6Wh0hVCm0QggadjJuoBVUB3ek3Ccqp3hPecamkeg7tzLLE5XOR9xUa3ViDNc8CvotSipAyc2EYFPLXutu93DImlIyno7BqhBudaApZdcR6cloQfGl6X/varGPj5+G4DUxPfD8ezT0KwmonLHl6pHyXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9Ox8/TgEaKXje5gT+ccePUFmBOGhq7/DzObDFtwP6Q=;
 b=jFfbCaVe+846F319FIfqfKe65TvHPEAA7unykX7NvNWABArV9i0pnR1PCkvjsx6zDjEsnWS1MDrTnrTtBfPGIVguzPPZY5fbW6Ql49hpR+AVrTzEXxpy7TdV8MbZhsAITbF41zJUaqC1+O5afV/hzxctgt0/yYr9YDl+oEEUG7z4Y9f0EgEinK7HyekpXJihPZy+tbmrG/u1FABf0CNv12dblmvl8QbkYA8LCShu7T1mpaIDV1xtKNdg2MMwksJhlHBPxJ+WgI5R3/pmPhguMXizHB9gyLyRIYPMd4mp2uYRVKtg7x8qBkaxx/vvRtlNOtS8NCngoFsFnkzSL8nvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9Ox8/TgEaKXje5gT+ccePUFmBOGhq7/DzObDFtwP6Q=;
 b=aoXxkKLx7Xlo87/bHTvOygcza8I3BbjPlwRXTyuiVpMxsnHuaMbDX5Lsg9n3X0LbW66RfeYFH+2i7dxWPjam4yXgzMnImMj9ckU0MDKuqZ5cA4zy3f05HpS/Btgt+RmSrU7mSvmS8bdS5inpINJBtTAxZYtW1f3CMuKG4+bSuDY0Mpua/dKbAtZke6QPLVq+wsnQrVWMdBPRzF9b8ug1aoBiWBgzP+gVcHtkcP9v6X/+edrVq/eJVqkjoqoYyAWY9YAN4Q700Ba5IgQOqXKfXCuNQYTy4aOQGq/vcx7xvgEikRPTeCsnNWU5gtxJO6a/MDkfbHhqHfDlBJMAcVORAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB9189.namprd12.prod.outlook.com
 (2603:10b6:a03:55b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:28:13 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 15:28:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v5 01/10] iommupt: Add RISC-V Second-stage
 (iohgatp) page table support
From: Jason Gunthorpe <jgg@nvidia.com>
To: fangyu.yu@linux.alibaba.com
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
 robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com, 
 jroedel@suse.de, zong.li@sifive.com, andrew.jones@linux.dev, 
 anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, 
 atish.patra@linux.dev, skhawaja@google.com, vasant.hegde@amd.com, 
 joerg.roedel@amd.com, tanchi25@mails.ucas.ac.cn, 
 gong.shuai@sanechips.com.cn, guoren@kernel.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 kvm-riscv@lists.infradead.org
In-Reply-To: <20261020094106.92722-2-fangyu.yu@linux.alibaba.com>
References: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
 <20261020094106.92722-2-fangyu.yu@linux.alibaba.com>
Date: Wed, 28 Oct 2026 12:28:08 -0300
Message-Id: <179320128820.2412245.15284768771245673285.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SN7PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:806:126::7) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ2PR12MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7710e3-09f4-4d2a-59a1-08df35081454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	mpzOvAKNS0amIcDbhjXcN5B788FKKIid575LL+fb7J9fkaw3kLIhAfe2bobx5Ilj8QUmuxLjaOXBb4dLY9ewyDQx+EqHadsGiDaVKLFmWuEkS3Nw2NjT1Dp3w7D/kuDF/GRDoXdjxRHLjqSwv7N+Ynpgtg5bBVO4vcM9gjRmk0fjvtobqSkPfTx+BMhp7h8sMRG/ULGsdXC762e/dQtGrvr57n21UFuDUGNnKwBZMnWZ1f8iiG0vyUfmqfBRpeAOgGNu7IqF0s2VMNhlcXhMUEyCedw5wt2CL4SIATRUSklIoYZW/uKPxDlQiERC+EYzMUWuGQ8hWX8G7HB+usKpg2wo5tJkzwQtUyqPxMY9dJn0M4u+gf5cxMylnXTdKHDIaf8hEYU/X3uJEKen/pFC/9lDOn+V8SdkCZJmfELjO3e9JTRGwokrrlByZs7x2KjmUbTFOSBwaURfUNpDXhxSdqutGhbUj68n6cGyb68WJid76Wg6k7d4KA0nEkG3B51qlFBl8l5qKJYg+EOdd9s34GFu3HMAo6Unr23qaqAoovUbp9hBLFCDk/8awcRdLKr37XGOOOIMJaJezqaWsTXcEf+boJP+Y90kMU72NetdwMbGdBubGnYOK60iNaX7JvwU+357mP8z0/Kt6MlXU2+Sz68ju5Ku3vOvNRGclPlfz6g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3pubTZTL3V2enVLbDRvczR0L05tamV3S1JJSExvZDJySWVaUXJpcDlDTjJW?=
 =?utf-8?B?UDZJalBNbG9PejQ2d1IzcGVsWWVxclVYM1J4YUVLckh0WVJya2R1K0Z2ZE1N?=
 =?utf-8?B?QzhkcjBaZTBsU3hkTVY1VDdzUUJwTjhNRE8xbU0yN1BOeVlJTlpBbGJ0S0Fh?=
 =?utf-8?B?Z3F1NWxXR1hySnU2T1VabjhPU1daK3pCQnVpV3g4TlRjU0QrMzVib1ZHQ1hz?=
 =?utf-8?B?SldmV0haTGZ5cHo4UXl2bW11eHBxaHBudXdHajVRUmwrREJVeFhLVWVpS0ZG?=
 =?utf-8?B?aVJJeVNOSUpsZjJ6MzcxaktYdSt0dENMNHpZK2lYYjFnbDUrejFUUXZtOStS?=
 =?utf-8?B?YVdtUVk1bUtPQTNSaE1PVGZVZXQ0czBLcTJ5cFYxNnBpMjZ4MnpxQnRtZUEw?=
 =?utf-8?B?V2IrQ1B5RVRrQWJ2aFJ4Q2tYUHdKM1B0ZDYzZWR6RWtNdHdpbnRjaC9mcGdm?=
 =?utf-8?B?ZDlKVmNqNy92eHVHWklSQmJlSEMrT1lXMTkzdDBzcmxTRUYxdWQ1aXR6ZjdI?=
 =?utf-8?B?aklPM09UZElqdUhBcFZiUlRjTDFSdXF3QkJEcDdsZFA5dWdidm9Jc0dEbmQy?=
 =?utf-8?B?cGJMWDA4aWNsR2VDeW93cVExYzBqSlJJWi9SZGphMzh3TWVsYnhDVjNiYS9R?=
 =?utf-8?B?NC9YRmRkUS96WGxrbGFLMWtRNVhJLzBWY24vS1IwUlFCWU85YlNobEpJN2tE?=
 =?utf-8?B?anE0RFhhQ0JTWGV0c1VYQzJBbWRtVVZvdm1ibDVGclVUNWhBNGVodGRLSkpM?=
 =?utf-8?B?NE85UGwvc2o4aXB2dlc5UFVRR2sxbVhCVHpmS3hXN2lqRFdPS2Rud2U0Q25N?=
 =?utf-8?B?WmhrRmxrZksxcENHemRUeER2b0M3QUFMNUlISTkzQW9HZFIwbXdYWkd4NUY4?=
 =?utf-8?B?bStINzdFUWxFRWcvb040MFQ1dW41SjhKKzBoaFFmK2h5UXllMmV2bmFsOGV1?=
 =?utf-8?B?TC9VNEVMMzJJVVNod1A1MUxtbUpGam00Q0VadUh4cWJLb1djdCthVDZZWlJy?=
 =?utf-8?B?Rzlvc25sRFM4cEt3ZU45Q0lTMVF2TTdlV0JiQytvRnQ5N0FNTzRhU0FObWhw?=
 =?utf-8?B?ZmdtQ3RLck9ENDdMRmxzVmZaVUJFUFd4RFFNSlFpdXoyTUQ4Y3NDcWF5bkxa?=
 =?utf-8?B?VXZ0Ny92MkFwb0NlMXppQjBhTGFjQlJxRlZyczJLQ29vSEZ2Y2tRdllhbWc0?=
 =?utf-8?B?QTNQVFhta0dzM2kra3lrVDBDcjFneThYZWdlaDkycDIxYUcxWlB1RWtrR2ls?=
 =?utf-8?B?UW4vMVgwQTAwblI1YU5NYUN4bDliZmV5UlczSUN1czNZTEFwaEQ2bE5xRzJD?=
 =?utf-8?B?ZkFNYk9UZVZrRVVEbmdxT29SdUxJa1ZyTzZRWXFGV0I0Ly9vZWUzUEVORkk1?=
 =?utf-8?B?YVIzM0JyNTQyTVA0dW9wa09zb0lFMVduN0F3dUwxcWo5T05EUkZlVll6R1I4?=
 =?utf-8?B?MzA1OXNJRWREK25vQUFIaU9sMjd2ZGdVeUpQVWtwa2t0Q3ludkdLQkdKOTdW?=
 =?utf-8?B?VisySG5CVG84SXVXbHVJcm10S0tRM1lNRjZGemxXNVIvNERMNHh6R0dkZUQy?=
 =?utf-8?B?RnUwQ0dKUFVkZkxCVFNXSWtIYS9nM1FaZ3BoNGtZSmxRVDB0MEV5ODB5dG4y?=
 =?utf-8?B?UVNBUmI2VGw2amtjODlHc0JQZkZpNDJMRFo2d2VGeW9aU09KT3Rhc1NMTDN3?=
 =?utf-8?B?bERzWDJ2dGVESVNhYlVQcnBXK1VYV2hPVGYxcHc1SUp4REIzd1JFdFY4TnMw?=
 =?utf-8?B?OEJGUFdWUU1Fa0FTdWpIaVZVTWQ0ZjV5aEtLa0hYMWlUdlE4bUwxVC9yTTVt?=
 =?utf-8?B?QUtrNDM2bXpvaGdSMU9KSVlJVFdOdHB4V3BNVWl2TDhEd09KSVo1NUM0UWU4?=
 =?utf-8?B?R1pHbE4rbVY0NXR5Ri9TakNLcmVpVDdxR01YSXQ4QkFGbFRZU2pVYjBVYjJ5?=
 =?utf-8?B?TGhiUWQ5UmZpL0JXay8ySXJZSjNIZUpyRGxqYTQyUjZWNE9ReE5CL0hLQU1F?=
 =?utf-8?B?MVpiVnIzZlFHUW5nREYyUmkyM09nUGQ3a1lpeFVQSEJmNmNzVVhUaFNvUDlR?=
 =?utf-8?B?ZVZqSTExZHRBTVlwQnczWEZ2c1ArcFNUUm9kR0c1Mnc3TkNkREt3UHUvUk9W?=
 =?utf-8?B?K2JpUmJIeFgyVnVsbHJncks4aGRQYnl3S0xKK09SUmJPaU8vRFVPOWNCOTk1?=
 =?utf-8?B?MTJmcDhuM21mMGp0R21tcHNET0RjV3dpekRwQTg1VGVGUXBDMFhOOUtBbUFa?=
 =?utf-8?B?RmNFd3hqMEh4VzdxWWFVL2FZYXVOUlZYYlFvRlN5SjROVSt4SGxDYjNaTFFo?=
 =?utf-8?Q?t0j+bIADQGna2KqNJY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7710e3-09f4-4d2a-59a1-08df35081454
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:28:12.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL5ocyEW5hw0KPUvdqnsAXW2dbpZVYCo51NVNp8ct28+8px0k+vuMp0UeCS9SeYS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

On Tue, 20 Oct 2026 17:40:57 +0800, fangyu.yu@linux.alibaba.com <fangyu.yu@linux.alibaba.com> wrote:
> Add support for Sv39x4/Sv48x4/Sv57x4 Second-stage page tables used by
> the RISC-V IOMMU iohgatp register. The x4 root page table is 16 KiB
> instead of the usual 4 KiB, covering 2 extra GPA bits (hw_max_vasz_lg2
> = 41/50/59).

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
