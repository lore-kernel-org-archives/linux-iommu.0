Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CCBC4727E
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769212193E
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xNQZRJbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769212193E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0339E8612B;
	Wed, 23 Sep 2020 10:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPbBQaOfIPIj; Wed, 23 Sep 2020 10:11:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 89A3D860C2;
	Wed, 23 Sep 2020 10:11:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6974BC0895;
	Wed, 23 Sep 2020 10:11:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFBD2C0859
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A4CBF86EB1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K1aiT8ngj3gy for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:11:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D6F8E86BE2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8wpnkw4Qz6GywjbYxGp5stmL0g+WGi3IViMIjz+VAdfJzT3p93y059enIuE/04JVph7jzyconW/dUkxckiknXsncO42R9BwcZ2hmyvBq1BWZBbUd1TyJA7PRho2H1gqd6b7A7skAUR8JL8dOtknPoTCF1AhXc5vBajmRQ0ACuQG0iYhHSuUr8oBvl/Vp28eb/R7c3EVsR5gYwQskGr1fSUZq2oHORIkrnzFgSVWVVeRQ/CqJAGuvLS18dqy5XOGzUDEFuaXJ8OkeESLKfzg4xImJWVK3gLE1rkWtIB+L2SudtUBXiLgcOvL2IU0moZmmcKaXAmuY06VKpGvuo2GSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNYfRxFr2lHj+6XUrW+YPfxDuN3vHBirnqdMyTJLQCE=;
 b=PDKJzx0OSakvkPQ8f4H+7NWu8a/EGwK2fY6E/unSmO2rZpnzPOjp618PACUmu2YK6X6U4semrqENe+iE5cdcMLYUvkeMW1wTIKPTKY3yqQiozzyVU+guZxG59A6LGVLcDMx4Vim/WpS4J2q3UMw6px7cXmWsGQqzCv0l3Bhge9EWvhj5umMRmXwPSkbdWt/RgUdxC8UzQ+uyI0R/+aaEZQZKYORXRKDwt16DfP8OF92G0qQ0Vt7XfpAu4GZXfaL8yEv4WVzLTirYPvohPtpVQx1snV/eO6xOZy640+6eTGdFrf/2+1oYu7Jb900efQ3ZmVbtGRxwfwWskkIopfQVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNYfRxFr2lHj+6XUrW+YPfxDuN3vHBirnqdMyTJLQCE=;
 b=xNQZRJbJYaX3aUflKfqClnKYRICO2A4QWhKUdA5Z525IOrCd4j6bwNJr8FJS8MLrq/sNW/W5UYQ2f9BTikEtMev9doKtofYDqeAeTdYW7FjJ1KuDO+vePE3bRWHdTLPgtIVWGrJ5GmB6oEzRTuP5g4hw2qKPqrc0EN7tY5J5Dlo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:42 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:42 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 01/13] iommu: amd: Re-define amd_iommu_domain_encode_pgtable
 as inline
Date: Wed, 23 Sep 2020 10:14:30 +0000
Message-Id: <20200923101442.73157-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0601CA0003.namprd06.prod.outlook.com
 (2603:10b6:803:2f::13) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0601CA0003.namprd06.prod.outlook.com (2603:10b6:803:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 23 Sep 2020 10:11:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6c74a80-772c-438b-16c7-08d85fa91153
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB346676613BA7F25EA4E59B1DF3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAV1Af40Wq4v2PvIT7yfVE/sbmkWnJIAlTpxE+JY0ME400s83+V8+TIYsAW8O9oKf1zANRc3E2as/L5HhikqRhExKl+lUZtLKvYSivq2zGEs1yypFZ1qdJGfOAtazusPKlPDVHZjTpUOtmYqEBLsxYIMnfbweUrKB78oRP9eq/sMuZTcL1wLIGEQLQLX7TXN/CqyjQlrUSKo4xFAvui33CBIA3VHh51iKl0SdBAKTZ60w9EyWhwBVthejhqvbzjMSuNdWSH68BoD4ab+LJ+nNk+SXaheIH4A/TkW0dcV0F2E15F3LlBQM/fv9sEgTE1h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZoskVsYssQDfdR8uiD2vz4NnCiEb6AVyGYapg8lZAdmWr4IEWfkRa73YbpXh5CAR7RPH+AaXyO9Bdw8YwlFsxZ+mDNJdLK+M52Is1Y7QjQPlDOn5TBeJXN6jsD9ZJm/s3A7D6cNr4NXtHUMCHxuk99/fGc6ojv126teQHoRIVx/G46OPTyHAZs1wqyU1OHnzWh+ByY1Rr1WoTouRGSICZlQnmwK89z1LV62D0lY6x+KzVJAE0dyYQ3wUltkXshH90j+IFZN4E5qOFe3zRLokRz2PzpJUB2Xy2MN1fFJVjWVnf8gD/OUfWsTgWb1+Y1Q8nV+i0GymkuX7Q68IUYoKs8aSK9kWioMMLvMtKvrA0KYGqSsk+befCR/RNaBCPF5wTQcyKwBUS9ZXnGIJkg7qX1UhAPtncIMNmF8rQ8yeWEjMu4KW+DneeU7AUOjzGivLmwovC6E99DiQVXgOPdvbPDcw+em1YLqitnrruqDYzlMEXm/ChOKFssEJ21IxEPSztuXWfbzZhNMmBq66gr/ZKvGajt4pnvnCDOExkylxNl0q4heqPB4vgRhNE0mB4dN9Bu+FaTzU001NdBhZ4Aeq6467kdEHr3HUQMYuXtC+6e2FucFnqduXHZG1mW6tWstQdZpCCdGVsy0FhMYroxFUeA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c74a80-772c-438b-16c7-08d85fa91153
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:42.1633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+jI5Q7zkIv2WkRsGWe9BRVqW/4QQ0yaBtQ3MRMPI0GHzdplN+x3zrqFTb1VtuyJIAZofWziFK/8zsorJla+3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Move the function to header file to allow inclusion in other files.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 13 +++++++++++++
 drivers/iommu/amd/iommu.c     | 10 ----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 57309716fd18..97cdb235ce69 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -93,6 +93,19 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 	return phys_to_virt(__sme_clr(paddr));
 }
 
+static inline
+void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
+{
+	atomic64_set(&domain->pt_root, root);
+}
+
+static inline
+void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
+{
+	amd_iommu_domain_set_pt_root(domain, 0);
+}
+
+
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
 extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 					 struct device *dev);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index db4fb840c59c..e92b3f744292 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -162,16 +162,6 @@ static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
 	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
 }
 
-static void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
-{
-	atomic64_set(&domain->pt_root, root);
-}
-
-static void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
-{
-	amd_iommu_domain_set_pt_root(domain, 0);
-}
-
 static void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode)
 {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
