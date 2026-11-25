Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628450;
	b=QodRDXjZaTVWCY6AgRDgVn//abCHSvE24NYNw3BIKwrIH92iBSw0gyWaxyK6yDFhCdSW
	 4MOVfUs6bbxtdJhBfbWB3r+/2oQNBHD7npZLYftrPHapMKU+FPmW8tNGk8eUHMKYsGRBS
	 1pl49KIe3ep9wom7nT6NpFNzD25dAdOWn/shwmVFyYyXiUHH3sTDq/AxHVwT6hYmjLYBj
	 pQT+o6JfryWImTD39voGVl2YZ8VKTDnma2brdCvVdM9x3YEnGuYAK5Cdx6aEL/1ZrhYbv
	 MdYP8H0zhdsgmTug+3Oxx8Xs9bSkOgiQdhU+YuS0Dd6lS/CV9QBa+30eSgS2PyYxzgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
	b=shh0m9hIfJvqDHabjb33DZkustw3vmKyrPFEOze8xV/DaAi2keMzhIWRyHLAvGwLx3aZ
	 B6+emaKPPis1z0iiB8jePZCG+OxsuyxuuYmvKwQUJo7/4ztDADcEHg0p+10IQrZVUOYiF
	 TPAmtYZ6kL0/y/Dn/jxyDGoV2gVKnTkuUEgA+IE3AvfhCEIg9U6edwpdZxfhO73Wm9FlJ
	 bUGZIwaLcBYbCFbBaVs6KuFqJL/i92F5tllCglHRY8nkVAUAeffI2IeC+2I2166ZntHMX
	 +JH3ZEEerAq79oitOAtm/F3SgB0kaAiF51JjkpTmQDMHK0wWHRJkFov97V8HyKj21eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p6HG1C5f;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF13606A330
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 17:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF13606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p6HG1C5f
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b41188c8b9so4282116a91.0
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 09:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795628449; x=1796233249; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
        b=p6HG1C5fkQH+AvnP8A3Le4TMLMAPBb0bpBOrd1cpHqQbIEzXBCLi7zhrOELIE4vq/k
         63cSoFsJrw2XjiAOHWWmSnwaDHYQAMoLgW7R4B7sEO0XFovZ6kvClpY7Vtuwt19/WhDA
         tstalW8cqyZZ07FKnWAFLPNY54RDlzAGcufWq23lpGQAgnqiOGIikMXPAFxdA1xwffKP
         CO/PuB1PuSD7hd8xJ4PadHnjK8nne8JlJkfbC4OkB6USq5pc22ushJS8j/TgR4czi9XR
         ZVrA7DlvJ37NDUoSKxx+jCxBPLGDM1nFWttMW0Lgt7l2AL0oPg9M9RIHoRvh03a7r01O
         TXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795628449; x=1796233249;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
        b=VZLvJ9UOIBJIs3+uuJmdaDczAG+0gT8haf7vKAI6nAai9u7i4d7D/ase1aGn70cft8
         oRrJ/nQRBAxziLLkQrFj5Cr8Y3AsSz97OKN38LMpqXNJbLFC+bHQqRZLdIyCT3eJx3q8
         DXAeBco2NnrfOOOuHVkL5JF69gC7L5oHJFjeNXjPaPnQXL2LLChmM+wjrL3uQL/oBXEO
         5mvxPczSgMlXoJybooAhUMh80tRZx0Q0RtgSuM6JsPPRngRuhg/G7yl7FloPEIA+h0lC
         j7BNb/cvJJR2Ry5yoeq3Tsimj0YOPJOz48ZQo260OwPgaX+Nj+4GWWvRefS+HtBj4gnZ
         v6gg==
X-Forwarded-Encrypted: i=1; AL+hErFRJ9DNklNeSOS9mMswiHzLcnFHsfBexDscXiMWz4TQ05CH96lCvmK0yRzXf4EAWVFAo5vZhw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8UBlF27Igh1Vr2UduDemL6vAjYMxHfwH58C3Pjan/eShn54HVi
	oqSeVjDY6zjC0+dLXv8Xi6OGZMHOTbwL/75kQZsmlABNkS5aHrhsCaTfWT8xWxwx4A==
X-Gm-Gg: AZFdTZek3uWV4/uVab85LykzacVbWfsXsoGU6Vu3EQLlSHv/0W693ob96sTgz6OCSzt
	724to3Q5BJXIHVpi8Bg8bIcNZ/s1vXQVYJBm8R1idjmnbjHO/Rq4RlpAR1r6fBX+HG+t+DqdN36
	hNgpmnruNuAP5xT6DU4WdCP8jiZVefnBjZVQ+SgnP5h54L30Jf8Y4m8SWiwUeO8dh9i3GwHz+rM
	k3gvwNg15PESGG4Zu9u4EzpAiEvOgITMi68SaxFgbmzY/k6L+LY6PUMtN9AerUSoDoIX4FEfg+/
	9sPQftzpL6H/o2DSDrUj4MeM+RAbJGInXHoAcorVEhup545jvybNad5GdaJYpHp2weoeqjcDy2X
	JWHfWQFrjcBN3PXLREss145SigNCqynf7S5TTg+VjWKYCIxowuHFRfbWbGf8U0feuO2qqdQ9SX2
	EItMVrJRx9QX/EZ/fTZKugPymFXxQAQReV2pxPh/qw6i3t26aNgdCzDAdxRq8pXkjLk1RT6FeJx
	L4c5WyxvK6CMmB5o3A1l/1s5blb0aAQ3IrCIo1ys1So7rjb9u5TZ0m7luCGdoAuooXfBTXklljR
	g9cXZlRUQB/aHZZC+JMcyg8aWcm38aePC862YPow5F1f4SrWmWz93WZpi1rXDjyB
X-Received: by 2002:a17:90b:390b:b0:3b3:fe22:2745 with SMTP id 98e67ed59e1d1-3b41c933edamr18216503a91.45.1795628448898;
        Wed, 25 Nov 2026 09:40:48 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm31676002a91.15.2026.11.25.09.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 09:40:47 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 09:40:47 -0800
Message-Id: <DN4H5ST3X9L1.3IUEC1CA5QI8H@google.com>
Cc: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
 <2vxz4idb1i2w.fsf@kernel.org> <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
 <2vxzld6hx97g.fsf@kernel.org>
In-Reply-To: <2vxzld6hx97g.fsf@kernel.org>

On Wed Nov 25, 2026 at 6:43 AM PST, Pratyush Yadav wrote:
[...]

> So I wouldn't want to support slab until we have file handlers that
> churn through a lot of preserved objects.

Makes sense. If KHO slab isn't coming, then I'm fine with the arena.

One thing I realized is that the choice between the two is visible to
the incoming kernel. With separate allocations, the incoming kernel has
to free struct kho_vmalloc and struct memfd_luo_ser separately. With
the arena, it must only free the top-level allocation. So we should
pick one now (while memfd is bumping its compatible string anyway)
rather than switching later.

Separate allocations leaves the door open to KHO slab but wastes memory
in the short term. It's not obvious to me which direction to go :)
