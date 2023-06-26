Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763B8C04
	for <iommu@lists.linux.dev>; Mon, 26 Jun 2023 12:18:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEOY9gEhZ1pnjJ9vFzdjWEBcGawe+DVGOA8IkOAjToQ+BXev9TOoGmcr3F5IpXaQaSVgeZ/584INDgquPfO0Zolww5kKq6W+l6Uu366VITmdg0t4S7/ENLjIqOlnWE62NvBb1ygDNe9oWthc6TzFPoORMpTddx+l8CIcWSd7/9EcWlwEGG1mhZtvwCcbxcpqPmeaZdSbrdh6j11HBDtzymHbe44RHnaPCAZFQDzIR2aPLrko1moPY7PAiOVV3DSLfsjcXr2EaKKJCX8uad6acEgTxwvx4UtCAu7WSUCVVoYm01LWbm/c0zLvBrdSc63Uf+APiJ1qVcuV68+9DDsCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDnu6gWXGW+fuhIfrQNbGLZty77wsrEDrj+37oJ4C/o=;
 b=k5wNzxmFCl5K1tMPhfOEkZEyflOjg88wDIAMYu6kBM7eGs3aKe3ss6y6R3uEiW5tEl/GP7jnyXEANUxTApxYFbkfV6xP/14gQ7Ok4eHUprq24DYlWHUvoYwOlLOW+ClYEcpFm1vNbJInm8DEL26VX/jU2dwHlv7HrGz6TwWdUT4wsyrIDvV/6t8p5OytMIoKnYVy2cBwk9/KUFSog7knTe93w7+zdJzlLv8bHWtgtGnVBcICLaH/Q8ZCqQLxauJiJOmBdhgEx3oSBIu/WwclCQBE4OASwIH5d0PcbCO4T0NQzyAAnJ/Rt4ZM8cMXguZuVsLhIrpUveGeUJtNi7w9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDnu6gWXGW+fuhIfrQNbGLZty77wsrEDrj+37oJ4C/o=;
 b=E0FZhtKbUL9Xg1xb7atrriuABZVlVTuWJmFYEeTXnJZYJeO+thUloOxrMLG/bJF1AERCKRMUI5lNrp9QOaBSrgW+ruNmSJpAsEKRoHyoNcbVWbH/3Fcn9vfz9/902QMLX2I4sPDgCDzb/4GchAjLGfQHn4NG9uO+kkhyQ5NWIEHbjhJmk3EuNudyiGu4k/urli6GYly1p38mX+QbpptmzO6kBGzj2iEd7OKA/Nt5hVEfXgv6YyNUGTa5AI+lwchoU87yDnPHPgwi2ouN3KgRaR1CdaCVmBxdL2tR/LatVNigourKXvDb337JEBg2mw47NPPpSUF9FdcHR+ihESMP4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 12:18:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 12:18:01 +0000
Date: Mon, 26 Jun 2023 09:18:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>, Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com,
	syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH rc v2 0/2] iommufd syzkaller fixes
Message-ID: <ZJmB+EGHi/iQOfnF@nvidia.com>
References: <0-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v2-9a03761d445d+54-iommufd_syz2_jgg@nvidia.com>
X-ClientProxiedBy: BL1P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: c14a22c1-4667-4683-df1a-08db763f628d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lWr6mBVlDrg12691y4CXoC8zHZaQZViUH9M4qLRFLOgFx5bzQf9e12uYdncvz0rRpktfoWKylY1BfOaf+z+Ovon7s2d1fYrsULGXxWXRMagtZB0g5CXymjfJ21m8V/rd7GxindZ1FerTWvY9bD7sqh1vUCFGChqEoxXQJUfSZC60GGWfu3TsYHcjY755sQkb+y/1g/B3+kcxoLAHOnZfHMJzJSlBuuwwWriTiUuGpUTRGR0XQJK4CE1+TkZUEjiXh/VoF3CY6siFbnlg5MrYnogGkjvyCI1CCI9aq7QOKhTqf6PF2I6YpyrCtNsDeMKUdN6GA8ocURN7w+cHWsRjkQ7LHqz5/RjMz9VA6Bcu3b18n4tWsdynfoVWFfmqp902aUkh0TYgOUyXN1usAcA4lP9xaKMoZ883Mk906ITah4QZ85kZRj/5VzLsw7GsVNNcwUg/3NwAI6JL48C1xmjgFe63K4w8MMzm68op5BIxKqbl/gDceZmvlWl3dADvsniAvRk6YSpmsM2aWT9JH/rWmXlBzHTTVI1aw2R5P9c7Mag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(2906002)(4744005)(6486002)(38100700002)(83380400001)(2616005)(6512007)(26005)(186003)(966005)(41300700001)(54906003)(86362001)(478600001)(36756003)(66476007)(66556008)(4326008)(66946007)(6916009)(316002)(6506007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZQ16C0Vbsq+q2WuO5bhaPW/gNJy5qubXb9oANSxX8q0rZQ7NiickLuloRUmd?=
 =?us-ascii?Q?D9JModIcbaoOwhnp1WKkxyOg4ZKEDaU79vEAeJU/zG8Nlt17ERkjNaqEXSta?=
 =?us-ascii?Q?2AelAN9HYO7On3V2IxVlzQdEutS1Doue2bjaJhh3l74tERoR4Sh5Uq2OMJAb?=
 =?us-ascii?Q?yd82QsMpAqlFOrSjGi5s2FioIhOxJNOhPtkYh7254GdRDkEQzAmE9nZuSIvz?=
 =?us-ascii?Q?FTYu4S6ui5o25mZWgWFv1Ey9LQdKtFvX9SfzG8P42eTyQ5lE5mAesYW4ViY+?=
 =?us-ascii?Q?s0THmRB22ovIiCP4nny9/voWWUfmYvIg2TvIMpwP54kb6rQjhXLaKsXSPh23?=
 =?us-ascii?Q?wp77AcGVjst7/d8tmbopy4+pSySIS/I3sI5a1ycBnlIVmixqNrp3ZubYkeRk?=
 =?us-ascii?Q?CPyVbJ8oSvUGRU5OuPpaDQRuuhQ0tQC9MWADtd/zwphv+YTH443zyp2WDCUo?=
 =?us-ascii?Q?8HEI4WWglNmQ1a7w13oXkvzQudFrYAMyLNIPf4sq/kgZk9+iiPDNBFsuK6jI?=
 =?us-ascii?Q?klwwr9BtLZpT8ziHcmQjwncm25dLv9etMg93lPwwCTrf+RClHoizmDOvvuA6?=
 =?us-ascii?Q?jW3MxRJ+x9zNXo2qJ7KNqV0y1BPvkGxLlD79pL1PIBIEGotaGYiwIQ+8sfD1?=
 =?us-ascii?Q?jFTz8YqSrkJNpRiv5o1njAAwDvzzfTHOuXACeUKpuMbCf59ToqnEFCxVOxvG?=
 =?us-ascii?Q?S8qNVnINpKXwglA6fC0h2Q/UVdQeuk83vRv4XocgD5h6yV3XvmplGeL07mZS?=
 =?us-ascii?Q?8Fd3i6b7JMIE9R1RSwWHkuRk+CnF4EUveNiSRuwQllxDnYKYSEUsDVLNPpTL?=
 =?us-ascii?Q?9voqqaFA/Nz6t23G2v5Rs3C4iE2uK2mM6ujweKZG+AXlRSNRpETzpiTyci3b?=
 =?us-ascii?Q?RKKqGhbz7IaGss/+9YntgSz/LabbwDRlcDZjUmEud/OG5+yDhG7a72KIoRao?=
 =?us-ascii?Q?ksmZrwegU8/LwP6YiQrLHB0MxndYb5gz+fkrr/bsgj8egrG1vqqrYnkOUR8C?=
 =?us-ascii?Q?mlu3imKiMZHus964T5j2fPaZZNuuPZ/8Jjq5WFTLkjQagYkw3NQqXXdfv1tS?=
 =?us-ascii?Q?eTJMCzNUiWtHg5kVZpDIaF8pJlBHC4tbpB+fTUAsBSQ8s6DAizLvKq5AjfBz?=
 =?us-ascii?Q?AST5rmfEaAl/bMoJJsQprT/Gge45tLAW7OroLl1j+J9JhxQQeWYqh9a3TkUU?=
 =?us-ascii?Q?fY0jZpAwQad4Jk39MbGz2sei6PgygquGxzmf3VtNqkSiD5Chz/dj/SM6PZnl?=
 =?us-ascii?Q?OWa7DidfaaFRhdvlA3zXCvM9vaoKEVwrS7V4ISkoe1bTDeFCm07AiWHIK/Rf?=
 =?us-ascii?Q?Q6FtCD+Zqmr//VcTb+yvVClZDK5M4WRMK07uPdt9MlJQaY6PL5ZswdDDx9J1?=
 =?us-ascii?Q?gL/GJBVTQ4Jl77o9ZwoIMEsc0n2YqpB9re2Px8FnVEZgeAaKfh7AaJhYBbMQ?=
 =?us-ascii?Q?sWifsfPDxCMQRGBarkipsFX6muoQZZwfZdrLRH3U8Y6ZzhVjM2gxX5CUdsq7?=
 =?us-ascii?Q?hfp9cOCD6qC/f1dYe2V3xAwOLRwxNtB4WNhD+8uEhWQsfEDwSD13I2naPtWZ?=
 =?us-ascii?Q?sLt2k/BG0GEb0TsTJ4MrRXfBC9QzMKxFfWgF1mYZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14a22c1-4667-4683-df1a-08db763f628d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:18:01.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZVb+z/ZfFjHfYm+mrsJHISl1Vpy7wKAcshMA4wfBUdH/ZRniQw1Kyzns4ekpcGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033

On Tue, Jun 20, 2023 at 11:11:22AM -0300, Jason Gunthorpe wrote:
> Two syzkaller fixes, both the same botched locking of the area pointer
> during the unmap of IOVA being used by an access.
> 
> v2:
>  - Zero tries if the IOVA progresses
> v1: https://lore.kernel.org/r/0-v1-9f7c19e02561+31-iommufd_syz2_jgg@nvidia.com
> 
> Jason Gunthorpe (2):
>   iommufd: Do not access the area pointer after unlocking
>   iommufd: Call iopt_area_contig_done() under the lock

Applied

Thanks,
Jason
