Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E019F9E8
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007099; cv=none; b=J+e5LKS1BCz3ASWHCbeEHd+W3mdgv5cLer6vK3rCymHa34HqKxF/vBxrsnsNxOmYY5r1AK35SGVtxo8Q0/vTW+L/gAwlL5uDcGzuDFqScv0pZWSisw16HebHro69suGOAI1CXDtHClL1mIl3u0bxvUU+V4ALf8XV3hG0nxrN3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007099; c=relaxed/simple;
	bh=0YZU/DvP8fB3z8mZiiIDMaWfk8+HgW+71aQP8SeLwgY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JCmm+SJSGvXZNhPZfQx8AQk6ylDN0IBT6BysH/nfoHjWiTSgA5KW1I6b02Hoje2/0I9XR21E0yEMuK0xBGkffdiZvxY269rLoT3So1HLJvLi2H3q2loL265Lt+DjnkTh1U4LPy9GkkmAuX9i4+dsbP6uddFRT2NlSMcUnilzTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0KXxiJo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0KXxiJo"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so466995a91.1
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742007098; x=1742611898; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMbGiitCpuvjOFuODMMxjAc19DExq9bX91Vfl+5044M=;
        b=b0KXxiJoXuc1Hra8DoV+yaDqDV799BOqVNvr6qTX6kLgHW3Fm5g4/li8Jd1sbD1NL/
         KX8YFDl2/UN9sJt2UOWUnqKX0Aa7Uln5Rf3OYnv6QPx7dRglRUhQEbnMaulaqAmrBFuW
         sucgPnr/aCfccNDarYcFc0i1Y+e/0TUUwqnJFg0EvPzUh5yIxViRRL8pFMgBCyzHvqtM
         qgKqF4rT0OSy9Qgk4sMkE+mwlXU3MwRMUktGcJCOCXlkZ9MN85Qbp1Zmjx9Kj7vnyNx/
         thKfGRdfPuYb5C0Tn57pjN3TwOCXIgjx0/4st4ap4bwMF7p/LBS0NstPeUReTro1Xew3
         XufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742007098; x=1742611898;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMbGiitCpuvjOFuODMMxjAc19DExq9bX91Vfl+5044M=;
        b=QttY3+Psn8pbjqr+n3sqoPkQWEhO0toLjdBjX2lJBHZV4FephK/ATcaYLGPbjwd02J
         PbvjZdd3Vr9vFx0SNo69xH+BFvN26TEU0Fx0jd/58thEAYA+lta/9B2jKL9CpWkB7Ri+
         JttGm1DZA11OgZeQd4S47DQx74IKq76S4W3zxwCHjYDQSaita0QCJlSdiexn0zxD0mum
         jcytlXzEqep/KF9HqmptDIjOtsLUYPeTDG0ZKAkamAG6tgYH++fpgJZTZUu7YdQXj7eG
         Oj/59sNJe26XxP+qbUOmvyajtvvyPXM2Jtk9ioHJh0rWwFXN7tKBdK/XwvckY8oXAv9J
         nUIQ==
X-Gm-Message-State: AOJu0YyAknsZDnjurmOkQOhoobabs84kaDJsqvm5LhJkjbzWbV5RfKa4
	PPCDt1p6G1awHqODBDCrpzUsJxH8SkUJJ3d7wmxmWHjK8MIkV4f3dRk3tcSO5jjtoTqq9XRAcrR
	cqg==
X-Google-Smtp-Source: AGHT+IEp3KLKUystWtxj9uI1C1L9MSg3ce6eOk6EzEg5jdro4UAaSDmC2iPIXDV2Ck000kG9t+mMtpyxKqA=
X-Received: from pjbos14.prod.google.com ([2002:a17:90b:1cce:b0:2ef:d283:5089])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f0b:b0:2fe:80cb:ac05
 with SMTP id 98e67ed59e1d1-30151c9a26bmr6572265a91.9.1742007097783; Fri, 14
 Mar 2025 19:51:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 19:51:33 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315025135.2365846-1-seanjc@google.com>
Subject: [PATCH 0/2] iommu/vt-d: Fix posted vCPU vs. posted MSI bugs
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix bugs where using posted MSIs will clobber IRTEs that are configured to
post IRQs to a vCPU, and where undoing vCPU posting fails to put the IRTE
backing into posted MSI mode.

Sean Christopherson (2):
  iommu/vt-d: Put IRTE back into posted MSI mode if vCPU posting is
    disabled
  iommu/vt-d: Don't clobber posted vCPU IRTE when host IRQ affinity
    changes

 drivers/iommu/intel/irq_remapping.c | 42 ++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 15 deletions(-)


base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
-- 
2.49.0.rc1.451.g8f38331e32-goog

