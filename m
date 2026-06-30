Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2040E8C6;
	Tue, 30 Jun 2026 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817531; cv=none; b=uxtGG40QSGkKbYOBzFztSTf0ixoH2fgmMI6Xt/WpWtNvWuVP3XCSnGuEHvD2WfDtPsAMTLyp6LdpV8WA5bm2D3GooGn+M16zEnE+g8kipZoUDbh2MOf8JNgbjZ3sz1hMkeS31jkJsw3fOgWLXwWV+m+Eg+SVfXYdA8by7hKHKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817531; c=relaxed/simple;
	bh=kZJbG2O+6yeX6gEpYhNOPnGwXw3frAuKFZculiTCulw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HP54clVvp17yIVlj5v+k0zVm+UjGrBiIDF+Grf3zR30P731lL19++kCyxZyJfaOSxnBtdCqsQUmIo7h1237RGRdBA96fSuGd3z7M7BNWDUIH8JGgSAmLk7e8exUffex1IvQxxV2NzjOuLW2fWI3fB1SFihKryc+nErpPXeGSM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsY9VY65; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsY9VY65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5952C1F00A3A;
	Tue, 30 Jun 2026 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817529;
	bh=hnQYDbNf1O/dH1zz/2VAhmSeCCwJ5x8F/LTf+gjtwkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EsY9VY65AjqqaljnNdL/WAs6WuJcvoLAqplQsn0gWbo46qXa6s2y0w/oWEJAsCFIq
	 ehVh4d2Xrv5dg7VFvLnBVF0Bwi3oC7zeA4QBQkDruvHtUzZE+vdzY2exsFb48TALvV
	 F6rHNDZ2Z5uRiAFcgPnzuLf5YseFMDpBfcyp6KeLRXWUqYdCgpModVNc8XE3tA4Vqu
	 2888Gy8eyH6AkwcHD5Jj/9gW+J+tL+7jVxdMPWVDBZspAfBVc0qAPpUgiPDcFYWwHO
	 zrJu7UPonWZbRh3C4lAEQjGI48ohqR0WwYaeiZn2/THLKWRk/pGT4pFQUA2t3zKj4Y
	 Y2Ts2iKbbGafA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: chenhuacai@kernel.org,  kernel@xen0n.name,  pjw@kernel.org,
  palmer@dabbelt.com,  aou@eecs.berkeley.edu,  robh@kernel.org,
  saravanak@kernel.org,  bhe@redhat.com,  rppt@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  loongarch@lists.linux.dev,  linux-riscv@lists.infradead.org,
  devicetree@vger.kernel.org,  kexec@lists.infradead.org,
  iommu@lists.linux.dev,  zhaomeijing@lixiang.com,
  catalin.marinas@arm.com,  will@kernel.org,  alex@ghiti.fr,
  akpm@linux-foundation.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  ruirui.yang@linux.dev,  m.szyprowski@samsung.com,
  robin.murphy@arm.com
Subject: Re: [PATCH v4 01/10] kexec/crash: provide crash_exclude_mem_range()
 stub when CONFIG_CRASH_DUMP=n
In-Reply-To: <20260630074715.4126796-2-chenwandun1@gmail.com> (Wandun Chen's
	message of "Tue, 30 Jun 2026 15:47:05 +0800")
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
	<20260630074715.4126796-2-chenwandun1@gmail.com>
Date: Tue, 30 Jun 2026 13:05:23 +0200
Message-ID: <2vxzqzloi8zw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 30 2026, Wandun Chen wrote:

> From: Wandun Chen <chenwandun@lixiang.com>
>
> Prepare for an upcoming change that excludes non-dumpable reserved
> regions from the kdump vmcore and will call crash_exclude_mem_range()
> from generic, non-arch code.
>
> No functional change.
>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav
