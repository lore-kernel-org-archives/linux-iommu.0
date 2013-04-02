From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
	register
Date: Tue, 2 Apr 2013 16:05:47 +0200
Message-ID: <20130402140546.GA15687@8bytes.org>
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
	<20130326144629.GB2727@8bytes.org>
	<51527D74.9080209@jp.fujitsu.com>
	<20130327103122.GK30540@8bytes.org> <51591EEE.60401@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51591EEE.60401-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 01, 2013 at 02:45:18PM +0900, Takao Indoh wrote:
> <Current flow on kdump boot>
> enable_IR
>   intel_enable_irq_remapping
>     iommu_disable_irq_remapping  <== IRES/QIES/TES disabled here
>     dmar_disable_qi              <== do nothing
>     dmar_enable_qi               <== QIES enabled
>     intel_setup_irq_remapping    <== IRES enabled

But what we want to do here in the kdumo case is to disable translation
too, right? Because the former kernel might have translation and
irq-remapping enabled and the kdump kernel might be compiled without
support for dma-remapping. So if we don't disable translation here too
the kdump kernel is unable to do DMA.

I agree that disabling translation should be a bit more explicit instead
of the current code.


	Joerg
