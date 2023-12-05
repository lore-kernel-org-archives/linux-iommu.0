Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845DA59
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FBtpYU3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+MTXWz2H/giims4awoaQ0Midvwub14fXtfqwTf7TS01JPA7bRzMiJdCepzat9m0F6/iOcg0vZAoW/R/eoza/WFvo+a6alL02MG5z/kpABHK+oQGMIj+Wn51R2xp9Ic0NTQEmY7bQC9F2riWeNCQDvXSb8zgAtyfUWjuHMcOP8S9ytjjy40QYn477JXH9K/4doM/NOPnzb0O+ZsGQdL3et916DBZTDG900IlZMQW/dCePv4refgwgGDbOLUGWSG421gVTFKsls/he0/USM56Nfy3Dzt1Bh9xo0TfjJLCRzjBwz2Sz4TGX7POxyfIeoVUlLyUlGQRKHdn613keAyuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afbpg3X1VpLqtsGSBgIAznwuGGAjkxsOHcjcxKXdnxE=;
 b=PkVey7w/iaMyvvETdSKboQ4EU/ZMJRuz8u1upowzMERpj+XwOaub+975+lZKLk2gjnM72BLP0d0SVruLyz9k87mC97jIVvUB+gM1ZOBZCdhUHpQlNT+TTtNTsygg+c8uNF26SiUiUBgxOwjpAKtR/ZpTikeOcefh1Km7oY2Uh72guGOl4Qx5UC4p8dN4dlUhRsEsaVsrstS2ErpbMD439FTSKGqNUvGEilH1Bc52SnlKmsXI+bDegyl5Tq9oj4JcAP8eMOh4gt7WeTyJAoktqc545VO0IUtvqcVyghpqjWqQLRmdCXXIQo04vSnGfrxKILpDEJWvOriiNRuQ+6zWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afbpg3X1VpLqtsGSBgIAznwuGGAjkxsOHcjcxKXdnxE=;
 b=FBtpYU3nuz+FxJXkGToIOLFXSI/QEZUfk1M/zQZmeFowwK//VG2f3NX0b0bJDDax9AlW+OKjmWrWQNWTwLh+jm0iInr7IQhQo/x8UXv/8fokXBlEfn3UDo6SNvR2GHEEcyUw0RLJb6N1AfuzUbHO1eEwj3mGijaEPovkuzy+bzA2qmTjxi0HyNwZOUP/Xktml1Xzz3yUhsAH9foDgZ1B/fyYu8AnOTruVjT0uh5Auf6MNWJOk1NYXx7oW+UspEMcU9QFKDS2m6PgP4TJTdvBAQ9+Eiehz2GtP2zxxQqIuR9+jdlWY9k8eq7bp/qe9dBwbwUKdTFpUJRxKDqsh6UoAg==
Received: from CH2PR07CA0040.namprd07.prod.outlook.com (2603:10b6:610:5b::14)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 03:03:32 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::59) by CH2PR07CA0040.outlook.office365.com
 (2603:10b6:610:5b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 03:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 03:03:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 19:03:15 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 19:03:15 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 19:03:14 -0800
Date: Mon, 4 Dec 2023 19:03:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Michael Shavit <mshavit@google.com>
Subject: Re: [PATCH v2 10/27] iommu/arm-smmu-v3: Move the CD generation for
 SVA into a function
Message-ID: <ZW6S8CPK5UQ1mYpa@Asurada-Nvidia>
References: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
 <10-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c2e98b-8a66-43b9-8b44-08dbf53ec379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hSp2aoFwronO/SFmCnex4Xwy0De6X2a41GLnzWKGexT5ynKCx7VSbA4KbOfwtkuSrNUrZFrWMJt98MC6yf7qQYzfUc2katwpoiBNTNtaWcUzzw3prZxKR9MPNmqPbqBYZfNCrKTpHzplphaSng5LukoRpt6mMRpe4wxNNUoDArFgZRodfbU+X+uye1iPHERiGyOBGtsF4dRba6Recp7itT5QpDKNBeDWwD7um83wiG6puciwQwA5IfXDhxXvKyHkmIqWTdqN2Ugq89NfaPVbT47J9iU/2K9HXB3uoghj3bgqMoZfWd9wwWyd+DI51eLpy6gPBGL7T5gs9K4ha405CpsSSgcZXWlrbqqmxJnaaCWYe93vYYTa0cgIgw4w70j0UxB3hZWvXQ87padWJHKl8M9XHVLnwhGkh3BD4ZHdVQpVYuJnpXMcbN9FSdS8cKDRIqMGwJ9rlO9WOzSv2xfbB50Vupmm3ploYGqfzfqaAgpMTf811kIImG9aJcBDO9wul2nqn65n7YVcWyPEkLwLZYiH6BLmL2xr1oyefYpXlO/kqzbEIY/lJKly5X2+nofo9/rN6gQ7mE3fud0Ok9O/7IVPXuyur9n9ZbH1W5XHd77v804g406/Bg0B8RwpOJ+XHI3lBTFr9+ncXAGz4HnRz/WsmCBlrbbRIsb/6xMeOScFLwV7HYfCYkqdtRfk6wov4oZcjhlUiXurb/w51ZBa1LaYyn7amP82Rp7JmjivFLDk8mvRAnTmgdE4K4XBUcAY
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(70586007)(54906003)(70206006)(316002)(6636002)(478600001)(40460700003)(4744005)(5660300002)(41300700001)(2906002)(33716001)(86362001)(6862004)(4326008)(8936002)(8676002)(36860700001)(40480700001)(47076005)(83380400001)(356005)(7636003)(55016003)(26005)(426003)(82740400003)(336012)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 03:03:31.7794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c2e98b-8a66-43b9-8b44-08dbf53ec379
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248

On Wed, Nov 01, 2023 at 08:36:28PM -0300, Jason Gunthorpe wrote:
> Pull all the calculations for building the CD table entry for a mmu_struct
> into arm_smmu_make_sva_cd().
> 
> Call it in the two places installing the SVA CD table entry.
> 
> Open code the last caller of arm_smmu_update_ctx_desc_devices() and remove
> the function.
> 
> Remove arm_smmu_write_ctx_desc() since all callers are gone.

It seems that there are still two lines of comments mentioning
arm_smmu_write_ctx_desc that should be removed or updated too?

Nicolin
