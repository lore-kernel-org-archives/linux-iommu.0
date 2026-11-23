Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455141;
	b=cDJgj8mHLE+Cr938HWX6QqJALzkElBgtlr/EbATYOMjjpTGqAC98y0UDEoI1Bp14SyHj
	 WoKNwAhf1Rv3ImhXXjMzKzKEr6RWflj/GTlFBSdaI8rVXTjZUX9Urfu5zPJgv9xGCW4I0
	 P/lJmt6nwVHvZFAs40BImWLxx0mor5ZXxDV3v0yzM8ZTKWin6yyncRCdnDoFxEDUarr3A
	 zQGJq6QyQpoVLEBoExuyr87e+3jCP28Eg6lYo11K4UXeBXUH8UrRF0Au8nGXXtbCQQQVf
	 l5U7APrsJFAotDZC0lqiKg+FYlheh9HO4Jj8g16NXaOWEtChoL6RmS7SBZkH51pmy1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=P+l/VRR07HqPbgm9tEPK7SVr6Tlf5vY5XKwCiYVXpnE=;
	b=iFJInDFv0OXBcz6d2HN2RUtQFcvUVYCmnpcbdi2KV7KTNYLn82lrDRDbSgHBnzQ1LNVy
	 9e9hfibaKT3rsIEfLIVWBfGzbkbnhg/4d5Z6rJ60chwPl2h4oVHO0uVwV0srn0PrMAj9W
	 q4aQqi7Aigd6pZ8HvUBTtzv8K8/tmrerdFItrzfSo2CEkIvX3deO1QqgGpJfVytMnIUBf
	 TgIOKfuCBonygPe97Dc0JO1XMOrMpK2ob6lOTt2CTSVKzMXqwrF2tUKoKio6tn3H0ctmy
	 fbJvGhh8AamIPXCG5B7HP5MVTBjgxwWeD98BpweXU0XI3AOjOJaOC3VBpGWwj0RLc3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aIaDX2Za;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415BD606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 17:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 415BD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aIaDX2Za
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f04244c3d0so29819375ad.3
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795455140; x=1796059940; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P+l/VRR07HqPbgm9tEPK7SVr6Tlf5vY5XKwCiYVXpnE=;
        b=aIaDX2Za1UAxDZvHikVowcIZLEDfyZNK/wJ7n0zdBFr1kO5d7UmwabvcI5D71wVcCW
         sWvZMULyDzVN8TdIgZomhhSKXJx++KqyH6Jj/1JtZkLAgrkoJCaFYMZDSISektkDUW6w
         3gefAGclXbeK6SbKVxBZFwNJsb0G7wO8bUW21km4irmig1tZdMtcjE8ar59tb8V/3kvv
         08lEYiD092ntiE7JRaPnc7FGugYqVobsK0EF8snw/jlM8q65+lRJxNOqLCdRyC2LhpfK
         8yblElZVDkQo1+OLk2EqSPKtFapxpJpOSZbisPjGf2aY8kZRMZJ11SONR7TB//xgp1Jv
         2sJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455140; x=1796059940;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+l/VRR07HqPbgm9tEPK7SVr6Tlf5vY5XKwCiYVXpnE=;
        b=MH89vQb1S0ncpgIs2OK68P7e0P7NezxilqCvsXsIkdyso9iANRjXakn0ASQEegLz63
         PlRo6DWad0N5tbnjRL+AzTfABMVuKOe+lm9FDQoWWum+pWwXhaoKg6voU+nWYXIZRgiV
         IJOfMTaBgYg0Ziq3bWUPJFxkn+/YLIxmUP5x9HQegyApyWra3Qk7ZzBnetDSms/+XCE+
         uQL6YHu9Fdf4W4EbD/m9ouWxGKn5VDsqE2SO68SOf3hl0hpYoW2ItJJeh/3Hxj8LvA+Q
         mXYZx0I+JqnVswKIJCWxwYrBKIVdmftgjIv6fUItoJPSQJFjHjD9I65MzUWcwW76WCbP
         Xudw==
X-Forwarded-Encrypted: i=1; AL+hErGejB2TzMlOEHNlcWng/FtbHk0koBiYD7cxz3L89qGst7Um7erbQsAp36mgZn3TKKh2NEF5fQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+LvgkWWwk25qUZCEdXSNmVIRsyCgFKaW7UzdS+lBPxrQITj9Ib
	Tja/HoaYir2ovNr7dyfLqOcAY9nQs80PS/nzQaHp0iqlcbuowBN2JolaHcyvtglvPw==
X-Gm-Gg: AZFdTZd/kZYQBb0lqIqIIa1TE5yRnFQ2S+EiRrpbyknG6vc+omN2maVkPCnjqtJmHsd
	pCGIT9LKPuouXaMbS5koT9zHmsaSGzTTpDOai/nekrjBJplBhYqHpb+uZXd0DijdZHSG+pW8+Oz
	lS3QyZaBNeNttLXUmUJKVEYGVbMdF7gXbj+m8x1MR0zPGiuAwmgkqumtmt52fsUIFaaRH/HzhyL
	iRCUwIZmRj14qw+fmu1VDm24Eoeb4lrznpFR+A22L0yxX/Iy7y6oU8nFAEldO+dqg9h131zOx1e
	j1KwMj6fNaWKD0D4isfNM0fvO/Pdw8Nwc+VJ6JO3vBwxu14n6KGLvXwJSua61eI/2+XPeaPDOzv
	JahBB2XjDXhw+LHQQrX5zN1vfWIsIAN/nypl3XjC3afamvlfTvWEMmkXhMPVSEdSoeHNZdXGiDf
	kb+tAmE0tAZirJx2vzszarySylEVJKqKCXZbquC8ZcN6xM0FMq2rzTR/U/Gx6w74hza7R1p9rVf
	4FP9UtyiIU+dsVApYelX1S5OLWGXIoj1jvDESxPdGZVFYHlsr8PVKni52xDZZUSXt7CsQx5OxKS
	P0SnFs3I4WwZtRnwJHhIQZUJJUwoXn82Vy2gpCxFxKfjAVKruDE4PTzPoFtC+tFd
X-Received: by 2002:a17:902:e807:b0:2ee:1fab:158f with SMTP id d9443c01a7336-2f03f167d4emr115089865ad.43.1795455139780;
        Mon, 23 Nov 2026 09:32:19 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f051a566f7sm45650825ad.41.2026.11.23.09.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 09:32:18 -0800 (PST)
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
Date: Mon, 23 Nov 2026 09:32:17 -0800
Message-Id: <DN2RQ7LGX224.3W3PSQ2PBHTJZ@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "Tarun Sahu"
 <tarunsahu@google.com>
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike Rapoport"
 <rppt@kernel.org>, <robin.murphy@arm.com>, <maz@kernel.org>,
 <will@kernel.org>, "David Matlack" <dmatlack@google.com>, "Alexander Graf"
 <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
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
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
 <2vxzse0rzjdn.fsf@kernel.org>
In-Reply-To: <2vxzse0rzjdn.fsf@kernel.org>

On Mon Nov 23, 2026 at 6:56 AM PST, Pratyush Yadav wrote:
[...]

> When we have all this available, I don't see the point in
> differentiating between optional and required features at the ABI level.
> At the ABI level, all that matters is what the incoming kernel
> understands. If the incoming kernel does not understand a specific
> field, the outgoing kernel should just not use it. There's no point.
> Best case, it gets ignored.

I pretty strongly disagree.

An optional feature is one that the next kernel does not need to
understand to correctly restore the object. A required feature is one
that the next kernel must understand to correctly restore the object.
Optional features can be enabled without any compatibility concerns.
Required features must be enabled carefully (IMO via uAPI) to avoid
breaking Live Update.

I agree it's a good idea for the outgoing kernel to check that the next
kernel supports all of the required features it is using, so the Live
Update can be stopped before the kexec. But that doesn't remove the
need for the distinction. The next kernel still has to decide what to
do when it sees a feature bit it doesn't understand, e.g. because no
spec was provided, the spec was wrong, or we kexec'd into a different
kernel than planned. Without the distinction it can only:

 A. Treat all features as optional, which risks misinterpreting state
    and corrupting memory if the previous kernel did not properly
    validate the next kernel's capabilities.

 B. Treat all features as required, which means no new feature can be
    enabled until every kernel it might Live Update to (including
    rollback targets) understands it, even when those kernels could
    safely ignore it.

Neither of those is a good outcome.

> The semantics of required or optional then become "can I describe this
> object with the capabilities I can use?". If the answer is yes,
> serialization succeeds, if the answer is no, serialization fails. So
> with this, KHO_MAP_F_MULTI_INDEX or KHO_MAP_F_DYN_DEPTH are indeed
> optional. All memfds can be described without these, they just will be
> less efficient.

I think this is a different meaning of "optional". Whether the outgoing
kernel can choose not to use a feature is a decision for the serializer.
Whether the next kernel can safely ignore a feature's data is a property
of the ABI. KHO_MAP_F_MULTI_INDEX is optional in the first sense, but
required in the second: a kernel that doesn't understand it will
misinterpret the map. The header needs to convey the second.

So I see the spec and required bits as complementary: the spec lets the
outgoing kernel avoid features the next kernel doesn't support and fail
before kexec, and required bits let the next kernel fail safely if that
check was skipped or wrong.
