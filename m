Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57AE10A39
	for <iommu@lists.linux.dev>; Mon,  2 Oct 2023 11:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696247863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2JA8Z38D8eUi/xmH+rBm9nb9Bwfoc30nugRqNPb0OY=;
	b=iXGAWTPONJMX7YP/PqGj8CrLzlhqReRrNexLNHZxoFK9oTfyh0nIi6gW9jJ4ewJ8LDXeGb
	W3rqWMaA3/eRN1ftKHwflMA2Z2YP+YJF+DQ1MvVbigZW0U/hLZLGYbe13B+0wjUHbB29kF
	4YYwolhjOj60zpVdNkRsAlpwzQDLx04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-CWvtSVzZOEiXnzY8rUs16w-1; Mon, 02 Oct 2023 07:57:37 -0400
X-MC-Unique: CWvtSVzZOEiXnzY8rUs16w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4A5F8007A4;
	Mon,  2 Oct 2023 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.55])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A5CB6140E950;
	Mon,  2 Oct 2023 11:57:32 +0000 (UTC)
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
Subject: [PATCH v3 2/4] x86: KVM: AVIC: stop using 'is_running' bit in avic_vcpu_put()
Date: Mon,  2 Oct 2023 14:57:21 +0300
Message-Id: <20231002115723.175344-3-mlevitsk@redhat.com>
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

An optimization was added to avic_vcpu_load() in commit 782f64558de7
("KVM: SVM: Skip AVIC and IRTE updates when loading blocking vCPU")
to avoid re-enabling AVIC if the vCPU is about to block.

Such situation arises when a vCPU thread is preempted in between the call
to kvm_arch_vcpu_blocking() and before the matching call to
kvm_arch_vcpu_unblocking() which in case of AVIC disables/enables the AVIC
on this vCPU.

The same optimization was done in avic_vcpu_put() however the code was
based on physical id table's 'is_running' bit, building upon assumption
that if avic_vcpu_load() didn't set it, then kvm doesn't need to disable
avic (since it wasn't really enabled).

However, once AVIC's IPI virtualization is made optional, this bit
might be always false regardless if a vCPU is running or not.

To fix this, instead of checking this bit, check the same
'kvm_vcpu_is_blocking()' condition.

Also, as a bonus, re-enable the warning for already set 'is_running' bit,
if it was found set, during avic_vcpu_put() execution and the vCPU was not
blocking a condition which indicates a bug.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/avic.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 2092db892d7d052..4c75ca15999fcd4 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1075,16 +1075,10 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	lockdep_assert_preemption_disabled();
 
 	/*
-	 * Note, reading the Physical ID entry outside of ir_list_lock is safe
-	 * as only the pCPU that has loaded (or is loading) the vCPU is allowed
-	 * to modify the entry, and preemption is disabled.  I.e. the vCPU
-	 * can't be scheduled out and thus avic_vcpu_{put,load}() can't run
-	 * recursively.
+	 * If the vcpu is blocking, there is no need to do anything.
+	 * See the comment in avic_vcpu_load().
 	 */
-	entry = READ_ONCE(*(svm->avic_physical_id_cache));
-
-	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
-	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
+	if (kvm_vcpu_is_blocking(vcpu))
 		return;
 
 	/*
@@ -1099,6 +1093,9 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 
 	avic_update_iommu_vcpu_affinity(vcpu, -1, 0);
 
+	entry = READ_ONCE(*(svm->avic_physical_id_cache));
+	WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK));
+
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
 
-- 
2.26.3

