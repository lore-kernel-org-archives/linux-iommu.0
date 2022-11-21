Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B963B4
	for <iommu@lists.linux.dev>; Mon, 21 Nov 2022 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1669040565; bh=kLgwWbPGjHzbqAaR5tU5kEsFVB2PXzcJZ+7PhdF+gFc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Un+AbR0AypcNFMoqt6w24nIcmd771HS69hCf7bH2i6gzeh+YwTfUMwVDfVjiOeT9y
	 Ow570Or1fCvZl8wXK2hEQG9m2tKkV3DCD3ZQkChXGhL/dbhL2qjd/kTe2lLvZQ55jK
	 GwQl9/Oc0YEP6MwTxYqUpf451M/x0hvrjJGPtbOyl50gdtPy88yOt6Yo50zzgLvuPP
	 XX1VERWPtEmwOGk03NJD7fl9Ai8YjanuRy3pAXXThvDOMN9lOYB0Z59u5khQrTMrgX
	 kyR4yU6wRGXAGxyk0nRXHKkKopQwXKZGdOL3mwQQ+fxhu8FCmRMHp8UpLFy1HriBNr
	 +gEVuyaloZ0zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.168.19]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwUm-1pDY5J0Ipg-00uK1U; Mon, 21
 Nov 2022 15:22:45 +0100
Message-ID: <fe7d7c8b-ac23-6025-fd7d-12f22b174220@gmx.de>
Date: Mon, 21 Nov 2022 15:22:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: RFC: switch to use the generic remapping dma-allocator
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-parisc@vger.kernel.org, iommu@lists.linux.dev
References: <20221121131623.228727-1-hch@lst.de>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20221121131623.228727-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ODcLNIqhk5u9y7pypM52V6bp3Vc4w57Arm+LC10gmPLaAzIvKPN
 KfLOpvNMRIpi71MkUfY966gEYZs50LcfGbzKq6xNRpvfhEKZbjnLQq3Yg51jnBWEgYNw67L
 l1Pu1lgRNACXZ28lZLwBN6wHTaIK3eTif05gF5LkPLc+lAH4WrC7gUO7zFXxWScsBF2C9Kn
 3oUb06Y71NQfvp8D0whnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:heweo/uRmF0=;7gn2PlAAcVT3sQY1Ml/+aL7UHpa
 MaWKRK6Ajybt671P+USQ1IOMEbjiSMdIdZzoYe+I1AfFKpeuQA/+bkl5o9QZQLbI2vkq5/So9
 lQpnbo7r2j8UPAYz5SJQEGZtt48Gn0C60G81uZhiSYOSjB/7GD1oKdOXX1uOCrny/2JfmeObz
 ETz1DwJtNB5eKPbUyQET9eN94IHcibs8Bb+O7AtqqHGehsBYq7kYEX6AS2MwuXQnv3yIVFs+s
 br4YT+i1cZp8WiF6AX238hauZy7ooRZcy50vdvLI+vL+o0OTBM61nCmCu7X7p2OnD5HGgOLq1
 52PZO+pH3YLzIusz1Zrxm/EtgNrrwFuhAHc7+wUQXwW5HbP6jYklCLRsajNtCRuT/mhR5iRyA
 vMkfM5SfwIjXocNUVnJV3wTtr73epj4CsThSvEfkdbBSgWuClpOz2DzqatvGmqfZvT2PNJ9zz
 P+lj6fXy1v59+9j/Ofg0mJ1AbQV8rvmUgbLOb40pk1iUx0SLXyIplKoAD3LxEt+juuDvarBrQ
 9gZC8Z9uq+KzlxVThLgrQC4YrPlWAacBVFX8cDjSPw1SLNhdiXjA5e2nLdId+bO9g5hUgSiEe
 XP+4aYFInd5PiCyCxeGDcwt1sm5SuZMzqv/N18YrWkMpyVFb+PmOMD4c569CtxR0sZw88rzdf
 VpY9g7M9rP+RsNqPJbvTmAATtnfGgkCgiPEmjMMwIdUy5NUr9lbCMVVDBVsLsl7QIgioD61hx
 eIw9YRJnse4gJc6DWLc9DidJt7CQkwqZ+1w83bvvnXu7nmggO8xJTbVhXSmYgX7xDjkDOQW7L
 J9WzNGfHEZCpxB56hE0DZ/F3ECN4JW7DpJ3PqxlFfsyysY7za5bOGubSe/JaHqu5S83So0Yis
 IdFoJHyIGKmolRMTdZT623u7BgpCRFG8jTJUcun/4EKyoLrvmIYoBSre+641YvUP5jKW3Pj/a
 QV/rhw==

Hi Christoph,

On 11/21/22 14:16, Christoph Hellwig wrote:
> currently parisc has it's own implementation of the dma-coherent
> allocator that sets up PTEs with the uncached bit.  I can't see any
> reason why using vmap to do the same kind of setup shouldn't work.
> This small series shows how that could work, but due to a lack of
> actual parisc hardware it is compile tested only and not only needs
> a careful review but also actual testing on hardware.

Very interesting!
I'll give it a spin on real hardware and will come back with the results..=
.

Thanks!
Helge


> Diffstat:
>   arch/parisc/Kconfig               |    4
>   arch/parisc/include/asm/pgtable.h |    1
>   arch/parisc/kernel/pci-dma.c      |  446 +----------------------------=
---------
>   include/linux/dma-map-ops.h       |    1
>   kernel/dma/Kconfig                |    3
>   kernel/dma/direct.c               |    4
>   6 files changed, 24 insertions(+), 435 deletions(-)

