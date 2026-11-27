Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781703;
	b=k+StfFfwnaS6iiXCh99iLcYEhJWfk1SyT5cbX0ryYiDJIyLwxXA+dIqtfC9g3kjr5TC6
	 +4ErIZZ8D/IGCt5dwDGCEnP53Fktvehc/aXJf7m4ObebMwjQRAZTmwUnKm2Sj5hdmhfvy
	 eQpVQG8jaur/vi8wYOgrlWMboo7Q5LOoTZs/rqEjjIeQHORahFQzvwkWv6PTGWNYlfw0U
	 JiYau0Zl537jOeNR9o4c1vQAn8WnwMrUI2n4vYZJ+KxjqR816sK9vpF+MlR30wb5c6WgR
	 2aCSF7dsUZfKj4RKbYp+d0kgqmqhld8sO+EHedUxQsD0s/ke8a48U20S0HRE1obUUUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781703;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iM54K9orOriSVeFYm8Tg3Py4IYE5anR7lg79PbJmHes=;
	b=AOCbNrKl04gTT2wCtrZCD1l8xLJkKHY/esFhB2RYFtnq8R3suzAElAhy148POIDPXcxm
	 8bve0y1APX61d2JsZVhDtJOqkICjAqXpyOzy2+wS7okjabTJT1O80oraB2oowFNTQe69d
	 gQTPc+TjfX2mWeXTkpxf1nTxlqoBlfPmuBjoIjN4mRiMEcM/lJnLeUGP3/zeBGV3q55kx
	 bHvIms4HegFBNHsYa42My2BPcEL9j4ccp+XSgr/7au8goYQo6W3GovQGmoxwXDnhzHpD+
	 ouFE3uSx01dpq9o3a70qDqW0NzEH72OM0KLzpMFjrf2wr1PHDmGMmO37F/GkVn8ZJVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtt1283S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D3606A323;
	Fri, 27 Nov 2026 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtt1283S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B0A1F00919;
	Fri, 27 Nov 2026 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795781703;
	bh=iM54K9orOriSVeFYm8Tg3Py4IYE5anR7lg79PbJmHes=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dtt1283SmVlMJDALB8+fBXMf9DpoJ/7duRnkVxmjg9BRCMUmL36GBysLxMuEUnc6L
	 NW05HR0AteyNXiALdjX0kNEoQS1iGQV3dNU2074CQ6xn5Qy/KAuuQKK7ZgL/v0zglo
	 aQnlcYatWQ/16jLUmzBmCzBq16QBDXkb07IHKc9bPo48Pmn5HEWsuSw3yDu8lDQh15
	 4vVAQNpU+4801ZTfCfRhqVwKEc6VoUKRlrZfCLY1/mdxwi5sjFq5uqSTfpq/rI+j2h
	 t1BrO1KSr6StxWy2CHoeWL3nUFdig+6cQvltOqpUS/feBqaZmViFLklXQ+sMzB/znc
	 Ti308wFpeHxyQ==
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 8/8] optee: Add support for lendable-dma-pool
From: Sumit Garg <sumit.garg@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, 
 akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, 
 ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, 
 ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, 
 danielmentz@google.com, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261111110738.872947-9-vdonnefort@google.com>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-9-vdonnefort@google.com>
Date: Fri, 27 Nov 2026 17:44:23 +0530
Message-Id: <179578166371.172025.1170602724631713692.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=469; i=sumit.garg@kernel.org;
 h=from:subject:message-id; bh=Y+fnpb+6sgyx/TICAWkXBLbJdNddcf3dmWbm5GHNfSA=;
 b=owGbwMvMwCV2RWpxpe9rmzmMp9WSGLI5S3Stv366/n7plf8Ot9/EukWzz7haXJDOvVWsU4v9/
 t/qn+eWdZSyMIhxMciKKbKkfv02bZvQv9pQqxM8MHNYmUCGMHBxCsBENjcy/JWrfuZ8cN60h88P
 3OLZJalc9e5m+ebZ/w/xd75snDkhw3oaw1/RFY9W6+5S/7WJ+YNH/jKlWJfFzIsSbMtevzAJ+Ln
 f1o8ZAA==
X-Developer-Key: i=sumit.garg@kernel.org; a=openpgp;
 fpr=65F5F696B612FE7D553AC80CD41AA3794DEB3C9C

> When memory is lent to secure world, fatal CPU speculative reads can
> still occur while it retains a cacheable mapping. Use the
> lendable-dma-pool API to unmap pages before lending and restore them
> upon reclaim.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Thanks for all the rework, the OP-TEE changes looks good to me. FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

-- 
Sumit Garg <sumit.garg@kernel.org>
