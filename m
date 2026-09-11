Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE838DC6C
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147181; cv=fail; b=TOBP1EQzX4lwSldve2jHCsAJjui3RIVUqyer+PV04EXeznNfKKlglMJDeYq6X63gXzh4JJjBHX4pYUfKBQ2e0gH2JSjobeSKNJPf/bVu8TfIQcuCmxhXGDqcMLbUU0hnBECu5tlXpg1f2MpiTFh8MoAfsR7Ds+yTyRWxLnYRChs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147181; c=relaxed/simple;
	bh=Rd6toRH+p88Oq3M7uUHt7pe/9G6Onay2CQkHv9PY+74=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=ED4Kpa6v9PGiGEXP4N90Pri6L3oLpGUpuqvsYU0mh0A1VKYkG9oYx9N6TTptjgpvKENTHF9PVKaB/ueDJQ+VKnL84eFGRfdUx7xsQJKmbZyHJC67PvhlZCKoh7zsg9/lY1HHkfBD6O41fbLEpC17B6vpOuOWTbRxkjGNSuMnoBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tQOOqxqF; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tQOOqxqF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4miuq/ALJS2aeVw/vfqSDqFb0pNMhJM2uKRjT3pQAfjVWcVf7H+XbzPujMfyd1nmAxRusPUZpQowFqFfvNOaiKJTZlS3vMWJtYFbQxag8msaarUg/K8vYFmIU+fNwtLmxrRiQ1qbXFfepMf0p373wZmW8Ua76r5ATlzwZGoPAOZPe7mE2zxek81wC1jE7KLhLB8I1ZMRWG8O4y9q6rFHHjCWztkSXhkU3KPXkyMmjcWQnstbm/0cFhliRyQFYq9GCgjuYiAUZn5EvgXCMuy/55/gTT2TJugzVTqmRZ3qeMMoV5alAZEhdsKbAW/zlh39o/PrxbmP8hEptAfo+v6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR0PPC+DdafEEJrPjdMbe2X1KdK10mX0EBZSjGpZALM=;
 b=Y53BWVZqdYl8wcUkctaCfqX6c3tCnuMIaoUwSPgt+OX5R7c0LWU4aav6XsG4r/+NqW/mc6+Zxuv6Y+FEPQf+M3N7SCay4KagQ1viJoFtattvvh7a8XC6F4Yg27KdRz8yYYbuCttj8udnATkja+XwOsTySk3/g2Wu+UJrlSuceS+yu1wLQAaSzLYjbo/qONen3YNM5FxHsrgveDpRsVy5WSalDrT4We3JAeDh2bGCkyclozVu2jn1LBIcsB7iwMOnQZkr1cGH1UaMDDt/YCccE+6HLQH7aXjlyP10ejiVbYNyGoaLdDI7x6ObC1uF6uvJZYjfs33Wv4kypgne/8xwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR0PPC+DdafEEJrPjdMbe2X1KdK10mX0EBZSjGpZALM=;
 b=tQOOqxqF1dBPgihLTXQRi07u4SJd8A2oxyfoSfvbt56rtlFixZ+DKNzqFlsped0jaJva2QinYGuwNqDtsoD8mHvTxhkOxtv+QpoRjmMNF78IHo6s3NoY5EmFJeVVjsaY8wR2MjkRz02LTE9K7P4QNDF4f0Ayu9V7InXLJMB1qZsM5dsR15lYMJbPjh4tV732hPefj6hquGxyXpmvGvPqH5JzBH9MD/mr18PNqTGRvQZYE3HlNvrmtYnE52Aogn2iTLFhMqz1aXcSurdVBgOMR2xfj1U8ORxLZPkS7Fc8FjvLUNUPp85FhP/x+5BFTMm12OkymuHtDm6RP2Su0C6WcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by MN0PR12MB6127.namprd12.prod.outlook.com
 (2603:10b6:208:3c5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:19:35 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:19:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, 
 Kevin Tian <kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Pranjal Shrivastava <praan@google.com>
In-Reply-To: <cover.1788127877.git.nicolinc@nvidia.com>
References: <cover.1788127877.git.nicolinc@nvidia.com>
Subject: Re: [PATCH v6 0/5] iommufd: Iterate the cache invalidation array
 in the core
Message-Id: <178914599038.1311365.11397999399990847073.b4-ty@b4>
Date: Fri, 11 Sep 2026 13:59:50 -0300
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0341.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::27) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e199b45-69ea-4c47-de58-08df1028da19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DUn51RXlPPBGQiVjcKnYQdfBAv/af6WNigDDd/SrsPSX5tbo3LhQ6Y5Jqtc6+d20d4b3OHECY2oWya0ywCQF3aABokZ4GBbQ+F+Xj5g5ertbxQXRnmS+RkiE38gjpbeM3hfKqGbGKKsqY9rs6hU6h1+6lymhavj6PMrTQ7/ANg+8tNzC4lgjs1dUshu7FHUssxlT6cw/J0duVUmz7Qg6X3kq5R8U1W9drMA9eJM5Ji5Gt2GMNqCzwLw4DnAjfpW1/Sszppu7IE5t/zalgFVJ11hpgz6KFPtSYswRffZaEALp3Xjp8V/9vDp8PUmXMR8Pk9usitA4k04IWyH2W7BQnompS/aKQ4gjlHI9QH16Fr/DLwoCD2Mr/gZ+CDjuzNhi+U3QjtjKtK0su6jsPeCKWmSLo5b5DHTd9CmApQhaM+vdXjJ8wIvQDl65JRJSlO4T9Yo7VZGyP4Gum13/VpxhMUG/VQKd1QJVgY6fIcEKRMTQ/yPs+hTPUpHcQ+O6IlR1FpWMWNrLJrJ8WbnaRNLWLGfQf8/5vtXYLAyy+RUoXq2geF9+fvHMgGWGS3M/zKHoGHY0UmwOHDN/CfERv10OzlGbeo9wsLkCn4LiBUKtNgRS3FOD04ixLgqsxACF/0W+SM0FDMFE0qtJ7St/ZmPeEZZ4Bb68zMX0bYaUaQ4MX98=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDRMZUhSQnRjZEQ2RUE5dmFRUHV2REpBYjRYQ0I2QStReERJRDRxdk81R1ly?=
 =?utf-8?B?SkRCdll0OWZrUjdnT2ZKVDBtM2xkUFRMNjVDVGJ5OVR4MlB6OVR4SzllRG5E?=
 =?utf-8?B?WnNJbk9HWTNsbEhqNHdleGx2WWpmRlRnUkhwOTdwK3FPTXJ1U3ZyV2xXMW9R?=
 =?utf-8?B?a1BEaUdRSmRiMkZ6OFJCQmNNODg0b1gzSWl3Q25Bc0hwb1cyb1M4RWR3a0pT?=
 =?utf-8?B?U2dEOVQ4ZkN0VUdUbG8xb054aXptTWh0bHNUNVJDUytLa291MXJUbDIvNmZ1?=
 =?utf-8?B?RUQ5ZnhreithM0FZS0RVTG1PcmVaV3hmTkllMjlNbFVFMWRzQldJTzdJYVl1?=
 =?utf-8?B?Qzl2WnVEYmEyemhSYVpSYmJJbVB6a1lGamdEWkc2S1ZpTGZkQjNjVlU3OU9C?=
 =?utf-8?B?dm84UExYM2R6UEVTejZJVzQ2Vmg3Rk5XZXdFYis5aXpLQ1pXZkRyUWtIUmNC?=
 =?utf-8?B?Snl0QUY0ZVNycWRrWElRUFNQdzBtQ3BjS3A1SlhqOWpLaVAyajFqMXFuNG8w?=
 =?utf-8?B?NUtQM3RrUUx5SllMSS9TNjJEWUtncUtjcnk5VUVKa2h2ME5VZ2hOZzR4cGlC?=
 =?utf-8?B?T1o2eFl5d2tybXl4elkvOEFFYlJqbm93Ti9MSk56aXcxM1g0MnVGOTVYZHpX?=
 =?utf-8?B?VmJ0cUlMbDkrZTkzM2tOVCtlRnVZc3BZZmIxV2VXOERjSjN3SDltQmExeVF0?=
 =?utf-8?B?SXdiTUJ5aFFudXNodUFUejFNd1IwaUcyaFNTTzlJdkJwVGxPZng5RkY5RFZ6?=
 =?utf-8?B?UmZUWGVUbHdqOElnZjY4NHVMZEFvWUloN1lHVVYzQTNHMXhleENlRUc0UCtI?=
 =?utf-8?B?UG5MU0tIZVdYdTNDM0ROb3BZTUpFcVQrUWoreTdVZkI5QXJRTDE3YzJLWjho?=
 =?utf-8?B?cFM4clR5QVN0b2hWbnU4VVoyVVdXQnM3VU9vd1RBcEN5KzA4Ri9vUFFYeTFh?=
 =?utf-8?B?VmxGZnJBcEx4Z3B0cktEUWxRcDBVRFRUVUx2VDB1Kys0QUxaV1M5R3pBaWha?=
 =?utf-8?B?bndhK0ZaSWtjUUZWQzRPQWQ2d0FCRlNhVVJscmpFT29XWTNsdzdLaWhBSGhF?=
 =?utf-8?B?aFhlYnpCbEVDc1FiYkg1TjlLNlY4dDJ6ZVFHRmQycjQrdGh4WVJUb2ptSEh2?=
 =?utf-8?B?MW9vcHAyZlc5UWhGMjdKY2dtaGNJOHBCMVVmbnZQTW94bnRMc3dPRFBzOGtx?=
 =?utf-8?B?cnUwdHhqS3ZaWXlVTGFGMUkzR0VDM0VtektpaElMRDBaWERYelhMQjgrLzdR?=
 =?utf-8?B?NFJkQUo2Zk5DUDJOQkF2SitkNG9oR0NHUkM1Y3I3NVFLQUw1VjIrMlJtTWgy?=
 =?utf-8?B?M0NPUExiakpORS8wbHdaVDRXUW5CWEFxNjBacVZQV2V2czVHTWw2SGw0Q1NB?=
 =?utf-8?B?dUNrdDluSjV0UC84bkpkSEtvWTZVemZnalNyK0EwcFYzR0RYOUlzNi9zd0ds?=
 =?utf-8?B?UFFYR3Zyc0NYNU5BeVJmNXB2TTJ1OVpWLzh2aTE5eURha3RhWHhpQzhZa2JV?=
 =?utf-8?B?V1VveG9lQk9BRCthdUduVWNvZk9IQVpwT1BvZHg5Nlh5VXRVLy9zZDQ1OVhi?=
 =?utf-8?B?bm40WWg2SlQvMGk5Qk1tV3AyR2x4U215cDNiVzNkTUw5TjhLdEQ0emZ2SjRQ?=
 =?utf-8?B?V1lORVo2TTN1Sy9rZCtsSFlSWGEwQ0xsdjB0a2N1ZmphQnIzWlI0d3VYa1V5?=
 =?utf-8?B?NlpYMXhXdmJTVHVSOWVoNnZPSU5tQkZsMmhIWlV4S1RYR2sya01vb1o4MUNk?=
 =?utf-8?B?U0pFeXBGdytvTXMySXdGV29jTUROMkpGUGdVeTdCSjh4QWFhSmUwZ2pWWDVF?=
 =?utf-8?B?YTBLa3JoZU1ZYk45cFVnMTZXS0U1WHpMTVIyTEhCTUxhdUhpYW9jcnEydDI2?=
 =?utf-8?B?cDk1REQ2aVc3cUVTeWY1Z0YxR1AyWEg5MTNOWVN1emlYV2ZGRnZ4L21uOXNr?=
 =?utf-8?B?QTZLWFEwWmwxdmJMdUxZU0tIS21jME1FaitZRHk4VFVoL094RlYyUFlKMWFI?=
 =?utf-8?B?a28vSEZQNWhSQ01CVzR1UmJpcGIraHJidGkvMXRYUU1qNXhwdzFuaUdja0F4?=
 =?utf-8?B?WmYvQVZLUnRrRURlRU4wODQxdlJQSVVFaHZSMnlHSERtSk5ibmxsMER4V2t1?=
 =?utf-8?B?OUFUdFNuaGYzY2pabTZ0YVBJNU9vMmdTaTFvRkl2eEtsNnhEUEo5czg1K3Aw?=
 =?utf-8?B?cHJMNCtPZnQzUkxpcytYbGtXVGQ4U2t3aTEveDAwQnYyOTdGNmRBQS94UUtX?=
 =?utf-8?B?dmxrbUQ3SG44WjBGWjVRVVhNQUlvemYreEZ6K0pVS2hSaUZqZDFoeUxhdHNB?=
 =?utf-8?Q?3msVDdxp3qDIYizTcI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e199b45-69ea-4c47-de58-08df1028da19
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:19:35.4951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evTt913/hTBbwg4yylXtIkYoKSOeA6ISnim4sjbQhUI71Q+2QwSfsPCYB4UZb4si
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127


On Sun, 30 Aug 2026 15:26:37 -0700, Nicolin Chen wrote:
> iommufd: Iterate the cache invalidation array in the core
> 
> The vIOMMU cache_invalidate() and the nested-HWPT cache_invalidate_user()
> ops are each handed the full user invalidation array and must report, via
> array->entry_num, how many of its entries they handled. That makes every
> driver open-code the same array walk, with real downsides:
> 
> [...]

Applied, thanks!

[1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation commands
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=26564d25cd814dfd72a21a2c52b81e678cf02bae
[2/5] iommufd: Iterate the cache invalidation array in the core
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=61e2f25a49bc4d274e71856b2bcac0753f38bafb
[3/5] iommufd/selftest: Convert cache invalidation mocks to the core array loop
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=5519695903a4b443903dd6d9207ad340bc3c984b
[4/5] iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core array loop
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=2d4f03f6610d569070a86d8d2c583ddfcd390f75
[5/5] iommu/vt-d: Convert nested cache invalidation to the core array loop
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=fe85c40e992be9578b8cdfa992d9e23005e25e77

Best regards,
-- 
Jason

