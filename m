Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E24428
	for <iommu@lists.linux.dev>; Tue,  9 Aug 2022 13:53:20 +0000 (UTC)
Received: from notapiano (unknown [193.27.14.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 31A1C6601C45;
	Tue,  9 Aug 2022 14:53:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1660053198;
	bh=R+CpuZN1Sl+R1CObLrG1wLITHiTzHmjmpta/SIREkdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjuY2JQzbM0PFwmAXUkG2NewMPwh5uPBzPQkoYv8b+NViFKYoRaSGYgXA6YSAWYna
	 qSBCjU78IGhJ0uGfuZn1Dm3GK3sBSeTGvJn1h4XdjaUwFgk2W+FEOhGkRDDJFRzjOJ
	 h6KRVfb+d4ZURdxwDr4dcpUa4or57PdiFRkAIwdaxAEEn9Px2t9oVIl/E5wlAs04f8
	 X9cns2SgL1slzGdaZ5yS6uInTQxTVkc37bwEle4BoVpSUOeSYyFPhU4OJDaxvVrrlC
	 7CWGQFRiCPv/rrgLzG7f46/tSSyyk5QXckkaePiEdtklThsMY+ItVw04TaYHAG3H3X
	 XVOk1qLihA2aA==
Date: Tue, 9 Aug 2022 09:53:12 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Tinghan Shen <tinghan.shen@mediatek.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v5 02/20] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
Message-ID: <20220809135312.hadcs7ti2cgyyuez@notapiano>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
 <20220804021553.14867-3-tinghan.shen@mediatek.com>
 <96e66425-ff2a-4640-8b96-48fa39943bf9@linaro.org>
 <6a1977971317059fcfad685869b6ccf233edcb68.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a1977971317059fcfad685869b6ccf233edcb68.camel@mediatek.com>

On Tue, Aug 09, 2022 at 07:01:10PM +0800, Tinghan Shen wrote:
> Hi Krzysztof,
> 
> On Thu, 2022-08-04 at 17:12 +0200, Krzysztof Kozlowski wrote:
> > On 04/08/2022 04:15, Tinghan Shen wrote:
> > > 
> > > It's because the 'mediatek,mt8195-smi-sub-common' compatible incorrectly
> > > matches the 'else' conditions for gen2 HW without gals.
> > > 
> > > Rewrite the 'else' condition to specifically identify the compatibles
> > > that utilizing gen2 HW without gals.
> > > 
> > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > Reviewed-by: AngeloGioacchino Del Regno
> > >  <angelogioacchino.delregno@collabora.com>
> > 
> > Unfortunately, your patches got corrupted.
> > 
> > 
> > Best regards,
> > Krzysztof
> 
> Do you mean rebase to the latest linux-next?
> I'll rebase in the next version, thanks!

Hi TingHan,

the issue is that some line wrapping happened on your patches, which broke tags
and also the diffs themselves (it's very obvious on patch 3). So you need to
sort out your setup so that no longer happens, and resend the patch.

Thanks,
Nícolas
