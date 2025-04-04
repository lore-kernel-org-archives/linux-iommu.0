Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61923F424
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795677; cv=none; b=TthJmJaZ0JqYNR03KaSDovlkohtJCGOx9C+IQHmOSgXVvPgns5iQ5M5HoXkeiapOZGjzyJNVYzaEnE78G+XHEXeM+hjY/TIPQUAcHFSTkf2DYhiJ1I1Yqxgn2+sMSS7MG53pwk0ygIpjOQ6XSJtKP5bvuI2q97T5p6ULQXJ/nwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795677; c=relaxed/simple;
	bh=bysiSM9qAdo7w3jTZoibNt/lKzOp1jzLwij4XBANYyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rNxBwkbNXkbIF4PupvtbqceH8KSQ/UejfY452Qtyb6I1MLtAvbS+Uo5tftxMsz55lcLpTUVvAKRH3yxZr+wO2xQ32JKFRiB7M1nFcGyohUsbSTh2zL7t8TIwsMNJojDmAiQ90548I/cQVqhpR5NsuY0BilAR3LeBH8N9+teak3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TJ9qjHbU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJ9qjHbU"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af9564001cbso1734493a12.3
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795675; x=1744400475; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PxawxOY/h734lZVFn8ksHoL6g5gCibnUodY00H7f/TU=;
        b=TJ9qjHbUE/Co1Hj1lYcFkp1VVYySplU5jmXFtr5yQFO4HURhZKbywe63pKgTeOlYYY
         phAOh8gMiYSyqFP4lcO5foHF6mVA4QizkbmSSHWHMBHorioAKln3PR8pw6kRToHgZ8Gg
         0kwqD3DTUu6qXPHCNYz926vwfhgwy8FeNkvaJf3wVhtQLdkjY8J6VPjEHSUnFL/qUaG6
         eKaxUs7PzsjI83si86ufXq1jww0KlJ/pqWb31j7rw7K0cppBzA9aArdUCpX4u6jO8yte
         17L9D5h7mONCTg0T4hJJOxvjbP0LTlWav1QGxlzk4yaz9kpZ2YQk4k0gL3ZnWlOP06Oh
         jX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795675; x=1744400475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxawxOY/h734lZVFn8ksHoL6g5gCibnUodY00H7f/TU=;
        b=TFnFDNblxkIZ2XG0VZ92RY+H7TPGtWWmN4lZihgY0lWLNv+WfwTu6HA0lG5UEUsXOV
         lv9bMAUn3KkmGiorVk5HgPMpT7Q9ljmcGIa5BRLJNlCvfJ9PEO9LAvYdDlDwSS7CkiAp
         x+A+bvOc+aYFwFWGY3Wy4M0MpQm+rRLr1WUTZNrbL3F0ROLFwfqiJ9KDlArDSa7bOp/8
         Oh5dRhsZPXj6ucd5hL2lRdBh/uwumbjI2kUGvdKt09rcFoF+b9j08GsKf+xcYp3JX3YQ
         dNrZ6rGsZmvI1V2nQLImow4iXdKcJGMGzxeyv7DY8hIZ/7jz5x+eLlFedSZD3GrTAYMa
         23aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyMPoIXhhjZ3j+7rhAC0JcWL33kUu+GO/cNSDNB1WBvs+FEka6ZO4EDP2+pNlF02lwdxKfBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKh1uiQEmBOveY4o0JhB+3CbL1xUJptBvUT6qn3zSeDJ9BxEgN
	B4n1wkBK3o3XMx41aNPazH+hJ6BZWz4qw9fagomdxbgYbMuSyGMO7N3tDq/xhTWSo3V6MP7FV5T
	YgA==
X-Google-Smtp-Source: AGHT+IF0dzvMV/vshjJPGocWxq0fkVPPJN838E/ImYVh1WQmz0SFa2CAc3x62alWuXzKlUZkk5y4MEI9SnQ=
X-Received: from pfbgs17.prod.google.com ([2002:a05:6a00:4d91:b0:736:56a2:99ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c66:b0:224:191d:8a87
 with SMTP id d9443c01a7336-22a8a8739e2mr55191535ad.26.1743795675258; Fri, 04
 Apr 2025 12:41:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:06 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-52-seanjc@google.com>
Subject: [PATCH 51/67] KVM: SVM: Process all IRTEs on affinity change even if
 one update fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

When updating IRTE GA fields, keep processing all other IRTEs if an update
fails, as not updating later entries risks making a bad situation worse.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 5f5022d12b1b..5544e8e88926 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -857,12 +857,10 @@ static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu
 	if (list_empty(&svm->ir_list))
 		return 0;
 
-	list_for_each_entry(ir, &svm->ir_list, node) {
+	list_for_each_entry(ir, &svm->ir_list, node)
 		ret = amd_iommu_update_ga(cpu, ir->data);
-		if (ret)
-			return ret;
-	}
-	return 0;
+
+	return ret;
 }
 
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
-- 
2.49.0.504.g3bcea36a83-goog

