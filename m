From: Tobias Geiger <tobias.geiger-9woOUGhjKTphl2p70BpVqQ@public.gmane.org>
Subject: Re: Regression since 4.1
Date: Thu, 10 Dec 2015 00:07:57 +0100
Message-ID: <6847091.8HQyRDvvTU@pc>
References: <5418503.92eb9JWhCR@t400> <1449688068.15753.461.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1449688068.15753.461.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello Alex,

thanks for looking into this.

Nothing helps - not adding "ignore_loglevel" , not removing everything but the 
most necessary (="BOOT_IMAGE=/boot/vmlinuz-4.3.0-trunk-amd64 ro 
root=LABEL=dom0root  panic=15 iommu=on intel_iommu=on ignore_loglevel") - grub 
loads the kernel, loads initrd, execs the kernel - and then nothing. no output 
of any kind from the kernel. no sysrq, no panic-reboot despite panic=15 ... 
nothing. not even a blinking cursor, just a steady cursor which is still from 
grub i guess...

It all comes down to kernel > 4.1 && iommu=on = not working here

Hardware is:
Intel DX58SO, Intel CPU i7 920... all pretty solid running for years now, 
always with iommo=on.

I'd love to debug this further, just dont know how...

Greetings!
Tobias

Am Mittwoch, 9. Dezember 2015, 12:07:48 schrieb Alex Williamson:
> Try simply removing the "quiet" and "splash" or "rhgb" options if there
> are any from the kernel command line in grub first.  You can temporarily
> just editing the commandline manually as you boot.  If you don't have a
> serial console available, at least have a camera handy to take a picture
> of the screen.  You can also add "ignore_loglevel" to the kernel
> commandline to get more logging.  Thanks,
> 
> Alex
