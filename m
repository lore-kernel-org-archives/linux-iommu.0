From: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [RESEND PATCH v2 2/6] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI
	controller enables IRQ remapping
Date: Mon, 6 Jun 2016 16:25:18 +0800
Message-ID: <201606060825.u568OfQF007771@mx0a-001b2d01.pphosted.com>
References: <201606060500.cgRhY40o%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201606060500.cgRhY40o%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2016/6/6 5:11, kbuild test robot wrote:

> Hi,
>
> [auto build test ERROR on vfio/next]
> [also build test ERROR on v4.7-rc1 next-20160603]
> [cannot apply to pci/next]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Yongji-Xie/PCI-Add-a-new-PCI_BUS_FLAGS_MSI_REMAP-flag/20160530-215348
> base:   https://github.com/awilliam/linux-vfio.git next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
> reproduce:
>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>     drivers/pci/msi.c: In function 'pci_bus_msi_isolated':
>>> drivers/pci/msi.c:1146:20: error: 'MSI_FLAG_IRQ_REMAPPING' undeclared (first use in this function)
>       if (info->flags & MSI_FLAG_IRQ_REMAPPING)
>                         ^
>     drivers/pci/msi.c:1146:20: note: each undeclared identifier is reported only once for each function it appears in
>
> vim +/MSI_FLAG_IRQ_REMAPPING +1146 drivers/pci/msi.c
>
>    1140		struct msi_domain_info *info;
>    1141	
>    1142		if (!domain)
>    1143			return 0;
>    1144	
>    1145		info = msi_get_domain_info(domain);
>> 1146		if (info->flags & MSI_FLAG_IRQ_REMAPPING)
>    1147			return 1;
>    1148	#endif
>    1149		return 0;

This fault is expected because this patch is based on patchset [1] which
introduce flag MSI_FLAG_IRQ_REMAPPING.

[1] 
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html

Thanks,
Yongji
