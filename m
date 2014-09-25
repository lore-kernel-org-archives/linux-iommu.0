From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Thu, 25 Sep 2014 10:36:02 +0800
Message-ID: <54237F92.1090601@huawei.com>
References: <1597491265.153338.1411595791727.JavaMail.open-xchange@oxuslxltgw04.lxa.perfora.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1597491265.153338.1411595791727.JavaMail.open-xchange-91tEjvOFe9KcT/DCa4qSTkaJx/dRlJfr5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Roschewsk <gerard-1/SUfjJPYocsP9Te1NuDSQC/G2K4zDHf@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2014/9/25 5:56, Rob Roschewsk wrote:
> Hello All .... wonder if there has been any movement on this issue .... I'm having a similar issue 
>  
> I'm running an HP dl380 gen 8 with an Emulex OneConnect 10Gb iSCSI (14e4:164c) (rev 11)
> also known as " Hewlett-Packard Company NC373i Integrated Multifunction Gigabit Server Adapter"
>  
> 03:00.2 Mass storage controller: Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3) (rev 01)
> 
> 03:00.3 Mass storage controller: Emulex Corporation OneConnect 10Gb iSCSI Initiator (be3) (rev 01)
> 
> Seems as soon as the iscsi target is contacted the following messages appear in the log every few seconds ....
> 

It seems to a different problem, in my issue, the DMA fault messages contained a non-exist PCI ID in system.
But in this issue, 03:00.2 is in system, the fault addr is ffffc000, I guess it's DMA virtual address allocated
by vt-d driver. And it seems to 03:00.2 has no write access authority.

> Sep 24 15:25:30  kernel: [ 78.682675] dmar: DRHD: handling fault status reg 2
> Sep 24 15:25:30  kernel: [ 78.699797] dmar: DMAR:[DMA Write] Request device [03:00.2] fault addr ffffc000
> Sep 24 15:25:30  kernel: [ 78.699797] DMAR:[fault reason 05] PTE Write access is not set
> Sep 24 15:25:30  kernel: [ 78.934546] dmar: DRHD: handling fault status reg 102
> Sep 24 15:25:30  kernel: [ 78.934549] dmar: DMAR:[DMA Write] Request device [03:00.2] fault addr ffffc000
> Sep 24 15:25:30  kernel: [ 78.934549] DMAR:[fault reason 05] PTE Write access is not set
> Sep 24 15:25:30  kernel: [ 78.935359] dmar: DRHD: handling fault status reg 202
> 
> If I pull intel_iommu=on out of the kernel command line the problem goes away.
> 
> System is running Ubuntu 14.04.1 LTS 
> 
> 3.13.0-32-generic #57-Ubuntu SMP Tue Jul 15 03:51:08 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
> 
> Looking for help .... I'm not sure where I should be looking next ..... I need SR-IOV for other adapters in the box.
> 
> I have a system up that I can pull any data from that might be required.
> 
> Thanks,
> 
> --> Rob
> 
>  
> 
> 
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 


-- 
Thanks!
Yijing
