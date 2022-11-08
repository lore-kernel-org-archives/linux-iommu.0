Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E37617F5;
	Tue,  8 Nov 2022 00:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIMgQT9UJbG4jL1L5dnQ95DleVOdjoDP5k0LE/VioXER4zGR6W8wLpIAHTXtlOX1GnQHm6Gig2wmnyV6i7cu0/i/jzZUiy0xYFfeI4uduVd3nGZY4jsRGGp0XmAXWass/BrWuXfeibi6EfwHU+obokP+7GowfJU5qSnR68GlxTJmpd32ipXwzH6m0Zn/swIVtF0ghKwgglPwAU7hhf6HA4bWr+kIpx1VDmc9FPYT3nUJiQin0kxnPL+TziDZgHIdf9Wg3r8R17WziApNv9oxM7I65/QTsRn/GajQ1v8G0lY8olxVqNl0PzEE9NUmgAfMBx5yrIWt+CxfPh1WIgPnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRGLRl685td6dItFUrTg4RP3dGHbhsEqyq5JIiCIt/U=;
 b=MMJmj+Hf81NevwWx6MGQdBSOOs4jc4oN3NWHwvPbcs48z0bYHWnKSviaNQEVqI1xp/A59zHRQKNJq4dtPFXP1Rmfrhc8mliMarezWeABuAk+DHvTZlCdUvDVkXit5XxISvwrMaRYqJxrGVtjIr1sr0wxlOXWauP5D/yQw7oGAlUnG7zCFrxxziTG4ghdEr1E1ZpMbQkf1eEqc5PiVoD2bUCkEHbQ0QBioFL04+mx4MqZBQ6B5Nv2cVLwHcQGdR4Sp5C6RZYzKANrdSgmMa2qNWu7iQpkNpVjeHRGM1+SHyXI8ieNG9CP1Qzjf4CUzje+syftW1fxH5v68EnNny2JpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRGLRl685td6dItFUrTg4RP3dGHbhsEqyq5JIiCIt/U=;
 b=ENPZpJhJYJ5QiZpcI4kEGkDLLGpMLdb3xRtBbQx4iJIDckjkvoUAjrF6lMRseaHMhiXlYg8yX6qwm7iVvMD7D4SA+AVdKKspYElkRXY9fws8Pc5Br3K7ooUxYDNGSpLtV6uBK+gnKGuCNLxzM2FyW+Q2crSkL4PTt4jfDXL7xurou7ATq9IOitCMhsexBe1QjfvlwEGCRMDbdkux0C1AqZ/wqbuLr9xTr7+azJp40o/4A6W0GXYneR23uzCzoqcsYZBtX8s/FXwMQZuOHGeybbpnolnXv0WQgZybTlFprhSU9ctR87TsDgzUHUjaQoqlUMyH/AaZ1pW542vzrDUcVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:16 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: bpf@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	kvm@vger.kernel.org,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v4 15/17] iommufd: Add a selftest
Date: Mon,  7 Nov 2022 20:49:08 -0400
Message-Id: <15-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:208:15e::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ef8878-9a96-40d5-912c-08dac1230d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GJnp8IOPhGVT8enKRSKjLCXjJ3aLzyEbvB+7iOjSBH8+G1bc/JK7zn6GAYqH/mfvULbfmrM3Lqb05xixFHRMIeVJL8QSzmHwKqsUyiiAXdbixQAmLs8TGc5dHKW3PaGYUIOmK0rwdkDjfkQuuP2uIYsdeNbpkH74d5nGayYjTk8YIyGVfGzRaLoaaZ1WJ7DB00giMtCWKeMivvKsY2fX86+kbasKMdtSYJoGQQejVV1UQfxO5ccCN3et7JneuMtC52MMdH9NMyYc7mgyWuNejSeUKI+Z1G7eKaFkO2MMAxlDicMWLrfcgtY3hrshNK2jBfG7byh3iEXT1et7ddE5VcY13RNcoW4vhqzqX8cM1CIllLR8ELiBKDOQ+DISvTT+92O+ndUmapEcu0IFTAJVnFC/3Qh1BkBPk5AW7iJW928fKcT6jfDiuRa1hh3YG3mcy2GY+vHmjqfGz+cKY5SF+HtmoTk3kjCtF4H0mCW3Hc3poT3AfiRVyGRnX/fc+so1Kv0St1Vzqv6DF9ljj6ArAq5qDJtziqdY4+LILuoVddcUx8h4zJbnayAQQ6W5P/Lt/XsZ7hh2jvC9xZ/R9XFVWVP03u3IO7LDVNpTEazKut9irpz+CwfX9/M5vK9ouP9E42/IYlFA82PizRJ1WLGnDNQaljJHXQ1trvvAjq2BFP5TXCoI9NMeFY3XmXlwQ+EUGB2nrpygQbskjjm3ppUAzwS/WvsEujeUljBVD5vuLDhJSOM2AohLP7PAXp+GlWXx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(30864003)(8676002)(54906003)(110136005)(66476007)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(316002)(66946007)(41300700001)(66556008)(4326008)(186003)(2616005)(83380400001)(6486002)(478600001)(6512007)(26005)(6666004)(6506007)(86362001)(921005)(36756003)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6S+Ql6mmCfewjHBgljR547h8GVTRrDlQVOZe425O9z06RDx0PVMAm+hua5/0?=
 =?us-ascii?Q?HA1BMbaXfyTrmxg6t1JXLcleu4bve41Nmk7lnV/XPXHNhQLoHFDzVjYi8Wkf?=
 =?us-ascii?Q?D0lAUlBaeSaTTsHcS+NKLoTkDaDpt0RNJ3oRwmfgGr4USutq8GvjSWJDtKkF?=
 =?us-ascii?Q?gYXv0+psn6t+K2QaibjXYtWfAwlOVhXYciZNXnG9++bC3zA0UjyZIjpSXDmm?=
 =?us-ascii?Q?IUnywImHY5NeGpDUMAN/FCBucLoWvZl65U51GCnlMsxwBKPAThZqTzcJEPuK?=
 =?us-ascii?Q?ObxXhdHeClGHhymqNbZ2bBeM6MGV/5t00CVQ9TXvb2OeaOlNmwAAko7s49AV?=
 =?us-ascii?Q?J2T8GLwWl6Kehe2Kc3hoH6cXCQNl9xglUI6Dj4Sp8YiEOfmQtmsCKgoEQ63u?=
 =?us-ascii?Q?YHchzQE2CoEWyW1DNijavGgSmryer4o7Tf+jHR317vviFDXt8cgg1DFEv9jZ?=
 =?us-ascii?Q?ZCXxU8yyI/4h4hEY8bzoW86EbMMgy4mIJhWPllawFBXLDzvwXm/h+f3MN5UZ?=
 =?us-ascii?Q?5LkEByw07FTW9mWXIptwDkx05Ig7zzHuWznHLbhztZS6d1wHjhMHhUz0VGMf?=
 =?us-ascii?Q?xVXaCM/lBe5O2VRTYSFb8zZ/+ZlmZ7a1XnhKgJSAh2J7X8tlWTZ4jC04XgD7?=
 =?us-ascii?Q?Xp5CZfIcgrJsgbm8bkN7WuI3qpO9x4IxMQwxikoduI16EGcmNiYrluQG9tu4?=
 =?us-ascii?Q?HNCfXBpbquXMeWmJps0kyBbi8XC2TUA5itPVR65gpOFP0DNBEklD4ME04zoR?=
 =?us-ascii?Q?S/YrOJqilMwq12iPyWEh/se7oDPDTE8VaevZ7KY2pUuQbjcpGV1fBj7c5QBG?=
 =?us-ascii?Q?JwdSJpTtHCypqhrGTm5akM7xK9UgUwqnfwVeqt5CxX1R+PYZcb5HFv8rmxh4?=
 =?us-ascii?Q?Mfw5OEHz1MTmVxoF3aQeVY4k2O3LF+GbNjbUQlQQw9WIeKbJKQ1ig9yuZ6H8?=
 =?us-ascii?Q?gD3n0pQSeKcccet95hYems5TVSYiyfN/duBl18mJ5x3w9h/31/50P4iNMeMn?=
 =?us-ascii?Q?8YqpADnBM1g1z+ZacoZ6hCnzRzOPA9i8YNQhYiyv/3yNTGflassq1U5T3TN6?=
 =?us-ascii?Q?00wzkFhsQfwHBYbe1Yf8FE33JyByT1yiu+nnbXoMiGNwZwxm2iMi6dYFnAJe?=
 =?us-ascii?Q?TQKRvc565c+Xwg8FTKsAzLmoxeyTOi09CKDAUp1vb9vNCf7dQglJ2eQeUm+R?=
 =?us-ascii?Q?5LU2OuFKVMCjhGlB0n30mk6NpXSbyjWyKzl/qLXerajxLIcqoMLjn/nNb6T1?=
 =?us-ascii?Q?yw/mQItwwsImBDVENjmTzNu7DbHC1+h2uOWrJiOMgcYuN7iLz5IVDXB73uYg?=
 =?us-ascii?Q?lbeiINAKSjewx2uv9FA46Nfshfv1P5BDobGb0zyT/It43Cqv3x/GvpAICqX0?=
 =?us-ascii?Q?80Eg0XHm6Tu7KlWNu8lnmkl+9fzRLwuCc8KFVAgkLtVoawEOK3EdV5U34VXR?=
 =?us-ascii?Q?pUAaKmtOKEI35S8LdffK+mG/uY5KqHPvDfEjTtWgFXkgG91GjZgdU/T5+96f?=
 =?us-ascii?Q?1nV54DRox7tv7sO3WOTW0M8A1PQXPlFuT68o+PErQ74LFh70TKqYlZtsCCai?=
 =?us-ascii?Q?wrK/nYS/NoPyQxioc2E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ef8878-9a96-40d5-912c-08dac1230d34
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:11.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNEDYKn/Zkma0oUmLgqsa31oCMkYFU7EeBeDQ9e+rXgLCc2gNc9yi0DgILznASsh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

Cover the essential functionality of the iommufd with a directed
test. This aims to achieve reasonable functional coverage using the
in-kernel self test framework.

It provides a mock kernel module for the iommu_domain that allows it to
run without any HW and the mocking provides a way to directly validate
that the PFNs loaded into the iommu_domain are correct.

The mock also simulates the rare case of PAGE_SIZE > iommu page size as
the mock will operate at a 2K iommu page size. This allows exercising all
of the calculations to support this mismatch.

This allows achieving high coverage of the corner cases in the iopt_pages.

However, it is an unusually invasive config option to enable all of
this. The config option should not be enabled in a production kernel.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/Kconfig                 |   11 +
 drivers/iommu/iommufd/Makefile                |    2 +
 drivers/iommu/iommufd/device.c                |   38 +
 drivers/iommu/iommufd/ioas.c                  |    3 +
 drivers/iommu/iommufd/iommufd_private.h       |   35 +
 drivers/iommu/iommufd/iommufd_test.h          |   93 +
 drivers/iommu/iommufd/main.c                  |   14 +
 drivers/iommu/iommufd/pages.c                 |    8 +
 drivers/iommu/iommufd/selftest.c              |  853 +++++++++
 include/linux/iommufd.h                       |    3 +
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/iommu/.gitignore      |    3 +
 tools/testing/selftests/iommu/Makefile        |   12 +
 tools/testing/selftests/iommu/config          |    2 +
 tools/testing/selftests/iommu/iommufd.c       | 1627 +++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  580 ++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  278 +++
 17 files changed, 3563 insertions(+)
 create mode 100644 drivers/iommu/iommufd/iommufd_test.h
 create mode 100644 drivers/iommu/iommufd/selftest.c
 create mode 100644 tools/testing/selftests/iommu/.gitignore
 create mode 100644 tools/testing/selftests/iommu/Makefile
 create mode 100644 tools/testing/selftests/iommu/config
 create mode 100644 tools/testing/selftests/iommu/iommufd.c
 create mode 100644 tools/testing/selftests/iommu/iommufd_fail_nth.c
 create mode 100644 tools/testing/selftests/iommu/iommufd_utils.h

diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
index 6d65d0f06f169f..399a2edeaef6de 100644
--- a/drivers/iommu/iommufd/Kconfig
+++ b/drivers/iommu/iommufd/Kconfig
@@ -10,3 +10,14 @@ config IOMMUFD
 	  it relates to managing IO page tables that point at user space memory.
 
 	  If you don't know what to do here, say N.
+
+if IOMMUFD
+config IOMMUFD_TEST
+	bool "IOMMU Userspace API Test support"
+	depends on RUNTIME_TESTING_MENU
+	depends on FAULT_INJECTION
+	default n
+	help
+	  This is dangerous, do not enable unless running
+	  tools/testing/selftests/iommu
+endif
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 2fdff04000b326..8aeba81800c512 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -8,4 +8,6 @@ iommufd-y := \
 	pages.o \
 	vfio_compat.o
 
+iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
+
 obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index da365d0cf4cf19..8ca5a38b2a79b8 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -703,3 +703,41 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, IOMMUFD);
+
+#ifdef CONFIG_IOMMUFD_TEST
+/*
+ * Creating a real iommufd_device is too hard, bypass creating a iommufd_device
+ * and go directly to attaching a domain.
+ */
+struct iommufd_hw_pagetable *
+iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
+			       struct iommufd_ioas *ioas,
+			       struct device *mock_dev)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	int rc;
+
+	hwpt = iommufd_hw_pagetable_alloc(ictx, ioas, mock_dev);
+	if (IS_ERR(hwpt))
+		return hwpt;
+
+	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
+	if (rc)
+		goto out_hwpt;
+
+	refcount_inc(&hwpt->obj.users);
+	iommufd_object_finalize(ictx, &hwpt->obj);
+	return hwpt;
+
+out_hwpt:
+	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
+	return ERR_PTR(rc);
+}
+
+void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
+				    struct iommufd_hw_pagetable *hwpt)
+{
+	iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+	refcount_dec(&hwpt->obj.users);
+}
+#endif
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 64e6d0f73e39aa..9e5b8c16bc9c45 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -237,6 +237,9 @@ int iommufd_ioas_copy(struct iommufd_ucmd *ucmd)
 	unsigned long iova;
 	int rc;
 
+	iommufd_test_syz_conv_iova_id(ucmd, cmd->src_ioas_id, &cmd->src_iova,
+				      &cmd->flags);
+
 	if ((cmd->flags &
 	     ~(IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE |
 	       IOMMU_IOAS_MAP_READABLE)))
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5bb9788fc5aef1..7605c5a5a6091b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -113,6 +113,9 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_HW_PAGETABLE,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
+#ifdef CONFIG_IOMMUFD_TEST
+	IOMMUFD_OBJ_SELFTEST,
+#endif
 };
 
 /* Base struct for all objects with a userspace ID handle. */
@@ -269,4 +272,36 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			struct iommufd_access *access);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+#ifdef CONFIG_IOMMUFD_TEST
+struct iommufd_hw_pagetable *
+iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
+			       struct iommufd_ioas *ioas,
+			       struct device *mock_dev);
+void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
+				    struct iommufd_hw_pagetable *hwpt);
+int iommufd_test(struct iommufd_ucmd *ucmd);
+void iommufd_selftest_destroy(struct iommufd_object *obj);
+extern size_t iommufd_test_memory_limit;
+void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
+				   unsigned int ioas_id, u64 *iova, u32 *flags);
+bool iommufd_should_fail(void);
+void __init iommufd_test_init(void);
+void iommufd_test_exit(void);
+#else
+static inline void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
+						 unsigned int ioas_id,
+						 u64 *iova, u32 *flags)
+{
+}
+static inline bool iommufd_should_fail(void)
+{
+	return false;
+}
+static inline void __init iommufd_test_init(void)
+{
+}
+static inline void iommufd_test_exit(void)
+{
+}
+#endif
 #endif
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
new file mode 100644
index 00000000000000..1d96a8f466fd29
--- /dev/null
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES.
+ */
+#ifndef _UAPI_IOMMUFD_TEST_H
+#define _UAPI_IOMMUFD_TEST_H
+
+#include <linux/types.h>
+#include <linux/iommufd.h>
+
+enum {
+	IOMMU_TEST_OP_ADD_RESERVED = 1,
+	IOMMU_TEST_OP_MOCK_DOMAIN,
+	IOMMU_TEST_OP_MD_CHECK_MAP,
+	IOMMU_TEST_OP_MD_CHECK_REFS,
+	IOMMU_TEST_OP_CREATE_ACCESS,
+	IOMMU_TEST_OP_DESTROY_ACCESS_PAGES,
+	IOMMU_TEST_OP_ACCESS_PAGES,
+	IOMMU_TEST_OP_ACCESS_RW,
+	IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
+};
+
+enum {
+	MOCK_APERTURE_START = 1UL << 24,
+	MOCK_APERTURE_LAST = (1UL << 31) - 1,
+};
+
+enum {
+	MOCK_FLAGS_ACCESS_WRITE = 1 << 0,
+	MOCK_FLAGS_ACCESS_SYZ = 1 << 16,
+};
+
+enum {
+	MOCK_ACCESS_RW_WRITE = 1 << 0,
+	MOCK_ACCESS_RW_SLOW_PATH = 1 << 2,
+};
+
+enum {
+	MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES = 1 << 0,
+};
+
+struct iommu_test_cmd {
+	__u32 size;
+	__u32 op;
+	__u32 id;
+	__u32 __reserved;
+	union {
+		struct {
+			__aligned_u64 start;
+			__aligned_u64 length;
+		} add_reserved;
+		struct {
+			__u32 out_device_id;
+			__u32 out_hwpt_id;
+		} mock_domain;
+		struct {
+			__aligned_u64 iova;
+			__aligned_u64 length;
+			__aligned_u64 uptr;
+		} check_map;
+		struct {
+			__aligned_u64 length;
+			__aligned_u64 uptr;
+			__u32 refs;
+		} check_refs;
+		struct {
+			__u32 out_access_fd;
+			__u32 flags;
+		} create_access;
+		struct {
+			__u32 access_pages_id;
+		} destroy_access_pages;
+		struct {
+			__u32 flags;
+			__u32 out_access_pages_id;
+			__aligned_u64 iova;
+			__aligned_u64 length;
+			__aligned_u64 uptr;
+		} access_pages;
+		struct {
+			__aligned_u64 iova;
+			__aligned_u64 length;
+			__aligned_u64 uptr;
+			__u32 flags;
+		} access_rw;
+		struct {
+			__u32 limit;
+		} memory_limit;
+	};
+	__u32 last;
+};
+#define IOMMU_TEST_CMD _IO(IOMMUFD_TYPE, IOMMUFD_CMD_BASE + 32)
+
+#endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index f76b2c8dcde8e5..7de0f95f2ee68a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -19,6 +19,7 @@
 #include <linux/iommufd.h>
 
 #include "iommufd_private.h"
+#include "iommufd_test.h"
 
 struct iommufd_object_ops {
 	void (*destroy)(struct iommufd_object *obj);
@@ -234,6 +235,9 @@ union ucmd_buffer {
 	struct iommu_ioas_iova_ranges iova_ranges;
 	struct iommu_ioas_map map;
 	struct iommu_ioas_unmap unmap;
+#ifdef CONFIG_IOMMUFD_TEST
+	struct iommu_test_cmd test;
+#endif
 };
 
 struct iommufd_ioctl_op {
@@ -270,6 +274,9 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+#ifdef CONFIG_IOMMUFD_TEST
+	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
+#endif
 };
 
 static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
@@ -370,6 +377,11 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_HW_PAGETABLE] = {
 		.destroy = iommufd_hw_pagetable_destroy,
 	},
+#ifdef CONFIG_IOMMUFD_TEST
+	[IOMMUFD_OBJ_SELFTEST] = {
+		.destroy = iommufd_selftest_destroy,
+	},
+#endif
 };
 
 static struct miscdevice iommu_misc_dev = {
@@ -387,11 +399,13 @@ static int __init iommufd_init(void)
 	ret = misc_register(&iommu_misc_dev);
 	if (ret)
 		return ret;
+	iommufd_test_init();
 	return 0;
 }
 
 static void __exit iommufd_exit(void)
 {
+	iommufd_test_exit();
 	misc_deregister(&iommu_misc_dev);
 }
 
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index d8f3f2a07e8378..c3783ea01d7996 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -56,7 +56,11 @@
 #include "io_pagetable.h"
 #include "double_span.h"
 
+#ifndef CONFIG_IOMMUFD_TEST
 #define TEMP_MEMORY_LIMIT 65536
+#else
+#define TEMP_MEMORY_LIMIT iommufd_test_memory_limit
+#endif
 #define BATCH_BACKUP_SIZE 32
 
 /*
@@ -1671,6 +1675,10 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 	bool change_mm = current->mm != pages->source_mm;
 	int rc = 0;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    (flags & __IOMMUFD_ACCESS_RW_SLOW_PATH))
+		change_mm = true;
+
 	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
 		return -EPERM;
 
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
new file mode 100644
index 00000000000000..d31493f4fdf473
--- /dev/null
+++ b/drivers/iommu/iommufd/selftest.c
@@ -0,0 +1,853 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ * Kernel side components to support tools/testing/selftests/iommu
+ */
+#include <linux/slab.h>
+#include <linux/iommu.h>
+#include <linux/xarray.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
+#include <linux/fault-inject.h>
+#include <uapi/linux/iommufd.h>
+
+#include "io_pagetable.h"
+#include "iommufd_private.h"
+#include "iommufd_test.h"
+
+static DECLARE_FAULT_ATTR(fail_iommufd);
+static struct dentry *dbgfs_root;
+
+size_t iommufd_test_memory_limit = 65536;
+
+enum {
+	MOCK_IO_PAGE_SIZE = PAGE_SIZE / 2,
+
+	/*
+	 * Like a real page table alignment requires the low bits of the address
+	 * to be zero. xarray also requires the high bit to be zero, so we store
+	 * the pfns shifted. The upper bits are used for metadata.
+	 */
+	MOCK_PFN_MASK = ULONG_MAX / MOCK_IO_PAGE_SIZE,
+
+	_MOCK_PFN_START = MOCK_PFN_MASK + 1,
+	MOCK_PFN_START_IOVA = _MOCK_PFN_START,
+	MOCK_PFN_LAST_IOVA = _MOCK_PFN_START,
+};
+
+/*
+ * Syzkaller has trouble randomizing the correct iova to use since it is linked
+ * to the map ioctl's output, and it has no ide about that. So, simplify things.
+ * In syzkaller mode the 64 bit IOVA is converted into an nth area and offset
+ * value. This has a much smaller randomization space and syzkaller can hit it.
+ */
+static unsigned long iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
+						u64 *iova)
+{
+	struct syz_layout {
+		__u32 nth_area;
+		__u32 offset;
+	};
+	struct syz_layout *syz = (void *)iova;
+	unsigned int nth = syz->nth_area;
+	struct iopt_area *area;
+
+	down_read(&iopt->iova_rwsem);
+	for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
+	     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
+		if (nth == 0) {
+			up_read(&iopt->iova_rwsem);
+			return iopt_area_iova(area) + syz->offset;
+		}
+		nth--;
+	}
+	up_read(&iopt->iova_rwsem);
+
+	return 0;
+}
+
+void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
+				   unsigned int ioas_id, u64 *iova, u32 *flags)
+{
+	struct iommufd_ioas *ioas;
+
+	if (!(*flags & MOCK_FLAGS_ACCESS_SYZ))
+		return;
+	*flags &= ~(u32)MOCK_FLAGS_ACCESS_SYZ;
+
+	ioas = iommufd_get_ioas(ucmd, ioas_id);
+	if (IS_ERR(ioas))
+		return;
+	*iova = iommufd_test_syz_conv_iova(&ioas->iopt, iova);
+	iommufd_put_object(&ioas->obj);
+}
+
+struct mock_iommu_domain {
+	struct iommu_domain domain;
+	struct xarray pfns;
+};
+
+enum selftest_obj_type {
+	TYPE_IDEV,
+};
+
+struct selftest_obj {
+	struct iommufd_object obj;
+	enum selftest_obj_type type;
+
+	union {
+		struct {
+			struct iommufd_hw_pagetable *hwpt;
+			struct iommufd_ctx *ictx;
+			struct device mock_dev;
+		} idev;
+	};
+};
+
+static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
+{
+	struct mock_iommu_domain *mock;
+
+	if (WARN_ON(iommu_domain_type != IOMMU_DOMAIN_UNMANAGED))
+		return NULL;
+
+	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
+	if (!mock)
+		return NULL;
+	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
+	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
+	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
+	xa_init(&mock->pfns);
+	return &mock->domain;
+}
+
+static void mock_domain_free(struct iommu_domain *domain)
+{
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+
+	WARN_ON(!xa_empty(&mock->pfns));
+	kfree(mock);
+}
+
+static int mock_domain_map_pages(struct iommu_domain *domain,
+				 unsigned long iova, phys_addr_t paddr,
+				 size_t pgsize, size_t pgcount, int prot,
+				 gfp_t gfp, size_t *mapped)
+{
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+	unsigned long flags = MOCK_PFN_START_IOVA;
+	unsigned long start_iova = iova;
+
+	/*
+	 * xarray does not reliably work with fault injection because it does a
+	 * retry allocation, so put our own failure point.
+	 */
+	if (iommufd_should_fail())
+		return -ENOENT;
+
+	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
+	WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
+	for (; pgcount; pgcount--) {
+		size_t cur;
+
+		for (cur = 0; cur != pgsize; cur += MOCK_IO_PAGE_SIZE) {
+			void *old;
+
+			if (pgcount == 1 && cur + MOCK_IO_PAGE_SIZE == pgsize)
+				flags = MOCK_PFN_LAST_IOVA;
+			old = xa_store(&mock->pfns, iova / MOCK_IO_PAGE_SIZE,
+				       xa_mk_value((paddr / MOCK_IO_PAGE_SIZE) |
+						   flags),
+				       GFP_KERNEL);
+			if (xa_is_err(old)) {
+				for (; start_iova != iova;
+				     start_iova += MOCK_IO_PAGE_SIZE)
+					xa_erase(&mock->pfns,
+						 start_iova /
+							 MOCK_IO_PAGE_SIZE);
+				return xa_err(old);
+			}
+			WARN_ON(old);
+			iova += MOCK_IO_PAGE_SIZE;
+			paddr += MOCK_IO_PAGE_SIZE;
+			*mapped += MOCK_IO_PAGE_SIZE;
+			flags = 0;
+		}
+	}
+	return 0;
+}
+
+static size_t mock_domain_unmap_pages(struct iommu_domain *domain,
+				      unsigned long iova, size_t pgsize,
+				      size_t pgcount,
+				      struct iommu_iotlb_gather *iotlb_gather)
+{
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+	bool first = true;
+	size_t ret = 0;
+	void *ent;
+
+	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
+	WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
+
+	for (; pgcount; pgcount--) {
+		size_t cur;
+
+		for (cur = 0; cur != pgsize; cur += MOCK_IO_PAGE_SIZE) {
+			ent = xa_erase(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
+			WARN_ON(!ent);
+			/*
+			 * iommufd generates unmaps that must be a strict
+			 * superset of the map's performend So every starting
+			 * IOVA should have been an iova passed to map, and the
+			 *
+			 * First IOVA must be present and have been a first IOVA
+			 * passed to map_pages
+			 */
+			if (first) {
+				WARN_ON(!(xa_to_value(ent) &
+					  MOCK_PFN_START_IOVA));
+				first = false;
+			}
+			if (pgcount == 1 && cur + MOCK_IO_PAGE_SIZE == pgsize)
+				WARN_ON(!(xa_to_value(ent) &
+					  MOCK_PFN_LAST_IOVA));
+
+			iova += MOCK_IO_PAGE_SIZE;
+			ret += MOCK_IO_PAGE_SIZE;
+		}
+	}
+	return ret;
+}
+
+static phys_addr_t mock_domain_iova_to_phys(struct iommu_domain *domain,
+					    dma_addr_t iova)
+{
+	struct mock_iommu_domain *mock =
+		container_of(domain, struct mock_iommu_domain, domain);
+	void *ent;
+
+	WARN_ON(iova % MOCK_IO_PAGE_SIZE);
+	ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
+	WARN_ON(!ent);
+	return (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE;
+}
+
+static const struct iommu_ops mock_ops = {
+	.owner = THIS_MODULE,
+	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
+	.domain_alloc = mock_domain_alloc,
+	.default_domain_ops =
+		&(struct iommu_domain_ops){
+			.free = mock_domain_free,
+			.map_pages = mock_domain_map_pages,
+			.unmap_pages = mock_domain_unmap_pages,
+			.iova_to_phys = mock_domain_iova_to_phys,
+		},
+};
+
+static inline struct iommufd_hw_pagetable *
+get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
+		 struct mock_iommu_domain **mock)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_object *obj;
+
+	obj = iommufd_get_object(ucmd->ictx, mockpt_id,
+				 IOMMUFD_OBJ_HW_PAGETABLE);
+	if (IS_ERR(obj))
+		return ERR_CAST(obj);
+	hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
+	if (hwpt->domain->ops != mock_ops.default_domain_ops) {
+		iommufd_put_object(&hwpt->obj);
+		return ERR_PTR(-EINVAL);
+	}
+	*mock = container_of(hwpt->domain, struct mock_iommu_domain, domain);
+	return hwpt;
+}
+
+/* Create an hw_pagetable with the mock domain so we can test the domain ops */
+static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
+				    struct iommu_test_cmd *cmd)
+{
+	static struct bus_type mock_bus = { .iommu_ops = &mock_ops };
+	struct iommufd_hw_pagetable *hwpt;
+	struct selftest_obj *sobj;
+	struct iommufd_ioas *ioas;
+	int rc;
+
+	ioas = iommufd_get_ioas(ucmd, cmd->id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	sobj = iommufd_object_alloc(ucmd->ictx, sobj, IOMMUFD_OBJ_SELFTEST);
+	if (IS_ERR(sobj)) {
+		rc = PTR_ERR(sobj);
+		goto out_ioas;
+	}
+	sobj->idev.ictx = ucmd->ictx;
+	sobj->type = TYPE_IDEV;
+	sobj->idev.mock_dev.bus = &mock_bus;
+
+	hwpt = iommufd_device_selftest_attach(ucmd->ictx, ioas,
+					      &sobj->idev.mock_dev);
+	if (IS_ERR(hwpt)) {
+		rc = PTR_ERR(hwpt);
+		goto out_sobj;
+	}
+	sobj->idev.hwpt = hwpt;
+
+	/* Userspace must destroy both of these IDs to destroy the object */
+	cmd->mock_domain.out_hwpt_id = hwpt->obj.id;
+	cmd->mock_domain.out_device_id = sobj->obj.id;
+	iommufd_object_finalize(ucmd->ictx, &sobj->obj);
+	iommufd_put_object(&ioas->obj);
+	return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_sobj:
+	iommufd_object_abort(ucmd->ictx, &sobj->obj);
+out_ioas:
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+/* Add an additional reserved IOVA to the IOAS */
+static int iommufd_test_add_reserved(struct iommufd_ucmd *ucmd,
+				     unsigned int mockpt_id,
+				     unsigned long start, size_t length)
+{
+	struct iommufd_ioas *ioas;
+	int rc;
+
+	ioas = iommufd_get_ioas(ucmd, mockpt_id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+	down_write(&ioas->iopt.iova_rwsem);
+	rc = iopt_reserve_iova(&ioas->iopt, start, start + length - 1, NULL);
+	up_write(&ioas->iopt.iova_rwsem);
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+/* Check that every pfn under each iova matches the pfn under a user VA */
+static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
+				    unsigned int mockpt_id, unsigned long iova,
+				    size_t length, void __user *uptr)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct mock_iommu_domain *mock;
+	int rc;
+
+	if (iova % MOCK_IO_PAGE_SIZE || length % MOCK_IO_PAGE_SIZE ||
+	    (uintptr_t)uptr % MOCK_IO_PAGE_SIZE)
+		return -EINVAL;
+
+	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	for (; length; length -= MOCK_IO_PAGE_SIZE) {
+		struct page *pages[1];
+		unsigned long pfn;
+		long npages;
+		void *ent;
+
+		npages = get_user_pages_fast((uintptr_t)uptr & PAGE_MASK, 1, 0,
+					     pages);
+		if (npages < 0) {
+			rc = npages;
+			goto out_put;
+		}
+		if (WARN_ON(npages != 1)) {
+			rc = -EFAULT;
+			goto out_put;
+		}
+		pfn = page_to_pfn(pages[0]);
+		put_page(pages[0]);
+
+		ent = xa_load(&mock->pfns, iova / MOCK_IO_PAGE_SIZE);
+		if (!ent ||
+		    (xa_to_value(ent) & MOCK_PFN_MASK) * MOCK_IO_PAGE_SIZE !=
+			    pfn * PAGE_SIZE + ((uintptr_t)uptr % PAGE_SIZE)) {
+			rc = -EINVAL;
+			goto out_put;
+		}
+		iova += MOCK_IO_PAGE_SIZE;
+		uptr += MOCK_IO_PAGE_SIZE;
+	}
+	rc = 0;
+
+out_put:
+	iommufd_put_object(&hwpt->obj);
+	return rc;
+}
+
+/* Check that the page ref count matches, to look for missing pin/unpins */
+static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
+				      void __user *uptr, size_t length,
+				      unsigned int refs)
+{
+	if (length % PAGE_SIZE || (uintptr_t)uptr % PAGE_SIZE)
+		return -EINVAL;
+
+	for (; length; length -= PAGE_SIZE) {
+		struct page *pages[1];
+		long npages;
+
+		npages = get_user_pages_fast((uintptr_t)uptr, 1, 0, pages);
+		if (npages < 0)
+			return npages;
+		if (WARN_ON(npages != 1))
+			return -EFAULT;
+		if (!PageCompound(pages[0])) {
+			unsigned int count;
+
+			count = page_ref_count(pages[0]);
+			if (count / GUP_PIN_COUNTING_BIAS != refs) {
+				put_page(pages[0]);
+				return -EIO;
+			}
+		}
+		put_page(pages[0]);
+		uptr += PAGE_SIZE;
+	}
+	return 0;
+}
+
+struct selftest_access {
+	struct iommufd_access *access;
+	struct file *file;
+	struct mutex lock;
+	struct list_head items;
+	unsigned int next_id;
+	bool destroying;
+};
+
+struct selftest_access_item {
+	struct list_head items_elm;
+	unsigned long iova;
+	size_t length;
+	unsigned int id;
+};
+
+static const struct file_operations iommfd_test_staccess_fops;
+
+static struct selftest_access *iommufd_access_get(int fd)
+{
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		return ERR_PTR(-EBADFD);
+
+	if (file->f_op != &iommfd_test_staccess_fops) {
+		fput(file);
+		return ERR_PTR(-EBADFD);
+	}
+	return file->private_data;
+}
+
+static void iommufd_test_access_unmap(void *data, unsigned long iova,
+				      unsigned long length)
+{
+	unsigned long iova_last = iova + length - 1;
+	struct selftest_access *staccess = data;
+	struct selftest_access_item *item;
+	struct selftest_access_item *tmp;
+
+	mutex_lock(&staccess->lock);
+	list_for_each_entry_safe(item, tmp, &staccess->items, items_elm) {
+		if (iova > item->iova + item->length - 1 ||
+		    iova_last < item->iova)
+			continue;
+		list_del(&item->items_elm);
+		iommufd_access_unpin_pages(staccess->access, item->iova,
+					   item->length);
+		kfree(item);
+	}
+	mutex_unlock(&staccess->lock);
+}
+
+static int iommufd_test_access_item_destroy(struct iommufd_ucmd *ucmd,
+					    unsigned int access_id,
+					    unsigned int item_id)
+{
+	struct selftest_access_item *item;
+	struct selftest_access *staccess;
+
+	staccess = iommufd_access_get(access_id);
+	if (IS_ERR(staccess))
+		return PTR_ERR(staccess);
+
+	mutex_lock(&staccess->lock);
+	list_for_each_entry(item, &staccess->items, items_elm) {
+		if (item->id == item_id) {
+			list_del(&item->items_elm);
+			iommufd_access_unpin_pages(staccess->access, item->iova,
+						   item->length);
+			mutex_unlock(&staccess->lock);
+			kfree(item);
+			fput(staccess->file);
+			return 0;
+		}
+	}
+	mutex_unlock(&staccess->lock);
+	fput(staccess->file);
+	return -ENOENT;
+}
+
+static int iommufd_test_staccess_release(struct inode *inode,
+					 struct file *filep)
+{
+	struct selftest_access *staccess = filep->private_data;
+
+	if (staccess->access) {
+		iommufd_test_access_unmap(staccess, 0, ULONG_MAX);
+		iommufd_access_destroy(staccess->access);
+	}
+	mutex_destroy(&staccess->lock);
+	kfree(staccess);
+	return 0;
+}
+
+static const struct iommufd_access_ops selftest_access_ops_pin = {
+	.needs_pin_pages = 1,
+	.unmap = iommufd_test_access_unmap,
+};
+
+static const struct iommufd_access_ops selftest_access_ops = {
+	.unmap = iommufd_test_access_unmap,
+};
+
+static const struct file_operations iommfd_test_staccess_fops = {
+	.release = iommufd_test_staccess_release,
+};
+
+static struct selftest_access *iommufd_test_alloc_access(void)
+{
+	struct selftest_access *staccess;
+	struct file *filep;
+
+	staccess = kzalloc(sizeof(*staccess), GFP_KERNEL_ACCOUNT);
+	if (!staccess)
+		return ERR_PTR(-ENOMEM);
+	INIT_LIST_HEAD(&staccess->items);
+	mutex_init(&staccess->lock);
+
+	filep = anon_inode_getfile("[iommufd_test_staccess]",
+				   &iommfd_test_staccess_fops, staccess,
+				   O_RDWR);
+	if (IS_ERR(filep)) {
+		kfree(staccess);
+		return ERR_CAST(filep);
+	}
+	staccess->file = filep;
+	return staccess;
+}
+
+static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
+				      unsigned int ioas_id, unsigned int flags)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+	struct selftest_access *staccess;
+	struct iommufd_access *access;
+	int fdno;
+	int rc;
+
+	if (flags & ~MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES)
+		return -EOPNOTSUPP;
+
+	staccess = iommufd_test_alloc_access();
+	if (IS_ERR(staccess))
+		return PTR_ERR(staccess);
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0) {
+		rc = -ENOMEM;
+		goto out_free_staccess;
+	}
+
+	access = iommufd_access_create(
+		ucmd->ictx, ioas_id,
+		(flags & MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES) ?
+			&selftest_access_ops_pin :
+			&selftest_access_ops,
+		staccess);
+	if (IS_ERR(access)) {
+		rc = PTR_ERR(access);
+		goto out_put_fdno;
+	}
+	cmd->create_access.out_access_fd = fdno;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_destroy;
+
+	staccess->access = access;
+	fd_install(fdno, staccess->file);
+	return 0;
+
+out_destroy:
+	iommufd_access_destroy(access);
+out_put_fdno:
+	put_unused_fd(fdno);
+out_free_staccess:
+	fput(staccess->file);
+	return rc;
+}
+
+/* Check that the pages in a page array match the pages in the user VA */
+static int iommufd_test_check_pages(void __user *uptr, struct page **pages,
+				    size_t npages)
+{
+	for (; npages; npages--) {
+		struct page *tmp_pages[1];
+		long rc;
+
+		rc = get_user_pages_fast((uintptr_t)uptr, 1, 0, tmp_pages);
+		if (rc < 0)
+			return rc;
+		if (WARN_ON(rc != 1))
+			return -EFAULT;
+		put_page(tmp_pages[0]);
+		if (tmp_pages[0] != *pages)
+			return -EBADE;
+		pages++;
+		uptr += PAGE_SIZE;
+	}
+	return 0;
+}
+
+static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
+				     unsigned int access_id, unsigned long iova,
+				     size_t length, void __user *uptr,
+				     u32 flags)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+	struct selftest_access_item *item;
+	struct selftest_access *staccess;
+	struct page **pages;
+	size_t npages;
+	int rc;
+
+	/* Prevent syzkaller from triggering a WARN_ON in kvzalloc() */
+	if (length > 16*1024*1024)
+		return -ENOMEM;
+
+	if (flags & ~(MOCK_FLAGS_ACCESS_WRITE | MOCK_FLAGS_ACCESS_SYZ))
+		return -EOPNOTSUPP;
+
+	staccess = iommufd_access_get(access_id);
+	if (IS_ERR(staccess))
+		return PTR_ERR(staccess);
+
+	if (staccess->access->ops != &selftest_access_ops_pin) {
+		rc = -EOPNOTSUPP;
+		goto out_put;
+	}
+
+	if (flags & MOCK_FLAGS_ACCESS_SYZ)
+		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
+					&cmd->access_pages.iova);
+
+	npages = (ALIGN(iova + length, PAGE_SIZE) -
+		  ALIGN_DOWN(iova, PAGE_SIZE)) /
+		 PAGE_SIZE;
+	pages = kvcalloc(npages, sizeof(*pages), GFP_KERNEL_ACCOUNT);
+	if (!pages) {
+		rc = -ENOMEM;
+		goto out_put;
+	}
+
+	/*
+	 * Drivers will need to think very carefully about this locking. The
+	 * core code can do multiple unmaps instantaneously after
+	 * iommufd_access_pin_pages() and *all* the unmaps must not return until
+	 * the range is unpinned. This simple implementation puts a global lock
+	 * around the pin, which may not suit drivers that want this to be a
+	 * performance path. drivers that get this wrong will trigger WARN_ON
+	 * races and cause EDEADLOCK failures to userspace.
+	 */
+	mutex_lock(&staccess->lock);
+	rc = iommufd_access_pin_pages(staccess->access, iova, length, pages,
+				      flags & MOCK_FLAGS_ACCESS_WRITE);
+	if (rc)
+		goto out_unlock;
+
+	/* For syzkaller allow uptr to be NULL to skip this check */
+	if (uptr) {
+		rc = iommufd_test_check_pages(
+			uptr - (iova - ALIGN_DOWN(iova, PAGE_SIZE)), pages,
+			npages);
+		if (rc)
+			goto out_unaccess;
+	}
+
+	item = kzalloc(sizeof(*item), GFP_KERNEL_ACCOUNT);
+	if (!item) {
+		rc = -ENOMEM;
+		goto out_unaccess;
+	}
+
+	item->iova = iova;
+	item->length = length;
+	item->id = staccess->next_id++;
+	list_add_tail(&item->items_elm, &staccess->items);
+
+	cmd->access_pages.out_access_pages_id = item->id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_free_item;
+	goto out_unlock;
+
+out_free_item:
+	list_del(&item->items_elm);
+	kfree(item);
+out_unaccess:
+	iommufd_access_unpin_pages(staccess->access, iova, length);
+out_unlock:
+	mutex_unlock(&staccess->lock);
+	kvfree(pages);
+out_put:
+	fput(staccess->file);
+	return rc;
+}
+
+static int iommufd_test_access_rw(struct iommufd_ucmd *ucmd,
+				  unsigned int access_id, unsigned long iova,
+				  size_t length, void __user *ubuf,
+				  unsigned int flags)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+	struct selftest_access *staccess;
+	void *tmp;
+	int rc;
+
+	/* Prevent syzkaller from triggering a WARN_ON in kvzalloc() */
+	if (length > 16*1024*1024)
+		return -ENOMEM;
+
+	if (flags & ~(MOCK_ACCESS_RW_WRITE | MOCK_ACCESS_RW_SLOW_PATH |
+		      MOCK_FLAGS_ACCESS_SYZ))
+		return -EOPNOTSUPP;
+
+	staccess = iommufd_access_get(access_id);
+	if (IS_ERR(staccess))
+		return PTR_ERR(staccess);
+
+	tmp = kvzalloc(length, GFP_KERNEL_ACCOUNT);
+	if (!tmp) {
+		rc = -ENOMEM;
+		goto out_put;
+	}
+
+	if (flags & MOCK_ACCESS_RW_WRITE) {
+		if (copy_from_user(tmp, ubuf, length)) {
+			rc = -EFAULT;
+			goto out_free;
+		}
+	}
+
+	if (flags & MOCK_FLAGS_ACCESS_SYZ)
+		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
+					&cmd->access_rw.iova);
+
+	rc = iommufd_access_rw(staccess->access, iova, tmp, length, flags);
+	if (rc)
+		goto out_free;
+	if (!(flags & MOCK_ACCESS_RW_WRITE)) {
+		if (copy_to_user(ubuf, tmp, length)) {
+			rc = -EFAULT;
+			goto out_free;
+		}
+	}
+
+out_free:
+	kvfree(tmp);
+out_put:
+	fput(staccess->file);
+	return rc;
+}
+static_assert((unsigned int)MOCK_ACCESS_RW_WRITE == IOMMUFD_ACCESS_RW_WRITE);
+static_assert((unsigned int)MOCK_ACCESS_RW_SLOW_PATH ==
+	      __IOMMUFD_ACCESS_RW_SLOW_PATH);
+
+void iommufd_selftest_destroy(struct iommufd_object *obj)
+{
+	struct selftest_obj *sobj = container_of(obj, struct selftest_obj, obj);
+
+	switch (sobj->type) {
+	case TYPE_IDEV:
+		iommufd_device_selftest_detach(sobj->idev.ictx,
+					       sobj->idev.hwpt);
+		break;
+	}
+}
+
+int iommufd_test(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+
+	switch (cmd->op) {
+	case IOMMU_TEST_OP_ADD_RESERVED:
+		return iommufd_test_add_reserved(ucmd, cmd->id,
+						 cmd->add_reserved.start,
+						 cmd->add_reserved.length);
+	case IOMMU_TEST_OP_MOCK_DOMAIN:
+		return iommufd_test_mock_domain(ucmd, cmd);
+	case IOMMU_TEST_OP_MD_CHECK_MAP:
+		return iommufd_test_md_check_pa(
+			ucmd, cmd->id, cmd->check_map.iova,
+			cmd->check_map.length,
+			u64_to_user_ptr(cmd->check_map.uptr));
+	case IOMMU_TEST_OP_MD_CHECK_REFS:
+		return iommufd_test_md_check_refs(
+			ucmd, u64_to_user_ptr(cmd->check_refs.uptr),
+			cmd->check_refs.length, cmd->check_refs.refs);
+	case IOMMU_TEST_OP_CREATE_ACCESS:
+		return iommufd_test_create_access(ucmd, cmd->id,
+						  cmd->create_access.flags);
+	case IOMMU_TEST_OP_ACCESS_PAGES:
+		return iommufd_test_access_pages(
+			ucmd, cmd->id, cmd->access_pages.iova,
+			cmd->access_pages.length,
+			u64_to_user_ptr(cmd->access_pages.uptr),
+			cmd->access_pages.flags);
+	case IOMMU_TEST_OP_ACCESS_RW:
+		return iommufd_test_access_rw(
+			ucmd, cmd->id, cmd->access_rw.iova,
+			cmd->access_rw.length,
+			u64_to_user_ptr(cmd->access_rw.uptr),
+			cmd->access_rw.flags);
+	case IOMMU_TEST_OP_DESTROY_ACCESS_PAGES:
+		return iommufd_test_access_item_destroy(
+			ucmd, cmd->id, cmd->destroy_access_pages.access_pages_id);
+	case IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT:
+		/* Protect _batch_init(), can not be less than elmsz */
+		if (cmd->memory_limit.limit <
+		    sizeof(unsigned long) + sizeof(u32))
+			return -EINVAL;
+		iommufd_test_memory_limit = cmd->memory_limit.limit;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+bool iommufd_should_fail(void)
+{
+	return should_fail(&fail_iommufd, 1);
+}
+
+void __init iommufd_test_init(void)
+{
+	dbgfs_root =
+		fault_create_debugfs_attr("fail_iommufd", NULL, &fail_iommufd);
+}
+
+void iommufd_test_exit(void)
+{
+	debugfs_remove_recursive(dbgfs_root);
+}
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index d57b044acca4cb..7a5d64a1dae482 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -38,6 +38,9 @@ enum {
 	IOMMUFD_ACCESS_RW_WRITE = 1 << 0,
 	/* Set if the caller is in a kthread then rw will use kthread_use_mm() */
 	IOMMUFD_ACCESS_RW_KTHREAD = 1 << 1,
+
+	/* Only for use by selftest */
+	__IOMMUFD_ACCESS_RW_SLOW_PATH = 1 << 2,
 };
 
 struct iommufd_access *
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f07aef7c592c2e..d6680af7b2956e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -27,6 +27,7 @@ TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
 TARGETS += intel_pstate
+TARGETS += iommu
 TARGETS += ipc
 TARGETS += ir
 TARGETS += kcmp
diff --git a/tools/testing/selftests/iommu/.gitignore b/tools/testing/selftests/iommu/.gitignore
new file mode 100644
index 00000000000000..7d0703049ebaf4
--- /dev/null
+++ b/tools/testing/selftests/iommu/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/iommufd
+/iommufd_fail_nth
diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
new file mode 100644
index 00000000000000..7cb74d26f14171
--- /dev/null
+++ b/tools/testing/selftests/iommu/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -Wall -O2 -Wno-unused-function
+CFLAGS += -I../../../../include/uapi/
+CFLAGS += -I../../../../include/
+
+CFLAGS += -D_GNU_SOURCE
+
+TEST_GEN_PROGS :=
+TEST_GEN_PROGS += iommufd
+TEST_GEN_PROGS += iommufd_fail_nth
+
+include ../lib.mk
diff --git a/tools/testing/selftests/iommu/config b/tools/testing/selftests/iommu/config
new file mode 100644
index 00000000000000..6c4f901d6fed3c
--- /dev/null
+++ b/tools/testing/selftests/iommu/config
@@ -0,0 +1,2 @@
+CONFIG_IOMMUFD
+CONFIG_IOMMUFD_TEST
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
new file mode 100644
index 00000000000000..4ff3592b282b70
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -0,0 +1,1627 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES */
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/eventfd.h>
+
+#define __EXPORTED_HEADERS__
+#include <linux/vfio.h>
+
+#include "iommufd_utils.h"
+
+static void *buffer;
+
+static unsigned long PAGE_SIZE;
+static unsigned long HUGEPAGE_SIZE;
+
+#define MOCK_PAGE_SIZE (PAGE_SIZE / 2)
+
+static unsigned long get_huge_page_size(void)
+{
+	char buf[80];
+	int ret;
+	int fd;
+
+	fd = open("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size",
+		  O_RDONLY);
+	if (fd < 0)
+		return 2 * 1024 * 1024;
+
+	ret = read(fd, buf, sizeof(buf));
+	close(fd);
+	if (ret <= 0 || ret == sizeof(buf))
+		return 2 * 1024 * 1024;
+	buf[ret] = 0;
+	return strtoul(buf, NULL, 10);
+}
+
+static __attribute__((constructor)) void setup_sizes(void)
+{
+	void *vrc;
+	int rc;
+
+	PAGE_SIZE = sysconf(_SC_PAGE_SIZE);
+	HUGEPAGE_SIZE = get_huge_page_size();
+
+	BUFFER_SIZE = PAGE_SIZE * 16;
+	rc = posix_memalign(&buffer, HUGEPAGE_SIZE, BUFFER_SIZE);
+	assert(!rc);
+	assert(buffer);
+	assert((uintptr_t)buffer % HUGEPAGE_SIZE == 0);
+	vrc = mmap(buffer, BUFFER_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	assert(vrc == buffer);
+}
+
+FIXTURE(iommufd)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(iommufd)
+{
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+}
+
+FIXTURE_TEARDOWN(iommufd)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+TEST_F(iommufd, simple_close)
+{
+}
+
+TEST_F(iommufd, cmd_fail)
+{
+	struct iommu_destroy cmd = { .size = sizeof(cmd), .id = 0 };
+
+	/* object id is invalid */
+	EXPECT_ERRNO(ENOENT, _test_ioctl_destroy(self->fd, 0));
+	/* Bad pointer */
+	EXPECT_ERRNO(EFAULT, ioctl(self->fd, IOMMU_DESTROY, NULL));
+	/* Unknown ioctl */
+	EXPECT_ERRNO(ENOTTY,
+		     ioctl(self->fd, _IO(IOMMUFD_TYPE, IOMMUFD_CMD_BASE - 1),
+			   &cmd));
+}
+
+TEST_F(iommufd, cmd_length)
+{
+#define TEST_LENGTH(_struct, _ioctl)                                     \
+	{                                                                \
+		struct {                                                 \
+			struct _struct cmd;                              \
+			uint8_t extra;                                   \
+		} cmd = { .cmd = { .size = sizeof(struct _struct) - 1 }, \
+			  .extra = UINT8_MAX };                          \
+		int old_errno;                                           \
+		int rc;                                                  \
+									 \
+		EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, _ioctl, &cmd)); \
+		cmd.cmd.size = sizeof(struct _struct) + 1;               \
+		EXPECT_ERRNO(E2BIG, ioctl(self->fd, _ioctl, &cmd));      \
+		cmd.cmd.size = sizeof(struct _struct);                   \
+		rc = ioctl(self->fd, _ioctl, &cmd);                      \
+		old_errno = errno;                                       \
+		cmd.cmd.size = sizeof(struct _struct) + 1;               \
+		cmd.extra = 0;                                           \
+		if (rc) {                                                \
+			EXPECT_ERRNO(old_errno,                          \
+				     ioctl(self->fd, _ioctl, &cmd));     \
+		} else {                                                 \
+			ASSERT_EQ(0, ioctl(self->fd, _ioctl, &cmd));     \
+		}                                                        \
+	}
+
+	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY);
+	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC);
+	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES);
+	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS);
+	TEST_LENGTH(iommu_ioas_map, IOMMU_IOAS_MAP);
+	TEST_LENGTH(iommu_ioas_copy, IOMMU_IOAS_COPY);
+	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP);
+	TEST_LENGTH(iommu_option, IOMMU_OPTION);
+	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
+#undef TEST_LENGTH
+}
+
+TEST_F(iommufd, cmd_ex_fail)
+{
+	struct {
+		struct iommu_destroy cmd;
+		__u64 future;
+	} cmd = { .cmd = { .size = sizeof(cmd), .id = 0 } };
+
+	/* object id is invalid and command is longer */
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+	/* future area is non-zero */
+	cmd.future = 1;
+	EXPECT_ERRNO(E2BIG, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+	/* Original command "works" */
+	cmd.cmd.size = sizeof(cmd.cmd);
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+	/* Short command fails */
+	cmd.cmd.size = sizeof(cmd.cmd) - 1;
+	EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+}
+
+TEST_F(iommufd, global_options)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_RLIMIT_MODE,
+		.op = IOMMU_OPTION_OP_GET,
+		.val64 = 1,
+	};
+
+	cmd.option_id = IOMMU_OPTION_RLIMIT_MODE;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(0, cmd.val64);
+
+	/* This requires root */
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 1;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	cmd.val64 = 2;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_GET;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(1, cmd.val64);
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 0;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_GET;
+	cmd.option_id = IOMMU_OPTION_HUGE_PAGES;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	cmd.op = IOMMU_OPTION_OP_SET;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
+}
+
+FIXTURE(iommufd_ioas)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t domain_id;
+	uint64_t base_iova;
+};
+
+FIXTURE_VARIANT(iommufd_ioas)
+{
+	unsigned int mock_domains;
+	unsigned int memory_limit;
+};
+
+FIXTURE_SETUP(iommufd_ioas)
+{
+	unsigned int i;
+
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+	test_ioctl_ioas_alloc(&self->ioas_id);
+
+	if (!variant->memory_limit) {
+		test_ioctl_set_default_memory_limit();
+	} else {
+		test_ioctl_set_temp_memory_limit(variant->memory_limit);
+	}
+
+	for (i = 0; i != variant->mock_domains; i++) {
+		test_cmd_mock_domain(self->ioas_id, NULL, &self->domain_id);
+		self->base_iova = MOCK_APERTURE_START;
+	}
+}
+
+FIXTURE_TEARDOWN(iommufd_ioas)
+{
+	test_ioctl_set_default_memory_limit();
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, no_domain)
+{
+};
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, mock_domain)
+{
+	.mock_domains = 1,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, two_mock_domain)
+{
+	.mock_domains = 2,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, mock_domain_limit)
+{
+	.mock_domains = 1,
+	.memory_limit = 16,
+};
+
+TEST_F(iommufd_ioas, ioas_auto_destroy)
+{
+}
+
+TEST_F(iommufd_ioas, ioas_destroy)
+{
+	if (self->domain_id) {
+		/* IOAS cannot be freed while a domain is on it */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->ioas_id));
+	} else {
+		/* Can allocate and manually free an IOAS table */
+		test_ioctl_destroy(self->ioas_id);
+	}
+}
+
+TEST_F(iommufd_ioas, ioas_area_destroy)
+{
+	/* Adding an area does not change ability to destroy */
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, self->base_iova);
+	if (self->domain_id)
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->ioas_id));
+	else
+		test_ioctl_destroy(self->ioas_id);
+}
+
+TEST_F(iommufd_ioas, ioas_area_auto_destroy)
+{
+	int i;
+
+	/* Can allocate and automatically free an IOAS table with many areas */
+	for (i = 0; i != 10; i++) {
+		test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE,
+					  self->base_iova + i * PAGE_SIZE);
+	}
+}
+
+TEST_F(iommufd_ioas, area)
+{
+	int i;
+
+	/* Unmap fails if nothing is mapped */
+	for (i = 0; i != 10; i++)
+		test_err_ioctl_ioas_unmap(ENOENT, i * PAGE_SIZE, PAGE_SIZE);
+
+	/* Unmap works */
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE,
+					  self->base_iova + i * PAGE_SIZE);
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(self->base_iova + i * PAGE_SIZE,
+				      PAGE_SIZE);
+
+	/* Split fails */
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE * 2,
+				  self->base_iova + 16 * PAGE_SIZE);
+	test_err_ioctl_ioas_unmap(ENOENT, self->base_iova + 16 * PAGE_SIZE,
+				  PAGE_SIZE);
+	test_err_ioctl_ioas_unmap(ENOENT, self->base_iova + 17 * PAGE_SIZE,
+				  PAGE_SIZE);
+
+	/* Over map fails */
+	test_err_ioctl_ioas_map_fixed(EADDRINUSE, buffer, PAGE_SIZE * 2,
+				      self->base_iova + 16 * PAGE_SIZE);
+	test_err_ioctl_ioas_map_fixed(EADDRINUSE, buffer, PAGE_SIZE,
+				      self->base_iova + 16 * PAGE_SIZE);
+	test_err_ioctl_ioas_map_fixed(EADDRINUSE, buffer, PAGE_SIZE,
+				      self->base_iova + 17 * PAGE_SIZE);
+	test_err_ioctl_ioas_map_fixed(EADDRINUSE, buffer, PAGE_SIZE * 2,
+				      self->base_iova + 15 * PAGE_SIZE);
+	test_err_ioctl_ioas_map_fixed(EADDRINUSE, buffer, PAGE_SIZE * 3,
+				      self->base_iova + 15 * PAGE_SIZE);
+
+	/* unmap all works */
+	test_ioctl_ioas_unmap(0, UINT64_MAX);
+
+	/* Unmap all succeeds on an empty IOAS */
+	test_ioctl_ioas_unmap(0, UINT64_MAX);
+}
+
+TEST_F(iommufd_ioas, unmap_fully_contained_areas)
+{
+	uint64_t unmap_len;
+	int i;
+
+	/* Give no_domain some space to rewind base_iova */
+	self->base_iova += 4 * PAGE_SIZE;
+
+	for (i = 0; i != 4; i++)
+		test_ioctl_ioas_map_fixed(buffer, 8 * PAGE_SIZE,
+					  self->base_iova + i * 16 * PAGE_SIZE);
+
+	/* Unmap not fully contained area doesn't work */
+	test_err_ioctl_ioas_unmap(ENOENT, self->base_iova - 4 * PAGE_SIZE,
+				  8 * PAGE_SIZE);
+	test_err_ioctl_ioas_unmap(ENOENT,
+				  self->base_iova + 3 * 16 * PAGE_SIZE +
+					  8 * PAGE_SIZE - 4 * PAGE_SIZE,
+				  8 * PAGE_SIZE);
+
+	/* Unmap fully contained areas works */
+	ASSERT_EQ(0, _test_ioctl_ioas_unmap(self->fd, self->ioas_id,
+					    self->base_iova - 4 * PAGE_SIZE,
+					    3 * 16 * PAGE_SIZE + 8 * PAGE_SIZE +
+						    4 * PAGE_SIZE,
+					    &unmap_len));
+	ASSERT_EQ(32 * PAGE_SIZE, unmap_len);
+}
+
+TEST_F(iommufd_ioas, area_auto_iova)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_ADD_RESERVED,
+		.id = self->ioas_id,
+		.add_reserved = { .start = PAGE_SIZE * 4,
+				  .length = PAGE_SIZE * 100 },
+	};
+	struct iommu_iova_range ranges[1] = {};
+	struct iommu_ioas_allow_iovas allow_cmd = {
+		.size = sizeof(allow_cmd),
+		.ioas_id = self->ioas_id,
+		.num_iovas = 1,
+		.allowed_iovas = (uintptr_t)ranges,
+	};
+	__u64 iovas[10];
+	int i;
+
+	/* Simple 4k pages */
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_map(buffer, PAGE_SIZE, &iovas[i]);
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE);
+
+	/* Kernel automatically aligns IOVAs properly */
+	for (i = 0; i != 10; i++) {
+		size_t length = PAGE_SIZE * (i + 1);
+
+		if (self->domain_id) {
+			test_ioctl_ioas_map(buffer, length, &iovas[i]);
+		} else {
+			test_ioctl_ioas_map((void *)(1UL << 31), length,
+					    &iovas[i]);
+		}
+		EXPECT_EQ(0, iovas[i] % (1UL << (ffs(length) - 1)));
+	}
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE * (i + 1));
+
+	/* Avoids a reserved region */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			&test_cmd));
+	for (i = 0; i != 10; i++) {
+		size_t length = PAGE_SIZE * (i + 1);
+
+		test_ioctl_ioas_map(buffer, length, &iovas[i]);
+		EXPECT_EQ(0, iovas[i] % (1UL << (ffs(length) - 1)));
+		EXPECT_EQ(false,
+			  iovas[i] > test_cmd.add_reserved.start &&
+				  iovas[i] <
+					  test_cmd.add_reserved.start +
+						  test_cmd.add_reserved.length);
+	}
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE * (i + 1));
+
+	/* Allowed region intersects with a reserved region */
+	ranges[0].start = PAGE_SIZE;
+	ranges[0].last = PAGE_SIZE * 600;
+	EXPECT_ERRNO(EADDRINUSE,
+		     ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+
+	/* Allocate from an allowed region */
+	if (self->domain_id) {
+		ranges[0].start = MOCK_APERTURE_START + PAGE_SIZE;
+		ranges[0].last = MOCK_APERTURE_START + PAGE_SIZE * 600 - 1;
+	} else {
+		ranges[0].start = PAGE_SIZE * 200;
+		ranges[0].last = PAGE_SIZE * 600 - 1;
+	}
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+	for (i = 0; i != 10; i++) {
+		size_t length = PAGE_SIZE * (i + 1);
+
+		test_ioctl_ioas_map(buffer, length, &iovas[i]);
+		EXPECT_EQ(0, iovas[i] % (1UL << (ffs(length) - 1)));
+		EXPECT_EQ(true, iovas[i] >= ranges[0].start);
+		EXPECT_EQ(true, iovas[i] <= ranges[0].last);
+		EXPECT_EQ(true, iovas[i] + length > ranges[0].start);
+		EXPECT_EQ(true, iovas[i] + length <= ranges[0].last + 1);
+	}
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE * (i + 1));
+}
+
+TEST_F(iommufd_ioas, area_allowed)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_ADD_RESERVED,
+		.id = self->ioas_id,
+		.add_reserved = { .start = PAGE_SIZE * 4,
+				  .length = PAGE_SIZE * 100 },
+	};
+	struct iommu_iova_range ranges[1] = {};
+	struct iommu_ioas_allow_iovas allow_cmd = {
+		.size = sizeof(allow_cmd),
+		.ioas_id = self->ioas_id,
+		.num_iovas = 1,
+		.allowed_iovas = (uintptr_t)ranges,
+	};
+
+	/* Reserved intersects an allowed */
+	allow_cmd.num_iovas = 1;
+	ranges[0].start = self->base_iova;
+	ranges[0].last = ranges[0].start + PAGE_SIZE * 600;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+	test_cmd.add_reserved.start = ranges[0].start + PAGE_SIZE;
+	test_cmd.add_reserved.length = PAGE_SIZE;
+	EXPECT_ERRNO(EADDRINUSE,
+		     ioctl(self->fd,
+			   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			   &test_cmd));
+	allow_cmd.num_iovas = 0;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+
+	/* Allowed intersects a reserved */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			&test_cmd));
+	allow_cmd.num_iovas = 1;
+	ranges[0].start = self->base_iova;
+	ranges[0].last = ranges[0].start + PAGE_SIZE * 600;
+	EXPECT_ERRNO(EADDRINUSE,
+		     ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+}
+
+TEST_F(iommufd_ioas, copy_area)
+{
+	struct iommu_ioas_copy copy_cmd = {
+		.size = sizeof(copy_cmd),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA,
+		.dst_ioas_id = self->ioas_id,
+		.src_ioas_id = self->ioas_id,
+		.length = PAGE_SIZE,
+	};
+
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, self->base_iova);
+
+	/* Copy inside a single IOAS */
+	copy_cmd.src_iova = self->base_iova;
+	copy_cmd.dst_iova = self->base_iova + PAGE_SIZE;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+
+	/* Copy between IOAS's */
+	copy_cmd.src_iova = self->base_iova;
+	copy_cmd.dst_iova = 0;
+	test_ioctl_ioas_alloc(&copy_cmd.dst_ioas_id);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+}
+
+TEST_F(iommufd_ioas, iova_ranges)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_ADD_RESERVED,
+		.id = self->ioas_id,
+		.add_reserved = { .start = PAGE_SIZE, .length = PAGE_SIZE },
+	};
+	struct iommu_iova_range *ranges = buffer;
+	struct iommu_ioas_iova_ranges ranges_cmd = {
+		.size = sizeof(ranges_cmd),
+		.ioas_id = self->ioas_id,
+		.num_iovas = BUFFER_SIZE / sizeof(*ranges),
+		.allowed_iovas = (uintptr_t)ranges,
+	};
+
+	/* Range can be read */
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+	EXPECT_EQ(1, ranges_cmd.num_iovas);
+	if (!self->domain_id) {
+		EXPECT_EQ(0, ranges[0].start);
+		EXPECT_EQ(SIZE_MAX, ranges[0].last);
+		EXPECT_EQ(1, ranges_cmd.out_iova_alignment);
+	} else {
+		EXPECT_EQ(MOCK_APERTURE_START, ranges[0].start);
+		EXPECT_EQ(MOCK_APERTURE_LAST, ranges[0].last);
+		EXPECT_EQ(MOCK_PAGE_SIZE, ranges_cmd.out_iova_alignment);
+	}
+
+	/* Buffer too small */
+	memset(ranges, 0, BUFFER_SIZE);
+	ranges_cmd.num_iovas = 0;
+	EXPECT_ERRNO(EMSGSIZE,
+		     ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+	EXPECT_EQ(1, ranges_cmd.num_iovas);
+	EXPECT_EQ(0, ranges[0].start);
+	EXPECT_EQ(0, ranges[0].last);
+
+	/* 2 ranges */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			&test_cmd));
+	ranges_cmd.num_iovas = BUFFER_SIZE / sizeof(*ranges);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+	if (!self->domain_id) {
+		EXPECT_EQ(2, ranges_cmd.num_iovas);
+		EXPECT_EQ(0, ranges[0].start);
+		EXPECT_EQ(PAGE_SIZE - 1, ranges[0].last);
+		EXPECT_EQ(PAGE_SIZE * 2, ranges[1].start);
+		EXPECT_EQ(SIZE_MAX, ranges[1].last);
+	} else {
+		EXPECT_EQ(1, ranges_cmd.num_iovas);
+		EXPECT_EQ(MOCK_APERTURE_START, ranges[0].start);
+		EXPECT_EQ(MOCK_APERTURE_LAST, ranges[0].last);
+	}
+
+	/* Buffer too small */
+	memset(ranges, 0, BUFFER_SIZE);
+	ranges_cmd.num_iovas = 1;
+	if (!self->domain_id) {
+		EXPECT_ERRNO(EMSGSIZE, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES,
+					     &ranges_cmd));
+		EXPECT_EQ(2, ranges_cmd.num_iovas);
+		EXPECT_EQ(0, ranges[0].start);
+		EXPECT_EQ(PAGE_SIZE - 1, ranges[0].last);
+	} else {
+		ASSERT_EQ(0,
+			  ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+		EXPECT_EQ(1, ranges_cmd.num_iovas);
+		EXPECT_EQ(MOCK_APERTURE_START, ranges[0].start);
+		EXPECT_EQ(MOCK_APERTURE_LAST, ranges[0].last);
+	}
+	EXPECT_EQ(0, ranges[1].start);
+	EXPECT_EQ(0, ranges[1].last);
+}
+
+TEST_F(iommufd_ioas, access_pin)
+{
+	struct iommu_test_cmd access_cmd = {
+		.size = sizeof(access_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_PAGES,
+		.access_pages = { .iova = MOCK_APERTURE_START,
+				  .length = BUFFER_SIZE,
+				  .uptr = (uintptr_t)buffer },
+	};
+	struct iommu_test_cmd check_map_cmd = {
+		.size = sizeof(check_map_cmd),
+		.op = IOMMU_TEST_OP_MD_CHECK_MAP,
+		.check_map = { .iova = MOCK_APERTURE_START,
+			       .length = BUFFER_SIZE,
+			       .uptr = (uintptr_t)buffer },
+	};
+	uint32_t access_pages_id;
+	unsigned int npages;
+
+	test_cmd_create_access(self->ioas_id, &access_cmd.id,
+			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
+
+	for (npages = 1; npages < BUFFER_SIZE / PAGE_SIZE; npages++) {
+		uint32_t mock_device_id;
+		uint32_t mock_hwpt_id;
+
+		access_cmd.access_pages.length = npages * PAGE_SIZE;
+
+		/* Single map/unmap */
+		test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE,
+					  MOCK_APERTURE_START);
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+				   &access_cmd));
+		test_cmd_destroy_access_pages(
+			access_cmd.id,
+			access_cmd.access_pages.out_access_pages_id);
+
+		/* Double user */
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+				   &access_cmd));
+		access_pages_id = access_cmd.access_pages.out_access_pages_id;
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+				   &access_cmd));
+		test_cmd_destroy_access_pages(
+			access_cmd.id,
+			access_cmd.access_pages.out_access_pages_id);
+		test_cmd_destroy_access_pages(access_cmd.id, access_pages_id);
+
+		/* Add/remove a domain with a user */
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+				   &access_cmd));
+		test_cmd_mock_domain(self->ioas_id, &mock_device_id,
+				     &mock_hwpt_id);
+		check_map_cmd.id = mock_hwpt_id;
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
+				   &check_map_cmd));
+
+		test_ioctl_destroy(mock_device_id);
+		test_ioctl_destroy(mock_hwpt_id);
+		test_cmd_destroy_access_pages(
+			access_cmd.id,
+			access_cmd.access_pages.out_access_pages_id);
+
+		test_ioctl_ioas_unmap(MOCK_APERTURE_START, BUFFER_SIZE);
+	}
+	test_cmd_destroy_access(access_cmd.id);
+}
+
+TEST_F(iommufd_ioas, access_pin_unmap)
+{
+	struct iommu_test_cmd access_pages_cmd = {
+		.size = sizeof(access_pages_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_PAGES,
+		.access_pages = { .iova = MOCK_APERTURE_START,
+				  .length = BUFFER_SIZE,
+				  .uptr = (uintptr_t)buffer },
+	};
+
+	test_cmd_create_access(self->ioas_id, &access_pages_cmd.id,
+			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
+	test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE, MOCK_APERTURE_START);
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_pages_cmd));
+
+	/* Trigger the unmap op */
+	test_ioctl_ioas_unmap(MOCK_APERTURE_START, BUFFER_SIZE);
+
+	/* kernel removed the item for us */
+	test_err_destroy_access_pages(
+		ENOENT, access_pages_cmd.id,
+		access_pages_cmd.access_pages.out_access_pages_id);
+}
+
+static void check_access_rw(struct __test_metadata *_metadata, int fd,
+			    unsigned int access_id, uint64_t iova,
+			    unsigned int def_flags)
+{
+	uint16_t tmp[32];
+	struct iommu_test_cmd access_cmd = {
+		.size = sizeof(access_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_RW,
+		.id = access_id,
+		.access_rw = { .uptr = (uintptr_t)tmp },
+	};
+	uint16_t *buffer16 = buffer;
+	unsigned int i;
+	void *tmp2;
+
+	for (i = 0; i != BUFFER_SIZE / sizeof(*buffer16); i++)
+		buffer16[i] = rand();
+
+	for (access_cmd.access_rw.iova = iova + PAGE_SIZE - 50;
+	     access_cmd.access_rw.iova < iova + PAGE_SIZE + 50;
+	     access_cmd.access_rw.iova++) {
+		for (access_cmd.access_rw.length = 1;
+		     access_cmd.access_rw.length < sizeof(tmp);
+		     access_cmd.access_rw.length++) {
+			access_cmd.access_rw.flags = def_flags;
+			ASSERT_EQ(0, ioctl(fd,
+					   _IOMMU_TEST_CMD(
+						   IOMMU_TEST_OP_ACCESS_RW),
+					   &access_cmd));
+			ASSERT_EQ(0,
+				  memcmp(buffer + (access_cmd.access_rw.iova -
+						   iova),
+					 tmp, access_cmd.access_rw.length));
+
+			for (i = 0; i != ARRAY_SIZE(tmp); i++)
+				tmp[i] = rand();
+			access_cmd.access_rw.flags = def_flags |
+						     MOCK_ACCESS_RW_WRITE;
+			ASSERT_EQ(0, ioctl(fd,
+					   _IOMMU_TEST_CMD(
+						   IOMMU_TEST_OP_ACCESS_RW),
+					   &access_cmd));
+			ASSERT_EQ(0,
+				  memcmp(buffer + (access_cmd.access_rw.iova -
+						   iova),
+					 tmp, access_cmd.access_rw.length));
+		}
+	}
+
+	/* Multi-page test */
+	tmp2 = malloc(BUFFER_SIZE);
+	ASSERT_NE(NULL, tmp2);
+	access_cmd.access_rw.iova = iova;
+	access_cmd.access_rw.length = BUFFER_SIZE;
+	access_cmd.access_rw.flags = def_flags;
+	access_cmd.access_rw.uptr = (uintptr_t)tmp2;
+	ASSERT_EQ(0, ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			   &access_cmd));
+	ASSERT_EQ(0, memcmp(buffer, tmp2, access_cmd.access_rw.length));
+	free(tmp2);
+}
+
+TEST_F(iommufd_ioas, access_rw)
+{
+	__u32 access_id;
+	__u64 iova;
+
+	test_cmd_create_access(self->ioas_id, &access_id, 0);
+	test_ioctl_ioas_map(buffer, BUFFER_SIZE, &iova);
+	check_access_rw(_metadata, self->fd, access_id, iova, 0);
+	check_access_rw(_metadata, self->fd, access_id, iova,
+			MOCK_ACCESS_RW_SLOW_PATH);
+	test_ioctl_ioas_unmap(iova, BUFFER_SIZE);
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, access_rw_unaligned)
+{
+	__u32 access_id;
+	__u64 iova;
+
+	test_cmd_create_access(self->ioas_id, &access_id, 0);
+
+	/* Unaligned pages */
+	iova = self->base_iova + MOCK_PAGE_SIZE;
+	test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE, iova);
+	check_access_rw(_metadata, self->fd, access_id, iova, 0);
+	test_ioctl_ioas_unmap(iova, BUFFER_SIZE);
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, fork_gone)
+{
+	__u32 access_id;
+	pid_t child;
+
+	test_cmd_create_access(self->ioas_id, &access_id, 0);
+
+	/* Create a mapping with a different mm */
+	child = fork();
+	if (!child) {
+		test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE,
+					  MOCK_APERTURE_START);
+		exit(0);
+	}
+	ASSERT_NE(-1, child);
+	ASSERT_EQ(child, waitpid(child, NULL, 0));
+
+	if (self->domain_id) {
+		/*
+		 * If a domain already existed then everything was pinned within
+		 * the fork, so this copies from one domain to another.
+		 */
+		test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+		check_access_rw(_metadata, self->fd, access_id,
+				MOCK_APERTURE_START, 0);
+
+	} else {
+		/*
+		 * Otherwise we need to actually pin pages which can't happen
+		 * since the fork is gone.
+		 */
+		test_err_mock_domain(EFAULT, self->ioas_id, NULL, NULL);
+	}
+
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, fork_present)
+{
+	__u32 access_id;
+	int pipefds[2];
+	uint64_t tmp;
+	pid_t child;
+	int efd;
+
+	test_cmd_create_access(self->ioas_id, &access_id, 0);
+
+	ASSERT_EQ(0, pipe2(pipefds, O_CLOEXEC));
+	efd = eventfd(0, EFD_CLOEXEC);
+	ASSERT_NE(-1, efd);
+
+	/* Create a mapping with a different mm */
+	child = fork();
+	if (!child) {
+		__u64 iova;
+		uint64_t one = 1;
+
+		close(pipefds[1]);
+		test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE,
+					  MOCK_APERTURE_START);
+		if (write(efd, &one, sizeof(one)) != sizeof(one))
+			exit(100);
+		if (read(pipefds[0], &iova, 1) != 1)
+			exit(100);
+		exit(0);
+	}
+	close(pipefds[0]);
+	ASSERT_NE(-1, child);
+	ASSERT_EQ(8, read(efd, &tmp, sizeof(tmp)));
+
+	/* Read pages from the remote process */
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	check_access_rw(_metadata, self->fd, access_id, MOCK_APERTURE_START, 0);
+
+	ASSERT_EQ(0, close(pipefds[1]));
+	ASSERT_EQ(child, waitpid(child, NULL, 0));
+
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, ioas_option_huge_pages)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_HUGE_PAGES,
+		.op = IOMMU_OPTION_OP_GET,
+		.val64 = 3,
+		.object_id = self->ioas_id,
+	};
+
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(1, cmd.val64);
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 0;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_GET;
+	cmd.val64 = 3;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(0, cmd.val64);
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 2;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 1;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+}
+
+TEST_F(iommufd_ioas, ioas_iova_alloc)
+{
+	unsigned int length;
+	__u64 iova;
+
+	for (length = 1; length != PAGE_SIZE * 2; length++) {
+		if (variant->mock_domains && (length % MOCK_PAGE_SIZE)) {
+			test_err_ioctl_ioas_map(EINVAL, buffer, length, &iova);
+		} else {
+			test_ioctl_ioas_map(buffer, length, &iova);
+			test_ioctl_ioas_unmap(iova, length);
+		}
+	}
+}
+
+TEST_F(iommufd_ioas, ioas_align_change)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_HUGE_PAGES,
+		.op = IOMMU_OPTION_OP_SET,
+		.object_id = self->ioas_id,
+		/* 0 means everything must be aligned to PAGE_SIZE */
+		.val64 = 0,
+	};
+
+	/*
+	 * We cannot upgrade the alignment using OPTION_HUGE_PAGES when a domain
+	 * and map are present.
+	 */
+	if (variant->mock_domains)
+		return;
+
+	/*
+	 * We can upgrade to PAGE_SIZE alignment when things are aligned right
+	 */
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, MOCK_APERTURE_START);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	/* Misalignment is rejected at map time */
+	test_err_ioctl_ioas_map_fixed(EINVAL, buffer + MOCK_PAGE_SIZE,
+				      PAGE_SIZE,
+				      MOCK_APERTURE_START + PAGE_SIZE);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	/* Reduce alignment */
+	cmd.val64 = 1;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	/* Confirm misalignment is rejected during alignment upgrade */
+	test_ioctl_ioas_map_fixed(buffer + MOCK_PAGE_SIZE, PAGE_SIZE,
+				  MOCK_APERTURE_START + PAGE_SIZE);
+	cmd.val64 = 0;
+	EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	test_ioctl_ioas_unmap(MOCK_APERTURE_START + PAGE_SIZE, PAGE_SIZE);
+	test_ioctl_ioas_unmap(MOCK_APERTURE_START, PAGE_SIZE);
+}
+
+TEST_F(iommufd_ioas, copy_sweep)
+{
+	struct iommu_ioas_copy copy_cmd = {
+		.size = sizeof(copy_cmd),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA,
+		.src_ioas_id = self->ioas_id,
+		.dst_iova = MOCK_APERTURE_START,
+		.length = MOCK_PAGE_SIZE,
+	};
+	unsigned int dst_ioas_id;
+	uint64_t last_iova;
+	uint64_t iova;
+
+	test_ioctl_ioas_alloc(&dst_ioas_id);
+	copy_cmd.dst_ioas_id = dst_ioas_id;
+
+	if (variant->mock_domains)
+		last_iova = MOCK_APERTURE_START + BUFFER_SIZE - 1;
+	else
+		last_iova = MOCK_APERTURE_START + BUFFER_SIZE - 2;
+
+	test_ioctl_ioas_map_fixed(buffer, last_iova - MOCK_APERTURE_START + 1,
+				  MOCK_APERTURE_START);
+
+	for (iova = MOCK_APERTURE_START - PAGE_SIZE; iova <= last_iova;
+	     iova += 511) {
+		copy_cmd.src_iova = iova;
+		if (iova < MOCK_APERTURE_START ||
+		    iova + copy_cmd.length - 1 > last_iova) {
+			EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_IOAS_COPY,
+						   &copy_cmd));
+		} else {
+			ASSERT_EQ(0,
+				  ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+			test_ioctl_ioas_unmap_id(dst_ioas_id, copy_cmd.dst_iova,
+						 copy_cmd.length);
+		}
+	}
+
+	test_ioctl_destroy(dst_ioas_id);
+}
+
+FIXTURE(iommufd_mock_domain)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t domain_id;
+	uint32_t domain_ids[2];
+	int mmap_flags;
+	size_t mmap_buf_size;
+};
+
+FIXTURE_VARIANT(iommufd_mock_domain)
+{
+	unsigned int mock_domains;
+	bool hugepages;
+};
+
+FIXTURE_SETUP(iommufd_mock_domain)
+{
+	unsigned int i;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+	test_ioctl_ioas_alloc(&self->ioas_id);
+
+	ASSERT_GE(ARRAY_SIZE(self->domain_ids), variant->mock_domains);
+
+	for (i = 0; i != variant->mock_domains; i++)
+		test_cmd_mock_domain(self->ioas_id, NULL, &self->domain_ids[i]);
+	self->domain_id = self->domain_ids[0];
+
+	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
+	self->mmap_buf_size = PAGE_SIZE * 8;
+	if (variant->hugepages) {
+		/*
+		 * MAP_POPULATE will cause the kernel to fail mmap if THPs are
+		 * not available.
+		 */
+		self->mmap_flags |= MAP_HUGETLB | MAP_POPULATE;
+		self->mmap_buf_size = HUGEPAGE_SIZE * 2;
+	}
+}
+
+FIXTURE_TEARDOWN(iommufd_mock_domain)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain)
+{
+	.mock_domains = 1,
+	.hugepages = false,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains)
+{
+	.mock_domains = 2,
+	.hugepages = false,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_hugepage)
+{
+	.mock_domains = 1,
+	.hugepages = true,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains_hugepage)
+{
+	.mock_domains = 2,
+	.hugepages = true,
+};
+
+/* Have the kernel check that the user pages made it to the iommu_domain */
+#define check_mock_iova(_ptr, _iova, _length)                                \
+	({                                                                   \
+		struct iommu_test_cmd check_map_cmd = {                      \
+			.size = sizeof(check_map_cmd),                       \
+			.op = IOMMU_TEST_OP_MD_CHECK_MAP,                    \
+			.id = self->domain_id,                               \
+			.check_map = { .iova = _iova,                        \
+				       .length = _length,                    \
+				       .uptr = (uintptr_t)(_ptr) },          \
+		};                                                           \
+		ASSERT_EQ(0,                                                 \
+			  ioctl(self->fd,                                    \
+				_IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP), \
+				&check_map_cmd));                            \
+		if (self->domain_ids[1]) {                                   \
+			check_map_cmd.id = self->domain_ids[1];              \
+			ASSERT_EQ(0,                                         \
+				  ioctl(self->fd,                            \
+					_IOMMU_TEST_CMD(                     \
+						IOMMU_TEST_OP_MD_CHECK_MAP), \
+					&check_map_cmd));                    \
+		}                                                            \
+	})
+
+TEST_F(iommufd_mock_domain, basic)
+{
+	size_t buf_size = self->mmap_buf_size;
+	uint8_t *buf;
+	__u64 iova;
+
+	/* Simple one page map */
+	test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
+	check_mock_iova(buffer, iova, PAGE_SIZE);
+
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+
+	/* EFAULT half way through mapping */
+	ASSERT_EQ(0, munmap(buf + buf_size / 2, buf_size / 2));
+	test_err_ioctl_ioas_map(EFAULT, buf, buf_size, &iova);
+
+	/* EFAULT on first page */
+	ASSERT_EQ(0, munmap(buf, buf_size / 2));
+	test_err_ioctl_ioas_map(EFAULT, buf, buf_size, &iova);
+}
+
+TEST_F(iommufd_mock_domain, all_aligns)
+{
+	size_t test_step = variant->hugepages ? (self->mmap_buf_size / 16) :
+						MOCK_PAGE_SIZE;
+	size_t buf_size = self->mmap_buf_size;
+	unsigned int start;
+	unsigned int end;
+	uint8_t *buf;
+
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+	check_refs(buf, buf_size, 0);
+
+	/*
+	 * Map every combination of page size and alignment within a big region,
+	 * less for hugepage case as it takes so long to finish.
+	 */
+	for (start = 0; start < buf_size; start += test_step) {
+		if (variant->hugepages)
+			end = buf_size;
+		else
+			end = start + MOCK_PAGE_SIZE;
+		for (; end < buf_size; end += MOCK_PAGE_SIZE) {
+			size_t length = end - start;
+			__u64 iova;
+
+			test_ioctl_ioas_map(buf + start, length, &iova);
+			check_mock_iova(buf + start, iova, length);
+			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
+				   end / PAGE_SIZE * PAGE_SIZE -
+					   start / PAGE_SIZE * PAGE_SIZE,
+				   1);
+
+			test_ioctl_ioas_unmap(iova, length);
+		}
+	}
+	check_refs(buf, buf_size, 0);
+	ASSERT_EQ(0, munmap(buf, buf_size));
+}
+
+TEST_F(iommufd_mock_domain, all_aligns_copy)
+{
+	size_t test_step = variant->hugepages ? self->mmap_buf_size / 16 :
+						MOCK_PAGE_SIZE;
+	size_t buf_size = self->mmap_buf_size;
+	unsigned int start;
+	unsigned int end;
+	uint8_t *buf;
+
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+	check_refs(buf, buf_size, 0);
+
+	/*
+	 * Map every combination of page size and alignment within a big region,
+	 * less for hugepage case as it takes so long to finish.
+	 */
+	for (start = 0; start < buf_size; start += test_step) {
+		if (variant->hugepages)
+			end = buf_size;
+		else
+			end = start + MOCK_PAGE_SIZE;
+		for (; end < buf_size; end += MOCK_PAGE_SIZE) {
+			size_t length = end - start;
+			unsigned int old_id;
+			uint32_t mock_device_id;
+			__u64 iova;
+
+			test_ioctl_ioas_map(buf + start, length, &iova);
+
+			/* Add and destroy a domain while the area exists */
+			old_id = self->domain_ids[1];
+			test_cmd_mock_domain(self->ioas_id, &mock_device_id,
+					     &self->domain_ids[1]);
+
+			check_mock_iova(buf + start, iova, length);
+			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
+				   end / PAGE_SIZE * PAGE_SIZE -
+					   start / PAGE_SIZE * PAGE_SIZE,
+				   1);
+
+			test_ioctl_destroy(mock_device_id);
+			test_ioctl_destroy(self->domain_ids[1]);
+			self->domain_ids[1] = old_id;
+
+			test_ioctl_ioas_unmap(iova, length);
+		}
+	}
+	check_refs(buf, buf_size, 0);
+	ASSERT_EQ(0, munmap(buf, buf_size));
+}
+
+TEST_F(iommufd_mock_domain, user_copy)
+{
+	struct iommu_test_cmd access_cmd = {
+		.size = sizeof(access_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_PAGES,
+		.access_pages = { .length = BUFFER_SIZE,
+				  .uptr = (uintptr_t)buffer },
+	};
+	struct iommu_ioas_copy copy_cmd = {
+		.size = sizeof(copy_cmd),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA,
+		.dst_ioas_id = self->ioas_id,
+		.dst_iova = MOCK_APERTURE_START,
+		.length = BUFFER_SIZE,
+	};
+	unsigned int ioas_id;
+
+	/* Pin the pages in an IOAS with no domains then copy to an IOAS with domains */
+	test_ioctl_ioas_alloc(&ioas_id);
+	test_ioctl_ioas_map_id(ioas_id, buffer, BUFFER_SIZE,
+			       &copy_cmd.src_iova);
+
+	test_cmd_create_access(ioas_id, &access_cmd.id,
+			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
+
+	access_cmd.access_pages.iova = copy_cmd.src_iova;
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_cmd));
+	copy_cmd.src_ioas_id = ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
+
+	test_cmd_destroy_access_pages(
+		access_cmd.id, access_cmd.access_pages.out_access_pages_id);
+	test_cmd_destroy_access(access_cmd.id) test_ioctl_destroy(ioas_id);
+
+	test_ioctl_destroy(ioas_id);
+}
+
+/* VFIO compatibility IOCTLs */
+
+TEST_F(iommufd, simple_ioctls)
+{
+	ASSERT_EQ(VFIO_API_VERSION, ioctl(self->fd, VFIO_GET_API_VERSION));
+	ASSERT_EQ(1, ioctl(self->fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU));
+}
+
+TEST_F(iommufd, unmap_cmd)
+{
+	struct vfio_iommu_type1_dma_unmap unmap_cmd = {
+		.iova = MOCK_APERTURE_START,
+		.size = PAGE_SIZE,
+	};
+
+	unmap_cmd.argsz = 1;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+
+	unmap_cmd.argsz = sizeof(unmap_cmd);
+	unmap_cmd.flags = 1 << 31;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+
+	unmap_cmd.flags = 0;
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+}
+
+TEST_F(iommufd, map_cmd)
+{
+	struct vfio_iommu_type1_dma_map map_cmd = {
+		.iova = MOCK_APERTURE_START,
+		.size = PAGE_SIZE,
+		.vaddr = (__u64)buffer,
+	};
+
+	map_cmd.argsz = 1;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+
+	map_cmd.argsz = sizeof(map_cmd);
+	map_cmd.flags = 1 << 31;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+
+	/* Requires a domain to be attached */
+	map_cmd.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+}
+
+TEST_F(iommufd, info_cmd)
+{
+	struct vfio_iommu_type1_info info_cmd = {};
+
+	/* Invalid argsz */
+	info_cmd.argsz = 1;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_GET_INFO, &info_cmd));
+
+	info_cmd.argsz = sizeof(info_cmd);
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_IOMMU_GET_INFO, &info_cmd));
+}
+
+TEST_F(iommufd, set_iommu_cmd)
+{
+	/* Requires a domain to be attached */
+	EXPECT_ERRNO(ENODEV,
+		     ioctl(self->fd, VFIO_SET_IOMMU, VFIO_TYPE1v2_IOMMU));
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU));
+}
+
+TEST_F(iommufd, vfio_ioas)
+{
+	struct iommu_vfio_ioas vfio_ioas_cmd = {
+		.size = sizeof(vfio_ioas_cmd),
+		.op = IOMMU_VFIO_IOAS_GET,
+	};
+	__u32 ioas_id;
+
+	/* ENODEV if there is no compat ioas */
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+
+	/* Invalid id for set */
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_SET;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+
+	/* Valid id for set*/
+	test_ioctl_ioas_alloc(&ioas_id);
+	vfio_ioas_cmd.ioas_id = ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+
+	/* Same id comes back from get */
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_GET;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+	ASSERT_EQ(ioas_id, vfio_ioas_cmd.ioas_id);
+
+	/* Clear works */
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_CLEAR;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_GET;
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+}
+
+FIXTURE(vfio_compat_mock_domain)
+{
+	int fd;
+	uint32_t ioas_id;
+};
+
+FIXTURE_VARIANT(vfio_compat_mock_domain)
+{
+	unsigned int version;
+};
+
+FIXTURE_SETUP(vfio_compat_mock_domain)
+{
+	struct iommu_vfio_ioas vfio_ioas_cmd = {
+		.size = sizeof(vfio_ioas_cmd),
+		.op = IOMMU_VFIO_IOAS_SET,
+	};
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+
+	/* Create what VFIO would consider a group */
+	test_ioctl_ioas_alloc(&self->ioas_id);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+
+	/* Attach it to the vfio compat */
+	vfio_ioas_cmd.ioas_id = self->ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_SET_IOMMU, variant->version));
+}
+
+FIXTURE_TEARDOWN(vfio_compat_mock_domain)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(vfio_compat_mock_domain, Ver1v2)
+{
+	.version = VFIO_TYPE1v2_IOMMU,
+};
+
+FIXTURE_VARIANT_ADD(vfio_compat_mock_domain, Ver1v0)
+{
+	.version = VFIO_TYPE1_IOMMU,
+};
+
+TEST_F(vfio_compat_mock_domain, simple_close)
+{
+}
+
+TEST_F(vfio_compat_mock_domain, option_huge_pages)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_HUGE_PAGES,
+		.op = IOMMU_OPTION_OP_GET,
+		.val64 = 3,
+		.object_id = self->ioas_id,
+	};
+
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	if (variant->version == VFIO_TYPE1_IOMMU) {
+		ASSERT_EQ(0, cmd.val64);
+	} else {
+		ASSERT_EQ(1, cmd.val64);
+	}
+}
+
+/*
+ * Execute an ioctl command stored in buffer and check that the result does not
+ * overflow memory.
+ */
+static bool is_filled(const void *buf, uint8_t c, size_t len)
+{
+	const uint8_t *cbuf = buf;
+
+	for (; len; cbuf++, len--)
+		if (*cbuf != c)
+			return false;
+	return true;
+}
+
+#define ioctl_check_buf(fd, cmd)                                         \
+	({                                                               \
+		size_t _cmd_len = *(__u32 *)buffer;                      \
+									 \
+		memset(buffer + _cmd_len, 0xAA, BUFFER_SIZE - _cmd_len); \
+		ASSERT_EQ(0, ioctl(fd, cmd, buffer));                    \
+		ASSERT_EQ(true, is_filled(buffer + _cmd_len, 0xAA,       \
+					  BUFFER_SIZE - _cmd_len));      \
+	})
+
+static void check_vfio_info_cap_chain(struct __test_metadata *_metadata,
+				      struct vfio_iommu_type1_info *info_cmd)
+{
+	const struct vfio_info_cap_header *cap;
+
+	ASSERT_GE(info_cmd->argsz, info_cmd->cap_offset + sizeof(*cap));
+	cap = buffer + info_cmd->cap_offset;
+	while (true) {
+		size_t cap_size;
+
+		if (cap->next)
+			cap_size = (buffer + cap->next) - (void *)cap;
+		else
+			cap_size = (buffer + info_cmd->argsz) - (void *)cap;
+
+		switch (cap->id) {
+		case VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE: {
+			struct vfio_iommu_type1_info_cap_iova_range *data =
+				(void *)cap;
+
+			ASSERT_EQ(1, data->header.version);
+			ASSERT_EQ(1, data->nr_iovas);
+			EXPECT_EQ(MOCK_APERTURE_START,
+				  data->iova_ranges[0].start);
+			EXPECT_EQ(MOCK_APERTURE_LAST, data->iova_ranges[0].end);
+			break;
+		}
+		case VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL: {
+			struct vfio_iommu_type1_info_dma_avail *data =
+				(void *)cap;
+
+			ASSERT_EQ(1, data->header.version);
+			ASSERT_EQ(sizeof(*data), cap_size);
+			break;
+		}
+		default:
+			ASSERT_EQ(false, true);
+			break;
+		}
+		if (!cap->next)
+			break;
+
+		ASSERT_GE(info_cmd->argsz, cap->next + sizeof(*cap));
+		ASSERT_GE(buffer + cap->next, (void *)cap);
+		cap = buffer + cap->next;
+	}
+}
+
+TEST_F(vfio_compat_mock_domain, get_info)
+{
+	struct vfio_iommu_type1_info *info_cmd = buffer;
+	unsigned int i;
+	size_t caplen;
+
+	/* Pre-cap ABI */
+	*info_cmd = (struct vfio_iommu_type1_info){
+		.argsz = offsetof(struct vfio_iommu_type1_info, cap_offset),
+	};
+	ioctl_check_buf(self->fd, VFIO_IOMMU_GET_INFO);
+	ASSERT_NE(0, info_cmd->iova_pgsizes);
+	ASSERT_EQ(VFIO_IOMMU_INFO_PGSIZES | VFIO_IOMMU_INFO_CAPS,
+		  info_cmd->flags);
+
+	/* Read the cap chain size */
+	*info_cmd = (struct vfio_iommu_type1_info){
+		.argsz = sizeof(*info_cmd),
+	};
+	ioctl_check_buf(self->fd, VFIO_IOMMU_GET_INFO);
+	ASSERT_NE(0, info_cmd->iova_pgsizes);
+	ASSERT_EQ(VFIO_IOMMU_INFO_PGSIZES | VFIO_IOMMU_INFO_CAPS,
+		  info_cmd->flags);
+	ASSERT_EQ(0, info_cmd->cap_offset);
+	ASSERT_LT(sizeof(*info_cmd), info_cmd->argsz);
+
+	/* Read the caps, kernel should never create a corrupted caps */
+	caplen = info_cmd->argsz;
+	for (i = sizeof(*info_cmd); i < caplen; i++) {
+		*info_cmd = (struct vfio_iommu_type1_info){
+			.argsz = i,
+		};
+		ioctl_check_buf(self->fd, VFIO_IOMMU_GET_INFO);
+		ASSERT_EQ(VFIO_IOMMU_INFO_PGSIZES | VFIO_IOMMU_INFO_CAPS,
+			  info_cmd->flags);
+		if (!info_cmd->cap_offset)
+			continue;
+		check_vfio_info_cap_chain(_metadata, info_cmd);
+	}
+}
+
+static void shuffle_array(unsigned long *array, size_t nelms)
+{
+	unsigned int i;
+
+	/* Shuffle */
+	for (i = 0; i != nelms; i++) {
+		unsigned long tmp = array[i];
+		unsigned int other = rand() % (nelms - i);
+
+		array[i] = array[other];
+		array[other] = tmp;
+	}
+}
+
+TEST_F(vfio_compat_mock_domain, map)
+{
+	struct vfio_iommu_type1_dma_map map_cmd = {
+		.argsz = sizeof(map_cmd),
+		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
+		.vaddr = (uintptr_t)buffer,
+		.size = BUFFER_SIZE,
+		.iova = MOCK_APERTURE_START,
+	};
+	struct vfio_iommu_type1_dma_unmap unmap_cmd = {
+		.argsz = sizeof(unmap_cmd),
+		.size = BUFFER_SIZE,
+		.iova = MOCK_APERTURE_START,
+	};
+	unsigned long pages_iova[BUFFER_SIZE / PAGE_SIZE];
+	unsigned int i;
+
+	/* Simple map/unmap */
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+	ASSERT_EQ(BUFFER_SIZE, unmap_cmd.size);
+
+	/* UNMAP_FLAG_ALL requres 0 iova/size */
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+	unmap_cmd.flags = VFIO_DMA_UNMAP_FLAG_ALL;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+
+	unmap_cmd.iova = 0;
+	unmap_cmd.size = 0;
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+	ASSERT_EQ(BUFFER_SIZE, unmap_cmd.size);
+
+	/* Small pages */
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++) {
+		map_cmd.iova = pages_iova[i] =
+			MOCK_APERTURE_START + i * PAGE_SIZE;
+		map_cmd.vaddr = (uintptr_t)buffer + i * PAGE_SIZE;
+		map_cmd.size = PAGE_SIZE;
+		ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+	}
+	shuffle_array(pages_iova, ARRAY_SIZE(pages_iova));
+
+	unmap_cmd.flags = 0;
+	unmap_cmd.size = PAGE_SIZE;
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++) {
+		unmap_cmd.iova = pages_iova[i];
+		ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+	}
+}
+
+TEST_F(vfio_compat_mock_domain, huge_map)
+{
+	size_t buf_size = HUGEPAGE_SIZE * 2;
+	struct vfio_iommu_type1_dma_map map_cmd = {
+		.argsz = sizeof(map_cmd),
+		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
+		.size = buf_size,
+		.iova = MOCK_APERTURE_START,
+	};
+	struct vfio_iommu_type1_dma_unmap unmap_cmd = {
+		.argsz = sizeof(unmap_cmd),
+	};
+	unsigned long pages_iova[16];
+	unsigned int i;
+	void *buf;
+
+	/* Test huge pages and splitting */
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB | MAP_POPULATE, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+	map_cmd.vaddr = (uintptr_t)buf;
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+
+	unmap_cmd.size = buf_size / ARRAY_SIZE(pages_iova);
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++)
+		pages_iova[i] = MOCK_APERTURE_START + (i * unmap_cmd.size);
+	shuffle_array(pages_iova, ARRAY_SIZE(pages_iova));
+
+	/* type1 mode can cut up larger mappings, type1v2 always fails */
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++) {
+		unmap_cmd.iova = pages_iova[i];
+		unmap_cmd.size = buf_size / ARRAY_SIZE(pages_iova);
+		if (variant->version == VFIO_TYPE1_IOMMU) {
+			ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA,
+					   &unmap_cmd));
+		} else {
+			EXPECT_ERRNO(ENOENT,
+				     ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA,
+					   &unmap_cmd));
+		}
+	}
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
new file mode 100644
index 00000000000000..99eaa9f32e0b23
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -0,0 +1,580 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
+ *
+ * These tests are "kernel integrity" tests. They are looking for kernel
+ * WARN/OOPS/kasn/etc splats triggered by kernel sanitizers & debugging
+ * features. It does not attempt to verify that the system calls are doing what
+ * they are supposed to do.
+ *
+ * The basic philosophy is to run a sequence of calls that will succeed and then
+ * sweep every failure injection point on that call chain to look for
+ * interesting things in error handling.
+ *
+ * This test is best run with:
+ *  echo 1 > /proc/sys/kernel/panic_on_warn
+ * If something is actually going wrong.
+ */
+#include <fcntl.h>
+#include <dirent.h>
+
+#define __EXPORTED_HEADERS__
+#include <linux/vfio.h>
+
+#include "iommufd_utils.h"
+
+static bool have_fault_injection;
+
+static int writeat(int dfd, const char *fn, const char *val)
+{
+	size_t val_len = strlen(val);
+	ssize_t res;
+	int fd;
+
+	fd = openat(dfd, fn, O_WRONLY);
+	if (fd == -1)
+		return -1;
+	res = write(fd, val, val_len);
+	assert(res == val_len);
+	close(fd);
+	return 0;
+}
+
+static __attribute__((constructor)) void setup_buffer(void)
+{
+	BUFFER_SIZE = 2*1024*1024;
+
+	buffer = mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE,
+		      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+/*
+ * This sets up fail_injection in a way that is useful for this test.
+ * It does not attempt to restore things back to how they were.
+ */
+static __attribute__((constructor)) void setup_fault_injection(void)
+{
+	DIR *debugfs = opendir("/sys/kernel/debug/");
+	struct dirent *dent;
+
+	if (!debugfs)
+		return;
+
+	/* Allow any allocation call to be fault injected */
+	if (writeat(dirfd(debugfs), "failslab/ignore-gfp-wait", "N"))
+		return;
+	writeat(dirfd(debugfs), "fail_page_alloc/ignore-gfp-wait", "N");
+	writeat(dirfd(debugfs), "fail_page_alloc/ignore-gfp-highmem", "N");
+
+	while ((dent = readdir(debugfs))) {
+		char fn[300];
+
+		if (strncmp(dent->d_name, "fail", 4) != 0)
+			continue;
+
+		/* We are looking for kernel splats, quiet down the log */
+		snprintf(fn, sizeof(fn), "%s/verbose", dent->d_name);
+		writeat(dirfd(debugfs), fn, "0");
+	}
+	closedir(debugfs);
+	have_fault_injection = true;
+}
+
+struct fail_nth_state {
+	int proc_fd;
+	unsigned int iteration;
+};
+
+static void fail_nth_first(struct __test_metadata *_metadata,
+			   struct fail_nth_state *nth_state)
+{
+	char buf[300];
+
+	snprintf(buf, sizeof(buf), "/proc/self/task/%u/fail-nth", gettid());
+	nth_state->proc_fd = open(buf, O_RDWR);
+	ASSERT_NE(-1, nth_state->proc_fd);
+}
+
+static bool fail_nth_next(struct __test_metadata *_metadata,
+			  struct fail_nth_state *nth_state,
+			  int test_result)
+{
+	static const char disable_nth[] = "0";
+	char buf[300];
+
+	/*
+	 * This is just an arbitrary limit based on the current kernel
+	 * situation. Changes in the kernel can dramtically change the number of
+	 * required fault injection sites, so if this hits it doesn't
+	 * necessarily mean a test failure, just that the limit has to be made
+	 * bigger.
+	 */
+	ASSERT_GT(400, nth_state->iteration);
+	if (nth_state->iteration != 0) {
+		ssize_t res;
+		ssize_t res2;
+
+		buf[0] = 0;
+		/*
+		 * Annoyingly disabling the nth can also fail. This means
+		 * the test passed without triggering failure
+		 */
+		res = pread(nth_state->proc_fd, buf, sizeof(buf), 0);
+		if (res == -1 && errno == EFAULT) {
+			buf[0] = '1';
+			buf[1] = '\n';
+			res = 2;
+		}
+
+		res2 = pwrite(nth_state->proc_fd, disable_nth,
+			      ARRAY_SIZE(disable_nth) - 1, 0);
+		if (res2 == -1 && errno == EFAULT) {
+			res2 = pwrite(nth_state->proc_fd, disable_nth,
+				      ARRAY_SIZE(disable_nth) - 1, 0);
+			buf[0] = '1';
+			buf[1] = '\n';
+		}
+		ASSERT_EQ(ARRAY_SIZE(disable_nth) - 1, res2);
+
+		/* printf("  nth %u result=%d nth=%u\n", nth_state->iteration,
+		       test_result, atoi(buf)); */
+		fflush(stdout);
+		ASSERT_LT(1, res);
+		if (res != 2 || buf[0] != '0' || buf[1] != '\n')
+			return false;
+	} else {
+		/* printf("  nth %u result=%d\n", nth_state->iteration,
+		       test_result); */
+	}
+	nth_state->iteration++;
+	return true;
+}
+
+/*
+ * This is called during the test to start failure injection. It allows the test
+ * to do some setup that has already been swept and thus reduce the required
+ * iterations.
+ */
+void __fail_nth_enable(struct __test_metadata *_metadata,
+		       struct fail_nth_state *nth_state)
+{
+	char buf[300];
+	size_t len;
+
+	if (!nth_state->iteration)
+		return;
+
+	len = snprintf(buf, sizeof(buf), "%u", nth_state->iteration);
+	ASSERT_EQ(len, pwrite(nth_state->proc_fd, buf, len, 0));
+}
+#define fail_nth_enable() __fail_nth_enable(_metadata, _nth_state)
+
+#define TEST_FAIL_NTH(fixture_name, name)                                           \
+	static int test_nth_##name(struct __test_metadata *_metadata,               \
+				   FIXTURE_DATA(fixture_name) *self,                \
+				   const FIXTURE_VARIANT(fixture_name)              \
+					   *variant,                                \
+				   struct fail_nth_state *_nth_state);              \
+	TEST_F(fixture_name, name)                                                  \
+	{                                                                           \
+		struct fail_nth_state nth_state = {};                               \
+		int test_result = 0;                                                \
+										    \
+		if (!have_fault_injection)                                          \
+			SKIP(return,                                                \
+				   "fault injection is not enabled in the kernel"); \
+		fail_nth_first(_metadata, &nth_state);                              \
+		ASSERT_EQ(0, test_nth_##name(_metadata, self, variant,              \
+					     &nth_state));                          \
+		while (fail_nth_next(_metadata, &nth_state, test_result)) {         \
+			fixture_name##_teardown(_metadata, self, variant);          \
+			fixture_name##_setup(_metadata, self, variant);             \
+			test_result = test_nth_##name(_metadata, self,              \
+						      variant, &nth_state);         \
+		};                                                                  \
+		ASSERT_EQ(0, test_result);                                          \
+	}                                                                           \
+	static int test_nth_##name(                                                 \
+		struct __test_metadata __attribute__((unused)) *_metadata,          \
+		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self,           \
+		const FIXTURE_VARIANT(fixture_name) __attribute__((unused))         \
+			*variant,                                                   \
+		struct fail_nth_state *_nth_state)
+
+FIXTURE(basic_fail_nth)
+{
+	int fd;
+	uint32_t access_id;
+};
+
+FIXTURE_SETUP(basic_fail_nth)
+{
+	self->fd = -1;
+	self->access_id = 0;
+}
+
+FIXTURE_TEARDOWN(basic_fail_nth)
+{
+	int rc;
+
+	if (self->access_id) {
+		/* The access FD holds the iommufd open until it closes */
+		rc = _test_cmd_destroy_access(self->access_id);
+		assert(rc == 0);
+	}
+	teardown_iommufd(self->fd, _metadata);
+}
+
+/* Cover ioas.c */
+TEST_FAIL_NTH(basic_fail_nth, basic)
+{
+	struct iommu_iova_range ranges[10];
+	uint32_t ioas_id;
+	__u64 iova;
+
+	fail_nth_enable();
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	{
+		struct iommu_ioas_iova_ranges ranges_cmd = {
+			.size = sizeof(ranges_cmd),
+			.num_iovas = ARRAY_SIZE(ranges),
+			.ioas_id = ioas_id,
+			.allowed_iovas = (uintptr_t)ranges,
+		};
+		if (ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd))
+			return -1;
+	}
+
+	{
+		struct iommu_ioas_allow_iovas allow_cmd = {
+			.size = sizeof(allow_cmd),
+			.ioas_id = ioas_id,
+			.num_iovas = 1,
+			.allowed_iovas = (uintptr_t)ranges,
+		};
+
+		ranges[0].start = 16*1024;
+		ranges[0].last = BUFFER_SIZE + 16 * 1024 * 600 - 1;
+		if (ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd))
+			return -1;
+	}
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	{
+		struct iommu_ioas_copy copy_cmd = {
+			.size = sizeof(copy_cmd),
+			.flags = IOMMU_IOAS_MAP_WRITEABLE |
+				 IOMMU_IOAS_MAP_READABLE,
+			.dst_ioas_id = ioas_id,
+			.src_ioas_id = ioas_id,
+			.src_iova = iova,
+			.length = sizeof(ranges),
+		};
+
+		if (ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd))
+			return -1;
+	}
+
+	if (_test_ioctl_ioas_unmap(self->fd, ioas_id, iova, BUFFER_SIZE,
+				   NULL))
+		return -1;
+	/* Failure path of no IOVA to unmap */
+	_test_ioctl_ioas_unmap(self->fd, ioas_id, iova, BUFFER_SIZE, NULL);
+	return 0;
+}
+
+/* iopt_area_fill_domains() and iopt_area_fill_domain() */
+TEST_FAIL_NTH(basic_fail_nth, map_domain)
+{
+	uint32_t ioas_id;
+	__u32 device_id;
+	__u32 hwpt_id;
+	__u64 iova;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
+		return -1;
+
+	fail_nth_enable();
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+		return -1;
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	if (_test_ioctl_destroy(self->fd, device_id))
+		return -1;
+	if (_test_ioctl_destroy(self->fd, hwpt_id))
+		return -1;
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+		return -1;
+	return 0;
+}
+
+TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
+{
+	uint32_t ioas_id;
+	__u32 device_id2;
+	__u32 device_id;
+	__u32 hwpt_id2;
+	__u32 hwpt_id;
+	__u64 iova;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
+		return -1;
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+		return -1;
+
+	fail_nth_enable();
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id2, &hwpt_id2))
+		return -1;
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	if (_test_ioctl_destroy(self->fd, device_id))
+		return -1;
+	if (_test_ioctl_destroy(self->fd, hwpt_id))
+		return -1;
+
+	if (_test_ioctl_destroy(self->fd, device_id2))
+		return -1;
+	if (_test_ioctl_destroy(self->fd, hwpt_id2))
+		return -1;
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+		return -1;
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id2, &hwpt_id2))
+		return -1;
+	return 0;
+}
+
+TEST_FAIL_NTH(basic_fail_nth, access_rw)
+{
+	uint64_t tmp_big[4096];
+	uint32_t ioas_id;
+	uint16_t tmp[32];
+	__u64 iova;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
+		return -1;
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	fail_nth_enable();
+
+	if (_test_cmd_create_access(self->fd, ioas_id, &self->access_id, 0))
+		return -1;
+
+	{
+		struct iommu_test_cmd access_cmd = {
+			.size = sizeof(access_cmd),
+			.op = IOMMU_TEST_OP_ACCESS_RW,
+			.id = self->access_id,
+			.access_rw = { .iova = iova,
+				       .length = sizeof(tmp),
+				       .uptr = (uintptr_t)tmp },
+		};
+
+		// READ
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+
+		access_cmd.access_rw.flags = MOCK_ACCESS_RW_WRITE;
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+
+		access_cmd.access_rw.flags = MOCK_ACCESS_RW_SLOW_PATH;
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+		access_cmd.access_rw.flags = MOCK_ACCESS_RW_SLOW_PATH |
+					     MOCK_ACCESS_RW_WRITE;
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+	}
+
+	{
+		struct iommu_test_cmd access_cmd = {
+			.size = sizeof(access_cmd),
+			.op = IOMMU_TEST_OP_ACCESS_RW,
+			.id = self->access_id,
+			.access_rw = { .iova = iova,
+				       .flags = MOCK_ACCESS_RW_SLOW_PATH,
+				       .length = sizeof(tmp_big),
+				       .uptr = (uintptr_t)tmp_big },
+		};
+
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+	}
+	if (_test_cmd_destroy_access(self->access_id))
+		return -1;
+	self->access_id = 0;
+	return 0;
+}
+
+/* pages.c access functions */
+TEST_FAIL_NTH(basic_fail_nth, access_pin)
+{
+	uint32_t access_pages_id;
+	uint32_t ioas_id;
+	__u64 iova;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
+		return -1;
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	if (_test_cmd_create_access(self->fd, ioas_id, &self->access_id,
+				    MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES))
+		return -1;
+
+	fail_nth_enable();
+
+	{
+		struct iommu_test_cmd access_cmd = {
+			.size = sizeof(access_cmd),
+			.op = IOMMU_TEST_OP_ACCESS_PAGES,
+			.id = self->access_id,
+			.access_pages = { .iova = iova,
+					  .length = BUFFER_SIZE,
+					  .uptr = (uintptr_t)buffer },
+		};
+
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+		access_pages_id = access_cmd.access_pages.out_access_pages_id;
+	}
+
+	if (_test_cmd_destroy_access_pages(self->fd, self->access_id,
+					   access_pages_id))
+		return -1;
+
+	if (_test_cmd_destroy_access(self->access_id))
+		return -1;
+	self->access_id = 0;
+	return 0;
+}
+
+/* iopt_pages_fill_xarray() */
+TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
+{
+	uint32_t access_pages_id;
+	uint32_t ioas_id;
+	__u32 device_id;
+	__u32 hwpt_id;
+	__u64 iova;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
+		return -1;
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+		return -1;
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	if (_test_cmd_create_access(self->fd, ioas_id, &self->access_id,
+				    MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES))
+		return -1;
+
+	fail_nth_enable();
+
+	{
+		struct iommu_test_cmd access_cmd = {
+			.size = sizeof(access_cmd),
+			.op = IOMMU_TEST_OP_ACCESS_PAGES,
+			.id = self->access_id,
+			.access_pages = { .iova = iova,
+					  .length = BUFFER_SIZE,
+					  .uptr = (uintptr_t)buffer },
+		};
+
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+		access_pages_id = access_cmd.access_pages.out_access_pages_id;
+	}
+
+	if (_test_cmd_destroy_access_pages(self->fd, self->access_id,
+					   access_pages_id))
+		return -1;
+
+	if (_test_cmd_destroy_access(self->access_id))
+		return -1;
+	self->access_id = 0;
+
+	if (_test_ioctl_destroy(self->fd, device_id))
+		return -1;
+	if (_test_ioctl_destroy(self->fd, hwpt_id))
+		return -1;
+	return 0;
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
new file mode 100644
index 00000000000000..0d1f46369c2a30
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -0,0 +1,278 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES */
+#ifndef __SELFTEST_IOMMUFD_UTILS
+#define __SELFTEST_IOMMUFD_UTILS
+
+#include <unistd.h>
+#include <stddef.h>
+#include <sys/fcntl.h>
+#include <sys/ioctl.h>
+#include <stdint.h>
+#include <assert.h>
+
+#include "../kselftest_harness.h"
+#include "../../../../drivers/iommu/iommufd/iommufd_test.h"
+
+/* Hack to make assertions more readable */
+#define _IOMMU_TEST_CMD(x) IOMMU_TEST_CMD
+
+static void *buffer;
+static unsigned long BUFFER_SIZE;
+
+/*
+ * Have the kernel check the refcount on pages. I don't know why a freshly
+ * mmap'd anon non-compound page starts out with a ref of 3
+ */
+#define check_refs(_ptr, _length, _refs)                                      \
+	({                                                                    \
+		struct iommu_test_cmd test_cmd = {                            \
+			.size = sizeof(test_cmd),                             \
+			.op = IOMMU_TEST_OP_MD_CHECK_REFS,                    \
+			.check_refs = { .length = _length,                    \
+					.uptr = (uintptr_t)(_ptr),            \
+					.refs = _refs },                      \
+		};                                                            \
+		ASSERT_EQ(0,                                                  \
+			  ioctl(self->fd,                                     \
+				_IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_REFS), \
+				&test_cmd));                                  \
+	})
+
+static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *device_id,
+				 __u32 *hwpt_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_MOCK_DOMAIN,
+		.id = ioas_id,
+		.mock_domain = {},
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (ret)
+		return ret;
+	if (device_id)
+		*device_id = cmd.mock_domain.out_device_id;
+	assert(cmd.id != 0);
+	if (hwpt_id)
+		*hwpt_id = cmd.mock_domain.out_hwpt_id;
+	return 0;
+}
+#define test_cmd_mock_domain(ioas_id, device_id, hwpt_id)                \
+	ASSERT_EQ(0, _test_cmd_mock_domain(self->fd, ioas_id, device_id, \
+					   hwpt_id))
+#define test_err_mock_domain(_errno, ioas_id, device_id, hwpt_id)     \
+	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
+						   device_id, hwpt_id))
+
+static int _test_cmd_create_access(int fd, unsigned int ioas_id,
+				   __u32 *access_id, unsigned int flags)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_CREATE_ACCESS,
+		.id = ioas_id,
+		.create_access = { .flags = flags },
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (ret)
+		return ret;
+	*access_id = cmd.create_access.out_access_fd;
+	return 0;
+}
+#define test_cmd_create_access(ioas_id, access_id, flags)                  \
+	ASSERT_EQ(0, _test_cmd_create_access(self->fd, ioas_id, access_id, \
+					     flags))
+
+static int _test_cmd_destroy_access(unsigned int access_id)
+{
+	return close(access_id);
+}
+#define test_cmd_destroy_access(access_id) \
+	ASSERT_EQ(0, _test_cmd_destroy_access(access_id))
+
+static int _test_cmd_destroy_access_pages(int fd, unsigned int access_id,
+					  unsigned int access_pages_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_DESTROY_ACCESS_PAGES,
+		.id = access_id,
+		.destroy_access_pages = { .access_pages_id = access_pages_id },
+	};
+	return ioctl(fd, IOMMU_TEST_CMD, &cmd);
+}
+#define test_cmd_destroy_access_pages(access_id, access_pages_id)        \
+	ASSERT_EQ(0, _test_cmd_destroy_access_pages(self->fd, access_id, \
+						    access_pages_id))
+#define test_err_destroy_access_pages(_errno, access_id, access_pages_id) \
+	EXPECT_ERRNO(_errno, _test_cmd_destroy_access_pages(              \
+				     self->fd, access_id, access_pages_id))
+
+static int _test_ioctl_destroy(int fd, unsigned int id)
+{
+	struct iommu_destroy cmd = {
+		.size = sizeof(cmd),
+		.id = id,
+	};
+	return ioctl(fd, IOMMU_DESTROY, &cmd);
+}
+#define test_ioctl_destroy(id) ASSERT_EQ(0, _test_ioctl_destroy(self->fd, id))
+
+static int _test_ioctl_ioas_alloc(int fd, __u32 *id)
+{
+	struct iommu_ioas_alloc cmd = {
+		.size = sizeof(cmd),
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_IOAS_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	*id = cmd.out_ioas_id;
+	return 0;
+}
+#define test_ioctl_ioas_alloc(id)                                   \
+	({                                                          \
+		ASSERT_EQ(0, _test_ioctl_ioas_alloc(self->fd, id)); \
+		ASSERT_NE(0, *(id));                                \
+	})
+
+static int _test_ioctl_ioas_map(int fd, unsigned int ioas_id, void *buffer,
+				size_t length, __u64 *iova, unsigned int flags)
+{
+	struct iommu_ioas_map cmd = {
+		.size = sizeof(cmd),
+		.flags = flags,
+		.ioas_id = ioas_id,
+		.user_va = (uintptr_t)buffer,
+		.length = length,
+	};
+	int ret;
+
+	if (flags & IOMMU_IOAS_MAP_FIXED_IOVA)
+		cmd.iova = *iova;
+
+	ret = ioctl(fd, IOMMU_IOAS_MAP, &cmd);
+	*iova = cmd.iova;
+	return ret;
+}
+#define test_ioctl_ioas_map(buffer, length, iova_p)                        \
+	ASSERT_EQ(0, _test_ioctl_ioas_map(self->fd, self->ioas_id, buffer, \
+					  length, iova_p,                  \
+					  IOMMU_IOAS_MAP_WRITEABLE |       \
+						  IOMMU_IOAS_MAP_READABLE))
+
+#define test_err_ioctl_ioas_map(_errno, buffer, length, iova_p)            \
+	EXPECT_ERRNO(_errno,                                               \
+		     _test_ioctl_ioas_map(self->fd, self->ioas_id, buffer, \
+					  length, iova_p,                  \
+					  IOMMU_IOAS_MAP_WRITEABLE |       \
+						  IOMMU_IOAS_MAP_READABLE))
+
+#define test_ioctl_ioas_map_id(ioas_id, buffer, length, iova_p)              \
+	ASSERT_EQ(0, _test_ioctl_ioas_map(self->fd, ioas_id, buffer, length, \
+					  iova_p,                            \
+					  IOMMU_IOAS_MAP_WRITEABLE |         \
+						  IOMMU_IOAS_MAP_READABLE))
+
+#define test_ioctl_ioas_map_fixed(buffer, length, iova)                       \
+	({                                                                    \
+		__u64 __iova = iova;                                          \
+		ASSERT_EQ(0, _test_ioctl_ioas_map(                            \
+				     self->fd, self->ioas_id, buffer, length, \
+				     &__iova,                                 \
+				     IOMMU_IOAS_MAP_FIXED_IOVA |              \
+					     IOMMU_IOAS_MAP_WRITEABLE |       \
+					     IOMMU_IOAS_MAP_READABLE));       \
+	})
+
+#define test_err_ioctl_ioas_map_fixed(_errno, buffer, length, iova)           \
+	({                                                                    \
+		__u64 __iova = iova;                                          \
+		EXPECT_ERRNO(_errno,                                          \
+			     _test_ioctl_ioas_map(                            \
+				     self->fd, self->ioas_id, buffer, length, \
+				     &__iova,                                 \
+				     IOMMU_IOAS_MAP_FIXED_IOVA |              \
+					     IOMMU_IOAS_MAP_WRITEABLE |       \
+					     IOMMU_IOAS_MAP_READABLE));       \
+	})
+
+static int _test_ioctl_ioas_unmap(int fd, unsigned int ioas_id, uint64_t iova,
+				  size_t length, uint64_t *out_len)
+{
+	struct iommu_ioas_unmap cmd = {
+		.size = sizeof(cmd),
+		.ioas_id = ioas_id,
+		.iova = iova,
+		.length = length,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_IOAS_UNMAP, &cmd);
+	if (out_len)
+		*out_len = cmd.length;
+	return ret;
+}
+#define test_ioctl_ioas_unmap(iova, length)                                \
+	ASSERT_EQ(0, _test_ioctl_ioas_unmap(self->fd, self->ioas_id, iova, \
+					    length, NULL))
+
+#define test_ioctl_ioas_unmap_id(ioas_id, iova, length)                      \
+	ASSERT_EQ(0, _test_ioctl_ioas_unmap(self->fd, ioas_id, iova, length, \
+					    NULL))
+
+#define test_err_ioctl_ioas_unmap(_errno, iova, length)                      \
+	EXPECT_ERRNO(_errno, _test_ioctl_ioas_unmap(self->fd, self->ioas_id, \
+						    iova, length, NULL))
+
+static int _test_ioctl_set_temp_memory_limit(int fd, unsigned int limit)
+{
+	struct iommu_test_cmd memlimit_cmd = {
+		.size = sizeof(memlimit_cmd),
+		.op = IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
+		.memory_limit = { .limit = limit },
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT),
+		     &memlimit_cmd);
+}
+
+#define test_ioctl_set_temp_memory_limit(limit) \
+	ASSERT_EQ(0, _test_ioctl_set_temp_memory_limit(self->fd, limit))
+
+#define test_ioctl_set_default_memory_limit() \
+	test_ioctl_set_temp_memory_limit(65536)
+
+static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_MD_CHECK_REFS,
+		.check_refs = { .length = BUFFER_SIZE,
+				.uptr = (uintptr_t)buffer },
+	};
+
+	if (fd == -1)
+		return;
+
+	EXPECT_EQ(0, close(fd));
+
+	fd = open("/dev/iommu", O_RDWR);
+	EXPECT_NE(-1, fd);
+	EXPECT_EQ(0, ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_REFS),
+			   &test_cmd));
+	EXPECT_EQ(0, close(fd));
+}
+
+#define EXPECT_ERRNO(expected_errno, cmd)         \
+	({                                        \
+		ASSERT_EQ(-1, cmd);               \
+		EXPECT_EQ(expected_errno, errno); \
+	})
+
+#endif
-- 
2.38.1

