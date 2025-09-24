Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED1305044
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717633; cv=fail; b=Cc4iG7Tc21C5NwA5czflpybQj3OEyFzOlS3RqgbZzIgPWnIE6UqbxkKoy4BeyihFnbdEPdXBFjlJiorzFrfO08TqlJ+SPbJT25rPBcbBbo+s6evCvwiMQGGnDU3H3rEg69o2GZKaA5KF9EC8JxHE1K4d08NIcv2by61MWMPHuds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717633; c=relaxed/simple;
	bh=L7RIaStp3ti4ky7GQzz2UtpQWMgP/sL1U+SMuRztdU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KR6iG8lKIk4kwAGNVUPM+5K6W7EDfvckZ0Jz+4s+8oKF/ThFIApR3yPt8IwJgyi5eGBDBnznt0jtqlAtFX7Pv50Ynd5D+41/INXnxAdtna5m9HUbA77OfTTF23/dGoM9EhFvt11jWraVdLJxi99T/Izp0D0l3WQv15U11skZip8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LDouM9p3; arc=fail smtp.client-ip=52.101.57.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LDouM9p3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/28MD5tBGTTTbiHrIE7ScncCaAZHwYbpcJEH4z106uV6Bu72qgViHf0wrGGO5KUMaA81ylHAjfwO+zqP/zHAlhYSJFYauglaEkoAAY0ztXvioisGoUg3n53TaVJ1zUppU/aJ6BWmAIGPW7mFNZ+g47mG8Q5GT6obr4TMlgwGUagvOwt699JIQtUWL5TlzYIJwG24xrzfecG6QAlQ4gYEma68NwjR9MEfx6osf5XWaBgWzF+TCZv4laSX/zJfSohogEdz/ZYmhCsMYrzoX4ivhro/xts/E13ixi3e5Vd2On3TUNofkqaV+6zc3pDWDuSSVPHPEIPYZk0gzxhxr4JfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7bD5EC1L01n3xwLVKjQsyWDOuUIEdkKm6GP5afLpvg=;
 b=fqzrWML7AGgGFBCcwkSZtCYKTtJ0BVBHmB3zGpDYLqAO7U2U822wEcXSKt8hWTQgHPT/kpLUgCzCKASkCtoUX/WYDEwu3vujIM/hrvx6LyQOKG6/YMnpXSrSSF3cjzSwwG2V5EMUIl83CIet8G7+lYeTEINUjQad4SVIzuXpvGlVWZ7a1STpqI41Ogb9lHwpKj0AObuJm8yMOeylt7cNAeE2pHkFlKkBuGC3Vuyop4av384Lpnn+AeH/XPHn/InLWNNeTovfktz9sy43LwaHZua0a6AlkJvKv5xfNCCjWEL4cA1d2VA/iA9vly02sahvLF0VjZwLgtrk4DOczlnXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7bD5EC1L01n3xwLVKjQsyWDOuUIEdkKm6GP5afLpvg=;
 b=LDouM9p3oQUOcK7ZSzsClC/it2p9uB+aGC1zPtIqUNlSVYNEBLw9mrNO75rZQgsZekrhPf9nXFW6HSBicIVKyhkKYJwHY5lqmfbVca1hpj2IP/M9TznhtMJzTxunO8Zz6FK/KEc+ySHCxDiFZmvMNu4I/SiEwQY5jxX2S3lpUt/u033un2DMQIJx1jdKH9SfPPl15pB7IJrt9Yhz/SOzetzWPdj1EWrWnVyc0uMZ8w1ae79mFLIMdMF72Fv5uwgIOLWdHh5hLvKCSe9St6yZ0O9x5BbhCtpyWhV9CKMrhuWrQq13rA+ISJNMbTJ/w0EI4fyaoCMVvOvkMCNFWz2o+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Wed, 24 Sep
 2025 12:40:26 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 12:40:25 +0000
Date: Wed, 24 Sep 2025 09:40:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/8] x86/mm: Use pagetable_free()
Message-ID: <20250924124024.GG2617119@nvidia.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919054007.472493-6-baolu.lu@linux.intel.com>
X-ClientProxiedBy: SN4PR0501CA0111.namprd05.prod.outlook.com
 (2603:10b6:803:42::28) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 040099f6-1d37-43e3-b9f5-08ddfb678914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C4xqJXq37Os+0hEpXHXXy/IVA8icx0xyALvwUuTn27YO2tdM10hlhexW5kVQ?=
 =?us-ascii?Q?5bp8EU2o9i1OpsV7ZkEM2C71XC4oPEx7CacyOKYu3zuJsAGz1YDqKvkWHONT?=
 =?us-ascii?Q?uayNLQoKKfQrM2cKdrnDg5sFPm+6k6ydpd/zcLCdIh2fWhJGtXMlcZvc/3dX?=
 =?us-ascii?Q?5R5i97NNfhBT920FQqMZaQa9Uh3x8leotQnN5pvsR9UCo3s4meTAfcC9XEYa?=
 =?us-ascii?Q?ZPH8vv3O0zAk5FBfIX5jo3NrKZGU1QHMZoBxVMYrhSruuk5Y212Bs7THAPja?=
 =?us-ascii?Q?yFC5UQerqZmqf+znbJ46jscvJTvcY9AtepPHjoPw2QYKR/7d0HiQlqFDuCRR?=
 =?us-ascii?Q?9Q6LC6zloBZBZv/Pg6N3qSwo4vufxSSu04bS4ePMc+sTGoRtniMhnPSWPzWE?=
 =?us-ascii?Q?l/wgPPIn87rdea19nYwI4fQzIBbYhcQ4javJjbtFD5FbupeA920C6eAX79WV?=
 =?us-ascii?Q?9IJOuw9YnHHEUlehrZumFpQeZ1L1ATwdE6pEzgt5Gxc3cpu2ftDYFYvJbNMk?=
 =?us-ascii?Q?PhQU8XQKYP3gg4jnGI4iaSoznmaHsaLvtzUvUE3elvTD6OqGaGvMeAO0z3GY?=
 =?us-ascii?Q?6cdV6eNXAKyaU1P+Z+grOj93KXrzVyh+dWh6+xN2TysU2KjvHwoPUYDlU63C?=
 =?us-ascii?Q?2I82YatEcczhhJ6TplkPxICCBiGkIMn4jCXaErQWXi8ZW7Kv79ExzGWqYHml?=
 =?us-ascii?Q?RLy7NWeM3AaU5SRVLY1qRPqHL88ma+DLZ685bVgM1XeoEQJoehvsEohUgMpM?=
 =?us-ascii?Q?/Z2dIfkiBb6mHcFkSt38bX9sTNJ+trGrUtBtaFH/Zko2VeV47sAKn+6pqJkX?=
 =?us-ascii?Q?gN9/nMI/KkLrrK3aqZF5Vly4NaaDcBddyTFjGWl3FiOmwn4GlFvCV7NTd313?=
 =?us-ascii?Q?MwnDYPBrxmGZAfB4V2LQ7OFJx/LbDWs7EPsggvUHOWXu0RnmmYBkIv0pv1CD?=
 =?us-ascii?Q?mdw8CSgGf8TjO1o3gfFu6vVUSNbkcI5rkoZDHsh38VyhFzt21eQTVFg1mxsf?=
 =?us-ascii?Q?IZZkdEXOUJt+ezBxThuxEyvpKugm9iaA05eCbVi4L/cqKm4WR9n/5+G4Fd7M?=
 =?us-ascii?Q?l6vO7HuIF5wVPtm5mgy56wOLTVzOaiM9BBGWQvwndBUuMvPQ8XXCb607bvdb?=
 =?us-ascii?Q?tdV16AhJnFSOzpBLt/GaxjX2Vz11Oy0h/PTdNeQ+B6uLYb1tfarsL8NN7+DC?=
 =?us-ascii?Q?RhRCN/5Zf44UEX6HV3Vop2Hy9krPzbqRNn1P4f+29HgxJFkQSQUCUkDuJPpP?=
 =?us-ascii?Q?mgI6ukWlSsMUbllOXgTjihM+qCSq2HHDasZu5yfskXYOHLr08NJGNCawVicD?=
 =?us-ascii?Q?Cq74V6DTPouVtOwaCOLil0i5laXDQPOwqNTtQdqmSPfG27ZNBuQo9RWsGRC9?=
 =?us-ascii?Q?fb2BzDbZkrxbzv71w/ydpDegkf+/Cjw0Lollrb071YuJLk/6rJYEdbfylW5s?=
 =?us-ascii?Q?GOa7RL1kUeY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4gaxlttoADmgIfbnqRpkLw91rWzcRgk2SMX/6yN1qWXZUaCBSa3hJj6N+qZk?=
 =?us-ascii?Q?p5VPrFApaXdRRTbLn54X4ACxDtvevcd5JMr1YQRxmu9Wd0IaEcnoHQ+LOt7b?=
 =?us-ascii?Q?NBPWaVjF3JbJvJemjIZG0Zm91Bmf4IHdGL2dwyKzmmJ4lqsBcAQ8qr90HScn?=
 =?us-ascii?Q?kPAf3taRS5coHnQgTUwh1nR6HYsfp2MBJBCXggD9U/WI7yYbrSwkuBz6oaft?=
 =?us-ascii?Q?nIhkYqWTHJNEirqNHqm10YKRT3FS6siP5lH5+6V6YPK9pMQ+6+EWS3pPyuIy?=
 =?us-ascii?Q?1AP21rmI8urlrclUIZ3LEd4RMmP0O5l3mqnv7fimhgenA8d8QeRdpZA8ida5?=
 =?us-ascii?Q?PMFuqGG7ZGRPOsxejEHDPKad/4SRCVkD+kZ9SLEohkUSo+Bcunni1PNk0bix?=
 =?us-ascii?Q?qLUop9Cnbg3VsSb8MTVa86oxiks9v4mj43HdP7dZt2ldIAdBNCOpe+W+vgZp?=
 =?us-ascii?Q?cHMLmK9zsF9VYutKgeO9kjm80oY8EgzkNG6pL/vxxnsybAXBm2scaa/C0Bj8?=
 =?us-ascii?Q?JeYxgAnZIz+lg9KENBnmWOFVj2dYPmL1NK4h6q3AM1lbVz7nopQWUASGZYgP?=
 =?us-ascii?Q?XTjiUap7jgq6NbAmcXC/61RciT2aN5EADMOaTPZj8PUF5iyD7WTHdVxLe9Vi?=
 =?us-ascii?Q?ijOrIqOkE2mKR8QAgZJgcJsIT+qqrjocqf4Pqfglv1h2BxxsfjCWlVyUqIEV?=
 =?us-ascii?Q?dKWiGLIHcBwq99T406+CDSnZzf3f9+p25DgBJR/iBpN6KYGwuU9aQ9WaD7bS?=
 =?us-ascii?Q?fHCMN8ux+TFClicy+ZRmPVNKa7kUBpR0V+Niwz+nQqQw1aY5y0Bvk070Rq/Z?=
 =?us-ascii?Q?zcqZQWOYivmbX3OsPmdiGtIjjqh9lSFo3RqhASs5yBXJe/WKfKbG2fT1TMka?=
 =?us-ascii?Q?JpZo093FC/N4tub6A6hUaPLcvL2PQBb502CK2X15fWZOC+GKWqk6iY6shZHM?=
 =?us-ascii?Q?39zFz0G3Oi6dmrjZGAsZ5WdYlE9vyOJqVK5ADIEzlLyaJNoumm9L9N5GCcFU?=
 =?us-ascii?Q?NQMXwgG4rcWDOs7WtFWIRNZquys66H7QZBJQML1JJEA9YY9Por//G9+uhK+6?=
 =?us-ascii?Q?is9fMntGQrjc7QusR/gap+PUmaBmMSC2cxKhJHpGsgitQ/kuXo76MqnsAaD8?=
 =?us-ascii?Q?iHK7fpsTPx3FSoTY4Xb2+wLzim53qmxFaua4FEiBqqbHcYigvo3pTw4e/SJr?=
 =?us-ascii?Q?zdvrsFbJiyPF1M9wThLxOr9B7lP8/vfDRiQrDOBuiI0Ncq9LBpwEjjfIYa81?=
 =?us-ascii?Q?Xu5t+vjZcb4eXmm8nZdGyfbTfZ5JpOJzO3FGln8tyVcxx/R4D/qQLO7CE6zU?=
 =?us-ascii?Q?L2V4VgqKgc6QhC3sN+BIC4maA8vJISmWSzMhw12ZmBHaBZdHs5zDD9z/ZBoJ?=
 =?us-ascii?Q?7x/wBrX/lW4v8d5nRMcNHoIbwJky2el7hUoCN2bRjCIwZCbciDForKAw+wSv?=
 =?us-ascii?Q?B8p5uTyy6jADG7hnDTPV/fkpTWKOFBStKSTGdC0nvpeDHtMqvQWFtgd9d4Rl?=
 =?us-ascii?Q?z3Q1tcFLNDzd9YvJwu9UiECuwcErTVBt/LysKsHx8IkU69/EQ3c3WeODm9wc?=
 =?us-ascii?Q?R+ld6h6l7Bhq08BJpW0bxVqvGsmpkFgLPy/N0kQI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040099f6-1d37-43e3-b9f5-08ddfb678914
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 12:40:25.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQTieK6eKV1Q4aUrVAqJg2Zea/zcGO5cL8w5rRJHj8OyfGSKH4glCZW/uwhLzHDi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

On Fri, Sep 19, 2025 at 01:40:03PM +0800, Lu Baolu wrote:
> The kernel's memory management subsystem provides a dedicated interface,
> pagetable_free(), for freeing page table pages. Updates two call sites to
> use pagetable_free() instead of the lower-level __free_page() or
> free_pages(). This improves code consistency and clarity, and ensures the
> correct freeing mechanism is used.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/mm/init_64.c        | 2 +-
>  arch/x86/mm/pat/set_memory.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
