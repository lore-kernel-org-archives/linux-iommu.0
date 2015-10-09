From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 3/6] iommu: add ARM short descriptor page table
 allocator.
Date: Fri, 9 Oct 2015 18:41:51 +0100
Message-ID: <5617FC5F.60505@arm.com>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
 <1438597279-2937-4-git-send-email-yong.wu@mediatek.com>
 <20150916155824.GM28771@arm.com> <1442501662.8145.151.camel@mhfsdcap03>
 <1442931167.17514.39.camel@mhfsdcap03> <20151009155750.GS26278@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151009155750.GS26278-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, "frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Daniel
List-Id: iommu@lists.linux-foundation.org

On 09/10/15 16:57, Will Deacon wrote:
> On Tue, Sep 22, 2015 at 03:12:47PM +0100, Yong Wu wrote:
>>       I would like to show you a problem I met, The recursion here may
>> lead to stack overflow while we test FHD video decode.
>>
>>      From the log, I get the internal variable in the error case: the
>> "size" is 0x100000, the "iova" is 0xfea00000, but at that time the
>> "blk_size" is 0x1000 as it was the map of small-page. so it enter the
>> recursion here.
>>
>>      After check the unmap flow, there is only a iommu_unmap in
>> __iommu_dma_unmap, and it won't check the physical address align in
>> iommu_unmap.
>
> That sounds like a bug in __iommu_dma_unmap. Robin?

Isn't it just cf27ec930be9 again wearing different trousers? All I do is 
call iommu_unmap with the same total size that was mapped originally.

Robin.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
