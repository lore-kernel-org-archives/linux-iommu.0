Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9693B14C2
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718594; cv=none; b=fwIhcnUdKu8Vv+ggVP2D8f2fxWAFY9J0Abn8R5AGQT6iOKbuwc/Kbx0K+eLPBY2yp8OVhbG3Yr2Qdl0L5ygJ67rXiz/9obAr9FVFiJ8VKdkdS8ZE4u8BSIHacrPhV4joTIb9d7c/g/fPjUFDrNnGRhKNlH7CarFzQ0IaE1K0ybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718594; c=relaxed/simple;
	bh=dXLOLr+OICkYPnxLiSyxM595gWsgKFLmoYsaM3It1+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXo2CbACISAIyVdnoKjsKGxe+fNbyD8CK5HDeOXG50YEuPVuIl7xU/YuYF+xZySQLO0KEph/R40olum56t993P775ahc7b3l1Q7xAwm/Jc4BKdj3xzR1t+7vrglDqSzDEueKazCjyEPMw98nMnKDiwqOvMVACwFKms0QGKWy090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7tLMSz4; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7tLMSz4"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cad1448ddcso10634585ad.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 14:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718592; x=1784323392; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXLOLr+OICkYPnxLiSyxM595gWsgKFLmoYsaM3It1+g=;
        b=o7tLMSz45Z9Gi5I8QCC/Udca0wUS/CdhyvgDQhx9Gvhael/LGiAudgQWllBc326VLu
         X816jz7YuG6lMYXIaqsLdGmJIFdTbxBRkehjkPfpqGNLqCnBCTGwOGIrHSdbyj8Odt7N
         KJMx9pA2Tc5e2yk+a40OUH51rgi53K+JwW8JQwam8TO+aflBvQ1DCmnM4+cYrR0vzTnw
         hjETJzYqOEOjYRYBVWdg8DcWBS9NimOqIUhgo+eNnzrwtxcgVM5DupgRWq5HFPZFDA8f
         8DuKY7x4sGhx8MTULIUSCTOvFL9iJLh+9TsYiDBd6lNM9p4PFw+0IS+Yeql3Cg/Pc2uv
         NYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718592; x=1784323392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dXLOLr+OICkYPnxLiSyxM595gWsgKFLmoYsaM3It1+g=;
        b=SXCNnwWTljZjq6A+y1cvD9AsLZU6sF1n2WLLKJqy1YNVjv2KyhPKjx3FWbkjneyAEM
         O5BAKWQshylZ64M4orWih40hNivFEiIqyAJMX44w2VL6vY9knqGqsOD/77TAbjG/Ljrv
         sYC+Nw3p/Ldvyyznj0D9Ej4g+bE+yCFag7a9ZgCkK4nDT0i5Gf4Klp5Z/Q++sfCKrUlb
         nYcwByQgsBYydLFciCAwm3nKAI8OjE/k/iagqvlLb+AER27D4WucjSDXYibtrXpiEyWy
         LYYTJM4uWmVIExbZNSR10VRwSUtKZILExpkPiKw9pAohdRn8wnYzxPprTuZC1rBKVWOe
         2CbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8Hkqwn/gCVw3NTimjuGO9iLohT6ODo467by2TZiO3tGtwt/WdkrqgcUMJGXxuGPGyGkU5Og==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTozSl3s1zfn2cbA55E2PBUicrrI/3wL1AL8ePGbaqnSVQpllb
	FJvny0sHSKc/6pSD4u15FKQzLw9/ylVYWo2wCeCRKl6WsWvTrinZ9AGG
X-Gm-Gg: AfdE7clJEQY2QNrHthqew4XDqcy7IUnGoIqqDj2aZJLT/y6A0qjOtIo1jcG68jr5P4d
	0iml608F5YDJXyfPV46wity7n6rYIEX3yZ+WSyua5d5EdA0QEKqJC2hWQerxhQKIhvhr/md+gP5
	4PM8h/yOubGag8UQk2kulNLYxMujVb1UUe0rB5nGJV9HxjVWPPzhInQUMC/CvysJrNzNsLleaqe
	NFKpf2S7sXieV8gPj8FN/7YAoVPT5nTZ4Izy/NWefeNyL9NjECZLrZPj64eY1duDsiksvE1HfSE
	ofedm568H7RKwXxaXsIer2TMLRdcHFETtyfakgi7nDyr7LybYl3wNQNN12UolkMxar8AffjMZ38
	OFAnJoPbf3HWO+p+MB/Medtz3/kWQN+yfQnOKICr1Nf+R1OcxTq3/rvtETj1s+jQEC0sR9BTu25
	iq0wvxcXAfoe8l23p0llRYEB3naMdhk6FL37c3N6ikK31jC6mJ0vRTrACX2NaQbFKXNn9dQdM=
X-Received: by 2002:a17:902:e844:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2ce9e795bfemr7461565ad.1.1783718592223;
        Fri, 10 Jul 2026 14:23:12 -0700 (PDT)
Received: from ubuntu-gnu-linux-24-04-3.hub ([2407:7000:af23:3e00:f127:785b:6e87:f831])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d2efsm65044975ad.64.2026.07.10.14.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:23:11 -0700 (PDT)
From: Jiaxing Hu <huhuvmb88@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/rockchip: implement .flush_iotlb_all
Date: Sat, 11 Jul 2026 09:23:04 +1200
Message-ID: <20260710212304.11958-1-huhuvmb88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710060513.863714-1-huhuvmb88@gmail.com>
References: <20260710060513.863714-1-huhuvmb88@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 11 Jul 2026, Robin Murphy wrote:
> there's no harm in drivers implementing it *if* they also implement the
> relevant optimisations to avoid synchronous flushing in unmap_pages to
> make CAP_DEFERRED_FLUSH worthwhile.

Understood, thanks. I will drop the standalone patch. If I come back to
rk_iommu it will be the full version: move invalidation out of unmap_pages
into an iotlb_sync/gather path and advertise CAP_DEFERRED_FLUSH with
numbers, rather than flush_iotlb_all on its own.

Thanks,
Jiaxing
