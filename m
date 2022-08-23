Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093AB323E
	for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 17:51:53 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id n28so3998276vkm.5
        for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Es/SKRV3OFmw44FXdjOkfiW1qF34GTyugA5yXeHJg1o=;
        b=Htyr6zgvLeb7VOm7M8YiX0MsuKqOQFg/1Dp9MRFHsmMgRGKEd9WwyKRrcHeLFHDm29
         nM/bfzgL5k3eFrWzgPUgctn35VeUeDiJtJePnx7M8C0hWVKT2REkwMdmxOUxw1i9Lfw/
         CbaaQ7uMsAT/X0Ph7VPdpGckzFqaPwgU378K5NGCsUHDagyqlzkGONXRTiXCOcBGYWCI
         q+YsgKQhl5xhXQB8Pc+6yWmSx4zaOylSieaKP7lpCxr22IPB5+DWeJotUqS+aEZLUsRo
         lVTqqaXDT5t9QEmcI+bIRPwSAPgzInt39jLGTIsGH1dQuSP7u56N7t5qOqn2Fr4w4b5y
         /Ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Es/SKRV3OFmw44FXdjOkfiW1qF34GTyugA5yXeHJg1o=;
        b=8F3ueLoPAVPkAoar04br0C781WPuHakFIQzR6+GVPnZNvLbgOq10DD518vkrAUN6xB
         wFeGC2FT9PrjVSmsccCKjN+FgJN+3rOp6DfKdm7Ate5+t80/rooM+HCXEpRQaiQqaiLa
         0OA1nu4wUrh8MzFfFXKCV5OBWVynH3T65nljVSRFGwdz1BgXLkDmhAiOPwGN8r15IEPy
         huGblKVQ2c6P5PUYPTO+xYWcYwaz9Qx0AoSFrQ2fRDElx7NZ4ZKzGUIWNl4qibmxZ7Ex
         Vqvdp0nV/c+mM5HRxNC2p+E8PMEcuFg6TRQGWNuy6hKXJhH/obrgbxox+5aJtDzcXbNE
         smsA==
X-Gm-Message-State: ACgBeo0Elp4Y3l6vsLanKyctT5rPTaQs2UVJNmevjr/MF02p0YlgdZ5P
	nieTX0o3RRgm/E0g7t4CJyNYPJvHagR0ySh2lUvHnw==
X-Google-Smtp-Source: AA6agR5LT5c2oH4HlSHea9+vMd6hW5j0wL9NLrJYmoLqS7f6O+74rga8DGg+9ywWJM7NvmxoN1meBCLo0cewOr+i/3A=
X-Received: by 2002:a1f:9b07:0:b0:378:7c48:c6c with SMTP id
 d7-20020a1f9b07000000b003787c480c6cmr9890448vke.32.1661277112758; Tue, 23 Aug
 2022 10:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220823080118.128342613@linuxfoundation.org> <20220823080131.532813281@linuxfoundation.org>
 <c49d3b2b-9f5a-4257-9085-f7ac107cff40@oracle.com>
In-Reply-To: <c49d3b2b-9f5a-4257-9085-f7ac107cff40@oracle.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 23 Aug 2022 11:51:16 -0600
Message-ID: <CAOUHufagA1x4jyjH9Q0RX65fwF3SyYHUTkNnB0S_t-2GqbiC2A@mail.gmail.com>
Subject: Re: [PATCH 5.19 319/365] swiotlb: panic if nslabs is too small
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>, 
	Robin Murphy <robin.murphy@arm.com>, stable <stable@vger.kernel.org>, 
	Sasha Levin <sashal@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 23, 2022 at 11:25 AM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>
> Adding Robin, Yu and swiotlb list.

Thanks.

> There is an on-going discussion whether to revert this patch, because it breaks
> a corner case in MIPS

I wouldn't call it a corner case. Cavium Octeon is the major platform
we use to test Debian MIPS ports [1], and 4 out of 5 best-selling
Wi-Fi routers are MIPS-based [2].

[1] https://wiki.debian.org/MIPSPort
[2] https://www.amazon.com/bestsellers/pc/300189

> when many kernel CONFIGs are not enabled (related to PCI
> and device). As a result, MIPS pre-allocates only PAGE_SIZE buffer as swiotlb.
>
> https://lore.kernel.org/all/20220820012031.1285979-1-yuzhao@google.com/
>
> However, the core idea of the patch is to panic on purpose if the swiotlb is
> configured with <1MB memory, in order to sync with the remap failure handler in
> swiotlb_init_remap().
>
> Therefore, I am waiting for suggestion from Christoph whether (1) to revert this
> patch, or (2) enforce the restriction to disallow <1MB allocation.

There are other archs (arm, ppc, riscv, s390, etc.) that call
swiotlb_init(). Have you verified them all?
