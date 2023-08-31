Received: from ustc.edu.cn (smtp2.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7669470
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:Date:Message-Id:To:Cc:
	Subject:From:In-Reply-To:References:Mime-Version:Content-Type:
	Content-Transfer-Encoding; bh=Qq8Or05Z3wupAqn+SJQ9X4Kn3q8NHmmiK9
	CjrR91gH8=; b=rgNp4kUdq4N0sUNapWTMToG9TbDrP77a8Hpgu57vGuNfKyMiP1
	8UE6FVBe/3VgjwN+7AO2kUklAJHRi9vTy6vulgNSf0Plf2aTGMQp7YwNVzF5fWC/
	w2/M0ttER885IWy9VUeiXbk5u0QPEj0oD0ZU/raEa4UrAvNtdN7rrHDxQ=
Received: from localhost (unknown [101.88.124.132])
	by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDn7xshg_Bk8vSlAQ--.5239S2;
	Thu, 31 Aug 2023 20:10:09 +0800 (CST)
Date: Thu, 31 Aug 2023 12:10:11 +0000 (UTC)
Message-Id: <20230831.121011.290302981294821287.hchunhui@mail.ustc.edu.cn>
To: hch@lst.de
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-pool: remove a __maybe_unused label in
 atomic_pool_expand
From: Chunhui He <hchunhui@mail.ustc.edu.cn>
In-Reply-To: <20230830092804.148776-1-hch@lst.de>
References: <20230830092804.148776-1-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 28.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LkAmygDn7xshg_Bk8vSlAQ--.5239S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtry8urW8GryUXF1DAryfCrg_yoWfXrb_J3
	43Gw1fuFs8XFs7Z3WUCws3Xrn5Ka4DWrZ3ua17JFWYkFyDJrZIqFn7Jws5WryDJw47GFWU
	CasrurWDKr1aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbw8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jn3ktUUUUU=
X-CM-SenderInfo: pkfk30xkxlqzxdloh3xvwfhvlgxou0/


On Wed, 30 Aug 2023 11:28:04 +0200, Christoph Hellwig <hch@lst.de> wrote:
> Move the #endif a line so that free_page label is only seen by the
> compile pass when actually used.

Reviewed-by: Chunhui He <hchunhui@mail.ustc.edu.cn>

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/pool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 1acec2e228273f..b481c48a31a630 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -135,9 +135,9 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  remove_mapping:
>  #ifdef CONFIG_DMA_DIRECT_REMAP
>  	dma_common_free_remap(addr, pool_size);
> -#endif
> -free_page: __maybe_unused
> +free_page:
>  	__free_pages(page, order);
> +#endif
>  out:
>  	return ret;
>  }
> -- 
> 2.39.2
> 

