Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1D4F0552
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089810; cv=fail; b=h2kSytp16YBE5eglOxTbUO02R07RPGAv2pfvh7blJzMPMuSw3/gvxxQngz4BJnqtmnNS8DG27LSLtzmDhHTpgaLIrG8LXtpxd+Q70b/qDnJIDmMiMVpAJQlo3xNvKB9s1wUdQVC60busXdQog4JhQyVhroc0tSa9s1uXtoHQtrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089810; c=relaxed/simple;
	bh=wpqyOmVcZqh7la6RByrfSvsAwa+28iOk0b8wiDmeAZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YIGOzTJjwryEX+5YSdA5P0oT373cRO+lfV+K/RZhejjUnUJBwDIud+jjFJY4zGq3Pw0IwR+bfwiK4Eb2OWrsehefM9Bs7EzpkZ9kt2hPPaiL5rO0LKKwu/WkhM5DNyM/PtuYVoDJ7KfneFKcnTDem3af5t2ripbFPPvptzKRokA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECJp0P8Q; arc=fail smtp.client-ip=52.101.48.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECJp0P8Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nm9jkCXAbmq12L6L2zIfazlb0hCDOAomTSIWqGFx7PpeP6BDgLU5g6oXx6BRpXCfYKrgEP3XAVh9lC0+LmMDSmtN4rm/BFaQnEdQS2hc7nGqHfBtBpWD4eDhz3l7ao38F6KZ5V1anRQgYG5/QY7c1X55ASG+ecK2c4TScUkjYazc7BmsPxnki8OYvVGROr/aJASSAAOxnEMPSDB2fpXi4gLzsEWVMX4YyHfbGxxCIn5LCom6DlG/4s48acbwDec2YXWTanStw6lr8zB45+wjR1vvJr4ooL0mn4zyax/7dMgU+ZkO8gEbeqPx3jBIMow9Dua946VhbjTgxpT+0wGRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpqyOmVcZqh7la6RByrfSvsAwa+28iOk0b8wiDmeAZk=;
 b=uW/P4vr0AP6qr8fG2bZM030KdK8gZnvBlpGzGgvW0JhzOVzhhSWHfgxcfWPHPDPKWEbOIaefmFUCziP2hsjM24qwoDBP60D5dUh4ZcKsdinm/tsPaskeZCvbj9B+BPK1qW9VKktevjaWW6kiyFj0WvdNTX5Og0T6wSk6dKlQakKLeFD3HpHYOYknARF2XOtAmPzcSULkqDgQOPV+3fdgfJXeG1XDfLZi3vCWeRxuVvwpiyiAmuErlH/HymZDTeplI0j+X/Z/F/+GSRk101zrG12umUtf0FvKUw5aQsCX6NWxYuzM3VYusXXuL/w39mmFF9TPNNFe/Pgr8K0fcV+CqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpqyOmVcZqh7la6RByrfSvsAwa+28iOk0b8wiDmeAZk=;
 b=ECJp0P8QcnyQr6vH7B13LMonodyygo9xVvWlaq3x7bPPery0FcWdH5e84CIdwzbuiBJXtP9FhpqK/gtlFAFeVBL8uR1sfAwxW8eINgpdH693kSbosymIz8EdChCbr5EeE818ioNgBQ/Ckg9sPZDhcewPRHeoD/7Cm8SAFlvQQ5BQaRMtHOlNLIUBjpJFsX2wBwgdR7H6gwUFkSOF87MzxvJh5p7AVxfrGFHIZy+dD69ea6WXyFqe425TrRn1+FEXD+pBI4QnigSLiKPCe4Kxw2p1Yy1T8O8FbBxbCmUk6QuTH8BHnuObvA13dDa/lY92oqmBmiqCA8E5S4dsUy8sLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA5PPFD8C5D7E64.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Tue, 22 Sep
 2026 15:09:58 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 15:09:58 +0000
Date: Tue, 22 Sep 2026 12:09:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Peng Fan <peng.fan@nxp.com>, Robin Murphy <robin.murphy@arm.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: arm-smmu-v3 sharing SID
Message-ID: <20260922150956.GA2440598@nvidia.com>
References: <DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <359b01bc-e87a-9a50-c971-681e89985491@arm.com>
 <DU0PR04MB9417B971D20D1572FB598769887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20230518130459.GA2587493@myrica>
 <29132993-25e1-3e9d-464c-b9037d5c71d3@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29132993-25e1-3e9d-464c-b9037d5c71d3@linux.intel.com>
X-ClientProxiedBy: PH8P220CA0048.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::25) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f8b2da-a4f4-4279-b2a6-08df18bb9138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jmZTa8qfPf4f+7oMbxQe0GbPXe7dOYgAfhTqzaRY0fpwigvvUQmd9OHkW7lw/Fs4+czqN7gOemfB/HK/GmjD66ghOl8gBRrBd9Tf7axx/gZEsIcDB9CoUnAaZ2xedVSzbPJR4t8NgtrHDFTh9QXvFKgS1zsvL8V112dSkpXaPs/EH5W76yofBwsvzFu7castzmXb+zF8GGhww3SXhb1ocrHtpSZVMvse9ZTD1Mxz+usoIfr8/sriVgcDTd0dT+QEp7/tYrjO8meb5y0LQNiT/ww5EvRBwnnkoZWDAaV4jzhr+qC4Ilb0Rfw2dC9dg9GR4wl/ZsES1OZJP1+hxG5U0EH010b0dYLoKfsxq6O2xiJRyvgj+ESQZRw3dhgnce0CHDWtPFyiVY7Zkuh6sb2YvuP7QOv9tcFjjz0596/xVKIKWeM+kD+isQ+Dujc4XmB/CePigHDuuYIc6MNquzQTutmbhmvUU/B5JUf569wBD/11ZSJQt3VTtfosvy+Qe4bkffPC+jAEnSI4dAhGQ41lTi3RSKqatmDixbEUKu4A6lSY/UhCbaqVF9wZo6LRj0ksACf0WlUCBsHDKH4FQyE0JTKpZUV/nr1qf3Fm9p0Xt9bunsHCLbeF1pIvVPA0plSFLEHHkYWPQRlVPTUzn+vYI3zFqxiwF8Du9TsseSq32gg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xI2knJXRF1WBqC9XBKOWfZo9vCY95fNKKB4OeeAnc+uQ7SsWkyL6Fr6KH5Yk?=
 =?us-ascii?Q?WXxJuUkB/PJx7OgniJ74SIlfxF87yKs3qH3kq5XucVEpgtGnMrYvItUzBiXE?=
 =?us-ascii?Q?+WEQ30Vmb9DdguZxDEuceU9KEJRZcbN+hRdKa5USoNuuEMQz8ONz/mL3GWFv?=
 =?us-ascii?Q?sySYPm0bcU42rTbHRnAo+856vc1do8FsGLfDTIDra4eK1hvfT8qc4cIVKhGP?=
 =?us-ascii?Q?TdE+FkVNeE/jy3hdqrPrwkZlFwk64re+QS9LxHMquqsPlOVdxZ6sQQtaO+A5?=
 =?us-ascii?Q?KgwpNusEdvh9FqGDALHi0NlitbZFKFIPqBZU0fJ5gJTCloxUXUEJnZ3GeSHv?=
 =?us-ascii?Q?y2MA987opzDH4BeOrLXVzqToVSNO5bp/e8B6B1LxuBHJkJB6Edfc9fRbUBa1?=
 =?us-ascii?Q?XHdRBCmgRCfxhajh1P0z8X41QH6H8LDYTidIZEzMCVgV20ztCTHrS2DIhUqb?=
 =?us-ascii?Q?+ZbkhJ40a9SpS8e30KcCCtU2eRgLy0Lbq4J2Ir4bp7uErDJJC8cq6F74ipiR?=
 =?us-ascii?Q?QLx8+MAGQ0r+OOzYfi2DvKvB5298usUGYG650udeWwH0Inbd4CdUVy/gjcPN?=
 =?us-ascii?Q?eIQC5sQ87byNQoRfm/mEybujvZ4oX7rV75K+6TSK/KR9Zi5iHAleNeIjdTOK?=
 =?us-ascii?Q?TCmyNM/hN/qGQFOu6lSFPNmqyLz/U+hhtTdLRqSdVjQXb8zsUFGiepd+TGdN?=
 =?us-ascii?Q?YfuekPWSL0cdVQwEYQ22mjH81OCcMf66lRrXtGoNCjheh0YNJOxP5s62/1ld?=
 =?us-ascii?Q?iwfcvukZxn3Tu/ihGWdJQfqipWD/UIyUcE7ZMyqsh8E4C55AVtmOa2deDJ7S?=
 =?us-ascii?Q?Jpy2lUpstYkKaFQdB0uP4U9Dv0E7vmp1jsR0r7t8txurinLssYwMi7aEuDz0?=
 =?us-ascii?Q?Lf/yCjml1UPEKHeJN2yWK+T7kBSJrFblGeSWKpQilDqYG4yvE3oVoJZz79U7?=
 =?us-ascii?Q?q96YpJYIDLp+bbsH85lJdCKDffCi3MOYoQh7l2aoraJf9CIq4j2GCZnThFue?=
 =?us-ascii?Q?L/ZTBKLmztv2vf36yMHXdKElhw7OjS7ySmXkmIrrQ9ORA4F3E24sULe3OW29?=
 =?us-ascii?Q?JPj69cY7AvVpTvq30ypXMribxoKgT5AxgNWLf2jhjkeJbRJfqjyfpheih+oc?=
 =?us-ascii?Q?rMasmvXRNCY20X+W0X/qDlDJIVSUZuO3lJtqLAAZDsSCb7r73ovdhlzWVZ7d?=
 =?us-ascii?Q?DoGXYjZFmJhiEeJ/qNvkkOLvDE0p8Amo06MmR3DEG0QY0Vna5mZ4t2BblZmg?=
 =?us-ascii?Q?0VO/TWLpHM1Uz/tjchadqbiAsCvbzFi//20YlEFNgGmyfvSO+HnVz/fa7PkP?=
 =?us-ascii?Q?a6bJu/aZbbz/8F7C0UyaqSRf8fu8rcChpiW5xGjQUhVI+6WzZLmDdM3wBNkL?=
 =?us-ascii?Q?CfT40MqGW3wp0lcXu+Ib46KCPDYTxOHXedWYz+KZ0CHMnIY3p8qYVaU5TiQ+?=
 =?us-ascii?Q?qbGyNThx23rYnqp0/4k1gueJhLzT7Urz8AWBolcm73KjjIYR3Ooy+aUA11z8?=
 =?us-ascii?Q?SBsls1QtuBCyZ+U3qhUyS4BQX4HnwpEV6Jvxt1nkMXhqd1ZyxzC5L8up2C+s?=
 =?us-ascii?Q?a2jWA8Kst7TDXnsz5JMxQKKj9qDedGQ9d0UcTBoGYP7LRV2oyxFVQBM5BhTU?=
 =?us-ascii?Q?+STXYPjOFYpqpo8AjhUly76ZL0McT5er5RFZJiK/927RxmqU1bSdzi4dh5PC?=
 =?us-ascii?Q?YkSEVTYTc5QQl5BTf5Xu/qmcE1iDb1bDoY9Fg/5ztrYRpa3O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f8b2da-a4f4-4279-b2a6-08df18bb9138
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:09:58.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOc4lv+/ctf8pWxSmXlqgphjJG8v6nCIxQHR5DX+a0MTAHpyZUbni7cVQJVt1JxE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64

On Fri, May 19, 2023 at 10:49:17AM +0800, Baolu Lu wrote:

> This creates an illusion that the iommu core still insists on supporting
> pasid on multiple device groups.

Yeah, it doesn't have an issue itself, the issue with PASID is higher
up..

We actually built a system that requires pasid multi-device groups. It
doesn't work and you have to hack things to make single device groups
(sigh). People have asked about fixing it upstream but nobody has
tried. It seems hard.

Jason
