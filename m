Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131BB15D5B9
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380186; cv=fail; b=gv0A3KisT5hVWm1or8GLp/A1Hbmr1cV6yfO6RWsn+Z7qcYXXAHyt1LvsTSd+HzppeOVuWiMVhKEl6m96eaeUq1w5cziHS2WWZjCJ+UaStLN5nDy4Ndngn/sGBpN2TA78PiGw/xXwOvVSeM6bYoQKvVJk4ZELdxrzyF0o9ZmRSIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380186; c=relaxed/simple;
	bh=gvMRVUXwPqcXj9AhtfqFxGdTL3B3hxs54L4wzUG0Sig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=elj6pUD20myf3Du2ZrNAld0qygfZF28hmmvUvVU3ryja2y1IeufhR0nrdDyY+zHLGTp1vOjgf1vCUybCSvUFOsaFbCoKUtMP7hLuvmf3ZFRWhhrNvcrL5Mpfwrzc+HY2FFij2Hg1ihCkfBoz4rHgm+ZAAFBCAOz9esH2OTI5aBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gKZSB2fE; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gKZSB2fE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhA/eECI0h78ROn1D7HFtJDTtIwx95rjbnSKAQ1csA4mZMbMK6ufeCX4KuXDbSoz3mAzpDgEIp+5/dWa6zC19DCXBqOwJRBT5IGCspOY9h4gZtGvBjGsVfn+fmaiNVTxZF4Qx8b9W+dykCLUdaS59y1sA9+JKoxlbK/wYBg89dfeFxUtzeJPRQEJVVDEuXvdbU45AH2He2QRhQmTDVqERYHdK2uc7hFDd3DC0A3YstxTQa4srwr2aVRu5hleK9X1W/bdTR1t4SUGrnbllCEZL0IViy4A5lZY4YfLCoQvaRjY8R972nsb7GKjFJGw7AHKRmUbQnXgGvSSXRvsDWjY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAAbryAYVEMmRv4XVzVFDVPBl2T+1SQMwAF7xh5hhRg=;
 b=cs1YIA0CxY9bwhV59IgY8J3rapeUGUlkoCAU90kyx3FCKNQFh6uVs0iyH04Dy1IAoFBQi0O6XnSfXiMk1mR92i8ikkXcJIhKIxjo6jY8gkoaiWsdrD6SMaQP0f1PvRFCXbOR5VD7sNrq/F9jGr7eA2OrwGNTWZF2gOYhHf7YUhIiToiVSYdq9D12EHwpoldu/X/DWIF2FUez1yMGQxf5oHp0w4CDWruQMYM3i4j2QihsPa+X26u8S9Av1ZHokRMkPxagOZSvu2ECbva3/eJAPY/tiQu7uZ90DMpDi1IIF7cpdH1Z7yUrpNDwN7qT6hCiN57SzkkUAGdNOeJEa4eOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAAbryAYVEMmRv4XVzVFDVPBl2T+1SQMwAF7xh5hhRg=;
 b=gKZSB2fEwi/K31td6oUyKfuuqAE24p+YbdS7ESUeiIDbZXyHpIF0AZR1nnE0YW9BTEfkaAPsXpw8fYIgs7vD22mf5XdqGawARKhVPVnbdJAPCPIwt7OzOLVyJU68IEWUfdAqZpV7DuF6qxv1CZhAaysD9nd503syxYJm+WKPhrafst2Nx1iQfsJ30nxY4iymTrm+JANRuwZN5Wyx6SczuI5Z6hRhJMjWo6g0kk9srAB7Du4iWiMCW6o2xr12ZH7erMEkmFSZCTCZ7j5X2qwXtW7U9yirDXG/IEDaWlkupVKzkyYX78PIXakq+BpDUGSDJbax3hDAS+XI+BjILDxr0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 19:49:42 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:49:42 +0000
Date: Thu, 26 Sep 2024 16:49:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v4 4/6] iommu/amd: Introduce helper function get_dte256()
Message-ID: <20240926194937.GQ9417@nvidia.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
 <20240916171805.324292-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916171805.324292-5-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: LO4P123CA0458.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: c78b3e7d-0b44-46fd-4d36-08dcde645d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nj4yBXiCEl96mU97mdkJ6uxAV8wNfj+irAb6NRxAEzqMvmLDnj61oXmYQ4Sk?=
 =?us-ascii?Q?wMDEN4nZZ95UyPOYCO0QqbD44CuPrCp5esgmaO1cCbqfZfi3iTNw3eVP5Wdl?=
 =?us-ascii?Q?KvoQBjk8sIDh2Stckod2NFYcBU9+Pd36oortC4hlFii+5vUZf+7YK2G3rElu?=
 =?us-ascii?Q?3V5SmtQItaRqWijrbYN2arMa9OI6sy7g+69qgrq7ZTj8MMIkD+0xA7ewCTim?=
 =?us-ascii?Q?tKjbhN2YWU8tX1mcKjAo+OZbch7qQ+MXnRI7CB27wlxHYsUkhbTi1ywaXa+c?=
 =?us-ascii?Q?fXvHKkjv3j0YU+vTc4aANlrCSrNh/ACHy5oS6dipMyYxRPBEa3+/o6ragmIR?=
 =?us-ascii?Q?WLJtmtVMuFnnj4jRMUp7/CDdh9aTCWkp/kabMhQd9GaI7zF1ez0B/HbkIl73?=
 =?us-ascii?Q?YwABVheNI3vkZslJTBw6NoOHHHuoQ8/wCLK73L7V20yXj+Z+siHSHrpX1zYP?=
 =?us-ascii?Q?q26Rbpcz9y5modZF76uA5r/6IiEN56Xy5lJBpAh/eXw0PT/o7j5VXu7J2gDg?=
 =?us-ascii?Q?62IPiQV8121NrzgpPMc3R3nwyzgBbrAaQSIVERqO1Igi4UXI5h7vUUtGHvyQ?=
 =?us-ascii?Q?s9QMik6bxCiBebPN+5zkGGEWpVYo1XKkBbhvu2/00crP8n54e5VK3nDfAv+I?=
 =?us-ascii?Q?qmOTqzAvLKRRlihNd7d6BjFO6sp++Vk8CR4N7n2IzSEtAgipSo5UsNcwXtGU?=
 =?us-ascii?Q?ysojE73DAEtYn8CPBK3F+fhdjMivUqAJ97qrk+D0PQEVCOBXdOT5jxhpfxXH?=
 =?us-ascii?Q?mOYJnSgoyoOlADvvCoVLZkvlVncvbQRtIyrPsODJ2rMDciChLApAupC1zWRv?=
 =?us-ascii?Q?+BFB/kaJ97ld7hqal5gc9iK57R/jvjHVXMjo8bdg6OOJaPEPbYfWoLSx+XHe?=
 =?us-ascii?Q?CKEbA65EO86nperHL9zAF+42+z1pove0RBuDq4R3cGDOm2nCs7C8HsmidT4b?=
 =?us-ascii?Q?jFvd3q+ZfrvwWb30PIUG7Z4REyhGv5H1YDgPkTrVtDAbLWiTIC2oPeDf5vk7?=
 =?us-ascii?Q?tbfHpBjw9DK9QHlxyz6U3mLii4zIxEEQ3G53VmXPRYyNHLosn2s+F/TJSa4P?=
 =?us-ascii?Q?me9fUOoDwsYtyCgdX+zPN3CpLuK+GV8ZcggtgFuT4GIr0ml75lzZuwU5UVpn?=
 =?us-ascii?Q?rflc348pKcLboRkBdGVQzotV5PtQBIZFC4PNpeU7RbZN7UDMJa65k0GIvhjG?=
 =?us-ascii?Q?wUMZ3dcr9M7G91tpkGM7RqwhHzLiwtZxy7cclR2e6OzKZsV1RedbkTYK1ok4?=
 =?us-ascii?Q?plDoA939/1ChivMY8Bq0wltmlcYCOcKaTv5i9CV0dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8O6oDOJkaSxlG0xmpUbm0m+wp6pJfLQ+RjE0XbOyK1nS9JaTsKqH1K3m8biQ?=
 =?us-ascii?Q?dgEPqlQYYqwGPvCB1QBXYtpXO32vNBor5wVZFYDfKkH4QrYjiR22hnBQj44T?=
 =?us-ascii?Q?K0WwDDbBNONK26FdJfigwF2zliKJXqWYDWlud6Z5ztGisCvzOmYan2VdRLTm?=
 =?us-ascii?Q?ccKkBoue1swLvt4lHp+XR1vBH6ebWiRMvqfGmDUUs3D94tb1B5xHNS5N7qPK?=
 =?us-ascii?Q?G4lfY17p7y+h/R1chRwUelnBz+Dcs6rnmHW0EAw1Pz+w7LbS1AofX2BWd6SH?=
 =?us-ascii?Q?0lwJBqzxGxM13MmRMNhAq5sCd8WYKjrLAdQ6VLuxILhBl6aZ8i1gYUnjE17m?=
 =?us-ascii?Q?ZrtyPCg4kGJ+36iDQJgPcY54DfVvwNPQp7s/k3ZEfr/Je0ZGA/wjmBSF1rcV?=
 =?us-ascii?Q?52lzOmyu+wEkp8EQr9jkvnzY0MJcvRY4MyHYzqFe0nbBb2NPKlCzwtgPB35h?=
 =?us-ascii?Q?Va/d5yg5Ys7LOXF4f6WX1GW+ztJPVqOl+XBpn2EanmTFDV2IieEadzS08Xuk?=
 =?us-ascii?Q?IGAvA+5aPIsGkw2tKMD+2HTp24WcsEvGFkfT38NrnHLOLikXDT6VkNLU+Sjb?=
 =?us-ascii?Q?0Mc9byZ04LTjET3r/Kz3/h9ka2c6d/CpY9roFK7IFc1z5CCXryrDPyHwXhuv?=
 =?us-ascii?Q?qneAODK2nPkLjVgZsnVgkMYWFx6fuC418kFrQkb0oIkSydM2AaBo8STsA7VS?=
 =?us-ascii?Q?9PHFB0cm8Eqf59Mr4N8W72ikuyijHz4lMGT+wVI978gHOftrIX4zhPljGpxA?=
 =?us-ascii?Q?ydztltgXflzTpbvStjs5Hu1qJjtuMiU6Tk5Tsq1cYJliDJNbiext+2Z10VL0?=
 =?us-ascii?Q?YJQhJJKzDO8ri0G7f7POGOKFron1yc8rTd40MnBeLhw0TO8cLbokXVyaoGUU?=
 =?us-ascii?Q?1wpNysoO5dkOlBYQgluRXYW4/gDrWsuEiw1r66TL5h0ftMAnc4QgSnlC7kJf?=
 =?us-ascii?Q?4LhsM+N61vuR9SPpkxDP6m6uh0dLlguY7wJ5zvBPAvw7fJ+je81t/flESGSy?=
 =?us-ascii?Q?tBMm9s7pdWH3ORAYO7VS2T7M3vZRyuy9VVYuNZotpB4o8l427h2f8arXseJ2?=
 =?us-ascii?Q?pPL2Ck27RbdhPLiV1z1P9R2NCJdh/LvkR/rwEO716hEkmeUtuU/T8BNooITR?=
 =?us-ascii?Q?4Bu4FS0Nu9Wc3LT8l2Jpbu+YZWSmZqwBtLUVQHK4vVd8CwgjE20S0ctAcFfJ?=
 =?us-ascii?Q?XgrxRQIePzyc9dOJZQjBljC6h8Cfx8hRyL1D/s2zPzr4K/ZCut+nOvhtzzLO?=
 =?us-ascii?Q?ydfZDrsParXOyB+vWCW5XOBh8+vT7VuWAQCGj3IO2W9cOLD01zQq1iF6XUho?=
 =?us-ascii?Q?x902az1nojUk3J+PPUS51gA0aO30b8r+Ex0/AsneTbsRZFCBHSKPTmuYmL1P?=
 =?us-ascii?Q?ZLfAIzaZZIEpmD9pGMypHxe2MVgZPgAFiQ7ERPIgIk27M3x9qJ7Vwbowzq5m?=
 =?us-ascii?Q?XUuLvOsw3kp73AdpyUYCOAxOHfP/48eOjVgDUB4VJusjnNiCEEvDs+zqa9lY?=
 =?us-ascii?Q?DynH8GrjOBWjaKuy0+qWq0IqbbI3Ab8JFGceZMpy2/dSE6Rli7mYp2pb+DAx?=
 =?us-ascii?Q?k+CRqvU13uUxWmKJf1DsUJSf7l0BHp8BAhooPZ8Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78b3e7d-0b44-46fd-4d36-08dcde645d09
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:49:42.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFWq1Tmovc83yWXxKDvqYLV37793p8ItWYxKpIYi1B6woAS2pu5NZ/OEt53ac1iZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208

On Mon, Sep 16, 2024 at 05:18:03PM +0000, Suravee Suthikulpanit wrote:
> And use it in clone_alias() along with update_dte256().
> Also use get_dte256() in dump_dte_entry().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 49 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 9 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
