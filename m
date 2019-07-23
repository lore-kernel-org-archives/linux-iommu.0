Return-Path: <SRS0=bViT=VU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D447C76186
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 19:00:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D344721655
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 19:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ql2qyewN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D344721655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 98966C7C;
	Tue, 23 Jul 2019 19:00:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 03CCCC00
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 19:00:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
	(mail-bgr052100141045.outbound.protection.outlook.com
	[52.100.141.45])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A9219FE
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 19:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=hk1oviYFK0WmxasVHAfSpbUE2pwvPEjwAKqBOc9GbXf2W3vR2ImFfbzQyMWS7FBrZNec656hpDlop2Cr9DpINxClNHW5ObURvSX61O6b0Q6uzm89XA77K/oBOywhlQzx+fdTRc08jIg5Nud2W8V2sm54x710PBXmIhwNAP373l42Bo5OpzT8xcenDoAZt+s4WrAl205jg/8x2TF6lFgz/eeRh5q0lwAnL9Ivhe6K3AcVnD+KdXjz90Y0pTi3rxUbBapW6oAteHRDrwh235lh+utlmj0ku8YsBXeRzsxtdzlI6n/T+RpTR1gCSpzIk0xPK+x3ixgdINxlmvaIrVKrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=NOvd5LC+ZThpAtC//vxbuBZ1d8joz6a9W4beMKhcLRk=;
	b=VkyTorBJi+lA9hHTgiTHke9vxFn8HmlaY8kMWjAigcbQDWJQ9LnWf0eSW6mh5IKsOxaABr1kL70y8y1E14Ev5ll7nY8oZbfPbBxr47yBQEVi+TyX3qxIPCEowk+E67SLHCc5yn0R7F8S66DquBIdqS+5mmOW4sagghjwWbzvSedMgXIA8tf6gEvLxirvEB7KGw2f4eVqmc7RgNayntjT59WKfWHLAq6F86NkH+n+3+JGTUmUpaZBHkVLbtBRoc/S49K2EqXOZj69BWJMC1JKRJLl6Slca8IkoP6NoNXPpPryvUqbZQGKd5+HJF9YgJtDYDVVXWs7TaTL61Y1WBosVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=NOvd5LC+ZThpAtC//vxbuBZ1d8joz6a9W4beMKhcLRk=;
	b=Ql2qyewNa31aFZmr+EeqgM2qbNqrbURG4cj7n64dTHxfyXNNKUo88yI2azn0HhDilcRLAdvQaY69BEkejqgnd+FQh5lMrkIK1WLWmUKvh7E1fQUnh4ffqD8Q51zctx70aEv7Vm8Vnhm+royD9XzDOZvdi3nPUXugFK3G3PYXAeI=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
	DM6PR12MB4060.namprd12.prod.outlook.com (10.141.185.143) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2094.17; Tue, 23 Jul 2019 19:00:38 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
	([fe80::a91d:8752:288:ed5f]) by DM6PR12MB2844.namprd12.prod.outlook.com
	([fe80::a91d:8752:288:ed5f%6]) with mapi id 15.20.2115.005;
	Tue, 23 Jul 2019 19:00:38 +0000
From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [PATCH] iommu/amd: Re-factor guest virtual APIC (de-)activation code
Thread-Topic: [PATCH] iommu/amd: Re-factor guest virtual APIC (de-)activation
	code
Thread-Index: AQHVQYjqgveBJWNO50+h3kyfKugOIQ==
Date: Tue, 23 Jul 2019 19:00:37 +0000
Message-ID: <1563908430-81636-1-git-send-email-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.78.1]
x-clientproxiedby: DM5PR13CA0050.namprd13.prod.outlook.com
	(2603:10b6:3:117::12) To DM6PR12MB2844.namprd12.prod.outlook.com
	(2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba206a99-3185-458f-d6bf-08d70fa00c78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB4060; 
x-ms-traffictypediagnostic: DM6PR12MB4060:
x-microsoft-antispam-prvs: <DM6PR12MB4060AC91F27A4CD8DF860C32F3C70@DM6PR12MB4060.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:SPM;
	SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(14444005)(8936002)(186003)(476003)(256004)(50226002)(66556008)(102836004)(2616005)(26005)(66946007)(66446008)(66476007)(52116002)(2906002)(36756003)(71190400001)(71200400001)(64756008)(66066001)(5660300002)(2501003)(4326008)(68736007)(486006)(6506007)(386003)(25786009)(6436002)(6512007)(316002)(81166006)(110136005)(53936002)(6486002)(81156014)(3846002)(14454004)(305945005)(54906003)(7736002)(99286004)(478600001)(4720700003)(8676002)(6116002)(86362001)(59010400001);
	DIR:OUT; SFP:1501; SCL:5; SRVR:DM6PR12MB4060;
	H:DM6PR12MB2844.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JLVz9nVyxDQXELnlLhFskBl82GNgcWh8GroQSIidfcyxoocufo/iDjpjGW5oOsnTZ0ElBgHL+Dl33KIdOKi4Dg76DorWn9RVkTAPiriABk9wrt5dmIWpbQJFROHU5vRgcnjpLWO/G7pn4cuIxcMuiMneIDtmzzxMOXtTvRWGvUOnvcnvzM5vxZAyL9Dp6dWjFaNamec0J1EU/OnXhsKo6LNKwV3ZyiV0IfBDoOuI6moutv6rJuctznG5OhYHfV/+3E7dMw1aVwMa11DhsRzGUNSX2jjSmrSiaEHutCu0WdqK3KRc/LDQJ/KNI7X/eakXnUK48xcLDOOyK05h1608VO8jUhR69vUV8276UD6w+qB9htUKd0BYCbaxpcByZva85UKQo2QZLcjO5uNc/4AjKtwFJaB8IrWFEMj+uIZVaf+eOvHZvjDi71Lxm4wTlqWZqOqciUCC0bj44Zqll2KTYgz3jnA2PqWCKGPRlFNwZNIWLv2TPvyAwdQqgCwRhhSt5bQug/aLiN6M9lM/8akIaoLhtJO49xPfsw2Z9wwlsdrh4lnPNRtK/ekWXzq4BgH4OZF9Mn8Und/9d5e7SlFX5hvFR1r9UPDkiwuOzZWAUNkjIH+WNjXfHTpNZ4FOe9lH/WE8S6qUKsZJkQeWH/neWqyYLlgk/PJxNa2UbUJ0pRmAKzw1MiAcuy6CvXpesLRp
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba206a99-3185-458f-d6bf-08d70fa00c78
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 19:00:37.8752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssuthiku@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4060
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Re-factore the logic for activate/deactivate guest virtual APIC mode (GAM)
into helper functions, and export them for other drivers (e.g. SVM).
to support run-time activate/deactivate of SVM AVIC.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c       | 85 +++++++++++++++++++++++++++++------------
 drivers/iommu/amd_iommu_types.h |  9 +++++
 include/linux/amd-iommu.h       | 12 ++++++
 3 files changed, 82 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index dce1d8d..42fba8d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4301,13 +4301,62 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 	.deactivate = irq_remapping_deactivate,
 };
 
+int amd_iommu_activate_guest_mode(void *data)
+{
+	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
+	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
+
+	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
+	    !entry || entry->lo.fields_vapic.guest_mode)
+		return 0;
+
+	entry->lo.val = 0;
+	entry->hi.val = 0;
+
+	entry->lo.fields_vapic.guest_mode  = 1;
+	entry->lo.fields_vapic.ga_log_intr = 1;
+	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
+	entry->hi.fields.vector            = ir_data->ga_vector;
+	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
+
+	return modify_irte_ga(ir_data->irq_2_irte.devid,
+			      ir_data->irq_2_irte.index, entry, NULL);
+}
+EXPORT_SYMBOL(amd_iommu_activate_guest_mode);
+
+int amd_iommu_deactivate_guest_mode(void *data)
+{
+	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
+	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
+	struct irq_cfg *cfg = ir_data->cfg;
+
+	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
+	    !entry || !entry->lo.fields_vapic.guest_mode)
+		return 0;
+
+	entry->lo.val = 0;
+	entry->hi.val = 0;
+
+	entry->lo.fields_remap.dm          = apic->irq_dest_mode;
+	entry->lo.fields_remap.int_type    = apic->irq_delivery_mode;
+	entry->hi.fields.vector            = cfg->vector;
+	entry->lo.fields_remap.destination =
+				APICID_TO_IRTE_DEST_LO(cfg->dest_apicid);
+	entry->hi.fields.destination =
+				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
+
+	return modify_irte_ga(ir_data->irq_2_irte.devid,
+			      ir_data->irq_2_irte.index, entry, NULL);
+}
+EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
+
 static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 {
+	int ret;
 	struct amd_iommu *iommu;
 	struct amd_iommu_pi_data *pi_data = vcpu_info;
 	struct vcpu_data *vcpu_pi_info = pi_data->vcpu_data;
 	struct amd_ir_data *ir_data = data->chip_data;
-	struct irte_ga *irte = (struct irte_ga *) ir_data->entry;
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
 	struct iommu_dev_data *dev_data = search_dev_data(irte_info->devid);
 
@@ -4318,6 +4367,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	if (!dev_data || !dev_data->use_vapic)
 		return 0;
 
+	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
 
 	/* Note:
@@ -4336,37 +4386,24 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 
 	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
-		/* Setting */
-		irte->hi.fields.ga_root_ptr = (pi_data->base >> 12);
-		irte->hi.fields.vector = vcpu_pi_info->vector;
-		irte->lo.fields_vapic.ga_log_intr = 1;
-		irte->lo.fields_vapic.guest_mode = 1;
-		irte->lo.fields_vapic.ga_tag = pi_data->ga_tag;
-
-		ir_data->cached_ga_tag = pi_data->ga_tag;
+		ir_data->ga_root_ptr = (pi_data->base >> 12);
+		ir_data->ga_vector = vcpu_pi_info->vector;
+		ir_data->ga_tag = pi_data->ga_tag;
+		ret = amd_iommu_activate_guest_mode(ir_data);
+		if (!ret)
+			ir_data->cached_ga_tag = pi_data->ga_tag;
 	} else {
-		/* Un-Setting */
-		struct irq_cfg *cfg = irqd_cfg(data);
-
-		irte->hi.val = 0;
-		irte->lo.val = 0;
-		irte->hi.fields.vector = cfg->vector;
-		irte->lo.fields_remap.guest_mode = 0;
-		irte->lo.fields_remap.destination =
-				APICID_TO_IRTE_DEST_LO(cfg->dest_apicid);
-		irte->hi.fields.destination =
-				APICID_TO_IRTE_DEST_HI(cfg->dest_apicid);
-		irte->lo.fields_remap.int_type = apic->irq_delivery_mode;
-		irte->lo.fields_remap.dm = apic->irq_dest_mode;
+		ret = amd_iommu_deactivate_guest_mode(ir_data);
 
 		/*
 		 * This communicates the ga_tag back to the caller
 		 * so that it can do all the necessary clean up.
 		 */
-		ir_data->cached_ga_tag = 0;
+		if (!ret)
+			ir_data->cached_ga_tag = 0;
 	}
 
-	return modify_irte_ga(irte_info->devid, irte_info->index, irte, ir_data);
+	return ret;
 }
 
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 64edd5a..9ac229e 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -873,6 +873,15 @@ struct amd_ir_data {
 	struct msi_msg msi_entry;
 	void *entry;    /* Pointer to union irte or struct irte_ga */
 	void *ref;      /* Pointer to the actual irte */
+
+	/**
+	 * Store information for activate/de-activate
+	 * Guest virtual APIC mode during runtime.
+	 */
+	struct irq_cfg *cfg;
+	int ga_vector;
+	int ga_root_ptr;
+	int ga_tag;
 };
 
 struct amd_irte_ops {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 4a4d006..21e950e 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -184,6 +184,9 @@ extern int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
 extern int
 amd_iommu_update_ga(int cpu, bool is_run, void *data);
 
+extern int amd_iommu_activate_guest_mode(void *data);
+extern int amd_iommu_deactivate_guest_mode(void *data);
+
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
 
 static inline int
@@ -198,6 +201,15 @@ extern int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
 	return 0;
 }
 
+static inline int amd_iommu_activate_guest_mode(void *data)
+{
+	return 0;
+}
+
+static inline int amd_iommu_deactivate_guest_mode(void *data)
+{
+	return 0;
+}
 #endif /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
 
 #endif /* _ASM_X86_AMD_IOMMU_H */
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
