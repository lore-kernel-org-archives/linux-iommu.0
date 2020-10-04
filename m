Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47913C41604
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9082067D
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4hvYcrYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9082067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C2D5C854C2;
	Sun,  4 Oct 2020 01:42:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v3iwi-Z2wBxo; Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7490284EF0;
	Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F26CC0895;
	Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 828E9C0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 70ED88640E
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ISMHkGEhBz3U for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4453886234
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAfPlI4YdkRcy808HccCzLYmX4J2ScclEvm3hhKV0f3kZ7oYB94HhVH/7oWEcIK6BFVXUtaKF6a7Hm/7HX9nAGTheNrB1urwB2MSI6CH6BuLLiSQvNuP6FrOwYYITvyBYBNAps9cZg/GeMjnGA8aePjF8geBPhU/FPHDlQ7ZzrFBp13TMY97u7ZIMDzc/4A1203EZ1kVaepwdW7uoaUI2jP3LEiuZZeU/jAJCfZoHw+rNS8P3wCiLNgRLFqNtzqeZ4pCdvWtRu7huApSUlMTXZeWkPeD4RJ1AKhn7yP1mPMEkBzFA6AJ5N3FMmYejCNR2TtXmK/2uI6HOo680WIeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieYxJjxpC5SjX20CZiJMdfcEf/BogeNyGRw5vM0xbDw=;
 b=hXDlWSPAF5MLLpHMpU9B+dfkxnraXNpnodttcVYL8Wuqa6JbnH2HGmSthOOLDLCBvAovTLQgWHcCGyJ/HRZ12dXyGt6Bh7pJn+RMnyAc0jUUA22pi8AbLyijK3QuTpNrDRg9z55rIvmT2pjbb+LY4uz9OqbzMbXzkQGBWhCvVip83CfFtz2qdhqz6STfTavhu2r2XUV0DQ/xffRXd+lvLapU/ka+dvMsCLODL55ruAAC5bn99+x4tmIwMm9ujPuNYUDjQWr70dYtxuNYjbSuuKYmo3nwb+tyS4njaPffHrp2ZiytUtEycCE7VDWLeaRaTS/gNuDIUJKsm2G0/+Qp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieYxJjxpC5SjX20CZiJMdfcEf/BogeNyGRw5vM0xbDw=;
 b=4hvYcrYCJPEh1+FQb+epSAOOSwtaD3qa21yr2TcHCQIyVCc+x6DAxdB1nHo1KvvvNUqMdgs0AEgWkQ/3WtYg8Z1pzzg0R0PnDYklZHgnxmdMqThm6NczYNVlZVD4n+AK2ErVIFUPSIh4Kel0OpPOlttquCtZZ0zw5/FNuXqmJzY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:42:02 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:42:02 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 09/14] iommu/amd: Rename variables to be consistent with
 struct io_pgtable_ops
Date: Sun,  4 Oct 2020 01:45:44 +0000
Message-Id: <20201004014549.16065-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Sun, 4 Oct 2020 01:42:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aff19487-9f85-4a29-2d10-08d86806b0c1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1451F994A7ACC71248F23004F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvouwB/tPrJwiDnPG2tQbo8JjHJyp0RBBGZipbqzL09ShmEa4hQLdOwoiNXxdLm9A67hHITg2ld7NxoVZtZOA7MbS74gur82jxg2eWlOCYWdI+gTn4xYUfn33X0Dj14p2Tpv7C2RLpQA564U1taAf4wU65CbpcR+DzpSM4PY8ARDXdvc39bdKy6IQ0eOi51YU+1wIWM2kZGvNcMosLHx3s9gVXec7civrEuqD6ZvGgZReE3kUhoraMrY/TRrF6QsulnpQg+saXqg9Y/Fr7N3LNI6l4muUsjPDYpyAok7nzfDBB3dzMA6169z5OuvbeBazwCKq2ITycctXW2+YQUTcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: D3HGECH6U1j7wguekXL6RfY0pZpBrU7z5zJSFbM55tkcSORdlNmblDMT2L8UKDXVSmWJ8oYxhbTzSa1l9ZkHIXsCO3jIQ5mUa5rFgiS+tECBVLylYDFZGBToaPp4E7G6s8uinh/qCWIK4rBrUDoONKHI02unb27owf+nyBuILj5IoulcZlsOwdx27gtkJVypPTIAcMO9+Oxg/0zCR47NqYuAfX8IFrLs1/fNGMWbfYsa05XcDKY1bm+mMHJDCE6vI6Mk8lSTraaceAgLO8PJEA64yY3pJAl7syU4wDhLSkCp8VCVlrIyf4xBV91HFz7btOLJBZNIpz8zMtvkLGW8DO4bVraL5ob/LPHUVU4TBbPJ0p09hrU9nZP5HSDDTw8m5aF65CbbDwkPCpjyxaar+AxOoIlS3tx4cfmJHhOcai6J/pl7Dk6zd4+KyG7TNu5yl9Wd5KuKFNQrl4+VM5BEqditFSl8vUVqbuUKho9fFCmIzpTRbFLn2hfESffho8peoc/nzRDeBhqDfLRvW28PfYATCUB8pAj+AgORhE0tbnBeGVe0dBtqr0aSQ4Viak+qOvZBN60jhEOH7GA4O9HtWOitjXL9xdUkb/F5NgnskENSf9z6sQnLi+rt56uaQY1kAXb7QV3Ic8qxr6dF3YcpWQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff19487-9f85-4a29-2d10-08d86806b0c1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:42:02.3065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZbSMC9jIz2CA/0A+W7avXWSEqEVqGVrruRAPyH7dK/lRCswZJkiEzD/OihRRRcAuWMuU7qHeui2Rl5prJTUXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Cc: robin.murphy@arm.com
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

There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 6c063d2c8bf0..989db64a89a7 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -393,9 +393,9 @@ static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
  * and full 64 bit address spaces.
  */
 int iommu_map_page(struct protection_domain *dom,
-		   unsigned long bus_addr,
-		   unsigned long phys_addr,
-		   unsigned long page_size,
+		   unsigned long iova,
+		   unsigned long paddr,
+		   unsigned long size,
 		   int prot,
 		   gfp_t gfp)
 {
@@ -404,15 +404,15 @@ int iommu_map_page(struct protection_domain *dom,
 	u64 __pte, *pte;
 	int ret, i, count;
 
-	BUG_ON(!IS_ALIGNED(bus_addr, page_size));
-	BUG_ON(!IS_ALIGNED(phys_addr, page_size));
+	BUG_ON(!IS_ALIGNED(iova, size));
+	BUG_ON(!IS_ALIGNED(paddr, size));
 
 	ret = -EINVAL;
 	if (!(prot & IOMMU_PROT_MASK))
 		goto out;
 
-	count = PAGE_SIZE_PTE_COUNT(page_size);
-	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp, &updated);
+	count = PAGE_SIZE_PTE_COUNT(size);
+	pte   = alloc_pte(dom, iova, size, NULL, gfp, &updated);
 
 	ret = -ENOMEM;
 	if (!pte)
@@ -425,10 +425,10 @@ int iommu_map_page(struct protection_domain *dom,
 		updated = true;
 
 	if (count > 1) {
-		__pte = PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
+		__pte = PAGE_SIZE_PTE(__sme_set(paddr), size);
 		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 	} else
-		__pte = __sme_set(phys_addr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
+		__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 
 	if (prot & IOMMU_PROT_IR)
 		__pte |= IOMMU_PTE_IR;
@@ -462,20 +462,19 @@ int iommu_map_page(struct protection_domain *dom,
 }
 
 unsigned long iommu_unmap_page(struct protection_domain *dom,
-			       unsigned long bus_addr,
-			       unsigned long page_size)
+			       unsigned long iova,
+			       unsigned long size)
 {
 	unsigned long long unmapped;
 	unsigned long unmap_size;
 	u64 *pte;
 
-	BUG_ON(!is_power_of_2(page_size));
+	BUG_ON(!is_power_of_2(size));
 
 	unmapped = 0;
 
-	while (unmapped < page_size) {
-
-		pte = fetch_pte(dom, bus_addr, &unmap_size);
+	while (unmapped < size) {
+		pte = fetch_pte(dom, iova, &unmap_size);
 
 		if (pte) {
 			int i, count;
@@ -485,7 +484,7 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 				pte[i] = 0ULL;
 		}
 
-		bus_addr  = (bus_addr & ~(unmap_size - 1)) + unmap_size;
+		iova = (iova & ~(unmap_size - 1)) + unmap_size;
 		unmapped += unmap_size;
 	}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
