Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2BC2C1;
	Wed, 29 Mar 2023 23:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0VD8/HhBnL5FYMGzQtYFbxeFGDYK0HlpTdkIY5Vk+JcpXLcGygrONKGCyGVd2EBLIJFw52uaf1/oJb+6PoxYClsfPuVpquFEicHhFdll0OlBjHAqlvc6iXoeRtHASwUbroKk+luIiFuykMiSrWWuMO80ZCr5vnqo+4KXUwPIKKEsuPA/Otrbl6KV70pu+GSXqprm1yNZS4Lpdn8NGDV481n6p/hYTLbhfJqyYeG9C+8zwoNwx5myqkf/0I6zEGgCChLP9FNktKXUL+EuKSoRar0PlPkvdKiyaUmTfvkSX7QUh3D1fHBOTFTH2ZnOLro7tbowReCa96MRM3MRDqcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IMwyM9A6caxeqpFy/R8qn0GUAVwEKEeiMrafGW5DFY=;
 b=AjsMUDAZ2xQt0FsXp1QJc37RXZZ/Sg3tGcx81CKU77AkvRx/C/3lemV2WWZyFPU5EnoRRFCt3SSuTArBIZtdEzBM6yZDZs5p+1H2MhLD6an4cbLwUuahpqky6jzEh8OZNr3dc5H50LwwtvqfUcxxeE78sSFy4tKufALFCXgOplrY46np9PYrF/wIYi35TH/pmAhZ85dBc52aDX5glf/8LicGYNJHXo2JF4I/FqNqolE9rAM8lkN1/mGrZ/jv/CfftR1Qv4y4qtOiCIeo6Oh/ek66g2UUPz7tslFx902dfqP6S0tnBrsmPoEXb4++E6ryl7oze8/jJN5vBwrhrUz2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IMwyM9A6caxeqpFy/R8qn0GUAVwEKEeiMrafGW5DFY=;
 b=TqfWB7o4MdWGtkgKmwqtGTynCjFP22/vA1Gp3elyVtDpnjkp1+l5m7s0NCON7eLsInlI3JwtoAYn4qSwmm/xdZzxbmLHhCBfuPHawiyl53EXd/I1BJ9EDfBtocN8yQ6DpP6uFptmdgY/zNHeHWMUkavbUagVJeMdeeLbmQAVvrfaBpYzfENhZWhkcXlwqP/2CCU/2ibHsk3hJ1dQR+SHeo3kLO2d2v6nD4ceCbSY4AvKNyHVrh4b8kFoxqOcHLgEdFYaNjTGGngrzMH68wvuxRnJpQr9nAHgi8/YbOins+MlDf9VBcb/jpVXGHaiwzWDjPZj8lQTSIIqiHGoXam7rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 23:40:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 23:40:45 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 05/14] iommu: Use __iommu_group_set_domain() in iommu_change_dev_def_domain()
Date: Wed, 29 Mar 2023 20:40:29 -0300
Message-Id: <5-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:208:2be::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 265d284a-2c8f-444b-db6d-08db30af0130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7+NBdaBhcsQ3lhMoyZcfgeDp43TMXgEjbyHrBv4JZyhVTgs2zSRrXDz0UKOf8rBKxKmXNRNOAn6ZD2VrsNJGYZ5FL2/Q9uWcdXhO9nyIm3TzQ+wLDVY75mwW0I3vfoKRPM1LKWab79Bx9o5fz8v96QwyKvcG4b0NmtAqVRFFVP6F5IVCrotToN1QSJrgNgUAzUpZVUPQj+K8PKn0RDh5/R2OnBuBlcdhXIjLJQBrQ0WgkGZt6/VecLjh+wKG98cGG+8RcA20N3E1pPhfYbRBMj19JXmmFdm8czDj8g4WZ/lo98Nzw9MaRHVZ5Fip/lkID8nf75uU3quYNRsaQTSi9Bw5q6+36Hl1jeHouSlgFEP5VGLoBYrWo383E55MwttUGJRYxRusC+BFoJ+qTyAacYqbTlX7X6t8FO5Nn/y/6jkYBAW9pMeGfNHqtbHsJA754j/wqwq26qB+PyPirpRFncnVbqIhFQ0dYHMXUxY9WZ/B+8otHCRXw+puEcdJkeWfLgFPvtfOQ+4iP302fS9krUz+eHG8QzIe6o8cErSaobiGKG1UaeYqX1POC+8yA8kBHGqhrn1EKs8My3FZbEksdUEsTq3e/F0EP30us0k4vvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(7416002)(36756003)(86362001)(186003)(2616005)(83380400001)(6506007)(26005)(5660300002)(6512007)(107886003)(8936002)(6666004)(41300700001)(6486002)(4326008)(66556008)(8676002)(2906002)(110136005)(38100700002)(66946007)(54906003)(316002)(66476007)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9GypzcvOp4K3msdjJbkbLhraGdx3uLPXOp5nJ8OvohokBGbaGYJWqfwLY17i?=
 =?us-ascii?Q?56M6/1fUhaHu6v0tmI1SYVTLCRTTOQbmVQnYahenmxv30NrP5wl/Z/oL/PQi?=
 =?us-ascii?Q?s7W/pt1gAlLjjAYOWiKK9pui4ZnSpSlSGLtWVAXz7zaKzmPmkGiMRef/D+tl?=
 =?us-ascii?Q?pmhMKLmefe5nlzLpxW9fdWxNzstNoRdKVP8K1R2ZXmBw6Aq4+n2mhZg8bfvE?=
 =?us-ascii?Q?cL0nt3ClwiczzZ/ScKsgpVifLNnygruFv0uRr29k/27Rgq31zq+ObV05Thq8?=
 =?us-ascii?Q?jLG6HN9sFBtzevKd87LwRfq2yQIB2wTg+pGBl+LncxaM+e02jpG8wzqVm32D?=
 =?us-ascii?Q?o43uN5ouq8c1FzIffbMLtsL8lXSCoLZXcyqFQ7vuAVIalKyXJiwz30wA+094?=
 =?us-ascii?Q?L395hqDB0o2gRIgcN6qap13achJaBv2zQOeT4pAtbSk5C/8eTTWyhxFlZKnz?=
 =?us-ascii?Q?b/zAmIlacjGIiY58ojpXegSg3appELHT2fAk8dnlJ+V+U0XxQoJ3lkavTPRM?=
 =?us-ascii?Q?d8BpzEEcilZ+QY9L8SfdL0sBzvkVYMxXAqE8cTgHhC1gDAS+UMVppGDNPWgC?=
 =?us-ascii?Q?Kg4+a845ChSmutMmB5h/U5DSnpjwkIjttq24NIJEX1LkxFZJucN8TmPv0r0A?=
 =?us-ascii?Q?FOXwz1/JeQh13yuMFHsmq+FERhXxJ8Qk8PuQ204Emx6kWc9R3KjR1MUTPIhU?=
 =?us-ascii?Q?4jRlDXoqmhhyqKGhShro4fbAYHN0Fx97DewwSecpgrYc+8cJON/26VazK6QO?=
 =?us-ascii?Q?o0PKDB30pcy/FcHqgaAr8HX1NoNcpj37dVOzE/mS/Mv6bzRyJwShJK2oCUTt?=
 =?us-ascii?Q?41JwNlUxGCsgrKrlj9mLDJgtKiqvLmjtiwMYDDPxy72ypMJHB2F1fvJtvDaL?=
 =?us-ascii?Q?7nTbaUqGGoh17vLNgOP0mmHRNPzA9q/5umqWswldSr8OOfC4AP1z+Sjojb77?=
 =?us-ascii?Q?Q6Y589+aqsn0tKXqEJg4+1OsWgQUWMBXv6rd0Qvlli2ark1XFeQ+VMMoknFh?=
 =?us-ascii?Q?KM0Oq734Smv9TR1WyffqklX33s0PtHsX6q4lICdm//OpA+3urdEUbpCTxsfW?=
 =?us-ascii?Q?e4MbkkFIAcZiCKHTcy7CTKqkBGB23nAZ3FJQVteCing12WcdQuIXHN4HCiQk?=
 =?us-ascii?Q?EmFyZ0YW20J8/ZkF5QesnByeWX9FK2ih4Nmlco9LaTfyZYNXFJxQ4faT4kBS?=
 =?us-ascii?Q?4i7hVEZY/mkPhPrR6hUP5FXG/ENmKtog6PHfZpvsVx3iSyd8ocjaOlSXJ+Wt?=
 =?us-ascii?Q?UQ1Tc1Mxm6RlI5p3Q2EYyaG1g8sagLJ6k139HdS5dNQ0N1mBjQhJhU+rs7b+?=
 =?us-ascii?Q?UYPk+KquKZNrQgRl5HxkLM47qBZq++t9eMQKGX8oveI9uCp9wXUrb5JjiHAC?=
 =?us-ascii?Q?+Glh1u4D1k5Ll+LlJfJz15tgRzMWHVoixa+aPL+fWpDPZm3lbj9j7JEI4xhx?=
 =?us-ascii?Q?vvr/Gvnpi6/8QbzbFCktnmx1mTG+g2io9KmXB1yZiPqFSIRTjZq/iqPL+u7T?=
 =?us-ascii?Q?z5rGYlMIZSOJnarWyH0r/E8ozK2Ld/Lytsc57jpk9idu5C2VaT6Glf0dT5LS?=
 =?us-ascii?Q?C/KhjzwMuWbdbQpRxxTXSp5KmMp/R6WYPCtluc2m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265d284a-2c8f-444b-db6d-08db30af0130
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 23:40:40.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unbbYZc+6oJLZppmT3L9t1snLZIFFXhPf//EBDoaXlNTwxbvr8VvrqbAV+xQfXQ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

This is missing re-attach error handling if the attach fails, use the
common code.

The ugly "group->domain = prev_domain" will be cleaned in a later patch.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ba9e988293f23f..cd75d7405a3051 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2963,11 +2963,12 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	if (ret)
 		goto restore_old_domain;
 
-	ret = iommu_group_create_direct_mappings(group);
+	group->domain = prev_dom;
+	ret = iommu_create_device_direct_mappings(group, dev);
 	if (ret)
 		goto free_new_domain;
 
-	ret = __iommu_attach_group(group->default_domain, group);
+	ret = __iommu_group_set_domain(group, group->default_domain);
 	if (ret)
 		goto free_new_domain;
 
@@ -2979,7 +2980,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	iommu_domain_free(group->default_domain);
 restore_old_domain:
 	group->default_domain = prev_dom;
-	group->domain = prev_dom;
 
 	return ret;
 }
-- 
2.40.0

