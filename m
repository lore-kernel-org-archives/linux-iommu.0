Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6EF215055
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 00:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498141; cv=fail; b=hXK2TFOv3d8hvz1XoKQG7/x8kzJbJXPH41DWxGx8XMg9qyb8+zFkZwBNzZ5sPXW1dBqhARum8kEhB8KduO3X1VQDusG45unXFnIdRUfCP9IU90ej2EtWMC9dVoqVs9lkKlJ/GfuCxYpwH60nTZSEJ8cpf50G6PKieYPjg1+zCjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498141; c=relaxed/simple;
	bh=202uKQ2RU25YjxuYR61mxICfb6R8qTdXMz6djjJDzkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q+LchqONVeOhPNfyVvh2yp3KflUbyqlmaiIin81CaBenH/BZowasb1YDueUX14SmpnS02r/FFPjEZMyaa3FHi5Qd9lc7EDj4S+818B/s6oXgJvzNvLSeXgSye3NXYIScnKLTBqpjIIFV4ErpPZqsrg8w7yig0ZEEIgUB6SG9EZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OR4sMpZt; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OR4sMpZt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2OD7tvW24HDWyV4uGLh3pX0c3b3Vdy1yWMQE4Orj5isTOAD9BYucsSZ/FTVi9qArWH6Ta8sustSw3c1ma85KPRi4RbZmt14Ih8lz8bUWUjlWTsauRY04tSXxoM8PRzoSBek5Shmyk9rSxjxB5EOduEfkFZH3tiSv8232PGsjZJT3oqjAms/XrpAVW7UXL3P9dF2L5CqVqLrBcrmDgdJMogSSwyX7IN1afCb1LiEIJe2HIvm2WtHQIN1b93G+x1SeLEYWIATMnXqz81PzJlWI8cTVkgfRec5FtJLWrsa/fXugb5MsLdQy7Jsu7MTuVtjn60MhMj7yzIkuFVxcQoCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=202uKQ2RU25YjxuYR61mxICfb6R8qTdXMz6djjJDzkQ=;
 b=pFAcPLxjiorVoC5x3Bj9bopJpjH6bVJGeq9ce5WvYmbnovJtLEK05b+ojVWXXB0cSOxaUH26FVUggv22iETmC6hQz1sOrFzyGkQFASywYxvPgXQdMohAQNSywZF3yLM1AH2/j2mGTTJ8g4jaTFKbiBhqWTJYmbMrxdC0FJtXrLvX9BW2jjljygnC/q+2WDmUsN11I/YRv830XjTV0vKMYCKPXEML+9dW80mGh4K3aWIDSfwVA42ngUIfM4KKvI7JW6apBL+r1sMVytgg3FMxOr5LVtWEXvmrQ37qTnNu9s16GxU/MSCKKQLQRQTEpPzuXk8+El0s/PLLYx5BL6LyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=202uKQ2RU25YjxuYR61mxICfb6R8qTdXMz6djjJDzkQ=;
 b=OR4sMpZtgQfD6qr6b2/v/Sm3Qs9uLzZVmA0LgWODb8vC108AeXZsMpbM8eQB4HREVtoWE6zd+xbgybMGCkzmqA8iFQueXcBnY8DAkq2rDhi8yQrlXc0ljI2pELbsxDaMz8BciFEEvrl5ST2ebrNUY8oKG+J4JgFQrty8BIG/uoXWzLBNPiFIlTB5xdKOh9aTOTSZcQlRRLu40IFUlwzKk55Di+CsXH7gngPuuCMJhHFdnRGN0PnXtGqAgMPZ7c+PQAXR9ZU53i+nG9K2hPoF2pdhmif51AjqH4xFoAzng6jvB9OtNILA5tOTMNWIWH13EfFpWN2eqxongeYDQUc02w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Tue, 3 Mar
 2026 00:35:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 00:35:33 +0000
Date: Mon, 2 Mar 2026 20:35:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 00/11] iommufd: Enable noiommu mode for cdev
Message-ID: <20260303003532.GA5933@nvidia.com>
References: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
X-ClientProxiedBy: BL0PR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:207:3d::47) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9e4933-6e01-4cde-9952-08de78bcc7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	753CkXL3Ntw49uqExhUHdiihlc8AAPSSZndIJLg5luFDnEOaYks23MWaO6X6wEd73nnSDRy4CU+ApkDxdzxVGOWJbyZpYB0lEXOCDYglDU88VXbeKRLjvxsQ4TJqw8OSxAZBEmyFlYdc/AiJe/Wi1X25/eToMU3zPvqbJgHt5pmRetHAYs8JOzhqJ6RkUx2ibZtN/ZUV25fuBAQbberPQyY2MhnvFSsJQqLXGScF5+GUsT8RQ6WEGPrIPMdS5iyCqatUrCjG/m9NAvZ1/RL9UljUXYfsrydjZAgZg8v+XF10+qNQRORUnZ8BL9BUSF9VRzVGvPwgeDDR7mijqdviSZOvlLAI/5NkVPpw6ylVlg0uVIrifidiF8yOgtJTdtbgSNUsp5jHntGuFLienOJiZEYxgdAgMS3jAbGqa6kPsvJ8HQiJTtVkP71nuOgb18GV7fYa4sTwg64epp2snUmVqZOeUz1q52jHDYRDltg1DKn+8e6wV6343cwWDd8jcuo0IOf3W/do4orNAjFwqukRVCd83ocbgGLjIKgeOGlYvBx/o+q/ZSgfQabHjTf2y/wp8xilsa+K1Fg+idq7MTTaFP3GaTZ/OXJ/p2MCm/0VR1tPmT4eKXFmkwcnkm2Cm8aJGy6vdnZPngkbaD6pa8geZDLYd7qGRLwSt7+0VzhbvFutIpDWAyxGPOUzM80q6rPfsH1s7FqRWBrr89cKuiwm9p0pTcVQj9BOFNBpmjqUs10=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fnRnZgB7yzCtuVY+TIf3LQ2ADwmrcevSQtxfM03I5E9SUJHfNP38UgK3YCrI?=
 =?us-ascii?Q?NkzuAyqYrvQPgaTSWcH8JY9/QrlC5bpr9wYoK8a0Vwp3NCt5a+1PS/Il3Uvq?=
 =?us-ascii?Q?hHmrXO8FwMG6443nHw0NFvnZLs8VEHohUOOtSe1kLCml4lr8odGRkkqrqCXJ?=
 =?us-ascii?Q?DKvnHQXIZmin+0Ew/VYFAT1gt5+wUSR5/cB2t9JRviuVkjZ4P0iw0mx8pG4e?=
 =?us-ascii?Q?S4m4h2hWhpbheH6OGXJ3woTT+L+pD6CMjpAxas1x0zgkD5VIB88tWGniHZZ2?=
 =?us-ascii?Q?/n91zvmpaOIGqgir28SFLRu0SFHScsG20G5SN4z06wJ2Ztcl6+UOQB387OfI?=
 =?us-ascii?Q?7S2JznUizD7k/na3JaF8GmIXUluaWmcQEhUGCDmJLLE/kOrAY3jx9IwhqgqE?=
 =?us-ascii?Q?ZZJNNMfzg80z/ba0EqdDIpMPU6T3dedQlE9eybzZsJ039DgJLOz4DNllZviJ?=
 =?us-ascii?Q?c8Y2o1XSLQZ/FGqRxERBo/gItm0dAdSJgDSDJxqh91qf+UVPvjs5mc7etXeE?=
 =?us-ascii?Q?5qtb4RnAyVzDTK5DKFTWbf97k/jb49ROtgTSDwcBYo0nBTzX6b685Xb665AP?=
 =?us-ascii?Q?atCNcv0OO8jLmhzYDnLHGHICENyk4tIQZiDIvhixOOtJBeUxna12lcT6M9Ee?=
 =?us-ascii?Q?PZDg2L7gGOiBFAZ6lyvpaaXS79sKOggDWfB3voQddsPNhOYtvXf0w6Y/DhXV?=
 =?us-ascii?Q?mdB8oqfEI2VfHMWg8DpUHbQAemOSPVv0+A2tPVMar4vpTJFVG4gwZ1YVweWL?=
 =?us-ascii?Q?GD6jwNUfKxAxF+8JVsyCVx4MtJRAKCluOxupuk9H2nJRaIYOxLVluhP0iaEd?=
 =?us-ascii?Q?YoE9+KHuT1KXQAP3PMr42c+P/o3a9untaYUpHSPSE9jBKYWO79Q1MlCKeMc1?=
 =?us-ascii?Q?F/AA/QEez86m+D5als9lMcXiFHcVkXT+6byYr2W1OOaesvWlJALD/D+43eMN?=
 =?us-ascii?Q?NhLAPy9xJ3CR6OGlO7GV3iEY2NoSqu+1zRbIePGyWM4NYX1y6MrExh1Q0g9k?=
 =?us-ascii?Q?mDV7ZnJhHiFk6AZi2YffeHWzGD6x1SuP9SDkncnnzwtFAE+e4rBKvZk/YVk5?=
 =?us-ascii?Q?2AqH5Da7H8h59huDbY6bYZ3Ju5PNRhUdJFnxGrE55iAFqIFFKoGqZGDyq3wf?=
 =?us-ascii?Q?dXWLllrdPdwTRZXBqh5ILBUTmY7iH7comXolrXqhOw9qMSezFlP+Kl6w/QkT?=
 =?us-ascii?Q?UP/6S2mZXP++bb9JtiSc9sWTcJL3pEtNkKFqTzIqYy9Y6GkqI3xfBFSSabMM?=
 =?us-ascii?Q?ykGj8D+X/B2WNFTODWoD8RKaJ+fvQPH8yUSphplv5bo8j6L67/BN5eFKKUNz?=
 =?us-ascii?Q?cQnPPl1/R0OZ+5GiXz5rCaaY9CyrOQL959ZV1gY1aUhJGZVtYXlWW1aInIfw?=
 =?us-ascii?Q?97ig0zKdpFG0hosQjQZHAwFyUhVdLosqmpn3HQnnVmubFkdJxUbQieoS4GgQ?=
 =?us-ascii?Q?lUgz1lzixT1nQ69GVuSbWgoqEboTdVSKxCITExNxN4+JP51NqZW4SUCv23Vx?=
 =?us-ascii?Q?+Mfj+ZHmc6X5gx811N02htnT1Oq4XG5zcgOiPf8jnlkNuedinbdTVvD7BGA0?=
 =?us-ascii?Q?G0twW+r0t5kRZKu+l8psxZnKxI/AljDFdVrtV+WQ7ZHgk/myey93XnOif0pp?=
 =?us-ascii?Q?4lB0KVk5qPJaHJLRMnsrWjpA+Qia+soO2LprUfPDsw9ICFY/iVQmcjzmG9An?=
 =?us-ascii?Q?XRQNZ7rz2EH17bmGqQXwmLYnK5+RxUH0j0SXRZwhQ06yEMIeUSKFfqH528M7?=
 =?us-ascii?Q?xQsdWI6ZjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9e4933-6e01-4cde-9952-08de78bcc7a3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 00:35:33.4862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bbytr9Suh/NGuesrLWTpUeAL+ZH6qaYgM9WhYGMbZ9dn6b2Jjw5ewPCPfIXKVGvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778

On Fri, Feb 27, 2026 at 09:52:36AM -0800, Jacob Pan wrote:
> VFIO's unsafe_noiommu_mode has long provided a way for userspace drivers
> to operate on platforms lacking a hardware IOMMU. Today, IOMMUFD also
> supports No-IOMMU mode for group-based devices under vfio_compat mode.
> However, IOMMUFD's native character device (cdev) does not yet support
> No-IOMMU mode, which is the purpose of this patch.

I browsed through this quickly and it looks OK to me, though I might
suggest correcting that FIXME so that the get pa scans the domain for
contiguous physical address. You can copy the loop from vfio probably.

Also the kbuild error needs fixing, I gave a suggestion for that in
the thread.

Thanks,
Jason
