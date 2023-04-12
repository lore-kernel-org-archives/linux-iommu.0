Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237405696;
	Wed, 12 Apr 2023 13:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M//gKbIwEy94wfaD39GzQ5hZo5QffGBPcqwBqSzWT4IJr/WOm+3QCfcL0ZsKtjqIirv2B5Sfw7NuFbN35d13+1t+Gc0VzzvXhyRWh4wwi7QSUOVgS9o0OFNugVDyMTGJwxolG05s+VkEpDBPAkp0LIjVDlGSvKMpNOfPwb09L1PVEvO5vaZg64SHJ2nKBNPxbqMFv5LDZHYKwPQdmf2VeXNFTIeyktGdAHcaE3YhS4TCkaaL2cCcDIe8sYc7IBdok3XcZH5M3cRdM/AZQD2eA3eQ2cKPo5kJNDVgVgmOKWQqC4TeNjF2okRiU1ake2jfpkoYXkcR+A9TnhyDh2ktbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhfzZqu1Szd02WJboZEHH0vVBQqEX8FrSFxEwdRuH6Q=;
 b=enZkw4siXLLy8plsxEnPRM38uo1P3c5o5W+9wP0kNR0+O2RuKzFlIYyCjdas7vR/A5DdS2Ai1AcJnr2ZiAoAkAjW8GNlPgKQfdqUkPOEi9vQ5WEL4BO/WPBnHTJtqgButlcbZ3gde0vJ91vnTfjldz6nBUIG6nrJvrRUOKQAxxHvuecNAL3gjog2p9PJ6oTOGUwcEk4fHdWpDNQr1ULXCAwgclKbGfZClFjKRczGdnuC3dj9YBAnz8iAWLppcIgYCBgpQUqZ5fqOHrrVVBYq5je90c47IqSasNJ6kPXxvThbZLNAj3jsZYmtgo9aAJ4OV8msn/+DcGCbFN2C4Gav0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhfzZqu1Szd02WJboZEHH0vVBQqEX8FrSFxEwdRuH6Q=;
 b=Jbl+nsQsc5tR4HhQJmrq4LENX6ZGwdf9Z4CXXyWK6WYW7FPzyJ27LEkFKzuFiVxTwpahIve+VybBtMj+KWZkMW9HwlPWVh1t/8TERVcQwDbtOCgXZEfhKmntv16K6ZXLiW7LgNpE7uL13Na+bCE92mOMD2NVXbqoxWfN6NeeCLwEmAgLiaZWLdWhWsRM/sRY5bOBgrjuP+N4s5+kuT6W18PqM1KErlugnpR/srDIjvbPoTGu9zojD/mgr3AR/bBw2WCoMb61f4eYr1Tk0Is2gQhF4N01GrPxTtv4uako2fkpQosXOs28/1WfdnKGe0eXnJITblbGpxy0pQI5O/tXUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 13:51:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 13:51:57 +0000
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
Subject: [PATCH v4 07/17] iommu: Remove iommu_group_do_dma_first_attach() from iommu_group_add_device()
Date: Wed, 12 Apr 2023 10:51:37 -0300
Message-Id: <7-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:207:3d::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: defb02ec-e146-4b2d-281e-08db3b5d1039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E6NxUt3yC1WP2Kmxqe7nhAdcnsD6ynkO2mIIJ8ulx0ddnvres/iC8+4/iRJMyuKX5bef1CMxDNR6/uyN+GNVDFdTHrwQXPcmWgl/hOK57DrmkK24ya+iKt81lcV/BIJM7MThjJTQbokVXv7albnCKkFCMk7J1iUyQMWFfEG11hW2EdVLm4XjbrUtP5HXfD9iKoM1hGSbCJdYL6WgC+M0IZnu2OdPAzmzQ4aXp+Qtw7UYtFAZVri5kiAX+rTX3I2TqtPslV/bjzZp85ppKsfQSFy9P71zoEnbyAb2yYyX/rLzJ76e/FKm6Xcs+U52/1M3TJTR7/xx58F0IVGRaQ0Dv/vPQcOilLpHEF2fYOMQzweGwPheWVDC9PAjWIIGHGkpL/a23K2W3fcgS3Kr90u28rm4jOTZVo8j1IA89QvDqtbLLn2pvU9eQhjKOFhzw4kHyOdDNEjQhq//QhCR4IHCYIZrWOt3Gsv4v5He1IsxVNW/aXimc8ez26705L3WUoas2fMlLIrqVAHySoW+jQmhDWgJBZ9Ee9YumwOXUlgK5jnaTrbuM6es1lTzlBU1andfrt+TyVNMOMXy1bb342c031LZmReqv/Lg9infyldgtgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(4326008)(66946007)(54906003)(478600001)(6486002)(66556008)(66476007)(8676002)(41300700001)(110136005)(316002)(36756003)(86362001)(107886003)(2616005)(6512007)(26005)(6506007)(83380400001)(6666004)(8936002)(7416002)(5660300002)(186003)(2906002)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ASnrPhzIZDafkt6dpX9nDG4xr9sCwLGDnEaZWq3ZkO6lWSZRw8sZE7JrRJu3?=
 =?us-ascii?Q?P5pS95kI9uBKr/iyUi0puiNSyBxzjJ+twa70O0++CYKTFARw7CrpfqVf3B1J?=
 =?us-ascii?Q?ukZI6nOrjKQIwGpDQYBZ3+xtFzuPZxRhVd2TyzVa/qxAA4eVPQJ336Rryz96?=
 =?us-ascii?Q?ZbH6gfQF8N5sRdIozm3BfMnigcWaEEXEzzZN83Ijtdgmu3f/rixMGA/tv34M?=
 =?us-ascii?Q?T+Kq8byuy7lwbwZ/nj2IWzsiA86eJDg6w6xk4sxM/vX3RBXgRRKsBjkzsDVk?=
 =?us-ascii?Q?wER3S93d9nBtHGLz3GWXi/iiuTEsUbXThyZBiDCNTUFtmmkKQpEr1V5+gdGQ?=
 =?us-ascii?Q?aBwkTd+zq2YR63EnQDtaMKUSldKeGsBcrswG0619gSjnEaqikoXbFLN/PFHa?=
 =?us-ascii?Q?XYYgjvHmn03VMGks3HhJD2juTsQ8In3uVhzOJFud/dj6Zdtl94OGZjNQxy7C?=
 =?us-ascii?Q?keaM/PdgaOuKZ2mXiF5LyqQCZUSDMfVmEEPlfl0TPbxWxYl80/epKIdtbHdC?=
 =?us-ascii?Q?SO05m9j0DmvWXjG0IN/3+onXwoFVMIp/p4Lu2sOeV/r1kkvQYdo66wcl9ngh?=
 =?us-ascii?Q?zlFj2/evh4E/S2CUtYXkl6pnF64D6/TDZdW3Fpyo1yU62X5h1O6O/vYowXhC?=
 =?us-ascii?Q?0dAh0c7vbe+Myd7OYtPVnRWoTozF4bAE999tKqJPTzv09ab2kwI/95G/+Nk/?=
 =?us-ascii?Q?JVlc123gcIxJPdDidgf6+xzAAFzknMa/yT2gMH0niv3RI4hJksIDzxWykZZo?=
 =?us-ascii?Q?C4QwwdyvgZVyICSlIex4nU2gz2HrTyIvGZZAl+rrIlQSTOnm6VfLQwkIm6Y4?=
 =?us-ascii?Q?QlXgAZ58p+7WG41kgHeg8wtdvLiYwOSx4sxnuMr78MpYNCJKRrnD1RMSPkO3?=
 =?us-ascii?Q?SgmY/crCOid7iJRkbiBdoYrfamYRtl8psy0LfJ7UIEa/hcrpvGddJyYm03hZ?=
 =?us-ascii?Q?UbR6WG5EM6Yf++E2pJsxMP+2zP+fBWB/IDLqlFjkLfMc0BxW/iNSSpMz9Ju5?=
 =?us-ascii?Q?geRM5iF1dAcvytilJQXx2n7XqVOGOh54+qEHKdGfaCntTIB5eNFhkhLrr7vR?=
 =?us-ascii?Q?txj4G1BhD8v0/chDHS+JFWTkBV81Hl7PxTHOvW1bNjUGp9jsOh4g4MZ8vpBu?=
 =?us-ascii?Q?A4F74YpOfbaOftqaecvkeeqqdeQJOFV0gGFuoNFRBSNU82mRW8N+f1fFaAD5?=
 =?us-ascii?Q?1KsQDkfVWHxTczyasGkAnC+xE3D+Twajay2Bj1ePUd5Qh7R6fcCEDk10tTn4?=
 =?us-ascii?Q?VTuEIbjUDfK3i9/ZmGgkNDXhUyOUlsB0V5er0Q3zjCdOMSvjcg99MBBwYz0v?=
 =?us-ascii?Q?zRnt5ShEY0EaCNj7uIUAnntc5UjekyIwUADxyAsF7VpxAQfwAYXPP9P1s9Kp?=
 =?us-ascii?Q?7sdBgMd7vWR13W9AIUpXwz8ZV2xPwOqWomoUFafhiMcKTTkHTbvGNvFGRHx4?=
 =?us-ascii?Q?/xV1IAPiXM0Uq762N/kcO4G04L+qBhanfft5lC1NRc+obK74lma+6aGJBywv?=
 =?us-ascii?Q?wIHziDiO5rpl5j/KdVvrxzxCY9i6WaHn+buj9aPvkitEDSTRWoCC17LHmEtQ?=
 =?us-ascii?Q?5z59V4cd5hSBTcwq3BRRKjqcftI4JcXv+I4sYy9P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defb02ec-e146-4b2d-281e-08db3b5d1039
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 13:51:49.4702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+CJrjxoh7hbtN62sHgL74nVQ/g2w9wRz2aEacyPI4RsoJ41OQSkj4cSPsiBGp0K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

This function is only used to construct the groups, it should not be
operating the iommu driver.

External callers in VFIO and POWER do not have any iommu drivers on the
devices so group->domain will be NULL.

The only internal caller is from iommu_probe_device() which already calls
iommu_group_do_dma_first_attach(), meaning we are calling it twice in the
only case it matters.

Since iommu_probe_device() is the logical place to sort out the group's
domain, remove the call from iommu_group_add_device().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b6e6140119731a..24b0290d16ffd4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1104,25 +1104,13 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain)
-		ret = iommu_group_do_dma_first_attach(dev, group->domain);
 	mutex_unlock(&group->mutex);
-	if (ret)
-		goto err_put_group;
-
 	trace_add_device_to_group(group->id, dev);
 
 	dev_info(dev, "Adding to iommu group %d\n", group->id);
 
 	return 0;
 
-err_put_group:
-	mutex_lock(&group->mutex);
-	list_del(&device->list);
-	mutex_unlock(&group->mutex);
-	dev->iommu_group = NULL;
-	kobject_put(group->devices_kobj);
-	sysfs_remove_link(group->devices_kobj, device->name);
 err_free_name:
 	kfree(device->name);
 err_remove_link:
-- 
2.40.0

