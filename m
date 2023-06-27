Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA113064
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 17:18:35 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id CAE6D8C3F3;
	Tue, 27 Jun 2023 19:18:27 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1687886308; bh=6gFDNhhGJv90UdgxcbzryDH6ZG6dLvIYFXDAuTPtvSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bySKOQZltr9ohomUzM2aa5V74hK2GS3Z0zDb44uDmzzs/QvDRuAyvfkpp/sqmUsbo
	 TYNOTc/GZ87znxp5/6S40uTgA1tFep572/XZFIr4a0dvnpFyyemllCPFmTL8ejWTBR
	 jtihWMAS44zGXF3GRLhcBphwoEtpIHavdX+JxLcjBcAgrze60nJp9hzy2wm/xMLv2W
	 f3DxfaFhc3IY3NIsJPaGj3Z1shXXSEaD9AOnCOuEnsKIDh9ZxDEfwP+mpg5g+evpr2
	 SvnstvX48os/E5D1n8oEawxiBdrFV1sIno0QU0c2fjDy6lmqnnEG5s2xs8if27cr6c
	 HuelAtwFx36+A==
Date: Tue, 27 Jun 2023 19:18:26 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: unexport swiotlb_active v2
Message-ID: <20230627191826.41aba02e@meshulam.tesarici.cz>
In-Reply-To: <20230619091941.GA17034@lst.de>
References: <20230612142542.111581-1-hch@lst.de>
	<20230619091941.GA17034@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jun 2023 11:19:41 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Any comments?  I'd really like to finish this off this merge window..

Let me second this request. My dynamic SWIOTLB patch series also has a
dependence on this.

Petr T
