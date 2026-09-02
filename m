Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC354AA58E
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376406; cv=none; b=Tmov38kFDanaHKUj+BO0KH9fXnRiQMLNKS+oBWi2NrhTLoSGJhX15Xv0Ev68KA6zY8M4hHUKd/qT7w9p/y3RFE+2b2jJBtBA6xlWPoG6F1mD2bHQ3osH6fQ46TT+Adp8+JcD+AcdntsPuImWSoqYnwn9zDgf7GRG3mMMsIjlspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376406; c=relaxed/simple;
	bh=y0nOywplQ3deuSEhSsaVE3Xyee6bNT1wa/osER2A2b0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G1GAYCf8nsxGtkD/GiXtnxv0Fa4UjaZHUEUDaFTpSkXvQ5p44hW7lwmmmlPICLYd+MvX3yCQBn6V6P9XhSD/Sb9L6dKhxVPs3s/i3kUJoJv1k/NxQh4C6TSexPn23v+IN62n1zsX+vE3tu0/b3KoIM2K+qrvAvMF9E6sadSNRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srLbxKYn; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srLbxKYn"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8538a72b430so1364176b3a.2
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788376404; x=1788981204; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N/WHyg1m6TTdS/dUEqB2VFq+qj0dM9IofHpTvipqAJU=;
        b=srLbxKYn1SCSb+RDWdcE4spa3T10rNEc7WkcKAR+yr+7Fb8GmSAOtPtD2DRaNV4Oue
         Bd80bkeW7cDzDrms1WmSkOwQuRWBGM8yn78qPLFgN00hE1pmAjPTBm0hL10CuxqGZ5DY
         l55Yts+Yu4KQG/fK1O7FigpQIVG5eDgdoSlGuFME1qsb4mXGaiUdOCKaWHYsN0OYSuLC
         SIaz3YeAF9ye5EYfTIeWykIVwzXLb1fPImTaiTu6YcNOa/9QdDkwIvM3K0OuGuzG4+Vk
         K3upjLcA+jMcJYO4VUW52SuDZN+qZpkMROJkjmthU7WfMLOBPyidpLAdIFh7BjBUInRy
         HGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788376404; x=1788981204;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N/WHyg1m6TTdS/dUEqB2VFq+qj0dM9IofHpTvipqAJU=;
        b=Od5sEiPnDYSNyAvgOsuFpboNT1gDZ5mm5n/z6DhxoVfSzP8nYaiunNobkbbVmKsVYB
         OzuKIfilCbClWdUbSVdM+D3GKcBPYbgvLsK1ZyChgjBK9DOHrKv8fZ7OqSCIvwaxKxpJ
         c6156MqcJIuc7uhyXLpKByWrGzRhNd+y6OIDIKUON/JV/Yvx7BZBnYtXoBit+iK1ukYH
         2ytxYCrivcjoP981D3nfB+T7mdV9LKqaRftxp1rUkz/eYNVih3hfy7Af1OyH+kMdq4uF
         5HnD62oT2iFYT8u4n/Kzf7suGp3m7LEeVYqvrhDeoFGxmuBypb63+JCJV6AYDqz48wyT
         iFoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrVHgtpUJH+xnmZo+yPRl7tTwYhISAzsZnwX17VEAPhlXQun41MLj349EHyVg4NXG+qLHcQQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kN4CydrPLKR/A3l7OSxCj3JiOxQULuAYKiKl6tRWmC7KIG0XEu
	lqagpQseSuOTrWyagfh6DiYpJS8binXPCN7zrYRhl1lSDkC93bKhGxXoRYNOcuocJlndEKYDAMj
	7OaRFwA==
X-Received: from pfbbd13.prod.google.com ([2002:a05:6a00:278d:b0:851:d12e:df63])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab8a:b0:845:31a6:d84d
 with SMTP id d2e1a72fcca58-85ed20ee9f1mr11533931b3a.7.1788376404046; Wed, 02
 Sep 2026 12:13:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 12:13:19 -0700
In-Reply-To: <20260821-stable-item001-snp-builtin-kvm@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260821-stable-item001-snp-builtin-kvm@kernel.org>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902191321.2644150-1-seanjc@google.com>
Subject: [PATCH 6.12.y 0/2] x86/sev: Make SNP usable with KVM=y
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Gao Shiyuan <gaoshiyuan@baidu.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Joerg Roedel <jroedel@suse.de>, Sean Christopherson <seanjc@google.com>, Stable@vger.kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Tested SEV, SEV-ES, and SEV-SNP, with KVM as modules and fully built-in.

Ashish Kalra (1):
  x86/sev: Fix broken SNP support with KVM module built-in

Gao Shiyuan (1):
  iommu/amd: remove return value of amd_iommu_detect

 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/virt/svm/sev.c    | 21 ++++++---------------
 drivers/iommu/amd/init.c   | 36 ++++++++++++++++++++++++++++++------
 include/linux/amd-iommu.h  |  4 ++--
 4 files changed, 40 insertions(+), 23 deletions(-)


base-commit: f717995cb7dcd8998ab15516b8006aea09cfde0d
-- 
2.55.0.970.g62bdec98f9-goog

