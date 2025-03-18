Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D820C000
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300842; cv=fail; b=sXeqb3k8RCKtNQKyImoV/Ew2Bwfko73XXz8CLSSeVedpWVDPJryfHMWWSMV4cWeN96ZUO46bkpn8wC+BSqLO4Jk87+sVRnQ/esKgsLjKiz/HfueOWJYVibFdkZmR3vu7BE7/2GkRq1T4IEWD9FJs8LPt9YL8xizRtbVJmy5BE2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300842; c=relaxed/simple;
	bh=DpEnYaarMCsxnSvbLbh6ayN6BEbsyqsVJ3uIIdr37rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CUeDJDTr1q2QAKNComNKyqqBweWxwh45BurMuLZNv8vaGkqdOJafPRkHY9LdXf70gM0LIbl6oZnwE8KFoy92IUp6oYjB8f7sF0bADNvazrwOFL3EaMtXj2zgsPXNZgX6gQcBcSUYocqxpy5ph7zEsbd3w2KXcBdFsDRFQb7lvDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RkqcdhXc; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RkqcdhXc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwTNgqDI6aThaeloPo1l+VbvE/3+hnWNiQ5iURRxWl0IaZIJMyBZ5MFmFUqY1d1LJl1+/stUmKTTzQSo62eDLozX1bzZZ+JvQkkBe8v5j2oA3dr8MrNBuhjumOSv6zKY16Fy2RYp5BeioSUZPz4FcZFAKo3xJJHTlHhPqLf3d82ZlyLqmclBVJ4z5yJylvec9S+TJ61x3td766CFEiPbtUhi0/cEX3GLMK6KjOpUX+bQLm1D2a5cZ4YXj9JvNsUa/vs0dR4OlYKmd7ZZ8fbevosBQD4lTXcHEtGql321hecYtZW5Kfu+TZzT3UtTrYtx4fv1x4u1oiUTZy8v4htsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtylA91Xu+4cD0rOtyySy9Pzh/mVEyRHf7Intkv14jE=;
 b=mGWMdv4Ur4FICEvyLR8tB5RhxanX+d47+WRz8uX9pzT05K7Z1f+dypm0Y3orUPvqAb0WWDWSdjQZeN9TRtmhwVVPEW6hRAiVVvH7Dvii/S0jG593lYCrfXOAcNi+i7YhkfBjqObgrcNUI3FKB+Aip1rDBxiiMjEnXR9AS0MS2ya18IKmAB9CYanOFaBmDQ2lTjq0N7b7kajNYp8feGbOnmkNH5z59mz9XOB0UjvSfz1xUP3O+zaF8Gkl2zF7gOEYcC1tALy2guiru67kyIf6QW5eiBBy1FL7j7fAiXXCRCFigr3Xi0P0g8bpqSrnFFuaY9UEHRXxgbIRVm64sFkHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtylA91Xu+4cD0rOtyySy9Pzh/mVEyRHf7Intkv14jE=;
 b=RkqcdhXc1HIPBKqmqqLH0Mgw5TWAyCYXB9KBsyw9euAUVtD7IJl7SraXDTnGdUzx+FeWDP96LuwQzGRAHcqkb9uGvr9Ut2pGv9kAazYa2yRJbdV08GOAONIUf00f7Zclgc+wQ0eWUELoAyrqwJ1xV65MfRGmqyONSX5DcFDl7ZJKPoTRem6uEKw7nYLGfZTUc7PPOuA2QbUCFdC4p4RGPwEp0YPRW073++GMbjV3sO/kVDMyn+rd+Cln6MKeAEE51r5Q457dADEwXIcyCKtR3G2MnRYQtP2Nj0NhZa98jPzN2UNbm1Nv387h8TE+1Vx+mZUIMh3eCmWwxcUZt6yZ7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:27:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:27:16 +0000
Date: Tue, 18 Mar 2025 09:27:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 07/21] iommufd/device: Check !igroup->hwpt in
 iommufd_device_attach_reserved_iova()
Message-ID: <20250318122715.GH9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-8-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR0102CA0016.prod.exchangelabs.com
 (2603:10b6:207:18::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: a272a249-a8ed-422d-5320-08dd6618384b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?stzH7nFDHv/oCAf4OlTL80YFdyU3cZLJ5MkTad9dcqFadYAelk2WpRbetMGL?=
 =?us-ascii?Q?TeW2I5dz15iecu07cBXMH/yhAEMvZjN1E/vWKbK6zHpKMnQwhZgYsrVi6Jlf?=
 =?us-ascii?Q?ZM3eGd+Qv91qaAcmd/DrD3jTsMF7S9bysGQUK2XXJHtLwYEkLkI6ExQylGrG?=
 =?us-ascii?Q?3z9GRRYvyruscZx9zzssbjncS3BiGe6M6V0fIxshl2NbHQGZuTXkl76h4OIM?=
 =?us-ascii?Q?fz9bEa/RvrLeUKQ2lCz8Ch+zKZuM82RT+h4RhOZO2lMYWyyGu6iOAskkm/6R?=
 =?us-ascii?Q?8wv1xZup93qcbooH0+XpMvuDKnlP6FyMOMbvXy5MiOzTUrz8XC2iP+pQy8+h?=
 =?us-ascii?Q?5dHCv+DtaXjV3e3o/Zj2bRd9xC8LiIFQJGpUFMqCdd51YVQKoMb4o7GbnTwA?=
 =?us-ascii?Q?oDdxtou7lp8A2SvBBOhcr3VJx6Yxw0pritP9qRlt0NofkiUMtPT6tUKb1iCG?=
 =?us-ascii?Q?nFQxPNhflm/qDDLjy5mn2BvavgToQZpEghEou0Rokgoe8mrnCgyYZY1H1o5n?=
 =?us-ascii?Q?DOwyAuLsV4Y8fkjGLbU8ZNV8b0PICw4HaCQvwVVqxsik2PrDu8pCUWnQ7BkC?=
 =?us-ascii?Q?r2Tqu7whbcQxzWyliXE44F2wUNuBtZRJ3Gfi/6WjctlETBWMU0S2gUfrcW3a?=
 =?us-ascii?Q?sgT8o7NePfYQ/QQ+DmdcViZNaCjOZS1sSKvQMhirIbVbwAhIwqKJ3Bx9IaJJ?=
 =?us-ascii?Q?WWYKPT+RaVjcL7sr5va+5jBVA7LhFO65iD5W0tWgeUs8lXHw64PMWkdVuyxN?=
 =?us-ascii?Q?dSfbz6EGVQLSLWD5gOVrIW8ZdLjPJ7lV8CZtExfAo9rghp+GHRxWx9BbON2d?=
 =?us-ascii?Q?es0r4Iq8+pdExFG3TEb1SfIlxMm6D4rWB91lVuFH1POR7oXDrjStZoejkdw8?=
 =?us-ascii?Q?nkfqFNBvQVlufp28R1GOXktT16aYqnNBrgTAl0SFFH/IuJFlElXjTYbGz0Fi?=
 =?us-ascii?Q?Ww9mP6q0F/TrXEngEoh6hKCkbPtRsBL5xeo3NwTGByWd00x2tdH6+qwP+Wjy?=
 =?us-ascii?Q?NUdRjN8vAgiY3To4w1vnB8gIwnKMJyHrP5EityiFvVKw98oFAM/Y2Ik9tIrn?=
 =?us-ascii?Q?wsqnqgjzqV22o9/VEtYKR4aHFsM4Qa6EDy6CNcT+5QeZ0KNNTofvQQCzqUxi?=
 =?us-ascii?Q?2QcwUu6ylzBQS7XEDGBpXB+YqKeTZEEGkYBFDznziwHI2PSNcO2DAz081ZrA?=
 =?us-ascii?Q?3XSXjPZzzuHbj7VqX9Onkt3Y6bYNmJGcbnYSDwLhHyqJpI0YKkxpHRKJYLwI?=
 =?us-ascii?Q?WlnPDRCdZBdiudGQp772XNZtphPq+znK5JoHh4Cjqyk+t4nDb4se0S1QRqoD?=
 =?us-ascii?Q?3nL7Orj67ivB0nQVnzGVR2j7TWQq+zZGzUCTKrs2agIlAmkuIr0GcIffG1iN?=
 =?us-ascii?Q?U4Jn+G4J7PVgfO/U5ejdvXI6Es/Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LS10iPCgFmaVQHWvUZvs4rlsJkAtbX8MlpfQ8gzSdwhZwKZ3F9WggTyoc2H8?=
 =?us-ascii?Q?9I+W+WctBPwcoHRDuXCYducUIFD7hQSoAmpgMckI5LEbkKC3BAZUp2okQptF?=
 =?us-ascii?Q?mEAz9A7tI7XrzFAZ26hELB8hRWfkzhY8DrbCcEZ4SiZkjWgBpbupJdvebOeC?=
 =?us-ascii?Q?GerhM3iBvr0cNfXFsqs9ruHmNYfSGrNxnOaPNGA5UBr7Z2shekvQiOY7xo/I?=
 =?us-ascii?Q?PMOKTOCbkTMTJlfM/rnWSSDKKHlZGdtLXPZTUaQrzIeRjf8ke1Qfx8kWoc8Z?=
 =?us-ascii?Q?fwrRJUTjfLLGslk1Ca9vmjU/AYLV//WDZ2z3BzVg/I/arfSFP6auicgcUN80?=
 =?us-ascii?Q?0UdUJecZNKdrm9VsyrPwTnydTjYQCiDJh4y5XTm5xxkLGCMmBtEkW/MjXczP?=
 =?us-ascii?Q?gN6STafR5EVPp7cALdV/cRDoBq6zGHNFnrlaCq1xgYmww6tbHv/LUevKimRz?=
 =?us-ascii?Q?q9J9hkMWeXAmZDd5r0mqbMuiULIlDc3AG/FWrBi+R1KesvrYwgiTc/LuL/Me?=
 =?us-ascii?Q?OeVDhWcnbP60yGhlc5Xbm5+qNJaLdGbD1CMlEo1G3aIwuGtqDOqWJw3eUA09?=
 =?us-ascii?Q?//ehNDXNgiKEpsXy3AyhWCJpIOPEQuZ7/rwxZShCnJPvOkw1bsdgm6QJ81Vr?=
 =?us-ascii?Q?HFguYxdp6BWhyzChAnjOxU+HY/K3wxyX07UgdA4hjHP4w+HfNTCsWkPCo0Mb?=
 =?us-ascii?Q?5+0lefT+XKz0xbyqpp+Rpz9eKtvD9MomlwwmCgC/agMFMq8FF9reSNEIdVeA?=
 =?us-ascii?Q?nUgmggH9DpYfzqLcQ133LrqKqdX5F9PNGcnqUalkc0wHccImsRpG1xzVDxnL?=
 =?us-ascii?Q?lZh0QZcDoCTQFUPyD61BF1nNR6HQS9B4z5n6mFRoiOWvWgdgzKFK3t7BFPYp?=
 =?us-ascii?Q?ikkNOVR7U4l8SR1xtsJY83sxVad+wB+OR08WoWeOXJ5dA6a4NmEDpqtpot+8?=
 =?us-ascii?Q?CdhlftFbfB9TqQI8tOV1ji3Upw+ikzrZkAaJLqW4onXLhV+5+hC6GiKP1q3J?=
 =?us-ascii?Q?jjLdiHOh9tSOZWmP0GcdOrxP0Gdhlum9Kcf9c4lS3Ff9G3h/92UVnAYDIsRw?=
 =?us-ascii?Q?Np1xCSZAVQ94bCf8aWRgkhjbEOOcIsQ2Mw0RZ67yTwde4OEQGWoWA8aHJeo3?=
 =?us-ascii?Q?uqEfZEW7xHxXiIRInuNpvQGVe1LR621tLhg+KRnRx0JQMmLB66VgbRBZ0PgT?=
 =?us-ascii?Q?hoJcqCe/O6mSCShSbu+vNLMdEP1o2gFuOXyB7p5d5caDNZfHvOnd5HpMdLmd?=
 =?us-ascii?Q?Ch/9SpqowdTrNxRSCSdDi+n8L3ITlAg5FN8L5EGjltWUb8wJyXlttydROTpE?=
 =?us-ascii?Q?K4N5hTAY9kd+a/ng9z7f6+YCQnvZnC2CmebBzfGQWf7aN0mf7dJhCxGWTF1R?=
 =?us-ascii?Q?99Pto0EljgahHryt8CzLe5Ypl1/DE5+CaKgmyuZ6ulQmILEJqf05RAxR24ND?=
 =?us-ascii?Q?h8oLWQsuWh79aCjjuOUk7tvY4PTC9oDKCrcqzxr3E2LVgDhFdUAfTIbs0e3W?=
 =?us-ascii?Q?wtIqzPIPgGxVxfGed6c2ooxM8mUTeQPPmHnPrSRKXtTHg5tkS1SSmaaKfx1S?=
 =?us-ascii?Q?LnG5W6yFUbv+0TrZ+sHXThzh7YRr6fKTQ6fYiD8e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a272a249-a8ed-422d-5320-08dd6618384b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:27:16.8390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5byAi84IionR+WzxkZLpgXr9MBKf6WaiVxg+R1PgEtibx8NI86ImudfnksffRQlY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731

On Thu, Mar 13, 2025 at 05:35:18AM -0700, Yi Liu wrote:
> iommufd_device_attach_reserved_iova() needs to handle the sw_msi when
> the first device of the group is attaching to the domain. Currently,
> it checks the igroup->device_list empty. However, !igroup->hwpt has the
> same effect. Use it can help to further transit the igroup->hwpt to
> iommufd_attach_handle. Hence prepare to add PASID support.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Though I wonder if this pattern should have been made into a little
inline helper.. igroup_first_attach(igroup, pasid) ?

Jason
