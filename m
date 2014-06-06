From: Eli Billauer <eli.billauer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dma-mapping: Add devm_ interface for
	dma_map_single()
Date: Fri, 06 Jun 2014 14:45:06 +0300
Message-ID: <5391A9C2.3040602@gmail.com>
References: <1401606077-1739-1-git-send-email-eli.billauer@gmail.com>
	<1401606077-1739-2-git-send-email-eli.billauer@gmail.com>
	<538E3D04.9060808@samsung.com> <20140603233907.GB23880@8bytes.org>
	<20140604140408.GC5004@htj.dyndns.org>
	<20140604141211.GC23880@8bytes.org>
	<20140604141416.GD5004@htj.dyndns.org> <538F3548.4050101@gmail.com>
	<20140604212525.GE23880@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20140604212525.GE23880-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, discuss-Wa75r+71Mmgdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello Joerg.


On 05/06/14 00:25, Joerg Roedel wrote:
>
> What you are trying to do should work with dma_alloc_noncoherent(). The
> API allows partial syncs on this memory, so you should be fine.
>    
Please try to put yourself in my position: I have a driver that I care 
about, which works fine for a few years. It's based upon 
dma_map_single(), which seems to be the common way to get non-coherent 
memory, even for the driver's entire lifespan. I realize that 
dma_alloc_* was the intended way to do it, but fact is that dma_map_* 
has become the common choice.

Now I need to switch to dma_alloc_noncoherent(), which isn't used by 
many drivers, it seems. It should work the same, but there's always the 
worry if I'll cover all the corners. So will I take this risk of a nasty 
DMA bug on some esoteric platform, just to cut some lines in the code?

And if I choose to keep the unmanaged dma_map_single(), maybe I'll mess 
up if I convert other allocations to the managed API? Hmmm, maybe it's 
best to forget all about it.
> The problem with a devm variant of dma_map_* is that it is too easy to
> misuse or to use it wrong so that a driver could eat up all available
> DMA handles on some platforms.
>    
I suppose you mean that those who use dma_map_* for a one-off DMA 
session will drop the unmapping, thinking that it's "managed anyhow"...? 
Well, you can say that about any of the managed functions. For example, 
when devm_kzalloc() was introduced, someone maybe argued that people 
would drop kfree()s where they shouldn't, causing memory leaks.

So I think it boils down to whether devres is a good idea or not. 
Someone who thinks it's bad, will reject any new API, referring to 
memory efficiency, additional causes of failure and the risk of 
misleading the herd.

But if devres is to become commonly used in the future, I think drop-in 
replacements are necessary. In my opinion, telling people to adopt 
another methodology (e.g. dma_alloc_noncoherent vs. mapping), even if 
functionally equivalent, is a good way to make sure devres is never adopted.

Regards,
    Eli
> 	Joerg
>
>
>    
