Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BC3F9F5B
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143976; cv=none; b=qZdqVEmmgq3AjyiyN9/sk1NUS6t6zFMJzjHpn+adqlkAGZSUvoOj0U+ZP/Bvywj05uF2eUAJf3o5cfbG0F9MuRYy32iaBeUELJ29Wr7QloOUJL0Qxy3sds0HrDIKupT3xzO5ESBvTi+RZFe6M7IiFY4uY+0yWSZ/41jzv7ofwxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143976; c=relaxed/simple;
	bh=WBdGcxWiDrcVKqaT6IjY7dlU/wWj/hMB+CXmv51CihE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaAPH12kN5qsTmWokC2+4BcxlgpTGTP1Yssg3yEACaNFb5bHG3/ii6lJWAgVImvOpXDLXfQxFjeBPIkdr0EarpI9v2Mum6kSrzSyL5B5lNci+PvQtiRYsbgiwBJoG5og8k8bsCWvSR3WDDcLmDxlkpCzlU2QEjjYrnTUOlwluek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URjumONf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URjumONf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so48552215e9.1
        for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792143973; x=1792748773; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WBdGcxWiDrcVKqaT6IjY7dlU/wWj/hMB+CXmv51CihE=;
        b=URjumONfcfryt1WgeuAqgjRYS5Y9e/PDeAZq5vW+4zjAtO2opeCvVefEdusMUjQFdc
         p18kJCWeg0he0Fyk0wVyF0tyf2VahpI2s+k+dC3y/pNBDbBxenOGktoqLxkIPc+o7keB
         ACaNSuXTDaZmcCQjGI+txXujwnEsM4xIsndA9HfW7V6LYZal8kuPitoVQnkuQdG5NZZE
         kXWW8oHMTCB20QNdKwz9byhh8JM0cMWp1GLwSdF5cHfjGmTvgkGjgWMe2+TstmW79Z+b
         kuDlU7jSw5I0+GY0XIKz7CbaazIMVXUW63DvIS8d7GqgQHKsa2irApbWuHmql+PHfm3x
         9GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143973; x=1792748773;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBdGcxWiDrcVKqaT6IjY7dlU/wWj/hMB+CXmv51CihE=;
        b=rl86pgNYwcdWxYswyT0jX2u2DAfcp5lU8P6/LTgIbLMLcAZA4yEtEtiAdBmdvwmTmp
         O3m9VBtebEXwUAGlmfdkHgdZh2+uM77RfNShSrHLOIMlRgw4PBdP6ZH2YHCWScwBGSQf
         C4q87CUgK+JO8yIHrfG/diJfIaCxyPGliFt5sow3iGIeKtCnwelkUCeLdtH09w9eztYg
         G9AEgmrYbbpnIhPWY/yipjeebYfjU5XWUoSBBIdeK2GCEu7C1NkhY5mm2cXuEVLNY1us
         jxf1+QTMkllHso2RJuqtinRWshQ+O02APyqN4s1D1wquNSy3aZJuRbGd9SBg/gqSfh3h
         jz9A==
X-Forwarded-Encrypted: i=1; AKwUvBzG8vcaigi+XcXHC5IFgsHPkb8pWuOBKMWJbbNxIQDM78qYqQ+QjWQzjIAeaHA/LzOL8uivtg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJkOPMl1ClZC+eaQ/0z8F6/EPTKQC+1wsTua9hmCeSLgV+LTR0x
	V00V89GFJjrhUtvYSUcpR63evBGCKZjRw5pBr5quk6ROTx4pIYnZQx3Z
X-Gm-Gg: AYBFou1bPoY81N9tZlta+OL10ZQ96a2PqhdGlfgt+g90ZMA2K15xCY5+apszKbzN1Je
	zZY2/mLC9eU/AetQ6Jx7DZ58nWYeaiE9lIeYgVpjRVmU6zlEK3QjEJ7B3w/t9ITfOctUfKLrGka
	eB8+NnXWHBZqx/KfW7GvZvg1jL+QfIKSuz0QDxjE336plHJB901t/+a2WLwvrqEGC+HbY5wGWVA
	ISbwnkkYZn3/i1vN2krU7i8EdRZ1UirAbp5E9N6gVr9vDQ8cYkRkVr0nEMFUkgPBwjoncHw3UmW
	FBPhzN71d16tvSiCpwTk4ZFeKwqVLmLPBHF9xJn0CVHarPIUC9XkJM/+tf/Ff92859Wm5kjPPI4
	yGjBSy1AxsfKULjK62oknyC06Dfuw6HEI3ibpYnwsep0rK/NRKdkf1csolhttWuNp2M1K9Yl2Im
	t3cvIqxbvTFY1daWK6+kS1giUdx58QGHBGAJ5vli6T5KALUNOYWKJjy0s0MgbS7TdwiAp0GNNEo
	dxD1/w4/ixvBYfN+EnxHx70/LYb8nPrAG4Yq8rxyP8FFlbRqr+oo3Jqz7cYKHnO6O5uAbj7yctY
	+BWpX4YdlJ4tSXZgs3m5ndXk8HHwWcCpvJU=
X-Received: by 2002:a05:600c:83c6:b0:4a1:7093:40c7 with SMTP id 5b1f17b1804b1-4a18e493048mr406737735e9.8.1792143972697;
        Fri, 16 Oct 2026 02:46:12 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca43012sm17041055e9.3.2026.10.16.02.46.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2026 02:46:12 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 07/11] iommufd: Use large IOMMU pages for provider mappings
Date: Fri, 16 Oct 2026 09:46:10 +0000
Message-ID: <20261016094610.57849-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016001448.GC14213@ziepe.ca>
References: <20261014093733.90312-1-griffoul@gmail.com> <20261014093733.90312-8-griffoul@gmail.com> <20261016001448.GC14213@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Oct 15, 2026 at 09:14:48PM -0300, Jason Gunthorpe wrote:
> You are going to need to go into generic_pt and implement cut and a
> more suitable unmap to make this stuff work properly. We can't over
> unmap on conversions.

Agreed. I'll drop this patch from v3 for now.

Just to check I understand what you have in mind: a cut operation in
generic_pt that splits a large entry in place into smaller ones, so
that the revoke unmaps exactly its range, and iommufd uses large pages
only on domains that support it?

> Also please don't write commit messages with AI. WTF is this even
> trying to say? The subject is "use large pages" and this text says
> "map each page with its own call"

Sorry about that. It goes away with the patch, and I'll check and
rewrite the other commit messages for v3.

Fred
