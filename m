Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1BD51E;
	Wed,  5 Apr 2023 23:38:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DA4srwY3XUX5mzSTdNCItl0tNjgR9eLTvTyt8p7q4sJvTlui59cxUtkXzFMieUqLQuJMDnrnJGGjoHZcZ+2buQMSUqWEtGgM7ZdPM6Yfjjihz3IjIRyBl/tkw6Eg6r5ipnJn3UwzTv/deDI+RwlOjAjKMgalIYeCSSq3lUwSu/pmoRjdiueKDmprq1H5TyEN03WiqKylrQWT1IKiMP3UtEsGqrW+LsvlzfpqXLuBuyP7H0yLnAkJXQBt00oYnXOW5831lsw2QuV8DLrzyscOXiUYbokZ14LulySXHSzNb1xkCycxCpGeGE2iA6Iu1QKYGviywS04LAAqHTpBor7dTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/kCww6mBGbQ9rwn/Xod/fv72ZDK2yas5Xhy43dkVS8=;
 b=nfnzfFotiTq1Zou2UxHzwA0wcbqkty0jsgjPIJrrthAD8yjHwvrWpVFhj2roy35YBbUeYlC+sHLCbZmhAnmqWfiHY60CofRRnEFRjaXwP+QdV6Kl+Jss7O9mHlP9od35issZb2WvlrCLC9X3TJBTfA6MVViEzz3YbM9KwPH6Xk40xK/94M6hGCwfL+qU3NDiVIRzPBsJIF4wg2YKZ7/YaDcXrpKYYvKp+NqYsVqbevBSQLQnaaYxIQneNBHAFKtWN2x8PFLWVhzzCn6x/8OKrW1JSwv7ZUpqCCmLrpwc8C3bKx4GkAP7Gp1NTco5FHQGXsN7/QCt13jnC+YpJdUwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/kCww6mBGbQ9rwn/Xod/fv72ZDK2yas5Xhy43dkVS8=;
 b=N3RSH75zao0sv6ays7rwfJa2SnMdWyjUJlArUerFRu1kOVCAQ2o6XyK++bj8XRzLHqSlbU61+UMt66Tm6hihEafTFkehU32y8dm8d2j8SzWhXv2+eqXNOz6BgyKTeTfdPGkPGFIhcdxYK6sgQ6jIbaX6qmC2XsM3ZHqj8v3TnQVusC22PQtobPHYVIDjB4TcYQteNbZnNdIh39HnJU4DsgNPuvLAe8Yd58jGyfA+HmDtMDiEI/8hhEhxgxPWK9xlc7EBa3sfC6GhTwz7L79oe0LyGxSt//NP5UaOlLXbVX92TFE6Bw8fZveQxURTt5NiqshIS25+Cryk3E92hWKUEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 23:38:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 23:38:41 +0000
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
Subject: [PATCH v3 15/17] iommu: Allow IOMMU_RESV_DIRECT to work on ARM
Date: Wed,  5 Apr 2023 20:38:36 -0300
Message-Id: <15-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:208:d4::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ad177f-09a9-4a60-c169-08db362ee23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IRinYGW6PdJ8pSiq7PC7QUIveyHi5QhgKIhTG54r8lEBp7j9Sjr9fuJBUGDBYcRe2dFFgIxpPQJNOll4cFEdWYfjMkEE9bTMsX0GsSU6fWlQb4Pep5rUJnbBxQm9wlKWA4sYJsw/n+fxTmMZO/sXBpFoIMi0E61nCdKuk0evZfmMsLKQghqVv2gTqfyWy36EYdmp1zvGSDsptFC5KFRb0oo4Sul4UYPuQbIfWquTd3AFU7zEu1Z/2lLSzzLxnNTKCzb5FufJPYuQKrgVazt6wOEf12NriSfPbkwEmpUBlyC0ZjDIXsZOH1IyAl5Q9HRB9W9ZmbbGsflold3H7sALtsNKf68CyVFZvKfF9xzAF1wb2cSKH1yGj3Mkvk+90IFjQL0/Vu0whwfOplf72Tu6yoV0ISHvpGqbkcNFXefcMs/xf01eTXV+z/sPy3VjFen60QqfnHZuqiH06DZQ/egOJHtEgdM3IDYn6vJxQy9OfRmIuC46CqJpShIwJVnJ4qEZffP/gnkjiHDHlrv9fUJnCqDwpOJcT38CiLdtmek3geXoj1ieZI2BGpvbYn/L9HBD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199021)(2906002)(38100700002)(5660300002)(8936002)(41300700001)(4326008)(478600001)(66476007)(8676002)(66556008)(66946007)(7416002)(110136005)(83380400001)(316002)(6486002)(6512007)(6506007)(54906003)(36756003)(186003)(6666004)(86362001)(2616005)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rb8vo1y2FAkdC7IsowM3ijzYB1q4G2z/jV0vVWUVC4VZIDXwGmg7cpldUxd4?=
 =?us-ascii?Q?iFtUXSf9KQKjTIrmhhNXoKQi/f1j4TBClm0yzPqWVe0XGAhSybIWfBWjC41e?=
 =?us-ascii?Q?i6zlDPOyzjAQB3ma026bAYkTgk/qjW10EdKLIgXpp4515q3T1k4xET1x7MBB?=
 =?us-ascii?Q?Xn+ZkR+6PCJbn9T4D0sXw1hw02UHRhiuZcintChg4krVOt7+HkBH61oOpHvk?=
 =?us-ascii?Q?Xo2STa35nsl4LMGHk3o9xlfjvIZbTf493dW7fnUrvsjYt6worwboG7SEhIwC?=
 =?us-ascii?Q?bsKD42C9wz04PKSRyKl2pEVY+AB/Dixqj2CZsEpKT6xp6cLK0YyfFTuKpL5p?=
 =?us-ascii?Q?xRQZQjzXtvPlA/qw/TeD9HT+4jPWHmILYVa7tMITq3zVJNG3vfRPtPzc3BoO?=
 =?us-ascii?Q?pm1RS/9M5wifKu4onwo0Iz+2dcbCdM1ZEKYEV5rbRwkPSOPLo3c4Z+t3JKNc?=
 =?us-ascii?Q?0XJOpkdVYk5/kDFCpUoUbrEn8tbmexsup2hSuJvEPqG9N7i9yXz8LPnLTPEK?=
 =?us-ascii?Q?ns4EMFoVRt5yqB3NKEAKpWG7pT5oeunQpxMDGs7arYR6OuTMfPY11BbxakAr?=
 =?us-ascii?Q?ItteB3DgriWFcCC5iMucY1bgNwN/a4LeCb7XjHokZ+zWVU0V8oBfPDnYA0kN?=
 =?us-ascii?Q?ACxYrxqvXshJxwn6sxsX2f8JBBUvkoL+fzsqQInKxlDR7fmJUVj8cQS2FPNs?=
 =?us-ascii?Q?jrGo6N/nP04205oAouAELzfwHQpLv/ZBQT45v36Le/LOIrTEsLAUnF2tU0I3?=
 =?us-ascii?Q?kW0xfTIdCcgUoiRH7y7QSOrfwAfH6z/JGEhIGaqjZie8ZfLJdqPShflNldQV?=
 =?us-ascii?Q?o/oo4emXJY3+juCk0sJooUF8QGTVUvxLvFwr7v4SrfkhdcrHRbYz2v9Wb++l?=
 =?us-ascii?Q?AiyjIgCYZD48v1PjCEYDTYif459xPNJU3ia2+AWvrJz5pSflJwwATPE+5QXb?=
 =?us-ascii?Q?UjsfiEDx7lOBAFADmvYMXhz3dAAo3KlTmruq3L5rFn7a6E/R3Di9UM2c5+Ga?=
 =?us-ascii?Q?LqdVwcRfBk7/8fe0yQ1havA0CduI1fbP/11SeZ9YOuB+GBWhrMOvvDlPZVCt?=
 =?us-ascii?Q?fnSE7cxKXScG8+DpekIDnJu1pzT+mkxVcZerAoOWNQ/iNJUlMLF3ez61TYGd?=
 =?us-ascii?Q?0FvQ0WOQwUBACn0pgIv/0bFLJZrTbMkMdnAKl836ROlAElVll9LcjHGUVfqm?=
 =?us-ascii?Q?V/x4/hOdEP7vX2jPIdDIQw1zNAma8vUi31K1CyFq1qsSxI9071dY/wwQM9JK?=
 =?us-ascii?Q?Kyd+79EnGhxaDD67JUVmQy3q1dLbk3qmqaB3Ja09AKWHBa3ZB+JBPW4ur/W1?=
 =?us-ascii?Q?MWNyrF3+2Wfc44SWqI+GbW+kQxZmUlWLfsr+coeGN3P97axN/1QMrNutQS8z?=
 =?us-ascii?Q?SICnN40rzO1/9is6hiu+4kMw2PtYawKhR67AZtJ+4ZdrjpCpMLR5wgwwfeXF?=
 =?us-ascii?Q?a8elT/IYknzK158f5K2knzs7gN4UtQyGM1kSXq3ignGV3ng0HMbCAPm++c6+?=
 =?us-ascii?Q?T/esxkvY+InGD9TforByAywHKzh8pK2JrhWitYf54W+U+V0AYE1cbRR0bO5P?=
 =?us-ascii?Q?RAkkSTEfxGUyDp5nyE6u1FvXI2xm5xGyU/UE2U9A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ad177f-09a9-4a60-c169-08db362ee23b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 23:38:39.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpGLpu1LPHOb+o7TCUCpNhvCOdYSa6j2OHT9pk8ZgJ1ygzlhPcmr53mxCeQoX29h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879

For now several ARM drivers do not allow mappings to be created until a
domain is attached. This means they do not technically support
IOMMU_RESV_DIRECT as it requires the 1:1 maps to work continuously.

Currently if the platform requests these maps on ARM systems they are
silently ignored.

Work around this by trying again to establish the direct mappings after
the domain is attached if the pre-attach attempt failed.

In the long run the drivers will be fixed to fully setup domains when they
are created without waiting for attachment.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b1e8e8bf955bcd..d0aa837b31cdfd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2884,6 +2884,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 {
 	struct group_device *gdev;
 	struct iommu_domain *dom;
+	bool direct_failed;
 	int req_type;
 	int ret;
 
@@ -2917,8 +2918,11 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	 * mapped before their device is attached, in order to guarantee
 	 * continuity with any FW activity
 	 */
-	for_each_group_device(group, gdev)
-		iommu_create_device_direct_mappings(dom, gdev->dev);
+	direct_failed = false;
+	for_each_group_device(group, gdev) {
+		if (iommu_create_device_direct_mappings(dom, gdev->dev))
+			direct_failed = true;
+	}
 
 	ret = __iommu_group_set_domain_internal(group, dom,
 						IOMMU_SET_DOMAIN_WITH_DEFERRED);
@@ -2938,6 +2942,17 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		goto out_set;
 	}
 
+	/*
+	 * Driver's are supposed to allow mappings to be installed in a domain
+	 * before device attachment, but some don't. Hack around this defect by
+	 * trying again after attaching. If this happens it means the device
+	 * will not continuously have the IOMMU_RESV_DIRECT map.
+	 */
+	if (direct_failed) {
+		for_each_group_device(group, gdev)
+			iommu_create_device_direct_mappings(dom, gdev->dev);
+	}
+
 out_set:
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
-- 
2.40.0

