Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7A48790
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G/0SZgyf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hrurz1dqF8mUU8CADNIOfPmlTaCUTXdHsXRsJQC5Dt0pOb7edTUbVF69ui0PpgyM76IG+sACjbRO15GXgRW8WV7uLhujqoly0+zLMV4k+ygN0hK0rP9iR8aQo3UjeKZzer0lgchs7suYYz5lWekxO4qBYhA5LfWWrstZiVn6/3wrUzmqSjF0E3Z6KYzKspW+5SA5x+B3TCk57jAEzQdKEFNfFKpPD4OeYRy1zlt8CmWZV+u5DeMzr3jd8/4p0I6SMDrOm9kj2L2kKQUMq1mEMKPyG9K0j0tLutytQf/o5Gf1pPsakjc390TAhUj+wP3cMVRr0HQ35fHe0DdgJemIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebKit2nWFQC8PSsmr8cs1N/Sow9TuBlkWyQJ9uKbl4g=;
 b=H9V7+OwbVMfq0O8DVe5m7H9Js19Vsr0wlmr4SmCVkSDvJKhdXOz1h1O/pETS1LSNIVwxu8OyONen7C3RWAqkfkIZo3KYrHFlZFwEPuRxMZQf+NyAZP9DToa8EcL4y8WNcqRnNvvDgcMAcuXJQdH2nMNgIjk3jXLkbLeHZ/ttemikRsX8KgXlC6uzS5AZvwtIf1A00T8HmkQgGA7YS4bvK39jaofn+pz9NplzG6W3peTGPZ9H9kpXjTG9lp5ooPjP30LkYc4uNoxcGrDK9jB5W3OtTGRSxivVktIrV122RnjAgaqn4KYb6USkJd5gogKrcXFGBzPsRFjn8ejICNsjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebKit2nWFQC8PSsmr8cs1N/Sow9TuBlkWyQJ9uKbl4g=;
 b=G/0SZgyfpqW3cAzXqwx44CFkQURSG+mzwnLqdwuQtJmbbrGRU+KCqZWKcPpmWPDVdWm4AWYsc15DrhCoOZZrHqh1oov2cceOa07aaUQhGGw3xhQAuMgeF0jm0eeqYWHXwVUaSe6zm5QBT+iACBtK+Psd6ScXr3QmZ/P+oLbKfHWNcIiHpAEFi8IBYLGFJVfuexrVG/C+2QznpviUULjVNEfsnP99U2npwm4eu8tqpvTDr9TTGjyiHIyW54EBXGTZGG1CncDwmSyk4XrzE2dGhw5jxiWe8kl/eNtTm3C6nJJhYYDI/gN6BkR0Z9pJvJb8XVudk7goZ/RxK2kcRu3D5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:22:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:22:15 +0000
Date: Mon, 11 Dec 2023 10:22:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 0/7] Convert SMMU to domain_alloc_paging()
Message-ID: <20231211142214.GG2944114@nvidia.com>
References: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
 <20231130004905.GA1395649@nvidia.com>
 <ZXcZL19OLbctV_W-@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXcZL19OLbctV_W-@8bytes.org>
X-ClientProxiedBy: BL1PR13CA0254.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d906468-fccc-46f9-377f-08dbfa5492c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+T8bOjx7NfqBYDuxWhqM8NPx0/Z88dLclsYOqKxsNSo56UOEqqmm+45F8+k/wWod+LE/aJtRZPyFggtyN40roakSnxjur0JbamWydfG5Tm3rWr1PwZiuM1P9Mqj00UsYtIGb7HaYpXFFf9Y+z2Wk80KJXqcQuab0Tel9hzP7Nh2X4vuysMzpS/xmDw1L0zqbxKkxA0XmpJFrgxh9mRy400uhe2K71Sx9g208hRGHmCNcGdKwtKyb6bJ2PFuW33YhaXOYBSc0b62d52yr6WZuTAvFpJ3fwI8oDbx7zPUUq+e1i+1JC6i+4tvhkFUnnuSNrGlogNdWsxT7GblfqWRW8ybb7oMWdhyE1xnicpbn6MNLctNSN0BPvVJEwKCSxSUCo4Ocj/VGx5YHh0KGmabZVUABSvODdwhozyZgrPkxyfc8WSIqhcJYqQ9Nlio+rofIKR9BLDWLxB20pX0QQTppKMIv4vPXw7yJnBL6RMPeNgnS7dPnduGGawutlBLH+tA3m0WtN46ZOHdB+PTd8eoLyPMRY+jHdKrql0no5NWoYKyDhg/xScnvyrNccCuJ/Yh1vYp43HUt8Q1JKq7T1QeRP6TjKTVvKd0AWsCwc+MW3qA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(478600001)(41300700001)(6916009)(66556008)(66476007)(54906003)(6486002)(66946007)(7416002)(966005)(4744005)(316002)(38100700002)(86362001)(8936002)(8676002)(4326008)(6506007)(6512007)(36756003)(33656002)(1076003)(5660300002)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V+/2rAVe+y8ueUQnf1UHBUR4TPW0X095u+xtoQG+Py6L62jduITCk363usNS?=
 =?us-ascii?Q?36MLaNVROVNaZx3suHHyM5N80CcTkQt/2Qxmu5nmOIAAzQ0thHkkpXmRqSJ5?=
 =?us-ascii?Q?SfTzM2P/Mq0P3T6kDbPFKMm5FQ3Y2he5Jm06C3fptFkbrW21gbeUlnG6rxK2?=
 =?us-ascii?Q?vvQSY5Urw+IP5iIjRHasIgKBvPXDFHHx5K8fWPbrGQpH8iFbeNnf0ttX1Ppk?=
 =?us-ascii?Q?l808I/7KpadhgSEbplxrShEHquZ0AKNxhct5uoVSRn3eB7fa9miHchSiZsLG?=
 =?us-ascii?Q?SGkVGs1/HUjOqiU3G8o/WSjOqXYTqEwodbHFbgm8GjXc1qRognGECccOe39b?=
 =?us-ascii?Q?O9O9cQPMkfgLskjNaxqDTwWuilKAt8DaULzZhRtF8PCfNKa0fiNBklMNP9Ew?=
 =?us-ascii?Q?CAZX9tTRz0ulTl1rh5QJ7BPPBJc8l+T2LEjI+v3S9YTobKb3/Nh5HEilFDhy?=
 =?us-ascii?Q?Ngi055Fc8g6oXnpEStpKdqo3W6ZQHdK7WkxEpCy3ZswZbudO2rP732Rt5mWL?=
 =?us-ascii?Q?B35lCXA49QW8dxe/lvq5yUloePqWgY4dbeP6wIwQT9N/hF++yUfLdLSk6vRs?=
 =?us-ascii?Q?WI77LReGG8Es2cK8naM7LCmBk5yChDC93tptMQp9v+g1OrmQCpHORZUVfFL+?=
 =?us-ascii?Q?w0fdYN0TIGeOKBx783haU2sOufV05Yo2Ph91qp5X3KCDZEjv2hXw/xdeqylX?=
 =?us-ascii?Q?34s4WsHgU5Ta6kMLSk9C2QFpjto5D9Rh1ns+wDATkqaDtjQkwaLsb46Lwl/Z?=
 =?us-ascii?Q?3xacy/DJVoCdIR9BkMmj/ujAVwyx+nCVnhb2Jq8l+nt9Djg+p6ZAJhQgSOKr?=
 =?us-ascii?Q?+RfyPFs3PJLAdKeYqS8DHqE4c7NXq/aZGDwBIeUYw7lS4AXwQbsgY8i2W8WF?=
 =?us-ascii?Q?mKDzRBKHJADuI4c1ijUydeTU9BoavIkwcCs+NHSS8Nw/RO6hutD6uWcS8KMy?=
 =?us-ascii?Q?JwnrzZ9IvFsc3tDZsrBnydhILyO5riDxuYvd9FaUQz1ouZm7r6uEfcNytL0J?=
 =?us-ascii?Q?XTy3TUxCVKo0ApMau02GvU2mXMgkgzHro15H8Lv15bc7Uv1fJ9YP4vohhl0g?=
 =?us-ascii?Q?NOe542zfZ0TXGaZ0qjbY5qonS3nsCMtGjcLDWykJ39cVwyRsKoMk0HmDUdle?=
 =?us-ascii?Q?weuAT3/nlctrWIerCvNejbjV0eGkIEQsDgBT7obYH7UxKBNmX3H76FD84HHx?=
 =?us-ascii?Q?wGOQF3+NrO2S9mkyY9Z2zDEeRuOY12S4KOMbwQr4jOC0HMfjmu5esAlCqEfK?=
 =?us-ascii?Q?2rK+rz3k2gMWEn6q5gTfRmqhCELASqrVmdQqaDx97+Nw2xh8gmCiRs4vdFvc?=
 =?us-ascii?Q?RDpfukIREVO06OQZbqwEFG3myzni8JdyelQNBCnHfWtl6ViQqav6eHSukzJX?=
 =?us-ascii?Q?zhklMn/EfUa86nvY2bSfc3QTze3XWx67ZFRiUrCDNCZHhu5s40ZAnsXjpZsf?=
 =?us-ascii?Q?dyPSlA94OQDHaBv6s60PDR1JP1zA7mZ3CRT2w7eeP89/FaO00NZSPhFVCBit?=
 =?us-ascii?Q?IW/OdJ5fWmOS5Fc60USNWK0sCILn6vGfRGJQ/TfLBjgY4nAzxpApxXskEIyP?=
 =?us-ascii?Q?U7C7kTProJYZBAtw1LHVf2EFOonwXlcapN0hBZbo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d906468-fccc-46f9-377f-08dbfa5492c3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:22:15.1153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWgSWIl+JMEiof8AFFLEZqSa17I3DrbQ2KOPWvZMbmwAYNFXkRJ5sJFxcT+75oZ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

On Mon, Dec 11, 2023 at 03:14:07PM +0100, Joerg Roedel wrote:
> On Wed, Nov 29, 2023 at 08:49:05PM -0400, Jason Gunthorpe wrote:
> > This is still pending, it doesn't need rebasing on v6.7
> > 
> > The DART patches were merges so all the dependencies are in v6.7 now.
> 
> This is mostly ARM-SMMU, so I leave it to Will and Robin to
> decide/pick-up.

Let's have it in this kernel please.

There was a v2 two months ago that got no further comments:

https://lore.kernel.org/all/0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com/

Jason
