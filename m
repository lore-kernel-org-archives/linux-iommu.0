Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96B3A451E
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682119; cv=none; b=RvBitmZoPujnKbNPmZCu6f3uaHGeF+1VGbs6DRVWt1Oblwr3BMQiG6BDa1Z05S48ILnVbZ7SBcHs3xn9XTN6fYTRNkHjeCioxL5OelCGAHbIyihVZDiK1Sa2DIeekL6GYdWpU1ZAX5u+La7e3YSJzMtAm+qdN3mOVt+c6oefkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682119; c=relaxed/simple;
	bh=iMApwtVfAiHTe4uNdsg1pmRa4ajqzJGEhdVZ2CWz9x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gp0ejI49YjJrMASes8s929OnPLaSk/nr4qn1Y0PK7TCG2cJaNeP5s2vWRZQTKUve89PaYRpupI5GkixMCN6ENSmdW68lrEYDePrUArB2evmz2xRGLnijeVp33JJ+w+Avbbp4oMslIECTcQCY+XM3cexr24niC68qKpmLXbCyRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNItWfEc; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNItWfEc"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-381191ea2adso510421a91.1
        for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 04:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783682118; x=1784286918; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMApwtVfAiHTe4uNdsg1pmRa4ajqzJGEhdVZ2CWz9x4=;
        b=cNItWfEcsFG7sIq3NFWTvSg0Ud1TwzxuAqzDkQ1GNNirgoE/344NpaERoJbt7Q99Rv
         aPTXK35ih2CZXyrbljy/CoX3g2aNR2q+WdAGyiW8xArbsfifc5mge7MPW9vUCO67EPfn
         UK8WkjzlnnXENeS7vDa73PL7Of69/A0QZ9v4mQzbpM50OR0U2FwCRQ3a3y6oMScESsSL
         J5I77VZpCbSvZOagfNw/kuxA35T8KSUMUxCp0kkqNa122lUMD6L+tqa+aYrFZ8dlRwWk
         Qvt+ohb92Z82LlnYgCqoo8lOh185j6XikFPiuvTKyZMHKjmTtfsCkpqr/IoKpw/a5b/d
         HMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682118; x=1784286918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iMApwtVfAiHTe4uNdsg1pmRa4ajqzJGEhdVZ2CWz9x4=;
        b=cKBbsHDXEzULDbu8rVuxWA+eW63onQ8nyZ9Ro8EedO9sPcjqcaf+HkfZpaehHCuw20
         HqMU98c+L0O3TH/7Sko0vAixuKTRCNYXAn63jzwCwDB2T607LNbkJ9CCVLVOIDjutTNb
         Tj6DQ4K+v1Z/g2qgKOjdaeam8I7IuI6TRKUWpUlvPNTh+9snORw1S9wtZc5rUBwW9fOW
         om1aVA+uXgoToSAJQN9omwgHOWzj8swl7QZTyk1Kyv2u1UBHK7EGQ6OMc1qQQrYTn2nI
         GFrHGV2XLBXQ63uD5zV6uNXBUqkCkEfH+YLG3jwJRPqZzVJidOFolyaARDkOLtaSN6bJ
         gI5A==
X-Forwarded-Encrypted: i=1; AHgh+RpkzUue96RLh5TNgLTdf0YV8cm7niq9ytPK6fnKBJBp+iCsuuKfrCHm/Hw5jTK1F5vCZ/2qWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAK5e3OnUHVkEdZR6ndOUfiLULPak5z37rfOkA1agescXx1FIY
	g8eySyVqzOz6TDpXh5hbHkj2bazv5vESR94yNyY70uTnTNSSk57B+EvQ
X-Gm-Gg: AfdE7cmaABhPn0Fnh0Wpmr/7gZlNrR6QvIKru3+RRPAVehMl8mAI2USBpxlUr5I8KKG
	4tYv6izsfCBeJSJIkLIgTZM1v0dlaa4xJZD3ZoGjzb6c9XQZqyygx6ZLjFMoPRJrA5XVVGgE2QO
	gowDy9JkA9I5hRjYHZXXdYYqJT/U8IvNpwwgf/KmwGOM1/yGy49KJ/eKjz+ymbmtgvojaXw8zLd
	y8WHD073t1oA5kzBxud9clbpER5XKeUO7oG7UxPkGu9y3UVNMuk/Z5zrhHDgNAHaIUPv6qZcl8O
	c0Dy2JTXBLKbzrgHr1iyElH+FmD7cKs+i7q7jpPK8dJ7LMCFY5gJeMSfEQe4ZN9ly1U9VzjaCaY
	g2j9IaC3kp3VuCGNBV3JZb7DetFD/uRN0vqyG2Y/4ZGj4mv3CC2eCOOwHlWP8RPKzXgIVpq+Dvz
	bwWQI7AJEHSuSuntG82souc9oK/k8yo4FKbXvZE4ktYKtbZSdPC1uAP7ME02Sy3aJi2SW1mKE=
X-Received: by 2002:a17:90b:37cc:b0:387:e0cb:7f5 with SMTP id 98e67ed59e1d1-3894298482bmr11227568a91.41.1783682117496;
        Fri, 10 Jul 2026 04:15:17 -0700 (PDT)
Received: from ubuntu-gnu-linux-24-04-3.hub ([2407:7000:af23:3e00:eb86:437c:263f:195f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5622ae99sm2576177a91.14.2026.07.10.04.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:15:16 -0700 (PDT)
From: Jiaxing Hu <huhuvmb88@gmail.com>
To: Will Deacon <will@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/rockchip: implement .flush_iotlb_all
Date: Fri, 10 Jul 2026 23:15:08 +1200
Message-ID: <20260710111508.917486-1-huhuvmb88@gmail.com>
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

On Fri, 10 Jul 2026, Will Deacon wrote:
> So I think this is the wrong direction. We should try harder to remove
> the function rather than add new implementations of it. I'm assuming
> you're only adding it for some out-of-tree code that calls it?

Yes, that's right. The only caller is the out-of-tree RK3576 NPU
(accel/rocket) bring-up I mentioned in the commit message. There's no
in-tree rk_iommu user, since the in-tree consumers all invalidate through
.unmap and none of them call iommu_flush_iotlb_all().

So if the plan is to remove the function rather than add new
implementations of it, then I've got this backwards. Please drop the
patch. If the NPU driver ever goes upstream I'll make it stop relying on
iommu_flush_iotlb_all() rather than bring this one back.

Thanks for taking a look, and for the pointers to those two commits.

Jiaxing
