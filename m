From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: fix usage of force parameter in
	intel_ir_reconfigure_irte()
Date: Thu, 3 May 2018 14:23:46 +0200
Message-ID: <20180503122346.nl3dovkyb3py3zpc@8bytes.org>
References: <1520375981-4958-1-git-send-email-jag.raman@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1520375981-4958-1-git-send-email-jag.raman-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jagannathan Raman <jag.raman-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 06, 2018 at 05:39:41PM -0500, Jagannathan Raman wrote:
> It was noticed that the IRTE configured for guest OS kernel
> was over-written while the guest was running. As a result,
> vt-d Posted Interrupts configured for the guest are not being
> delivered directly, and instead bounces off the host. Every
> interrupt delivery takes a VM Exit.
> 
> It was noticed that the following stack is doing the over-write:
> [  147.463177]  modify_irte+0x171/0x1f0
> [  147.463405]  intel_ir_set_affinity+0x5c/0x80
> [  147.463641]  msi_domain_set_affinity+0x32/0x90
> [  147.463881]  irq_do_set_affinity+0x37/0xd0
> [  147.464125]  irq_set_affinity_locked+0x9d/0xb0
> [  147.464374]  __irq_set_affinity+0x42/0x70
> [  147.464627]  write_irq_affinity.isra.5+0xe1/0x110
> [  147.464895]  proc_reg_write+0x38/0x70
> [  147.465150]  __vfs_write+0x36/0x180
> [  147.465408]  ? handle_mm_fault+0xdf/0x200
> [  147.465671]  ? _cond_resched+0x15/0x30
> [  147.465936]  vfs_write+0xad/0x1a0
> [  147.466204]  SyS_write+0x52/0xc0
> [  147.466472]  do_syscall_64+0x74/0x1a0
> [  147.466744]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> 
> reversing the sense of force check in intel_ir_reconfigure_irte()
> restores proper posted interrupt functionality
> 
> Signed-off-by: Jagannathan Raman <jag.raman-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Applie, thanks.
