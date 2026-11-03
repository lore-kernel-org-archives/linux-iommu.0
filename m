Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734733;
	b=bkHAhSmUeLUK2Kf2JktaRZnro41HUIBDVdQBsnP/l1bUVYrb2+pnAluN1+78GrzQm+R5
	 rxF3wwig8OH7givJDt4xBghRPV+MiDerVPricSJgkBuAqg2dfYsPu3jlbd/F96mBI9JbW
	 ML/gHM7Sn2fiYLAXc6OOBfdrgvNnaaN538r2r++PDSEFF87kWoBhubRKehbCn5ka2VM4C
	 REsRXcGl2k2NXuLKbuqrPxEoj4EEg8rU9MaIMUmY7B3RrX1lzk0PnSCFm4scdyj1tkmDj
	 IpPs3UdjWi+wtbykymTRad9+vrIQgtwxNSmxBkg6Edb4n16BxsPe6SJTc/Pfy75jksg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TK3utwnIPX37GwcC6jBJrNjTtS9pS+ECr0ZBshoSLgk=;
	b=0Q2XPoKPXzI4IPcBoGCmBt2joogToDhvitF9pLNCdxQ1Bst6J6rPReC7VD6oi5HCv3Ao
	 gAwJi52EViaedcCxShKKRQze273MPgS0qLGpYHYmDzuZamPQne6zN4bvN/eZOHn4QY9b5
	 bbtbiZWdSsoRqSjlLUMjBYI/m7g4QzCr/J2CXsuoRBO3td+FazZU58oUjRO52S73B7Qtq
	 C7ot+HY3N2mKMi28RM/2+aMVjv/7iyB3F6dKMAafgZVpMFcBurdI595Kn0qa4vhKTVWB7
	 0Kfrl0OU8+BBdVGldaoFKOLsA42gJ3lovcSeRSj0EhdDEQfY4TvQB4CIOnW2pWKf7OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TX+afQ5O;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C7606A324
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 19:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD7C7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TX+afQ5O
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so13886665e9.1
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 11:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793734731; x=1794339531; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TK3utwnIPX37GwcC6jBJrNjTtS9pS+ECr0ZBshoSLgk=;
        b=TX+afQ5OtmLi0K/jNFhb5EjLFNdHPjZexNLXbOdK2n5L5lLYEavfh1RJezjq0Ewnb8
         uMFSW+ADG6GkMoE/+t5MPs5slp/rIsftxgRNBloTBYJpOSWoXuI4lnWWgjjMc7c6i9r/
         FnpsINYLolXqce+OhmVw3GnOSYu1JyZW1mcc2VUzZ4QJQrjJUKVletpO7pdts0qA+O2O
         G64bKp/+JAcwyQhOzFhvtfXS6xX1pIfP+/0ZTBb2utw+aMk+4705defFpSoGrnDRuwZ7
         MShz/Pjj0dmSZj29lOYd/kbI3ZRBb66RbEb/ATVdtDsufZXApjfvENXVLF/vHz2g4Z74
         7ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734731; x=1794339531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TK3utwnIPX37GwcC6jBJrNjTtS9pS+ECr0ZBshoSLgk=;
        b=y6nLD+eFfBPLc24Qu5JkSVT6Xlo6v12bmrVSBrRIYlV0N0UqF7l/u7zGtmse06tt5Q
         N6jNQQ1RWVFhtYxHiapH/Pq5qq6jvBJAEolVRztI0TP6jKmnoIeMbR7Xv6a2UKlBsuz2
         IX+j89rKSIL0/SeAcAR+lrXOPdqOZsiKsrBEd5XIFl5eFYe7PLd2KOoDoHbuxL3heIFH
         eA8ZNMpYtbqtZ5VS0zgFB9eFEuPvIuZ1vAz8oG0bV1jfz86yo1NUEgSuF6GP3ZnMU0+Q
         jn4U2SJN+AZPXJXtECkMECo51OqWhqcivQVsRPhQvDTqoWsmrTxRX3CCGAv9XKMr/Npr
         cGVw==
X-Forwarded-Encrypted: i=1; AKwUvBwsKEHJGSM+ewyea/rPK6aj+WrX6nxmnz4ltNKfOqUvnIUA5fs5LXx/FC+9VjF9V393qxBQbQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8EhZ8mp2wZ4SveOGt18QbE29fJP0iqURhtK6EdlOfpc5vfIdWb
	4+PR5BmXEgaFgBHjtrs5YR765zqZ0zHh8xnbX0NqMQn9BCaKrelMK5LY
X-Gm-Gg: AYBFou0aj1qCAZjxNX0+Ebyu9dEKmcdo/W+srYnjQCUUyzPfE+xBu3d8LV0mtxkhnPQ
	OWmbSpw/DfOGP6rWYEZQahEVZxOj273B6Sztox+HiLnZWE3Mor79Gjc0VEvzrsQKkKftqEkhkh5
	vzbVTY030ZeLsznNMycpB9E8WK5gDaE3AA5NItiH6+p861x19+zo+31G36mFbQuSxOY39ex2b+d
	vJKOfn3TAGhH1xghP1ExdRgFNDUN3xwekXEVB//2QH+iJppklVgY0sel4E1AxKz/UqSQRpJwMHZ
	78V1ZOK1y4pXjXGmI6e+n181PWnuD9NvhHOT8xi13F/Jf99LvOz/pLxoAwiOOIl/z9luyB3ew2M
	P6vqIFavm1ayRXJ4Ifz2tkWTrPiIoEKSKPONx4/9i+QARuLIHnSyxZiRPIYt/vWu8VR3T7y4N21
	vnYcHiiQREoMK8pMLy18Ar7IuMF4MbZPwFY7q4jtdQV91Df8PVQGZVI4e441hMdllA7NqPa3Tkp
	mdwTtEKRpAU4l3dYljVDrwVb+XqkMcuN/qGs8qGtSzRCJ7VYornvQpilfeWNAprOh8AJ9z1XTi0
	RuQNDfWYe5Tzyn883EigczmAS3oe9GqM9BxD8BXGXAX9eH1VUcOLUMvrgzYaUpnl8w+NEjdzJJ8
	LSz9wKMRFYnaLAI5fY35W9PVNiYOwNFSEyKLABlIZa4vfdHMFyfU08CzSulM3XXRycg==
X-Received: by 2002:a05:600c:848c:b0:4a3:5da2:38ae with SMTP id 5b1f17b1804b1-4ac17a3628emr326325635e9.14.1793734731206;
        Tue, 03 Nov 2026 11:38:51 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a5372d8bsm87303325e9.0.2026.11.03.11.38.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:38:50 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev
Cc: Ackerley Tng <ackerleytng@google.com>,
	Alex Williamson <alex@shazbot.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Will Deacon <will@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [RFC PATCH v3 07/13] KVM: guest_memfd: Support private/shared conversion of device memory
Date: Tue,  3 Nov 2026 19:38:50 +0000
Message-ID: <20261103193850.15363-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101071928.2462549-8-aneesh.kumar@kernel.org>
References: <20261101071928.2462549-8-aneesh.kumar@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

> +			if (!slot)
> +				return -EINVAL;

[...]

> +			ret = kvm_arch_gmem_device_map(gi->device.kvm, slot, gpa,
> +						       (u64)(high - first) << PAGE_SHIFT,
> +						       PFN_PHYS(pfn));
> +			if (ret)
> +				return ret;

Unless I'm missing something, these returns leave the pieces already
mapped in place, while the attributes stay shared. A later conversion
to shared would then find nothing to do, and a retry of this
conversion would run into the pieces that are mapped.

Would it make sense for the error path to unmap what was mapped, e.g.
with kvm_gmem_invalidate_start() and KVM_FILTER_PRIVATE on the range?

Fred
