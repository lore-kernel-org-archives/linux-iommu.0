From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix unity mapping initialization race
Date: Mon, 11 Jul 2016 18:05:51 +0800
Message-ID: <CAKT61h9=yCdgsEXh3MQgtoyPb_Jzmpv2L_k-8gxHfqYwTYKKOw@mail.gmail.com>
References: <1467820838-5059-1-git-send-email-joro@8bytes.org>
 <57823445.1020808@iommu.org> <20160711071959.GB12639@8bytes.org>
 <57836609.5060406@iommu.org> <20160711093907.GD12639@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160711093907.GD12639@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Wan Zongshun <vw@iommu.org>, iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

>
>> Sorry, why you still say this 'init_device_table_dma' can block DMA?
>> I just think this function will enable DMA transfer, since  we set
>> the V and TV bits, right? or I misunderstand what "block DMA" mean?
>
> When the V and TV bits are not set, it means that all DMA from that
> device-id is forwared untranslated by the IOMMU. But if we set V and TV
> it means that there is translation information, and the IOMMU translates
> the requests using the rest of the DTE information. As all other bits
> are 0, this means that page-table-level is 0 (== no page-table) and that
> the global IW and IR bits are 0 too (== no read and write permissions).
> So all requests are blocked.
>

Clearly.

Thanks.

>
>
>         Joerg
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
