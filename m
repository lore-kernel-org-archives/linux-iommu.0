Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3144519A7
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142193; cv=none; b=AtYZhSSHWXT6O3eGhuCLdTmTmqHSL7x0HPAewvemGrNhHv7WDsAQbYdDdTdHUubnPTAPGesC/Vwc1dF6DE2MMSSHko5GCG30cjdgGkOywbw66fpIaP5AEkhSXCKrEQElP+elh+YEg+Fr3aE+of3e1mX46Xn9tNtH7NcLCIVSXL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142193; c=relaxed/simple;
	bh=ZKTQiqaUB5djL+VKplSECEMXubTC4GKdMv8dMZE3860=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zx+kjSIrXaj16n87ZNiJLKQXbRQHXzVD3ysaaMPj4IcCCWOgLw8hSYJE6rywIRsLpX28x6FVauqz7olDMrG76gFFbI7wR5z7nYinkcRPNKJrP7wiX3jN5I6NuL13J6pfDKapkxLgyehxSXrZ+XqeBKBNFnfKwp7d+aRrQL7N20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j5fSq2WzTz8Xrnw;
	Fri, 16 Oct 2026 17:16:27 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl2.zte.com.cn with SMTP id 69G9GElv040441;
	Fri, 16 Oct 2026 17:16:14 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Fri, 16 Oct 2026 17:16:17 +0800
X-Zmail-TransId: 3e816ad1eb5a024-bff28
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: jgg@ziepe.ca
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, atish.patra@linux.dev,
        fangyu.yu@linux.alibaba.com, gong.shuai@sanechips.com.cn,
        gsh517025@gmail.com, iommu@lists.linux.dev, joro@8bytes.org,
        kevin.tian@intel.com, kvm-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        pbonzini@redhat.com, pjw@kernel.org, robin.murphy@arm.com,
        seanjc@google.com, tomasz.jeznach@linux.dev, will@kernel.org,
        wu.fei9@sanechips.com.cn, zhao.qingye@sanechips.com.cn
Subject: Re: [RFC PATCH 0/12] iommu/riscv: Add nested translation (vIOMMU) support
Date: Fri, 16 Oct 2026 17:16:10 +0800
Message-ID: <20261016091610.13912-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016000004.GB14213@ziepe.ca>
References: <20261016000004.GB14213@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 69G9GElv040441
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 16 Oct 2026 17:16:27 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD1EB6B.001/4j5fSq2WzTz8Xrnw

Hi Jason,

Thanks for the review again.

> > Add nested translation support to the RISC-V IOMMU driver, so a KVM guest
> > with its own vIOMMU can own the first stage of a device context while the
> > host keeps the second stage, and add the interrupt support. This is an RFC
> > and comments on the design are welcome.
>
> The iommufd parts looked reasonable to me
>
> I feel some mild skepticism about all the MSI parts, it would be good
> to get more of the interrupt stuff actually landed before posting this
> again.

Agreed on the MSI parts. They are a working proof to exercise the
nested flow end to end, not a finished design. The reason they are
in this series at all is that the NVMe device we use for testing
depends on MSI interrupts. Without this support, DMA succeeds but
the MSIs fault, so the driver ends up polling for completions after
timeouts.

We will keep following the irqbypass groundwork as it evolves, and
continue this work once it has landed.

>
> Please try harder on the commit messages, do not use AI to write them
> like this. They need to explain why this patch exists and what problem
> it is solving not some inscrutible description of what it contains.

I will rewrite all of them.

Thanks,
Shuai

>
> You'll need other riscv people to help you with reviewing it.
>
> Jason
