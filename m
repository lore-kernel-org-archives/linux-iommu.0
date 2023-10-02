Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096CE156FD
	for <iommu@lists.linux.dev>; Mon,  2 Oct 2023 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696247864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ar0urwZ0bmfOZ0eV2FeowpE2tYaVs6PwEG08j6g7CC4=;
	b=IAqksnEuqhCCDzicSBL85eTmKGy0t4OyavIrtCE+LpYgUtBJag4hkrQkw7HhyjayBR3Oi5
	ZR2wEycPJSLqOCWejj5vDzv4Qoyo8qhs6F46E7agZcc4xv2wNYFlhV1GyakgRv2DjuhifQ
	e0k//HXnpuNKcrE+XP7j/hospQPfJu8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-eA8zi65nNnCoX1cK0Oq2uA-1; Mon, 02 Oct 2023 07:57:40 -0400
X-MC-Unique: eA8zi65nNnCoX1cK0Oq2uA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3B4285A5BA;
	Mon,  2 Oct 2023 11:57:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4471C140E950;
	Mon,  2 Oct 2023 11:57:36 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 3/4] x86: KVM: don't read physical ID table entry in avic_pi_update_irte()
Date: Mon,  2 Oct 2023 14:57:22 +0300
Message-Id: <20231002115723.175344-4-mlevitsk@redhat.com>
In-Reply-To: <20231002115723.175344-1-mlevitsk@redhat.com>
References: <20231002115723.175344-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7

Change AVIC's code to use vcpu->loaded and vcpu->cpu instead of reading
back the cpu and 'is_running' bit from the avic's physical id entry.

Once AVIC's IPI virtualization is made optional, the 'is_running'
bit might always be false regardless if a vCPU is running or not.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/avic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 4c75ca15999fcd4..bdab28005ad3405 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -791,7 +791,6 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	int ret = 0;
 	unsigned long flags;
 	struct amd_svm_iommu_ir *ir;
-	u64 entry;
 
 	/**
 	 * In some cases, the existing irte is updated and re-set,
@@ -832,10 +831,11 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 	 * will update the pCPU info when the vCPU awkened and/or scheduled in.
 	 * See also avic_vcpu_load().
 	 */
-	entry = READ_ONCE(*(svm->avic_physical_id_cache));
-	if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
-		amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
-				    true, pi->ir_data);
+	if (READ_ONCE(svm->vcpu.loaded)) {
+		/* Ensure that the vcpu->loaded is read before the vcpu->cpu */
+		smp_rmb();
+		amd_iommu_update_ga(READ_ONCE(svm->vcpu.cpu), true, pi->ir_data);
+	}
 
 	list_add(&ir->node, &svm->ir_list);
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
-- 
2.26.3

