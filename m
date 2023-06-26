Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FCEA93A
	for <iommu@lists.linux.dev>; Mon, 26 Jun 2023 14:08:51 +0000 (UTC)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QqTsN1bTkz9xFrP
	for <iommu@lists.linux.dev>; Mon, 26 Jun 2023 21:56:24 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCnC+fjm5lkLhG+Aw--.37910S2;
	Mon, 26 Jun 2023 15:08:42 +0100 (CET)
Message-ID: <de78e57f7d7ee163f1efdcd1f470eb5ba5e8a060.camel@huaweicloud.com>
Subject: Re: [PATCH v1 0/2] swiotlb: Fix a couple of bugs in sizing areas
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Petr Tesarik <petrtesarik@huaweicloud.com>, Christoph Hellwig
 <hch@lst.de>,  Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
Date: Mon, 26 Jun 2023 16:08:30 +0200
In-Reply-To: <cover.1687784289.git.petr.tesarik.ext@huawei.com>
References: <cover.1687784289.git.petr.tesarik.ext@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCnC+fjm5lkLhG+Aw--.37910S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1kKw4DJw4ktFWDZryUGFg_yoWxurb_ua
	4vyr98ArZ8JFs3ZF93GF47C3y09r4xAF1Yqasrt3y3JryUXF95XF1kWFsYqr1kWr4xuryY
	yrn8ArWrtr1fKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
	IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABF1jj4tm5gAAs8
X-CFilter-Loop: Reflected

On Mon, 2023-06-26 at 15:01 +0200, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
>=20
> While reworking the dynamic SWIOTLB implementation, I ran into some
> locking issues with the current implementation. I believe the bugs
> are serious enough to be fixed separately.

Thanks, excellent work!

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

> Petr Tesarik (2):
>   swiotlb: Always set the number of areas before allocating the pool
>   swiotlb: Reduce the number of areas to match actual memory pool size
>=20
>  kernel/dma/swiotlb.c | 46 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>=20

