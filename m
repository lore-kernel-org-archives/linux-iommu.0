Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37B30EF89
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200793; cv=none; b=P0JkDZZkDPi1DW870aOoTnv2sbqo7fIjMIYyDXPr1b3NT+CuhiAI6M/3B21jQeWjiv1ZOp02pJKiUtUyopiz9PlFHUnvegSUGqwqW883StDjD7JG+PcPg8Rz3Ryf33/o9e7TbXmmueAyZC8UiwKKU6zbTxUYwo42DWfhM0sztXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200793; c=relaxed/simple;
	bh=XxnLpS3+VPeOBlMC4Ka+b4+RXUk4ywnuUiy9zu0pes4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=THV+m8el1mtAcCjmvmjf9ImPWrQfLbbOuNyrpqdRymP4MqJftVHXR8rjhS/Na32gakehvobOyUsuq/WGUQbwQs+Do6hWT7SnF7/TUJlb1MhpXxBcw4Af0U5IvFAfZHxc0FTtJKDDeALrnUiS+wi1/B9nkpRzjNCTOs/I8HIPJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C9pn3PyB; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9pn3PyB"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c20d5d7f4so11816625c88.1
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 14:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776200791; x=1776805591; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C0aq5PnM9ScwhwGR5KXubbdrmBvk/M258zn+LjecNA8=;
        b=C9pn3PyBdxyZjD0QMYr8M/R1i5Q40SJzQxXIDLRaybiQ7d0oHnUKtmmWc6FHpPhkvy
         /PB6VWQalZjmB416t+8baVd9ahhdBFLsE4bU/DoiRJMDqaewdIbGOySOG4RNdH5/AXFs
         4Diw17knh9pqCbxdgJdUspk3a52bCjYU/BG+dZpuMrjLxdcDczdL7/zV+Kc3xmSvXyh/
         IlppL15peBvshTe5T5Lr3SYjX6frkdHHK+9XTNihlG9fkydM0HPdOXgnbIIbzs0qRTcX
         CWUZaJoUWp33cqj0xc8nchdIV5nqZi9VY3ucoc9Ina/cbJGrmMftJrUVoelA8o6+/Xt7
         ItDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776200791; x=1776805591;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0aq5PnM9ScwhwGR5KXubbdrmBvk/M258zn+LjecNA8=;
        b=HC/Hcd8nVkT0JKn95DkcAcdd7vN5AN5/aI02+BNGE+wd4kBua9T2ct75JGPUz49fLv
         YL9FmVY9XlgsERxiLiuivPrfhuj1ok0z9bisaFqoX2aV17q9jjWXjDqQD7Y7SXUSCBci
         jv69gEiBn69wU8D6zfWeNZgGvfBMVCJsloGdrYgZUHG1wJFQuOLPc9UwljrIaYn50D7m
         PylCQY3pJQZhMSuJk4bQPla0Vc7oOhWiKzZMpgk7PXI27c06k1xEbBFGmZMQqC4/sKgF
         RwhUuM4z6W8GsztuHdcjyZLQWbjL8NqvVzBEaDj7Vi73Wa+SqyRcDDbpPAZkWm+GO9/x
         l2tw==
X-Gm-Message-State: AOJu0YwRqdLJxdROIj3JknjAnvNB9v6oEOaJHdDzBe0byP9V+fI1kxfi
	4aA71gFVtPyS0DfI5J1NUJtWnzgCfP1wgHr5rq6TuNj8239nm9xzpd5cZYGvxXYAprADgzCW5lS
	trtKDWL0cv0k+B8+TeBWbNRcS/66+6IoWLhXjv2Q0pjW9SuUx9/Q1miqrwxKMprDN8yS1TY+n0b
	PS53LzFzsor5UsiT72QfIbgSpb5YdUBw==
X-Received: from dlbrh5.prod.google.com ([2002:a05:7022:f305:b0:12c:4c5f:243d])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6894:b0:12a:68cc:3f08
 with SMTP id a92af1059eb24-12c34e65d19mr11098846c88.8.1776200790299; Tue, 14
 Apr 2026 14:06:30 -0700 (PDT)
Date: Tue, 14 Apr 2026 21:06:25 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414210626.2097722-1-wnliu@google.com>
Subject: [PATCH v1 0/1]  Don't split flush for amd_iommu_domain_flush_all()
From: Weinan Liu <wnliu@google.com>
To: iommu@lists.linux.dev, jgg@nvidia.com
Cc: joro@8bytes.org, patches@lists.linux.dev, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, wei.w.wang@hotmail.com, will@kernel.org, 
	kpsingh@kernel.org, josef@toxicpanda.com, Weinan Liu <wnliu@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch is a respin of Josef Bacik's original work[1] to fix the
performance issues and soft lockups in the AMD IOMMU driver when running
within a VM. I am taking over the respin as Josef currently has limited
time for this

[1]:https://lore.kernel.org/linux-iommu/ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com

Weinan Liu (1):
  iommu/amd: Don't split flush for amd_iommu_domain_flush_all()

 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.54.0.rc0.605.g598a273b03-goog

