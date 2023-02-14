Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4B2CA5
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 20:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DybBSwGGUf2hK2KI+TGm/Ar8dKRCdTeAFJi41+BdKdif3ZEzDLhhujeau7JdwM7ii9p6ncVHZVJePLzKEgrrvO7NHn7iLQezdb6Gk+7Rq1iJmPSFxYrr0ueq3Hk2nEBb4jjSzrGhXz4Cb/By7CED/wE4bVmSkfTcV1H5vu6j1aitSNYOQ69Hs8prXaRP0CJRt1cS2xn/pIHDeHq2pb4SnfZB3V1FDP01khePB0cnCFRCFXzHC1GqCmwi8ClbfkWs/WiuVTO07Td2hKz/j/51h7CJnMZ0+K393NRA14RVqKcThzkU5fB2oxlasMdBTwWAVHmr5o5VZwIW44iRGCroYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRSCXmJkTKxwUbZ40IGOY3cNB1kdmeFvWyYvvtsN670=;
 b=Ko6VZMedfC7KU9eDB/JraIgrru7WFzDLUZzR0raIIc7YhdZbIi7ZGGWcLAswlN3nmcxjCZG9C4esPT4abYLdB83Bi0Wgb0LCYGvvGD4gUotKeL1VZIb+A85ZEHAu/gRWb3gsci4lfQRmRrp7NdkkPJLJdy3FcyovedSqwHz2BeDR9b5Q/Atk72p7UmxA9WeIOf+HCN2DnFzGUuLkzdDRA4x/+WBPD4OVaV2q0T6V1x3lsPEYaOrmLG5kf2bYCOgIo3G0PSMo8YILt6rLz/XO6rnEdodDXy4FDNBZgfhoeYbQ534lPWnLiYmJ6ZmTxpF5yasQOc5dzFWwrA8SSHxGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRSCXmJkTKxwUbZ40IGOY3cNB1kdmeFvWyYvvtsN670=;
 b=mNddxqHvib2P53AdH4HYDpSa7AnHuBQLquIrvDyXwDhfu8nJBUZ1nRrwPOhdZiuQx6UkGy/lKipzq8rcrQtVX9nheaPU5qhNE8EG+tBn/CWttv3rtOC3D/BGjOcy0eauTnWKuqDqyikGInwtNFDOIWFXy/+Qx6sVAYrjRt8M+X00KHmbgCRVZiAnhv2mL/wW1PHFrIdDOzpuC/YcZ+5zLXIgjWnu1TNHiUGvy+lfD5oRH5uxgM+7ssfPS+oxVyyl+cVVk534OPV6jbqjUjrfAzjcE0MY6Y9R7FJAi5sdwWf2a5hx4XjTQIbEecZ94gtrDJIWtlHFRiktnEUof06WIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 20:48:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 20:48:41 +0000
Date: Tue, 14 Feb 2023 16:48:39 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Eric Auger <eric.auger@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH] iommufd: Make sure to zero vfio_iommu_type1_info before
 copying to user
Message-ID: <Y+vzp1kIWK80h05d@nvidia.com>
References: <0-v1-a74499ece799+1a-iommufd_get_info_leak_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-a74499ece799+1a-iommufd_get_info_leak_jgg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: aff07cee-3a7a-46cc-0b10-08db0eccdb11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g6EwzpQRR614MUwmaInohLkzWsz4YBSniU09osabq/YjIDwk4DR7sxbsEg2Bu1AuG6tfMBEXUM5ASxvkcMFxo5GEZ6UEAI8yXIVIEkAiBguX+EjCBTUeNGbwRhSIBZSj0gHEvtS6RJlspcpcU90+u5GOfhxYbHdASMfCKP1EhivziD4nNJhmJVRahf8YJrUIcNSUbVU2fsG1V2vTfTttJH3lZg9AflyLSfMtZgAKTRM10uKhVInajThn3UrtGuo5Rv09fJavnTX8rD8miHGF5pHlZf7+06ZyFxbmVSSEfd7Z7Q9sN9AVqkrQTlT5S9i2ES1CkbCKhaP92X1zXZH9kPV1ZH1BGVpInePFHktXA/3qn0WppO8BxEhmNJIk8ts92mRm/pEiYzDYRqS2/PeM1YqU2yqaN4qZaYroiZvDWlVYVBmHZ6OQH2quT4U5cjELp+joiAmRyblPj8LnCpLkCgJ7WVpr5cl85reBd7Ml6D2VABvF+hFt3bDQG8XTAXf06jpZhTnMZRYji6odMPOAw6NkO0+y87Qv1revRaau1VB/lFaUgQxzZNA93JVGowAtyCNubF5Avg3b9W5vjSpDGV+rXEH6NMS6RbAW1VKmf1Y0ujv1XwXgqNAtXwM/WKZAmDxD66rHMePZ0RuCX6VZTt+qaiixLN23uP6lRPkJOem+Z+Afi8gG4QkpWd5hSLdY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199018)(36756003)(2616005)(83380400001)(4744005)(8936002)(38100700002)(41300700001)(5660300002)(2906002)(6506007)(26005)(186003)(6512007)(6486002)(316002)(6916009)(86362001)(54906003)(8676002)(66476007)(66556008)(66946007)(4326008)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T/k0kobLgjbSmY3oBPbLlopVn7rRRJAAfIjOPt95jHJO2wutGEIUgbfKiexH?=
 =?us-ascii?Q?hSpqDEZMhEgNij6sX+gWBdiX587Pht6D3TR2NguVaP5y0A2fTP6r8EN5qY6N?=
 =?us-ascii?Q?79ZJxuSxaZ/6IE9rNE2hQKVWmbaDJwlW93ZKS3P8LqvfkoJjwg19z6bm6CFi?=
 =?us-ascii?Q?jIuTfegzjyOgEjP03rNstZ+URp+vh/oyHY2qNCkcl7kzVwCRdRIoyu1tLhHv?=
 =?us-ascii?Q?r2YtwTfM4djrfilfKwOz0l3OcWlXRg3TgnJz2QFMoHzBsnbtmiradNYqhHrd?=
 =?us-ascii?Q?CiQUe54i1kkiQIqe9iQbL8bT4ulM06w6qvu9GBnj9lTcB/M0ysPQvnqvj0oc?=
 =?us-ascii?Q?3+Htm6hjZDph22sAPJbSUnV5YOMh4WXZw18qiMCeF+NC9UWMzWrB4UxFV7KY?=
 =?us-ascii?Q?oOUB3D9ipCnrZILgxAp2Ummk1Gjl36S8/qbJVW7gC0KkmZuaB3vv3YS3mbnd?=
 =?us-ascii?Q?rYtMStTMMJievJ3eq5j0cJjcTtTOIn4TA0RymFG01WVN1JTxaMT6kDge2GOS?=
 =?us-ascii?Q?TiPDNx+pKtTJzT29Hp3kRrMd1J87ikqCZy1l3vmjnLH5XbtqU/7EW3KA5nSX?=
 =?us-ascii?Q?S/63aNsIpG3AGeC0jbwQJqLjXMNfnHkYswqc5pW8a43+4eclkSxqYlMQcztx?=
 =?us-ascii?Q?3qPQBJh2BlqNteOx7x8vCSmaHnfngi/Nt7BhjVmyX92uKTpfmIh3+9VrBIUf?=
 =?us-ascii?Q?JvosomUjP5JUgg+nFVu7FPQjXE3ZTmmUUGTrbRFYWwFMko5JCAXvRy6BWhX2?=
 =?us-ascii?Q?biJ6HiA1zSxNKeHGBrYvJ5bofnahMfQjfqThaQlfqZiiJAXBkL80Cr5ZDCcs?=
 =?us-ascii?Q?UwX6d+LVtXIqLkENYTDO+37SqioPXitk7c7ANcRZYJ78hHMgh5pKVeadxYpC?=
 =?us-ascii?Q?RQIs8ePTeib/2TpBOmlxVeAC8nximPZQhBSZTifIpbdya9yH82xZ5Y8BLqM/?=
 =?us-ascii?Q?7looyy9Vmhsp8CUyVzKJPp006hhugzA2pGD1fbKHt8znnYeuS2zP2jiMa/RI?=
 =?us-ascii?Q?2Rl+3hdMjyFVIvKxSwUFNB4r0UpOSaUfXAkDLpORhK2ekV4voQi/HTUvReqX?=
 =?us-ascii?Q?k5VvyR86ZpLKrZ8GQi/5zGf1LgM2pSsI5w6ptemR3kf/izxytbjmG22WDc6k?=
 =?us-ascii?Q?x85HEFwQlaMv38y8oTE/dIbw6CzW+jK80XpqDH+6SWQc1LaDjHnyOb23gccT?=
 =?us-ascii?Q?+2DbVo4FyZvMExWtj1Gaph39y2cEbYaLVgBMWWM6TUelsRjmI4dPjVhn8YYk?=
 =?us-ascii?Q?CAgmM/1PZLNpo/4tZI9OpnYwcLQUZPOyaDFN+aOPw5/QNgJKgTWfEIkvKcKO?=
 =?us-ascii?Q?0kfNh87najxQTQMsl34yyKmIRTvKZylmbfTGQI1rnaw76pSW8IqQjL6ZkNle?=
 =?us-ascii?Q?NH7BuxpZi5MjOQeHHCRJsTjib/oYoMLw8l3jI7a8yeRk6sWDMj3LtKaV17Hh?=
 =?us-ascii?Q?mC1DDKoyqKY1zkdz3YgaAXkY/CBWWEBgFGxDJ+Pqg9/SbLzC08Gyg9Gl9QWf?=
 =?us-ascii?Q?DoSALxOcb9fKhzhVvGRYZsy64MQ/OfpDYjwLHDLAdbgt++9ZlWuWd4DLUA92?=
 =?us-ascii?Q?HJTTKBobRTGeu6SmWDaiHmf0inyiFv/xgOowIien?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff07cee-3a7a-46cc-0b10-08db0eccdb11
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 20:48:41.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSAGR5FAdbtRdsbQrSYMhQ+hWShbk5FDYrwQ8mp191ejCs/B0IcgvRZLX+sJugBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814

On Mon, Feb 13, 2023 at 10:32:21AM -0400, Jason Gunthorpe wrote:
> Missed a zero initialization here. Most of the struct is filled with
> a copy_from_user(), however minsz for that copy is smaller than the
> actual struct by 8 bytes, thus we don't fill the padding.
> 
> Cc: stable@vger.kernel.org # 6.1+
> Fixes: d624d6652a65 ("iommufd: vfio container FD ioctl compatibility")
> Reported-by: syzbot+cb1e0978f6bf46b83a58@syzkaller.appspotmail.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/vfio_compat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied

Jason
