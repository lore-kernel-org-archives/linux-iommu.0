Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.214.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792768361;
	b=FQQuA0TGUsCU8Gf2NL4RJ8b09Mezb2ratypDkFeJcXgKsT7mGFaOZ62ood0b9d4aICVg
	 Q1NfCY+NfJzKw5zGX4b8ubxL1JCc9vdgyURkKEdvP60SdTSn+5CfoTwihpFp4pQ3/3IZw
	 tA2J/5q5goKsjRHORrVK+uk6h0iF/huiyy5+3+wpBxtUxvy96pZgpprZAX8a+siiw40lr
	 /aDOz/KivCxHLwWIrqY4RIbNoVYmJWeK8TrpI+PcZXZ9WC0KF+g1GLX8+UCJzpEFW1noB
	 SGKVv/wYlEtxPsrqRvP9Cls5OLV6P90oj6U11H/Q1KfXygTTCiypAieaV44IEwkcm1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GTBZU2NYoxY52zS87kN5cvRsx8+DZYRk/wDlQGdD9fA=;
	b=DBRCiJX0nQcQkgO0SOuC1S/Arss4++0Dc7neZAqcjc5dRJe1sIr6Cg+4ea9eslzpaspB
	 8iwxfZTtNWnCdr3CkFJGtLC0Ixrxo+v5x0yDhgkx8UOl2jUC0X+v0nIb32RAjpvVZFCzQ
	 9c7cMDJAzgpoEeyjGttxB/SwHw1Vt6QKngaPjKPgaub+kp1FYMrsrUNe1dbQlyn42Fjvm
	 tCwuBk/aVqShvz8+OhAp5w9L0WGwJSTYN/zzpx0+7gKVYFYkQuhxt/HlhUcRy5x14jO7W
	 PAbfohMUk3CVQR/AaZ7vhIhs4T1W+ZtjX9lsnEOvy59a04tZPWdwM9i5Naa7Q9Rn25Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wPcARuvX;
	arc=fail smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB5606A31B
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 15:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACB5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wPcARuvX
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2db33db4de9so74985ad.0
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792768360; cv=none;
        d=google.com; s=arc-20260327;
        b=RHrzXLXiWxHXX9BxvmTNx08S0GcMIub8Jd5GOjmI2ttIRodqiGdPgPi1Dk5Pp3QSTG
         ZFmzJlgqUE5tU/sRp8UxBfpnaG1JFS2Yed3e7hvxnArjWorj8GE3wCQjjwJNpYc0Keds
         e4XWQ69Nusa0QeZS+y4d7cmo4ajwBXBq2aCgYIyzF1qW9tHlS0fqWdUoYviTz5VPZRsH
         OvPzE28oT0Lx2K7go+27umlQwxFITv+0Se8+JSy7YSz0GN0UmyttwR+Q40N96H9S1u5z
         IZflnIKkO0FWuaXv+L9lcB3y3aIP3Yev2pjt/rurJ8An4jWAWOEOGu+46BzpYy97w/2v
         Ss3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GTBZU2NYoxY52zS87kN5cvRsx8+DZYRk/wDlQGdD9fA=;
        fh=B0veIH+dG6HtfTdfzkLALLzoT/C2DJ0wCQAT1f6eYXA=;
        b=IJh4Qj3MYPA3hPrKfYVmhFyGDY85eWPoTO+VKWbCTmdg83g28553Kho3rPcUly+DBe
         wpAeFkiHNF4HFK5zvwLBdBqJ09d5icfYUFB+/Qedaw+2YDe6ddZeSbaKzNq60rYZ2uFC
         A6epIh1T+Z1cA+1T1dBgTgAvPAjXiWaocNTvFPsJxpAJ+K7yyczY6b+Z+g+xIxbnU4zT
         RQeprp0vC5jf9HzMv9I2iDu406LWqLNv8fzuHF9sPAbGn/GLMh6FoTQPDV++bQUcr/dS
         po7+rKiPlEW2gSn1jkBrINZ8Kq4oevekp0u/EFT0nUCzl6MPPD1xMMYgSjaOCSdZegRi
         7qzQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792768360; x=1793373160; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GTBZU2NYoxY52zS87kN5cvRsx8+DZYRk/wDlQGdD9fA=;
        b=wPcARuvXJMuTkGBQkbGyDXRpdJsWIWehT3z9y+lhYS+duvNjrGA4TZbeuLH4aN+Eqv
         PZ5JwDHBRhs0Q37YBwO/2jkik7Clf70lwOnp/ZSvphUKObQwanMYpf9guIgk7NeBSALg
         0qMqWe8+jTQylIwPwXDW17+g7Fup2qWuZRpGawyrgR1spZ18TsfaLAx6xtuhH+v9w77l
         ucv2ysNl7Jfzs9uN0n8akkcRfKdRH0Vw/sDgO9S5L9yqi3NjsLc0cd10l8jxCv8IfYNV
         wSxor2JMR7Nk1Xe6CUFT7OmiSC3FwtVgLcMWDKoOueAkQcG2j3rZswLFBE/P8gRQ8YKx
         LiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768360; x=1793373160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTBZU2NYoxY52zS87kN5cvRsx8+DZYRk/wDlQGdD9fA=;
        b=a+oTqvuczkglzraRcEVoX1xzMBjmGWHrA4u6WEifRQd8iFDQMTYaioOi+cQwR5gZV3
         tsAVmyLy0SSdX32fA/kKW9lGdRI0iLvx8LsEqcPOHR5BaFRyzOlpGFQGbbf/tuLEv+g4
         NgVwG4EhD+u+TQtwk9PuNWX1Cje3dimUCBwUvfv8T2Hb/qTMpanPV0NOLrtZr8UJaPL7
         HcAYdviunb8IOnqX/vO2G0jh4GQV7nNNokcpOXnTmG1JU2jZr9chFJTR8k1l3RyHVCYI
         uOms9M+8qeG2beP1Kyz4GNvxTORHcko9XPrwjt+h+ybRRn5izDNX2tPlPPhIT/fbfLr4
         0Sxw==
X-Forwarded-Encrypted: i=1; AKwUvBwRGUrHlMOnBt2rnirSViSPkFrf1HhlWZLN3hc6el4G5wyknLJ+puFWBBPmY+We7qozY/xZKw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ6STqBR6tSwDArAv7mYsH7Iy0raqeBqKx/AzQJwoKLt1are6Fp
	g2t8t6HLyz7I+hXp2Vjv4xvw6zVd1ao7TxAvm74NX5pRfcwhJDn8ZFmfgpuWD48z6VObY61W5G6
	pQ86UzyvCpEHo/uhrYL7iNLr0oil2+242ml+2cr8v
X-Gm-Gg: AYBFou0VbQj9wIY1e2LOnd6+lhDMuCA9WLFd2Weln2beFV/JyNpbYpbGWDbNbJF95B4
	cypKNEbP6PvhbmTmDe/1+8ZaqKNfVulaMDPr6YOrwTGo8jgl/U7uV1KFekjAT0WCs2IvhvhbQqG
	m+3Q45xgjlY7OaA3NhaMbbZKylijp9Fdud/y/1MWXQnHr+aTW5QLn1X6hWooBTy7aanHQAiCFFT
	Kmkqdx9GDvWFwL+EPloRoHmwZhJP8i495QKP6adHmU15Su2pXKKFXFnPGl89SnnqjEhtHwajlxU
	tlnyhU4M633+Xf1p8pnu9UPfvnAJAEvrFvLmluk4GCFxFmZ/CGll9JGiYHx4FYB1yeTBlIIYLsW
	CClnozIKgv3JAxkTlbMgWqxnL9fK+J6sv5LoSgQ==
X-Received: by 2002:a17:902:e84f:b0:2d0:1aaf:daec with SMTP id
 d9443c01a7336-2ea7f4e1cbemr4092325ad.9.1792768358959; Fri, 23 Oct 2026
 08:12:38 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org> <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
 <20261022201229.GH3381610@ziepe.ca> <CAMOZA0KaanmevmvWS=M3gKfBeborzfCQTiF_xbSeYMWbozG7Mg@mail.gmail.com>
 <20261023140107.GC3977851@ziepe.ca> <CAMOZA0J+MOLv+s4PAvsAK1jbasnbQRyHffZw1VEKutH9Vr6ODw@mail.gmail.com>
 <20261023145023.GH3977851@ziepe.ca>
In-Reply-To: <20261023145023.GH3977851@ziepe.ca>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 23 Oct 2026 17:12:02 +0200
X-Gm-Features: AclHuK9W5A7aXTPFZUdD2jRhpUmEtp7k-vVQ254ZWcJE4ItfG1TCZYdvtBT8nSc
Message-ID: <CAMOZA0JfsviAkojjEewehxMq0r0AboS=L6AWafMj4_Azaeg-ww@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 4:50=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Oct 23, 2026 at 04:30:25PM +0200, Luigi Rizzo wrote:

Just addressing the last part:

> ...The CC stuff seems
> actively dangerous. Unconditionally always using CC shared memory for
> skbs is completely security wrong. What I have traffic flowing inside
> my VM between containers or something? Does this end up putting those
> skbs in shared memory even if they never hit a physical NIC?  Same
> with a TDISP capable NIC, does this unconditionally degrade its
> security?

the current series was RFC and "unconditional"  just to show the concept.

My next version (a trivial change, really) is fully opt-in on a
per-device and per direction basis.

The unencrypted (or pre-mapped) buffers will only be used for traffic
that hits a device that opted in, and only for the directions that were
opted in. So we can finely tune the configuration based on hw capabilities,
threat model and performance requirements.

cheers
luigi
