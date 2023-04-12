Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F995696;
	Wed, 12 Apr 2023 13:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUjGQ/ErcoDqsDtKOlGM890UNgzKreG7CpmetsuU8W/Na7Qaim3sKB5psbE6qzR/MYl/TI0RqQNzrsU1mVEjyiLog03CZNnBzPErUwmnhnlQCqeGPEdVsi/bBypSx0FHsT1cViIkWfy79ga62Hat+rFM6mU7I0NhG9sIjiakBq5QLoND8Myn6lBUMijCNu1vuLsFEuTUwEDfgNfaRGCWnqq1wHKhkm57E/K+eT7lcMhaA3U6T6vWGhIDoVm9eHtZumsgNcsuQRf0WKBxk5LmfHcFBNz7A2NKGCMZJZW6qJtwwxZAlDQeF9Tl16IVac204aaUd+5oWR9WD2N0EIz+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sMf7AVnrc0BT+xGFJRtWyG76ZoZL6yqF+Da5mGO+ec=;
 b=RHgtgfPncel7A5R3oL8+Ifh8ef1SyYZ+G57pwTNNRWGUqs6ch4lfiQJHaRXJK4aiMWp3rTJ7cm+D6jFyVT2uE422GALjeg83Y1LsnUEuQm2x5j3UDpC9l28rvGeqFsIOlFyKpkZfyTrqk92VK98Y001X3+hS29TY5m/ogiaN8jmbDARWTIfZSFQcUdvfTAwhNJB5cxoXDBB9arpAVCttgDNBppwUwSyFU2FPN31UDydDzAfPw8weB8MhD13SOfWrLti6d09JZQOGjAr4CbkA8wD4XlrB/SvBSdkh3aFa2GtC4vHvu5+6wurOUd2fHJIKk3c9GduOMGydPGfb+Od2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sMf7AVnrc0BT+xGFJRtWyG76ZoZL6yqF+Da5mGO+ec=;
 b=IBY5dIP2mTaHkn7Ie4rvdZTC0bRPdsIX6lE9MDc1DiUSH/jTGJdt2WIzNc8/7zv5vXA532Tiq8tfTyJefVz6n0WWnETK1OU4BzVJ8zLki2uXc6S7aZtyN0L6N3Csaer4WD3Nbi/YAfe/qjZRuPecPnQCz/8wWEC8j0sbj8SX+iGeG/SaXgdCSMchMA3Bg565WbipuOYoV6jhz2XpdyjQYNGnHx1vflHtdBCM46XRpM9/A7tWBDvvxowX6tMFQfQzOYldQwVDjuiFqRqnq4SIXSoITmtQJNLRdyV86B4JjzJJG0qAFI5PQRME5UvGyoyNX0OC8+G40hblxSJ/DCGNiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 13:51:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:55 +0000
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
Subject: [PATCH v4 01/17] iommu: Replace iommu_group_device_count() with list_count_nodes()
Date: Wed, 12 Apr 2023 10:51:31 -0300
Message-Id: <1-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:208:15e::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b01c84-d40a-41c2-a8d0-08db3b5d100b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jmHjEGhcAlIZcDHzaEYaNz/zeodvNbZ02leWzBimUizf0WX+qdXoNj0dyltzlXp02ug+PrSzwwAQxhl6lVCiqt8pvRt4hU2wGB5S9FTARmvp73x2z7Z1ZAKYgQ8iEmVv5yQ3eV1hmPm1DtX44aAjZyeAfTVWlUSDLTbTUIymWn5K/2z2gS6tgTMo3iS1g3RSPqhOuPzZyICM3rrvEpoS9VaxdeoOT4frB3Mm5a82omppvXSAL7VWB5eENo871XNcD0Oat/aha2c7ML2m94dwT+X8LVxqmtGnQlv00jW9rfdTW0sHAAqYq1eEkSL9eg51++UcEuCFrnsdj0r2y2jVRZUIeZio31i9o8ninXzMl4UjPLB0XlLx4XuWNFjvepx1q9KF9ThvPvcXE7Tke1fd+HpFQJfbf8IsIedKOey7Ysy2NIAJuPcLL53DlgWx1Czyd575YlmwyThL6sPbsPJPnea3FaNqJ6eWstaE30SfKZHUEAclGClEjzrzhwu/qgV9/G+AuK46KueSIgZq3cF7Azo+YB5ttLgywOVDO6WuAZd8BNOSn2a7NT0wXC2UZKanULcB/vznzdWdLswRhdy3nKeMTJcBE8NiZ6vJbE7lhlU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(4326008)(66946007)(54906003)(478600001)(6486002)(66556008)(66476007)(8676002)(41300700001)(110136005)(316002)(36756003)(86362001)(107886003)(2616005)(6512007)(26005)(6506007)(83380400001)(6666004)(8936002)(7416002)(5660300002)(186003)(2906002)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNZSHXvmj8UNBTMSD4WaflHnLWlwZcn6KUlFKlhcm4qCYcQ3suVz+T/4qJZL?=
 =?us-ascii?Q?a0Qy98LElSZR8c6XgL7tYb0mW1RwOexsrBeXAUuF1ril2dy9dMp9+cKu2WWH?=
 =?us-ascii?Q?UgFzS5Lj76YMkoB+yEyxBUjTDgjqejISCm/O3jhj4ECt7nd9BEukYZz3bqFM?=
 =?us-ascii?Q?kaDXH1iwSX0y2SY1M38krTA60sKycJlHFPO/2vE1neEFEz2UO70fai+ZDY2B?=
 =?us-ascii?Q?v4NbuzavXh4LUXsg3EkC2XcFODU5FvDi+0efvU+3vSrZ4oCd/Ku/NvpZAffJ?=
 =?us-ascii?Q?VTNbghc1anoebpsACGlQBognutuaDCFQt0dhB0oRkV4R92zBfXkIliV40+zT?=
 =?us-ascii?Q?mhSw1kNvkFPoY8GUWrTiyT3vdhmC5D1mZ9xy8akIg6HdkWXFr/kEtOT5DsTj?=
 =?us-ascii?Q?1B4hkCruLdEd7NDIMhDFW5M+GRGnlWtyXoYUyj1ReOTFhv8EhtFWgOcx4daM?=
 =?us-ascii?Q?z3FoSCr5QCiXjL23sokxMEXLzZrK/EwElHeqzV7HUETFIZQ4j7ZzBHX3KiAE?=
 =?us-ascii?Q?52kGFAtuwSF6OasQ3EcEVgXwJspazDO6NfD3jfk2dSi8CVbrXCoYGQG3bFqM?=
 =?us-ascii?Q?DsauKjhUDlVqWzgYkN2QA1DyUjZ/XQ5FfGgmv26302yq2FLY5Fszf3IfFIdV?=
 =?us-ascii?Q?4djHC0OJ4+i0yrXcV4GvulSDpkrzvSqvjlvJNsRoLv8g54vT7XwD4Rc1erPQ?=
 =?us-ascii?Q?kOGA0eMgKdTsVpS3DTwebZxov1Ev5X8r1Q770/mw2oTdMTilXzmTzUcuKP3I?=
 =?us-ascii?Q?NBe6NCSHH9OlxSoYnPzd7UvZBVb5loMp6/LWUswPP/dsX6A0RkDCEDQLaaDg?=
 =?us-ascii?Q?DyIs2yazCSBeEYM1BRM5u1PdcRgM1veBKj68THAoViwVfDTZejysqvWVkqTg?=
 =?us-ascii?Q?cIl/7f/9BBUPpk/3C1PiF33m5FKGDLGIEGQ/hmmQsyY29vqSxm4z8VSDOt+k?=
 =?us-ascii?Q?ka4vdZHZBH8tMJjXW39ajSP6Ec71gwd6IW6Fda/ByKAcWMTrV7uou03HRWeA?=
 =?us-ascii?Q?Y1ICg1YB+blsLbbpRV9l6JczpLGb1kJ32EbEoMSOQptoSRbYJPydhqUboBh4?=
 =?us-ascii?Q?NyK2yQNG9eoPeu6AJ8wisctUI7hT0deHWk0jBMJbq3yRfKlh1Bwsz68/zME7?=
 =?us-ascii?Q?EsWgiuwqnKfoeD98di+e7XY3SSsd05lEykJMyny5vzLkA16PHcZLgGmal4Xy?=
 =?us-ascii?Q?nWTfPv5z9mew8p7yhATlQWx8BTc9heBzdZolfWUIYHBWvcxo7Crn+IGBXgui?=
 =?us-ascii?Q?m8fVFg2XNhQsDiXO8syKPIalj1iHvsquNMVSid14KnUHZUXZfjLRLGbA3OvP?=
 =?us-ascii?Q?uCG9ayzbkW+nUlEsU8OL8XMtV5MCn0+IobHqw2R3vb/fhRyabdiupf+jJSZ4?=
 =?us-ascii?Q?FwP2om+KVCEq4UcxvFzl+dXugmpUY+6wzxA6+srw5mwLrFlndDZ9ciGIIbFk?=
 =?us-ascii?Q?aaOMc8nhsfg+3L4sNVLiBI3rpRfqjEy6DB5MuR+frYopnEpDnlQpub5c63dI?=
 =?us-ascii?Q?LHRu4h9bLXBCdits1CuVxCNryPOLa8K3eyD7G7B1CPm0E2Q3ewpQn12tf3tL?=
 =?us-ascii?Q?J54Y8tngwIe9f2M0LIqcttQppe046hyoXIldfX8n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b01c84-d40a-41c2-a8d0-08db3b5d100b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:49.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gN8IsuSl0/ZtnGbqz/kLjMSKq5l+q2uuNqkM2SjwKCTM1dFnl1Bwa5DWTQLA6Qiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

No reason to wrapper a standard function, just call the library directly.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7abee83610b6c9..8cdf47279704c2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1149,17 +1149,6 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-static int iommu_group_device_count(struct iommu_group *group)
-{
-	struct group_device *entry;
-	int ret = 0;
-
-	list_for_each_entry(entry, &group->devices, list)
-		ret++;
-
-	return ret;
-}
-
 static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				      int (*fn)(struct device *, void *))
 {
@@ -2101,7 +2090,7 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+	if (list_count_nodes(&group->devices) != 1)
 		goto out_unlock;
 
 	ret = __iommu_attach_group(domain, group);
@@ -2132,7 +2121,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (WARN_ON(domain != group->domain) ||
-	    WARN_ON(iommu_group_device_count(group) != 1))
+	    WARN_ON(list_count_nodes(&group->devices) != 1))
 		goto out_unlock;
 	__iommu_group_set_core_domain(group);
 
-- 
2.40.0

