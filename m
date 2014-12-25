From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Bug 90311] New: Hibernate failure with intel_iommu
Date: Thu, 25 Dec 2014 12:55:27 -0700
Message-ID: <CAErSpo7rtsQfqkMCRy7u+Tn_iCEPN5HbMQdz1hQTOvUt=67CkQ@mail.gmail.com>
References: <bug-90311-41252@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <bug-90311-41252-3bo0kxnWaOQUvHkbgXJLS5sdmw4N0Rt+2LY78lusg7I@public.gmane.org/>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: thomas.lindroth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[+cc Alex, linux-pci, iommu]

On Thu, Dec 25, 2014 at 12:13 PM,  <bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=90311
>
>             Bug ID: 90311
>            Summary: Hibernate failure with intel_iommu
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.18.1
>           Hardware: x86-64
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
>           Reporter: thomas.lindroth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>         Regression: No
>
> Created attachment 161811
>   --> https://bugzilla.kernel.org/attachment.cgi?id=161811&action=edit
> dmesg with iommu on
>
> Enabling intel_iommu=on causes uswsusp s2disk to fail. Hibernate always works
> fine without iommu and as far as I can tell everything works fine with iommu on
> without hibernating. With intel_iommu set to on I can enter hibernate but the
> system doesn't come back properly. By that I mean the kernel can't read from
> swap and everything freezes. I can still switch between virtual terminals, view
> the system log and use magic sysrq to reboot. The system log is spammed with
> error messages from the scsi subsystem. http://i.imgur.com/ToFd8NM.jpg sdb
> contains root and swap.
>
> I'm guessing the iommu mapping isn't setup properly after resume so the disk
> controller can't do DMA anymore. I have made sure the kernel command line
> contains intel_iommu=on before and after suspend. I have one of the bad marvell
> 88SE9172 controllers but the swap is not connected to it (bug #42679).
>
> I'm running a gentoo system with kernel 3.18.1 on a Gigabyte Z97X-Gaming G1
> mobo with bios F7 (latest). Finding the problem might be difficult and I don't
> know what kind of information to provide. I can give you any debug output
> needed and apply debug patches if needed.

Is this a regression?  If so, what was the most recent working kernel?
