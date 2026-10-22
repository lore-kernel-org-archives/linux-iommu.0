Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792678174;
	b=CnfX76FUjQDq20l3c4PLsmKhT4ETqgPEj814AVaCg5zrfFBQzKZUrlpVrAs1TkUlALMJ
	 BUXWGIq8yqrLtortTwI8GmtXNKVBQtD76sp7Sc1QicuBkoYD8nesR754BExiigIKZcIMI
	 MtAO9dm+ZRL0u3gl6gZ9/Fet9bzl8EBAxWC/UfAYZ1I0Vp9mEBndL6d/RWcjl/TgmRN+4
	 9fwi8utT8fjfELEEMAIpnW085xmQrmZx1OE35OYx9wBX04zu8t5pYK+eqbraFmQe/3K2R
	 +V8li+21r5WCXL5FeHkfSZ/0zAP+SaWYgvZHvGdvuYVu9x7VunP56LYXeDLUCQfgRYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678174;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=IQWsuIYC7HNLYjCI5sCV1oswRGOsY+v9zH4sg38obwY=;
	b=nhfeMa0u7+gZ7iAzx1p0CBrCZabeNAXZ2zgqkdEyMnhuCLpVSjoFZu5e9oFUBnklz9Jr
	 EIv8+zikl9oOmkO6PjbjO3yH9ToAPhORi/6WJ/Y0uY7fUT0XBCIwoPvRHjKT3cke6EHwL
	 8M5s5Tk591Gao3erkBAXLSdz/hlr6NgnrulP5+u8Cx1d45TJlu4Izdc8wwf5Mhj2KLGRa
	 0c9SpxTmV5q5wNeYNmu0E6+X6FmjHfnVVRQ+QRJCAyfuLj9FYJ4Yjs2rVdSo1JnM38IMy
	 qnSHo86pJsV7iXgfQl0uPWPBhiBUOv4g/xDVl4F3D2UCMAHrxukb9O6+AQaXv4dGc/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=H8W52sjq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.33
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8531606A329;
	Thu, 22 Oct 2026 14:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8531606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=H8W52sjq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGiKgAvkKnxScn89VZtJ1OH+BsxJCcdRV/fJwGE8MCY44upMNt3Mkh649z54lZyFWDT4CHz/AA6VBUppqlFkRBkXv24ZGRMRWXnvzXrucvKpwtXdYWlahQEAw3etEFnz96C1K6DASAV6ZjkxMzlT8G9wSAZFqza7EMFXVkBpvpjuKOaozGzp8zYclEtsgr2dJoZJXkDHLLrtPsYN0U3yw9DP2Iruf/zZVUpt3qVFHnnYZgLuwqv1Odb52sOI+J02RNGHoOWQ2g9Aw0YMytvbRSTqfXfp1eBY90ZlJP1aPWkkZ75HtDc3jLFIFnLn2NIzIBATXspsbim7Wg3hzCR/fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQWsuIYC7HNLYjCI5sCV1oswRGOsY+v9zH4sg38obwY=;
 b=wQeQNe8+kjcYxCIlDbiI+x44jJZEveisTLV+pbTE2EiT3dUHWiPlypA6PTlYsdVroJW6Jw3a8ysxG4nnvLOIsFrcNGNjFzDPyNkH+yQjstfOpQE9kJ85f5Cijc78oUsR89AeCgL+cw65wB4u0RIIjMnhP6kyQ7BADpjpz6pSvgwJiUNvchzDgnEi48xLzi45pPm50pM/eeXXYcqnowHJl4czPnszDbkxtTQHXVy8iVpdtI66xh4c3wnIfZztxJE5iiC8BmERfTHeMFOxwVjPpGQQt4qydn8qmmkZpmWr208PLiLNhfkLEwL9kQCJfjp0CSZ8PyAV+MbdGL66tMAD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQWsuIYC7HNLYjCI5sCV1oswRGOsY+v9zH4sg38obwY=;
 b=H8W52sjqy4pz7moFM91TQfUVqpn6yDU0hfI8TXzoNeJrPTUW3G0DEelmhqRefoO5H0XK3g5ZgngBVAKhQeSbKQxi+0BWw1Kgj1vc80711Xvo7kT19snY1v1FfBrt3j19Kcqn6rNGSJCv2/x94qa5OBFe4fRiTNP1xTQiWDRNCRk=
Received: from BN0PR04CA0099.namprd04.prod.outlook.com (2603:10b6:408:ec::14)
 by LY0PR12MB025421.namprd12.prod.outlook.com (2603:10b6:404:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 14:09:28 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::4a) by BN0PR04CA0099.outlook.office365.com
 (2603:10b6:408:ec::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 14:09:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 14:09:28 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 09:09:14 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Jeff Layton <jlayton@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Kiryl Shutsemau <kas@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, Marco Elver <elver@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Robin Murphy <robin.murphy@arm.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>, Sean Christopherson <seanjc@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v6 6/7] KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Interrupt (GAPPI)
Date: Thu, 22 Oct 2026 19:34:24 +0530
Message-ID: <20261022140425.27465-7-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022140425.27465-1-sarunkod@amd.com>
References: <20261022140425.27465-1-sarunkod@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|LY0PR12MB025421:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a181aaf-d50a-4679-89c2-08df304615f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|1800799024|376014|82310400026|261009223027099003|10067099003|56012099006|261021121427099003|18002099003|22082099003|261021123027099003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	97hX7hva7lzqRzoikALyCcpAt8iwkJY96p1vK43u5FHaNbtp2M3l52E1PzuGciSkCF4pZNPqPEX/nVgxKY+dC8KN9qUldLE2bq8cKy/Ll8SNcitnG8ZjQkav4gIbxhpOju12llqWzuaDIQ1ASWCuBJlC3GaKdTX9Oa5f67yxl9T6wb/AGi6JP3j4y8AEpZdAvKzYfNDekoqgiKIJ/WqYY/2S5hKC6LrO0hzndTK4ETfrKWgoPzTURsJlOLn/jCK9CB/4E66Nriz6+u547z2EUXlDqhr/TWQByJtAEzEes0zav1qPn0A3wRVlc5r7OgiaUEetOMydQbDF83zt4SHdHfRC83AM2a9z59jWWkNzpxH3DCpcCBTINpJagg6pmn53/WAJfEH4Na1ylGzu5qoSABlk/b8O7BKSH3oxioNpgfxw3h/rcsKLxwXDVPDsAWZbXv/eZ5xZDhxsUst3DSdJfcq7bXlHx0tNJG9Ux3canDGjTgmGl3v0Nf2AI++xAOA/ftS8KMR9GZ/1QIZVEQS/ChQHJDHGnxLMDF4rom7Kodx+9mqQYW0wU5e2W27iYwYmi5LLzqq4vuXpcleyUmzQj1IEUkteb9WF1c2djfu5gde7r6DddII2vNB7Do15wGD5NykWyXYyANN73QvNyK/E+3aW27Vm354TA5d3+VF2EHE9iDG8TljryGqMZS4jk0VzMYM8gRyAL3R1Vs0b4gbkv59YBnuKUw9jVVShXNr1qFsAvTc6U70FsIsRGq5yoyNY
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(1800799024)(376014)(82310400026)(261009223027099003)(10067099003)(56012099006)(261021121427099003)(18002099003)(22082099003)(261021123027099003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lv3Gw81nJBQS5kuVXZjoPN3r4KmNWqzBb8cvda3D4JkwnLmu6A6XZ0EJIY88MbAeJHf2XkKXRECQm7tSFY/1C0OEpEykPaisJKANi8pdB3aNheeD99Kiji0+X5y9Y4K42fX+9ylCaHSyvYUJKGYquCyMxZTY+MuTVaPfkCEsuvjS840hgrtULSCB5RCiRVPnGsHgkqYzmZG3xaL87NrMjz0yFbdfqNkpB4gfb5dxGEisLJpTygE+uro1hzKDhl0B8MwiVopS7ZeGotsPRytrDTzVGxqULQj6AV0T3YqB+1N+AYVhU7oPicm0sUNcJBjYMlAMuNvpCy2ar+fP03Ov4QC1GarcOF4Qc57T7if1ZDbGWDSRbPkeXpm8h9rWHvEGIsydTw0fvlR6WPLeVTCUUuw/De42migS63ADj9qd87TSQFSlXZ8DnM01AYsytxx6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:09:28.3982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a181aaf-d50a-4679-89c2-08df304615f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB025421

With AVIC guest-mode interrupt remapping, device interrupts are posted into
the guest vAPIC backing page by the IOMMU. When the vCPU is not running
(IRTE[IsRun] = 0), KVM must still be notified to schedule it. The legacy
path uses the GA log.

GAPPI (Guest APIC Physical Processor Interrupt) is an alternative to the
GA log mechanism provided by the AMD IOMMU. With GAPPI enabled, the IOMMU
still updates the vAPIC backing page IRR, but the host wakeup notification
is delivered as a physical APIC interrupt to IRTE[Destination], using
IRTE[GATag][7:0] as the vector (POSTED_INTR_WAKEUP_VECTOR).

SVM follows the Intel posted-interrupt wakeup model. Each pCPU maintains
a list of blocked vCPUs that may be woken by a GAPPI delivery to that CPU.
When a vCPU blocks while waiting for an interrupt, SVM enqueues it on the
wakeup list of the pCPU on which it was previously running and passes that
same pCPU's physical APIC ID to the IOMMU to program IRTE[Destination].
The rationale is that the vCPU is likely to run again on the same pCPU,
which is common when vCPUs are pinned; targeting GAPPI notifications there
reduces unnecessary VMEXITs from GAPPI deliveries on other CPUs. SVM
registers the GAPPI handler via kvm_set_posted_intr_wakeup_handler(). On
delivery, it walks the local vCPU list and wakes vCPUs with a pending IRR.

All GAPPI logic is gated on amd_iommu_gappi. Without it, KVM and the IOMMU
falls back to the legacy GA log mechanism for vCPU wakeup.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 arch/x86/kvm/svm/avic.c | 64 +++++++++++++++++++++++++++++++++++------
 arch/x86/kvm/svm/svm.c  |  1 +
 arch/x86/kvm/svm/svm.h  |  4 +++
 3 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index b975f08825ce..baeca0ad8dfe 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -877,6 +877,8 @@ int avic_init_vcpu(struct vcpu_svm *svm)
 	INIT_LIST_HEAD(&svm->ir_list);
 	raw_spin_lock_init(&svm->ir_list_lock);
 
+	svm->gappi_cpu = 0;
+
 	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
@@ -895,6 +897,17 @@ void avic_vcpu_free(struct kvm_vcpu *vcpu)
 
 	if (kvm_svm->avic_physical_id_table && avic_is_addressable_vcpu(vcpu))
 		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], 0);
+
+	if (amd_iommu_gappi) {
+		struct vcpu_svm *svm = to_svm(vcpu);
+		unsigned long flags;
+
+		local_irq_save(flags);
+
+		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
+
+		local_irq_restore(flags);
+	}
 }
 
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
@@ -934,8 +947,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * if AVIC is enabled/uninhibited in the future.
 		 */
 		struct amd_iommu_pi_data pi_data = {
-			.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
-					     vcpu->vcpu_idx),
 			.is_guest_mode = kvm_vcpu_apicv_active(vcpu),
 			.vapic_addr = avic_get_backing_page_address(to_svm(vcpu)),
 			.vector = vector,
@@ -958,6 +969,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * scheduled out, KVM will update the pCPU info when the vCPU
 		 * is awakened and/or scheduled in.  See also avic_vcpu_load().
 		 */
+		if (amd_iommu_gappi)
+			pi_data.ga_tag = POSTED_INTR_WAKEUP_VECTOR;
+		else
+			pi_data.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
+						    vcpu->vcpu_idx);
+
 		entry = svm->avic_physical_id_entry;
 		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
 			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
@@ -966,6 +983,9 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			pi_data.apicid = -1;
 			pi_data.wakeup_intr = entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR;
 			pi_data.is_running = false;
+
+			if (amd_iommu_gappi)
+				pi_data.apicid = cpu_physical_id(svm->gappi_cpu);
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
@@ -1018,7 +1038,7 @@ enum avic_vcpu_action {
 };
 
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
-					    enum avic_vcpu_action action)
+					    int cpu, enum avic_vcpu_action action)
 {
 	bool wakeup_intr = (action & AVIC_START_BLOCKING);
 	bool is_running = apicid >= 0;
@@ -1027,6 +1047,25 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 
 	lockdep_assert_held(&svm->ir_list_lock);
 
+	if (action & AVIC_TOGGLE_ON_OFF)
+		/*
+		 * When AVIC is disabled, IOMMU switches to legacy IRTE and
+		 * does not genrate wakeup notification. Hence there is no
+		 * need to add vCPU on wakeup list. This reduces the number of
+		 * vCPUs on the list, effectively reducing interrupt handler
+		 * time and avoiding spurious wakeup to the vCPU.
+		 */
+		goto skip_wakeup_handler;
+
+	if (amd_iommu_gappi && is_running) {
+		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
+		svm->gappi_cpu = cpu; /* Store cpu number as target for GAPPI */
+	} else if (amd_iommu_gappi && wakeup_intr) {
+		apicid = cpu_physical_id(svm->gappi_cpu);
+		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
+	}
+
+skip_wakeup_handler:
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
 	 * interrupt remapping table entry targeting this vcpu.
@@ -1093,7 +1132,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, cpu, action);
 
 	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
@@ -1135,7 +1174,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 	 */
 	raw_spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
+	avic_update_iommu_vcpu_affinity(vcpu, -1, -1, action);
 
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 
@@ -1183,7 +1222,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 
 		/*
 		 * The vCPU was preempted while blocking, ensure its IRTEs are
-		 * configured to generate GA Log Interrupts.
+		 * configured to request host wakeup notification.
 		 */
 		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR))))
 			return;
@@ -1308,6 +1347,13 @@ static bool __init avic_want_avic_enabled(void)
 	return true;
 }
 
+bool avic_vcpu_irq_pending(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	return kvm_lapic_find_highest_irr(&svm->vcpu) >= 0;
+}
+
 /*
  * Note:
  * - The module param avic enable both xAPIC and x2APIC mode.
@@ -1351,6 +1397,8 @@ bool __init avic_hardware_setup(void)
 
 void avic_hardware_unsetup(void)
 {
-	if (avic)
-		amd_iommu_register_ga_log_notifier(NULL);
+	if (!avic)
+		return;
+
+	amd_iommu_register_ga_log_notifier(NULL);
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c054803d4673..cd0d8e8c386e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5352,6 +5352,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_put = svm_vcpu_put,
 	.vcpu_blocking = avic_vcpu_blocking,
 	.vcpu_unblocking = avic_vcpu_unblocking,
+	.vcpu_irq_pending = avic_vcpu_irq_pending,
 
 	.update_exception_bitmap = svm_update_exception_bitmap,
 	.get_feature_msr = svm_get_feature_msr,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 29bde741874a..58d4e85e30fe 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -368,6 +368,9 @@ struct vcpu_svm {
 
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
+
+	/* GAPPI related fields */
+	int gappi_cpu;
 };
 
 struct svm_cpu_data {
@@ -958,6 +961,7 @@ int avic_init_vcpu(struct vcpu_svm *svm);
 void avic_vcpu_free(struct kvm_vcpu *vcpu);
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void avic_vcpu_put(struct kvm_vcpu *vcpu);
+bool avic_vcpu_irq_pending(struct kvm_vcpu *vcpu);
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
 void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
 int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
-- 
2.34.1

