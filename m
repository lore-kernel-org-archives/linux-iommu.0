Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04227E1D0;
	Wed, 20 Aug 2025 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728296; cv=none; b=VESI3n7HlZvdY+g34qDnKeBt6tdUghyrtEog6AsVAsllHPXDqhOvT92ykC+dos+BkLO2dh3bT6HokhXv7ARMDlqUy2/AJjtr1Imwz1pOP04Am15JmiwQpTNB25+U+XnMTbGiRmyyv20ODUeSdamTlenf/a9shKafzceNx6lfZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728296; c=relaxed/simple;
	bh=/JY0iqrp4JSe7nyCZ7qTFtuYchueOQZRK2oCJASh9jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewE6F+LX7ENutcEJS3kiQaLSO1wbTFhe8RBaVVeucZKGmcVA4AuxnxRgUNZctOXxYeStpVzhFp+x6HIsKUOIl4P36C/NpmOufDHRZIFn7VnNI5S0MSW8P3J0IYJTv4NRJuhD2yLVdY8sfEoL/HUB3P16496SQZ0/2Nj5O8xN2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTfP7tgN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTfP7tgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D540C4CEE7;
	Wed, 20 Aug 2025 22:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728296;
	bh=/JY0iqrp4JSe7nyCZ7qTFtuYchueOQZRK2oCJASh9jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTfP7tgNNAP8bsZydX8VBSDKuM65d5RZP+Iy/o8rQIXB+6ff+6A3oxKAo7SV2WUhO
	 Rv0yhlu4Pwr4auKLXw3xrIU0TwPgazkTmKPJgRO+vZ6o/bIThAXoylOqfipxn8mYlA
	 RXOWfcTfrKttn/5yb8TQMNllxa3pxkkRSZjuNt/sT+UGLyNcclUd30VklOjZTHOGhU
	 GQEMiIFf0PgnSiGPnloPDPhCrZlfcCI81BxzQbY050J/nocZgM/BUSENAO1Mdo6pQ1
	 R1UbpoPV3UjcpFL/UeUDgSkDUDGGRJDp7vHyHF6KhxEPtAp7BhQVlQsjG5v+h1HJwm
	 HG1gM6rgmCWfw==
Date: Wed, 20 Aug 2025 17:18:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org, Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>, Hector Martin <marcan@marcan.st>,
	Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
	linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>,
	Sven Peter <sven@kernel.org>, iommu@lists.linux.dev,
	Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/9] dt-bindings: mailbox: apple,mailbox: Add ASC
 mailboxes on Apple A11 and T2
Message-ID: <175572829424.1511541.14649448626507633958.robh@kernel.org>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-1-65648cd189e0@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818-t8015-nvme-v2-1-65648cd189e0@gmail.com>


On Mon, 18 Aug 2025 16:42:54 +0800, Nick Chan wrote:
> Add bindings for ASC mailboxes as found on Apple A11 and T2 SoCs. These
> mailboxes are used for coprocessors including Secure Enclave Processor
> (SEP), the NVMe coprocessor and the system management controller.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

