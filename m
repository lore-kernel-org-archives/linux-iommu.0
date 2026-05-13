Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA50341065
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682740; cv=fail; b=Thf7X55TE1e+JNVhKdxfFR9gXG2jo0/n2s4ZftEEOVzqaUf7YSapl+fMQfSq2sdWXFhHH5vXyCCPwpzCSPMTEAkwnzyYNmMQOdo368RJWYVflbso9cvGi9Uxf/wX8be8UbKBFaOW38RmDBe15zqqwRstiqv19yfn61byTimGfVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682740; c=relaxed/simple;
	bh=LTwXrRIPpbvDyfEtbwD1EZRg0TVszJKIMS3NtZBJNn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QgfZt1NeSgC2BjvXBcJ1Vh3WZMNtaiAFZQtVWZBA6A1WY9PyUB1hv3KgUAl9nj/W+zTu0xTsARMmp/6GtMqx3L+QOk+6IAPo1FXaWvWm+o4K3Kl8q1/3vx/ISyZgIAVcJ877Jt2WN7GVKXJ/JOw+ySsvj7jv/Wc5GLOYqrtNH0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nBCScYHn; arc=fail smtp.client-ip=40.93.194.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nBCScYHn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdyD70elaChT7GpnO1xJw0xz7NnZK5ExpfpG1c9cuS4UWotctYULS6DrPj9er6cDNtprr0Gi1vpg2BxBSVLQjCON7+gkQb0H7GJ1lrNhLDyvWGeNL1giiNUJK9TVaEhGepOcSAUCoPHQOLCIOBNEx09Ri4tcwq2f+FeSVE4B90GnxsJRqcyQwXGooRx8VJEMES7FtiHleJmP7rXAyqxVodiMk4Lqyum+1N+E6ooZc9yZ1ga1DjVq2TzL/dmppoKc8JxnkL8clgRC5cggLAIPGLA0axJ+R5FObZmqhyzAmu0hM2y5UNvZjDObP4aHphOm2JQqrKeb38G7ELDz3KsndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTwXrRIPpbvDyfEtbwD1EZRg0TVszJKIMS3NtZBJNn4=;
 b=XurnWt2BntZdkqP0BRXznp2CUCORnP+z/4p0wzssGqoDY1A4VBihm9T6o22imP7bqeosDLlR6e3XylAKTzx/rAeYaICqQxRzrGOXaLmS7mg86wcRUCpQ8gI12KvS0xsstB03gs+P6lNRLjs5crtLadMPuOaM8kD6hHNtWmShMLQwwWyANap0NkXpvoQMOKY2TZ1HqYG6RvfDDThA3rdti+ay3Q4u16P7WoCahQIqe83yKRQ4xKtoOWlMQrDgwPS29nAwu8+8HlaIYef9m35DNisieQxpxAZovlO+sqv+vu7WG5QOJIYwV7kaK7xT0g4upWtNfnp7bTmNFqyZz3kSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTwXrRIPpbvDyfEtbwD1EZRg0TVszJKIMS3NtZBJNn4=;
 b=nBCScYHn5nKSlBaEaNgv7uH4aBrfvSGx5YXXJxUMYmHZVysNu5vXCONUS6E0L2aGJW8cZRac1jjh88sYe9IUWqE+EGwyAYhPZCEGaUmyFIYjc/W+kzBolOHP1KbzjHn5g+G893beVdOAdxDHDShle9UPW/oSbvYEe7fzDP4xjpZScV5Epk/u+exlSf00oEFeEbvRevhQXT+OOdPT5LV3AcIKbx/9asWgO/6fCk5hzihgq/LzxG5ySLULEJWyLZ4YBbRuKVqTJRM0lR2NY1BCxwH/I3NuJKqkQatUIeD81uyZICD9l7Sgew8uwuw3HCVISOFjedh+cJUPkgBqONWBsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:32:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 14:32:14 +0000
Date: Wed, 13 May 2026 11:32:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
Message-ID: <20260513143213.GA787748@nvidia.com>
References: <af0SdkjQOZxnnaQb@google.com>
 <20260508123550.GB9254@nvidia.com>
 <af3hWGp3etGOIdEn@google.com>
 <f31043cc-45dd-457f-8031-0cef51c9470e@arm.com>
 <af3ryl7G58D2GeWr@google.com>
 <4e129891-2f52-4bac-8e33-1fdde42fd29a@arm.com>
 <af7oyeleKFXpcIKu@nvidia.com>
 <agHYDxuYyqzmAfy5@google.com>
 <agRjt9XpN66ktdk9@willie-the-truck>
 <agSKZPJmFMLc0gno@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agSKZPJmFMLc0gno@google.com>
X-ClientProxiedBy: BL1PR13CA0346.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: a90143dd-f6d2-4b32-4fa6-08deb0fc6d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qlkbXvCFtJQHFeixCPLV5tt1mDlmDGExuFybShA1jFTBAyFAepqLpKSt7azDeuMh0hZ0WJ9ja5GAju2eaEwD166FLYUEg+VeZAtrgQnPrGJAG7oi9S0g4WKBHrW/GwJBtc2pXN/nZjqjrjYWpaVD0rOr8GmA5b0AnmCvCvZVOM0hFMBeTBHSKeDXHKi5E5vjqqUY6YLwipF+fpr7oQYgtiLJJJghjB92xXQjBCkoIov2UaGFsglcvRY7eDb++rWVokX2Ka8U491RkBE1AojoBLqc4LEuW8uB1W4H6tjJh7/6yYVTtQLZPxjimTquMzhqGbvD+BmhyUlo4rzcY6u7e+q2CT2XPx8NmBpC45kbl496HiBgYlPhVUgvT7lefivdsXiX4SgZeK8+zgtQqHNzGaisa6+GfkopnrTohJJyGC8NXzbhkpRklTkjVxaJ/ov+HyU0UO3VY/grfvbPhwABNB3kYKNHtJDfyYl0XKQ9As0lF1bTww8ZYOM3AgvjofJOTajPhP05spq1b+ygJWN/BP066s3+zlRzH8hIoCMYJojm2Qi1sQ1tOG5rVSe9mtZqUTXTrs0bsEOGkO0nowP2gAILvZhrNqVWwO6sZEiTnTodCJEwPiixlU2AKebU9YpHU3KLTSBw1+Fj24bpNVfoJI2wVQ8IOKLyqct6L/RQUsxa76Q0ziCQjp77zyboOViU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f1RNSU9GC1ZbscLfO33IvumxtZRlXU3ZCV0oW7TFdXCzIcy6VYiYp5LXpj8Q?=
 =?us-ascii?Q?EubWD+9ukMbqdeJoGRcTaPpvcF+AO/aBERePBYXSbiMemzhPws1QHF56D3Bk?=
 =?us-ascii?Q?YsIdxuZ5SifKuLHnE103lPIZ9XxFDXymp1COIbmytai6CDIcjEoaype1MTDP?=
 =?us-ascii?Q?o0N0dTZOF/dUOxTxo8VT5dNe6Hur8GzkhX9Y9/LIy52uq4htg/GeXyrvuMKw?=
 =?us-ascii?Q?2/tgZm9bbpTWm5iB0zjWpUR2uaAfVAoZPqvsVu3LTKppUhB6Zo0p+ETmOuuI?=
 =?us-ascii?Q?JQLpjeG5h8hG2OpeLCrOENQHfHshAik2in3GCCSsFyh1xe/78jCvb5Gn6U1X?=
 =?us-ascii?Q?U17qZ532ze+viXWXrT/HE0jOtqOXGLd/6rocARuUKXmTG1YhLMcpHsESF7u0?=
 =?us-ascii?Q?2agiqGkuUNdmDpVH80WiTukln7IUEp70wKVwWZNhwCV4PUHCXWZ5tDOd0e1C?=
 =?us-ascii?Q?g+IKOD5nqbNfGdayZ+zEAP+5QZySflybwLB8FLQctOJ3393eWxEkfbURCpQi?=
 =?us-ascii?Q?OCAPmYa269/++jXJjNljO1i4FlA1soz/8+9Nqrjybl8lZ5IOZN7AVA9h9j/g?=
 =?us-ascii?Q?ee53JBBSph1ShR3YCME6ekO/UHW/RFojJLjddsttbo2PdDq18Iv7kqTFI9Ob?=
 =?us-ascii?Q?3rVSS2VMT/HHK10RW3rY4TL1JoiHaVZDmzt3NxUozh5uSGVeFRqCmmrtzpqs?=
 =?us-ascii?Q?emKoBASmgd0n0fdwG0IJFXyDIMpdkc94/2SwSNqal3PoDDJZvuP70gSC52fD?=
 =?us-ascii?Q?7o51/4KPqtSDxfwzGJLzNycWyBlKk3+sI8vJjAWh1wlsYNIBFRM5SR3zERxI?=
 =?us-ascii?Q?MOe79uANYEXrNTNq0jvEPGS8djifyxFRi529fjUAfni7dQgDIm/5PL/n51i6?=
 =?us-ascii?Q?FiSHodujk+kB8Fw2GB4vTDVp1Jq8Wjox5n7ofiH+fEJGVjNfaUxFSQPvhrXP?=
 =?us-ascii?Q?UKBXox6rNCAKR6CXDbc6jawSAuSMpCaOE03uhCi5NkyiRQA5fycmJ8SqwVH8?=
 =?us-ascii?Q?lbw3wfCTwLiABRHH5N5RlCowm+lFxGoiJT7xBXjRC4jZhf8Bsa5MgKLNq1Vz?=
 =?us-ascii?Q?QnbXU9O7DOP2VvB0exGl9/nhmm8eocdJlXAq2NVTWs5Z8nKBH8sI8j4IkuzH?=
 =?us-ascii?Q?o11WIRAwdoKBSI/hTfs6DJgqVN2iEKtpPm6sqvkOHiXqPqWgeRk3nMstObjC?=
 =?us-ascii?Q?BzS4GA8zBzW+dVEvvL02gRamYjatfOtPJsuDS1KXfJdpd8iPkMD2SCCv735+?=
 =?us-ascii?Q?fwfFONtsqd6KOwwnU1sfXW8uPI3loSo/NgBjvAcJC0fCkJtVu7AYKLXzNzK+?=
 =?us-ascii?Q?tQqd/UNCuEUywN1dgFBcQMqKS5OvoBSCUbuW3zGPXWzQ7r+gtIgXeqfftdkE?=
 =?us-ascii?Q?T3p/qZoDVO2cRa2kRMcPxpC++10YI2ZiIhYtPPBKw4zB0E4VYPvCG7qK2Vod?=
 =?us-ascii?Q?IydK1dRVfMNFuhW2LoQaN9u4JMrXl/u1sEj7e0uKBK4SnSI8EjNUOeGUKSla?=
 =?us-ascii?Q?QulFeczaQSxveRDFIPNYeFx/Xhz3dzkMGHQTziu1fSA/TyXGK0JWRGFbFNLo?=
 =?us-ascii?Q?5YTc9/0IXAOHORw24Wr9i877xqE8tDEoVDsle0Qp4PUpGvVPx1r9dqb+SnhI?=
 =?us-ascii?Q?T+P5MglDa1gcXQ6JVuBZJNpqHscL3cfDyOWq8HPqAOsBcBN8F7t7A3kOuJAy?=
 =?us-ascii?Q?mJfFyM0wukkycqiUNPGnzvM/ux+gJDbvzIssCFhx9uZxamH1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90143dd-f6d2-4b32-4fa6-08deb0fc6d52
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:32:14.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/+/ZPV2hYx9lyf8gf9b2Hkw7/5rDiEjqxIciGwBwaAFboPb7Iv8eVTa0eHuRTd8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059

On Wed, May 13, 2026 at 02:27:48PM +0000, Pranjal Shrivastava wrote:

> Now, if we're work on an SVA page, with only SMMU supporting HTTU. A DMA
> writes to the page and the process (CPU) calls fsync(). IIUC, it performs
> a lookup in the Page Cache specifically for folios tagged as DIRTY.
> Since, vmscan didn't run yet, this could potentally drop the writes..

How does it work differently in the MM when the CPU has BBM support?

Jason
