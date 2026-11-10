Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330231;
	b=rnpP/DfVCtU1zQf/C1GLS4a1b8+y5kVvRfpKHnAmmAM1mzYq4iBY18V1dzA4DHL+8XHN
	 2rxI/fMVCMavPJ3nrnj6lbi1FxUmGpP2uQvKc9dIAgGGRWFY9lzeWgKynWdrfK7XVoWTC
	 2tw/XxGd2+TOhC6lgEp/J6DoORqbbfFqAdSC3L2HciJ8ghhoFjNdHUnfYoNEDv78wKkk7
	 jcqqVplc4p1KFs0E+yo8PNxOcfDwLW/c2YJ0/0Xfo8mGBykdRT/0FLnsPhtSDDsoaYP2Q
	 smjoJ1weIs0ff6ICAmFDTjhTT9c+dIAzk8yX6UzMNbC23soP8V/rpkzU1oeQrtWMufQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
	b=YxBwNAt/aaJnNeT4EzRj0uK5hw8IKl+cBohqVk3i+KJnXJHOSUNIwsBOaRzkcdYBFx4b
	 PQlgkiFLD68RU/CvAP93JGQ3bRxaNKdkFDHBryMlnMCJ3SV439Hc6Ywqq5j7zDLm7nys2
	 uwIsyX387Q/pQNOQR5us1H5C/Mnd1xJw2VP5XFNLCm3sRsHtC/aPPRhcLOiSpmnBaLn30
	 G/ekbaX9gBfeEeDSFCN+LydS542yRNZFr9s19M6tCYz6jiXW8L/uQ8wM/LPYLDcw/pn4c
	 sVjHnAMWXOMBf5RZlz4vuUW8/AOCsUXODI1904wYj6cdVWc6oZesoUgV14jJb5pPwvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XnHZmP5J;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82D606A32A
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 17:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F82D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XnHZmP5J
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso1708139a91.2
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794330231; x=1794935031; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
        b=XnHZmP5J2WVlzvlOUmrOvKw/TjGwN9RN3JgG85bGTpPbvNN3Pm3O9IUj5+B4TEgcOU
         LRBlDqbHVjGUTgCtRYYFFR7JgL5ZB64zw58JQRPHdTw+SSgsGP5QxxPLcfB/r1I99RBC
         e5RmIBYsWlpCLhFbGPjZpnKOO93VvvRjg5Gng2CUuj8uhkrbBKMTaqa1GaCm1ph+hAx5
         Tdi48hiOTR6q2GY+cIL0EaJn5hDWZcr+tsCITV/hCgPBHAtSvCZJFDbmqAvCG/DEPv4n
         YVqetN8pKEJIDckP+aOM9Fp2c7hXLkk9hXbnukWjtL/I4LuAHgj1YrX6DlyPye5Q1mZo
         CDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330231; x=1794935031;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
        b=dcoOQM6+PY9UoPAZyX1ImelIgPVa61cfmLlB+HllEHfHOXLnmAw/hbYGyMsVPWhLGE
         NYNZM9ztxT0LjJUroO43LJ/rxWoYhT2ZgWl6YMwj66jCM8k6PYe3YKWUGq3mj+EF8eYN
         9o+MXk+Ha8sVenNK1HFutzcRQjTfbdJdeh/TDbuUZSUE5YKXvGk2CUqG6DIbvbRvmI7y
         4e0rDKYlxe/UfwYRG1qiI/AY6rYZ9u2CC2qhxI9PcxpcAD7IomOM46SNkyAhp/g7cUU4
         YwYnDUDQ4eKtILcN9zTpYKbh/fVzY5HNauWLcrFkXKTOZh+TWNtFstQ6TXWA75+RqN11
         8oHA==
X-Forwarded-Encrypted: i=1; AL+hErGvfnLOxkpjxUhydtnmX2aHfzQp3rbiQPur4+dPvhnutf4IeOCUySvmOlDNQsh4G/7KqfBKlg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+7n7GWSleMiQuZWbuuAbUR8Azw16cW0KqnSiEpBERyRh8zItOU
	66UrrUidTHJL759xN0EZQa+/USFvm0o+EPYnd4cWaFR0ff/sNpUBRJJMQ7tk5VRM0w==
X-Gm-Gg: AYBFou1xW9ZHE4Q2zro/+8DD4pHG4c+oPKs3lrpBbuYxx7hoMfX1ydAuekAS9Nz0T3f
	kXtvHgUSOi1y3K7csvQO3xI+1Q+IlvbDR6K6nBviKYBYZk/6MDyQ4HaolYYiANj0CH0rT5nfmzs
	eODbWx8j5dvKnDfUNzggi2Qq80I3g38BxEmTlwjmSHtEQG5Q9efg0Jrry9tVkio06GD+HMmmSnv
	/zol96eAmJPlAbGcucPXajbITy0Nzxs8v/xjFITbzdwJQMq9gG6HWqBhWzPgOwWKupNBMrq6TEn
	9aXtUvfB6EdN8UiEtt6TQQGv8DJPapKZ7nbbvAtNKeKhnkmcL6mikThNLfu4OalvYMtk5w0cQNV
	0atkZ/viHwv8zgraLjm24nToXPsplwpeC84F74xc//LTT8sLwEGLQNROGHD1Hhz796GrGAYPXEm
	uwuoR7PqiTCIqys4YS9Rh3LFpRTpj3R3P/8ssq4IbaFl+zPxzEvioQuTzIVsLCJGBW1hJiPEqlS
	2e0S3to6Hrz6mr91c5oGaHt/vTSwuIHBbFYqq4AA+z+GXRyJXT7g5R1jM5h8/yPPJFemuMqiLxr
	me5d69TsTrPSO2mB0n2Yb2U9LpmQkBeBnm91B6/nhhXvrvYp1JTs6m0JIxb1GOzl
X-Received: by 2002:a17:90b:524d:b0:3a6:e901:e79b with SMTP id 98e67ed59e1d1-3b166cc14bamr3213232a91.15.1794330230055;
        Tue, 10 Nov 2026 09:03:50 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm514293a91.14.2026.11.10.09.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:03:48 -0800 (PST)
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
Date: Tue, 10 Nov 2026 17:03:48 +0000
Message-Id: <DMROZB8DPEWD.W2BFC7JIBVZP@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block
 header
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-3-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-3-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> Add an entry_size field to struct kho_block_header_ser. On the outgoing
> side, record bs->entry_size into every block header during allocation.
> During restoration, derive the entry stride directly from the block
> header instead of relying on caller-supplied dimensions. The
> kho_block_set_init() interface remains unchanged. A zero entry size,

Since the entry size now comes from the block headers, incoming block
sets should not take an entry size at all. I pointed this out on the
PCI patch (16/19) as well. As is, every incoming path still calls
kho_block_set_init() with this kernel's (outgoing) entry size, which
kho_block_set_restore() then silently overwrites. That makes the
callers (e.g. pci_flb_retrieve() and the LUO session/file restore
paths) read as if they iterate incoming entries with the outgoing entry
size. kho_block_set_restore() should initialize the block set itself
from the incoming block headers, and the incoming paths should drop the
kho_block_set_init() call.

Please also add an accessor for the entry size, e.g.
kho_block_set_entry_size(). Users of the block set need it to check that
incoming entries are large enough for the fields they read, and that
the fields of a feature are within the entry.

[...]

> + * Each block header also records the size of its entries. A newer kerne=
l may
> + * append fields to an entry, so the kernel that writes a block and the =
kernel
> + * that reads it can use different entry sizes. The reader steps through=
 the
> + * entries with the recorded size, so every entry is found, and it does =
not read
> + * beyond the recorded size of an entry.

KHO blocks can't guarantee the last part. The iterator returns a void *
that the caller casts to its own struct, so it is up to the caller to
not read fields beyond the entry size. Please document that callers must
check the entry size before accessing fields that may not be present.

