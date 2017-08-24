From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] iommu/pamu: Add support for generic iommu-device
Date: Thu, 24 Aug 2017 15:04:44 +0200
Message-ID: <20170824130444.GE19533@8bytes.org>
References: <1502290014-2890-1-git-send-email-joro@8bytes.org>
	<1502290014-2890-5-git-send-email-joro@8bytes.org>
	<878tiaxyu4.fsf@concordia.ellerman.id.au>
	<20170823142134.GD19533@8bytes.org>
	<87ziapwwki.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ziapwwki.fsf-W0DJWXSxmBNbyGPkN3NxC2scP1bn1w/D@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Cc: Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Michael,

On Thu, Aug 24, 2017 at 12:04:13PM +1000, Michael Ellerman wrote:
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> writes:
> > Can you please try the attached patch?
> 
> Thanks, that works.

Great, thanks for testing it. I'll queue it on-top of the original
patch-set.

> 
> It boots happily, much later in boot I see these messages:
> 
> [    2.085616] iommu: Adding device ffe301000.jr to group 9
> [    2.091101] iommu: Adding device ffe302000.jr to group 10
> [    2.096633] iommu: Adding device ffe303000.jr to group 11
> [    2.102161] iommu: Adding device ffe304000.jr to group 12

Looks good.

> 
> In /sys I see:
> 
> root@p5020ds:~# ls -l /sys/class/iommu/iommu0
> lrwxrwxrwx 1 root root 0 Aug 24 12:01 /sys/class/iommu/iommu0 -> ../../devices/virtual/iommu/iommu0
> 
> And:
> 
> root@p5020ds:~# ls -l /sys/devices/virtual/iommu/iommu0/devices/
> total 0
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 0000:00:00.0 -> ../../../../platform/ffe200000.pcie/pci0000:00/0000:00:00.0
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 2000:00:00.0 -> ../../../../platform/ffe202000.pcie/pci2000:00/2000:00:00.0
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 2000:01:00.0 -> ../../../../platform/ffe202000.pcie/pci2000:00/2000:00:00.0/2000:01:00.0
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 2000:01:00.1 -> ../../../../platform/ffe202000.pcie/pci2000:00/2000:00:00.0/2000:01:00.1
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe100300.dma -> ../../../../platform/ffe000000.soc/ffe100300.dma
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe101300.dma -> ../../../../platform/ffe000000.soc/ffe101300.dma
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe114000.sdhc -> ../../../../platform/ffe000000.soc/ffe114000.sdhc
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe200000.pcie -> ../../../../platform/ffe200000.pcie
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe202000.pcie -> ../../../../platform/ffe202000.pcie
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe210000.usb -> ../../../../platform/ffe000000.soc/ffe210000.usb
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe211000.usb -> ../../../../platform/ffe000000.soc/ffe211000.usb
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe220000.sata -> ../../../../platform/ffe000000.soc/ffe220000.sata
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe221000.sata -> ../../../../platform/ffe000000.soc/ffe221000.sata
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe301000.jr -> ../../../../platform/ffe000000.soc/ffe300000.crypto/ffe301000.jr
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe302000.jr -> ../../../../platform/ffe000000.soc/ffe300000.crypto/ffe302000.jr
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe303000.jr -> ../../../../platform/ffe000000.soc/ffe300000.crypto/ffe303000.jr
> lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe304000.jr -> ../../../../platform/ffe000000.soc/ffe300000.crypto/ffe304000.jr
> 
> 
> Which seems like it's working?

Exactly, that is what I'd expect to see with the patches.


Thanks again and cheers,


       Joerg
