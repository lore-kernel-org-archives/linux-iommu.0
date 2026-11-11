Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379554;
	b=cap1fgmHMozLTbrWa3cmPQnarOS23VyCxXEQgmZIY16VxYUArFJkoDlcYVr4Y9jVxOzo
	 2tiVcCfd/cPnnMNZJVpJJ0fbLr9f2Egc83syKxakBylJdNtP3b774rqHhrLX9ZXThBPGl
	 SHhCZ4xaOmFqEFwMw7riTJoxcq6EhtL89VlV9dczCI1dKQBn0JgQ/eFlpr7YBXM5YWdCd
	 LQngyq3UAhz9RABOm4nagNVwDeqxUJEAb6vcjZr6b+Oy3uLaVBrt95ybjgXNChVSQpkVP
	 6Z4rQSQH45Ec/faU2dQ6R+5LjD7ezRN9YLDGbQR6FFegTypBQdUctOlsh5yu9XNnW9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379554;
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
	bh=q2VCiTIzJSqLtB6l12uXBpoZKOtkn+ZzzPyemq2IMYY=;
	b=4cmfXb3CBNqVgTG0Tm2Bc9gqPac+sLQ1dQhfVvYZxO1rJUGNLYxyHMtMgkJRdi9Aasr2
	 kjOxiC+rQpgfu54ZIALWYgSRfe016KkvvjkNT/YaqmY55k4dIKIjK/zZcZJOadKA90HGb
	 Dq8vS4GDFJBRtYtFtOnBsA/XUwzmtQH4sedKJNBglY/9zt4iO16j5LFAZ/+FqABCjcsXp
	 7EGeB1Nf8/0GeybGllQHqyOOBcoHmn/y95NYk8JivVrWhuI64FjBu2gGQj3X0w3/2VNYo
	 maV6XOpWAku5HxNKcrlrqoswC5Arvyik7mTTqokksGPApEQYxjzhmF1GCYM76c1Km0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mZXTYB57;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.24
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BC606A32E;
	Wed, 11 Nov 2026 06:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A45BC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mZXTYB57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcKxrOGlnaitA9WdhTCfNI1TURBJ1YNyOuEbwePV9DJpaTai2+tRCEvGVLYerHzKVC+pS+fsB0tcAdq6T0P5wU/3e+R46Ox5YtsPiKM+0VIikYc3NUII8oM7O89d3l9jAhGaI5lPRVa2zy0xwzFhDIY3Bwswk80b5f9pQfO5eNZ4eLmDa9/m+5FtI0OsXwCfZycFcXobJyDD6Qphs3wVSdwkxHb13RdSV9VALDPM8GSl6Ez5w1bhqKMfbvMlKHwRGFKyiAWoxy2ZLo5BAqkzyCw+Y1q3sy/Wbnt3H9lgaoK5Eq8S17Op608H0DOUYywwTMDRKuOOha3WBiheH/XVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2VCiTIzJSqLtB6l12uXBpoZKOtkn+ZzzPyemq2IMYY=;
 b=hgBpT/GLo8BDGe1BVtw88+kdNNC9jiiZZOcs2+zlaa6lYUBbL+vs7OjbonnqmYRcliaeQEls9GWtFG+k70rlgqk4P0T+giyagb8+wjnW0w225+DtpusC9tMJoPE3/tF9+u85ODuoRKGdtVlXbTgrDxjvhK5dzfT9lotpPiwv3Xf7lX6qyh+015Dtawz5vyZ2cVM8vxsJw/jyL9Zea4+B3HdAOyeLPZeDCtR1XA4zve5Ui+LwJobPKMIM4cm8VMhQhYbfrNIyhHUpNrCo3FQrLtlp0/7I9uDriaTvjXY4+EUToBClL37ir7e8MmO1hboc3CCi8I7L7JBI++PN+Q9d0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=zytor.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2VCiTIzJSqLtB6l12uXBpoZKOtkn+ZzzPyemq2IMYY=;
 b=mZXTYB57C7vGHRQlrN4znzWybvAX4dCTR6PLKatMNISyU+u2f8vmdfyYD6aMzLYJJ2l/1vrU3yz0unpwalAuRykLnrKfj+VR9gDqJcqD6i2LwsNTGfbFRQgD3+ulYdwSAA7c1DQhFMswunKGJuXBAu52M0zylsEvfVasMNo92m4=
Received: from SJ0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:a03:33e::17)
 by SAWPR12MB999164.namprd12.prod.outlook.com (2603:10b6:806:4e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:45:48 +0000
Received: from MW1PEPF0001888F.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::13) by SJ0PR03CA0042.outlook.office365.com
 (2603:10b6:a03:33e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Wed,
 11 Nov 2026 06:45:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001888F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 06:45:48 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 00:45:38 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Ethan Nelson-Moore
	<enelsonmoore@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Layton
	<jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Karl Mehltretter
	<kmehltretter@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, Marco Elver
	<elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Sairaj Kodilkar <sarunkod@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner
	<tglx@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>, Will Deacon
	<will@kernel.org>, <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v7 6/7] KVM: SVM: Add support for AMD IOMMU Guest APIC Physical Processor Interrupt (GAPPI)
Date: Wed, 11 Nov 2026 12:12:41 +0530
Message-ID: <20261111064242.29336-7-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111064242.29336-1-sarunkod@amd.com>
References: <20261111064242.29336-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888F:EE_|SAWPR12MB999164:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f43142e-0dd5-41be-e147-08df3fbf6b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|23010399003|1800799024|82310400026|921020|10067099003|261026121527099003|11063799006|261026140227099003|56012099006|261102123227099003|261009223027099003|261022075727099003|261021123027099003|261028144727099003|261022105027099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0S8IHn6/bcu9YEp9nki7AzlxJkPGKSXpuUskRfGesCXgMkudJZexR3KScRlGMZetkFo2HJGrVnN4qdvX4/YQPxsnQzqaBlTAKZWZSu/wk5ET+BY8O5+iEwBG83fu0aSW+GfJ+9nGAf0fGxWprA6H7ds0vr13ViNPilYqZw2ZnYZuZ0ocqAvrM8Xihl0+VjGEt7NxVtZjv/l0JZB9t6YVe52GY9WcgGxPWXX6z9quQXA5xr5OQYbbXPxM54Vlc6TsLlWAex5QF4UOCrpOy2ETHgsSuxToULr0P9Eb56ChxVovjxHqJaCA5cgG3Uwazm/WgBMdQrkOieODpmSlX/SJxRpgVL7Pf6ISkfCid3F7+Wg0hFqAK8m6fYzgovWOh/EeMnhY5kZKKbDmYb8ji71YTt1Y3gm3/uDPL7RLE/q5FAXXCmUGGvBU922SBjaIEMxTkJz69xo9qfTPhj1y6QsUMNSFSevanLLujgXKFS71SLl3GH6TpQ0KPJ3Qb1q7Eg9JVc4VOjfmv0tZzl93+g8oqES7trSrELttW2NBBohp2l5S4LRIimYm9Aor/oAl8fL1z5cmwGObNLYGYtcBJCK4L26iTcQk2De7GF6IiqdlgUgpXxWdL97lPZUiaoitaHAx1x3CmxKVjhL7fRJzY1gyOEl3IleOQFZXjAkDYE9qYIqd4lA19bUZ1OSbR59sy9vzDSzUtsiPDrhZ+8EvlHTtUTtNQHZKSomuROqNZaj80IsziP8ReF9AAmU4kt81UDTm
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(23010399003)(1800799024)(82310400026)(921020)(10067099003)(261026121527099003)(11063799006)(261026140227099003)(56012099006)(261102123227099003)(261009223027099003)(261022075727099003)(261021123027099003)(261028144727099003)(261022105027099003)(261021121427099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6zN/v2htByLLyPDTcbglsG4BN51LYE1eD78Ed3z+bAVFnfA2evyfs5iN10uI/CwRvQtSva2QhrxnHlb+vTDkcEr9aDthgRZD6MPEnFga29wKxb7fbt7KvUlSEyKwjqHdVliYVN+Xww4ZpsdsvHrAfjhyIKU7S8Og0rDeRT8KplwEIWV8YwFQ5bE+XzIT4ni7GxTa/6Aw0jpdb2rcNOZfeesrkg0KH3Pajm/ax8ssx+evtBFFGIQ8+BROxLxXmdxsc8fvVyAxzWRc3qgjjF4OeoyjJEsDiOE7WMf0ZXM/5s5uvJhYa5q0B5P6e1mU3gKt0NXbojVC4EKYN2Y0fNxgXNsbIg9fi7bZBbNb+dMQtVUDlExug8tCxBeYBEsR67xiynAGPy9XccHWM6LP+yV5IYvewj1DKD65LvK7k7BkF/eqoHJ4nsrnuxaq1d0OV0vT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:45:48.0508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f43142e-0dd5-41be-e147-08df3fbf6b53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001888F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999164

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
 arch/x86/kvm/svm/avic.c | 75 ++++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.c  |  1 +
 arch/x86/kvm/svm/svm.h  |  4 +++
 3 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index b975f08825ce..ebfd74adc4cb 100644
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
@@ -1027,6 +1047,36 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int apicid,
 
 	lockdep_assert_held(&svm->ir_list_lock);
 
+	if (!amd_iommu_gappi)
+		goto skip_wakeup_handler;
+
+	if (action & AVIC_TOGGLE_ON_OFF) {
+		/*
+		 * When AVIC is disabled, IOMMU switches to legacy IRTE and
+		 * does not generate wakeup notification. Hence there is no
+		 * need to add vCPU on wakeup list. This reduces the number of
+		 * vCPUs on the list, effectively reducing interrupt handler
+		 * time and avoiding spurious wakeup to the vCPU.
+		 */
+		if (is_running)
+			/*
+			 * Store the CPU so that next call with
+			 * AVIC_STOP_RUNNING can add the vCPU on to
+			 * appropriate wakeup list.
+			 */
+			svm->gappi_cpu = cpu;
+		goto skip_wakeup_handler;
+	}
+
+	if (is_running) {
+		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
+		svm->gappi_cpu = cpu;
+	} else {
+		apicid = cpu_physical_id(svm->gappi_cpu);
+		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
+	}
+
+skip_wakeup_handler:
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
 	 * interrupt remapping table entry targeting this vcpu.
@@ -1093,7 +1143,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, cpu, action);
 
 	raw_spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
@@ -1135,7 +1185,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 	 */
 	raw_spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
+	avic_update_iommu_vcpu_affinity(vcpu, -1, -1, action);
 
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR);
 
@@ -1183,7 +1233,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 
 		/*
 		 * The vCPU was preempted while blocking, ensure its IRTEs are
-		 * configured to generate GA Log Interrupts.
+		 * configured to request host wakeup notification.
 		 */
 		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR))))
 			return;
@@ -1308,6 +1358,13 @@ static bool __init avic_want_avic_enabled(void)
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
@@ -1351,6 +1408,8 @@ bool __init avic_hardware_setup(void)
 
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
index e30ee80624b7..a8f99fb474f5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5486,6 +5486,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_put = svm_vcpu_put,
 	.vcpu_blocking = avic_vcpu_blocking,
 	.vcpu_unblocking = avic_vcpu_unblocking,
+	.vcpu_irq_pending = avic_vcpu_irq_pending,
 
 	.update_exception_bitmap = svm_update_exception_bitmap,
 	.get_feature_msr = svm_get_feature_msr,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index cd3242811e43..331a7c8fb5c6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -369,6 +369,9 @@ struct vcpu_svm {
 
 	/* Guest GIF value, used when vGIF is not enabled */
 	bool guest_gif;
+
+	/* GAPPI related fields */
+	int gappi_cpu;
 };
 
 struct svm_cpu_data {
@@ -969,6 +972,7 @@ int avic_init_vcpu(struct vcpu_svm *svm);
 void avic_vcpu_free(struct kvm_vcpu *vcpu);
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void avic_vcpu_put(struct kvm_vcpu *vcpu);
+bool avic_vcpu_irq_pending(struct kvm_vcpu *vcpu);
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
 void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
 int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
-- 
2.34.1

