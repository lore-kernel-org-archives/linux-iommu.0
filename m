Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7E374FC
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695922456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jEwA8CyX78/GkMVoiAVbpRnGMlV0gBkCqcXscfLzkHs=;
	b=Cwcuq528PVvN76re+Anv4GDYmozrOM/QpWX9X3TsFW+pIdPQl85NGfKD12b0PSwqUrZoDJ
	9lkOWjISbiPKHbUBJOC/pJDQwnmipGMU4qMKRD/KZEWfkKh79wiWtdBMIG2Fki92P9UXdr
	2wqWD0l6xAy4pSZ0IPMlPsDCFnKyCsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-8q4-2IX4M9GzgZ9LF6aO2A-1; Thu, 28 Sep 2023 13:34:12 -0400
X-MC-Unique: 8q4-2IX4M9GzgZ9LF6aO2A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C8F9185A790;
	Thu, 28 Sep 2023 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.141])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B43D14171CB;
	Thu, 28 Sep 2023 17:34:07 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: iommu@lists.linux.dev,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Joerg Roedel <joro@8bytes.org>,
	x86@kernel.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] x86: KVM: SVM: refresh AVIC inhibition in svm_leave_nested()
Date: Thu, 28 Sep 2023 20:33:53 +0300
Message-Id: <20230928173354.217464-4-mlevitsk@redhat.com>
In-Reply-To: <20230928173354.217464-1-mlevitsk@redhat.com>
References: <20230928173354.217464-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7

svm_leave_nested() similar to a nested VM exit, get the vCPU out of nested
mode and thus should end the local inhibition of AVIC on this vCPU.

Failure to do so, can lead to hangs on guest reboot.

Raise the KVM_REQ_APICV_UPDATE request to refresh the AVIC state of the
current vCPU in this case.

Fixes: f44509f849fe ("KVM: x86: SVM: allow AVIC to co-exist with a nested guest running")
Cc: stable@vger.kernel.org
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index dd496c9e5f91f28..3fea8c47679e689 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1253,6 +1253,9 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 
 		nested_svm_uninit_mmu_context(vcpu);
 		vmcb_mark_all_dirty(svm->vmcb);
+
+		if (kvm_apicv_activated(vcpu->kvm))
+			kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 	}
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
-- 
2.26.3

