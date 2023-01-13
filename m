Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEF02F2A;
	Fri, 13 Jan 2023 15:35:22 +0000 (UTC)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E886A261BE3;
	Fri, 13 Jan 2023 16:35:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673624121;
	bh=HQll+dtETcToYPK0AFX1WAMkvWIdTPoYlWHDFOoqErY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIoRgGoPLXf3TmS73/3zYA9xxsm8n6zU03O0tcCLrwrIlW9fsgXJSA59NGVMyjjl9
	 Vt7HlxkXoDiMQOgujailfp2yQE6XmxyZcywA2Ot+jv6zJvvfwLDWBZQ9BGxVg9uKKB
	 Pmh7OeXCRnLW2Q70jzms5n5Z9iLDG6Ys0CQA4CCGi0prMTnB7voo7RGh7hLtQ/CAdJ
	 UYGsKCM05h35y3F8UG9GVpo3qI5B7qYj5l/DeeZ0WlkBH3kguQLeOkO0vuaI96iYin
	 9EMUcVFg6F4vBcbpCk2z12HbKwcj5+ShaSIga0eAwfIGfYA2T+3JDARww6iRBNwZ+i
	 7aFT92K2O/RYw==
Date: Fri, 13 Jan 2023 16:35:19 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Samuel Holland <samuel@sholland.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 6/6] riscv: dts: allwinner: d1: Add the IOMMU node
Message-ID: <Y8F6NxYpJELbvogC@8bytes.org>
References: <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-7-samuel@sholland.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103010903.11181-7-samuel@sholland.org>

On Mon, Jan 02, 2023 at 07:09:03PM -0600, Samuel Holland wrote:
>  arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 10 ++++++++++

This file does not exist in v6.2-rc3, what tree ist this patch-set based
on?

Regards,

	Joerg

