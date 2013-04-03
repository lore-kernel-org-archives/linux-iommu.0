From: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
	register
Date: Wed, 03 Apr 2013 16:11:52 +0900
Message-ID: <515BD638.8070307@jp.fujitsu.com>
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
	<20130326144629.GB2727@8bytes.org>
	<51527D74.9080209@jp.fujitsu.com>
	<20130327103122.GK30540@8bytes.org> <51591EEE.60401@jp.fujitsu.com>
	<20130402140546.GA15687@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130402140546.GA15687-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

(2013/04/02 23:05), Joerg Roedel wrote:
> On Mon, Apr 01, 2013 at 02:45:18PM +0900, Takao Indoh wrote:
>> <Current flow on kdump boot>
>> enable_IR
>>    intel_enable_irq_remapping
>>      iommu_disable_irq_remapping  <== IRES/QIES/TES disabled here
>>      dmar_disable_qi              <== do nothing
>>      dmar_enable_qi               <== QIES enabled
>>      intel_setup_irq_remapping    <== IRES enabled
> 
> But what we want to do here in the kdumo case is to disable translation
> too, right? Because the former kernel might have translation and
> irq-remapping enabled and the kdump kernel might be compiled without
> support for dma-remapping. So if we don't disable translation here too
> the kdump kernel is unable to do DMA.

Yeah, you are right. I forgot such a case.

To be honest, I also expected the side effect of this patch. As I wrote
in the previous mail, I'm working on kdump problem with iommu, that is,
ongoing DMA causes DMAR fault in 2nd kernel and sometimes kdump fails
due to this fault. What we have to do is stopping DMA transaction
before DMA-remapping is disabled in 2nd kernel. To do this, we need to
reset devices before intel_enable_irq_remapping() is called, but it is
very difficult because struct pci_dev is not prepared in this stage.
After applying this patch, DMA-remapping is disabled in init_dmars where
struct pci_dev is ready, so it's easier to handle. For example we can
add pci quirk to reset devices.

So, disabling translation in 2nd kernel is necessary, and it's better if
we can do it after struct pci_dev is prepared. (after subsys_initcall?)
Any idea?

Thanks,
Takao Indoh

> 
> I agree that disabling translation should be a bit more explicit instead
> of the current code.
> 
> 
> 	Joerg
> 
